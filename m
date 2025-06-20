Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CAAC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW4p-0004Xh-6j; Fri, 20 Jun 2025 03:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW4m-0004XO-JW
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:17 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW4j-0008FB-QF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404134; x=1781940134;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=AC9VZNRkms8k+/0lirgFaos7m/5KcQFJbiGKfH910sM=;
 b=ZeI6lnk5mcbu8mb+j9mVYXVyURHKJnWmrMfu1XQdnhi/TmkIqoiXbEb8
 RFkh3BGwRLpifMCV1rTo99HqJxjmhTLz8PhYPjJRDDO4ZLKCLLIiCRB6H
 oXhTZxbr2QuUkxu9KBsx4EDcyu7KqZRDFElBxBvUiPoqkaMWmHUq5W2G6
 EwcKlVJ9rmKW/YHsbnZM3uzobkOqHyjf4ydoihMFKNs/WOKjKq9hW2b7I
 1hcAyM8QO1nctmAzQ/StwAWlSRah34dMBsUozohxIFWrbBhQYPZTYP/S2
 /M683Ml7h2ILwjBQLTnCj96nARVqTEJAZhG8ksn0tZdJrvxZnzjglhf0c A==;
X-CSE-ConnectionGUID: NjLbYt5sTWmg2R5jFSMoMQ==
X-CSE-MsgGUID: rhxoWpiER3+8T+nlDMWlTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532234"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532234"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:09 -0700
X-CSE-ConnectionGUID: BIpFjnrtTcmLGYxzmosBDg==
X-CSE-MsgGUID: 8vfCQosBRp2tWX6Wt7GaxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863029"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 00/19] intel_iommu: Enable stage-1 translation for
 passthrough device
Date: Fri, 20 Jun 2025 15:17:54 +0800
Message-Id: <20250620071813.55571-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

For passthrough device with intel_iommu.x-flts=on, we don't do shadowing of
guest page table for passthrough device but pass stage-1 page table to host
side to construct a nested domain. There was some effort to enable this feature
in old days, see [1] for details.

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

This series reuse VFIO device's default hwpt as nested parent instead of
creating new one. This way avoids duplicate code of a new memory listener,
all existing feature from VFIO listener can be shared, e.g., ram discard,
dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
under a PCI bridge with emulated device, because emulated device wants
IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off", because
VFIO device's default hwpt is created with NEST_PARENT flag, kernel
inhibit RO mappings when switch to shadow mode.

This series is also a prerequisite work for vSVA, i.e. Sharing guest
application address space with passthrough devices.

There are some interactions between VFIO and vIOMMU
* vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
  subsystem. VFIO calls them to register/unregister HostIOMMUDevice
  instance to vIOMMU at vfio device realize stage.
* vIOMMU registers PCIIOMMUOps get_viommu_cap to PCI subsystem.
  VFIO calls it to get vIOMMU exposed capabilities.
* vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
  to bind/unbind device to IOMMUFD backed domains, either nested
  domain or not.

See below diagram:

        VFIO Device                                 Intel IOMMU
    .-----------------.                         .-------------------.
    |                 |                         |                   |
    |       .---------|PCIIOMMUOps              |.-------------.    |
    |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |    |
    |       | Device  |------------------------>|| Device list |    |
    |       .---------|(get_viommu_cap)         |.-------------.    |
    |                 |                         |       |           |
    |                 |                         |       V           |
    |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
    |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
    |       | link    |<------------------------|  |   Device    |  |
    |       .---------|            (detach_hwpt)|  .-------------.  |
    |                 |                         |       |           |
    |                 |                         |       ...         |
    .-----------------.                         .-------------------.

Below is an exmaple to enable stage-1 translation for passthrough device:

    -M q35,...
    -device intel-iommu,x-scalable-mode=on,x-flts=on...
    -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...

Test done:
- VFIO devices hotplug/unplug
- different VFIO devices linked to different iommufds
- vhost net device ping test

PATCH1-6:  Some preparing work
PATCH7-8:  Compatibility check between vIOMMU and Host IOMMU
PATCH9-18: Implement stage-1 page table for passthrough device
PATCH19:   Enable stage-1 translation for passthrough device

Qemu code can be found at [2]

Fault report isn't supported in this series, we presume guest kernel always
construct correct stage1 page table for passthrough device. For emulated
devices, the emulation code already provided stage1 fault injection.

TODO:
- Fault report to guest when HW stage1 faults

[1] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v2

Thanks
Zhenzhong

Changelog:
v2:
- introduce get_viommu_cap() to get STAGE1 flag to create nested parent hwpt (Liuyi)
- reuse VFIO's default hwpt as parent hwpt of nested translation (Nicolin, Liuyi)
- abandon support of VFIO device under pcie-to-pci bridge to simplify design (Liuyi)
- bypass RO mapping in VFIO's default hwpt if ERRATA_772415_SPR17 (Liuyi)
- drop vtd_dev_to_context_entry optimization (Liuyi)

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

Zhenzhong Duan (16):
  intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
    vtd_ce_get_pasid_entry
  hw/pci: Introduce pci_device_get_viommu_cap()
  intel_iommu: Implement get_viommu_cap() callback
  vfio/iommufd: Force creating nested parent domain
  hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
  intel_iommu: Introduce a new structure VTDHostIOMMUDevice
  intel_iommu: Check for compatibility with IOMMUFD backed device when
    x-flts=on
  intel_iommu: Fail passthrough device under PCI bridge if x-flts=on
  intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
  intel_iommu: Handle PASID entry removing and updating
  intel_iommu: Handle PASID entry adding
  intel_iommu: Introduce a new pasid cache invalidation type FORCE_RESET
  intel_iommu: Stick to system MR for IOMMUFD backed host device when
    x-fls=on
  intel_iommu: Bind/unbind guest page table to host
  Workaround for ERRATA_772415_SPR17
  intel_iommu: Enable host device when x-flts=on in scalable mode

 MAINTAINERS                           |    1 +
 hw/i386/intel_iommu_internal.h        |   56 ++
 include/hw/i386/intel_iommu.h         |    8 +-
 include/hw/iommu.h                    |   14 +
 include/hw/pci/pci.h                  |   24 +
 include/hw/vfio/vfio-container-base.h |    1 +
 hw/i386/intel_iommu.c                 | 1023 ++++++++++++++++++++++++-
 hw/pci/pci.c                          |   23 +-
 hw/vfio/iommufd.c                     |   22 +-
 hw/vfio/listener.c                    |   13 +-
 hw/i386/trace-events                  |    8 +
 11 files changed, 1160 insertions(+), 33 deletions(-)
 create mode 100644 include/hw/iommu.h

-- 
2.34.1


