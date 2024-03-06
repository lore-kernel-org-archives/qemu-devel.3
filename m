Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A334CC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 22:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhziw-0006Fu-90; Wed, 06 Mar 2024 17:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rhziu-0006Fc-Ev
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 17:26:52 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rhzis-0001q6-4y
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 17:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709764011; x=1741300011;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RrARhO2dmUsgC4o+SC6z0Izhmm3hFZPqY74ISjvlfXM=;
 b=e9xnZd+51F8ZsZTT1wCKaS9K5IwoxW0P5wycWfQFRfezuVJt+hWt0Fsr
 ldHpkMGI6t7pihlFzA0grk6t5hWWS79UdCYC/6eRsHxbtQMt9MmWFVfT0
 Jr9GaA4/U/Q2FIJPnySezF/f7V8Lf9X1AOZvVira9mQSr65s+kLx+dW+G
 pDVkmht0pXouRhxjNwbOXuH8fOuIDp2Z8oO1nyUGXGZwsL/ArYYaL0HB5
 d0q2/vrzZpSXe063fFMs6uVoZwyGvjKuYh83gUcJ4y0IW3GsILleSgvgf
 j6zsv+LkjHWJE2MDhpUh75gQl1OeQAAj41Rucsr+zK9N/xLLwI5Gxjkd1 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="8223863"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="8223863"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 14:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9785416"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa009.fm.intel.com with ESMTP; 06 Mar 2024 14:26:44 -0800
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
Date: Wed,  6 Mar 2024 14:25:23 -0800
Message-Id: <20240306222523.3236832-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If the guest state is paused before it gets a response for the current
scanout frame submission (resource-flush), it won't flush new frames
after being restored as it still waits for the old response, which is
accepted as a scanout render done signal. So it's needed to unblock
the current scanout render pipeline before the run state is changed
to make sure the guest receives the response for the current frame
submission.

v2: Giving some time for the fence to be signaled before flushing
    the pipeline

v3: Prevent redundant call of gd_hw_gl_flushed by checking dmabuf
    and fence_fd >= 0 in it (e.g. during and after eglClientWaitSync
    in gd_change_runstate).

    Destroy sync object later in gd_hw_fl_flushed

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/egl-helpers.c |  2 --
 ui/gtk.c         | 31 +++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 3d19dbe382..a77f9e57d9 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -385,8 +385,6 @@ void egl_dmabuf_create_fence(QemuDmaBuf *dmabuf)
     if (dmabuf->sync) {
         dmabuf->fence_fd = eglDupNativeFenceFDANDROID(qemu_egl_display,
                                                       dmabuf->sync);
-        eglDestroySyncKHR(qemu_egl_display, dmabuf->sync);
-        dmabuf->sync = NULL;
     }
 }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 810d7fc796..eaca890cba 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -597,10 +597,14 @@ void gd_hw_gl_flushed(void *vcon)
     VirtualConsole *vc = vcon;
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 
-    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
-    close(dmabuf->fence_fd);
-    dmabuf->fence_fd = -1;
-    graphic_hw_gl_block(vc->gfx.dcl.con, false);
+    if (dmabuf && dmabuf->fence_fd >= 0) {
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


