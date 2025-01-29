Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B61C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 14:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td9IG-0000VU-De; Wed, 29 Jan 2025 09:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9ID-0000Ul-TP
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1td9IB-0001KA-0U
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 09:43:49 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEXoCF031305;
 Wed, 29 Jan 2025 14:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2023-11-20; bh=EjLGAx2B
 FvnCfffJ89gWXqCQ78YvsXXfKrAwxdK1xgI=; b=Tl5Rr5/BojzBqlZAHNN74LJM
 MsWbAIfwLc4Ege0gOZ+zjMA76DAEwoa6UIIwawv3q/q1ANHA5KrB5CX2a8fluulW
 9frx6dPUeFlrtP1XIbcY/ZvEss4hPrzovqrwWH+URANJsg2es9364eHDL7T0cTt/
 3kFWowGjGwMaMmukNyz5++zq+7CNZncc1ogd0UHicHSVrenkXLWgg0mFOq+rtFo8
 dFmFUY7f15A6i4QgviAZKFvhw6iaEQ3q8qMdhnNJAbApsFshnPZ5+/7ZTRn7qim8
 PGHMWcg75PFefC9gP2lUTi+oSE3SpXtpgzXjFjVMFNCmHQZOjDQFrkWM1bCSJA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fp1a81dg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50TEa4L5034436; Wed, 29 Jan 2025 14:43:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44cpd9s4nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jan 2025 14:43:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 50TEhf8E003307;
 Wed, 29 Jan 2025 14:43:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 44cpd9s49q-1; Wed, 29 Jan 2025 14:43:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 00/26] Live update: vfio and iommufd
Date: Wed, 29 Jan 2025 06:42:56 -0800
Message-Id: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290119
X-Proofpoint-GUID: 36szkNa7lWdkt4uW0bNObhmopLpcSw0r
X-Proofpoint-ORIG-GUID: 36szkNa7lWdkt4uW0bNObhmopLpcSw0r
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Support vfio and iommufd devices with the cpr-transfer live migration mode.
Devices that do not support live migration can still support cpr-transfer,
allowing live update to a new version of QEMU on the same host, with no loss
of guest connectivity.

No user-visible interfaces are added.

For legacy containers:

Pass vfio device descriptors to new QEMU.  In new QEMU, during vfio_realize,
skip the ioctls that configure the device, because it is already configured.

Use VFIO_DMA_UNMAP_FLAG_VADDR to abandon the old VA's for DMA mapped
regions, and use VFIO_DMA_MAP_FLAG_VADDR to register the new VA in new
QEMU and update the locked memory accounting.  The physical pages remain
pinned, because the descriptor of the device that locked them remains open,
so DMA to those pages continues without interruption.  Mediated devices are
not supported, however, because they require the VA to always be valid, and
there is a brief window where no VA is registered.

Save the MSI message area as part of vfio-pci vmstate, and pass the interrupt
and notifier eventfd's to new QEMU.  New QEMU loads the MSI data, then the
vfio-pci post_load handler finds the eventfds in CPR state, rebuilds vector
data structures, and attaches the interrupts to the new KVM instance.  This
logic also applies to iommufd containers.

For iommufd containers:

Use IOMMU_IOAS_MAP_FILE to register memory regions for DMA when they are
backed by a file (including a memfd), so DMA mappings do not depend on VA,
which can differ after live update.  This allows mediated devices to be
supported.

Pass the iommufd and vfio device descriptors from old to new QEMU.  In new
QEMU, during vfio_realize, skip the ioctls that configure the device, because
it is already configured.

In new QEMU, call ioctl(IOMMU_IOAS_CHANGE_PROCESS) to update mm ownership and
locked memory accounting.

Patches 3 to 7 are specific to legacy containers.
Patches 15 to 26 are specific to iommufd containers.
Patches 1, 2 and 8 to 14 apply to both.

Changes from previous versions:
  * This series contains minor changes from the "Live update: vfio" and
    "Live update: iommufd" series, mainly bug fixes and refactored patches.

Steve Sistare (26):
  migration: cpr helpers
  migration: lower handler priority
  vfio: vfio_find_ram_discard_listener
  vfio/container: register container for cpr
  vfio/container: preserve descriptors
  vfio/container: preserve DMA mappings
  vfio/container: recover from unmap-all-vaddr failure
  pci: skip reset during cpr
  pci: export msix_is_pending
  vfio-pci: refactor for cpr
  vfio-pci: skip reset during cpr
  vfio-pci: preserve MSI
  vfio-pci: preserve INTx
  migration: close kvm after cpr
  migration: cpr_get_fd_param helper
  vfio: return mr from vfio_get_xlat_addr
  vfio: pass ramblock to vfio_container_dma_map
  vfio/iommufd: define iommufd_cdev_make_hwpt
  vfio/iommufd: use IOMMU_IOAS_MAP_FILE
  vfio/iommufd: export iommufd_cdev_get_info_iova_range
  iommufd: change process ioctl
  vfio/iommufd: invariant device name
  vfio/iommufd: register container for cpr
  vfio/iommufd: preserve descriptors
  vfio/iommufd: reconstruct device
  iommufd: preserve DMA mappings

 accel/kvm/kvm-all.c                   |  20 +++
 backends/iommufd.c                    |  88 +++++++++-
 backends/trace-events                 |   2 +
 hw/pci/msix.c                         |   2 +-
 hw/pci/pci.c                          |  13 ++
 hw/vfio/common.c                      | 108 +++++++++---
 hw/vfio/container-base.c              |  12 +-
 hw/vfio/container.c                   | 155 ++++++++++++++---
 hw/vfio/cpr-iommufd.c                 | 161 ++++++++++++++++++
 hw/vfio/cpr-legacy.c                  | 161 ++++++++++++++++++
 hw/vfio/helpers.c                     |  28 ++--
 hw/vfio/iommufd.c                     | 156 ++++++++++++-----
 hw/vfio/meson.build                   |   4 +-
 hw/vfio/pci.c                         | 307 +++++++++++++++++++++++++++++-----
 hw/vfio/trace-events                  |   1 +
 hw/virtio/vhost-vdpa.c                |   2 +-
 include/exec/cpu-common.h             |   1 +
 include/exec/memory.h                 |   5 +-
 include/hw/pci/msix.h                 |   1 +
 include/hw/vfio/vfio-common.h         |  25 +++
 include/hw/vfio/vfio-container-base.h |   6 +-
 include/migration/cpr.h               |   7 +
 include/migration/vmstate.h           |   3 +-
 include/system/iommufd.h              |   6 +
 include/system/kvm.h                  |   1 +
 migration/cpr-transfer.c              |  18 ++
 migration/cpr.c                       |  70 ++++++++
 migration/migration.c                 |   1 +
 migration/savevm.c                    |   4 +-
 system/memory.c                       |   8 +-
 system/physmem.c                      |   5 +
 31 files changed, 1230 insertions(+), 151 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c
 create mode 100644 hw/vfio/cpr-legacy.c

-- 
1.8.3.1


