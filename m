Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2802CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 04:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwwgc-0007BY-OU; Wed, 17 Apr 2024 00:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwwga-0007B8-MB
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:14:16 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rwwgY-0006J8-HQ
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 00:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713327254; x=1744863254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VUF4uTVHQQwcIgc2IkzWhuF4P13jR1cs03eo4A3sTeE=;
 b=Hw1VZeiiJqJN1HamW5NOR10Eyvy9OfjxD5WGW6Bj3gm9SX0X2C/cvpDD
 fSpULNLs5ukHlpG2l2VpcFF7w7FJbVzgMwhNgoEmZhy8KfmQsVzGA9xk4
 6inJDrHn3iVDlXLAdd56G0d4n5P3kl1TOfr5hpFVrhKbZXpyA6Yy3Hyav
 MQYExucnd4vqQbMWQxvZikSLRTk5d3873ZqYEvLJzkptLCpkCy8wCJLLC
 hYS+N6jmrCBJLq02mRxxMbqlZ5AvfMiRD0cSKNfD7KwEXdiljp3mbhgw6
 AtvN588dwVeacLutK9mGk3krlmSCrz0Nz3+YZ8UrBa53+pzVg58ytolJF A==;
X-CSE-ConnectionGUID: ZPG2OwdIT6iFEu8pyj++CQ==
X-CSE-MsgGUID: ZOiANb0qQWmzpACkJ6VZhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12582851"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="12582851"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 21:14:06 -0700
X-CSE-ConnectionGUID: 1AijJvaMS2WXWrXRPxIKow==
X-CSE-MsgGUID: UTEAAGRXQyOSYGGFZJQfwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="22491574"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa009.jf.intel.com with ESMTP; 16 Apr 2024 21:14:06 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v6 2/3] ui/console: Introduce dpy_gl_qemu_dmabuf_set_..()
 helpers
Date: Tue, 16 Apr 2024 21:09:53 -0700
Message-Id: <20240417040954.55641-3-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417040954.55641-1-dongwon.kim@intel.com>
References: <20240417040954.55641-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

To enhance security in accessing the QemuDmaBuf struct, new helper
functions for setting specific fields within the struct were introduced.
And all occurrences where these fields were previously set directly
have been updated to utilize these helper functions.

Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/console.h |  5 +++++
 ui/console.c         | 30 ++++++++++++++++++++++++++++++
 ui/egl-helpers.c     | 16 +++++++++-------
 ui/gtk-egl.c         |  4 ++--
 ui/gtk-gl-area.c     |  4 ++--
 ui/gtk.c             |  2 +-
 6 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 6292943a82..3d9d8b9fce 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -375,6 +375,11 @@ void *dpy_gl_qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
 int32_t dpy_gl_qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
 bool dpy_gl_qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
 bool dpy_gl_qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
+void dpy_gl_qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
+void dpy_gl_qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
+void dpy_gl_qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
+void dpy_gl_qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted);
+void dpy_gl_qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/ui/console.c b/ui/console.c
index 5d5635f783..d4ca9e6e0f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1244,6 +1244,36 @@ bool dpy_gl_qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
     return dmabuf->draw_submitted;
 }
 
+void dpy_gl_qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
+{
+    assert(dmabuf != NULL);
+    dmabuf->texture = texture;
+}
+
+void dpy_gl_qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd)
+{
+    assert(dmabuf != NULL);
+    dmabuf->fence_fd = fence_fd;
+}
+
+void dpy_gl_qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync)
+{
+    assert(dmabuf != NULL);
+    dmabuf->sync = sync;
+}
+
+void dpy_gl_qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submitted)
+{
+    assert(dmabuf != NULL);
+    dmabuf->draw_submitted = draw_submitted;
+}
+
+void dpy_gl_qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
+{
+    assert(dmabuf != NULL);
+    dmabuf->fd = fd;
+}
+
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 86d64c68ce..c71a2878c2 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -348,8 +348,8 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
         return;
     }
 
-    glGenTextures(1, &dmabuf->texture);
-    texture = dpy_gl_qemu_dmabuf_get_texture(dmabuf);
+    glGenTextures(1, &texture);
+    dpy_gl_qemu_dmabuf_set_texture(dmabuf, texture);
     glBindTexture(GL_TEXTURE_2D, texture);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
@@ -368,7 +368,7 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
     }
 
     glDeleteTextures(1, &texture);
-    dmabuf->texture = 0;
+    dpy_gl_qemu_dmabuf_set_texture(dmabuf, 0);
 }
 
 void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
@@ -382,7 +382,7 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
         sync = eglCreateSyncKHR(qemu_egl_display,
                                 EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
         if (sync != EGL_NO_SYNC_KHR) {
-            dmabuf->sync = sync;
+            dpy_gl_qemu_dmabuf_set_sync(dmabuf, sync);
         }
     }
 }
@@ -390,12 +390,14 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
 void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
 {
     void *sync = dpy_gl_qemu_dmabuf_get_sync(dmabuf);
+    int fence_fd;
 
     if (sync) {
-        dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
-                                                      sync);
+        fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
+                                              sync);
+        dpy_gl_qemu_dmabuf_set_fence_fd(dmabuf, fence_fd);
         eglDestroySyncKHR(qemu_egl_display, sync);
-        dmabuf->sync = NULL;
+        dpy_gl_qemu_dmabuf_set_sync(dmabuf, NULL);
     }
 }
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index c9469af9ed..7494a34d7c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -87,7 +87,7 @@ void gd_egl_draw(VirtualConsole *vc)
             if (!dpy_gl_qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
-                dmabuf->draw_submitted = false;
+                dpy_gl_qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
         }
 #endif
@@ -381,7 +381,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf &&
         !dpy_gl_qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        dpy_gl_qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_egl_set_scanout_mode(vc, true);
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 193862ecc2..26b9689a5f 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -63,7 +63,7 @@ void gd_gl_area_draw(VirtualConsole *vc)
             if (!dpy_gl_qemu_dmabuf_get_draw_submitted(dmabuf)) {
                 return;
             } else {
-                dmabuf->draw_submitted = false;
+                dpy_gl_qemu_dmabuf_set_draw_submitted(dmabuf, false);
             }
         }
 #endif
@@ -291,7 +291,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf &&
         !dpy_gl_qemu_dmabuf_get_draw_submitted(vc->gfx.guest_fb.dmabuf)) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
-        vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        dpy_gl_qemu_dmabuf_set_draw_submitted(vc->gfx.guest_fb.dmabuf, true);
         gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
diff --git a/ui/gtk.c b/ui/gtk.c
index 2c054a42ba..b6a1f6f897 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -601,7 +601,7 @@ void gd_hw_gl_flushed(void *vcon)
     fence_fd = dpy_gl_qemu_dmabuf_get_fence_fd(dmabuf);
     qemu_set_fd_handler(fence_fd, NULL, NULL, NULL);
     close(fence_fd);
-    dmabuf->fence_fd = -1;
+    dpy_gl_qemu_dmabuf_set_fence_fd(dmabuf, -1);
     graphic_hw_gl_block(vc->gfx.dcl.con, false);
 }
 
-- 
2.34.1


