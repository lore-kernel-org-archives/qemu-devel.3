Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92C3C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua94N-0006sY-WF; Fri, 11 Jul 2025 04:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xU-0004V2-L1; Fri, 11 Jul 2025 04:18:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ua8xS-00040Y-M4; Fri, 11 Jul 2025 04:18:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C6AF1356D2;
 Fri, 11 Jul 2025 11:17:18 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 824E323FA47;
 Fri, 11 Jul 2025 11:17:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Weifeng Liu <weifeng.liu@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 07/39] ui/sdl: Consider scaling in mouse event handling
Date: Fri, 11 Jul 2025 11:16:03 +0300
Message-ID: <20250711081745.1785806-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250711105634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Weifeng Liu <weifeng.liu@intel.com>

When using sdl display backend, if the window is scaled, incorrect mouse
positions will be reported since scaling is not properly handled. Fix it
by transforming the positions from window coordinate to guest buffer
coordinate.

Signed-off-by: Weifeng Liu <weifeng.liu@intel.com>
Message-ID: <20250511073337.876650-6-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 30aa105640b0a2a541744b6584d57c9a4b86debd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/sdl2.c b/ui/sdl2.c
index cda4293a53..b00e421f7f 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -488,14 +488,14 @@ static void handle_mousemotion(SDL_Event *ev)
 {
     int max_x, max_y;
     struct sdl2_console *scon = get_scon_from_window(ev->motion.windowID);
+    int scr_w, scr_h, surf_w, surf_h, x, y, dx, dy;
 
     if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
+    SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
     if (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
-        int scr_w, scr_h;
-        SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
         max_x = scr_w - 1;
         max_y = scr_h - 1;
         if (gui_grab && !gui_fullscreen
@@ -509,9 +509,14 @@ static void handle_mousemotion(SDL_Event *ev)
             sdl_grab_start(scon);
         }
     }
+    surf_w = surface_width(scon->surface);
+    surf_h = surface_height(scon->surface);
+    x = (int64_t)ev->motion.x * surf_w / scr_w;
+    y = (int64_t)ev->motion.y * surf_h / scr_h;
+    dx = (int64_t)ev->motion.xrel * surf_w / scr_w;
+    dy = (int64_t)ev->motion.yrel * surf_h / scr_h;
     if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
-        sdl_send_mouse_event(scon, ev->motion.xrel, ev->motion.yrel,
-                             ev->motion.x, ev->motion.y, ev->motion.state);
+        sdl_send_mouse_event(scon, dx, dy, x, y, ev->motion.state);
     }
 }
 
@@ -520,12 +525,17 @@ static void handle_mousebutton(SDL_Event *ev)
     int buttonstate = SDL_GetMouseState(NULL, NULL);
     SDL_MouseButtonEvent *bev;
     struct sdl2_console *scon = get_scon_from_window(ev->button.windowID);
+    int scr_w, scr_h, x, y;
 
     if (!scon || !qemu_console_is_graphic(scon->dcl.con)) {
         return;
     }
 
     bev = &ev->button;
+    SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
+    x = (int64_t)bev->x * surface_width(scon->surface) / scr_w;
+    y = (int64_t)bev->y * surface_height(scon->surface) / scr_h;
+
     if (!gui_grab && !qemu_input_is_absolute(scon->dcl.con)) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
             /* start grabbing all events */
@@ -537,7 +547,7 @@ static void handle_mousebutton(SDL_Event *ev)
         } else {
             buttonstate &= ~SDL_BUTTON(bev->button);
         }
-        sdl_send_mouse_event(scon, 0, 0, bev->x, bev->y, buttonstate);
+        sdl_send_mouse_event(scon, 0, 0, x, y, buttonstate);
     }
 }
 
-- 
2.47.2


