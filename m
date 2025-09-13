Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B551CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMO-00009k-OT; Sat, 13 Sep 2025 04:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMA-0008Pe-Ok
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLM5-00056V-CR
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K81C6uk9t9Dg2b6Iz8EY9jhnxIIs4JTIXVttzHXc7Yg=;
 b=eQysX7cic30pWd/SvFgqklUB0Gk3gJH6FrRnyzB++OFb0IWn+gBw89VrQKRTZXiu+WceNv
 202cSZFeSLVuholJmtibAY1mwDMBKui5YS8sMFRVGXgXDiL7S3glWBG5bvXhvMbeFo6rNd
 tlVAvGY3SdY6lzA4FaCOUW93o59wMrs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-1lwu7rHdOzqO3Ba9lQioQg-1; Sat, 13 Sep 2025 04:11:28 -0400
X-MC-Unique: 1lwu7rHdOzqO3Ba9lQioQg-1
X-Mimecast-MFC-AGG-ID: 1lwu7rHdOzqO3Ba9lQioQg_1757751087
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e7c2273e69so599616f8f.1
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751086; x=1758355886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K81C6uk9t9Dg2b6Iz8EY9jhnxIIs4JTIXVttzHXc7Yg=;
 b=fOZahmntpAFr4NsPpMyp2HlbSu7xEZ3mZkgXGzQ8XCBYi24Obi4q8OuR3wLVQ9B6J8
 OWFEIVhOdBF6YdWR5dGYi2FsSHCzonsfeiMqEu/jR5+qKF/5aJv2FcfPshy0J97YZhvJ
 gPHvmAl41k/TPA6qE6Ba4OV6lpv/4FmpjeqT8Y82d8IwD1PM2ltCix1Wsx9Lu/nt/N1Z
 KC4ekdBB50MV41YY5X6IgO94HLZ2LAyTqYz2Ta+g/15VYxTujppxUz+vZyb3hL9byrB8
 ltvN37YrAj41bBZFjld71slyc/UjRPdhvQDAB4BSo0kYwO1XADineELqXBWwEsetf7Qh
 bu8w==
X-Gm-Message-State: AOJu0Yx8DL3X9co+9zVVTM/0L8fxmxIMZWHD8hHp4SvPdTdHqezY/s0i
 nwnGj0X8ac410ICiZ8M3btVd9LxAXKCs4woK7FzaSanOWscVau76Ji/NA6hcCyVq1E7O+I8/uNG
 o1zHkcWJYfP4+WTdzfP8+rgYJ/1Ca5hG4ZUZ5P+DgSVJ7VfKn22cSmRWpleNTBpofzUFs2shBIx
 blSw1F+z8HmWJHAWj+baE+WZ9KNiAIcyDjfxDuJ4ri
X-Gm-Gg: ASbGncuXQ6UX0CulkCgijl3qo32Ev4pZnoA4JNqjBkE1tCEB62y6TR33RDsWrPYC/Th
 ztcomeP2dyuj4gkwh25nAtvZ3QAuVSwPAEJ4B55ii8JL2Angwqz/tHNcNxzUL/ieknjf1TonJoN
 AYC73CrGt4ZlnEVDShiNy1F6R2cR187HM1Dgi0jEWA/kjnvaSpzX+alE2AV7RbyP15Ool3QvQ48
 XKSVI10cvVU9zkOhU6yJrdgF6KSZ4Y0VEyMyAkfoyIwA2my6T2the+CgVeN3nNC2QVXKkqZCY4m
 MRAgkqxW3SVr5bwJglomRlR9YXKvsyeqH02wihNLgxwSHU/Gh6rjfBZu35NdzcNh2wWMw6xzqSa
 eQ65o+moEoTltsj92d7yT1C1jdaIAXk1Y1lNLvj0K/Gc=
X-Received: by 2002:a5d:5f49:0:b0:3dc:15d2:b92a with SMTP id
 ffacd0b85a97d-3e765a05285mr4166617f8f.41.1757751084755; 
 Sat, 13 Sep 2025 01:11:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSVcRmlujwM1qTqDyo7Pw6OcMgsMUu/BsPI0BoEcmTTZHyGKpKw/0SBQ5LQnDhWNI9Q1WWXQ==
X-Received: by 2002:a5d:5f49:0:b0:3dc:15d2:b92a with SMTP id
 ffacd0b85a97d-3e765a05285mr4166552f8f.41.1757751083370; 
 Sat, 13 Sep 2025 01:11:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e86602a7d5sm1931665f8f.62.2025.09.13.01.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 35/61] rust: split Rust-only "common" crate
Date: Sat, 13 Sep 2025 10:09:16 +0200
Message-ID: <20250913080943.11710-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Link: https://lore.kernel.org/r/20250827104147.717203-6-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                 |   1 +
 rust/Cargo.lock                             |  10 +
 rust/Cargo.toml                             |   1 +
 rust/common/Cargo.toml                      |  19 ++
 rust/common/meson.build                     |  34 +++
 rust/{qemu-api => common}/src/assertions.rs |  16 +-
 rust/{qemu-api => common}/src/bitops.rs     |   1 -
 rust/{qemu-api => common}/src/callbacks.rs  |  10 +-
 rust/{qemu-api => common}/src/errno.rs      |   8 +-
 rust/common/src/lib.rs                      |  20 ++
 rust/common/src/opaque.rs                   | 238 ++++++++++++++++++++
 rust/{qemu-api => common}/src/uninit.rs     |   2 +-
 rust/common/src/zeroable.rs                 |  18 ++
 rust/hw/char/pl011/Cargo.toml               |   1 +
 rust/hw/char/pl011/meson.build              |   3 +-
 rust/hw/char/pl011/src/device.rs            |   3 +-
 rust/hw/timer/hpet/Cargo.toml               |   1 +
 rust/hw/timer/hpet/meson.build              |   3 +-
 rust/hw/timer/hpet/src/device.rs            |   2 +-
 rust/hw/timer/hpet/src/fw_cfg.rs            |   3 +-
 rust/meson.build                            |   1 +
 rust/qemu-api-macros/src/lib.rs             |  16 +-
 rust/qemu-api-macros/src/tests.rs           |   6 +-
 rust/qemu-api/Cargo.toml                    |   1 +
 rust/qemu-api/meson.build                   |  14 +-
 rust/qemu-api/src/bindings.rs               |  21 ++
 rust/qemu-api/src/cell.rs                   | 235 +------------------
 rust/qemu-api/src/chardev.rs                |   5 +-
 rust/qemu-api/src/error.rs                  |   3 +-
 rust/qemu-api/src/irq.rs                    |   3 +-
 rust/qemu-api/src/lib.rs                    |   6 -
 rust/qemu-api/src/log.rs                    |   4 +-
 rust/qemu-api/src/memory.rs                 |   5 +-
 rust/qemu-api/src/prelude.rs                |   6 +-
 rust/qemu-api/src/qdev.rs                   |  10 +-
 rust/qemu-api/src/qom.rs                    |   3 +-
 rust/qemu-api/src/sysbus.rs                 |   3 +-
 rust/qemu-api/src/timer.rs                  |   8 +-
 rust/qemu-api/src/vmstate.rs                |  23 +-
 rust/qemu-api/src/zeroable.rs               |  37 ---
 rust/qemu-api/tests/vmstate_tests.rs        |   3 +-
 41 files changed, 448 insertions(+), 359 deletions(-)
 create mode 100644 rust/common/Cargo.toml
 create mode 100644 rust/common/meson.build
 rename rust/{qemu-api => common}/src/assertions.rs (92%)
 rename rust/{qemu-api => common}/src/bitops.rs (98%)
 rename rust/{qemu-api => common}/src/callbacks.rs (97%)
 rename rust/{qemu-api => common}/src/errno.rs (98%)
 create mode 100644 rust/common/src/lib.rs
 create mode 100644 rust/common/src/opaque.rs
 rename rust/{qemu-api => common}/src/uninit.rs (98%)
 create mode 100644 rust/common/src/zeroable.rs
 delete mode 100644 rust/qemu-api/src/zeroable.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index fb045388b92..cee5a342062 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3515,6 +3515,7 @@ F: include/hw/registerfields.h
 Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
+F: rust/common/
 F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 4baf6ba663c..71e8c7ed62a 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -44,6 +44,13 @@ dependencies = [
  "qemu_api_macros",
 ]
 
+[[package]]
+name = "common"
+version = "0.1.0"
+dependencies = [
+ "libc",
+]
+
 [[package]]
 name = "either"
 version = "1.12.0"
@@ -63,6 +70,7 @@ dependencies = [
 name = "hpet"
 version = "0.1.0"
 dependencies = [
+ "common",
  "qemu_api",
  "qemu_api_macros",
 ]
@@ -89,6 +97,7 @@ dependencies = [
  "bilge",
  "bilge-impl",
  "bits",
+ "common",
  "qemu_api",
  "qemu_api_macros",
 ]
@@ -130,6 +139,7 @@ name = "qemu_api"
 version = "0.1.0"
 dependencies = [
  "anyhow",
+ "common",
  "foreign",
  "libc",
  "qemu_api_macros",
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index cd4bf8ef8e1..c0426d42430 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -2,6 +2,7 @@
 resolver = "2"
 members = [
     "bits",
+    "common",
     "qemu-api-macros",
     "qemu-api",
     "hw/char/pl011",
diff --git a/rust/common/Cargo.toml b/rust/common/Cargo.toml
new file mode 100644
index 00000000000..5e106427e80
--- /dev/null
+++ b/rust/common/Cargo.toml
@@ -0,0 +1,19 @@
+[package]
+name = "common"
+version = "0.1.0"
+description = "Rust common code for QEMU"
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
+libc.workspace = true
+
+[lints]
+workspace = true
diff --git a/rust/common/meson.build b/rust/common/meson.build
new file mode 100644
index 00000000000..230a967760d
--- /dev/null
+++ b/rust/common/meson.build
@@ -0,0 +1,34 @@
+_common_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+_common_rs = static_library(
+  'common',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/assertions.rs',
+      'src/bitops.rs',
+      'src/callbacks.rs',
+      'src/errno.rs',
+      'src/opaque.rs',
+      'src/uninit.rs',
+      'src/zeroable.rs',
+    ],
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _common_cfg,
+  dependencies: [libc_rs],
+)
+
+common_rs = declare_dependency(link_with: [_common_rs])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-common-doctests',
+     _common_rs,
+     protocol: 'rust',
+     dependencies: common_rs,
+     suite: ['doc', 'rust'])
diff --git a/rust/qemu-api/src/assertions.rs b/rust/common/src/assertions.rs
similarity index 92%
rename from rust/qemu-api/src/assertions.rs
rename to rust/common/src/assertions.rs
index e4fe23b674e..91f83a5d3d4 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/common/src/assertions.rs
@@ -8,7 +8,7 @@
 //! types match the expectations of C code.
 //!
 //! Documentation is hidden because it only exposes macros, which
-//! are exported directly from `qemu_api`.
+//! are exported directly from `common`.
 
 // Based on https://stackoverflow.com/questions/64251852/x/70978292#70978292
 // (stackoverflow answers are released under MIT license).
@@ -27,7 +27,7 @@ impl<T> EqType for T {
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::assert_same_type;
+/// # use common::assert_same_type;
 /// # use std::ops::Deref;
 /// assert_same_type!(u32, u32);
 /// assert_same_type!(<Box<u32> as Deref>::Target, u32);
@@ -36,7 +36,7 @@ impl<T> EqType for T {
 /// Different types will cause a compile failure
 ///
 /// ```compile_fail
-/// # use qemu_api::assert_same_type;
+/// # use common::assert_same_type;
 /// assert_same_type!(&Box<u32>, &u32);
 /// ```
 #[macro_export]
@@ -61,7 +61,7 @@ fn types_must_be_equal<T, U>(_: T)
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::assert_field_type;
+/// # use common::assert_field_type;
 /// pub struct A {
 ///     field1: u32,
 /// }
@@ -72,7 +72,7 @@ fn types_must_be_equal<T, U>(_: T)
 /// Different types will cause a compile failure
 ///
 /// ```compile_fail
-/// # use qemu_api::assert_field_type;
+/// # use common::assert_field_type;
 /// # pub struct A { field1: u32 }
 /// assert_field_type!(A, field1, i32);
 /// ```
@@ -103,7 +103,7 @@ const fn types_must_be_equal<T, U>(_: &T)
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::assert_match;
+/// # use common::assert_match;
 /// // JoinHandle does not implement `Eq`, therefore the result
 /// // does not either.
 /// let result: Result<std::thread::JoinHandle<()>, u32> = Err(42);
@@ -132,12 +132,12 @@ macro_rules! assert_match {
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::static_assert;
+/// # use common::static_assert;
 /// static_assert!("abc".len() == 3);
 /// ```
 ///
 /// ```compile_fail
-/// # use qemu_api::static_assert;
+/// # use common::static_assert;
 /// static_assert!("abc".len() == 2); // does not compile
 /// ```
 #[macro_export]
diff --git a/rust/qemu-api/src/bitops.rs b/rust/common/src/bitops.rs
similarity index 98%
rename from rust/qemu-api/src/bitops.rs
rename to rust/common/src/bitops.rs
index b1e3a530ab5..06c78c3b8a7 100644
--- a/rust/qemu-api/src/bitops.rs
+++ b/rust/common/src/bitops.rs
@@ -3,7 +3,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 //! This module provides bit operation extensions to integer types.
-//! It is usually included via the `qemu_api` prelude.
 
 use std::ops::{
     Add, AddAssign, BitAnd, BitAndAssign, BitOr, BitOrAssign, BitXor, BitXorAssign, Div, DivAssign,
diff --git a/rust/qemu-api/src/callbacks.rs b/rust/common/src/callbacks.rs
similarity index 97%
rename from rust/qemu-api/src/callbacks.rs
rename to rust/common/src/callbacks.rs
index dbe2305f509..b8898fe96f7 100644
--- a/rust/qemu-api/src/callbacks.rs
+++ b/rust/common/src/callbacks.rs
@@ -55,7 +55,7 @@
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::callbacks::FnCall;
+/// # use common::callbacks::FnCall;
 /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
 ///     F::call((s,))
 /// }
@@ -71,7 +71,7 @@
 /// Attempting to pass a non-zero-sized closure causes a compile-time failure:
 ///
 /// ```compile_fail
-/// # use qemu_api::callbacks::FnCall;
+/// # use common::callbacks::FnCall;
 /// # fn call_it<'a, F: FnCall<(&'a str,), String>>(_f: &F, s: &'a str) -> String {
 /// #     F::call((s,))
 /// # }
@@ -82,7 +82,7 @@
 /// `()` can be used to indicate "no function":
 ///
 /// ```
-/// # use qemu_api::callbacks::FnCall;
+/// # use common::callbacks::FnCall;
 /// fn optional<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> Option<String> {
 ///     if F::IS_SOME {
 ///         Some(F::call((s,)))
@@ -97,7 +97,7 @@
 /// Invoking `F::call` will then be a run-time error.
 ///
 /// ```should_panic
-/// # use qemu_api::callbacks::FnCall;
+/// # use common::callbacks::FnCall;
 /// # fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
 /// #     F::call((s,))
 /// # }
@@ -120,7 +120,7 @@ pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
     /// You can use `IS_SOME` to catch this at compile time:
     ///
     /// ```compile_fail
-    /// # use qemu_api::callbacks::FnCall;
+    /// # use common::callbacks::FnCall;
     /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
     ///     const { assert!(F::IS_SOME) }
     ///     F::call((s,))
diff --git a/rust/qemu-api/src/errno.rs b/rust/common/src/errno.rs
similarity index 98%
rename from rust/qemu-api/src/errno.rs
rename to rust/common/src/errno.rs
index 507850fe33c..64b2933b078 100644
--- a/rust/qemu-api/src/errno.rs
+++ b/rust/common/src/errno.rs
@@ -185,7 +185,7 @@ fn map_ok(self) -> i32 {
 /// are interpreted as negated `errno` and turned into an `Err`.
 ///
 /// ```
-/// # use qemu_api::errno::into_io_result;
+/// # use common::errno::into_io_result;
 /// # use std::io::ErrorKind;
 /// let ok = into_io_result(1i32).unwrap();
 /// assert_eq!(ok, 1u32);
@@ -201,7 +201,7 @@ fn map_ok(self) -> i32 {
 /// likely overflows and will panic:
 ///
 /// ```should_panic
-/// # use qemu_api::errno::into_io_result;
+/// # use common::errno::into_io_result;
 /// # #[allow(dead_code)]
 /// let err = into_io_result(-0x1234_5678i32); // panic
 /// ```
@@ -213,7 +213,7 @@ pub fn into_io_result<T: GetErrno>(value: T) -> io::Result<T::Out> {
 /// values to report errors.
 ///
 /// ```
-/// # use qemu_api::errno::into_neg_errno;
+/// # use common::errno::into_neg_errno;
 /// # use std::io::{self, ErrorKind};
 /// let ok: io::Result<()> = Ok(());
 /// assert_eq!(into_neg_errno(ok), 0);
@@ -232,7 +232,7 @@ pub fn into_io_result<T: GetErrno>(value: T) -> io::Result<T::Out> {
 /// positive:
 ///
 /// ```should_panic
-/// # use qemu_api::errno::into_neg_errno;
+/// # use common::errno::into_neg_errno;
 /// # use std::io;
 /// let err: io::Result<u32> = Ok(0x8899_AABB);
 /// into_neg_errno(err) // panic
diff --git a/rust/common/src/lib.rs b/rust/common/src/lib.rs
new file mode 100644
index 00000000000..25216503aab
--- /dev/null
+++ b/rust/common/src/lib.rs
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod assertions;
+
+pub mod bitops;
+
+pub mod callbacks;
+pub use callbacks::FnCall;
+
+pub mod errno;
+pub use errno::Errno;
+
+pub mod opaque;
+pub use opaque::{Opaque, Wrapper};
+
+pub mod uninit;
+pub use uninit::MaybeUninitField;
+
+pub mod zeroable;
+pub use zeroable::Zeroable;
diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
new file mode 100644
index 00000000000..d25a5f3ae1a
--- /dev/null
+++ b/rust/common/src/opaque.rs
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: MIT
+
+//! ## Opaque wrappers
+//!
+//! The cell types from the previous section are useful at the boundaries
+//! of code that requires interior mutability.  When writing glue code that
+//! interacts directly with C structs, however, it is useful to operate
+//! at a lower level.
+//!
+//! C functions often violate Rust's fundamental assumptions about memory
+//! safety by modifying memory even if it is shared.  Furthermore, C structs
+//! often start their life uninitialized and may be populated lazily.
+//!
+//! For this reason, this module provides the [`Opaque<T>`] type to opt out
+//! of Rust's usual guarantees about the wrapped type. Access to the wrapped
+//! value is always through raw pointers, obtained via methods like
+//! [`as_mut_ptr()`](Opaque::as_mut_ptr) and [`as_ptr()`](Opaque::as_ptr). These
+//! pointers can then be passed to C functions or dereferenced; both actions
+//! require `unsafe` blocks, making it clear where safety guarantees must be
+//! manually verified. For example
+//!
+//! ```ignore
+//! unsafe {
+//!     let state = Opaque::<MyStruct>::uninit();
+//!     qemu_struct_init(state.as_mut_ptr());
+//! }
+//! ```
+//!
+//! [`Opaque<T>`] will usually be wrapped one level further, so that
+//! bridge methods can be added to the wrapper:
+//!
+//! ```ignore
+//! pub struct MyStruct(Opaque<bindings::MyStruct>);
+//!
+//! impl MyStruct {
+//!     fn new() -> Pin<Box<MyStruct>> {
+//!         let result = Box::pin(unsafe { Opaque::uninit() });
+//!         unsafe { qemu_struct_init(result.as_mut_ptr()) };
+//!         result
+//!     }
+//! }
+//! ```
+//!
+//! This pattern of wrapping bindgen-generated types in [`Opaque<T>`] provides
+//! several advantages:
+//!
+//! * The choice of traits to be implemented is not limited by the
+//!   bindgen-generated code.  For example, [`Drop`] can be added without
+//!   disabling [`Copy`] on the underlying bindgen type
+//!
+//! * [`Send`] and [`Sync`] implementations can be controlled by the wrapper
+//!   type rather than being automatically derived from the C struct's layout
+//!
+//! * Methods can be implemented in a separate crate from the bindgen-generated
+//!   bindings
+//!
+//! * [`Debug`](std::fmt::Debug) and [`Display`](std::fmt::Display)
+//!   implementations can be customized to be more readable than the raw C
+//!   struct representation
+//!
+//! The [`Opaque<T>`] type does not include BQL validation; it is possible to
+//! assert in the code that the right lock is taken, to use it together
+//! with a custom lock guard type, or to let C code take the lock, as
+//! appropriate.  It is also possible to use it with non-thread-safe
+//! types, since by default (unlike [`BqlCell`] and [`BqlRefCell`]
+//! it is neither `Sync` nor `Send`.
+//!
+//! While [`Opaque<T>`] is necessary for C interop, it should be used sparingly
+//! and only at FFI boundaries. For QEMU-specific types that need interior
+//! mutability, prefer [`BqlCell`] or [`BqlRefCell`].
+//!
+//! [`BqlCell`]: ../../qemu_api/cell/struct.BqlCell.html
+//! [`BqlRefCell`]: ../../qemu_api/cell/struct.BqlRefCell.html
+use std::{cell::UnsafeCell, fmt, marker::PhantomPinned, mem::MaybeUninit, ptr::NonNull};
+
+/// Stores an opaque value that is shared with C code.
+///
+/// Often, C structs can changed when calling a C function even if they are
+/// behind a shared Rust reference, or they can be initialized lazily and have
+/// invalid bit patterns (e.g. `3` for a [`bool`]).  This goes against Rust's
+/// strict aliasing rules, which normally prevent mutation through shared
+/// references.
+///
+/// Wrapping the struct with `Opaque<T>` ensures that the Rust compiler does not
+/// assume the usual constraints that Rust structs require, and allows using
+/// shared references on the Rust side.
+///
+/// `Opaque<T>` is `#[repr(transparent)]`, so that it matches the memory layout
+/// of `T`.
+#[repr(transparent)]
+pub struct Opaque<T> {
+    value: UnsafeCell<MaybeUninit<T>>,
+    // PhantomPinned also allows multiple references to the `Opaque<T>`, i.e.
+    // one `&mut Opaque<T>` can coexist with a `&mut T` or any number of `&T`;
+    // see https://docs.rs/pinned-aliasable/latest/pinned_aliasable/.
+    _pin: PhantomPinned,
+}
+
+impl<T> Opaque<T> {
+    /// Creates a new shared reference from a C pointer
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid, though it need not point to a valid value.
+    pub unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
+        let ptr = NonNull::new(ptr).unwrap().cast::<Self>();
+        // SAFETY: Self is a transparent wrapper over T
+        unsafe { ptr.as_ref() }
+    }
+
+    /// Creates a new opaque object with uninitialized contents.
+    ///
+    /// # Safety
+    ///
+    /// Ultimately the pointer to the returned value will be dereferenced
+    /// in another `unsafe` block, for example when passing it to a C function,
+    /// but the functions containing the dereference are usually safe.  The
+    /// value returned from `uninit()` must be initialized and pinned before
+    /// calling them.
+    pub const unsafe fn uninit() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::uninit()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Creates a new opaque object with zeroed contents.
+    ///
+    /// # Safety
+    ///
+    /// Ultimately the pointer to the returned value will be dereferenced
+    /// in another `unsafe` block, for example when passing it to a C function,
+    /// but the functions containing the dereference are usually safe.  The
+    /// value returned from `uninit()` must be pinned (and possibly initialized)
+    /// before calling them.
+    pub const unsafe fn zeroed() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::zeroed()),
+            _pin: PhantomPinned,
+        }
+    }
+
+    /// Returns a raw mutable pointer to the opaque data.
+    pub const fn as_mut_ptr(&self) -> *mut T {
+        UnsafeCell::get(&self.value).cast()
+    }
+
+    /// Returns a raw pointer to the opaque data.
+    pub const fn as_ptr(&self) -> *const T {
+        self.as_mut_ptr().cast_const()
+    }
+
+    /// Returns a raw pointer to the opaque data that can be passed to a
+    /// C function as `void *`.
+    pub const fn as_void_ptr(&self) -> *mut std::ffi::c_void {
+        UnsafeCell::get(&self.value).cast()
+    }
+
+    /// Converts a raw pointer to the wrapped type.
+    pub const fn raw_get(slot: *mut Self) -> *mut T {
+        // Compare with Linux's raw_get method, which goes through an UnsafeCell
+        // because it takes a *const Self instead.
+        slot.cast()
+    }
+}
+
+impl<T> fmt::Debug for Opaque<T> {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        let mut name: String = "Opaque<".to_string();
+        name += std::any::type_name::<T>();
+        name += ">";
+        f.debug_tuple(&name).field(&self.as_ptr()).finish()
+    }
+}
+
+impl<T: Default> Opaque<T> {
+    /// Creates a new opaque object with default contents.
+    ///
+    /// # Safety
+    ///
+    /// Ultimately the pointer to the returned value will be dereferenced
+    /// in another `unsafe` block, for example when passing it to a C function,
+    /// but the functions containing the dereference are usually safe.  The
+    /// value returned from `uninit()` must be pinned before calling them.
+    pub unsafe fn new() -> Self {
+        Self {
+            value: UnsafeCell::new(MaybeUninit::new(T::default())),
+            _pin: PhantomPinned,
+        }
+    }
+}
+
+/// Annotates [`Self`] as a transparent wrapper for another type.
+///
+/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
+///
+/// # Examples
+///
+/// ```
+/// # use std::mem::ManuallyDrop;
+/// # use common::opaque::Wrapper;
+/// #[repr(transparent)]
+/// pub struct Example {
+///     inner: ManuallyDrop<String>,
+/// }
+///
+/// unsafe impl Wrapper for Example {
+///     type Wrapped = String;
+/// }
+/// ```
+///
+/// # Safety
+///
+/// `Self` must be a `#[repr(transparent)]` wrapper for the `Wrapped` type,
+/// whether directly or indirectly.
+///
+/// # Methods
+///
+/// By convention, types that implement Wrapper also implement the following
+/// methods:
+///
+/// ```ignore
+/// pub const unsafe fn from_raw<'a>(value: *mut Self::Wrapped) -> &'a Self;
+/// pub const unsafe fn as_mut_ptr(&self) -> *mut Self::Wrapped;
+/// pub const unsafe fn as_ptr(&self) -> *const Self::Wrapped;
+/// pub const unsafe fn raw_get(slot: *mut Self) -> *const Self::Wrapped;
+/// ```
+///
+/// They are not defined here to allow them to be `const`.
+///
+/// [`qemu_api_macros::Wrapper`]: ../../qemu_api_macros/derive.Wrapper.html
+pub unsafe trait Wrapper {
+    type Wrapped;
+}
+
+unsafe impl<T> Wrapper for Opaque<T> {
+    type Wrapped = T;
+}
diff --git a/rust/qemu-api/src/uninit.rs b/rust/common/src/uninit.rs
similarity index 98%
rename from rust/qemu-api/src/uninit.rs
rename to rust/common/src/uninit.rs
index b0a829729dd..e7f9fcd2e3f 100644
--- a/rust/qemu-api/src/uninit.rs
+++ b/rust/common/src/uninit.rs
@@ -63,7 +63,7 @@ fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
 /// }
 ///
 /// # use std::mem::MaybeUninit;
-/// # use qemu_api::{assert_match, uninit_field_mut};
+/// # use common::{assert_match, uninit_field_mut};
 ///
 /// let mut s: MaybeUninit<S> = MaybeUninit::zeroed();
 /// uninit_field_mut!(s, x).write(5);
diff --git a/rust/common/src/zeroable.rs b/rust/common/src/zeroable.rs
new file mode 100644
index 00000000000..fd056deb1f6
--- /dev/null
+++ b/rust/common/src/zeroable.rs
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Defines a trait for structs that can be safely initialized with zero bytes.
+
+/// Encapsulates the requirement that
+/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
+/// behavior.
+///
+/// # Safety
+///
+/// Do not add this trait to a type unless all-zeroes is a valid value for the
+/// type.  In particular, raw pointers can be zero, but references and
+/// `NonNull<T>` cannot.
+pub unsafe trait Zeroable: Default {
+    /// Return a value of Self whose memory representation consists of all
+    /// zeroes, with the possible exclusion of padding bytes.
+    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
+}
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 88ef110507d..6d15f107dfa 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
+common = { path = "../../../common" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 2a1be329abc..c4a9f531f7d 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -7,7 +7,8 @@ _libpl011_rs = static_library(
     bilge_rs,
     bilge_impl_rs,
     bits_rs,
-    qemu_api,
+    common_rs,
+    qemu_api_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 8411db8d00c..b4aa6c45f87 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -4,6 +4,7 @@
 
 use std::{ffi::CStr, mem::size_of};
 
+use common::{static_assert, uninit_field_mut};
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward, impl_vmstate_struct,
@@ -14,9 +15,7 @@
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, Owned, ParentField, ParentInit},
-    static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    uninit_field_mut,
     vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_fields, vmstate_of, vmstate_subsections, vmstate_unused,
 };
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index ac5df23c1d0..ba7354f07e0 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -11,6 +11,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+common = { path = "../../../common" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index c2d7c0532ca..c91d330439a 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -4,7 +4,8 @@ _libhpet_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   dependencies: [
-    qemu_api,
+    common_rs,
+    qemu_api_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index dd5326a40d4..72375d31550 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -10,6 +10,7 @@
     slice::from_ref,
 };
 
+use common::{bitops::IntegerExt, uninit_field_mut};
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
@@ -27,7 +28,6 @@
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
-    uninit_field_mut,
     vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
     vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
 };
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index 619d662ee1e..0605225fbb1 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -4,7 +4,8 @@
 
 use std::ptr::addr_of_mut;
 
-use qemu_api::{cell::bql_locked, zeroable::Zeroable};
+use common::Zeroable;
+use qemu_api::cell::bql_locked;
 
 /// Each `HPETState` represents a Event Timer Block. The v1 spec supports
 /// up to 8 blocks. QEMU only uses 1 block (in PC machine).
diff --git a/rust/meson.build b/rust/meson.build
index 331f11b7e72..402f8d66007 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -22,6 +22,7 @@ qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 
 genrs = []
 
+subdir('common')
 subdir('qemu-api-macros')
 subdir('bits')
 subdir('qemu-api')
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index a65a7ce2fe9..49003a47801 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -97,7 +97,7 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
         .ident;
 
     Ok(quote! {
-        ::qemu_api::assert_field_type!(#name, #parent,
+        ::common::assert_field_type!(#name, #parent,
             ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
 
         ::qemu_api::module_init! {
@@ -125,20 +125,20 @@ fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     let typ = &field.ty;
 
     Ok(quote! {
-        unsafe impl ::qemu_api::cell::Wrapper for #name {
-            type Wrapped = <#typ as ::qemu_api::cell::Wrapper>::Wrapped;
+        unsafe impl ::common::opaque::Wrapper for #name {
+            type Wrapped = <#typ as ::common::opaque::Wrapper>::Wrapped;
         }
         impl #name {
-            pub unsafe fn from_raw<'a>(ptr: *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped) -> &'a Self {
+            pub unsafe fn from_raw<'a>(ptr: *mut <Self as ::common::opaque::Wrapper>::Wrapped) -> &'a Self {
                 let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
                 unsafe { ptr.as_ref() }
             }
 
-            pub const fn as_mut_ptr(&self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
+            pub const fn as_mut_ptr(&self) -> *mut <Self as ::common::opaque::Wrapper>::Wrapped {
                 self.0.as_mut_ptr()
             }
 
-            pub const fn as_ptr(&self) -> *const <Self as ::qemu_api::cell::Wrapper>::Wrapped {
+            pub const fn as_ptr(&self) -> *const <Self as ::common::opaque::Wrapper>::Wrapped {
                 self.0.as_ptr()
             }
 
@@ -146,7 +146,7 @@ pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
                 self.0.as_void_ptr()
             }
 
-            pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
+            pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::common::opaque::Wrapper>::Wrapped {
                 slot.cast()
             }
         }
@@ -282,7 +282,7 @@ macro_rules! str_to_c_str {
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
                 set_default: #set_default,
                 defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
-                ..::qemu_api::zeroable::Zeroable::ZERO
+                ..::common::Zeroable::ZERO
             }
         });
     }
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 0e5a5728908..ef2806368d2 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -108,7 +108,7 @@ unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
                         offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
                         set_default: true,
                         defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
-                        ..::qemu_api::zeroable::Zeroable::ZERO
+                        ..::common::Zeroable::ZERO
                     }
                 ];
             }
@@ -135,7 +135,7 @@ unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
                         offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
                         set_default: true,
                         defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
-                        ..::qemu_api::zeroable::Zeroable::ZERO
+                        ..::common::Zeroable::ZERO
                     }
                 ];
             }
@@ -165,7 +165,7 @@ struct Foo {
             }
         },
         quote! {
-            ::qemu_api::assert_field_type!(
+            ::common::assert_field_type!(
                 Foo,
                 _unused,
                 ::qemu_api::qom::ParentField<<Foo as ::qemu_api::qom::ObjectImpl>::ParentType>
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index c5ed78035b6..2e0e2044912 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -14,6 +14,7 @@ repository.workspace = true
 rust-version.workspace = true
 
 [dependencies]
+common = { path = "../common" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 anyhow = { workspace = true }
 foreign = { workspace = true }
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 062009f1618..64af3caef58 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -52,13 +52,9 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
-      'src/assertions.rs',
       'src/bindings.rs',
-      'src/bitops.rs',
-      'src/callbacks.rs',
       'src/cell.rs',
       'src/chardev.rs',
-      'src/errno.rs',
       'src/error.rs',
       'src/irq.rs',
       'src/log.rs',
@@ -69,23 +65,21 @@ _qemu_api_rs = static_library(
       'src/qom.rs',
       'src/sysbus.rs',
       'src/timer.rs',
-      'src/uninit.rs',
       'src/vmstate.rs',
-      'src/zeroable.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
                  qom, hwcore, chardev, migration],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(link_with: [_qemu_api_rs],
+qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
   dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
@@ -94,7 +88,7 @@ qemu_api = declare_dependency(link_with: [_qemu_api_rs],
 rust.doctest('rust-qemu-api-doctests',
      _qemu_api_rs,
      protocol: 'rust',
-     dependencies: qemu_api,
+     dependencies: [qemu_api_rs],
      suite: ['doc', 'rust'])
 
 test('rust-qemu-api-integration',
@@ -104,7 +98,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api]),
+        dependencies: [common_rs, qemu_api_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index b8104dea8be..3acdd903b52 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -20,6 +20,8 @@
 
 //! `bindgen`-generated declarations.
 
+use common::Zeroable;
+
 #[cfg(MESON)]
 include!("bindings.inc.rs");
 
@@ -56,3 +58,22 @@ unsafe impl Sync for VMStateField {}
 
 unsafe impl Send for VMStateInfo {}
 unsafe impl Sync for VMStateInfo {}
+
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for crate::bindings::VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
+
+unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::Property {}
+unsafe impl Zeroable for crate::bindings::VMStateFlags {}
+unsafe impl Zeroable for crate::bindings::VMStateField {}
+unsafe impl Zeroable for crate::bindings::VMStateDescription {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
+unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
+unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
+unsafe impl Zeroable for crate::bindings::CharBackend {}
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 9943d7286b6..d13848df200 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -141,82 +141,13 @@
 //! Multiple immutable borrows are allowed via [`borrow`](BqlRefCell::borrow),
 //! or a single mutable borrow via [`borrow_mut`](BqlRefCell::borrow_mut).  The
 //! thread will panic if these rules are violated or if the BQL is not held.
-//!
-//! ## Opaque wrappers
-//!
-//! The cell types from the previous section are useful at the boundaries
-//! of code that requires interior mutability.  When writing glue code that
-//! interacts directly with C structs, however, it is useful to operate
-//! at a lower level.
-//!
-//! C functions often violate Rust's fundamental assumptions about memory
-//! safety by modifying memory even if it is shared.  Furthermore, C structs
-//! often start their life uninitialized and may be populated lazily.
-//!
-//! For this reason, this module provides the [`Opaque<T>`] type to opt out
-//! of Rust's usual guarantees about the wrapped type. Access to the wrapped
-//! value is always through raw pointers, obtained via methods like
-//! [`as_mut_ptr()`](Opaque::as_mut_ptr) and [`as_ptr()`](Opaque::as_ptr). These
-//! pointers can then be passed to C functions or dereferenced; both actions
-//! require `unsafe` blocks, making it clear where safety guarantees must be
-//! manually verified. For example
-//!
-//! ```ignore
-//! unsafe {
-//!     let state = Opaque::<MyStruct>::uninit();
-//!     qemu_struct_init(state.as_mut_ptr());
-//! }
-//! ```
-//!
-//! [`Opaque<T>`] will usually be wrapped one level further, so that
-//! bridge methods can be added to the wrapper:
-//!
-//! ```ignore
-//! pub struct MyStruct(Opaque<bindings::MyStruct>);
-//!
-//! impl MyStruct {
-//!     fn new() -> Pin<Box<MyStruct>> {
-//!         let result = Box::pin(unsafe { Opaque::uninit() });
-//!         unsafe { qemu_struct_init(result.as_mut_ptr()) };
-//!         result
-//!     }
-//! }
-//! ```
-//!
-//! This pattern of wrapping bindgen-generated types in [`Opaque<T>`] provides
-//! several advantages:
-//!
-//! * The choice of traits to be implemented is not limited by the
-//!   bindgen-generated code.  For example, [`Drop`] can be added without
-//!   disabling [`Copy`] on the underlying bindgen type
-//!
-//! * [`Send`] and [`Sync`] implementations can be controlled by the wrapper
-//!   type rather than being automatically derived from the C struct's layout
-//!
-//! * Methods can be implemented in a separate crate from the bindgen-generated
-//!   bindings
-//!
-//! * [`Debug`](std::fmt::Debug) and [`Display`](std::fmt::Display)
-//!   implementations can be customized to be more readable than the raw C
-//!   struct representation
-//!
-//! The [`Opaque<T>`] type does not include BQL validation; it is possible to
-//! assert in the code that the right lock is taken, to use it together
-//! with a custom lock guard type, or to let C code take the lock, as
-//! appropriate.  It is also possible to use it with non-thread-safe
-//! types, since by default (unlike [`BqlCell`] and [`BqlRefCell`]
-//! it is neither `Sync` nor `Send`.
-//!
-//! While [`Opaque<T>`] is necessary for C interop, it should be used sparingly
-//! and only at FFI boundaries. For QEMU-specific types that need interior
-//! mutability, prefer [`BqlCell`] or [`BqlRefCell`].
 
 use std::{
     cell::{Cell, UnsafeCell},
     cmp::Ordering,
     fmt,
-    marker::{PhantomData, PhantomPinned},
-    mem::{self, MaybeUninit},
+    marker::PhantomData,
+    mem,
     ops::{Deref, DerefMut},
     ptr::NonNull,
 };
@@ -939,165 +870,3 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
         (**self).fmt(f)
     }
 }
-
-/// Stores an opaque value that is shared with C code.
-///
-/// Often, C structs can changed when calling a C function even if they are
-/// behind a shared Rust reference, or they can be initialized lazily and have
-/// invalid bit patterns (e.g. `3` for a [`bool`]).  This goes against Rust's
-/// strict aliasing rules, which normally prevent mutation through shared
-/// references.
-///
-/// Wrapping the struct with `Opaque<T>` ensures that the Rust compiler does not
-/// assume the usual constraints that Rust structs require, and allows using
-/// shared references on the Rust side.
-///
-/// `Opaque<T>` is `#[repr(transparent)]`, so that it matches the memory layout
-/// of `T`.
-#[repr(transparent)]
-pub struct Opaque<T> {
-    value: UnsafeCell<MaybeUninit<T>>,
-    // PhantomPinned also allows multiple references to the `Opaque<T>`, i.e.
-    // one `&mut Opaque<T>` can coexist with a `&mut T` or any number of `&T`;
-    // see https://docs.rs/pinned-aliasable/latest/pinned_aliasable/.
-    _pin: PhantomPinned,
-}
-
-impl<T> Opaque<T> {
-    /// Creates a new shared reference from a C pointer
-    ///
-    /// # Safety
-    ///
-    /// The pointer must be valid, though it need not point to a valid value.
-    pub unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
-        let ptr = NonNull::new(ptr).unwrap().cast::<Self>();
-        // SAFETY: Self is a transparent wrapper over T
-        unsafe { ptr.as_ref() }
-    }
-
-    /// Creates a new opaque object with uninitialized contents.
-    ///
-    /// # Safety
-    ///
-    /// Ultimately the pointer to the returned value will be dereferenced
-    /// in another `unsafe` block, for example when passing it to a C function,
-    /// but the functions containing the dereference are usually safe.  The
-    /// value returned from `uninit()` must be initialized and pinned before
-    /// calling them.
-    pub const unsafe fn uninit() -> Self {
-        Self {
-            value: UnsafeCell::new(MaybeUninit::uninit()),
-            _pin: PhantomPinned,
-        }
-    }
-
-    /// Creates a new opaque object with zeroed contents.
-    ///
-    /// # Safety
-    ///
-    /// Ultimately the pointer to the returned value will be dereferenced
-    /// in another `unsafe` block, for example when passing it to a C function,
-    /// but the functions containing the dereference are usually safe.  The
-    /// value returned from `uninit()` must be pinned (and possibly initialized)
-    /// before calling them.
-    pub const unsafe fn zeroed() -> Self {
-        Self {
-            value: UnsafeCell::new(MaybeUninit::zeroed()),
-            _pin: PhantomPinned,
-        }
-    }
-
-    /// Returns a raw mutable pointer to the opaque data.
-    pub const fn as_mut_ptr(&self) -> *mut T {
-        UnsafeCell::get(&self.value).cast()
-    }
-
-    /// Returns a raw pointer to the opaque data.
-    pub const fn as_ptr(&self) -> *const T {
-        self.as_mut_ptr().cast_const()
-    }
-
-    /// Returns a raw pointer to the opaque data that can be passed to a
-    /// C function as `void *`.
-    pub const fn as_void_ptr(&self) -> *mut std::ffi::c_void {
-        UnsafeCell::get(&self.value).cast()
-    }
-
-    /// Converts a raw pointer to the wrapped type.
-    pub const fn raw_get(slot: *mut Self) -> *mut T {
-        // Compare with Linux's raw_get method, which goes through an UnsafeCell
-        // because it takes a *const Self instead.
-        slot.cast()
-    }
-}
-
-impl<T> fmt::Debug for Opaque<T> {
-    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
-        let mut name: String = "Opaque<".to_string();
-        name += std::any::type_name::<T>();
-        name += ">";
-        f.debug_tuple(&name).field(&self.as_ptr()).finish()
-    }
-}
-
-impl<T: Default> Opaque<T> {
-    /// Creates a new opaque object with default contents.
-    ///
-    /// # Safety
-    ///
-    /// Ultimately the pointer to the returned value will be dereferenced
-    /// in another `unsafe` block, for example when passing it to a C function,
-    /// but the functions containing the dereference are usually safe.  The
-    /// value returned from `uninit()` must be pinned before calling them.
-    pub unsafe fn new() -> Self {
-        Self {
-            value: UnsafeCell::new(MaybeUninit::new(T::default())),
-            _pin: PhantomPinned,
-        }
-    }
-}
-
-/// Annotates [`Self`] as a transparent wrapper for another type.
-///
-/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
-///
-/// # Examples
-///
-/// ```
-/// # use std::mem::ManuallyDrop;
-/// # use qemu_api::cell::Wrapper;
-/// #[repr(transparent)]
-/// pub struct Example {
-///     inner: ManuallyDrop<String>,
-/// }
-///
-/// unsafe impl Wrapper for Example {
-///     type Wrapped = String;
-/// }
-/// ```
-///
-/// # Safety
-///
-/// `Self` must be a `#[repr(transparent)]` wrapper for the `Wrapped` type,
-/// whether directly or indirectly.
-///
-/// # Methods
-///
-/// By convention, types that implement Wrapper also implement the following
-/// methods:
-///
-/// ```ignore
-/// pub const unsafe fn from_raw<'a>(value: *mut Self::Wrapped) -> &'a Self;
-/// pub const unsafe fn as_mut_ptr(&self) -> *mut Self::Wrapped;
-/// pub const unsafe fn as_ptr(&self) -> *const Self::Wrapped;
-/// pub const unsafe fn raw_get(slot: *mut Self) -> *const Self::Wrapped;
-/// ```
-///
-/// They are not defined here to allow them to be `const`.
-pub unsafe trait Wrapper {
-    type Wrapped;
-}
-
-unsafe impl<T> Wrapper for Opaque<T> {
-    type Wrapped = T;
-}
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index cb27be52569..5a351dcecb0 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -18,10 +18,11 @@
     slice,
 };
 
+use common::{callbacks::FnCall, errno, Opaque};
+
 use crate::{
     bindings,
-    callbacks::FnCall,
-    cell::{BqlRefMut, Opaque},
+    cell::{BqlRefCell, BqlRefMut},
     prelude::*,
 };
 
diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
index e114fc4178b..8bac3cbec81 100644
--- a/rust/qemu-api/src/error.rs
+++ b/rust/qemu-api/src/error.rs
@@ -316,10 +316,11 @@ mod tests {
     use std::ffi::CStr;
 
     use anyhow::anyhow;
+    use common::assert_match;
     use foreign::OwnedPointer;
 
     use super::*;
-    use crate::{assert_match, bindings};
+    use crate::bindings;
 
     #[track_caller]
     fn error_for_test(msg: &CStr) -> OwnedPointer<Error> {
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 1526e6f63a1..ea6b32848c5 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -10,9 +10,10 @@
     ptr,
 };
 
+use common::Opaque;
+
 use crate::{
     bindings::{self, qemu_set_irq},
-    cell::Opaque,
     prelude::*,
     qom::ObjectClass,
 };
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index daa2493bb69..6232e39e711 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -13,12 +13,8 @@
 #[rustfmt::skip]
 pub mod prelude;
 
-pub mod assertions;
-pub mod bitops;
-pub mod callbacks;
 pub mod cell;
 pub mod chardev;
-pub mod errno;
 pub mod error;
 pub mod irq;
 pub mod log;
@@ -28,9 +24,7 @@
 pub mod qom;
 pub mod sysbus;
 pub mod timer;
-pub mod uninit;
 pub mod vmstate;
-pub mod zeroable;
 
 // Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
 // crate).
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
index a441b8c1f2e..d07f6272dc1 100644
--- a/rust/qemu-api/src/log.rs
+++ b/rust/qemu-api/src/log.rs
@@ -8,7 +8,9 @@
     ptr::NonNull,
 };
 
-use crate::{bindings, errno};
+use common::errno;
+
+use crate::bindings;
 
 #[repr(u32)]
 /// Represents specific error categories within QEMU's logging system.
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index e40fad6cf19..f790cb5fd2d 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -10,14 +10,11 @@
 };
 
 pub use bindings::{hwaddr, MemTxAttrs};
+use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 
 use crate::{
     bindings::{self, device_endian, memory_region_init_io},
-    callbacks::FnCall,
-    cell::Opaque,
     prelude::*,
-    uninit::MaybeUninitField,
-    zeroable::Zeroable,
 };
 
 pub struct MemoryRegionOps<T>(
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 8f9e23ee2c5..dcfe71497f0 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -4,13 +4,9 @@
 
 //! Commonly used traits and types for QEMU.
 
-pub use crate::bitops::IntegerExt;
-
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
-pub use crate::errno;
-
 pub use crate::log_mask_ln;
 
 pub use crate::qdev::DeviceMethods;
@@ -19,8 +15,8 @@
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
-pub use crate::qom::ObjectDeref;
 pub use crate::qom::ObjectClassMethods;
+pub use crate::qom::ObjectDeref;
 pub use crate::qom::ObjectMethods;
 pub use crate::qom::ObjectType;
 
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index e2b4121cac5..8be125fae47 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -10,11 +10,11 @@
 };
 
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
+use common::{callbacks::FnCall, Opaque};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
-    callbacks::FnCall,
-    cell::{bql_locked, Opaque},
+    cell::bql_locked,
     chardev::Chardev,
     error::{Error, Result},
     impl_vmstate_c_struct,
@@ -246,7 +246,7 @@ macro_rules! define_property {
             bitnr: $bitnr,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..$crate::zeroable::Zeroable::ZERO
+            ..::common::zeroable::Zeroable::ZERO
         }
     };
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
@@ -257,7 +257,7 @@ macro_rules! define_property {
             offset: ::std::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..$crate::zeroable::Zeroable::ZERO
+            ..::common::zeroable::Zeroable::ZERO
         }
     };
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) => {
@@ -267,7 +267,7 @@ macro_rules! define_property {
             info: $prop,
             offset: ::std::mem::offset_of!($state, $field) as isize,
             set_default: false,
-            ..$crate::zeroable::Zeroable::ZERO
+            ..::common::zeroable::Zeroable::ZERO
         }
     };
 }
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 12c6fc6752c..49b4f03ccfc 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -102,13 +102,14 @@
 };
 
 pub use bindings::ObjectClass;
+use common::Opaque;
 
 use crate::{
     bindings::{
         self, object_class_dynamic_cast, object_dynamic_cast, object_get_class,
         object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
-    cell::{bql_locked, Opaque},
+    cell::bql_locked,
     impl_vmstate_pointer,
 };
 
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index e92502a8fe6..4a5b4cbbf67 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -7,10 +7,11 @@
 use std::{ffi::CStr, ptr::addr_of_mut};
 
 pub use bindings::SysBusDeviceClass;
+use common::Opaque;
 
 use crate::{
     bindings,
-    cell::{bql_locked, Opaque},
+    cell::bql_locked,
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 1e639eaf221..383e1a6e774 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -7,10 +7,10 @@
     pin::Pin,
 };
 
-use crate::{
-    bindings::{self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType},
-    callbacks::FnCall,
-    cell::Opaque,
+use common::{callbacks::FnCall, Opaque};
+
+use crate::bindings::{
+    self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
 };
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index ce42b031bc1..06aac3a73f4 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -35,14 +35,15 @@
     ptr::{addr_of, NonNull},
 };
 
-pub use crate::bindings::{MigrationPriority, VMStateField};
-use crate::{
-    bindings::{self, VMStateFlags},
+use common::{
     callbacks::FnCall,
     errno::{into_neg_errno, Errno},
-    zeroable::Zeroable,
+    Zeroable,
 };
 
+use crate::bindings::{self, VMStateFlags};
+pub use crate::bindings::{MigrationPriority, VMStateField};
+
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
 /// [`PhantomData`]`<T>` argument; `T` is the type of
@@ -271,7 +272,7 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-impl_vmstate_transparent!(crate::cell::Opaque<T> where T: VMState);
+impl_vmstate_transparent!(::common::Opaque<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
@@ -324,7 +325,7 @@ unsafe impl VMState for $type {
                 vmsd: ::std::ptr::addr_of!($vmsd),
                 size: ::std::mem::size_of::<$type>(),
                 flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-                ..$crate::zeroable::Zeroable::ZERO
+                ..common::zeroable::Zeroable::ZERO
             };
         }
     };
@@ -367,7 +368,7 @@ macro_rules! vmstate_unused {
             size: $size,
             info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
             flags: $crate::bindings::VMStateFlags::VMS_BUFFER,
-            ..$crate::zeroable::Zeroable::ZERO
+            ..::common::Zeroable::ZERO
         }
     }};
 }
@@ -390,7 +391,7 @@ pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), b
 #[macro_export]
 macro_rules! vmstate_exist_fn {
     ($struct_name:ty, $test_fn:expr) => {{
-        const fn test_cb_builder__<T, F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>>(
+        const fn test_cb_builder__<T, F: for<'a> ::common::callbacks::FnCall<(&'a T, u8), bool>>(
             _phantom: ::core::marker::PhantomData<F>,
         ) -> $crate::vmstate::VMSFieldExistCb {
             const { assert!(F::IS_SOME) };
@@ -414,7 +415,7 @@ macro_rules! vmstate_fields {
             $($field),*,
             $crate::bindings::VMStateField {
                 flags: $crate::bindings::VMStateFlags::VMS_END,
-                ..$crate::zeroable::Zeroable::ZERO
+                ..::common::zeroable::Zeroable::ZERO
             }
         ];
         _FIELDS.as_ptr()
@@ -433,7 +434,7 @@ macro_rules! vmstate_validate {
                     | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
             ),
             num: 0, // 0 elements: no data, only run test_fn callback
-            ..$crate::zeroable::Zeroable::ZERO
+            ..::common::zeroable::Zeroable::ZERO
         }
     };
 }
@@ -455,7 +456,7 @@ unsafe impl $crate::vmstate::VMState for $type {
                     vmsd: ::core::ptr::addr_of!(*VMSD),
                     size: ::core::mem::size_of::<$type>(),
                     flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-                    ..$crate::zeroable::Zeroable::ZERO
+                    ..common::Zeroable::ZERO
                 }
             };
         }
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
deleted file mode 100644
index d8239d08563..00000000000
--- a/rust/qemu-api/src/zeroable.rs
+++ /dev/null
@@ -1,37 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-//! Defines a trait for structs that can be safely initialized with zero bytes.
-
-/// Encapsulates the requirement that
-/// `MaybeUninit::<Self>::zeroed().assume_init()` does not cause undefined
-/// behavior.
-///
-/// # Safety
-///
-/// Do not add this trait to a type unless all-zeroes is a valid value for the
-/// type.  In particular, raw pointers can be zero, but references and
-/// `NonNull<T>` cannot.
-pub unsafe trait Zeroable: Default {
-    /// Return a value of Self whose memory representation consists of all
-    /// zeroes, with the possible exclusion of padding bytes.
-    const ZERO: Self = unsafe { ::core::mem::MaybeUninit::<Self>::zeroed().assume_init() };
-}
-
-// bindgen does not derive Default here
-#[allow(clippy::derivable_impls)]
-impl Default for crate::bindings::VMStateFlags {
-    fn default() -> Self {
-        Self(0)
-    }
-}
-
-unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::Property {}
-unsafe impl Zeroable for crate::bindings::VMStateFlags {}
-unsafe impl Zeroable for crate::bindings::VMStateField {}
-unsafe impl Zeroable for crate::bindings::VMStateDescription {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
-unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
-unsafe impl Zeroable for crate::bindings::CharBackend {}
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 2c0670ba0ee..d9e5bcc4987 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -9,12 +9,13 @@
     slice,
 };
 
+use common::Opaque;
 use qemu_api::{
     bindings::{
         vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
-    cell::{BqlCell, Opaque},
+    cell::BqlCell,
     impl_vmstate_forward, impl_vmstate_struct,
     vmstate::{VMStateDescription, VMStateDescriptionBuilder, VMStateField},
     vmstate_fields, vmstate_of, vmstate_unused, vmstate_validate,
-- 
2.51.0


