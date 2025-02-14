Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826D2C021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwSm-0004Jv-CQ; Fri, 14 Feb 2025 09:14:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSj-0004H1-Ud
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:37 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwSh-0004QP-Ph
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:14:37 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECubt4024014;
 Fri, 14 Feb 2025 14:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=nlFZDgfz1Ovvj17z
 bdQEjdxQNsuG2gJ/VKGnqF5kL8g=; b=XKgOSdhOw9eiHPBc1dMA4GOdRDo5tNUf
 ejW6N/KULhWEm535ltMZbpF3U76GosN/5zORxcxlsFp3zYn77Vlco34dqzEUqkz5
 6T8I8zfx5bgx6UTiMg9DTbNjt4uzLRIqcYkYXykXCDyxTYb6nyZLTNERj6Q4Xz0T
 C64Ntppo4F/6rUHmynUYyPKR39lZl+jd9m3Ioyb+7rYwF551CZMwUnmLNduU1TrK
 l7dosd3E/Za/9cMTs4vJeKC940tS4eEP2pwME1tLjcB4pns3b0fk+hzUpgOcxhGD
 mTYEszs/836KL5OtbXLR5Kne8y87g9h0io76ptKhbulEa4CTjbIxzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s43q6b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECog16025151; Fri, 14 Feb 2025 14:14:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksg2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:14:29 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETPD006920;
 Fri, 14 Feb 2025 14:14:29 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-1; Fri, 14 Feb 2025 14:14:29 +0000
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
Subject: [PATCH V2 00/45] Live update: vfio and iommufd
Date: Fri, 14 Feb 2025 06:13:42 -0800
Message-Id: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: FxKGs4_7naIzLIgz3b6WpPlmX4IgxGAh
X-Proofpoint-ORIG-GUID: FxKGs4_7naIzLIgz3b6WpPlmX4IgxGAh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Patches 5 to 14 are specific to legacy containers.
Patches 27 to 44 are specific to iommufd containers.
The remainder apply to both.

Changes from previous versions:
  * V1 of this series contains minor changes from the "Live update: vfio" and
    "Live update: iommufd" series, mainly bug fixes and refactored patches.

Changes in V2:
  * refactored various vfio code snippets into new cpr helpers
  * refactored vfio struct members into cpr-specific structures
  * refactored various small changes into their own patches
  * split complex patches.  Notably:
    - split "refactor for cpr" into 5 patches
    - split "reconstruct device" into 4 patches
  * refactored vfio_connect_container using helpers and made its
    error recovery more robust.
  * moved vfio pci msi/vector/intx cpr functions to cpr.c
  * renamed "reused" to cpr_reused and cpr.reused
  * squashed vfio_cpr_[un]register_container to their call sites
  * simplified iommu_type setting after cpr
  * added cpr_open_fd and cpr_is_incoming helpers
  * removed changes from vfio_legacy_dma_map, and instead temporarily
    override dma_map and dma_unmap ops.
  * deleted error_report and returned Error to callers where possible.
  * simplified the memory_get_xlat_addr interface
  * fixed flags passed to iommufd_backend_alloc_hwpt
  * defined MIG_PRI_UNINITIALIZED
  * added maintainers

Steve Sistare (45):
  MAINTAINERS: Add reviewer for CPR
  migration: cpr helpers
  migration: lower handler priority
  vfio: vfio_find_ram_discard_listener
  vfio/container: ram discard disable helper
  vfio/container: reform vfio_connect_container cleanup
  vfio/container: vfio_container_group_add
  vfio/container: register container for cpr
  vfio/container: preserve descriptors
  vfio/container: export vfio_legacy_dma_map
  vfio/container: discard old DMA vaddr
  vfio/container: restore DMA vaddr
  vfio/container: mdev cpr blocker
  vfio/container: recover from unmap-all-vaddr failure
  pci: export msix_is_pending
  pci: skip reset during cpr
  vfio-pci: skip reset during cpr
  vfio/pci: vfio_vector_init
  vfio/pci: vfio_notifier_init
  vfio/pci: pass vector to virq functions
  vfio/pci: vfio_notifier_init cpr parameters
  vfio/pci: vfio_notifier_cleanup
  vfio/pci: export MSI functions
  vfio-pci: preserve MSI
  vfio-pci: preserve INTx
  migration: close kvm after cpr
  migration: cpr_get_fd_param helper
  vfio: return mr from vfio_get_xlat_addr
  vfio: pass ramblock to vfio_container_dma_map
  backends/iommufd: iommufd_backend_map_file_dma
  backends/iommufd: change process ioctl
  physmem: qemu_ram_get_fd_offset
  vfio/iommufd: use IOMMU_IOAS_MAP_FILE
  vfio/iommufd: export iommufd_cdev_get_info_iova_range
  vfio/iommufd: define hwpt constructors
  vfio/iommufd: invariant device name
  vfio/iommufd: fix cpr register
  vfio/iommufd: register container for cpr
  vfio/iommufd: preserve descriptors
  vfio/iommufd: reconstruct device
  vfio/iommufd: reconstruct hw_caps
  vfio/iommufd: reconstruct hwpt
  vfio/iommufd: change process
  iommufd: preserve DMA mappings
  vfio/container: delete old cpr register

 MAINTAINERS                           |  12 ++
 accel/kvm/kvm-all.c                   |  28 ++++
 backends/iommufd.c                    |  83 ++++++++--
 backends/trace-events                 |   2 +
 hw/pci/msix.c                         |   2 +-
 hw/pci/pci.c                          |  13 ++
 hw/vfio/common.c                      |  91 ++++++++---
 hw/vfio/container-base.c              |  12 +-
 hw/vfio/container.c                   | 216 +++++++++++++++++---------
 hw/vfio/cpr-iommufd.c                 | 172 +++++++++++++++++++++
 hw/vfio/cpr-legacy.c                  | 277 ++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                         | 176 +++++++++++++++++++--
 hw/vfio/helpers.c                     |  20 +--
 hw/vfio/iommufd.c                     | 139 +++++++++++++----
 hw/vfio/meson.build                   |   4 +-
 hw/vfio/pci.c                         | 194 ++++++++++++++++++------
 hw/vfio/pci.h                         |  12 ++
 hw/vfio/trace-events                  |   1 +
 hw/virtio/vhost-vdpa.c                |   8 +-
 include/exec/cpu-common.h             |   1 +
 include/exec/memory.h                 |   6 +-
 include/hw/pci/msix.h                 |   1 +
 include/hw/vfio/vfio-common.h         |  20 ++-
 include/hw/vfio/vfio-container-base.h |   6 +-
 include/hw/vfio/vfio-cpr.h            |  69 +++++++++
 include/migration/cpr.h               |  10 ++
 include/migration/vmstate.h           |   6 +-
 include/system/iommufd.h              |   6 +
 include/system/kvm.h                  |   1 +
 migration/cpr-transfer.c              |  18 +++
 migration/cpr.c                       |  92 +++++++++++
 migration/migration.c                 |   1 +
 migration/savevm.c                    |   4 +-
 system/memory.c                       |  19 +--
 system/physmem.c                      |   5 +
 35 files changed, 1490 insertions(+), 237 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c
 create mode 100644 hw/vfio/cpr-legacy.c
 create mode 100644 include/hw/vfio/vfio-cpr.h

base-commit: de278e54aefed143526174335f8286f7437d20be

-- 
1.8.3.1


