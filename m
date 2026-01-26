Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CBCC88E7E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 09:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkIo2-00020t-Pe; Mon, 26 Jan 2026 04:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkIns-0001v6-CH
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vkInq-0005zi-2j
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 04:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769419353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPa5h3aD/5wLkODm+sqMFrJ0UMHGiuqZciNwX7qEZyg=;
 b=JwH8cunjg3KkCOnWxA/Sy3yvBOE7YaD77OD9OlTH2XtmOIRocb7gjimp+zLXygdJTafrSA
 tDCOSkrUL6bOux0AQ3WIwF/L3k4SlmuVoFHCJ7XTVMB+C9auMKcaBWhLny14CXFkKgn056
 MpfV4BWTyVnkuOMXeVE8jovwMIAZhtk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-pDHmG497MsuOy6qbr-n5Qg-1; Mon,
 26 Jan 2026 04:22:31 -0500
X-MC-Unique: pDHmG497MsuOy6qbr-n5Qg-1
X-Mimecast-MFC-AGG-ID: pDHmG497MsuOy6qbr-n5Qg_1769419350
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA6201944E45; Mon, 26 Jan 2026 09:22:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A3E01956095; Mon, 26 Jan 2026 09:22:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Nicolin Chen <nicolinc@nvidia.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 5/7] hw/vfio/region: Create dmabuf for PCI BAR per region
Date: Mon, 26 Jan 2026 10:22:10 +0100
Message-ID: <20260126092212.503162-6-clg@redhat.com>
In-Reply-To: <20260126092212.503162-1-clg@redhat.com>
References: <20260126092212.503162-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. Create a dmabuf for each mapped BAR region after the mmap is set
up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
the BAR correctly in the host IOMMU page table.

If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
and continues with normal mmap handling.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260121114111.34045-4-skolothumtho@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/region.c     | 65 +++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |  1 +
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ca75ab1be4d601f5371c929a7784c8ba264df9ae..ab39d77574ccef0ca8d393435979db97bcbd882b 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "system/ramblock.h"
 #include "vfio-helpers.h"
 
 /*
@@ -238,13 +239,71 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
     region->mmaps[index].mmap = NULL;
 }
 
+static bool vfio_region_create_dma_buf(VFIORegion *region, Error **errp)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    VFIODevice *vbasedev = region->vbasedev;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    size_t total_size;
+    int i, ret;
+
+    total_size = sizeof(*feature) + sizeof(*dma_buf) +
+                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
+    feature = g_malloc0(total_size);
+    *feature = (struct vfio_device_feature) {
+        .argsz = total_size,
+        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
+    };
+
+    dma_buf = (void *)feature->data;
+    *dma_buf = (struct vfio_device_feature_dma_buf) {
+        .region_index = region->nr,
+        .open_flags = O_RDWR,
+        .nr_ranges = region->nr_mmaps,
+    };
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
+        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
+    }
+
+    ret = vfio_device_get_feature(vbasedev, feature);
+    if (ret < 0) {
+        if (ret == -ENOTTY) {
+            warn_report_once("VFIO dma-buf not supported in kernel: "
+                             "PCI BAR IOMMU mappings may fail");
+            return true;
+        }
+        /* P2P DMA or exposing device memory use cases are not supported. */
+        error_setg_errno(errp, -ret, "%s: failed to create dma-buf: "
+                         "PCI BAR IOMMU mappings may fail",
+                         memory_region_name(region->mem));
+        return false;
+    }
+
+    /* Assign the dmabuf fd to associated RAMBlock */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        MemoryRegion *mr = &region->mmaps[i].mem;
+        RAMBlock *ram_block = mr->ram_block;
+
+        ram_block->fd = ret;
+        ram_block->fd_offset = region->mmaps[i].offset;
+        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
+                                 memory_region_name(region->mem),
+                                 region->mmaps[i].offset,
+                                 region->mmaps[i].size);
+    }
+    return true;
+}
+
 int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
+    Error *local_err = NULL;
     char *name;
     int fd;
 
-    if (!region->mem) {
+    if (!region->mem || !region->nr_mmaps) {
         return 0;
     }
 
@@ -305,6 +364,10 @@ int vfio_region_mmap(VFIORegion *region)
                                region->mmaps[i].size - 1);
     }
 
+    if (!vfio_region_create_dma_buf(region, &local_err)) {
+        error_report_err(local_err);
+    }
+
     return 0;
 
 no_mmap:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 180e3d526b80bd43d18bbfb9332833df4fbeb720..466695507b77c974ba0e4e61109c0abe2d06c71c 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -118,6 +118,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
+vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
 vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
 vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
-- 
2.52.0


