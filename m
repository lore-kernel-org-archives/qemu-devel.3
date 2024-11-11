Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D90BD2E9C2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPwX-0004uP-88; Mon, 11 Nov 2024 03:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwU-0004tz-MR
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:38 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwS-0003UY-WD
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314317; x=1762850317;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uuK+rEEw/aRsB08dz1yLedB9EqNJOQvHrVrQJEPdptU=;
 b=BDt0fYUvY2m7qXGhk0Yw74mbGc7C2X9Y+5CmM5jY+q0vH33dz5eyOv1i
 Nxa8uS0vF3qoWUUq/BgG4hmR4dxTGQTfZuDPKAE03W+N1WVjXEvf5IYup
 Q/N06mWaF4LayYxnF7l5Rn2n6L2gKT0yHIVMd5EGi08FjBAqfpvfLXzZt
 VKOjwy7Sm9gC1NvRxSUgPyFBbmS63+Ky12fmnNfcAMrS8ta6Lk+DsI3Jy
 LZB2zNSdAHRIb0+Yw3fXurLjr+YiZwhsVS07DXGiTWunTRviUlBwbOpG4
 /JGqSWOOsi/05p0vRnJjv8UVu4vnGROMQr5UtIhmuPGyjVPYTWWclIyZI g==;
X-CSE-ConnectionGUID: qzCmZzcOS+Cu42+4VRdQlQ==
X-CSE-MsgGUID: MwdF7zs8SxWzX9cVqzzCdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334419"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334419"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:36 -0800
X-CSE-ConnectionGUID: D8nIQAJLQOi088C3QfqmgQ==
X-CSE-MsgGUID: 19ide4DjTpu99ed344T0QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608292"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:32 -0800
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
Subject: [PATCH v5 07/20] intel_iommu: Check if the input address is canonical
Date: Mon, 11 Nov 2024 16:34:44 +0800
Message-Id: <20241111083457.2090664-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

First stage translation must fail if the address to translate is
not canonical.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 86d3354198..3e7365dfff 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -326,6 +326,7 @@ typedef enum VTDFaultReason {
     /* Non-zero reserved field in present first-stage paging entry */
     VTD_FR_FS_PAGING_ENTRY_RSVD = 0x72,
     VTD_FR_PASID_ENTRY_FSPTPTR_INV = 0x73, /* Invalid FSPTPTR in PASID entry */
+    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
     VTD_FR_FS_PAGING_ENTRY_US = 0x81,      /* Privilege violation */
     VTD_FR_SM_WRITE = 0x85,                /* No write permission */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dbd64d608f..4cc4d668fc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1824,6 +1824,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_FS_PAGING_ENTRY_P] = true,
     [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
     [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_FS_PAGING_ENTRY_US] = true,
     [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
@@ -1930,6 +1931,22 @@ static inline bool vtd_flpte_present(uint64_t flpte)
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
+
+    if (msb) {
+        return upper_bits == upper_bits_mask;
+    } else {
+        return !upper_bits;
+    }
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1945,6 +1962,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
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


