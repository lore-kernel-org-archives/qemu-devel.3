Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50292E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 07:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLzno-0007XA-31; Fri, 13 Dec 2024 02:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLznm-0007WX-Gn
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:30 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tLzne-000714-1A
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 02:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734073762; x=1765609762;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0IjN+0MCgw2Kfh512oUfcZYlwhsgCE7z2ZafiBOLqqs=;
 b=DBUQO5bRVnWX/9cPpzMd7fqAwX/D7+GX3uBW9hOPSxz2+hWf+pCZe9kR
 Zl9NU4UWvQDffn7w/3M3Z9FfDWBjj0r9IP1j49/DFDJkvyyWJZn94yHMu
 2crE9wstSgxmymIaNgry5TqI6OmWxMFcaKFmcLL1lJZ2V/TpG3RVvBE5O
 c+2OZYhqqS5OEBmhwxRDs6nC2wT0OwU4QRERx8DG2/KYXtdRSyvY4+nNp
 vHMZ7OaWYRkwF0xBgszJiIuDTjOitvS6tMHnnYr2c3AA8PkzY0Unod/Jy
 RR2TkX+n5GXZMsoKxfWm/S2J1MuLN3MeIV+QaD4ksqAGL88XPtZSIs9YR A==;
X-CSE-ConnectionGUID: HQuWCuzVRzG12Sk5azeiig==
X-CSE-MsgGUID: ZTzMwpaWSwyqxg1B7xJqjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="51937058"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="51937058"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:16 -0800
X-CSE-ConnectionGUID: awN3I9MKSHqDQVXc8J2szA==
X-CSE-MsgGUID: MTGxQwfkRQ+XmeIdh72Srg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; d="scan'208";a="96365528"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 23:09:13 -0800
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 0/7] Enable shared device assignment
Date: Fri, 13 Dec 2024 15:08:42 +0800
Message-ID: <20241213070852.106092-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
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

Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
discard") effectively disables device assignment when using guest_memfd.
This poses a significant challenge as guest_memfd is essential for
confidential guests, thereby blocking device assignment to these VMs.
The initial rationale for disabling device assignment was due to stale
IOMMU mappings (see Problem section) and the assumption that TEE I/O
(SEV-TIO, TDX Connect, COVE-IO, etc.) would solve the device-assignment
problem for confidential guests [1]. However, this assumption has proven
to be incorrect. TEE I/O relies on the ability to operate devices against
"shared" or untrusted memory, which is crucial for device initialization
and error recovery scenarios. As a result, the current implementation does
not adequately support device assignment for confidential guests, necessitating
a reevaluation of the approach to ensure compatibility and functionality.

This series enables shared device assignment by notifying VFIO of page
conversions using an existing framework named RamDiscardListener.
Additionally, there is an ongoing patch set [2] that aims to add 1G page
support for guest_memfd. This patch set introduces in-place page conversion,
where private and shared memory share the same physical pages as the backend.
This development may impact our solution.

We presented our solution in the guest_memfd meeting to discuss its
compatibility with the new changes and potential future directions (see [3]
for more details). The conclusion was that, although our solution may not be
the most elegant (see the Limitation section), it is sufficient for now and
can be easily adapted to future changes.

We are re-posting the patch series with some cleanup and have removed the RFC
label for the main enabling patches (1-6). The newly-added patch 7 is still
marked as RFC as it tries to resolve some extension concerns related to
RamDiscardManager for future usage.

The overview of the patches:
- Patch 1: Export a helper to get intersection of a MemoryRegionSection
  with a given range.
- Patch 2-6: Introduce a new object to manage the guest-memfd with
  RamDiscardManager, and notify the shared/private state change during
  conversion.
- Patch 7: Try to resolve a semantics concern related to RamDiscardManager
  i.e. RamDiscardManager is used to manage memory plug/unplug state
  instead of shared/private state. It would affect future users of
  RamDiscardManger in confidential VMs. Attach it behind as a RFC patch[4].

Changes since last version:
- Add a patch to export some generic helper functions from virtio-mem code.
- Change the bitmap in guest_memfd_manager from default shared to default
  private. This keeps alignment with virtio-mem that 1-setting in bitmap
  represents the populated state and may help to export more generic code
  if necessary.
- Add the helpers to initialize/uninitialize the guest_memfd_manager instance
  to make it more clear.
- Add a patch to distinguish between the shared/private state change and
  the memory plug/unplug state change in RamDiscardManager.
- RFC: https://lore.kernel.org/qemu-devel/20240725072118.358923-1-chenyi.qiang@intel.com/

---

Background
==========
Confidential VMs have two classes of memory: shared and private memory.
Shared memory is accessible from the host/VMM while private memory is
not. Confidential VMs can decide which memory is shared/private and
convert memory between shared/private at runtime.

"guest_memfd" is a new kind of fd whose primary goal is to serve guest
private memory. The key differences between guest_memfd and normal memfd
are that guest_memfd is spawned by a KVM ioctl, bound to its owner VM and
cannot be mapped, read or written by userspace.

In QEMU's implementation, shared memory is allocated with normal methods
(e.g. mmap or fallocate) while private memory is allocated from
guest_memfd. When a VM performs memory conversions, QEMU frees pages via
madvise() or via PUNCH_HOLE on memfd or guest_memfd from one side and
allocates new pages from the other side.

Problem
=======
Device assignment in QEMU is implemented via VFIO system. In the normal
VM, VM memory is pinned at the beginning of time by VFIO. In the
confidential VM, the VM can convert memory and when that happens
nothing currently tells VFIO that its mappings are stale. This means
that page conversion leaks memory and leaves stale IOMMU mappings. For
example, sequence like the following can result in stale IOMMU mappings:

1. allocate shared page
2. convert page shared->private
3. discard shared page
4. convert page private->shared
5. allocate shared page
6. issue DMA operations against that shared page

After step 3, VFIO is still pinning the page. However, DMA operations in
step 6 will hit the old mapping that was allocated in step 1, which
causes the device to access the invalid data.

Solution
========
The key to enable shared device assignment is to update the IOMMU mappings
on page conversion.

Given the constraints and assumptions here is a solution that satisfied
the use cases. RamDiscardManager, an existing interface currently
utilized by virtio-mem, offers a means to modify IOMMU mappings in
accordance with VM page assignment. Page conversion is similar to
hot-removing a page in one mode and adding it back in the other.

This series implements a RamDiscardManager for confidential VMs and
utilizes its infrastructure to notify VFIO of page conversions.

Another possible attempt [5] was to not discard shared pages in step 3
above. This was an incomplete band-aid because guests would consume
twice the memory since shared pages wouldn't be freed even after they
were converted to private.

w/ in-place page conversion
===========================
To support 1G page support for guest_memfd, the current direction is to
allow mmap() of guest_memfd to userspace so that both private and shared
memory can use the same physical pages as the backend. This in-place page
conversion design eliminates the need to discard pages during shared/private
conversions. However, device assignment will still be blocked because the
in-place page conversion will reject the conversion when the page is pinned
by VFIO.

To address this, the key difference lies in the sequence of VFIO map/unmap
operations and the page conversion. This series can be adjusted to achieve
unmap-before-conversion-to-private and map-after-conversion-to-shared,
ensuring compatibility with guest_memfd.

Additionally, with in-place page conversion, the previously mentioned
solution to disable the discard of shared pages is not feasible because
shared and private memory share the same backend, and no discard operation
is performed. Retaining the old mappings in the IOMMU would result in
unsafe DMA access to protected memory.

Limitation
==========

One limitation (also discussed in the guest_memfd meeting) is that VFIO
expects the DMA mapping for a specific IOVA to be mapped and unmapped with
the same granularity. The guest may perform partial conversions, such as
converting a small region within a larger region. To prevent such invalid
cases, all operations are performed with 4K granularity. The possible
solutions we can think of are either to enable VFIO to support partial unmap
or to implement an enlightened guest to avoid partial conversion. The former
requires complex changes in VFIO, while the latter requires the page
conversion to be a guest-enlightened behavior. It is still uncertain which
option is a preferred one.

Testing
=======
This patch series is tested with the KVM/QEMU branch:
KVM: https://github.com/intel/tdx/tree/tdx_kvm_dev-2024-11-20
QEMU: https://github.com/intel-staging/qemu-tdx/tree/tdx-upstream-snapshot-2024-12-13

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
[1] https://lore.kernel.org/all/d6acfbef-96a1-42bc-8866-c12a4de8c57c@redhat.com/
[2] https://lore.kernel.org/lkml/cover.1726009989.git.ackerleytng@google.com/
[3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.jr4csfgw1uql
[4] https://lore.kernel.org/qemu-devel/d299bbad-81bc-462e-91b5-a6d9c27ffe3a@redhat.com/
[5] https://lore.kernel.org/all/20240320083945.991426-20-michael.roth@amd.com/

Chenyi Qiang (7):
  memory: Export a helper to get intersection of a MemoryRegionSection
    with a given range
  guest_memfd: Introduce an object to manage the guest-memfd with
    RamDiscardManager
  guest_memfd: Introduce a callback to notify the shared/private state
    change
  KVM: Notify the state change event during shared/private conversion
  memory: Register the RamDiscardManager instance upon guest_memfd
    creation
  RAMBlock: make guest_memfd require coordinate discard
  memory: Add a new argument to indicate the request attribute in
    RamDismcardManager helpers

 accel/kvm/kvm-all.c                  |   4 +
 hw/vfio/common.c                     |  22 +-
 hw/virtio/virtio-mem.c               |  55 ++--
 include/exec/memory.h                |  36 ++-
 include/sysemu/guest-memfd-manager.h |  91 ++++++
 migration/ram.c                      |  14 +-
 system/guest-memfd-manager.c         | 456 +++++++++++++++++++++++++++
 system/memory.c                      |  30 +-
 system/memory_mapping.c              |   4 +-
 system/meson.build                   |   1 +
 system/physmem.c                     |   9 +-
 11 files changed, 659 insertions(+), 63 deletions(-)
 create mode 100644 include/sysemu/guest-memfd-manager.h
 create mode 100644 system/guest-memfd-manager.c

-- 
2.43.5


