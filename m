Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B64C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTgV-0006eC-Ks; Tue, 18 Mar 2025 05:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgN-00068i-60
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTgK-0002Ut-F7
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UlfhCi95s5Pg65sztE9dKrbT2Ma9PiuPvtSEFGRW5RU=;
 b=TsWHbd1ILmeF7z/2z3aY+a8QmtumtPhK8LEEz1c9eTDEzg+lt77cO7S9rqbsWgFzT8oGWv
 3E99zl0OoTR3snAMZfJo7Fq8zlPIVvkiRYKZR/yDow+RrmuVSavGmVtSwNztO+yNaKyKgd
 TZKbhavELFdeUfu6cTTsPShkYn2vu1Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-k_AzVIU_NX6-rFi3ufFtZg-1; Tue,
 18 Mar 2025 05:56:16 -0400
X-MC-Unique: k_AzVIU_NX6-rFi3ufFtZg-1
X-Mimecast-MFC-AGG-ID: k_AzVIU_NX6-rFi3ufFtZg_1742291776
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 044C01955DAC; Tue, 18 Mar 2025 09:56:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8FA31828A83; Tue, 18 Mar 2025 09:56:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 30/32] vfio: Rename VFIO dirty tracking services
Date: Tue, 18 Mar 2025 10:54:13 +0100
Message-ID: <20250318095415.670319-31-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rename these routines :

  vfio_devices_all_device_dirty_tracking_started -> vfio_dirty_tracking_devices_is_started_all
  vfio_devices_all_dirty_tracking_started        -> vfio_dirty_tracking_devices_is_started
  vfio_devices_all_device_dirty_tracking         -> vfio_dirty_tracking_devices_is_supported
  vfio_devices_dma_logging_start                 -> vfio_dirty_tracking_devices_dma_logging_start
  vfio_devices_dma_logging_stop                  -> vfio_dirty_tracking_devices_dma_logging_stop
  vfio_devices_query_dirty_bitmap                -> vfio_dirty_tracking_devices_query_dirty_bitmap
  vfio_get_dirty_bitmap                          -> vfio_dirty_tracking_query_dirty_bitmap

to better reflect the namespace they belong to.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/dirty-tracking.h |  6 +++---
 hw/vfio/container.c      |  6 +++---
 hw/vfio/dirty-tracking.c | 44 ++++++++++++++++++++--------------------
 hw/vfio/trace-events     |  2 +-
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/hw/vfio/dirty-tracking.h b/hw/vfio/dirty-tracking.h
index 322af30b0d5370600719594d4aed4c407f7d2295..db9494202a780108ce78b642950bfed78ba3f253 100644
--- a/hw/vfio/dirty-tracking.h
+++ b/hw/vfio/dirty-tracking.h
@@ -11,9 +11,9 @@
 
 extern const MemoryListener vfio_memory_listener;
 
-bool vfio_devices_all_dirty_tracking_started(const VFIOContainerBase *bcontainer);
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer);
+bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer);
+int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp);
 
 #endif /* HW_VFIO_DIRTY_TRACKING_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 40d6c1fecbf9c37c22b8c19f8e9e8b6c5c381249..7b3ec798a77052b8cb0b47d3dceaca1428cb50bd 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -138,8 +138,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     int ret;
     Error *local_err = NULL;
 
-    if (iotlb && vfio_devices_all_dirty_tracking_started(bcontainer)) {
-        if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
+    if (iotlb && vfio_dirty_tracking_devices_is_started(bcontainer)) {
+        if (!vfio_dirty_tracking_devices_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
@@ -170,7 +170,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_get_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, size,
                                     iotlb->translated_addr, &local_err);
         if (ret) {
             error_report_err(local_err);
diff --git a/hw/vfio/dirty-tracking.c b/hw/vfio/dirty-tracking.c
index 9b20668a6d0df93a2cfde12d9a5cd7c223ae3ca1..8e47ccbb9aea748e57271508ddcd10e394abf16c 100644
--- a/hw/vfio/dirty-tracking.c
+++ b/hw/vfio/dirty-tracking.c
@@ -45,7 +45,7 @@
  * Device state interfaces
  */
 
-static bool vfio_devices_all_device_dirty_tracking_started(
+static bool vfio_dirty_tracking_devices_is_started_all(
     const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
@@ -59,10 +59,9 @@ static bool vfio_devices_all_device_dirty_tracking_started(
     return true;
 }
 
-bool vfio_devices_all_dirty_tracking_started(
-    const VFIOContainerBase *bcontainer)
+bool vfio_dirty_tracking_devices_is_started(const VFIOContainerBase *bcontainer)
 {
-    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
+    return vfio_dirty_tracking_devices_is_started_all(bcontainer) ||
            bcontainer->dirty_pages_started;
 }
 
@@ -70,7 +69,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
-    if (!vfio_devices_all_dirty_tracking_started(bcontainer)) {
+    if (!vfio_dirty_tracking_devices_is_started(bcontainer)) {
         return false;
     }
 
@@ -90,7 +89,7 @@ static bool vfio_log_sync_needed(const VFIOContainerBase *bcontainer)
     return true;
 }
 
-bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
+bool vfio_dirty_tracking_devices_is_supported(const VFIOContainerBase *bcontainer)
 {
     VFIODevice *vbasedev;
 
@@ -809,7 +808,7 @@ static void vfio_dirty_tracking_init(VFIOContainerBase *bcontainer,
     memory_listener_unregister(&dirty.listener);
 }
 
-static void vfio_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
+static void vfio_dirty_tracking_devices_dma_logging_stop(VFIOContainerBase *bcontainer)
 {
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
@@ -907,7 +906,7 @@ static void vfio_device_feature_dma_logging_start_destroy(
     g_free(feature);
 }
 
-static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
+static bool vfio_dirty_tracking_devices_dma_logging_start(VFIOContainerBase *bcontainer,
                                           Error **errp)
 {
     struct vfio_device_feature *feature;
@@ -940,7 +939,7 @@ static bool vfio_devices_dma_logging_start(VFIOContainerBase *bcontainer,
 
 out:
     if (ret) {
-        vfio_devices_dma_logging_stop(bcontainer);
+        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
     }
 
     vfio_device_feature_dma_logging_start_destroy(feature);
@@ -956,8 +955,8 @@ static bool vfio_listener_log_global_start(MemoryListener *listener,
                                                  listener);
     bool ret;
 
-    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
-        ret = vfio_devices_dma_logging_start(bcontainer, errp);
+    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
+        ret = vfio_dirty_tracking_devices_dma_logging_start(bcontainer, errp);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, true, errp) == 0;
     }
@@ -975,8 +974,8 @@ static void vfio_listener_log_global_stop(MemoryListener *listener)
     Error *local_err = NULL;
     int ret = 0;
 
-    if (vfio_devices_all_device_dirty_tracking(bcontainer)) {
-        vfio_devices_dma_logging_stop(bcontainer);
+    if (vfio_dirty_tracking_devices_is_supported(bcontainer)) {
+        vfio_dirty_tracking_devices_dma_logging_stop(bcontainer);
     } else {
         ret = vfio_container_set_dirty_page_tracking(bcontainer, false,
                                                      &local_err);
@@ -1016,7 +1015,7 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
     return 0;
 }
 
-static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
+static int vfio_dirty_tracking_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                  VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
     VFIODevice *vbasedev;
@@ -1038,11 +1037,11 @@ static int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
     return 0;
 }
 
-int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
+int vfio_dirty_tracking_query_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
                           uint64_t size, ram_addr_t ram_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
-        vfio_devices_all_device_dirty_tracking(bcontainer);
+        vfio_dirty_tracking_devices_is_supported(bcontainer);
     uint64_t dirty_pages;
     VFIOBitmap vbmap;
     int ret;
@@ -1062,8 +1061,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
     }
 
     if (all_device_dirty_tracking) {
-        ret = vfio_devices_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                              errp);
+        ret = vfio_dirty_tracking_devices_query_dirty_bitmap(bcontainer, &vbmap,
+                                                             iova, size, errp);
     } else {
         ret = vfio_container_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
                                                 errp);
@@ -1076,7 +1075,8 @@ int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t iova,
     dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
                                                          vbmap.pages);
 
-    trace_vfio_get_dirty_bitmap(iova, size, vbmap.size, ram_addr, dirty_pages);
+    trace_vfio_dirty_tracking_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
+                                                 dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
@@ -1113,7 +1113,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
         goto out_unlock;
     }
 
-    ret = vfio_get_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
+    ret = vfio_dirty_tracking_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
     if (ret) {
         error_prepend(&local_err,
@@ -1147,7 +1147,7 @@ static int vfio_ram_discard_get_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_get_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
+    ret = vfio_dirty_tracking_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
                                 &local_err);
     if (ret) {
         error_report_err(local_err);
@@ -1241,7 +1241,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
     ram_addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
-    return vfio_get_dirty_bitmap(bcontainer,
+    return vfio_dirty_tracking_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
                                  int128_get64(section->size), ram_addr, errp);
 }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 512f4913b72d9a1e8a04df24318a4947fa361e28..6cf8ec3530c68e7528eefa80b7c8ecb401319f88 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -100,7 +100,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" -
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
-vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_dirty_tracking_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # region.c
-- 
2.48.1


