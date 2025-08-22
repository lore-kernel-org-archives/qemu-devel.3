Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C243CA0FE1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLT0-0007s3-Pr; Fri, 22 Aug 2025 02:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLSv-0007nd-BD
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:34 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLSq-0000ij-J4
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844888; x=1787380888;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zXumKBdZuRAUYmg3xluk5iQbzF3gco0A1S+CjPSylXU=;
 b=BmnTkVyV9Zncq/H76RAxO4dZKCPXpPF6G7njucv7556NHJlECjIV6uom
 Gia+aiIww5DRO5uVcOFc9LFk/SIAPd8uqHytg2hE4xdr/u11n3dN06NEu
 AUE6Klt5fGN1V8mfgzWWSXs8uCV4YwJHLdcfn7V5NOHNbEfXIrDam+kGz
 8d0p96y7pUrkFChsCgvJ8dWHL3V++YXZeu5T8xcNY+p6tuwLBmICau91D
 U/7uNxgOg33cxsnf+aVyg4X1Nxl3uDga5e1dCtB0c0rog5haCNDX+NsE1
 UY4Ts4bvchrzOl4nIeQGda1HQVtH6To0dbiQdLSLhJApn5FqSQlCTkUVH w==;
X-CSE-ConnectionGUID: QDgGo1htS2aD9ZZ8va9dLA==
X-CSE-MsgGUID: SO87ixYMRGyiE51BGHRXFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851738"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851738"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:23 -0700
X-CSE-ConnectionGUID: LkD4jErRSxKA0DmRgIluiw==
X-CSE-MsgGUID: ZZ4MS9kVRlqC12UJchUSzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244822"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
Date: Fri, 22 Aug 2025 02:40:38 -0400
Message-ID: <20250822064101.123526-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Below is an example to enable stage-1 translation for passthrough device:

    -M q35,...
    -device intel-iommu,x-scalable-mode=on,x-flts=on...
    -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...

Test done:
- VFIO devices hotplug/unplug
- different VFIO devices linked to different iommufds
- vhost net device ping test

PATCH1-7:  Some preparing work
PATCH8-9:  Compatibility check between vIOMMU and Host IOMMU
PATCH10-18:Implement stage-1 page table for passthrough device
PATCH19-20:Workaround for ERRATA_772415_SPR17
PATCH21:   Enable stage-1 translation for passthrough device

Qemu code can be found at [2]

Fault report isn't supported in this series, we presume guest kernel always
construct correct stage1 page table for passthrough device. For emulated
devices, the emulation code already provided stage1 fault injection.

TODO:
- Fault report to guest when HW stage1 faults

[1] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v5

Thanks
Zhenzhong

Changelog:
v5:
- refine commit log of patch2 (Cedric, Nicolin)
- introduce helper vfio_pci_from_vfio_device() (Cedric)
- introduce helper vfio_device_viommu_get_nested() (Cedric)
- pass 'bool bypass_ro' argument to vfio_listener_valid_section() instead of 'VFIOContainerBase *' (Cedric)
- fix a potential build error reported by Jim Shu

v4:
- s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin, Donald, Shameer)
- clarify get_viommu_cap() return pure emulated caps and explain reason in commit log (Eric)
- retrieve the ce only if vtd_as->pasid in vtd_as_to_iommu_pasid_locked (Eric)
- refine doc comment and commit log in patch10-11 (Eric)

v3:
- define enum type for VIOMMU_CAP_* (Eric)
- drop inline flag in the patch which uses the helper (Eric)
- use extract64 in new introduced MACRO (Eric)
- polish comments and fix typo error (Eric)
- split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
- optimize bind/unbind error path processing

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
  intel_iommu: Replay pasid bindings after context cache invalidation
  intel_iommu: Propagate PASID-based iotlb invalidation to host
  intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
    changed

Zhenzhong Duan (18):
  intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
    vtd_ce_get_pasid_entry
  hw/pci: Introduce pci_device_get_viommu_cap()
  intel_iommu: Implement get_viommu_cap() callback
  vfio: Introduce helper vfio_pci_from_vfio_device()
  vfio/iommufd: Force creating nested parent domain
  hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
  intel_iommu: Introduce a new structure VTDHostIOMMUDevice
  intel_iommu: Check for compatibility with IOMMUFD backed device when
    x-flts=on
  intel_iommu: Fail passthrough device under PCI bridge if x-flts=on
  intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
  intel_iommu: Handle PASID entry removal and update
  intel_iommu: Handle PASID entry addition
  intel_iommu: Introduce a new pasid cache invalidation type FORCE_RESET
  intel_iommu: Stick to system MR for IOMMUFD backed host device when
    x-fls=on
  intel_iommu: Bind/unbind guest page table to host
  vfio: Add a new element bypass_ro in VFIOContainerBase
  Workaround for ERRATA_772415_SPR17
  intel_iommu: Enable host device when x-flts=on in scalable mode

 MAINTAINERS                           |   1 +
 hw/i386/intel_iommu_internal.h        |  68 +-
 hw/vfio/pci.h                         |  12 +
 include/hw/i386/intel_iommu.h         |   9 +-
 include/hw/iommu.h                    |  19 +
 include/hw/pci/pci.h                  |  27 +
 include/hw/vfio/vfio-container-base.h |   1 +
 include/hw/vfio/vfio-device.h         |   2 +
 hw/i386/intel_iommu.c                 | 941 +++++++++++++++++++++++++-
 hw/pci/pci.c                          |  23 +-
 hw/vfio/container.c                   |   4 +-
 hw/vfio/device.c                      |  14 +-
 hw/vfio/iommufd.c                     |  20 +-
 hw/vfio/listener.c                    |  25 +-
 hw/vfio/pci.c                         |   9 +
 hw/i386/trace-events                  |   8 +
 16 files changed, 1131 insertions(+), 52 deletions(-)
 create mode 100644 include/hw/iommu.h


base-commit: 88f72048d2f5835a1b9eaba690c7861393aef283
-- 
2.47.1


