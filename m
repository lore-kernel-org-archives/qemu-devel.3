Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2620CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvic-0005d0-8p; Mon, 17 Nov 2025 04:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKviT-0005Fp-Ro
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:40:11 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKviO-0006Kp-JX
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372405; x=1794908405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OkrsG+esTKod4mdcx5QKPDhC8H4DEd9zDUZfqRFMN4U=;
 b=UbKiL2bufxEuyg+XvHdhjMm8PZ936KxqDptDgIXb81+lH6upFcp2n4q/
 239uoceVSXOMfqLxFvtQ0lBEUZyUt9M0DuYJUnk98aUUzr8Fa+RrZ+J1r
 hlHDaMMspQxShuwz9KyuiiMdZ2XxGkyoO29D4rPl5FmyDUIYRRLowv5ja
 fS+Pu0KZw2Vo1hR6SYP6EtRdmOWMYLFo6a6QPqDtdFRzlIYkUtROLic9n
 GEmEWrqSXEX1X7r/ZfNtmbzHydBw/KGZJ7CX+3K5Wy2fjn1rkhOa1o1Pl
 cQyAL9Upga5sL1uAKR0hF1d3qtydCHuaM8vwAFg2bHfdOs3O8J5EDqoo6 g==;
X-CSE-ConnectionGUID: 1QPRjCzMQYWwSlRu+fpDLw==
X-CSE-MsgGUID: TTS/3A13SuO4E9DLj3gluA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76046089"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76046089"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:51 -0800
X-CSE-ConnectionGUID: hMKXZCzEQNWz/U4xmtv9sg==
X-CSE-MsgGUID: 8eYwztzuS6O7NdD/hZEfzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190071002"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:47 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 20/23] intel_iommu_accel: Implement get_host_iommu_quirks()
 callback
Date: Mon, 17 Nov 2025 04:37:23 -0500
Message-ID: <20251117093729.1121324-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Implement get_host_iommu_quirks() callback to retrieve the vendor specific
hardware information data and convert it into bitmaps defined with enum
host_iommu_quirks. It will be used by VFIO in subsequent patch.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h |  5 +++++
 hw/i386/intel_iommu.c       |  2 ++
 hw/i386/intel_iommu_accel.c | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 76862310c2..c7ad6daa87 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -20,6 +20,7 @@ bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
 void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -46,5 +47,9 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
                                                     uint64_t npages, bool ih)
 {
 }
+
+static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+}
 #endif
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 269b7da958..33ed11e207 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5590,6 +5590,8 @@ static void vtd_class_init(ObjectClass *klass, const void *data)
     x86_class->int_remap = vtd_int_remap;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Intel IOMMU (VT-d) DMA Remapping device";
+
+    vtd_iommu_ops_update_accel(&vtd_iommu_ops);
 }
 
 static const TypeInfo vtd_info = {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 41d0e4107b..700284864d 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -12,6 +12,7 @@
 #include "system/iommufd.h"
 #include "intel_iommu_internal.h"
 #include "intel_iommu_accel.h"
+#include "hw/iommu.h"
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
@@ -251,3 +252,23 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach(s->vtd_address_spaces,
                          vtd_flush_host_piotlb_locked, &piotlb_info);
 }
+
+static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
+                                          void *caps, uint32_t size)
+{
+    struct iommu_hw_info_vtd *vtd = caps;
+    uint64_t quirks = 0;
+
+    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
+        sizeof(struct iommu_hw_info_vtd) <= size &&
+        vtd->flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
+    }
+
+    return quirks;
+}
+
+void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
+{
+    ops->get_host_iommu_quirks = vtd_get_host_iommu_quirks;
+}
-- 
2.47.1


