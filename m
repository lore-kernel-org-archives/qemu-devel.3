Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9023FC54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 01:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn7ee-0004SB-TI; Wed, 20 Mar 2024 21:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn7ec-0004Rd-Ie
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 21:55:38 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rn7ea-00060l-9m
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 21:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710986136; x=1742522136;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BzwS8i53kcmZ55BpLau5lBJ8XuGlzUkahYpnC1wnPBY=;
 b=kcapedO1BSopw0S9UY2LX83xQJhYTClV6SRBl/LYbT8aDoW1BDuBKrXn
 dDWnrr9batyWOxGJo/RrRL20nrESjetz4VhY8IpTZU+FnG4a3nDfvh1xK
 bGrJJoyPsZiStaoiD6oocC2AW5JJ6Xme4+77WQ3fz35i7V+YIuFOW2u03
 vHvGM5urzoQX+yJnn82mQypvP764Z1HmtWYamdjyuqa6bndmbrfvb7HxH
 3/WzcL/1p0xd471JSPdqgD2/cpug72uj9HlwbqVOpe0Rj5qySnqGeFI6+
 7Pez1DTC9mAczNczsbdIRfLgryxR9Tumy/bPgWLb6iE2hc49MMmzK1K36 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="16589706"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="16589706"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 18:55:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="18992119"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa004.fm.intel.com with ESMTP; 20 Mar 2024 18:55:32 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH v4] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
Date: Wed, 20 Mar 2024 18:53:57 -0700
Message-Id: <20240321015357.3365982-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It is required to ensure the current scanout frame is completed
before transitioning guest's run-state to save to prevent potential
guest waiting for the response on the resource flush of the old
scanout frame upon resume.

v2: Giving some time for the fence to be signaled before flushing
    the pipeline

v3: Prevent redudant call of gd_hw_gl_flushed by checking dmabuf
    and fence_fd >= 0 in it (e.g. during and after eglClientWaitSync
    in gd_change_runstate)

v4: Rewrote the commit msg

    Creating fence_fd in the same function where sync is created to
    handle the case where the valid sync is created but fence_fd is
    failed to be created.

    0 is a valid fd so any fence_fd > -1 for the fence in draw function
    in gtk-egl.c and gtk-gl-area.c will be considered valid

    egl_sync and fence_fd for it are created in the same function

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/egl-helpers.c | 16 ++++++----------
 ui/gtk-egl.c     | 10 ++--------
 ui/gtk-gl-area.c |  9 ++-------
 ui/gtk.c         | 31 +++++++++++++++++++++++++++----
 4 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 3d19dbe382..b6a8169ffc 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -376,20 +376,16 @@ void egl_dmabuf_create_sync(QemuDmaBuf *dmabuf)
                                 EGL_SYNC_NATIVE_FENCE_ANDROID, NULL);
         if (sync != EGL_NO_SYNC_KHR) {
             dmabuf->sync = sync;
+            dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
+                                                          dmabuf->sync);
+            if (dmabuf->fence_fd < 0) {
+                eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
+                dmabuf->sync = NULL;
+            }
         }
     }
 }
 
-void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
-{
-    if (dmabuf->sync) {
-        dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
-                                                      dmabuf->sync);
-        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
-        dmabuf->sync = NULL;
-    }
-}
-
 #endif /* CONFIG_GBM */
 
 /* ---------------------------------------------------------------------- */
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3af5ac5bcf..683a87c6b3 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -98,8 +98,8 @@ void gd_egl_draw(VirtualConsole *vc)
         glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd > 0) {
+            egl_dmabuf_create_sync(dmabuf);
+            if (dmabuf->fence_fd > -1) {
                 qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
@@ -348,12 +348,6 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
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
 
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 52dcac161e..7791498646 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -77,16 +77,11 @@ void gd_gl_area_draw(VirtualConsole *vc)
         glBlitFramebuffer(0, y1, vc->gfx.w, y2,
                           0, 0, ww, wh,
                           GL_COLOR_BUFFER_BIT, GL_NEAREST);
-#ifdef CONFIG_GBM
-        if (dmabuf) {
-            egl_dmabuf_create_sync(dmabuf);
-        }
-#endif
         glFlush();
 #ifdef CONFIG_GBM
         if (dmabuf) {
-            egl_dmabuf_create_fence(dmabuf);
-            if (dmabuf->fence_fd > 0) {
+            egl_dmabuf_create_sync(dmabuf);
+            if (dmabuf->fence_fd > -1) {
                 qemu_set_fd_handler(dmabuf->fence_fd, gd_hw_gl_flushed, NULL, vc);
                 return;
             }
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..bbe05a0baf 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -597,10 +597,14 @@ void gd_hw_gl_flushed(void *vcon)
     VirtualConsole *vc = vcon;
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 
-    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
-    close(dmabuf->fence_fd);
-    dmabuf->fence_fd = -1;
-    graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    if (dmabuf && dmabuf->fence_fd > -1) {
+        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
+        close(dmabuf->fence_fd);
+        dmabuf->fence_fd = -1;
+        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
+        dmabuf->sync = NULL;
+        graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    }
 }
 
 /** DisplayState Callbacks (opengl version) **/
@@ -678,6 +682,25 @@ static const DisplayGLCtxOps egl_ctx_ops = {
 static void gd_change_runstate(void *opaque, bool running, RunState state)
 {
     GtkDisplayState *s = opaque;
+    int i;
+
+    if (state == RUN_STATE_SAVE_VM) {
+        for (i = 0; i < s->nb_vcs; i++) {
+            VirtualConsole *vc = &s->vc[i];
+
+            if (vc->gfx.guest_fb.dmabuf &&
+                vc->gfx.guest_fb.dmabuf->fence_fd >= 0) {
+                eglClientWaitSync(qemu_egl_display,
+                                  vc->gfx.guest_fb.dmabuf->sync,
+                                  EGL_SYNC_FLUSH_COMMANDS_BIT_KHR,
+                                  100000000);
+
+                /* force flushing current scanout blob rendering process
+                 * just in case the fence is still not signaled */
+                gd_hw_gl_flushed(vc);
+            }
+        }
+    }
 
     gd_update_caption(s);
 }
-- 
2.34.1


