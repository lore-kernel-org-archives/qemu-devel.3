Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C95EA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpnw-00061H-I2; Wed, 04 Feb 2026 22:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnp-0005sK-4z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:13:09 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnn-0001xZ-Bv
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770261187; x=1801797187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cmZCbFWZBmy27uy8f1zyKQBCOzzDx+hRdvm7jVkNBNc=;
 b=YXUw1aCkeC0L55sAL5APfZJa92Hux1LQWA5UP+eAZYTZP+2Q2muXRBlM
 il0XsE2FEakEVTYbdWO9dPiRUho10hRNJze4AdfZTkT91VHbRxaKGpEV3
 b9g9jx5GdziKq150+WgPJuvdrItiiyVBiQbpITaep2o120yFoVGHreNMd
 BdUkKxMms0/qd/cUaZ4uVrAowdLxnyvkckaKpmjlVpNRbgHgklCU5d84v
 HIzW06abgfeECaqoAsIHR50s9Fob1MWbGDXtjL2Aqh4zS7SXmLwo0URpD
 R+kanJE50sO2/KNZf0NHB33EN/v48oxQOv299gHRZkbSYfcLmWiRfa2ok g==;
X-CSE-ConnectionGUID: SQmXjoQLRiWmWcY+jpE72Q==
X-CSE-MsgGUID: /YEFxEs5Roq8PuAeYU5gng==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96910531"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="96910531"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:13:06 -0800
X-CSE-ConnectionGUID: 1oNtGRgQTim8YQuNfbs4bA==
X-CSE-MsgGUID: Br4UWhLNToCTG95Y6s79NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="209652108"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:13:03 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [RFC PATCH 13/14] intel_iommu: Drop pasid related check
Date: Wed,  4 Feb 2026 22:11:31 -0500
Message-ID: <20260205031133.74357-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205031133.74357-1-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

The check of 's->pasid && x86_iommu->dt_supported' is an overkill,
because all emulated devices don't support PASID capability yet,
they never send Requests-with-PASID, no pasid tagged iotlb entries
are cached in the device. Even if guest send PASID-based-Device-TLB
invalidation request, we can ignore it safely.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 17252c804b..4ab50a9fd9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5490,17 +5490,6 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->pcibus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
-
-    if (s->pasid && x86_iommu->dt_supported) {
-        /*
-         * PASID-based-Device-TLB Invalidate Descriptor is not
-         * implemented and it requires support from vhost layer which
-         * needs to be implemented in the future.
-         */
-        error_setg(errp, "PASID based device IOTLB is not supported");
-        return;
-    }
 
     if (!vtd_decide_config(s, errp)) {
         return;
-- 
2.47.3


