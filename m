Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654BFF513EE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyM7m-0004iB-O8; Thu, 05 Mar 2026 22:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7k-0004cw-QR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:45:12 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7h-0006Ja-3N
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772768709; x=1804304709;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/rSjrNJDHcn9lT9mlx+7/Jfo07GOetgWVoKK9X4qUbo=;
 b=EHD90/5Vxv/j5Dntozsv+N3S5XLw7v82Ipr6O8a0GX35u9dzWEVStY9B
 Byh19VYlD1cLdLk5NgbLwuWECoTJCqAd84cUNeFwsK7X0bh2uCEgUT7H3
 BtmTHowi+DKItVTs0jIwg+6mnXZ5h+FSc8f3I3jJhSddfjnc0UzAKbbLj
 EzWbD86ID0OTt83jTMZl/RnWq/rGGAeahJBIA7l8YloJmPbXcol4lNNq2
 UkUQT7vOMw5fKjpVWK41DErS36qmkh+2N0tP4JrkuuAKsC79vU5Nem4VH
 Pl4D6ivoxEddmo00HUKa368cKESzCvdc4T8bJhwAyP23M5yqui4weiRIy g==;
X-CSE-ConnectionGUID: u1F46LUuQXWZoZP5klQ8lg==
X-CSE-MsgGUID: v3+8uYECQOWaHhgjGpsAKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91448351"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91448351"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:45:05 -0800
X-CSE-ConnectionGUID: Wu0ypxU4SfWHqI/g8Yrjfw==
X-CSE-MsgGUID: TpCaGPTUS3OKmQQs39jRdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215613520"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:45:02 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 13/13] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 when configured
Date: Thu,  5 Mar 2026 22:44:07 -0500
Message-ID: <20260306034409.184873-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306034409.184873-1-zhenzhong.duan@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e99a9cf9c6..af4904e341 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4796,6 +4796,7 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     uint64_t flags;
 
     flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+    flags |= s->pasid ? VIOMMU_FLAG_PASID_SUPPORTED : 0;
 
     return flags;
 }
-- 
2.47.3


