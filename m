Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81100CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvhd-0004Ui-Gt; Mon, 17 Nov 2025 04:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvh8-0004Hb-4s
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:38:49 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvh4-0006Fj-RW
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372323; x=1794908323;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SaPWauZCovDtguFycylS01Pj0BmVIid6QW+wendfLuc=;
 b=XdNj8QavXiEFnC2hYoopzS2xT84UjWQdf9RlSNoN3aQIlp06C7jq30IN
 Ag4pZ4c2WGu5vm4XwyrTV1SdkgSJh9BWBSIew8k7+j/0v0Oab+qaIPNGg
 P1RNMkOOFW6QQB+KVq8FOFO+jft19AwEBGo5pYMtP3484soVcf+jve/Nx
 hqbLFvhbH6JJMBuo+469aNGtwjjvEaoqWfI/5kbt9Q78tj94HY8wzE6hU
 03zfjYgj3HIqJzHsrRmY7NYl+t24rOi20EU65ZgGn0M7uB2Btkv+5TYxT
 SHl2zTPVoyOQQ/5WEZSTEwJHX35zILGc3e0SCwjBOj9FNjQCxbmBXXMHT g==;
X-CSE-ConnectionGUID: WPbQi5uoTzGMdx5mIVx8gw==
X-CSE-MsgGUID: by6DJ2zNRyu5PSWurPS1tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76045854"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76045854"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:38:34 -0800
X-CSE-ConnectionGUID: +3iXa4bgSj2GuVFYFGKVjw==
X-CSE-MsgGUID: iOniffMqRUSjjrJo/BJbUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070809"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:38:30 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 00/23] intel_iommu: Enable first stage translation for
 passthrough device
Date: Mon, 17 Nov 2025 04:37:03 -0500
Message-ID: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
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
guest page table but pass first stage page table to host side to construct a
nested HWPT. There was some effort to enable this feature in old days, see
[1] for details.

The key design is to utilize the dual-stage IOMMU translation (also known as
IOMMU nested translation) capability in host IOMMU. As the below diagram shows,
guest I/O page table pointer in GPA (guest physical address) is passed to host
and be used to perform the first stage address translation. Along with it,
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
        .-------------.  .-----------------------------.
        |   pIOMMU    |  | First stage for GIOVA->GPA  |
        |             |  '-----------------------------'
        .----------------/  |
        | PASID Entry |     V (Nested xlate)
        '----------------\.--------------------------------------------.
        |             |   | Second stage for GPA->HPA, unmanaged domain|
        |             |   '--------------------------------------------'
        '-------------'
<Intel VT-d Nested translation>

This series reuse VFIO device's default HWPT as nesting parent instead of
creating new one. This way avoids duplicate code of a new memory listener,
all existing feature from VFIO listener can be shared, e.g., ram discard,
dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
under a PCI bridge with emulated device, because emulated device wants
IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off" on platform
with ERRATA_772415_SPR17, because VFIO device's default HWPT is created
with NEST_PARENT flag, kernel inhibit RO mappings when switch to shadow
mode.

This series is also a prerequisite work for vSVA, i.e. Sharing guest
application address space with passthrough devices.

There are some interactions between VFIO and vIOMMU
* vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
  subsystem. VFIO calls them to register/unregister HostIOMMUDevice
  instance to vIOMMU at vfio device realize stage.
* vIOMMU registers PCIIOMMUOps get_viommu_flags to PCI subsystem.
  VFIO calls it to get vIOMMU exposed flags.
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
    |       .---------|(get_viommu_flags)       |.-------------.    |
    |                 |                         |       |           |
    |                 |                         |       V           |
    |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
    |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
    |       | link    |<------------------------|  |   Device    |  |
    |       .---------|            (detach_hwpt)|  .-------------.  |
    |                 |                         |       |           |
    |                 |                         |       ...         |
    .-----------------.                         .-------------------.

Below is an example to enable first stage translation for passthrough device:

    -M q35,...
    -device intel-iommu,x-scalable-mode=on,x-flts=on...
    -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...

Test done:
- VFIO devices hotplug/unplug
- different VFIO devices linked to different iommufds
- vhost net device ping test
- migration with QAT passthrough

PATCH01-08: Some preparing work
PATCH09-10: Compatibility check between vIOMMU and Host IOMMU
PATCH11-16: Implement first stage translation for passthrough device
PATCH17-18: Add migration support and optimization
PATCH19-21: Workaround for ERRATA_772415_SPR17
PATCH22:    Enable first stage translation for passthrough device
PATCH23:    Add doc

Qemu code can be found at [2], it's based on
vfio-next + migration_relax_series[3].

Fault event injection to guest isn't supported in this series, we presume guest
kernel always construct correct first stage page table for passthrough device.
For emulated devices, the emulation code already provided first stage fault
injection.

TODO:
- Fault event injection to guest when HW first stage page table faults

[1] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v8
[3] https://lore.kernel.org/qemu-devel/20251106042027.856594-1-zhenzhong.duan@intel.com/

Thanks
Zhenzhong

Changelog:
v8:
- add hw/i386/intel_iommu_accel.[hc] to hold accel code (Eric)
- return bool for all vtd accel related functions (Cedric, Eric)
- introduce a new PCIIOMMUOps::get_host_iommu_quirks() (Eric, Nicolin)
- minor polishment to comment and code (Cedric, Eric)
- drop some R-b as they have changes needing review again

v7:
- s/host_iommu_extract_vendor_caps/host_iommu_extract_quirks (Nicolin)
- s/RID_PASID/PASID_0 (Eric)
- drop rid2pasid check in vtd_do_iommu_translate (Eric)
- refine DID check in vtd_pasid_cache_sync_locked (Liuyi)
- refine commit log (Nicolin, Eric, Liuyi)
- Fix doc build (Cedric)
- add migration support

v6:
- delete RPS capability related supporting code (Eric, Yi)
- use terminology 'first/second stage' to replace 'first/second level" (Eric, Yi)
- use get_viommu_flags() instead of get_viommu_caps() (Nicolin)
- drop non-RID_PASID related code and simplify pasid invalidation handling (Eric, Yi)
- drop the patch that handle pasid replay when context invalidation (Eric)
- move vendor specific cap check from VFIO core to backend/iommufd.c (Nicolin)

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
- introduce get_viommu_cap() to get STAGE1 flag to create nesting parent HWPT (Liuyi)
- reuse VFIO's default HWPT as parent HWPT of nested translation (Nicolin, Liuyi)
- abandon support of VFIO device under pcie-to-pci bridge to simplify design (Liuyi)
- bypass RO mapping in VFIO's default HWPT if ERRATA_772415_SPR17 (Liuyi)
- drop vtd_dev_to_context_entry optimization (Liuyi)

v1:
- simplify vendor specific checking in vtd_check_hiod (Cedric, Nicolin)
- rebase to master


Yi Liu (3):
  intel_iommu_accel: Propagate PASID-based iotlb invalidation to host
  intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
    changed
  intel_iommu: Replay pasid bindings after context cache invalidation

Zhenzhong Duan (20):
  intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
    vtd_ce_get_pasid_entry
  intel_iommu: Delete RPS capability related supporting code
  intel_iommu: Update terminology to match VTD spec
  hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
  hw/pci: Introduce pci_device_get_viommu_flags()
  intel_iommu: Implement get_viommu_flags() callback
  intel_iommu: Introduce a new structure VTDHostIOMMUDevice
  vfio/iommufd: Force creating nesting parent HWPT
  intel_iommu_accel: Check for compatibility with IOMMUFD backed device
    when x-flts=on
  intel_iommu_accel: Fail passthrough device under PCI bridge if
    x-flts=on
  intel_iommu_accel: Stick to system MR for IOMMUFD backed host device
    when x-flts=on
  intel_iommu: Add some macros and inline functions
  intel_iommu_accel: Bind/unbind guest page table to host
  vfio/listener: Bypass readonly region for dirty tracking
  intel_iommu: Add migration support with x-flts=on
  hw/pci: Introduce pci_device_get_host_iommu_quirks()
  intel_iommu_accel: Implement get_host_iommu_quirks() callback
  Workaround for ERRATA_772415_SPR17
  intel_iommu: Enable host device when x-flts=on in scalable mode
  docs/devel: Add IOMMUFD nesting documentation

 MAINTAINERS                      |   2 +
 docs/devel/vfio-iommufd.rst      |  25 ++
 hw/i386/intel_iommu_accel.h      |  55 ++++
 hw/i386/intel_iommu_internal.h   | 155 ++++++---
 include/hw/i386/intel_iommu.h    |   5 +-
 include/hw/iommu.h               |  30 ++
 include/hw/pci/pci.h             |  55 ++++
 include/hw/vfio/vfio-container.h |   1 +
 include/hw/vfio/vfio-device.h    |   5 +
 hw/i386/intel_iommu.c            | 530 ++++++++++++++++++-------------
 hw/i386/intel_iommu_accel.c      | 272 ++++++++++++++++
 hw/pci/pci.c                     |  35 +-
 hw/vfio/device.c                 |  26 ++
 hw/vfio/iommufd.c                |  18 +-
 hw/vfio/listener.c               |  48 ++-
 tests/qtest/intel-iommu-test.c   |   4 +-
 hw/i386/Kconfig                  |   5 +
 hw/i386/meson.build              |   1 +
 hw/i386/trace-events             |   4 +
 hw/vfio/trace-events             |   1 +
 20 files changed, 979 insertions(+), 298 deletions(-)
 create mode 100644 hw/i386/intel_iommu_accel.h
 create mode 100644 include/hw/iommu.h
 create mode 100644 hw/i386/intel_iommu_accel.c

-- 
2.47.1


