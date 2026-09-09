Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24ACC79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Cju-0004Hf-0V; Wed, 09 Sep 2026 03:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x4Cjs-0004HK-Ho
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:00 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x4Cjq-0003cj-Mm
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788938938; x=1820474938;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xKiayMsCWAy7X4boh8Y6SgHtQJkvJQEbgmpkPCg0c8E=;
 b=BrlwRKKkMRp/oCGirrm0p0Ax/bgZfni7E/VTfJ5e99pk7YksQFSPfKjT
 IVlEh1QP16lGOPKYVt3/FXsVbmR5YfQ29Q3mu/9txGAkxUNoYeajgIDcu
 o2j9MeYbtEKDTsZ5z9VXP1oKqqt3ju1oRR4cVCwDW/Ie7/hqrain6Ajmo
 N0W7rD3JL80Ssq1gegZ9iGVBa4bGTJ7ONivhbdAgdTt/b0bvnCUwhLc8r
 yyffjrXXA0JW+dX0HEBMdGgNzOCo/JzOtbzlG7wT8BELB8iBWXz1+3H3u
 rNqxwN9yGeXfSUlpsMoAqq25fundbyx6z5/wEXAbAf1/B61LuCMefucFw Q==;
X-CSE-ConnectionGUID: RHG+GWMZS6q+J49uzOqZ4w==
X-CSE-MsgGUID: Cn2L82dAT+ewV3Ijzxt55g==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106723269"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="106723269"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:28:55 -0700
X-CSE-ConnectionGUID: CuGicn8aSuaOXY9R+HY89A==
X-CSE-MsgGUID: +94xDjtXTIipZThsAz4bNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267982352"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.229.148])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 00:28:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowangio@gmail.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 0/6] intel_iommu: Enable PRQ support for passthrough device
Date: Wed,  9 Sep 2026 15:28:31 +0800
Message-ID: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
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

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_prq.v6

Tests:
Tested with DSA wq attached to an user APP which triggers IO page fault on
process page table durging DMA.
Build test with window cross-build.

Thanks
Zhenzhong

Changelog:
v6:
- further polish doc comments for vtd_pri_request_page (Liuyi)
- set FAULTQ_BUF_SIZE to 2048 to avoid prq lost (Liuyi)
- move PRE validation hunk in the caller side (Liuyi)
- add break in vtd_prq_list search loop in vtd_prq_response_notify (Clement)
- s/vtd_prq_report_fault/vtd_propagate_recoverable_fault (Liuyi, Clement)
- s/vtd_prq_read_fault/vtd_read_fs_faultq (Liuyi)
- s/vtd_prq_write_response/vtd_write_fs_faultq
- s/vtd_prq_response_notify/vtd_prq_handle_pasid_response

v5:
- add comment "Accept the PCI PASID as input" to docstring of function vtd_pri_request_page (Clement)
- change vtd_prq_report_fault() parameter type "int cnt" -> "unsigned cnt" (Clement)
- check return value of vtd_pri_request_page() and send response (Clement)
- free all vtd_prq_list entries when detaching (Clement)

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

 hw/i386/intel_iommu_accel.h    |  16 +-
 hw/i386/intel_iommu_internal.h |   3 +
 include/hw/i386/intel_iommu.h  |   6 +
 include/system/iommufd.h       |   7 +-
 backends/iommufd.c             |  28 +++-
 hw/arm/smmuv3-accel.c          |   6 +-
 hw/i386/intel_iommu.c          |  18 ++-
 hw/i386/intel_iommu_accel.c    | 281 ++++++++++++++++++++++++++++++++-
 hw/vfio/iommufd.c              |   2 +-
 backends/trace-events          |   3 +-
 hw/i386/trace-events           |   2 +
 11 files changed, 350 insertions(+), 22 deletions(-)

-- 
2.52.0


