Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19937D2E022
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 08:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3WJ1-0005tx-Dp; Wed, 23 Oct 2024 04:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t3WIq-0005tU-2B
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:01:12 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t3WIm-0002IC-NC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729670470; x=1761206470;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T9YI5AivMLjiMG+JybRFoRFAeaU3k3oQbQyM/wgyqbo=;
 b=f/0gij3vRp/NWtSk2yJGAx9zNJ6kK5j9IowOCx6YsXH2sn2rBZxYBJ3L
 8nwM+unCg904CQAYsGOZsBx3erWZObMGiTNTFp0/SHZHaYuUufZuZ9mzp
 ggcPeym0DdqWSzyYE5wbxWp+neIRRCs1Go/BKix4i9JgV8JqzkCP4GRT3
 BhyZA4YGs+wzE9BqaNhsp1BNP//+/nVEJ4unE+ruwqMSXyab7YDgXSM3a
 hwpN9P2BtKwBZzq6tWVjzTphvkaA7rqA48IqjCVFGbvaT06ydujS/oZe0
 n2FgY5UIqxjkxjAjxA4X0zCOjeo1DJ1ZoWLjI1OeatMq+6+HvT4GcqdmI Q==;
X-CSE-ConnectionGUID: L4zar9E7R62/JkyJ+7TdVQ==
X-CSE-MsgGUID: pQ3jSb+qQeiw3Q3vVaSgEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29347281"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; d="scan'208";a="29347281"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 01:01:02 -0700
X-CSE-ConnectionGUID: TH9JHLYMRQC2mmpEDsJ5ZA==
X-CSE-MsgGUID: CHvEUauZQWyybyExXorTsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; d="scan'208";a="80312912"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 01:00:58 -0700
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
Subject: [PATCH v4] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
Date: Wed, 23 Oct 2024 15:57:53 +0800
Message-Id: <20241023075753.580534-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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
introduce a property "stale-tm" to allow user to control the setting.

Use hw_compat_9_1 to handle the compatibility for machines before 9.2 which
allow guest to set the field. Starting from 9.2, this field is reserved(0)
by default to match spec. Of course, user can force it on command line.

This doesn't impact function of vIOMMU as there was no logic to emulate
Transient Mapping.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v4: s/x-stale-tm/stale-tm (Jason)
v3: still need to check x86_iommu->dt_supported
v2: introcude "x-stale-tm" to handle migration compatibility (Jason)

 hw/i386/intel_iommu_internal.h | 12 ++++++------
 include/hw/i386/intel_iommu.h  |  3 +++
 hw/i386/intel_iommu.c          |  7 ++++---
 hw/i386/pc.c                   |  1 +
 4 files changed, 14 insertions(+), 9 deletions(-)

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
index 08fe218935..8612d0917b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3372,6 +3372,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
+    DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -4138,15 +4139,15 @@ static void vtd_init(IntelIOMMUState *s)
      */
     vtd_spte_rsvd[0] = ~0ULL;
     vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
+                                        x86_iommu->dt_supported && s->stale_tm);
     vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
 
     vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+                                        x86_iommu->dt_supported && s->stale_tm);
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+                                        x86_iommu->dt_supported && s->stale_tm);
 
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2047633e4c..830614d930 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -82,6 +82,7 @@
 GlobalProperty pc_compat_9_1[] = {
     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
+    { TYPE_INTEL_IOMMU_DEVICE, "stale-tm", "on" },
 };
 const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
 
-- 
2.34.1


