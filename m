Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E59CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgL7-0005Tg-E7; Wed, 03 Sep 2025 01:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgL0-0005Rm-GG
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:18 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1utgKy-00020Q-P0
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756878437; x=1788414437;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L8wsa5EiKVsZTTAjXcSAQwAl5L2jNrbI/NYMZNyKHtE=;
 b=F467Gd/JI0PyGyk7OsGoGxsAtrx9E+9hJlnoSSJDX1IZS8YK6Msd6Ozn
 SVHS6FRQY2TCUEZup+hGCM0Mi07Fj08WnDEJzNqBIbIIBsOMK9aGHVwpK
 TvUlYTWvhg8HRmKURV6ZNvBE2bZEvbR/0rznZAJpOVhB8Q5ICyU3h3P7S
 sPX2fAa3KRte6hc98PNBSU1DMLq3u2sj/7x82Jy+sSOAMtUj+GHjj0X30
 uAGX1D0V8EkAzIu21DI4MAZd5fxSZLq9HGZZ1DnxoGLzUzLXrvV2zwItu
 tK8smSdhP1Tn4DdRV9Ur1Hy7zSmepTBdGKapSdE7epJ/Sv52YyDoJcWYX A==;
X-CSE-ConnectionGUID: 7M9uiSF5QLOxpLqZFLBO2g==
X-CSE-MsgGUID: ZcrgeHNQQ4CehCl04/GTrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="58878187"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="58878187"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:09 -0700
X-CSE-ConnectionGUID: m6/wSRLwQ4KmS0uOH7X2dg==
X-CSE-MsgGUID: y9dLOmXjTb2ChRg4VaroMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="175634765"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 22:47:08 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [RFC 2/6] vfio: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
Date: Tue,  2 Sep 2025 22:42:15 -0700
Message-ID: <20250903054438.1179384-3-vivek.kasireddy@intel.com>
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

In order to implement VFIO_DEVICE_FEATURE_DMA_BUF, we first need
to identify the PCI region the buffer (represented by iovec) belongs
to and then translate its addresses to offsets within that region.

The qemu_ram_block_from_host() API gives us both the region and the
offset info we need to populate the dma ranges in order to invoke
this feature.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/region.c              | 49 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h |  3 +++
 2 files changed, 52 insertions(+)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index d04c57db63..b58188147c 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -28,6 +28,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "system/ramblock.h"
 #include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
@@ -401,3 +402,51 @@ void vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
     trace_vfio_region_mmaps_set_enabled(memory_region_name(region->mem),
                                         enabled);
 }
+
+int vfio_device_create_dmabuf(VFIODevice *vdev,
+                              struct iovec *iov, unsigned int iov_cnt)
+{
+    g_autofree struct vfio_device_feature *feature;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    VFIORegion *region;
+    ram_addr_t offset;
+    MemoryRegion *mr;
+    RAMBlock *rb;
+    size_t argsz;
+    int i;
+
+    argsz = sizeof(*feature) + sizeof (*dma_buf) +
+            sizeof(struct vfio_region_dma_range) * iov_cnt;
+    feature = g_malloc0(argsz);
+    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
+
+    for (i = 0; i < iov_cnt; i++) {
+        rcu_read_lock();
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        rcu_read_unlock();
+
+        if (!rb) {
+            return -1;
+        }
+
+        mr = rb->mr;
+        if (mr->ops != &vfio_region_ops) {
+            mr = mr->container;
+            if (mr->ops != &vfio_region_ops) {
+                return -1;
+            }
+        }
+
+        region = mr->opaque;
+        dma_buf->region_index = region->nr;
+        dma_buf->dma_ranges[i].offset = offset;
+        dma_buf->dma_ranges[i].length = iov[i].iov_len;
+    }
+
+    dma_buf->nr_ranges = iov_cnt;
+    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
+    feature->argsz = argsz;
+    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF;
+
+    return ioctl(vdev->fd, VFIO_DEVICE_FEATURE, feature);
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6e4d5ccdac..e127abd5f0 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -277,6 +277,9 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
 
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                 struct vfio_irq_info *info);
+
+int vfio_device_create_dmabuf(VFIODevice *vbasedev,
+                              struct iovec *iov, unsigned int iov_cnt);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


