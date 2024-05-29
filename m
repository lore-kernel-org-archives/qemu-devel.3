Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70889C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM72-0001HG-Kh; Wed, 29 May 2024 12:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6x-00019t-QR
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:11 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6v-0006Ki-C9
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:11 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6i-006COe-St;
 Wed, 29 May 2024 17:24:56 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [PATCH 03/26] vfio/container: support VFIO_DMA_UNMAP_FLAG_ALL
Date: Wed, 29 May 2024 17:22:56 +0100
Message-Id: <20240529162319.1476680-4-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

Some containers can directly implement unmapping all regions;
add a new flag to support this.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/common.c                      | 24 +++++++----------
 hw/vfio/container-base.c              |  4 +--
 hw/vfio/container.c                   | 38 +++++++++++++++++++++++++--
 hw/vfio/iommufd.c                     | 19 +++++++++++++-
 include/hw/vfio/vfio-common.h         |  1 +
 include/hw/vfio/vfio-container-base.h |  4 +--
 6 files changed, 68 insertions(+), 22 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index a18af7a94f..ac89bc4b02 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -330,7 +330,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         }
     } else {
         ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       iotlb->addr_mask + 1, iotlb);
+                                       iotlb->addr_mask + 1, iotlb, 0);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
@@ -354,7 +354,7 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     int ret;
 
     /* Unmap with a single call. */
-    ret = vfio_container_dma_unmap(bcontainer, iova, size , NULL);
+    ret = vfio_container_dma_unmap(bcontainer, iova, size, NULL, 0);
     if (ret) {
         error_report("%s: vfio_container_dma_unmap() failed: %s", __func__,
                      strerror(-ret));
@@ -806,21 +806,15 @@ static void vfio_listener_region_del(MemoryListener *listener,
     }
 
     if (try_unmap) {
+        int flags = 0;
+
         if (int128_eq(llsize, int128_2_64())) {
-            /* The unmap ioctl doesn't accept a full 64-bit span. */
-            llsize = int128_rshift(llsize, 1);
-            ret = vfio_container_dma_unmap(bcontainer, iova,
-                                           int128_get64(llsize), NULL);
-            if (ret) {
-                error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
-                             "0x%"HWADDR_PRIx") = %d (%s)",
-                             bcontainer, iova, int128_get64(llsize), ret,
-                             strerror(-ret));
-            }
-            iova += int128_get64(llsize);
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
         }
-        ret = vfio_container_dma_unmap(bcontainer, iova,
-                                       int128_get64(llsize), NULL);
+
+        ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
+                                       NULL, flags);
+
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index f16766f490..3b2d3f38d5 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -26,10 +26,10 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb)
+                             IOMMUTLBEntry *iotlb, int flags)
 {
     g_assert(bcontainer->ops->dma_unmap);
-    return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
+    return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb, flags);
 }
 
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 6e6308382f..27ddb894e9 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -118,7 +118,7 @@ unmap_exit:
  */
 static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
                                  hwaddr iova, ram_addr_t size,
-                                 IOMMUTLBEntry *iotlb)
+                                 IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -141,6 +141,34 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
         need_dirty_sync = true;
     }
 
+    /* use unmap all if supported */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        unmap.iova = 0;
+        unmap.size = 0;
+        if (container->unmap_all_supported) {
+            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+        } else {
+            /* unmap in halves */
+            Int128 llsize = int128_rshift(int128_2_64(), 1);
+
+            unmap.size = int128_get64(llsize);
+
+            ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+
+            if (ret == 0) {
+                unmap.iova += int128_get64(llsize);
+
+                ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
+            }
+        }
+
+        if (ret != 0) {
+            return -errno;
+        }
+
+        goto out;
+    }
+
     while (ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, &unmap)) {
         /*
          * The type1 backend has an off-by-one bug in the kernel (71a7d3d78e3c
@@ -164,6 +192,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
         return -errno;
     }
 
+out:
     if (need_dirty_sync) {
         ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr, &local_err);
@@ -201,7 +230,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
      */
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
         (errno == EBUSY &&
-         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL) == 0 &&
+         vfio_legacy_dma_unmap(bcontainer, iova, size, NULL, 0) == 0 &&
          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
         return 0;
     }
@@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     vfio_get_info_iova_range(info, bcontainer);
 
     vfio_get_iommu_info_migration(container, info);
+
+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+
+    container->unmap_all_supported = (ret != 0);
+
     return true;
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 3d08a4f2dc..7bcadacd0b 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -40,11 +40,28 @@ static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
 
 static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
                               hwaddr iova, ram_addr_t size,
-                              IOMMUTLBEntry *iotlb)
+                              IOMMUTLBEntry *iotlb, int flags)
 {
     const VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
 
+    /* unmap in halves */
+    if (flags & VFIO_DMA_UNMAP_FLAG_ALL) {
+        Int128 llsize = int128_rshift(int128_2_64(), 1);
+        int ret;
+
+        ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                        iova, int128_get64(llsize));
+        iova += int128_get64(llsize);
+
+        if (ret == 0) {
+            ret = iommufd_backend_unmap_dma(container->be, container->ioas_id,
+                                            iova, int128_get64(llsize));
+        }
+
+        return ret;
+    }
+
     /* TODO: Handle dma_unmap_bitmap with iotlb args (migration) */
     return iommufd_backend_unmap_dma(container->be,
                                      container->ioas_id, iova, size);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 4cb1ab8645..d112c9b72f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,6 +79,7 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    bool unmap_all_supported;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index e9b59c179e..c2c1af70ac 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -75,7 +75,7 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            void *vaddr, bool readonly, MemoryRegion *mrp);
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
-                             IOMMUTLBEntry *iotlb);
+                             IOMMUTLBEntry *iotlb, int flags);
 bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section,
                                        Error **errp);
@@ -118,7 +118,7 @@ struct VFIOIOMMUClass {
                    void *vaddr, bool readonly, MemoryRegion *mrp);
     int (*dma_unmap)(const VFIOContainerBase *bcontainer,
                      hwaddr iova, ram_addr_t size,
-                     IOMMUTLBEntry *iotlb);
+                     IOMMUTLBEntry *iotlb, int flags);
     bool (*attach_device)(const char *name, VFIODevice *vbasedev,
                           AddressSpace *as, Error **errp);
     void (*detach_device)(VFIODevice *vbasedev);
-- 
2.34.1


