Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6F9C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYso-0000dW-D0; Thu, 15 Aug 2024 07:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsl-0000Vv-Mv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:43:07 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsh-0002FD-Lo
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:43:07 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ef248ab2aeso13329731fa.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722182; x=1724326982; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9AH8vRNroqO0BRAuBLWZclpUvZUmj0NUZwy3ED45Y50=;
 b=cP3DuokV6DcqHZ60klepJYK7A97a0efAhdxXqe5DSYJe937HUGL3DbSJqpGpZPs8Fe
 5in6AHS6DE0E10t+GO8mVGeDgAuJtFLlDslXxIKXh3HBisgPf01ai9oacdNjlrVVYDuO
 TWMJLJM7c9QC5Jd8h+dHtRAQ2/CcYhQX1OoliO1repHUVSC/m8JgH4VwwQxZAJocHC24
 3N7HdmSEBCpfDr7t/Mz4Uwvl0RBgUqVNaaX85/lC9lHGUKZjse3MaAVZnSEPOcGwrHWr
 uVkTzsvyKUkZ2Occww3cHXawLbkKho+lsfLJ79I2lZyj1cybgCdq8LfyOjeyABL439WX
 8Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722182; x=1724326982;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9AH8vRNroqO0BRAuBLWZclpUvZUmj0NUZwy3ED45Y50=;
 b=VpH4tfwF5udWA+5UPS3lwrXOukL8Cn5LjUYnqiMpM+l+Xc82u6asOtJwwaaNxIiM2y
 GZtFnBb8ut/5MFhrbsO4Y4Wl+QUg79ADSEBYQyFGjopbNXtJyDUAQkV6GFDyFNl8w9sf
 t3maUZyh9nFbNwCbTQxyykhc3px5TWMtDgdQmCza/cH6eeiozukLx4V6EkicUA9+aTyz
 8ZGwivS6bXU/lJS3KVf83KFZRroC5YP+jC7rl0U2O2Kj33r6uDo4KDL4AZBO8Iar66JU
 rDZJZ3dq/w/rmmkay5DzK8lLJxfA9Y6exjyNydg15/SV6pFnvsvKcyYXJV48elxPczKt
 1XLA==
X-Gm-Message-State: AOJu0Yzbomm2nqiJd5MiH7v+X82b60K9xFjWebKrQAq/Jpf6VNIcc+ix
 ldgCFeIdigCEpW5oAWm9zg1cMthLy0g+ghKWAZHz/lzd+t81km8Ir29MbiHIAQ0=
X-Google-Smtp-Source: AGHT+IHyPpW6nBeeBoKQXtiMzlHtraz+lGKOEDKmx/JLTQnnpZVX7M76ApXl1cVBUKvrKEnEVa/zlA==
X-Received: by 2002:a2e:9b53:0:b0:2ef:2555:e52d with SMTP id
 38308e7fff4ca-2f3aa3013d5mr36608521fa.45.1723722181738; 
 Thu, 15 Aug 2024 04:43:01 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:43:01 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 15 Aug 2024 14:42:23 +0300
Subject: [PATCH v7 6/7] rust: add crate to expose bindings and interfaces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-rust-pl011-v7-6-975135e98831@linaro.org>
References: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
In-Reply-To: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=19909;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=OjGZB4pnS3YcBBB4zpPQy09SfkF7g06wyd1fZ1yrcHI=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW11ZVNBN1RVbFkwQnNkL3dqMVBWbWN2aDF4CnBqemJuMnV4VzVUdW0wMU1r
 UDZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJnQUt
 DUkIzS2Nkd2YzNEowSEpqRC85TWFTcFptS09uV3BJRG53UjQvdzhLRm5rV0dIZi8vUWJrZVROaA
 pWcDZsSFoxdmNtOWFOYlhyakx4ZndzZ2xtY3dhMHhEelJqUys2RlQwYTZKVnp1aTdHeisyMkVma
 nE1Mld2YlpvCkRVUVBlU0pBZUYwRmdSbzVFdGZKTDhKOGkwaU5Xd2RUU3crKzcxYkZIajBWK0Ja
 Zy9EamR4UXo1QjVuOG9IRzkKN0xJYmprTFZ5KzBRaHZRc1FYdDRYaSt6Wmhab3BMeXh1RzRESlB
 GeVg5UVpqc2p0MUVZQno1Z0NuQWpaanRoQQpVSGxRVlltT0R5Nm50czJyQXM1cVB4c0NKU2lqZX
 NCTzM0VlFSbGdkdTJaQzJqU1dFSDd3LzVxWlR3R0ZBcGtHCnlKRCtpQUNYVjJ1NXN6RncyWkdQZ
 1JmbVdJZU9NSitrZ2pVOG43WUJXdndCNzNiYlcrMGYwalhZRGcvb0ZIc3QKOTFwdGV5RHBlSTds
 U1UzKzZGc0tlTEhnSGxmVHVOd0l6Rkp0N3hFUFpCaFdmSnpqTUd2WjM0SzA2NmxmdU1EeQpja1p
 6KytqTUFMRVdJeVhzb1dKL0QwQmxJSUd4aTh3OW9JOGdNRjR5bkxvQ2pSQ1JPQjZrR2hzRWdQNy
 tlajlPClh3a0ZLdDByem1MS0ttZDdVak12R2JsQjJoYlBjYVBkNWFKeXBISjE4NVJ4RXNxbFVpS
 09TaVFMSFVGY0ZQbm8KM3lQS3VMWGk0K3JqZFhGd2p2ellXcE0xV2E1ODdLaWdrR2cwV0pDOHF4
 RWMrNmZydmtGTlpaME5pSVREOE4vaQpKSHpidHlRdEpCZFYvQ3hCQ2hGckhRN1NrQ1BEc1dhcWR
 UV05kczhHTDJVNU5GZXhhTWhGeS9Qa0ViN0YzWGNCCkdGMnFvQT09Cj05R2hFCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Co-authored-by: Junjie Mao <junjie.mao@intel.com>
Co-authored-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Junjie Mao <junjie.mao@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                       |   6 ++
 rust/meson.build                  |   9 +++
 rust/qemu-api/.gitignore          |   2 +
 rust/qemu-api/Cargo.lock          |   7 +++
 rust/qemu-api/Cargo.toml          |  23 +++++++
 rust/qemu-api/README.md           |  17 +++++
 rust/qemu-api/build.rs            |  13 ++++
 rust/qemu-api/meson.build         |  17 +++++
 rust/qemu-api/rustfmt.toml        |   1 +
 rust/qemu-api/src/bindings.rs     |   7 +++
 rust/qemu-api/src/definitions.rs  | 108 ++++++++++++++++++++++++++++++++
 rust/qemu-api/src/device_class.rs | 128 ++++++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs          | 100 +++++++++++++++++++++++++++++
 rust/qemu-api/src/tests.rs        |  48 ++++++++++++++
 rust/rustfmt.toml                 |   7 +++
 15 files changed, 493 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5464cb2b03..56a88048d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3348,6 +3348,12 @@ F: hw/core/register.c
 F: include/hw/register.h
 F: include/hw/registerfields.h
 
+Rust
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/qemu-api
+F: rust/rustfmt.toml
+
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
diff --git a/rust/meson.build b/rust/meson.build
index e69de29bb2..d5f32aed25 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -0,0 +1,9 @@
+_lib_bindings_rs = static_library(
+  '_bindings_rs',
+  bindings_rs,
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+)
+
+subdir('qemu-api')
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
index 0000000000..51260cbe42
--- /dev/null
+++ b/rust/qemu-api/Cargo.toml
@@ -0,0 +1,23 @@
+[package]
+name = "qemu_api"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0 OR GPL-3.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "Rust bindings for QEMU"
+repository = "https://gitlab.com/qemu-project/qemu/"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[dependencies]
+
+[features]
+default = ["allocator"]
+allocator = []
+
+# Do not include in any global workspace
+[workspace]
diff --git a/rust/qemu-api/README.md b/rust/qemu-api/README.md
new file mode 100644
index 0000000000..7588fa29ef
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
+$ ninja bindings.rs
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
index 0000000000..2f57c2b3d4
--- /dev/null
+++ b/rust/qemu-api/build.rs
@@ -0,0 +1,13 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use std::path::Path;
+
+fn main() {
+    if !Path::new("src/bindings.rs.inc").exists() {
+        panic!(
+            "No generated C bindings found! Either build them manually with bindgen or with meson \
+             (`ninja bindings.rs`) and copy them to src/bindings.rs.inc, or build through meson."
+        );
+    }
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
new file mode 100644
index 0000000000..997d478309
--- /dev/null
+++ b/rust/qemu-api/meson.build
@@ -0,0 +1,17 @@
+_qemu_api_rs = static_library(
+  'qemu_api',
+  [files('src/lib.rs')],
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: rust_args + [
+    '--cfg', 'MESON_BINDINGS_RS',
+  ],
+  link_with: [
+    _lib_bindings_rs,
+  ],
+)
+
+qemu_api = declare_dependency(
+  link_with: _qemu_api_rs,
+)
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
index 0000000000..fb595f1469
--- /dev/null
+++ b/rust/qemu-api/src/bindings.rs
@@ -0,0 +1,7 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+#[cfg(not(MESON_BINDINGS_RS))]
+include!("bindings.rs.inc");
+
+#[cfg(MESON_BINDINGS_RS)]
+pub use ::_bindings_rs::*;
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
new file mode 100644
index 0000000000..6de42229b6
--- /dev/null
+++ b/rust/qemu-api/src/definitions.rs
@@ -0,0 +1,108 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+//! Definitions required by QEMU when registering a device.
+
+/// Trait a type must implement to be registered with QEMU.
+pub trait ObjectImpl {
+    type Class;
+    const TYPE_INFO: crate::bindings::TypeInfo;
+    const TYPE_NAME: &'static ::core::ffi::CStr;
+    const PARENT_TYPE_NAME: Option<&'static ::core::ffi::CStr>;
+    const INSTANCE_INIT: ::core::option::Option<
+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
+    >;
+    const INSTANCE_POST_INIT: ::core::option::Option<
+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
+    >;
+    const INSTANCE_FINALIZE: ::core::option::Option<
+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
+    >;
+    const ABSTRACT: bool;
+}
+
+pub trait Class {
+    const CLASS_INIT: ::core::option::Option<
+        unsafe extern "C" fn(
+            klass: *mut crate::bindings::ObjectClass,
+            data: *mut core::ffi::c_void,
+        ),
+    >;
+    const CLASS_BASE_INIT: ::core::option::Option<
+        unsafe extern "C" fn(
+            klass: *mut crate::bindings::ObjectClass,
+            data: *mut core::ffi::c_void,
+        ),
+    >;
+}
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
+    ($t:ty) => {
+        $crate::bindings::TypeInfo {
+            name: <$t as $crate::definitions::ObjectImpl>::TYPE_NAME.as_ptr(),
+            parent: if let Some(pname) = <$t as $crate::definitions::ObjectImpl>::PARENT_TYPE_NAME {
+                pname.as_ptr()
+            } else {
+                ::core::ptr::null_mut()
+            },
+            instance_size: ::core::mem::size_of::<$t>(),
+            instance_align: ::core::mem::align_of::<$t>(),
+            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
+            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
+            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
+            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
+            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
+            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
+            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
+            class_data: ::core::ptr::null_mut(),
+            interfaces: ::core::ptr::null_mut(),
+        };
+    }
+}
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
new file mode 100644
index 0000000000..f8d4c04e03
--- /dev/null
+++ b/rust/qemu-api/src/device_class.rs
@@ -0,0 +1,128 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+use std::sync::OnceLock;
+
+use crate::bindings::Property;
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
+    pub fn as_mut_ptr(&mut self) -> *mut Property {
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
index 0000000000..6f02ac45e2
--- /dev/null
+++ b/rust/qemu-api/src/lib.rs
@@ -0,0 +1,100 @@
+// Copyright 2024 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0 OR GPL-3.0-or-later
+
+#![doc = include_str!("../README.md")]
+
+#[cfg(MESON_BINDINGS_RS)]
+extern crate _bindings_rs;
+
+#[cfg_attr(not(MESON_BINDINGS_RS), allow(
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals
+))]
+#[cfg_attr(not(MESON_BINDINGS_RS), allow(
+    clippy::missing_const_for_fn,
+    clippy::too_many_arguments,
+    clippy::approx_constant,
+    clippy::use_self,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+))]
+#[cfg_attr(not(MESON_BINDINGS_RS), rustfmt::skip)]
+pub mod bindings;
+
+pub mod definitions;
+pub mod device_class;
+
+#[cfg(test)]
+mod tests;
+
+use std::alloc::{GlobalAlloc, Layout};
+
+extern "C" {
+    pub fn g_aligned_alloc0(
+        n_blocks: bindings::gsize,
+        n_block_bytes: bindings::gsize,
+        alignment: bindings::gsize,
+    ) -> bindings::gpointer;
+    pub fn g_aligned_free(mem: bindings::gpointer);
+    pub fn g_malloc0(n_bytes: bindings::gsize) -> bindings::gpointer;
+    pub fn g_free(mem: bindings::gpointer);
+}
+
+/// An allocator that uses the same allocator as QEMU in C.
+///
+/// It is enabled by default with the `allocator` feature.
+///
+/// To set it up manually as a global allocator in your crate:
+///
+/// ```ignore
+/// use qemu_api::QemuAllocator;
+///
+/// #[global_allocator]
+/// static GLOBAL: QemuAllocator = QemuAllocator::new();
+/// ```
+#[derive(Clone, Copy, Debug)]
+#[repr(C)]
+pub struct QemuAllocator {
+    _unused: [u8; 0],
+}
+
+#[cfg_attr(feature = "allocator", global_allocator)]
+pub static GLOBAL: QemuAllocator = QemuAllocator::new();
+
+impl QemuAllocator {
+    pub const fn new() -> Self {
+        Self { _unused: [] }
+    }
+}
+
+impl Default for QemuAllocator {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+unsafe impl GlobalAlloc for QemuAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        if layout.align() == 0 {
+            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
+        } else {
+            g_aligned_alloc0(
+                layout.size().try_into().unwrap(),
+                1,
+                layout.align().try_into().unwrap(),
+            )
+            .cast::<u8>()
+        }
+    }
+
+    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
+        if layout.align() == 0 {
+            g_free(ptr.cast::<_>())
+        } else {
+            g_aligned_free(ptr.cast::<_>())
+        }
+    }
+}
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
2.44.0


