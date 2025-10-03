Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673F4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRl-0005E9-Lw; Fri, 03 Oct 2025 19:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRa-0005Co-FP
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:11 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRV-0001SP-Jw
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535046; x=1791071046;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4evIso+6d2BOWelVVD3O4OPx0/uTU1kCk84WrOUwPzE=;
 b=OQNJijfkwa8Gh9lAob5AZnnQRtAe9L2i6YHk2Pq2iYSU7jD/Ah5gVbyf
 5D6qVU5E0NsVkhWvb4O65R8yMQzMorOKZ+QReMcNjA76r2t2TwDEIGe2c
 anpupZTcvglqtaVJe4AEASd3KxR/4qkHZEe4iNVxP7Ff2AZECwLen4apE
 PqXts+s1Jnj/LUJ1bkQ7h44P03ohfoWm+Qec2JeCqmYzl/RenMH5ZsquV
 NVDJrgJm1xUXVfvCqi9kJ5NCMzoXtDnmUM1uEY03xwnUgMYph3LnWFV0f
 KdzA7EOavDneeqL1L1GoLNeCGGCkliexOJLo6tWMJwcUnJx+49OC0sXCs A==;
X-CSE-ConnectionGUID: h/HPeZ/IToGrUhA030j6Tw==
X-CSE-MsgGUID: Lu1rOcfLSG6MEGXQl2CrwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705049"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705049"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:39 -0700
X-CSE-ConnectionGUID: YBL+4x0lSIaaygVNDL+W0A==
X-CSE-MsgGUID: tu4EOXeqTzC5OwuvqJNKUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428161"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:39 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v1 7/7] virtio-gpu-udmabuf: Create dmabuf for blobs associated
 with VFIO devices
Date: Fri,  3 Oct 2025 16:36:00 -0700
Message-ID: <20251003234138.85820-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003234138.85820-1-vivek.kasireddy@intel.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

In addition to memfd, a blob resource can also have its backing
storage in a VFIO device region. Therefore, we first need to figure
out if the blob is backed by a VFIO device region or a memfd before
we can call the right API to get a dmabuf fd created.

So, once we have the ramblock and the associated mr, we rely on
memory_region_is_ram_device() to tell us where the backing storage
is located. If the blob resource is VFIO backed, we try to find the
right VFIO device that contains the blob and then invoke the API
vfio_device_create_dmabuf().

Note that in virtio_gpu_remap_udmabuf(), we first try to test if
the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
use the VFIO device fd directly to create the CPU mapping.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/Kconfig              |   5 ++
 hw/display/virtio-gpu-udmabuf.c | 143 ++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index 1e95ab28ef..0d090f25f5 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -106,6 +106,11 @@ config VIRTIO_VGA
     depends on VIRTIO_PCI
     select VGA
 
+config VIRTIO_GPU_VFIO_BLOB
+    bool
+    default y
+    depends on VFIO
+
 config VHOST_USER_GPU
     bool
     default y
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d804f321aa..bd06b4f300 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -18,6 +18,7 @@
 #include "ui/console.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
+#include "hw/vfio/vfio-device.h"
 #include "trace.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
@@ -27,6 +28,33 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
+static void vfio_create_dmabuf(VFIODevice *vdev,
+                               struct virtio_gpu_simple_resource *res)
+{
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+    res->dmabuf_fd = vfio_device_create_dmabuf(vdev, res->iov, res->iov_cnt);
+    if (res->dmabuf_fd < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
+                      __func__, strerror(errno));
+    }
+#endif
+}
+
+static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
+{
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+    VFIODevice *vdev;
+
+    QLIST_FOREACH(vdev, &vfio_device_list, next) {
+        if (vdev->dev == mr->dev) {
+            return vdev;
+        }
+    }
+#endif
+    return NULL;
+}
+
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     struct udmabuf_create_list *list;
@@ -68,11 +96,73 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
     g_free(list);
 }
 
-static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res)
+static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
+                              VFIODevice *vdev)
+{
+    struct vfio_region_info *info;
+    ram_addr_t offset, len = 0;
+    void *map, *submap;
+    int i, ret = -1;
+    RAMBlock *rb;
+
+    /*
+     * We first reserve a contiguous chunk of address space for the entire
+     * dmabuf, then replace it with smaller mappings that correspond to the
+     * individual segments of the dmabuf.
+     */
+    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev->fd, 0);
+    if (map == MAP_FAILED) {
+        return map;
+    }
+
+    for (i = 0; i < res->iov_cnt; i++) {
+        rcu_read_lock();
+        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
+        rcu_read_unlock();
+
+        if (!rb) {
+            goto err;
+        }
+
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+        ret = vfio_get_region_index_from_mr(rb->mr);
+        if (ret < 0) {
+            goto err;
+        }
+
+        ret = vfio_device_get_region_info(vdev, ret, &info);
+#endif
+        if (ret < 0) {
+            goto err;
+        }
+
+        submap = mmap(map + len, res->iov[i].iov_len, PROT_READ,
+                      MAP_SHARED | MAP_FIXED, vdev->fd,
+                      info->offset + offset);
+        if (submap == MAP_FAILED) {
+            goto err;
+        }
+
+        len += res->iov[i].iov_len;
+    }
+    return map;
+err:
+    munmap(map, res->blob_size);
+    return MAP_FAILED;
+}
+
+static void virtio_gpu_remap_udmabuf(struct virtio_gpu_simple_resource *res,
+                                     VFIODevice *vdev)
 {
     res->remapped = mmap(NULL, res->blob_size, PROT_READ,
                          MAP_SHARED, res->dmabuf_fd, 0);
     if (res->remapped == MAP_FAILED) {
+        if (vdev) {
+            res->remapped = vfio_dmabuf_mmap(res, vdev);
+            if (res->remapped != MAP_FAILED) {
+                return;
+            }
+        }
         warn_report("%s: dmabuf mmap failed: %s", __func__,
                     strerror(errno));
         res->remapped = NULL;
@@ -130,18 +220,59 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 {
+    VFIODevice *vdev = NULL;
     void *pdata = NULL;
+    ram_addr_t offset;
+    RAMBlock *rb;
 
     res->dmabuf_fd = -1;
     if (res->iov_cnt == 1 &&
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
-        virtio_gpu_create_udmabuf(res);
-        if (res->dmabuf_fd < 0) {
+        rcu_read_lock();
+        rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
+        rcu_read_unlock();
+
+        if (!rb) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Could not find ram block for host address\n",
+                          __func__);
             return;
         }
-        virtio_gpu_remap_udmabuf(res);
+
+        if (memory_region_is_ram_device(rb->mr)) {
+            vdev = vfio_device_lookup(rb->mr);
+            if (!vdev) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: Could not find device to create dmabuf\n",
+                              __func__);
+                return;
+            }
+
+            vfio_create_dmabuf(vdev, res);
+            if (res->dmabuf_fd < 0) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: Could not create dmabuf from vfio device\n",
+                              __func__);
+                return;
+            }
+        } else if (memory_region_is_ram(rb->mr) && virtio_gpu_have_udmabuf()) {
+            virtio_gpu_create_udmabuf(res);
+            if (res->dmabuf_fd < 0) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: Could not create dmabuf from memfd\n",
+                              __func__);
+                return;
+            }
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: memory region cannot be used to create dmabuf\n",
+                          __func__);
+            return;
+        }
+
+        virtio_gpu_remap_udmabuf(res, vdev);
         if (!res->remapped) {
             return;
         }
@@ -153,9 +284,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 
 void virtio_gpu_fini_udmabuf(struct virtio_gpu_simple_resource *res)
 {
-    if (res->remapped) {
-        virtio_gpu_destroy_udmabuf(res);
-    }
+    virtio_gpu_destroy_udmabuf(res);
 }
 
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
-- 
2.50.1


