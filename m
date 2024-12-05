Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0EDE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4k4-0006FM-P8; Thu, 05 Dec 2024 00:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k3-0006Ev-Nx; Thu, 05 Dec 2024 00:49:35 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4k1-00079o-HE; Thu, 05 Dec 2024 00:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377774; x=1764913774;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+UM44gN8vs+EoSbyXpVOo3DcigJbEd34STQ9qH+3m8A=;
 b=TvHd3OTY/ZvSO9ZohiAnhY9lelyaPKe7E404BYj7cIQTv21Jjg4ooQzG
 AK3zN4f4XTzbtnkpK5NMppuAW/kSglx6iOoXNSfe/Gv7D92OrnXiSpwRc
 xSqHfNPTTJES+V5VJRxktA7MGZI6j7J5hhzVHtkP5TztINSH+oU4SFB4J
 6Qp4JMTam7TO40K+Z+OG8H40lbVmHGSR3kdiMMd5rK8msYGf7KwwM2UdN
 lxJyM1cci5yuOiaN7XYagfzFCbJ7wkXcVEH5vg+bIPudmLzJz8SIg9t7q
 6SKa3kZFYPQ2AAdLhWOOWqdY5ia3PBUSwejDcN6B8cgjrnrg7dDx/kA2j A==;
X-CSE-ConnectionGUID: GLHQQMJMSlOiqPAfFojnKg==
X-CSE-MsgGUID: jIVc0b7MRluCfR2+T62X6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815646"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815646"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:32 -0800
X-CSE-ConnectionGUID: RvzMCpbrQcCozAZUsKbHdw==
X-CSE-MsgGUID: yl2iBmPNTs2lapUgSlNJ3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455001"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:29 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 06/13] rust: add bindings for memattrs
Date: Thu,  5 Dec 2024 14:07:07 +0800
Message-Id: <20241205060714.256270-7-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The MemTxAttrs structure is composed of bitfield members, and bindgen is
unable to generate an equivalent macro definition for
MEMTXATTRS_UNSPECIFIED.

Therefore, we have to manually define a global constant variable
MEMTXATTRS_UNSPECIFIED to support calls from Rust code.

However, the binding methods of MemTxAttrs are non-const, so we cannot
directly use them when defining MEMTXATTRS_UNSPECIFIED. As a result,
add the third-party crate once_cell to use its Lazy to help define
MEMTXATTRS_UNSPECIFIED.

Note, lazy_static has been deprecated and LazyCell (in std) became
stable since v1.80. When the minimum supported rustc version is bumped
to v1.80 in the future, LazyCell can be used to replace the current
once_cell.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/Cargo.lock                               |  7 ++++++
 rust/qemu-api/Cargo.toml                      |  1 +
 rust/qemu-api/meson.build                     |  9 ++++++--
 rust/qemu-api/src/lib.rs                      |  1 +
 rust/qemu-api/src/memattrs.rs                 | 21 +++++++++++++++++
 rust/wrapper.h                                |  1 +
 scripts/archive-source.sh                     |  2 +-
 scripts/make-release                          |  2 +-
 subprojects/.gitignore                        |  1 +
 subprojects/once_cell-1.20-rs.wrap            |  7 ++++++
 .../once_cell-1.20-rs/meson.build             | 23 +++++++++++++++++++
 11 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 rust/qemu-api/src/memattrs.rs
 create mode 100644 subprojects/once_cell-1.20-rs.wrap
 create mode 100644 subprojects/packagefiles/once_cell-1.20-rs/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c0c6069247a8..6b19553b6d10 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -46,6 +46,12 @@ dependencies = [
  "either",
 ]
 
+[[package]]
+name = "once_cell"
+version = "1.20.2"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "1261fe7e33c73b354eab43b1273a57c8f967d0391e80353e51f764ac02cf6775"
+
 [[package]]
 name = "pl011"
 version = "0.1.0"
@@ -92,6 +98,7 @@ dependencies = [
 name = "qemu_api"
 version = "0.1.0"
 dependencies = [
+ "once_cell",
  "qemu_api_macros",
  "version_check",
 ]
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 4aa22f319860..265e00f97176 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -14,6 +14,7 @@ keywords = []
 categories = []
 
 [dependencies]
+once_cell = { version = "1.20.2" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 
 [build-dependencies]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 00e86a679d8a..508986948883 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -10,6 +10,9 @@ if get_option('debug_mutex')
   _qemu_api_cfg += ['--feature', 'debug_cell']
 endif
 
+subproject('once_cell-1.20-rs', required: true)
+once_cell_dep = dependency('once_cell-1.20-rs')
+
 _qemu_api_rs = static_library(
   'qemu_api',
   structured_sources(
@@ -20,6 +23,7 @@ _qemu_api_rs = static_library(
       'src/cell.rs',
       'src/c_str.rs',
       'src/irq.rs',
+      'src/memattrs.rs',
       'src/module.rs',
       'src/offset_of.rs',
       'src/qdev.rs',
@@ -33,6 +37,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
+  dependencies: once_cell_dep,
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
@@ -40,7 +45,7 @@ rust.test('rust-qemu-api-tests', _qemu_api_rs,
 
 qemu_api = declare_dependency(
   link_with: _qemu_api_rs,
-  dependencies: qemu_api_macros,
+  dependencies: [qemu_api_macros, once_cell_dep],
 )
 
 # Rust executables do not support objects, so add an intermediate step.
@@ -56,7 +61,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [qemu_api, qemu_api_macros],
+        dependencies: [qemu_api, qemu_api_macros, once_cell_dep],
         link_whole: [rust_qemu_api_objs, libqemuutil]),
     args: [
         '--test',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 009906c907e7..e60c9ac16409 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -11,6 +11,7 @@
 pub mod c_str;
 pub mod cell;
 pub mod irq;
+pub mod memattrs;
 pub mod module;
 pub mod offset_of;
 pub mod qdev;
diff --git a/rust/qemu-api/src/memattrs.rs b/rust/qemu-api/src/memattrs.rs
new file mode 100644
index 000000000000..7cc8aea4b7b7
--- /dev/null
+++ b/rust/qemu-api/src/memattrs.rs
@@ -0,0 +1,21 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use once_cell::sync::Lazy;
+
+use crate::bindings::MemTxAttrs;
+
+impl MemTxAttrs {
+    fn memtxattrs_unspecified() -> Self {
+        let mut attrs = MemTxAttrs::default();
+        attrs.set_unspecified(1);
+        attrs
+    }
+}
+
+/// Bus masters which don't specify any attributes will get this,
+/// which has all attribute bits clear except the topmost one
+/// (so that we can distinguish "all attributes deliberately clear"
+/// from "didn't specify" if necessary).
+pub static MEMTXATTRS_UNSPECIFIED: Lazy<MemTxAttrs> = Lazy::new(MemTxAttrs::memtxattrs_unspecified);
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 285d0eb6ad01..033f3e9cf32c 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -62,3 +62,4 @@ typedef enum memory_order {
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
+#include "exec/memattrs.h"
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 30677c3ec903..59e72d92498a 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -30,7 +30,7 @@ subprojects="keycodemapdb libvfio-user berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  syn-2-rs unicode-ident-1-rs once_cell-1.20-rs"
 sub_deinit=""
 
 function cleanup() {
diff --git a/scripts/make-release b/scripts/make-release
index 8dc939124c4f..b6b48bdf6f08 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -21,7 +21,7 @@ SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 arbitrary-int-1-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs itertools-0.11-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
-  syn-2-rs unicode-ident-1-rs"
+  syn-2-rs unicode-ident-1-rs once_cell-1.20-rs"
 
 src="$1"
 version="$2"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 50f173f90dbe..dba8ea74b823 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /bilge-impl-0.2.0
 /either-1.12.0
 /itertools-0.11.0
+/once_cell-1.20.2
 /proc-macro-error-1.0.4
 /proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.84
diff --git a/subprojects/once_cell-1.20-rs.wrap b/subprojects/once_cell-1.20-rs.wrap
new file mode 100644
index 000000000000..b13ba81a22b1
--- /dev/null
+++ b/subprojects/once_cell-1.20-rs.wrap
@@ -0,0 +1,7 @@
+[wrap-file]
+directory = once_cell-1.20.2
+source_url = https://crates.io/api/v1/crates/once_cell/1.20.2/download
+source_filename = once_cell-1.20.2.tar.gz
+source_hash = 1261fe7e33c73b354eab43b1273a57c8f967d0391e80353e51f764ac02cf6775
+#method = cargo
+patch_directory = once_cell-1.20-rs
diff --git a/subprojects/packagefiles/once_cell-1.20-rs/meson.build b/subprojects/packagefiles/once_cell-1.20-rs/meson.build
new file mode 100644
index 000000000000..0b81f8e76250
--- /dev/null
+++ b/subprojects/packagefiles/once_cell-1.20-rs/meson.build
@@ -0,0 +1,23 @@
+project('once_cell-1.20-rs', 'rust',
+  version: '1.20.2',
+  license: 'MIT OR Apache-2.0',
+  default_options: [])
+
+_once_cell_rs = static_library(
+  'once_cell',
+  files('src/lib.rs'),
+  gnu_symbol_visibility: 'hidden',
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: [
+    '--cfg', 'feature="std"'
+  ],
+  dependencies: [],
+  native: true,
+)
+
+once_cell_dep = declare_dependency(
+  link_with: _once_cell_rs,
+)
+
+meson.override_dependency('once_cell-1.20-rs', once_cell_dep, native: true)
-- 
2.34.1


