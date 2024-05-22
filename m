Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5099C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQv-0004yI-FM; Wed, 22 May 2024 02:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQm-0004li-Vs
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:33 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQk-0006eK-Oq
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359191; x=1747895191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PTpYwvhKNL/GkXgHdnrW7sO+QlTIBmFpWaRFq585gVQ=;
 b=flyFsdkpc3A+7tQFsMkx1qeSgESuGayuN7C8V/k7J+xd2qtXEuS59R+f
 LDe3jsraOvNxbEv1ZN/0NFIdWSE6yial35fhENRKx34VK8zdTk69qVDrr
 +byJMM50+8ehAzY4tW7NAnZVaURl+ev4ewtEGzTazC05s3DKpjhksPD5N
 vVabE1uLzpNOFSnAe+Gpia8C3NM1pdmJX1PWbOCCUWpc+/IeLL0tCXwdk
 FM3NEtFzbFQjF+j4AzCpKuz35b2mjZgtjwa7FQ+G+5kQboedxNhmijPqK
 iotcfyDIzMK9yxLIvW7A0A8FXuCK9+f1Y1dolztk1H+mhrApBVCgZVRmr w==;
X-CSE-ConnectionGUID: b8u4kNWzQjeDUg9u0x8hvg==
X-CSE-MsgGUID: 6Dyzkp1WTy62Ft//n+/Bww==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972538"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972538"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:30 -0700
X-CSE-ConnectionGUID: 5VI/SIFPQvGQpuYmbxISpg==
X-CSE-MsgGUID: /ur7f/pLTb6RQJvfpe5BPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597791"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:25 -0700
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
Subject: [PATCH rfcv2 08/17] intel_iommu: set accessed and dirty bits during
 first stage translation
Date: Wed, 22 May 2024 14:23:04 +0800
Message-Id: <20240522062313.453317-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index b6820dbca3..c0a94af820 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -327,6 +327,7 @@ typedef enum VTDFaultReason {
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
+    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
     VTD_FR_MAX,                 /* Guard */
 } VTDFaultReason;
 
@@ -547,6 +548,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 /* First Level Paging Structure */
 #define VTD_FL_PT_LEVEL             1
 #define VTD_FL_PT_ENTRY_NR          512
+#define VTD_FL_PTE_A                0x20
+#define VTD_FL_PTE_D                0x40
 
 /* Masks for First Level Paging Entry */
 #define VTD_FL_RW_MASK              (1ULL << 1)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1ea030bfbe..0801112e2e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1802,6 +1802,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_FS_NON_CANONICAL] = true,
+    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1927,6 +1928,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
             );
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
@@ -1972,7 +1987,17 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_WRITE;
         }
 
+        if (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_PTE_A)
+                                                                != MEMTX_OK) {
+            return -VTD_FR_FS_BIT_UPDATE_FAILED;
+        }
+
         if (vtd_is_last_flpte(flpte, level)) {
+            if (is_write &&
+                (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_PTE_D) !=
+                                                                    MEMTX_OK)) {
+                    return -VTD_FR_FS_BIT_UPDATE_FAILED;
+            }
             *flptep = flpte;
             *flpte_level = level;
             return 0;
-- 
2.34.1


