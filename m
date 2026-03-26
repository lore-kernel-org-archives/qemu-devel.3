Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C514E106F30F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5glJ-0002oA-79; Thu, 26 Mar 2026 05:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glH-0002nl-Pu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:19 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glG-0003yC-4g
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516339; x=1806052339;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QzOlSiVRbcW6stkj1MPh/qnj/ah8oIDtQ9NBnTlisHI=;
 b=S+cvKs0GynsuGuPaIQarbQ+wJWsIh32b39WSJvWRW0uACvvr4cdNImfX
 Y5Bl/sIH2g6/WzebuyIkEZTZYxiAuG0kJgqORxEm8mpcIWGSKYwH7kJ4S
 oNKLyyqpWP3ddeH+cm5naWeIJ/o/R+f0UK/SZpgHM08NhMRlmmBaKMUcS
 dBNBuFfeOFNG7D0gaLhbHQjsjR05PPKwtMNHrrsaD1gaTaQRlrXaZjo0c
 iYMfnSFdhzvJd6klN7qe2gKNZkD5n4mYaCQd9sniOUhkKUvLoAIku/njK
 n07QjepvAq1m8N7c1DdE8X52pvh2TOvLVohyvj75QLBT/RElgAu6ndpc3 w==;
X-CSE-ConnectionGUID: j3MqIUpRS8Wuo9CdJ+BbbQ==
X-CSE-MsgGUID: twg9kC5nThiafbmGd05bGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531373"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531373"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:17 -0700
X-CSE-ConnectionGUID: eLT+sT6MRLS13KWq8+ciWA==
X-CSE-MsgGUID: bLDuV8yvTiCP4+I3ZXN4Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368597"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 09/14] intel_iommu_accel: Bypass PASID entry addition for
 just deleted entry
Date: Thu, 26 Mar 2026 05:11:23 -0400
Message-ID: <20260326091130.321483-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu_accel.c    | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index d5f212ded9..f3cb6cff1c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -631,6 +631,7 @@ typedef struct VTDPASIDCacheInfo {
     uint8_t type;
     uint16_t did;
     uint32_t pasid;
+    bool accel_pce_deleted;
 } VTDPASIDCacheInfo;
 
 typedef struct VTDPIOTLBInvInfo {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index c1285ce331..1e27c0feb8 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -311,6 +311,10 @@ static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
          */
         QLIST_REMOVE(vtd_pce, next);
         g_free(vtd_pce);
+
+        if (pc_info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) {
+            pc_info->accel_pce_deleted = true;
+        }
     }
 }
 
@@ -498,7 +502,12 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
          * removed.
          */
         vtd_pasid_cache_invalidate(vtd_hiod, pc_info);
-        vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+
+        if (pc_info->accel_pce_deleted) {
+            pc_info->accel_pce_deleted = false;
+        } else {
+            vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
+        }
     }
 }
 
-- 
2.47.3


