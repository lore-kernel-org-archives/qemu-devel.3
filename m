Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CC7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMvz-000454-Aj; Wed, 08 Jul 2026 03:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvV-0003pE-B1; Wed, 08 Jul 2026 03:42:37 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvP-0004QA-Qg; Wed, 08 Jul 2026 03:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496552; x=1815032552;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Zlj3EGiHa4LQ/4c5Z1D2L6tMR9/TmHa8dEZnSV/iQgo=;
 b=U5BM99KE7a1AgsOfg/y1IeFfa079wfWHtQ8GgGQu0yNDphW4CTiQ2kjX
 L5JJ1D75CjshtmBXqVdw6KJy2pwj3PLk/xlMlATYpnDu8f5zfvLOXE3bI
 jtCGa92vcNYAh7Op9/DCFHMtLf2idi9YUZ8IZFT8stre2XA4MfesR+I5O
 6JthiiwOlVcnqAPnwGYv+/x9ZuF/KALJfQUcqbG45YHC5zjnKn1SC2m3S
 Khzh0vk/8YGuRsREPGuFXZXbRLxniwJTSahef+L9CxDezQgtp3D3yy/pZ
 WKGHeOX5Y8ubPHbtJrv65UJNj+8/bibhi2m5xr2ridxR7iQHzn1viv1eP A==;
X-CSE-ConnectionGUID: JNaVo2txRAKR/y70M6o3cg==
X-CSE-MsgGUID: AS2zPVUzRfKjZipOncZg3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343168"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343168"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:42:26 -0700
X-CSE-ConnectionGUID: X35nGc+bT56GcSAlr2pS7w==
X-CSE-MsgGUID: Z6QXhVp7QXOMT4mmQwofSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555890"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:21 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 00/26] rust/memory: Integrate the vm-memory API from rust-vmm
Date: Wed,  8 Jul 2026 16:10:26 +0800
Message-Id: <20260708081052.2276617-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Compared to v1 [*], v2 has the following main changes:
 * Upgrade vm-memory to v0.18.0, and drop QEMU-specific patches in v1.
   - Thanks to Paolo and Hanna, the mian gaps identified in v1 have been
     largely resolved:
     1) Blanket Bytes<GuestAddress> trait for GuestMemory: done.
     2) Extend try_access: try_access has been deprecated, so that
        QEMU is free to decide ...
        
        ...whether to use a private try_access method (Patch 19):

        FlatView::try_access_full()

        ...or to switch to iterator (Patch 20):

        FlatViewChunk / FlatViewChunkIterator / FlatView::get_chunks()

 * Drop native endianness and require explicit endianness at
   AddressSpace::store and load.
   - EndianValued trait bound: Patch 22.

   And now we can have:
       ADDRESS_SPACE_MEMORY.store(GuestAddress(addr), Le32::from(val))

 * "Rich" expression in the Bytes trait:
   - impl Bytes<(MemoryRegionAddress, MemTxAttrs)> for MemoryRegionSection
   - impl Bytes<(GuestAddress, MemTxAttrs)> for FlatView

 * New RCU binding - Patch 9.
 * New HPET FSB test (to verify memory store).
   - the full test is a gap since it's no way to link physmem.c without
     a emulator.

Overall, there have been quite a few changes since v1. For more details,
please refer to the Changelog sction.

[*] RFC v1: https://lore.kernel.org/qemu-devel/20250807123027.2910950-1-zhao1.liu@intel.com/ 

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

This series tries to integrate vm-memory API for QEMU.

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

 * Critical wrappers for intermediate memroy read/write (they're still
   simple wrapper over C functions):
   - rust_section_read_continue_step
   - rust_section_write_continue_step

   With the above step helpers, Rust could build its own read/write
   loop (a simple loop or iteration with iterator).

 * And, special C helpers for memory load/store:
   - rust_section_load

   MemTxResult rust_section_load(MemoryRegionSection *section,
                                 hwaddr mr_offset, uint8_t *buf,
                                 MemTxAttrs attrs, hwaddr len);

   - rust_section_store

   MemTxResult rust_section_store(MemoryRegionSection *section,
                                  hwaddr mr_offset, const uint8_t *buf,
                                  MemTxAttrs attrs, hwaddr len);


   These 2 load/store helpers are so different:

   1) comparing with the detail implementations of
   address_space_ld{size}_{endian}/address_space_st{size}_{endian},
   these 2 functions aren't bound with specific type (l, q, or w), and
   transfer the value via byte array.

   This is because of the AtomicAccess bound in vm_memory::Bytes, which
   makes it difficult to convert AtomicAccess type to u64! (For more
   details, please refer the comments of Bytes::store/Bytes::load in
   patch 18 "rust/memory: Implement vm_memory::GuestMemoryRegion for
   MemoryRegionSection").

   2) these 2 helpers do not have "endian" suffix since the endianness
   is specified by Rust side entries (via EndianValued trait bound).
   And more importantly, Rust entries do not support native endianness.
   So as the intermediate bridge, these C helpers do not strictly
   enforce endianness; that task is left to Rust.

Of course, some other wrappers are also needed for FlatView and
AddressSpace:
 * For FlatView:
   - flatview_ref
   - flatview_translate_section
   - flatview_unref

 * For AddressSpace:
   - address_space_lookup_section
   - address_space_memory
   - address_space_get_flatview

They're all simple wrappers.


Endianness & Memory attributes
==============================

Rust side uses two different approaches to address the issues of
endianness and memory attributes support.

Endianness
----------

Rust side introduces EndianValued trait which packs endian types
from vm-memory: LeNN & BeNN.

Then the top-level entries could limit endianness for its argument
type. For example:

impl AddressSpace {
...

    pub fn store<T: EndianValued>(&self, addr: GuestAddress, val: T) -> Result<()> {}
    pub fn load<T: EndianValued>(&self, addr: GuestAddress) -> Result<T>{}

...
}

The above store and load methods only accetpt explicit endian types:
Le32 (little endian 32 bits), Be64 (big endian 64 bits), etc.

And they reject plain (without explicit endianness/depend on host
endianness) types: u32, u64.

The EndianValued trait bound in Rust serves the same purpose as the
"endian" suffixes in C-side functions (such as *_le and *_be).

Memory Attributes
-----------------

Unlike the default Bytes implementation in vm-memory, QEMU Rust
integrates MemAttrs into Bytes as well:

    impl Bytes<(MemoryRegionAddress, MemTxAttrs)> for MemoryRegionSection
    impl Bytes<(GuestAddress, MemTxAttrs)> for FlatView

so that all methods (write/read/store/load) under Bytes trait could
accept "(MemoryRegionAddress, MemTxAttrs)" as the parameter type, which
includes both address and MemTxAttrs information.


QEMU's FlatViewChunk vs vm-memory's VolatileSlice
=================================================

VolatileSlice of vm-memory cannot be applied to QEMU since it only
support RAM with host address pointer.

In RFC v1 (with vm-memory v0.16.0), there was no need to consider
such things in the first place.

However, vm-memory (v0.18.0) deprecated GestMemoryBackend::try_access()
and switched to using the iterator to implement memory access via
get_slices(), which is built on VolatileSlice and
GuestMemoryBackendSliceIterator.

QEMU has two options: either keep the try_access()-style loop, or
switch to its own get_slices()-style implementation.

For option #1, that's the patch 19, which has the try_access_full()
out of GestMemoryBackend trait and try_access_full() is a private/
inherent method of FlatView.

For option #2, patch 20 introduces FlatViewChunk (similar to
VolatileSlice), FlatViewChunkIterator (similar to
GuestMemoryBackendSliceIterator) and get_chunks() (simialr to
get_slices()).

Of these two options, option #1 is simpler, but option #2 demonstrates
QEMU's requirements for something similar to VolatileSlice, which is
insightful for considering higher-level slice/iterator abstractions
upstream.


NEW QEMU memory bindings/APIs based on vm-memory at Rust side
=============================================================

With all of the above are ready, now we could have the safe bindings for
the memory access in Rust side.

* write:

```
use system::memory::{GuestAddress, ADDRESS_SPACE_MEMORY};

let addr = GuestAddress(0x123123000);
let buf = [0x1, 0x2, 0x3, 0x4];
assert!(ADDRESS_SPACE_MEMORY.write(&buf, addr).is_ok());
```

* read:

```
use system::memory::{GuestAddress, ADDRESS_SPACE_MEMORY};

let addr = GuestAddress(0x123123000);
let mut buf = [0u8; 4];
assert!(ADDRESS_SPACE_MEMORY.read(&mut buf, addr).is_ok());
```

* load:

```
use system::memory::{GuestAddress, Le32, ADDRESS_SPACE_MEMORY};

let addr = GuestAddress(0x123123000);
assert!(ADDRESS_SPACE_MEMORY.load::<Le32>(addr).is_ok());
```

* store:

```
use system::memory::{GuestAddress, Le32, ADDRESS_SPACE_MEMORY};

let addr = GuestAddress(0x123123000);
assert!(ADDRESS_SPACE_MEMORY.store(addr, Le32::from(5)).is_ok());
```

Remaining Gap
=============

The full test is a gap since it's no way to link physmem.c without
a emulator at Rust side. Instead, provide a HPET FSB qtest case.


Change Log
==========
 * Use From instead of Into for u8->usize type conversion issue.
 * Upgrade vm-memory dependency to v0.18.0
 * Update Cargo.lock.
 * Drop windows dependencies for vm-memory.
 * Drop extra QEMU specific patches for vm-memory.
 * Add rust wrappers instead of dropping inline for C rcu read lock &
   unlock interfaces.
 * Include rcu.h in util-sys binding.
 * Use RAII pattern to guard RCU locking.
 * New RcuCell to simplify RCU read in Rust.
 * Do not expose address_space_to_flatview() to Rust anymore. Instead,
   implement address_space_get_flatview() at Rust side.
 * Drop section_get_host_addr().
 * Drop the native endian assumption and require the caller to use the
   target device's endianness.
 * Implement GuestMemoryRegionBytes for MemoryRegionSection to satisfy
   supertrait requirement.
 * Implement Bytes<(MemoryRegionAddress, MemTxAttrs)> to attach
   MemTxAttrs.
 * For write/read, add an extra loop to ensure write/read are actually
   finished within the same region.
 * Implement Bytes<(MemoryRegionAddress, MemTxAttrs)> to attach
   MemTxAttrs.
 * Move GuestMemoryBackend::try_access() to FlatView::try_access_full().
 * Use vm-memory::Permissions to replace is_write flag.
 * Implement get_chunks with iterator for memory access.
 * Implement EndianValued trait to bind top level store & load entries.
 * Implement GuestAddressSpace for &AddressSpace since it requires
   Clone for now.
 * Re-implement RCU protection logic by using RcuCell and lifetime
   to provide RCU critical section.
 * Fix AddressSapce::memory() and use a loop just like C side did.
 * Explicitly require AddressSpace::save and load specify endianness
   and no longer rely on native endianness.
 * Explicitly specify endianness by Le32 and get rid of native
   endianness.
 * Drop expect() method to avoid abort() on error - consistent with the
   behavior on the C side.
 * New HPET test case.

Thanks and Best Regards,
Zhao
---
Zhao Liu (26):
  rust/hpet: Fix the error caused by vm-memory
  rust/cargo: Add the support for vm-memory
  subprojects: Add thiserror-impl crate
  subprojects: Add thiserror crate
  subprojects: Add vm-memory crate
  rust: Add vm-memory in meson
  rcu: Add rust wrappers for rcu_read_lock & rcu_read_unlock
  rust/bindings/util-sys: Include rcu.h in bindings wrapper
  rust/util: Add RCU bindings
  memory: Expose FlatView refcount interfaces to Rust
  memory: Rename address_space_lookup_region and expose it to Rust
  memory: Make flatview_do_translate() return a pointer to
    MemoryRegionSection
  memory: Add a translation helper to return a MemoryRegionSection
  memory: Rename flatview_access_allowed() to
    memory_region_access_allowed()
  memory: Add MemoryRegionSection-based misc helpers
  memory: Add wrappers for intermediate read/write steps
  memory: Add store/load interfaces for Rust
  rust/system/memory: Implement vm_memory::GuestMemoryRegion for
    MemoryRegionSection
  rust/system/memory: Implement vm_memory::GuestMemory for FlatView
  rust/system/memory: Switch to iteration style for memory access
  rust/system/memory: Add an RAII guard to manage FlatView reference
    counts
  rust/system/memory: Wrap vm-memory's endian types for explicit access
  rust/memory: Provide AddressSpace bindings
  rust/hpet: Use safe binding to access address space
  hw/timer/hpet: Add HPET_TN_BASE macro
  tests/qtest: Add HPET test case to verify FSB store

 hw/timer/hpet.c                               |    8 +-
 include/hw/timer/hpet.h                       |    1 +
 include/qemu/rcu.h                            |   18 +
 include/system/memory.h                       |  273 +++-
 rust/Cargo.lock                               |   33 +-
 rust/Cargo.toml                               |    1 +
 rust/bindings/hwcore-sys/lib.rs               |    2 +-
 rust/bindings/system-sys/lib.rs               |    2 +-
 rust/bindings/util-sys/wrapper.h              |    1 +
 rust/hw/char/pl011/wrapper.h                  |    1 +
 rust/hw/timer/hpet/src/device.rs              |   31 +-
 rust/meson.build                              |    2 +
 rust/system/Cargo.toml                        |    1 +
 rust/system/meson.build                       |    2 +-
 rust/system/src/memory.rs                     | 1294 ++++++++++++++++-
 rust/util/src/lib.rs                          |    1 +
 rust/util/src/rcu.rs                          |  137 ++
 scripts/archive-source.sh                     |    3 +
 scripts/make-release                          |    3 +-
 subprojects/.gitignore                        |    3 +
 .../packagefiles/thiserror-1-rs/meson.build   |   23 +
 .../thiserror-impl-1-rs/meson.build           |   41 +
 .../vm-memory-0.18-rs/meson.build             |   27 +
 subprojects/thiserror-1-rs.wrap               |   10 +
 subprojects/thiserror-impl-1-rs.wrap          |   10 +
 subprojects/vm-memory-0.18-rs.wrap            |   10 +
 system/memory-internal.h                      |    1 -
 system/memory.c                               |    2 +-
 system/physmem.c                              |  203 ++-
 tests/qtest/hpet-test.c                       |   77 +
 tests/qtest/meson.build                       |    1 +
 util/rcu.c                                    |   10 +
 32 files changed, 2142 insertions(+), 90 deletions(-)
 create mode 100644 rust/util/src/rcu.rs
 create mode 100644 subprojects/packagefiles/thiserror-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/thiserror-impl-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/vm-memory-0.18-rs/meson.build
 create mode 100644 subprojects/thiserror-1-rs.wrap
 create mode 100644 subprojects/thiserror-impl-1-rs.wrap
 create mode 100644 subprojects/vm-memory-0.18-rs.wrap
 create mode 100644 tests/qtest/hpet-test.c

-- 
2.34.1


