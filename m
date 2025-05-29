Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2C8C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKirz-0003xP-9F; Thu, 29 May 2025 15:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKiry-0003x8-1v
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKirv-0000BS-LU
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:24:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfxVY022106;
 Thu, 29 May 2025 19:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=FzeBy2SWFtGobYU5
 q3r8pR5DTWzD+i5oki9BgOlOlYI=; b=esmZbjjXi2KTNrFW7vjVzAiGqlyRdlhE
 Tw/DIfMedlcQWYqmNbDNYqfQ4rKdu9JtIIPpxW1Ubda81TYiFAA8OIHbI9JJW9yl
 qP6wLqVPS5KDprJEji9TCPjvYPjagoz+rqxEReXUCDFPZvxy+wFoxrHJn6QuQgKN
 cOoQDfF1cCfxZ5fIEH6ou8pLOZnxA5s1f95UiGKxmxCAVXzVEucctL8jVe2C2V5Q
 I2IUJvVOV/K/bTHIjB7/7JJmJSxrY/4pNn7M/CxKr0awMJEHU0ei8KaxdEywIxrJ
 FcfnJDaoE7iRYS8htQebClIELTPkbLyMQQINEsv7zFya4aLMY3oPIQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ym12hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:41 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJMOu8020575; Thu, 29 May 2025 19:24:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jc4vk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:24:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJOeQl022158;
 Thu, 29 May 2025 19:24:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46u4jc4vjq-1; Thu, 29 May 2025 19:24:40 +0000
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
Subject: [PATCH V4 00/43] Live update: vfio and iommufd
Date: Thu, 29 May 2025 12:23:56 -0700
Message-Id: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290189
X-Proofpoint-GUID: d8kWcSVbipAzPSCpYjQatpgcpVz1ylP5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE4OSBTYWx0ZWRfXziYYxrIb3MIR
 aYYnll8o29hEwja2DfgaE1ONZEDFSPiC9ExfEgNRrN0/h55Mu/vnObFLYXQeKIQLHecOXJOtZtg
 3fDJXZNod7JHRuupFHPglu1mcOcLkwZG41yBbdTNYFcyiKQrfpVF3QV9AKhVcGI4DKX8rqRwxQf
 MAO1WpqD84DcUK/Mp7jrKO5/3JhuDQ5/t8Vl+l/Tc+QflC1a3P3wnMQDmrCOYCTtiofQ4h7KPJI
 xOqUQNFpmNzZnzntPZ0BdF+ZcPFA4FbXLnY1jPHl+fbl1hu51PtnSYHTkRuxGarPRlOM58QVL2C
 DcSF7fEVIAgwew61bfY7wQpIa4vN7L4XBTzJz+UheqjIYRdCyzZBvY+yU+WrAmG4X4zjZei/4MS
 vXKVktCJpzwAuskg1Bxsbjny4glRO28wdKQy/TWR/nGByhk87iKnmxiL00Ceenh4HXza2lC/
X-Proofpoint-ORIG-GUID: d8kWcSVbipAzPSCpYjQatpgcpVz1ylP5
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=6838b47a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=6sVW_zmk9xcIwHsUiXsA:9
 a=QEXdDO2ut3YA:10
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

Changes in V4:
  * added SPDX-License-Identifier
  * patch "vfio/container: preserve descriptors"
    - rewrote search loop in vfio_container_connect
    - do not return pfd from vfio_cpr_container_match
    - add helper for VFIO_GROUP_GET_DEVICE_FD
  * deleted patch "export vfio_legacy_dma_map"
  * patch "vfio/container: restore DMA vaddr"
    - deleted redundant error_report from vfio_legacy_cpr_dma_map
    - save old dma_map function
  * patch "vfio-pci: skip reset during cpr"
    - use cpr_is_incoming instead of cpr_reused
  * renamed err -> local_err in all new code
  * patch "export MSI functions"
    -  renamed with vfio_pci prefix, and defined wrappers for low level
       routines instead of exporting them.
  * patch "close kvm after cpr"
    - fixed build error for !CONFIG_KVM
  * added the cpr_resave_fd helper
  * dropped patch "pass ramblock to vfio_container_dma_map", relying on
    "pass MemoryRegion" from the vfio-user series instead.
  * deleted "reused" variables, replaced with cpr_is_incoming()
  * renamed cpr_needed_for_reuse -> cpr_incoming_needed
  * rewrote patch "pci: skip reset during cpr"
  * rebased to latest master

  for iommufd:
    * deleted redundant error_report from iommufd_backend_map_file_dma
    * added interface doc for dma_map_file
    * check return value of cpr_open_fd
    * deleted "export iommufd_cdev_get_info_iova_range"
    * deleted "reconstruct device"
    * deleted "reconstruct hw_caps"
    * deleted "define hwpt constructors"
    * seperated cpr registration for iommufd be and vfio container
    * correctly attach to multiple containers per iommufd using ioas_id
    * simplified "reconstruct hwpt" by matching against hwpt_id.
    * added patch "add vfio_device_free_name"


Steve Sistare (43):
  MAINTAINERS: Add reviewer for CPR
  vfio: return mr from vfio_get_xlat_addr
  vfio/container: pass MemoryRegion to DMA operations
  vfio/pci: vfio_pci_put_device on failure
  migration: cpr helpers
  migration: lower handler priority
  vfio: vfio_find_ram_discard_listener
  vfio: move vfio-cpr.h
  vfio/container: register container for cpr
  vfio/container: preserve descriptors
  vfio/container: discard old DMA vaddr
  vfio/container: restore DMA vaddr
  vfio/container: mdev cpr blocker
  vfio/container: recover from unmap-all-vaddr failure
  pci: export msix_is_pending
  pci: skip reset during cpr
  vfio-pci: skip reset during cpr
  vfio/pci: vfio_pci_vector_init
  vfio/pci: vfio_notifier_init
  vfio/pci: pass vector to virq functions
  vfio/pci: vfio_notifier_init cpr parameters
  vfio/pci: vfio_notifier_cleanup
  vfio/pci: export MSI functions
  vfio-pci: preserve MSI
  vfio-pci: preserve INTx
  migration: close kvm after cpr
  migration: cpr_get_fd_param helper
  backends/iommufd: iommufd_backend_map_file_dma
  backends/iommufd: change process ioctl
  physmem: qemu_ram_get_fd_offset
  vfio/iommufd: use IOMMU_IOAS_MAP_FILE
  vfio/iommufd: invariant device name
  vfio/iommufd: add vfio_device_free_name
  vfio/iommufd: device name blocker
  vfio/iommufd: register container for cpr
  migration: vfio cpr state hook
  vfio/iommufd: cpr state
  vfio/iommufd: preserve descriptors
  vfio/iommufd: reconstruct device
  vfio/iommufd: reconstruct hwpt
  vfio/iommufd: change process
  iommufd: preserve DMA mappings
  vfio/container: delete old cpr register

 MAINTAINERS                           |  10 ++
 hw/vfio/pci.h                         |  10 ++
 hw/vfio/vfio-cpr.h                    |  15 --
 include/exec/cpu-common.h             |   1 +
 include/hw/pci/msix.h                 |   1 +
 include/hw/pci/pci_device.h           |   3 +
 include/hw/vfio/vfio-container-base.h |  38 ++++-
 include/hw/vfio/vfio-container.h      |   2 +
 include/hw/vfio/vfio-cpr.h            |  78 +++++++++
 include/hw/vfio/vfio-device.h         |   5 +
 include/migration/cpr.h               |  21 +++
 include/migration/vmstate.h           |   6 +-
 include/system/iommufd.h              |   6 +
 include/system/kvm.h                  |   1 +
 include/system/memory.h               |  19 ++-
 accel/kvm/kvm-all.c                   |  28 ++++
 accel/stubs/kvm-stub.c                |   5 +
 backends/iommufd.c                    | 101 +++++++++++-
 hw/pci/msix.c                         |   2 +-
 hw/pci/pci.c                          |   5 +
 hw/vfio/ap.c                          |   2 +-
 hw/vfio/ccw.c                         |   2 +-
 hw/vfio/container-base.c              |  13 +-
 hw/vfio/container.c                   | 101 +++++++++---
 hw/vfio/cpr-iommufd.c                 | 220 ++++++++++++++++++++++++++
 hw/vfio/cpr-legacy.c                  | 288 ++++++++++++++++++++++++++++++++++
 hw/vfio/cpr.c                         | 161 +++++++++++++++++--
 hw/vfio/device.c                      |  40 +++--
 hw/vfio/helpers.c                     |  10 ++
 hw/vfio/iommufd.c                     |  86 ++++++++--
 hw/vfio/listener.c                    |  93 +++++++----
 hw/vfio/pci.c                         | 232 ++++++++++++++++++++-------
 hw/vfio/platform.c                    |   2 +-
 hw/vfio/vfio-stubs.c                  |  13 ++
 hw/virtio/vhost-vdpa.c                |   9 +-
 migration/cpr-transfer.c              |  18 +++
 migration/cpr.c                       |  95 +++++++++--
 migration/migration.c                 |   1 +
 migration/savevm.c                    |   4 +-
 system/memory.c                       |  32 +---
 system/physmem.c                      |   5 +
 backends/trace-events                 |   2 +
 hw/vfio/meson.build                   |   4 +
 43 files changed, 1576 insertions(+), 214 deletions(-)
 delete mode 100644 hw/vfio/vfio-cpr.h
 create mode 100644 include/hw/vfio/vfio-cpr.h
 create mode 100644 hw/vfio/cpr-iommufd.c
 create mode 100644 hw/vfio/cpr-legacy.c
 create mode 100644 hw/vfio/vfio-stubs.c

base-commit: d2e9b78162e31b1eaf20f3a4f563da82da56908d
-- 
1.8.3.1


