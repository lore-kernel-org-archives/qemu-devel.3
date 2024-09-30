Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80B4CF649E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCiw-0006nd-Ed; Mon, 30 Sep 2024 05:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCiv-0006it-7n
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:29:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svCit-0006mv-BI
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727688583; x=1759224583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gAzdXE8kbIu6eqGeu2m9d5lr+H3IV9C0qMeJOpIAWuA=;
 b=id6ixY1NSoPRghGjCY/0gkCJbP6i4U0UAxJcNPbU+PN6LergAAiGvM9l
 Losj77RjIwlZj6LGlyirQXEjInNEmUYShmRyohPfBQt+tOFzJxDOzp16Y
 vAEa4Qen8BWPV8ZO6pJo6MlkyiBiqfBkU4GIBZRTMNoM/PbwRJUjFaTKY
 X4nqmM6fSeJIax7BK3GaN5PrPeAUdP1Ry7VH9d9pex39u8Xu3gbMeciEE
 nTj7aaiR2WHuoOV0X1gKXJ9PPTtgI7DyeGh5Uz5OsjJTxYm9lLV6oFfCj
 ZGznO+jmElqYxWxL8WhJkyTjZPZc8Tjk4Y4xnbH/5/UGPFpIbMTsHNJ9T g==;
X-CSE-ConnectionGUID: 0diPlE2mTPuxHDLSnSpniw==
X-CSE-MsgGUID: ZoPvsCk6TgqDAyn33e7hzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26721617"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="26721617"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:29:42 -0700
X-CSE-ConnectionGUID: EeTM1D4yT1WkoBwr6vdHbQ==
X-CSE-MsgGUID: i1PhKHChQEW4tFDrkA65xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="77749381"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:29:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 01/17] intel_iommu: Use the latest fault reasons defined by
 spec
Date: Mon, 30 Sep 2024 17:26:15 +0800
Message-Id: <20240930092631.2997543-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Yu Zhang <yu.c.zhang@linux.intel.com>

Spec revision 3.0 or above defines more detailed fault reasons for
scalable mode. So introduce them into emulation code, see spec
section 7.1.2 for details.

Note spec revision has no relation with VERSION register, Guest
kernel should not use that register to judge what features are
supported. Instead cap/ecap bits should be checked.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  9 ++++++++-
 hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c818c819fe..d0f9d4589d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -311,7 +311,14 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
-    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
+    /* PASID directory entry access failure */
+    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
+    /* The Present(P) field of pasid directory entry is 0 */
+    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
+    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
+    /* The Present(P) field of pasid table entry is 0 */
+    VTD_FR_PASID_ENTRY_P = 0x59,
+    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index eb5aa2b2d5..378e417b27 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -796,7 +796,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     addr = pasid_dir_base + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ACCESS_ERR;
     }
 
     pdire->val = le64_to_cpu(pdire->val);
@@ -814,6 +814,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
                                           dma_addr_t addr,
                                           VTDPASIDEntry *pe)
 {
+    uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -823,7 +824,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     addr = addr + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
     }
     for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
         pe->val[i] = le64_to_cpu(pe->val[i]);
@@ -831,11 +832,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
 
     /* Do translation type check */
     if (!vtd_pe_type_check(x86_iommu, pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
-    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
-        return -VTD_FR_PASID_TABLE_INV;
+    pgtt = VTD_PE_GET_TYPE(pe);
+    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
+        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
     return 0;
@@ -876,7 +879,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
@@ -885,7 +888,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pe_present(pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_ENTRY_P;
     }
 
     return 0;
@@ -938,7 +941,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     /*
@@ -1795,7 +1798,11 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_ROOT_ENTRY_RSVD] = false,
     [VTD_FR_PAGING_ENTRY_RSVD] = true,
     [VTD_FR_CONTEXT_ENTRY_TT] = true,
-    [VTD_FR_PASID_TABLE_INV] = false,
+    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
+    [VTD_FR_PASID_DIR_ENTRY_P] = true,
+    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
+    [VTD_FR_PASID_ENTRY_P] = true,
+    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_MAX] = false,
 };
-- 
2.34.1


