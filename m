Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53621CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDeh-0000J8-Hb; Wed, 27 Aug 2025 06:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDdq-0007gk-AL
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDdl-0003IG-6F
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M6aVwOOD9rEDAb5U2UJxaez6TBwK6aCM+bF7yD1pxos=;
 b=TekNx5UqY/J0vkVLhnq88OixPuJer2LhBHvV5lUUAIWk0SfF1yZi44ZqTGpg7v7Jg1ONvn
 FhJ7NaL3o3SrhcAsq1JBQDX5oRisGDBEcMzn+8+fDpPGumXPenxGp8P0dqHJGHpC8sZ+Ts
 qppAVwmwTdWoYxUEP+S/GVKCBdG5Ng8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-wlF9l4osOKuM9qom2jTDlg-1; Wed,
 27 Aug 2025 06:44:23 -0400
X-MC-Unique: wlF9l4osOKuM9qom2jTDlg-1
X-Mimecast-MFC-AGG-ID: wlF9l4osOKuM9qom2jTDlg_1756291462
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AA5E18004D4; Wed, 27 Aug 2025 10:44:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 387111800291; Wed, 27 Aug 2025 10:44:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 19/22] rust: repurpose qemu_api -> tests
Date: Wed, 27 Aug 2025 14:41:41 +0400
Message-ID: <20250827104147.717203-20-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The crate purpose is only to provide integration tests at this point,
that can't easily be moved to a specific crate.

It's also often a good practice to have a single integration test crate
(see for ex https://github.com/rust-lang/cargo/issues/4867)

Drop README.md, use docs/devel/rust.rst instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 rust/qemu-api/wrapper.h                       | 53 -----------
 rust/Cargo.lock                               | 36 ++++----
 rust/Cargo.toml                               |  2 +-
 rust/meson.build                              |  2 +-
 rust/qemu-api/.gitignore                      |  2 -
 rust/qemu-api/README.md                       | 19 ----
 rust/qemu-api/meson.build                     | 87 -------------------
 rust/qemu-api/src/bindings.rs                 | 33 -------
 rust/qemu-api/src/lib.rs                      | 14 ---
 rust/qemu-api/src/prelude.rs                  |  5 --
 rust/{qemu-api => tests}/Cargo.toml           |  7 +-
 rust/tests/meson.build                        | 14 +++
 .../tests/vmstate_tests.rs                    |  0
 14 files changed, 38 insertions(+), 238 deletions(-)
 delete mode 100644 rust/qemu-api/wrapper.h
 delete mode 100644 rust/qemu-api/.gitignore
 delete mode 100644 rust/qemu-api/README.md
 delete mode 100644 rust/qemu-api/meson.build
 delete mode 100644 rust/qemu-api/src/bindings.rs
 delete mode 100644 rust/qemu-api/src/lib.rs
 delete mode 100644 rust/qemu-api/src/prelude.rs
 rename rust/{qemu-api => tests}/Cargo.toml (80%)
 create mode 100644 rust/tests/meson.build
 rename rust/{qemu-api => tests}/tests/vmstate_tests.rs (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62790c7b5d..d978e41e08 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3515,11 +3515,11 @@ F: rust/chardev/
 F: rust/common/
 F: rust/hw/core/
 F: rust/migration/
-F: rust/qemu-api
 F: rust/qemu-macros/
 F: rust/qom/
 F: rust/rustfmt.toml
 F: rust/system/
+F: rust/tests/
 F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
 
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
deleted file mode 100644
index 7c9c20b14f..0000000000
--- a/rust/qemu-api/wrapper.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/*
- * QEMU System Emulator
- *
- * Copyright (c) 2024 Linaro Ltd.
- *
- * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-
-/*
- * This header file is meant to be used as input to the `bindgen` application
- * in order to generate C FFI compatible Rust bindings.
- */
-
-#ifndef __CLANG_STDATOMIC_H
-#define __CLANG_STDATOMIC_H
-/*
- * Fix potential missing stdatomic.h error in case bindgen does not insert the
- * correct libclang header paths on its own. We do not use stdatomic.h symbols
- * in QEMU code, so it's fine to declare dummy types instead.
- */
-typedef enum memory_order {
-  memory_order_relaxed,
-  memory_order_consume,
-  memory_order_acquire,
-  memory_order_release,
-  memory_order_acq_rel,
-  memory_order_seq_cst,
-} memory_order;
-#endif /* __CLANG_STDATOMIC_H */
-
-#include "qemu/osdep.h"
-#include "qemu-io.h"
-#include "exec/memattrs.h"
-#include "hw/char/pl011.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index d0299dc262..b7e55e0129 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -187,24 +187,6 @@ dependencies = [
  "unicode-ident",
 ]
 
-[[package]]
-name = "qemu_api"
-version = "0.1.0"
-dependencies = [
- "anyhow",
- "bql",
- "chardev",
- "common",
- "foreign",
- "hwcore",
- "libc",
- "migration",
- "qemu_macros",
- "qom",
- "system",
- "util",
-]
-
 [[package]]
 name = "qemu_macros"
 version = "0.1.0"
@@ -255,6 +237,24 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "tests"
+version = "0.1.0"
+dependencies = [
+ "anyhow",
+ "bql",
+ "chardev",
+ "common",
+ "foreign",
+ "hwcore",
+ "libc",
+ "migration",
+ "qemu_macros",
+ "qom",
+ "system",
+ "util",
+]
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 4a97510676..84b6eefefb 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -6,13 +6,13 @@ members = [
     "common",
     "migration",
     "qemu-macros",
-    "qemu-api",
     "qom",
     "system",
     "hw/core",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
+    "tests",
 ]
 
 [workspace.package]
diff --git a/rust/meson.build b/rust/meson.build
index 9f6a0b161d..32d569f871 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -32,7 +32,7 @@ subdir('qom')
 subdir('system')
 subdir('chardev')
 subdir('hw/core')
-subdir('qemu-api')
+subdir('tests')
 
 subdir('hw')
 
diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
deleted file mode 100644
index df6c2163e0..0000000000
--- a/rust/qemu-api/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# Ignore generated bindings file overrides.
-/src/bindings.inc.rs
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
deleted file mode 100644
index ed1b7ab263..0000000000
--- a/rust/qemu-api/README.md
+++ /dev/null
@@ -1,19 +0,0 @@
-# QEMU bindings and API wrappers
-
-This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
-
-The C bindings can be generated with `bindgen`, using this build target:
-
-```console
-$ make bindings.inc.rs
-```
-
-## Generate Rust documentation
-
-Common Cargo tasks can be performed from the QEMU build directory
-
-```console
-$ make clippy
-$ make rustfmt
-$ make rustdoc
-```
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
deleted file mode 100644
index 02318950ff..0000000000
--- a/rust/qemu-api/meson.build
+++ /dev/null
@@ -1,87 +0,0 @@
-_qemu_api_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
-  capture: true, check: true).stdout().strip().splitlines()
-
-c_enums = [
-  'MemoryDeviceInfoKind',
-]
-_qemu_api_bindgen_args = []
-foreach enum : c_enums
-  _qemu_api_bindgen_args += ['--rustified-enum', enum]
-endforeach
-
-blocked_type = [
-  'Chardev',
-  'Error',
-  'MemTxAttrs',
-  'MemoryRegion',
-  'ObjectClass',
-  'VMStateDescription',
-  'device_endian',
-]
-foreach type: blocked_type
-  _qemu_api_bindgen_args += ['--blocklist-type', type]
-endforeach
-
-# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
-#
-# Rust bindings generation with `bindgen` might fail in some cases where the
-# detected `libclang` does not match the expected `clang` version/target. In
-# this case you must pass the path to `clang` and `libclang` to your build
-# command invocation using the environment variables CLANG_PATH and
-# LIBCLANG_PATH
-_qemu_api_bindings_inc_rs = rust.bindgen(
-  input: 'wrapper.h',
-  dependencies: common_ss.all_dependencies(),
-  output: 'bindings.inc.rs',
-  include_directories: bindings_incdir,
-  bindgen_version: ['>=0.60.0'],
-  args: bindgen_args_common + _qemu_api_bindgen_args,
-  )
-
-_qemu_api_rs = static_library(
-  'qemu_api',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/bindings.rs',
-      'src/prelude.rs',
-    ],
-    {'.' : _qemu_api_bindings_inc_rs},
-  ),
-  override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_abi: 'rust',
-  rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs, hwcore_rs,
-                 qom, hwcore, chardev, migration],
-)
-
-rust.test('rust-qemu-api-tests', _qemu_api_rs,
-          suite: ['unit', 'rust'])
-
-qemu_api = declare_dependency(link_with: [_qemu_api_rs],
-  dependencies: [qemu_macros, qom, hwcore, chardev, migration])
-
-# Doctests are essentially integration tests, so they need the same dependencies.
-# Note that running them requires the object files for C code, so place them
-# in a separate suite that is run by the "build" CI jobs rather than "check".
-rust.doctest('rust-qemu-api-doctests',
-     _qemu_api_rs,
-     protocol: 'rust',
-     dependencies: qemu_api,
-     suite: ['doc', 'rust'])
-
-test('rust-qemu-api-integration',
-    executable(
-        'rust-qemu-api-integration',
-        files('tests/vmstate_tests.rs'),
-        override_options: ['rust_std=2021', 'build.rust_std=2021'],
-        rust_args: ['--test'],
-        install: false,
-        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs, qemu_api]),
-    args: [
-        '--test', '--test-threads', '1',
-        '--format', 'pretty',
-    ],
-    protocol: 'rust',
-    suite: ['unit', 'rust'])
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
deleted file mode 100644
index 9c863e9b5b..0000000000
--- a/rust/qemu-api/src/bindings.rs
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#![allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unnecessary_transmutes,
-    unsafe_op_in_unsafe_fn,
-    clippy::pedantic,
-    clippy::restriction,
-    clippy::style,
-    clippy::missing_const_for_fn,
-    clippy::ptr_offset_with_cast,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc,
-    clippy::too_many_arguments
-)]
-
-//! `bindgen`-generated declarations.
-
-use chardev::bindings::Chardev;
-use migration::bindings::VMStateDescription;
-use qom::bindings::ObjectClass;
-use system::bindings::{device_endian, MemTxAttrs, MemoryRegion};
-use util::bindings::Error;
-
-#[cfg(MESON)]
-include!("bindings.inc.rs");
-
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
deleted file mode 100644
index 50fb2fa99d..0000000000
--- a/rust/qemu-api/src/lib.rs
+++ /dev/null
@@ -1,14 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
-#![deny(clippy::missing_const_for_fn)]
-
-#[rustfmt::skip]
-pub mod bindings;
-
-// preserve one-item-per-"use" syntax, it is clearer
-// for prelude-like modules
-#[rustfmt::skip]
-pub mod prelude;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
deleted file mode 100644
index 8db56f9f81..0000000000
--- a/rust/qemu-api/src/prelude.rs
+++ /dev/null
@@ -1,5 +0,0 @@
-// Copyright 2024 Red Hat, Inc.
-// Author(s): Paolo Bonzini <pbonzini@redhat.com>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-//! Commonly used traits and types for QEMU.
diff --git a/rust/qemu-api/Cargo.toml b/rust/tests/Cargo.toml
similarity index 80%
rename from rust/qemu-api/Cargo.toml
rename to rust/tests/Cargo.toml
index c77f6af174..079c490363 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/tests/Cargo.toml
@@ -1,12 +1,11 @@
 [package]
-name = "qemu_api"
+name = "tests"
 version = "0.1.0"
-authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
-description = "Rust bindings for QEMU"
-readme = "README.md"
+description = "Rust integration tests for QEMU"
 resolver = "2"
 publish = false
 
+authors.workspace = true
 edition.workspace = true
 homepage.workspace = true
 license.workspace = true
diff --git a/rust/tests/meson.build b/rust/tests/meson.build
new file mode 100644
index 0000000000..00688c66fb
--- /dev/null
+++ b/rust/tests/meson.build
@@ -0,0 +1,14 @@
+test('rust-integration',
+    executable(
+        'rust-integration',
+        files('tests/vmstate_tests.rs'),
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs]),
+    args: [
+        '--test', '--test-threads', '1',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/tests/tests/vmstate_tests.rs
similarity index 100%
rename from rust/qemu-api/tests/vmstate_tests.rs
rename to rust/tests/tests/vmstate_tests.rs
-- 
2.50.1


