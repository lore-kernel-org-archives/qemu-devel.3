Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAE2C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 08:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wymMw-0001kv-Hv; Tue, 25 Aug 2026 04:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wymMu-0001kN-LZ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:18:52 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wymMs-0002R3-PL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 04:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787645930; x=1819181930;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=6AcsQA2kVk2rcYJLOui/qfmtaWG/Kse4tOZTw4+qr/Y=;
 b=VVv3JLDp2OcNMHCjnGX7/Edrma51W/B0O00QtbNuOdAmcqpV8zaa3SUW
 c39TIwA5nLtcCRCc6F0wlJCfpI8i7nZfORp5hviPU91WH1vgVhCqk//jB
 WtsoBCfxbveGX3J3Elqm4/iFA3GpEXC/UR8hel6c4LSBnlnoJ6OHaWi3I
 +vh6GvC3hTlQWGcUcIiZ+zDxXE5ssF1aSdZIj35h3C9uGRZGy5PGSBvgc
 iwXW2QjkeNflYWymd2W5YmA8ycDg7ZFe4+pxckiofeqFpgd+lHRCI15uR
 7itaHmpWOjotCfIRT90b33EZS857dfIh3mJhGRzBag4+RKaZ72JrLFwve Q==;
X-CSE-ConnectionGUID: LaASjp69T7WjhyCxbxcqeQ==
X-CSE-MsgGUID: wmlNR66SRd+jrdsBJonF3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="87967055"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="87967055"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:18:46 -0700
X-CSE-ConnectionGUID: aQoggwgGQnWP7Q21yGvW5g==
X-CSE-MsgGUID: UJ0CQuOpT06kMg16aLwFqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="265905291"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 01:18:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 0/6] intel_iommu: Enable PRQ support for passthrough device
Date: Tue, 25 Aug 2026 16:18:07 +0800
Message-ID: <20260825081814.138140-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

When svm=on,pasid-bits=N,fsts=on is configured for virtual vtd, we enable
guest's support for vSVM. In this case, the host VTD may generate
recoverable first stage page fault event, QEMU read the event and inject
it to guest.

After guest handles the event, it sends a page group response, QEMU gets
the response and pass it to host VTD.

This series adds QEMU support for receiving such host events through the
FAULTQ interface and propagating them to the guest, then catching guest's
responses and propagating them to host.

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_prq.v4

Tests:
Tested with DSA wq attached to an user APP which triggers IO page fault on
process page table durging DMA.
Build test with window cross-build.

Thanks
Zhenzhong

Changelog:
v4:
- add the comment to the docstring of the function vtd_prq_report_fault itself (Clement)
- add "out_" prefix for fault_id & fault_fd output parameter (Clement)

v3:
- convert to PCI pasid before passing to vtd_pri_request_page (Clement)
- expose vtd_pri_request_page and drop accel_ops pointer (Clement)
- add a cleanup patch "intel_iommu_accel: Guard VTDAccelPASIDCacheEntry definition" (Philippe)

v2:
- define fault_fd int type (Liuyi)
- update comments on FAULTQ_BUF_SIZE (Liuyi)
- drop param vtd_hiod in vtd_destroy_old_fs_faultq() (Liuyi)
- s/vtd_propagate_page_group_response_accel/vtd_accel_propagate_page_group_response (Liuyi)
- call vtd_prq_response_notify() directly instead of through pri_notifier (Liuyi)
- replace "fault_id != 0" check with "fault_fd < 0" check (Liuyi)

Zhenzhong Duan (6):
  intel_iommu_accel: Guard VTDAccelPASIDCacheEntry definition
  backends/iommufd: Introduce iommufd_backend_alloc_faultq
  backends/iommufd: Extend iommufd_backend_alloc_hwpt() with fault_id
  intel_iommu_accel: Add PRQ injection for passthrough device
  intel_iommu_accel: Accept PRQ response for passthrough device
  intel_iommu_accel: teardown FAULTQ resources in bottom half

 hw/i386/intel_iommu_accel.h    |  16 ++-
 hw/i386/intel_iommu_internal.h |   3 +
 include/hw/i386/intel_iommu.h  |   6 +
 include/system/iommufd.h       |   7 +-
 backends/iommufd.c             |  28 +++-
 hw/arm/smmuv3-accel.c          |   6 +-
 hw/i386/intel_iommu.c          |  11 +-
 hw/i386/intel_iommu_accel.c    | 252 ++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c              |   2 +-
 backends/trace-events          |   3 +-
 hw/i386/trace-events           |   2 +
 11 files changed, 315 insertions(+), 21 deletions(-)

-- 
2.52.0


