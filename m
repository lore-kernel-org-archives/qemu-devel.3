Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA3FCCD193
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7Fm-0004hy-W0; Thu, 23 Oct 2025 22:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fj-0004dV-V4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:04 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fg-0006Ox-Q4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761271801; x=1792807801;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Eclj4cdx4Y1JlW3goqyMKz0ankf8fdaUIvLDDlYhGM4=;
 b=FpjdLewklbbutUML6DrMXVBWBkiB5qB93ZmqjJBh4eqiU1LehqySPJsO
 kwkxvl4CBBht1WyIlQClQsSb5FGRliLbsLhOhyshLDj/+glhEy9c/Lfjf
 VtwT+JCmrSVBecpm+heM2lNs6p9eP5h1mMBSyYirmlp5Ps2gQ95oKw6WP
 rxWKU7MOpDs3q/PuE5Uc6OmzYNN8jfLDWbvMWgoWhRL6C/ZRnbv4cRMFv
 Dny73KqaEap3hNvj+MfF4tXilxnDr7DOPKOKOWPzTfC14N0U7py/Ym1sT
 j9iHwf11CI9SX3MC2X5GTQq0Lb7/rmMrQrlh9OtbMRKT9pSvVpv8/e/IX g==;
X-CSE-ConnectionGUID: edbHvyIxTPGxEfKC/GePZQ==
X-CSE-MsgGUID: SpYey2r3Q2GBxl2AEZnZwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62662149"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62662149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:10:00 -0700
X-CSE-ConnectionGUID: a/PBr8OJR8CQr8JJ2eeKTQ==
X-CSE-MsgGUID: gpOse9nRSIeV8qH7jc/ukg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="189440766"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:09:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 4/8] vfio: Add a backend_flag parameter to
 vfio_contianer_query_dirty_bitmap()
Date: Thu, 23 Oct 2025 22:09:18 -0400
Message-ID: <20251024020922.13053-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024020922.13053-1-zhenzhong.duan@intel.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

From: Joao Martins <joao.m.martins@oracle.com>

This new parameter will be used in following patch, currently 0 is passed.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 include/hw/vfio/vfio-container.h |  8 ++++++--
 hw/vfio-user/container.c         |  5 +++--
 hw/vfio/container-legacy.c       |  5 +++--
 hw/vfio/container.c              | 15 +++++++++------
 hw/vfio/iommufd.c                |  7 ++++---
 hw/vfio/listener.c               |  6 +++---
 hw/vfio/trace-events             |  2 +-
 7 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index c4b58d664b..9f6e8cedfc 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -99,7 +99,9 @@ bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainer *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      hwaddr translated_addr, Error **errp);
+                                      uint64_t backend_flag,
+                                      hwaddr translated_addr,
+                                      Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
@@ -253,12 +255,14 @@ struct VFIOIOMMUClass {
      * @vbmap: #VFIOBitmap internal bitmap structure
      * @iova: iova base address
      * @size: size of iova range
+     * @backend_flag: flags for backend, opaque to upper layer container
      * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error.
      */
     int (*query_dirty_bitmap)(const VFIOContainer *bcontainer,
-                VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
+                              VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
+                              uint64_t backend_flag, Error **errp);
     /* PCI specific */
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index e45192fef6..3ce6ea12db 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -162,8 +162,9 @@ vfio_user_set_dirty_page_tracking(const VFIOContainer *bcontainer,
 }
 
 static int vfio_user_query_dirty_bitmap(const VFIOContainer *bcontainer,
-                                         VFIOBitmap *vbmap, hwaddr iova,
-                                         hwaddr size, Error **errp)
+                                        VFIOBitmap *vbmap, hwaddr iova,
+                                        hwaddr size, uint64_t backend_flag,
+                                        Error **errp)
 {
     error_setg_errno(errp, ENOTSUP, "Not supported");
     return -ENOTSUP;
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index b7e3b892b9..dd9c4a6a5a 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -154,7 +154,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                     iotlb->translated_addr, &local_err);
         if (ret) {
             error_report_err(local_err);
@@ -255,7 +255,8 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainer *bcontainer,
 }
 
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainer *bcontainer,
-                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
+                                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
+                                   uint64_t backend_flag, Error **errp)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ddec300e3..7706603c1c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -213,13 +213,13 @@ static int vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
 
 static int vfio_container_iommu_query_dirty_bitmap(
     const VFIOContainer *bcontainer, VFIOBitmap *vbmap, hwaddr iova,
-    hwaddr size, Error **errp)
+    hwaddr size, uint64_t backend_flag, Error **errp)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     g_assert(vioc->query_dirty_bitmap);
     return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
-                                               errp);
+                                    backend_flag, errp);
 }
 
 static int vfio_container_devices_query_dirty_bitmap(
@@ -247,7 +247,9 @@ static int vfio_container_devices_query_dirty_bitmap(
 
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      hwaddr translated_addr, Error **errp)
+                                      uint64_t backend_flag,
+                                      hwaddr translated_addr,
+                                      Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -274,7 +276,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                                         errp);
     } else {
         ret = vfio_container_iommu_query_dirty_bitmap(bcontainer, &vbmap, iova, size,
-                                                     errp);
+                                                      backend_flag, errp);
     }
 
     if (ret) {
@@ -285,8 +287,9 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                                          translated_addr,
                                                          vbmap.pages);
 
-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
-                                            translated_addr, dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, backend_flag,
+                                            vbmap.size, translated_addr,
+                                            dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 5f96a41246..b59a8639c6 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -74,7 +74,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                                     iotlb->translated_addr,
                                                     &local_err);
             if (ret) {
@@ -100,7 +100,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     }
 
     if (need_dirty_sync) {
-        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+        ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size, 0,
                                                 iotlb->translated_addr,
                                                 &local_err);
         if (ret) {
@@ -216,7 +216,8 @@ err:
 
 static int iommufd_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       VFIOBitmap *vbmap, hwaddr iova,
-                                      hwaddr size, Error **errp)
+                                      hwaddr size, uint64_t backend_flag,
+                                      Error **errp)
 {
     VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
     unsigned long page_size = qemu_real_host_page_size();
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2d7d3a4645..2109101158 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -1083,7 +1083,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
-                                translated_addr, &local_err);
+                                0, translated_addr, &local_err);
     if (ret) {
         error_prepend(&local_err,
                       "vfio_iommu_map_dirty_notify(%p, 0x%"HWADDR_PRIx", "
@@ -1119,7 +1119,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size,
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, 0,
                                             translated_addr, &local_err);
     if (ret) {
         error_report_err(local_err);
@@ -1204,7 +1204,7 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
 
     return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                   int128_get64(section->size), translated_addr, errp);
+                   int128_get64(section->size), 0, translated_addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 1e895448cd..3c62bab764 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -105,7 +105,7 @@ vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32,
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container.c
-vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
+vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t backend_flag, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size=0x%"PRIx64" backend_flag=0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
 
 # container-legacy.c
 vfio_container_disconnect(int fd) "close container->fd=%d"
-- 
2.47.1


