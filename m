Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FEACCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 09:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gss-0002SO-5M; Fri, 17 Oct 2025 05:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9gsp-0002RN-Hg
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:36:23 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9gsm-0004yA-OY
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 05:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760693780; x=1792229780;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D2e+ESwtLZs18uXR9FupPKhFMkUPPRdSzpQnflsXbK8=;
 b=cb/m9W9KmeUjIsorxdve2eethmcfIStODWXFa0bpH0Ik4C3T4OTKVcDK
 ZOZVOdzxDwCoeV3gI16fiFILD5RZTvOph0vCs6y+yRZqQUfb5ZtzGxkhB
 qPHHwaWJlqKBbZxl6u0sJ518L5+G5L6nfYlIhmfBFZDHIScP9t0B5dESy
 JuZ8cgi096TVl04+NmhBwcxYKuB8zEselTiWZEreFLKc47SbSOHOOmAVD
 H688mnKL4rNZGxxO8O+heuhvYE6z+SWrvYr3byybUm5LHFlZQ2+ZWCJDp
 Ls8JIssJBa7bjeVkk1eDYHzrdplPBK6uwkvlCcRn4DDpCgWcP3MHKNGMN g==;
X-CSE-ConnectionGUID: 6pOh0/2wSRSMbYG1tE5fqg==
X-CSE-MsgGUID: m5199TQxQTae4b2z4qLMuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62805641"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="62805641"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 02:36:15 -0700
X-CSE-ConnectionGUID: j03yQWz/QPmFZ1fXxVlsGg==
X-CSE-MsgGUID: XUG/lOJvSaKJ/ns+l/5xwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; d="scan'208";a="186720564"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 02:36:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 2/3] intel_iommu: Reset pasid cache when system level reset
Date: Fri, 17 Oct 2025 05:36:01 -0400
Message-ID: <20251017093602.525338-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251017093602.525338-1-zhenzhong.duan@intel.com>
References: <20251017093602.525338-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
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


