Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F47D7308A
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Ve8-0001MM-4M; Thu, 02 Apr 2026 23:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Ve0-0001L6-QE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:30 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Vdy-0004N9-Us
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188587; x=1806724587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mfXdfQl9POujA0hQEorAHvjyvPh51rTk6rz0RNAFMBU=;
 b=KlCrfclvCivFL4c6VctewMpjn8TSTrwnFCiB8CcLqb0adMoWdPsfwOvC
 g4h56mSmbo/CK9pMA8YDK/bUnmXPLbL2ZbYmA9nbF5ZjFSbL3EHxjwsxw
 cijYn8zI0WVDORYe1HBHxgTCT2xFAF09geF8R7o++94bX2kTGM/WA9jgh
 dv24tv3CaZZtD9oz4xWj1G/lpinr5ePwl/WAx875WI3aJQWW574RaB5v1
 csXuvsm5BCZUdswacjk3ZO/rhIXI7fo0iBBxxN028yuIxJnZTsd9S6DCK
 mDibmjElErLcGeFDM64GsHNdY/DuO5ck9ShgMfBdubd9T20zXoCvgu8ID A==;
X-CSE-ConnectionGUID: kRUrvwVYSEuHzDsZzRcDrg==
X-CSE-MsgGUID: EXRz7F7zQS+LD3JX6/pW6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140666"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140666"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:26 -0700
X-CSE-ConnectionGUID: dmytq7ywRkuErKUxuHYG2g==
X-CSE-MsgGUID: MXyG1X11RqizFhwtkTjPNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884918"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 10/14] intel_iommu_accel: Bypass PASID entry addition for
 just deleted entry
Date: Thu,  2 Apr 2026 23:55:34 -0400
Message-ID: <20260403035541.18355-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403035541.18355-1-zhenzhong.duan@intel.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu_accel.c    | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 623dc24760..2c716c5297 100644
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
index b951d90135..457fdcba62 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -302,10 +302,15 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
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
@@ -339,7 +344,7 @@ vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
          * to be either all-zero or non-present. Either case means existing
          * pasid cache should be invalidated.
          */
-        vtd_accel_delete_pc(vtd_pce);
+        vtd_accel_delete_pc(vtd_pce, pc_info);
     }
 }
 
@@ -502,7 +507,12 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
          * removed.
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


