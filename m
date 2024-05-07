Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2374C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H2U-0008JX-6P; Tue, 07 May 2024 05:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2S-0008JM-PI
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:08 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2Q-00007g-0v
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073786; x=1746609786;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ECtMSJ4Hf7GDWod1eZLnSy0ZFBCaVKwnTWBkNVKQzzE=;
 b=LMPTwr61H3cnsz+R17ao1naz7fiGEtvqEzYdNq88MmEZ+aJKNLki/CdF
 TWW9NXPYyKh69mHBQsij8kEgLxRaKunBZMy1oqoDGizFQ5QzkGEOdEH2o
 wh99cil+/5wtIugoCzoKjx4pAHI2+gsipouQp6T2JUEaPAstHz8McQa7M
 TjqVZKhhZu8o1dvfkC/40pe5tqQbphoOL5s3y8ZXfYgOSgpRy0VWTAkaA
 iddItofkQt7ayp+IobRYu0IrK0FMh+2KyigMZh6qaJA/XztvPnx5zHqh/
 OWI5aNrpDZlgcKd5FvX0W9lwz3gQbDATXTE7MRSdwp6ka5N+UvVi0JVmH g==;
X-CSE-ConnectionGUID: mV8QFqDKQViin+snYekEfA==
X-CSE-MsgGUID: kqYfAPxqRUiCFwvyWD06wg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785173"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785173"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:01 -0700
X-CSE-ConnectionGUID: 2qzGpL4OT6aRwqvX1Ogz0A==
X-CSE-MsgGUID: i0maunaIRBei4cgE6QrAjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553237"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:22:58 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 00/19] Add a host IOMMU device abstraction to check with
 vIOMMU
Date: Tue,  7 May 2024 17:20:24 +0800
Message-Id: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

This series introduce a HostIOMMUDevice abstraction and sub-classes.
Also HostIOMMUDeviceCaps structure in HostIOMMUDevice and a new interface
between vIOMMU and HostIOMMUDevice.

HostIOMMUDeviceClass::realize() is introduced to initialize
HostIOMMUDeviceCaps and other fields of HostIOMMUDevice variants.

HostIOMMUDeviceClass::check_cap() is introduced to query host IOMMU
device capabilities.

The class tree is as below:

                              HostIOMMUDevice
                                     | .caps
                                     | .realize()
                                     | .check_cap()
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
PATCH5-11: Introduce HostIOMMUDeviceCaps, implement .realize() and .check_cap() handler
PATCH12-16: Create HostIOMMUDevice instance and pass to vIOMMU
PATCH17-19: Implement compatibility check between host IOMMU and vIOMMU(intel_iommu)

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_v4

Besides the compatibility check in this series, in nesting series, this
host IOMMU device is extended for much wider usage. For anyone interested
on the nesting series, here is the link:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2

Thanks
Zhenzhong

Changelog:
v3:
- move properties vdev, iommufd and devid to nesting series where need it (Cédric)
- fix 32bit build with clz64 (Cédric)
- change check_cap naming to get_cap (Cédric)
- return bool if error is passed through errp (Cédric)
- drop HostIOMMUDevice[LegacyVFIO|IOMMUFD|IOMMUFDVFIO] declaration (Cédric)
- drop HOST_IOMMU_DEVICE_CAP_IOMMUFD (Cédric)
- replace include directive with forward declaration (Cédric)

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
 hw/i386/intel_iommu_internal.h        |   8 ++
 include/hw/i386/intel_iommu.h         |   3 +
 include/hw/pci/pci.h                  |  38 ++++-
 include/hw/vfio/vfio-common.h         |   7 +
 include/hw/vfio/vfio-container-base.h |   3 +
 include/qemu/range.h                  |  11 ++
 include/sysemu/host_iommu_device.h    |  92 ++++++++++++
 include/sysemu/iommufd.h              |  20 +++
 backends/host_iommu_device.c          |  42 ++++++
 backends/iommufd.c                    |  77 +++++++---
 hw/i386/intel_iommu.c                 | 195 ++++++++++++++++++++------
 hw/pci/pci.c                          |  75 +++++++++-
 hw/vfio/common.c                      |  16 ++-
 hw/vfio/container.c                   |  50 ++++++-
 hw/vfio/iommufd.c                     |  44 +++++-
 hw/vfio/pci.c                         |  19 ++-
 backends/Kconfig                      |   5 +
 backends/meson.build                  |   1 +
 19 files changed, 638 insertions(+), 70 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

-- 
2.34.1


