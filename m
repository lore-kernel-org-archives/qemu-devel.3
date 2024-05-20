Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866C9C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 08:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8ySQ-0001Tv-FL; Mon, 20 May 2024 04:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8yQY-0001Hn-5T
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:31:26 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8yQK-0001CW-0t
 for qemu-devel@nongnu.org; Mon, 20 May 2024 04:31:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716193872; x=1747729872;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SOXzDkh2I1C5gyzCeXuSG5h2n25+YiZaiklkacGiMPA=;
 b=MNFGViW7fKaBVe+Y8ugB+7PoPlfrCxyByjNtsACMSRYVGQ9i+emjyU1D
 XoxV9YAyanoRgYJlBkh7HRxWGJiA5Hp9RKhXfKxuY2XQ4h7yI1U07cF/X
 +KLWeYDuhIywLuYCbwd/x/FZGvtDHEEK1Rw2gx7JIRVmKqJN0BP1Kf5jY
 czyoz+kaISEIGwF+A8Llnszsx6aev9mpxIMXkNNJ04DR96Wj4k7mX8wZ4
 iBRPKhnqesyVF6m8KU0umo1KjvgbjjEDc9mVV8npddcI8Z4cWG4R/2IcC
 0AdL9VndO5s4gVceWRp2u75lYhHQYgIs4ypSzJvoGxoKc5cYhUNhmj1ar g==;
X-CSE-ConnectionGUID: qc9KE7LKT6mEtvWzlAYRzA==
X-CSE-MsgGUID: IZfWUqJ7Qb2X9RCYJPXzPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12106743"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="12106743"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 01:30:41 -0700
X-CSE-ConnectionGUID: JSaTa9f+STanAlQLR7gt1w==
X-CSE-MsgGUID: /kitKpHZRYSFoNSKPczY6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="63683710"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 01:30:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 1/2] intel_iommu: Update version to 3.0 and add the latest
 fault reasons
Date: Mon, 20 May 2024 16:28:14 +0800
Message-Id: <20240520082815.260745-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240520082815.260745-1-zhenzhong.duan@intel.com>
References: <20240520082815.260745-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The scalable mode was introduced in VTD spec 3.0, now that
the scalable mode is already supported, bump version to 3.0.

In spec 3.0 some more detailed fault reasons are defined
for scalable mode. So introduce them into emulation code,
see spec section 7.1.2 for details.

Guest kernel should use the version for informational purpose
not feature check, cap/ecap bits should be checked instead.
So this change will not impact migration.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  9 ++++++++-
 hw/i386/intel_iommu.c          | 27 +++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f8cf99bddf..c0ca7b372f 100644
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
index cc8e59674e..098db79602 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -771,7 +771,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     addr = pasid_dir_base + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ACCESS_ERR;
     }
 
     pdire->val = le64_to_cpu(pdire->val);
@@ -789,6 +789,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
                                           dma_addr_t addr,
                                           VTDPASIDEntry *pe)
 {
+    uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -798,7 +799,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     addr = addr + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
     }
     for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
         pe->val[i] = le64_to_cpu(pe->val[i]);
@@ -806,11 +807,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
 
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
@@ -851,7 +854,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
@@ -860,7 +863,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pe_present(pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_ENTRY_P;
     }
 
     return 0;
@@ -913,7 +916,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     /*
@@ -1770,7 +1773,11 @@ static const bool vtd_qualified_faults[] = {
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
@@ -4031,7 +4038,7 @@ static void vtd_init(IntelIOMMUState *s)
     vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
-    vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
+    vtd_define_long(s, DMAR_VER_REG, 0x30UL, 0, 0);
     vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
     vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
     vtd_define_long(s, DMAR_GCMD_REG, 0, 0xff800000UL, 0);
-- 
2.34.1


