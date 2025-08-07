Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C40C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRs-0001Zi-Im; Thu, 07 Aug 2025 08:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRD-0007xZ-2A; Thu, 07 Aug 2025 08:09:41 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzR9-00058l-L4; Thu, 07 Aug 2025 08:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568576; x=1786104576;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IcxfGX15IY6iFsOKxfs10AFkyWYMXNZqJnwjVx46zZc=;
 b=f+BtDV4UTcs+iFp/3IsfJt6z9VQDjG/BapuICwVPVJ/Z8pnksyXLB1TJ
 q1mHNS1Wj1ga9/RjaElYP2m/zWO1HYst68pizeOhpuSo9HqXX09qRyoSH
 AbjrbKFrSM/pdo7Gbc6nX5tIDppWlQJ6FCvRkVr9UI99qLXwdZYWaxuII
 gFh0Cpq2z3EQjavjW40LUbsh882RqO3pWMCjESbtwDUxjJwhHXV04B+6z
 cLqKn03vuv+2RyjRv8cGlYiimw3teBr8uYsgJxnbM2vaNkXb/3q+3lDzh
 iQgljXj5o4QQXId6mAtFuwA6Hol9a3a/YKuPIOMbW8ZqyNGw0RImFSulw g==;
X-CSE-ConnectionGUID: gRCeL4+aQxW+I24AUM+GLA==
X-CSE-MsgGUID: 4IMNRqXOQyGiTtnwuMX0DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036785"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:34 -0700
X-CSE-ConnectionGUID: mvEPT2R8R6WHRfp7AlWChg==
X-CSE-MsgGUID: DlHmuEwnTeuxQDQ7EjUj4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701119"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:31 -0700
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
Subject: [RFC 10/26] subprojects/vm-memory: Patch vm-memory for QEMU memory
 backend
Date: Thu,  7 Aug 2025 20:30:11 +0800
Message-Id: <20250807123027.2910950-11-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
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

Add 2 patches to support QEMU memory backend implementation.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 .../packagefiles/vm-memory-0.16-rs/0001.diff  |  81 +++++++++++++
 .../packagefiles/vm-memory-0.16-rs/0002.diff  | 111 ++++++++++++++++++
 subprojects/vm-memory-0.16-rs.wrap            |   2 +
 3 files changed, 194 insertions(+)
 create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
 create mode 100644 subprojects/packagefiles/vm-memory-0.16-rs/0002.diff

diff --git a/subprojects/packagefiles/vm-memory-0.16-rs/0001.diff b/subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
new file mode 100644
index 000000000000..037193108d45
--- /dev/null
+++ b/subprojects/packagefiles/vm-memory-0.16-rs/0001.diff
@@ -0,0 +1,81 @@
+From 298f8ba019b2fe159fa943e0ae4dfd3c83ee64e0 Mon Sep 17 00:00:00 2001
+From: Zhao Liu <zhao1.liu@intel.com>
+Date: Wed, 6 Aug 2025 11:31:11 +0800
+Subject: [PATCH 1/2] guest_memory: Add a marker tarit to implement
+ Bytes<GuestAddress> for GuestMemory
+
+At present, Bytes<GuestAddress> is implemented as the blanet trait for
+all types which implemented GuestMemory.
+
+QEMU needs to customize its own Bytes<GuestAddress> implementation.
+
+So add a marker trait to still provide the default implementation for
+GuestRegionCollection and GuestMemoryMmap, and QEMU could have its own
+implementation.
+
+Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
+---
+ src/guest_memory.rs | 8 +++++++-
+ src/lib.rs          | 2 +-
+ src/region.rs       | 6 ++++--
+ 3 files changed, 12 insertions(+), 4 deletions(-)
+
+diff --git a/src/guest_memory.rs b/src/guest_memory.rs
+index 39e4f10a89d6..5b78038c3c92 100644
+--- a/src/guest_memory.rs
++++ b/src/guest_memory.rs
+@@ -457,7 +457,13 @@ pub trait GuestMemory {
+     }
+ }
+ 
+-impl<T: GuestMemory + ?Sized> Bytes<GuestAddress> for T {
++/// A marker trait that if implemented on a type `M` makes available a default
++/// implementation of `Bytes<GuestAddress>` for `M`, based on the assumption
++/// that the entire `GuestMemory` is just traditional Guest memory abstraction
++/// without any special access requirements.
++pub trait GuestMemoryBytes: GuestMemory {}
++
++impl<M: GuestMemoryBytes + ?Sized> Bytes<GuestAddress> for M {
+     type E = Error;
+ 
+     fn write(&self, buf: &[u8], addr: GuestAddress) -> Result<usize> {
+diff --git a/src/lib.rs b/src/lib.rs
+index 2f87f4c8482f..64ed3ec27a36 100644
+--- a/src/lib.rs
++++ b/src/lib.rs
+@@ -47,7 +47,7 @@ pub use endian::{Be16, Be32, Be64, BeSize, Le16, Le32, Le64, LeSize};
+ pub mod guest_memory;
+ pub use guest_memory::{
+     Error as GuestMemoryError, FileOffset, GuestAddress, GuestAddressSpace, GuestMemory,
+-    GuestUsize, MemoryRegionAddress, Result as GuestMemoryResult,
++    GuestMemoryBytes, GuestUsize, MemoryRegionAddress, Result as GuestMemoryResult,
+ };
+ 
+ pub mod region;
+diff --git a/src/region.rs b/src/region.rs
+index e716a6290e75..7114dfbe15a7 100644
+--- a/src/region.rs
++++ b/src/region.rs
+@@ -3,8 +3,8 @@
+ use crate::bitmap::{Bitmap, BS};
+ use crate::guest_memory::Result;
+ use crate::{
+-    Address, AtomicAccess, Bytes, FileOffset, GuestAddress, GuestMemory, GuestMemoryError,
+-    GuestUsize, MemoryRegionAddress, ReadVolatile, VolatileSlice, WriteVolatile,
++    Address, AtomicAccess, Bytes, FileOffset, GuestAddress, GuestMemory, GuestMemoryBytes,
++    GuestMemoryError, GuestUsize, MemoryRegionAddress, ReadVolatile, VolatileSlice, WriteVolatile,
+ };
+ use std::sync::atomic::Ordering;
+ use std::sync::Arc;
+@@ -322,6 +322,8 @@ impl<R: GuestMemoryRegion> GuestMemory for GuestRegionCollection<R> {
+     }
+ }
+ 
++impl<R: GuestMemoryRegion> GuestMemoryBytes for GuestRegionCollection<R> {}
++
+ /// A marker trait that if implemented on a type `R` makes available a default
+ /// implementation of `Bytes<MemoryRegionAddress>` for `R`, based on the assumption
+ /// that the entire `GuestMemoryRegion` is just traditional memory without any
+-- 
+2.34.1
+
diff --git a/subprojects/packagefiles/vm-memory-0.16-rs/0002.diff b/subprojects/packagefiles/vm-memory-0.16-rs/0002.diff
new file mode 100644
index 000000000000..bfef1bf1fee3
--- /dev/null
+++ b/subprojects/packagefiles/vm-memory-0.16-rs/0002.diff
@@ -0,0 +1,111 @@
+From 2af7ea12a589fde619690e5060c01710cb6f2e0e Mon Sep 17 00:00:00 2001
+From: Zhao Liu <zhao1.liu@intel.com>
+Date: Wed, 6 Aug 2025 14:27:14 +0800
+Subject: [PATCH 2/2] guest_memory: Add is_write argument for
+ GuestMemory::try_access()
+
+QEMU needs to know whether the memory access is for write or not, e.g.,
+memory region may be read-only, or iommu needs to distinguish write
+access.
+
+The alternative option is to move try_access() into Bytes trait, and
+implement Bytes<(GuestAddress, is_write)> for QEMU's GuestMemory
+abstraction. However, try_access() seems to lack generality in the
+abstraction of Bytes, as only GuestMemory needs it.
+
+Therefore, just add another argument in try_access() to help handle
+more complex memory backend.
+
+Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
+---
+ src/bitmap/mod.rs   | 17 +++++++++++------
+ src/guest_memory.rs | 10 ++++++----
+ 2 files changed, 17 insertions(+), 10 deletions(-)
+
+diff --git a/src/bitmap/mod.rs b/src/bitmap/mod.rs
+index cf1555b29350..de4203166304 100644
+--- a/src/bitmap/mod.rs
++++ b/src/bitmap/mod.rs
+@@ -287,12 +287,17 @@ pub(crate) mod tests {
+         // Finally, let's invoke the generic tests for `Bytes`.
+         let check_range_closure = |m: &M, start: usize, len: usize, clean: bool| -> bool {
+             let mut check_result = true;
+-            m.try_access(len, GuestAddress(start as u64), |_, size, reg_addr, reg| {
+-                if !check_range(&reg.bitmap(), reg_addr.0 as usize, size, clean) {
+-                    check_result = false;
+-                }
+-                Ok(size)
+-            })
++            m.try_access(
++                len,
++                GuestAddress(start as u64),
++                false,
++                |_, size, reg_addr, reg| {
++                    if !check_range(&reg.bitmap(), reg_addr.0 as usize, size, clean) {
++                        check_result = false;
++                    }
++                    Ok(size)
++                },
++            )
+             .unwrap();
+ 
+             check_result
+diff --git a/src/guest_memory.rs b/src/guest_memory.rs
+index 5b78038c3c92..53981c4e8e94 100644
+--- a/src/guest_memory.rs
++++ b/src/guest_memory.rs
+@@ -353,7 +353,7 @@ pub trait GuestMemory {
+ 
+     /// Check whether the range [base, base + len) is valid.
+     fn check_range(&self, base: GuestAddress, len: usize) -> bool {
+-        match self.try_access(len, base, |_, count, _, _| -> Result<usize> { Ok(count) }) {
++        match self.try_access(len, base, false, |_, count, _, _| -> Result<usize> { Ok(count) }) {
+             Ok(count) => count == len,
+             _ => false,
+         }
+@@ -374,7 +374,7 @@ pub trait GuestMemory {
+     /// - the error code returned by the callback 'f'
+     /// - the size of the already handled data when encountering the first hole
+     /// - the size of the already handled data when the whole range has been handled
+-    fn try_access<F>(&self, count: usize, addr: GuestAddress, mut f: F) -> Result<usize>
++    fn try_access<F>(&self, count: usize, addr: GuestAddress, _is_write: bool, mut f: F) -> Result<usize>
+     where
+         F: FnMut(usize, usize, MemoryRegionAddress, &Self::R) -> Result<usize>,
+     {
+@@ -470,6 +470,7 @@ impl<M: GuestMemoryBytes + ?Sized> Bytes<GuestAddress> for M {
+         self.try_access(
+             buf.len(),
+             addr,
++            true,
+             |offset, _count, caddr, region| -> Result<usize> {
+                 region.write(&buf[offset..], caddr)
+             },
+@@ -480,6 +481,7 @@ impl<M: GuestMemoryBytes + ?Sized> Bytes<GuestAddress> for M {
+         self.try_access(
+             buf.len(),
+             addr,
++            false,
+             |offset, _count, caddr, region| -> Result<usize> {
+                 region.read(&mut buf[offset..], caddr)
+             },
+@@ -547,7 +549,7 @@ impl<M: GuestMemoryBytes + ?Sized> Bytes<GuestAddress> for M {
+     where
+         F: ReadVolatile,
+     {
+-        self.try_access(count, addr, |_, len, caddr, region| -> Result<usize> {
++        self.try_access(count, addr, false, |_, len, caddr, region| -> Result<usize> {
+             region.read_volatile_from(caddr, src, len)
+         })
+     }
+@@ -575,7 +577,7 @@ impl<M: GuestMemoryBytes + ?Sized> Bytes<GuestAddress> for M {
+     where
+         F: WriteVolatile,
+     {
+-        self.try_access(count, addr, |_, len, caddr, region| -> Result<usize> {
++        self.try_access(count, addr, true, |_, len, caddr, region| -> Result<usize> {
+             // For a non-RAM region, reading could have side effects, so we
+             // must use write_all().
+             region.write_all_volatile_to(caddr, dst, len).map(|()| len)
+-- 
+2.34.1
+
diff --git a/subprojects/vm-memory-0.16-rs.wrap b/subprojects/vm-memory-0.16-rs.wrap
index a057c8c9efc1..592271300294 100644
--- a/subprojects/vm-memory-0.16-rs.wrap
+++ b/subprojects/vm-memory-0.16-rs.wrap
@@ -8,5 +8,7 @@ revision = 5eb996a060d7ca3844cbd2f10b1d048c0c91942f
 patch_directory = vm-memory-0.16-rs
 depth = 1
 
+diff_files = vm-memory-0.16-rs/0001.diff, vm-memory-0.16-rs/0002.diff
+
 # bump this version number on every change to meson.build or the patches:
 # v2
-- 
2.34.1


