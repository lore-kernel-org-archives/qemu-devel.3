Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D1C104891E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6Bh-000671-IP; Fri, 27 Feb 2026 17:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vw6Bf-000665-FD
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:19:55 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vw6Bd-0007ml-4m
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772230793; x=1803766793;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w3uTWrXd7VpeYAZj7l0t+FPlTl71pJf89qInb+jdvno=;
 b=PMD4w9whVnKdfhXufCfSIOO7+j9+UWaj7aw3QKiqTQOdpQ9hxQ4EQD25
 i+3M+YPKercSQjL4yWSTZefV8JdpdFwIVGgR9pS7bCLbGBGYatb5X+tHH
 ZCFCUvhZUYNEPIKdHwuaKZ+ytWGmRw8We64de7C3DtC8R/brw/Htv8Rzh
 MSliEoL08uZqWhzih8IjdLEkhSZQykpOQNDowXrWzaIT72jYvNrA7LBnd
 y3LtgM0ZQk22Sw0eNJsXxslke8PHehv3TkJ3i7IqdGXItxunBQbd2v28P
 e7h+m8iP4mW24sgNFAm42toRC1FZz47WvVPslDQHX4ub91GiaQKc9In6J w==;
X-CSE-ConnectionGUID: NtD6NHYJRHiCXxQh2fYHSw==
X-CSE-MsgGUID: u70RVhsjRKGezR+cQczWcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73509359"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; d="scan'208";a="73509359"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 14:19:40 -0800
X-CSE-ConnectionGUID: UJmKq1egSZuBswMWk647Ag==
X-CSE-MsgGUID: 1PhaXEl1SSK7ZQipksUNIA==
X-ExtLoop1: 1
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2026 14:19:40 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v8 07/10] vfio/device: Add support for creating dmabuf from
 multiple ranges
Date: Fri, 27 Feb 2026 14:13:53 -0800
Message-ID: <20260227221632.827046-8-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227221632.827046-1-vivek.kasireddy@intel.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
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

Lastly, introduce an enum to return the type of error encountered
while creating the dmabuf fd.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 hw/vfio/device.c              | 84 +++++++++++++++++++++++++++++++++++
 hw/vfio/dmabuf-stubs.c        | 17 +++++++
 hw/vfio/meson.build           |  1 +
 include/hw/vfio/vfio-device.h | 22 +++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 hw/vfio/dmabuf-stubs.c

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..a25ecc3697 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/core/iommu.h"
@@ -644,3 +645,86 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
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
+int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
+                                 Error **errp)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    RAMBlock *rb, *first_rb;
+    VFIODevice *vbasedev;
+    ram_addr_t offset;
+    int i, index, ret;
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
+        return VFIO_DMABUF_CREATE_GUEST_ERROR;
+    }
+
+    for (i = 0; i < iov_cnt; i++) {
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        if (i == 0) {
+            first_rb = rb;
+        }
+        if (!rb || rb != first_rb) {
+            error_setg(errp, "Cannot create dmabuf with different regions\n");
+            return VFIO_DMABUF_CREATE_GUEST_ERROR;
+        }
+
+        index = vfio_get_region_index_from_mr(rb->mr);
+        if (index < 0) {
+            error_setg(errp, "Cannot find region index for dmabuf segment\n");
+            return VFIO_DMABUF_CREATE_GUEST_ERROR;
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
+    ret = vfio_device_get_feature(vbasedev, feature);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Could not create dmabuf fd via VFIO device");
+        if (ret == -ENODEV || ret == -EINVAL) {
+            return VFIO_DMABUF_CREATE_GUEST_ERROR;
+        }
+        return VFIO_DMABUF_CREATE_HOST_ERROR;
+    }
+    return ret;
+}
diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
new file mode 100644
index 0000000000..e71e2b68dd
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
+                                 Error **errp)
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
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 596c7f5a10..9dcf3ea57d 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -41,6 +41,13 @@ enum {
     VFIO_DEVICE_TYPE_AP = 3,
 };
 
+enum {
+    /* Guest is responsible for this error */
+    VFIO_DMABUF_CREATE_GUEST_ERROR = -1,
+    /* Host is at fault for this error */
+    VFIO_DMABUF_CREATE_HOST_ERROR = -2,
+};
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODeviceIOOps VFIODeviceIOOps;
 typedef struct VFIOMigration VFIOMigration;
@@ -318,6 +325,21 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
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
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Returns the created dmabuf fd or either VFIO_DMABUF_CREATE_GUEST_ERROR
+ * or VFIO_DMABUF_CREATE_HOST_ERROR on error.
+ */
+int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int iov_cnt,
+                                 Error **errp);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.53.0


