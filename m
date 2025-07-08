Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01A7C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFGA-0006o2-VH; Tue, 08 Jul 2025 16:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsf-0000yp-BH
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:31 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDsb-00082f-3f
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002486; x=1783538486;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ecCMAEtIFZ0ONaJFrbOrf4SBvoPdLunNt7lfHH3s8UY=;
 b=jeA58G/HieA9NtX8l3t7V7WTe6RY1nvZ0Xi57SoNn3I4MQyee1XAd9+i
 PKfmr+dMF1/YiLF1nzDq8CB/Z4IA9Epz14yTYvainRTwAIyA2OzPwhmVP
 LTjwIGOOynuItaHszuHbHlCXSAp3iJMxFvV5NLzNysPCKjQJjqRYXrmHc
 J9Ye2jicXzNil9e6Eebwofd2JI1Yi6jq5tMqlP14m+BZlOCLO5lRpFA6C
 GUFqzq7u0Zuybkf0qzIzhRRUoofAzzNnN3jei5r8Bu9w+SeYMotLKUt86
 KOEuRuQ6eD/e5AdouWgycQKUZkVemjEJWgX3RZJ3Rnn0ovWL4SXquXXdV Q==;
X-CSE-ConnectionGUID: Yr26/+RuQaCfGGUQqkpJ4Q==
X-CSE-MsgGUID: lIEkm4RDT168lrMcz7mHAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57974127"
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="57974127"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:38 -0700
X-CSE-ConnectionGUID: eRaIQmN4TweP5v58V4pByA==
X-CSE-MsgGUID: 1GRpPe+SQhCAGO2avQ47Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,297,1744095600"; d="scan'208";a="192648042"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 04:07:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 20/20] intel_iommu: Enable host device when x-flts=on in
 scalable mode
Date: Tue,  8 Jul 2025 07:06:01 -0400
Message-ID: <20250708110601.633308-21-zhenzhong.duan@intel.com>
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

Now that all infrastructures of supporting passthrough device running
with stage-1 translation are there, enable it now.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0a86bd47b2..08e4d5cfe7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5203,6 +5203,8 @@ static bool vtd_check_hiod(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                    "when x-flts=on");
         return false;
     }
+
+    return true;
 #endif
 
     error_setg(errp, "host IOMMU is incompatible with stage-1 translation");
-- 
2.47.1


