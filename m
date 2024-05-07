Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20662C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 18:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4PmT-0005IO-5q; Tue, 07 May 2024 14:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4PmN-0005HR-Fi
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:43:07 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s4PmK-0005LJ-GA
 for qemu-devel@nongnu.org; Tue, 07 May 2024 14:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715107385; x=1746643385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DyroyyPwTLRM4k5xeCFYw/8XEqvtDDE72GldM7N945s=;
 b=Bvi44rG92Th8xehPMl0XuR0N80Wtd1x/Ivljdpi8AMVaLCZfqJ7q5als
 E+PhmXpA3OJUQ6S4kYwsfhIuIRNYZIvUdaUS53OuAmGaGKL/ye43gG3Uq
 RnYa4oQfc1CAYXoyl0ozlirSSvVwANSsyop4KT8fxm8DbEzdDM7NOSItd
 NkxQqoCMr0TLw/JTIwySEYPwz3abLHIgm9KjruLQmNu2dQZ7eRNL+h+3e
 lZ14M8PDtl4PUlcQQOX0gvDS+0b/J+3i/7Y1uzyt74zkny6kmfpZJ0j4f
 J84ymdr2M5xsfXQJq85y1dWiTaXzeUwrAnOU5+sAnz1ic5IPd7UlKRYyc g==;
X-CSE-ConnectionGUID: sDBu2WEpTbKVUXHvUSm7Ug==
X-CSE-MsgGUID: cDzJitHpQquu6dg5XXQzQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22321498"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="22321498"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 11:42:56 -0700
X-CSE-ConnectionGUID: OMwQTUvWSX+BSkdrfRI1AQ==
X-CSE-MsgGUID: rZsIjJT7SsuPiTTawHLq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; d="scan'208";a="29031362"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa006.jf.intel.com with ESMTP; 07 May 2024 11:42:56 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v13 4/6] ui/console: Use qemu_dmabuf_set_..() helpers instead
Date: Tue,  7 May 2024 11:37:55 -0700
Message-Id: <20240507183757.3383641-5-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507183757.3383641-1-dongwon.kim@intel.com>
References: <20240507183757.3383641-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

This commit updates all occurrences where these fields were
set directly have been updated to utilize helper functions.

v7: removed prefix, "dpy_gl_" from all helpers

v8: Introduction of helpers was removed as those were already added
    by the previous commit

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/egl-helpers.c | 16 +++++++++-------
 ui/gtk-egl.c     |  4 ++--
 ui/gtk-gl-area.c |  4 ++--
 ui/gtk.c         |  6 +++---
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 3f96e63d25..99b2ebbe23 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -348,8 +348,8 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
         return;
     }
 
-    glGenTextures(1, &dmabuf->texture);
-    texture = qemu_dmabuf_get_texture(dmabuf);
+    glGenTextures(1, &texture);
+    qemu_dmabuf_set_texture(dmabuf, texture);
     glBindTexture(GL_TEXTURE_2D, texture);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
@@ -368,7 +368,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
     }
 
     glDeleteTextures(1, &texture);
-    dmabuf->texture = 0;
+    qemu_dmabuf_set_texture(dmabuf, 0);
 }
 
 void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
@@ -382,7 +382,7 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
         sync = eglCreateSyncKHR(qemu_egl_display,
                                 EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
         if (sync != EGL_NO_SYNC_KHR) {
-            dmabuf->sync = sync;
+            qemu_dmabuf_set_sync(dmabuf, sync);
         }
     }
 }
@@ -390,12 +390,14 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
 void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
 {
     void *sync = qemu_dmabuf_get_sync(dmabuf);
+    int fence_fd;
 
     if (sync) {
-        dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
-                                                      sync);
+        fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
+                                              sync);
+        qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
         eglDestroySyncKHR(qemu_egl_display, sync);
-        dmabuf->sync = NULL;
+        qemu_dmabuf_set_sync(dmabuf, NULL);
     }
 }
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 7a45daefa1..ec0bf45482 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -87,7 +87,7 @@ void gd_egl_draw(VirtualConsole *vc)
             if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
-                dmabuf->draw_submitted = false;
+                qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
         }
 #endif
@@ -381,7 +381,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_egl_set_scanout_mode(vc, true);
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 2d70280803..9a3f3d0d71 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -63,7 +63,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             if (!qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
-                dmabuf->draw_submitted = false;
+                qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
         }
 #endif
@@ -291,7 +291,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf &&
         !qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
diff --git a/ui/gtk.c b/ui/gtk.c
index 237c913b26..3a6832eb1b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -598,11 +598,11 @@ void gd_hw_gl_flushed(void *vcon)
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
     int fence_fd;
 
-    if (dmabuf->fence_fd >= 0) {
-        fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+    fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+    if (fence_fd >= 0) {
         qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
         close(fence_fd);
-        dmabuf->fence_fd = -1;
+        qemu_dmabuf_set_fence_fd(dmabuf, -1);
         graphic_hw_gl_block(vc->gfx.dcl.con, false);
     }
 }
-- 
2.34.1


