Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB23C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU0w-0000mG-8r; Fri, 06 Jun 2025 06:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0t-0000gr-37
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:27 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0r-0007i7-3x
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204565; x=1780740565;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MwqvMEQzo4CbL5t0IoG9sS/GIbwM3ObDhtoFzCH2qNA=;
 b=cruosfrXPtdvILoOJ/mycWnTSArpctbHFygcdz8NezGjgz+2dt3f7hea
 poJun3FvowC96nCrQfswoER3G/LJ6Gnx7rdtQRMSkCv4lmbDzVscIDPDq
 nUC25mr+scLRj9836z+HEkUT+5Q9eCxgZdVHkb6CXx7DHWP4Rx/fKRyBE
 E6GI68s1qtO0A/I/hTIKhXmhdefO2lBRpLcrRbZXUSjlsVAvlIOP85s6y
 oTr6A3R8odai8rzLUpJVwgnjj8LgPNoeOgC272cKCA/H1ancM58tqPmbn
 52Nm+n1rK1S0R5XzYW2KOJPeWxF3fYY8BwSmvJh0jSMWBFM1CIg22HhQ4 w==;
X-CSE-ConnectionGUID: 6sQlWZebTimOK98cde9Urg==
X-CSE-MsgGUID: mlOiUBruRomOEdQ2jhE3/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747366"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747366"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:23 -0700
X-CSE-ConnectionGUID: TquY0+CNTyeB8LSwrIL34w==
X-CSE-MsgGUID: T1JwbOBvT/WvuNnghesbmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759254"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 13/15] intel_iommu: Refresh pasid bind when either SRTP or
 TE bit is changed
Date: Fri,  6 Jun 2025 18:04:14 +0800
Message-Id: <20250606100416.346132-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

From: Yi Liu <yi.l.liu@intel.com>

When either 'Set Root Table Pointer' or 'Translation Enable' bit is changed,
the pasid bindings on host side become stale and need to be updated.

Introduce a helper function vtd_refresh_pasid_bind() for that purpose.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 79e1cda364..ec8b0ff13a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -89,6 +89,7 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
 static void vtd_pasid_cache_sync(IntelIOMMUState *s,
@@ -3362,6 +3363,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -3396,6 +3398,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -4111,6 +4114,26 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     }
 }
 
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .error_happened = false,
+                                  .type = VTD_PASID_CACHE_GLOBAL_INV };
+
+    /*
+     * Only when dmar is enabled, should pasid bindings replayed,
+     * otherwise no need to replay.
+     */
+    if (!s->dmar_enabled) {
+        return;
+    }
+
+    if (!s->flts || !s->root_scalable) {
+        return;
+    }
+
+    vtd_replay_guest_pasid_bindings(s, &pc_info);
+}
+
 /*
  * This function syncs the pasid bindings between guest and host.
  * It includes updating the pasid cache in vIOMMU and updating the
-- 
2.34.1


