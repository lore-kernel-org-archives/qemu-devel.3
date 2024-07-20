Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5172CC3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVFZG-0007Xz-7b; Sat, 20 Jul 2024 15:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYv-0006pw-O3
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVFYj-0000pH-2N
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:16:03 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJA1iM020362;
 Sat, 20 Jul 2024 19:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=a5KHxr
 QvTRZeUAeYqk6vluuD5Tcqe1WWbOuFrqOSbN8=; b=BVc5EPJqIhTPLBiBLHZUVk
 ONyw4FMk341jit1+poPoL6DZqjcxn+icrIGkf01c5ysEYLWp/hcLqEBE8xsk/6YP
 TOyKFeOE0o1+r2AUz4NJwhAIjaK/Ua9Dod9cm6SNl+hXFgoSE8fq2zUZGIWeJmqn
 M3OdvdrP8pH+jZVZF5XeE4Q8QadS6rNmpN1hpkjDkd5cIFydV9W8cf1jO4Mjbknu
 Vm5+wBDEx7E8fcs3iBfMaZBojEuSl8pIvGKToeDazE+lzS3O0A9lyxdDX/PMxH5S
 UMUpR1dHvRLlMbYnvUnMB0vf8a/1GbSrhdx1wOKYjNE3sRLvmo6340l2pyeyUw+w
 ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gk5gr051-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:40 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KI0BUG027428; Sat, 20 Jul 2024 19:15:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5put4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:15:39 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KJFdf1028365;
 Sat, 20 Jul 2024 19:15:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 40g3p5pusv-1; Sat, 20 Jul 2024 19:15:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 00/12] Live update: iommufd
Date: Sat, 20 Jul 2024 12:15:25 -0700
Message-Id: <1721502937-87102-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200140
X-Proofpoint-GUID: FwVexKhvD5Nm6n6cMgLPCf6qp-SPfnJz
X-Proofpoint-ORIG-GUID: FwVexKhvD5Nm6n6cMgLPCf6qp-SPfnJz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Support iommufd devices with the cpr-exec live migration mode.
No user-visible interfaces are added.

Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
QEMU, during vfio_realize, skip the ioctls that configure the device, because
it is already configured.

In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update the mm ownership,
locked memory accounting, and virtual address of all DMA mappings.  The old
virtual address of each memory region is needed to identify the existing
mapping, so pass the host address of each RAMBlock in the migration data
stream.

Block CPR if the iommufd container has any vfio mdevs (mediated devices).
IOMMU_IOAS_CHANGE_PROCESS can be used as-is to support mdevs, but it requires
extra work in userland at CPR time so that kernel threads have access to the
old mappings until the mappings are updated in new QEMU.  I have prototyped
those changes but they need more work before posting.

This series depends on the following qemu series
  [PATCH V1 00/08] Live update: vfio
  https://lore.kernel.org/qemu-devel/1720558737-451106-1-git-send-email-steven.sistare@oracle.com/

This series depends on the IOMMU_IOAS_CHANGE_PROCESS kernel interface which
is a work in progress:
  iommufd live update
  https://lore.kernel.org/linux-iommu/1721501805-86928-1-git-send-email-steven.sistare@oracle.com

Steve Sistare (12):
  vfio: move cpr_exec_notifier
  iommufd: no DMA to BARs
  iommufd: pass name to connect
  migration: cpr_find_fd_any
  iommufd: preserve device fd
  iommufd: export iommufd_cdev_get_info_iova_range
  iommufd: change_process kernel interface
  vfio/iommufd: register container for cpr
  vfio/iommufd: rebuild device
  migration/ram: old host address
  iommufd: update DMA virtual addresses
  vfio: mdev blocker

 backends/iommufd.c                    | 113 ++++++++++++++++++++++++++++++++--
 hw/core/machine.c                     |   6 ++
 hw/vfio/common.c                      |   3 +-
 hw/vfio/cpr-iommufd.c                 |  84 +++++++++++++++++++++++++
 hw/vfio/cpr-legacy.c                  |  10 +--
 hw/vfio/helpers.c                     |   1 +
 hw/vfio/iommufd.c                     |  43 ++++++++++---
 hw/vfio/meson.build                   |   1 +
 hw/vfio/pci.c                         |  10 +++
 include/exec/memory.h                 |   1 +
 include/exec/ramblock.h               |   1 +
 include/hw/vfio/vfio-common.h         |   7 ++-
 include/hw/vfio/vfio-container-base.h |   3 +
 include/migration/cpr.h               |   1 +
 include/sysemu/iommufd.h              |   7 ++-
 linux-headers/linux/iommufd.h         |  19 ++++++
 migration/cpr.c                       |  15 +++++
 migration/migration.h                 |   2 +
 migration/options.c                   |   2 +
 migration/ram.c                       |   7 +++
 20 files changed, 316 insertions(+), 20 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c

-- 
1.8.3.1


