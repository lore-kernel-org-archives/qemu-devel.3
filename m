Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EBDC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYNG-0006Uo-R6; Mon, 10 Mar 2025 04:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1trYN9-0006T0-Eg
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:27 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1trYN3-0004PV-Ec
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741594821; x=1773130821;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LXWNHMvLvXD0VwhJ6IcIyTnGaD9zgRK8HpIgyy3vA6E=;
 b=EqKd2OxFOxo3A/sCAw/Z85503bOZ451Ufyddrk/67kbau7Ml4YmlelCo
 SH+t7fMPqTsOBNnpM/T4pK4VXtqmeGbXeVD8r2yENI+ur1pjRtZX5T3vs
 fGc0PhwUonrxgKZKb/ujxxybvvfmGPCzSub4aaLLoCbm1LlNJvjHtdCK3
 Zh2h693ZQEMlzDi6yxS8pvor4U2pOqecGk7n+kXy4SrKb+GhW7anQ5F0e
 vUcyiCGetANH5TLNa0nHkY/tc5sPt1Y8hMzk4dEJTnmqDj9dRX1vT2lN5
 +pVCoHxCOLseFqu4qqQogEsHF0lRPep41HZzmoNgTkIO6cdLU3r56L57J Q==;
X-CSE-ConnectionGUID: XhvEvJ3zTF2DPG84egPgoQ==
X-CSE-MsgGUID: m7jA3MhLRMa9ysuwpqvweA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42688440"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="42688440"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 01:20:16 -0700
X-CSE-ConnectionGUID: 8jJCGZSLQg+TyO4E3PI0/w==
X-CSE-MsgGUID: rn7e5Ph6R2+rfXMhZWE4GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="150862776"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 01:20:13 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 0/7] Enable shared device assignment
Date: Mon, 10 Mar 2025 16:18:28 +0800
Message-ID: <20250310081837.13123-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the v3 series of the shared device assignment support.

The overview of this series:
- Patch 1-3: preparation patches. The function exposure and some
  defintion change to return values.
- Patch 4-5: Introduce a new object to implement RamDiscardManager
  interface and a callback to notify the shared/private state change.
- Patch 6: Store the new object including guest_memfd information in
  RAMBlock. Register the RamDiscardManager instance to the target
  RAMBlock's MemoryRegion so that the object can notify the page
  conversion events to other systems.
- Patch 7: Unlock the coordinate discard so that the shared device
  assignment (VFIO) can work with guest_memfd.

Compared with v2 series, the main changes are:

- Introduce the new patch 04 to unify the definiton of ReplayRamPopulate()
  and ReplayRamDiscard().
- In state_change() callback, fallback to a "1 block at a time" handling in case of
  mixed state. In addition, change the bitmap before calling the
  listener so that the listener can do the change according to the
  latest status.
- In kvm_convert_memory(), use ReplayPopulated() and ReplayDiscard()
  interface to trigger set_attribute() and add the undo operation if
  state_change() failed.
- v2: https://lore.kernel.org/qemu-devel/20250217081833.21568-1-chenyi.qiang@intel.com/

More small changes or details can be found in the individual patches.

---
Original cover letter:

Background
==========
Confidential VMs have two classes of memory: shared and private memory.
Shared memory is accessible from the host/VMM while private memory is
not. Confidential VMs can decide which memory is shared/private and
convert memory between shared/private at runtime.

"guest_memfd" is a new kind of fd whose primary goal is to serve guest
private memory. In current implementation, shared memory is allocated
with normal methods (e.g. mmap or fallocate) while private memory is
allocated from guest_memfd. When a VM performs memory conversions, QEMU
frees pages via madvise or via PUNCH_HOLE on memfd or guest_memfd from
one side, and allocates new pages from the other side. This will cause a
stale IOMMU mapping issue mentioned in [1] when we try to enable shared
device assignment in confidential VMs.

Solution
========
The key to enable shared device assignment is to update the IOMMU mappings
on page conversion. RamDiscardManager, an existing interface currently
utilized by virtio-mem, offers a means to modify IOMMU mappings in
accordance with VM page assignment. Page conversion is similar to
hot-removing a page in one mode and adding it back in the other.

This series implements a RamDiscardManager for confidential VMs and
utilizes its infrastructure to notify VFIO of page conversions.

Relationship with in-place page conversion
==========================================
To support 1G page support for guest_memfd [2], the current direction is to
allow mmap() of guest_memfd to userspace so that both private and shared
memory can use the same physical pages as the backend. This in-place page
conversion design eliminates the need to discard pages during shared/private
conversions. However, device assignment will still be blocked because the
in-place page conversion will reject the conversion when the page is pinned
by VFIO.

To address this, the key difference lies in the sequence of VFIO map/unmap
operations and the page conversion. It can be adjusted to achieve
unmap-before-conversion-to-private and map-after-conversion-to-shared,
ensuring compatibility with guest_memfd.

Limitation
==========
One limitation is that VFIO expects the DMA mapping for a specific IOVA
to be mapped and unmapped with the same granularity. The guest may
perform partial conversions, such as converting a small region within a
larger region. To prevent such invalid cases, all operations are
performed with 4K granularity. This could be optimized after the
cut_mapping operation [3] is introduced in future. We can alway perform a
split-before-unmap if partial conversions happen. If the split succeeds,
the unmap will succeed and be atomic. If the split fails, the unmap
process fails.

Testing
=======
This patch series is tested based on TDX patches available at:
KVM: https://github.com/intel/tdx/tree/kvm-coco-queue-snapshot/kvm-coco-queue-snapshot-20250308
QEMU: https://github.com/intel-staging/qemu-tdx/tree/tdx-upstream-snapshot-2025-03-10

To facilitate shared device assignment with the NIC, employ the legacy
type1 VFIO with the QEMU command:

qemu-system-x86_64 [...]
    -device vfio-pci,host=XX:XX.X

The parameter of dma_entry_limit needs to be adjusted. For example, a
16GB guest needs to adjust the parameter like
vfio_iommu_type1.dma_entry_limit=4194304.

If use the iommufd-backed VFIO with the qemu command:

qemu-system-x86_64 [...]
    -object iommufd,id=iommufd0 \
    -device vfio-pci,host=XX:XX.X,iommufd=iommufd0

No additional adjustment required.

Following the bootup of the TD guest, the guest's IP address becomes
visible, and iperf is able to successfully send and receive data.

Related link
============
[1] https://lore.kernel.org/qemu-devel/20240423150951.41600-54-pbonzini@redhat.com/
[2] https://lore.kernel.org/lkml/cover.1726009989.git.ackerleytng@google.com/
[3] https://lore.kernel.org/linux-iommu/7-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com/

Chenyi Qiang (7):
  memory: Export a helper to get intersection of a MemoryRegionSection
    with a given range
  memory: Change memory_region_set_ram_discard_manager() to return the
    result
  memory: Unify the definiton of ReplayRamPopulate() and
    ReplayRamDiscard()
  memory-attribute-manager: Introduce MemoryAttributeManager to manage
    RAMBLock with guest_memfd
  memory-attribute-manager: Introduce a callback to notify the
    shared/private state change
  memory: Attach MemoryAttributeManager to guest_memfd-backed RAMBlocks
  RAMBlock: Make guest_memfd require coordinate discard

 accel/kvm/kvm-all.c                       |  50 ++-
 hw/virtio/virtio-mem.c                    |  81 ++--
 include/exec/memory.h                     |  64 ++-
 include/exec/ramblock.h                   |   2 +
 include/system/memory-attribute-manager.h |  60 +++
 migration/ram.c                           |   5 +-
 system/memory-attribute-manager.c         | 471 ++++++++++++++++++++++
 system/memory.c                           |  22 +-
 system/meson.build                        |   1 +
 system/physmem.c                          |  17 +-
 10 files changed, 690 insertions(+), 83 deletions(-)
 create mode 100644 include/system/memory-attribute-manager.h
 create mode 100644 system/memory-attribute-manager.c

-- 
2.43.5


