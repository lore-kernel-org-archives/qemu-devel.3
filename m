Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E54ACD043F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0LO-0004xQ-H0; Tue, 06 Jan 2026 01:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0Kn-0004HY-4i
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:28 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0Kl-0007KE-IB
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680064; x=1799216064;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1j2XPGhWMf3qhGvRwJmZwvU1wHOP9IAgJszP6UNK7NM=;
 b=mTszGFQ/HNa4LJb2yMRmRaZo0/Y+2DObFNiY5b7xXDueo+yXqIdA0pbS
 fTqIOzaja8knz6nQL6NxlZo0A37kYjiJo7Qk3H6JF4KqLQzg6MzHLH0c9
 I8WN2v8LT7BxhWtePOuJyz/Atr4XmNXMtVMjs5Cn2TKlcXSQN55g5UAMR
 b9wosBses+OA/rQIlspfehmJImUZIf1EpBiU68HpHZcNgLS06mwiWHCqd
 sT/b2OKOT/iZEisNRINzlOtPqbC1MXAO65UtVxHzxtCrmAZL1afVgqEWs
 1wKK5UUFh4KiaEUpNlXvJcfntMf1pX/IcTvhcT42JMTTP0MpDkQxValbR A==;
X-CSE-ConnectionGUID: rcNSgTLeSpaL18Jg9qrsbw==
X-CSE-MsgGUID: vHzIFNuFSVOeUJwSe1BGJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094064"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094064"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:23 -0800
X-CSE-ConnectionGUID: mHMlmKKuQeOSeRmnxkJoIA==
X-CSE-MsgGUID: Wq8zODl0RPOwA3IOAWxm7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588900"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:19 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 15/19] intel_iommu: Replay all pasid bindings when either
 SRTP or TE bit is changed
Date: Tue,  6 Jan 2026 01:12:57 -0500
Message-ID: <20260106061304.314546-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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

From: Yi Liu <yi.l.liu@intel.com>

When either 'Set Root Table Pointer' or 'Translation Enable' bit is changed,
all pasid bindings on host side become stale and need to be updated.

Introduce a helper function vtd_replay_pasid_bindings_all() to go through all
pasid entries in all passthrough devices to update host side bindings.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2889c29102..3241af811c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -76,6 +76,7 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
 {
@@ -2629,6 +2630,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_replay_pasid_bindings_all(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -2663,6 +2665,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_replay_pasid_bindings_all(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -3162,6 +3165,13 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     vtd_iommu_unlock(s);
 }
 
+static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .type = VTD_INV_DESC_PASIDC_G_GLOBAL };
+
+    vtd_pasid_cache_sync(s, &pc_info);
+}
+
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
                                    VTDInvDesc *inv_desc)
 {
-- 
2.47.1


