Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC12BC021A2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thy3L-0007wy-2k; Tue, 11 Feb 2025 16:44:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3H-0007wA-9J
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thy3E-00057M-99
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739310255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fpWi6Lp+0idjuJpbly0bAmMnHVPZli1daAYI9ZCRM4=;
 b=ZD12PBkxpM6vhZFGNDWFOI04NZuhjsYLOZU3fg1Vfjq0AQAV0hn34PxU608LIWknX7WP0S
 uksPbaqgPrhJDVrnUaWtL5rtZaRA/Cl1HPPX0P5nwdCasi0y8EDlWcTeRDHyo0WXsCMoCQ
 2FiwkH87J6SNia0lOkvEkIAAjd4AriY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-oju8D7GoNEipsrnBma2jOg-1; Tue,
 11 Feb 2025 16:44:11 -0500
X-MC-Unique: oju8D7GoNEipsrnBma2jOg-1
X-Mimecast-MFC-AGG-ID: oju8D7GoNEipsrnBma2jOg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97EF7180087F; Tue, 11 Feb 2025 21:44:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.210])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F015195608D; Tue, 11 Feb 2025 21:44:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: [PATCH 01/11] rust: Build separate qemu_api_tools and qemu_api_system
Date: Tue, 11 Feb 2025 22:43:18 +0100
Message-ID: <20250211214328.640374-2-kwolf@redhat.com>
In-Reply-To: <20250211214328.640374-1-kwolf@redhat.com>
References: <20250211214328.640374-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The existing qemu_api library can't be linked into tools because it
contains a few bindings for things that only exist in the system
emulator.

This adds a new "system" feature to the qemu_api crate that enables the
system emulator parts in it, and build the crate twice: qemu_api_tools
is the core library that can be linked into tools, and qemu_api_system
is the full one for the system emulator.

Unfortunately, since library names have to be unique in meson, this
means that every user of the library now needs to specify a
rust_dependency_map to make either qemu_api_tools or qemu_api_system
show up as the qemu_api crate in Rust.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 rust/wrapper-system.h          | 44 +++++++++++++++++++++
 rust/wrapper.h                 |  9 -----
 meson.build                    | 11 +++++-
 rust/hw/char/pl011/meson.build |  3 +-
 rust/meson.build               | 11 +++---
 rust/qemu-api/Cargo.toml       |  1 +
 rust/qemu-api/build.rs         | 10 ++++-
 rust/qemu-api/meson.build      | 70 ++++++++++++++++++++++------------
 rust/qemu-api/src/bindings.rs  | 16 ++++++--
 rust/qemu-api/src/lib.rs       |  4 ++
 rust/qemu-api/src/prelude.rs   |  2 +
 rust/qemu-api/src/zeroable.rs  | 10 +++++
 12 files changed, 143 insertions(+), 48 deletions(-)
 create mode 100644 rust/wrapper-system.h

diff --git a/rust/wrapper-system.h b/rust/wrapper-system.h
new file mode 100644
index 0000000000..fc6c571e6d
--- /dev/null
+++ b/rust/wrapper-system.h
@@ -0,0 +1,44 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+/* The system emulator has all of the bindings tools have */
+#include "wrapper.h"
+
+#include "system/system.h"
+#include "hw/sysbus.h"
+#include "exec/memory.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
diff --git a/rust/wrapper.h b/rust/wrapper.h
index a9bc67af0d..41be87adcf 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -50,15 +50,6 @@ typedef enum memory_order {
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu-io.h"
-#include "system/system.h"
-#include "hw/sysbus.h"
-#include "exec/memory.h"
 #include "chardev/char-fe.h"
-#include "hw/clock.h"
-#include "hw/qdev-clock.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
-#include "hw/irq.h"
 #include "qapi/error.h"
-#include "migration/vmstate.h"
 #include "chardev/char-serial.h"
diff --git a/meson.build b/meson.build
index 18cf9e2913..1f26801b69 100644
--- a/meson.build
+++ b/meson.build
@@ -4094,10 +4094,17 @@ if have_rust
   # this case you must pass the path to `clang` and `libclang` to your build
   # command invocation using the environment variables CLANG_PATH and
   # LIBCLANG_PATH
-  bindings_rs = rust.bindgen(
+  bindings_rs_tools = rust.bindgen(
     input: 'rust/wrapper.h',
+    output: 'bindings_tools.inc.rs',
+    include_directories: include_directories('.', 'include'),
+    bindgen_version: ['>=0.60.0'],
+    args: bindgen_args,
+    )
+  bindings_rs_system = rust.bindgen(
+    input: 'rust/wrapper-system.h',
     dependencies: common_ss.all_dependencies(),
-    output: 'bindings.inc.rs',
+    output: 'bindings_system.inc.rs',
     include_directories: include_directories('.', 'include'),
     bindgen_version: ['>=0.60.0'],
     args: bindgen_args,
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 547cca5a96..d2cfede5dc 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -12,9 +12,10 @@ _libpl011_rs = static_library(
   dependencies: [
     bilge_dep,
     bilge_impl_dep,
-    qemu_api,
+    qemu_api_system,
     qemu_api_macros,
   ],
+  rust_dependency_map: {'qemu_api_system': 'qemu_api'},
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
diff --git a/rust/meson.build b/rust/meson.build
index 91e52b8fb8..50eb23b072 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -9,18 +9,19 @@ if cargo.found()
   run_target('clippy',
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
-              cargo, 'clippy', '--tests'],
-    depends: bindings_rs)
+              cargo, 'clippy', '--tests', '--features', 'system'],
+    depends: bindings_rs_system)
 
   run_target('rustfmt',
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
               cargo, 'fmt'],
-    depends: bindings_rs)
+    depends: bindings_rs_system)
 
   run_target('rustdoc',
     command: [config_host['MESON'], 'devenv',
               '--workdir', '@CURRENT_SOURCE_DIR@',
-              cargo, 'doc', '--no-deps', '--document-private-items'],
-    depends: bindings_rs)
+              cargo, 'doc', '--no-deps', '--document-private-items',
+              '--features', 'system'],
+    depends: bindings_rs_system)
 endif
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index a51dd14285..ed7b60bc80 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -24,6 +24,7 @@ version_check = "~0.9"
 default = ["debug_cell"]
 allocator = []
 debug_cell = []
+system= []
 
 [lints]
 workspace = true
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 471e6c633d..b14f9d4e4a 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -16,7 +16,13 @@ fn main() -> Result<()> {
     let path = env::var("MESON_BUILD_ROOT")
         .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
 
-    let file = format!("{}/bindings.inc.rs", path);
+    let basename = if cfg!(feature = "system") {
+        "bindings_system.inc.rs"
+    } else {
+        "bindings_tools.inc.rs"
+    };
+
+    let file = format!("{}/{}", path, basename);
     let file = Path::new(&file);
     if !Path::new(&file).exists() {
         panic!(concat!(
@@ -31,7 +37,7 @@ fn main() -> Result<()> {
     }
 
     let out_dir = env::var("OUT_DIR").unwrap();
-    let dest_path = format!("{}/bindings.inc.rs", out_dir);
+    let dest_path = format!("{}/{}", out_dir, basename);
     let dest_path = Path::new(&dest_path);
     if dest_path.symlink_metadata().is_ok() {
         remove_file(dest_path)?;
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 60944a657d..acac384936 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -10,39 +10,58 @@ if get_option('debug_mutex')
   _qemu_api_cfg += ['--cfg', 'feature="debug_cell"']
 endif
 
-_qemu_api_rs = static_library(
-  'qemu_api',
+sources_core = [
+  'src/lib.rs',
+  'src/assertions.rs',
+  'src/bindings.rs',
+  'src/bitops.rs',
+  'src/callbacks.rs',
+  'src/cell.rs',
+  'src/c_str.rs',
+  'src/module.rs',
+  'src/offset_of.rs',
+  'src/prelude.rs',
+  'src/qom.rs',
+  'src/zeroable.rs',
+]
+sources_system = sources_core + [
+  'src/irq.rs',
+  'src/qdev.rs',
+  'src/sysbus.rs',
+  'src/vmstate.rs',
+]
+
+
+_qemu_api_tools_rs = static_library(
+  'qemu_api_tools',
   structured_sources(
-    [
-      'src/lib.rs',
-      'src/assertions.rs',
-      'src/bindings.rs',
-      'src/bitops.rs',
-      'src/callbacks.rs',
-      'src/cell.rs',
-      'src/c_str.rs',
-      'src/irq.rs',
-      'src/module.rs',
-      'src/offset_of.rs',
-      'src/prelude.rs',
-      'src/qdev.rs',
-      'src/qom.rs',
-      'src/sysbus.rs',
-      'src/vmstate.rs',
-      'src/zeroable.rs',
-    ],
-    {'.' : bindings_rs},
+    sources_core,
+    {'.' : bindings_rs_tools},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
 )
+_qemu_api_system_rs = static_library(
+  'qemu_api_system',
+  structured_sources(
+    sources_system,
+    {'.' : bindings_rs_system},
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _qemu_api_cfg + ['--cfg', 'feature="system"'],
+)
 
-rust.test('rust-qemu-api-tests', _qemu_api_rs,
+rust.test('rust-qemu-api-tests', _qemu_api_system_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(
-  link_with: _qemu_api_rs,
+qemu_api_tools = declare_dependency(
+  link_with: _qemu_api_tools_rs,
+  dependencies: qemu_api_macros,
+)
+qemu_api_system = declare_dependency(
+  link_with: _qemu_api_system_rs,
   dependencies: qemu_api_macros,
 )
 
@@ -59,7 +78,8 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api, qemu_api_macros],
+        dependencies: [qemu_api_system, qemu_api_macros],
+        rust_dependency_map: {'qemu_api_system': 'qemu_api'},
         link_whole: [rust_qemu_api_objs, libqemuutil]),
     args: [
         '--test', '--test-threads', '1',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 8a9b821bb9..2bf6c13a32 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -15,15 +15,23 @@
     clippy::missing_safety_doc
 )]
 
-#[cfg(MESON)]
-include!("bindings.inc.rs");
+#[cfg(all(MESON, not(feature="system")))]
+include!("bindings_tools.inc.rs");
+#[cfg(all(MESON, feature="system"))]
+include!("bindings_system.inc.rs");
 
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+#[cfg(all(not(MESON), not(feature="system")))]
+include!(concat!(env!("OUT_DIR"), "/bindings_tools.inc.rs"));
+#[cfg(all(not(MESON), feature="system"))]
+include!(concat!(env!("OUT_DIR"), "/bindings_system.inc.rs"));
 
 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}
 unsafe impl Sync for TypeInfo {}
+
+#[cfg(feature="system")]
 unsafe impl Sync for VMStateDescription {}
+#[cfg(feature="system")]
 unsafe impl Sync for VMStateField {}
+#[cfg(feature="system")]
 unsafe impl Sync for VMStateInfo {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 3cf9371cff..3c6c154f3d 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -18,12 +18,16 @@
 pub mod c_str;
 pub mod callbacks;
 pub mod cell;
+#[cfg(feature = "system")]
 pub mod irq;
 pub mod module;
 pub mod offset_of;
+#[cfg(feature = "system")]
 pub mod qdev;
 pub mod qom;
+#[cfg(feature = "system")]
 pub mod sysbus;
+#[cfg(feature = "system")]
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 2dc86e19b2..1b8d7d319e 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -17,6 +17,8 @@
 
 pub use crate::qom_isa;
 
+#[cfg(feature="system")]
 pub use crate::sysbus::SysBusDeviceMethods;
 
+#[cfg(feature="system")]
 pub use crate::vmstate::VMState;
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 7b04947cb6..b454e9e05e 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -56,6 +56,7 @@ pub unsafe trait Zeroable: Default {
 /// ## Differences with `core::mem::zeroed`
 ///
 /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
+#[allow(unused)]
 macro_rules! const_zero {
     // This macro to produce a type-generic zero constant is taken from the
     // const_zero crate (v0.1.1):
@@ -77,6 +78,7 @@ union TypeAsBytes {
 }
 
 /// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
+#[allow(unused)]
 macro_rules! impl_zeroable {
     ($type:ty) => {
         unsafe impl Zeroable for $type {
@@ -86,6 +88,7 @@ unsafe impl Zeroable for $type {
 }
 
 // bindgen does not derive Default here
+#[cfg(feature = "system")]
 #[allow(clippy::derivable_impls)]
 impl Default for crate::bindings::VMStateFlags {
     fn default() -> Self {
@@ -93,10 +96,17 @@ fn default() -> Self {
     }
 }
 
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::Property);
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::VMStateFlags);
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::VMStateField);
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::VMStateDescription);
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
+#[cfg(feature = "system")]
 impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
-- 
2.48.1


