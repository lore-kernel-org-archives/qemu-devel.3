Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851C5C54E92
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhUz-0007Wx-H8; Wed, 21 May 2025 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUJ-000695-HC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:55 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUC-0006WB-Tq
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826388; x=1779362388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3K50eCvsdiQRtVIiYWqzkx8n0RxYaguzz/yR54JEsYE=;
 b=LBUh7RTm6pB4i7DMpXW+/ZYTPUmnM9GlrSRfcXiCfkiXxj5Wj7CLg9CH
 aqERSKoqlDH//B/9jUS64MTLnvixjShmfi2xgnLGzaK0SrBRrKHBy1qQY
 PJZi3EPO7xaThdnHXDWH59Wf5GlPCfHIwhfonhj+XCDcB7D5OhboBcg5T
 J9c8Y/ggA4QrEXue3wUSa84m6ERFu+tkqZm86z5fgGQ+iny9H04l8rMMG
 AJ+Im37bCIt51BcVXNnpxyi6MQIYSSGC2lsfm44lydSx6pCzF07cH6pz8
 t689lqkSo2J4Lg5cNjTUiSl84dkhZdgylJIr9PyT78CflNSzN8+UV9aZE Q==;
X-CSE-ConnectionGUID: OVIXqqlnTryBAWe6H6INzw==
X-CSE-MsgGUID: dwShg3QJT9ahlIF3ynHR1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49895101"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49895101"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:46 -0700
X-CSE-ConnectionGUID: T9mGUAHnQfeNSirbFbvS9Q==
X-CSE-MsgGUID: p4S455VQQcmL/VIsYmiRmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158373"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:41 -0700
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
Subject: [PATCH rfcv3 14/21] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Date: Wed, 21 May 2025 19:14:44 +0800
Message-Id: <20250521111452.3316354-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
underlying pasid entry is still valid, it drops all the pasid caches.

FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
only used internally in system level reset.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
 hw/i386/trace-events           |  1 +
 3 files changed, 31 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 4f6d9e9036..5e5583d94a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -564,6 +564,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
 
 typedef enum VTDPCInvType {
+    /* Force reset all */
+    VTD_PASID_CACHE_FORCE_RESET = 0,
     /* pasid cache invalidation rely on guest PASID entry */
     VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
     VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 8d9076216c..050b0d3ca2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -86,6 +86,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
+
 static void vtd_panic_require_caching_mode(void)
 {
     error_report("We need to set caching-mode=on for intel-iommu to enable "
@@ -390,6 +392,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
@@ -3186,6 +3189,8 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
     }
 
     switch (pc_info->type) {
+    case VTD_PASID_CACHE_FORCE_RESET:
+        goto remove;
     case VTD_PASID_CACHE_PASIDSI:
         if (pc_info->pasid != pasid) {
             return false;
@@ -3239,6 +3244,26 @@ remove:
     return true;
 }
 
+/* Caller of this function should hold iommu_lock */
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_reset();
+
+    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
+
+    /*
+     * Reset pasid cache is a big hammer, so use g_hash_table_foreach_remove
+     * which will free the vtd_as instances. Also, as a big hammer, use
+     * VTD_PASID_CACHE_FORCE_RESET to ensure all the vtd_as instances are
+     * dropped, meanwhile the change will be passed to host if
+     * HostIOMMUDeviceIOMMUFD is available.
+     */
+    g_hash_table_foreach_remove(s->vtd_address_spaces,
+                                vtd_flush_pasid, &pc_info);
+}
+
 static void vtd_sm_pasid_table_walk_one(IntelIOMMUState *s,
                                         dma_addr_t pt_base,
                                         int start,
@@ -3366,6 +3391,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     case VTD_PASID_CACHE_GLOBAL_INV:
         /* loop all assigned devices */
         break;
+    case VTD_PASID_CACHE_FORCE_RESET:
+        /* For force reset, no need to go further replay */
+        return;
     default:
         error_report("invalid pc_info->type for replay");
         abort();
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ae5bbfcdc0..c8a936eb46 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
-- 
2.34.1


