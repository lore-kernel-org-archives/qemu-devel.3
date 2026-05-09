Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26271CD37AF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 04:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLZ0q-0001Vz-WA; Sat, 09 May 2026 00:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ0e-0001Sn-SE
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:51 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLZ0c-0000SL-Ga
 for qemu-devel@nongnu.org; Sat, 09 May 2026 00:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778299786; x=1809835786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4qDlev/LjQNpzEpYYcrQhorU9LFoLHbN3zEPhmtiENE=;
 b=n0+elv+Ux+SBAPOXVEvBY59QSEelE3YS5XPIv4HIsraLdZYJZwT/dhn+
 SwS0KWrDy1vHjhhCgXqrfcY2DU3Kh8t1+BX1z5MOsAVVF6tlEPtgyadAM
 UVxLF4JgGH1THTIxB8ZZrReYVsaOs+raKXQXHxE9cpKtQ5YDyvyB0fmvd
 PnVHBukSHSDncFc1PoMjGl133hCN5mqK3m7f4ctGD2kZ4TjmN+aSM+Lky
 ry1xP8lg+2NggG7C6d8CWDR9DHEsVg7wIsQiR3rU4i/1IW0+/49LLhBZP
 +Ab6msitPdyNbkNy8nKNLQqwFFtLyZ+Ccvhfa+Mob4VhH+UVJC2d8d7Gv A==;
X-CSE-ConnectionGUID: hSkNZLluRbmC1PCEHRkdsg==
X-CSE-MsgGUID: zSo8CHQPQS+krB9QhpoEIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90654510"
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="90654510"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:35 -0700
X-CSE-ConnectionGUID: YF5ZcGm2QBusaB5jgc9XKw==
X-CSE-MsgGUID: jZIk6awbQ768h0Ll9askUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,224,1770624000"; d="scan'208";a="235966596"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 21:09:31 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 15/15] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 and VIOMMU_FLAG_WANT_PASID_ATTACH
Date: Sat,  9 May 2026 00:08:08 -0400
Message-ID: <20260509040819.1044702-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

We don't expose the two flags when first stage is not configured as we
don't support shadow page table on a PASID.

This is the final knob to enable PASID.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6067069e02..70546e91d4 100644
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


