Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6CCCCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDQ7-0004Zh-2W; Fri, 24 Oct 2025 04:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQ4-0004SO-Hs
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:08 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDPx-0006I7-Tg
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295502; x=1792831502;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3jvcjJxqUdbicL8teg7AXKG3rrdZgjeEBk5/zMcoafA=;
 b=mHIvtUnl3Xynsdc389KVjd1yXzhHSw2bhWbpkEa/4si05P9sjeVel28H
 03g2ePVmlrdyyOwc+DZg+aUcBldpa1s+tDQcCuJBTEFXPtKnoP7nGFYC3
 nS7JCFyKd6GAzTsvCxWq/l6jAVZgwoGvJelzARllVbOj+xpUG7BQBzBdP
 bjvkGj5hyTnmyRaiRv1mHVaiTF9KarksBSeHKEhctsNtz1s5HNANJpHFu
 b7MkK6mXGTFHIFmUPUKl9+aTlPS7rkTsmETq54ckofx4okykjezYygh9I
 Ui0aR1vsUA8/2r9bJwjTj6LGOIjdajh6CXrOy1fm5J9kxdyVS8CQCrXpD g==;
X-CSE-ConnectionGUID: /nktxN2oTumDe2RNeja2zg==
X-CSE-MsgGUID: rH9WIP1iRi2rYAS4TW6jsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504847"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504847"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:01 -0700
X-CSE-ConnectionGUID: U+94MmGuSmKbj/r2zqorXg==
X-CSE-MsgGUID: AsqJ9lOISXyTdP/WOQTe1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183985848"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:44:57 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 07/23] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Date: Fri, 24 Oct 2025 04:43:31 -0400
Message-ID: <20251024084349.102322-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index ba0f1f5096..09edba81e2 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -28,6 +28,7 @@
 #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
 #define HW_I386_INTEL_IOMMU_INTERNAL_H
 #include "hw/i386/intel_iommu.h"
+#include "system/host_iommu_device.h"
 
 /*
  * Intel IOMMU register specification
@@ -677,4 +678,10 @@ typedef struct VTDPASIDCacheInfo {
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
index a84d6965a4..3758ac239c 100644
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
index db5be065bf..4c83578c54 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -291,7 +291,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
 
 static void vtd_hiod_destroy(gpointer v)
 {
-    object_unref(v);
+    VTDHostIOMMUDevice *vtd_hiod = v;
+
+    object_unref(vtd_hiod->hiod);
+    g_free(vtd_hiod);
 }
 
 static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
@@ -4610,6 +4613,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                      HostIOMMUDevice *hiod, Error **errp)
 {
     IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hiod;
     struct vtd_as_key key = {
         .bus = bus,
         .devfn = devfn,
@@ -4632,7 +4636,14 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
@@ -4642,7 +4653,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     new_key->devfn = devfn;
 
     object_ref(hiod);
-    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hiod);
 
     vtd_iommu_unlock(s);
 
-- 
2.47.1


