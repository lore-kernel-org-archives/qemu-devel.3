Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE57EC3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hFg-0001NJ-5J; Mon, 07 Apr 2025 03:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFG-0001IA-Bt
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:14 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hFE-0005Qw-0R
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012212; x=1775548212;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jOVy7Ml6/2LDRm72chti/Lz4qTE3xrNmv1SgD04lXdk=;
 b=mDiswFZCBELKszv8x9TGWh/yM4EGoMTuSdH33NHFcHsqn2tdwCg5OI6i
 /L+3A6cLQa2/dzX634YW9V2DdqlpzJnVkVBQiVrHrncmcgCl1TQig6eYR
 vatKsMJglKc/JOpVhgHFVByXcGzKJN7MFHvUYEeD5++nsLCjesA5sYa51
 v5p1jTLNepri7a4ipT17qKPnaIqaOr/HqMhvINaQalowG6ck6EETgtYgc
 vC/FNYoAwJUOkpj8SZk7tr+Fkkg8bTW3y4Wez3Bi7Z0dw7zEYNWxlCaca
 ODKvvylNshKmeqdZl3bVSuLcO2WOdDNXU73SEtStikd/kaXeel5Osw9+f A==;
X-CSE-ConnectionGUID: cuZuq8USTZalFRmhIBPRRA==
X-CSE-MsgGUID: eRs5IpNpR9OO+BwMgnCvzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857549"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857549"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:11 -0700
X-CSE-ConnectionGUID: WKLDJ1FmTiejDRlLKWWZ3Q==
X-CSE-MsgGUID: hw6BqKrnQpe7BwXSvQbjGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405620"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:50:07 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 06/13] vfio: Add the support for PrivateSharedManager
 Interface
Date: Mon,  7 Apr 2025 15:49:26 +0800
Message-ID: <20250407074939.18657-7-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250407074939.18657-1-chenyi.qiang@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

Subsystems like VFIO previously disabled ram block discard and only
allowed coordinated discarding via RamDiscardManager. However,
guest_memfd in confidential VMs relies on discard operations for page
conversion between private and shared memory. This can lead to stale
IOMMU mapping issue when assigning a hardware device to a confidential
VM via shared memory. With the introduction of PrivateSharedManager
interface to manage private and shared states and being distinct from
RamDiscardManager, include PrivateSharedManager in coordinated RAM
discard and add related support in VFIO.

Currently, migration support for confidential VMs is not available, so
vfio_sync_dirty_bitmap() handling for PrivateSharedListener can be
ignored. The register/unregister of PrivateSharedListener is necessary
during vfio_listener_region_add/del(). The listener callbacks are
similar between RamDiscardListener and PrivateSharedListener, allowing
for extraction of common parts opportunisticlly.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
---
Changes in v4
    - Newly added.
---
 hw/vfio/common.c                      | 104 +++++++++++++++++++++++---
 hw/vfio/container-base.c              |   1 +
 include/hw/vfio/vfio-container-base.h |  10 +++
 3 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3172d877cc..48468a12c3 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -335,13 +335,9 @@ out:
     rcu_read_unlock();
 }
 
-static void vfio_ram_discard_notify_discard(StateChangeListener *scl,
-                                            MemoryRegionSection *section)
+static void vfio_state_change_notify_to_state_clear(VFIOContainerBase *bcontainer,
+                                                    MemoryRegionSection *section)
 {
-    RamDiscardListener *rdl = container_of(scl, RamDiscardListener, scl);
-    VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
-                                                listener);
-    VFIOContainerBase *bcontainer = vrdl->bcontainer;
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
     int ret;
@@ -354,13 +350,28 @@ static void vfio_ram_discard_notify_discard(StateChangeListener *scl,
     }
 }
 
-static int vfio_ram_discard_notify_populate(StateChangeListener *scl,
+static void vfio_ram_discard_notify_discard(StateChangeListener *scl,
                                             MemoryRegionSection *section)
 {
     RamDiscardListener *rdl = container_of(scl, RamDiscardListener, scl);
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
-    VFIOContainerBase *bcontainer = vrdl->bcontainer;
+    vfio_state_change_notify_to_state_clear(vrdl->bcontainer, section);
+}
+
+static void vfio_private_shared_notify_to_private(StateChangeListener *scl,
+                                                  MemoryRegionSection *section)
+{
+    PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
+    VFIOPrivateSharedListener *vpsl = container_of(psl, VFIOPrivateSharedListener,
+                                                   listener);
+    vfio_state_change_notify_to_state_clear(vpsl->bcontainer, section);
+}
+
+static int vfio_state_change_notify_to_state_set(VFIOContainerBase *bcontainer,
+                                                 MemoryRegionSection *section,
+                                                 uint64_t granularity)
+{
     const hwaddr end = section->offset_within_region +
                        int128_get64(section->size);
     hwaddr start, next, iova;
@@ -372,7 +383,7 @@ static int vfio_ram_discard_notify_populate(StateChangeListener *scl,
      * unmap in minimum granularity later.
      */
     for (start = section->offset_within_region; start < end; start = next) {
-        next = ROUND_UP(start + 1, vrdl->granularity);
+        next = ROUND_UP(start + 1, granularity);
         next = MIN(next, end);
 
         iova = start - section->offset_within_region +
@@ -383,13 +394,33 @@ static int vfio_ram_discard_notify_populate(StateChangeListener *scl,
                                      vaddr, section->readonly);
         if (ret) {
             /* Rollback */
-            vfio_ram_discard_notify_discard(scl, section);
+            vfio_state_change_notify_to_state_clear(bcontainer, section);
             return ret;
         }
     }
     return 0;
 }
 
+static int vfio_ram_discard_notify_populate(StateChangeListener *scl,
+                                            MemoryRegionSection *section)
+{
+    RamDiscardListener *rdl = container_of(scl, RamDiscardListener, scl);
+    VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
+                                                listener);
+    return vfio_state_change_notify_to_state_set(vrdl->bcontainer, section,
+                                                 vrdl->granularity);
+}
+
+static int vfio_private_shared_notify_to_shared(StateChangeListener *scl,
+                                                MemoryRegionSection *section)
+{
+    PrivateSharedListener *psl = container_of(scl, PrivateSharedListener, scl);
+    VFIOPrivateSharedListener *vpsl = container_of(psl, VFIOPrivateSharedListener,
+                                                   listener);
+    return vfio_state_change_notify_to_state_set(vpsl->bcontainer, section,
+                                                 vpsl->granularity);
+}
+
 static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                MemoryRegionSection *section)
 {
@@ -466,6 +497,27 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
     }
 }
 
+static void vfio_register_private_shared_listener(VFIOContainerBase *bcontainer,
+                                                  MemoryRegionSection *section)
+{
+    GenericStateManager *gsm = memory_region_get_generic_state_manager(section->mr);
+    VFIOPrivateSharedListener *vpsl;
+    PrivateSharedListener *psl;
+
+    vpsl = g_new0(VFIOPrivateSharedListener, 1);
+    vpsl->bcontainer = bcontainer;
+    vpsl->mr = section->mr;
+    vpsl->offset_within_address_space = section->offset_within_address_space;
+    vpsl->granularity = generic_state_manager_get_min_granularity(gsm,
+                                                                  section->mr);
+
+    psl = &vpsl->listener;
+    private_shared_listener_init(psl, vfio_private_shared_notify_to_shared,
+                                 vfio_private_shared_notify_to_private);
+    generic_state_manager_register_listener(gsm, &psl->scl, section);
+    QLIST_INSERT_HEAD(&bcontainer->vpsl_list, vpsl, next);
+}
+
 static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
                                                  MemoryRegionSection *section)
 {
@@ -491,6 +543,31 @@ static void vfio_unregister_ram_discard_listener(VFIOContainerBase *bcontainer,
     g_free(vrdl);
 }
 
+static void vfio_unregister_private_shared_listener(VFIOContainerBase *bcontainer,
+                                                    MemoryRegionSection *section)
+{
+    GenericStateManager *gsm = memory_region_get_generic_state_manager(section->mr);
+    VFIOPrivateSharedListener *vpsl = NULL;
+    PrivateSharedListener *psl;
+
+    QLIST_FOREACH(vpsl, &bcontainer->vpsl_list, next) {
+        if (vpsl->mr == section->mr &&
+            vpsl->offset_within_address_space ==
+            section->offset_within_address_space) {
+            break;
+        }
+    }
+
+    if (!vpsl) {
+        hw_error("vfio: Trying to unregister missing RAM discard listener");
+    }
+
+    psl = &vpsl->listener;
+    generic_state_manager_unregister_listener(gsm, &psl->scl);
+    QLIST_REMOVE(vpsl, next);
+    g_free(vpsl);
+}
+
 static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
 {
     MemoryRegion *mr = section->mr;
@@ -644,6 +721,9 @@ static void vfio_listener_region_add(MemoryListener *listener,
     if (memory_region_has_ram_discard_manager(section->mr)) {
         vfio_register_ram_discard_listener(bcontainer, section);
         return;
+    } else if (memory_region_has_private_shared_manager(section->mr)) {
+        vfio_register_private_shared_listener(bcontainer, section);
+        return;
     }
 
     vaddr = memory_region_get_ram_ptr(section->mr) +
@@ -764,6 +844,10 @@ static void vfio_listener_region_del(MemoryListener *listener,
         vfio_unregister_ram_discard_listener(bcontainer, section);
         /* Unregistering will trigger an unmap. */
         try_unmap = false;
+    } else if (memory_region_has_private_shared_manager(section->mr)) {
+        vfio_unregister_private_shared_listener(bcontainer, section);
+        /* Unregistering will trigger an unmap. */
+        try_unmap = false;
     }
 
     if (try_unmap) {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 749a3fd29d..ff5df925c2 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -135,6 +135,7 @@ static void vfio_container_instance_init(Object *obj)
     bcontainer->iova_ranges = NULL;
     QLIST_INIT(&bcontainer->giommu_list);
     QLIST_INIT(&bcontainer->vrdl_list);
+    QLIST_INIT(&bcontainer->vpsl_list);
 }
 
 static const TypeInfo types[] = {
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab..8d7c0b1179 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -47,6 +47,7 @@ typedef struct VFIOContainerBase {
     bool dirty_pages_started; /* Protected by BQL */
     QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
+    QLIST_HEAD(, VFIOPrivateSharedListener) vpsl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
@@ -71,6 +72,15 @@ typedef struct VFIORamDiscardListener {
     QLIST_ENTRY(VFIORamDiscardListener) next;
 } VFIORamDiscardListener;
 
+typedef struct VFIOPrivateSharedListener {
+    VFIOContainerBase *bcontainer;
+    MemoryRegion *mr;
+    hwaddr offset_within_address_space;
+    uint64_t granularity;
+    PrivateSharedListener listener;
+    QLIST_ENTRY(VFIOPrivateSharedListener) next;
+} VFIOPrivateSharedListener;
+
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly);
-- 
2.43.5


