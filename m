Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FBAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKDg-0004bH-Lt; Tue, 20 May 2025 06:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDe-0004b8-TL
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:10 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uHKDc-0004eb-Ff
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747736949; x=1779272949;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9JU4KRuBjIZ/fwOUCW3LW93ux2jg9gglm4OlG0lJK+Y=;
 b=PzagchZlQGp/wnuCO1MYObMChAVmTCD9wXklu822VyDmd3bSduVLyM3s
 TXq0HHgDZzkXk5mbnR5y5B8prBMGlaTfY+YzCLRqqM+63naxZPOCaSvsL
 7N+ACBs5RfvqLD4uNNHS6zwPF5GUFQbiRwngMCj7MQXw5yDg94oEzFMoa
 VblzBQW5yJVeHjzrQhAracf8YIlnUxOJT3yHdviM3bvtBZmQDHKSzH/YI
 WW0H9ja043wV9709Me9VcnVzILWDL+I4KZEQdNSkQVMLQKuWvROL0hmRQ
 ssR2tJA/nbe0pq0GfSRO54vPwBz2OpjFyUxC1QTfXReQ1X2hVxlpWSC/b g==;
X-CSE-ConnectionGUID: E81/rqIbRiumHr8CHS7QaQ==
X-CSE-MsgGUID: v9gTtkH+Th2g3PxOWThhmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49566604"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="49566604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:05 -0700
X-CSE-ConnectionGUID: NO/ICbJZSxefTCn+T6qDag==
X-CSE-MsgGUID: sQmbhplGRWCiCx6BWjz4pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144905180"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 03:29:00 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Gao Chao <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v5 00/10] Enable shared device assignment
Date: Tue, 20 May 2025 18:28:40 +0800
Message-ID: <20250520102856.132417-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

This is the v5 series of the shared device assignment support.

As discussed in the v4 series [1], the GenericStateManager parent class
and PrivateSharedManager child interface were deemed to be in the wrong
direction. This series reverts back to the original single
RamDiscardManager interface and puts it as future work to allow the
co-existence of multiple pairs of state management. For example, if we
want to have virtio-mem co-exist with guest_memfd, it will need a new
framework to combine the private/shared/discard states [2].

Another change since the last version is the error handling of memory
conversion. Currently, the failure of kvm_convert_memory() causes QEMU
to quit instead of resuming the guest. The complex rollback operation
doesn't add value and merely adds code that is difficult to test.
Although in the future, it is more likely to encounter more errors on
conversion paths like unmap failure on shared to private in-place
conversion. This series keeps complex error handling out of the picture
for now and attaches related handling at the end of the series for
future extension.

Apart from the above two parts with future work, there's some
optimization work in the future, i.e., using other more memory-efficient
mechanism to track ranges of contiguous states instead of a bitmap [3].
This series still uses a bitmap for simplicity.
 
The overview of this series:
- Patch 1-3: Preparation patches. These include function exposure and
  some definition changes to return values.
- Patch 4-5: Introduce a new object to implement RamDiscardManager
  interface and a helper to notify the shared/private state change.
- Patch 6: Store the new object including guest_memfd information in
  RAMBlock. Register the RamDiscardManager instance to the target
  RAMBlock's MemoryRegion so that the RamDiscardManager users can run in
  the specific path.
- Patch 7: Unlock the coordinate discard so that the shared device
  assignment (VFIO) can work with guest_memfd. After this patch, the
  basic device assignement functionality can work properly.
- Patch 8-9: Some cleanup work. Move the state change handling into a
  RamDiscardListener so that it can be invoked together with the VFIO
  listener by the state_change() call. This series dropped the priority
  support in v4 which is required by in-place conversions, because the
  conversion path will likely change.
- Patch 10: More complex error handing including rollback and mixture
  states conversion case.

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
stale IOMMU mapping issue mentioned in [4] when we try to enable shared
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
To support 1G page support for guest_memfd [5], the current direction is to
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
cut_mapping operation[6] is introduced in future. We can alway perform a
split-before-unmap if partial conversions happen. If the split succeeds,
the unmap will succeed and be atomic. If the split fails, the unmap
process fails.

Testing
=======
This patch series is tested based on TDX patches available at:
KVM: https://github.com/intel/tdx/tree/kvm-coco-queue-snapshot/kvm-coco-queue-snapshot-20250408
QEMU: https://github.com/intel-staging/qemu-tdx/tree/tdx-upstream-snapshot-2025-05-20

Because the new features like cut_mapping operation will only be support in iommufd.
It is recommended to use the iommufd-backed VFIO with the qemu command:

qemu-system-x86_64 [...]
    -object iommufd,id=iommufd0 \
    -device vfio-pci,host=XX:XX.X,iommufd=iommufd0

Following the bootup of the TD guest, the guest's IP address becomes
visible, and iperf is able to successfully send and receive data.

Related link
============
[1] https://lore.kernel.org/qemu-devel/20250407074939.18657-1-chenyi.qiang@intel.com/
[2] https://lore.kernel.org/qemu-devel/d1a71e00-243b-4751-ab73-c05a4e090d58@redhat.com/
[3] https://lore.kernel.org/qemu-devel/96ab7fa9-bd7a-444d-aef8-8c9c30439044@redhat.com/
[4] https://lore.kernel.org/qemu-devel/20240423150951.41600-54-pbonzini@redhat.com/
[5] https://lore.kernel.org/kvm/cover.1747264138.git.ackerleytng@google.com/
[6] https://lore.kernel.org/linux-iommu/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com/


Chenyi Qiang (10):
  memory: Export a helper to get intersection of a MemoryRegionSection
    with a given range
  memory: Change memory_region_set_ram_discard_manager() to return the
    result
  memory: Unify the definiton of ReplayRamPopulate() and
    ReplayRamDiscard()
  ram-block-attribute: Introduce RamBlockAttribute to manage RAMBlock
    with guest_memfd
  ram-block-attribute: Introduce a helper to notify shared/private state
    changes
  memory: Attach RamBlockAttribute to guest_memfd-backed RAMBlocks
  RAMBlock: Make guest_memfd require coordinate discard
  memory: Change NotifyRamDiscard() definition to return the result
  KVM: Introduce RamDiscardListener for attribute changes during memory
    conversions
  ram-block-attribute: Add more error handling during state changes

 MAINTAINERS                                 |   1 +
 accel/kvm/kvm-all.c                         |  79 ++-
 hw/vfio/listener.c                          |   6 +-
 hw/virtio/virtio-mem.c                      |  83 ++--
 include/system/confidential-guest-support.h |   9 +
 include/system/memory.h                     |  76 ++-
 include/system/ramblock.h                   |  22 +
 migration/ram.c                             |  33 +-
 system/memory.c                             |  22 +-
 system/meson.build                          |   1 +
 system/physmem.c                            |  18 +-
 system/ram-block-attribute.c                | 514 ++++++++++++++++++++
 target/i386/kvm/tdx.c                       |   1 +
 target/i386/sev.c                           |   1 +
 14 files changed, 770 insertions(+), 96 deletions(-)
 create mode 100644 system/ram-block-attribute.c

-- 
2.43.5


