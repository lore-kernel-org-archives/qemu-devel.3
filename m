Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC475CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 03:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v34n8-0001Qv-PM; Sun, 28 Sep 2025 23:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34n7-0001Pn-3P
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:09 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v34my-0007dc-Re
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 23:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759117381; x=1790653381;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yK2dpmDEopeGqU1aW0wmSFvM9vPYzMUMJFcs4x1WVUU=;
 b=KoAhsP57uWwRNZYwaXTM1vNYYRfmACeCR2irZLs00EFSDN2H0oI/ac0H
 42h9Bqs/LnDGnEy2UOJWVY7Z6Alap0OzvFRG3b5UaRvatCvYz7heFsBk5
 HQ4j2gMykMd59S3aLl9L02HUo5c32BclL0LkLltjRPMTvjdkPpOsJe+jR
 671WENPa9s9a4vM6vZnzGmE+xj/+Gn/OCo/VmWUWE3z9vVwjhPsuwEVFG
 f8He2EhS5m5Bql8qaj5ydNGTwPVspCkf4FqUcNj3rz7eLBdziv7C8UuaQ
 G+JtdQjl7C7iR5GmqjGgcx0iTEZyp52JFySNQ7SlRYYfqhMHrdaD0Bjpn Q==;
X-CSE-ConnectionGUID: i8t2NXp7Q9G+5+IhG61ofQ==
X-CSE-MsgGUID: 4lxmVHdhQ16SQigi1gCqUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11567"; a="64989290"
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="64989290"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:50 -0700
X-CSE-ConnectionGUID: 2LLSf/YtR32fR5k8KFMO5A==
X-CSE-MsgGUID: MzjlhEiOTquDaMxbBVnZQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,300,1751266800"; d="scan'208";a="178865048"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 20:42:48 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/3] intel_iommu: Enable Enhanced Set Root Table Pointer
 Support (ESRTPS)
Date: Sun, 28 Sep 2025 23:42:04 -0400
Message-ID: <20250929034206.439266-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250929034206.439266-1-zhenzhong.duan@intel.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

According to VTD spec rev 4.1 section 6.6:
"For implementations reporting the Enhanced Set Root Table Pointer Support
(ESRTPS) field as Clear, on a 'Set Root Table Pointer' operation, software
must perform a global invalidate of the context cache, PASID-cache (if
applicable), and IOTLB, in that order. This is required to ensure hardware
references only the remapping structures referenced by the new root table
pointer and not stale cached entries.

For implementations reporting the Enhanced Set Root Table Pointer Support
(ESRTPS) field as Set, as part of 'Set Root Table Pointer' operation,
hardware performs global invalidation on all DMA remapping translation
caches and hence software is not required to perform additional
invalidations"

We already implemented ESRTPS capability in vtd_handle_gcmd_srtp() by
calling vtd_reset_caches(), just set ESRTPS in DMAR_CAP_REG to avoid
unnecessary global invalidation requests of context, PASID-cache and
IOTLB from guest.

This change doesn't impact migration as the content of DMAR_CAP_REG is
migrated too.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 360e937989..5dd92d388d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -214,6 +214,7 @@
 #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
 #define VTD_CAP_FS1GP               (1ULL << 56)
+#define VTD_CAP_ESRTPS              (1ULL << 63)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 #define VTD_PASID_ID_SHIFT          20
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 83c5e44413..f04300022e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4549,7 +4549,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
 
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
-             VTD_CAP_MGAW(s->aw_bits);
+             VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
     if (s->dma_drain) {
         s->cap |= VTD_CAP_DRAIN;
     }
-- 
2.47.1


