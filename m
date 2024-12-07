Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8844BE7717D
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2024 22:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tK3Nt-0005RJ-HI; Sat, 07 Dec 2024 17:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1tK3Nr-0005RB-1I
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 17:34:43 -0500
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1tK3Np-000184-02
 for qemu-devel@nongnu.org; Sat, 07 Dec 2024 17:34:42 -0500
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout04.t-online.de (Postfix) with SMTP id 28D3BEC1;
 Sat,  7 Dec 2024 23:34:35 +0100 (CET)
Received: from linpower.localnet ([84.175.226.173]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1tK3Nh-0ZBQyv0; Sat, 7 Dec 2024 23:34:33 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id ED6A3200240; Sat,  7 Dec 2024 23:34:32 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH v2] ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
Date: Sat,  7 Dec 2024 23:34:32 +0100
Message-ID: <20241207223432.6896-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1733610873-CFFFC9E5-E866CDFE/0/0 CLEAN NORMAL
X-TOI-MSGID: 0bf528ff-1433-4107-a31c-9394ef7cdf17
Received-SPF: pass client-ip=194.25.134.18;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout04.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since SDL2 2.30.4 the SDL2 keyboard hook procedure also filters
out the special left Control key event for every Alt Gr key event
on keyboards with an international layout. This means the QEMU low
level keyboard hook procedure is no longer needed. Remove the QEMU
Windows keyboard hook procedure.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2139
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2323
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 ui/meson.build |  4 ----
 ui/sdl2.c      | 26 --------------------------
 2 files changed, 30 deletions(-)

diff --git a/ui/meson.build b/ui/meson.build
index 28c7381dd1..35fb04cadf 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -120,10 +120,6 @@ if gtk.found()
 endif
 
 if sdl.found()
-  if host_os == 'windows'
-    system_ss.add(files('win32-kbd-hook.c'))
-  endif
-
   sdl_ss = ss.source_set()
   sdl_ss.add(sdl, sdl_image, pixman, glib, files(
     'sdl2-2d.c',
diff --git a/ui/sdl2.c b/ui/sdl2.c
index bd4f5a9da1..3d70eaebfa 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -32,7 +32,6 @@
 #include "sysemu/runstate.h"
 #include "sysemu/runstate-action.h"
 #include "sysemu/sysemu.h"
-#include "ui/win32-kbd-hook.h"
 #include "qemu/log.h"
 
 static int sdl2_num_outputs;
@@ -262,7 +261,6 @@ static void sdl_grab_start(struct sdl2_console *scon)
     }
     SDL_SetWindowGrab(scon->real_window, SDL_TRUE);
     gui_grab = 1;
-    win32_kbd_set_grab(true);
     sdl_update_caption(scon);
 }
 
@@ -270,7 +268,6 @@ static void sdl_grab_end(struct sdl2_console *scon)
 {
     SDL_SetWindowGrab(scon->real_window, SDL_FALSE);
     gui_grab = 0;
-    win32_kbd_set_grab(false);
     sdl_show_cursor(scon);
     sdl_update_caption(scon);
 }
@@ -371,19 +368,6 @@ static int get_mod_state(void)
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
@@ -608,10 +592,6 @@ static void handle_windowevent(SDL_Event *ev)
         sdl2_redraw(scon);
         break;
     case SDL_WINDOWEVENT_FOCUS_GAINED:
-        win32_kbd_set_grab(gui_grab);
-        if (qemu_console_is_graphic(scon->dcl.con)) {
-            win32_kbd_set_window(sdl2_win32_get_hwnd(scon));
-        }
         /* fall through */
     case SDL_WINDOWEVENT_ENTER:
         if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
@@ -627,9 +607,6 @@ static void handle_windowevent(SDL_Event *ev)
         scon->ignore_hotkeys = get_mod_state();
         break;
     case SDL_WINDOWEVENT_FOCUS_LOST:
-        if (qemu_console_is_graphic(scon->dcl.con)) {
-            win32_kbd_set_window(NULL);
-        }
         if (gui_grab && !gui_fullscreen) {
             sdl_grab_end(scon);
         }
@@ -869,10 +846,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
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
-- 
2.43.0


