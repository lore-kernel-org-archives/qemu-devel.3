Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88A6CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJt-0006QU-TS; Tue, 26 Aug 2025 10:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJq-0006Px-F4
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJh-0007A4-9W
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvwCIrS0tHQ0/SPChJSCGSmNkNVeeZOxW+qU6kX3a0g=;
 b=IaD3Gm+QAx8mHkQgfp/rblrUkol2dhCwOGcAsjQLfJcxsU+sUFap8C4zc6nP9GXdxo+tYA
 +2Xr1EQO4ZZFtihWhpvCmq2tGTVRo2E4Cru2E4Oz2JHrBgjBkS29VCgtr3X4GtdyqmOISE
 +KsCjrEdS+QfKQzLkzqaWi3JF9IgCCA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-XURCNVWuNMqroGeKeYQe3g-1; Tue,
 26 Aug 2025 10:06:17 -0400
X-MC-Unique: XURCNVWuNMqroGeKeYQe3g-1
X-Mimecast-MFC-AGG-ID: XURCNVWuNMqroGeKeYQe3g_1756217169
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A63619560B6; Tue, 26 Aug 2025 14:06:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA41A19560AD; Tue, 26 Aug 2025 14:06:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 13/18] rust: split "hwcore" crate
Date: Tue, 26 Aug 2025 18:04:41 +0400
Message-ID: <20250826140449.4190022-14-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                               |  1 +
 rust/hw/core/wrapper.h                    | 32 ++++++++
 rust/qemu-api/wrapper.h                   |  6 --
 rust/Cargo.lock                           | 17 ++++
 rust/Cargo.toml                           |  1 +
 rust/hw/char/pl011/Cargo.toml             |  1 +
 rust/hw/char/pl011/meson.build            |  1 +
 rust/hw/char/pl011/src/device.rs          | 20 +++--
 rust/hw/core/Cargo.toml                   | 26 +++++++
 rust/hw/core/build.rs                     | 43 +++++++++++
 rust/hw/core/meson.build                  | 94 +++++++++++++++++++++++
 rust/hw/core/src/bindings.rs              | 41 ++++++++++
 rust/{qemu-api => hw/core}/src/irq.rs     |  0
 rust/hw/core/src/lib.rs                   | 12 +++
 rust/{qemu-api => hw/core}/src/qdev.rs    |  6 +-
 rust/{qemu-api => hw/core}/src/sysbus.rs  |  0
 rust/{qemu-api => hw/core}/tests/tests.rs | 20 ++---
 rust/hw/timer/hpet/Cargo.toml             |  1 +
 rust/hw/timer/hpet/meson.build            |  1 +
 rust/hw/timer/hpet/src/device.rs          | 22 +++---
 rust/meson.build                          |  1 +
 rust/qemu-api/Cargo.toml                  |  1 +
 rust/qemu-api/meson.build                 | 17 +---
 rust/qemu-api/src/bindings.rs             | 10 ---
 rust/qemu-api/src/lib.rs                  |  4 -
 rust/qemu-api/src/prelude.rs              |  4 -
 26 files changed, 305 insertions(+), 77 deletions(-)
 create mode 100644 rust/hw/core/wrapper.h
 create mode 100644 rust/hw/core/Cargo.toml
 create mode 100644 rust/hw/core/build.rs
 create mode 100644 rust/hw/core/meson.build
 create mode 100644 rust/hw/core/src/bindings.rs
 rename rust/{qemu-api => hw/core}/src/irq.rs (100%)
 create mode 100644 rust/hw/core/src/lib.rs
 rename rust/{qemu-api => hw/core}/src/qdev.rs (98%)
 rename rust/{qemu-api => hw/core}/src/sysbus.rs (100%)
 rename rust/{qemu-api => hw/core}/tests/tests.rs (89%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce8bb3c076..3f40a80240 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3513,6 +3513,7 @@ S: Maintained
 F: rust/bql/
 F: rust/chardev/
 F: rust/common/
+F: rust/hw/core/
 F: rust/migration/
 F: rust/qemu-api
 F: rust/qemu-api-macros
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
new file mode 100644
index 0000000000..3bdbd1249e
--- /dev/null
+++ b/rust/hw/core/wrapper.h
@@ -0,0 +1,32 @@
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
+#include "hw/sysbus.h"
+#include "hw/clock.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
+#include "hw/irq.h"
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 564733b903..7c9c20b14f 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -49,11 +49,5 @@ typedef enum memory_order {
 
 #include "qemu/osdep.h"
 #include "qemu-io.h"
-#include "hw/sysbus.h"
-#include "hw/clock.h"
-#include "hw/qdev-clock.h"
-#include "hw/qdev-properties.h"
-#include "hw/qdev-properties-system.h"
-#include "hw/irq.h"
 #include "exec/memattrs.h"
 #include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index e4946549c0..7ed22ca687 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -88,6 +88,7 @@ version = "0.1.0"
 dependencies = [
  "bql",
  "common",
+ "hwcore",
  "migration",
  "qemu_api",
  "qemu_api_macros",
@@ -96,6 +97,20 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "hwcore"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "chardev",
+ "common",
+ "migration",
+ "qemu_api_macros",
+ "qom",
+ "system",
+ "util",
+]
+
 [[package]]
 name = "itertools"
 version = "0.11.0"
@@ -130,6 +145,7 @@ dependencies = [
  "bql",
  "chardev",
  "common",
+ "hwcore",
  "migration",
  "qemu_api",
  "qemu_api_macros",
@@ -179,6 +195,7 @@ dependencies = [
  "chardev",
  "common",
  "foreign",
+ "hwcore",
  "libc",
  "migration",
  "qemu_api_macros",
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 1c18e69660..ca94d2cf40 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -9,6 +9,7 @@ members = [
     "qemu-api",
     "qom",
     "system",
+    "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index e4b1c3f1eb..830d88586b 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -23,6 +23,7 @@ migration = { path = "../../../migration" }
 qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
+hwcore = { path = "../../../hw/core" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 06ebaf7ab9..83030476de 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -16,6 +16,7 @@ _libpl011_rs = static_library(
     qom_rs,
     chardev_rs,
     system_rs,
+    hwcore_rs,
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5307ac480b..e0d89db28d 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -11,18 +11,16 @@
 use bql::BqlRefCell;
 use chardev::{CharBackend, Chardev, Event};
 use common::{static_assert, uninit_field_mut, Zeroable};
+use hwcore::{
+    bindings::{qdev_prop_bool, qdev_prop_chr},
+    declare_properties, define_property, vmstate_clock, Clock, ClockEvent, DeviceImpl,
+    DeviceMethods, DeviceState, IRQState, InterruptSource, Property, ResetType,
+    ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
+};
 use migration::{
     impl_vmstate_forward, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections,
     vmstate_unused, VMStateDescription,
 };
-use qemu_api::{
-    bindings::{qdev_prop_bool, qdev_prop_chr},
-    irq::{IRQState, InterruptSource},
-    prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    sysbus::{SysBusDevice, SysBusDeviceImpl},
-    vmstate_clock,
-};
 use qom::{
     qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods, ObjectType,
     Owned, ParentField, ParentInit,
@@ -786,16 +784,16 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     ..Zeroable::ZERO
 };
 
-qemu_api::declare_properties! {
+declare_properties! {
     PL011_PROPERTIES,
-    qemu_api::define_property!(
+    define_property!(
         c"chardev",
         PL011State,
         char_backend,
         unsafe { &qdev_prop_chr },
         CharBackend
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"migrate-clk",
         PL011State,
         migrate_clock,
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
new file mode 100644
index 0000000000..0b35380264
--- /dev/null
+++ b/rust/hw/core/Cargo.toml
@@ -0,0 +1,26 @@
+[package]
+name = "hwcore"
+version = "0.1.0"
+description = "Rust bindings for QEMU/hwcore"
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
+common = { path = "../../common" }
+bql = { path = "../../bql" }
+qom = { path = "../../qom" }
+chardev = { path = "../../chardev" }
+migration = { path = "../../migration" }
+system = { path = "../../system" }
+util = { path = "../../util" }
+qemu_api_macros = { path = "../../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/hw/core/build.rs b/rust/hw/core/build.rs
new file mode 100644
index 0000000000..3f8e1bff89
--- /dev/null
+++ b/rust/hw/core/build.rs
@@ -0,0 +1,43 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[cfg(unix)]
+use std::os::unix::fs::symlink as symlink_file;
+#[cfg(windows)]
+use std::os::windows::fs::symlink_file;
+use std::{env, fs::remove_file, io::Result, path::Path};
+
+fn main() -> Result<()> {
+    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
+        format!("{root}/rust/hw/core/bindings.inc.rs")
+    } else {
+        // Placing bindings.inc.rs in the source directory is supported
+        // but not documented or encouraged.
+        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+    };
+
+    let file = Path::new(&file);
+    if !Path::new(&file).exists() {
+        panic!(concat!(
+            "\n",
+            "    No generated C bindings found! Maybe you wanted one of\n",
+            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
+            "\n",
+            "    For other uses of `cargo`, start a subshell with\n",
+            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
+            "    the top of the build tree."
+        ));
+    }
+
+    let out_dir = env::var("OUT_DIR").unwrap();
+    let dest_path = format!("{out_dir}/bindings.inc.rs");
+    let dest_path = Path::new(&dest_path);
+    if dest_path.symlink_metadata().is_ok() {
+        remove_file(dest_path)?;
+    }
+    symlink_file(file, dest_path)?;
+
+    println!("cargo:rerun-if-changed=build.rs");
+    Ok(())
+}
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
new file mode 100644
index 0000000000..d390f2d665
--- /dev/null
+++ b/rust/hw/core/meson.build
@@ -0,0 +1,94 @@
+_hwcore_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+_hwcore_bindgen_args = []
+c_enums = [
+  'DeviceCategory',
+  'GpioPolarity',
+  'MachineInitPhase',
+  'ResetType',
+]
+foreach enum : c_enums
+  _hwcore_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+blocked_type = [
+  'Chardev',
+  'Error',
+  'ObjectClass',
+  'MemoryRegion',
+  'VMStateDescription',
+]
+foreach type: blocked_type
+  _hwcore_bindgen_args += ['--blocklist-type', type]
+endforeach
+
+c_bitfields = [
+  'ClockEvent',
+]
+foreach enum : c_bitfields
+  _hwcore_bindgen_args += ['--bitfield-enum', enum]
+endforeach
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_hwcore_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _hwcore_bindgen_args,
+)
+
+_hwcore_rs = static_library(
+  'hwcore',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/irq.rs',
+      'src/qdev.rs',
+      'src/sysbus.rs',
+    ],
+    {'.': _hwcore_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _hwcore_cfg,
+  dependencies: [qemu_api_macros, common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
+                 qom, hwcore, chardev, migration],
+)
+
+hwcore_rs = declare_dependency(link_with: [_hwcore_rs],
+  dependencies: [qom_rs, hwcore])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-hwcore-rs-doctests',
+     _hwcore_rs,
+     protocol: 'rust',
+     dependencies: hwcore_rs,
+     suite: ['doc', 'rust'])
+
+test('rust-hwcore-rs-integration',
+    executable(
+        'rust-hwcore-rs-integration',
+        files('tests/tests.rs'),
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_api_macros, util_rs]),
+    args: [
+        '--test', '--test-threads', '1',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
diff --git a/rust/hw/core/src/bindings.rs b/rust/hw/core/src/bindings.rs
new file mode 100644
index 0000000000..919c02b56a
--- /dev/null
+++ b/rust/hw/core/src/bindings.rs
@@ -0,0 +1,41 @@
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
+use chardev::bindings::Chardev;
+use common::Zeroable;
+use migration::bindings::VMStateDescription;
+use qom::bindings::ObjectClass;
+use system::bindings::MemoryRegion;
+use util::bindings::Error;
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+
+unsafe impl Send for TypeInfo {}
+unsafe impl Sync for TypeInfo {}
+
+unsafe impl Zeroable for Property__bindgen_ty_1 {}
+unsafe impl Zeroable for Property {}
diff --git a/rust/qemu-api/src/irq.rs b/rust/hw/core/src/irq.rs
similarity index 100%
rename from rust/qemu-api/src/irq.rs
rename to rust/hw/core/src/irq.rs
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
new file mode 100644
index 0000000000..c5c33f3dec
--- /dev/null
+++ b/rust/hw/core/src/lib.rs
@@ -0,0 +1,12 @@
+pub use qom;
+
+pub mod bindings;
+
+mod irq;
+pub use irq::*;
+
+mod qdev;
+pub use qdev::*;
+
+mod sysbus;
+pub use sysbus::*;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/hw/core/src/qdev.rs
similarity index 98%
rename from rust/qemu-api/src/qdev.rs
rename to rust/hw/core/src/qdev.rs
index 98d8593ca5..16a4769758 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -9,7 +9,6 @@
     ptr::NonNull,
 };
 
-pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use chardev::Chardev;
 use common::{callbacks::FnCall, Opaque};
 use migration::vmstate::VMStateDescription;
@@ -19,6 +18,7 @@
 };
 pub use util::{Error, Result};
 
+pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     irq::InterruptSource,
@@ -428,11 +428,11 @@ macro_rules! vmstate_clock {
                 ::common::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    ::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
+                    ::qom::Owned<$crate::Clock> $(, num = $num)?
                 );
                 ::std::mem::offset_of!($struct_name, $field_name)
             },
-            size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
+            size: ::core::mem::size_of::<*const $crate::Clock>(),
             flags: ::migration::VMStateFlags(
                 ::migration::VMStateFlags::VMS_STRUCT.0
                     | ::migration::VMStateFlags::VMS_POINTER.0,
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
similarity index 100%
rename from rust/qemu-api/src/sysbus.rs
rename to rust/hw/core/src/sysbus.rs
diff --git a/rust/qemu-api/tests/tests.rs b/rust/hw/core/tests/tests.rs
similarity index 89%
rename from rust/qemu-api/tests/tests.rs
rename to rust/hw/core/tests/tests.rs
index 821aabe831..f11c15ac62 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -6,21 +6,17 @@
 
 use bql::BqlCell;
 use common::Zeroable;
-use migration::VMStateDescription;
-use qemu_api::{
-    bindings::qdev_prop_bool,
-    declare_properties, define_property,
-    qdev::{DeviceClassExt, DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
-    sysbus::SysBusDevice,
+use hwcore::{
+    bindings::qdev_prop_bool, declare_properties, define_property, DeviceClassExt, DeviceImpl,
+    DeviceState, Property, ResettablePhasesImpl, SysBusDevice,
 };
+use migration::vmstate::VMStateDescription;
 use qom::{
-    Object, ObjectCast, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods, ObjectType,
-    ParentField,
+    qom_isa, Object, ObjectCast, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods,
+    ObjectType, ParentField,
 };
 use util::bindings::{module_call_init, module_init_type};
 
-mod vmstate_tests;
-
 // Test that macros can compile.
 pub static VMSTATE: VMStateDescription = VMStateDescription {
     name: c"name".as_ptr(),
@@ -35,7 +31,7 @@ pub struct DummyState {
     migrate_clock: bool,
 }
 
-qom::qom_isa!(DummyState: Object, DeviceState);
+qom_isa!(DummyState: Object, DeviceState);
 
 pub struct DummyClass {
     parent_class: <DeviceState as ObjectType>::Class,
@@ -86,7 +82,7 @@ pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
 
-qom::qom_isa!(DummyChildState: Object, DeviceState, DummyState);
+qom_isa!(DummyChildState: Object, DeviceState, DummyState);
 
 pub struct DummyChildClass {
     parent_class: <DummyState as ObjectType>::Class,
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index a95b1271c6..e28d66f645 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -19,6 +19,7 @@ qom = { path = "../../../qom" }
 system = { path = "../../../system" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
+hwcore = { path = "../../../hw/core" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 74cbe27df8..d65306c169 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -12,6 +12,7 @@ _libhpet_rs = static_library(
     qemu_api_macros,
     qom_rs,
     system_rs,
+    hwcore_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index f5cc4ee0ad..2ea101bb7f 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -12,17 +12,15 @@
 
 use bql::{BqlCell, BqlRefCell};
 use common::{bitops::IntegerExt, uninit_field_mut, Zeroable};
+use hwcore::{
+    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
+    declare_properties, define_property, DeviceImpl, DeviceMethods, DeviceState, InterruptSource,
+    Property, ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
+};
 use migration::{
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
     VMStateDescription, VMStateFieldHelper,
 };
-use qemu_api::{
-    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
-    irq::InterruptSource,
-    prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    sysbus::{SysBusDevice, SysBusDeviceImpl},
-};
 use qom::{qom_isa, Object, ObjectImpl, ObjectType, ParentField, ParentInit};
 use system::{
     bindings::{address_space_memory, address_space_stl_le, hwaddr},
@@ -900,9 +898,9 @@ impl ObjectImpl for HPETState {
 }
 
 // TODO: Make these properties user-configurable!
-qemu_api::declare_properties! {
+declare_properties! {
     HPET_PROPERTIES,
-    qemu_api::define_property!(
+    define_property!(
         c"timers",
         HPETState,
         num_timers,
@@ -910,7 +908,7 @@ impl ObjectImpl for HPETState {
         u8,
         default = HPET_MIN_TIMERS
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"msi",
         HPETState,
         flags,
@@ -919,7 +917,7 @@ impl ObjectImpl for HPETState {
         bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8,
         default = false,
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"hpet-intcap",
         HPETState,
         int_route_cap,
@@ -927,7 +925,7 @@ impl ObjectImpl for HPETState {
         u32,
         default = 0
     ),
-    qemu_api::define_property!(
+    define_property!(
         c"hpet-offset-saved",
         HPETState,
         hpet_offset_saved,
diff --git a/rust/meson.build b/rust/meson.build
index d8b71f5506..041b0a473e 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -31,6 +31,7 @@ subdir('bql')
 subdir('qom')
 subdir('system')
 subdir('chardev')
+subdir('hw/core')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 2429c4eb9f..9f216e45a6 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 chardev = { path = "../chardev" }
+hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 644ca44573..a4c90b2bf7 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -3,22 +3,12 @@ _qemu_api_cfg = run_command(rustc_args,
   capture: true, check: true).stdout().strip().splitlines()
 
 c_enums = [
-  'DeviceCategory',
-  'GpioPolarity',
-  'MachineInitPhase',
   'MemoryDeviceInfoKind',
-  'ResetType',
 ]
 _qemu_api_bindgen_args = []
 foreach enum : c_enums
   _qemu_api_bindgen_args += ['--rustified-enum', enum]
 endforeach
-c_bitfields = [
-  'ClockEvent',
-]
-foreach enum : c_bitfields
-  _qemu_api_bindgen_args += ['--bitfield-enum', enum]
-endforeach
 
 blocked_type = [
   'Chardev',
@@ -55,17 +45,14 @@ _qemu_api_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
-      'src/irq.rs',
       'src/prelude.rs',
-      'src/qdev.rs',
-      'src/sysbus.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs,
+  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs, hwcore_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -87,7 +74,7 @@ rust.doctest('rust-qemu-api-doctests',
 test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
-        files('tests/tests.rs', 'tests/vmstate_tests.rs'),
+        files('tests/vmstate_tests.rs'),
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 63b805c76e..9c863e9b5b 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,7 +21,6 @@
 //! `bindgen`-generated declarations.
 
 use chardev::bindings::Chardev;
-use common::Zeroable;
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
 use system::bindings::{device_endian, MemTxAttrs, MemoryRegion};
@@ -32,12 +31,3 @@
 
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
-
-unsafe impl Send for Property {}
-unsafe impl Sync for Property {}
-
-unsafe impl Send for TypeInfo {}
-unsafe impl Sync for TypeInfo {}
-
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::Property {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 38ff102b86..50fb2fa99d 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -12,7 +12,3 @@
 // for prelude-like modules
 #[rustfmt::skip]
 pub mod prelude;
-
-pub mod irq;
-pub mod qdev;
-pub mod sysbus;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 9e9d1c8247..8db56f9f81 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -3,7 +3,3 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! Commonly used traits and types for QEMU.
-
-pub use crate::qdev::DeviceMethods;
-
-pub use crate::sysbus::SysBusDeviceMethods;
-- 
2.50.1


