Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAED0106F30F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5glJ-0002o9-1W; Thu, 26 Mar 2026 05:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glG-0002nP-2i
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:19 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glD-0003w6-Nv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516336; x=1806052336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S6cC6lJukGHOwM5+CrGFl0+FheJI+u2VRyvwaFYmsao=;
 b=iSgQUiryfkThtAM4C4FN8Tzsnu+sF71DzN14+Xg+J/R7PMvGqiTqMti5
 VSBDp2HB28HuRhIeJeDsfWbrZLMPf8FDZbBMxOnTGT3AopGLOEZ9dCLtT
 XIRj1uA9OToM44v/AhQshsOBEYdULT41mHaIGspnnnSDP2N8O1vTDXgf5
 TsEGz68Za8sKMz9sPXdHdCCoxoSL0hSiIXuLewZdratm5O0pHIQmeCFk6
 /TZV5IXubDKdHwkIUOmBzoZAI5GewuLNAT3URb3PKFtdRHMoSjZVGxnc0
 tiQ0TgjtR1IzL/b1XGcv4P02gsQ+uXYVvlomfvJo2XXOhz158fA/dzAMu w==;
X-CSE-ConnectionGUID: F8LXQtIyRcGn1aFhwNV65Q==
X-CSE-MsgGUID: D+2XQUMaTDGHw8OazjjQxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531364"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531364"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:14 -0700
X-CSE-ConnectionGUID: rcsHXIP1Rby/hIUz2J91RA==
X-CSE-MsgGUID: aehMUtffQsitKk0FWqHlYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368592"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 08/14] intel_iommu_accel: Handle PASID entry removal for
 pc_inv_dsc request
Date: Thu, 26 Mar 2026 05:11:22 -0400
Message-ID: <20260326091130.321483-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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

This happen before the PASID entry addition, because a new added entry
should never be removed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 75 +++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 32d8ab0ef9..c1285ce331 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -16,6 +16,28 @@
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
+static inline int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
+                                             VTDPASIDEntry *pe)
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
@@ -257,6 +279,52 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                          vtd_flush_host_piotlb_locked, &piotlb_info);
 }
 
+static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
+                                           VTDPASIDCacheInfo *pc_info)
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
+        QLIST_REMOVE(vtd_pce, next);
+        g_free(vtd_pce);
+    }
+}
+
+/* Delete invalid pasid cache entry from pasid_cache_list */
+static void vtd_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
+                                       VTDPASIDCacheInfo *pc_info)
+{
+    VTDAccelPASIDCacheEntry *vtd_pce, *next;
+
+    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
+        vtd_pasid_cache_invalidate_one(vtd_pce, pc_info);
+    }
+}
+
 static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
                               VTDPASIDEntry *pe)
 {
@@ -423,6 +491,13 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
                                  TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
             continue;
         }
+
+        /*
+         * PASID entry removal is handled before addition intentionally,
+         * because it's unnecessary to iterate on an entry that will be
+         * removed.
+         */
+        vtd_pasid_cache_invalidate(vtd_hiod, pc_info);
         vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
     }
 }
-- 
2.47.3


