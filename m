Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250D9C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 11:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSEkF-0005M4-F1; Fri, 12 Jul 2024 07:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkD-0005LB-4i
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sSEkA-0007bm-Ga
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 07:47:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46CAWYBn003651;
 Fri, 12 Jul 2024 11:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=corp-2023-11-20; bh=RTKdAXV9HtWVdw
 POqIxTTzfO0jvhX6Aqs+QNLA6grKc=; b=cLSZInuVCG8ZzQRaL5sUYvOMZ578M/
 F3KXcHbofmUax8yyr3r47SV6qa589QagadVTcuNqj+3XQC/a/HdtodyxD/Dk5yI1
 DhfmLDG8pwIv/VmXLMCfWa1kP25MDkYtm9md/PngoubNRMo3/HB/lT6aUVXtlW6q
 IKKdpZB7s9Zkz5UDZ0ZekooYi3nDwzxfn/I8bgc64sf7H8zZtzVih51FhKxSGDFv
 d7au4YVIsBJnS/r6qvOegCvff9nx39IQ4IMhHDP4CZO3yt/FWyTJL9dZQ08Ikrym
 7PJ889dxduMU1QM0pglhfb2dCfPhlKyKQBQwkgPOkMvkez1GGOOGn/PA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsut6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46CB9sch022104; Fri, 12 Jul 2024 11:47:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv3ppyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jul 2024 11:47:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46CBlCCS008041;
 Fri, 12 Jul 2024 11:47:12 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-0-59.vpn.oracle.com
 [10.175.0.59])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 409vv3ppxv-1; Fri, 12 Jul 2024 11:47:12 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
Date: Fri, 12 Jul 2024 12:46:52 +0100
Message-Id: <20240712114704.8708-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407120080
X-Proofpoint-ORIG-GUID: uqBYEiYif_ZggWmQbp8th86L8q8i0XDn
X-Proofpoint-GUID: uqBYEiYif_ZggWmQbp8th86L8q8i0XDn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This small series adds support for IOMMU dirty tracking support via the
IOMMUFD backend. The hardware capability is available on most recent x86
hardware. The series is divided organized as follows:

* Patch 1-2: Fixes a regression into mdev support with IOMMUFD. This
             one is independent of the series but happened to cross it
             while testing mdev with this series

* Patch 3: Adds a support to iommufd_get_device_info() for capabilities

* Patches 4 - 10: IOMMUFD backend support for dirty tracking;

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

* Patches 11-12: Don't block live migration where there's no VF dirty
tracker, considering that we have IOMMU dirty tracking.

Comments and feedback appreciated. Thanks for all the review thus far!

Cheers,
    Joao

P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
some bugs fixed there with regards to IOMMU hugepage dirty tracking.

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

Joao Martins (12):
  vfio/pci: Extract mdev check into an helper
  vfio/iommufd: Don't initialize nor set a HOST_IOMMU_DEVICE with mdev
  backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW
    capabilities
  vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
  vfio/iommufd: Introduce auto domain creation
  vfio/{iommufd,container}: Remove caps::aw_bits
  vfio/{iommufd,container}: Initialize HostIOMMUDeviceCaps during
    attach_device()
  vfio/iommufd: Probe and request hwpt dirty tracking capability
  vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
  vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
  vfio/migration: Don't block migration device dirty tracking is
    unsupported
  vfio/common: Allow disabling device dirty page tracking

 include/hw/vfio/vfio-common.h      |  13 +++
 include/sysemu/host_iommu_device.h |   2 +-
 include/sysemu/iommufd.h           |  14 ++-
 backends/iommufd.c                 |  89 ++++++++++++++-
 hw/vfio/common.c                   |  17 +--
 hw/vfio/container.c                |  11 +-
 hw/vfio/helpers.c                  |  18 +++
 hw/vfio/iommufd.c                  | 178 ++++++++++++++++++++++++++++-
 hw/vfio/migration.c                |   4 +-
 hw/vfio/pci.c                      |  22 ++--
 backends/trace-events              |   3 +
 11 files changed, 339 insertions(+), 32 deletions(-)

-- 
2.17.2


