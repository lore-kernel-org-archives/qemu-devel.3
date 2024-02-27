Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD11C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 20:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf4Kt-0005xu-KD; Tue, 27 Feb 2024 15:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1pG-0005RI-OM
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:05:12 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GitP=KE=redhat.com=clg@ozlabs.org>)
 id 1rf1pC-0001mJ-4v
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:05:09 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Tklkm10Trz4x1k;
 Wed, 28 Feb 2024 05:05:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tklkj3rxMz4x1Y;
 Wed, 28 Feb 2024 05:05:01 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 19/21] vfio: Add Error** argument to .get_dirty_bitmap()
 handler
Date: Tue, 27 Feb 2024 19:03:43 +0100
Message-ID: <20240227180345.548960-20-clg@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227180345.548960-1-clg@redhat.com>
References: <20240227180345.548960-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GitP=KE=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 27 Feb 2024 15:45:32 -0500
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

Let the callers do the error reporting. Add documentation while at it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  4 +-
 include/hw/vfio/vfio-container-base.h | 17 +++++++-
 hw/vfio/common.c                      | 59 ++++++++++++++++++---------
 hw/vfio/container-base.c              |  5 ++-
 hw/vfio/container.c                   | 13 +++---
 5 files changed, 67 insertions(+), 31 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 6d9dee626afc491645d2c2398f3e3210961f67e9..83ffad89f5cf434452332fe29fb752d9ec71b2f0 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -271,9 +271,9 @@ bool
 vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
-                                    hwaddr size);
+                                    hwaddr size, Error **errp);
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr);
+                          uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 /* Returns 0 on success, or a negative errno. */
 int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index dec2023eceb6c7d62b0ee35008cc58f8e695e190..3ee713014cb414f18b34092641a17717983b5559 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -84,7 +84,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
-                                      hwaddr iova, hwaddr size);
+                                      hwaddr iova, hwaddr size, Error **errp);
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
                          VFIOAddressSpace *space,
@@ -137,9 +137,22 @@ struct VFIOIOMMUClass {
      */
     int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
                                    bool start, Error **errp);
+    /**
+     * @query_dirty_bitmap
+     *
+     * Get list of dirty pages from container
+     *
+     * @bcontainer: #VFIOContainerBase from which to get dirty pages
+     * @vbmap: #VFIOBitmap internal bitmap structure
+     * @iova: iova base address
+     * @size: size of iova range
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*query_dirty_bitmap)(const VFIOContainerBase *bcontainer,
                               VFIOBitmap *vbmap,
-                              hwaddr iova, hwaddr size);
+                              hwaddr iova, hwaddr size, Error **errp);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 43f37447e3692ffa97788b02f83b81b44aaf301a..8fbf04e55d1b304bc80fdd9ef6f5f5089acd3360 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1154,7 +1154,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
-                                    hwaddr size)
+                                    hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
     int ret;
@@ -1163,10 +1163,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
         ret = vfio_device_dma_logging_report(vbasedev, iova, size,
                                              vbmap->bitmap);
         if (ret) {
-            error_report("%s: Failed to get DMA logging report, iova: "
-                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
-                         ", err: %d (%s)",
-                         vbasedev->name, iova, size, ret, strerror(-ret));
+            error_setg(errp, "%s: Failed to get DMA logging report, iova: "
+                       "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
+                       ", err: %d (%s)",
+                       vbasedev->name, iova, size, ret, strerror(-ret));
 
             return ret;
         }
@@ -1176,7 +1176,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 }
 
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr)
+                          uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(bcontainer);
@@ -1193,13 +1193,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 
     ret = vfio_bitmap_alloc(&vbmap, size);
     if (ret) {
+        error_setg_errno(errp, -ret,
+                         "Failed to allocate dirty tracking bitmap");
         return ret;
     }
 
     if (all_device_dirty_tracking) {
-        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
+        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
+                                              errp);
     } else {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size);
+        ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
+                                                errp);
     }
 
     if (ret) {
@@ -1247,12 +1251,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
-                                translated_addr);
+                                translated_addr, &local_err);
     if (ret) {
-        error_report("vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
-                     "0x%"HWADDR_PRIx") = %d (%s)",
-                     bcontainer, iova, iotlb->addr_mask + 1, ret,
-                     strerror(-ret));
+        error_prepend(&local_err,
+                      "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
+                      "0x%"HWADDR_PRIx") failed :", bcontainer, iova,
+                      iotlb->addr_mask + 1);
+        error_report_err(local_err);
     }
 
 out_lock:
@@ -1272,12 +1277,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
     const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
                                 section->offset_within_region;
     VFIORamDiscardListener *vrdl = opaque;
+    Error *local_err = NULL;
+    int ret;
 
     /*
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    return vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr);
+    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
+                                &local_err);
+    if (ret) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 static int
@@ -1309,7 +1321,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
 }
 
 static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
-                                  MemoryRegionSection *section)
+                                  MemoryRegionSection *section, Error **errp)
 {
     ram_addr_t ram_addr;
 
@@ -1340,7 +1352,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
         }
         return 0;
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
-        return vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
+        int ret;
+
+        ret = vfio_sync_ram_discard_listener_dirty_bitmap(bcontainer, section);
+        if (ret) {
+            error_setg(errp,
+                       "Failed to sync dirty bitmap with RAM discard listener");
+            return ret;
+        }
     }
 
     ram_addr = memory_region_get_ram_addr(section->mr) +
@@ -1348,7 +1367,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
 
     return vfio_get_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                   int128_get64(section->size), ram_addr);
+                                 int128_get64(section->size), ram_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
@@ -1357,16 +1376,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
     int ret;
+    Error *local_err = NULL;
 
     if (vfio_listener_skipped_section(section)) {
         return;
     }
 
     if (vfio_devices_all_dirty_tracking(bcontainer)) {
-        ret = vfio_sync_dirty_bitmap(bcontainer, section);
+        ret = vfio_sync_dirty_bitmap(bcontainer, section, &local_err);
         if (ret) {
-            error_report("vfio: Failed to sync dirty bitmap, err: %d (%s)", ret,
-                         strerror(-ret));
+            error_report_err(local_err);
             vfio_set_migration_error(ret);
         }
     }
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 7c0764121d24b02b6c4e66e368d7dff78a6d65aa..8db59881873c3b1edee81104b966af737e5fa6f6 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -65,10 +65,11 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
 
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
-                                      hwaddr iova, hwaddr size)
+                                      hwaddr iova, hwaddr size, Error **errp)
 {
     g_assert(bcontainer->ops->query_dirty_bitmap);
-    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size);
+    return bcontainer->ops->query_dirty_bitmap(bcontainer, vbmap, iova, size,
+                                               errp);
 }
 
 void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index f772ac79b9c413c86d7e60f6dc4e6699852d5aac..a5243b5ee4bb5bc2f732554bd6cfa1b92758195e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -131,6 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     };
     bool need_dirty_sync = false;
     int ret;
+    Error *local_err = NULL;
 
     if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
@@ -166,8 +167,9 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 
     if (need_dirty_sync) {
         ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
-                                    iotlb->translated_addr);
+                                    iotlb->translated_addr, &local_err);
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
     }
@@ -237,7 +239,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                           VFIOBitmap *vbmap,
-                                          hwaddr iova, hwaddr size)
+                                          hwaddr iova, hwaddr size,
+                                          Error **errp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -265,9 +268,9 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
     ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
     if (ret) {
         ret = -errno;
-        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
-                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
-                (uint64_t)range->size, errno);
+        error_setg(errp, "Failed to get dirty bitmap for iova: 0x%"PRIx64
+                   " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
+                   (uint64_t)range->size, errno);
     }
 
     g_free(dbitmap);
-- 
2.43.2


