Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B69D73094
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ve4-0001LU-6g; Thu, 02 Apr 2026 23:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdx-0001K6-Tn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:26 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdv-0004N9-Cw
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188583; x=1806724583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0MFb3HenNSUls1fHNRaU0yBgX5qm6xrytDacYEjt9Sg=;
 b=k/e5dIQxz3qsTO9GfoXwAwuJAlbwAVbUtqq2KrSiI4eRHKNDBX+oVRo3
 pT9mV11MWlKen85gn2byCiXWIJp+nZrlZ79pExzU3dzoHMyk3wBz5ZG3Y
 jiajZCC0OElCVJ/2Apkqu6tVXa1EcWkK2yB6UM4K1RGlRgI2If2+opfHQ
 yAx31RYW5b3pw7vBnh3RyqsfzRZ/DvVj7dhaU7yfbUkxxWVwAVLNekO6q
 jciS60MfyqEOVmwxwo+4JZaN5aRATFsJPwceQLe3aRcZKEzrS1jCscoog
 V5EpgJUYlw1RlRxOTN6adcY/ae1vFtcIN6Xe0cSWTkm3cyuI20Q3+9Aaa A==;
X-CSE-ConnectionGUID: 96jB31MqQryBNTidhD7/9g==
X-CSE-MsgGUID: aVfGJ3wyS2SakPUGKZOvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140657"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140657"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:22 -0700
X-CSE-ConnectionGUID: 0sfQhFlOQVyjMHPwBRX5mg==
X-CSE-MsgGUID: xAbM44NEQSSw4aTr0lFT1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884904"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 09/14] intel_iommu_accel: Handle PASID entry removal for
 pc_inv_dsc request
Date: Thu,  2 Apr 2026 23:55:33 -0400
Message-ID: <20260403035541.18355-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403035541.18355-1-zhenzhong.duan@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 46250aa75c..b951d90135 100644
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
@@ -422,6 +495,13 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
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


