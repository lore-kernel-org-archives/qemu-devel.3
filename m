Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E98D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfarI-0003pG-Mm; Tue, 13 Jan 2026 04:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfar0-0003Cm-Qh
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqz-0003UA-0M
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vjfMWroBwbRuDbaxuV3pc5DM8ekaFeG0lGHDNirnPw=;
 b=Aqg7snEIJnnhhdeXODRYUfJILmnFV9pXT7owtkU71g52E0pgbsturTz3da/aTjQkLccYWO
 uvwKs7nLVObNt4erljRJ85J/hkwUdbzw6MqyULeveWoX/dhj9p077x0x0zBbXIKlPl+tCj
 9FVQ29li9j9r3c5DIxT4rbeDs9hSQXQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-MDk5YS8sMFiC-QDE-tk12Q-1; Tue,
 13 Jan 2026 04:38:18 -0500
X-MC-Unique: MDk5YS8sMFiC-QDE-tk12Q-1
X-Mimecast-MFC-AGG-ID: MDk5YS8sMFiC-QDE-tk12Q_1768297097
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AE1C19560B2; Tue, 13 Jan 2026 09:38:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA14230001A8; Tue, 13 Jan 2026 09:38:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/41] vfio/listener: Bypass readonly region for dirty tracking
Date: Tue, 13 Jan 2026 10:36:29 +0100
Message-ID: <20260113093637.1549214-34-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When doing dirty tracking or calculating dirty tracking range, readonly
regions can be bypassed, because corresponding DMA mappings are readonly
and never become dirty.

This can optimize dirty tracking a bit for passthrough device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20260106062808.316574-4-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c   | 48 ++++++++++++++++++++++++++++++++++----------
 hw/vfio/trace-events |  1 +
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 813621f22f8b5ec284388f9c5f719525ec5f282c..f193468dee30354ea8c07e9bf2d89b4da42ab78a 100644
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
index 3c62bab7647a7d027038444fa4b164182d3feb2b..180e3d526b80bd43d18bbfb9332833df4fbeb720 100644
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
2.52.0


