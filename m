Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD260D2E9C3
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPyB-0007yp-IX; Mon, 11 Nov 2024 03:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxJ-0006NU-Uz
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:29 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPxI-0003ZP-5B
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314368; x=1762850368;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SqXN9CljVR1L1MNMF8CBqfciL2WzDNfReTzozF5HPSY=;
 b=CzPM6bCTOaTDk2OBenAU4Y3B86xxF9siCPxfX4LAalVIjVezaUGP/xm/
 KbonkQTfYJOzjx+IdNY7/AEZIgFp8r897it574XkdkL0xKRUOIjM397C0
 7+1LTlsSzKaVMW3hZzh6NtWmxnjA60R29E/JK2zp2tGyRpC5wuFCFezC6
 VqrnK10rggxzaBteoDCIYEcndcx7FY8V+VCKYXhFIOnKkXtfR5rB9WVV4
 k7PiGk/hHy8C9o0rG62xe4C1fHaBL3HAqu8L/jGMZBoE6QioKyg+ULgiZ
 DhHQYKnheqn0+qjKuz/NvPvBcGSfq/ovL/iJk+UVzI/7KNqqC1vhOsHtp Q==;
X-CSE-ConnectionGUID: OGmiZHduR0qwtg1Yu1J0BA==
X-CSE-MsgGUID: 7bi0NrmxRy+xMnoPr00Mbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334591"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:27 -0800
X-CSE-ConnectionGUID: AMBWmLmzQwmu9fUcHj0tqw==
X-CSE-MsgGUID: zq1/rsezQ4qveqXU//TpHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608448"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:39:23 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Date: Mon, 11 Nov 2024 16:34:55 +0800
Message-Id: <20241111083457.2090664-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
related to scalable mode translation, thus there are multiple combinations.

This vIOMMU implementation wants to simplify it with a new property "x-flts".
When enabled in scalable mode, first stage translation also known as scalable
modern mode is supported. When enabled in legacy mode, throw out error.

With scalable modern mode exposed to user, also accurate the pasid entry
check in vtd_pe_type_check().

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2c977aa7da..e8b211e8b0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
+#define VTD_ECAP_FLTS               (1ULL << 47)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
@@ -211,6 +212,7 @@
 #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
 #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
+#define VTD_CAP_FS1GP               (1ULL << 56)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 #define VTD_PASID_ID_SHIFT          20
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b921793c3a..a7a81aebee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -803,16 +803,18 @@ static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
 }
 
 /* Return true if check passed, otherwise false */
-static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
-                                     VTDPASIDEntry *pe)
+static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
 {
     switch (VTD_PE_GET_TYPE(pe)) {
-    case VTD_SM_PASID_ENTRY_SLT:
-        return true;
-    case VTD_SM_PASID_ENTRY_PT:
-        return x86_iommu->pt_supported;
     case VTD_SM_PASID_ENTRY_FLT:
+        return !!(s->ecap & VTD_ECAP_FLTS);
+    case VTD_SM_PASID_ENTRY_SLT:
+        return !!(s->ecap & VTD_ECAP_SLTS);
     case VTD_SM_PASID_ENTRY_NESTED:
+        /* Not support NESTED page table type yet */
+        return false;
+    case VTD_SM_PASID_ENTRY_PT:
+        return !!(s->ecap & VTD_ECAP_PT);
     default:
         /* Unknown type */
         return false;
@@ -861,7 +863,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     index = VTD_PASID_TABLE_INDEX(pasid);
     entry_size = VTD_PASID_ENTRY_SIZE;
@@ -875,7 +876,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     }
 
     /* Do translation type check */
-    if (!vtd_pe_type_check(x86_iommu, pe)) {
+    if (!vtd_pe_type_check(s, pe)) {
         return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
@@ -3827,6 +3828,7 @@ static Property vtd_properties[] = {
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, scalable_modern, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
@@ -4558,7 +4560,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->scalable_modern) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
+        s->cap |= VTD_CAP_FS1GP;
+    } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
 
@@ -4737,6 +4742,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (!s->scalable_mode && s->scalable_modern) {
+        error_setg(errp, "Legacy mode: not support x-flts=on");
+        return false;
+    }
+
     if (!s->scalable_modern && s->aw_bits != VTD_HOST_AW_39BIT &&
         s->aw_bits != VTD_HOST_AW_48BIT) {
         error_setg(errp, "%s mode: supported values for aw-bits are: %d, %d",
-- 
2.34.1


