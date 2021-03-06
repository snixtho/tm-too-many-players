[Setting name="Visible" description="Show the widget while on a server."]
bool Setting_Visible = false;

[Setting name="Only In Spectator" description="Only show the widget while spectating."]
bool Setting_OnlyInSpec = false;

[Setting hidden]
float Setting_Height = 285;

[Setting hidden]
float Setting_Width = 200;

[Setting hidden]
float Setting_PosX = 0;

[Setting hidden]
float Setting_PosY = 75;


bool _joinedServer = false;

bool IsSpectating() {
    auto api = GetApp().CurrentPlayground.Interface.ManialinkScriptHandler;

    return api.IsSpectator || api.IsSpectatorClient;
}

void RenderMenu() {
    if (UI::MenuItem("\\$f00" + Icons::DotCircleO + "\\$z Too Many Players", "", Setting_Visible)) {
        Setting_Visible = !Setting_Visible;
    }
}

void Render() {
    auto app = GetApp();

    if (app.CurrentPlayground !is null && app.Network.IsMultiInternet) {
        if (Setting_OnlyInSpec && !IsSpectating()) return;

        widgetWindow.Render();

        if (!_joinedServer) {
            widgetWindow.UpdatePlayers();
        }

        _joinedServer = true;
    } else {
        _joinedServer = false;
    }
}

void Main() {}
