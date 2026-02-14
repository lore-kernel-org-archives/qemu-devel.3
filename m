Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618D3EF99FE
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr6Xb-00056k-GY; Fri, 13 Feb 2026 22:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6XZ-000569-6H
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:41:53 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6XW-00089J-De
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771040510; x=1802576510;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yHDeaOD2WhR4jhQz3dGBFMjY4Egy+zTJ/z6t9DOiFts=;
 b=h925539HEWqXqqoiOwJWhl3hgBPZjBFxKx/qoZHaELF4YIawsVkdDuMR
 gxmSF0If5rP4buY+zbjdn0g6O8vt4CClqaUgfgohJ+iddryPjURdYZ3ve
 g76XH42GLfmQauadNIkeB+1p4bDzDzcVM2l7c7dBaDKz2Ap9ilrzhL2ZM
 2FBr/6q5ubXIXeutWMCHNVhRJw83WTUT147+CLFhvi+knk2B3RS23xnuQ
 b62WG5DA2mAKtsffkNX5B+92xUQZSSj3sp2PkaNyzZrA9msQf+touQy2P
 zmgZPSZZdMs0B82gs24LqA+MSNoZvVp/eMA8LWVc6Biunfd5fLbu5gXX6 g==;
X-CSE-ConnectionGUID: 9n9c7JwaTtOC5GWRSsbSCg==
X-CSE-MsgGUID: 38vjxfXYRHisQpC2VTOIXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83666789"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="83666789"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:41:47 -0800
X-CSE-ConnectionGUID: Lp8ZYaOlRyaXKXCKqypY8g==
X-CSE-MsgGUID: AzAEnVmlR6SWynnmJzNh2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212932908"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:41:43 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFCv2 PATCH 00/13] intel_iommu: Enable PASID support for passthrough
 device
Date: Fri, 13 Feb 2026 22:41:20 -0500
Message-ID: <20260214034135.220413-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
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

Now we already support first stage translation with passthrough device
backed by nested translation in host, but only for PASID_0.

Structure VTDAddressSpace includes some elements suitable for emulated
device and passthrough device without PASID, e.g., address space,
different memory regions, etc, it is also protected by vtd iommu lock,
all these are useless and become a burden for passthrough device with
PASID.

When there are lots of PASIDs used in one device, the AS and MRs are
all registered to memory core and impact the whole system performance.

So instead of using VTDAddressSpace to cache pasid entry for each pasid
of a passthrough device, we define a light weight structure
VTDACCELPASIDCacheEntry with only necessary elements for each pasid. We
will use this struct as a parameter to conduct binding/unbinding to
nested hwpt, to record the current binded nested hwpt and even future
PRQ support. It's also designed to support PASID_0.

The potential full definition of VTDACCELPASIDCacheEntry may like:

  typedef struct VTDACCELPASIDCacheEntry {
      VTDHostIOMMUDevice *vtd_hiod;
      VTDPASIDEntry pe;
      uint32_t pasid;
      uint32_t fs_hwpt_id;
      uint32_t fault_id;
      int fault_fd;
      QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
      IOMMUPRINotifier pri_notifier_entry;
      IOMMUPRINotifier *pri_notifier;
      QLIST_ENTRY(VTDACCELPASIDCacheEntry) next;
  } VTDACCELPASIDCacheEntry;

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_pasid

PATCH01-06: Some preparing work
PATCH07-09: Handle PASID entry addition and removal
PATCH10-11: Support pasid binding and unbinding
PATCH12-13: Add PASID related check and enable PASID for passthrough device

This patchset depends on a kernel feature enhancement[1] to work.

Tests:
Tested with DSA device which driver uses 2 PASIDs by default.

Thanks
Zhenzhong

[1] https://lore.kernel.org/all/20260205023405.41583-1-zhenzhong.duan@intel.com/

Changelog:
RFCv2:
- extend attach/detach_hwpt() instead of introducing new callbacks (Shammer)
- Define IOMMU_NO_PASID for device attachment without pasid (Nicolin)
- update vtd_destroy_old_fs_hwpt()'s parameter for naming consistency (Clement)
- check pasid bits size to be no more than 20 bits (Clement)
- initialize local variable max_pasid_log2 to 0 (Cédric)


Zhenzhong Duan (13):
  vfio/iommufd: Extend attach/detach_hwpt callback implementations with
    pasid
  iommufd: Extend attach/detach_hwpt callbacks to support pasid
  vfio/iommufd: Create nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
    flag
  intel_iommu: Create the nested hwpt with IOMMU_HWPT_ALLOC_PASID flag
  intel_iommu: Change pasid property from bool to uint8
  intel_iommu: Export some functions
  intel_iommu: Handle PASID entry addition for pc_inv_dsc request
  intel_iommu: Handle PASID entry removal for pc_inv_dsc request
  intel_iommu: Handle PASID entry removal for system reset
  intel_iommu_accel: Support pasid binding/unbinding and PIOTLB flushing
  intel_iommu_accel: drop _lock suffix in
    vtd_flush_host_piotlb_all_locked()
  intel_iommu_accel: Add pasid bits size check
  intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED when configured

 hw/i386/intel_iommu_accel.h    |  34 ++-
 hw/i386/intel_iommu_internal.h |  41 +++-
 include/hw/core/iommu.h        |   2 +
 include/hw/i386/intel_iommu.h  |   4 +-
 include/hw/vfio/vfio-device.h  |   1 +
 include/system/iommufd.h       |  16 +-
 backends/iommufd.c             |   9 +-
 hw/arm/smmuv3-accel.c          |  12 +-
 hw/i386/intel_iommu.c          |  81 +++----
 hw/i386/intel_iommu_accel.c    | 406 +++++++++++++++++++++++++++------
 hw/vfio/device.c               |  11 +
 hw/vfio/iommufd.c              |  56 +++--
 hw/vfio/trace-events           |   4 +-
 13 files changed, 506 insertions(+), 171 deletions(-)

-- 
2.47.3


