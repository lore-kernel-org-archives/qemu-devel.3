Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADEAC87FDA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzQv-0007cI-4h; Thu, 07 Aug 2025 08:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQn-0007Rs-Eb; Thu, 07 Aug 2025 08:09:15 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzQi-00053l-IV; Thu, 07 Aug 2025 08:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568548; x=1786104548;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BUs+FiCAipw1LMY3Bv/udZ9uYMZJgxcMA0OA6r9z2FI=;
 b=a/ZbydVHAyjZurBESIC7R1KA/+KQZE0V4qNHTIVWzYoqAnIMVYmQO/OF
 B2/MnvfzX3bzr9gppeV8d0K6TGySiaz6Sjf4OWa4RCOPm0Bw42k5uZ8n1
 skrlWO3cjnEGhkpFsUk3vKOFceCe1AlWDcGx+hRciQcaNOiXoU2rOteKA
 TS2fP/8r7284kgPGUxl/HMfXEKPdlmR2tqnQMnhGXq6bFhsrZ1Uo9z9l8
 3aG6LXttzXjwEhEMW0rEOB6B8mQUyQ/1ChIqb4c5U1nCRnmtzVDl2Popp
 QlAFmm3lbQ8ivkmMpDDboxigHWJ2B5xpCCfOhS2qPoQdWZZO6Cup1ZjS2 g==;
X-CSE-ConnectionGUID: SjiTwUSuSSOeKbUQxI8IXA==
X-CSE-MsgGUID: bjyITwyDShuhGaqPQoZfDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036687"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036687"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:00 -0700
X-CSE-ConnectionGUID: Q7JBjARATHGHRFEuId3lTQ==
X-CSE-MsgGUID: oBJpUfD+TZePjyKRApBGxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701029"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:08:57 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 00/26] rust/memory: Integrate the vm-memory API from rust-vmm
Date: Thu,  7 Aug 2025 20:30:01 +0800
Message-Id: <20250807123027.2910950-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

This RFC series explores integrating the vm-memory API into QEMU's
rust/memory bindings.

Thanks to Paolo and Manos's many suggestions and feedback, I have
resolved many issues over the past few months, but there are still
some open issues that I would like to discuss.

This series finally provides the following safe interfaces in Rust:
 * AddressSpace::write in Rust <=> address_space_write in C
   - **but only** supports MEMTXATTRS_UNSPECIFIED

 * AddressSpace::read in Rust <=> address_space_read_full in C
   - **but only** supports MEMTXATTRS_UNSPECIFIED.

 * AddressSpace::store in Rust <=> address_space_st{size} in C
   - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.

 * AddressSpace::load in Rust <=> address_space_ld{size} in C
   - **but only** supports MEMTXATTRS_UNSPECIFIED and native endian.

And this series involves changes mainly to these three parts:
 * NEW QEMU memory APIs wrapper at C side.
 * Extra changes for vm-memory (downstream for now).
 * NEW QEMU memory bindings/APIs based on vm-memory at Rust side.

Although the number of line changes appears to be significant, more
than half of them are documentation and comments.

(Note: the latest vm-memory v0.16.2 crate didn't contain Paolo's
 commit 5f59e29c3d30 ("guest_memory: let multiple regions slice one
 global bitmap"), so I have to pull the vm-memory from github directly.)

Thanks for your feedback!


Background
==========

About vm-memory crate, it's design documentation said:

"The vm-memory crate focuses on defining consumer side interfaces to
 access the physical memory of the VM. It does not define how the
 underlying VM memory provider is implemented. Lightweight VMMs like
 CrosVM and Firecracker can make assumptions about the structure of VM's
 physical memory and implement a lightweight backend to access it. For
 VMMs like Qemu, a high performance and full functionality backend may
 be implemented with less assumptions."

At present, in addition to the memory model abstractions (including
GuestMemoryRegion, GuestMemory, and AddressSpace) it provides, it also
implements a simple memory management backend based on mmap for RAM
access.

However, for QEMU, the backend implementation based on vm-memory is more
complex, as QEMU not only needs to consider MMIO/IOMMU, but also complex
situations such as different endian/memory attributes.

This series tries to be simple as much as possible, and leaves different
endian/memory attributes support as the open issues.

But... wait, why vm-memory is necessary?

QEMU needs the safe Rust bindings for memory access. Whatever vm-memory
is used or not, there'll be the similar wrappers over AddressSpace/
FlatView/MemorySection, and there'll be the safe bindings for translation/
memory store, load, read and write.

Even if we don't use vm-memory, we will likely end up creating something
similar to vm-memory.

Furthermore, many components in vm-memory are also inspiring for
enhancements on the QEMU Rust side.

So, why not have a try?


Introduction
============

The core idea of this series is simple:
 * Implement vm_memory::GuestMemoryRegion trait for MemoryRegionSection
   to represent (non-overlapping) memory region.

   vm_memory::GuestMemoryRegion trait itself doesn't provide any
   interface to access memory. So vm_memory::Bytes trait is also
   necessary for MemoryRegionSection to access memory region.

 * Implement vm_memory::GuestMemory trait for FlatView to manage
   Guest memory regions (that's MemoryRegionSection).

   Similarly, vm_memory::Bytes trait is also needed for FlatView
   to provide methods to write/read/store/load memory.

 * Implement vm_memory::AddressSpace tarit for AddressSpace, to
   provide a safe address space abstraction at Rust side.


For the above three parts, the most critical stuff is related to
MemoryRegionSection.

Currently QEMU's memory API is built around MemoryRegion, and
MemoryRegionSection is only for internal use at the most time.

But vm_memory::GuestMemoryRegion trait requires us to wrap unsafe C
bindings based on MemoryRegionSection. So it's necessary to expose
some C memory APIs based MemoryRegionSection. This is the following
section:


NEW QEMU memory APIs wrappers at C side
=======================================

Around MemoryRegionSection, this series provides these interfaces:
 * Some straightforward wrappers over original C interfaces:
   - section_access_allowed
   - section_covers_region_addr,
   - section_fuzz_dma_read
   - section_get_host_addr

 * Critical wrappers for intermediate memroy read/write (they're still
   simple wrapper over C functions):
   - section_rust_read_continue_step
   - section_rust_write_continue_step

 * And, special C helpers for memory load/store:
   - section_rust_load

   MemTxResult section_rust_load(MemoryRegionSection *section,
                                 hwaddr mr_offset, uint8_t *buf,
                                 MemTxAttrs attrs, hwaddr len);

   - section_rust_store

   MemTxResult section_rust_store(MemoryRegionSection *section,
                                  hwaddr mr_offset, const uint8_t *buf,
                                  MemTxAttrs attrs, hwaddr len);


   These 2 load/store helpers are so different: comparing with the
   detail implementations of address_space_ld{size}/
   address_space_st{size}, these 2 functions aren't bound with specific
   type (l, q, or w), and transfer the value via byte array.

   This is because of the AtomicAccess bound in vm_memory::Bytes, which
   makes it difficult to convert AtomicAccess type to u64! (For more
   details, please refer the comments of Bytes::store/Bytes::load in
   patch 22 "rust/memory: Implement vm_memory::GuestMemoryRegion for
   MemoryRegionSection").


Of course, some other wrappers are also needed for FlatView and
AddressSpace:
 * For FlatView:
   - flatview_ref
   - flatview_translate_section
   - flatview_unref

 * For AddressSpace:
   - address_space_lookup_section
   - address_space_memory
   - address_space_to_flatview

They're all simple wrappers.

But, though QEMU's native C memory API could support complex conditions,
such as different endian formats or different memory attributes,
especially for memory write/read/store/load inferfaces. For now, Rust
side can only limit the support to only native endian and only
MEMTXATTRS_UNSPECIFIED.

This issue is related with why and how to adjust vm-memory's API for
QEMU:


Extra changes for vm-memory (downstream for now)
================================================

(All the patches for vm-memory can be found at patch 10 "subprojects/
 vm-memory: Patch vm-memory for QEMU memory".)

As a minimum requirement, vm-memory still needs at least two changes:
 * the 0001.diff file under subprojects/packagefiles/vm-memory-0.16-rs:

   guest_memory: Add a marker tarit to implement Bytes<GuestAddress> for
   GuestMemory

   - This patch allows QEMU to customize its own Bytes trait
     implementation for FlatView, which makes it possible to have the
     memory write/read process in Rust similar to
     flatview_write/flatview_read in C side.

     So this patch is straightforward with low risk.

 * the 0002.diff file under subprojects/packagefiles/vm-memory-0.16-rs:

   guest_memory: Add is_write argument for GuestMemory::try_access()

   - This patch is related with how to extend vm-memory to support more
     complex cases.

     Paolo suggested to implement Bytes<(GuestAddress, MemTxAttrs)> for
     FlatView, but I found it's tricky since memory read/write will
     finally depend on GuestMemory::try_access() to do iteration. Then
     try_access() should konw more information.

     1) One option is like the 0002.diff, just to add more arguments,
        but this option is not very flexible. It is difficult to extend
        for MemTxAttrs because vm-memory does not have MemTxAttrs at all.
        (But perhaps vm-memory could support more memory attributes?)

     2) Another option is to move try_access() under Bytes trait, then
        try_access could accepts the tuple like (GuestAddress, MemTxAttrs)
        or (GuestAddress, bool, MemTxAttrs) - boolean is is_write. But
        my concern is I'm not sure whether it's proper to let Bytes have
        try_access() method, especially there's no other need expect
        GuestMemory.

   Therefore, this is the issue that blocks us to provide more flexible
   (or more complex) memory access interfaces at Rust side.


NEW QEMU memory bindings/APIs based on vm-memory at Rust side
=============================================================

At least, now we could have the safe bindings for the most basic (and
minimum) memory access in Rust side - no special memory attributs, and
only naive endian.

Speaking endian, this is another open issue. The current implementation
only supports native endian, i.e., endian that is consistent with the
target. Users can obtain the current endian and adjust it, for example,

```
use qemu_api::memory::{ADDRESS_SPACE_MEMORY, target_is_big_endian};

let addr = GuestAddress(0x123438000);
let val: u32 = 5;
let val_end = if target_is_big_endian() {
    val.to_be()
} else {
    val.to_le()
};

assert!(ADDRESS_SPACE_MEMORY.store(addr, val_end).is_ok());
```

It can work, But idealy, for Rust, type itself could tell enough
information.

But unfortunately, the Bytes::store/load accepts AtomicAccess, it doesn't
provide any information about endian (though vm-memory has other endian
type, e.g., Le32/be32).

For more endian support, I think there would be 2 options:
 1) Implement Bytes<(GuestAddress, bool, MemTxAttrs, DeviceEndian)>, and
    ask C side to handle endian issues.

 2) Consider to add endian information in AtomicAccess.
 
Option 1 seems easier, but option 2 seems more reasonable? Because only
the Bytes::store/load care about endian, and no other methods requires
it. Considering endian for the entire Bytes seems a bit overkill.


Open issues
===========

Alright, the open issues are talked in the above sections. But let me
make a summary:

* About how to support more MemTxAttrs, please see the section "Extra
  changes for vm-memory (downstream for now)".

* About how to support more endian formats, please see the section
  "NEW QEMU memory bindings/APIs based on vm-memory at Rust side".


Thanks and Best Regards,
Zhao
---
Zhao Liu (26):
  rust/hpet: Fix the error caused by vm-memory
  rust/cargo: Add the support for vm-memory
  subprojects: Add thiserror-impl crate
  subprojects: Add thiserror crate
  subprojects: Add winapi-i686-pc-windows-gnu crate
  subprojects: Add winapi-x86_64-pc-windows-gnu crate
  subprojects: Add winapi crate
  subprojects: Add vm-memory crate
  rust: Add vm-memory in meson
  subprojects/vm-memory: Patch vm-memory for QEMU memory backend
  rust/cargo: Specify the patched vm-memory crate
  rcu: Make rcu_read_lock & rcu_read_unlock not inline
  rust: Add RCU bindings
  memory: Expose interfaces about Flatview reference count to Rust side
  memory: Rename address_space_lookup_region and expose it to Rust side
  memory: Make flatview_do_translate() return a pointer to
    MemoryRegionSection
  memory: Add a translation helper to return MemoryRegionSection
  memory: Rename flatview_access_allowed() to
    memory_region_access_allowed()
  memory: Add MemoryRegionSection based misc helpers
  memory: Add wrappers of intermediate steps for read/write
  memory: Add store/load interfaces for Rust side
  rust/memory: Implement vm_memory::GuestMemoryRegion for
    MemoryRegionSection
  rust/memory: Implement vm_memory::GuestMemory for FlatView
  rust/memory: Provide AddressSpace bindings
  rust/memory: Add binding to check target endian
  rust/hpet: Use safe binding to access address space

 include/qemu/rcu.h                            |  45 +-
 include/system/memory.h                       | 313 +++++-
 rust/Cargo.lock                               |  51 +
 rust/Cargo.toml                               |   3 +
 rust/hw/timer/hpet/src/device.rs              |  29 +-
 rust/meson.build                              |   2 +
 rust/qemu-api/Cargo.toml                      |  11 +
 rust/qemu-api/meson.build                     |   5 +-
 rust/qemu-api/src/lib.rs                      |   1 +
 rust/qemu-api/src/memory.rs                   | 971 +++++++++++++++++-
 rust/qemu-api/src/rcu.rs                      |  26 +
 rust/qemu-api/wrapper.h                       |   2 +
 scripts/archive-source.sh                     |   4 +-
 scripts/make-release                          |   4 +-
 subprojects/.gitignore                        |   6 +
 .../packagefiles/thiserror-1-rs/meson.build   |  23 +
 .../thiserror-impl-1-rs/meson.build           |  41 +
 .../packagefiles/vm-memory-0.16-rs/0001.diff  |  81 ++
 .../packagefiles/vm-memory-0.16-rs/0002.diff  | 111 ++
 .../vm-memory-0.16-rs/meson.build             |  35 +
 .../packagefiles/winapi-0.3-rs/meson.build    |  46 +
 .../meson.build                               |  20 +
 .../meson.build                               |  20 +
 subprojects/thiserror-1-rs.wrap               |  10 +
 subprojects/thiserror-impl-1-rs.wrap          |  10 +
 subprojects/vm-memory-0.16-rs.wrap            |  14 +
 subprojects/winapi-0.3-rs.wrap                |  10 +
 .../winapi-i686-pc-windows-gnu-0.4-rs.wrap    |  10 +
 .../winapi-x86_64-pc-windows-gnu-0.4-rs.wrap  |  10 +
 system/memory-internal.h                      |   1 -
 system/memory.c                               |   7 +-
 system/physmem.c                              | 200 +++-
 util/rcu.c                                    |  43 +
 33 files changed, 2040 insertions(+), 125 deletions(-)
 create mode 100644 rust/qemu-api/src/rcu.rs
 create mode 100644 subprojects/packagefiles/thiserror-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/thiserror-impl-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
 create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/0002.diff
 create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/meson.build
 create mode 100644 subprojects/packagefiles/winapi-0.3-rs/meson.build
 create mode 100644 subprojects/packagefiles/winapi-i686-pc-windows-gnu-0.4-rs/meson.build
 create mode 100644 subprojects/packagefiles/winapi-x86_64-pc-windows-gnu-0.4-rs/meson.build
 create mode 100644 subprojects/thiserror-1-rs.wrap
 create mode 100644 subprojects/thiserror-impl-1-rs.wrap
 create mode 100644 subprojects/vm-memory-0.16-rs.wrap
 create mode 100644 subprojects/winapi-0.3-rs.wrap
 create mode 100644 subprojects/winapi-i686-pc-windows-gnu-0.4-rs.wrap
 create mode 100644 subprojects/winapi-x86_64-pc-windows-gnu-0.4-rs.wrap

-- 
2.34.1


