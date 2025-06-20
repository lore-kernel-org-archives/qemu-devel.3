Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C74C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5J-0004cl-JK; Fri, 20 Jun 2025 03:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5B-0004bc-Bj
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:43 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW59-0008IS-3d
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404159; x=1781940159;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RZS2p55dxo9IOvEV82x8xQCu503ewsLCel29bMAyhS4=;
 b=GfTWAA+GDhlVNaO5I0IIjjR01hqHbUo9uHS8B49qUTTZrjiaUM8RF/fu
 f3tTB+hbzYWVeuWhyWSqqaGpRZpqHCsOWI2A9dhE/Qf0bG9ffOcp6BLHx
 T19xfNdXjU3ApaGszkvpaMWvp6IsZrXErE7/4YjFFvJCnG1EX/KQdT70D
 BFcC74CJscxyq9qSJMZ71NynoSMnnMiyhCaTL890sjpfjMz8XHGqKo6pQ
 Y+mM+uWEqYund315pc+Fxisk5sXUcaqwvabcnRlxP+fQ9/tn/2BJl6W2W
 GhrUNw8GJjJdWLdRD0u6YJiQvXJ9KqebcpgKzZKI05NcM4y7RMuxJbnYD w==;
X-CSE-ConnectionGUID: PQjXw4auQVWgF6L5G9M0PA==
X-CSE-MsgGUID: NHhLl9w8Sk283lvOm+ojzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532330"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532330"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:38 -0700
X-CSE-ConnectionGUID: w1vRtc4MT2GpkeN0Tw5cnA==
X-CSE-MsgGUID: Gu5ZxCJPRn2AAGm6ci4ngQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863111"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 06/19] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Date: Fri, 20 Jun 2025 15:18:00 +0800
Message-Id: <20250620071813.55571-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

Introduce a new structure VTDHostIOMMUDevice which replaces
HostIOMMUDevice to be stored in hash table.

It includes a reference to HostIOMMUDevice and IntelIOMMUState,
also includes BDF information which will be used in future
patches.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  7 +++++++
 include/hw/i386/intel_iommu.h  |  2 +-
 hw/i386/intel_iommu.c          | 15 +++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e8b211e8b0..7aba259ef8 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -28,6 +28,7 @@
 #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
 #define HW_I386_INTEL_IOMMU_INTERNAL_H
 #include "hw/i386/intel_iommu.h"
+#include "system/host_iommu_device.h"
 
 /*
  * Intel IOMMU register specification
@@ -607,4 +608,10 @@ typedef struct VTDRootEntry VTDRootEntry;
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
index e95477e855..50f9b27a45 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -295,7 +295,7 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
-    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
+    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
 
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 702973da5c..e90fd2f28f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -281,7 +281,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
 
 static void vtd_hiod_destroy(gpointer v)
 {
-    object_unref(v);
+    VTDHostIOMMUDevice *vtd_hiod = v;
+
+    object_unref(vtd_hiod->hiod);
+    g_free(vtd_hiod);
 }
 
 static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
@@ -4360,6 +4363,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
     IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hiod;
     struct vtd_as_key key = {
         .bus = bus,
         .devfn = devfn,
@@ -4376,7 +4380,14 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
@@ -4386,7 +4397,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     new_key->devfn = devfn;
 
     object_ref(hiod);
-    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hiod);
 
     vtd_iommu_unlock(s);
 
-- 
2.34.1


