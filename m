Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD89CAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUP-00023k-4F; Thu, 18 Sep 2025 04:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUL-0001pB-2l
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:37 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUD-0004kl-Vl
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185970; x=1789721970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i+NMpkk9mRvGcaJo7YVNDuAo7rFNRmnFq4XiUVElC7o=;
 b=lmJa6LJfBD0vHNjgYMD4QKpwhKm2EsneRvUCjzyF743kxGUJ/lrzKfIJ
 5rozB0C67M6pfXTcps6HrhdeKIjPJGIkedU633Q/XlB53vGEQeQNPatMH
 MtvINRBbQs37cabXqTdCm34eGKlTa33y9Z2JmtxaB5QUQhSuztYP4lUCF
 5HynpH/+Q9UA0YZHK8OZH7beU0bRfjfTTGD5f45UXqUk594BrfZC6a6YV
 wDhUOGQ97CF3BIoWSGPwlTdVI7k4t3hEZEbfcYgvwWaP0QCMCOOnOy2fs
 8gp9PpVtotNJtlX/UpZbltA5XQ5OAIOA6VOqwmFHDcendFkNhTG8HEM60 g==;
X-CSE-ConnectionGUID: vaOJaWVVSzeQuLi/JRe1AA==
X-CSE-MsgGUID: VCsbdsmdRSK+S5PMYI17TQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109537"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109537"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:27 -0700
X-CSE-ConnectionGUID: SOEe3UgUR7Smv1jQMxdUtw==
X-CSE-MsgGUID: GfY7XHVDReyGzS/R+rpbQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930434"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 14/22] intel_iommu: Add some macros and inline functions
Date: Thu, 18 Sep 2025 04:57:53 -0400
Message-ID: <20250918085803.796942-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add some macros and inline functions that will be used by following
patch.

This patch also make a cleanup to change macro VTD_SM_PASID_ENTRY_FSPM
to use extract64() just like what smmu does, because this macro is used
indirectly by new introduced inline functions. But we doesn't aim to
change the huge amount of bit mask style macro definitions in this patch,
that should be in a separate patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  6 +++++-
 hw/i386/intel_iommu.c          | 30 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d400bcee21..3d5ee5ed52 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -592,8 +592,12 @@ typedef struct VTDPASIDCacheInfo {
 #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
 #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
 
-#define VTD_SM_PASID_ENTRY_FSPM          3ULL
 #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
+#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
+/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
+#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
+#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
+#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
 
 /* First Level Paging Structure */
 /* Masks for First Level Paging Entry */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a6638e13be..5908368c44 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -49,8 +49,7 @@
 
 /* pe operations */
 #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
-#define VTD_PE_GET_FS_LEVEL(pe) \
-    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
+#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
@@ -838,6 +837,31 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
     }
 }
 
+static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
+{
+    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
+}
+
+/*
+ * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
+ *                                 57 bits for 5-level paging(FSPM=01)
+ */
+static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
+{
+    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
+}
+
+static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
+}
+
+/* check if pgtt is first stage translation */
+static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
+{
+    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FST);
+}
+
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
 {
     return pdire->val & 1;
@@ -1709,7 +1733,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
              */
             return false;
         }
-        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
+        return vtd_pe_pgtt_is_pt(&pe);
     }
 
     return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
-- 
2.47.1


