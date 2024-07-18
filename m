Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F027AC3DA6C
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMMU-0006m5-Q4; Thu, 18 Jul 2024 04:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMT-0006h6-JP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMR-0008CX-Fm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290775; x=1752826775;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HGlgmPL0tpzaQnQi2F+oTSTTGoGfTxoXVwUJvqqqnZ0=;
 b=AADTiZl4AqfsUE74HXXvObMd4Kh/x6KEQpRci98PXZSmD6uD3llbbbXD
 lm/SJQ0RHC+N8svtjwH/eefpKg9HGqP0QbkAcppvX5D5meWmMV2P/3jsQ
 rnx0InOE3vMvktOSoUazBz2C0iS2FISUDyysgGCrWiZly8xkCM7lXkrAQ
 qFczK/4mnQPOA+Soh8CpebxUXlXs2pq46qDXsC2lmv37Ku7cYVUwTCf7u
 mraGadq6h0yndA46BoOG8WIsWxV8ITCWZHtKNPv3Oi/QH245E4ojyDEvi
 bnZQe1DbnzmNV1jK2h1V6fwTDPYrfWXrWh4h4a7R+Zh72OPfgmIW+OhGN w==;
X-CSE-ConnectionGUID: +ToJlRkQS4WueFSgBFc5mA==
X-CSE-MsgGUID: EBF13lZTRCiEdSkEYNwf8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996139"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:34 -0700
X-CSE-ConnectionGUID: EAgaSNRPRGG9mBOSi9b4lw==
X-CSE-MsgGUID: elt6DWCOT325f/JKCqyg/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717122"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:30 -0700
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
Subject: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for scalable
 modern mode
Date: Thu, 18 Jul 2024 16:16:22 +0800
Message-Id: <20240718081636.879544-4-zhenzhong.duan@intel.com>
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

Add an new element scalable_mode in IntelIOMMUState to mark scalable
modern mode, this element will be exposed as an intel_iommu property
finally.

For now, it's only a placehholder and used for cap/ecap initialization,
compatibility check and block host device passthrough until nesting
is supported.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 include/hw/i386/intel_iommu.h  |  1 +
 hw/i386/intel_iommu.c          | 34 +++++++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c0ca7b372f..4e0331caba 100644
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
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1eb05c29fc..788ed42477 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -262,6 +262,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    bool scalable_modern;           /* RO - is modern SM supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
     dma_addr_t root;                /* Current root table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1cff8b00ae..40cbd4a0f4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -755,16 +755,20 @@ static inline bool vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
 }
 
 /* Return true if check passed, otherwise false */
-static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
-                                     VTDPASIDEntry *pe)
+static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
 {
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
     switch (VTD_PE_GET_TYPE(pe)) {
+    case VTD_SM_PASID_ENTRY_FLT:
+        return s->scalable_modern;
     case VTD_SM_PASID_ENTRY_SLT:
-        return true;
+        return !s->scalable_modern;
+    case VTD_SM_PASID_ENTRY_NESTED:
+        /* Not support NESTED page table type yet */
+        return false;
     case VTD_SM_PASID_ENTRY_PT:
         return x86_iommu->pt_supported;
-    case VTD_SM_PASID_ENTRY_FLT:
-    case VTD_SM_PASID_ENTRY_NESTED:
     default:
         /* Unknown type */
         return false;
@@ -813,7 +817,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     index = VTD_PASID_TABLE_INDEX(pasid);
     entry_size = VTD_PASID_ENTRY_SIZE;
@@ -827,7 +830,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     }
 
     /* Do translation type check */
-    if (!vtd_pe_type_check(x86_iommu, pe)) {
+    if (!vtd_pe_type_check(s, pe)) {
         return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
@@ -3861,7 +3864,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return false;
     }
 
-    return true;
+    if (!s->scalable_modern) {
+        /* All checks requested by VTD non-modern mode pass */
+        return true;
+    }
+
+    error_setg(errp, "host device is unsupported in scalable modern mode yet");
+    return false;
 }
 
 static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
@@ -4084,7 +4093,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->scalable_modern) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
+        s->cap |= VTD_CAP_FS1GP;
+    } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
 
@@ -4251,9 +4263,9 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
-    /* Currently only address widths supported are 39 and 48 bits */
     if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
-        (s->aw_bits != VTD_HOST_AW_48BIT)) {
+        (s->aw_bits != VTD_HOST_AW_48BIT) &&
+        !s->scalable_modern) {
         error_setg(errp, "Supported values for aw-bits are: %d, %d",
                    VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
         return false;
-- 
2.34.1


