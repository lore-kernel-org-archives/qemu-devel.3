Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67885E8FDA0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 08:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2nH-000070-9r; Fri, 26 Dec 2025 03:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2mm-0008TX-7w
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 03:02:57 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2mg-0005DY-Sk
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 03:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766736171; x=1798272171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yv9n9nBxZOXkuulFbpph1Y2JDKGxurFmxcngXr6yCf0=;
 b=c0VCKhwzM+ItrlpWBs6+Ie/hbba4nIoxQQcIguaykFVEdWvu7B5zirKg
 0Xt8HA1S9rm9WXYfZKrfbloP4kipFobkT57kQwHZobzC7JVm0bdqrfOQq
 DlAos0EVYXoiPyie9ubWOP7vkVjw5p1dINVlPoE4PSWz7L14rxSlUggfE
 fRl/xTg+MMO5tf3HpZ5+xZ39f4BOpDaWqdvuP6Fs+/8154COnrd08PFRq
 pnkLDgZGfXDk9fRMrKPuPZL6kOmeW9um2bwEPmx53CbmoHJ+aOKORI6ma
 A4QC4oScmS533ekYMGHXv0Mt4XKm/dv4Ad7Fe14DxvBYqSQ4DXTtrCXb/ A==;
X-CSE-ConnectionGUID: 9v/VUUh8RCuydcpqFn/xaA==
X-CSE-MsgGUID: 2ohJpW1+Q4uS/+24P3/nSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="68392839"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="68392839"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2025 00:02:51 -0800
X-CSE-ConnectionGUID: +jzyKitFThCCGd90qjDApA==
X-CSE-MsgGUID: 4m6Jl5FCTvKg7spKKUmZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="204846813"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2025 00:02:46 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 3/4] vfio/listener: Bypass readonly region for dirty
 tracking
Date: Fri, 26 Dec 2025 03:02:25 -0500
Message-ID: <20251226080227.1167993-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251226080227.1167993-1-zhenzhong.duan@intel.com>
References: <20251226080227.1167993-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When doing dirty tracking or calculating dirty tracking range, readonly
regions can be bypassed, because corresponding DMA mappings are readonly
and never become dirty.

This can optimize dirty tracking a bit for passthrough device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/listener.c   | 48 ++++++++++++++++++++++++++++++++++----------
 hw/vfio/trace-events |  1 +
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 35675e0ed7..ee3ed52428 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -76,8 +76,13 @@ static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
     return true;
 }
 
-static bool vfio_listener_skipped_section(MemoryRegionSection *section)
+static bool vfio_listener_skipped_section(MemoryRegionSection *section,
+                                          bool bypass_ro)
 {
+    if (bypass_ro && section->readonly) {
+        return true;
+    }
+
     return (!memory_region_is_ram(section->mr) &&
             !memory_region_is_iommu(section->mr)) ||
            memory_region_is_protected(section->mr) ||
@@ -368,9 +373,9 @@ static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
 }
 
 static bool vfio_listener_valid_section(MemoryRegionSection *section,
-                                        const char *name)
+                                        bool bypass_ro, const char *name)
 {
-    if (vfio_listener_skipped_section(section)) {
+    if (vfio_listener_skipped_section(section, bypass_ro)) {
         trace_vfio_listener_region_skip(name,
                 section->offset_within_address_space,
                 section->offset_within_address_space +
@@ -497,7 +502,7 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
     int ret;
     Error *err = NULL;
 
-    if (!vfio_listener_valid_section(section, "region_add")) {
+    if (!vfio_listener_valid_section(section, false, "region_add")) {
         return;
     }
 
@@ -663,7 +668,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     int ret;
     bool try_unmap = true;
 
-    if (!vfio_listener_valid_section(section, "region_del")) {
+    if (!vfio_listener_valid_section(section, false, "region_del")) {
         return;
     }
 
@@ -722,9 +727,10 @@ static void vfio_listener_region_del(MemoryListener *listener,
         }
 
         /*
-         * Fake an IOTLB entry for identity mapping which is needed by dirty
-         * tracking when switch out of PT domain. In fact, in unmap_bitmap,
-         * only translated_addr field is used to set dirty bitmap.
+         * Fake an IOTLB entry for writable identity mapping which is needed
+         * by dirty tracking when switch out of PT domain. In fact, in
+         * unmap_bitmap, only translated_addr field is used to set dirty
+         * bitmap.
          *
          * Note: When switch into PT domain from DMA domain, the whole IOMMU
          * MR is deleted without iotlb, before that happen, we depend on
@@ -733,7 +739,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
          * it is triggered during switching to block domain because vtd does
          * not support direct switching from DMA to PT domain.
          */
-        if (global_dirty_tracking && memory_region_is_ram(section->mr)) {
+        if (global_dirty_tracking && memory_region_is_ram(section->mr) &&
+            !section->readonly) {
             entry.iova = iova;
             entry.translated_addr = iova;
             iotlb = &entry;
@@ -841,7 +848,8 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
         container_of(listener, VFIODirtyRangesListener, listener);
     hwaddr iova, end;
 
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
+    /* Bypass readonly section as it never becomes dirty */
+    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
         !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
@@ -1100,6 +1108,19 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if (!mr) {
         goto out_unlock;
     }
+
+    /*
+     * The mapping is readonly when either it's a readonly mapping in guest
+     * or mapped target is readonly, bypass it for dirty tracking as it
+     * never becomes dirty.
+     */
+    if (!(iotlb->perm & IOMMU_WO) || mr->readonly) {
+        trace_vfio_iommu_map_dirty_notify_skip_ro(iova,
+                                                  iova + iotlb->addr_mask);
+        rcu_read_unlock();
+        return;
+    }
+
     translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
@@ -1235,7 +1256,12 @@ static void vfio_listener_log_sync(MemoryListener *listener,
     int ret;
     Error *local_err = NULL;
 
-    if (vfio_listener_skipped_section(section)) {
+    /*
+     * Bypass readonly section as it never becomes dirty, iommu memory section
+     * is RW and never bypassed. The readonly mappings in iommu MR are bypassed
+     * in vfio_iommu_map_dirty_notify().
+     */
+    if (vfio_listener_skipped_section(section, true)) {
         return;
     }
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 3c62bab764..180e3d526b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -103,6 +103,7 @@ vfio_listener_region_del(uint64_t start, uint64_t end) "region_del 0x%"PRIx64" -
 vfio_device_dirty_tracking_update(uint64_t start, uint64_t end, uint64_t min, uint64_t max) "section 0x%"PRIx64" - 0x%"PRIx64" -> update [0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_device_dirty_tracking_start(int nr_ranges, uint64_t min32, uint64_t max32, uint64_t min64, uint64_t max64, uint64_t minpci, uint64_t maxpci) "nr_ranges %d 32:[0x%"PRIx64" - 0x%"PRIx64"], 64:[0x%"PRIx64" - 0x%"PRIx64"], pci64:[0x%"PRIx64" - 0x%"PRIx64"]"
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
+vfio_iommu_map_dirty_notify_skip_ro(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
 
 # container.c
 vfio_container_query_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t backend_flag, uint64_t bitmap_size, uint64_t translated_addr, uint64_t dirty_pages) "iova=0x%"PRIx64" size=0x%"PRIx64" backend_flag=0x%"PRIx64" bitmap_size=0x%"PRIx64" gpa=0x%"PRIx64" dirty_pages=%"PRIu64
-- 
2.47.1


