Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D904CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVUYN-00071w-IF; Fri, 05 Jun 2026 09:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wVRXa-0005DA-7q
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:12:38 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1wVRXY-00008n-2I
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:12:37 -0400
DKIM-Signature: a=rsa-sha256; bh=mob90Hpqwwt9IT39w2pVTh2KgcYtBqyhRPZgNimNytc=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1780654351; v=1;
 b=beSOwEQvC3VtCOwVp18PIVkYROeYnwpeCWtNeIHOYalKbeTji31JKqwA6E9kSP+pr3b0T0yh
 ZG0RbtYb9S/RIuX7lRzG6+6Wf44NW6wX6cI6uhohjeOvrnaJfmpx9K3SblJh4MFwnMndevqGs3e
 8WOTdSXaLqXTtsUHNwavYfqYSwmNnhlo9XUmya3wEdSwsJIgsOn4qalAAfkM4rCjrLe9QI3M9E7
 VLX/xiNh3JEbfqR7h/4zGmpe8HWD7GyiWUCnye81vgkoNYUqHm+WCCYThQjIDr3nql8RUcGjqtj
 a5LDPELANmmh4qBiDB6JEflVSBxM1cyh1tOOBabEZZWhg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id B978521341;
 Fri, 05 Jun 2026 10:12:31 +0000 (UTC)
From: ~rongyichang <rongyichang@git.sr.ht>
Date: Fri, 05 Jun 2026 17:53:25 +0800
Subject: [PATCH qemu] ui/sdl2: add grab-on-tablet option for absolute input
 devices
Message-ID: <178065435170.20548.15372728064868431795-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armbru@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Jun 2026 09:25:32 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~rongyichang <rongyichang@xiaomi.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: rongyichang <rongyichang@xiaomi.com>

When using absolute coordinate input devices (e.g. virtio-tablet-device),
the SDL display backend implements a "soft grab" where the mouse is
automatically grabbed when it enters the window interior and ungrabbed
when it hits the window edge. This edge-ungrab behavior causes problems
in embedded emulation scenarios:

1. Mouse escapes the SDL window at edges
2. SDL does not deliver BUTTONUP events for the escaped mouse
3. The guest gets stuck in a pressed/touch-down state
4. First click back into the window is silently dropped

This issue is confirmed as a known SDL limitation (SDL issue #5301).

Add a new -display sdl,grab-on-tablet=3Don option that makes absolute
coordinate devices use the same grab behavior as relative (mouse)
devices: user must click to grab, Ctrl+Alt+G to release, and no
automatic grab on window enter or edge-based ungrab/regrab.

Signed-off-by: Yichang Rong <rongyichang@xiaomi.com>
---
 qapi/ui.json    |  8 +++++++-
 qemu-options.hx |  9 +++++++--
 ui/sdl2.c       | 16 +++++++++++++---
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index b2c42a7f57..454d9041bf 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1477,10 +1477,16 @@
 # @grab-mod: Modifier keys that should be pressed together with the
 #     "G" key to release the mouse grab.
 #
+# @grab-on-tablet: When enabled, the mouse grab is required even for
+#     tablet (absolute) input devices.  This is useful when the guest
+#     OS uses a tablet device but you still want click-to-grab
+#     semantics (e.g. NuttX touchscreen emulation).
+#
 # Since: 7.1
 ##
 { 'struct'  : 'DisplaySDL',
-  'data'    : { '*grab-mod'   : 'HotKeyMod' } }
+  'data'    : { '*grab-mod'   : 'HotKeyMod',
+                '*grab-on-tablet' : 'bool' } }
=20
 ##
 # @DisplayType:
diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..1e1836312c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2205,8 +2205,8 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
     "-display spice-app[,gl=3Don|off]\n"
 #endif
 #if defined(CONFIG_SDL)
-    "-display sdl[,gl=3Don|core|es|off][,grab-mod=3D<mod>][,show-cursor=3Don=
|off]\n"
-    "            [,window-close=3Don|off]\n"
+    "-display sdl[,gl=3Don|core|es|off][,grab-mod=3D<mod>][,grab-on-tablet=
=3Don|off]\n"
+    "            [,show-cursor=3Don|off][,window-close=3Don|off]\n"
 #endif
 #if defined(CONFIG_GTK)
     "-display gtk[,clipboard=3Don|off][,full-screen=3Don|off][,gl=3Don|off]\=
n"
@@ -2284,6 +2284,11 @@ SRST
         the mouse grabbing in conjunction with the "g" key. ``<mods>`` can be
         either ``lshift-lctrl-lalt`` or ``rctrl``.
=20
+        ``grab-on-tablet=3Don|off`` : When enabled, the mouse grab is requir=
ed
+        even for tablet (absolute) input devices.  This is useful when the
+        guest OS uses a tablet device but you still want click-to-grab
+        semantics.
+
         ``gl=3Don|off|core|es`` : Use OpenGL for displaying
=20
         ``show-cursor=3Don|off`` :  Force showing the mouse cursor
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 4fcdbd79d3..af94ae8500 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -46,6 +46,7 @@ static SDL_Surface *guest_sprite_surface;
 static int gui_grab; /* if true, all keyboard/mouse events are grabbed */
 static bool alt_grab;
 static bool ctrl_grab;
+static bool grab_on_tablet;
=20
 static int gui_saved_grab;
 static int gui_fullscreen;
@@ -504,7 +505,8 @@ static void handle_mousemotion(SDL_Event *ev)
     }
=20
     SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
-    if (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
+    if ((qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) &&
+        !grab_on_tablet) {
         max_x =3D scr_w - 1;
         max_y =3D scr_h - 1;
         if (gui_grab && !gui_fullscreen
@@ -545,7 +547,8 @@ static void handle_mousebutton(SDL_Event *ev)
     x =3D (int64_t)bev->x * surface_width(scon->surface) / scr_w;
     y =3D (int64_t)bev->y * surface_height(scon->surface) / scr_h;
=20
-    if (!gui_grab && !qemu_input_is_absolute(scon->dcl.con)) {
+    if (!gui_grab &&
+        (!qemu_input_is_absolute(scon->dcl.con) || grab_on_tablet)) {
         if (ev->type =3D=3D SDL_MOUSEBUTTONUP && bev->button =3D=3D SDL_BUTT=
ON_LEFT) {
             /* start grabbing all events */
             sdl_grab_start(scon);
@@ -614,7 +617,10 @@ static void handle_windowevent(SDL_Event *ev)
     case SDL_WINDOWEVENT_FOCUS_GAINED:
         /* fall through */
     case SDL_WINDOWEVENT_ENTER:
-        if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_=
enabled)) {
+        if (!gui_grab &&
+            (qemu_input_is_absolute(scon->dcl.con) ||
+             absolute_enabled) &&
+            !grab_on_tablet) {
             absolute_mouse_grab(scon);
         }
         /* If a new console window opened using a hotkey receives the
@@ -921,6 +927,10 @@ static void sdl2_display_init(DisplayState *ds, DisplayO=
ptions *o)
         }
     }
=20
+    if (o->u.sdl.has_grab_on_tablet) {
+        grab_on_tablet =3D o->u.sdl.grab_on_tablet;
+    }
+
     for (i =3D 0;; i++) {
         QemuConsole *con =3D qemu_console_lookup_by_index(i);
         if (!con) {
--=20
2.49.1

