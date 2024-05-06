Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ED6C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3uXi-0006XA-1e; Mon, 06 May 2024 05:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uXC-0005Mx-Tn
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s3uX8-0007Db-5o
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714987277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbfK/EfbO9wYCUSmx116xi66KsdJG9TEPjoE+6qvd64=;
 b=LlJMi+02hVqJunxo8mJSVW4HwvJAT8NXg0J67O42ttzloyhb7O0gMoVSfPZCl3MPfg10LH
 6PO3ECUDp0CS78/iTPCGqvHg3MfPFc7nNorbgoJ69oFO10mRvyf+V2QwE8559zzxI3QmGR
 Ms+dNSmrmk1/ZPvZOKtVJHpJu3S+clI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-rdLsU7qzPsS1v9l5TZ-6cw-1; Mon, 06 May 2024 05:21:15 -0400
X-MC-Unique: rdLsU7qzPsS1v9l5TZ-6cw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87EA281061A;
 Mon,  6 May 2024 09:21:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE8BDAC68;
 Mon,  6 May 2024 09:21:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v5 08/10] vfio: Add Error** argument to .get_dirty_bitmap()
 handler
Date: Mon,  6 May 2024 11:20:51 +0200
Message-ID: <20240506092053.388578-9-clg@redhat.com>
In-Reply-To: <20240506092053.388578-1-clg@redhat.com>
References: <20240506092053.388578-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Changes in v5:

 - Replaced error_setg() by error_setg_errno() in
   vfio_devices_query_dirty_bitmap() and vfio_legacy_query_dirty_bitmap()
 - ':' -> '-' in vfio_iommu_map_dirty_notify()
 
 include/hw/vfio/vfio-common.h         |  4 +-
 include/hw/vfio/vfio-container-base.h | 17 +++++++-
 hw/vfio/common.c                      | 59 ++++++++++++++++++---------
 hw/vfio/container-base.c              |  5 ++-
 hw/vfio/container.c                   | 14 ++++---
 5 files changed, 68 insertions(+), 31 deletions(-)

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
index 326ceea52a2030eec9dad289a9845866c4a8c090..48c92e186231c2c2b548abed08800faff3f430a7 100644
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
index da748563eb33843e93631a5240759964f33162f2..c3d82a9d6e434e33f361e4b96157bf912d5c3a2f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1141,7 +1141,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 
 int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                     VFIOBitmap *vbmap, hwaddr iova,
-                                    hwaddr size)
+                                    hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
     int ret;
@@ -1150,10 +1150,10 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
         ret = vfio_device_dma_logging_report(vbasedev, iova, size,
                                              vbmap->bitmap);
         if (ret) {
-            error_report("%s: Failed to get DMA logging report, iova: "
-                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
-                         ", err: %d (%s)",
-                         vbasedev->name, iova, size, ret, strerror(-ret));
+            error_setg_errno(errp, -ret,
+                             "%s: Failed to get DMA logging report, iova: "
+                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
+                             vbasedev->name, iova, size);
 
             return ret;
         }
@@ -1163,7 +1163,7 @@ int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
 }
 
 int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
-                          uint64_t size, ram_addr_t ram_addr)
+                          uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_devices_all_device_dirty_tracking(bcontainer);
@@ -1180,13 +1180,17 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
 
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
@@ -1234,12 +1238,13 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
+                      "0x%"HWADDR_PRIx") failed - ", bcontainer, iova,
+                      iotlb->addr_mask + 1);
+        error_report_err(local_err);
     }
 
 out_lock:
@@ -1259,12 +1264,19 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
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
@@ -1296,7 +1308,7 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
 }
 
 static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
-                                  MemoryRegionSection *section)
+                                  MemoryRegionSection *section, Error **errp)
 {
     ram_addr_t ram_addr;
 
@@ -1327,7 +1339,14 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
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
@@ -1335,7 +1354,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
 
     return vfio_get_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                   int128_get64(section->size), ram_addr);
+                                 int128_get64(section->size), ram_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
@@ -1344,16 +1363,16 @@ static void vfio_listener_log_sync(MemoryListener *listener,
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
index c35221fbe7dc5453050f97cd186fc958e24f28f7..e00db6546c652c61a352f8e4cd65b212ecfb65bc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -130,6 +130,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     };
     bool need_dirty_sync = false;
     int ret;
+    Error *local_err = NULL;
 
     if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
@@ -165,8 +166,9 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
 
     if (need_dirty_sync) {
         ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
-                                    iotlb->translated_addr);
+                                    iotlb->translated_addr, &local_err);
         if (ret) {
+            error_report_err(local_err);
             return ret;
         }
     }
@@ -236,7 +238,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                                           VFIOBitmap *vbmap,
-                                          hwaddr iova, hwaddr size)
+                                          hwaddr iova, hwaddr size,
+                                          Error **errp)
 {
     const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                                   bcontainer);
@@ -264,9 +267,10 @@ static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
     ret = ioctl(container->fd, VFIO_IOMMU_DIRTY_PAGES, dbitmap);
     if (ret) {
         ret = -errno;
-        error_report("Failed to get dirty bitmap for iova: 0x%"PRIx64
-                " size: 0x%"PRIx64" err: %d", (uint64_t)range->iova,
-                (uint64_t)range->size, errno);
+        error_setg_errno(errp, errno,
+                         "Failed to get dirty bitmap for iova: 0x%"PRIx64
+                         " size: 0x%"PRIx64, (uint64_t)range->iova,
+                         (uint64_t)range->size);
     }
 
     g_free(dbitmap);
-- 
2.45.0


