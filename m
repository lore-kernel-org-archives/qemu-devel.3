Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F827CD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLZ0H-0001Jt-Au; Sat, 09 May 2026 00:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ0E-0001J5-AY
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ0C-0000O8-LE
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299760; x=1809835760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w57PrZ7fPgRo17DBnfcZ635ZEaNNGi59zZYLsqxNamM=;
 b=PgdLZO1kMV8i6uvEYzugrl8FrQkOXCqilTEIK2Jgc7aNFAaA4NfaAO2h
 8NBnVlsKdlPhHwJiqeVK4ipKbVTbsN5RNRw1I3O937KF75UjCtA/zNgYC
 4MyT311RQ6FLWYNMHoHdq7xHtujsNU4/qvaEFWAp95QWieONdxsRv8clh
 COl4/NB09Oo2ihKXCvIfoDbjM/8wam278eYaDHzMB8DgxoDeEpjWovmaI
 5g0kviuxhZHs5aM2o8+Fs1VyKz4U0GuVoP12WEKZAL0pWs5tAO/Kehnsz
 4s0OidLaKXVrvLuueJPVwhRjiXBrDaxYA1IbiLqAM80SZmtafBRNmp7xG Q==;
X-CSE-ConnectionGUID: ljNLHYCcTYG+VO5PA09sSQ==
X-CSE-MsgGUID: h7t48smoQAOT5e474I3A9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654477"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654477"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:17 -0700
X-CSE-ConnectionGUID: 1NgmlzGrQueL1LE4o0M3tQ==
X-CSE-MsgGUID: rYWZ/VsiTPWRA8669Kk24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966554"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal for
 pc_inv_dsc request
Date: Sat,  9 May 2026 00:08:03 -0400
Message-ID: <20260509040819.1044702-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When guest deletes PASID entries, QEMU will capture the pasid cache
invalidation request, walk through pasid_cache_list in each passthrough
device to find stale VTDAccelPASIDCacheEntry and delete them.

Co-developed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index a66d63b4c8..82bfbdf484 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -16,6 +16,28 @@
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
+static int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
+                                      VTDPASIDEntry *pe)
+{
+    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
+    IntelIOMMUState *s = vtd_hiod->iommu_state;
+    uint32_t pasid = vtd_pce->pasid;
+    VTDContextEntry ce;
+    int ret;
+
+    if (!s->dmar_enabled || !s->root_scalable) {
+        return -VTD_FR_RTADDR_INV_TTM;
+    }
+
+    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
+                                   vtd_hiod->devfn, &ce);
+    if (ret) {
+        return ret;
+    }
+
+    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
+}
+
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp)
 {
@@ -280,6 +302,57 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 }
 
+static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
+{
+    QLIST_REMOVE(vtd_pce, next);
+    g_free(vtd_pce);
+}
+
+static void
+vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
+                                     VTDPASIDCacheInfo *pc_info)
+{
+    VTDPASIDEntry pe;
+    uint16_t did;
+
+    /*
+     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
+     * DID check. If DID doesn't match the value in cache or memory, then
+     * it's not a pasid entry we want to invalidate.
+     */
+    switch (pc_info->type) {
+    case VTD_INV_DESC_PASIDC_G_PASID_SI:
+        if (pc_info->pasid != vtd_pce->pasid) {
+            return;
+        }
+        /* Fall through */
+    case VTD_INV_DESC_PASIDC_G_DSI:
+        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pasid_entry);
+        if (pc_info->did != did) {
+            return;
+        }
+    }
+
+    if (vtd_hiod_get_pe_from_pasid(vtd_pce, &pe)) {
+        /*
+         * No valid pasid entry in guest memory. e.g. pasid entry was modified
+         * to be either all-zero or non-present. Either case means existing
+         * pasid cache should be invalidated.
+         */
+        vtd_accel_delete_pc(vtd_pce);
+    }
+}
+
+static void vtd_accel_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
+                                             VTDPASIDCacheInfo *pc_info)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce, *next;
+
+    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
+        vtd_accel_pasid_cache_invalidate_one(vtd_pce, pc_info);
+    }
+}
+
 /*
  * This function walks over PASID range within [start, end) in a single
  * PASID table for entries matching @info type/did, then create
@@ -411,6 +484,13 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
                                  TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
             continue;
         }
+
+        /*
+         * PASID entry removal is handled before addition intentionally,
+         * because it's unnecessary to iterate on an entry that will be
+         * removed.
+         */
+        vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
         vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
     }
 }
-- 
2.47.3


