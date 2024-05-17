Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6867C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 10:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7un1-0005ot-PY; Fri, 17 May 2024 06:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7umz-0005oj-Jb
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:26:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7umv-00056o-U9
 for qemu-devel@nongnu.org; Fri, 17 May 2024 06:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715941570; x=1747477570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7056gP3rdOG9Z1Wglagj65AjGY/7qiEUgUDWcurHDOk=;
 b=SJNTJlzXHt7ir3nIufbGMaFY1QrFeXbuMla25qL7vpXtDP7DH9k91Knz
 ht1CpD2XCG2zugS7RCsRC7hVPCwiHdzXeSkBsY6Gt9UT+YDGUpSZwVEJo
 +/xxp7YM01GSrncVr+x5sOw/bnpHlUGYscSygIvjftRxd3NvhuD0o6enU
 rg5+JaoqUeaahgESQS+07msqMIEJBN/qT9e0Wy6w+Zj35/EHFakc0FCvi
 q/d4P2Qxf58+YQZKv4A32Vpg7xUOsh48gFqENYideaLfRzA2rlpzoM2i9
 RCAsJzezK92WmfvtUo7B4agW5Njo5Ynd8rP22WJ69csXFaoox1CI+Rhh5 A==;
X-CSE-ConnectionGUID: B2SSbeB6T7W6h/WxcErupQ==
X-CSE-MsgGUID: LXFkxVyWRgywttbqNY3RFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="29627528"
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; d="scan'208";a="29627528"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 03:26:07 -0700
X-CSE-ConnectionGUID: vTZbYu87QTORpRfQK77gww==
X-CSE-MsgGUID: gNGTFB+MQTWNGuaCH+Ha1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,167,1712646000"; d="scan'208";a="31763837"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 03:26:04 -0700
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
Subject: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Date: Fri, 17 May 2024 18:23:34 +0800
Message-Id: <20240517102334.81943-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

From: Yu Zhang <yu.c.zhang@linux.intel.com>

Currently we use only VTD_FR_PASID_TABLE_INV as fault reason.
Update with more detailed fault reasons listed in VT-d spec 7.2.3.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  8 +++++++-
 hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f8cf99bddf..666e2cf2ce 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -311,7 +311,13 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
-    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
+    /* PASID directory entry access failure */
+    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
+    /* The Present(P) field of pasid directory entry is 0 */
+    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
+    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
+    VTD_FR_PASID_ENTRY_P = 0x59, /* The Present(P) field of pasidt-entry is 0 */
+    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8e59674e..0951ebb71d 100644
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
-- 
2.34.1


