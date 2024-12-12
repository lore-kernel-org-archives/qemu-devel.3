Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1886EE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLelY-0004fL-3b; Thu, 12 Dec 2024 03:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelW-0004ek-Qf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:46 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelV-0007zv-5o
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992905; x=1765528905;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S0ozBEtnTpcJwUPb54LDCz6SzveFLNfygCcZwvi7lwA=;
 b=AqE8bfDUedhNrairbGSrKkt7FJa9CL3FPjgszHJbI47h135lvgeK2e1a
 0VZFo4/aiz6CL0gl/FQtFQtgvE1JztA6psT9lKvx5zKJgIHwZ8RTWG2a8
 FM5W0/i8opNVOJFFV5J3FjTcQgxVYzzNgUzucCbrIIUmm+9BoIpfbup3c
 xIrsLokaWc9GYsd1wBeGz7ACXOsJ4EyGSyxMf9PPPapQxzSj0AtidDJQV
 /3GU4KN8E4JQQDfgpDdJH1ygMa/QTwL1AXvy+hYj0bw0enJqPNWyvJCuP
 JMSZJbVSCu4d2W4ZsmUkaOA3ZZIcbCBgaobjFzTmxzCQbbTSPVdGBxAbN w==;
X-CSE-ConnectionGUID: aBblPtAcRROLpAYlA3r47w==
X-CSE-MsgGUID: GPL2MGm8SWanqkpU/yClCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34124867"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34124867"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:44 -0800
X-CSE-ConnectionGUID: njL9OKgNQg6kNUGXrYG+6g==
X-CSE-MsgGUID: R+8oYY5dSF6yUfKNbpQz5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407043"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:40 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 07/20] intel_iommu: Check if the input address is canonical
Date: Thu, 12 Dec 2024 16:37:44 +0800
Message-Id: <20241212083757.605022-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Stage-1 translation must fail if the address to translate is
not canonical.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 86d3354198..3e7365dfff 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -326,6 +326,7 @@ typedef enum VTDFaultReason {
     /* Non-zero reserved field in present first-stage paging entry */
     VTD_FR_FS_PAGING_ENTRY_RSVD = 0x72,
     VTD_FR_PASID_ENTRY_FSPTPTR_INV = 0x73, /* Invalid FSPTPTR in PASID entry */
+    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
     VTD_FR_FS_PAGING_ENTRY_US = 0x81,      /* Privilege violation */
     VTD_FR_SM_WRITE = 0x85,                /* No write permission */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dbfd48fb65..a4a2a44f92 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1824,6 +1824,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_FS_PAGING_ENTRY_P] = true,
     [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
     [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_FS_PAGING_ENTRY_US] = true,
     [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
@@ -1930,6 +1931,22 @@ static inline bool vtd_flpte_present(uint64_t flpte)
     return !!(flpte & VTD_FL_P);
 }
 
+/* Return true if IOVA is canonical, otherwise false. */
+static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
+                                        VTDContextEntry *ce, uint32_t pasid)
+{
+    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
+    uint64_t upper_bits_mask = ~(iova_limit - 1);
+    uint64_t upper_bits = iova & upper_bits_mask;
+    bool msb = ((iova & (iova_limit >> 1)) != 0);
+
+    if (msb) {
+        return upper_bits == upper_bits_mask;
+    } else {
+        return !upper_bits;
+    }
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1945,6 +1962,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t flpte;
 
+    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
+        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
+                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
+        return -VTD_FR_FS_NON_CANONICAL;
+    }
+
     while (true) {
         offset = vtd_iova_level_offset(iova, level);
         flpte = vtd_get_pte(addr, offset);
-- 
2.34.1


