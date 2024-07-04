Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA486C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLOu-0008Gw-W7; Thu, 04 Jul 2024 08:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNu-0007tY-Hx
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNc-0002R3-1G
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42567ddf099so3756045e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720095362; x=1720700162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoRb5gNelpL+/SZJuMxfrJOn6b78+p4RR49qMAksc6Q=;
 b=FQniMsxKOvZRnUmCEM0kbe4tXCQxdWn/RC24ajLVh8IJh9EoWS7NgTBkx53d0OZTBx
 ixcjQikJU8h7tx+luKGIqOCopXcaVMUB5/TygbDdxQwyVa+NRg6qiv4IcE6jSv95sB/H
 occ02JAx8rywaDhd3EDmHbNcKELDYRiH5ge24v8uVbAeexbCQGctHYBCYzEKPEvXpsXf
 LOPN8G/oFVCyiAGx/+KK8X16NLT9ZWjjz9X0NQ2y47xT9+FBLV0dvSHCDg70Na6Sh9gM
 /ox1JAR14X//2LYs3C67IfugBDLqAUOU+63G8yvKFkt+/kxiOB0JXflo1sVuqM9O39dY
 se/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095362; x=1720700162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoRb5gNelpL+/SZJuMxfrJOn6b78+p4RR49qMAksc6Q=;
 b=GIVndDQJDzZzAnnJRUHj1qbNUcPT9/OncJmh334RyNS20HOoODdDP+lgz0L6/wAD0s
 RWNAwImQpGpUV7zYf+pCIv39Oig8BUsUgQ35vCCPUAbqQ1lB+Nqfl80i9uat51HgiLjH
 76W+A4osxGLqSiTTCjbrVuJOyfU66aJtkkyftqQ5nwe6PmDR07blm8W57PPYeMoOyycN
 meOkgUyLJINAYS2liHIGWgXain8L9ALS3NtKk7Wp8VmihPHpBZLcGZsEo4nz+Gmj4vIM
 Qe5KX4kmssfNzIWkvKlA2ySFwQL1/YlRKmYuJ3dlbWhwy6iynn/bUDVzteB61st6w3Em
 QQPg==
X-Gm-Message-State: AOJu0YyXNHljfp4CEbpcFvoYO0T/A/snggKNYOj7aUDdiaf8kGrm5Doq
 ZAX4eDzPj2WGzsD1uWM4pQ4q9VdHHtgn40snbI4o858/W4TQu+fnG6sa4ffasYf1itutw4gnUry
 l7oY=
X-Google-Smtp-Source: AGHT+IEawnden7sYBYyRupYBypwaBsXLukkF2UMkFjog8ihUin7kt8YBIsZnxH1+Ri3akQ5XgHDPKQ==
X-Received: by 2002:a05:600c:364c:b0:425:7a99:e6f2 with SMTP id
 5b1f17b1804b1-4264a3e31bfmr13021295e9.14.1720095361724; 
 Thu, 04 Jul 2024 05:16:01 -0700 (PDT)
Received: from localhost.localdomain (adsl-241.37.6.160.tellas.gr.
 [37.6.160.241]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm22471015e9.32.2024.07.04.05.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:16:01 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v4 3/7] rust: add crate to expose bindings and interfaces
Date: Thu,  4 Jul 2024 15:15:39 +0300
Message-ID: <eea3fbaeb15e10ee082d38aee19e55ea1d3a607c.1720094395.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add rust/qemu-api, which exposes rust-bindgen generated FFI bindings and
provides some declaration macros for symbols visible to the rest of
QEMU.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                       |   7 ++
 rust/.cargo/config.toml           |   2 +
 rust/qemu-api/.gitignore          |   2 +
 rust/qemu-api/Cargo.lock          |   7 ++
 rust/qemu-api/Cargo.toml          |  59 ++++++++++++++
 rust/qemu-api/README.md           |  17 ++++
 rust/qemu-api/build.rs            |  48 +++++++++++
 rust/qemu-api/deny.toml           |  57 +++++++++++++
 rust/qemu-api/meson.build         |   0
 rust/qemu-api/rustfmt.toml        |   1 +
 rust/qemu-api/src/bindings.rs     |   8 ++
 rust/qemu-api/src/definitions.rs  | 112 +++++++++++++++++++++++++
 rust/qemu-api/src/device_class.rs | 131 ++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs          |  29 +++++++
 rust/qemu-api/src/tests.rs        |  48 +++++++++++
 rust/rustfmt.toml                 |   7 ++
 16 files changed, 535 insertions(+)
 create mode 100644 rust/.cargo/config.toml
 create mode 100644 rust/qemu-api/.gitignore
 create mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/Cargo.toml
 create mode 100644 rust/qemu-api/README.md
 create mode 100644 rust/qemu-api/build.rs
 create mode 100644 rust/qemu-api/deny.toml
 create mode 100644 rust/qemu-api/meson.build
 create mode 120000 rust/qemu-api/rustfmt.toml
 create mode 100644 rust/qemu-api/src/bindings.rs
 create mode 100644 rust/qemu-api/src/definitions.rs
 create mode 100644 rust/qemu-api/src/device_class.rs
 create mode 100644 rust/qemu-api/src/lib.rs
 create mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/rustfmt.toml

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7b8207fb..8598d38eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3340,6 +3340,11 @@ F: hw/core/register.c
 F: include/hw/register.h
 F: include/hw/registerfields.h
 
+Rust
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/qemu-api
+
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
@@ -4233,6 +4238,8 @@ F: scripts/cargo_wrapper.py
 F: rust/meson.build
 F: rust/wrapper.h
 F: rust/.gitignore
+F: rust/rustfmt.toml
+F: rust/.cargo/config.toml
 
 Miscellaneous
 -------------
diff --git a/rust/.cargo/config.toml b/rust/.cargo/config.toml
new file mode 100644
index 0000000000..241210ffa7
--- /dev/null
+++ b/rust/.cargo/config.toml
@@ -0,0 +1,2 @@
+[build]
+rustflags = ["-Crelocation-model=pic", "-Ctarget-feature=+crt-static"]
diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
new file mode 100644
index 0000000000..71eaff2035
--- /dev/null
+++ b/rust/qemu-api/.gitignore
@@ -0,0 +1,2 @@
+# Ignore generated bindings file overrides.
+src/bindings.rs.inc
diff --git a/rust/qemu-api/Cargo.lock b/rust/qemu-api/Cargo.lock
new file mode 100644
index 0000000000..e9c51a243a
--- /dev/null
+++ b/rust/qemu-api/Cargo.lock
@@ -0,0 +1,7 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "qemu_api"
+version = "0.1.0"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
new file mode 100644
index 0000000000..94a48b9ce9
--- /dev/null
+++ b/rust/qemu-api/Cargo.toml
@@ -0,0 +1,59 @@
+[package]
+name = "qemu_api"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0 OR GPL-3.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "Rust bindings for QEMU"
+repository = "https://gitlab.com/epilys/rust-for-qemu"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[dependencies]
+
+[lints]
+[lints.rustdoc]
+broken_intra_doc_links = "deny"
+redundant_explicit_links = "deny"
+[lints.clippy]
+# lint groups
+correctness = { level = "deny", priority = -1 }
+suspicious = { level = "deny", priority = -1 }
+complexity = { level = "deny", priority = -1 }
+perf = { level = "deny", priority = -1 }
+cargo = { level = "deny", priority = -1 }
+nursery = { level = "deny", priority = -1 }
+style = { level = "deny", priority = -1 }
+# restriction group
+dbg_macro = "deny"
+rc_buffer = "deny"
+as_underscore = "deny"
+assertions_on_result_states = "deny"
+# pedantic group
+doc_markdown = "deny"
+expect_fun_call = "deny"
+borrow_as_ptr = "deny"
+case_sensitive_file_extension_comparisons = "deny"
+cast_lossless = "deny"
+cast_ptr_alignment = "allow"
+large_futures = "deny"
+waker_clone_wake = "deny"
+unused_enumerate_index = "deny"
+unnecessary_fallible_conversions = "deny"
+struct_field_names = "deny"
+manual_hash_one = "deny"
+into_iter_without_iter = "deny"
+option_if_let_else = "deny"
+missing_const_for_fn = "deny"
+significant_drop_tightening = "deny"
+multiple_crate_versions = "deny"
+significant_drop_in_scrutinee = "deny"
+cognitive_complexity = "deny"
+missing_safety_doc = "allow"
+
+# Do not include in any global workspace
+[workspace]
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
new file mode 100644
index 0000000000..f16a1a929d
--- /dev/null
+++ b/rust/qemu-api/README.md
@@ -0,0 +1,17 @@
+# QEMU bindings and API wrappers
+
+This library exports helper Rust types, Rust macros and C FFI bindings for internal QEMU APIs.
+
+The C bindings can be generated with `bindgen`, using this build target:
+
+```console
+$ ninja bindings-aarch64-softmmu.rs
+```
+
+## Generate Rust documentation
+
+To generate docs for this crate, including private items:
+
+```sh
+cargo doc --no-deps --document-private-items
+```
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
new file mode 100644
index 0000000000..13164f8371
--- /dev/null
+++ b/rust/qemu-api/build.rs
@@ -0,0 +1,48 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use std::{env, path::Path};
+
+fn main() {
+    println!("cargo:rerun-if-env-changed=MESON_BUILD_ROOT");
+    println!("cargo:rerun-if-changed=src/bindings.rs.inc");
+
+    let out_dir = env::var_os("OUT_DIR").unwrap();
+
+    if let Some(build_dir) = std::env::var_os("MESON_BUILD_ROOT") {
+        let mut build_dir = Path::new(&build_dir).to_path_buf();
+        let mut out_dir = Path::new(&out_dir).to_path_buf();
+        assert!(
+            build_dir.exists(),
+            "MESON_BUILD_ROOT value does not exist on filesystem: {}",
+            build_dir.display()
+        );
+        assert!(
+            build_dir.is_dir(),
+            "MESON_BUILD_ROOT value is not actually a directory: {}",
+            build_dir.display()
+        );
+        // TODO: add logic for other guest target architectures.
+        build_dir.push("bindings-aarch64-softmmu.rs");
+        let bindings_rs = build_dir;
+        assert!(
+            bindings_rs.exists(),
+            "MESON_BUILD_ROOT/bindings-aarch64-softmmu.rs does not exist on filesystem: {}",
+            bindings_rs.display()
+        );
+        assert!(
+            bindings_rs.is_file(),
+            "MESON_BUILD_ROOT/bindings-aarch64-softmmu.rs is not a file: {}",
+            bindings_rs.display()
+        );
+        out_dir.push("bindings.rs");
+        std::fs::copy(bindings_rs, out_dir).unwrap();
+        println!("cargo:rustc-cfg=MESON_BINDINGS_RS");
+    } else if !Path::new("src/bindings.rs.inc").exists() {
+        panic!(
+            "No generated C bindings found! Either build them manually with bindgen or with meson \
+             (`ninja bindings-aarch64-softmmu.rs`) and copy them to src/bindings.rs.inc, or build \
+             through meson."
+        );
+    }
+}
diff --git a/rust/qemu-api/deny.toml b/rust/qemu-api/deny.toml
new file mode 100644
index 0000000000..3992380509
--- /dev/null
+++ b/rust/qemu-api/deny.toml
@@ -0,0 +1,57 @@
+# cargo-deny configuration file
+
+[graph]
+targets = [
+    "aarch64-unknown-linux-gnu",
+    "x86_64-unknown-linux-gnu",
+    "x86_64-apple-darwin",
+    "aarch64-apple-darwin",
+    "x86_64-pc-windows-gnu",
+    "aarch64-pc-windows-gnullvm",
+]
+#exclude = []
+all-features = false
+no-default-features = false
+#features = []
+
+[output]
+feature-depth = 1
+
+[advisories]
+db-path = "$CARGO_HOME/advisory-dbs"
+db-urls = ["https://github.com/rustsec/advisory-db"]
+ignore = []
+
+[licenses]
+allow = [
+  "GPL-2.0",
+  "MIT",
+  "Apache-2.0",
+  "Unicode-DFS-2016",
+]
+confidence-threshold = 0.8
+exceptions = []
+
+[licenses.private]
+ignore = false
+registries = []
+
+[bans]
+multiple-versions = "warn"
+wildcards = "deny"
+# The graph highlighting used when creating dotgraphs for crates
+# with multiple versions
+# * lowest-version - The path to the lowest versioned duplicate is highlighted
+# * simplest-path - The path to the version with the fewest edges is highlighted
+# * all - Both lowest-version and simplest-path are used
+highlight = "all"
+workspace-default-features = "allow"
+external-default-features = "allow"
+allow = []
+deny = []
+
+[sources]
+unknown-registry = "deny"
+unknown-git = "deny"
+allow-registry = ["https://github.com/rust-lang/crates.io-index"]
+allow-git = []
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/rust/qemu-api/rustfmt.toml b/rust/qemu-api/rustfmt.toml
new file mode 120000
index 0000000000..39f97b043b
--- /dev/null
+++ b/rust/qemu-api/rustfmt.toml
@@ -0,0 +1 @@
+../rustfmt.toml
\ No newline at end of file
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
new file mode 100644
index 0000000000..1220a3d8f0
--- /dev/null
+++ b/rust/qemu-api/src/bindings.rs
@@ -0,0 +1,8 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+#[cfg(MESON_BINDINGS_RS)]
+include!(concat!(env!("OUT_DIR"), "/bindings.rs"));
+
+#[cfg(not(MESON_BINDINGS_RS))]
+include!("bindings.rs.inc");
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
new file mode 100644
index 0000000000..04b3a4d565
--- /dev/null
+++ b/rust/qemu-api/src/definitions.rs
@@ -0,0 +1,112 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+//! Definitions required by QEMU when registering a device.
+
+use crate::bindings::*;
+
+unsafe impl Sync for TypeInfo {}
+unsafe impl Sync for VMStateDescription {}
+
+#[macro_export]
+macro_rules! module_init {
+    ($func:expr, $type:expr) => {
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static LOAD_MODULE: extern "C" fn() = {
+            assert!($type < $crate::bindings::module_init_type_MODULE_INIT_MAX);
+
+            extern "C" fn __load() {
+                // ::std::panic::set_hook(::std::boxed::Box::new(|_| {}));
+
+                unsafe {
+                    $crate::bindings::register_module_init(Some($func), $type);
+                }
+            }
+
+            __load
+        };
+    };
+    (qom: $func:ident => $body:block) => {
+        // NOTE: To have custom identifiers for the ctor func we need to either supply
+        // them directly as a macro argument or create them with a proc macro.
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static LOAD_MODULE: extern "C" fn() = {
+            extern "C" fn __load() {
+                // ::std::panic::set_hook(::std::boxed::Box::new(|_| {}));
+                #[no_mangle]
+                unsafe extern "C" fn $func() {
+                    $body
+                }
+
+                unsafe {
+                    $crate::bindings::register_module_init(
+                        Some($func),
+                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
+                    );
+                }
+            }
+
+            __load
+        };
+    };
+}
+
+#[macro_export]
+macro_rules! type_info {
+    ($(#[$outer:meta])*
+     $name:ident: $t:ty,
+     $(name: $tname:expr,)*
+     $(parent: $pname:expr,)*
+     $(instance_init: $ii_fn:expr,)*
+     $(instance_post_init: $ipi_fn:expr,)*
+     $(instance_finalize: $if_fn:expr,)*
+     $(abstract_: $a_val:expr,)*
+     $(class_init: $ci_fn:expr,)*
+     $(class_base_init: $cbi_fn:expr,)*
+    ) => {
+        #[used]
+        $(#[$outer])*
+        pub static $name: $crate::bindings::TypeInfo = $crate::bindings::TypeInfo {
+                $(name: {
+                #[used]
+                static TYPE_NAME: &::core::ffi::CStr = $tname;
+                $tname.as_ptr()
+            },)*
+            $(parent: {
+                #[used]
+                static PARENT_TYPE_NAME: &::core::ffi::CStr = $pname;
+                $pname.as_ptr()
+            },)*
+            instance_size: ::core::mem::size_of::<$t>(),
+            instance_align: ::core::mem::align_of::<$t>(),
+            $(
+                instance_init: $ii_fn,
+            )*
+            $(
+                instance_post_init: $ipi_fn,
+            )*
+            $(
+                instance_finalize: $if_fn,
+            )*
+            $(
+                abstract_: $a_val,
+            )*
+            class_size: 0,
+            $(
+                class_init: $ci_fn,
+            )*
+            $(
+                class_base_init: $cbi_fn,
+            )*
+            class_data: core::ptr::null_mut(),
+            interfaces: core::ptr::null_mut(),
+            ..unsafe { MaybeUninit::<$crate::bindings::TypeInfo>::zeroed().assume_init() }
+        };
+    }
+}
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
new file mode 100644
index 0000000000..855d70364a
--- /dev/null
+++ b/rust/qemu-api/src/device_class.rs
@@ -0,0 +1,131 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use std::sync::OnceLock;
+
+use crate::bindings::*;
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+
+#[macro_export]
+macro_rules! device_class_init {
+    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, reset_fn => $reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
+        #[no_mangle]
+        pub unsafe extern "C" fn $func(
+            klass: *mut $crate::bindings::ObjectClass,
+            _: *mut ::core::ffi::c_void,
+        ) {
+            let mut dc =
+                ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
+            dc.as_mut().realize = $realize_fn;
+            dc.as_mut().reset = $reset_fn;
+            dc.as_mut().vmsd = &$vmsd;
+            $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
+        }
+    };
+}
+
+#[macro_export]
+macro_rules! define_property {
+    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr$(,)*) => {
+        $crate::bindings::Property {
+            name: {
+                #[used]
+                static _TEMP: &::core::ffi::CStr = $name;
+                _TEMP.as_ptr()
+            },
+            info: $prop,
+            offset: ::core::mem::offset_of!($state, $field)
+                .try_into()
+                .expect("Could not fit offset value to type"),
+            bitnr: 0,
+            bitmask: 0,
+            set_default: true,
+            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval.into() },
+            arrayoffset: 0,
+            arrayinfo: ::core::ptr::null(),
+            arrayfieldsize: 0,
+            link_type: ::core::ptr::null(),
+        }
+    };
+    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr$(,)*) => {
+        $crate::bindings::Property {
+            name: {
+                #[used]
+                static _TEMP: &::core::ffi::CStr = $name;
+                _TEMP.as_ptr()
+            },
+            info: $prop,
+            offset: ::core::mem::offset_of!($state, $field)
+                .try_into()
+                .expect("Could not fit offset value to type"),
+            bitnr: 0,
+            bitmask: 0,
+            set_default: false,
+            defval: $crate::bindings::Property__bindgen_ty_1 { i: 0 },
+            arrayoffset: 0,
+            arrayinfo: ::core::ptr::null(),
+            arrayfieldsize: 0,
+            link_type: ::core::ptr::null(),
+        }
+    };
+}
+
+#[repr(C)]
+pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn() -> [Property; N]);
+
+impl<const N: usize> Properties<N> {
+    pub unsafe fn as_mut_ptr(&mut self) -> *mut Property {
+        _ = self.0.get_or_init(self.1);
+        self.0.get_mut().unwrap().as_mut_ptr()
+    }
+}
+
+#[macro_export]
+macro_rules! declare_properties {
+    ($ident:ident, $($prop:expr),*$(,)*) => {
+
+        const fn _calc_prop_len() -> usize {
+            let mut len = 1;
+            $({
+                _ = stringify!($prop);
+                len += 1;
+            })*
+            len
+        }
+        const PROP_LEN: usize = _calc_prop_len();
+
+        #[no_mangle]
+        fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {
+            [
+                $($prop),*,
+                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
+            ]
+        }
+
+        #[no_mangle]
+        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
+    };
+}
+
+#[macro_export]
+macro_rules! vm_state_description {
+    ($(#[$outer:meta])*
+     $name:ident,
+     $(name: $vname:expr,)*
+     $(unmigratable: $um_val:expr,)*
+    ) => {
+        #[used]
+        $(#[$outer])*
+        pub static $name: $crate::bindings::VMStateDescription = $crate::bindings::VMStateDescription {
+            $(name: {
+                #[used]
+                static VMSTATE_NAME: &::core::ffi::CStr = $vname;
+                $vname.as_ptr()
+            },)*
+            unmigratable: true,
+            ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::VMStateDescription>::zeroed().assume_init() }
+        };
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
new file mode 100644
index 0000000000..74825c84e7
--- /dev/null
+++ b/rust/qemu-api/src/lib.rs
@@ -0,0 +1,29 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+#![doc = include_str!("../README.md")]
+
+// FIXME: remove improper_ctypes
+#[allow(
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals
+)]
+#[allow(
+    clippy::missing_const_for_fn,
+    clippy::useless_transmute,
+    clippy::too_many_arguments,
+    clippy::approx_constant,
+    clippy::use_self,
+    clippy::cast_lossless,
+)]
+#[rustfmt::skip]
+pub mod bindings;
+
+pub mod definitions;
+pub mod device_class;
+
+#[cfg(test)]
+mod tests;
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
new file mode 100644
index 0000000000..88c26308ee
--- /dev/null
+++ b/rust/qemu-api/src/tests.rs
@@ -0,0 +1,48 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use crate::{
+    bindings::*, declare_properties, define_property, device_class_init, vm_state_description,
+};
+
+#[test]
+fn test_device_decl_macros() {
+    // Test that macros can compile.
+    vm_state_description! {
+        VMSTATE,
+        name: c"name",
+        unmigratable: true,
+    }
+
+    #[repr(C)]
+    pub struct DummyState {
+        pub char_backend: CharBackend,
+        pub migrate_clock: bool,
+    }
+
+    declare_properties! {
+        DUMMY_PROPERTIES,
+            define_property!(
+                c"chardev",
+                DummyState,
+                char_backend,
+                unsafe { &qdev_prop_chr },
+                CharBackend
+            ),
+            define_property!(
+                c"migrate-clk",
+                DummyState,
+                migrate_clock,
+                unsafe { &qdev_prop_bool },
+                bool
+            ),
+    }
+
+    device_class_init! {
+        dummy_class_init,
+        props => DUMMY_PROPERTIES,
+        realize_fn => None,
+        reset_fn => None,
+        vmsd => VMSTATE,
+    }
+}
diff --git a/rust/rustfmt.toml b/rust/rustfmt.toml
new file mode 100644
index 0000000000..ebecb99fe0
--- /dev/null
+++ b/rust/rustfmt.toml
@@ -0,0 +1,7 @@
+edition = "2021"
+format_generated_files = false
+format_code_in_doc_comments = true
+format_strings = true
+imports_granularity = "Crate"
+group_imports = "StdExternalCrate"
+wrap_comments = true
-- 
γαῖα πυρί μιχθήτω


