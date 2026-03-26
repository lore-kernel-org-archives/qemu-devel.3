Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E2A106F310
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gku-0002k6-8Y; Thu, 26 Mar 2026 05:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5gkq-0002jH-ES
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:11:52 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5gko-0003uj-BO
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516311; x=1806052311;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gj5e/lV6Na+orv9h9pfSru8Da51T+AkraUGg0qWEX8o=;
 b=TmS3Cq4ey71OO7h97AGbLvKVFlGsfJoTwA7VudQQsEKO4bBLBgscXUFP
 hdC9YO1zR99gBzXfOq3ZmVFY33S0wXqMDladeckpAbG5+FrsYMAVgQtnW
 qIxYP9cHJoww2mZGdHRgT6t07CEY88HYhqesbAHCizfmNMaoTKYdPBsW+
 Qiu3HTq172HnkY5XYH7VaiU/D1C1+hnpOZZ0rJqDuQF+FMlqObN08N4x9
 4b54CjAt0MoOpQhbN0D1SWXfQz04VKq96GONozvVTfbvAesoOG2HIAf+O
 k6cbaFeSI28BDGlqvs/568MANQ8xW8Kx+oISx2AVp3jgYAeORhfxZh+Yx Q==;
X-CSE-ConnectionGUID: gg88DtZhQBKg22ksU9UbeQ==
X-CSE-MsgGUID: QkX8ZDoFRSC1WNwr+6ez2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531298"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531298"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:11:46 -0700
X-CSE-ConnectionGUID: PDeQ5Y0TTlii7JoJjzY2aQ==
X-CSE-MsgGUID: tRYd33VgSyC89mW+2BdbPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368543"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:11:42 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 00/14] intel_iommu: Enable PASID support for passthrough
 device
Date: Thu, 26 Mar 2026 05:11:14 -0400
Message-ID: <20260326091130.321483-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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
VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
will use this struct as a parameter to conduct binding/unbinding to
nested hwpt, to record the current binded nested hwpt and even future
PRQ support. It's also designed to support PASID_0.

The potential full definition of VTDAccelPASIDCacheEntry may like:

  typedef struct VTDAccelPASIDCacheEntry {
      VTDHostIOMMUDevice *vtd_hiod;
      VTDPASIDEntry pasid_entry;
      uint32_t pasid;
      uint32_t fs_hwpt_id;
      uint32_t fault_id;
      int fault_fd;
      QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
      IOMMUPRINotifier pri_notifier_entry;
      IOMMUPRINotifier *pri_notifier;
      QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
  } VTDAccelPASIDCacheEntry;

GIT branch: https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_pasid

PATCH01-06: Some preparing work
PATCH07-10: Handle PASID entry addition and removal
PATCH11-12: Support pasid binding and unbinding
PATCH13-14: Add PASID related check and enable PASID for passthrough device

This patchset depends on a kernel feature enhancement[1] to work.

Tests:
Tested with DSA device which driver uses 2 PASIDs by default.

Thanks
Zhenzhong

[1] https://lore.kernel.org/all/20260205023405.41583-1-zhenzhong.duan@intel.com/

Changelog:
v2:
- move the check "s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH" to patch5 (Clement)
- move #include "hw/core/iommu.h" before #include "hw/core/qdev.h" (liuyi)
- polish the comment about @Pasid parameter (Liuyi)
- s/pe/pasid_entry, s/as_it/hiod_it, s/vtd_find_add_pc/vtd_accel_fill_pc (Liuyi)
- s/VTDACCELPASIDCacheEntry/VTDAccelPASIDCacheEntry (Liuyi)
- add explanation in code about PASID removal before addition (Liuyi)
- polish the comment about scope of VTDAccelPASIDCacheEntry vs VTDPASIDCacheEntry (Liuyi)
- add an optimization to bypass PASID entry addition for PASID selective pv_inv_dsc (Liuyi)

v1:
- use naming pattern "XXX_SET_THENAME" same as smmu (Clement)
- fix s->pasid check (Clement)

RFCv2:
- extend attach/detach_hwpt() instead of introducing new callbacks (Shammer)
- Define IOMMU_NO_PASID for device attachment without pasid (Nicolin)
- update vtd_destroy_old_fs_hwpt()'s parameter for naming consistency (Clement)
- check pasid bits size to be no more than 20 bits (Clement)
- initialize local variable max_pasid_log2 to 0 (Cédric)


Zhenzhong Duan (14):
  vfio/iommufd: Extend attach/detach_hwpt callback implementations with
    pasid
  iommufd: Extend attach/detach_hwpt callbacks to support pasid
  vfio/iommufd: Create nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
    flag
  intel_iommu: Create the nested hwpt with IOMMU_HWPT_ALLOC_PASID flag
  intel_iommu: Change pasid property from bool to uint8
  intel_iommu: Export some functions
  intel_iommu_accel: Handle PASID entry addition for pc_inv_dsc request
  intel_iommu_accel: Handle PASID entry removal for pc_inv_dsc request
  intel_iommu_accel: Bypass PASID entry addition for just deleted entry
  intel_iommu_accel: Handle PASID entry removal for system reset
  intel_iommu_accel: Support pasid binding/unbinding and PIOTLB flushing
  intel_iommu_accel: drop _lock suffix in
    vtd_flush_host_piotlb_all_locked()
  intel_iommu_accel: Add pasid bits size check
  intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED when configured

 hw/i386/intel_iommu_accel.h    |  34 ++-
 hw/i386/intel_iommu_internal.h |  43 +++-
 include/hw/core/iommu.h        |   2 +
 include/hw/i386/intel_iommu.h  |   4 +-
 include/hw/vfio/vfio-device.h  |   1 +
 include/system/iommufd.h       |  16 +-
 backends/iommufd.c             |   9 +-
 hw/arm/smmuv3-accel.c          |  12 +-
 hw/i386/intel_iommu.c          |  83 +++----
 hw/i386/intel_iommu_accel.c    | 420 +++++++++++++++++++++++++++------
 hw/vfio/device.c               |  11 +
 hw/vfio/iommufd.c              |  56 +++--
 hw/vfio/trace-events           |   4 +-
 13 files changed, 524 insertions(+), 171 deletions(-)

-- 
2.47.3


