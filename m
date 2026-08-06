Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B7CC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrsgv-0001pT-IK; Thu, 06 Aug 2026 03:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wrsgs-0001pC-Sf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:39:00 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wrsgq-0001cw-Ok
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786001937; x=1817537937;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dn5E2AvMEMhI2D5hHApQz/9+mMFA+lk4dOF5WYqD8+4=;
 b=JKIFGC8ctUPvkzgsFphO15n8kTMl16OJ5AJx7huD1F3B6RhehoBeWy1T
 O9Ln2pF6VlFGMHROaXBY9tmmZ2Sb4zTyTgp/x8I/2QToMqy1ZNmIgsSgo
 +vZyxy3D8JZ3takhRC6to6ksyxYqvHy8CEX68EtoOqrEAx4EMrKHDRCD/
 uDpLzn7tFlLurl+UGBUIEQNAi4pgDKg3ti/zc5ptZM412yjVeB//ilt1T
 AvdejCfT0AAAGP9WgWAhxaR0cHgr6StP4BPW2RCQrcTPGjlad0UvL+yRq
 ITNWH5fzgbfSgvBU0X/jln8I1pz0CAivyi3FGldfOMYIDuhVQQgEp9pY4 Q==;
X-CSE-ConnectionGUID: UtOr4oEFTEShZWKH7+mCcQ==
X-CSE-MsgGUID: CnKBPJb5T5yz3hKbhVVtMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86662680"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86662680"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:38:52 -0700
X-CSE-ConnectionGUID: +LErV6sbQ8q2XQkWx+hqwg==
X-CSE-MsgGUID: qTN3riPoTKG5VR1D4dWlDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="265506935"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:38:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough device
Date: Thu,  6 Aug 2026 03:38:18 -0400
Message-ID: <20260806073825.363468-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.852,
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

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_prq.v3

Tests:
Tested with DSA wq attached to an user app which triggers IO page fault on
process page table durging DMA.

Thanks
Zhenzhong

Changelog:
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
 hw/i386/intel_iommu_accel.c    | 245 ++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c              |   2 +-
 backends/trace-events          |   3 +-
 hw/i386/trace-events           |   2 +
 11 files changed, 308 insertions(+), 21 deletions(-)

-- 
2.52.0


