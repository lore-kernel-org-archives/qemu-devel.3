Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972BDC44503
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMwB-0004Rl-47; Wed, 08 Jul 2026 03:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvw-00043b-Lk; Wed, 08 Jul 2026 03:43:04 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMvu-0004ox-MJ; Wed, 08 Jul 2026 03:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496583; x=1815032583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W0Yo/PAidXNCh/t02WCIULdm+1D7XGMULjYWmJ+pn8k=;
 b=ailSzGr0meK+iLEQLcHgA6wzvI3aOwJyiD6sOtyxLlJRYUYnDF3yU+Oe
 XP6RYxIY50DmuKyqUGat+jDj6MPUpxhKsVZ2QbqKOvndNtr2rBku3VfPK
 NRiPx2uuTmJFTR5H4R23hmhjNutEY8HTj/Y8vTIRokY2HQ8/eJ9P2mBsN
 p7nZVsy/ToFTzegiw4mUiqk2BUPk2mzQ3scU4JIABX4ZtoGisHsBLp1Mj
 i8W/vLhznHlRjbqKjWwuYpQXOGZbdyc1K34PsU98p9hnagYbMRsYStVTx
 Kx8YYOMBGWjYXjj31UIYffjtgCOHb5o2D1ERdXs9OvC2AZMqVvNzwszz4 w==;
X-CSE-ConnectionGUID: 2+09BiJwSeOaJVg2BvTDsQ==
X-CSE-MsgGUID: 0MF5kwKJSpihxQQHA7sOgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343286"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343286"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:43:02 -0700
X-CSE-ConnectionGUID: GRxtV1fgTR2gpTNPi2/pRA==
X-CSE-MsgGUID: fU63z/x0R1mdKAUoY/bvnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251555961"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:42:57 -0700
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
Subject: [RFC v2 09/26] rust/util: Add RCU bindings
Date: Wed,  8 Jul 2026 16:10:35 +0800
Message-Id: <20260708081052.2276617-10-zhao1.liu@intel.com>
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

Add RCU bindings, including an RAII guard for rcu_read_lock() &
rcu_read_unlock(), and an RcuCell to model qatomic_rcu_read within an
RCU critical section.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Use RAII pattern to guard RCU locking.
 * New RcuCell to simplify RCU read in Rust.
---
 rust/hw/char/pl011/wrapper.h |   1 +
 rust/util/src/lib.rs         |   1 +
 rust/util/src/rcu.rs         | 137 +++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 rust/util/src/rcu.rs

diff --git a/rust/hw/char/pl011/wrapper.h b/rust/hw/char/pl011/wrapper.h
index 87a5a589c8ea..2f66683fcd10 100644
--- a/rust/hw/char/pl011/wrapper.h
+++ b/rust/hw/char/pl011/wrapper.h
@@ -49,3 +49,4 @@ typedef enum memory_order {
 
 #include "qemu/osdep.h"
 #include "hw/char/pl011.h"
+#include "qemu/rcu.h"
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
index 436c67e139ed..0736c1883dbf 100644
--- a/rust/util/src/lib.rs
+++ b/rust/util/src/lib.rs
@@ -5,6 +5,7 @@
 pub mod error;
 pub mod log;
 pub mod module;
+pub mod rcu;
 
 // preserve one-item-per-"use" syntax, it is clearer
 // for prelude-like modules
diff --git a/rust/util/src/rcu.rs b/rust/util/src/rcu.rs
new file mode 100644
index 000000000000..e233f9698bfd
--- /dev/null
+++ b/rust/util/src/rcu.rs
@@ -0,0 +1,137 @@
+// Copyright (C) 2026 Intel Corporation.
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for `rcu_read_lock` and `rcu_read_unlock`.
+//! More details about RCU in QEMU, please refer docs/devel/rcu.rst.
+
+use std::{
+    marker::PhantomData,
+    sync::atomic::{AtomicPtr, Ordering},
+};
+
+use crate::bindings;
+
+/// RAII guard for the RCU read side lock.  The lock is acquired on creation and
+/// released on drop.
+///
+/// This guard is not `Send` or `Sync`, so it cannot be moved to another thread
+/// or stored in a global variable.  This ensures the RCU read side lock to be
+/// held and unlocked in the same thread.  The guard is also not `Clone` or
+/// `Copy`, so it cannot be duplicated and this can avoid double-unlock, which
+/// would be a bug.
+///
+/// ```ignore
+/// let guard = RcuGuard::new();
+/// // do some RCU read-side work
+/// drop(guard); // releases the RCU read side lock
+/// ```
+pub struct RcuGuard {
+    _marker: PhantomData<*const ()>,
+}
+
+impl RcuGuard {
+    /// Acquires the RCU read side lock and returns a guard.
+    #[inline]
+    pub fn new() -> Self {
+        // SAFETY: An FFI call with no additional requirements.
+        unsafe {
+            bindings::rust_rcu_read_lock();
+        }
+        // INVARIANT: The RCU read side lock was just acquired above.
+        Self {
+            _marker: PhantomData,
+        }
+    }
+}
+
+impl Default for RcuGuard {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for RcuGuard {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: An FFI call with no additional requirements.
+        unsafe {
+            bindings::rust_rcu_read_unlock();
+        }
+    }
+}
+
+/// (Reader-side view of) an RCU-protected C pointer wrapper.
+///
+/// This wrapper expresses the RCU read semantics of the C side:
+///
+/// ```c
+/// rcu_read_lock();
+/// p = qatomic_rcu_read(&foo);
+/// /* do something with p. */
+/// rcu_read_unlock();
+/// ```
+///
+/// With this wrapper, the above code can be expressed as:
+///
+/// ```ignore
+/// // SAFETY: `foo_ptr` is a live RCU-protected pointer.
+/// let cell = unsafe { RcuCell::from_ptr(foo_ptr) };
+/// {
+///     let guard = RcuGuard::new();
+///     if let Some(p) = cell.get(&guard) {
+///         /* do something with p. */
+///     }
+/// } // `rcu_read_unlock()` runs here, when `guard` is dropped.
+/// ```
+///
+/// # Ordering vs. C's `qatomic_rcu_read`
+///
+/// C's `qatomic_rcu_read` compiles to `__ATOMIC_RELAXED` followed by
+/// `smp_read_barrier_depends()` (or `__ATOMIC_CONSUME` under TSAN).
+/// `smp_read_barrier_depends()` is a *compiler* barrier on all hosts QEMU
+/// supports (see [docs/devel/atomics.rst](../../docs/devel/atomics.rst)),
+/// providing dependency ordering.
+///
+/// Rust exposes neither `Ordering::Consume` nor a dependency-barrier
+/// primitive.  So there is no exact Rust equivalent of `qatomic_rcu_read`.
+/// Instead, use [`Ordering::Acquire`], the strictly stronger option:
+/// - `Acquire` is a correct upper bound: every ordering that C's
+///   `qatomic_rcu_read` guarantees is also guaranteed by `Acquire`, and it
+///   correctly pairs with the updater's `qatomic_rcu_set()` (a Release store).
+#[repr(transparent)]
+pub struct RcuCell<T> {
+    data: AtomicPtr<T>,
+}
+
+impl<T> RcuCell<T> {
+    /// Convert a C raw pointer to an [`RcuCell`] in place, without copying it.
+    ///
+    /// Note: copying the pointer first and then loading the copy would
+    /// synchronise with nothing: the `Ordering::Acquire` must be applied to
+    /// the original pointer to pair with `qatomic_rcu_set()`.
+    ///
+    /// # Safety
+    ///
+    /// `field` must point to a valid `*mut T` updated only with
+    /// `qatomic_rcu_set()`, and the `T` object pointed to by `*field` must
+    ///  remain valid during the RCU read-side critical section entered before
+    ///  calling `RcuCell<T>::get`.
+    pub unsafe fn from_ptr<'a>(field: *const *mut T) -> &'a Self {
+        // SAFETY: `RcuCell` is `repr(transparent)` over `AtomicPtr<T>`.
+        unsafe { &*(field.cast::<Self>()) }
+    }
+
+    /// An almost equivalent of `qatomic_rcu_read()`, but with
+    /// `Ordering::Acquire`.
+    #[inline]
+    fn raw_get(&self) -> *mut T {
+        self.data.load(Ordering::Acquire)
+    }
+
+    pub fn get<'g>(&self, _: &'g RcuGuard) -> Option<&'g T> {
+        // SAFETY: the reference is *shared*, which allows several readers
+        // to hold the RCU lock concurrently.
+        unsafe { self.raw_get().as_ref() }
+    }
+}
-- 
2.34.1


