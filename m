Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D94C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhUs-0007Di-Bs; Wed, 21 May 2025 07:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUf-0006rI-AN
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:20:20 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUc-0006eB-JR
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826414; x=1779362414;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JYjpbRjIjKR0Gja310odOFYqYkbagbfHA+iNIYGMZkI=;
 b=l3OjHlTh9W08qAGsBuNH92aUOwEy/EFYUMPCGByimDDpq1rikVNHsAj2
 6hIt2w6QC4GGWO2FitSaRbmxi4WUrb6qOWWG8dvku5R89iWuj70LEHWSP
 qGE7quI6tNPE9FsaIUeomiAxdCQluLSSMsu1P3bSinfRsYwX58ssRNmwZ
 mBHf6Bwb+HA0X6fUXocQalmFoCpR3P0WdvYa57Qqof3J9TFVTyGdJ7I/U
 bzZLibkTUIzAYYpsO6LCFmCiXZNCGQX2p74Ym8JC9mAvSmZtyNiwmpMVj
 syK9BBVzC+xI/46ZWmE3ZnQZAVT5nRPXVxmvsMO9hZrfWZRD0cnbHYiFx A==;
X-CSE-ConnectionGUID: eZo20kAlRU6U389+lTg1WQ==
X-CSE-MsgGUID: 2kZD3j+qR4Cyh70sRkY/fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49895175"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49895175"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:20:12 -0700
X-CSE-ConnectionGUID: VdAQK/qJQt6eG+5sb+49/Q==
X-CSE-MsgGUID: q/60nqvvSVycJXzm5Fz3FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158488"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:20:07 -0700
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
Subject: [PATCH rfcv3 19/21] intel_iommu: Refresh pasid bind when either SRTP
 or TE bit is changed
Date: Wed, 21 May 2025 19:14:49 +0800
Message-Id: <20250521111452.3316354-20-zhenzhong.duan@intel.com>
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
index bb21060d7e..b8f3b8effa 100644
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


