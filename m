Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF2DC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 08:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPdIJ-0007zQ-AT; Thu, 12 Jun 2025 04:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIG-0007y2-LL
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:16 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uPdIC-0004F6-Kk
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 04:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749716893; x=1781252893;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=joAghIkMYWd3PwQ3ujiYRJi4NlnEZo8X1PfGmwzB2O0=;
 b=baLyByyziLBaUFR9HHqXpK53E9QDlOOai3O5fGkGKiAB2rWCcLPYYaex
 /NLEstWTlkOubx1U6R1lin9EsuOK/yXsGhOeYv9eXxCwzq5ztKm3WSlX0
 254vNNQmRHQQRGbBhXE880RV0KoIH6+WyaO23ffnEeLL9GJChmc1/DVUN
 XRL5NqeFIVMmp5wlMC4dxA3pEqIP0Tz8vFNDCp/6fVMrnT1MFjWbOxwvg
 2PX3GzaBDYyWxTJMcWb9hNFOMMcawsne11DEF2vBgCBgyHMIk5iVq10XD
 GO7D+4h50UoEhuY9aB87w7kGrpY7ndtJ7+Cq09DWo0cX0LsE6K/rNhrnF Q==;
X-CSE-ConnectionGUID: WxTpOGfNQpuz8DhZ/aHKtQ==
X-CSE-MsgGUID: ptvM74dcQkuGuWGUzZYuPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="69453406"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="69453406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:27:57 -0700
X-CSE-ConnectionGUID: NQmv2W5WSy+Nx6F6IAFlbQ==
X-CSE-MsgGUID: UU37cAuWSheeqWtyRGWcyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; d="scan'208";a="152442004"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 01:27:53 -0700
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
 Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v7 0/5] Enable shared device assignment
Date: Thu, 12 Jun 2025 16:27:41 +0800
Message-ID: <20250612082747.51539-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

This is the v7 series of the shared device assignment support.

There are not many differences compared to the previous version [1]. The
primary changes include some code cleanup in patch #4 and the addition
of a new comment in patch #5 to describe the brief period of status
consistency.

Overview of this series:

- Patch 1-3: Preparation patches. These include function exposure and
  some function prototype changes.
- Patch 4: Introduce a new object to implement RamDiscardManager
  interface and a helper to notify the shared/private state change.
- Patch 5: Enable coordinated discarding of RAM with guest_memfd through
  the RamDiscardManager interface.

---

Background
==========
Confidential VMs have two classes of memory: shared and private memory.
Shared memory is accessible from the host/VMM while private memory is
not. Confidential VMs can decide which memory is shared/private and
convert memory between shared and private at runtime.

"guest_memfd" is a new kind of fd whose primary goal is to serve guest
private memory. In current implementation, shared memory is allocated
with normal methods (e.g. mmap or fallocate) while private memory is
allocated from guest_memfd. When a VM performs memory conversions, QEMU
frees pages via madvise or via PUNCH_HOLE on memfd or guest_memfd from
one side, and allocates new pages from the other side. This will cause a
stale IOMMU mapping issue mentioned in [2] when we try to enable shared
device assignment in confidential VMs.

Solution
========
The key to enable shared device assignment is to update the IOMMU mappings
on page conversion. RamDiscardManager, an existing interface currently
utilized by virtio-mem, offers a means to modify IOMMU mappings in
accordance with VM page assignment. Page conversions is similar to
hot-removing a page in one mode and adding it back in the other.

This series implements a RamDiscardmanager for confidential VMs and
utilizes its infrastructure to notify VFIO of page conversions.

Limitation and future extension
===============================
This series only supports the basic shared device assignment functionality.
There are still some limitations and areas that can be extended or
optimized in the future.

Relationship with in-place conversion
-------------------------------------
In-place page conversion is the ongoing work to allow mmap() of
guest_memfd to userspace so that both private and shared memory can use
the same physical memory as the backend. This new design eliminates the
need to discard pages during shared/private conversions. When it is
ready, shared device assignment needs be adjusted to achieve an
unmap-before-conversion-to-private and map-after-conversion-to-shared
sequence to be compatible with the change.

Partial unmap limitation
------------------------
VFIO expects the DMA mapping for a specific IOVA to be mapped and
unmapped with the same granularity. The guest may perform partial
conversion, such as converting a small region within a larger one. To
prevent such invalid cases, current operations are performed with 4K
granularity. This could be optimized after DMA mapping cut operation
[3] is introduced in the future. We can always perform a
split-before-unmap if partial conversions happens. If the split
succeeds, the unmap will succeed and be atomic. If the split fails, the
unmap process fails.

More attributes management
--------------------------
Current RamDiscardManager can only manage a pair of opposite states like
populated/discared or shared/private. If more states need to be
considered, for example, support virtio-mem in confidential VMs, three
states would be possible (shared populated/private populated/discard).
Current framework cannot handle such scenario and we need to think of
some new framework at that time [4].

Memory overhead optimization
----------------------------
A comment from Baolu [5] suggests considering using Maple Tree or a generic
interval tree to manage private/shared state instead of a bitmap, which
can reduce memory consumption. This optmization can also be considered
in other bitmap use cases like dirty bitmaps for guest RAM.

Testing
=======
This patch series is tested based on kenrel v6.16-rc1 since TDX base
support has been merged. The QEMU repo is available at
QEMU: https://github.com/intel-staging/qemu-tdx/tree/tdx-upstream-snapshot-2025-06-12-v2

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

Related link
============
[1] https://lore.kernel.org/qemu-devel/20250530083256.105186-1-chenyi.qiang@intel.com/
[2] https://lore.kernel.org/qemu-devel/20240423150951.41600-54-pbonzini@redhat.com/
[3] https://lore.kernel.org/linux-iommu/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com/
[4] https://lore.kernel.org/qemu-devel/d1a71e00-243b-4751-ab73-c05a4e090d58@redhat.com/
[5] https://lore.kernel.org/qemu-devel/013b36a9-9310-4073-b54c-9c511f23decf@linux.intel.com/

Chenyi Qiang (5):
  memory: Export a helper to get intersection of a MemoryRegionSection
    with a given range
  memory: Change memory_region_set_ram_discard_manager() to return the
    result
  memory: Unify the definiton of ReplayRamPopulate() and
    ReplayRamDiscard()
  ram-block-attributes: Introduce RamBlockAttributes to manage RAMBlock
    with guest_memfd
  physmem: Support coordinated discarding of RAM with guest_memfd

 MAINTAINERS                   |   1 +
 accel/kvm/kvm-all.c           |   9 +
 hw/virtio/virtio-mem.c        |  83 +++----
 include/system/memory.h       | 100 ++++++--
 include/system/ramblock.h     |  22 ++
 migration/ram.c               |   5 +-
 system/memory.c               |  22 +-
 system/meson.build            |   1 +
 system/physmem.c              |  23 +-
 system/ram-block-attributes.c | 442 ++++++++++++++++++++++++++++++++++
 system/trace-events           |   3 +
 11 files changed, 627 insertions(+), 84 deletions(-)
 create mode 100644 system/ram-block-attributes.c

-- 
2.43.5


