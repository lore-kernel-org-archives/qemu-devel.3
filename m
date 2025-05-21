Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B138C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhTE-0005Q9-Qo; Wed, 21 May 2025 07:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTC-0005Pw-KP
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:18:46 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhT8-0006N1-7R
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826322; x=1779362322;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HWt7cLu4dN8eynQtv1LmlMi+odC7y81WOQ/S+BTpmv8=;
 b=K2zYtlVFjE0q5QK39q6WIMlG1m3hwIcqMJixVfWwVEm0QGDN2Og4T2EB
 Iu5vcI6H0iSxr++QXJT+h7op8kixABckQHEb9tchXlx0YZkIKqbxhy6/r
 89E+kk/SD8Lxc+qydTixR9vOIAweSfyxJMgSZ8SUXKS/Z/iZpoJpibCGW
 PKdYNjxbQ31fT7qbm0UgtzrnrRTojmaRXK7ZK3XgvTcW8m2vJPkmGYQzs
 S3/zMsFj1cO4/bDukqdpFWqcqM6mFTHFr4X2bUKkPiLjyBxlaKfZWD3ng
 osqmoSeE4Yf3JQ3KA0aYGmklNfi0JAhU1lcNm7TxLMv2smhUVzC6B3cfW Q==;
X-CSE-ConnectionGUID: 2ZeYHG7dTi6iCO6jWbUD6Q==
X-CSE-MsgGUID: sCzoRtTsTzujfB7rz31Xmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894849"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894849"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:39 -0700
X-CSE-ConnectionGUID: Zu10v4dYSVuhDKvw2gjQfQ==
X-CSE-MsgGUID: 37scwfy1T82RckwT2pHhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158272"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:18:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv3 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
Date: Wed, 21 May 2025 19:14:30 +0800
Message-Id: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
        |   pIOMMU    |  | Stage1 for GIOVA->GPA  |
        |             |  '------------------------'
        .----------------/  |
        | PASID Entry |     V (Nested xlate)
        '----------------\.--------------------------------------.
        |             |   | Stage2 for GPA->HPA, unmanaged domain|
        |             |   '--------------------------------------'
        '-------------'
For history reason, there are different namings in different VTD spec rev,
Where:
 - Stage1 = First stage = First level = flts
 - Stage2 = Second stage = Second level = slts
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

E.g., Under one guest's scope, Stage-2 page table could be shared by different
devices if there is no conflict and devices link to same iommufd object,
i.e. devices under same host IOMMU can share same stage-2 page table. If there
is conflict, i.e. there is one device under non cache coherency mode which is
different from others, it requires a separate stage-2 page table in non-CC mode.

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
    | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,only RW)|
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

Fault report isn't supported in this series, we presume guest kernel always
construct correct S1 page table for passthrough device. For emulated devices,
the emulation code already provided S1 fault injection.

PATCH1-6:  Add HWPT-based nesting infrastructure support
PATCH7-8:  Some cleanup work
PATCH9:    cap/ecap related compatibility check between vIOMMU and Host IOMMU
PATCH10-20:Implement stage-1 page table for passthrough device
PATCH21:   Enable stage-1 translation for passthrough device

Qemu code can be found at [3]

TODO:
- RAM discard
- dirty tracking on stage-2 page table
- Fault report to guest when HW Stage-1 faults

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv3

Thanks
Zhenzhong

Changelog:
rfcv3:
- s/hwpt_id/id in iommufd_backend_invalidate_cache()'s parameter (Shameer)
- hide vtd vendor specific caps in a wrapper union (Eric, Nicolin)
- simplify return value check of get_cap() (Eric)
- drop realize_late (Cedric, Eric)
- split patch13:intel_iommu: Add PASID cache management infrastructure (Eric)
- s/vtd_pasid_cache_reset/vtd_pasid_cache_reset_locked (Eric)
- s/vtd_pe_get_domain_id/vtd_pe_get_did (Eric)
- refine comments (Eric, Donald)

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

Zhenzhong Duan (18):
  backends/iommufd: Add a helper to invalidate user-managed HWPT
  vfio/iommufd: Add properties and handlers to
    TYPE_HOST_IOMMU_DEVICE_IOMMUFD
  vfio/iommufd: Initialize iommufd specific members in
    HostIOMMUDeviceIOMMUFD
  vfio/iommufd: Implement [at|de]tach_hwpt handlers
  vfio/iommufd: Save vendor specific device info
  iommufd: Implement query of host VTD IOMMU's capability
  intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
    vtd_ce_get_pasid_entry
  intel_iommu: Optimize context entry cache utilization
  intel_iommu: Check for compatibility with IOMMUFD backed device when
    x-flts=on
  intel_iommu: Introduce a new structure VTDHostIOMMUDevice
  intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
  intel_iommu: Handle PASID entry removing and updating
  intel_iommu: Handle PASID entry adding
  intel_iommu: Introduce a new pasid cache invalidation type FORCE_RESET
  intel_iommu: Bind/unbind guest page table to host
  intel_iommu: ERRATA_772415 workaround
  intel_iommu: Bypass replay in stage-1 page table mode
  intel_iommu: Enable host device when x-flts=on in scalable mode

 hw/i386/intel_iommu_internal.h     |   56 +
 include/hw/i386/intel_iommu.h      |   33 +-
 include/system/host_iommu_device.h |   32 +
 include/system/iommufd.h           |   54 +
 backends/iommufd.c                 |   94 +-
 hw/i386/intel_iommu.c              | 1670 ++++++++++++++++++++++++----
 hw/vfio/iommufd.c                  |   40 +
 backends/trace-events              |    1 +
 hw/i386/trace-events               |   13 +
 9 files changed, 1791 insertions(+), 202 deletions(-)

-- 
2.34.1


