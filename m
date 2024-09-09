Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2211CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 06:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snXgz-0004Nz-Sb; Mon, 09 Sep 2024 02:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1snXgv-0004FR-VI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:16:01 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1snXgt-0003T0-TV
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:16:01 -0400
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
 by mailout07.t-online.de (Postfix) with SMTP id 9E7489788;
 Mon,  9 Sep 2024 08:15:53 +0200 (CEST)
Received: from linpower.localnet ([93.236.144.183]) by fwd79.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1snXgn-2648G10; Mon, 9 Sep 2024 08:15:53 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id D78AA2001CD; Mon,  9 Sep 2024 08:15:52 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/3] ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
Date: Mon,  9 Sep 2024 08:15:50 +0200
Message-Id: <20240909061552.6122-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
References: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1725862553-C17F05C5-241EE4EB/0/0 CLEAN NORMAL
X-TOI-MSGID: d0bfdf8f-8f1d-4f78-bf43-e0f6ce2fc0bd
Received-SPF: pass client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Windows only:

The libSDL2 Windows message loop needs the libSDL2 Windows low
level keyboard hook procedure to grab the left and right Windows
keys correctly. Reenable the SDL2 Windows keyboard hook procedure.

Because the QEMU Windows keyboard hook procedure is still needed
to filter out the special left Control key event for every Alt Gr
key event, it's important to install the two keyboard hook
procedures in the following order. First the SDL2 procedure, then
the QEMU procedure.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/sdl2.c           | 53 ++++++++++++++++++++++++++++++---------------
 ui/win32-kbd-hook.c |  3 +++
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/ui/sdl2.c b/ui/sdl2.c
index 98ed974371..ac37c173a1 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -42,6 +42,7 @@ static SDL_Surface *guest_sprite_surface;
 static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 static bool alt_grab;
 static bool ctrl_grab;
+static bool win32_kbd_grab;
 
 static int gui_saved_grab;
 static int gui_fullscreen;
@@ -202,6 +203,19 @@ static void sdl_update_caption(struct sdl2_console *scon)
     }
 }
 
+static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
+{
+#ifdef CONFIG_WIN32
+    SDL_SysWMinfo info;
+
+    SDL_VERSION(&info.version);
+    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
+        return info.info.win.window;
+    }
+#endif
+    return NULL;
+}
+
 static void sdl_hide_cursor(struct sdl2_console *scon)
 {
     if (scon->opts->has_show_cursor && scon->opts->show_cursor) {
@@ -259,9 +273,16 @@ static void sdl_grab_start(struct sdl2_console *scon)
     } else {
         sdl_hide_cursor(scon);
     }
+    /*
+     * Windows: To ensure that QEMU's low level keyboard hook procedure is
+     * called before SDL2's, the QEMU procedure must first be removed and
+     * then the SDL2 and QEMU procedures must be installed in this order.
+     */
+    win32_kbd_set_window(NULL);
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
+    win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
     gui_grab = 1;
-    win32_kbd_set_grab(true);
+    win32_kbd_set_grab(win32_kbd_grab);
     sdl_update_caption(scon);
 }
 
@@ -370,19 +391,6 @@ static int get_mod_state(void)
     }
 }
 
-static void *sdl2_win32_get_hwnd(struct sdl2_console *scon)
-{
-#ifdef CONFIG_WIN32
-    SDL_SysWMinfo info;
-
-    SDL_VERSION(&info.version);
-    if (SDL_GetWindowWMInfo(scon->real_window, &info)) {
-        return info.info.win.window;
-    }
-#endif
-    return NULL;
-}
-
 static void handle_keydown(SDL_Event *ev)
 {
     int win;
@@ -605,7 +613,7 @@ static void handle_windowevent(SDL_Event *ev)
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
-        win32_kbd_set_grab(gui_grab);
+        win32_kbd_set_grab(win32_kbd_grab && gui_grab);
         if (qemu_console_is_graphic(scon->dcl.con)) {
             win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
         }
@@ -849,6 +857,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     uint8_t data = 0;
     int i;
     SDL_SysWMinfo info;
+    SDL_version ver;
     SDL_Surface *icon = NULL;
     char *dir;
 
@@ -866,10 +875,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 #ifdef SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR /* only available since SDL 2.0.8 */
     SDL_SetHint(SDL_HINT_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR, "0");
 #endif
-#ifndef CONFIG_WIN32
-    /* QEMU uses its own low level keyboard hook procedure on Windows */
     SDL_SetHint(SDL_HINT_GRAB_KEYBOARD, "1");
-#endif
 #ifdef SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
@@ -877,6 +883,17 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
+    /*
+     * Since version 2.16.0 under Windows, SDL2 has its own low level
+     * keyboard hook procedure to grab the keyboard. The remaining task of
+     * QEMU's low level keyboard hook procedure is to filter out the special
+     * left Control up/down key event for every Alt Gr key event on keyboards
+     * with an international layout.
+     */
+    SDL_GetVersion(&ver);
+    if (ver.major == 2 && ver.minor < 16) {
+        win32_kbd_grab = true;
+    }
 
     gui_fullscreen = o->has_full_screen && o->full_screen;
 
diff --git a/ui/win32-kbd-hook.c b/ui/win32-kbd-hook.c
index 1ac237db9e..39d42134a2 100644
--- a/ui/win32-kbd-hook.c
+++ b/ui/win32-kbd-hook.c
@@ -91,6 +91,9 @@ void win32_kbd_set_window(void *hwnd)
             win32_unhook_notifier.notify = keyboard_hook_unhook;
             qemu_add_exit_notifier(&win32_unhook_notifier);
         }
+    } else if (!hwnd && win32_keyboard_hook) {
+        keyboard_hook_unhook(&win32_unhook_notifier, NULL);
+        qemu_remove_exit_notifier(&win32_unhook_notifier);
     }
 
     win32_window = hwnd;
-- 
2.35.3


