Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmUK-00067K-P5; Fri, 19 Jul 2024 08:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmU8-0005I5-Sr
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:13:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUmTz-0008WE-QH
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:13:12 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JC51l2023753;
 Fri, 19 Jul 2024 12:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=corp-2023-11-20; bh=eaC5c7O7TC6W6f
 WV3OlR1Q2xruLkGUwgyeGXvM6MvsM=; b=ZTHPCWqGcv22QwK+/bnTGnYCI1cRS0
 hqTY2qbuLpPaVedKD0wGRxzqhVP6Hmmfk9Zt4KbkJZnjnaSGPJzr6M7ETM3Pb9FN
 p3TX8D6i5fH3g+ij3oPOhkd32a4FPTORyfygITUQBnIvGjVuC+09wmCaijFReele
 jfMyHjjvPDcAThjYH+dcAuVjBWLP8R94XYs4y7E1shGg2VvdV7bCRfKPoTWhhWfJ
 ab/p3kF+P9VI3XY5uyPD96bs6q09k7plYEc+Gf3EyoVb+Sngzx+n77FgbiqdZ3ac
 VNmlvGvAno2frppBZPIcCdf/rMkK9VMEPGS/+JOutRO6u92+so9pyFrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fqub80tu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:13:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46JBmho6038864; Fri, 19 Jul 2024 12:05:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexk36g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jul 2024 12:05:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46JC5DMB011010;
 Fri, 19 Jul 2024 12:05:13 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-12-11.vpn.oracle.com
 [10.175.12.11])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 40dwexk34j-1; Fri, 19 Jul 2024 12:05:13 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v5 00/13] hw/iommufd: IOMMUFD Dirty Tracking
Date: Fri, 19 Jul 2024 13:04:48 +0100
Message-Id: <20240719120501.81279-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407190093
X-Proofpoint-ORIG-GUID: 5TC7pmWYm4-iX7SIKOeX69ztFerZth9L
X-Proofpoint-GUID: 5TC7pmWYm4-iX7SIKOeX69ztFerZth9L
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This small series adds support for IOMMU dirty tracking support via the
IOMMUFD backend. The hardware capability is available on most recent x86
hardware. The series is divided organized as follows:

* Patch 1-2: Fixes a regression into mdev support with IOMMUFD. This
             one is independent of the series but happened to cross it
             while testing mdev with this series

* Patch 3: Adds a support to iommufd_get_device_info() for capabilities

* Patches 4 - 11: IOMMUFD backend support for dirty tracking;

Introduce auto domains -- Patch 5 goes into more detail, but the gist is that
we will find and attach a device to a compatible IOMMU domain, or allocate a new
hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
workflow is relatively simple:

1) Probe device and allow dirty tracking in the HWPT
2) Toggling dirty tracking on/off
3) Read-and-clear of Dirty IOVAs

The heuristics selected for (1) were to always request the HWPT for
dirty tracking if supported, or rely on device dirty page tracking. This
is a little simplistic and we aren't necessarily utilizing IOMMU dirty
tracking even if we ask during hwpt allocation.

The unmap case is deferred until further vIOMMU support with migration
is added[3] which will then introduce the usage of
IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
dma unmap bitmap flow.

* Patches 12-13: Don't block live migration where there's no VF dirty
tracker, considering that we have IOMMU dirty tracking.

Comments and feedback appreciated. Thanks for the review so far and
apologies in advance if I missed any comment.

Cheers,
    Joao

P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
some bugs fixed there with regards to IOMMU hugepage dirty tracking.

Changes since v4[6]:
* Add various Reviewed-by in patches 2,3,4,6,8,11
* Change error messages to mention IOMMU (Zhenzhong)
* Better improve the checking of dirty page tracking in
  vfio_migration_realize() to detect per-device IOMMU instead of using
  container dirty_page_supported().
* Improve/Cleanup various commit messages to be clear (Eric)
* Extract the caps::hw_caps into its own patch as it was miosleading to
be hidden in another patch (new patch 7)
* Restructure patch 1 helper to be vfio_device_is_mdev() and use
vfio::mdev directly in rest of patches (Cedric)
* Improve error messages of set,query dirty tracking (Cedric)
* Add missing casts to uintptr and uint64_t* (Cedric)
* Improve terciary check in set_dirty_Tracking (Cedric)
* Add missing commens to struct doc from aw_bits removal (and hw_caps
addition) (Eric)
* Fix the detach flow in auto domains (Eric)
* Add new helper vfio_device_hiod_realize() and use it in backends
* (Cedric)
* Move introduction of iommufd_hwpt_dirty_tracking() in the predecessor
* patch (Cedric)
* Set hwpt to NULL on detach (Eric)
* Spurious line (Eric)

Changes since v3[5]:
* Skip HostIOMMUDevice::realize for mdev, and introduce a helper to check if the VFIO
  device is mdev. (Zhenzhong)
* Skip setting IOMMU device for mdev (Zhenzhong)
* Add Zhenzhong review tag in patch 3
* Utilize vbasedev::bcontainer::dirty_pages_supported instead of introducing
  a new HostIOMMUDevice capability and thus remove the cap patch from the series (Zhenzhong)
* Move the HostIOMMUDevice::realize() to be part of VFIODevice initialization in attach_device()
while skipping it all together for mdev. (Cedric)
* Due to the previous item, had to remove aw_bits because it depends on device attach being
finished, instead defer it to when get_cap() gets called.
* Skip auto domains for mdev instead of purposedly erroring out (Zhenzhong)
* Pass errp in all cases, and instead just free the error in case of -EINVAL
  in most of all patches, and also pass Error* in iommufd_backend_alloc_hwpt() amd
  set/query dirty. This is made better thanks in part to skipping auto domains for mdev (Cedric)

Changes since RFCv2[4]:
* Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING even if
we end up not actually toggling dirty tracking. (Avihai)
* Fix error handling widely in auto domains logic and all patches (Avihai)
* Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
* New patches 1 and 2 taking into consideration previous comments.
* Store hwpt::flags to know if we have dirty tracking (Avihai)
* New patch 8, that allows to query dirty tracking support after
provisioning. This is a cleaner way to check IOMMU dirty tracking support
when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
device caps way is still used because at vfio attach we aren't yet with
a fully initialized migration state.
* Adopt error propagation in query,set dirty tracking
* Misc improvements overall broadly and Avihai
* Drop hugepages as it's a bit unrelated; I can pursue that patch
* separately. The main motivation is to provide a way to test
without hugepages similar to what vfio_type1_iommu.disable_hugepages=1
does.

Changes since RFCv1[2]:
* Remove intel/amd dirty tracking emulation enabling
* Remove the dirtyrate improvement for VF/IOMMU dirty tracking
[Will pursue these two in separate series]
* Introduce auto domains support
* Enforce dirty tracking following the IOMMUFD UAPI for this
* Add support for toggling hugepages in IOMMUFD
* Auto enable support when VF supports migration to use IOMMU
when it doesn't have VF dirty tracking
* Add a parameter to toggle VF dirty tracking

[0] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
[1] https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
[2] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
[3] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
[4] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
[5] https://lore.kernel.org/qemu-devel/20240708143420.16953-1-joao.m.martins@oracle.com/
[6] https://lore.kernel.org/qemu-devel/20240712114704.8708-1-joao.m.martins@oracle.com/#t

Joao Martins (13):
  vfio/pci: Extract mdev check into an helper
  vfio/iommufd: Don't initialize nor set a HOST_IOMMU_DEVICE with mdev
  backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW
    capabilities
  vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
  vfio/iommufd: Introduce auto domain creation
  vfio/{iommufd,container}: Remove caps::aw_bits
  vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
  vfio/{iommufd,container}: Invoke HostIOMMUDevice::realize() during
    attach_device()
  vfio/iommufd: Probe and request hwpt dirty tracking capability
  vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
  vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
  vfio/migration: Don't block migration device dirty tracking is
    unsupported
  vfio/common: Allow disabling device dirty page tracking

 include/hw/vfio/vfio-common.h      |  15 +++
 include/sysemu/host_iommu_device.h |   5 +-
 include/sysemu/iommufd.h           |  13 ++-
 backends/iommufd.c                 |  89 +++++++++++++-
 hw/vfio/common.c                   |  17 +--
 hw/vfio/container.c                |   9 +-
 hw/vfio/helpers.c                  |  25 ++++
 hw/vfio/iommufd.c                  | 181 ++++++++++++++++++++++++++++-
 hw/vfio/migration.c                |  12 +-
 hw/vfio/pci.c                      |  26 +++--
 backends/trace-events              |   3 +
 11 files changed, 356 insertions(+), 39 deletions(-)

-- 
2.17.2


