Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5B8D6CFD5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYo-0003DG-30; Fri, 23 Jan 2026 01:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYm-0003Bx-Lk
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:20 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYk-0000sJ-OT
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149339; x=1800685339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dOH/gF7JQzm/bUOolKZgzEjapwUscWN6HlBLSOMbf+Y=;
 b=NVA7BPq2aM6Mv0T+h6oNDdRrc88h1Y9heMbqA9acS1IWQve0CjiY6B5z
 mjFPyF3y82z3xv5eEWadDuqoX9XshpSQGE1C6JJqZiWhvUr0qO+u9A7bK
 9+wuTtuSXHe6fA64fLivH1CHLY2IFetFYWkiglqH7LSyj4JWoVQR0zO7Y
 ghSOjfYjbt/ufMSDAinUzsKLKQlH8mLW0r0UejKrz5t0RCrYhgs2WT+GU
 aO6OUJDUn1SDeW32wURGSLveZwmuiAE6EZKPJSOKCn686FFkLH3uWXpql
 4CDzPqgWlbMbOuFbx/Q7V+zh+x0DJ2EeymNRiBvLuVBHiHnZqmFjB55l/ Q==;
X-CSE-ConnectionGUID: 4QeUSSb0Q/apgaxFyZ9n/A==
X-CSE-MsgGUID: qSE17k1PTEmnmPKwhNjuBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254211"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254211"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:07 -0800
X-CSE-ConnectionGUID: w6msm5gySf+lcl0A4LBqHw==
X-CSE-MsgGUID: xVV5IrQ6Rqek6V1wbXhFkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287420"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:05 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs associated
 with VFIO devices
Date: Thu, 22 Jan 2026 22:17:47 -0800
Message-ID: <20260123062042.568703-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260123062042.568703-1-vivek.kasireddy@intel.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
storage in a VFIO device region. Since, there is no effective way
to determine where the backing storage is located, we first try to
create a dmabuf assuming it is in memfd. If that fails, we try to
create a dmabuf assuming it is in VFIO device region.

So, we first call virtio_gpu_create_udmabuf() to check if the blob's
backing storage is located in a memfd or not. If it is not, we call
vfio_create_dmabuf() which identifies the right VFIO device and
eventually invokes the vfio_device_create_dmabuf_fd() API to have
a dmabuf fd created.

Note that in virtio_gpu_remap_dmabuf(), we first try to test if
the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
use the VFIO device fd directly to create the CPU mapping.

While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
from virtio_gpu_create_udmabuf() and also replace warn_report()
with qemu_log_mask().

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/Kconfig             |   5 ++
 hw/display/virtio-gpu-dmabuf.c | 117 ++++++++++++++++++++++++++++++---
 2 files changed, 113 insertions(+), 9 deletions(-)

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
diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-dmabuf.c
index c34d4c85bc..2dfe70d7eb 100644
--- a/hw/display/virtio-gpu-dmabuf.c
+++ b/hw/display/virtio-gpu-dmabuf.c
@@ -18,6 +18,7 @@
 #include "ui/console.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
+#include "hw/vfio/vfio-device.h"
 #include "trace.h"
 #include "system/ramblock.h"
 #include "system/hostmem.h"
@@ -27,6 +28,38 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
+static void vfio_create_dmabuf(struct virtio_gpu_simple_resource *res)
+{
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+    VFIODevice *vbasedev;
+    RAMBlock *first_rb;
+    ram_addr_t offset;
+
+    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
+    if (!first_rb) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Could not find ramblock\n", __func__);
+        return;
+    }
+
+    vbasedev = vfio_device_lookup(first_rb->mr);
+    if (!vbasedev) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: No VFIO device found to create dmabuf from\n",
+                      __func__);
+        return;
+    }
+
+    res->dmabuf_fd = vfio_device_create_dmabuf_fd(vbasedev,
+                                                  res->iov, res->iov_cnt);
+    if (res->dmabuf_fd < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
+                      __func__, strerror(errno));
+    }
+#endif
+}
+
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     struct udmabuf_create_list *list;
@@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
                      sizeof(struct udmabuf_create_item) * res->iov_cnt);
 
     for (i = 0; i < res->iov_cnt; i++) {
-        rcu_read_lock();
         rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
-        rcu_read_unlock();
-
         if (!rb || rb->fd < 0) {
             g_free(list);
             return;
@@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 
     res->dmabuf_fd = ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
     if (res->dmabuf_fd < 0) {
-        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
-                    strerror(errno));
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: UDMABUF_CREATE_LIST: %s\n",
+                      __func__, strerror(errno));
     }
     g_free(list);
 }
 
+static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res)
+{
+    struct vfio_region_info *info = NULL;
+    VFIODevice *vbasedev = NULL;
+    ram_addr_t offset, len = 0;
+    RAMBlock *first_rb, *rb;
+    void *map, *submap;
+    int i, ret = -1;
+
+    first_rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
+    if (!first_rb) {
+        return MAP_FAILED;
+    }
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+    vbasedev = vfio_device_lookup(first_rb->mr);
+#endif
+    if (!vbasedev) {
+        return MAP_FAILED;
+    }
+
+    /*
+     * We first reserve a contiguous chunk of address space for the entire
+     * dmabuf, then replace it with smaller mappings that correspond to the
+     * individual segments of the dmabuf.
+     */
+    map = mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vbasedev->fd, 0);
+    if (map == MAP_FAILED) {
+        return map;
+    }
+
+    for (i = 0; i < res->iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(res->iov[i].iov_base, false, &offset);
+        if (rb != first_rb) {
+            goto err;
+        }
+#if defined(VIRTIO_GPU_VFIO_BLOB)
+        ret = vfio_get_region_index_from_mr(rb->mr);
+        if (ret < 0) {
+            goto err;
+        }
+
+        ret = vfio_device_get_region_info(vbasedev, ret, &info);
+#endif
+        if (ret < 0 || !info) {
+            goto err;
+        }
+
+        submap = mmap(map + len, res->iov[i].iov_len, PROT_READ,
+                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
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
 static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource *res)
 {
     res->remapped = mmap(NULL, res->blob_size, PROT_READ,
                          MAP_SHARED, res->dmabuf_fd, 0);
     if (res->remapped == MAP_FAILED) {
+        res->remapped = vfio_dmabuf_mmap(res);
+        if (res->remapped != MAP_FAILED) {
+            return;
+        }
         warn_report("%s: dmabuf mmap failed: %s", __func__,
                     strerror(errno));
         res->remapped = NULL;
@@ -139,8 +236,12 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
     } else {
         virtio_gpu_create_udmabuf(res);
         if (res->dmabuf_fd < 0) {
-            return;
+            vfio_create_dmabuf(res);
+            if (res->dmabuf_fd < 0) {
+                return;
+            }
         }
+
         virtio_gpu_remap_dmabuf(res);
         if (!res->remapped) {
             return;
@@ -153,9 +254,7 @@ void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
 
 void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
 {
-    if (res->remapped) {
-        virtio_gpu_destroy_dmabuf(res);
-    }
+    virtio_gpu_destroy_dmabuf(res);
 }
 
 static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf *dmabuf)
-- 
2.50.1


