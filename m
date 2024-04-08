Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0DC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 08:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtk9m-0002kD-Jm; Mon, 08 Apr 2024 04:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9l-0002jz-58
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:09 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rtk9i-00081z-Tf
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 04:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712564107; x=1744100107;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=rC7Xx4PH74uMcqcgF1eP97UItKcRmNkaeHrgUmBaGyg=;
 b=carhP693p9MShw1ITjWV41t9NzYwsKmIf9+rf0kdnuc01/xQVc4AB9Y/
 hJsjcKurxmGiJm688w9KTfTCAuk7P+6GB9eRoAFaUNdCIAar0P89wg1UY
 7l7tQOcMzY57nFtRY8gZndvH3+CLI3BSnYfNvT3lyMmskVyJd6j3oy4BJ
 pRYDBMOqpmGuz9k504cW8NN/7KoHsT/PJYuEfrTmxvcsFy781LI7wZopL
 DY4jTLziJ+KJm0AiC5fMFMYwc6p4ILMeUovk+qkJ0uMdn5q2LNdfzXQef
 bdSvpkAGOwhRX2GFsxqyjdvN2JB5qdKkVnJEvS+uqsSHqSOo2BdnpGF0+ Q==;
X-CSE-ConnectionGUID: QoU1Ct8UTQKxXTH1ec/QmA==
X-CSE-MsgGUID: IvJ6+jePSbCpvCt8rxa4Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="19199654"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19199654"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:03 -0700
X-CSE-ConnectionGUID: 9a3bYI6oRUmyw4J56TjqXQ==
X-CSE-MsgGUID: +TBlYr4pT4+qDZCpKfYLyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; d="scan'208";a="19845163"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2024 01:15:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 00/10] Add a host IOMMU device abstraction
Date: Mon,  8 Apr 2024 16:12:20 +0800
Message-Id: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Based on Joao's suggestion, the iommufd nesting prerequisite series [1]
is further splitted to host IOMMU device abstract part and vIOMMU
check part. This series implements the 1st part.

This split also faciliates the dirty tracking series [2] and virtio-iommu
series [3] to depend on 1st part.

The major change in this version is to use QOM, the class tree is as below:

                        HostIOMMUDevice
                               | .get_host_iommu_info()
                               |
                               |
            .------------------------------------.
            |                  |                 |
      HIODLegacyVFIO    [HIODLegacyVDPA]    HIODIOMMUFD
            | .vdev            | [.vdev]         | .iommufd
                                                 | .devid
                                                 | [.ioas_id]
                                                 | [.attach_hwpt()]
                                                 | [.detach_hwpt()]
                                                 |
                                    .----------------------.
                                    |                      |
                           HIODIOMMUFDVFIO         [HIODIOMMUFDVDPA]
                                    | .vdev                | [.vdev]

* The classes in [] will be implemented in future.
* .ioas_id, .attach/detach_hwpt() will be implemented in nesting series.
* .vdev in different class points to different agent device,
* i.e., for VFIO it points to VFIODevice.

PATCH1-4: Introduce HostIOMMUDevice and its sub classes
PATCH5-7: Implement get_host_iommu_info() callback
PATCH8-10: Create HostIOMMUDevice instance and pass to vIOMMU

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_part1_v2

[1] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
[2] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/qemu-devel/20240117080414.316890-1-eric.auger@redhat.com/

Thanks
Zhenzhong

Changelog:
v2:
- use QOM to abstract host IOMMU device and its sub-classes (Cédric)
- move host IOMMU device creation in attach_device() (Cédric)
- refine pci_device_set/unset_iommu_device doc futher (Eric)
- define host IOMMU info format of different backend
- implement get_host_iommu_info() for different backend (Cédric)

v1:
- use HostIOMMUDevice handle instead of union in VFIODevice (Eric)
- change host_iommu_device_init to host_iommu_device_create
- allocate HostIOMMUDevice in host_iommu_device_create callback
  and set the VFIODevice base_hdev handle (Eric)
- refine pci_device_set/unset_iommu_device doc (Eric)
- use HostIOMMUDevice handle instead of union in VTDHostIOMMUDevice (Eric)

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


Yi Liu (1):
  hw/pci: Introduce pci_device_set/unset_iommu_device()

Zhenzhong Duan (9):
  backends: Introduce abstract HostIOMMUDevice
  vfio: Introduce HIODLegacyVFIO device
  backends/iommufd: Introduce abstract HIODIOMMUFD device
  vfio/iommufd: Introduce HIODIOMMUFDVFIO device
  vfio: Implement get_host_iommu_info() callback
  backends/iommufd: Introduce helper function
    iommufd_backend_get_device_info()
  backends/iommufd: Implement get_host_iommu_info() callback
  vfio: Create host IOMMU device instance
  vfio: Pass HostIOMMUDevice to vIOMMU

 MAINTAINERS                        |  2 +
 include/hw/pci/pci.h               | 40 +++++++++++++-
 include/hw/vfio/vfio-common.h      | 23 ++++++++
 include/sysemu/host_iommu_device.h | 29 ++++++++++
 include/sysemu/iommufd.h           | 33 ++++++++++++
 backends/host_iommu_device.c       | 19 +++++++
 backends/iommufd.c                 | 85 ++++++++++++++++++++++++------
 hw/pci/pci.c                       | 75 ++++++++++++++++++++++++--
 hw/vfio/container.c                | 40 +++++++++++++-
 hw/vfio/iommufd.c                  | 19 ++++++-
 hw/vfio/pci.c                      | 20 +++++--
 backends/Kconfig                   |  5 ++
 backends/meson.build               |  1 +
 13 files changed, 364 insertions(+), 27 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h
 create mode 100644 backends/host_iommu_device.c

-- 
2.34.1


