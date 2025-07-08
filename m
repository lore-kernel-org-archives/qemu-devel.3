Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4693FC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFG6-0006Ps-Ql; Tue, 08 Jul 2025 16:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsT-0000jk-Sl
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:25 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsN-00086x-EO
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002472; x=1783538472;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dCdMwZtfNTWkcMIeigv9JOJVasGlx1kVILv8S0JT6pM=;
 b=Y6GYObwXJD32sowXHvkRneieF/oOMoNTEQL1HQ7PwwT9m2PEErWGpm0B
 kuBctwNS6aiXVvIODj76vfYHHal6kqTxFQlj41dJZkDETp2dr0ur5hykL
 //ZxbyWovFHakIpv9dRa5otPIPElO9gq5CxZN4lvaFSUVOWu12W3FQvqh
 +Z4rLB4Q+6l4YyP6cRzMvQIXQXccNqSOewazUgPIYfJVF1txWqoXvJZu/
 eU9geAHDfW3EChJ3RtNa4w16bjw9XKcG2L+NSkfAPzSnv8d/vfWafrw8r
 9SJmaQGzBXZd1JTPScQNylngwrwpUov/8h2F1HM76B6PP0326EdSpqEq+ Q==;
X-CSE-ConnectionGUID: N9P0UXIHT2m/rKKGSbR6XQ==
X-CSE-MsgGUID: OXhfQxAMS4mkrpyi5e5dPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57974085"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57974085"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:26 -0700
X-CSE-ConnectionGUID: Uf1TDdP3QuGBO9YOaiXiSA==
X-CSE-MsgGUID: enIbriHURwWdMzEplbdfZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192648020"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 17/20] intel_iommu: Replay all pasid bindings when either
 SRTP or TE bit is changed
Date: Tue,  8 Jul 2025 07:05:58 -0400
Message-ID: <20250708110601.633308-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250708110601.633308-1-zhenzhong.duan@intel.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
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
---
 hw/i386/intel_iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d8b4296fe4..0a86bd47b2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -89,6 +89,7 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
 static void vtd_pasid_cache_sync(IntelIOMMUState *s,
@@ -3044,6 +3045,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_replay_pasid_bindings_all(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -3078,6 +3080,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_replay_pasid_bindings_all(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -3758,6 +3761,17 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     }
 }
 
+static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .type = VTD_PASID_CACHE_GLOBAL_INV };
+
+    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    vtd_replay_guest_pasid_bindings(s, &pc_info);
+}
+
 /* Update the pasid cache in vIOMMU */
 static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
 {
-- 
2.47.1


