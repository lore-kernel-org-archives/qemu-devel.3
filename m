Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C00CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 03:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa3kX-0004sH-51; Wed, 17 Jun 2026 23:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3kU-0004rV-Vn
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:02 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wa3kT-0008Kp-43
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 23:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781754541; x=1813290541;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=7gan0CWTJdoieZmtblSwnmLmjwYQt6V8O/b1ESBGDHs=;
 b=LrEZ3ZXQtLYsofixmN7/PlcqbcM4uU7lEoqta6eRK3JZewPPjuweS44W
 gWgzSSPugFAXFzX75xhSC3vMMvHlPmoYmnX3/o4OY+sHhiY2mPna05n8o
 enV162CosqfgXv96Z2Rsm7Pi0dv5kmVwwvBPPD1RXdnbUipYRPav4DKuf
 NF4YAYVwpKNqEQP4oycQ3dthwMmR6cKFHOdjCoN1FnelyJb6L7pmO8ReI
 hduGSriGrCS9zGlnR5q5wYfYjGGamH1rJRzUOQWLkQQFkvy+si+fIQArC
 a105duX4gIlcU+UUDy8H1fQVj8hwGxZSmWd0CKM57GQDn761qzoYpjjj2 w==;
X-CSE-ConnectionGUID: oI7QBfVbTzay9HqJYsf6cQ==
X-CSE-MsgGUID: F3Ss3T71QaOUblGhycdbFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82776811"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="82776811"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:48:55 -0700
X-CSE-ConnectionGUID: Fiz0W6S+QPCNHkJHzXr06Q==
X-CSE-MsgGUID: 5GCXCXZgTyKXwGz28A7W0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; d="scan'208";a="253352565"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 20:48:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 0/5] intel_iommu: Enable PRQ support for passthrough device
Date: Wed, 17 Jun 2026 23:48:38 -0400
Message-ID: <20260618034844.618011-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
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

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_prq.v2

Tests:
Tested with DSA wq attached to an user APP which triggers IO page fault on
process page table durging DMA.

Thanks
Zhenzhong

Changelog:
v2:
- define fault_fd int type (Liuyi)
- update comments on FAULTQ_BUF_SIZE (Liuyi)
- drop param vtd_hiod in vtd_destroy_old_fs_faultq() (Liuyi)
- s/vtd_propagate_page_group_response_accel/vtd_accel_propagate_page_group_response (Liuyi)
- call vtd_prq_response_notify() directly instead of through pri_notifier (Liuyi)
- replace "fault_id != 0" check with "fault_fd < 0" check (Liuyi)

Zhenzhong Duan (5):
  backends/iommufd: Introduce iommufd_backend_alloc_faultq
  backends/iommufd: Extend iommufd_backend_alloc_hwpt() with fault_id
  intel_iommu_accel: Add PRQ injection for passthrough device
  intel_iommu_accel: Accept PRQ response for passthrough device
  intel_iommu_accel: teardown FAULTQ resources in bottom half

 hw/i386/intel_iommu_accel.h   |  14 ++
 include/hw/i386/intel_iommu.h |   6 +
 include/system/iommufd.h      |   7 +-
 backends/iommufd.c            |  28 +++-
 hw/arm/smmuv3-accel.c         |   6 +-
 hw/i386/intel_iommu.c         |   4 +
 hw/i386/intel_iommu_accel.c   | 245 +++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c             |   2 +-
 backends/trace-events         |   3 +-
 hw/i386/trace-events          |   2 +
 10 files changed, 301 insertions(+), 16 deletions(-)

-- 
2.52.0


