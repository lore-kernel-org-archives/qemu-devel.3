Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1402CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 22:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWNcl-0008DR-6z; Tue, 23 Jul 2024 18:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sWNci-000880-Uf
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 18:04:45 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sWNch-0002Cd-4f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 18:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721772283; x=1753308283;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xw+Od6uHSyed8v4SnhD/CR9QclCIv8RmGdTi85CVUps=;
 b=gDP991h/l1vrbsTWkpLQ/YKKk2TSJQerN2XgeSaYKCAYhUMbunRKG/OU
 jVTB31809lQ8G9jMgtyUSgPY+nYRfSNjbXw0fFOYVe399riNM7FHNkhtl
 xN53FS/Tb7GHIKwau1+vR6PQ1yFI0BalPd20JYPuSR83q1KCFfj2dUaiv
 SrD8O0GTMXWhPgvSy1ngxQTsWQgz5utETfBSPdF/Jg6WMkpwCg2E3J5Tc
 PPPEbMgcVa80N5df/H2spuZThC3fb+kTVnUp1SCxKXvXHhtMgiy3Qeu/R
 bV9f+wrULua3Xoec9fC8O4HZlp6Wp6MUnry4zfrKjVxUdlDMVMGwRdxbW A==;
X-CSE-ConnectionGUID: 0ur9jyu4QT2xsLlLrtFG/A==
X-CSE-MsgGUID: qEBkZYkfRPOTd7QFu/JySQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19298442"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; d="scan'208";a="19298442"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 15:04:34 -0700
X-CSE-ConnectionGUID: 1HmcIXR6QEiRw1oTDDIbuQ==
X-CSE-MsgGUID: e4HNJXgGTiWGHLVUDK2fxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; d="scan'208";a="57198647"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by orviesa003.jf.intel.com with ESMTP; 23 Jul 2024 15:04:33 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] ui/egl-helpers: Consolidates create-sync and
 create-fence
Date: Tue, 23 Jul 2024 15:02:57 -0700
Message-Id: <20240723220258.3170957-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723220258.3170957-1-dongwon.kim@intel.com>
References: <20240723220258.3170957-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

There is no reason to split those two operations so combining
two functions - egl_dmabuf_create_sync and egl_dmabuf_create_fence.

v2: egl_dmabuf_create_fence -> egl_dmabuf_create_fence_fd
    (Marc-André Lureau <marcandre.lureau@redhat.com>)

v3: create fence only if current QemuDmaBuf->fence_fd = -1
    to make sure there is no fence currently bound to the
    QemuDmaBuf

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/egl-helpers.h |  3 +--
 ui/egl-helpers.c         | 24 +++++++++---------------
 ui/gtk-egl.c             | 17 ++++-------------
 ui/gtk-gl-area.c         | 12 +++---------
 4 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 4b8c0d2281..221548e3c9 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -51,8 +51,7 @@ int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
 
 void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf);
 void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf);
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf);
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf);
+int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf);
 
 #endif
 
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 99b2ebbe23..67c90abe18 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -371,9 +371,10 @@ void egl_dmabuf_release_texture(QemuDmaBuf *dmabuf)
     qemu_dmabuf_set_texture(dmabuf, 0);
 }
 
-void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
+int egl_dmabuf_create_fence_fd(QemuDmaBuf *dmabuf)
 {
     EGLSyncKHR sync;
+    int fence_fd = -1;
 
     if (epoxy_has_egl_extension(qemu_egl_display,
                                 "EGL_KHR_fence_sync") &&
@@ -382,23 +383,16 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
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
index 9831c10e1b..9983b0423a 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -68,7 +68,6 @@ void gd_egl_draw(VirtualConsole *vc)
     GdkWindow *window;
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
-    int fence_fd;
 #endif
     int ww, wh, ws;
 
@@ -98,14 +97,13 @@ void gd_egl_draw(VirtualConsole *vc)
 
         glFlush();
 #ifdef CONFIG_GBM
-        if (dmabuf) {
-            egl_dmabuf_create_fence(dmabuf);
-            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+        if (dmabuf && qemu_dmabuf_get_fence_fd(dmabuf) == -1) {
+            int fence_fd = egl_dmabuf_create_fence_fd(dmabuf);
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
@@ -364,12 +362,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
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
 
@@ -387,7 +379,6 @@ void gd_egl_flush(DisplayChangeListener *dcl,
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
     }
-
     gd_egl_scanout_flush(&vc->gfx.dcl, x, y, w, h);
 }
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index b628b35451..929bb49290 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -78,16 +78,9 @@ void gd_gl_area_draw(VirtualConsole *vc)
                           0, 0, ww, wh,
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
 #ifdef CONFIG_GBM
-        if (dmabuf) {
-            egl_dmabuf_create_sync(dmabuf);
-        }
-#endif
-        glFlush();
-#ifdef CONFIG_GBM
-        if (dmabuf) {
+        if (dmabuf && qemu_dmabuf_get_fence_fd(dmabuf) == -1) {
             int fence_fd;
-            egl_dmabuf_create_fence(dmabuf);
-            fence_fd = qemu_dmabuf_get_fence_fd(dmabuf);
+            fence_fd = egl_dmabuf_create_fence_fd(dmabuf);
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
2.43.0


