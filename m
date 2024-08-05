Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BD3C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFP-000334-Um; Mon, 05 Aug 2024 02:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarF7-0002n8-8C
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:57 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarF3-0002Cr-NC
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839450; x=1754375450;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tyTUGMCms0hzjN7qnTn/8Dv0La9ACcHcXuKiSuT8dg8=;
 b=nJGfexGLJs5v4T19zEYPwz6VHjQ1PLAlt/Egp7vKHqVxfDogAEufA8d/
 YBqskRAWoCd9sAGY25DGLsM/z/5ZuV4TyeYons3feIX0Gqz5MAkV9FnZx
 tS+Goy70khL5vIxc4yQtmMqja1JcK1CSsymGx4FTpK1zqCDsmB9ptL9IE
 R03hUeDTcufBwkmu/RcILWX5FcJwLmJ4uHUtF8aQ1bTr9mj5DyeA9OCwI
 fw3NfTm9QpbSdFhhUiCiQKUS+ns4lxM21w1ZrrUWqbjaXzdG8V2mSYykn
 9ddYy4im1FlhnYnCLmkOPWtP3bLO0xMC8fFMBUBo7r/DuT8ih+ja9MDjo A==;
X-CSE-ConnectionGUID: ymP9SDMtTpmlJ/8yZxbjZw==
X-CSE-MsgGUID: FRzJ8aIeT3yQIIZVjzqQNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282736"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282736"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:45 -0700
X-CSE-ConnectionGUID: nh3FWfN/TKqDTejqjXTZnA==
X-CSE-MsgGUID: zyfkortoRFWe22vjy3+64Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786824"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:40 -0700
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
Subject: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Date: Mon,  5 Aug 2024 14:27:18 +0800
Message-Id: <20240805062727.2307552-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 668583aeca..7786ef7624 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -324,6 +324,7 @@ typedef enum VTDFaultReason {
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
+    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
     VTD_FR_MAX,                 /* Guard */
 } VTDFaultReason;
 
@@ -549,6 +550,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 /* Masks for First Level Paging Entry */
 #define VTD_FL_P                    1ULL
 #define VTD_FL_RW_MASK              (1ULL << 1)
+#define VTD_FL_A                    0x20
+#define VTD_FL_D                    0x40
 
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6121cca4cd..3c2ceed284 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1822,6 +1822,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_FS_NON_CANONICAL] = true,
+    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1939,6 +1940,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
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
@@ -1990,7 +2005,16 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_PAGING_ENTRY_RSVD;
         }
 
+        if (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_A) != MEMTX_OK) {
+            return -VTD_FR_FS_BIT_UPDATE_FAILED;
+        }
+
         if (vtd_is_last_pte(flpte, level)) {
+            if (is_write &&
+                (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_D) !=
+                                                                    MEMTX_OK)) {
+                    return -VTD_FR_FS_BIT_UPDATE_FAILED;
+            }
             *flptep = flpte;
             *flpte_level = level;
             return 0;
-- 
2.34.1


