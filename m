Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580D6CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJu-0006R4-5z; Tue, 26 Aug 2025 10:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJr-0006Q9-T3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJn-0007Bs-Hd
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OV0h791og2qoAD0Epr7sODfDivVo0B6Xd6wCrSVJks=;
 b=eObdXm57cxlzoEFzxtwK7kNqyoViFfAR3vfMd3P6hMRIkzyP+I4j7Nd1HvRZwAsSpYaRBk
 HMk82dduTEcEdm4MngIy2nAbC9o4wDRgjMXyKyQ4s9LYy2v8IDRWH6CyBjsKjOjIIqFfUX
 iTZVynZ/aFqXc/sx/eTDytUfnXkHIKE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-w9XgFepQM0u4WVtWuU66cw-1; Tue,
 26 Aug 2025 10:06:26 -0400
X-MC-Unique: w9XgFepQM0u4WVtWuU66cw-1
X-Mimecast-MFC-AGG-ID: w9XgFepQM0u4WVtWuU66cw_1756217185
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5003E180029D; Tue, 26 Aug 2025 14:06:25 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13C081977686; Tue, 26 Aug 2025 14:06:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 16/18] rust/pl011: drop dependency on qemu_api
Date: Tue, 26 Aug 2025 18:04:44 +0400
Message-ID: <20250826140449.4190022-17-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/hw/char/pl011/wrapper.h       | 51 ++++++++++++++++++++++++++++++
 rust/Cargo.lock                    |  2 --
 rust/hw/char/pl011/Cargo.toml      |  1 -
 rust/hw/char/pl011/build.rs        | 43 +++++++++++++++++++++++++
 rust/hw/char/pl011/meson.build     | 27 ++++++++++++++--
 rust/hw/char/pl011/src/bindings.rs | 27 ++++++++++++++++
 rust/hw/char/pl011/src/device.rs   |  2 +-
 rust/hw/char/pl011/src/lib.rs      |  1 +
 8 files changed, 148 insertions(+), 6 deletions(-)
 create mode 100644 rust/hw/char/pl011/wrapper.h
 create mode 100644 rust/hw/char/pl011/build.rs
 create mode 100644 rust/hw/char/pl011/src/bindings.rs

diff --git a/rust/hw/char/pl011/wrapper.h b/rust/hw/char/pl011/wrapper.h
new file mode 100644
index 0000000000..87a5a589c8
--- /dev/null
+++ b/rust/hw/char/pl011/wrapper.h
@@ -0,0 +1,51 @@
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
+#include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 9bb2ab5bf6..1a9a36ecec 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -90,7 +90,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_api",
  "qemu_macros",
  "qom",
  "system",
@@ -147,7 +146,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_api",
  "qemu_macros",
  "qom",
  "system",
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 9e451fc0aa..285d25c217 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -24,7 +24,6 @@ qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
-qemu_api = { path = "../../../qemu-api" }
 qemu_macros = { path = "../../../qemu-macros" }
 
 [lints]
diff --git a/rust/hw/char/pl011/build.rs b/rust/hw/char/pl011/build.rs
new file mode 100644
index 0000000000..721bf2c457
--- /dev/null
+++ b/rust/hw/char/pl011/build.rs
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
+        format!("{root}/rust/hw/char/pl011/bindings.inc.rs")
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
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 7d90f2aad6..a14993f692 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -1,6 +1,30 @@
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_libpl011_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common,
+)
+
 _libpl011_rs = static_library(
   'pl011',
-  files('src/lib.rs'),
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/device.rs',
+      'src/registers.rs',
+    ],
+    {'.' : _libpl011_bindings_inc_rs},
+  ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
@@ -11,7 +35,6 @@ _libpl011_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_api,
     qemu_macros,
     qom_rs,
     chardev_rs,
diff --git a/rust/hw/char/pl011/src/bindings.rs b/rust/hw/char/pl011/src/bindings.rs
new file mode 100644
index 0000000000..bd5ea840cb
--- /dev/null
+++ b/rust/hw/char/pl011/src/bindings.rs
@@ -0,0 +1,27 @@
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
+//! `bindgen`-generated declarations.
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index caaa05c04c..c9f6087540 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -137,7 +137,7 @@ pub struct PL011State {
 // structs, so the size of the Rust version must not be any larger
 // than the size of the C one. If this assert triggers you need to
 // expand the padding_for_rust[] array in the C PL011State struct.
-static_assert!(size_of::<PL011State>() <= size_of::<qemu_api::bindings::PL011State>());
+static_assert!(size_of::<PL011State>() <= size_of::<crate::bindings::PL011State>());
 
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2b70d2ff56..0c19b708c0 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,6 +12,7 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
+mod bindings;
 mod device;
 mod registers;
 
-- 
2.50.1


