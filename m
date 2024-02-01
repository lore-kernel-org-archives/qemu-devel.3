Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B639C47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 07:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRWm-0005Ci-9j; Thu, 01 Feb 2024 02:30:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWj-0005CO-IC
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:25 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWg-0001R8-Nr
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772622; x=1738308622;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3DNbYD28HZTNCXztxJEcXprhBDT9h1wgRolKaca44BI=;
 b=nReUtXJ7i1Q03mr/tRbLKvycyl5pAu3/uFmIrQtPzh7/XsxJ99q3e44r
 ex7Aa6VMCkDzW7DkoVUVWOS4CI0zuQbD0gaugm8kak7H8kgggbS9ZtUxu
 iI4Cv5rZqu6sfWArIrf4CsFOgjPEIrWnqTr1dOAIe9eE5F0vHgdRzHLH0
 vsXLlpnwTHa+hNdh+MrMotlQf6u7Wjf/pALYbvClilAA1HRVbJefoJYSa
 N4RtLut692nuFAipETZJdPF7Yg/mHWVClaEzrAEHAxVLmWYpQsKpNVtnZ
 2i0CNQ25hFzwWiiAhzgyfPJTHl/LJOw44nHxQ2bigjek9wEon+hS0MJLQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676598"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676598"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443119"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:13 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 00/18] Check and sync host IOMMU cap/ecap with vIOMMU
Date: Thu,  1 Feb 2024 15:28:00 +0800
Message-Id: <20240201072818.327930-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

This enables vIOMMU to get host IOMMU cap/ecap information by introducing
a new set/unset_iommu_device interface, then vIOMMU could check or sync
with vIOMMU's own cap/ecap config.

It works by having device side, i.e. VFIO, register either an IOMMULegacyDevice
or IOMMUFDDevice to vIOMMU, which includes necessary data to archive that.
Currently only VFIO device is supported, but it could also be used for other
devices, i.e., VDPA.

For coldplugged device, we can get its host IOMMU cap/ecap during qemu init,
then check and sync into vIOMMU cap/ecap.
For hotplugged device, vIOMMU cap/ecap is frozen, we could only check with
vIOMMU cap/ecap, not allowed to update. IF check fails, hotplugged will fail.

This is also a prerequisite for incoming iommufd nesting series:
'intel_iommu: Enable stage-1 translation'.

I didn't implement cap/ecap sync for legacy VFIO backend, would like to see
what Eric want to put in IOMMULegacyDevice for virtio-iommu and if I can
utilize some of them.

PATCH1-3: Introduce HostIOMMUDevice and two sub class
PATCH4-5: Define HostIOMMUDevice instance in VFIODevice
PATCH6-9: Introdcue host_iommu_device_init callback to intialize HostIOMMUDevice
PATCH10-12: Introdcue set/unset_iommu_device to pass HostIOMMUDevice to vIOMMU
PATCH13-18: Implement cap/ecap check and sync in intel_iommu

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_rfcv2

Thanks
Zhenzhong


Changelog:
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


Yi Liu (3):
  hw/pci: Introduce pci_device_set/unset_iommu_device()
  intel_iommu: Add set/unset_iommu_device callback
  intel_iommu: Add a framework to check and sync host IOMMU cap/ecap

Zhenzhong Duan (15):
  Introduce a common abstract struct HostIOMMUDevice
  backends/iommufd: Introduce IOMMUFDDevice
  vfio: Introduce IOMMULegacyDevice
  vfio: Add host iommu device instance into VFIODevice
  vfio: Remove redundant iommufd and devid elements in VFIODevice
  vfio: Introduce host_iommu_device_init callback
  vfio/container: Implement host_iommu_device_init callback in legacy
    mode
  vfio/iommufd: Implement host_iommu_device_init callback in iommufd
    mode
  vfio/pci: Initialize host iommu device instance after attachment
  vfio: Initialize host IOMMU device and pass to vIOMMU
  intel_iommu: Extract out vtd_cap_init to initialize cap/ecap
  backends/iommufd: Introduce helper function iommufd_device_get_info()
  intel_iommu: Implement check and sync mechanism in iommufd mode
  intel_iommu: Use mgaw instead of s->aw_bits
  intel_iommu: Block migration if cap is updated

 hw/i386/intel_iommu_internal.h        |  15 ++
 include/hw/i386/intel_iommu.h         |   4 +
 include/hw/pci/pci.h                  |  38 +++-
 include/hw/vfio/vfio-common.h         |  20 +-
 include/hw/vfio/vfio-container-base.h |   1 +
 include/sysemu/host_iommu_device.h    |  22 ++
 include/sysemu/iommufd.h              |  18 ++
 backends/iommufd.c                    |  31 ++-
 hw/i386/acpi-build.c                  |   3 +-
 hw/i386/intel_iommu.c                 | 279 ++++++++++++++++++++------
 hw/pci/pci.c                          |  62 +++++-
 hw/vfio/ap.c                          |   2 +-
 hw/vfio/ccw.c                         |   2 +-
 hw/vfio/common.c                      |  10 +-
 hw/vfio/container.c                   |   7 +
 hw/vfio/helpers.c                     |   2 +-
 hw/vfio/iommufd.c                     |  32 +--
 hw/vfio/pci.c                         |  25 ++-
 hw/vfio/platform.c                    |   3 +-
 19 files changed, 488 insertions(+), 88 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h

-- 
2.34.1


