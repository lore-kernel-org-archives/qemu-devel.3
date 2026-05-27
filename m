Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4082ECD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS792-0007ni-HX; Wed, 27 May 2026 01:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS78S-0006sr-G0
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:56 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS78Q-0001BX-BH
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860934; x=1811396934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mcGcBp/fqPIJqkUBXN6LH7ThmZKmxBB6v78bYprfIcM=;
 b=C72y2s4cPln2ze07cYoKbcLfBgWMCwggK7vWDYCh2P7mXV/ZgFGG8LkM
 E9ZGnSzjfQekknHVNba9HFLOHPqF5YZKCiFfUgNBHNBKOYva8XY6Bayfk
 tUSUffwpYFlhMrXRwbJs3lPC1cm45o+AN7TwWOkxOwveLuc98ppl4UmaI
 /eEFTBU4z6Z0uFqiT54JDda+r0Ys4qhg984EDRkVpZE7a8anbsTS6mzSC
 8CLQu95uX/TEFYlTpbfC1eWS2qv5pans3SLAwv5Z6SkHOrUWms7rTz6ic
 f2eufDujltSJyITMk4AvIoBeZRBKs3NeCND0qESUUJIwz+lurVBdCPpoq Q==;
X-CSE-ConnectionGUID: kGfEQx0vT2G8NZpws7hsfA==
X-CSE-MsgGUID: Nu4ofx8dRKqX9myVzB4XTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988207"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988207"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:43 -0700
X-CSE-ConnectionGUID: /cVlfhVaTi+jZXh0xJRazQ==
X-CSE-MsgGUID: vO/6IKdxSW2gw2+byPf5RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086872"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:39 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 17/17] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 and VIOMMU_FLAG_WANT_PASID_ATTACH
Date: Wed, 27 May 2026 01:46:55 -0400
Message-ID: <20260527054658.1021096-18-zhenzhong.duan@intel.com>
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

VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
capability, also check VIOMMU_FLAG_WANT_PASID_ATTACH to enable pasid
attachment, without those guest could not enable PASID of this device even
if vIOMMU's pasid is configured.

We don't expose the two flags when fist stage translation is not configured
as we don't support shadow page table on a PASID.

This is the final knob to enable PASID.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0859bafd1..572c260726 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4788,6 +4788,11 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     if (s->fsts) {
         flags = VIOMMU_FLAG_WANT_NESTING_PARENT |
                 VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
+
+        if (s->pasid) {
+            flags |= VIOMMU_FLAG_PASID_SUPPORTED |
+                     VIOMMU_FLAG_WANT_PASID_ATTACH;
+        }
     }
 
     return flags;
-- 
2.47.3


