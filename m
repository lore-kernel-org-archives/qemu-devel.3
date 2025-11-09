Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B6DCD1292
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 05:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHy8s-0005br-Jq; Sun, 09 Nov 2025 00:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8a-0005Wp-TL
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:53 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vHy8Z-0007aH-4n
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 00:38:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762666731; x=1794202731;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z6qFGL5WE+eZg5Z8dvi+fn6ZmgEH4hUNJqCkhe0bpoo=;
 b=cVuYxiSjAFu7ejntj7M0Gd/HlAhXIiA22bMM7AVG3xRON4cd9wR7nB4d
 kU4A/XDAwSlgbyvt24jVIiM/Z5M5wGAsnElLKL6iuQJJcHV5LVNZDvUBi
 hpq28QYUor0gbSdANPMrxjuBCLBPwq8TAMyoTMWb1gVovsa0KVh34plcj
 cFoiw5DR49K9XYGTtk27tQVGspFzqcI24JN/ym46YeSlfTfwKCVq/lI6y
 CwKfFyacaWPf0e8F2Hr/DQsf0UvqTHFB+AzvxxZFsAM7PiXxAcj1/5Sbh
 55AjljfKb6ZQuIKhjrT2xbaPtTpZ1bCZ/WLO7cB7E2kQ/Z+mEDQkfFkj5 g==;
X-CSE-ConnectionGUID: gcUvZYHzQUaGAdUWCJt1lw==
X-CSE-MsgGUID: 8gv3EkRtTfycmlZWbDpruw==
X-IronPort-AV: E=McAfee;i="6800,10657,11607"; a="63965791"
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="63965791"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:41 -0800
X-CSE-ConnectionGUID: YYReIa0VReybm7NJnLUTTQ==
X-CSE-MsgGUID: 9MqzAaCiSGqearlBRAb/xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,291,1754982000"; d="scan'208";a="188129063"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Nov 2025 21:38:41 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/10] vfio/device: Add support for
 VFIO_DEVICE_FEATURE_DMA_BUF
Date: Sat,  8 Nov 2025 21:33:50 -0800
Message-ID: <20251109053801.2267149-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
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
to identify the VFIO region and index the buffer (represented by
iovec) belongs to and then translate its addresses to offsets
within that region.

The qemu_ram_block_from_host() API gives us both the region and the
offset info we need to populate the dma ranges in order to invoke
this feature.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 40 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h | 14 ++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9ff73f9941..5417142482 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/hw.h"
@@ -615,3 +616,42 @@ VFIODevice *vfio_device_lookup(MemoryRegion *mr)
     }
     return NULL;
 }
+
+int vfio_device_create_dmabuf_fd(VFIODevice *vbasedev,
+                                 struct iovec *iov, unsigned int iov_cnt)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    size_t argsz;
+    int i, index;
+
+    argsz = sizeof(*feature) + sizeof (*dma_buf) +
+            sizeof(struct vfio_region_dma_range) * iov_cnt;
+    feature = g_malloc0(argsz);
+    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
+
+    for (i = 0; i < iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        if (!rb) {
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
+    feature->argsz = argsz;
+    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF;
+
+    return vbasedev->io_ops->device_feature(vbasedev, feature);
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 2f8087f133..7fc2912f15 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -309,6 +309,20 @@ int vfio_get_region_index_from_mr(MemoryRegion *mr);
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


