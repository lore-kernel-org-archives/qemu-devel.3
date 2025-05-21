Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A2EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhUA-0005wF-ST; Wed, 21 May 2025 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTj-0005Vo-4R
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:22 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTg-0006RC-27
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826356; x=1779362356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KLjRZ+Hv72Y3pA0KOcUTZCjBQvdG45vZ8JtjLhnvJ+A=;
 b=SL3G64zuqtyDxtF7QWYY9hhSmYK+HEQAAbduTbVhSUFCMyS0WK9+pcEf
 PXr8bc+Er8X2uA6to/mHC2HwkYY5VV4kmIX4GZMamIAvI1RTMoDsMQEEu
 eroGUuOg8Rl+khNErHs4lr3MArZdMn9FpXM7AYk/mEmi51Eb9EQ6doWzw
 6KaHhQjr2BWMtK+gFd5DbnV0mpXl6XV4KEWzRBWyi+/GYcuwoIqNx7Num
 5nuT/jjYAsNBJ8r22H2EcEcVkhNLnzwoBBoikIUaaOBl6NVj8VhSL7Udj
 6WkPq0Rs9bzaGIgljdN4gXzasx3tkootpWfr0YeZJNtzU6oosYHXL/9Nf g==;
X-CSE-ConnectionGUID: B+cjEv68RF+NB+I0c1gecw==
X-CSE-MsgGUID: JFRHimOYRqawviazBIrk6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894991"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894991"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:15 -0700
X-CSE-ConnectionGUID: xYBNWGo1SZOU1uNKeJCF7Q==
X-CSE-MsgGUID: 5oi/zXR/SDCKo/LYSEVakw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158336"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv3 08/21] intel_iommu: Optimize context entry cache
 utilization
Date: Wed, 21 May 2025 19:14:38 +0800
Message-Id: <20250521111452.3316354-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

There are many call sites referencing context entry by calling
vtd_dev_to_context_entry() which will traverse the DMAR table.

In most cases we can use cached context entry in vtd_as->context_cache_entry
except when its entry is stale. Currently only global and domain context
invalidation stale it.

So introduce a helper function vtd_as_to_context_entry() to fetch from cache
before trying with vtd_dev_to_context_entry().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f0b1f90eff..a2f3250724 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1597,6 +1597,22 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
     return 0;
 }
 
+static int vtd_as_to_context_entry(VTDAddressSpace *vtd_as, VTDContextEntry *ce)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    uint8_t bus_num = pci_bus_num(vtd_as->bus);
+    uint8_t devfn = vtd_as->devfn;
+    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
+
+    /* Try to fetch context-entry from cache first */
+    if (cc_entry->context_cache_gen == s->context_cache_gen) {
+        *ce = cc_entry->context_entry;
+        return 0;
+    } else {
+        return vtd_dev_to_context_entry(s, bus_num, devfn, ce);
+    }
+}
+
 static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
                                      void *private)
 {
@@ -1649,9 +1665,7 @@ static int vtd_address_space_sync(VTDAddressSpace *vtd_as)
         return 0;
     }
 
-    ret = vtd_dev_to_context_entry(vtd_as->iommu_state,
-                                   pci_bus_num(vtd_as->bus),
-                                   vtd_as->devfn, &ce);
+    ret = vtd_as_to_context_entry(vtd_as, &ce);
     if (ret) {
         if (ret == -VTD_FR_CONTEXT_ENTRY_P) {
             /*
@@ -1710,8 +1724,7 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
     assert(as);
 
     s = as->iommu_state;
-    if (vtd_dev_to_context_entry(s, pci_bus_num(as->bus), as->devfn,
-                                 &ce)) {
+    if (vtd_as_to_context_entry(as, &ce)) {
         /*
          * Possibly failed to parse the context entry for some reason
          * (e.g., during init, or any guest configuration errors on
@@ -2435,8 +2448,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
+        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
             vtd_address_space_sync(vtd_as);
         }
@@ -2458,8 +2470,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
-        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                       vtd_as->devfn, &ce);
+        ret = vtd_as_to_context_entry(vtd_as, &ce);
         if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
             uint32_t rid2pasid = PCI_NO_PASID;
 
@@ -2966,8 +2977,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
+        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
             uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
 
@@ -4146,7 +4156,7 @@ static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
     assert(vtd_as->pasid != PCI_NO_PASID);
 
     /* Try out best to fetch FPD, we can't do anything more */
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
+    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
         is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
         if (!is_fpd_set && s->root_scalable) {
             vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
@@ -4506,7 +4516,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     /* replay is protected by BQL, page walk will re-setup it safely */
     iova_tree_remove(vtd_as->iova_tree, map);
 
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
+    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
         trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
                                   "legacy mode",
                                   bus_n, PCI_SLOT(vtd_as->devfn),
-- 
2.34.1


