Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67081CD0437
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0LU-0005RB-96; Tue, 06 Jan 2026 01:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0L4-0004Z9-W1
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:48 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0L0-0007KE-BG
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680079; x=1799216079;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FF9x/Ip7iFJCv2UXPRRqxfSQ8WgyjtutSEexjOCvvXg=;
 b=iN89343z83MPel0X1z0+umtt0qD17pCI+/Lhhc8Ph/Icr+VwzhhPruAg
 d+ZH9m21HWa8slbKv0Hv11U2x6ZLi0XXkhsWJHgxNfmw8dmtGczOHRP1z
 30y7VUKfIyvIgiOD93Y0yc/pnHrj/O1L0K6TjNoUZtuJvqbKmEGeQwOJv
 3SNL1W7/6uWNr+0VJZ7lJyrgI8Qiop1fLSdclXL2LT6B9h7paU1I7uJqH
 9Fnf0Y6a9BtPcA1wzji1Pxt4dXmiAOgvK27uqcB2tSsHeMMsDR3h/4NGF
 8GJhsJ6z5oL+BXxV3T0KQSUsZ45oALGMHlJMiBqd1MCXBYs9zAH+7ByI5 w==;
X-CSE-ConnectionGUID: SOnP6Ai0SYWZSwvwAWMG0A==
X-CSE-MsgGUID: fSKUjnt7QLasXmtU7KGeYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094082"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:32 -0800
X-CSE-ConnectionGUID: 9WQBuvz8QzCsOMW/4hjrfw==
X-CSE-MsgGUID: Myj8NlxkRNWUmf1XEtV8pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588928"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:27 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 17/19] intel_iommu: Add migration support with x-flts=on
Date: Tue,  6 Jan 2026 01:12:59 -0500
Message-ID: <20260106061304.314546-18-zhenzhong.duan@intel.com>
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

When x-flts=on, we set up bindings to nested HWPT in host, after
migration, VFIO device binds to nesting parent HWPT by default.
We need to re-establish the bindings to nested HWPT, or else device
DMA will break.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 08236b85ee..f971cdd14c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4090,6 +4090,13 @@ static int vtd_post_load(void *opaque, int version_id)
      */
     vtd_switch_address_space_all(iommu);
 
+    /*
+     * Bindings to nested HWPT in host is set up dynamically depending
+     * on pasid entry configuration from guest. After migration, we
+     * need to re-establish the bindings before restoring device's DMA.
+     */
+    vtd_replay_pasid_bindings_all(iommu);
+
     return 0;
 }
 
-- 
2.47.1


