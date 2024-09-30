Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00867CF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svAwf-0002xU-V4; Mon, 30 Sep 2024 03:35:51 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svAwb-0002wX-1P
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:35:45 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svAvm-0008Fa-Mc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727681695; x=1759217695;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aCcMSeMNMPx+pb7Uzwd65SQYAQiwolqLIZNDri1C3Pk=;
 b=AJRI4rXZTmoNakSCs0ycwzkngurGBj5D+1rmXlo82xcYEsNkeFY40She
 YLjbCx0RkqdN4gITF/j9/Er9fOQFbBkObHw12s/pBiS1fCrCHF25OHHyY
 VXNjcWizll2A7PDarbcKi2jvKN7nlnTqGAvp/CGtGIa2bv4OHonLw9A5C
 2CBBWgyZdumz8Wa2c7uLjWTiL3qrrB8f0wtOM4iQR4U+mgQWzOOF/208F
 TewFE+2DkLqn0bG459bmuJ5im2CQpwM3T3/3ixQ68UbX87XNL1HtGp63c
 dmiLcdHU1rcO9zfUY4F6iaSknwpUSYHh+aYyfYu2so9mdMb4qoRGL0nFA Q==;
X-CSE-ConnectionGUID: loydjF65TYiVLQ6pM9jVkQ==
X-CSE-MsgGUID: dUz6DgGHQO2qH3bgTvEfaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="38107853"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="38107853"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2024 23:55:56 -0700
X-CSE-ConnectionGUID: Is8QYQNFQ0yD83G6fU2aoA==
X-CSE-MsgGUID: wm6sEFRXQxuxHEk858HQ0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="103984693"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2024 23:55:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] intel_iommu: Remove Transient Mapping (TM) field from
 second-level page-tables
Date: Mon, 30 Sep 2024 14:52:44 +0800
Message-Id: <20240930065245.2993767-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

VT-d spec removed Transient Mapping (TM) field from second-level page-tables
and treat the field as Reserved(0) since revision 3.2. Update code to match
spec.

This doesn't impact function of vIOMMU as there was no logic to emulate
Transient Mapping.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 13 +++----------
 hw/i386/intel_iommu.c          | 11 +++--------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 13d5d129ae..c818c819fe 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -412,9 +412,7 @@ typedef union VTDInvDesc VTDInvDesc;
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
-#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
-        (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
+#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw) \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
@@ -423,13 +421,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
-#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
-        (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
+#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw) \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
-        (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
+#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
 /* Information about page-selective IOTLB invalidate */
@@ -536,6 +530,5 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SL_W                    (1ULL << 1)
 #define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
-#define VTD_SL_TM                   (1ULL << 62)
 
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 08fe218935..eb5aa2b2d5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4111,8 +4111,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
  */
 static void vtd_init(IntelIOMMUState *s)
 {
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
-
     memset(s->csr, 0, DMAR_REG_SIZE);
     memset(s->wmask, 0, DMAR_REG_SIZE);
     memset(s->w1cmask, 0, DMAR_REG_SIZE);
@@ -4137,16 +4135,13 @@ static void vtd_init(IntelIOMMUState *s)
      * Rsvd field masks for spte
      */
     vtd_spte_rsvd[0] = ~0ULL;
-    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
 
-    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
-    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits);
 
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
-- 
2.34.1


