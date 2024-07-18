Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E4FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMMy-0007zC-JG; Thu, 18 Jul 2024 04:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMu-0007rX-SG
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:05 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMr-0008CX-NZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290802; x=1752826802;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ohUKes0yuoPJ6iFWtix7+np5TGcKAynQB1MPniKkVio=;
 b=Smt7TVA9SEychRN92oo8rLDndEHJL8rtWt3lyva5AO0rtlllLwNCGrV2
 4bI+1YCar9AjFODwgwIMaLvZ6IbrZWhS4MuCod3hWFjrWaZp39III+nB7
 oyPDAO2EnAue/IyUYCwoPYozYa7tlsujckqkhkTFuVy5xfzqdCxsopSMX
 sgddk7gAkFxFGzJwcfjE2oICkqa3wfmF6q7tv2+d6yllwZMEcR6S93KuB
 E5rKYypXycsfrJhATRbgBuvvk7xhyDT3tr4BiGXPIPDZaGVz8OS7O7+Nd
 JF/WCWITrVOb71crVX5InKv5WpblGSb214hU6T3sjqLZRjqIUXZHw7yy/ Q==;
X-CSE-ConnectionGUID: 11hEY4K0TSGOhw1WOgs4FQ==
X-CSE-MsgGUID: H/R3tLf/RPaGa5tWUN6ruA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996290"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996290"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:20:00 -0700
X-CSE-ConnectionGUID: cDKYJiqrR2yGuKQ75Ww1cA==
X-CSE-MsgGUID: OPj73iXVTXy9Pd/7pwraag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717357"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Date: Thu, 18 Jul 2024 16:16:28 +0800
Message-Id: <20240718081636.879544-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
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

According to spec, Page-Selective-within-Domain Invalidation (11b):

1. IOTLB entries caching second-stage mappings (PGTT=010b) or pass-through
(PGTT=100b) mappings associated with the specified domain-id and the
input-address range are invalidated.
2. IOTLB entries caching first-stage (PGTT=001b) or nested (PGTT=011b)
mapping associated with specified domain-id are invalidated.

So per spec definition the Page-Selective-within-Domain Invalidation
needs to flush first stage and nested cached IOTLB enties as well.

We don't support nested yet and pass-through mapping is never cached,
so what in iotlb cache are only first-stage and second-stage mappings.

Add a tag pgtt in VTDIOTLBEntry to mark PGTT type of the mapping and
invalidate entries based on PGTT type.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index fe9057c50d..b843d069cc 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -155,6 +155,7 @@ struct VTDIOTLBEntry {
     uint64_t pte;
     uint64_t mask;
     uint8_t access_flags;
+    uint8_t pgtt;
 };
 
 /* VT-d Source-ID Qualifier types */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 210df32f01..8d47e5ba78 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -305,9 +305,21 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
     VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
     uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
     uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
-    return (entry->domain_id == info->domain_id) &&
-            (((entry->gfn & info->mask) == gfn) ||
-             (entry->gfn == gfn_tlb));
+
+    if (entry->domain_id != info->domain_id) {
+        return false;
+    }
+
+    /*
+     * According to spec, IOTLB entries caching first-stage (PGTT=001b) or
+     * nested (PGTT=011b) mapping associated with specified domain-id are
+     * invalidated. Nested isn't supported yet, so only need to check 001b.
+     */
+    if (entry->pgtt == VTD_SM_PASID_ENTRY_FLT) {
+        return true;
+    }
+
+    return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
 }
 
 /* Reset all the gen of VTDAddressSpace to zero and set the gen of
@@ -382,7 +394,7 @@ out:
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
                              uint16_t domain_id, hwaddr addr, uint64_t pte,
                              uint8_t access_flags, uint32_t level,
-                             uint32_t pasid)
+                             uint32_t pasid, uint8_t pgtt)
 {
     VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
     struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
@@ -400,6 +412,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     entry->access_flags = access_flags;
     entry->mask = vtd_pt_level_page_mask(level);
     entry->pasid = pasid;
+    entry->pgtt = pgtt;
 
     key->gfn = gfn;
     key->sid = source_id;
@@ -2071,7 +2084,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
-    uint8_t access_flags;
+    uint8_t access_flags, pgtt;
     bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
 
@@ -2179,9 +2192,11 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (s->scalable_modern && s->root_scalable) {
         ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
+        pgtt = VTD_SM_PASID_ENTRY_FLT;
     } else {
         ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
+        pgtt = VTD_SM_PASID_ENTRY_SLT;
     }
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
@@ -2192,7 +2207,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     page_mask = vtd_pt_level_page_mask(level);
     access_flags = IOMMU_ACCESS_FLAG(reads, writes);
     vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
-                     addr, pte, access_flags, level, pasid);
+                     addr, pte, access_flags, level, pasid, pgtt);
 out:
     vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
-- 
2.34.1


