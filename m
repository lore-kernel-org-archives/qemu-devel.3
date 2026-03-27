Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1221610A1E63
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 02:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5xJV-0005WU-Fe; Thu, 26 Mar 2026 22:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJS-0005Vn-Qt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:43 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5xJQ-00083K-Lf
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 22:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774579961; x=1806115961;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JiAcB3qggG3pHQEwQithjy7HATt+Kg4MXdq8hZAMll4=;
 b=e1857Ll/Vu34ucnvjkvbxyFf567Qt7cOiIqu3GsukhVTalEOOvNq3nlg
 /B3qcEKSprGwQV8HzyKl153aNiSrr8mZa2A64lPXgRmeWNQc2ZRpRj+Zf
 J1OIrx7d3Om5Zd1YbWqV3RuuDVo+MOocEAiRVe/tYbASOicsnm7HPBuHc
 uDN1WudAnctqbHWMrR2AUNiNLiIgECKdhtzirg4TofouXt9HZF7VCaoby
 ATMEF27OLiRj4AmATi3AEbp+r1fXKYZtvXlryaMjWBWFph+2JuQOhY6/g
 Hb08mTrRgBcpGbAPilx5VVd6SuGEsoqDrLLz3ogHdY0giPPb6rViAV9DN w==;
X-CSE-ConnectionGUID: V6tuf8tpSfSgHOa4YzQbgw==
X-CSE-MsgGUID: 3kBe3wZyT7OKHLaU0qNkLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75719867"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75719867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:38 -0700
X-CSE-ConnectionGUID: W62hki3jTeuJemI3qVQsVw==
X-CSE-MsgGUID: pZecgcu6Qh2RyOFD1S77aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221874373"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 19:52:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 0/5] intel_iommu: Enable PRQ support for passthrough device
Date: Thu, 26 Mar 2026 22:52:22 -0400
Message-ID: <20260327025228.474257-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
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

Hi,

When svm=on,pasid=N,x-flst=on is configured for virtual vtd, we enable
guest's support for vSVM. In this case, the host VTD may generate
recoverable first stage page fault event, QEMU read the event and inject
it to guest.

After guest handles the event, it sends a page group response, QEMU gets
the response and pass it to host VTD.

This series adds QEMU support for receiving such host events through the
FAULTQ interface and propagating them to the guest, then catching guest's
responses and propagating them to host.

This patchset depends on pasid support:
https://lore.kernel.org/qemu-devel/20260326091130.321483-1-zhenzhong.duan@intel.com/#t

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_prq

Tests:
Tested with DSA wq attached to an user APP which triggers IO page fault on
process page table durging DMA.

Thanks
Zhenzhong


Zhenzhong Duan (5):
  backends/iommufd: Introduce iommufd_backend_alloc_faultq
  backends/iommufd: Extend iommufd_backend_alloc_hwpt() with fault_id
  intel_iommu_accel: Add PRQ injection for passthrough device
  intel_iommu_accel: Accept PRQ response for passthrough device
  intel_iommu_accel: teardown FAULTQ resources in bottom half

 hw/i386/intel_iommu_accel.h   |  16 +++
 include/hw/i386/intel_iommu.h |   6 +
 include/system/iommufd.h      |   7 +-
 backends/iommufd.c            |  34 ++++-
 hw/arm/smmuv3-accel.c         |   6 +-
 hw/i386/intel_iommu.c         |   4 +
 hw/i386/intel_iommu_accel.c   | 243 +++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c             |   2 +-
 backends/trace-events         |   3 +-
 hw/i386/trace-events          |   2 +
 10 files changed, 308 insertions(+), 15 deletions(-)

-- 
2.47.3


