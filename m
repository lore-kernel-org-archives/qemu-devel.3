Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56C7C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 07:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsoP-0005xw-1a; Thu, 25 Jul 2024 03:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoL-0005wy-Cr
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:49 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1sWsoE-0001Gw-Gu
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 03:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721892163; x=1753428163;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fCGXuk1OlehWsXuBwZOTRT0DK5yQ8xJuS1pxLg/KV+c=;
 b=M/pPYKlNxt2HHuaC35J1w5P1oSW9WznRiaNyVgUkfXqevz796vX9PSbg
 Gy++HHc8FsZk8DXTFWkPJagdYqfQNDPazTVQ4/tnlO5xrWK1SFG7yqPOl
 IcwP4ZXs8vAWsELKdrKI76hzkDhj6XMUki5cRCpZwx/8LpBIIZxCe87Mo
 cwQVH8BB6iWkw/og0hjmxG3OMex/BZIuZWmvRvTQYVm6Z5hmn1Bpwd1tr
 k5OTwtYRHWGGbgQbFeb/8DGBQcXMhxsrw7krdi3O1J5yaCBoUxQgGAsuV
 gJ2V2BJy6MMTwURm9O+wgrdtk554o1wzxTJk/xh0Gk6b7hcRhR5+3QJwV A==;
X-CSE-ConnectionGUID: 6RaTPOEOSAGfD09Qc7AeXg==
X-CSE-MsgGUID: Yp9EbN7MTlmxr+dhVSBFaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30753917"
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="30753917"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:38 -0700
X-CSE-ConnectionGUID: CUQ2TppUT7y1qyX+oSeVHw==
X-CSE-MsgGUID: vhKsDaAtQeCfNWrdhm/Zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,235,1716274800"; d="scan'208";a="52858136"
Received: from emr-bkc.sh.intel.com ([10.112.230.82])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2024 00:22:35 -0700
From: Chenyi Qiang <chenyi.qiang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Edgecombe Rick P <rick.p.edgecombe@intel.com>,
 Wang Wei W <wei.w.wang@intel.com>, Peng Chao P <chao.p.peng@intel.com>,
 Gao Chao <chao.gao@intel.com>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH 0/6] Enable shared device assignment
Date: Thu, 25 Jul 2024 03:21:09 -0400
Message-ID: <20240725072118.358923-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
discard") effectively disables device assignment with guest_memfd.
guest_memfd is required for confidential guests, so device assignment to
confidential guests is disabled. A supporting assumption for disabling
device-assignment was that TEE I/O (SEV-TIO, TDX Connect, COVE-IO
etc...) solves the confidential-guest device-assignment problem [1].
That turns out not to be the case because TEE I/O depends on being able
to operate devices against "shared"/untrusted memory for device
initialization and error recovery scenarios.

This series utilizes an existing framework named RamDiscardManager to
notify VFIO of page conversions. However, there's still one concern
related to the semantics of RamDiscardManager which is used to manage
the memory plug/unplug state. This is a little different from the memory
shared/private in our requirement. See the "Open" section below for more
details.

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

Currently, the commit 852f0048f3 ("RAMBlock: make guest_memfd require
uncoordinated discard") has blocked the device assignment with
guest_memfd to avoid this problem.

Solution
========
The key to enable shared device assignment is to solve the stale IOMMU
mappings problem.

Given the constraints and assumptions here is a solution that satisfied
the use cases. RamDiscardManager, an existing interface currently
utilized by virtio-mem, offers a means to modify IOMMU mappings in
accordance with VM page assignment. Page conversion is similar to
hot-removing a page in one mode and adding it back in the other.

This series implements a RamDiscardManager for confidential VMs and
utilizes its infrastructure to notify VFIO of page conversions.

Another possible attempt [2] was to not discard shared pages in step 3
above. This was an incomplete band-aid because guests would consume
twice the memory since shared pages wouldn't be freed even after they
were converted to private.

Open
====
Implementing a RamDiscardManager to notify VFIO of page conversions
causes changes in semantics: private memory is treated as discarded (or
hot-removed) memory. This isn't aligned with the expectation of current
RamDiscardManager users (e.g. VFIO or live migration) who really
expect that discarded memory is hot-removed and thus can be skipped when
the users are processing guest memory. Treating private memory as
discarded won't work in future if VFIO or live migration needs to handle
private memory. e.g. VFIO may need to map private memory to support
Trusted IO and live migration for confidential VMs need to migrate
private memory.

There are two possible ways to mitigate the semantics changes.
1. Develop a new mechanism to notify the page conversions between
private and shared. For example, utilize the notifier_list in QEMU. VFIO
registers its own handler and gets notified upon page conversions. This
is a clean approach which only touches the notifier workflow. A
challenge is that for device hotplug, existing shared memory should be
mapped in IOMMU. This will need additional changes.

2. Extend the existing RamDiscardManager interface to manage not only
the discarded/populated status of guest memory but also the
shared/private status. RamDiscardManager users like VFIO will be
notified with one more argument indicating what change is happening and
can take action accordingly. It also has challenges e.g. QEMU allows
only one RamDiscardManager, how to support virtio-mem for confidential
VMs would be a problem. And some APIs like .is_populated() exposed by
RamDiscardManager are meaningless to shared/private memory. So they may
need some adjustments.

Testing
=======
This patch series is tested based on the internal TDX KVM/QEMU tree.

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
[2] https://lore.kernel.org/all/20240320083945.991426-20-michael.roth@amd.com/

Chenyi Qiang (6):
  guest_memfd: Introduce an object to manage the guest-memfd with
    RamDiscardManager
  guest_memfd: Introduce a helper to notify the shared/private state
    change
  KVM: Notify the state change via RamDiscardManager helper during
    shared/private conversion
  memory: Register the RamDiscardManager instance upon guest_memfd
    creation
  guest-memfd: Default to discarded (private) in guest_memfd_manager
  RAMBlock: make guest_memfd require coordinate discard

 accel/kvm/kvm-all.c                  |   7 +
 include/sysemu/guest-memfd-manager.h |  49 +++
 system/guest-memfd-manager.c         | 425 +++++++++++++++++++++++++++
 system/meson.build                   |   1 +
 system/physmem.c                     |  11 +-
 5 files changed, 492 insertions(+), 1 deletion(-)
 create mode 100644 include/sysemu/guest-memfd-manager.h
 create mode 100644 system/guest-memfd-manager.c


base-commit: 900536d3e97aed7fdd9cb4dadd3bf7023360e819
-- 
2.43.5


