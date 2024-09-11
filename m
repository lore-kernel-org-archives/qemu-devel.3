Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C60BEE020D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFsk-00055W-0P; Wed, 11 Sep 2024 01:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFsg-0004ut-O8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:27:06 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFse-0004Mp-PL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726032425; x=1757568425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AITBgbbwWGVpEmJhWQEQKgwrBpsf2DE8pxN8/CX0AZE=;
 b=TICwsntcavay9zeFyd/kEkD5Hii9KbOh6nodjIeFVGpdhu5cm/2dV9Fk
 Gi1W8sjJPi29zOgBw13Ua/bcc7+yIh2V2BSZs+FLJlBDZ+ioKYJSGcM13
 ei2czmZmJmaR9+2nO5//BBejmt5/cTGtTT4sXzmBOCy7+eyxOphHEmLbL
 cOJ0E6LtL8Imp5EWRzUKix620gh7CCQPX/OBPASupcgZtWBrfAS4norUl
 43UYzYIxCVr7omrBCdmBGT66dNy8nSO85AQKE8hEHrS/lYSck7B6cvTsI
 eKHBg512mdyjO8+clUUOtgP20wnS13D3s3svdpBvsrrPdwLS5ijcvu0UF A==;
X-CSE-ConnectionGUID: 3JiW++k2R/u40xhisOTwCA==
X-CSE-MsgGUID: 1NqqiavzTveOjTWdjglyhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35403626"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="35403626"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:27:04 -0700
X-CSE-ConnectionGUID: lC8BTSklRRir5Nl5W+eypA==
X-CSE-MsgGUID: raa8UZK6QTSNdCeGRkh/mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="67536551"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:59 -0700
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
Subject: [PATCH v3 15/17] intel_iommu: Modify x-scalable-mode to be string
 option to expose scalable modern mode
Date: Wed, 11 Sep 2024 13:22:53 +0800
Message-Id: <20240911052255.1294071-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

From: Yi Liu <yi.l.liu@intel.com>

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
related to scalable mode translation, thus there are multiple combinations.
While this vIOMMU implementation wants to simplify it for user by providing
typical combinations. User could config it by "x-scalable-mode" option. The
usage is as below:

"-device intel-iommu,x-scalable-mode=["legacy"|"modern"|"off"]"

 - "legacy": gives support for stage-2 page table
 - "modern": gives support for stage-1 page table
 - "off": no scalable mode support
 - any other string, will throw error

If x-scalable-mode is not configured, it is equivalent to x-scalable-mode=off.

With scalable modern mode exposed to user, also accurate the pasid entry
check in vtd_pe_type_check().

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 include/hw/i386/intel_iommu.h  |  1 +
 hw/i386/intel_iommu.c          | 46 ++++++++++++++++++++++++++--------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 52bdbf3bc5..af99deb4cd 100644
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
index 48134bda11..650641544c 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -263,6 +263,7 @@ struct IntelIOMMUState {
 
     bool caching_mode;              /* RO - is cap CM enabled? */
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
+    char *scalable_mode_str;        /* RO - admin's Scalable Mode config */
     bool scalable_modern;           /* RO - is modern SM supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 949f120456..bb3ed48281 100644
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
 
@@ -3773,7 +3774,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_UINT8("aw-bits", IntelIOMMUState, aw_bits,
                       VTD_HOST_AW_AUTO),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
-    DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_STRING("x-scalable-mode", IntelIOMMUState, scalable_mode_str),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
@@ -4504,7 +4505,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->scalable_modern) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
+        s->cap |= VTD_CAP_FS1GP;
+    } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
 
@@ -4686,6 +4690,28 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (s->scalable_mode_str &&
+        (strcmp(s->scalable_mode_str, "off") &&
+         strcmp(s->scalable_mode_str, "modern") &&
+         strcmp(s->scalable_mode_str, "legacy"))) {
+        error_setg(errp, "Invalid x-scalable-mode config,"
+                         "Please use \"modern\", \"legacy\" or \"off\"");
+        return false;
+    }
+
+    if (s->scalable_mode_str &&
+        !strcmp(s->scalable_mode_str, "legacy")) {
+        s->scalable_mode = true;
+        s->scalable_modern = false;
+    } else if (s->scalable_mode_str &&
+        !strcmp(s->scalable_mode_str, "modern")) {
+        s->scalable_mode = true;
+        s->scalable_modern = true;
+    } else {
+        s->scalable_mode = false;
+        s->scalable_modern = false;
+    }
+
     if (s->aw_bits == VTD_HOST_AW_AUTO) {
         if (s->scalable_modern) {
             s->aw_bits = VTD_HOST_AW_48BIT;
-- 
2.34.1


