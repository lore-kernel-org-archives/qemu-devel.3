Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDEEC2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKR3D-0003zS-Gz; Thu, 20 Jun 2024 19:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR3C-0003yr-7M
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:42 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR3A-0001hp-Ee
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718925521; x=1750461521;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=aUhUdVN61RQrZr1LHcic/H9Yj04gNHVHexZdw7CMyVg=;
 b=MTnKR4gSD5DFe9QHyG8pcHnBO8YvG6YnmNm6eNAzdFYFhW33vXIUdiSJ
 IU1ph9il/RXt6dBA+r7BjzDoFThK7uk9xFBd7C+NwY03gUNb2C8U3mPP0
 9r7P1uZPVWcx7KLk1hF/AlKjjOYbZZpA2P2pknYlSOzbewYzSL/Znr4LL
 352UEMj3sw2XcBFfHkr90Vs5Xx87jsCQEkWzKbGcrbvALiCSk4BZ2nr2h
 +e0+dZM1TFB4mKyvxKL1lCv5foiT+XbsQzx3ElDtYM9UrcenAJGzDV2e4
 Fc9UIMqrmhXf+P4NrrMnOvb9lN3T2g2KpiJYRG0glV1qSmilYcH9f5IMl g==;
X-CSE-ConnectionGUID: iPzljJogSJORDeRQxE54qA==
X-CSE-MsgGUID: oKOU+YJ/SDawBsn/1loIkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33482969"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="33482969"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 16:18:29 -0700
X-CSE-ConnectionGUID: +tFeFk7MTWW1ebk3G1pfXw==
X-CSE-MsgGUID: NYwO/zOyRX6sH6cagwXI9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="42359633"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 16:18:28 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] ui/gtk-gl-draw: Start rendering of guest blob scanout
 if render_sync is off
Date: Thu, 20 Jun 2024 16:17:27 -0700
Message-Id: <20240620231727.235841-5-dongwon.kim@intel.com>
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

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-gl-area.c | 84 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 0b11423824..88d4e66a52 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -65,39 +65,36 @@ void gd_gl_area_draw(VirtualConsole *vc)
             } else {
                 qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
-        }
-#endif
 
-        glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
-        /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
-
-        glViewport(0, 0, ww, wh);
-        y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
-        y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
-        glBlitFramebuffer(0, y1, vc->gfx.w, y2,
-                          0, 0, ww, wh,
-                          GL_COLOR_BUFFER_BIT, GL_NEAREST);
-#ifdef CONFIG_GBM
-        if (dmabuf) {
-            int fence_fd;
-            fence_fd = egl_dmabuf_create_fence(dmabuf);
-            if (fence_fd >= 0) {
-                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
-                return;
+            if (qemu_dmabuf_get_render_sync(dmabuf)) {
+                int fence_fd;
+                glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
+                /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
+
+                glViewport(0, 0, ww, wh);
+                y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
+                y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
+                glBlitFramebuffer(0, y1, vc->gfx.w, y2,
+                                  0, 0, ww, wh,
+                                  GL_COLOR_BUFFER_BIT, GL_NEAREST);
+                fence_fd = egl_dmabuf_create_fence(dmabuf);
+                if (fence_fd >= 0) {
+                    qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
+                } else {
+                    graphic_hw_gl_block(vc->gfx.dcl.con, false);
+                }
             }
-            graphic_hw_gl_block(vc->gfx.dcl.con, false);
         }
 #endif
-        glFlush();
     } else {
         if (!vc->gfx.ds) {
             return;
         }
-        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
 
         surface_gl_setup_viewport(vc->gfx.gls, vc->gfx.ds, ww, wh);
         surface_gl_render_texture(vc->gfx.gls, vc->gfx.ds);
     }
+    glFlush();
 }
 
 void gd_gl_area_update(DisplayChangeListener *dcl,
@@ -119,13 +116,19 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+#ifdef CONFIG_GBM
+    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+#endif
+
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
+#ifdef CONFIG_GBM
+    if (dmabuf && qemu_dmabuf_get_draw_submitted(dmabuf) &&
+        qemu_dmabuf_get_render_sync(dmabuf)) {
         gd_gl_area_draw(vc);
         return;
     }
+#endif
 
     if (!vc->gfx.gls) {
         if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
@@ -282,13 +285,42 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
                           uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
+#ifdef CONFIG_GBM
+    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+    int ww, wh, ws, y1, y2;
+
+    if (dmabuf && !qemu_dmabuf_get_draw_submitted(dmabuf)) {
+        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
+        ws = gdk_window_get_scale_factor(gtk_widget_get_window(vc->gfx.drawing_area));
+        ww = gtk_widget_get_allocated_width(vc->gfx.drawing_area) * ws;
+        wh = gtk_widget_get_allocated_height(vc->gfx.drawing_area) * ws;
 
-    if (vc->gfx.guest_fb.dmabuf &&
-        !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
+        qemu_dmabuf_set_draw_submitted(dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
+        if (!qemu_dmabuf_get_render_sync(dmabuf)) {
+            int fence_fd;
+            glBindFramebuffer(GL_READ_FRAMEBUFFER, vc->gfx.guest_fb.framebuffer);
+            /* GtkGLArea sets GL_DRAW_FRAMEBUFFER for us */
+
+            glViewport(0, 0, ww, wh);
+            y1 = vc->gfx.y0_top ? 0 : vc->gfx.h;
+            y2 = vc->gfx.y0_top ? vc->gfx.h : 0;
+            glBlitFramebuffer(0, y1, vc->gfx.w, y2,
+                              0, 0, ww, wh,
+                              GL_COLOR_BUFFER_BIT, GL_NEAREST);
+
+            egl_dmabuf_create_fence(dmabuf);
+            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+            if (fence_fd >= 0) {
+                qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
+            } else {
+                graphic_hw_gl_block(vc->gfx.dcl.con, false);
+            }
+        }
     }
+#endif
+
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
 }
 
-- 
2.34.1


