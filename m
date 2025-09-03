Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77821CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgLB-0005Vh-EH; Wed, 03 Sep 2025 01:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgL2-0005ST-F9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:22 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgL0-000206-3w
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756878439; x=1788414439;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nHIkY6xxQVZuAgYEJkhfdggVCrRA/bv+587dx6C5wpY=;
 b=bZe8AXlatlIXGKYw0aqcHG1tO7zjoRm0Yckf/tSEhJCELEvzLfiVuxtn
 T+mSAiBk8MhG32hEk0bzV39UekVxVHollO7GG9MiezNumLr8D0SsPSm4l
 65WF1+DWJmrqTJRCbtJyiPOGDX+YW0WBsTrDcYubUNax/0soS0Qp7H3ax
 ZiNeFRiwbPfhAr4J+eS+55wB7xmR+e6fPckqWN12VXXvcxr2FDtYW7b2U
 1LxA9g0yn7Iz/ApwoSA9j7MXjnsdTmWoZt6ty+3o2arAPn0GeAUugmwTV
 tcG/xYEXNnbOUOFKz4Cb5kPkHNzhZA6ZMMptmJgfSCC6YvExKzXVoVoZi A==;
X-CSE-ConnectionGUID: Iyh0kuPzQ8SjL+lkDOnCDA==
X-CSE-MsgGUID: 2WXy0sgQTzey/2B50phL4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58878194"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="58878194"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:09 -0700
X-CSE-ConnectionGUID: i10GpvOySWysoFeNqw6gXw==
X-CSE-MsgGUID: fHiCdSqcTdWD5ho2YkXW+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="175634770"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:08 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [RFC 3/6] virtio-gpu-udmabuf: Create dmabuf for blobs associated with
 VFIO devices
Date: Tue,  2 Sep 2025 22:42:16 -0700
Message-ID: <20250903054438.1179384-4-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
vfio_create_dmabuf().

Note that we only call virtio_gpu_remap_udmabuf() if the blob is
backed by a memfd. This is because the VFIO dmabuf implementation
may not support mmap.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/display/virtio-gpu-udmabuf.c | 60 ++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index d804f321aa..0390a8f488 100644
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
@@ -27,6 +28,32 @@
 #include "standard-headers/linux/udmabuf.h"
 #include "standard-headers/drm/drm_fourcc.h"
 
+static void vfio_create_dmabuf(VFIODevice *vdev,
+                               struct virtio_gpu_simple_resource *res)
+{
+    res->dmabuf_fd = vfio_device_create_dmabuf(vdev, res->iov, res->iov_cnt);
+    if (res->dmabuf_fd < 0) {
+        warn_report("%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s", __func__,
+                    strerror(errno));
+    }
+}
+
+static VFIODevice *vfio_device_lookup(MemoryRegion *mr)
+{
+    VFIODevice *vdev;
+
+    if (QLIST_EMPTY(&vfio_device_list)) {
+        return NULL;
+    }
+
+    QLIST_FOREACH(vdev, &vfio_device_list, next) {
+        if (vdev->dev == mr->dev) {
+            return vdev;
+        }
+    }
+    return NULL;
+}
+
 static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res)
 {
     struct udmabuf_create_list *list;
@@ -130,6 +157,9 @@ bool virtio_gpu_have_udmabuf(void)
 
 void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 {
+    bool memfd_blob = false;
+    ram_addr_t offset;
+    RAMBlock *rb;
     void *pdata = NULL;
 
     res->dmabuf_fd = -1;
@@ -137,15 +167,31 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
         res->iov[0].iov_len < 4096) {
         pdata = res->iov[0].iov_base;
     } else {
-        virtio_gpu_create_udmabuf(res);
+        rb = qemu_ram_block_from_host(res->iov[0].iov_base, false, &offset);
+        if (rb && memory_region_is_ram_device(rb->mr)) {
+            VFIODevice *vdev = vfio_device_lookup(rb->mr);
+
+            if (!vdev) {
+                warn_report("Could not find device to create dmabuf");
+                return;
+            }
+            vfio_create_dmabuf(vdev, res);
+        } else {
+            virtio_gpu_create_udmabuf(res);
+            memfd_blob = true;
+        }
+
         if (res->dmabuf_fd < 0) {
             return;
         }
-        virtio_gpu_remap_udmabuf(res);
-        if (!res->remapped) {
-            return;
+
+        if (memfd_blob) {
+            virtio_gpu_remap_udmabuf(res);
+            if (!res->remapped) {
+                return;
+            }
+            pdata = res->remapped;
         }
-        pdata = res->remapped;
     }
 
     res->blob = pdata;
@@ -153,9 +199,7 @@ void virtio_gpu_init_udmabuf(struct virtio_gpu_simple_resource *res)
 
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


