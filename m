Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC761C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB86-0005Lh-2k; Tue, 27 Feb 2024 23:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB82-0005KU-SS
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:10 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB80-000087-I6
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092869; x=1740628869;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uRVbRoO+nekTbH/285z3TqXWKDREcTaHdWuLGsapt0E=;
 b=AQP+MfTq9jk3zTErySjDF5Y0omHDkKUiOWh2q7axGZpddpbNkXVgEjpl
 aF+35KnqLOKHvH7JVtSa/dQQPkV8rar/ZZsLYsJqnns78qIbH8QXe1jfN
 b59yyKMUbsdVb9OS6Z2hhGDgQKiXLemr5dRpM0B1YpWoKpTVBYCO+n3nf
 fLu2azhNLvPEJLfVOQueU+B+j33U+XWfN85yy/19mMQFVU45v96bvj/gy
 Os5xif5TTXXqdMJCmPLIS58dy7JBHX9g6WQuFlN3m6Ekfyq4kQt1vYtll
 8c8UOglDTJKiA10N/PhZcssvY+4wjykaR2xV6XWN4Lc7TM9H6c63qN82d w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342416"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342416"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917036"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:01 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 00/11] Add a host IOMMU device abstraction
Date: Wed, 28 Feb 2024 11:58:49 +0800
Message-Id: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Based on Joao's suggestion, the iommufd nesting prerequisite series [1]
is further splitted to host IOMMU device abstract part and vIOMMU
check/sync part. This series implements the 1st part.

This split also faciliates the dirty tracking series [2] and virtio-iommu
series [3] to depend on 1st part.

PATCH1-3: Introduce HostIOMMUDevice and two sub class
PATCH4: Define HostIOMMUDevice handle in VFIODevice
PATCH5-8: Introdcue host_iommu_device_create callback to allocate and intialize HostIOMMUDevice
PATCH9-10: Introdcue set/unset_iommu_device to pass HostIOMMUDevice to vIOMMU
PATCH11: a helper to get host IOMMU info

Because it's becoming clear on community's suggestion, I'd like to remove
rfc tag from this version.

Qemu code can be found at:
https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_preq_part1_v1

[1] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
[2] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/qemu-devel/20240117080414.316890-1-eric.auger@redhat.com/

Thanks
Zhenzhong

Changelog:
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

Zhenzhong Duan (10):
  Introduce a common abstract struct HostIOMMUDevice
  backends/iommufd: Introduce IOMMUFDDevice
  vfio: Introduce IOMMULegacyDevice
  vfio: Add HostIOMMUDevice handle into VFIODevice
  vfio: Introduce host_iommu_device_create callback
  vfio/container: Implement host_iommu_device_create callback in legacy
    mode
  vfio/iommufd: Implement host_iommu_device_create callback in iommufd
    mode
  vfio/pci: Allocate and initialize HostIOMMUDevice after attachment
  vfio: Pass HostIOMMUDevice to vIOMMU
  backends/iommufd: Introduce helper function iommufd_device_get_info()

 include/hw/pci/pci.h                  | 38 +++++++++++++++-
 include/hw/vfio/vfio-common.h         |  8 ++++
 include/hw/vfio/vfio-container-base.h |  1 +
 include/sysemu/host_iommu_device.h    | 22 ++++++++++
 include/sysemu/iommufd.h              | 19 ++++++++
 backends/iommufd.c                    | 32 +++++++++++++-
 hw/pci/pci.c                          | 62 +++++++++++++++++++++++++--
 hw/vfio/common.c                      |  8 ++++
 hw/vfio/container.c                   |  9 ++++
 hw/vfio/iommufd.c                     | 10 +++++
 hw/vfio/pci.c                         | 24 ++++++++---
 11 files changed, 223 insertions(+), 10 deletions(-)
 create mode 100644 include/sysemu/host_iommu_device.h

-- 
2.34.1


