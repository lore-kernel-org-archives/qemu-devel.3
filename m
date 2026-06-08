Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884ECCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWT04-0000Xh-CT; Mon, 08 Jun 2026 01:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSzz-0000Uh-AA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSzx-0004xj-Cb
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780898287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SbgYMQGkqrUYXhy0wW+KcAc0hDD6qViPTQE/lxFpPTE=;
 b=U8l0dOEvh+v5XC1CkFMeT6Y4lMg2vCzqyyz4foou7tIiudufxgh4l+qy3nuf4qhlQ662+9
 3idKI1F3svh70IK6XhK2iYETcuBrGjAUaZxjT/a1N0mO0EpMchqDGi3m0QJjbuobhfVr9W
 bNKchJL/xbpod4GaGC8R8UgWw2/8H5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-i7yQjAYSMgWbr6BvmMGY8w-1; Mon,
 08 Jun 2026 01:58:04 -0400
X-MC-Unique: i7yQjAYSMgWbr6BvmMGY8w-1
X-Mimecast-MFC-AGG-ID: i7yQjAYSMgWbr6BvmMGY8w_1780898283
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A64195608E; Mon,  8 Jun 2026 05:58:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8242830001BE; Mon,  8 Jun 2026 05:58:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/iommufd: Merge .dma_map_file() into .dma_map()
Date: Mon,  8 Jun 2026 07:57:58 +0200
Message-ID: <20260608055758.359002-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Simplify the VFIOIOMMUClass interface by removing the dma_map_file
handler. Move the logic to decide between the standard virtual and
file-backed mapping into the IOMMUFD backend, utilizing the
MemoryRegion already passed to the dma_map handler.

This removes redundant dispatch logic from the generic container layer
and let backends to manage their own mapping strategies. This is
similar to the vfio-user implementation.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container.h | 15 ----------
 hw/vfio/container.c              | 38 ------------------------
 hw/vfio/iommufd.c                | 50 +++++++++++++++++++++++---------
 3 files changed, 37 insertions(+), 66 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index a7d5c5ed679a0338937ae02f37140d94720f6f11..c70828a0529cb2b41162a8bd452da1d9c20bc08f 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -172,21 +172,6 @@ struct VFIOIOMMUClass {
     int (*dma_map)(const VFIOContainer *bcontainer,
                    hwaddr iova, uint64_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
-    /**
-     * @dma_map_file
-     *
-     * Map a file range for the container.
-     *
-     * @bcontainer: #VFIOContainer to use for map
-     * @iova: start address to map
-     * @size: size of the range to map
-     * @fd: descriptor of the file to map
-     * @start: starting file offset of the range to map
-     * @readonly: map read only if true
-     */
-    int (*dma_map_file)(const VFIOContainer *bcontainer,
-                        hwaddr iova, uint64_t size,
-                        int fd, unsigned long start, bool readonly);
     /**
      * @dma_unmap
      *
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 56bd9ac0095df7b0f4da85f1d8dcb8d571fa9f2a..d09a6637324c6bf29b2fe22369082f87e280c98f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -15,7 +15,6 @@
 #include <linux/vfio.h>
 
 #include "system/tcg.h"
-#include "system/ramblock.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container.h"
@@ -74,49 +73,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
     bcontainer->space = space;
 }
 
-static bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer,
-                                            MemoryRegion *mr, int *fd)
-{
-    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-    RAMBlock *rb = mr->ram_block;
-
-    if (!vioc->dma_map_file || !rb) {
-        return false;
-    }
-
-    *fd = qemu_ram_get_fd(rb);
-    if (*fd < 0) {
-        return false;
-    }
-
-    /*
-     * We can use IOMMU DMA mapping (IOMMU_IOAS_MAP_FILE) for :
-     *
-     * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
-     * 2) RAM device sub-regions (MMIO BARs)
-     *
-     * Private RAM mappings (MAP_PRIVATE) are strictly excluded. Because
-     * they are subject to copy-on-write (COW) anomalies, their underlying
-     * PFNs can permanently diverge from the backing file
-     */
-    return qemu_ram_is_shared(rb) || memory_region_is_ram_device(mr);
-}
-
 int vfio_container_dma_map(VFIOContainer *bcontainer,
                            hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-    int mfd;
 
-    if (vfio_container_can_dma_map_file(bcontainer, mr, &mfd)) {
-        RAMBlock *rb = mr->ram_block;
-        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
-        unsigned long offset = qemu_ram_get_fd_offset(rb);
-
-        return vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
-                                  readonly);
-    }
     g_assert(vioc->dma_map);
     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mr);
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 68f2ae6f9f667bb05c20e452e8c5b43da6558098..6ff668d2597e07c6953cf0f1997514aec199642c 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "system/iommufd.h"
+#include "system/ramblock.h"
 #include "hw/core/iommu.h"
 #include "hw/core/qdev.h"
 #include "hw/vfio/vfio-cpr.h"
@@ -35,26 +36,50 @@
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO             \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
+static bool iommufd_cdev_can_map_file_dma(MemoryRegion *mr, int *fd)
+{
+    RAMBlock *rb = mr ? mr->ram_block : NULL;
+
+    if (!rb) {
+        return false;
+    }
+
+    *fd = qemu_ram_get_fd(rb);
+    if (*fd < 0) {
+        return false;
+    }
+
+    /*
+     * Use iommufd_backend_map_file_dma() (IOMMU_IOAS_MAP_FILE) for:
+     * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
+     * 2) RAM device sub-regions (MMIO BARs)
+     *
+     * Private RAM mappings (MAP_PRIVATE) are excluded: copy-on-write
+     * semantics can cause their underlying PFNs to permanently diverge
+     * from the backing file.
+     */
+    return qemu_ram_is_shared(rb) || memory_region_is_ram_device(mr);
+}
+
 static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
                             uint64_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+    int fd;
 
-    return iommufd_backend_map_dma(container->be,
-                                   container->ioas_id,
-                                   iova, size, vaddr, readonly);
-}
+    if (iommufd_cdev_can_map_file_dma(mr, &fd)) {
+        RAMBlock *rb = mr->ram_block;
+        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
+        unsigned long offset = qemu_ram_get_fd_offset(rb);
 
-static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
-                                 hwaddr iova, uint64_t size,
-                                 int fd, unsigned long start, bool readonly)
-{
-    const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
+        return iommufd_backend_map_file_dma(container->be, container->ioas_id,
+                                            iova, size, fd,
+                                            start + offset, readonly);
+    }
 
-    return iommufd_backend_map_file_dma(container->be,
-                                        container->ioas_id,
-                                        iova, size, fd, start, readonly);
+    return iommufd_backend_map_dma(container->be, container->ioas_id,
+                                   iova, size, vaddr, readonly);
 }
 
 static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
@@ -929,7 +954,6 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
     VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
 
     vioc->dma_map = iommufd_cdev_map;
-    vioc->dma_map_file = iommufd_cdev_map_file;
     vioc->dma_unmap = iommufd_cdev_unmap;
     vioc->attach_device = iommufd_cdev_attach;
     vioc->detach_device = iommufd_cdev_detach;
-- 
2.54.0


