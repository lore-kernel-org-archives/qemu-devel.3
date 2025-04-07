Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8A3C3601E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hF9-0001Fj-Sm; Mon, 07 Apr 2025 03:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hEx-00019Y-Uv
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:49:57 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u1hEu-0005BH-DT
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 03:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744012193; x=1775548193;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mSAezktNG8dVzVhMCB8PZG527ESENfq5hxoLu+AvQFY=;
 b=dPDC+c1lFopf+Gk4qil4wOEf5yQrfWwO+9hDxaJjCYOauqcDyDvFPPZP
 FlZ1KdYU4+ktxnX+6SafOu+/VaCpIYfuJOsRgZM0WcIJIdaJok5L5Lgm2
 Gli8liemCrJ+prJvV+NkkQHoKzVVJekt+Dzzvd81Ldxard0V23AwXIZYM
 JyJ+trh4Cihrb2SrK3ZbnQazZFW6+OFaDdyhyjaRps2poljcqMZ7m7Qwi
 Hdr0SLyE4IcBM1fAf4QI3Rt3UID1E+jYtW0ukVGkvB+ajLnVCOi338t+R
 RwX9tDirt+bfUG9SV1yrr1nL4KEhNdTO9cJgqga7eyvO9n+HO9m9cprcl w==;
X-CSE-ConnectionGUID: CH9MJkakTPKyjmvelu2DAA==
X-CSE-MsgGUID: 5w35kspQQAimUxb+WZY8Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="67857495"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="67857495"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:49:48 -0700
X-CSE-ConnectionGUID: UzeJQF2cTKO9kHzxBF8TBA==
X-CSE-MsgGUID: lxvyyHAzR66S88l7ynURxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="128405457"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 00:49:45 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v4 00/13] Enable shared device assignment
Date: Mon,  7 Apr 2025 15:49:20 +0800
Message-ID: <20250407074939.18657-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=chenyi.qiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the v4 series of the shared device assignment support.

Compared with v3 series, the main changes are:

- Introduced a new GenericStateManager parent class, so that the existing
  RamDiscardManager and new PrivateSharedManager can be its child class
  and manage different states.
- Changed the name of MemoryAttributeManager to RamBlockAttribute to
  distinguish from the XXXManager interface and still use it to manage
  guest_memfd information. Meanwhile, Use it to implement
  PrivateSharedManager instead of RamDiscardManager to distinguish the
  states of populate/discard and shared/private.
- Moved the attribute change operations into a listener so that both the
  attribute change and IOMMU pins can be invoked in listener callbacks.
- Added priority listener support in PrivateSharedListener so that the
  attribute change listener and VFIO listener can be triggered in
  expected order to comply with in-place conversin requirement.
- v3: https://lore.kernel.org/qemu-devel/20250310081837.13123-1-chenyi.qiang@intel.com/

The overview of this series:
- Patch 1-3: preparation patches. These include function exposure and
  some definition changes to return values.
- Patch 4: Introduce a generic state change parent class with
  RamDiscardManager as its child class. This paves the way to introduce
  new child classes to manage other memory states.
- Patch 5-6: Introduce a new child class, PrivateSharedManager, to
  manage the private and shared states. Also adds VFIO support for this
  new interface to coordinate RAM discard support. 
- Patch 7-9: Introduce a new object to implement the
  PrivateSharedManager interface and a callback to notify the
  shared/private state change. Stores it in RAMBlocks and register it in
  the target MemoryRegion so that the object can notify page conversion
  events to other systems.
- Patch 10-11: Moves the state change handling into a
  PrivateSharedListener so that it can be invoked together with the VFIO
  listener by the state_change() call.
- Patch 12: To comply with in-place conversion, introduces the priority
  listener support so that the attribute change and IOMMU pin can follow
  the expected order.
- Patch 13: Unlocks the coordinate discard so that the shared device
  assignment (VFIO) can work with guest_memfd.

More small changes or details can be found in the individual patches.

---
Original cover letter with minor changes related to new parent class:

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
accordance with VM page assignment. Although the required operations in
VFIO for page conversion are similar to memory plug/unplug, the states of
private/shared are different from discard/populated. We want a similar
mechanism with RamDiscardManager but used to manage the state of private
and shared.

This series introduce a new parent abstract class to manage a pair of
opposite states with RamDiscardManager as its child to manage
populate/discard states, and introduce a new child class,
PrivateSharedManager, which can also utilize the same infrastructure to
notify VFIO of page conversions.

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
KVM: https://github.com/intel/tdx/tree/kvm-coco-queue-snapshot/kvm-coco-queue-snapshot-20250322
     (With the revert of HEAD commit)
QEMU: https://github.com/intel-staging/qemu-tdx/tree/tdx-upstream-snapshot-2025-04-07

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

Chenyi Qiang (13):
  memory: Export a helper to get intersection of a MemoryRegionSection
    with a given range
  memory: Change memory_region_set_ram_discard_manager() to return the
    result
  memory: Unify the definiton of ReplayRamPopulate() and
    ReplayRamDiscard()
  memory: Introduce generic state change parent class for
    RamDiscardManager
  memory: Introduce PrivateSharedManager Interface as child of
    GenericStateManager
  vfio: Add the support for PrivateSharedManager Interface
  ram-block-attribute: Introduce RamBlockAttribute to manage RAMBLock
    with guest_memfd
  ram-block-attribute: Introduce a callback to notify shared/private
    state changes
  memory: Attach RamBlockAttribute to guest_memfd-backed RAMBlocks
  memory: Change NotifyStateClear() definition to return the result
  KVM: Introduce CVMPrivateSharedListener for attribute changes during
    page conversions
  ram-block-attribute: Add priority listener support for
    PrivateSharedListener
  RAMBlock: Make guest_memfd require coordinate discard

 accel/kvm/kvm-all.c                         |  81 +++-
 hw/vfio/common.c                            | 131 +++++-
 hw/vfio/container-base.c                    |   1 +
 hw/virtio/virtio-mem.c                      | 168 +++----
 include/exec/memory.h                       | 407 ++++++++++------
 include/exec/ramblock.h                     |  25 +
 include/hw/vfio/vfio-container-base.h       |  10 +
 include/system/confidential-guest-support.h |  10 +
 migration/ram.c                             |  21 +-
 system/memory.c                             | 137 ++++--
 system/memory_mapping.c                     |   6 +-
 system/meson.build                          |   1 +
 system/physmem.c                            |  20 +-
 system/ram-block-attribute.c                | 495 ++++++++++++++++++++
 target/i386/kvm/tdx.c                       |   1 +
 target/i386/sev.c                           |   1 +
 16 files changed, 1192 insertions(+), 323 deletions(-)
 create mode 100644 system/ram-block-attribute.c

-- 
2.43.5


