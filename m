Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79100C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5Ty-0003OO-NZ; Wed, 02 Jul 2025 17:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tw-0003NC-Op
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tt-0003dd-SW
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LS92Z015986;
 Wed, 2 Jul 2025 21:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=zq9jyIawb3g/kS6D
 IqMSnAQhIEM0Cu7t2A5cyn7+dHw=; b=OF/9BJcO8Su5Wvp6YW4uR/wIidgvfO5j
 mHD6L/1v2FAjbuDu5YQjNxIH5m6+la4p0kAL8h5KM+ElvhrtqFWFf8FY545NQ+wY
 UdiJVf/69KQtUYokVbBp7rwjne7iK5g/BMnGwPe1VI8tppgOGV38cdfpbdmYi1TB
 w5nbg3TgZ+418/6U6qs5H2CIWmj1zCy38xrdcxllCI0b88tTdS6wB8qC7qgaMmz7
 P+MyV37GyZF9vECS26gBmFKuPLluiDi+drW/lYoBW8jPdnurz3qZOJRULM5ULTRt
 lrjIyyQKC136TLNWvkDbTag0nLUIL9NI6IggFV3knA9I0tW/s1CtjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xx7vct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:00 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LYikf033672; Wed, 2 Jul 2025 21:59:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtcxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:00 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxfs020012;
 Wed, 2 Jul 2025 21:58:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-1; Wed, 02 Jul 2025 21:58:59 +0000
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
Subject: [PATCH V6 00/21] Live update: vfio and iommufd
Date: Wed,  2 Jul 2025 14:58:37 -0700
Message-Id: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX6heP2JfgMtcP
 k8vzkHvfCXGOzcTE16gyT3Gs5BUGq1y9T1QHacV532WgcxTrAQqUs5GWax0c1KGa8JA+NzLzH9v
 vAl2kbx+BtqWxXVSo+jhHocf7tKHKYiMiNGqvjSeEtF9j0xAdcSoPFedEqXuCXZ7Zt70cHqbzZP
 /t4dD8FnTrJP5Flzv3gqpoEGH9jZzJnyHQIzMh2zQngF/IKORJrQ31X1vbPjl6VIoqgdAGmcRHw
 +O9edRY9ua+b4b93hfttaewpN4b7yI8Q4Y3jpnRlrCHC3XRVd42wZ5BBwrnD9naFXfS0uJsWiv/
 /LCF1n2VU+wrbbm7ebNcF2K9P4nqXlFe4FXHB/xYsE37YfWJM0AXP6HmvVxPNMOBPLVfpjzf21m
 9YdFSutyNv6/0OMfi7fN1C77AG+hc/TkkfFjnepI4glHhIYflhWUwVcVKdO6/eOf2xZxEjg4
X-Proofpoint-ORIG-GUID: _QO2YA0lD8XqtRZUHQSDAcbPfi4vVdcp
X-Proofpoint-GUID: _QO2YA0lD8XqtRZUHQSDAcbPfi4vVdcp
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6865aba5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=fXwqTCH3gT_5L80uFTsA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

NOTE: this V6 series depends on the patch
  vfio-user: do not register vfio-user container with cpr
which is in vfio-next.

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

Patches 3 to 8 are specific to legacy containers.
Patches 21 to 36 are specific to iommufd containers.
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

Changes in V5:
  * dropped: vfio/pci: vfio_pci_put_device on failure
  * added: "vfio: doc changes for cpr"
  * deleted unnecessary include of vfio-cpr.h
  * fixed compilation for !CONFIG_VFIO and !CONFIG_IOMMUFD
  * misc minor changes
  * Added RB's, rebased to master

Changes in V6:
  * dropped already-pulled patches
  * converted remaining g_free in "add vfio_device_free_name"
  * fixed iommufd_backend_disconnect in "preserve descriptors"
  * tweaked vfio_cpr_load_device in "preserve descriptors"
  * added trace_vfio_cpr_find_device in "cpr state"
  * rewrote vfio_notifier_init and vfio_msix_vector_use
  * rewrote the notifier in "close kvm after cpr"
  * Added RB's, rebased to master


Steve Sistare (21):
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
  vfio: doc changes for cpr

 docs/devel/migration/CPR.rst          |   5 +-
 qapi/migration.json                   |   6 +-
 hw/vfio/pci.h                         |   2 +
 include/exec/cpu-common.h             |   1 +
 include/hw/vfio/vfio-container-base.h |  15 +++
 include/hw/vfio/vfio-cpr.h            |  29 ++++-
 include/hw/vfio/vfio-device.h         |   3 +
 include/migration/cpr.h               |  14 +++
 include/system/iommufd.h              |   7 ++
 include/system/kvm.h                  |   1 +
 accel/kvm/kvm-all.c                   |  32 +++++
 backends/iommufd.c                    | 107 +++++++++++++++-
 hw/vfio/ap.c                          |   4 +-
 hw/vfio/ccw.c                         |   4 +-
 hw/vfio/container-base.c              |   9 ++
 hw/vfio/cpr-iommufd.c                 | 224 ++++++++++++++++++++++++++++++++++
 hw/vfio/cpr-legacy.c                  |   2 +
 hw/vfio/cpr.c                         | 144 ++++++++++++++++++++--
 hw/vfio/device.c                      |  40 ++++--
 hw/vfio/helpers.c                     |  11 ++
 hw/vfio/iommufd-stubs.c               |  18 +++
 hw/vfio/iommufd.c                     |  81 ++++++++++--
 hw/vfio/pci.c                         | 109 ++++++++++++++++-
 hw/vfio/platform.c                    |   2 +-
 migration/cpr.c                       |  52 ++++++--
 system/physmem.c                      |   5 +
 backends/trace-events                 |   2 +
 hw/vfio/meson.build                   |   2 +
 hw/vfio/trace-events                  |   3 +
 29 files changed, 871 insertions(+), 63 deletions(-)
 create mode 100644 hw/vfio/cpr-iommufd.c
 create mode 100644 hw/vfio/iommufd-stubs.c

-- 
1.8.3.1


