Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F136DCFC50C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 07:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMiHk-0007QQ-V7; Sat, 22 Nov 2025 02:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhTw-0000hN-Js
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:31 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vMhTS-0001Uz-9n
 for qemu-devel@nongnu.org; Sat, 22 Nov 2025 01:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763794318; x=1795330318;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NdIef43F78Ag8foHW0KVu5bgf8tD7h+BlEm9bwncXbc=;
 b=MCAYVIlGN/sdCmuFK0VGeuPgtauKej7WGNOONJqSvvNADRJ3/Q2/wPBd
 gm32bBEvwWyLVQAJU0ZKjeXcN3s1WECyDFda9z6dnpilo9Et51JqanMQj
 Ao2ZJ0hwTtxozWtEYizusVl2jfL8AY3Ur0mbGHygevHnFZuLNPZs3/jE1
 YTcW3vdEb3kJAczJTVM20AgLAmejSpuZV0wayLX27HDxs3RIiWeCbSM5u
 24QIUF5WnUdW2x0hPtZYsZEWgO2mPJoXrXGhqAEk0u/2Ri+88gWR6vFWe
 i5qCNSwZx9oXqDAL5nYoQRlFFN1kr0s89+HGP0yChHftz2x86v2kufBkE g==;
X-CSE-ConnectionGUID: Dku2uadiS2WMzQkcxxJxcw==
X-CSE-MsgGUID: qYHvB93rROe1+ag79rFviA==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65924079"
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="65924079"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
X-CSE-ConnectionGUID: Pc3LCWpAQ86St8E/BX1+Xg==
X-CSE-MsgGUID: NFv+/6uURSSG4KTaSdPtMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,217,1758610800"; d="scan'208";a="191064618"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 22:50:22 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 6/9] vfio/device: Add support for
 VFIO_DEVICE_FEATURE_DMA_BUF
Date: Fri, 21 Nov 2025 22:46:27 -0800
Message-ID: <20251122064936.2948632-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 45 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h | 14 +++++++++++
 2 files changed, 59 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 9ff73f9941..0679e55e8c 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/hw.h"
@@ -615,3 +616,47 @@ VFIODevice *vfio_device_lookup(MemoryRegion *mr)
     }
     return NULL;
 }
+
+int vfio_device_create_dmabuf_fd(VFIODevice *vbasedev,
+                                 struct iovec *iov, unsigned int iov_cnt)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    RAMBlock *rb, *first_rb;
+    ram_addr_t offset;
+    size_t argsz;
+    int i, index;
+
+    argsz = sizeof(*feature) + sizeof (*dma_buf) +
+            sizeof(struct vfio_region_dma_range) * iov_cnt;
+    feature = g_malloc0(argsz);
+    dma_buf = (struct vfio_device_feature_dma_buf *)feature->data;
+
+    first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
+    if (!first_rb) {
+        return -1;
+    }
+
+    for (i = 0; i < iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        if (rb != first_rb) {
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


