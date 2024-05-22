Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775C9C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQq-0004tb-Fw; Wed, 22 May 2024 02:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQc-0004hE-V9
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:26 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQb-0006eK-2d
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359181; x=1747895181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cUHaYrw4M5g3+Y/4geeEr+F2a1tGgIj677+LINY9b6c=;
 b=AIWOTI8yWFyv2ZqZCBSWfUqPvQ9H6btjazwarB1/CTbKuyzyzpZZbFPf
 n2C6WeBi0kDq1Ri/vEfVDXLw/m8iPN4vrN0OBTX15GO4/GXhN0YxvcOch
 gZNLPi0siCjZ9KFPlE4JEPv4F+QjzzCX9VIsKDCG9XSFdAEJN8SY4aS7N
 sYDU9Ew6F2vjVtnFaAdQTn5RndVX5wkOhYgTUQfOEdn6wbuBo4GL6q0BR
 p9tdX++4AOmIclDmQ1nHp2J6xEQ2DMcuiZTxFEBCIZRxwCBXJduC1BvL1
 wwmqkAzKaFuze6ohxmqPG2WXq9dg8+wIDlGWAVAjO0qwINIZyXuuIOEn9 Q==;
X-CSE-ConnectionGUID: SJU4JKg1SJWNvArLfrDEnQ==
X-CSE-MsgGUID: BTTP5QT1QgexLEDakBDTUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972513"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972513"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:20 -0700
X-CSE-ConnectionGUID: t84vdBkrSOWOu55os9EQQA==
X-CSE-MsgGUID: ymIhH+8wQD+23mb1bvap3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597743"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 06/17] intel_iommu: Implement stage-1 translation
Date: Wed, 22 May 2024 14:23:02 +0800
Message-Id: <20240522062313.453317-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

From: Yi Liu <yi.l.liu@intel.com>

This adds stage-1 page table walking to support stage-1 only
transltion in scalable modern mode.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  17 +++++
 hw/i386/intel_iommu.c          | 128 +++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 0e240d6d54..abfdbd5f65 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -534,6 +534,23 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
 
+#define VTD_SM_PASID_ENTRY_FLPM          3ULL
+#define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
+
+/* Paging Structure common */
+#define VTD_FL_PT_PAGE_SIZE_MASK    (1ULL << 7)
+/* Bits to decide the offset for each level */
+#define VTD_FL_LEVEL_BITS           9
+
+/* First Level Paging Structure */
+#define VTD_FL_PT_LEVEL             1
+#define VTD_FL_PT_ENTRY_NR          512
+
+/* Masks for First Level Paging Entry */
+#define VTD_FL_RW_MASK              (1ULL << 1)
+#define VTD_FL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
+#define VTD_PASID_ENTRY_FPD         (1ULL << 1) /* Fault Processing Disable */
+
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 544e8f0e40..cf29809bc1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -50,6 +50,8 @@
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
 #define VTD_PE_GET_LEVEL(pe) (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
+#define VTD_PE_GET_FLPT_LEVEL(pe) \
+    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM))
 
 /*
  * PCI bus number (or SID) is not reliable since the device is usaully
@@ -823,6 +825,11 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
             return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
+    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
+        VTD_PE_GET_FLPT_LEVEL(pe) != 4) {
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
+    }
+
     return 0;
 }
 
@@ -958,7 +965,11 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return VTD_PE_GET_LEVEL(&pe);
+        if (s->scalable_modern) {
+            return VTD_PE_GET_FLPT_LEVEL(&pe);
+        } else {
+            return VTD_PE_GET_LEVEL(&pe);
+        }
     }
 
     return vtd_ce_get_level(ce);
@@ -1045,7 +1056,11 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
 
     if (s->root_scalable) {
         vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
-        return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        if (s->scalable_modern) {
+            return pe.val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
+        } else {
+            return pe.val[0] & VTD_SM_PASID_ENTRY_SLPTPTR;
+        }
     }
 
     return vtd_ce_get_slpt_base(ce);
@@ -1847,6 +1862,106 @@ out:
     trace_vtd_pt_enable_fast_path(source_id, success);
 }
 
+/* The shift of an addr for a certain level of paging structure */
+static inline uint32_t vtd_flpt_level_shift(uint32_t level)
+{
+    assert(level != 0);
+    return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_FL_LEVEL_BITS;
+}
+
+/*
+ * Given an iova and the level of paging structure, return the offset
+ * of current level.
+ */
+static inline uint32_t vtd_iova_fl_level_offset(uint64_t iova, uint32_t level)
+{
+    return (iova >> vtd_flpt_level_shift(level)) &
+            ((1ULL << VTD_FL_LEVEL_BITS) - 1);
+}
+
+/* Get the content of a flpte located in @base_addr[@index] */
+static uint64_t vtd_get_flpte(dma_addr_t base_addr, uint32_t index)
+{
+    uint64_t flpte;
+
+    assert(index < VTD_FL_PT_ENTRY_NR);
+
+    if (dma_memory_read(&address_space_memory,
+                        base_addr + index * sizeof(flpte), &flpte,
+                        sizeof(flpte), MEMTXATTRS_UNSPECIFIED)) {
+        flpte = (uint64_t)-1;
+        return flpte;
+    }
+    flpte = le64_to_cpu(flpte);
+    return flpte;
+}
+
+static inline bool vtd_flpte_present(uint64_t flpte)
+{
+    return !!(flpte & 0x1);
+}
+
+/* Whether the pte indicates the address of the page frame */
+static inline bool vtd_is_last_flpte(uint64_t flpte, uint32_t level)
+{
+    return level == VTD_FL_PT_LEVEL || (flpte & VTD_FL_PT_PAGE_SIZE_MASK);
+}
+
+static inline uint64_t vtd_get_flpte_addr(uint64_t flpte, uint8_t aw)
+{
+    return flpte & VTD_FL_PT_BASE_ADDR_MASK(aw);
+}
+
+/*
+ * Given the @iova, get relevant @flptep. @flpte_level will be the last level
+ * of the translation, can be used for deciding the size of large page.
+ */
+static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
+                             uint64_t iova, bool is_write,
+                             uint64_t *flptep, uint32_t *flpte_level,
+                             bool *reads, bool *writes, uint8_t aw_bits,
+                             uint32_t pasid)
+{
+    dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
+    uint32_t level = vtd_get_iova_level(s, ce, pasid);
+    uint32_t offset;
+    uint64_t flpte;
+
+    while (true) {
+        offset = vtd_iova_fl_level_offset(iova, level);
+        flpte = vtd_get_flpte(addr, offset);
+        if (flpte == (uint64_t)-1) {
+            if (level == vtd_get_iova_level(s, ce, pasid)) {
+                /* Invalid programming of context-entry */
+                return -VTD_FR_CONTEXT_ENTRY_INV;
+            } else {
+                return -VTD_FR_PAGING_ENTRY_INV;
+            }
+        }
+
+        if (!vtd_flpte_present(flpte)) {
+            *reads = false;
+            *writes = false;
+            return -VTD_FR_PAGING_ENTRY_INV;
+        }
+
+        *reads = true;
+        *writes = (*writes) && (flpte & VTD_FL_RW_MASK);
+        if (is_write && !(flpte & VTD_FL_RW_MASK)) {
+            return -VTD_FR_WRITE;
+        }
+
+        if (vtd_is_last_flpte(flpte, level)) {
+            *flptep = flpte;
+            *flpte_level = level;
+            return 0;
+        }
+
+        addr = vtd_get_flpte_addr(flpte, aw_bits);
+        level--;
+    }
+}
+
 static void vtd_report_fault(IntelIOMMUState *s,
                              int err, bool is_fpd_set,
                              uint16_t source_id,
@@ -1995,8 +2110,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         }
     }
 
-    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
-                               &reads, &writes, s->aw_bits, pasid);
+    if (s->scalable_modern) {
+        ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    } else {
+        ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
+                                   &reads, &writes, s->aw_bits, pasid);
+    }
 
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
-- 
2.34.1


