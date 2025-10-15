Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868E0CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ycg-0002fO-Da; Wed, 15 Oct 2025 06:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8yce-0002fC-2K
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:20:44 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8ycR-0007Yv-6s
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760523632; x=1792059632;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bjHWJ+f9+LWQsZlTey/kgURrfDt8cVs0iggL1hu8gLY=;
 b=aXfRS9N66eGN2f0sfKxm1x+3HkBkmHvDO7P2QHV/FpEPTxsUQCuPOSbz
 OVg9Hz86L3PaDpdSo5P6X/uQKGkNPDDGWJdQRFY86y785xnU/44sRXN0f
 DY/PWr5YyPLIWneAbkD+vEuq9kIY/xBbfjqe+fwbH4DCA5sBrtRRq0lZm
 z/z+MBVms7fw/hFRMlFlO+TOv+BHKopGRMUg69FB2SxSZd7nJXKggO+dT
 edXymn9EebStJIJn0tSVVnmezR6f8nA38uabVllkPLusPJYDKBQXq6OyY
 c0kWHwQUScGpHOAS4aSKaytQ+l9QN5/EI/2mhS9B9q0tKJfkyaL5l0J9u g==;
X-CSE-ConnectionGUID: ro6YVjYbRhGd+WNhBUzONA==
X-CSE-MsgGUID: lqfEL0SLTeKFmRg3G/3JLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66556782"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="66556782"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:20:25 -0700
X-CSE-ConnectionGUID: UfFyOa/eRoS7GfiJ8IR0gw==
X-CSE-MsgGUID: jFiurvhvQ9+kSGEcNROjhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="182082675"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:20:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/3] Fix DMA failure when there is domain switch in
Date: Wed, 15 Oct 2025 06:19:59 -0400
Message-ID: <20251015102003.279239-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
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

Hi,

This fixes an DMA failure issue in guest when user switch domain
manually. E.g., echo [DMA|identity] > /sys/kernel/iommu_groups/6/type

First two patches come from [PATCH v6 00/22] intel_iommu: Enable first stage translation for passthrough device
which added basic support for pasid cache invalidation, the 3rd patch
add a fix.

Thanks
Zhenzhong

Zhenzhong Duan (3):
  intel_iommu: Handle PASID cache invalidation
  intel_iommu: Reset pasid cache when system level reset
  intel_iommu: Fix DMA failure when guest switches IOMMU domain

 hw/i386/intel_iommu_internal.h |  20 +++-
 include/hw/i386/intel_iommu.h  |   6 ++
 hw/i386/intel_iommu.c          | 168 ++++++++++++++++++++++++++++++---
 hw/i386/trace-events           |   4 +
 4 files changed, 185 insertions(+), 13 deletions(-)

-- 
2.47.1


