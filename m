Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46279C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0wg-0004b0-Kv; Mon, 03 Jun 2024 02:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wZ-0004Te-0C
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wV-0000rs-ML
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395196; x=1748931196;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cfQgQ8oW2HAPvYU7TUYRETswYC6mIu8VZgC9XicwxAI=;
 b=So4LjEWZi4bvmP/lmrsDGeiP5IGLWn6bL4NlMCfYyXg0FbfPjPp3t3zu
 g3noIHcfDtSbEsZJ7F9HSMl96ZSFLuY56k48NbapazVPKw0bn5InD6Ln/
 5m6jiqdP4yBvLrtFZTxl1+B66K7VyfBqTQOIEqnyKO8ngfTTaEMZYihjx
 29+6ZX7VMaC0t33XHodq8rfOjK44xONjmitN5fVfpjuvzm0Zlr3P7/6kB
 GftIpZQyQhsFaRxHGd5SHRhRPvppL4+ZnfzmMOR1Ut5pvyTO+OO6VuUyc
 SctFsygmIgl57xnojUwdcAZFjaC4zgsDwdfSnxRQ0SEQXnUIT6Fsn2hjP Q==;
X-CSE-ConnectionGUID: Uie5vHyST6+B1ZdlA25meQ==
X-CSE-MsgGUID: xc4BsQzhTwa9frBdAkzyjQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277606"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277606"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:11 -0700
X-CSE-ConnectionGUID: sXsMrq3iRR66XrzTw6RkMw==
X-CSE-MsgGUID: Wm1d8FJqQkGv2+AX9fIWKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855805"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 00/19] Add a host IOMMU device abstraction to check with
 vIOMMU
Date: Mon,  3 Jun 2024 14:10:04 +0800
Message-Id: <20240603061023.269738-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series introduce a HostIOMMUDevice abstraction and sub-classes.
Also HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
between vIOMMU and HostIOMMUDevice.

HostIOMMUDeviceClass::realize() is introduced to initialize
HostIOMMUDeviceCaps and other fields of HostIOMMUDevice variants.

HostIOMMUDeviceClass::get_cap() is introduced to query host IOMMU
device capabilities.

The class tree is as below:

                              HostIOMMUDevice
                                     | .caps
                                     | .realize()
                                     | .get_cap()
                                     |
            .-----------------------------------------------.
            |                        |                      |
HostIOMMUDeviceLegacyVFIO  {HostIOMMUDeviceLegacyVDPA}  HostIOMMUDeviceIOMMUFD
            |                        |                      | [.iommufd]
                                                            | [.devid]
                                                            | [.ioas_id]
                                                            | [.attach_hwpt()]
                                                            | [.detach_hwpt()]
                                                            |
                                            .----------------------.
                                            |                      |
                         HostIOMMUDeviceIOMMUFDVFIO  {HostIOMMUDeviceIOMMUFDVDPA}
                                          | [.vdev]                | {.vdev}

* The attributes in [] will be implemented in nesting series.
* The classes in {} will be implemented in future.
* .vdev in different class points to different agent device,
* i.e., for VFIO it points to VFIODevice.

PATCH1-4: Introduce HostIOMMUDevice and its sub classes
PATCH5-11: Introduce HostIOMMUDeviceCaps, implement .realize() and .get_cap() handler
PATCH12-16: Create HostIOMMUDevice instance and pass to vIOMMU
PATCH17-19: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)

Test done:
make check
vfio device hotplug/unplug with different backend on linux
reboot
build test on linux and windows11

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v6

Besides the compatibility check in this series, in nesting series, this
host IOMMU device is extended for much wider usage. For anyone interested
on the nesting series, here is the link:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
v6:
- Open coded host_iommu_device_get_cap() to avoid #ifdef in intel_iommu.c (Cédric)

v5:
- pci_device_set_iommu_device return true (Cédric)
- fix build failure on windows (thanks Cédric found that issue)

v4:
- move properties vdev, iommufd and devid to nesting series where need it (Cédric)
- fix 32bit build with clz64 (Cédric)
- change check_cap naming to get_cap (Cédric)
- return bool if error is passed through errp (Cédric)
- drop HostIOMMUDevice[LegacyVFIO|IOMMUFD|IOMMUFDVFIO] declaration (Cédric)
- drop HOST_IOMMU_DEVICE_CAP_IOMMUFD (Cédric)
- replace include directive with forward declaration (Cédric)

v3:
- refine declaration and doc for HostIOMMUDevice (Cédric, Philippe)
- introduce HostIOMMUDeviceCaps, .realize() and .check_cap() (Cédric)
- introduce helper range_get_last_bit() for range operation (Cédric)
- separate pci_device_get_iommu_bus_devfn() in a prereq patch (Cédric)
- replace HIOD_ abbreviation with HOST_IOMMU_DEVICE_ (Cédric)
- add header in include/sysemu/iommufd.h (Cédric)

v2:
- use QOM to abstract host IOMMU device and its sub-classes (Cédric)
- move host IOMMU device creation in attach_device() (Cédric)
- refine pci_device_set/unset_iommu_device doc further (Eric)
- define host IOMMU info format of different backend
- implement get_host_iommu_info() for different backend (Cédric)
- drop cap/ecap update logic (MST)
- check aw-bits from get_host_iommu_info() in legacy mode

v1:
- use HostIOMMUDevice handle instead of union in VFIODevice (Eric)
- change host_iommu_device_init to host_iommu_device_create
- allocate HostIOMMUDevice in host_iommu_device_create callback
  and set the VFIODevice base_hdev handle (Eric)
- refine pci_device_set/unset_iommu_device doc (Eric)
- use HostIOMMUDevice handle instead of union in VTDHostIOMMUDevice (Eric)
- convert HostIOMMUDevice to sub object pointer in vtd_check_hdev

rfcv2:
- introduce common abstract HostIOMMUDevice and sub struct for different BEs (Eric, Cédric)
- remove iommufd_device.[ch] (Cédric)
- remove duplicate iommufd/devid define from VFIODevice (Eric)
- drop the p in aliased_pbus and aliased_pdevfn (Eric)
- assert devfn and iommu_bus in pci_device_get_iommu_bus_devfn (Cédric, Eric)
- use errp in iommufd_device_get_info (Eric)
- split and simplify cap/ecap check/sync code in intel_iommu.c (Cédric)
- move VTDHostIOMMUDevice declaration to intel_iommu_internal.h (Cédric)
- make '(vtd->cap_reg >> 16) & 0x3fULL' a MACRO and add missed '+1' (Cédric)
- block migration if vIOMMU cap/ecap updated based on host IOMMU cap/ecap
- add R-B

Yi Liu (2):
  hw/pci: Introduce pci_device_[set|unset]_iommu_device()
  intel_iommu: Implement [set|unset]_iommu_device() callbacks

Zhenzhong Duan (17):
  backends: Introduce HostIOMMUDevice abstract
  vfio/container: Introduce TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO device
  backends/iommufd: Introduce abstract TYPE_HOST_IOMMU_DEVICE_IOMMUFD
    device
  vfio/iommufd: Introduce TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO device
  backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
  range: Introduce range_get_last_bit()
  vfio/container: Implement HostIOMMUDeviceClass::realize() handler
  backends/iommufd: Introduce helper function
    iommufd_backend_get_device_info()
  vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
  vfio/container: Implement HostIOMMUDeviceClass::get_cap() handler
  backends/iommufd: Implement HostIOMMUDeviceClass::get_cap() handler
  vfio: Introduce VFIOIOMMUClass::hiod_typename attribute
  vfio: Create host IOMMU device instance
  hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
  vfio/pci: Pass HostIOMMUDevice to vIOMMU
  intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
  intel_iommu: Check compatibility with host IOMMU capabilities

 MAINTAINERS                           |   2 +
 hw/i386/intel_iommu_internal.h        |   9 ++
 include/hw/i386/intel_iommu.h         |   3 +
 include/hw/pci/pci.h                  |  38 ++++-
 include/hw/vfio/vfio-common.h         |   7 +
 include/hw/vfio/vfio-container-base.h |   3 +
 include/qemu/range.h                  |  11 ++
 include/sysemu/host_iommu_device.h    |  88 ++++++++++++
 include/sysemu/iommufd.h              |  19 +++
 backends/host_iommu_device.c          |  30 ++++
 backends/iommufd.c                    |  76 ++++++++--
 hw/i386/intel_iommu.c                 | 198 ++++++++++++++++++++------
 hw/pci/pci.c                          |  75 +++++++++-
 hw/vfio/common.c                      |  16 ++-
 hw/vfio/container.c                   |  48 ++++++-
 hw/vfio/iommufd.c                     |  44 +++++-
 hw/vfio/pci.c                         |  19 ++-
 backends/Kconfig                      |   5 +
 backends/meson.build                  |   1 +
 19 files changed, 623 insertions(+), 69 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

-- 
2.34.1


