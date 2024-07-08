Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536D5C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpRz-0003uR-3i; Mon, 08 Jul 2024 10:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpRx-0003ky-B8
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sQpRv-0002S5-FL
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:34:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fTWl017381;
 Mon, 8 Jul 2024 14:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=corp-2023-11-20; bh=q6Ez0xZHxRg1FF
 /hZauua3wWcqIUu0LYTtJOMldDReI=; b=jPbf+XOocBScXsNibQbXuBVoy2/mgL
 DqW/xOkjpKYPfDv7B7PNCPrl7byFdUCzZoGwOxkOzHcG5z+C0taObpEctW/EGQm7
 a32n5lEBd4R2IeA2orjZOxAT9kt+6Sl+dF2R99awGJOxiiR5CiUrLo8vtFG3lc1k
 wWWEUNF3uBolT0fLJf3vrqPp370wSeexqI081Wqxrt+jGJyQJJSgoifKOOZxQLH8
 7jIcgqgDS/cLKsfvgEYZ+mxUpLWW96/k4MeiI8OqutPvSSqN/sCCFpaLxtO5QNxd
 W3aJyE3Z/zFfX0ItM1f+XkxiGAirL+Q0QauRzNs1GB2YPGyrr6vBlqCQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknjsqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 468DSiKG007181; Mon, 8 Jul 2024 14:34:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tu1r6p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 08 Jul 2024 14:34:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 468EXkZ3037381;
 Mon, 8 Jul 2024 14:34:27 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-56-128.vpn.oracle.com
 [10.175.56.128])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 407tu1r6ms-1; Mon, 08 Jul 2024 14:34:26 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking 
Date: Mon,  8 Jul 2024 15:34:10 +0100
Message-Id: <20240708143420.16953-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080109
X-Proofpoint-GUID: w7N-0cgkbBfVgli3vK_4yhhFCRVWiP3-
X-Proofpoint-ORIG-GUID: w7N-0cgkbBfVgli3vK_4yhhFCRVWiP3-
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

* Patch 1: Fixes a regression into mdev support with IOMMUFD. This
           one is independent of the series but happened to cross it
           while testing mdev with this series

* Patch 2: Adds a support to iommufd_get_device_info() for capabilities

* Patches 3 - 7: IOMMUFD backend support for dirty tracking;

Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
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

* Patches 8-10: Don't block live migration where there's no VF dirty
tracker, considering that we have IOMMU dirty tracking.

Comments and feedback appreciated.

Cheers,
    Joao

P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
some bugs fixed there with regards to IOMMU hugepage dirty tracking.

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

Joao Martins (10):
  vfio/iommufd: don't fail to realize on IOMMU_GET_HW_INFO failure
  backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW capabilities
  vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
  vfio/iommufd: Introduce auto domain creation
  vfio/iommufd: Probe and request hwpt dirty tracking capability
  vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
  vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
  vfio/iommufd: Parse hw_caps and store dirty tracking support
  vfio/migration: Don't block migration device dirty tracking is unsupported
  vfio/common: Allow disabling device dirty page tracking

 include/hw/vfio/vfio-common.h      |  11 ++
 include/sysemu/host_iommu_device.h |   2 +
 include/sysemu/iommufd.h           |  12 +-
 backends/iommufd.c                 |  81 ++++++++++-
 hw/vfio/common.c                   |   3 +
 hw/vfio/iommufd.c                  | 217 +++++++++++++++++++++++++++--
 hw/vfio/migration.c                |   7 +-
 hw/vfio/pci.c                      |   3 +
 backends/trace-events              |   3 +
 9 files changed, 325 insertions(+), 14 deletions(-)

-- 
2.17.2


