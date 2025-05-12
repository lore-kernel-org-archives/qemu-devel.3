Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6D9C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV9P-0003l9-02; Mon, 12 May 2025 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9M-0003hZ-Ax
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9I-0006dy-E7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:04 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fdD017603;
 Mon, 12 May 2025 15:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=KAo6+V/ro+LlNBlu
 9YmAdYizZRFJRXJ9XdtwLUQoGa8=; b=ppsfmr5SykurAGxHCsWHtIky4hBEzxk9
 8wTQn36msm84QiazlVj1DV7O15kLjggXEj9RttHx0qCBY22OJGNcaY5N+r0GYtuC
 bpn1UgtvvMMDi+oAGihHkZeRowEr0jjco8905qiTlgy40KSWzGp/KUuBxXocjy97
 Ue33hFkuj3czS5+d4EuMsSC4CF6o1Q/rwpWW7I4oaJC7QmSJB5W6Z4DPLH1gSGCg
 aN/qY1K/qf/nAi7SoV6ZMG0op+CoD59f5bt2aOkavkSiJjJomm2GZ4qE2bu5+Cp1
 d8CYtHownZcIVhZNHKfdvaQB8WbDSFhZ8GrYcPsk526q9e9xjZzbTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tveg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CEEdwc002446; Mon, 12 May 2025 15:32:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx3662u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:32:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk4c030605;
 Mon, 12 May 2025 15:32:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-1; Mon, 12 May 2025 15:32:54 +0000
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
Subject: [PATCH V3 00/42] Live update: vfio and iommufd
Date: Mon, 12 May 2025 08:32:11 -0700
Message-Id: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX3ESDL/kFZG58
 6LLnwN7RJU/Alf8v74IY/dfTlAf13wMQUDYdHHW9HpKgqEPJKh083xExSc0FCvX6ZGEFwFvqlDX
 yOjZp2XnguAL064F4OQviaslWkqet4m1YAcWFEsQJIqtYhurl3P5scCYSsUTcJJYnLpLj+j9r/f
 +Lo+0ZAB0bDB3RcPr4jydXazFN2WxLsr1xbg8iJybHnvdX7IMTWnAVZFcX1AHOUyrEJW+hsQJCN
 o8TlBfuNkI2ifQGzjZnQx/LKvSLyn5KqT3/vCrJNGSjqi26bHEoM2U6s/xmYgWp/4GexJzhZ6OS
 T0koEdznFBDSyZUUWdFiBpjf72tIN4jr2GWQKr6p+qmeHMHLXYnGvCuzU3Sq0+I1370kqXgQMcH
 I11AMxC6j6ksC9ZlWu26jC2F2x7dhaq3MXPBrmkQY/xI5iJDHqZi8phn8GKUDuuu9EUF3jPR
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682214a8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=Pp2TpBy26f_jZvUfYgUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: F38lv-60k6vBekTJpHDkg3Cpytep7QgR
X-Proofpoint-GUID: F38lv-60k6vBekTJpHDkg3Cpytep7QgR
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Patches 4 to 12 are specific to legacy containers.
Patches 25 to 41 are specific to iommufd containers.
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

Changes in V3:
  * removed cleanup patches that were already pulled
  * rebased to latest master


Steve Sistare (42):
  MAINTAINERS: Add reviewer for CPR
  migration: cpr helpers
  migration: lower handler priority
  vfio: vfio_find_ram_discard_listener
  vfio: move vfio-cpr.h
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
  vfio/iommufd: register container for cpr
  vfio/iommufd: preserve descriptors
  vfio/iommufd: reconstruct device
  vfio/iommufd: reconstruct hw_caps
  vfio/iommufd: reconstruct hwpt
  vfio/iommufd: change process
  iommufd: preserve DMA mappings
  vfio/container: delete old cpr register

 MAINTAINERS                           |  10 ++
 accel/kvm/kvm-all.c                   |  28 ++++
 backends/iommufd.c                    |  83 ++++++++--
 backends/trace-events                 |   2 +
 hw/pci/msix.c                         |   2 +-
 hw/pci/pci.c                          |  13 ++
 hw/vfio/container-base.c              |  12 +-
 hw/vfio/container.c                   | 100 +++++++++---
 hw/vfio/cpr-iommufd.c                 | 174 +++++++++++++++++++++
 hw/vfio/cpr-legacy.c                  | 284 ++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                         | 176 +++++++++++++++++++--
 hw/vfio/device.c                      |  20 +--
 hw/vfio/helpers.c                     |  10 ++
 hw/vfio/iommufd.c                     | 201 ++++++++++++++++--------
 hw/vfio/listener.c                    |  91 +++++++----
 hw/vfio/meson.build                   |   2 +
 hw/vfio/pci.c                         | 195 +++++++++++++++++------
 hw/vfio/pci.h                         |  12 ++
 hw/vfio/trace-events                  |   1 +
 hw/vfio/vfio-cpr.h                    |  15 --
 hw/vfio/vfio-iommufd.h                |  10 ++
 hw/virtio/vhost-vdpa.c                |   8 +-
 include/exec/cpu-common.h             |   1 +
 include/hw/pci/msix.h                 |   1 +
 include/hw/vfio/vfio-container-base.h |  15 +-
 include/hw/vfio/vfio-container.h      |   2 +
 include/hw/vfio/vfio-cpr.h            |  71 +++++++++
 include/hw/vfio/vfio-device.h         |   4 +
 include/migration/cpr.h               |   8 +
 include/migration/vmstate.h           |   6 +-
 include/qemu/vfio-helpers.h           |   1 -
 include/system/iommufd.h              |   6 +
 include/system/kvm.h                  |   1 +
 include/system/memory.h               |  16 +-
 migration/cpr-transfer.c              |  18 +++
 migration/cpr.c                       |  72 +++++++++
 migration/migration.c                 |   1 +
 migration/savevm.c                    |   4 +-
 system/memory.c                       |  25 +--
 system/physmem.c                      |   5 +
 40 files changed, 1460 insertions(+), 246 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c
 create mode 100644 hw/vfio/cpr-legacy.c
 delete mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 include/hw/vfio/vfio-cpr.h

base-commit: 7be29f2f1a3f5b037d27eedbd5df9f441e8c8c16
-- 
1.8.3.1


