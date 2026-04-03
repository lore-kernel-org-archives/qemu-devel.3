Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC49ED73090
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 03:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8VeH-0001b2-Hl; Thu, 02 Apr 2026 23:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8VeF-0001Tv-U4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:43 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8VeD-0004N9-Sn
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 23:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775188602; x=1806724602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gpq4iT48dEoIvQVMl/RDHwVdK3eHCPEFNnahXMO0tqE=;
 b=iMdWPuMM8VjZPFfPVH7f2yIaJWwE6ELZB5ARxO1lIH02nKL0ExXl9FFu
 mtcyimJdO8Q09nrMZiJLRhyBe5ZZTH3XEAnbbdNgEUOva3rhcIEm6wO2y
 PUjK+r+0IZCVpYEvcXdJ2T12IxEps16kyqTp3Tbc/QPyBFid4fy/jqZMg
 Y7FYILi4QrpIHGbVd2RIW5FLcu8wQhPY00UwrWJ0lLFqAYS9VII9mGNRo
 O4Q6S64bNgWK/Zy3f+Gm1jYjCBisyxx7bW+MfLL/23WLQHozxZ8hb0/oS
 FktblX6sIwAgUD2AlPKVbTni2B6wvaSNCOMreD2yYbo6WqmMCdRDNCvro A==;
X-CSE-ConnectionGUID: hkL0BQKcQlS3APi/4PMpbw==
X-CSE-MsgGUID: NPTtWIqBSu+Yn4n9pFu4eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76140700"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76140700"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:41 -0700
X-CSE-ConnectionGUID: RAgMnMFBQhOnMme+l00PZw==
X-CSE-MsgGUID: sX4x4nkSSK6VrsiAFlnkDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="223884968"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 20:56:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 14/14] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 when configured
Date: Thu,  2 Apr 2026 23:55:38 -0400
Message-ID: <20260403035541.18355-15-zhenzhong.duan@intel.com>
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

VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
capability, or else guest could not enable PASID of this device even if
vIOMMU's pasid is configured.

This is the final knob to enable PASID.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index abcb0df5d9..3cb8a547c7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4794,6 +4794,7 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     uint64_t flags;
 
     flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+    flags |= s->pasid ? VIOMMU_FLAG_PASID_SUPPORTED : 0;
 
     return flags;
 }
-- 
2.47.3


