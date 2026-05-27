Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA5BCD6E44
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS78y-0007WC-Hi; Wed, 27 May 2026 01:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS781-0006JC-Oj
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:29 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS77z-000149-Uu
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860908; x=1811396908;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WmvttA5APZjBvPH3sYtQBL5xVErvKSF69eLmvvUhMAI=;
 b=F4mwbFtgkPeXrYW8J+vZZrzxyWscPxbeXw7uCbuJ98b7Ywcpo1Z58uzZ
 l2C+injjES23OAlYoHNZLQUhthCnp4xGPgG3xUXpRRqr4EbjX16VJrP6v
 hNUoUkHVVBVxVOUhG2uSdguCM1zAL8JOgxdiftCubD3Vdrfk//0IDPznd
 a7njjJ3a9a62rnEMOTFFDqQGP7YpqJAs/n3G2KpSSUfOGvSRMXkPgIpjW
 lMdRtKzrwykXtwOZbuFwF3TCsj1w/10g1gVbB1NqXtIxwO462o+Anj0HR
 vitZFpOoLFl++7yctUZ5qvxLxL2NR4YigKhQRoHUojaow4tKt3AKhle/7 w==;
X-CSE-ConnectionGUID: XZ+rTuMwSO+raNATLDrnXg==
X-CSE-MsgGUID: WmeGzcT7S/6vxno9qU0d6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988178"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988178"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:27 -0700
X-CSE-ConnectionGUID: /SYnOcaFRPONapNOOASH+g==
X-CSE-MsgGUID: J2f8UTSgQeK/0twdRw+EyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086847"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 13/17] intel_iommu_accel: Bypass PASID entry addition for
 just deleted entry
Date: Wed, 27 May 2026 01:46:51 -0400
Message-ID: <20260527054658.1021096-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

For VTD_INV_DESC_PASIDC_G_PASID_SI typed pc_inv_dsc invalidation, if an
pasid entry is just removed, it can never be a new entry to add. So
calling vtd_replay_pasid_bind_for_dev() is unnecessary.

Introduce a new field accel_pce_deleted in VTDPASIDCacheInfo to mark
this case and to do the bypassing.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu_accel.c    | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 9307825017..64a38afa85 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -630,6 +630,7 @@ typedef struct VTDPASIDCacheInfo {
     uint8_t type;
     uint16_t did;
     uint32_t pasid;
+    bool accel_pce_deleted;
 } VTDPASIDCacheInfo;
 
 typedef struct VTDPIOTLBInvInfo {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index b6c560753e..f5fc6327b6 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -280,10 +280,15 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
     QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
 }
 
-static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
+static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce,
+                                VTDPASIDCacheInfo *pc_info)
 {
     QLIST_REMOVE(vtd_pce, next);
     g_free(vtd_pce);
+
+    if (pc_info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) {
+        pc_info->accel_pce_deleted = true;
+    }
 }
 
 static void
@@ -319,7 +324,7 @@ vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
-        vtd_accel_delete_pc(vtd_pce);
+        vtd_accel_delete_pc(vtd_pce, pc_info);
     }
 }
 
@@ -472,7 +477,12 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
          * removals before additions to optimize the replay process.
          */
         vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
-        vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+
+        if (pc_info->accel_pce_deleted) {
+            pc_info->accel_pce_deleted = false;
+        } else {
+            vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+        }
     }
 }
 
-- 
2.47.3


