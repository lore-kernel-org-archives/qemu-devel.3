Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68228EE020B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soFsA-0002X1-Th; Wed, 11 Sep 2024 01:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFs8-0002Vi-K8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:26:32 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1soFs6-0004Mp-TQ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726032391; x=1757568391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VJoRqi++1b3GuZESXgIRFQvtM0ZQW+aZDdqkIgNfyY8=;
 b=kR0dKmC1UZivp2PhazFxOFAIM3p5U7PkklaqTv9IYXjkSk18BjZzx93y
 AuOinDjuQ1yAx66ZJJvT7pmMXHCwaD5UjDJthCbCV70IPfTn5M2+gUdeq
 QvrZL8n/FX7sy4rYMoe+LTvPvWnDpsROh9fw3ra9udJSZX78lRoqGvIbb
 5uBYHYx8XEycq934mWUV5c1s87Mz9JZ/3/uutaLc55xGyC8+UCMYVVNQR
 6AWgRUFbKVhcu9LOZCLxkYuGdtL98vUc7xTo7svUq89duJprFKCTRAgSm
 P9FQFRIvHdnJJ5hzPYy4jCIc5fbR4q29GEor3ElIbCXDMKfKvNmyhmGwo g==;
X-CSE-ConnectionGUID: LyMVU2CET921tVZK7n4QOA==
X-CSE-MsgGUID: iwV0J8MbQz2+N2FV440olg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35403551"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="35403551"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:30 -0700
X-CSE-ConnectionGUID: bM1DBTJOQYi+FWXU99n8Ew==
X-CSE-MsgGUID: cXNaAeeZSi2jTh7Rr1uevA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; d="scan'208";a="67536465"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2024 22:26:26 -0700
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
Subject: [PATCH v3 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Date: Wed, 11 Sep 2024 13:22:46 +0800
Message-Id: <20240911052255.1294071-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

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
index be73366a64..180505423d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1822,6 +1822,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_FS_NON_CANONICAL] = true,
+    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1941,6 +1942,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
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
@@ -1954,7 +1969,7 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
     uint32_t level = vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
-    uint64_t flpte;
+    uint64_t flpte, flag_ad = VTD_FL_A;
 
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
@@ -1992,6 +2007,14 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_PAGING_ENTRY_RSVD;
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


