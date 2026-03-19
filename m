Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173871088E7E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 05:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w35r1-0004qG-HF; Thu, 19 Mar 2026 01:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qn-0004ne-F9
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:19 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w35qk-0007uV-4M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 01:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773897794; x=1805433794;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JTTCEdUVw9+0aUi3ZfwFDBMu95wnyduf3HZFBnxLZFk=;
 b=Fnh68D4DkFIrtXQLSP7i0jXLVUhmcpbbyf/MeVK6UOnflqvwxMABoEjD
 6LVv1xvySnlf5+WB+zBLQTqSIplC4gKvm4VmCZ63PBfPiyjvUB2qGsL/Y
 TWBfjyAPOIJOoHlgj+p43AjX7uUj7FTJGlWGA042fXgAG0LQuV5HJ0/Wt
 GIjYEJSqRQeNw1zQysXyd9zNhW/FV4uE2yTykVCgCXBroxquoc6XNn66Q
 yFRM3SDAbRifrB2xfTivnoK1OW7bdWbHnoe1yXVQIs1/yoC3QNjFeHTb/
 4TYqDaw9jquEyScEm6g++9L7QQOlVl6Qm17ypbiVomWE9tCsRDZWn34ve g==;
X-CSE-ConnectionGUID: RRaZsP4kRxiy/VQU2v1rZQ==
X-CSE-MsgGUID: Zm+jDHXrSOeeKNc/Z3xRDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74660393"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="74660393"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:06 -0700
X-CSE-ConnectionGUID: qkD6k2z9Ssq75a/Yvr2vrg==
X-CSE-MsgGUID: N5WOTdevSMOQBjK84ZoV8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; d="scan'208";a="218355531"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 22:23:04 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v12 07/10] vfio/device: Add support for creating dmabuf from
 multiple ranges
Date: Wed, 18 Mar 2026 22:15:56 -0700
Message-ID: <20260319052023.2088685-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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
VFIODevice associated with a memory region, introduce a helper
to just use the vfio_device_list to lookup the VFIODevice.
And, introduce another helper lookup the VFIO region given an
address.

Lastly, introduce an enum to return the type of error encountered
while creating the dmabuf fd.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/hw/vfio/vfio-device.h |  23 +++++++
 hw/vfio/device.c              | 114 ++++++++++++++++++++++++++++++++++
 hw/vfio/dmabuf-stubs.c        |  17 +++++
 hw/vfio/meson.build           |   1 +
 4 files changed, 155 insertions(+)
 create mode 100644 hw/vfio/dmabuf-stubs.c

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 828a31c006..d46640ff53 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,6 +41,13 @@ enum {
     VFIO_DEVICE_TYPE_AP = 3,
 };
 
+enum {
+    /* The Guest passed addresses stored in IOV are invalid */
+    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
+    /* Guest or Host may be at fault for this type of error */
+    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
+};
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
@@ -308,6 +315,22 @@ bool vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_t
 
 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                 struct vfio_irq_info *info);
+
+/**
+ * Create a dmabuf fd by first translating the addresses in the
+ * iovec array into VFIO region offsets and then invoking the
+ * VFIO_DEVICE_FEATURE_DMA_BUF feature.
+ *
+ * @iov: array of iovec entries associated with a buffer
+ * @iov_cnt: number of entries in the iovec array
+ * @total_size: total size of the dmabuf
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Returns the created dmabuf fd or either VFIO_DMABUF_CREATE_ERR_UNSPEC
+ * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
+ */
+int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
+                                 size_t total_size, Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..542c378913 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,7 +21,9 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
+#include "hw/vfio/vfio-region.h"
 #include "hw/vfio/pci.h"
 #include "hw/core/iommu.h"
 #include "hw/core/hw-error.h"
@@ -644,3 +646,115 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
 };
+
+/*
+ * This helper looks up the VFIODevice corresponding to the given iov. It
+ * can be useful to determinine if a buffer (represented by the iov) belongs
+ * to a VFIO device or not. This is mainly invoked when external components
+ * such as virtio-gpu request creation of dmabuf fds for buffers that may
+ * belong to a VFIO device.
+ */
+static bool vfio_device_lookup(struct iovec *iov, VFIODevice **vbasedevp,
+                               RAMBlock **first_rbp, Error **errp)
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
+    *first_rbp = first_rb;
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
+/*
+ * This helper looks up the VFIORegion corresponding to the given address.
+ * It also verifies that the RAMBlock associated with the address is the
+ * same as the first_rb passed in. This is to ensure that all addresses
+ * in the iov belong to the same region.
+ */
+static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
+                               RAMBlock *first_rb, ram_addr_t *offsetp,
+                               Error **errp)
+{
+    VFIORegion *region;
+    RAMBlock *rb;
+
+    rb = qemu_ram_block_from_host(addr, false, offsetp);
+    if (!rb || rb != first_rb) {
+        error_setg(errp, "Dmabuf segments must belong to the same region\n");
+        return false;
+    }
+
+    region = vfio_get_region_from_mr(rb->mr);
+    if (region) {
+        *regionp = region;
+        return true;
+    }
+    error_setg(errp, "Could not find valid region for dmabuf segment\n");
+    return false;
+}
+
+int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
+                                 size_t total_size, Error **errp)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    RAMBlock *first_rb = NULL;
+    VFIODevice *vbasedev;
+    VFIORegion *region;
+    ram_addr_t offset;
+    size_t argsz;
+    int i, ret;
+
+    if (iov_size(iov, iov_cnt) != total_size) {
+        error_setg(errp, "Total size of iov does not match dmabuf size\n");
+        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+    }
+
+    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
+        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+    }
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
+        if (!vfio_region_lookup(iov[i].iov_base, &region,
+                                first_rb, &offset, errp)) {
+            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
+        }
+
+        dma_buf->region_index = region->nr;
+        dma_buf->dma_ranges[i].offset = offset;
+        dma_buf->dma_ranges[i].length = iov[i].iov_len;
+    }
+
+    dma_buf->nr_ranges = iov_cnt;
+    dma_buf->open_flags = O_RDONLY | O_CLOEXEC;
+
+    ret = vfio_device_get_feature(vbasedev, feature);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Could not create dmabuf fd via VFIO device");
+        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
+    }
+    return ret;
+}
diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
new file mode 100644
index 0000000000..374bd2a188
--- /dev/null
+++ b/hw/vfio/dmabuf-stubs.c
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2026 Intel and/or its affiliates.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/iov.h"
+#include "hw/vfio/vfio-device.h"
+
+int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
+                                 size_t total_size, Error **errp)
+{
+    error_setg(errp, "VFIO dmabuf support is not enabled");
+    return VFIO_DMABUF_CREATE_HOST_ERROR;
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 82f68698fb..ac899d30a8 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -34,3 +34,4 @@ system_ss.add(when: 'CONFIG_IOMMUFD', if_false: files('iommufd-stubs.c'))
 system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
 ))
+system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-stubs.c'))
-- 
2.53.0


