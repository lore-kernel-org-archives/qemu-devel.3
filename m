Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA24CEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so06c-0001iy-Ad; Tue, 10 Sep 2024 08:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so064-00005q-SX
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:54 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so061-0004sk-3i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:51 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c3ed267a7bso962626a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971748; x=1726576548; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HqIM87fhTw43SqGt2W5ZH8rBPddGb+YRrinjrz5mpkc=;
 b=QputvzsoSfsiqdXb8zDIdn+mkL37ixAvr8B7t//W7PrRMbBlufC0rwwCPfRpmzDi+j
 83qCm63WOSqLYxTrvq1jnDSgKCeVzRa2gWZmveLBpZsEmGWPBZ/i/DBtzwK3VKFXTl84
 UZdGv1QEvTUPfwm4cYSyfeiosAnJSzD69wyObt+NCes4Iia4RVnysHuJ3iL9d3v4Rpmk
 yNGyEvZMI/j9tQJrP4ogK7xmpIXbUkfwZghbLjNxZ4oVce9SioCgLmullHrnXEQrrCpr
 8whoxdiv0mRrsNn4s8+fbB1aqcO61Fw7GJ+IxdZnssG4vRnr4t2qCyMWxA5NM9JFgbwo
 i5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971748; x=1726576548;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqIM87fhTw43SqGt2W5ZH8rBPddGb+YRrinjrz5mpkc=;
 b=hnGpMEyKy12uOr99biUXPI6CFvcy5CUXCWdT/P82FU9rn1C53oL0/C+z1ex5yrF7W2
 WKLDhMewLIkAw4qo9ybejEqIRDjtD7vA4zyZQXVfeGmV3fCF1uAzq5GnKxRRTUmjIJ/F
 oMetC/q77al6uzDisWgU4kE9m5fYmpWaZPIGCAuI+u4B+XfWLc82JAJF3vDcGJtpNq6p
 8D4TT15ZJF4pNKlV8NyYeD3AdyndJ8FsdlO1z7p23Tg2hFyP4ppwzxLUuANXLCQsIgTl
 z8Ol7xmDTHCSLhZHTTO+ArYPql9Khgu4rW7gYSxtvotpJ6f69qI0Tp9fSX4BcZsR/hw4
 vwKw==
X-Gm-Message-State: AOJu0YwQlKDT7tqbPECAvvCE5h8qlT4DI8bB9M2A6kNtBcaCMg7vCcb+
 HPbBUPdwHt/+Jgaw01n/espuj9hLEPgFUPsF2TF3bK0TZJLIxQziSG6pDsgmvSDKEfkEBH8zBz1
 5lBM=
X-Google-Smtp-Source: AGHT+IFIlHTxWcT65LhvWE8xQiShRnuMzzmjzl08dpYM+tQX50KcQf26l8KNBD2tzn4j+bFAAC7O0w==
X-Received: by 2002:a05:6402:13cc:b0:5c3:1089:ff23 with SMTP id
 4fb4d7f45d1cf-5c3dc7c92bfmr9448357a12.35.1725971747310; 
 Tue, 10 Sep 2024 05:35:47 -0700 (PDT)
Received: from [127.0.1.1] (adsl-234.109.242.225.tellas.gr. [109.242.225.234])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cd7sm4242994a12.3.2024.09.10.05.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:35:47 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 10 Sep 2024 15:35:14 +0300
Subject: [PATCH v10 8/9] rust: add utility procedural macro crate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-rust-pl011-v10-8-85a89ee33c40@linaro.org>
References: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
In-Reply-To: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=16713;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=4ZjER4mNdE/IH7uNW5mSaBQ6glGgNblSnk+jHzN8dog=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm00RDBNOTFkR2pjQTFVQzRKZC8zZUxQRnhJOTEyCllRRnNJS3VybzlXOUhjQzM4
 ZTZKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnVBOURBQUt
 DUkIzS2Nkd2YzNEowUERGRC85aUJPaytiVWR3MzhDSjJiazk4Ni8vNUxINXlyWHkyRlluN0UxVg
 o5MmRqbE9LTklJVmJyVXZUWFZVQnFWdGV2czhmdmI0VHd1b0o1YkJFUytqSWpRbjR6aEczOGkwQ
 llKQTFvYWZFClR2U3JicXJMY0FTOUJSdDRoK3I0anJSSG1kRlV6elNZQ3lMQXJyclFISFVNYUdH
 ZGVOZzE4bXozMEtWd1FRMTgKaWdrajRDS1NwTWdYVXFQR2F0VVRML3NyOUczWDRBOFhQN0NmK3E
 0a2tOc1hUQUhEajhJTFdUeGFnOEkwQ3hHbgpzamhJYnFTZ3VRSlZOQXBPRVdCQXh3SGREelBZQT
 dCaFZQNHgwcytxRVczUVpVUkhjdW1yR1czdXhpSjhScnhaCjlVWnhDaWFDTmFNUWdHZVVVZG5vZ
 nNVRUkwMHFWWGY4Qmcwa09Hem5YSDRUYXFZTGVQd0h5MGVVdWU0TzVZRlYKaytRVkZ3RlVNcFND
 dk00NHhqdzNlbTVxWW9IUEFmbC9lODdrTE12QUt4OFNpOTRWLzd4WVArYUF4ZEdqMXN5WAo5R2c
 1L1dnYXByZVV4NzViTlZXQ1lJYksydGo0R21ORDJidk1KQ3M0VzJWZ0hsaEduR3hMbmlVU05sa1
 JJYmJwCjhXcS9GT3NOV1VjcmsvT0c3TGt5d0s2aG1CQ3F5L291UE9Wei9LUzZxQjdiN1lZeHROR
 lJOdWk2WlVJWjkwZkIKZTZibkhwNHQ5TGtSTGNYM1NGc1RHd0YrQXd6VTNiRS94NVQ5dnJ6OFB0
 Zjd0bUpISjU5V0VSZU9SUmpVQkl5Lwp3WjhxWjF2SkMwTklHMWpOMlNjSlh2L1ZTK09ydnlZSUF
 RNzN6QnNUTTVodklScGVVVVdGMDFuL2MxaFZpb0JNCm45cTRJZz09Cj1tQitiCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                                        |  1 +
 rust/meson.build                                   |  1 +
 rust/qemu-api-macros/Cargo.lock                    | 47 ++++++++++++++++++++++
 rust/qemu-api-macros/Cargo.toml                    | 25 ++++++++++++
 rust/qemu-api-macros/README.md                     |  1 +
 rust/qemu-api-macros/meson.build                   | 25 ++++++++++++
 rust/qemu-api-macros/src/lib.rs                    | 43 ++++++++++++++++++++
 rust/qemu-api/meson.build                          |  3 ++
 scripts/archive-source.sh                          |  4 +-
 scripts/make-release                               |  3 +-
 subprojects/.gitignore                             |  4 ++
 .../packagefiles/proc-macro2-1-rs/meson.build      | 31 ++++++++++++++
 subprojects/packagefiles/quote-1-rs/meson.build    | 29 +++++++++++++
 subprojects/packagefiles/syn-2-rs/meson.build      | 40 ++++++++++++++++++
 subprojects/proc-macro2-1-rs.wrap                  |  7 ++++
 subprojects/quote-1-rs.wrap                        |  7 ++++
 subprojects/syn-2-rs.wrap                          |  7 ++++
 subprojects/unicode-ident-1-rs.wrap                |  7 ++++
 subprojects/unicode-ident-1-rs/meson.build         | 20 +++++++++
 19 files changed, 303 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d35e9f6b20bb23c7580de488ebaabc6c031343d2..727f3a7a2cfe600ffdb861bafada7db415d020e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3352,6 +3352,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/qemu-api
+F: rust/qemu-api-macros
 F: rust/rustfmt.toml
 
 SLIRP
diff --git a/rust/meson.build b/rust/meson.build
index 4a58d106b1dd1d7bee39dd129f57ddb5a95bd9b7..7a32b1b195083571931ad589965c10ddaf6383b1 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -1 +1,2 @@
+subdir('qemu-api-macros')
 subdir('qemu-api')
diff --git a/rust/qemu-api-macros/Cargo.lock b/rust/qemu-api-macros/Cargo.lock
new file mode 100644
index 0000000000000000000000000000000000000000..fdc0fce116c795da63fff3cfcddab164c98d47fa
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
index 0000000000000000000000000000000000000000..144cc3650fa04b2fa35a1185d970e1bab210a4eb
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
index 0000000000000000000000000000000000000000..f60f54ac4be08ccfbcfea8e21ceb15d25012dfc3
--- /dev/null
+++ b/rust/qemu-api-macros/README.md
@@ -0,0 +1 @@
+# `qemu-api-macros` - Utility macros for defining QEMU devices
diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
new file mode 100644
index 0000000000000000000000000000000000000000..48af91ed389120ddd6e15f6ee002f5da7063e329
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
index 0000000000000000000000000000000000000000..331bc9e215e0115191865cb8a29c4605e03fdaa8
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
+                        ::qemu_api::bindings::module_init_type_MODULE_INIT_QOM
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
index 1609f2dbb3933a8460ed0c95e7008be3969a11bd..6884d0fe4e3aa4a25efc72ca987004130b2ffee7 100644
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
index 65af8063e4bddc89ea4bdf05716ebc9ed108e7fb..6239cf18153e926a548ae8af7307ef01de082cfc 100755
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
index 6e0433de24dc8a37cefae6d828a2958309bbf1c1..076e5889537e19f0924e35b1679acdd20e1022fc 100755
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
index adca0266be69181151e77639096380b3aba4abcf..b6888182ca4e5b59b90cfde1792a5770e9a5240a 100644
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
index 0000000000000000000000000000000000000000..818ec59336b81ac7dd76a2317357c7b276cf490b
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
index 0000000000000000000000000000000000000000..d36609bd3c8aa7df95eb292661dd293fbe7320b0
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
index 0000000000000000000000000000000000000000..a53335f3092e06723039513a1bf5a0d35b4afcd7
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
index 0000000000000000000000000000000000000000..7053e2c013c6d6be9efa5dd99cb43b5906a772d3
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
index 0000000000000000000000000000000000000000..6e7ea69049f83d51190cef867cec1adc202f77db
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
index 0000000000000000000000000000000000000000..13ffdac3c3b1bbed2f568a2638c3dfe20dbc0748
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
index 0000000000000000000000000000000000000000..4609f96ed970a64bf0f9d06b29bcc9985a907c3d
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
index 0000000000000000000000000000000000000000..54f2376854504236689604f8ab08d351e4cceae9
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
2.45.2


