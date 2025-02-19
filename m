Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5922AC021B0
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 08:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkfPW-0005Rz-F4; Wed, 19 Feb 2025 03:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPS-0005R8-AH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:22 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tkfPO-0004ZM-AV
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 03:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739953578; x=1771489578;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n3G2+rZVAYvBLJBr7bDcazXKtkXOmjpxxwyVK8RE6fo=;
 b=Vl6diWRwWauWfr4Sm2Zik0kZMZe7roLn7j/fVFFFrByxrg1D1hQOLqhW
 lY2pM5iOP9CiQXto2HGZZOghm0HOQErL0SB97/2nHCrDNMACx+kt0+ueF
 4SiZLg7ltXcmRtfmFMmaGTqlCQrvY5k3czpZm1bdyRL0mx2iuiVWC43bi
 wQLj8zf6KgUieSI2jXY8hSavL9GxvYm+uVplvUTCk0XtDqvGBF05TnLS9
 7p5FII/JO1AHtLTOfYmtmN918ssJMfgFMFSlWGitHExlCV4V97d3jPvyz
 YedRfyY3tvbgoPdqVaIjJzMgHZyE1zxa72mPyQcB0OzkgbviAEx1o26Lx Q==;
X-CSE-ConnectionGUID: GQ6YicxnRQm29TQ5GO/NHA==
X-CSE-MsgGUID: PLL/9RU3T6OzNvbjFC/j7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40544029"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40544029"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:05 -0800
X-CSE-ConnectionGUID: SIX45rcyRym96KeumX6aww==
X-CSE-MsgGUID: dYk0yXssTXS+0LZ6dj5K6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119850762"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 00:26:01 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Date: Wed, 19 Feb 2025 16:22:08 +0800
Message-Id: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

Per Jason Wang's suggestion, iommufd nesting series[1] is split into
"Enable stage-1 translation for emulated device" series and
"Enable stage-1 translation for passthrough device" series.

This series is 2nd part focusing on passthrough device. We don't do
shadowing of guest page table for passthrough device but pass stage-1
page table to host side to construct a nested domain. There was some
effort to enable this feature in old days, see [2] for details.

The key design is to utilize the dual-stage IOMMU translation
(also known as IOMMU nested translation) capability in host IOMMU.
As the below diagram shows, guest I/O page table pointer in GPA
(guest physical address) is passed to host and be used to perform
the stage-1 address translation. Along with it, modifications to
present mappings in the guest I/O page table should be followed
with an IOTLB invalidation.

        .-------------.  .---------------------------.
        |   vIOMMU    |  | Guest I/O page table      |
        |             |  '---------------------------'
        .----------------/
        | PASID Entry |--- PASID cache flush --+
        '-------------'                        |
        |             |                        V
        |             |           I/O page table pointer in GPA
        '-------------'
    Guest
    ------| Shadow |---------------------------|--------
          v        v                           v
    Host
        .-------------.  .------------------------.
        |   pIOMMU    |  |  FS for GIOVA->GPA     |
        |             |  '------------------------'
        .----------------/  |
        | PASID Entry |     V (Nested xlate)
        '----------------\.----------------------------------.
        |             |   | SS for GPA->HPA, unmanaged domain|
        |             |   '----------------------------------'
        '-------------'
Where:
 - FS = First stage page tables
 - SS = Second stage page tables
<Intel VT-d Nested translation>

There are some interactions between VFIO and vIOMMU
* vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
  subsystem. VFIO calls them to register/unregister HostIOMMUDevice
  instance to vIOMMU at vfio device realize stage.
* vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
  to bind/unbind device to IOMMUFD backed domains, either nested
  domain or not.

See below diagram:

        VFIO Device                                 Intel IOMMU
    .-----------------.                         .-------------------.
    |                 |                         |                   |
    |       .---------|PCIIOMMUOps              |.-------------.    |
    |       | IOMMUFD |(set_iommu_device)       || Host IOMMU  |    |
    |       | Device  |------------------------>|| Device list |    |
    |       .---------|(unset_iommu_device)     |.-------------.    |
    |                 |                         |       |           |
    |                 |                         |       V           |
    |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
    |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
    |       | link    |<------------------------|  |   Device    |  |
    |       .---------|            (detach_hwpt)|  .-------------.  |
    |                 |                         |       |           |
    |                 |                         |       ...         |
    .-----------------.                         .-------------------.

Based on Yi's suggestion, this design is optimal in sharing ioas/hwpt
whenever possible and create new one on demand, also supports multiple
iommufd objects and ERRATA_772415.

E.g., Stage-2 page table could be shared by different devices if there
is no conflict and devices link to same iommufd object, i.e. devices
under same host IOMMU can share same stage-2 page table. If there is
conflict, i.e. there is one device under non cache coherency mode
which is different from others, it requires a separate stage-2 page
table in non-CC mode.

SPR platform has ERRATA_772415 which requires no readonly mappings
in stage-2 page table. This series supports creating VTDIOASContainer
with no readonly mappings. If there is a rare case that some IOMMUs
on a multiple IOMMU host have ERRATA_772415 and others not, this
design can still survive.

See below example diagram for a full view:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.    .-------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
    | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
    .------------------.    .------------------.    .-------------------.
             |                       |                              |
             |                       .-->...                        |
             V                                                      V
      .-------------------.    .-------------------.          .---------------.
      |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
      .-------------------.    .-------------------.          .---------------.
          |            |               |                            |
          |            |               |                            |
    .-----------.  .-----------.  .------------.              .------------.
    | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
    | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
    | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
    |           |  |           |  | (iommufd0) |              | (iommufd0) |
    .-----------.  .-----------.  .------------.              .------------.

This series is also a prerequisite work for vSVA, i.e. Sharing
guest application address space with passthrough devices.

To enable stage-1 translation, only need to add "x-scalable-mode=on,x-flts=on".
i.e. -device intel-iommu,x-scalable-mode=on,x-flts=on...

Passthrough device should use iommufd backend to work with stage-1 translation.
i.e. -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...

If host doesn't support nested translation, qemu will fail with an unsupported
report.

Test done:
- VFIO devices hotplug/unplug
- different VFIO devices linked to different iommufds
- vhost net device ping test

PATCH1-8:  Add HWPT-based nesting infrastructure support
PATCH9-10: Some cleanup work
PATCH11:   cap/ecap related compatibility check between vIOMMU and Host IOMMU
PATCH12-19:Implement stage-1 page table for passthrough device
PATCH20:   Enable stage-1 translation for passthrough device

Qemu code can be found at [3]

TODO:
- RAM discard
- dirty tracking on stage-2 page table

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
rfcv2:
- Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
- Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily rebase
- add two cleanup patches(patch9-10)
- VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of iommufd/devid/ioas_id
- add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as and
  iommu pasid, this is important for dropping VTDPASIDAddressSpace

Yi Liu (3):
  intel_iommu: Replay pasid binds after context cache invalidation
  intel_iommu: Propagate PASID-based iotlb invalidation to host
  intel_iommu: Refresh pasid bind when either SRTP or TE bit is changed

Zhenzhong Duan (17):
  backends/iommufd: Add helpers for invalidating user-managed HWPT
  vfio/iommufd: Add properties and handlers to
    TYPE_HOST_IOMMU_DEVICE_IOMMUFD
  HostIOMMUDevice: Introduce realize_late callback
  vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
  vfio/iommufd: Implement [at|de]tach_hwpt handlers
  host_iommu_device: Define two new capabilities
    HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
  iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
  iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA
  intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
    vtd_ce_get_pasid_entry
  intel_iommu: Optimize context entry cache utilization
  intel_iommu: Check for compatibility with IOMMUFD backed device when
    x-flts=on
  intel_iommu: Introduce a new structure VTDHostIOMMUDevice
  intel_iommu: Add PASID cache management infrastructure
  intel_iommu: Bind/unbind guest page table to host
  intel_iommu: ERRATA_772415 workaround
  intel_iommu: Bypass replay in stage-1 page table mode
  intel_iommu: Enable host device when x-flts=on in scalable mode

 hw/i386/intel_iommu_internal.h     |   56 +
 include/hw/i386/intel_iommu.h      |   33 +-
 include/system/host_iommu_device.h |   40 +
 include/system/iommufd.h           |   53 +
 backends/iommufd.c                 |   58 +
 hw/i386/intel_iommu.c              | 1660 ++++++++++++++++++++++++----
 hw/vfio/common.c                   |   17 +-
 hw/vfio/iommufd.c                  |   48 +
 backends/trace-events              |    1 +
 hw/i386/trace-events               |   13 +
 10 files changed, 1776 insertions(+), 203 deletions(-)

-- 
2.34.1


