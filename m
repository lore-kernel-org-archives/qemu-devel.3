Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E800AC021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPz-0005XT-Nu; Wed, 19 Feb 2025 03:26:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPy-0005Wz-Ep
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:54 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPw-0004bS-DG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953613; x=1771489613;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZSRjZEL5xQevlQwiqc5TcPp+0Tek1XsaolTTkz/enMw=;
 b=JODBjT+AEcSYZRxtiVnPo9r5j32QBDdTeN0vWtzHdJJSh1DWPY4+gn7k
 Q1j5Y2XwmnYlgymt80cIkzinO6sCpv8QnOVN13bpWtYq2LCvTwkd59yjx
 be2hnKCiAFN/v9RbFrwGJr+LfsfnC+mp/lB3CTPPP5bp48FVKXE6TFQ91
 rkIFJnm7xA+7wf3gaTleQgCkd3LN1rrMCIc23wblzkTEJFn1nigGzwLPJ
 8eTl8xK8m94b+GgNJshdi0WrWbsyH0YCuvlMJqBnSTWptD9sR2QNxWI6z
 tun+68htykVMvSSaToQ7yA/ZkIp/xLSay4EEflThjbOYk+sW1fT4kEcrS A==;
X-CSE-ConnectionGUID: v7ejwVxdRoOpJTxcUtJnOw==
X-CSE-MsgGUID: n3CuJ7WrSZK51OoWCzCevQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544166"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544166"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:52 -0800
X-CSE-ConnectionGUID: n1WCmcaPSQq1TYUhTDn36Q==
X-CSE-MsgGUID: wES+8Q3zTKWRmaBuTJ/rYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851111"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:46 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 10/20] intel_iommu: Optimize context entry cache
 utilization
Date: Wed, 19 Feb 2025 16:22:18 +0800
Message-Id: <20250219082228.3303163-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
vtd_as_to_context_entry() which will traverse the DMAR table.

In most cases we can use cached context entry in vtd_as->context_cache_entry
except it's stale. Currently only global and domain context invalidation
stales it.

So introduce a helper function vtd_as_to_context_entry() to fetch from cache
before trying with vtd_dev_to_context_entry().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df5fb30bc8..7709f55be5 100644
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
@@ -2443,8 +2456,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
+        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
             vtd_address_space_sync(vtd_as);
         }
@@ -2466,8 +2478,7 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
-        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                       vtd_as->devfn, &ce);
+        ret = vtd_as_to_context_entry(vtd_as, &ce);
         if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
             uint32_t rid2pasid = PCI_NO_PASID;
 
@@ -2974,8 +2985,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
-        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
-                                      vtd_as->devfn, &ce) &&
+        if (!vtd_as_to_context_entry(vtd_as, &ce) &&
             domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
             uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
 
@@ -4154,7 +4164,7 @@ static void vtd_report_ir_illegal_access(VTDAddressSpace *vtd_as,
     assert(vtd_as->pasid != PCI_NO_PASID);
 
     /* Try out best to fetch FPD, we can't do anything more */
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
+    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
         is_fpd_set = ce.lo & VTD_CONTEXT_ENTRY_FPD;
         if (!is_fpd_set && s->root_scalable) {
             vtd_ce_get_pasid_fpd(s, &ce, &is_fpd_set, vtd_as->pasid);
@@ -4491,7 +4501,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     /* replay is protected by BQL, page walk will re-setup it safely */
     iova_tree_remove(vtd_as->iova_tree, map);
 
-    if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
+    if (vtd_as_to_context_entry(vtd_as, &ce) == 0) {
         trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
                                   "legacy mode",
                                   bus_n, PCI_SLOT(vtd_as->devfn),
-- 
2.34.1


