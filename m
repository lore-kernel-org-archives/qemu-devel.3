Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C7ECF649E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCk7-0003yX-2P; Mon, 30 Sep 2024 05:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCjx-00039k-FA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:49 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCju-000759-Ka
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727688646; x=1759224646;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mcB/hqGV1tLMCKCrptZcB4IF0ZZYN+wUBcjOATpsUQQ=;
 b=ZN7QxCgNEu1qahEIGf94zc6Up5L4kJR8xktU/IJbkq70yLWCNkxYtRk1
 wbM9kMG6MOmPjEIOn8lYeRhRRyj1qDbqA9WZ2CQSM0LkGCXROjyUDopo1
 NxqH/1xUaaixbHYDAcl/DfdBy17If1s3b9gi9MMnATulgSx3qks0XSFaG
 t70gZxiNzeXJ0Q68ornZBzuqof8aoOnqQyxEYTDcWkoXWn0K+X/FuZ8hx
 T1p1c451nQyQfjJY3MefsNedK7td+uOUZi5ZpUQZCTAqF6nfI1kkVTv7l
 vLjJavVfeTAkS/cdcU5hspqeB1d9s+W9eNmguBlylhZeM+l+re4W9RBxn A==;
X-CSE-ConnectionGUID: 5UcJkQZSSmCxspN/Ex3clA==
X-CSE-MsgGUID: Nw4bXO5eSCOVYUriYFkwQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26721888"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="26721888"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:46 -0700
X-CSE-ConnectionGUID: hUSi/BBiR02ZI8e1ZwDJOw==
X-CSE-MsgGUID: wUI2VpxHRYCcT46o64iOOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77749889"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:30:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for scalable
 modern mode
Date: Mon, 30 Sep 2024 17:26:29 +0800
Message-Id: <20240930092631.2997543-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This vIOMMU implementation wants to simplify it with a new property "x-fls".
When enabled in scalable mode, first stage translation also known as scalable
modern mode is supported. When enabled in legacy mode, throw out error.

With scalable modern mode exposed to user, also accurate the pasid entry
check in vtd_pe_type_check().

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2702edd27f..f13576d334 100644
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
index 068a08f522..14578655e1 100644
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
 
@@ -3779,6 +3780,7 @@ static Property vtd_properties[] = {
                       VTD_HOST_AW_AUTO),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_BOOL("x-fls", IntelIOMMUState, scalable_modern, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
@@ -4509,7 +4511,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->scalable_modern) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
+        s->cap |= VTD_CAP_FS1GP;
+    } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
 
@@ -4683,6 +4688,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (!s->scalable_mode && s->scalable_modern) {
+        error_setg(errp, "Legacy mode: not support x-fls=on");
+        return false;
+    }
+
     if (s->aw_bits == VTD_HOST_AW_AUTO) {
         if (s->scalable_modern) {
             s->aw_bits = VTD_HOST_AW_48BIT;
-- 
2.34.1


