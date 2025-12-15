Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4111D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2Ri-0000Z6-SX; Mon, 15 Dec 2025 01:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RT-0008WQ-N5
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:26 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RO-0000u9-SM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781540; x=1797317540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FcPKH15Pp4X6wXLsOEyML7aQuUoKDmokaarwxceYBcc=;
 b=aOIGq46LExrJdx/EEizQQZa2/i9UU+w78nDoOXaDKh9ehHr8pVpSK/uA
 br8IJzshcB1c83t+HLhWCn2kQLmuQFSttVM71Tu+iwuOsauitd3CHCZ78
 l2+C7n8I/kATg20kzrmQBC2yf1Yw3kwE5w76Ph5YOJgBn8wmAu/YFKEHb
 T7/bbyaLAi61x4kkTPUmTzYKDK9Wp4WpzYuB/k/rPQd6fOXNFc687Zc/l
 N6uNVBs13g/sq71Ei1tTNvTg6J86HsLm4QbB+zQolbsJDD2arZi8Z8sRH
 Uo7UsqcUGqs8bW5e3G6vW0s/F/YGJ4skkWUY6+iPa5+gPStkXJycz3r39 Q==;
X-CSE-ConnectionGUID: 4OJ+HmxcSo+0KpRGw9nc3w==
X-CSE-MsgGUID: l+dFMySBQ8OhE0epEQ8aYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71305046"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71305046"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:19 -0800
X-CSE-ConnectionGUID: Tnn3g22eQv+FD4t7tChR0Q==
X-CSE-MsgGUID: sQuDSF6qQDydmpAsrb0smA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408856"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:14 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 15/19] intel_iommu: Replay all pasid bindings when either
 SRTP or TE bit is changed
Date: Mon, 15 Dec 2025 01:50:39 -0500
Message-ID: <20251215065046.86991-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
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
index e27f055d03..0de8f62fd4 100644
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


