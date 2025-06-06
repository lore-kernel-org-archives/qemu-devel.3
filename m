Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E769C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU13-0001JY-6q; Fri, 06 Jun 2025 06:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU10-00016T-83
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:34 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0w-0007i7-Nu
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204571; x=1780740571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6flmb2buVOzoFCEGsjS4ClTvDrhO72/0u5VsbJ6oxno=;
 b=RgKERAsbxeSiEtkMkxCACyd+IXBLaUWhW0uf+IVyoNk/UepoIE9ntoDe
 gLgDX9tfKkbbcFd+sobNmgDujwsSD825gp6Lx1LY+UdzGuQlLPLraoX1I
 Ych+RJKmIV7YelW7gqizzuUA4n/PLe//5XCztTTiV8AIpnA5iKhNKba26
 QcF4TzhzXICQj9G+ieT62GVGFSE8SG1llEjwzR36edfZr6Tep9sgSjDVN
 h8LSEKXc3kCso6ENvhQPHmLjeVe/xHgnJaQLkUuOSt/6I6uhXcSRYfoM0
 my5uQ81ofGsbOwqfYLxXcu6rr9LLlV3wrktsHIFNPZeTdFOEq/rK52BL5 A==;
X-CSE-ConnectionGUID: KNtgIB82QrGDeXEI9i/yww==
X-CSE-MsgGUID: wPhV00BURnq/ATwPRBE4vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747377"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747377"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:29 -0700
X-CSE-ConnectionGUID: q/07CYEmQYWYCUxvvffMmg==
X-CSE-MsgGUID: 8U5ub6UwT3KLukXxUjwy5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759264"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:24 -0700
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
Subject: [PATCH v1 14/15] intel_iommu: Bypass replay in stage-1 page table mode
Date: Fri,  6 Jun 2025 18:04:15 +0800
Message-Id: <20250606100416.346132-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

VFIO utilizes replay to setup initial shadow iommu mappings.
But when stage-1 page table is configured, it is passed to
host to construct nested page table, there is no replay needed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ec8b0ff13a..165998896c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5759,6 +5759,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
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


