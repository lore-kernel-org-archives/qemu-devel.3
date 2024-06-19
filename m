Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 20:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK1i7-0002lz-CB; Wed, 19 Jun 2024 16:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1i5-0002iP-ND
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:13 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sK1i0-0001l0-07
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 16:15:13 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so121269f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718828106; x=1719432906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6YXo207rlhGlbaRmzKkyQGTmva7fJtphs5B/iUxjak=;
 b=GjqlzQdZl05KF28wm/mCEnYj426DRlNdh+6CK5BM4bDtRy2TQ3jbitiKZ6sEcXKDwe
 olUMp0S0nARL9xHOf+/hJCg6BR1JS7ibmosGVClP7K2OEuhDhRe22epiVMNRnGPzbD3p
 8kYJlXaVyWFF9OaPO4h6WDMgG7K0b8fwGjc5kHUYv4/wkSYK/z5Qiam/ZZv3H/WU67Rk
 rS+8fTdUAk68pU8YVQQhIhDSIvIU/iPnc/PArRYSP49Hl1qbNboxr4iFh8KE5/Q7+/nx
 VH0gX+BUGu3jC7vXHwgcczivIICDKc67hi7ajFL29mnyAKtkCtk6c2kAUUxrRNKJlxb7
 /ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718828106; x=1719432906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6YXo207rlhGlbaRmzKkyQGTmva7fJtphs5B/iUxjak=;
 b=a9IWrOyuTccee+oHqXIJTQztFl8vLUuMmSk3UwnhvEgUhstM0nuh6/pDX6OfBtYKRt
 apr71jIjjDoZfYnHdkh24QcyzbZn89q6CPZcUvrIXJZ02FuBFr/QRJYOU+g3Aa9ERMXT
 uOvIcFPnkFmsv1o2Mip06PwyjtJcr/JtOuV+KEYVlpnEScJoAA7ScdVS0cfzI4RhfxHD
 gL13BLaFLN9SHGJM10A7PnnMBADICQZUd/Nrq8ybowhqbLqY+akJuUWS7uowinmBKmzZ
 1faJPNbqLw2Y6QEEQBQ2XK4Q5J3kgoWWgxZV3qOeQIDtJr6V0zHfkpa1ggKE+mbwzBZq
 XEog==
X-Gm-Message-State: AOJu0Yyy5dTnGxov1TtZgWoh4+hf8utagukafDq2ecr8VN3p1wELEyfN
 5x4esPAtDHvDkuFKiuCJiY62Eiq1GtWF8XalK6dz1E+9lMmKcZ4OGqpNiUz9A8hItqcitkgWNG3
 wIuI=
X-Google-Smtp-Source: AGHT+IFZlSTcnlvm+PtrRdz5wgwTg9FDRGty822QRxFAmLizGfvo7hl3k4spfrBVHowTxMCp4ISCpA==
X-Received: by 2002:a5d:4e0a:0:b0:360:81f8:698 with SMTP id
 ffacd0b85a97d-363199905fcmr2594604f8f.58.1718828105417; 
 Wed, 19 Jun 2024 13:15:05 -0700 (PDT)
Received: from localhost.localdomain (adsl-103.37.6.162.tellas.gr.
 [37.6.162.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101aac6sm45623235e9.0.2024.06.19.13.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:15:05 -0700 (PDT)
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
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 3/5] rust: add PL011 device model
Date: Wed, 19 Jun 2024 23:14:00 +0300
Message-ID: <5fefd88e9d7e02fed5ae1037a25a4c04a9b8b1a9.1718827153.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

This commit adds a re-implementation of hw/char/pl011.c in Rust.

It uses generated Rust bindings (produced by `ninja
aarch64-softmmu-generated.rs`) to
register itself as a QOM type/class.

How to build:

1. Make sure rust, cargo and bindgen (cargo install bindgen-cli) are
   installed
2. Configure a QEMU build with:
   --enable-system --target-list=aarch64-softmmu --enable-with-rust
3. Launching a VM with qemu-system-aarch64 should use the Rust version
   of the pl011 device (unless it is not set up so in hw/arm/virt.c; the
   type of the UART device is hardcoded).

   To confirm, inspect `info qom-tree` in the monitor and look for an
   `x-pl011-rust` device.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 MAINTAINERS                    |   7 +
 meson.build                    |   4 +
 rust/.cargo/config.toml        |   2 +
 rust/meson.build               |   2 +
 rust/pl011/.gitignore          |   2 +
 rust/pl011/Cargo.lock          | 120 +++++++
 rust/pl011/Cargo.toml          |  66 ++++
 rust/pl011/README.md           |  42 +++
 rust/pl011/build.rs            |  44 +++
 rust/pl011/deny.toml           |  57 ++++
 rust/pl011/meson.build         |   7 +
 rust/pl011/rustfmt.toml        |   1 +
 rust/pl011/src/definitions.rs  |  95 ++++++
 rust/pl011/src/device.rs       | 531 ++++++++++++++++++++++++++++++
 rust/pl011/src/device_class.rs |  95 ++++++
 rust/pl011/src/generated.rs    |   5 +
 rust/pl011/src/lib.rs          | 581 +++++++++++++++++++++++++++++++++
 rust/pl011/src/memory_ops.rs   |  38 +++
 rust/rustfmt.toml              |   7 +
 19 files changed, 1706 insertions(+)
 create mode 100644 rust/.cargo/config.toml
 create mode 100644 rust/pl011/.gitignore
 create mode 100644 rust/pl011/Cargo.lock
 create mode 100644 rust/pl011/Cargo.toml
 create mode 100644 rust/pl011/README.md
 create mode 100644 rust/pl011/build.rs
 create mode 100644 rust/pl011/deny.toml
 create mode 100644 rust/pl011/meson.build
 create mode 120000 rust/pl011/rustfmt.toml
 create mode 100644 rust/pl011/src/definitions.rs
 create mode 100644 rust/pl011/src/device.rs
 create mode 100644 rust/pl011/src/device_class.rs
 create mode 100644 rust/pl011/src/generated.rs
 create mode 100644 rust/pl011/src/lib.rs
 create mode 100644 rust/pl011/src/memory_ops.rs
 create mode 100644 rust/rustfmt.toml

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f36bb3e9a..1420d83402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1181,6 +1181,11 @@ F: include/hw/*/microbit*.h
 F: tests/qtest/microbit-test.c
 F: docs/system/arm/nrf.rst
 
+ARM PL011 Rust device
+M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+S: Maintained
+F: rust/pl011/
+
 AVR Machines
 -------------
 
@@ -4230,6 +4235,8 @@ F: scripts/cargo_wrapper.py
 F: rust/meson.build
 F: rust/wrapper.h
 F: rust/.gitignore
+F: rust/rustfmt.toml
+F: rust/.cargo/config.toml
 
 Miscellaneous
 -------------
diff --git a/meson.build b/meson.build
index 2b305e745a..ca40a39ad7 100644
--- a/meson.build
+++ b/meson.build
@@ -296,6 +296,10 @@ if get_option('with_rust').allowed()
 endif
 with_rust = cargo.found()
 
+if with_rust
+  subdir('rust')
+endif
+
 # default flags for all hosts
 # We use -fwrapv to tell the compiler that we require a C dialect where
 # left shift of signed integers is well defined and has the expected
diff --git a/rust/.cargo/config.toml b/rust/.cargo/config.toml
new file mode 100644
index 0000000000..241210ffa7
--- /dev/null
+++ b/rust/.cargo/config.toml
@@ -0,0 +1,2 @@
+[build]
+rustflags = ["-Crelocation-model=pic", "-Ctarget-feature=+crt-static"]
diff --git a/rust/meson.build b/rust/meson.build
index 435abd3e1c..e21309d922 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -109,6 +109,8 @@ endif
 # bindgen dependency is declared.
 rust_hw_target_list = {}
 
+subdir('pl011')
+
 foreach rust_hw_target, rust_hws: rust_hw_target_list
   foreach rust_hw_dev: rust_hws
     output = meson.current_build_dir() / rust_target_triple / rs_build_type / rust_hw_dev['output']
diff --git a/rust/pl011/.gitignore b/rust/pl011/.gitignore
new file mode 100644
index 0000000000..d8db38b44e
--- /dev/null
+++ b/rust/pl011/.gitignore
@@ -0,0 +1,2 @@
+# Ignore generated bindings file overrides.
+src/generated.rs.inc
diff --git a/rust/pl011/Cargo.lock b/rust/pl011/Cargo.lock
new file mode 100644
index 0000000000..d0fa46f9f5
--- /dev/null
+++ b/rust/pl011/Cargo.lock
@@ -0,0 +1,120 @@
+# This file is automatically @generated by Cargo.
+# It is not intended for manual editing.
+version = 3
+
+[[package]]
+name = "arbitrary-int"
+version = "1.2.7"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d"
+
+[[package]]
+name = "bilge"
+version = "0.2.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57"
+dependencies = [
+ "arbitrary-int",
+ "bilge-impl",
+]
+
+[[package]]
+name = "bilge-impl"
+version = "0.2.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8"
+dependencies = [
+ "itertools",
+ "proc-macro-error",
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
+[[package]]
+name = "either"
+version = "1.12.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
+
+[[package]]
+name = "itertools"
+version = "0.11.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57"
+dependencies = [
+ "either",
+]
+
+[[package]]
+name = "pl011"
+version = "0.1.0"
+dependencies = [
+ "arbitrary-int",
+ "bilge",
+ "bilge-impl",
+]
+
+[[package]]
+name = "proc-macro-error"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c"
+dependencies = [
+ "proc-macro-error-attr",
+ "proc-macro2",
+ "quote",
+ "version_check",
+]
+
+[[package]]
+name = "proc-macro-error-attr"
+version = "1.0.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "version_check",
+]
+
+[[package]]
+name = "proc-macro2"
+version = "1.0.84"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "ec96c6a92621310b51366f1e28d05ef11489516e93be030060e5fc12024a49d6"
+dependencies = [
+ "unicode-ident",
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
+version = "2.0.66"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5"
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
+
+[[package]]
+name = "version_check"
+version = "0.9.4"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "49874b5167b65d7193b8aba1567f5c7d93d001cafc34600cee003eda787e483f"
diff --git a/rust/pl011/Cargo.toml b/rust/pl011/Cargo.toml
new file mode 100644
index 0000000000..db74f2b59f
--- /dev/null
+++ b/rust/pl011/Cargo.toml
@@ -0,0 +1,66 @@
+[package]
+name = "pl011"
+version = "0.1.0"
+edition = "2021"
+authors = ["Manos Pitsidianakis <manos.pitsidianakis@linaro.org>"]
+license = "GPL-2.0 OR GPL-3.0-or-later"
+readme = "README.md"
+homepage = "https://www.qemu.org"
+description = "pl011 device model for QEMU"
+repository = "https://gitlab.com/epilys/rust-for-qemu"
+resolver = "2"
+publish = false
+keywords = []
+categories = []
+
+[lib]
+crate-type = ["staticlib"]
+
+# bilge deps included here to include them with docs
+[dependencies]
+arbitrary-int = { version = "1.2.7" }
+bilge = { version = "0.2.0" }
+bilge-impl = { version = "0.2.0" }
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
diff --git a/rust/pl011/README.md b/rust/pl011/README.md
new file mode 100644
index 0000000000..54efe3c0cb
--- /dev/null
+++ b/rust/pl011/README.md
@@ -0,0 +1,42 @@
+# PL011 QEMU Device Model
+
+This library implements a device model for the PrimeCell® UART (PL011)
+device in QEMU.
+
+The C bindings were generated for commit `01782d6b29`:
+
+```console
+$ git describe 01782d6b29
+v9.0.0-769-g01782d6b29
+```
+
+with `bindgen`, using this build target:
+
+```console
+$ ninja aarch64-softmmu-generated.rs
+```
+
+## Build static lib
+
+```sh
+cargo build --target x86_64-unknown-linux-gnu
+```
+
+Replace host target triplet if necessary.
+
+## Generate Rust documentation
+
+To generate docs for this crate, including private items:
+
+```sh
+cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+```
+
+To include direct dependencies like `bilge` (bitmaps for register types):
+
+```sh
+cargo tree --depth 1 -e normal --prefix none \
+ | cut -d' ' -f1 \
+ | xargs printf -- '-p %s\n' \
+ | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+```
diff --git a/rust/pl011/build.rs b/rust/pl011/build.rs
new file mode 100644
index 0000000000..169516d8ab
--- /dev/null
+++ b/rust/pl011/build.rs
@@ -0,0 +1,44 @@
+use std::{env, path::Path};
+
+fn main() {
+    println!("cargo::rerun-if-env-changed=MESON_BUILD_DIR");
+    println!("cargo::rerun-if-env-changed=MESON_BUILD_ROOT");
+    println!("cargo::rerun-if-changed=src/generated.rs.inc");
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
+        build_dir.push("aarch64-softmmu-generated.rs");
+        let generated_rs = build_dir;
+        assert!(
+            generated_rs.exists(),
+            "MESON_BUILD_ROOT/aarch64-softmmu-generated.rs does not exist on filesystem: {}",
+            generated_rs.display()
+        );
+        assert!(
+            generated_rs.is_file(),
+            "MESON_BUILD_ROOT/aarch64-softmmu-generated.rs is not a file: {}",
+            generated_rs.display()
+        );
+        out_dir.push("generated.rs");
+        std::fs::copy(generated_rs, out_dir).unwrap();
+        println!("cargo::rustc-cfg=MESON_GENERATED_RS");
+    } else if !Path::new("src/generated.rs.inc").exists() {
+        panic!(
+            "No generated C bindings found! Either build them manually with bindgen or with meson \
+             (`ninja aarch64-softmmu-generated.rs`) and copy them to src/generated.rs.inc, or build through meson."
+        );
+    }
+}
diff --git a/rust/pl011/deny.toml b/rust/pl011/deny.toml
new file mode 100644
index 0000000000..3992380509
--- /dev/null
+++ b/rust/pl011/deny.toml
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
diff --git a/rust/pl011/meson.build b/rust/pl011/meson.build
new file mode 100644
index 0000000000..70d1ca1148
--- /dev/null
+++ b/rust/pl011/meson.build
@@ -0,0 +1,7 @@
+rust_pl011 = {
+  'name': 'rust_pl011_cargo',
+  'dirname': 'pl011',
+  'output': 'libpl011.a',
+  }
+
+rust_hw_target_list += {'aarch64-softmmu': [rust_pl011]}
diff --git a/rust/pl011/rustfmt.toml b/rust/pl011/rustfmt.toml
new file mode 120000
index 0000000000..39f97b043b
--- /dev/null
+++ b/rust/pl011/rustfmt.toml
@@ -0,0 +1 @@
+../rustfmt.toml
\ No newline at end of file
diff --git a/rust/pl011/src/definitions.rs b/rust/pl011/src/definitions.rs
new file mode 100644
index 0000000000..f02604c114
--- /dev/null
+++ b/rust/pl011/src/definitions.rs
@@ -0,0 +1,95 @@
+//! Definitions required by QEMU when registering the device.
+
+use core::{ffi::CStr, mem::MaybeUninit, ptr::NonNull};
+
+use crate::{device::PL011State, device_class::pl011_class_init, generated::*};
+
+pub const TYPE_PL011: &CStr = unsafe { CStr::from_bytes_with_nul_unchecked(b"x-pl011-rust\0") };
+
+pub const PL011_ARM_INFO: TypeInfo = TypeInfo {
+    name: TYPE_PL011.as_ptr(),
+    parent: TYPE_SYS_BUS_DEVICE.as_ptr(),
+    instance_size: core::mem::size_of::<PL011State>(),
+    instance_align: core::mem::align_of::<PL011State>(),
+    instance_init: Some(pl011_init),
+    instance_post_init: None,
+    instance_finalize: None,
+    abstract_: false,
+    class_size: 0,
+    class_init: Some(pl011_class_init),
+    class_base_init: None,
+    class_data: core::ptr::null_mut(),
+    interfaces: core::ptr::null_mut(),
+};
+
+pub const VMSTATE_PL011: VMStateDescription = VMStateDescription {
+    name: PL011_ARM_INFO.name,
+    unmigratable: true,
+    ..unsafe { MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
+};
+//version_id : 2,
+//minimum_version_id : 2,
+//post_load : pl011_post_load,
+//fields = (const VMStateField[]) {
+//    VMSTATE_UINT32(readbuff, PL011State),
+//    VMSTATE_UINT32(flags, PL011State),
+//    VMSTATE_UINT32(lcr, PL011State),
+//    VMSTATE_UINT32(rsr, PL011State),
+//    VMSTATE_UINT32(cr, PL011State),
+//    VMSTATE_UINT32(dmacr, PL011State),
+//    VMSTATE_UINT32(int_enabled, PL011State),
+//    VMSTATE_UINT32(int_level, PL011State),
+//    VMSTATE_UINT32_ARRAY(read_fifo, PL011State, PL011_FIFO_DEPTH),
+//    VMSTATE_UINT32(ilpr, PL011State),
+//    VMSTATE_UINT32(ibrd, PL011State),
+//    VMSTATE_UINT32(fbrd, PL011State),
+//    VMSTATE_UINT32(ifl, PL011State),
+//    VMSTATE_INT32(read_pos, PL011State),
+//    VMSTATE_INT32(read_count, PL011State),
+//    VMSTATE_INT32(read_trigger, PL011State),
+//    VMSTATE_END_OF_LIST()
+//},
+//.subsections = (const VMStateDescription * const []) {
+//    &vmstate_pl011_clock,
+//    NULL
+//}
+
+#[no_mangle]
+pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
+    assert!(!obj.is_null());
+    let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
+    state.as_mut().init();
+}
+
+use crate::generated::module_init_type_MODULE_INIT_QOM;
+
+#[macro_export]
+macro_rules! module_init {
+    ($func:expr, $type:expr) => {
+        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
+        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
+        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
+        pub static LOAD_MODULE: extern "C" fn() = {
+            assert!($type < $crate::generated::module_init_type_MODULE_INIT_MAX);
+
+            extern "C" fn __load() {
+                // ::std::panic::set_hook(::std::boxed::Box::new(|_| {}));
+
+                unsafe {
+                    $crate::generated::register_module_init(Some($func), $type);
+                }
+            }
+
+            __load
+        };
+    };
+}
+
+#[no_mangle]
+unsafe extern "C" fn register_type() {
+    crate::generated::type_register_static(&PL011_ARM_INFO);
+}
+
+module_init! {
+    register_type, module_init_type_MODULE_INIT_QOM
+}
diff --git a/rust/pl011/src/device.rs b/rust/pl011/src/device.rs
new file mode 100644
index 0000000000..405f590f03
--- /dev/null
+++ b/rust/pl011/src/device.rs
@@ -0,0 +1,531 @@
+use core::{
+    ffi::{c_int, c_uchar, c_uint, c_void, CStr},
+    mem::MaybeUninit,
+    ptr::{addr_of, addr_of_mut, NonNull},
+};
+
+use crate::{
+    definitions::PL011_ARM_INFO,
+    generated::{self, *},
+    memory_ops::PL011_OPS,
+    registers::{self, Interrupt},
+    RegisterOffset,
+};
+
+static PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
+
+const DATA_BREAK: u32 = 1 << 10;
+
+/// QEMU sourced constant.
+pub const PL011_FIFO_DEPTH: usize = 16_usize;
+
+#[repr(C)]
+#[derive(Debug)]
+/// PL011 Device Model in QEMU
+pub struct PL011State {
+    pub parent_obj: SysBusDevice,
+    pub iomem: MemoryRegion,
+    pub readbuff: u32,
+    #[doc(alias = "fr")]
+    pub flags: registers::Flags,
+    #[doc(alias = "lcr")]
+    pub line_control: registers::LineControl,
+    #[doc(alias = "rsr")]
+    pub receive_status_error_clear: registers::ReceiveStatusErrorClear,
+    #[doc(alias = "cr")]
+    pub control: registers::Control,
+    pub dmacr: u32,
+    pub int_enabled: u32,
+    pub int_level: u32,
+    pub read_fifo: [u32; PL011_FIFO_DEPTH],
+    pub ilpr: u32,
+    pub ibrd: u32,
+    pub fbrd: u32,
+    pub ifl: u32,
+    pub read_pos: usize,
+    pub read_count: usize,
+    pub read_trigger: usize,
+    #[doc(alias = "chr")]
+    pub char_backend: CharBackend,
+    /// QEMU interrupts
+    ///
+    /// ```text
+    ///  * sysbus MMIO region 0: device registers
+    ///  * sysbus IRQ 0: `UARTINTR` (combined interrupt line)
+    ///  * sysbus IRQ 1: `UARTRXINTR` (receive FIFO interrupt line)
+    ///  * sysbus IRQ 2: `UARTTXINTR` (transmit FIFO interrupt line)
+    ///  * sysbus IRQ 3: `UARTRTINTR` (receive timeout interrupt line)
+    ///  * sysbus IRQ 4: `UARTMSINTR` (momem status interrupt line)
+    ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
+    /// ```
+    #[doc(alias = "irq")]
+    pub interrupts: [qemu_irq; 6usize],
+    #[doc(alias = "clk")]
+    pub clock: NonNull<Clock>,
+    #[doc(alias = "migrate_clk")]
+    pub migrate_clock: bool,
+}
+
+impl PL011State {
+    pub fn init(&mut self) {
+        unsafe {
+            memory_region_init_io(
+                addr_of_mut!(self.iomem),
+                addr_of_mut!(*self).cast::<Object>(),
+                &PL011_OPS,
+                addr_of_mut!(*self).cast::<c_void>(),
+                PL011_ARM_INFO.name,
+                0x1000,
+            );
+            let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
+            let dev = addr_of_mut!(*self).cast::<DeviceState>();
+            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
+            for irq in self.interrupts.iter_mut() {
+                sysbus_init_irq(sbd, irq);
+            }
+            const CLK_NAME: &CStr = unsafe { CStr::from_bytes_with_nul_unchecked(b"clk\0") };
+            self.clock = NonNull::new(qdev_init_clock_in(
+                dev,
+                CLK_NAME.as_ptr(),
+                None, /* pl011_clock_update */
+                addr_of_mut!(*self).cast::<c_void>(),
+                ClockEvent_ClockUpdate,
+            ))
+            .unwrap();
+        }
+    }
+
+    pub fn read(&mut self, offset: hwaddr, _size: core::ffi::c_uint) -> u64 {
+        use RegisterOffset::*;
+
+        match RegisterOffset::try_from(offset) {
+            Err(v) if (0x3f8..0x400).contains(&v) => {
+                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
+            }
+            Err(_) => {
+                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                0
+            }
+            Ok(DR) => {
+                // s->flags &= ~PL011_FLAG_RXFF;
+                self.flags.set_receive_fifo_full(false);
+                let c = self.read_fifo[self.read_pos];
+                if self.read_count > 0 {
+                    self.read_count -= 1;
+                    self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
+                }
+                if self.read_count == 0 {
+                    // self.flags |= PL011_FLAG_RXFE;
+                    self.flags.set_receive_fifo_empty(true);
+                }
+                if self.read_count + 1 == self.read_trigger {
+                    //self.int_level &= ~ INT_RX;
+                    self.int_level &= !registers::INT_RX;
+                }
+                // Update error bits.
+                self.receive_status_error_clear = c.to_be_bytes()[3].into();
+                self.update();
+                unsafe { qemu_chr_fe_accept_input(&mut self.char_backend) };
+                c.into()
+            }
+            Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
+            Ok(FR) => u16::from(self.flags).into(),
+            Ok(FBRD) => self.fbrd.into(),
+            Ok(ILPR) => self.ilpr.into(),
+            Ok(IBRD) => self.ibrd.into(),
+            Ok(LCR_H) => u16::from(self.line_control).into(),
+            Ok(CR) => {
+                // We exercise our self-control.
+                u16::from(self.control).into()
+            }
+            Ok(FLS) => self.ifl.into(),
+            Ok(IMSC) => self.int_enabled.into(),
+            Ok(RIS) => self.int_level.into(),
+            Ok(MIS) => u64::from(self.int_level & self.int_enabled),
+            Ok(ICR) => {
+                // "The UARTICR Register is the interrupt clear register and is write-only"
+                // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
+                0
+            }
+            Ok(DMACR) => self.dmacr.into(),
+        }
+    }
+
+    pub fn write(&mut self, offset: hwaddr, value: u64) {
+        // eprintln!("write offset {offset} value {value}");
+        use RegisterOffset::*;
+        let value: u32 = value as u32;
+        match RegisterOffset::try_from(offset) {
+            Err(_bad_offset) => {
+                eprintln!("write bad offset {offset} value {value}");
+            }
+            Ok(DR) => {
+                // ??? Check if transmitter is enabled.
+                let ch: u8 = value as u8;
+                // XXX this blocks entire thread. Rewrite to use
+                // qemu_chr_fe_write and background I/O callbacks
+                unsafe {
+                    qemu_chr_fe_write_all(addr_of_mut!(self.char_backend), &ch, 1);
+                }
+                self.loopback_tx(value);
+                self.int_level |= registers::INT_TX;
+                self.update();
+            }
+            Ok(RSR) => {
+                self.receive_status_error_clear = 0.into();
+            }
+            Ok(FR) => {
+                // flag writes are ignored
+            }
+            Ok(ILPR) => {
+                self.ilpr = value;
+            }
+            Ok(IBRD) => {
+                self.ibrd = value;
+            }
+            Ok(FBRD) => {
+                self.fbrd = value;
+            }
+            Ok(LCR_H) => {
+                let value = value as u16;
+                let new_val: registers::LineControl = value.into();
+                // Reset the FIFO state on FIFO enable or disable
+                if bool::from(self.line_control.fifos_enabled())
+                    ^ bool::from(new_val.fifos_enabled())
+                {
+                    self.reset_fifo();
+                }
+                if self.line_control.send_break() ^ new_val.send_break() {
+                    let mut break_enable: c_int = new_val.send_break().into();
+                    unsafe {
+                        qemu_chr_fe_ioctl(
+                            addr_of_mut!(self.char_backend),
+                            CHR_IOCTL_SERIAL_SET_BREAK as i32,
+                            addr_of_mut!(break_enable).cast::<c_void>(),
+                        );
+                    }
+                    self.loopback_break(break_enable > 0);
+                }
+                self.line_control = new_val;
+                self.set_read_trigger();
+            }
+            Ok(CR) => {
+                // ??? Need to implement the enable bit.
+                let value = value as u16;
+                self.control = value.into();
+                self.loopback_mdmctrl();
+            }
+            Ok(FLS) => {
+                self.ifl = value;
+                self.set_read_trigger();
+            }
+            Ok(IMSC) => {
+                self.int_enabled = value;
+                self.update();
+            }
+            Ok(RIS) => {}
+            Ok(MIS) => {}
+            Ok(ICR) => {
+                self.int_level &= !value;
+                self.update();
+            }
+            Ok(DMACR) => {
+                self.dmacr = value;
+                if value & 3 > 0 {
+                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
+                    eprintln!("pl011: DMA not implemented");
+                }
+            }
+        }
+    }
+
+    #[inline]
+    fn loopback_tx(&mut self, value: u32) {
+        if !self.loopback_enabled() {
+            return;
+        }
+
+        // Caveat:
+        //
+        // In real hardware, TX loopback happens at the serial-bit level
+        // and then reassembled by the RX logics back into bytes and placed
+        // into the RX fifo. That is, loopback happens after TX fifo.
+        //
+        // Because the real hardware TX fifo is time-drained at the frame
+        // rate governed by the configured serial format, some loopback
+        // bytes in TX fifo may still be able to get into the RX fifo
+        // that could be full at times while being drained at software
+        // pace.
+        //
+        // In such scenario, the RX draining pace is the major factor
+        // deciding which loopback bytes get into the RX fifo, unless
+        // hardware flow-control is enabled.
+        //
+        // For simplicity, the above described is not emulated.
+        self.put_fifo(value);
+    }
+
+    fn loopback_mdmctrl(&mut self) {
+        if !self.loopback_enabled() {
+            return;
+        }
+
+        /*
+         * Loopback software-driven modem control outputs to modem status inputs:
+         *   FR.RI  <= CR.Out2
+         *   FR.DCD <= CR.Out1
+         *   FR.CTS <= CR.RTS
+         *   FR.DSR <= CR.DTR
+         *
+         * The loopback happens immediately even if this call is triggered
+         * by setting only CR.LBE.
+         *
+         * CTS/RTS updates due to enabled hardware flow controls are not
+         * dealt with here.
+         */
+
+        //fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
+        //                  PL011_FLAG_DSR | PL011_FLAG_CTS);
+        //fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
+        //fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
+        //fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
+        //fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
+        //
+        self.flags.set_ring_indicator(self.control.out_2());
+        self.flags.set_data_carrier_detect(self.control.out_1());
+        self.flags.set_clear_to_send(self.control.request_to_send());
+        self.flags
+            .set_data_set_ready(self.control.data_transmit_ready());
+
+        // Change interrupts based on updated FR
+        let mut il = self.int_level;
+
+        il &= !Interrupt::MS;
+        //il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
+        //il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
+        //il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
+        //il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
+
+        if self.flags.data_set_ready() {
+            il |= Interrupt::DSR as u32;
+        }
+        if self.flags.data_carrier_detect() {
+            il |= Interrupt::DCD as u32;
+        }
+        if self.flags.clear_to_send() {
+            il |= Interrupt::CTS as u32;
+        }
+        if self.flags.ring_indicator() {
+            il |= Interrupt::RI as u32;
+        }
+        self.int_level = il;
+        self.update();
+    }
+
+    fn loopback_break(&mut self, enable: bool) {
+        if enable {
+            self.loopback_tx(DATA_BREAK);
+        }
+    }
+
+    fn set_read_trigger(&mut self) {
+        //#if 0
+        //    /* The docs say the RX interrupt is triggered when the FIFO exceeds
+        //       the threshold.  However linux only reads the FIFO in response to an
+        //       interrupt.  Triggering the interrupt when the FIFO is non-empty seems
+        //       to make things work.  */
+        //    if (s->lcr & LCR_FEN)
+        //        s->read_trigger = (s->ifl >> 1) & 0x1c;
+        //    else
+        //#endif
+        self.read_trigger = 1;
+    }
+
+    pub fn realize(&mut self) {
+        unsafe {
+            qemu_chr_fe_set_handlers(
+                addr_of_mut!(self.char_backend),
+                Some(pl011_can_receive),
+                Some(pl011_receive),
+                Some(pl011_event),
+                None,
+                addr_of_mut!(*self).cast::<c_void>(),
+                core::ptr::null_mut(),
+                true,
+            );
+        }
+    }
+
+    pub fn reset(&mut self) {
+        self.line_control.reset();
+        self.receive_status_error_clear.reset();
+        self.dmacr = 0;
+        self.int_enabled = 0;
+        self.int_level = 0;
+        self.ilpr = 0;
+        self.ibrd = 0;
+        self.fbrd = 0;
+        self.read_trigger = 1;
+        self.ifl = 0x12;
+        self.control.reset();
+        self.flags = 0.into();
+        self.reset_fifo();
+    }
+
+    pub fn reset_fifo(&mut self) {
+        self.read_count = 0;
+        self.read_pos = 0;
+
+        /* Reset FIFO flags */
+        self.flags.reset();
+    }
+
+    pub fn can_receive(&self) -> bool {
+        // trace_pl011_can_receive(s->lcr, s->read_count, r);
+        self.read_count < self.fifo_depth()
+    }
+
+    pub fn event(&mut self, event: QEMUChrEvent) {
+        if event == generated::QEMUChrEvent_CHR_EVENT_BREAK && !self.fifo_enabled() {
+            self.put_fifo(DATA_BREAK);
+            self.receive_status_error_clear.set_break_error(true);
+        }
+    }
+
+    #[inline]
+    pub fn fifo_enabled(&self) -> bool {
+        matches!(self.line_control.fifos_enabled(), registers::Mode::FIFO)
+    }
+
+    #[inline]
+    pub fn loopback_enabled(&self) -> bool {
+        self.control.enable_loopback()
+    }
+
+    #[inline]
+    pub fn fifo_depth(&self) -> usize {
+        // Note: FIFO depth is expected to be power-of-2
+        if self.fifo_enabled() {
+            return PL011_FIFO_DEPTH;
+        }
+        1
+    }
+
+    pub fn put_fifo(&mut self, value: c_uint) {
+        let depth = self.fifo_depth();
+        assert!(depth > 0);
+        let slot = (self.read_pos + self.read_count) & (depth - 1);
+        self.read_fifo[slot] = value;
+        self.read_count += 1;
+        // s->flags &= ~PL011_FLAG_RXFE;
+        self.flags.set_receive_fifo_empty(false);
+        if self.read_count == depth {
+            //s->flags |= PL011_FLAG_RXFF;
+            self.flags.set_receive_fifo_full(true);
+        }
+
+        if self.read_count == self.read_trigger {
+            self.int_level |= registers::INT_RX;
+            self.update();
+        }
+    }
+
+    pub fn update(&mut self) {
+        let flags = self.int_level & self.int_enabled;
+        for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
+            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
+        }
+    }
+}
+
+/// Which bits in the interrupt status matter for each outbound IRQ line ?
+pub const IRQMASK: [u32; 6] = [
+    /* combined IRQ */
+    Interrupt::E
+        | Interrupt::MS
+        | Interrupt::RT as u32
+        | Interrupt::TX as u32
+        | Interrupt::RX as u32,
+    Interrupt::RX as u32,
+    Interrupt::TX as u32,
+    Interrupt::RT as u32,
+    Interrupt::MS,
+    Interrupt::E,
+];
+
+pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
+    assert!(!opaque.is_null());
+    let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_ref().can_receive().into()
+}
+pub unsafe extern "C" fn pl011_receive(
+    opaque: *mut core::ffi::c_void,
+    buf: *const u8,
+    size: core::ffi::c_int,
+) {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    if state.as_ref().loopback_enabled() {
+        return;
+    }
+    if size > 0 {
+        assert!(!buf.is_null());
+        state.as_mut().put_fifo(*buf.cast::<c_uint>())
+    }
+}
+
+pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_mut().event(event)
+}
+
+pub const VMSTATE_PL011: VMStateDescription = VMStateDescription {
+    name: PL011_ARM_INFO.name,
+    unmigratable: true,
+    ..unsafe { MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
+};
+//version_id : 2,
+//minimum_version_id : 2,
+//post_load : pl011_post_load,
+//fields = (const VMStateField[]) {
+//    VMSTATE_UINT32(readbuff, PL011State),
+//    VMSTATE_UINT32(flags, PL011State),
+//    VMSTATE_UINT32(lcr, PL011State),
+//    VMSTATE_UINT32(rsr, PL011State),
+//    VMSTATE_UINT32(cr, PL011State),
+//    VMSTATE_UINT32(dmacr, PL011State),
+//    VMSTATE_UINT32(int_enabled, PL011State),
+//    VMSTATE_UINT32(int_level, PL011State),
+//    VMSTATE_UINT32_ARRAY(read_fifo, PL011State, PL011_FIFO_DEPTH),
+//    VMSTATE_UINT32(ilpr, PL011State),
+//    VMSTATE_UINT32(ibrd, PL011State),
+//    VMSTATE_UINT32(fbrd, PL011State),
+//    VMSTATE_UINT32(ifl, PL011State),
+//    VMSTATE_INT32(read_pos, PL011State),
+//    VMSTATE_INT32(read_count, PL011State),
+//    VMSTATE_INT32(read_trigger, PL011State),
+//    VMSTATE_END_OF_LIST()
+//},
+//.subsections = (const VMStateDescription * const []) {
+//    &vmstate_pl011_clock,
+//    NULL
+//}
+
+pub unsafe extern "C" fn pl011_create(
+    addr: u64,
+    irq: qemu_irq,
+    chr: *mut Chardev,
+) -> *mut DeviceState {
+    let dev: *mut DeviceState = unsafe { qdev_new(PL011_ARM_INFO.name) };
+    assert!(!dev.is_null());
+    let sysbus: *mut SysBusDevice = dev as *mut SysBusDevice;
+
+    unsafe {
+        qdev_prop_set_chr(dev, generated::TYPE_CHARDEV.as_ptr(), chr);
+        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
+        sysbus_mmio_map(sysbus, 0, addr);
+        sysbus_connect_irq(sysbus, 0, irq);
+    }
+    dev
+}
diff --git a/rust/pl011/src/device_class.rs b/rust/pl011/src/device_class.rs
new file mode 100644
index 0000000000..50d91eb527
--- /dev/null
+++ b/rust/pl011/src/device_class.rs
@@ -0,0 +1,95 @@
+use core::{mem::MaybeUninit, ptr::NonNull};
+use std::sync::OnceLock;
+
+use crate::{
+    device::{PL011State, VMSTATE_PL011},
+    generated::*,
+};
+
+#[no_mangle]
+pub unsafe extern "C" fn pl011_class_init(klass: *mut ObjectClass, _: *mut core::ffi::c_void) {
+    let mut dc = NonNull::new(klass.cast::<DeviceClass>()).unwrap();
+    dc.as_mut().realize = Some(pl011_realize);
+    dc.as_mut().reset = Some(pl011_reset);
+    dc.as_mut().vmsd = &VMSTATE_PL011;
+    _ = PL011_PROPERTIES.get_or_init(make_pl011_properties);
+    device_class_set_props(
+        dc.as_mut(),
+        PL011_PROPERTIES.get_mut().unwrap().as_mut_ptr(),
+    );
+}
+
+#[macro_export]
+macro_rules! define_property {
+    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr, default = $defval:expr) => {
+        $crate::generated::Property {
+            name: $name,
+            info: $prop,
+            offset: ::core::mem::offset_of!($state, $field) as _,
+            bitnr: 0,
+            bitmask: 0,
+            set_default: true,
+            defval: $crate::generated::Property__bindgen_ty_1 { u: $defval.into() },
+            arrayoffset: 0,
+            arrayinfo: ::core::ptr::null(),
+            arrayfieldsize: 0,
+            link_type: ::core::ptr::null(),
+        }
+    };
+    ($name:expr, $state:ty, $field:expr, $prop:expr, $type:expr) => {
+        $crate::generated::Property {
+            name: $name,
+            info: $prop,
+            offset: ::core::mem::offset_of!($state, $field) as _,
+            bitnr: 0,
+            bitmask: 0,
+            set_default: false,
+            defval: $crate::generated::Property__bindgen_ty_1 { i: 0 },
+            arrayoffset: 0,
+            arrayinfo: ::core::ptr::null(),
+            arrayfieldsize: 0,
+            link_type: ::core::ptr::null(),
+        }
+    };
+}
+
+#[no_mangle]
+pub static mut PL011_PROPERTIES: OnceLock<[Property; 3]> = OnceLock::new();
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+
+#[no_mangle]
+fn make_pl011_properties() -> [Property; 3] {
+    [
+        define_property!(
+            c"chardev".as_ptr(),
+            PL011State,
+            char_backend,
+            unsafe { &qdev_prop_chr },
+            CharBackend
+        ),
+        define_property!(
+            c"migrate-clk".as_ptr(),
+            PL011State,
+            migrate_clock,
+            unsafe { &qdev_prop_bool },
+            bool
+        ),
+        unsafe { MaybeUninit::<Property>::zeroed().assume_init() },
+    ]
+}
+
+#[no_mangle]
+pub unsafe extern "C" fn pl011_realize(dev: *mut DeviceState, _errp: *mut *mut Error) {
+    assert!(!dev.is_null());
+    let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
+    state.as_mut().realize();
+}
+
+#[no_mangle]
+pub unsafe extern "C" fn pl011_reset(dev: *mut DeviceState) {
+    assert!(!dev.is_null());
+    let mut state = NonNull::new_unchecked(dev.cast::<PL011State>());
+    state.as_mut().reset();
+}
diff --git a/rust/pl011/src/generated.rs b/rust/pl011/src/generated.rs
new file mode 100644
index 0000000000..670e7b541d
--- /dev/null
+++ b/rust/pl011/src/generated.rs
@@ -0,0 +1,5 @@
+#[cfg(MESON_GENERATED_RS)]
+include!(concat!(env!("OUT_DIR"), "/generated.rs"));
+
+#[cfg(not(MESON_GENERATED_RS))]
+include!("generated.rs.inc");
diff --git a/rust/pl011/src/lib.rs b/rust/pl011/src/lib.rs
new file mode 100644
index 0000000000..bb2899dbc2
--- /dev/null
+++ b/rust/pl011/src/lib.rs
@@ -0,0 +1,581 @@
+// PL011 QEMU Device Model
+//
+// This library implements a device model for the PrimeCell® UART (PL011)
+// device in QEMU.
+//
+#![doc = include_str!("../README.md")]
+//! # Library crate
+//!
+//! See [`PL011State`](crate::device::PL011State) for the device model type and
+//! the [`registers`] module for register types.
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
+pub mod generated;
+
+pub mod definitions;
+pub mod device;
+pub mod device_class;
+pub mod memory_ops;
+
+/// Offset of each register from the base memory address of the device.
+///
+/// # Source
+/// ARM DDI 0183G, Table 3-1 p.3-3
+#[doc(alias = "offset")]
+#[allow(non_camel_case_types)]
+#[repr(u64)]
+#[derive(Debug)]
+pub enum RegisterOffset {
+    /// Data Register
+    ///
+    /// A write to this register initiates the actual data transmission
+    #[doc(alias = "UARTDR")]
+    DR = 0x000,
+    /// Receive Status Register or Error Clear Register
+    #[doc(alias = "UARTRSR")]
+    #[doc(alias = "UARTECR")]
+    RSR = 0x004,
+    /// Flag Register
+    ///
+    /// A read of this register shows if transmission is complete
+    #[doc(alias = "UARTFR")]
+    FR = 0x018,
+    /// Fractional Baud Rate Register
+    ///
+    /// responsible for baud rate speed
+    #[doc(alias = "UARTFBRD")]
+    FBRD = 0x028,
+    /// `IrDA` Low-Power Counter Register
+    #[doc(alias = "UARTILPR")]
+    ILPR = 0x020,
+    /// Integer Baud Rate Register
+    ///
+    /// Responsible for baud rate speed
+    #[doc(alias = "UARTIBRD")]
+    IBRD = 0x024,
+    /// line control register (data frame format)
+    #[doc(alias = "UARTLCR_H")]
+    LCR_H = 0x02C,
+    /// Toggle UART, transmission or reception
+    #[doc(alias = "UARTCR")]
+    CR = 0x030,
+    /// Interrupt FIFO Level Select Register
+    #[doc(alias = "UARTIFLS")]
+    FLS = 0x034,
+    /// Interrupt Mask Set/Clear Register
+    #[doc(alias = "UARTIMSC")]
+    IMSC = 0x038,
+    /// Raw Interrupt Status Register
+    #[doc(alias = "UARTRIS")]
+    RIS = 0x03C,
+    /// Masked Interrupt Status Register
+    #[doc(alias = "UARTMIS")]
+    MIS = 0x040,
+    /// Interrupt Clear Register
+    #[doc(alias = "UARTICR")]
+    ICR = 0x044,
+    /// DMA control Register
+    #[doc(alias = "UARTDMACR")]
+    DMACR = 0x048,
+    ///// Reserved, offsets `0x04C` to `0x07C`.
+    //Reserved = 0x04C,
+}
+
+impl core::convert::TryFrom<u64> for RegisterOffset {
+    type Error = u64;
+
+    fn try_from(value: u64) -> Result<Self, Self::Error> {
+        macro_rules! case {
+            ($($discriminant:ident),*$(,)*) => {
+                /* check that matching on all macro arguments compiles, which means we are not
+                 * missing any enum value; if the type definition ever changes this will stop
+                 * compiling.
+                 */
+                const fn _assert_exhaustive(val: RegisterOffset) {
+                    match val {
+                        $(RegisterOffset::$discriminant => (),)*
+                    }
+                }
+
+                match value {
+                    $(x if x == Self::$discriminant as u64 => Ok(Self::$discriminant),)*
+                     _ => Err(value),
+                }
+            }
+        }
+        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR }
+    }
+}
+
+pub mod registers {
+    //! Device registers exposed as typed structs which are backed by arbitrary
+    //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
+    //!
+    //! All PL011 registers are essentially 32-bit wide, but are typed here as
+    //! bitmaps with only the necessary width. That is, if a struct bitmap
+    //! in this module is for example 16 bits long, it should be conceived
+    //! as a 32-bit register where the unmentioned higher bits are always
+    //! unused thus treated as zero when read or written.
+    use bilge::prelude::*;
+
+    // TODO: FIFO Mode has different semantics
+    /// Data Register, `UARTDR`
+    ///
+    /// The `UARTDR` register is the data register.
+    ///
+    /// For words to be transmitted:
+    ///
+    /// - if the FIFOs are enabled, data written to this location is pushed onto
+    ///   the transmit
+    /// FIFO
+    /// - if the FIFOs are not enabled, data is stored in the transmitter
+    ///   holding register (the
+    /// bottom word of the transmit FIFO).
+    ///
+    /// The write operation initiates transmission from the UART. The data is
+    /// prefixed with a start bit, appended with the appropriate parity bit
+    /// (if parity is enabled), and a stop bit. The resultant word is then
+    /// transmitted.
+    ///
+    /// For received words:
+    ///
+    /// - if the FIFOs are enabled, the data byte and the 4-bit status (break,
+    ///   frame, parity,
+    /// and overrun) is pushed onto the 12-bit wide receive FIFO
+    /// - if the FIFOs are not enabled, the data byte and status are stored in
+    ///   the receiving
+    /// holding register (the bottom word of the receive FIFO).
+    ///
+    /// The received data byte is read by performing reads from the `UARTDR`
+    /// register along with the corresponding status information. The status
+    /// information can also be read by a read of the `UARTRSR/UARTECR`
+    /// register.
+    ///
+    /// # Note
+    ///
+    /// You must disable the UART before any of the control registers are
+    /// reprogrammed. When the UART is disabled in the middle of
+    /// transmission or reception, it completes the current character before
+    /// stopping.
+    ///
+    /// # Source
+    /// ARM DDI 0183G 3.3.1 Data Register, UARTDR
+    #[bitsize(16)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    #[doc(alias = "UARTDR")]
+    pub struct Data {
+        _reserved: u4,
+        pub data: u8,
+        pub framing_error: bool,
+        pub parity_error: bool,
+        pub break_error: bool,
+        pub overrun_error: bool,
+    }
+
+    // TODO: FIFO Mode has different semantics
+    /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
+    ///
+    /// The UARTRSR/UARTECR register is the receive status register/error clear
+    /// register. Receive status can also be read from the `UARTRSR`
+    /// register. If the status is read from this register, then the status
+    /// information for break, framing and parity corresponds to the
+    /// data character read from the [Data register](Data), `UARTDR` prior to
+    /// reading the UARTRSR register. The status information for overrun is
+    /// set immediately when an overrun condition occurs.
+    ///
+    ///
+    /// # Note
+    /// The received data character must be read first from the [Data
+    /// Register](Data), `UARTDR` before reading the error status associated
+    /// with that data character from the `UARTRSR` register. This read
+    /// sequence cannot be reversed, because the `UARTRSR` register is
+    /// updated only when a read occurs from the `UARTDR` register. However,
+    /// the status information can also be obtained by reading the `UARTDR`
+    /// register
+    ///
+    /// # Source
+    /// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register,
+    /// UARTRSR/UARTECR
+    #[bitsize(8)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    pub struct ReceiveStatusErrorClear {
+        pub framing_error: bool,
+        pub parity_error: bool,
+        pub break_error: bool,
+        pub overrun_error: bool,
+        _reserved_unpredictable: u4,
+    }
+
+    impl ReceiveStatusErrorClear {
+        pub fn reset(&mut self) {
+            // All the bits are cleared to 0 on reset.
+            *self = 0.into();
+        }
+    }
+
+    impl Default for ReceiveStatusErrorClear {
+        fn default() -> Self {
+            0.into()
+        }
+    }
+
+    #[bitsize(16)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    /// Flag Register, `UARTFR`
+    #[doc(alias = "UARTFR")]
+    pub struct Flags {
+        /// CTS Clear to send. This bit is the complement of the UART clear to
+        /// send, `nUARTCTS`, modem status input. That is, the bit is 1
+        /// when `nUARTCTS` is LOW.
+        pub clear_to_send: bool,
+        /// DSR Data set ready. This bit is the complement of the UART data set
+        /// ready, `nUARTDSR`, modem status input. That is, the bit is 1 when
+        /// `nUARTDSR` is LOW.
+        pub data_set_ready: bool,
+        /// DCD Data carrier detect. This bit is the complement of the UART data
+        /// carrier detect, `nUARTDCD`, modem status input. That is, the bit is
+        /// 1 when `nUARTDCD` is LOW.
+        pub data_carrier_detect: bool,
+        /// BUSY UART busy. If this bit is set to 1, the UART is busy
+        /// transmitting data. This bit remains set until the complete
+        /// byte, including all the stop bits, has been sent from the
+        /// shift register. This bit is set as soon as the transmit FIFO
+        /// becomes non-empty, regardless of whether the UART is enabled
+        /// or not.
+        pub busy: bool,
+        /// RXFE Receive FIFO empty. The meaning of this bit depends on the
+        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
+        /// is disabled, this bit is set when the receive holding
+        /// register is empty. If the FIFO is enabled, the RXFE bit is
+        /// set when the receive FIFO is empty.
+        pub receive_fifo_empty: bool,
+        /// TXFF Transmit FIFO full. The meaning of this bit depends on the
+        /// state of the FEN bit in the UARTLCR_H register. If the FIFO
+        /// is disabled, this bit is set when the transmit holding
+        /// register is full. If the FIFO is enabled, the TXFF bit is
+        /// set when the transmit FIFO is full.
+        pub transmit_fifo_full: bool,
+        /// RXFF Receive FIFO full. The meaning of this bit depends on the state
+        /// of the FEN bit in the UARTLCR_H register. If the FIFO is
+        /// disabled, this bit is set when the receive holding register
+        /// is full. If the FIFO is enabled, the RXFF bit is set when
+        /// the receive FIFO is full.
+        pub receive_fifo_full: bool,
+        /// Transmit FIFO empty. The meaning of this bit depends on the state of
+        /// the FEN bit in the [Line Control register](LineControl),
+        /// `UARTLCR_H`. If the FIFO is disabled, this bit is set when the
+        /// transmit holding register is empty. If the FIFO is enabled,
+        /// the TXFE bit is set when the transmit FIFO is empty. This
+        /// bit does not indicate if there is data in the transmit shift
+        /// register.
+        pub transmit_fifo_empty: bool,
+        /// `RI`, is `true` when `nUARTRI` is `LOW`.
+        pub ring_indicator: bool,
+        _reserved_zero_no_modify: u7,
+    }
+
+    impl Flags {
+        pub fn reset(&mut self) {
+            // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are 1
+            self.set_receive_fifo_full(false);
+            self.set_transmit_fifo_full(false);
+            self.set_busy(false);
+            self.set_receive_fifo_empty(true);
+            self.set_transmit_fifo_empty(true);
+        }
+    }
+
+    impl Default for Flags {
+        fn default() -> Self {
+            let mut ret: Self = 0.into();
+            ret.reset();
+            ret
+        }
+    }
+
+    #[bitsize(16)]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    /// Line Control Register, `UARTLCR_H`
+    #[doc(alias = "UARTLCR_H")]
+    pub struct LineControl {
+        /// 15:8 - Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify: u8,
+        /// 7 SPS Stick parity select.
+        /// 0 = stick parity is disabled
+        /// 1 = either:
+        /// • if the EPS bit is 0 then the parity bit is transmitted and checked
+        /// as a 1 • if the EPS bit is 1 then the parity bit is
+        /// transmitted and checked as a 0. This bit has no effect when
+        /// the PEN bit disables parity checking and generation. See Table 3-11
+        /// on page 3-14 for the parity truth table.
+        pub sticky_parity: bool,
+        /// WLEN Word length. These bits indicate the number of data bits
+        /// transmitted or received in a frame as follows: b11 = 8 bits
+        /// b10 = 7 bits
+        /// b01 = 6 bits
+        /// b00 = 5 bits.
+        pub word_length: WordLength,
+        /// FEN Enable FIFOs:
+        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
+        /// 1-byte-deep holding registers 1 = transmit and receive FIFO
+        /// buffers are enabled (FIFO mode).
+        pub fifos_enabled: Mode,
+        /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
+        /// are transmitted at the end of the frame. The receive
+        /// logic does not check for two stop bits being received.
+        pub two_stops_bits: bool,
+        /// EPS Even parity select. Controls the type of parity the UART uses
+        /// during transmission and reception:
+        /// - 0 = odd parity. The UART generates or checks for an odd number of
+        ///   1s in the data and parity bits.
+        /// - 1 = even parity. The UART generates or checks for an even number
+        ///   of 1s in the data and parity bits.
+        /// This bit has no effect when the `PEN` bit disables parity checking
+        /// and generation. See Table 3-11 on page 3-14 for the parity
+        /// truth table.
+        pub parity: Parity,
+        /// 1 PEN Parity enable:
+        ///
+        /// - 0 = parity is disabled and no parity bit added to the data frame
+        /// - 1 = parity checking and generation is enabled.
+        ///
+        /// See Table 3-11 on page 3-14 for the parity truth table.
+        pub parity_enabled: bool,
+        /// BRK Send break.
+        ///
+        /// If this bit is set to `1`, a low-level is continually output on the
+        /// `UARTTXD` output, after completing transmission of the
+        /// current character. For the proper execution of the break command,
+        /// the software must set this bit for at least two complete
+        /// frames. For normal use, this bit must be cleared to `0`.
+        pub send_break: bool,
+    }
+
+    impl LineControl {
+        pub fn reset(&mut self) {
+            // All the bits are cleared to 0 when reset.
+            *self = 0.into();
+        }
+    }
+
+    impl Default for LineControl {
+        fn default() -> Self {
+            0.into()
+        }
+    }
+
+    #[bitsize(1)]
+    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+    /// `EPS` "Even parity select", field of [Line Control
+    /// register](LineControl).
+    pub enum Parity {
+        /// - 0 = odd parity. The UART generates or checks for an odd number of
+        ///   1s in the data and parity bits.
+        Odd = 0,
+        /// - 1 = even parity. The UART generates or checks for an even number
+        ///   of 1s in the data and parity bits.
+        Even = 1,
+    }
+
+    #[bitsize(1)]
+    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+    /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
+    /// register](LineControl).
+    pub enum Mode {
+        /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
+        /// 1-byte-deep holding registers
+        Character = 0,
+        /// 1 = transmit and receive FIFO buffers are enabled (FIFO mode).
+        FIFO = 1,
+    }
+
+    impl From<Mode> for bool {
+        fn from(val: Mode) -> Self {
+            matches!(val, Mode::FIFO)
+        }
+    }
+
+    #[bitsize(2)]
+    #[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+    /// `WLEN` Word length, field of [Line Control register](LineControl).
+    ///
+    /// These bits indicate the number of data bits transmitted or received in a
+    /// frame as follows:
+    pub enum WordLength {
+        /// b11 = 8 bits
+        _8Bits = 0b11,
+        /// b10 = 7 bits
+        _7Bits = 0b10,
+        /// b01 = 6 bits
+        _6Bits = 0b01,
+        /// b00 = 5 bits.
+        _5Bits = 0b00,
+    }
+
+    /// Control Register, `UARTCR`
+    ///
+    /// The `UARTCR` register is the control register. All the bits are cleared
+    /// to `0` on reset except for bits `9` and `8` that are set to `1`.
+    ///
+    /// # Source
+    /// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
+    #[bitsize(16)]
+    #[doc(alias = "UARTCR")]
+    #[derive(Clone, Copy, DebugBits, FromBits)]
+    pub struct Control {
+        /// `UARTEN` UART enable: 0 = UART is disabled. If the UART is disabled
+        /// in the middle of transmission or reception, it completes the current
+        /// character before stopping. 1 = the UART is enabled. Data
+        /// transmission and reception occurs for either UART signals or SIR
+        /// signals depending on the setting of the SIREN bit.
+        pub enable_uart: bool,
+        /// `SIREN` `SIR` enable: 0 = IrDA SIR ENDEC is disabled. `nSIROUT`
+        /// remains LOW (no light pulse generated), and signal transitions on
+        /// SIRIN have no effect. 1 = IrDA SIR ENDEC is enabled. Data is
+        /// transmitted and received on nSIROUT and SIRIN. UARTTXD remains HIGH,
+        /// in the marking state. Signal transitions on UARTRXD or modem status
+        /// inputs have no effect. This bit has no effect if the UARTEN bit
+        /// disables the UART.
+        pub enable_sir: bool,
+        /// `SIRLP` SIR low-power IrDA mode. This bit selects the IrDA encoding
+        /// mode. If this bit is cleared to 0, low-level bits are transmitted as
+        /// an active high pulse with a width of 3/ 16th of the bit period. If
+        /// this bit is set to 1, low-level bits are transmitted with a pulse
+        /// width that is 3 times the period of the IrLPBaud16 input signal,
+        /// regardless of the selected bit rate. Setting this bit uses less
+        /// power, but might reduce transmission distances.
+        pub sir_lowpower_irda_mode: u1,
+        /// Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify: u4,
+        /// `LBE` Loopback enable. If this bit is set to 1 and the SIREN bit is
+        /// set to 1 and the SIRTEST bit in the Test Control register, UARTTCR
+        /// on page 4-5 is set to 1, then the nSIROUT path is inverted, and fed
+        /// through to the SIRIN path. The SIRTEST bit in the test register must
+        /// be set to 1 to override the normal half-duplex SIR operation. This
+        /// must be the requirement for accessing the test registers during
+        /// normal operation, and SIRTEST must be cleared to 0 when loopback
+        /// testing is finished. This feature reduces the amount of external
+        /// coupling required during system test. If this bit is set to 1, and
+        /// the SIRTEST bit is set to 0, the UARTTXD path is fed through to the
+        /// UARTRXD path. In either SIR mode or UART mode, when this bit is set,
+        /// the modem outputs are also fed through to the modem inputs. This bit
+        /// is cleared to 0 on reset, to disable loopback.
+        pub enable_loopback: bool,
+        /// `TXE` Transmit enable. If this bit is set to 1, the transmit section
+        /// of the UART is enabled. Data transmission occurs for either UART
+        /// signals, or SIR signals depending on the setting of the SIREN bit.
+        /// When the UART is disabled in the middle of transmission, it
+        /// completes the current character before stopping.
+        pub enable_transmit: bool,
+        /// `RXE` Receive enable. If this bit is set to 1, the receive section
+        /// of the UART is enabled. Data reception occurs for either UART
+        /// signals or SIR signals depending on the setting of the SIREN bit.
+        /// When the UART is disabled in the middle of reception, it completes
+        /// the current character before stopping.
+        pub enable_receive: bool,
+        /// `DTR` Data transmit ready. This bit is the complement of the UART
+        /// data transmit ready, `nUARTDTR`, modem status output. That is, when
+        /// the bit is programmed to a 1 then `nUARTDTR` is LOW.
+        pub data_transmit_ready: bool,
+        /// `RTS` Request to send. This bit is the complement of the UART
+        /// request to send, `nUARTRTS`, modem status output. That is, when the
+        /// bit is programmed to a 1 then `nUARTRTS` is LOW.
+        pub request_to_send: bool,
+        /// `Out1` This bit is the complement of the UART Out1 (`nUARTOut1`)
+        /// modem status output. That is, when the bit is programmed to a 1 the
+        /// output is 0. For DTE this can be used as Data Carrier Detect (DCD).
+        pub out_1: bool,
+        /// `Out2` This bit is the complement of the UART Out2 (`nUARTOut2`)
+        /// modem status output. That is, when the bit is programmed to a 1, the
+        /// output is 0. For DTE this can be used as Ring Indicator (RI).
+        pub out_2: bool,
+        /// `RTSEn` RTS hardware flow control enable. If this bit is set to 1,
+        /// RTS hardware flow control is enabled. Data is only requested when
+        /// there is space in the receive FIFO for it to be received.
+        pub rts_hardware_flow_control_enable: bool,
+        /// `CTSEn` CTS hardware flow control enable. If this bit is set to 1,
+        /// CTS hardware flow control is enabled. Data is only transmitted when
+        /// the `nUARTCTS` signal is asserted.
+        pub cts_hardware_flow_control_enable: bool,
+    }
+
+    impl Control {
+        pub fn reset(&mut self) {
+            *self = 0.into();
+            self.set_enable_receive(true);
+            self.set_enable_transmit(true);
+        }
+    }
+
+    impl Default for Control {
+        fn default() -> Self {
+            let mut ret: Self = 0.into();
+            ret.reset();
+            ret
+        }
+    }
+
+    /// Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC
+    pub const INT_OE: u32 = 1 << 10;
+    pub const INT_BE: u32 = 1 << 9;
+    pub const INT_PE: u32 = 1 << 8;
+    pub const INT_FE: u32 = 1 << 7;
+    pub const INT_RT: u32 = 1 << 6;
+    pub const INT_TX: u32 = 1 << 5;
+    pub const INT_RX: u32 = 1 << 4;
+    pub const INT_DSR: u32 = 1 << 3;
+    pub const INT_DCD: u32 = 1 << 2;
+    pub const INT_CTS: u32 = 1 << 1;
+    pub const INT_RI: u32 = 1 << 0;
+    pub const INT_E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
+    pub const INT_MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
+
+    #[repr(u32)]
+    pub enum Interrupt {
+        OE = 1 << 10,
+        BE = 1 << 9,
+        PE = 1 << 8,
+        FE = 1 << 7,
+        RT = 1 << 6,
+        TX = 1 << 5,
+        RX = 1 << 4,
+        DSR = 1 << 3,
+        DCD = 1 << 2,
+        CTS = 1 << 1,
+        RI = 1 << 0,
+    }
+
+    impl Interrupt {
+        pub const E: u32 = INT_OE | INT_BE | INT_PE | INT_FE;
+        pub const MS: u32 = INT_RI | INT_DSR | INT_DCD | INT_CTS;
+    }
+}
+
+// State
+// TODO You must disable the UART before any of the control registers are
+// reprogrammed. When the UART is disabled in the middle of transmission or
+// reception, it completes the current character before stopping
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    #[test]
+    fn it_works() {}
+}
diff --git a/rust/pl011/src/memory_ops.rs b/rust/pl011/src/memory_ops.rs
new file mode 100644
index 0000000000..4c7d4577c7
--- /dev/null
+++ b/rust/pl011/src/memory_ops.rs
@@ -0,0 +1,38 @@
+use core::{mem::MaybeUninit, ptr::NonNull};
+
+use crate::{device::PL011State, generated::*};
+
+pub const PL011_OPS: MemoryRegionOps = MemoryRegionOps {
+    read: Some(pl011_read),
+    write: Some(pl011_write),
+    read_with_attrs: None,
+    write_with_attrs: None,
+    endianness: device_endian_DEVICE_NATIVE_ENDIAN,
+    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed().assume_init() },
+    impl_: MemoryRegionOps__bindgen_ty_2 {
+        min_access_size: 4,
+        max_access_size: 4,
+        ..unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_2>::zeroed().assume_init() }
+    },
+};
+
+unsafe extern "C" fn pl011_read(
+    opaque: *mut core::ffi::c_void,
+    addr: hwaddr,
+    size: core::ffi::c_uint,
+) -> u64 {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_mut().read(addr, size)
+}
+
+unsafe extern "C" fn pl011_write(
+    opaque: *mut core::ffi::c_void,
+    addr: hwaddr,
+    data: u64,
+    _size: core::ffi::c_uint,
+) {
+    assert!(!opaque.is_null());
+    let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
+    state.as_mut().write(addr, data)
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


