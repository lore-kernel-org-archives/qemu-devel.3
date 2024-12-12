Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2107DE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLem3-0004z7-7O; Thu, 12 Dec 2024 03:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelf-0004ki-UG
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:57 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLeld-0007zv-Sa
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992914; x=1765528914;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oFalavPII2jPBYEHTA2qw6pHgWP7I65PFi3X3wbm52U=;
 b=n3lYOxl29REQE24W3FvnWc8Q7vlQl9+3OdulrZHjVqhPG7E9ol3I4/+N
 2TxdOWkyKTC/zCLv2cVoFzkFh2vtByqe1D42EsehjvCFNi0TPG+U8F2Cd
 o/72FhJVUrkiLykdrybFdLX/evQefkT4bRdTTsDgOpGxygAtOhCqar1oy
 qi4zkHZ86/R5a3PLX9h1mLh3EX8GeBF6yuLlSUXHg9dxSShYT7Ssmo4vL
 QjBWYGxJN71iviBQbBf+ZAbS61hcmJAwJOxV2SFFUiW4fiLr3oF3hJasR
 ULLLWsTDrUctf5PA+dpUOFGVGE3SKbCkbFcZHiSs20pgQ0HOi2umz3CDQ Q==;
X-CSE-ConnectionGUID: tgQiL1zDSamfDXPBlRiJHA==
X-CSE-MsgGUID: yab1VZuLSb2pMv0f86wXeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34124912"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34124912"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:53 -0800
X-CSE-ConnectionGUID: s59hVgPJRTq90sO5G92N4g==
X-CSE-MsgGUID: 9+mzOw2kQPSSYBF9nzZp+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407085"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:49 -0800
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
Subject: [PATCH v6 09/20] intel_iommu: Set accessed and dirty bits during
 stage-1 translation
Date: Thu, 12 Dec 2024 16:37:46 +0800
Message-Id: <20241212083757.605022-10-zhenzhong.duan@intel.com>
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

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 3e7365dfff..22dd3faf0c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -332,6 +332,7 @@ typedef enum VTDFaultReason {
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
+    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
     VTD_FR_MAX,                 /* Guard */
 } VTDFaultReason;
 
@@ -564,6 +565,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_FL_P                    1ULL
 #define VTD_FL_RW                   (1ULL << 1)
 #define VTD_FL_US                   (1ULL << 2)
+#define VTD_FL_A                    (1ULL << 5)
+#define VTD_FL_D                    (1ULL << 6)
 
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 594c8e3272..ba2eba69c7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1806,6 +1806,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_FS_PAGING_ENTRY_US] = true,
     [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
+    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1925,6 +1926,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
     }
 }
 
+static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t index,
+                                       uint64_t pte, uint64_t flag)
+{
+    if (pte & flag) {
+        return MEMTX_OK;
+    }
+    pte |= flag;
+    pte = cpu_to_le64(pte);
+    return dma_memory_write(&address_space_memory,
+                            base_addr + index * sizeof(pte),
+                            &pte, sizeof(pte),
+                            MEMTXATTRS_UNSPECIFIED);
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1938,7 +1953,7 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
     uint32_t level = vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
-    uint64_t flpte;
+    uint64_t flpte, flag_ad = VTD_FL_A;
 
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
@@ -1985,6 +2000,14 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
 
+        if (vtd_is_last_pte(flpte, level) && is_write) {
+            flag_ad |= VTD_FL_D;
+        }
+
+        if (vtd_set_flag_in_pte(addr, offset, flpte, flag_ad) != MEMTX_OK) {
+            return -VTD_FR_FS_BIT_UPDATE_FAILED;
+        }
+
         if (vtd_is_last_pte(flpte, level)) {
             *flptep = flpte;
             *flpte_level = level;
-- 
2.34.1


