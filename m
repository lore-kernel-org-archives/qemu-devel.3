Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E119CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvix-0005og-JY; Mon, 17 Nov 2025 04:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKviE-000592-9T
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:40:02 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKviC-0006Kp-7z
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372392; x=1794908392;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=upukl2JcnyzmPxfGaIBFEQ3nzBlZZ2Dg6jwwVjvrLDI=;
 b=Fd/tHJvxHEJexlyaulCX9GzXqEdcpVQKfKTSYu677i9yyN5ZfI22WbCR
 msBQHn4tAS/y5WPFYyDyLo87654KYbuWZRaMq9YPT93r6t+oqiqTjLCA5
 LkqGh0hIMSYuKjKZreG1QPBa3x0NhfKkKzxmoS9sKpBhR0VZIIqJFEB+T
 QBJvHxVIdBn3LmtChdayuKtu4ieIK8zzAHmtQIiaAdBetBABpp+sSWlik
 zzk8uNZ1NaaqFaXoIACtxPLtM8oukUTIVYjHIoRbKjN5cvdf+CbxK2MXh
 fVeEu6M2VZMmwcFQiKDjdAwfGttqrviSXgo+RgFZAVsPn0bS/TrUw1Vhq g==;
X-CSE-ConnectionGUID: 626O7UpXREmIrulQag6big==
X-CSE-MsgGUID: e+L1ZlVlS4e/+/3Z58cn5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76046049"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76046049"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:40 -0800
X-CSE-ConnectionGUID: xrybInCiS3aowhHWly128g==
X-CSE-MsgGUID: nzTwrWrqShaa5dXIulXDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070965"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:36 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 17/23] vfio/listener: Bypass readonly region for dirty
 tracking
Date: Mon, 17 Nov 2025 04:37:20 -0500
Message-ID: <20251117093729.1121324-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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

When doing ditry tracking or calculating dirty tracking range, readonly
regions can be bypassed, because corresponding DMA mappings are readonly
and never become dirty.

This can optimize dirty tracking a bit for passthrough device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/listener.c   | 46 +++++++++++++++++++++++++++++++++-----------
 hw/vfio/trace-events |  1 +
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 3b48f6796c..ca2377d860 100644
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
 
@@ -722,11 +727,11 @@ static void vfio_listener_region_del(MemoryListener *listener,
         }
 
         /*
-         * Fake an IOTLB entry for identity mapping which is needed by dirty
-         * tracking. In fact, in unmap_bitmap, only translated_addr field is
-         * used to set dirty bitmap.
+         * Fake an IOTLB entry for writable identity mapping which is needed
+         * by dirty tracking. In fact, in unmap_bitmap, only translated_addr
+         * field is used to set dirty bitmap.
          */
-        if (!memory_region_is_iommu(section->mr)) {
+        if (!memory_region_is_iommu(section->mr) && !section->readonly) {
             entry.iova = iova;
             entry.translated_addr = iova;
             iotlb = &entry;
@@ -834,7 +839,8 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
         container_of(listener, VFIODirtyRangesListener, listener);
     hwaddr iova, end;
 
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
+    /* Bypass readonly section as it never becomes dirty */
+    if (!vfio_listener_valid_section(section, true, "tracking_update") ||
         !vfio_get_section_iova_range(dirty->bcontainer, section,
                                      &iova, &end, NULL)) {
         return;
@@ -1093,6 +1099,19 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
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
@@ -1228,7 +1247,12 @@ static void vfio_listener_log_sync(MemoryListener *listener,
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


