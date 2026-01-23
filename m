Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B89D6CFD5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 06:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjAYm-0003Bl-FG; Fri, 23 Jan 2026 01:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYl-0003Ak-4j
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:19 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vjAYj-0000rq-AQ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 01:22:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769149337; x=1800685337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9z4wt3h8g6G2FMrJhvHLEY2taO5XQrbNTl+7oirh0+8=;
 b=LmiSUKCVrtBFmThNzuMROr15WvMo54YmE59lruugEvEjJeG6KSsUM2GS
 4b1s5vT21rPCMs64THo/0GTOGsewe/WJNxnkNGID6GjlkkZ9QjXvd663g
 7I9CxsWKQTtUtqK/jJESjee9u6H5n7g1M6PgPuomyfdvdzVhqP7PeiYR4
 ZiSKNTaWxLPKFdYPZ6CCYXDuSm/DXI5eZ9OJlvDd2xUL2V0GirZspCf3h
 ZH6XkRRHbykpwNOPhB7Cv6tHMm8il8EIZXEQ+Yo8SwDS+EQ3w8gSmxcXI
 Lrn4VkrELYfvcl7Gnb51ApdsbUcOCPMFbEmek/Avd65bN6btZhjBAibbV w==;
X-CSE-ConnectionGUID: SQbDNshpRTu+io+vW17cQQ==
X-CSE-MsgGUID: nZM3YcQeRtWHqtRz6qhYZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="74254206"
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="74254206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:06 -0800
X-CSE-ConnectionGUID: V2H2UuOOQgSZ0Wt5SURKFw==
X-CSE-MsgGUID: WhwcxvSqQ4i5cJQp3trm8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,247,1763452800"; d="scan'208";a="207287414"
Received: from unknown (HELO vkasired-desk2.fm.intel.com) ([10.105.128.132])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 22:22:05 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 6/8] vfio/device: Add support for creating dmabuf from
 multiple ranges
Date: Thu, 22 Jan 2026 22:17:45 -0800
Message-ID: <20260123062042.568703-7-vivek.kasireddy@intel.com>
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

In order to create a dmabuf associated with a buffer that spans
multiple ranges, we first need to identify the VFIO region and
index the buffer (represented by iovec) belongs to and then
translate its addresses to offsets within that region.

The qemu_ram_block_from_host() API gives us both the region and
the offset info we need to populate the dma ranges so that we can
invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the dmabuf.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 44 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h | 14 +++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index afeff0f034..90d7758d0d 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/core/iommu.h"
@@ -656,3 +657,46 @@ VFIODevice *vfio_device_lookup(MemoryRegion *mr)
     }
     return NULL;
 }
+
+int vfio_device_create_dmabuf_fd(VFIODevice *vbasedev,
+                                 struct iovec *iov, unsigned int iov_cnt)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    RAMBlock *rb, *first_rb = NULL;
+    ram_addr_t offset;
+    size_t argsz;
+    int i, index;
+
+    argsz = sizeof(*feature) + sizeof (*dma_buf) +
+            sizeof(struct vfio_region_dma_range) * iov_cnt;
+    feature = g_malloc0(argsz);
+    *feature = (struct vfio_device_feature) {
+        .argsz = argsz,
+        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
+    };
+    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
+
+    for (i = 0; i < iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        if (i == 0) {
+            first_rb = rb;
+        }
+        if (!rb || rb != first_rb) {
+            return -1;
+        }
+
+        index = vfio_get_region_index_from_mr(rb->mr);
+        if (index < 0) {
+            return -1;
+        }
+
+        dma_buf->region_index = index;
+        dma_buf->dma_ranges[i].offset = offset;
+        dma_buf->dma_ranges[i].length = iov[i].iov_len;
+    }
+
+    dma_buf->nr_ranges = iov_cnt;
+    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
+    return vfio_device_get_feature(vbasedev, feature);
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index ccf2fd887c..2f7e50f7ce 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -327,6 +327,20 @@ int vfio_get_region_index_from_mr(MemoryRegion *mr);
  * Returns the VFIO device if found or NULL.
  */
 VFIODevice *vfio_device_lookup(MemoryRegion *mr);
+
+/**
+ * Create and return a dmabuf fd by first translating the addresses in the
+ * iovec array into VFIO region offsets and then invoking the
+ * VFIO_DEVICE_FEATURE_DMA_BUF feature.
+ *
+ * @vbasedev: #VFIODevice to use
+ * @iov: array of iovec entries associated with a buffer
+ * @iov_cnt: number of entries in the iovec array
+ *
+ * Returns the newly created dmabuf fd or -1 on error.
+ */
+int vfio_device_create_dmabuf_fd(VFIODevice *vbasedev,
+                                 struct iovec *iov, unsigned int iov_cnt);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


