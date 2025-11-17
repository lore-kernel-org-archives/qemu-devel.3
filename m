Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE388CEBF93
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvhX-0004NO-1o; Mon, 17 Nov 2025 04:39:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhQ-0004LQ-N8
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:06 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhO-0006HR-Dk
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372342; x=1794908342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4BT+d0D/HOhqnjY6XYfosheQDzftMiFU2NwzkVvs544=;
 b=MV7b7EtrP3BTUW+o+C7pvGf9CerGnPl2cG1qrlrxJaXfOe+wOVjvKqAb
 8ygigRRDFPL/qEauBITXshbc3M2Ltwfa1ER9l8MM7p0C1FAr3QLVyGZUb
 FZmA3lCof1fDfS/euqXR4SIEjC0itZlbLkoKQ0DZBgW+WfXm0PQhFNjOp
 eGlWmJlQNjDO32U1YNc1QqSKuYhGvf9v+4hzpyxNg7nFG6ELBCJpcCxk0
 15KrKMBNDY/iP6435QX1X7tVADdIycP4pWhRGBrPRNrq6eZgyIzx40Z76
 ICiGKIXTasckoe0gB3lWOdL1+GX4adNv999j2klcB4DjvYBWSngUcEibI w==;
X-CSE-ConnectionGUID: qkXuTiVfQ5KK2w7SkuIVCA==
X-CSE-MsgGUID: r7dragELRh+ZFSySjTyCcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76045942"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76045942"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:01 -0800
X-CSE-ConnectionGUID: WktvqDBWSUiPcaKXmgsSrw==
X-CSE-MsgGUID: 6Z9csp4sRoerIprlGj+NvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070903"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:38:57 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 07/23] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Date: Mon, 17 Nov 2025 04:37:10 -0500
Message-ID: <20251117093729.1121324-8-zhenzhong.duan@intel.com>
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

Introduce a new structure VTDHostIOMMUDevice which replaces
HostIOMMUDevice to be stored in hash table.

It includes a reference to HostIOMMUDevice and IntelIOMMUState,
also includes BDF information which will be used in future
patches.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h |  7 +++++++
 include/hw/i386/intel_iommu.h  |  2 +-
 hw/i386/intel_iommu.c          | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 3330298884..02522f64e0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -28,6 +28,7 @@
 #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
 #define HW_I386_INTEL_IOMMU_INTERNAL_H
 #include "hw/i386/intel_iommu.h"
+#include "system/host_iommu_device.h"
 
 /*
  * Intel IOMMU register specification
@@ -678,4 +679,10 @@ typedef struct VTDPASIDCacheInfo {
 /* Bits to decide the offset for each level */
 #define VTD_LEVEL_BITS           9
 
+typedef struct VTDHostIOMMUDevice {
+    IntelIOMMUState *iommu_state;
+    PCIBus *bus;
+    uint8_t devfn;
+    HostIOMMUDevice *hiod;
+} VTDHostIOMMUDevice;
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 0b7832d25d..401322665a 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -302,7 +302,7 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
-    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
+    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 43f3a49769..3095d78321 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -289,7 +289,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
 
 static void vtd_hiod_destroy(gpointer v)
 {
-    object_unref(v);
+    VTDHostIOMMUDevice *vtd_hiod = v;
+
+    object_unref(vtd_hiod->hiod);
+    g_free(vtd_hiod);
 }
 
 static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
@@ -4602,6 +4605,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
     IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hiod;
     struct vtd_as_key key = {
         .bus = bus,
         .devfn = devfn,
@@ -4624,7 +4628,14 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    vtd_hiod = g_malloc0(sizeof(VTDHostIOMMUDevice));
+    vtd_hiod->bus = bus;
+    vtd_hiod->devfn = (uint8_t)devfn;
+    vtd_hiod->iommu_state = s;
+    vtd_hiod->hiod = hiod;
+
     if (!vtd_check_hiod(s, hiod, errp)) {
+        g_free(vtd_hiod);
         vtd_iommu_unlock(s);
         return false;
     }
@@ -4634,7 +4645,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     new_key->devfn = devfn;
 
     object_ref(hiod);
-    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hiod);
 
     vtd_iommu_unlock(s);
 
-- 
2.47.1


