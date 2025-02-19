Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A613CC021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfQo-0006K2-T6; Wed, 19 Feb 2025 03:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQk-000691-Sp
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:43 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfQj-0004ge-2b
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953661; x=1771489661;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OA1DA9tb9D+FuuGPsY1Kf6tlYXcvdCgV9qaFOVXTlBY=;
 b=djohVP2bOpOdnLWah2pkd5PGT9rNadZ5HJnI1hKi6vC2DdZeU3H7JcKe
 oV2/uAQMPKa4iYAWGY1bfAhn4uV2lpEbNjEegKUrAX4PtGABMkQXtQg9Y
 3jy96Q/i4F1i0vd0EQHkB47AOK5bhn180Uilw6lSyiGg62Gn+GjGVKTPg
 xUfBSF/ZFSGYA1K72vgmCWtCiAb/XsPoK6lh8rYugt3l0RnyubCHrUErD
 0xDv2kt0VfaKixRXugNm1WBmpkAV9CZ4YaFNZpqxVRkqaU/Q+kgpyHHss
 w2mHiK8bylKGTV1Bu0k/McMVHZUbEYMmqVGFrmCoc3ksyJtk01mZiGV5c Q==;
X-CSE-ConnectionGUID: xIcxOOMuQCS9MOOuunDNLw==
X-CSE-MsgGUID: MSmNk24ETmm9V8WUv5BwDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544329"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544329"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:40 -0800
X-CSE-ConnectionGUID: DYzE6qIGTFKbry88xqHU1w==
X-CSE-MsgGUID: t6XifuAgTAOhfzlcU27WIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119851461"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:27:35 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv2 19/20] intel_iommu: Bypass replay in stage-1 page table
 mode
Date: Wed, 19 Feb 2025 16:22:27 +0800
Message-Id: <20250219082228.3303163-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

VFIO utilizes replay to setup initial shadow iommu mappings.
But when stage-1 page table is configured, it is passed to
host to construct nested page table, there is no replay needed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 225e332132..e4b83cbe50 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5743,6 +5743,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     VTDContextEntry ce;
     DMAMap map = { .iova = 0, .size = HWADDR_MAX };
 
+    /*
+     * Replay on stage-1 page table is meaningless as stage-1 page table
+     * is passthroughed to host to construct nested page table
+     */
+    if (s->flts && s->root_scalable) {
+        return;
+    }
+
     /* replay is protected by BQL, page walk will re-setup it safely */
     iova_tree_remove(vtd_as->iova_tree, map);
 
-- 
2.34.1


