Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBEBC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTzm-0008DB-V1; Fri, 06 Jun 2025 06:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTzk-0008Cy-Ug
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:17 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTzg-0007Yu-RW
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204493; x=1780740493;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=A88u28mt0bKFJUV/RTKwful70/8bb19NSOCtlBowFbQ=;
 b=FwoucjviT95qktIdUkvSjGYr/u5q0DaKn9Y6mYTK7NLJGc1cE9jOLvYt
 Ri8AzZr+udfZ0ZP+NgWIy5zU73P2o8Oz2tNQBeFRAv5wrLwnaQJoN/74I
 KHeRjXqzhvHMzCcNzU9djn2ZNMOzFDTrNhhS/zgbDTP2mKKstjT2Y835k
 W09dvjywGoWTR4GUnLWstoLEAfMU4MI/duFC2y9RnGuhsDZNlgYhJBsJe
 ERkt0qAMbtcq+BTHrlsOVvyi9XRQEt8ANVmCYisloDrIXDnZUFDAsQuLy
 3jIOfmmFVwEjlsSAQKqiUJ3WHuKDjJc1K8aIHqRZtYDcjP3amSMKQpB5S w==;
X-CSE-ConnectionGUID: aVc9NwK1TU2x8s6KMWd+2Q==
X-CSE-MsgGUID: xTRc95mlTVK3GCRILBb1lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747154"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747154"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:10 -0700
X-CSE-ConnectionGUID: c4fblvZBS+qdhrdVJDHTmQ==
X-CSE-MsgGUID: TtPIv0BqRCmYiSP1hvYlSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759030"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 00/15] intel_iommu: Enable stage-1 translation for
 passthrough device
Date: Fri,  6 Jun 2025 18:04:01 +0800
Message-Id: <20250606100416.346132-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

After VFIO/IOMMUFD prerequisite patchset got accepted, now this focuses on
stage-1 translation for passthrough device in intel_iommu. I thought it's
time to bump to v1 from rfcv3.

rfcv3 cover-letter:

Per Jason Wang's suggestion, iommufd nesting series[1] is split into
"Enable stage-1 translation for emulated device" series and
"Enable stage-1 translation for passthrough device" series.

This series is 2nd part focusing on passthrough device. We don't do shadowing
of guest page table for passthrough device but pass stage-1 page table to host
side to construct a nested domain. There was some effort to enable this feature
in old days, see [2] for details.

The key design is to utilize the dual-stage IOMMU translation (also known as
IOMMU nested translation) capability in host IOMMU. As the below diagram shows,
guest I/O page table pointer in GPA (guest physical address) is passed to host
and be used to perform the stage-1 address translation. Along with it,
modifications to present mappings in the guest I/O page table should be followed
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
- build on windows

Fault report isn't supported in this series, we presume guest kernel always
construct correct S1 page table for passthrough device. For emulated devices,
the emulation code already provided S1 fault injection.

PATCH1-2:  Some cleanup work
PATCH3:    cap/ecap related compatibility check between vIOMMU and Host IOMMU
PATCH4-14: Implement stage-1 page table for passthrough device
PATCH15:   Enable stage-1 translation for passthrough device

Qemu code can be found at [3]

TODO:
- RAM discard
- dirty tracking on stage-2 page table
- Fault report to guest when HW S1 faults

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
[2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v1

Thanks
Zhenzhong

Changelog:
v1:
- simplify vendor specific checking in vtd_check_hiod (Cedric, Nicolin)
- rebase to master

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

Zhenzhong Duan (12):
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

 hw/i386/intel_iommu_internal.h |   56 ++
 include/hw/i386/intel_iommu.h  |   33 +-
 hw/i386/intel_iommu.c          | 1659 ++++++++++++++++++++++++++++----
 hw/i386/trace-events           |   13 +
 4 files changed, 1563 insertions(+), 198 deletions(-)

-- 
2.34.1


