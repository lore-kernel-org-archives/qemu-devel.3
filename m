Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23244C2BD05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKR3C-0003yp-2W; Thu, 20 Jun 2024 19:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR3B-0003yR-1V
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:41 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR39-0001h8-8B
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718925519; x=1750461519;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rRv8TGUFB03Gz8XizonszwHP/JcMDSmmaYVfyiwCYds=;
 b=fM9mO7x9U5vygofPwwgoN4uQ0WV923XrPD+DUTXBtOvrfAMfeKrWui/+
 1ngVtgwf7orQsbywaZ582j9HG2hU1Bqg/Swy9rdES+S3GBI5i3O/5aTaE
 EMDxam1o8eg1IWTuXC18kaX4me3u4fJCoRTr3rSZLXrapRHLy8h99hqt8
 DHbxnl+KfC9oYq5bnlF6WT8AjmNpwC6tbbyvsXlKSzuTt7/+Slrh2m85Y
 oDHh0jiW/0ctyOXPN27CdHX3RhVfZMebqKoY1wXRip70egBis5Rv/aw6C
 /rG44PH4HBP7R+DsEPE5XKpYzPxEtsy0S1v7UTDHL7qSHOYoUpIefLiso g==;
X-CSE-ConnectionGUID: vLCnBx8ERiCGASfEtUHHdA==
X-CSE-MsgGUID: EEmVyGVZSRu6ewGJoMgiwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33482967"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="33482967"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 16:18:29 -0700
X-CSE-ConnectionGUID: t/EKEU9OQKOr77AXGCMlFQ==
X-CSE-MsgGUID: X3x/bQgWT1qT6fAbH4T90w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="42359632"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 16:18:28 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/4] ui/gtk-egl: Start rendering of guest blob scanout if
 render_sync is off
Date: Thu, 20 Jun 2024 16:17:26 -0700
Message-Id: <20240620231727.235841-4-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620231727.235841-1-dongwon.kim@intel.com>
References: <20240620231727.235841-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Dongwon Kim <dongwon.kim@intel.com>

Draw (executing glBlitFramebuffer) immediately as soon as the frame
is flushed instead of getting it done in the next draw event if render_sync
flag is reset. With this, the fence will be signaled way ealier so the guest
can be working on the next frame right away.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c | 88 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 37 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 55199f8659..2877140c3b 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -80,6 +80,12 @@ void gd_egl_draw(VirtualConsole *vc)
     ww = gdk_window_get_width(window) * ws;
     wh = gdk_window_get_height(window) * ws;
 
+    vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
+    vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
+
+    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                   vc->gfx.esurface, vc->gfx.ectx);
+
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
         if (dmabuf) {
@@ -88,21 +94,9 @@ void gd_egl_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
-        }
-#endif
-        gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
 
-        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
-        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
-
-        glFlush();
-#ifdef CONFIG_GBM
-        if (dmabuf) {
-            fence_fd = egl_dmabuf_create_fence(dmabuf);
-            if (fence_fd >= 0) {
-                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
-            } else {
-                graphic_hw_gl_block(vc->gfx.dcl.con, false);
+            if (qemu_dmabuf_get_render_sync(dmabuf)) {
+                gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
             }
         }
 #endif
@@ -110,19 +104,12 @@ void gd_egl_draw(VirtualConsole *vc)
         if (!vc->gfx.ds) {
             return;
         }
-        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                       vc->gfx.esurface, vc->gfx.ectx);
-
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
-
-        eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
-
-        vc->gfx.scale_x = (double)ww / surface_width(vc->gfx.ds);
-        vc->gfx.scale_y = (double)wh / surface_height(vc->gfx.ds);
-
-        glFlush();
     }
+
+    eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
+    glFlush();
 }
 
 void gd_egl_update(DisplayChangeListener *dcl,
@@ -146,14 +133,20 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+#ifdef CONFIG_GBM
+    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+#endif
+
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
+#ifdef CONFIG_GBM
+    if (dmabuf && qemu_dmabuf_get_draw_submitted(dmabuf) &&
+        qemu_dmabuf_get_render_sync(dmabuf)) {
         gd_egl_draw(vc);
         return;
     }
+#endif
 
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
@@ -166,9 +159,9 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
             surface_gl_create_texture(vc->gfx.gls, vc->gfx.ds);
         }
 #ifdef CONFIG_GBM
-        if (vc->gfx.guest_fb.dmabuf) {
-            egl_dmabuf_release_texture(vc->gfx.guest_fb.dmabuf);
-            gd_egl_scanout_dmabuf(dcl, vc->gfx.guest_fb.dmabuf);
+        if (dmabuf) {
+            egl_dmabuf_release_texture(dmabuf);
+            gd_egl_scanout_dmabuf(dcl, dmabuf);
         }
 #endif
     }
@@ -344,6 +337,11 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
         return;
     }
     if (!vc->gfx.guest_fb.framebuffer) {
+#ifdef CONFIG_GBM
+        if (dmabuf) {
+            graphic_hw_gl_block(vc->gfx.dcl.con, false);
+        }
+#endif
         return;
     }
 
@@ -366,7 +364,16 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
         egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
     }
 
-    eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
+#ifdef CONFIG_GBM
+    if (dmabuf) {
+        fence_fd = egl_dmabuf_create_fence(dmabuf);
+        if (fence_fd >= 0) {
+            qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
+        } else {
+            graphic_hw_gl_block(vc->gfx.dcl.con, false);
+        }
+    }
+#endif
 }
 
 void gd_egl_flush(DisplayChangeListener *dcl,
@@ -374,15 +381,22 @@ void gd_egl_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GtkWidget *area = vc->gfx.drawing_area;
-
-    if (vc->gfx.guest_fb.dmabuf &&
-        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
-        graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
-        gtk_egl_set_scanout_mode(vc, true);
-        gtk_widget_queue_draw_area(area, x, y, w, h);
+#ifdef CONFIG_GBM
+    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+    if (dmabuf) {
+        if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
+            graphic_hw_gl_block(vc->gfx.dcl.con, true);
+            qemu_dmabuf_set_draw_submitted(dmabuf, true);
+            gtk_egl_set_scanout_mode(vc, true);
+            if (!qemu_dmabuf_get_render_sync(dmabuf)) {
+                gd_egl_scanout_flush(&vc->gfx.dcl, 0, 0, vc->gfx.w, vc->gfx.h);
+            }
+            gtk_widget_queue_draw_area(area, x, y, w, h);
+        }
         return;
     }
+#endif
+
     gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
 }
 
-- 
2.34.1


