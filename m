Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD8EC54FB3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsnA-0000yI-49; Sat, 24 May 2025 13:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsn7-0000dw-8W
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uIsn5-0000lI-LB
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748108171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jHlFib1jbqDOGmIU5Jdl45qo+cDKFJf60/0MFNRQ3w=;
 b=hCupxoGd0GrxQeuT+uzqnca3uC9766k3fMa2/Whqv60gpYBIm24hA7dwqihKN/mCuctdfH
 dYWTe3C2ZM6qsk195gPRArjz1eZW9nO24y+rfr6NX5O4G2gV4iSFN1DGmalTcstuwS52yW
 0u4AM6mmhpjTEWhYl9D26m4/75sad1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297--bDCd0xNO7W4cPDU3vykjQ-1; Sat,
 24 May 2025 13:36:09 -0400
X-MC-Unique: -bDCd0xNO7W4cPDU3vykjQ-1
X-Mimecast-MFC-AGG-ID: -bDCd0xNO7W4cPDU3vykjQ_1748108169
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB2E2180048E; Sat, 24 May 2025 17:36:08 +0000 (UTC)
Received: from localhost (unknown [10.45.242.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85CC030001A1; Sat, 24 May 2025 17:36:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 stefanha@redhat.com, Weifeng Liu <weifeng.liu@intel.com>
Subject: [PULL 15/19] ui/sdl: Consider scaling in mouse event handling
Date: Sat, 24 May 2025 19:35:08 +0200
Message-ID: <20250524173514.317886-16-marcandre.lureau@redhat.com>
In-Reply-To: <20250524173514.317886-1-marcandre.lureau@redhat.com>
References: <20250524173514.317886-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Weifeng Liu <weifeng.liu@intel.com>

When using sdl display backend, if the window is scaled, incorrect mouse
positions will be reported since scaling is not properly handled. Fix it
by transforming the positions from window coordinate to guest buffer
coordinate.

Signed-off-by: Weifeng Liu <weifeng.liu@intel.com>
Message-ID: <20250511073337.876650-6-weifeng.liu.z@gmail.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/sdl2.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

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
2.49.0


