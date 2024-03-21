Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB7C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 23:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnS59-0007Ng-Eq; Thu, 21 Mar 2024 19:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS58-0007NU-48
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:22 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnS56-0007iR-A3
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 19:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711064661; x=1742600661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HWowGrDZ5wAvedguTHijDQ0FxMS517gzwRYLO/rG7Tk=;
 b=fKzv+lX5JRiIgmdO0Qc/iEQUY34rDk9JFhYYDLCxyySUCHobl7K2JRIC
 2K2kh0PdBUDAq6V6lnmy36yuX47kgrbTvWFKVMeGDc3aiVb73o+68/nvk
 n9O4qipgManTRaP6/tIeIrEK+vQQtk5QUkwBMp1F9cYX+E4YOK0DgNyJe
 R4w1aKmHI6hQ90GElYWIgKSLUQ3LOuuUVVWy4SGZs61oLJ17l/ixYxIeL
 KhGS/FTXDp07NGcoQNH3GEhN46XG3wmLVSsIVV6vnWdXJLf11UVNDB7Ym
 rDR9E8FRJyqIUJTVGaiul0vVsCZtgOrD1cgnWfZJYvXnidSBkb+pb39Cp w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6217225"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="6217225"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2024 16:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; d="scan'208";a="14743274"
Received: from dongwonk-z390-aorus-ultra.fm.intel.com ([10.105.129.124])
 by fmviesa006.fm.intel.com with ESMTP; 21 Mar 2024 16:44:13 -0700
From: dongwon.kim@intel.com
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	marcandre.lureau@redhat.com
Subject: [PATCH v4 1/3] ui/console: Introduce dpy_gl_dmabuf_get_height/width()
 helpers
Date: Thu, 21 Mar 2024 16:42:34 -0700
Message-Id: <20240321234236.3476163-2-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321234236.3476163-1-dongwon.kim@intel.com>
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

dpy_gl_dmabuf_get_height() and dpy_gl_dmabuf_get_width() are helpers for
retrieving width and height fields from QemuDmaBuf struct.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/console.h            |  2 ++
 hw/display/virtio-gpu-udmabuf.c |  7 ++++---
 hw/vfio/display.c               |  9 ++++++---
 ui/console.c                    | 18 ++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 0bc7a00ac0..6064487fc4 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -358,6 +358,8 @@ void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
                           bool have_hot, uint32_t hot_x, uint32_t hot_y);
 void dpy_gl_cursor_position(QemuConsole *con,
                             uint32_t pos_x, uint32_t pos_y);
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf);
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf);
 void dpy_gl_release_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_update(QemuConsole *con,
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d51184d658..a4ebf828ec 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -206,6 +206,7 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 {
     struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
     VGPUDMABuf *new_primary, *old_primary = NULL;
+    uint32_t width, height;
 
     new_primary = virtio_gpu_create_dmabuf(g, scanout_id, res, fb, r);
     if (!new_primary) {
@@ -216,10 +217,10 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
         old_primary = g->dmabuf.primary[scanout_id];
     }
 
+    width = dpy_gl_dmabuf_get_width(&new_primary->buf);
+    height = dpy_gl_dmabuf_get_height(&new_primary->buf);
     g->dmabuf.primary[scanout_id] = new_primary;
-    qemu_console_resize(scanout->con,
-                        new_primary->buf.width,
-                        new_primary->buf.height);
+    qemu_console_resize(scanout->con, width, height);
     dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
 
     if (old_primary) {
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 1aa440c663..c962e5f88f 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -286,6 +286,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIOPCIDevice *vdev = opaque;
     VFIODisplay *dpy = vdev->dpy;
     VFIODMABuf *primary, *cursor;
+    uint32_t width, height;
     bool free_bufs = false, new_cursor = false;
 
     primary = vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
@@ -296,10 +297,12 @@ static void vfio_display_dmabuf_update(void *opaque)
         return;
     }
 
+    width = dpy_gl_dmabuf_get_width(&primary->buf);
+    height = dpy_gl_dmabuf_get_height(&primary->buf);
+
     if (dpy->dmabuf.primary != primary) {
         dpy->dmabuf.primary = primary;
-        qemu_console_resize(dpy->con,
-                            primary->buf.width, primary->buf.height);
+        qemu_console_resize(dpy->con, width, height);
         dpy_gl_scanout_dmabuf(dpy->con, &primary->buf);
         free_bufs = true;
     }
@@ -328,7 +331,7 @@ static void vfio_display_dmabuf_update(void *opaque)
         cursor->pos_updates = 0;
     }
 
-    dpy_gl_update(dpy->con, 0, 0, primary->buf.width, primary->buf.height);
+    dpy_gl_update(dpy->con, 0, 0, width, height);
 
     if (free_bufs) {
         vfio_display_free_dmabufs(vdev);
diff --git a/ui/console.c b/ui/console.c
index 43226c5c14..1d0513a733 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1132,6 +1132,24 @@ void dpy_gl_cursor_position(QemuConsole *con,
     }
 }
 
+uint32_t dpy_gl_dmabuf_get_width(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->width;
+    }
+
+    return 0;
+}
+
+uint32_t dpy_gl_dmabuf_get_height(QemuDmaBuf *dmabuf)
+{
+    if (dmabuf) {
+        return dmabuf->height;
+    }
+
+    return 0;
+}
+
 void dpy_gl_release_dmabuf(QemuConsole *con,
                           QemuDmaBuf *dmabuf)
 {
-- 
2.34.1


