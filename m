Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5205CD043F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0KX-0003PZ-Gw; Tue, 06 Jan 2026 01:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0KV-0003Ne-MI
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:07 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0KT-0007JN-VC
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680046; x=1799216046;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sr9MnH4s1/ZT5Y57AsuK13UQrrgvHMmHqLScrqc26BI=;
 b=YIzOz4FhyFZKliX4IFbFU61tQBFbIAlq73TqSWC+mKXPHxzq/KQMRTy9
 NORVIIgKJGukvqfX4pcLXKcc6HlmnY5JDUlULkZWdFmWyL4weQvrrgCTg
 t7L5mvaFvNSVSPxZAKHEdTZCMtFLXAzSHYNYYN8kzVcmaPfY7lTn/e3Gx
 4m0BVSEOmo95tS/AL/GeuA/lFDySkWhq9xC7C8JV/JoUGIo8HamchbGow
 e9tIygqq7KgQKOed5w6jlaKGXywukJiBsYJJKrRVdvPxRU7Xp1r5lQpfe
 Dz/IYFts5BJ4Rl7cy9bFVcwCLeIq/flMGhy8ubF156Mw69PKDNIOq8DKh A==;
X-CSE-ConnectionGUID: kOCsFbP2Rf24Nr3OtE/rrg==
X-CSE-MsgGUID: /Cx/wUIrTFG7HW4plAmBQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094022"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094022"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:04 -0800
X-CSE-ConnectionGUID: 5onLJrM2S9W0BBlYUrtc7w==
X-CSE-MsgGUID: HmR/76+/QPiNC2HWJ/oYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588847"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:00 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 11/19] intel_iommu_accel: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Date: Tue,  6 Jan 2026 01:12:53 -0500
Message-ID: <20260106061304.314546-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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

When guest enables scalable mode and setup first stage page table, we don't
want to use IOMMU MR but rather continue using the system MR for IOMMUFD
backed host device.

Then default HWPT in VFIO contains GPA->HPA mappings which could be reused
as nesting parent HWPT to construct nested HWPT in vIOMMU.

Move vtd_as_key into intel_iommu_internal.h as it's also used by accel code.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu_accel.h    |  6 ++++++
 hw/i386/intel_iommu_internal.h | 11 +++++++++++
 hw/i386/intel_iommu.c          | 28 +++++++++++++++-------------
 hw/i386/intel_iommu_accel.c    | 18 ++++++++++++++++++
 4 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index 76e0d26942..d049cab3e1 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -15,6 +15,7 @@
 #ifdef CONFIG_VTD_ACCEL
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
+VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
                                         VTDHostIOMMUDevice *vtd_hiod,
@@ -24,5 +25,10 @@ static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
     error_append_hint(errp, "CONFIG_VTD_ACCEL is not enabled");
     return false;
 }
+
+static inline VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    return NULL;
+}
 #endif
 #endif
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 02522f64e0..d8dad18304 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -685,4 +685,15 @@ typedef struct VTDHostIOMMUDevice {
     uint8_t devfn;
     HostIOMMUDevice *hiod;
 } VTDHostIOMMUDevice;
+
+/*
+ * PCI bus number (or SID) is not reliable since the device is usaully
+ * initialized before guest can configure the PCI bridge
+ * (SECONDARY_BUS_NUMBER).
+ */
+struct vtd_as_key {
+    PCIBus *bus;
+    uint8_t devfn;
+    uint32_t pasid;
+};
 #endif
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0817b17772..d5a4e02fa1 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -55,17 +55,6 @@
 #define VTD_PE_GET_SS_LEVEL(pe) \
     (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
 
-/*
- * PCI bus number (or SID) is not reliable since the device is usaully
- * initialized before guest can configure the PCI bridge
- * (SECONDARY_BUS_NUMBER).
- */
-struct vtd_as_key {
-    PCIBus *bus;
-    uint8_t devfn;
-    uint32_t pasid;
-};
-
 /* bus/devfn is PCI device's real BDF not the aliased one */
 struct vtd_hiod_key {
     PCIBus *bus;
@@ -1730,12 +1719,25 @@ static bool vtd_as_pt_enabled(VTDAddressSpace *as)
 /* Return whether the device is using IOMMU translation. */
 static bool vtd_switch_address_space(VTDAddressSpace *as)
 {
+    IntelIOMMUState *s;
     bool use_iommu, pt;
 
     assert(as);
 
-    use_iommu = as->iommu_state->dmar_enabled && !vtd_as_pt_enabled(as);
-    pt = as->iommu_state->dmar_enabled && vtd_as_pt_enabled(as);
+    s = as->iommu_state;
+    use_iommu = s->dmar_enabled && !vtd_as_pt_enabled(as);
+    pt = s->dmar_enabled && vtd_as_pt_enabled(as);
+
+    /*
+     * When guest enables scalable mode and sets up first stage page table,
+     * we stick to system MR for IOMMUFD backed host device. Then its
+     * default hwpt contains GPA->HPA mappings which is used directly if
+     * PGTT=PT and used as nesting parent if PGTT=FST. Otherwise fall back
+     * to original processing.
+     */
+    if (s->root_scalable && s->fsts && vtd_find_hiod_iommufd(as)) {
+        use_iommu = false;
+    }
 
     trace_vtd_switch_address_space(pci_bus_num(as->bus),
                                    VTD_PCI_SLOT(as->devfn),
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index ead6c42879..ebfc503d64 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -50,3 +50,21 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                "host IOMMU is incompatible with guest first stage translation");
     return false;
 }
+
+VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
+{
+    IntelIOMMUState *s = as->iommu_state;
+    struct vtd_as_key key = {
+        .bus = as->bus,
+        .devfn = as->devfn,
+    };
+    VTDHostIOMMUDevice *vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev,
+                                                       &key);
+
+    if (vtd_hiod && vtd_hiod->hiod &&
+        object_dynamic_cast(OBJECT(vtd_hiod->hiod),
+                            TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        return vtd_hiod;
+    }
+    return NULL;
+}
-- 
2.47.1


