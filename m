Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2B6C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMMr-0007nN-6j; Thu, 18 Jul 2024 04:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMp-0007il-Km
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:59 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUMMn-0008CX-74
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721290797; x=1752826797;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=niCzkGR1Tw3ATONOfsEVQDnH7lN7M2YH9yAYiT3e5s0=;
 b=WpSbm2cYbQHTe3hgVfr8W7dSfZt/HNwCAeFsx4iLuTI5ALx5TxKnndu0
 cOEXvPqc0t2thdyC/Wn5eg/VIiVZ9K3Thbvk9Hkzvo4+QFWKz8raG+/TO
 jTsBk3WA/T9QEXzt8w2IsR6G+zBxItQ/MoSKi0h5qag4Mp0pceF1yNMRI
 Qyc0Rj10+0V3FK2BOUfZVxLJSEyhHMoYJXkkpD2mBN8j/o9hvuzRqUkz6
 6TAUyssOi1jmpGcU6AL1O1hMWEkwaQGhXPoEXFAOukU66UcDLKUB6jJjB
 TfJPgTpTaNxrCoEx0+8XIk4A+Oc77HbKdnsjm81KaBQXXByQRoHrTqbMo g==;
X-CSE-ConnectionGUID: HkibuFL0SUO815dmzIKDJw==
X-CSE-MsgGUID: 62NhtFBXSSmTTnzHBW/WfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29996259"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="29996259"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:56 -0700
X-CSE-ConnectionGUID: 7QUNIG2HQ7K+eWSKnl6QkQ==
X-CSE-MsgGUID: ZeQkuc2aQimmTqP3g/ydzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="81717300"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 01:19:53 -0700
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
Subject: [PATCH v1 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
Date: Thu, 18 Jul 2024 16:16:27 +0800
Message-Id: <20240718081636.879544-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718081636.879544-1-zhenzhong.duan@intel.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
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
 hw/i386/intel_iommu.c          | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 168185b850..cf0f176e06 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -326,6 +326,7 @@ typedef enum VTDFaultReason {
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
+    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
     VTD_FR_MAX,                 /* Guard */
 } VTDFaultReason;
 
@@ -560,6 +561,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 /* Masks for First Level Paging Entry */
 #define VTD_FL_P                    1ULL
 #define VTD_FL_RW_MASK              (1ULL << 1)
+#define VTD_FL_A                    0x20
+#define VTD_FL_D                    0x40
 
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 495a41cf80..210df32f01 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1825,6 +1825,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_FS_NON_CANONICAL] = true,
+    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1942,6 +1943,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
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
@@ -1993,7 +2008,16 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
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


