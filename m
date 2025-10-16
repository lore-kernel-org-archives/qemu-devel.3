Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5CACCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 07:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ign-00022S-Lz; Thu, 16 Oct 2025 03:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9Igh-0001vj-0Q
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:46:16 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9Ige-0005Nc-WE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 03:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760600773; x=1792136773;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D2e+ESwtLZs18uXR9FupPKhFMkUPPRdSzpQnflsXbK8=;
 b=JSRdY2XNnkEPy/jDUBukjCYAf7TvP/mu1uxjTXIqwVJ9mptbDIqMEKaE
 3enD/W12x+zGXaoYc5QDJ8vWlpUAWIkXJ0kf9t6jPR0Fb0aXERDhIHhz1
 CF4R6ZZ1SE+rHOnpTardwCx2UGj7XE08pUYyLCalWYmYAvOW2K9zq4Kax
 6eLYRLuud+ywq7rX3VRYR3ot8gVSIV6d2H+0Y9UZ18ht+D9CHJRIbIfrO
 LKhDADfToTy/cAwTifm83SAugBYyuaH5FhKjw1zQyC6DWT8wZy+rLXfad
 pyn7FYpO+SLjbGsUEEWO+61+cdwqFZzO6OTsS3s2FcLG4vHXOCL3a40ZA w==;
X-CSE-ConnectionGUID: 2cce/H4zTUCvTf7iCjsV1Q==
X-CSE-MsgGUID: 8QiXy//iT821+Un4HNPCxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62879145"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="62879145"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 00:46:03 -0700
X-CSE-ConnectionGUID: oMW0J+SrTcGgTl4En4+7QQ==
X-CSE-MsgGUID: u99WdQcUQJaRn5sXbcvaZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="182177524"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 00:46:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/3] intel_iommu: Reset pasid cache when system level reset
Date: Thu, 16 Oct 2025 03:45:43 -0400
Message-ID: <20251016074544.377637-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016074544.377637-1-zhenzhong.duan@intel.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15;
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

Reset pasid cache when system level reset. Currently we don't have any
device supporting PASID yet. So all are PASID_0, its vtd_as is allocated
by PCI system and never removed, just mark pasid cache invalid.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 16 ++++++++++++++++
 hw/i386/trace-events  |  1 +
 2 files changed, 17 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c47f13b659..07bc0a749c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,6 +87,21 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
+{
+    VTDAddressSpace *vtd_as;
+    GHashTableIter as_it;
+
+    trace_vtd_pasid_cache_reset();
+
+    g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
+        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
+        pc_entry->valid = false;
+    }
+}
+
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -381,6 +396,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 298addb24d..b704f4f90c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_inv_desc_pasid_cache_gsi(void) ""
 vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
-- 
2.47.1


