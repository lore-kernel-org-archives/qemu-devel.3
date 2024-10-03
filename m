Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285D6CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLtk-00005w-7M; Thu, 03 Oct 2024 09:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtg-00005F-Fq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:36 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtd-0005zp-Qo
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:36 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d0d0aea3cso134478366b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962172; x=1728566972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DkppQL1v/pmItEhwGGihnerfmCeSnbO4UZA/zfSM9Y=;
 b=uxMWNRCtpCNacse8TsSxNPDc8cUsmcDhCd2tZJlBFkBmmtxYSTug4XKVLDsedHmMQp
 z6YZFfaugYOur3N0jsztipD6TTJ6HeyLGoz21RjRQ5rPoF0fQukoZs1JSjAShqXmdGUu
 aVhSiXCRW2ryKCRmS+it9W7yjoe04CQLGfDAmDpSB3I3MzC1HxY8ZtPbtTvbrcyCuVOv
 bypMn6fxJXEgI1iDNHRbOZ2SRXfddYxSD+3+XvtxuwVMc1Tkfm8VcPgr3GMPgjsZvnyR
 F+hu2i0+5CRjgm8VDltJxCH7yVhyxudNYE9a4Xl4zH+SS9mKYSVNs67cWGVihcxz5Ekq
 k0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962172; x=1728566972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2DkppQL1v/pmItEhwGGihnerfmCeSnbO4UZA/zfSM9Y=;
 b=aHpIi6VpM16RB4iIwaHAiw1hRUetNwQ6lcvgMi4QZhrI8TIqAAaT4ALcK0X/PwgttA
 D8C1WThWkijg2ZB+4roPH8QrOCbTXCNnmf4aYA0cHPWus3ayNLp3KfKp+tQOpt3Dnf3Q
 XurlPFa2ramgV+xQaf9p3k8OMyxsvUlGk8iqaRAjhCL3Gqxt6F3q6uE6p2gGlpYyDLA3
 rkXXE8xyUM8T3dFKyezcJUh/SlefTbtLHekKhf8LR7uo2DnsDS6AhZuxnEddMyGuvmXX
 9CgobO0glkNIgnSU4uJCGG0nutKmoRhdhTbx7wRHwcm+e4SHpn8/jQTz4xYrnojSOHeY
 9nMA==
X-Gm-Message-State: AOJu0YwlLDt5NQZQlBsPHlhBvLMlGKvBqJheYZ63dteYEGy508vS78KY
 lZ/xXo77VDZrFoCyQziLyUlt+0ZZyRaErvHwOCM5Hv8RaXlC1cdjmVwQNnMgnJer8AGvpWV7cRU
 /2+s=
X-Google-Smtp-Source: AGHT+IHbxGQDiCdesnsGSsttnQzhmZhlKs9QubwtOCNopbnKt67bsEgE/wMBQ5RDs95/3Oz53Pq8TA==
X-Received: by 2002:a17:906:da89:b0:a8a:7f08:97a6 with SMTP id
 a640c23a62f3a-a98f8245695mr582933266b.24.1727962171761; 
 Thu, 03 Oct 2024 06:29:31 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:31 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v11 8/9] rust: add utility procedural macro crate
Date: Thu,  3 Oct 2024 16:28:50 +0300
Message-ID: <dd645642406a6dc2060c6f3f17db2bc77ed67b59.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
References: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit adds a helper crate library, qemu-api-macros for derive (and
other procedural) macros to be used along qemu-api.

It needs to be a separate library because in Rust, procedural macros, or
macros that can generate arbitrary code, need to be special separate
compilation units.

Only one macro is introduced in this patch, #[derive(Object)]. It
generates a constructor to register a QOM TypeInfo on init and it must
be used on types that implement qemu_api::definitions::ObjectImpl trait.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                                   |  1 +
 rust/meson.build                              |  1 +
 rust/qemu-api-macros/Cargo.lock               | 47 +++++++++++++++++++
 rust/qemu-api-macros/Cargo.toml               | 25 ++++++++++
 rust/qemu-api-macros/README.md                |  1 +
 rust/qemu-api-macros/meson.build              | 25 ++++++++++
 rust/qemu-api-macros/src/lib.rs               | 43 +++++++++++++++++
 rust/qemu-api/meson.build                     |  3 ++
 scripts/archive-source.sh                     |  4 +-
 scripts/make-release                          |  3 +-
 subprojects/.gitignore                        |  4 ++
 .../packagefiles/proc-macro2-1-rs/meson.build | 31 ++++++++++++
 .../packagefiles/quote-1-rs/meson.build       | 29 ++++++++++++
 subprojects/packagefiles/syn-2-rs/meson.build | 40 ++++++++++++++++
 subprojects/proc-macro2-1-rs.wrap             |  7 +++
 subprojects/quote-1-rs.wrap                   |  7 +++
 subprojects/syn-2-rs.wrap                     |  7 +++
 subprojects/unicode-ident-1-rs.wrap           |  7 +++
 subprojects/unicode-ident-1-rs/meson.build    | 20 ++++++++
 19 files changed, 303 insertions(+), 2 deletions(-)
 create mode 100644 rust/qemu-api-macros/Cargo.lock
 create mode 100644 rust/qemu-api-macros/Cargo.toml
 create mode 100644 rust/qemu-api-macros/README.md
 create mode 100644 rust/qemu-api-macros/meson.build
 create mode 100644 rust/qemu-api-macros/src/lib.rs
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 create mode 100644 subprojects/proc-macro2-1-rs.wrap
 create mode 100644 subprojects/quote-1-rs.wrap
 create mode 100644 subprojects/syn-2-rs.wrap
 create mode 100644 subprojects/unicode-ident-1-rs.wrap
 create mode 100644 subprojects/unicode-ident-1-rs/meson.build

diff --git a/MAINTAINERS b/MAINTAINERS
index bf235430dc..92bf3e3e8f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3301,6 +3301,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/qemu-api
+F: rust/qemu-api-macros
 F: rust/rustfmt.toml
 
 SLIRP
diff --git a/rust/meson.build b/rust/meson.build
index 4a58d106b1..7a32b1b195 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1 +1,2 @@
+subdir('qemu-api-macros')
 subdir('qemu-api')
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
new file mode 100644
index 0000000000..fdc0fce116
--- /dev/null
+++ b/rust/qemu-api-macros/Cargo.lock
@@ -0,0 +1,47 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.86"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "5e719e8df665df0d1c8fbfd238015744736151d4445ec0836b8e628aae103b77"
+dependencies = [
+ "unicode-ident",
+]
+
+[[package]]
+name = "qemu_api_macros"
+version = "0.1.0"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "quote"
+version = "1.0.36"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7"
+dependencies = [
+ "proc-macro2",
+]
+
+[[package]]
+name = "syn"
+version = "2.0.72"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc4b9b9bf2add8093d3f2c0204471e951b2285580335de42f9d2534f3ae7a8af"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "unicode-ident",
+]
+
+[[package]]
+name = "unicode-ident"
+version = "1.0.12"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
diff --git a/rust/qemu-api-macros/Cargo.toml b/rust/qemu-api-macros/Cargo.toml
new file mode 100644
index 0000000000..144cc3650f
--- /dev/null
+++ b/rust/qemu-api-macros/Cargo.toml
@@ -0,0 +1,25 @@
+[package]
+name = "qemu_api_macros"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "Rust bindings for QEMU - Utility macros"
+repository = "https://gitlab.com/qemu-project/qemu/"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[lib]
+proc-macro = true
+
+[dependencies]
+proc-macro2 = "1"
+quote = "1"
+syn = "2"
+
+# Do not include in any global workspace
+[workspace]
diff --git a/rust/qemu-api-macros/README.md b/rust/qemu-api-macros/README.md
new file mode 100644
index 0000000000..f60f54ac4b
--- /dev/null
+++ b/rust/qemu-api-macros/README.md
@@ -0,0 +1 @@
+# `qemu-api-macros` - Utility macros for defining QEMU devices
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
new file mode 100644
index 0000000000..48af91ed38
--- /dev/null
+++ b/rust/qemu-api-macros/meson.build
@@ -0,0 +1,25 @@
+add_languages('rust', required: true, native: true)
+
+quote_dep = dependency('quote-1-rs', native: true)
+syn_dep = dependency('syn-2-rs', native: true)
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+
+_qemu_api_macros_rs = import('rust').proc_macro(
+  'qemu_api_macros',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_args: [
+    '--cfg', 'use_fallback',
+    '--cfg', 'feature="syn-error"',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    proc_macro2_dep,
+    quote_dep,
+    syn_dep,
+  ],
+)
+
+qemu_api_macros = declare_dependency(
+  link_with: _qemu_api_macros_rs,
+)
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
new file mode 100644
index 0000000000..59aba592d9
--- /dev/null
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -0,0 +1,43 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro::TokenStream;
+use quote::{format_ident, quote};
+use syn::{parse_macro_input, DeriveInput};
+
+#[proc_macro_derive(Object)]
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    let name = input.ident;
+    let module_static = format_ident!("__{}_LOAD_MODULE", name);
+
+    let expanded = quote! {
+        #[allow(non_upper_case_globals)]
+        #[used]
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static #module_static: extern "C" fn() = {
+            extern "C" fn __register() {
+                unsafe {
+                    ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::definitions::ObjectImpl>::TYPE_INFO);
+                }
+            }
+
+            extern "C" fn __load() {
+                unsafe {
+                    ::qemu_api::bindings::register_module_init(
+                        Some(__register),
+                        ::qemu_api::bindings::module_init_type::MODULE_INIT_QOM
+                    );
+                }
+            }
+
+            __load
+        };
+    };
+
+    TokenStream::from(expanded)
+}
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 439ef73c29..c72d34b607 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,6 +14,9 @@ _qemu_api_rs = static_library(
     '--cfg', 'MESON',
     # '--cfg', 'feature="allocator"',
   ],
+  dependencies: [
+    qemu_api_macros,
+  ],
 )
 
 qemu_api = declare_dependency(
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 65af8063e4..6239cf1815 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,9 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-subprojects="keycodemapdb libvfio-user berkeley-softfloat-3 berkeley-testfloat-3"
+subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
+  berkeley-testfloat-3 unicode-ident-1.0.12 proc-macro2-1.0.84
+  quote-1.0.36 syn-2.0.66"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index 6e0433de24..076e588953 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -17,7 +17,8 @@ if [ $# -ne 2 ]; then
 fi
 
 # Only include wraps that are invoked with subproject()
-SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-testfloat-3"
+SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3 berkeley-testfloat-3
+  proc-macro2-1.0.84 quote-1.0.36 syn-2.0.66 unicode-ident-1.0.12"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index adca0266be..b6888182ca 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -6,3 +6,7 @@
 /keycodemapdb
 /libvfio-user
 /slirp
+/proc-macro2-1.0.84
+/quote-1.0.36
+/syn-2.0.66
+/unicode-ident-1.0.12
diff --git a/subprojects/packagefiles/proc-macro2-1-rs/meson.build b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
new file mode 100644
index 0000000000..818ec59336
--- /dev/null
+++ b/subprojects/packagefiles/proc-macro2-1-rs/meson.build
@@ -0,0 +1,31 @@
+project('proc-macro2-1-rs', 'rust',
+  version: '1.0.84',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('unicode-ident-1-rs', required: true)
+
+unicode_ident_dep = dependency('unicode-ident-1-rs', native: true)
+
+_proc_macro2_rs = static_library(
+  'proc_macro2',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cfg', 'feature="proc-macro"',
+    '--cfg', 'span_locations',
+    '--cfg', 'wrap_proc_macro',
+  ],
+  dependencies: [
+    unicode_ident_dep,
+  ],
+  native: true,
+)
+
+proc_macro2_dep = declare_dependency(
+  link_with: _proc_macro2_rs,
+)
+
+meson.override_dependency('proc-macro2-1-rs', proc_macro2_dep, native: true)
diff --git a/subprojects/packagefiles/quote-1-rs/meson.build b/subprojects/packagefiles/quote-1-rs/meson.build
new file mode 100644
index 0000000000..d36609bd3c
--- /dev/null
+++ b/subprojects/packagefiles/quote-1-rs/meson.build
@@ -0,0 +1,29 @@
+project('quote-1-rs', 'rust',
+  version: '1.12.0',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('proc-macro2-1-rs', required: true)
+
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+
+_quote_rs = static_library(
+  'quote',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    proc_macro2_dep,
+  ],
+  native: true,
+)
+
+quote_dep = declare_dependency(
+  link_with: _quote_rs,
+)
+
+meson.override_dependency('quote-1-rs', quote_dep, native: true)
diff --git a/subprojects/packagefiles/syn-2-rs/meson.build b/subprojects/packagefiles/syn-2-rs/meson.build
new file mode 100644
index 0000000000..a53335f309
--- /dev/null
+++ b/subprojects/packagefiles/syn-2-rs/meson.build
@@ -0,0 +1,40 @@
+project('syn-2-rs', 'rust',
+  version: '2.0.66',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+subproject('proc-macro2-1-rs', required: true)
+subproject('quote-1-rs', required: true)
+subproject('unicode-ident-1-rs', required: true)
+
+proc_macro2_dep = dependency('proc-macro2-1-rs', native: true)
+quote_dep = dependency('quote-1-rs', native: true)
+unicode_ident_dep = dependency('unicode-ident-1-rs', native: true)
+
+_syn_rs = static_library(
+  'syn',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cfg', 'feature="full"',
+    '--cfg', 'feature="derive"',
+    '--cfg', 'feature="parsing"',
+    '--cfg', 'feature="printing"',
+    '--cfg', 'feature="clone-impls"',
+    '--cfg', 'feature="proc-macro"',
+  ],
+  dependencies: [
+    quote_dep,
+    proc_macro2_dep,
+    unicode_ident_dep,
+  ],
+  native: true,
+)
+
+syn_dep = declare_dependency(
+  link_with: _syn_rs,
+)
+
+meson.override_dependency('syn-2-rs', syn_dep, native: true)
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
new file mode 100644
index 0000000000..7053e2c013
--- /dev/null
+++ b/subprojects/proc-macro2-1-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = proc-macro2-1.0.84
+source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.84/download
+source_filename = proc-macro2-1.0.84.0.tar.gz
+source_hash = ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6
+#method = cargo
+patch_directory = proc-macro2-1-rs
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
new file mode 100644
index 0000000000..6e7ea69049
--- /dev/null
+++ b/subprojects/quote-1-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = quote-1.0.36
+source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
+source_filename = quote-1.0.36.0.tar.gz
+source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
+#method = cargo
+patch_directory = quote-1-rs
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
new file mode 100644
index 0000000000..13ffdac3c3
--- /dev/null
+++ b/subprojects/syn-2-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = syn-2.0.66
+source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
+source_filename = syn-2.0.66.0.tar.gz
+source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
+#method = cargo
+patch_directory = syn-2-rs
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
new file mode 100644
index 0000000000..4609f96ed9
--- /dev/null
+++ b/subprojects/unicode-ident-1-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = unicode-ident-1.0.12
+source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
+source_filename = unicode-ident-1.0.12.tar.gz
+source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
+#method = cargo
+patch_directory = unicode-ident-1-rs
diff --git a/subprojects/unicode-ident-1-rs/meson.build b/subprojects/unicode-ident-1-rs/meson.build
new file mode 100644
index 0000000000..54f2376854
--- /dev/null
+++ b/subprojects/unicode-ident-1-rs/meson.build
@@ -0,0 +1,20 @@
+project('unicode-ident-1-rs', 'rust',
+  version: '1.0.12',
+  license: '(MIT OR Apache-2.0) AND Unicode-DFS-2016',
+  default_options: [])
+
+_unicode_ident_rs = static_library(
+  'unicode_ident',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [],
+  native: true,
+)
+
+unicode_ident_dep = declare_dependency(
+  link_with: _unicode_ident_rs,
+)
+
+meson.override_dependency('unicode-ident-1-rs', unicode_ident_dep, native: true)
-- 
γαῖα πυρί μιχθήτω


