Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E59DC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhV4-0007og-2g; Wed, 21 May 2025 07:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUk-0006ui-Ax
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:20:26 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhUh-0006wc-Fr
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826419; x=1779362419;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QTiWUiBaRhBrQcEJnuZOlCADlUJ7TE/qF2fK7PitoVg=;
 b=MEfhClvsYkfVJPjh4OpHpK2Tndw0oVOvCS6nUste3XbgPap87ZOhFBjZ
 NWMA5m7rT4tV7bMQSEQWlu0XcDYJfQgvyaIDVOlV5IXKCy8pYNSt0+8BI
 +ywU2FHPAFR7stAJlZpG5bB2atWtFCA0/RfC+o93TY+JH3LEq0f3KdI+l
 sbeVzw6Lp+y2cJZa7KxTudSs1GZeMoaCW3sGOli8KLUTLw8Sr170SGMgP
 YxTipQbwtTieUfUhPQoYcnMhxV+VK7D92QL4/wjyQwWSO9dwJ/lUBmvun
 K8Zjd9psJ3eqAP5EEiw8Ap5ZOoKyiYYi1H84qIBCzGIOByQnu4FzmzNEG w==;
X-CSE-ConnectionGUID: ZKA2OtAuQoKwfCVauDeB7A==
X-CSE-MsgGUID: fKDqLFZfSNi8Tq0Num3pSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49895189"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49895189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:20:17 -0700
X-CSE-ConnectionGUID: QoAm9oVGSpq3njSP1vdh4Q==
X-CSE-MsgGUID: HO3eWI+9R8WXXww3ozt3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158496"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:20:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv3 20/21] intel_iommu: Bypass replay in stage-1 page table
 mode
Date: Wed, 21 May 2025 19:14:50 +0800
Message-Id: <20250521111452.3316354-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
index b8f3b8effa..e7c662f609 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5768,6 +5768,14 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
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


