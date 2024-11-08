Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5ECD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJ5-0001uf-VP; Fri, 08 Nov 2024 13:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIw-0001oF-E6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TIu-0001v3-Ih
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yfF+e4p7LcLCc9fG9LqtNbaVzXuoaKz8W1PB4KLYI+g=;
 b=BqIcAv5L+FxKPEAvYEiILWEh9P5fCpcLjNW/PHQ9AUk/9FNeuNKSwMxSE1PVhb/ycD5maI
 hksPOnVKyXz8x/ZhPDKb1Lu/LKrWGSl7GT+Nw3FHAlvqpA/qnJ7Xtp5HpZoafumq3VkLeL
 wLPfeMV7SISuKJhE0iScyozpoqK5VIk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-QKgX2lYNMjCjPJtPeFRVbw-1; Fri, 08 Nov 2024 13:01:47 -0500
X-MC-Unique: QKgX2lYNMjCjPJtPeFRVbw-1
X-Mimecast-MFC-AGG-ID: QKgX2lYNMjCjPJtPeFRVbw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso16470465e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:01:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088906; x=1731693706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfF+e4p7LcLCc9fG9LqtNbaVzXuoaKz8W1PB4KLYI+g=;
 b=sTBriisjjkwlbwD1E2lzDseDOjGLgJFtFacFUNGtPOmHWP2UoqdMh7G/NVVo9n1kNi
 qfV/7TYM+TCmow1nlVJfpUfTh7ZsgUVCJ7PEwub5/HXU82vmt/e3ZgJrff3yEkv0CWg0
 sSPGLw3ahvXb/YI5vggmHyf0Qw0SMzSBXXK+XANUgCbbqANnjUrwe4mhn/UcHRjlBvF2
 UNFJdrgphxcX5B6UfK04kcRqXZrvLxd4H/mET+16seqsp0tSEdo1XqieG0oqTYGDhPjo
 hkKLnXKBedUxZX5Da337JfWRCB5lD/Lb2QsORhaof4+bcLSWhQ3Y2vvc/+SwHce5KaRu
 NCWg==
X-Gm-Message-State: AOJu0YzZDXLPfeSVE+OImpx5ReDDoUDZc9+//VTwyQsBv6zBi/3lGHcq
 zhBEWwgg1T+VAWKO0v6tB8Q3YHkL+qWcAAvGPiRaLIdoX5JzSrYb2Wng/+GT6e0BGaG+8VCetNP
 Y4SzEbHOWfpqTsgIr7g8zmW1dAzhi34wVllyzW0e/unI04Lu1eTlRszyjO17qFDmD5gR8DnrRis
 nRlSodPAdVDiwdF+cz47IcWbW8CnbkMtd34uAIAGo=
X-Received: by 2002:a05:600c:3514:b0:42e:8d0d:bca5 with SMTP id
 5b1f17b1804b1-432b74fdb3cmr30403925e9.2.1731088905633; 
 Fri, 08 Nov 2024 10:01:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhyluaPVV70eSO6iZo+1ACQh5JSnFU/paTGFP0efep//4xuscJhgzNAkyMzq0Bbn5Afs4T3A==
X-Received: by 2002:a05:600c:3514:b0:42e:8d0d:bca5 with SMTP id
 5b1f17b1804b1-432b74fdb3cmr30403495e9.2.1731088905123; 
 Fri, 08 Nov 2024 10:01:45 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970d1bsm5555560f8f.16.2024.11.08.10.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 01/11] rust: qemu_api: do not disable lints outside
 bindgen-generated code
Date: Fri,  8 Nov 2024 19:01:29 +0100
Message-ID: <20241108180139.117112-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

rust/qemu-api/src/lib.rs is disabling lints that cause problems
with code generated by bindgen.  Instead, include the bindgen
code via include!(...) and move the #![allow()] directives
into the bindings module.

Add MESON_BUILD_ROOT to the devenv, so that it's easy for
build.rs to find the include file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                   |  4 +++-
 rust/qemu-api/.gitignore      |  2 +-
 rust/qemu-api/build.rs        | 20 ++++++++++++++------
 rust/qemu-api/meson.build     |  1 +
 rust/qemu-api/src/bindings.rs | 29 +++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs      | 22 ----------------------
 6 files changed, 48 insertions(+), 30 deletions(-)
 create mode 100644 rust/qemu-api/src/bindings.rs

diff --git a/meson.build b/meson.build
index e0b880e4e13..a7342c6edbd 100644
--- a/meson.build
+++ b/meson.build
@@ -3,6 +3,8 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
                           'b_staticpic=false', 'stdsplit=false', 'optimization=2', 'b_pie=true'],
         version: files('VERSION'))
 
+meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
+
 add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
 add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
 add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
@@ -4089,7 +4091,7 @@ if have_rust
   bindings_rs = rust.bindgen(
     input: 'rust/wrapper.h',
     dependencies: common_ss.all_dependencies(),
-    output: 'bindings.rs',
+    output: 'bindings.rs.inc',
     include_directories: include_directories('.', 'include'),
     bindgen_version: ['>=0.60.0'],
     args: bindgen_args,
diff --git a/rust/qemu-api/.gitignore b/rust/qemu-api/.gitignore
index b9e7e004c86..2accb8745dc 100644
--- a/rust/qemu-api/.gitignore
+++ b/rust/qemu-api/.gitignore
@@ -1,2 +1,2 @@
 # Ignore generated bindings file overrides.
-src/bindings.rs
+/src/bindings.rs.inc
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 20f8f718b90..e4eab718553 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -2,18 +2,26 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::path::Path;
+use std::{env, path::Path};
 
 use version_check as rustc;
 
 fn main() {
-    if !Path::new("src/bindings.rs").exists() {
-        panic!(
-            "No generated C bindings found! Either build them manually with bindgen or with meson \
-             (`ninja bindings.rs`) and copy them to src/bindings.rs, or build through meson."
-        );
+    // Placing bindings.rs.inc in the source directory is supported
+    // but not documented or encouraged.
+    let path = env::var("MESON_BUILD_ROOT")
+        .unwrap_or_else(|_| format!("{}/src", env!("CARGO_MANIFEST_DIR")));
+
+    let file = format!("{}/bindings.rs.inc", path);
+    if !Path::new(&file).exists() {
+        panic!(concat!(
+            "No generated C bindings found! If you want to run `cargo`, start a subshell\n",
+            "with `meson devenv`, or point MESON_BUILD_ROOT to the top of the build tree."
+        ));
     }
 
+    println!("cargo:rustc-env=BINDINGS_RS_INC={}", file);
+
     // Check for available rustc features
     if rustc::is_min_version("1.77.0").unwrap_or(false) {
         println!("cargo:rustc-cfg=has_offset_of");
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 6f637af7b1b..e3870e901e3 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -9,6 +9,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/bindings.rs',
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
new file mode 100644
index 00000000000..1dac310594d
--- /dev/null
+++ b/rust/qemu-api/src/bindings.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unsafe_op_in_unsafe_fn,
+    clippy::missing_const_for_fn,
+    clippy::too_many_arguments,
+    clippy::approx_constant,
+    clippy::use_self,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc
+)]
+
+#[cfg(MESON)]
+include!("bindings.rs.inc");
+
+#[cfg(not(MESON))]
+include!(env!("BINDINGS_RS_INC"));
+
+unsafe impl Send for Property {}
+unsafe impl Sync for Property {}
+unsafe impl Sync for TypeInfo {}
+unsafe impl Sync for VMStateDescription {}
+unsafe impl Sync for VMStateField {}
+unsafe impl Sync for VMStateInfo {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index aa8d16ec94b..440aff3817d 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -4,31 +4,9 @@
 
 #![cfg_attr(not(MESON), doc = include_str!("../README.md"))]
 
-#[allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unsafe_op_in_unsafe_fn,
-    clippy::missing_const_for_fn,
-    clippy::too_many_arguments,
-    clippy::approx_constant,
-    clippy::use_self,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc,
-)]
 #[rustfmt::skip]
 pub mod bindings;
 
-unsafe impl Send for bindings::Property {}
-unsafe impl Sync for bindings::Property {}
-unsafe impl Sync for bindings::TypeInfo {}
-unsafe impl Sync for bindings::VMStateDescription {}
-unsafe impl Sync for bindings::VMStateField {}
-unsafe impl Sync for bindings::VMStateInfo {}
-
 pub mod c_str;
 pub mod definitions;
 pub mod device_class;
-- 
2.47.0


