Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B869CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDcs-0004ph-Dy; Wed, 27 Aug 2025 06:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDcp-0004k5-P4
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDck-00037w-Bb
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67HQqnP2opv/aXwsf95p/RgyTrHKiF4C47ubIzwJMl0=;
 b=LWpT9r3x/1TW+dA29sYh0FeeHRHNcfsyql6RtSDbxI7JyNvqyLk1GP9N46txk5mB3ziZlp
 hfK6eGnMm1IPcuSjin7MNYoGteUP5YOSYG/fMJ72hHpibihFBb7Nm2tcwEfjEu6T9HzB0G
 FCKZ+dkQiteVcqnPNDJu8RMiMS3JgBA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-j_Z-RIvMOUWcOenug5qLbA-1; Wed,
 27 Aug 2025 06:43:21 -0400
X-MC-Unique: j_Z-RIvMOUWcOenug5qLbA-1
X-Mimecast-MFC-AGG-ID: j_Z-RIvMOUWcOenug5qLbA_1756291400
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EA031800345; Wed, 27 Aug 2025 10:43:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED27B1955F24; Wed, 27 Aug 2025 10:43:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 11/22] rust: split "bql" crate
Date: Wed, 27 Aug 2025 14:41:33 +0400
Message-ID: <20250827104147.717203-12-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Unfortunately, an example had to be compile-time disabled, since it
relies on higher level crates (qdev, irq etc). The alternative is
probably to move that code to an example in qemu-api or elsewere and
make a link to it, or include_str.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                          |  1 +
 rust/bql/wrapper.h                   | 27 ++++++++
 rust/Cargo.lock                      | 10 +++
 rust/Cargo.toml                      |  1 +
 rust/bql/Cargo.toml                  | 23 +++++++
 rust/bql/build.rs                    |  1 +
 rust/bql/meson.build                 | 52 ++++++++++++++++
 rust/bql/src/bindings.rs             | 25 ++++++++
 rust/{qemu-api => bql}/src/cell.rs   | 92 ++++++++++------------------
 rust/bql/src/lib.rs                  | 29 +++++++++
 rust/common/src/opaque.rs            |  4 +-
 rust/hw/char/pl011/Cargo.toml        |  1 +
 rust/hw/char/pl011/meson.build       |  1 +
 rust/hw/char/pl011/src/device.rs     |  1 +
 rust/hw/timer/hpet/Cargo.toml        |  1 +
 rust/hw/timer/hpet/meson.build       |  1 +
 rust/hw/timer/hpet/src/device.rs     |  2 +-
 rust/hw/timer/hpet/src/fw_cfg.rs     |  5 +-
 rust/meson.build                     |  1 +
 rust/migration/src/vmstate.rs        |  4 +-
 rust/qemu-api/Cargo.toml             |  5 +-
 rust/qemu-api/meson.build            |  9 +--
 rust/qemu-api/src/chardev.rs         | 17 +++--
 rust/qemu-api/src/irq.rs             |  1 +
 rust/qemu-api/src/lib.rs             |  1 -
 rust/qemu-api/src/prelude.rs         |  3 -
 rust/qemu-api/src/qdev.rs            |  5 +-
 rust/qemu-api/src/qom.rs             | 13 ++--
 rust/qemu-api/src/sysbus.rs          | 13 ++--
 rust/qemu-api/tests/tests.rs         |  4 +-
 rust/qemu-api/tests/vmstate_tests.rs |  2 +-
 31 files changed, 244 insertions(+), 111 deletions(-)
 create mode 100644 rust/bql/wrapper.h
 create mode 100644 rust/bql/Cargo.toml
 create mode 120000 rust/bql/build.rs
 create mode 100644 rust/bql/meson.build
 create mode 100644 rust/bql/src/bindings.rs
 rename rust/{qemu-api => bql}/src/cell.rs (92%)
 create mode 100644 rust/bql/src/lib.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index bb4f5f011f..0b5f327d4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3510,6 +3510,7 @@ F: include/hw/registerfields.h
 Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
+F: rust/bql/
 F: rust/common/
 F: rust/migration/
 F: rust/qemu-api
diff --git a/rust/bql/wrapper.h b/rust/bql/wrapper.h
new file mode 100644
index 0000000000..2ef9a96e1d
--- /dev/null
+++ b/rust/bql/wrapper.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
+#include "qemu/osdep.h"
+
+#include "qemu/main-loop.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b3a810a653..2a73a0dd45 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -44,6 +44,13 @@ dependencies = [
  "qemu_api_macros",
 ]
 
+[[package]]
+name = "bql"
+version = "0.1.0"
+dependencies = [
+ "migration",
+]
+
 [[package]]
 name = "common"
 version = "0.1.0"
@@ -70,6 +77,7 @@ dependencies = [
 name = "hpet"
 version = "0.1.0"
 dependencies = [
+ "bql",
  "common",
  "migration",
  "qemu_api",
@@ -108,6 +116,7 @@ dependencies = [
  "bilge",
  "bilge-impl",
  "bits",
+ "bql",
  "common",
  "migration",
  "qemu_api",
@@ -152,6 +161,7 @@ name = "qemu_api"
 version = "0.1.0"
 dependencies = [
  "anyhow",
+ "bql",
  "common",
  "foreign",
  "libc",
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 0640a21580..73cb54f60b 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -2,6 +2,7 @@
 resolver = "2"
 members = [
     "bits",
+    "bql",
     "common",
     "migration",
     "qemu-api-macros",
diff --git a/rust/bql/Cargo.toml b/rust/bql/Cargo.toml
new file mode 100644
index 0000000000..1041bd4ea9
--- /dev/null
+++ b/rust/bql/Cargo.toml
@@ -0,0 +1,23 @@
+[package]
+name = "bql"
+version = "0.1.0"
+description = "Rust bindings for QEMU/BQL"
+resolver = "2"
+publish = false
+
+authors.workspace = true
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+migration = { path = "../migration" }
+
+[features]
+default = ["debug_cell"]
+debug_cell = []
+
+[lints]
+workspace = true
diff --git a/rust/bql/build.rs b/rust/bql/build.rs
new file mode 120000
index 0000000000..71a3167885
--- /dev/null
+++ b/rust/bql/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
new file mode 100644
index 0000000000..465774a5b2
--- /dev/null
+++ b/rust/bql/meson.build
@@ -0,0 +1,52 @@
+_bql_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+if get_option('debug_mutex')
+  _bql_cfg += ['--cfg', 'feature="debug_cell"']
+endif
+
+#
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_bql_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common,
+)
+
+_bql_rs = static_library(
+  'bql',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/cell.rs',
+    ],
+    {'.': _bql_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _bql_cfg,
+  dependencies: [migration_rs, qemuutil_rs],
+)
+
+bql_rs = declare_dependency(link_with: [_bql_rs],
+  dependencies: [qemuutil_rs])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-bql-rs-doctests',
+     _bql_rs,
+     protocol: 'rust',
+     dependencies: bql_rs,
+     suite: ['doc', 'rust'])
diff --git a/rust/bql/src/bindings.rs b/rust/bql/src/bindings.rs
new file mode 100644
index 0000000000..9ffff12cde
--- /dev/null
+++ b/rust/bql/src/bindings.rs
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/qemu-api/src/cell.rs b/rust/bql/src/cell.rs
similarity index 92%
rename from rust/qemu-api/src/cell.rs
rename to rust/bql/src/cell.rs
index 70cee2ca7a..43109130c5 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -75,9 +75,10 @@
 //!
 //! ### Example
 //!
-//! ```
+//! ```ignore
+//! # use bql::BqlRefCell;
 //! # use qemu_api::prelude::*;
-//! # use qemu_api::{cell::BqlRefCell, irq::InterruptSource, irq::IRQState};
+//! # use qemu_api::{irq::InterruptSource, irq::IRQState};
 //! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
 //! # const N_GPIOS: usize = 8;
 //! # struct PL061Registers { /* ... */ }
@@ -141,7 +142,6 @@
 //! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::borrow),
 //! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut).  The
 //! thread will panic if these rules are violated or if the BQL is not held.
-
 use std::{
     cell::{Cell, UnsafeCell},
     cmp::Ordering,
@@ -154,30 +154,6 @@
 
 use migration::impl_vmstate_transparent;
 
-use crate::bindings;
-
-/// An internal function that is used by doctests.
-pub fn bql_start_test() {
-    // SAFETY: integration tests are run with --test-threads=1, while
-    // unit tests and doctests are not multithreaded and do not have
-    // any BQL-protected data.  Just set bql_locked to true.
-    unsafe {
-        bindings::rust_bql_mock_lock();
-    }
-}
-
-pub fn bql_locked() -> bool {
-    // SAFETY: the function does nothing but return a thread-local bool
-    unsafe { bindings::bql_locked() }
-}
-
-fn bql_block_unlock(increase: bool) {
-    // SAFETY: this only adjusts a counter
-    unsafe {
-        bindings::bql_block_unlock(increase);
-    }
-}
-
 /// A mutable memory location that is protected by the Big QEMU Lock.
 ///
 /// # Memory layout
@@ -256,8 +232,8 @@ impl<T> BqlCell<T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlCell::new(5);
     /// ```
@@ -273,8 +249,8 @@ pub const fn new(value: T) -> BqlCell<T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlCell::new(5);
     ///
@@ -291,8 +267,8 @@ pub fn set(&self, val: T) {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let cell = BqlCell::new(5);
     /// assert_eq!(cell.get(), 5);
@@ -301,7 +277,7 @@ pub fn set(&self, val: T) {
     /// ```
     #[inline]
     pub fn replace(&self, val: T) -> T {
-        assert!(bql_locked());
+        assert!(crate::is_locked());
         // SAFETY: This can cause data races if called from multiple threads,
         // but it won't happen as long as C code accesses the value
         // under BQL protection only.
@@ -313,8 +289,8 @@ pub fn replace(&self, val: T) -> T {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlCell::new(5);
     /// let five = c.into_inner();
@@ -322,7 +298,7 @@ pub fn replace(&self, val: T) -> T {
     /// assert_eq!(five, 5);
     /// ```
     pub fn into_inner(self) -> T {
-        assert!(bql_locked());
+        assert!(crate::is_locked());
         self.value.into_inner()
     }
 }
@@ -333,8 +309,8 @@ impl<T: Copy> BqlCell<T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlCell::new(5);
     ///
@@ -342,7 +318,7 @@ impl<T: Copy> BqlCell<T> {
     /// ```
     #[inline]
     pub fn get(&self) -> T {
-        assert!(bql_locked());
+        assert!(crate::is_locked());
         // SAFETY: This can cause data races if called from multiple threads,
         // but it won't happen as long as C code accesses the value
         // under BQL protection only.
@@ -356,8 +332,8 @@ impl<T> BqlCell<T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlCell::new(5);
     ///
@@ -375,8 +351,8 @@ impl<T: Default> BqlCell<T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlCell::new(5);
     /// let five = c.take();
@@ -445,7 +421,7 @@ impl<T> BqlRefCell<T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlRefCell;
+    /// use bql::BqlRefCell;
     ///
     /// let c = BqlRefCell::new(5);
     /// ```
@@ -504,8 +480,8 @@ fn panic_already_borrowed(&self) -> ! {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlRefCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlRefCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlRefCell::new(5);
     ///
@@ -516,8 +492,8 @@ fn panic_already_borrowed(&self) -> ! {
     /// An example of panic:
     ///
     /// ```should_panic
-    /// use qemu_api::cell::BqlRefCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlRefCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlRefCell::new(5);
     ///
@@ -534,7 +510,7 @@ pub fn borrow(&self) -> BqlRef<'_, T> {
                 self.borrowed_at.set(Some(std::panic::Location::caller()));
             }
 
-            bql_block_unlock(true);
+            crate::block_unlock(true);
 
             // SAFETY: `BorrowRef` ensures that there is only immutable access
             // to the value while borrowed.
@@ -558,8 +534,8 @@ pub fn borrow(&self) -> BqlRef<'_, T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlRefCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlRefCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlRefCell::new("hello".to_owned());
     ///
@@ -571,8 +547,8 @@ pub fn borrow(&self) -> BqlRef<'_, T> {
     /// An example of panic:
     ///
     /// ```should_panic
-    /// use qemu_api::cell::BqlRefCell;
-    /// # qemu_api::cell::bql_start_test();
+    /// use bql::BqlRefCell;
+    /// # bql::start_test();
     ///
     /// let c = BqlRefCell::new(5);
     /// let m = c.borrow();
@@ -589,7 +565,7 @@ pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
             }
 
             // SAFETY: this only adjusts a counter
-            bql_block_unlock(true);
+            crate::block_unlock(true);
 
             // SAFETY: `BorrowRefMut` guarantees unique access.
             let value = unsafe { NonNull::new_unchecked(self.value.get()) };
@@ -608,7 +584,7 @@ pub fn borrow_mut(&self) -> BqlRefMut<'_, T> {
     /// # Examples
     ///
     /// ```
-    /// use qemu_api::cell::BqlRefCell;
+    /// use bql::BqlRefCell;
     ///
     /// let c = BqlRefCell::new(5);
     ///
@@ -733,7 +709,7 @@ fn drop(&mut self) {
         let borrow = self.borrow.get();
         debug_assert!(is_reading(borrow));
         self.borrow.set(borrow - 1);
-        bql_block_unlock(false)
+        crate::block_unlock(false)
     }
 }
 
@@ -823,7 +799,7 @@ fn drop(&mut self) {
         let borrow = self.borrow.get();
         debug_assert!(is_writing(borrow));
         self.borrow.set(borrow + 1);
-        bql_block_unlock(false)
+        crate::block_unlock(false)
     }
 }
 
diff --git a/rust/bql/src/lib.rs b/rust/bql/src/lib.rs
new file mode 100644
index 0000000000..ef08221e9c
--- /dev/null
+++ b/rust/bql/src/lib.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+mod bindings;
+use bindings::{bql_block_unlock, bql_locked, rust_bql_mock_lock};
+
+mod cell;
+pub use cell::*;
+
+/// An internal function that is used by doctests.
+pub fn start_test() {
+    // SAFETY: integration tests are run with --test-threads=1, while
+    // unit tests and doctests are not multithreaded and do not have
+    // any BQL-protected data.  Just set bql_locked to true.
+    unsafe {
+        rust_bql_mock_lock();
+    }
+}
+
+pub fn is_locked() -> bool {
+    // SAFETY: the function does nothing but return a thread-local bool
+    unsafe { bql_locked() }
+}
+
+pub fn block_unlock(increase: bool) {
+    // SAFETY: this only adjusts a counter
+    unsafe {
+        bql_block_unlock(increase);
+    }
+}
diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
index f96b91e25a..e076964634 100644
--- a/rust/common/src/opaque.rs
+++ b/rust/common/src/opaque.rs
@@ -69,8 +69,8 @@
 //! and only at FFI boundaries. For QEMU-specific types that need interior
 //! mutability, prefer [`BqlCell`] or [`BqlRefCell`].
 //!
-//! [`BqlCell`]: ../../qemu_api/cell/struct.BqlCell.html
-//! [`BqlRefCell`]: ../../qemu_api/cell/struct.BqlRefCell.html
+//! [`BqlCell`]: ../../bql/cell/struct.BqlCell.html
+//! [`BqlRefCell`]: ../../bql/cell/struct.BqlRefCell.html
 use std::{cell::UnsafeCell, fmt, marker::PhantomPinned, mem::MaybeUninit, ptr::NonNull};
 
 /// Stores an opaque value that is shared with C code.
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 7fd7531823..1a1d4ba715 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -18,6 +18,7 @@ bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
 common = { path = "../../../common" }
 util = { path = "../../../util" }
+bql = { path = "../../../bql" }
 migration = { path = "../../../migration" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index e3ddd17351..7062497b7c 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -10,6 +10,7 @@ _libpl011_rs = static_library(
     common_rs,
     util_rs,
     migration_rs,
+    bql_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 904faa80a9..7cffb894a8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -8,6 +8,7 @@
     ptr::NonNull,
 };
 
+use bql::BqlRefCell;
 use common::{static_assert, uninit_field_mut, Zeroable};
 use migration::{
     impl_vmstate_forward, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections,
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 70acdf03d6..9fcec38bfa 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 common = { path = "../../../common" }
 util = { path = "../../../util" }
 migration = { path = "../../../migration" }
+bql = { path = "../../../bql" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 2c605dcf9d..5e01e57210 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -7,6 +7,7 @@ _libhpet_rs = static_library(
     common_rs,
     util_rs,
     migration_rs,
+    bql_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 35b968cca7..c0e52ce415 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -10,6 +10,7 @@
     slice::from_ref,
 };
 
+use bql::{BqlCell, BqlRefCell};
 use common::{bitops::IntegerExt, uninit_field_mut, Zeroable};
 use migration::{
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
@@ -20,7 +21,6 @@
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
         qdev_prop_uint32, qdev_prop_usize,
     },
-    cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
     memory::{
         hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index 0605225fbb..e569b57b93 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -5,7 +5,6 @@
 use std::ptr::addr_of_mut;
 
 use common::Zeroable;
-use qemu_api::cell::bql_locked;
 
 /// Each `HPETState` represents a Event Timer Block. The v1 spec supports
 /// up to 8 blocks. QEMU only uses 1 block (in PC machine).
@@ -38,7 +37,7 @@ unsafe impl Zeroable for HPETFwConfig {}
 
 impl HPETFwConfig {
     pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
         let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
@@ -58,7 +57,7 @@ pub(crate) fn assign_hpet_id() -> Result<usize, &'static str> {
     }
 
     pub(crate) fn update_hpet_cfg(hpet_id: usize, timer_block_id: u32, address: u64) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
         let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
diff --git a/rust/meson.build b/rust/meson.build
index 826949b2e6..2ba1ea2280 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -27,6 +27,7 @@ subdir('qemu-api-macros')
 subdir('bits')
 subdir('util')
 subdir('migration')
+subdir('bql')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 4f95ab0d49..243f31baf6 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -198,8 +198,8 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// [`impl_vmstate_bitsized!`](crate::impl_vmstate_bitsized)
 /// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
 ///
-/// [`BqlCell`]: ../../qemu_api/cell/struct.BqlCell.html
-/// [`BqlRefCell`]: ../../qemu_api/cell/struct.BqlRefCell.html
+/// [`BqlCell`]: ../../bql/cell/struct.BqlCell.html
+/// [`BqlRefCell`]: ../../bql/cell/struct.BqlRefCell.html
 /// [`Owned`]: ../../qemu_api/qom/struct.Owned.html
 #[macro_export]
 macro_rules! vmstate_of {
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 4e44737843..8ba19baae8 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -17,14 +17,11 @@ rust-version.workspace = true
 common = { path = "../common" }
 migration = { path = "../migration" }
 util = { path = "../util" }
+bql = { path = "../bql" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 anyhow = "~1.0"
 libc.workspace = true
 foreign = "~0.3.1"
 
-[features]
-default = ["debug_cell"]
-debug_cell = []
-
 [lints]
 workspace = true
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index ee6311cd3f..dd829e3348 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -2,10 +2,6 @@ _qemu_api_cfg = run_command(rustc_args,
   '--config-headers', config_host_h, '--features', files('Cargo.toml'),
   capture: true, check: true).stdout().strip().splitlines()
 
-if get_option('debug_mutex')
-  _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
-endif
-
 c_enums = [
   'DeviceCategory',
   'GpioPolarity',
@@ -51,7 +47,6 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
-      'src/cell.rs',
       'src/chardev.rs',
       'src/irq.rs',
       'src/memory.rs',
@@ -65,7 +60,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs,
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -91,7 +86,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, util_rs, migration_rs, qemu_api]),
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qemu_api]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 4d42306b6c..c241b30b00 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -18,13 +18,10 @@
     slice,
 };
 
+use bql::{BqlRefCell, BqlRefMut};
 use common::{callbacks::FnCall, errno, Opaque};
 
-use crate::{
-    bindings,
-    cell::{BqlRefCell, BqlRefMut},
-    prelude::*,
-};
+use crate::{bindings, prelude::*};
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
@@ -44,13 +41,15 @@ pub struct CharBackend {
     _pin: PhantomPinned,
 }
 
-impl Write for BqlRefMut<'_, bindings::CharBackend> {
+pub struct CharBackendMut<'a>(BqlRefMut<'a, bindings::CharBackend>);
+
+impl Write for CharBackendMut<'_> {
     fn flush(&mut self) -> io::Result<()> {
         Ok(())
     }
 
     fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
-        let chr: &mut bindings::CharBackend = self;
+        let chr: &mut bindings::CharBackend = &mut self.0;
 
         let len = buf.len().try_into().unwrap();
         let r = unsafe { bindings::qemu_chr_fe_write(addr_of_mut!(*chr), buf.as_ptr(), len) };
@@ -58,7 +57,7 @@ fn write(&mut self, buf: &[u8]) -> io::Result<usize> {
     }
 
     fn write_all(&mut self, buf: &[u8]) -> io::Result<()> {
-        let chr: &mut bindings::CharBackend = self;
+        let chr: &mut bindings::CharBackend = &mut self.0;
 
         let len = buf.len().try_into().unwrap();
         let r = unsafe { bindings::qemu_chr_fe_write_all(addr_of_mut!(*chr), buf.as_ptr(), len) };
@@ -198,7 +197,7 @@ pub fn accept_input(&self) {
     /// the big QEMU lock while the character device is borrowed, as
     /// that might cause C code to write to the character device.
     pub fn borrow_mut(&self) -> impl Write + '_ {
-        self.inner.borrow_mut()
+        CharBackendMut(self.inner.borrow_mut())
     }
 
     /// Send a continuous stream of zero bits on the line if `enabled` is
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index ea6b32848c..3063fbe97a 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -10,6 +10,7 @@
     ptr,
 };
 
+use bql::BqlCell;
 use common::Opaque;
 
 use crate::{
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 52e4d5889b..37e6c21946 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -13,7 +13,6 @@
 #[rustfmt::skip]
 pub mod prelude;
 
-pub mod cell;
 pub mod chardev;
 pub mod irq;
 pub mod memory;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index c10c171158..9da7313016 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -4,9 +4,6 @@
 
 //! Commonly used traits and types for QEMU.
 
-pub use crate::cell::BqlCell;
-pub use crate::cell::BqlRefCell;
-
 pub use crate::qdev::DeviceMethods;
 
 pub use crate::qom::InterfaceType;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 15e1fdff96..6875c32be7 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -16,7 +16,6 @@
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
-    cell::bql_locked,
     chardev::Chardev,
     irq::InterruptSource,
     prelude::*,
@@ -275,7 +274,7 @@ fn do_init_clock_in(
             cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)>,
             events: ClockEvent,
         ) -> Owned<Clock> {
-            assert!(bql_locked());
+            assert!(bql::is_locked());
 
             // SAFETY: the clock is heap allocated, but qdev_init_clock_in()
             // does not gift the reference to its caller; so use Owned::from to
@@ -346,7 +345,7 @@ pub trait DeviceMethods: ObjectDeref
     Self::Target: IsA<DeviceState>,
 {
     fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         let c_propname = CString::new(propname).unwrap();
         let chr: &Chardev = chr;
         unsafe {
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 901445013c..e797958e4e 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -105,12 +105,9 @@
 use common::Opaque;
 use migration::impl_vmstate_pointer;
 
-use crate::{
-    bindings::{
-        self, object_class_dynamic_cast, object_dynamic_cast, object_get_class,
-        object_get_typename, object_new, object_ref, object_unref, TypeInfo,
-    },
-    cell::bql_locked,
+use crate::bindings::{
+    self, object_class_dynamic_cast, object_dynamic_cast, object_get_class, object_get_typename,
+    object_new, object_ref, object_unref, TypeInfo,
 };
 
 /// A safe wrapper around [`bindings::Object`].
@@ -873,7 +870,7 @@ impl<T: ObjectType> ObjectDeref for Owned<T> {}
 
 impl<T: ObjectType> Drop for Owned<T> {
     fn drop(&mut self) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         // SAFETY: creation method is unsafe, and whoever calls it has
         // responsibility that the pointer is valid, and remains valid
         // throughout the lifetime of the `Owned<T>` and its clones.
@@ -897,7 +894,7 @@ fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
 pub trait ObjectClassMethods: IsA<Object> {
     /// Return a new reference counted instance of this class
     fn new() -> Owned<Self> {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         // SAFETY: the object created by object_new is allocated on
         // the heap and has a reference count of 1
         unsafe {
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 2dbfc31dbd..b21883246e 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -11,7 +11,6 @@
 
 use crate::{
     bindings,
-    cell::bql_locked,
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
@@ -56,7 +55,7 @@ pub trait SysBusDeviceMethods: ObjectDeref
     /// region with a number that corresponds to the order of calls to
     /// `init_mmio`.
     fn init_mmio(&self, iomem: &MemoryRegion) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         unsafe {
             bindings::sysbus_init_mmio(self.upcast().as_mut_ptr(), iomem.as_mut_ptr());
         }
@@ -67,7 +66,7 @@ fn init_mmio(&self, iomem: &MemoryRegion) {
     /// whoever creates the sysbus device will refer to the interrupts with
     /// a number that corresponds to the order of calls to `init_irq`.
     fn init_irq(&self, irq: &InterruptSource) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         unsafe {
             bindings::sysbus_init_irq(self.upcast().as_mut_ptr(), irq.as_ptr());
         }
@@ -75,7 +74,7 @@ fn init_irq(&self, irq: &InterruptSource) {
 
     // TODO: do we want a type like GuestAddress here?
     fn mmio_addr(&self, id: u32) -> Option<u64> {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         // SAFETY: the BQL ensures that no one else writes to sbd.mmio[], and
         // the SysBusDevice must be initialized to get an IsA<SysBusDevice>.
         let sbd = unsafe { *self.upcast().as_ptr() };
@@ -89,7 +88,7 @@ fn mmio_addr(&self, id: u32) -> Option<u64> {
 
     // TODO: do we want a type like GuestAddress here?
     fn mmio_map(&self, id: u32, addr: u64) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         let id: i32 = id.try_into().unwrap();
         unsafe {
             bindings::sysbus_mmio_map(self.upcast().as_mut_ptr(), id, addr);
@@ -100,7 +99,7 @@ fn mmio_map(&self, id: u32, addr: u64) {
     // object_property_set_link) adds a reference to the IRQState,
     // which can prolong its life
     fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         let id: i32 = id.try_into().unwrap();
         let irq: &IRQState = irq;
         unsafe {
@@ -110,7 +109,7 @@ fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
 
     fn sysbus_realize(&self) {
         // TODO: return an Error
-        assert!(bql_locked());
+        assert!(bql::is_locked());
         unsafe {
             bindings::sysbus_realize(
                 self.upcast().as_mut_ptr(),
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 2ea4f88dd1..bc4bd320ce 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -4,11 +4,11 @@
 
 use std::{ffi::CStr, ptr::addr_of};
 
+use bql::BqlCell;
 use common::Zeroable;
 use migration::VMStateDescription;
 use qemu_api::{
     bindings::qdev_prop_bool,
-    cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
@@ -113,7 +113,7 @@ pub fn class_init<T: DeviceImpl>(self: &mut DummyChildClass) {
 fn init_qom() {
     static ONCE: BqlCell<bool> = BqlCell::new(false);
 
-    cell::bql_start_test();
+    bql::start_test();
     if !ONCE.get() {
         unsafe {
             module_call_init(module_init_type::MODULE_INIT_QOM);
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 3f64eb46c0..f808aed2c9 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -9,6 +9,7 @@
     slice,
 };
 
+use bql::BqlCell;
 use common::{Opaque, Zeroable};
 use migration::{
     bindings::{
@@ -19,7 +20,6 @@
     vmstate::{VMStateDescription, VMStateField, VMStateFieldHelper},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
 };
-use qemu_api::cell::BqlCell;
 
 const FOO_ARRAY_MAX: usize = 3;
 
-- 
2.50.1


