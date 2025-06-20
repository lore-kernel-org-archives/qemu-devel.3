Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B2AC7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW6E-00078p-6n; Fri, 20 Jun 2025 03:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW6D-00074M-GE
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW66-0008Oh-94
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404218; x=1781940218;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PmPNXq5DluNt2rvRLdyAOdZc/jwKfcS+19fXNWUCNQ0=;
 b=Hnf0AmdAMkPFo4LYe7+AEDCeiSftuCemQimuENswSv8bXxwZY7P2dvAN
 QoieUSi9VQ5G89loVfMo6JQLffdofVzKbNi7b0uuxu7fhF7UMKqOoV+QQ
 mV0K6GalwSj46ciQq7prLaY3Z3WTznycNR0VcXyc9Yw4ddvdJqzWXQPjf
 uJ3WDl6ySuBn83q3q3ISS328hUOQHgNb3Zsis8r5wJW/wvvCpxJRbs3i7
 mzZj/6cYRpmOA0FGwpf/hquiFtf5z+S9slr1Xg55oolRrWnyhtxqAheFD
 gU06f0bFrp/yZHox4IyJluwZUewKsmdbXvzzvHW9E0ORbbWiHqBZ6D1ds Q==;
X-CSE-ConnectionGUID: 4eBPnCSjR6uCIHol/ON3Rg==
X-CSE-MsgGUID: PWtdMmMuQv26dNzp71kRaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532524"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532524"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:34 -0700
X-CSE-ConnectionGUID: ux31/NHXQLq2qZl+0SIUbg==
X-CSE-MsgGUID: jfi8noxtTn2AHRXiBxDgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863273"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:30 -0700
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
Subject: [PATCH v2 17/19] intel_iommu: Refresh pasid bind when either SRTP or
 TE bit is changed
Date: Fri, 20 Jun 2025 15:18:11 +0800
Message-Id: <20250620071813.55571-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index d1fa395274..0b322078cc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -90,6 +90,7 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
 static void vtd_pasid_cache_sync(IntelIOMMUState *s,
@@ -3066,6 +3067,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -3100,6 +3102,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -3813,6 +3816,26 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
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


