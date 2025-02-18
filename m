Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C0C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSD9-0005wJ-TG; Tue, 18 Feb 2025 13:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD4-0005ui-Lt
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSD0-0007XE-P6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4RdwkbVt1bZTxYqb4BjOlvmlhJ2aABh/0sXszIfnQY=;
 b=YbeAomHkiobg1u1T4sDeaFwfUoxY4+QdERI6pU2dvSU4om/SIyXRIcWGxogWGwaYiKSb+Q
 xj72BJjSp4YZybXwTZ9zZWdNtPNNQ5+aHChbaoveOchiFJfYWDQXz129PSNiAg16uww7po
 Nh5Ldjm6gE6Jw3156RkA3akWu12nezE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-LyF7ob_ZNU-CCp20mdJW_g-1; Tue,
 18 Feb 2025 13:20:32 -0500
X-MC-Unique: LyF7ob_ZNU-CCp20mdJW_g-1
X-Mimecast-MFC-AGG-ID: LyF7ob_ZNU-CCp20mdJW_g_1739902831
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C550D18D95F1; Tue, 18 Feb 2025 18:20:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0539E1800360; Tue, 18 Feb 2025 18:20:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 01/11] rust: Build separate qemu_api_tools and
 qemu_api_system
Date: Tue, 18 Feb 2025 19:20:09 +0100
Message-ID: <20250218182019.111467-2-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 rust/wrapper-system.h          | 46 ++++++++++++++++++++
 rust/wrapper.h                 | 11 -----
 meson.build                    | 11 ++++-
 rust/hw/char/pl011/meson.build |  3 +-
 rust/hw/timer/hpet/meson.build |  3 +-
 rust/meson.build               | 11 ++---
 rust/qemu-api/Cargo.toml       |  1 +
 rust/qemu-api/build.rs         | 10 ++++-
 rust/qemu-api/meson.build      | 79 +++++++++++++++++++++-------------
 rust/qemu-api/src/bindings.rs  | 52 ++++++++++++----------
 rust/qemu-api/src/lib.rs       |  5 +++
 rust/qemu-api/src/prelude.rs   |  3 ++
 rust/qemu-api/src/zeroable.rs  | 35 ++++++++-------
 13 files changed, 182 insertions(+), 88 deletions(-)
 create mode 100644 rust/wrapper-system.h

diff --git a/rust/wrapper-system.h b/rust/wrapper-system.h
new file mode 100644
index 0000000000..06f4c5279a
--- /dev/null
+++ b/rust/wrapper-system.h
@@ -0,0 +1,46 @@
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
+#include "exec/address-spaces.h"
+#include "exec/memattrs.h"
+#include "exec/memory.h"
+#include "hw/clock.h"
+#include "hw/irq.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "system/system.h"
diff --git a/rust/wrapper.h b/rust/wrapper.h
index d927ad6799..f203fd13ac 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -50,18 +50,7 @@ typedef enum memory_order {
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
-#include "exec/memattrs.h"
 #include "qemu/timer.h"
-#include "exec/address-spaces.h"
diff --git a/meson.build b/meson.build
index 8ed10b6624..6ee1757828 100644
--- a/meson.build
+++ b/meson.build
@@ -4102,10 +4102,17 @@ if have_rust
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
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index c2d7c0532c..94b256ae2f 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -4,9 +4,10 @@ _libhpet_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
-    qemu_api,
+    qemu_api_system,
     qemu_api_macros,
   ],
+  rust_dependency_map: {'qemu_api_system': 'qemu_api'},
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
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
index 57747bc934..bc0393add4 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -25,6 +25,7 @@ version_check = "~0.9"
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
index bcf1cf780f..e0a3052c79 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -12,44 +12,64 @@ if get_option('debug_mutex')
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
+  'src/chardev.rs',
+  'src/c_str.rs',
+  'src/errno.rs',
+  'src/module.rs',
+  'src/offset_of.rs',
+  'src/prelude.rs',
+  'src/qom.rs',
+  'src/timer.rs',
+  'src/zeroable.rs',
+]
+sources_system = sources_core + [
+  'src/irq.rs',
+  'src/memory.rs',
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
-      'src/chardev.rs',
-      'src/c_str.rs',
-      'src/errno.rs',
-      'src/irq.rs',
-      'src/memory.rs',
-      'src/module.rs',
-      'src/offset_of.rs',
-      'src/prelude.rs',
-      'src/qdev.rs',
-      'src/qom.rs',
-      'src/sysbus.rs',
-      'src/timer.rs',
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
   dependencies: libc_dep,
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
+  dependencies: libc_dep,
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
 
@@ -66,7 +86,8 @@ test('rust-qemu-api-integration',
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
index d2868639ff..d93848c80c 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -17,11 +17,15 @@
 
 //! `bindgen`-generated declarations.
 
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
 
 // SAFETY: these are implemented in C; the bindings need to assert that the
 // BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
@@ -49,29 +53,33 @@ unsafe impl Sync for ObjectClass {}
 unsafe impl Send for Object {}
 unsafe impl Sync for Object {}
 
-unsafe impl Send for SysBusDevice {}
-unsafe impl Sync for SysBusDevice {}
-
-// SAFETY: this is a pure data struct
-unsafe impl Send for CoalescedMemoryRange {}
-unsafe impl Sync for CoalescedMemoryRange {}
-
-// SAFETY: these are constants and vtables; the Send and Sync requirements
-// are deferred to the unsafe callbacks that they contain
-unsafe impl Send for MemoryRegionOps {}
-unsafe impl Sync for MemoryRegionOps {}
-
 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}
 
 unsafe impl Send for TypeInfo {}
 unsafe impl Sync for TypeInfo {}
 
-unsafe impl Send for VMStateDescription {}
-unsafe impl Sync for VMStateDescription {}
+#[cfg(feature="system")]
+mod system_impls {
+    use super::*;
+
+    unsafe impl Send for SysBusDevice {}
+    unsafe impl Sync for SysBusDevice {}
+
+    // SAFETY: this is a pure data struct
+    unsafe impl Send for CoalescedMemoryRange {}
+    unsafe impl Sync for CoalescedMemoryRange {}
+
+    // SAFETY: these are constants and vtables; the Send and Sync requirements
+    // are deferred to the unsafe callbacks that they contain
+    unsafe impl Send for MemoryRegionOps {}
+    unsafe impl Sync for MemoryRegionOps {}
+
+    unsafe impl Send for VMStateDescription {}
+    unsafe impl Sync for VMStateDescription {}
 
-unsafe impl Send for VMStateField {}
-unsafe impl Sync for VMStateField {}
+    unsafe impl Send for VMStateField {}
+    unsafe impl Sync for VMStateField {}
 
-unsafe impl Send for VMStateInfo {}
-unsafe impl Sync for VMStateInfo {}
+    unsafe impl Send for VMStateInfo {}
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 05f38b51d3..825443abde 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -20,14 +20,19 @@
 pub mod cell;
 pub mod chardev;
 pub mod errno;
+#[cfg(feature = "system")]
 pub mod irq;
+#[cfg(feature = "system")]
 pub mod memory;
 pub mod module;
 pub mod offset_of;
+#[cfg(feature = "system")]
 pub mod qdev;
 pub mod qom;
+#[cfg(feature = "system")]
 pub mod sysbus;
 pub mod timer;
+#[cfg(feature = "system")]
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 634acf37a8..94738869d1 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -11,6 +11,7 @@
 
 pub use crate::errno;
 
+#[cfg(feature="system")]
 pub use crate::qdev::DeviceMethods;
 
 pub use crate::qom::InterfaceType;
@@ -25,6 +26,8 @@
 
 pub use crate::qom_isa;
 
+#[cfg(feature="system")]
 pub use crate::sysbus::SysBusDeviceMethods;
 
+#[cfg(feature="system")]
 pub use crate::vmstate::VMState;
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 47b6977828..bec5093366 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -58,6 +58,7 @@ pub unsafe trait Zeroable: Default {
 /// ## Differences with `core::mem::zeroed`
 ///
 /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
+#[allow(unused)]
 #[macro_export]
 macro_rules! const_zero {
     // This macro to produce a type-generic zero constant is taken from the
@@ -80,6 +81,7 @@ union TypeAsBytes {
 }
 
 /// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
+#[allow(unused)]
 #[macro_export]
 macro_rules! impl_zeroable {
     ($type:ty) => {
@@ -89,20 +91,23 @@ unsafe impl $crate::zeroable::Zeroable for $type {
     };
 }
 
-// bindgen does not derive Default here
-#[allow(clippy::derivable_impls)]
-impl Default for crate::bindings::VMStateFlags {
-    fn default() -> Self {
-        Self(0)
+#[cfg(feature = "system")]
+mod system_impls {
+    // bindgen does not derive Default here
+    #[allow(clippy::derivable_impls)]
+    impl Default for crate::bindings::VMStateFlags {
+        fn default() -> Self {
+            Self(0)
+        }
     }
-}
 
-impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
-impl_zeroable!(crate::bindings::Property);
-impl_zeroable!(crate::bindings::VMStateFlags);
-impl_zeroable!(crate::bindings::VMStateField);
-impl_zeroable!(crate::bindings::VMStateDescription);
-impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
-impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
-impl_zeroable!(crate::bindings::MemoryRegionOps);
-impl_zeroable!(crate::bindings::MemTxAttrs);
+    impl_zeroable!(crate::bindings::Property__bindgen_ty_1);
+    impl_zeroable!(crate::bindings::Property);
+    impl_zeroable!(crate::bindings::VMStateFlags);
+    impl_zeroable!(crate::bindings::VMStateField);
+    impl_zeroable!(crate::bindings::VMStateDescription);
+    impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_1);
+    impl_zeroable!(crate::bindings::MemoryRegionOps__bindgen_ty_2);
+    impl_zeroable!(crate::bindings::MemoryRegionOps);
+    impl_zeroable!(crate::bindings::MemTxAttrs);
+}
-- 
2.48.1


