Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE47DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KtH-0001Q4-Qa; Mon, 29 Apr 2024 02:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtF-0001MM-Nz
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:29 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KtC-0007kk-PK
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373607; x=1745909607;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HWHTMLjmI+9DUM1ywP09SLD6FzEUZtCSXcN3GPr5zjQ=;
 b=R8Qe4uo7mqeVm4LBT9ojASLReAbEt/3nwrt0h/NHLxgmtJHIRwha2mwK
 IwPHjVwxZlwkIiNAZz2dUD94Y87emsmPj5bOraqGd8g97C00no5q9XGnC
 54Jln88Hhx4kD/XF6OjN9Ll8nEO0nom1F6OhqrPYOhVNhO69q+u2iE5ll
 Army0OxSKbaD9WTusiSDMyUyiEsC5z6sauMVOgMwMK5cfR2xa8COmauSq
 WmatZaDvDa1SBby+eJf1UOsWjjzfqa5HmajAZ/jfh9cVi00BuHPMINDRW
 DSenjla47FS7B9Vg5ufQ290bSKqxqINdGj6cK0+yvcNjcPMCJyX/8fsqu w==;
X-CSE-ConnectionGUID: u3BxNX8CQda3KDpUQmQIkw==
X-CSE-MsgGUID: GgR8GKJ5RPiSD9QN+jrrKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560656"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560656"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:23 -0700
X-CSE-ConnectionGUID: 2M1NreAeRoiZXnpzgOiinw==
X-CSE-MsgGUID: g5AtAZBMRLKIWciZTFu36A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63487920"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 00/19] Add a host IOMMU device abstraction to check with
 vIOMMU
Date: Mon, 29 Apr 2024 14:50:27 +0800
Message-Id: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

The most important change in this version is instroducing a common
HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
between vIOMMU and HostIOMMUDevice.

HostIOMMUDeviceClass::realize() is introduced to initialize
HostIOMMUDeviceCaps and other fields of HostIOMMUDevice variants.

HostIOMMUDeviceClass::check_cap() is introduced to query host IOMMU
device capabilities.

After the change, part2 is only 3 patches, so merge it with part1 to be
a single prerequisite series, same for changelog. If anyone doesn't like
that, I can split again.

The class tree is as below:

                              HostIOMMUDevice
                                     | .caps
                                     | .realize()
                                     | .check_cap()
                                     |
            .-----------------------------------------------.
            |                        |                      |
HostIOMMUDeviceLegacyVFIO  {HostIOMMUDeviceLegacyVDPA}  HostIOMMUDeviceIOMMUFD
            | .vdev                  | {.vdev}              | .iommufd
                                                            | .devid
                                                            | [.ioas_id]
                                                            | [.attach_hwpt()]
                                                            | [.detach_hwpt()]
                                                            |
                                          .----------------------.
                                          |                      |
                       HostIOMMUDeviceIOMMUFDVFIO  {HostIOMMUDeviceIOMMUFDVDPA}
                                          | .vdev                | {.vdev}

* The attributes in [] will be implemented in nesting series.
* The classes in {} will be implemented in future.
* .vdev in different class points to different agent device,
* i.e., for VFIO it points to VFIODevice.

PATCH1-4: Introduce HostIOMMUDevice and its sub classes
PATCH5-11: Introduce HostIOMMUDeviceCaps, implement .realize() and .check_cap() handler
PATCH12-16: Create HostIOMMUDevice instance and pass to vIOMMU
PATCH17-19: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v3

Besides the compatibility check in this series, in nesting series, this
host IOMMU device is extended for much wider usage. For anyone interested
on the nesting series, here is the link:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
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
  vfio/container: Introduce HostIOMMUDeviceLegacyVFIO device
  backends/iommufd: Introduce abstract HostIOMMUDeviceIOMMUFD device
  vfio/iommufd: Introduce HostIOMMUDeviceIOMMUFDVFIO device
  backends/host_iommu_device: Introduce HostIOMMUDeviceCaps
  range: Introduce range_get_last_bit()
  vfio/container: Implement HostIOMMUDeviceClass::realize() handler
  backends/iommufd: Introduce helper function
    iommufd_backend_get_device_info()
  vfio/iommufd: Implement HostIOMMUDeviceClass::realize() handler
  vfio/container: Implement HostIOMMUDeviceClass::check_cap() handler
  backends/iommufd: Implement HostIOMMUDeviceClass::check_cap() handler
  vfio: Introduce VFIOIOMMUClass::hiod_typename attribute
  vfio: Create host IOMMU device instance
  hw/pci: Introduce helper function pci_device_get_iommu_bus_devfn()
  vfio/pci: Pass HostIOMMUDevice to vIOMMU
  intel_iommu: Extract out vtd_cap_init() to initialize cap/ecap
  intel_iommu: Check compatibility with host IOMMU capabilities

 MAINTAINERS                           |   2 +
 hw/i386/intel_iommu_internal.h        |   8 ++
 include/hw/i386/intel_iommu.h         |   3 +
 include/hw/pci/pci.h                  |  38 ++++-
 include/hw/vfio/vfio-common.h         |  26 ++++
 include/hw/vfio/vfio-container-base.h |   3 +
 include/qemu/range.h                  |  11 ++
 include/sysemu/host_iommu_device.h    |  95 +++++++++++++
 include/sysemu/iommufd.h              |  34 +++++
 backends/host_iommu_device.c          |  59 ++++++++
 backends/iommufd.c                    |  75 +++++++---
 hw/i386/intel_iommu.c                 | 197 ++++++++++++++++++++------
 hw/pci/pci.c                          |  75 +++++++++-
 hw/vfio/common.c                      |  18 ++-
 hw/vfio/container.c                   |  49 ++++++-
 hw/vfio/iommufd.c                     |  52 ++++++-
 hw/vfio/pci.c                         |  20 ++-
 backends/Kconfig                      |   5 +
 backends/meson.build                  |   1 +
 19 files changed, 701 insertions(+), 70 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

-- 
2.34.1


