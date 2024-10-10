Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9038DCF07BD
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 07:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syo2f-0007KD-M3; Thu, 10 Oct 2024 03:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1syo2e-0007Jz-65
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:57:00 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1syo2b-0002no-Rx
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 03:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728547018; x=1760083018;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lyjzp5XiFXHiZZpSXrnIP7FV9VhLQcrCX2uq6dC/vGA=;
 b=b3650mfi0ODZa2v0pd0j+NQ4NyXBXm0Ob0ms/hneyxI1r0EDY5Ixt7hi
 FZuH9/8OJAcd9SEBLH6hTO75vQ6bHEE2kZbhEjoXkjRjDl4YtRFOilGk4
 yAuRo/OJJPd7LjI7Go6RyeJ/88shZdWH4of6skBMj6C5+ls8iZ60t3Xvr
 GPe8OFA2YoS4td7t3AY7w4f8bKoEMqem7PpI1aoOjgmLfyvheE8oUcDGq
 j6FjNt4gRJxIDcHUJ3FIY9PRlWu/z2dY8OyQvuL8V9c22rTXp+Aw4j+BT
 oHhbzocjhIGjvM6TTaMajjV+jamz8/kzfOVVV+iR0k65haJuey2lI8p2d g==;
X-CSE-ConnectionGUID: XD40dqDCTU+vdiNMzEbXPg==
X-CSE-MsgGUID: 8sceUMEkST63lKOnF0oeMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="53291251"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; d="scan'208";a="53291251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 00:56:54 -0700
X-CSE-ConnectionGUID: Jfou3H7DTf+soziyKCbfVQ==
X-CSE-MsgGUID: eTWwLaGbRIODNejsotHwZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; d="scan'208";a="81325501"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2024 00:56:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to control
 Transient Mapping (TM) field
Date: Thu, 10 Oct 2024 15:53:54 +0800
Message-Id: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
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

VT-d spec removed Transient Mapping (TM) field from second-level page-tables
and treat the field as Reserved(0) since revision 3.2.

Changing the field as reserved(0) will break backward compatibility, so
introduce a property "x-stale-tm" to allow user to control the setting.

Use hw_compat_9_1 to handle the compatibility for machines before 9.2 which
allow guest to set the field. Starting from 9.2, this field is reserved(0)
by default to match spec. Of course, user can force it on command line.

This doesn't impact function of vIOMMU as there was no logic to emulate
Transient Mapping.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v2: Introcude "x-stale-tm" to handle migration compatibility (Jason)

 hw/i386/intel_iommu_internal.h | 12 ++++++------
 include/hw/i386/intel_iommu.h  |  3 +++
 hw/i386/intel_iommu.c          | 10 ++++------
 hw/i386/pc.c                   |  1 +
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 13d5d129ae..2f9bc0147d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -412,8 +412,8 @@ typedef union VTDInvDesc VTDInvDesc;
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
-#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
+#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, stale_tm) \
+        stale_tm ? \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
@@ -423,12 +423,12 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
-#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
+#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, stale_tm) \
+        stale_tm ? \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
+#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, stale_tm) \
+        stale_tm ? \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1eb05c29fc..d372cd396b 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -306,6 +306,9 @@ struct IntelIOMMUState {
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
 
+    /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
+    bool stale_tm;
+
     /*
      * Protects IOMMU states in general.  Currently it protects the
      * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 08fe218935..ed668a8eff 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3372,6 +3372,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
+    DEFINE_PROP_BOOL("x-stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -4111,8 +4112,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
  */
 static void vtd_init(IntelIOMMUState *s)
 {
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
-
     memset(s->csr, 0, DMAR_REG_SIZE);
     memset(s->wmask, 0, DMAR_REG_SIZE);
     memset(s->w1cmask, 0, DMAR_REG_SIZE);
@@ -4137,16 +4136,15 @@ static void vtd_init(IntelIOMMUState *s)
      * Rsvd field masks for spte
      */
     vtd_spte_rsvd[0] = ~0ULL;
-    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits, s->stale_tm);
     vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
 
     vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+                                                         s->stale_tm);
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+                                                         s->stale_tm);
 
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8d84c22458..2569771700 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -82,6 +82,7 @@
 GlobalProperty pc_compat_9_1[] = {
     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
+    { TYPE_INTEL_IOMMU_DEVICE, "x-stale-tm", "on" },
 };
 const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
 
-- 
2.34.1


