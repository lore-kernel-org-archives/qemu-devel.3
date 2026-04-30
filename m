Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B0AFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbX-0005ak-Cs; Thu, 30 Apr 2026 03:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILay-00059u-Nf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:03 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILaw-0008OM-Mp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533238; x=1809069238;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nciqrJEDnL7LE44597jZpQmfa0vZJA1BvaEkRrNFzf4=;
 b=NyXEqB7ljixtquka4Wb+SEXbGMQMG9Z3PoR++btLaZzy0koX+vFHoMEA
 ryGcXX5bqGx9dQHds4mAR8AUwkmojWNSVxucIM3CMhg6zZ35C405aKy6X
 4op1TZRKuAfFF59elTTK2WG1mDMUvhA055gZSD4893gqQ9jEniFyMm7Mu
 xxjxtkkKUI6zM9kXxBVsTMeUabjQY4Q1wJks28EExCruEc8ebjKgX59zd
 0AFRerOva3yS1A7mO6W9Z9iPGdXJXcAvtzyRDWlLhNNn15HkH2m48S9mb
 iIKn4F5Uv23ZLWhaqJ0+Ij7TTJXfhxC7VRD4EsPu1q0Y2Aw3nBIDAtAEx Q==;
X-CSE-ConnectionGUID: fjhF0UFySnCF89Wq0foKXA==
X-CSE-MsgGUID: /u8dQdzFSduPU5DcJnQTPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051622"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051622"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:57 -0700
X-CSE-ConnectionGUID: yFTsqa4XS7O2G/t7WVvkPw==
X-CSE-MsgGUID: 6Qkxt9EOTDSKmt7fnZOXhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771526"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:13:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 07/15] intel_iommu: Simplify PASID matching logic in
 invalidation handlers
Date: Thu, 30 Apr 2026 03:13:03 -0400
Message-ID: <20260430071315.354333-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor PASID matching in IOTLB/PIOTLB invalidation handlers by
introducing a helper function to convert VT-d PASID to PCI PASID,
eliminating complex conditions.

Suggested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 132 +++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 52 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6715cc4383..74642d8123 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -92,6 +92,34 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
     }
 }
 
+/*
+ * Converts VT-d PASID to PCI PASID representation
+ *
+ * This function handles the semantic difference between how Intel VT-d IOMMU
+ * and the PCI subsystem represent "no PASID" scenarios:
+ *
+ * Requests-without-PASID:
+ *   - PCI subsystem: Uses PCI_NO_PASID (-1) to indicate no PASID present
+ *   - VT-d IOMMU:    Uses PASID_0 (0) to index the PASID table for translation
+ *
+ * Requests-with-PASID:
+ *   - Both subsystems use identical PASID values (1-0xFFFFF)
+ *
+ * Since PCI PASID values are cached in vtd_as->pasid, this conversion is
+ * required when mapping from VT-d PASID space back to the corresponding
+ * vtd_as (address space) structure.
+ *
+ * @pasid: VT-d PASID value to convert
+ * @return: Corresponding PCI PASID value
+ */
+static uint32_t vtd_pasid_to_pci_pasid(uint32_t pasid)
+{
+    if (pasid == PASID_0) {
+        pasid = PCI_NO_PASID;
+    }
+    return pasid;
+}
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -2487,9 +2515,10 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
 }
 
 /*
- * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
+ * There is no pasid field in iotlb invalidation descriptor, so PASID_0
  * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
- * descriptor is passed which should not be PCI_NO_PASID.
+ * descriptor is passed. In both cases, pasid is converted to PCI pasid
+ * before checking with vtd_as->pasid.
  */
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
                                              uint16_t domain_id, hwaddr addr,
@@ -2500,51 +2529,45 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     int ret;
     hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
+    pasid = vtd_pasid_to_pci_pasid(pasid);
+
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
-        if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+        if (ret || vtd_as->pasid != pasid ||
+            domain_id != vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            continue;
+        }
+
+        if (vtd_as_has_map_notifier(vtd_as)) {
             /*
-             * In legacy mode, vtd_as->pasid == pasid is always true.
-             * In scalable mode, for vtd address space backing a PCI
-             * device without pasid, needs to compare pasid with
-             * PASID_0 of this device.
+             * When first stage translation is off, as long as we have MAP
+             * notifications registered in any of our IOMMU notifiers,
+             * we need to sync the shadow page table. Otherwise VFIO
+             * device attaches to nested page table instead of shadow
+             * page table, so no need to sync.
              */
-            if (!(vtd_as->pasid == pasid ||
-                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
-                continue;
-            }
-
-            if (vtd_as_has_map_notifier(vtd_as)) {
-                /*
-                 * When first stage translation is off, as long as we have MAP
-                 * notifications registered in any of our IOMMU notifiers,
-                 * we need to sync the shadow page table. Otherwise VFIO
-                 * device attaches to nested page table instead of shadow
-                 * page table, so no need to sync.
-                 */
-                if (!s->fsts || !s->root_scalable) {
-                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
-                }
-            } else {
-                /*
-                 * For UNMAP-only notifiers, we don't need to walk the
-                 * page tables.  We just deliver the PSI down to
-                 * invalidate caches.
-                 */
-                const IOMMUTLBEvent event = {
-                    .type = IOMMU_NOTIFIER_UNMAP,
-                    .entry = {
-                        .target_as = &address_space_memory,
-                        .iova = addr,
-                        .translated_addr = 0,
-                        .addr_mask = size - 1,
-                        .perm = IOMMU_NONE,
-                        .pasid = vtd_as->pasid,
-                    },
-                };
-                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
+            if (!s->fsts || !s->root_scalable) {
+                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
             }
+        } else {
+            /*
+             * For UNMAP-only notifiers, we don't need to walk the
+             * page tables.  We just deliver the PSI down to
+             * invalidate caches.
+             */
+            const IOMMUTLBEvent event = {
+                .type = IOMMU_NOTIFIER_UNMAP,
+                .entry = {
+                    .target_as = &address_space_memory,
+                    .iova = addr,
+                    .translated_addr = 0,
+                    .addr_mask = size - 1,
+                    .perm = IOMMU_NONE,
+                    .pasid = vtd_as->pasid,
+                },
+            };
+            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
         }
     }
 }
@@ -2563,7 +2586,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
     vtd_iommu_unlock(s);
-    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PCI_NO_PASID);
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PASID_0);
 }
 
 /* Flush IOTLB
@@ -3001,12 +3024,17 @@ static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
             (entry->pasid == info->pasid));
 }
 
+/*
+ * Piotlb invalidation supports pasid, pasid in its descriptor is passed and
+ * is converted to PCI pasid before checking with vtd_as->pasid.
+ */
 static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                                         uint16_t domain_id, uint32_t pasid)
 {
     VTDIOTLBPageInvInfo info;
     VTDAddressSpace *vtd_as;
     VTDContextEntry ce;
+    int ret;
 
     info.domain_id = domain_id;
     info.pasid = pasid;
@@ -3018,18 +3046,18 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                                      false);
     vtd_iommu_unlock(s);
 
+    pasid = vtd_pasid_to_pci_pasid(pasid);
+
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
-            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
-            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
-                vtd_as->pasid != pasid) {
-                continue;
-            }
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (ret || vtd_as->pasid != pasid ||
+            domain_id != vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            continue;
+        }
 
-            if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
-                vtd_address_space_sync(vtd_as);
-            }
+        if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
+            vtd_address_space_sync(vtd_as);
         }
     }
 }
-- 
2.47.3


