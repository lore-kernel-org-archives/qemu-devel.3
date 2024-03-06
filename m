Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCEEC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrS5-0002PW-EE; Wed, 06 Mar 2024 08:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRg-0001qD-Mn
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:32 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrRd-0006XF-Ir
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:36:31 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYP74FcDz4x0m;
 Thu,  7 Mar 2024 00:36:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYP42mnZz4wbh;
 Thu,  7 Mar 2024 00:36:24 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 23/25] vfio: Add Error** argument to .get_dirty_bitmap()
 handler
Date: Wed,  6 Mar 2024 14:34:38 +0100
Message-ID: <20240306133441.2351700-24-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 46f88493634b5634a9c14a5caa33a463fbf2c50d..68911d36676667352e94a97895828aff4b194b57 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -274,9 +274,9 @@ bool
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
index c76984654a596e3016a8cf833e10143eb872e102..ebc49ebfbe7de862450941b1129faad5d62b3769 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -85,7 +85,7 @@ int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start, Error **errp);
 int vfio_container_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                       VFIOBitmap *vbmap,
-                                      hwaddr iova, hwaddr size);
+                                      hwaddr iova, hwaddr size, Error **errp);
 
 void vfio_container_init(VFIOContainerBase *bcontainer,
                          VFIOAddressSpace *space,
@@ -138,9 +138,22 @@ struct VFIOIOMMUClass {
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
index 496e5adaf8f18e9ae7e86dd69be0b9e71e86404f..65a11dc088524647541db97b7b8d6f07e5044728 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1158,7 +1158,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
-                                    hwaddr size)
+                                    hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
     int ret;
@@ -1167,10 +1167,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
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
@@ -1180,7 +1180,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 }
 
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr)
+                          uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(bcontainer);
@@ -1197,13 +1197,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 
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
@@ -1251,12 +1255,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
@@ -1276,12 +1281,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
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
@@ -1313,7 +1325,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
 }
 
 static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
-                                  MemoryRegionSection *section)
+                                  MemoryRegionSection *section, Error **errp)
 {
     ram_addr_t ram_addr;
 
@@ -1344,7 +1356,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
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
@@ -1352,7 +1371,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
 
     return vfio_get_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                   int128_get64(section->size), ram_addr);
+                                 int128_get64(section->size), ram_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
@@ -1361,16 +1380,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
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
index 6524575aeddcea8470b5fd10caf57475088d1813..475d96eaaa927998c6aa8cc9aa9f2115f5a1efda 100644
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
2.44.0


