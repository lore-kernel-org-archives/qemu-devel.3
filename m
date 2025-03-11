Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829C0C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0Ku-0008MP-MI; Tue, 11 Mar 2025 10:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Kt-0008Lh-3u; Tue, 11 Mar 2025 10:11:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1ts0Kq-0006m2-6v; Tue, 11 Mar 2025 10:11:58 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZBwc83MBMz6D8bX;
 Tue, 11 Mar 2025 22:09:12 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 09E61140D26;
 Tue, 11 Mar 2025 22:11:45 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Mar 2025 15:11:37 +0100
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [RFC PATCH v2 00/20] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Date: Tue, 11 Mar 2025 14:10:25 +0000
Message-ID: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) AC_FROM_MANY_DOTS=2.499, BAYES_00=-1.9,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi All,

This patch series introduces initial support for a user-creatable
accelerated SMMUv3 device (-device arm-smmuv3-accel) in QEMU.

Why this is needed:

Currently, QEMU’s ARM SMMUv3 emulation (iommu=smmuv3) is tied to the
machine and does not support configuring the host SMMUv3 in nested
mode.This limitation prevents its use with vfio-pci passthrough
devices.

The new pluggable smmuv3-accel device enables host SMMUv3 configuration
with nested stage support (Stage 1 owned by the Guest and Stage 2 by the
host) via the new IOMMUFD APIs. Additionally, it allows multiple 
accelerated vSMMUv3 instances for guests running on hosts with multiple
physical SMMUv3s.

This will benefit in:
-Reduced invalidation broadcasts and lookups for devices behind multiple
 physical SMMUv3s.
-Simplifies handling of host SMMUv3s with differing feature sets.
-Lays the groundwork for additional capabilities like vCMDQ support.


Changes from RFCv1[0]:

Thanks to everyone who provided feedback on RFCv1!. 

–The device is now called arm-smmuv3-accel instead of arm-smmuv3-nested
 to better reflect its role in using the host's physical SMMUv3 for page
 table setup and cache invalidations.
-Includes patches for VIOMMU and VDEVICE IOMMUFD APIs (patches 1,2).
-Merges patches from Nicolin’s GitHub repository that add accelerated
 functionalityi for page table setup and cache invalidations[1]. I have
 modified these a bit, but hopefully has not broken anything.
-Incorporates various fixes and improvements based on RFCv1 feedback.
–Adds support for vfio-pci hotplug with smmuv3-accel.

Note: IORT RMR patches for MSI setup are currently excluded as we may
adopt a different approach for MSI handling in the future [2].

Also this has dependency on the common iommufd/vfio patches from
Zhenzhong's series here[3]

ToDos:

–At least one vfio-pci device must currently be cold-plugged to a
 pxb-pcie bus associated with the arm-smmuv3-accel. This is required both
 to associate a vSMMUv3 with a host SMMUv3 and also needed to
 retrieve the host SMMUv3 IDR registers for guest export.
 Future updates will remove this restriction by adding the
 necessary kernel support.
 Please find the discussion here[4]
-This version does not yet support host SMMUv3 fault handling or
 other event notifications. These will be addressed in a
 future patch series.


The complete branch can be found here:
https://github.com/hisilicon/qemu/tree/master-smmuv3-accel-rfcv2-ext

I have done basic sanity testing on a Hisilicon Platform using the kernel
branch here:
https://github.com/nicolinc/iommufd/tree/iommufd_msi-rfcv2

Usage Eg:

On a HiSilicon platform that has multiple host SMMUv3s, the ACC ZIP VF
devices and HNS VF devices are behind different host SMMUv3s. So for a
Guest, specify two arm-smmuv3-accel devices each behind a pxb-pcie as below,


./qemu-system-aarch64 -machine virt,accel=kvm,gic-version=3 \
-cpu host -smp cpus=4 -m size=4G,slots=4,maxmem=256G \
-bios QEMU_EFI.fd \
-object iommufd,id=iommufd0 \
-device virtio-blk-device,drive=fs \
-drive if=none,file=rootfs.qcow2,id=fs \
-device pxb-pcie,id=pcie.1,bus_nr=1,bus=pcie.0 \
-device arm-smmuv3-accel,bus=pcie.1 \
-device pcie-root-port,id=pcie.port1,bus=pcie.1,chassis=1,pref64-reserve=2M,io-reserve=1K \
-device vfio-pci,host=0000:7d:02.1,bus=pcie.port1,iommufd=iommufd0 \
-device pcie-root-port,id=pcie.port2,bus=pcie.1,chassis=2,pref64-reserve=2M,io-reserve=1K \
-device vfio-pci,host=0000:7d:02.2,bus=pcie.port2,iommufd=iommufd0 \
-device pxb-pcie,id=pcie.2,bus_nr=8,bus=pcie.0 \
-device arm-smmuv3-accel,bus=pcie.2 \
-device pcie-root-port,id=pcie.port3,bus=pcie.2,chassis=3,pref64-reserve=2M,io-reserve=1K \
-device vfio-pci,host=0000:75:00.1,bus=pcie.port3,iommufd=iommufd0 \
-kernel Image \
-append "rdinit=init console=ttyAMA0 root=/dev/vda2 rw earlycon=pl011,0x9000000" \
-device virtio-9p-pci,fsdev=p9fs,mount_tag=p9,bus=pcie.0 \
-fsdev local,id=p9fs,path=p9root,security_model=mapped \
-net none \
-nographic

Guest will boot with two SMMUv3s,
...
arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
arm-smmu-v3 arm-smmu-v3.0.auto: ias 44-bit, oas 44-bit (features 0x00008325)
arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries for cmdq
arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries for evtq
arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
arm-smmu-v3 arm-smmu-v3.1.auto: ias 44-bit, oas 44-bit (features 0x00008325)
arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries for cmdq
arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries for evtq

With a pci topology like below,

[root@localhost ~]# lspci -tv
-+-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
 |           +-01.0  Red Hat, Inc. QEMU PCIe Expander bridge
 |           +-02.0  Red Hat, Inc. QEMU PCIe Expander bridge
 |           \-03.0  Virtio: Virtio filesystem
 +-[0000:01]-+-00.0-[02]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
 |           \-01.0-[03]----00.0  Huawei Technologies Co., Ltd. HNS Network Controller (Virtual Function)
 \-[0000:08]---00.0-[09]----00.0  Huawei Technologies Co., Ltd. HiSilicon ZIP Engine(Virtual Function)

Further tests are always welcome.

Please take a look and let me know your feedback!

Thanks,
Shameer

[0] https://lore.kernel.org/qemu-devel/20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com/
[1] https://github.com/nicolinc/qemu/commit/3acbb7f3d114d6bb70f4895aa66a9ec28e6561d6
[2] https://lore.kernel.org/linux-iommu/cover.1740014950.git.nicolinc@nvidia.com/
[3] https://lore.kernel.org/qemu-devel/20250219082228.3303163-1-zhenzhong.duan@intel.com/
[4] https://lore.kernel.org/qemu-devel/Z6TLSdwgajmHVmGH@redhat.com/

Nicolin Chen (11):
  backends/iommufd: Introduce iommufd_backend_alloc_viommu
  backends/iommufd: Introduce iommufd_vdev_alloc
  hw/arm/smmuv3-accel: Add set/unset_iommu_device callback
  hw/arm/smmuv3-accel: Support nested STE install/uninstall support
  hw/arm/smmuv3-accel: Allocate a vDEVICE object for device
  hw/arm/smmuv3-accel: Return sysmem if stage-1 is bypassed
  hw/arm/smmuv3-accel: Introduce helpers to batch and issue cache
    invalidations
  hw/arm/smmuv3: Forward invalidation commands to hw
  hw/arm/smmuv3-accel: Read host SMMUv3 device info
  hw/arm/smmuv3: Check idr registers for STE_S1CDMAX and STE_S1STALLD
  hw/arm/smmu-common: Bypass emulated IOTLB for a accel SMMUv3

Shameer Kolothum (9):
  hw/arm/smmuv3-accel: Add initial infrastructure for smmuv3-accel
    device
  hw/arm/virt: Add support for smmuv3-accel
  hw/arm/smmuv3-accel: Associate a pxb-pcie bus
  hw/arm/smmu-common: Factor out common helper functions and export
  hw/arm/smmu-common: Introduce callbacks for PCIIOMMUOps
  hw/arm/smmuv3-accel: Provide get_address_space callback
  hw/arm/smmuv3: Install nested ste for CFGI_STE
  hw/arm/virt-acpi-build: Update IORT with multiple smmuv3-accel nodes
  hw/arm/smmuv3-accel: Enable smmuv3-accel creation

 backends/iommufd.c            |  51 +++
 backends/trace-events         |   2 +
 hw/arm/Kconfig                |   5 +
 hw/arm/meson.build            |   1 +
 hw/arm/smmu-common.c          |  95 +++++-
 hw/arm/smmuv3-accel.c         | 616 ++++++++++++++++++++++++++++++++++
 hw/arm/smmuv3-internal.h      |  54 +++
 hw/arm/smmuv3.c               |  80 ++++-
 hw/arm/trace-events           |   6 +
 hw/arm/virt-acpi-build.c      | 113 ++++++-
 hw/arm/virt.c                 |  12 +
 hw/core/sysbus-fdt.c          |   1 +
 include/hw/arm/smmu-common.h  |  14 +
 include/hw/arm/smmuv3-accel.h |  75 +++++
 include/hw/arm/virt.h         |   1 +
 include/system/iommufd.h      |  14 +
 16 files changed, 1101 insertions(+), 39 deletions(-)
 create mode 100644 hw/arm/smmuv3-accel.c
 create mode 100644 include/hw/arm/smmuv3-accel.h

-- 
2.34.1


