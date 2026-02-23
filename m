Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2B8E98DFE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 08:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQvn-0002xE-Hd; Mon, 23 Feb 2026 03:04:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvl-0002wI-4Y
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:37 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vuQvi-0004L5-85
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 03:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771833874; x=1803369874;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i+yz3W/13lozOSckUkgC09yg5zul8aQqUpaDK64jrDo=;
 b=cdVFGYqN80JZT0ktvHGgeOk3vvpAmOtR5u+bFTqgt1Th7mwnhVzxc4Mi
 tXazM78a6nzLjlHKkmuM9KDUbB79vjdKGDDM2AJVw4BtOu98y7fHvHnc/
 mZfrShMEs/uHvS+MfnFNMir6O9+Zbx0mmuVYDc9mAyMaUzdAidjn1Hvv4
 OmzzcZ90Q7ErJK1ZsN8Vdjp4Fv0iw4AO/9xKx7uqHTnQUvtNO4N6T454o
 8nP+/Ab+cJlAvtkcOJSo5koMV4VQ685HTayTQRxoXAL1IFVXKE0L/cHQm
 T9Ki+JYvty1jl94G0dPZg+v9egLohjfIW22sZexgqLNDiDbj6x306agsX g==;
X-CSE-ConnectionGUID: zXOKl5qKQ22GEViwos0lCg==
X-CSE-MsgGUID: g4qasrZuRv+3uhoWXn1hng==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72027140"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="72027140"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
X-CSE-ConnectionGUID: eK8cS/jVTHm9DaQ2VK6asg==
X-CSE-MsgGUID: dSw6/VWqRKmG6z9e1pzwbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; d="scan'208";a="246079178"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 00:04:23 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 08/10] vfio/device: Add support for creating dmabuf from
 multiple ranges
Date: Mon, 23 Feb 2026 00:00:12 -0800
Message-ID: <20260223080200.468558-9-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223080200.468558-1-vivek.kasireddy@intel.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_NONE=0.001,
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

Also, instead of iterating over all QOM devices to find the
VFIODevice associated with a memory region, introduce a helper to
just use the vfio_device_list to lookup the VFIODevice.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 81 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h | 14 ++++++
 2 files changed, 95 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..a7603600f3 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/core/iommu.h"
@@ -644,3 +645,83 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
 };
+
+static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
+                               Error **errp)
+{
+    VFIODevice *vbasedev;
+    RAMBlock *first_rb;
+    ram_addr_t offset;
+
+    first_rb = qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
+    if (!first_rb) {
+        error_setg(errp, "Could not find first ramblock\n");
+        return false;
+    }
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev == first_rb->mr->dev) {
+            *vbasedevp = vbasedev;
+            return true;
+        }
+    }
+    error_setg(errp, "No VFIO device found to create dmabuf from\n");
+    return false;
+}
+
+bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                               int *fd, Error **errp)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    RAMBlock *rb, *first_rb;
+    VFIODevice *vbasedev;
+    ram_addr_t offset;
+    int i, index;
+    size_t argsz;
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
+    if (!vfio_device_lookup(iov, &vbasedev, errp)) {
+        return false;
+    }
+
+    for (i = 0; i < iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        if (i == 0) {
+            first_rb = rb;
+        }
+        if (!rb || rb != first_rb) {
+            error_setg(errp, "Cannot create dmabuf with different regions\n");
+            return false;
+        }
+
+        index = vfio_get_region_index_from_mr(rb->mr);
+        if (index < 0) {
+            error_setg(errp, "Cannot find region index for dmabuf segment\n");
+            return false;
+        }
+
+        dma_buf->region_index = index;
+        dma_buf->dma_ranges[i].offset = offset;
+        dma_buf->dma_ranges[i].length = iov[i].iov_len;
+    }
+
+    dma_buf->nr_ranges = iov_cnt;
+    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
+
+    *fd = vfio_device_get_feature(vbasedev, feature);
+    if (*fd < 0) {
+        error_setg_errno(errp, -(*fd),
+                         "Could not create dmabuf fd via VFIO device");
+        return false;
+    }
+    return true;
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 596c7f5a10..003bac10b5 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -318,6 +318,20 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
  * Returns the region index or -1 on error.
  */
 int vfio_get_region_index_from_mr(MemoryRegion *mr);
+
+/**
+ * Create a dmabuf fd by first translating the addresses in the
+ * iovec array into VFIO region offsets and then invoking the
+ * VFIO_DEVICE_FEATURE_DMA_BUF feature.
+ *
+ * @iov: array of iovec entries associated with a buffer
+ * @iov_cnt: number of entries in the iovec array
+ * @fd: pointer to store the resulting dmabuf fd
+ *
+ * Returns true on success and false in case of an error.
+ */
+bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int iov_cnt,
+                               int *fd, Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.53.0


