Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D5C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuT-0003AH-Rq; Mon, 29 Apr 2024 02:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuQ-0002wf-3D
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:42 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuO-0007sZ-2w
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373680; x=1745909680;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B7nXRh7ZojaXtdhNyRfMhv/+nlUrwKMI6CTd3vTaKw0=;
 b=kiUuVVs/if+/kJIuwmm4hI4a3YYfRxBqge7CH3uM8IgoH6z4pvkWf3pf
 snqvXfvX/s6G65PiA3ys5boshlw5H9LSPZLaa8Uc+RMfLo49wiFABmz3K
 poXE+hO/s8RnryqZLcEuNa/OlgDwf3X0P4uhcojNWbpyzFfVljzntgMA+
 VL2ixJa0F/F/qMOkJGR3rXNhArvearbZeEsfCdpLegkpfvls28jw3vQF3
 hW/e2muqwLk2CoL5gOEVAMVAamqi0f9J4e+2eo68JXlz5V0JPPWlIIEk1
 WmLPqEe0wPnG4rPUVfxKwEibaVnqU2bbDcOueTwFJkdH+V12U7GC3nug4 g==;
X-CSE-ConnectionGUID: ovzbF8GbTRq0j8MZtTDJzA==
X-CSE-MsgGUID: AJrT3WN8QNSfItH9M5Wtqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560765"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560765"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:29 -0700
X-CSE-ConnectionGUID: Qmkoz7MDTSCD1IbkcMk3cQ==
X-CSE-MsgGUID: tWbG6iWHRT6NLUrAX9kk5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488389"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:25 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 17/19] intel_iommu: Extract out vtd_cap_init() to
 initialize cap/ecap
Date: Mon, 29 Apr 2024 14:50:44 +0800
Message-Id: <20240429065046.3688701-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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

Extract cap/ecap initialization in vtd_cap_init() to make code
cleaner.

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 93 ++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8e59674e..519063c8f8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3934,30 +3934,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     return;
 }
 
-/* Do the initialization. It will also be called when reset, so pay
- * attention when adding new initialization stuff.
- */
-static void vtd_init(IntelIOMMUState *s)
+static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    memset(s->csr, 0, DMAR_REG_SIZE);
-    memset(s->wmask, 0, DMAR_REG_SIZE);
-    memset(s->w1cmask, 0, DMAR_REG_SIZE);
-    memset(s->womask, 0, DMAR_REG_SIZE);
-
-    s->root = 0;
-    s->root_scalable = false;
-    s->dmar_enabled = false;
-    s->intr_enabled = false;
-    s->iq_head = 0;
-    s->iq_tail = 0;
-    s->iq = 0;
-    s->iq_size = 0;
-    s->qi_enabled = false;
-    s->iq_last_desc_type = VTD_INV_DESC_NONE;
-    s->iq_dw = false;
-    s->next_frcd_reg = 0;
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
              VTD_CAP_MGAW(s->aw_bits);
@@ -3974,27 +3954,6 @@ static void vtd_init(IntelIOMMUState *s)
     }
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
 
-    /*
-     * Rsvd field masks for spte
-     */
-    vtd_spte_rsvd[0] = ~0ULL;
-    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
-    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
-
-    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                         x86_iommu->dt_supported);
-    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                         x86_iommu->dt_supported);
-
-    if (s->scalable_mode || s->snoop_control) {
-        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
-        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
-        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
-    }
-
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
         if (s->intr_eim == ON_OFF_AUTO_ON) {
@@ -4027,6 +3986,56 @@ static void vtd_init(IntelIOMMUState *s)
     if (s->pasid) {
         s->ecap |= VTD_ECAP_PASID;
     }
+}
+
+/*
+ * Do the initialization. It will also be called when reset, so pay
+ * attention when adding new initialization stuff.
+ */
+static void vtd_init(IntelIOMMUState *s)
+{
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
+    memset(s->csr, 0, DMAR_REG_SIZE);
+    memset(s->wmask, 0, DMAR_REG_SIZE);
+    memset(s->w1cmask, 0, DMAR_REG_SIZE);
+    memset(s->womask, 0, DMAR_REG_SIZE);
+
+    s->root = 0;
+    s->root_scalable = false;
+    s->dmar_enabled = false;
+    s->intr_enabled = false;
+    s->iq_head = 0;
+    s->iq_tail = 0;
+    s->iq = 0;
+    s->iq_size = 0;
+    s->qi_enabled = false;
+    s->iq_last_desc_type = VTD_INV_DESC_NONE;
+    s->iq_dw = false;
+    s->next_frcd_reg = 0;
+
+    vtd_cap_init(s);
+
+    /*
+     * Rsvd field masks for spte
+     */
+    vtd_spte_rsvd[0] = ~0ULL;
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
+                                                  x86_iommu->dt_supported);
+    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
+                                                    x86_iommu->dt_supported);
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
+                                                    x86_iommu->dt_supported);
+
+    if (s->scalable_mode || s->snoop_control) {
+        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
+        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
+        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
+    }
 
     vtd_reset_caches(s);
 
-- 
2.34.1


