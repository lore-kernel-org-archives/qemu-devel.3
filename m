Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B8CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPB-0004sX-47; Wed, 12 Nov 2025 23:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOr-0004k6-UG; Wed, 12 Nov 2025 23:57:41 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOm-0001c6-AL; Wed, 12 Nov 2025 23:57:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009852; x=1794545852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BGzL/4pIP4+T106T6tStBo67qOhw/L4y6OIvrc/vvFY=;
 b=lOkxp4hHNFeaVramEUa5VJ47CgEdR1j5/eR5jJh6sQLikWDHBj4IphqP
 qgbvdnz0CZeCN5eS5JIwxNMKmnwSZOprZah0+NX7byePXGMmxvMEPXI5T
 gzoNS9GvR9V5N9KBfXLZzJ7hdfYRc1wZKYhJEDrGFJl2l5ZUib8wLWsa9
 Pe+EL8BlIuXZqFsJeGJcLXD2mZdx+cOpQzOlUQ3EDxGLidurFWc+aopPN
 2VArK04cAGTut0siHrYjKtIO+Ml7wmoz++5Qz1hAWtJy6U0S26NQSgX24
 WOHOZeMuEUdnTFF8dwuLqdz0u9Ga3eE64sqcRBKMifv6TDqtkKVNssVIg Q==;
X-CSE-ConnectionGUID: vmH1b3amTCuj6y881fv2KQ==
X-CSE-MsgGUID: s8uaFfF8QFuP11ewR8PfEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682072"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:30 -0800
X-CSE-ConnectionGUID: RYWFGF5/SM6iumNqlmTupg==
X-CSE-MsgGUID: ZDRNeJ6ORBmxNtRq1phk3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663234"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:28 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 04/22] rust/bql: Add BqlGuard to provide BQL context
Date: Thu, 13 Nov 2025 13:19:19 +0800
Message-Id: <20251113051937.4017675-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113051937.4017675-1-zhao1.liu@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

There's some case requiring BQL context, for example, accessing
BqlCell/BqlRefCell or operation on IRQ in lockless IO.

Note though BqlCell/BqlRefCell ensures BQL won't be released during
reference exists, they don't create BQL context if BQL is not locked,
instead, they just assert and panic when BQL is not locked.

Therefore, it's necessary to provide a way to create BQL context by hand
at Rust side. BqlGuard is suitable for this need.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qemu/main-loop.h |  22 ++++++++-
 rust/bql/src/lib.rs      | 101 ++++++++++++++++++++++++++++++++++++++-
 stubs/iothread-lock.c    |  11 +++++
 system/cpus.c            |  10 ++++
 4 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index 0d55c636b21a..7dd7c8211f02 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -250,7 +250,7 @@ AioContext *iohandler_get_aio_context(void);
 /**
  * rust_bql_mock_lock:
  *
- * Called from Rust doctests to make bql_lock() return true.
+ * Called from Rust doctests to make bql_locked() return true.
  * Do not touch.
  */
 void rust_bql_mock_lock(void);
@@ -368,6 +368,16 @@ bool qemu_in_main_thread(void);
 #define bql_lock() bql_lock_impl(__FILE__, __LINE__)
 void bql_lock_impl(const char *file, int line);
 
+/**
+ * @rust_bql_lock: A wrapper over bql_lock().
+ *
+ * This function is used to allow bindgen to generate bql_lock()
+ * binding.
+ *
+ * Do not call this function directly! Use bql_lock() instead.
+ */
+void rust_bql_lock(void);
+
 /**
  * bql_unlock: Unlock the Big QEMU Lock (BQL).
  *
@@ -383,6 +393,16 @@ void bql_lock_impl(const char *file, int line);
  */
 void bql_unlock(void);
 
+/**
+ * @rust_bql_unlock: A wrapper over bql_unlock().
+ *
+ * This function is used to allow bindgen to generate bql_unlock()
+ * binding.
+ *
+ * Do not call this function directly! Use bql_unlock() instead.
+ */
+void rust_bql_unlock(void);
+
 /**
  * BQL_LOCK_GUARD
  *
diff --git a/rust/bql/src/lib.rs b/rust/bql/src/lib.rs
index ef08221e9c1a..48cc76a7557c 100644
--- a/rust/bql/src/lib.rs
+++ b/rust/bql/src/lib.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 mod bindings;
-use bindings::{bql_block_unlock, bql_locked, rust_bql_mock_lock};
+use bindings::{bql_block_unlock, bql_locked, rust_bql_lock, rust_bql_mock_lock, rust_bql_unlock};
 
 mod cell;
 pub use cell::*;
@@ -27,3 +27,102 @@ pub fn block_unlock(increase: bool) {
         bql_block_unlock(increase);
     }
 }
+
+// this function is private since user should get BQL context via BqlGuard.
+fn lock() {
+    // SAFETY: the function locks bql which lifetime is enough to cover
+    // the device's entire lifetime.
+    unsafe {
+        rust_bql_lock();
+    }
+}
+
+// this function is private since user should get BQL context via BqlGuard.
+fn unlock() {
+    // SAFETY: the function unlocks bql which lifetime is enough to
+    // cover the device's entire lifetime.
+    unsafe {
+        rust_bql_unlock();
+    }
+}
+
+/// An RAII guard to ensure a block of code runs within the BQL context.
+///
+/// It checks if the BQL is already locked at its creation:
+/// * If not, it locks the BQL and will release it when it is dropped.
+/// * If yes, it blocks BQL unlocking until its lifetime is end.
+#[must_use]
+pub struct BqlGuard {
+    locked: bool,
+}
+
+impl BqlGuard {
+    /// Creates a new `BqlGuard` to ensure BQL is locked during its
+    /// lifetime.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use bql::{BqlCell, BqlGuard};
+    ///
+    /// fn foo() {
+    ///     let _guard = BqlGuard::new(); // BQL is locked
+    ///
+    ///     let c = BqlCell::new(5);
+    ///     assert_eq!(c.get(), 5);
+    /// } // BQL could be unlocked
+    /// ```
+    pub fn new() -> Self {
+        if !is_locked() {
+            lock();
+            Self { locked: true }
+        } else {
+            block_unlock(true);
+            Self { locked: false }
+        }
+    }
+}
+
+impl Default for BqlGuard {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+impl Drop for BqlGuard {
+    fn drop(&mut self) {
+        if self.locked {
+            unlock();
+        } else {
+            block_unlock(false);
+        }
+    }
+}
+
+/// Executes a closure (function) within the BQL context.
+///
+/// This function creates a `BqlGuard`.
+///
+/// # Examples
+///
+/// ```should_panic
+/// use bql::{with_guard, BqlRefCell};
+///
+/// let c = BqlRefCell::new(5);
+///
+/// with_guard(|| {
+///     // BQL is locked
+///     let m = c.borrow();
+///
+///     assert_eq!(*m, 5);
+/// }); // BQL could be unlocked
+///
+/// let b = c.borrow(); // this causes a panic
+/// ```
+pub fn with_guard<F, R>(f: F) -> R
+where
+    F: FnOnce() -> R,
+{
+    let _guard = BqlGuard::new();
+    f()
+}
diff --git a/stubs/iothread-lock.c b/stubs/iothread-lock.c
index c89c9c7228f3..e2ebce565a06 100644
--- a/stubs/iothread-lock.c
+++ b/stubs/iothread-lock.c
@@ -23,6 +23,17 @@ void bql_unlock(void)
     assert(!bql_unlock_blocked);
 }
 
+void rust_bql_lock(void)
+{
+    rust_bql_mock_lock();
+}
+
+void rust_bql_unlock(void)
+{
+    bql_unlock();
+    bql_is_locked = false;
+}
+
 void bql_block_unlock(bool increase)
 {
     uint32_t new_value;
diff --git a/system/cpus.c b/system/cpus.c
index ef2d2f241faa..da31bda59444 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -578,6 +578,11 @@ void bql_lock_impl(const char *file, int line)
     bql_lock_fn(&bql, file, line);
 }
 
+void rust_bql_lock(void)
+{
+    bql_lock();
+}
+
 void bql_unlock(void)
 {
     g_assert(bql_locked());
@@ -585,6 +590,11 @@ void bql_unlock(void)
     qemu_mutex_unlock(&bql);
 }
 
+void rust_bql_unlock(void)
+{
+    bql_unlock();
+}
+
 void qemu_cond_wait_bql(QemuCond *cond)
 {
     qemu_cond_wait(cond, &bql);
-- 
2.34.1


