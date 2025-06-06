Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453E4C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTzy-0008Ef-6V; Fri, 06 Jun 2025 06:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTzw-0008ER-4a
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:28 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTzq-0007aM-5S
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204502; x=1780740502;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KLjRZ+Hv72Y3pA0KOcUTZCjBQvdG45vZ8JtjLhnvJ+A=;
 b=ZLdiiI2Kgs9Dh3W5435NT2HMdxQbBmdihN6Dabxod/pefHuS31X037v6
 YTECuJIM3N9IULhxvAZjCuIkD+6wilzeKQ/QFfomXJ0btI2GRzsW090vj
 YpuQpr3fLlD0SXAuZJiPIK++o8Js01z/qw11qDFo1EJtB7Qt0RFP0zecA
 O97r43qYxGxTzBDCYKAZ8rqe6MSsEc6fpxongu3tXpj8YZkN0y3ykplT4
 FpwKK0iZk69hzSyLqnLv6+CJMiFatjnCXvnW43b25XoJJfYP8mYYxIyH7
 36+MWdmNrfmMwaOpDdDg2SAXuXQYyxZwluW/F9/jJ1tfdg0rmGFyLUpU1 A==;
X-CSE-ConnectionGUID: HrRAgS6cRCqCwrayKT3rOw==
X-CSE-MsgGUID: X0Hsy2SnRMKytU2qbkOLJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747177"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747177"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:21 -0700
X-CSE-ConnectionGUID: bV7Zn0ehRZ+64ISxwJMPMA==
X-CSE-MsgGUID: QNeND/9fRJuuDdIxOwE12Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759051"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:16 -0700
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
Subject: [PATCH v1 02/15] intel_iommu: Optimize context entry cache utilization
Date: Fri,  6 Jun 2025 18:04:03 +0800
Message-Id: <20250606100416.346132-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


