Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7DEC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKR3B-0003yQ-09; Thu, 20 Jun 2024 19:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR39-0003y2-N8
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:39 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sKR37-0001hV-UY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 19:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718925518; x=1750461518;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0PTTGxWxRaGqd6xV5WpwchsG1utShWc0Ne1B3hPt9n8=;
 b=AUbvEFUIbJYpBYo+vlDewvKXOV5DHKTnwiyOrPqRGYnw00gmDvOrkvXz
 L7PD1vvp23LuLiOIQ1sgpkcMXfQeICKhAEWrvzlSRcmVRwQcUuT6OPDmu
 GT/+pahsQZgLIp3gKcDancz0d1eSwNYq+gXisEyrKIdlZCjc2wWaIivxh
 SV8zPe6ebSRIg1OwZLcIsRUv7u9jPBzNONjdh5jHf1XVzdXah9paWgCwQ
 e/yDyfD/2D3z4i7WsTPrfoMfsGc4SivPZQ0Mz/fnZTkH1kjg1AorOiTsC
 4v/c05jEIBOzWkPIwvHKyaJryb0RtpDhWe6Xoet/Ig9OShfb/W2/YtMJr A==;
X-CSE-ConnectionGUID: 2fDg6VL0ROydXn+O7y49rA==
X-CSE-MsgGUID: S/hvYSOATzakQTxhdm0KQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="33482966"
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="33482966"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2024 16:18:29 -0700
X-CSE-ConnectionGUID: g94ORT4uR0mWXhGp06x4JA==
X-CSE-MsgGUID: h8rg1RqXSeC9TiAKq2Ir+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,253,1712646000"; d="scan'208";a="42359631"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa008.fm.intel.com with ESMTP; 20 Jun 2024 16:18:28 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/4] ui/egl-helpers: Consolidates create-sync and
 create-fence
Date: Thu, 20 Jun 2024 16:17:25 -0700
Message-Id: <20240620231727.235841-3-dongwon.kim@intel.com>
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

There is no reason to split those two operations so combining
two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/egl-helpers.h |  3 +--
 ui/egl-helpers.c         | 27 +++++++++++----------------
 ui/gtk-egl.c             | 19 +++++++------------
 ui/gtk-gl-area.c         | 10 ++--------
 4 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 4b8c0d2281..606d6c8288 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
+int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
 
 #endif
 
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 99b2ebbe23..e16f2cb23d 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -371,34 +371,29 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
     qemu_dmabuf_set_texture(dmabuf, 0);
 }
 
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
+int egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
 {
     EGLSyncKHR sync;
+    int fence_fd = -1;
 
     if (epoxy_has_egl_extension(qemu_egl_display,
                                 "EGL_KHR_fence_sync") &&
         epoxy_has_egl_extension(qemu_egl_display,
-                                "EGL_ANDROID_native_fence_sync")) {
+                                "EGL_ANDROID_native_fence_sync") &&
+        qemu_dmabuf_get_fence_fd(dmabuf) == -1) {
         sync = eglCreateSyncKHR(qemu_egl_display,
                                 EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
         if (sync != EGL_NO_SYNC_KHR) {
-            qemu_dmabuf_set_sync(dmabuf, sync);
+            fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
+                                                  sync);
+            if (fence_fd >= 0) {
+                qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
+            }
+            eglDestroySyncKHR(qemu_egl_display, sync);
         }
     }
-}
-
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
-{
-    void *sync = qemu_dmabuf_get_sync(dmabuf);
-    int fence_fd;
 
-    if (sync) {
-        fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
-                                              sync);
-        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
-        eglDestroySyncKHR(qemu_egl_display, sync);
-        qemu_dmabuf_set_sync(dmabuf, NULL);
-    }
+    return fence_fd;
 }
 
 #endif /* CONFIG_GBM */
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 9831c10e1b..55199f8659 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,7 +68,6 @@ void gd_egl_draw(VirtualConsole *vc)
     GdkWindow *window;
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
-    int fence_fd;
 #endif
     int ww, wh, ws;
 
@@ -99,13 +98,12 @@ void gd_egl_draw(VirtualConsole *vc)
         glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            egl_dmabuf_create_fence(dmabuf);
-            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+            fence_fd = egl_dmabuf_create_fence(dmabuf);
             if (fence_fd >= 0) {
                 qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
-                return;
+            } else {
+                graphic_hw_gl_block(vc->gfx.dcl.con, false);
             }
-            graphic_hw_gl_block(vc->gfx.dcl.con, false);
         }
 #endif
     } else {
@@ -336,7 +334,11 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *window;
+#ifdef CONFIG_GBM
+    QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
+#endif
     int ww, wh, ws;
+    int fence_fd;
 
     if (!vc->gfx.scanout_mode) {
         return;
@@ -364,12 +366,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
         egl_fb_blit(&vc->gfx.win_fb, &vc->gfx.guest_fb, !vc->gfx.y0_top);
     }
 
-#ifdef CONFIG_GBM
-    if (vc->gfx.guest_fb.dmabuf) {
-        egl_dmabuf_create_sync(vc->gfx.guest_fb.dmabuf);
-    }
-#endif
-
     eglSwapBuffers(qemu_egl_display, vc->gfx.esurface);
 }
 
@@ -387,7 +383,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
     }
-
     gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
 }
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index b628b35451..0b11423824 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -77,17 +77,10 @@ void gd_gl_area_draw(VirtualConsole *vc)
         glBlitFramebuffer(0, y1, vc->gfx.w, y2,
                           0, 0, ww, wh,
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
-#ifdef CONFIG_GBM
-        if (dmabuf) {
-            egl_dmabuf_create_sync(dmabuf);
-        }
-#endif
-        glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
             int fence_fd;
-            egl_dmabuf_create_fence(dmabuf);
-            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+            fence_fd = egl_dmabuf_create_fence(dmabuf);
             if (fence_fd >= 0) {
                 qemu_set_fd_handler(fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
@@ -95,6 +88,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             graphic_hw_gl_block(vc->gfx.dcl.con, false);
         }
 #endif
+        glFlush();
     } else {
         if (!vc->gfx.ds) {
             return;
-- 
2.34.1


