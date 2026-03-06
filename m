Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 949BCF513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyM7Q-0004Nc-3b; Thu, 05 Mar 2026 22:44:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7O-0004NE-4a
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:44:50 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7M-00066q-Ip
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772768688; x=1804304688;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PKdn5LzomzWI5ewjG4Qibnqt/n1gU9PWe89FsmPl/so=;
 b=AB430QoAmg1aseBE3qEgk9p0X+NC3Q5NPtVWcSaVAdqWuArT5cjsHKeD
 SAelu1+hZLyVZUckmbNYRilP8GVl/FPX/WI6/W2aEDzlf5psU1bBfBET/
 FU8GS88pkia5smSrfYJKWs2fnUJbiVr6GkSdlydlEQ8tuq0Fp+gNG8DjF
 vKWr7lt/GnpymJ6nV4asx9MtlxskWuq/G3+JNFofTYPvcSJjcpndJUU+K
 nKp6xPGYrSPB85BrzohABSU33nmKcS6f9fY2XVmyipQBIyFrP+LQ551HE
 b293/3eATleo2A/Wj4E+Azq3GQ+1hIxGSdSsTy4qac1rcvxRK+LF9Ws6O Q==;
X-CSE-ConnectionGUID: fXC1aQwDTpSO3lNTb7CY9A==
X-CSE-MsgGUID: fXq4D9boRVKYOYINYBdplw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91448304"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91448304"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:48 -0800
X-CSE-ConnectionGUID: EnSih1SOTtKqFHpLqqtzgQ==
X-CSE-MsgGUID: qwPi/f/yTlOJad14PAmsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215613388"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:44 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Date: Thu,  5 Mar 2026 22:44:02 -0500
Message-ID: <20260306034409.184873-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306034409.184873-1-zhenzhong.duan@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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
device to find stale VTDACCELPASIDCacheEntry and delete them.

This happen before the PASID entry addition, because a new added entry
should never be removed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.c | 70 +++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 0acf3ae77f..5a956af916 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -16,6 +16,28 @@
 #include "hw/pci/pci_bus.h"
 #include "trace.h"
 
+static inline int vtd_hiod_get_pe_from_pasid(VTDACCELPASIDCacheEntry *vtd_pce,
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
 
+static void vtd_pasid_cache_invalidate_one(VTDACCELPASIDCacheEntry *vtd_pce,
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
+        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pe);
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
+    VTDACCELPASIDCacheEntry *vtd_pce, *next;
+
+    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
+        vtd_pasid_cache_invalidate_one(vtd_pce, pc_info);
+    }
+}
+
 static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
                             VTDPASIDEntry *pe)
 {
@@ -423,6 +491,8 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
                                  TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
             continue;
         }
+
+        vtd_pasid_cache_invalidate(vtd_hiod, pc_info);
         vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
     }
 }
-- 
2.47.3


