Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B7DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 23:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4pRg-0005DS-Jv; Fri, 03 Oct 2025 19:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRa-0005Cn-FH
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:11 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v4pRS-0001RK-Cu
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 19:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759535042; x=1791071042;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GeDdKKWqMTcPJkOapTJo3+W0NvWSQWWmDbYaowesSRw=;
 b=NV7rIuM2p8xP8X6oUedsBjHZLz33fneVBwyhQ9BzFBDRy9fjj9DULe3E
 uRbjZjwlRCsYJADOihjoKTwVZi6rp5E7EQj+8mf8W0MC+xYIXSIrgU+9E
 IFPMefskfwmA5WlEw0/DA0i7xl4h6u73/QklQu3tX9fDslVGaF+hV2xPG
 OUWVkzbZ+tUmSiudav6DJ+udR8YXZIY8AGAStuD6NTTeTP6Suckx8Vaad
 IK2tuhJ8tKhFLjqirgcHV9eNTVpNDThGmy2JHhuKarvXUBiJLrMvM3Qj7
 0bnNffXtl9sIsRjurdlSl6f+Ak02K3hRSUt6J28jJSbNqsp9hpKTj8aV5 A==;
X-CSE-ConnectionGUID: zZ1ubLUvSaOtt2nS82/ivA==
X-CSE-MsgGUID: HX/5lzMIT7WiRbR4ojIEiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="61705043"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="61705043"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:39 -0700
X-CSE-ConnectionGUID: doDc5s1pS+eHHfrgl1IgHA==
X-CSE-MsgGUID: hPQ1h9d3R/CJz6qzyND+mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; d="scan'208";a="179428158"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 16:43:39 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v1 6/7] vfio/device: Add support for
 VFIO_DEVICE_FEATURE_DMA_BUF
Date: Fri,  3 Oct 2025 16:35:59 -0700
Message-ID: <20251003234138.85820-7-vivek.kasireddy@intel.com>
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
 hw/vfio/device.c              | 43 +++++++++++++++++++++++++++++++++++
 include/hw/vfio/vfio-device.h |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 64f8750389..49070929ac 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 
+#include "system/ramblock.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
 #include "hw/hw.h"
@@ -592,3 +593,45 @@ static VFIODeviceIOOps vfio_device_io_ops_ioctl = {
     .region_read = vfio_device_io_region_read,
     .region_write = vfio_device_io_region_write,
 };
+
+int vfio_device_create_dmabuf(VFIODevice *vdev,
+                              struct iovec *iov, unsigned int iov_cnt)
+{
+    g_autofree struct vfio_device_feature *feature;
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
+        rcu_read_lock();
+        rb = qemu_ram_block_from_host(iov[i].iov_base, false, &offset);
+        rcu_read_unlock();
+
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
+    return ioctl(vdev->fd, VFIO_DEVICE_FEATURE, feature);
+}
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index bdb106c937..74b3c4eef7 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -279,6 +279,9 @@ int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
                                 struct vfio_irq_info *info);
 
 int vfio_get_region_index_from_mr(MemoryRegion *mr);
+
+int vfio_device_create_dmabuf(VFIODevice *vbasedev,
+                              struct iovec *iov, unsigned int iov_cnt);
 #endif
 
 /* Returns 0 on success, or a negative errno. */
-- 
2.50.1


