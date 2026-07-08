Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD293C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxL-0007pj-Rb; Wed, 08 Jul 2026 03:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxI-0007SK-Un; Wed, 08 Jul 2026 03:44:29 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxE-0005Eb-6s; Wed, 08 Jul 2026 03:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496664; x=1815032664;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7pUu7lEsiV3/uTlM/f3KjTyEN0lQfwx/8ZOBtIu5tMM=;
 b=Sk7RsaMxADblWL8g/7QiXlqw4Me4zwFS6nc+rSD0ZtXU+c4lX/Oh2M/k
 21LqnP9QMN4nzzNMPBRBwsoByUzr4Z7lhO3I8W3u4WjAN5D0AlGxw83+p
 sfQ+lerBjT4sXTNfmGk5sBcBMiOKaajqOZ4hEE3MIw6Agy/ejLJ6piu0H
 n1ewG7AATvfOcHQ+niSgc/v1xgRrK4q3ArcEbP+3fam8AotridQjqnaCV
 PIL7c81ntEB9wY4lJxX5iLaWlzNoHB5fPBmvevJsWF6u9w1Kdhbr1inNb
 +bbP66cylhcgrzgXpbe6vlXXekUe74gjFRc3iJx4i3PFINZe+A4Q0wCHR A==;
X-CSE-ConnectionGUID: omR6aEq/RTOoyS3tJwF0jA==
X-CSE-MsgGUID: WxnmDCe8RQqD2I2mHDolkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343429"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343429"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:56 -0700
X-CSE-ConnectionGUID: 9g6IloLvQ/awONOMu95uDQ==
X-CSE-MsgGUID: xCAWjtLYR+KKTd6iJp1eqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556088"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:43:51 -0700
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
Subject: [RFC v2 22/26] rust/system/memory: Wrap vm-memory's endian types for
 explicit access
Date: Wed,  8 Jul 2026 16:10:48 +0800
Message-Id: <20260708081052.2276617-23-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
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

QEMU is getting rid of native endianness, so the load/store interfaces
should explicitly specify the target device's endianness.

vm-memory provides BeNN and LeNN types, but its Bytes trait uses the
AtomicAccess trait bound for its save/load methods. The explicit endian
wrappers do not implement this bound.

As the top-level interface, AddressSpace does not need to implement the
Bytes trait. It can simply take explicit endian types in its save/load
methods, convert them to a fixed-width AtomicAccess primitive, and
forward them to the underlying FlatView's Bytes::save and load.

Introduce the EndianValued trait to wrap vm-memory's endian types,
allowing interfaces that require explicit endianness to use it as a
trait bound.

Also, add a conversion method in EndianValued to get the fixed-width
AtomicAccess carrier, allowing higher-level interfaces to maintain
compatibility with Bytes::save/load internally.

Finally, implement the Sealed pattern for EndianValued to strictly limit
the supported types within the crate.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New commit to wrap BeNN and LeNN as an independent trait.
---
 rust/system/src/memory.rs | 94 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 2 deletions(-)

diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 12f48f71900b..b16e71ddbf4e 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -17,12 +17,12 @@
 
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 use qom::prelude::*;
-pub use vm_memory::GuestAddress;
 use vm_memory::{
-    bitmap::BS, Address, AtomicAccess, Bytes, GuestMemoryBackend, GuestMemoryError,
+    bitmap::BS, Address, AtomicAccess, ByteValued, Bytes, GuestMemoryBackend, GuestMemoryError,
     GuestMemoryRegion, GuestMemoryRegionBytes, GuestMemoryResult, GuestUsize, MemoryRegionAddress,
     Permissions, ReadVolatile, WriteVolatile,
 };
+pub use vm_memory::{Be16, Be32, Be64, GuestAddress, Le16, Le32, Le64};
 
 use crate::bindings::{
     self, address_space_lookup_section, device_endian, flatview_ref, flatview_translate_section,
@@ -1200,3 +1200,93 @@ fn clone(&self) -> Self {
         )
     }
 }
+
+/// Private module hosting the [`Sealed`](private::Sealed) supertrait of
+/// [`EndianValued`], keeping the set of [`EndianValued`] types closed to the
+/// ones listed below.
+///
+/// Reference: <https://rust-lang.github.io/api-guidelines/future-proofing.html#c-sealed>
+mod private {
+    pub trait Sealed {}
+}
+
+/// A sealed trait for types with an explicitly fixed byte order (e.g., `Le32`,
+/// `Be32`).
+///
+/// This ensures guest memory accesses via [`AddressSpace::store`] and
+/// [`AddressSpace::load`] are strictly independent of the host endianness.
+/// Types with implicit endianness (like bare u32 or [u8; 4]) are rejected.
+///
+/// Architecturally, this trait is designed for two purposes:
+///
+/// 1) Bypass the orphan rule: It acts as a local trait allowed to select
+///    specific `LeNN` and `BeNN` types from `vm-memory`'s [`ByteValued`],
+///    allowing a trait bound for the `AddressSpace` API.
+///
+/// 2) Enforce a closed set: Combined with the sealed mechanism, it prevents
+///    downstream crates (device or other crates) from implementing this trait.
+pub trait EndianValued: ByteValued + private::Sealed {
+    /// The same-width primitive integer used as the atomic carrier when an
+    /// explicit-endian access is passed to `Bytes::store`/`Bytes::load`.
+    type Carrier: AtomicAccess;
+
+    /// Convert `self` to [`Carrier`](Self::Carrier) integer, keeping the exact
+    /// bytes.
+    fn to_carrier(self) -> Self::Carrier;
+
+    /// Convert the [`Carrier`](Self::Carrier) integer back to this
+    /// fixed-endian type, keeping the exact bytes.
+    fn from_carrier(carrier: Self::Carrier) -> Self;
+}
+
+macro_rules! impl_endian_valued {
+    ($($t:ty => $carrier:ty),* $(,)?) => {
+        $(
+            impl private::Sealed for $t {}
+
+            impl EndianValued for $t {
+                type Carrier = $carrier;
+
+                #[inline(always)]
+                #[allow(clippy::useless_transmute)] // For i8 and u8
+                fn to_carrier(self) -> Self::Carrier {
+                    // SAFETY: The macro strictly pairs types of the exact same size.
+                    unsafe { std::mem::transmute(self) }
+                }
+
+                #[inline(always)]
+                #[allow(clippy::useless_transmute)] // For i8 and u8
+                fn from_carrier(carrier: Self::Carrier) -> Self {
+                    // SAFETY: The macro strictly pairs types of the exact same size.
+                    unsafe { std::mem::transmute(carrier) }
+                }
+            }
+        )*
+    };
+}
+
+// Explicit-endian wrappers (byte order fixed by the type) plus the single-byte
+// integers (which have no byte order at all).
+impl_endian_valued!(
+    Le16 => u16,
+    Le32 => u32,
+    Be16 => u16,
+    Be32 => u32,
+    u8 => u8,
+    i8 => i8,
+);
+
+// vm-memory only implements `AtomicAccess` for the 64-bit primitives on 64-bit
+// targets. Copy vm-memory's cfg here to avoid a mismatch between the two
+// traits.
+#[cfg(any(
+    target_arch = "x86_64",
+    target_arch = "aarch64",
+    target_arch = "powerpc64",
+    target_arch = "s390x",
+    target_arch = "riscv64"
+))]
+impl_endian_valued!(
+    Le64 => u64,
+    Be64 => u64,
+);
-- 
2.34.1


