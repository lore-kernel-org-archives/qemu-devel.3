Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77033C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 06:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sarFM-0002vA-Pl; Mon, 05 Aug 2024 02:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarF5-0002n6-8x
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:57 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sarEv-0002As-RQ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 02:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722839442; x=1754375442;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=38HYgjgTWR4uxnvcTJKXQdnXnLtWPR0LnXj/4FiurfI=;
 b=lJrcLQeZzjtuOUMXXXS+vCPLVG3oFUbT7ZffWRHjsfGOrmo3w3GjbFuo
 x9rdDb/W91vPyDr2OakEoCgymHQq6ai7NdL2ktQWNlzQhMixmgeZSD/sA
 NMk1/YEAVVr5J+Iec1LWGUTiPMDdRL/jOLqYynFR/Mp9/osoWBND/TMwx
 OqegfLMZh0oErsnLHuciJiZDmCgbpwdtoN3R4STpYmbdwTA8IhFo7CFO8
 pz3YCTLwj5Llle3flg9rt3xV6wlfUSLLPFDZx6rjb1DOj1q8mJmtOjAxe
 67CDJJkeyv9jl6/iyPtckcMpheBraJd90pOXQ86x/HKdAJfXZxFMlUtWE A==;
X-CSE-ConnectionGUID: UuNAPx9bQHm7wrlSaT8BTA==
X-CSE-MsgGUID: 6Lte/eJUShOBeUn4C63baQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="38282727"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="38282727"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:41 -0700
X-CSE-ConnectionGUID: BkuhIYXdT8eOZDQIf/89rg==
X-CSE-MsgGUID: 6HhGqKy8TcWWIfSGbvzXeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; d="scan'208";a="56786784"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2024 23:30:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 07/17] intel_iommu: Check if the input address is canonical
Date: Mon,  5 Aug 2024 14:27:17 +0800
Message-Id: <20240805062727.2307552-8-zhenzhong.duan@intel.com>
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

First stage translation must fail if the address to translate is
not canonical.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 51e9b1fc43..668583aeca 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -320,6 +320,8 @@ typedef enum VTDFaultReason {
     VTD_FR_PASID_ENTRY_P = 0x59,
     VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
+    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
+
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
     VTD_FR_MAX,                 /* Guard */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0bcbd5b777..6121cca4cd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1821,6 +1821,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_PASID_ENTRY_P] = true,
     [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1924,6 +1925,20 @@ static inline bool vtd_flpte_present(uint64_t flpte)
     return !!(flpte & VTD_FL_P);
 }
 
+/* Return true if IOVA is canonical, otherwise false. */
+static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
+                                        VTDContextEntry *ce, uint32_t pasid)
+{
+    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
+    uint64_t upper_bits_mask = ~(iova_limit - 1);
+    uint64_t upper_bits = iova & upper_bits_mask;
+    bool msb = ((iova & (iova_limit >> 1)) != 0);
+    return !(
+             (!msb && (upper_bits != 0)) ||
+             (msb && (upper_bits != upper_bits_mask))
+            );
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1939,6 +1954,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t flpte;
 
+    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
+        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
+                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
+        return -VTD_FR_FS_NON_CANONICAL;
+    }
+
     while (true) {
         offset = vtd_iova_level_offset(iova, level);
         flpte = vtd_get_pte(addr, offset);
-- 
2.34.1


