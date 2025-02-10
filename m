Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE86C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJk5-0000Db-IY; Sun, 09 Feb 2025 21:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJk3-0000Cd-Jg; Sun, 09 Feb 2025 21:41:47 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJk1-00089t-9q; Sun, 09 Feb 2025 21:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155305; x=1770691305;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z/illQfqoMk9DX2otLcysXvRJIDfE+l9fJRuQbiN7QY=;
 b=QA8Qd9TjqX8Cwow1wbEz0wy/S4em6c/yQIGgqNDUYpC+51JR/sV/Kv0Y
 5/NjXH5zNPd5qlDyffG+YjWhM++jnFmYsA3OmTh7giJc76aBIctQ32jlw
 ov43Pvmtv4NWmypNJYEbbSik80UrSNXy1CnK5pKoX7+jU9IE+IZe/8s5H
 Z7A2tHcd6UxxuSva5Gj/WeqWvtpZa23MXxBwEtR8H8jTbOK2nT6z7f40n
 5IlixFVXRIIXp/GuzJX9il0EyYEO374tDAgcNkhGW19bDIaFeKBwIxPkk
 WcNwDw1gZfdt4D8oE0wlDRuokdt/DO1CDQiV1vTSyCC6AP0SMeGqG1cyv Q==;
X-CSE-ConnectionGUID: /BGOOE00S56qcTmBgQGkMA==
X-CSE-MsgGUID: FisQ0Co0SYyFrSaSyAEcQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351274"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351274"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:43 -0800
X-CSE-ConnectionGUID: CgUERwOWSiKr70TTbpGZRA==
X-CSE-MsgGUID: a5wCEdvtSPu0OjrLkPyLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938231"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:41 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/10] rust/timer/hpet: define hpet_fw_cfg
Date: Mon, 10 Feb 2025 11:00:48 +0800
Message-Id: <20250210030051.2562726-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Define HPETFwEntry structure with the same memory layout as
hpet_fw_entry in C.

Further, define the global hpet_cfg variable in Rust which is the
same as the C version. This hpet_cfg variable in Rust will replace
the C version one and allows both Rust code and C code to access it.

The Rust version of hpet_cfg is self-contained, avoiding unsafe
access to C code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * hpet_fw_cfg doesn't need a BqlRefCell.

Changes since Patch v1:
 * Add rust_version in Cargo.toml.
 * Fix clippy's complaints about mut references to static mut.
 * Enable workspace's lint configurations for hpet.
 * Make update_hpet_cfg()'s parameters not in Option<>.
---
 rust/Cargo.lock                  |  8 ++++
 rust/Cargo.toml                  |  1 +
 rust/hw/meson.build              |  1 +
 rust/hw/timer/hpet/Cargo.toml    | 18 +++++++
 rust/hw/timer/hpet/meson.build   | 18 +++++++
 rust/hw/timer/hpet/src/fw_cfg.rs | 80 ++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs    | 13 ++++++
 rust/hw/timer/meson.build        |  1 +
 rust/qemu-api/src/zeroable.rs    |  6 ++-
 9 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 rust/hw/timer/hpet/Cargo.toml
 create mode 100644 rust/hw/timer/hpet/meson.build
 create mode 100644 rust/hw/timer/hpet/src/fw_cfg.rs
 create mode 100644 rust/hw/timer/hpet/src/lib.rs
 create mode 100644 rust/hw/timer/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c0c6069247a8..79e142723b83 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -37,6 +37,14 @@ version = "1.12.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
 
+[[package]]
+name = "hpet"
+version = "0.1.0"
+dependencies = [
+ "qemu_api",
+ "qemu_api_macros",
+]
+
 [[package]]
 name = "itertools"
 version = "0.11.0"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5b6b6ca43825..9265d30f46a2 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -4,6 +4,7 @@ members = [
     "qemu-api-macros",
     "qemu-api",
     "hw/char/pl011",
+    "hw/timer/hpet",
 ]
 
 [workspace.lints.rust]
diff --git a/rust/hw/meson.build b/rust/hw/meson.build
index 860196645e71..9749d4adfc96 100644
--- a/rust/hw/meson.build
+++ b/rust/hw/meson.build
@@ -1 +1,2 @@
 subdir('char')
+subdir('timer')
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
new file mode 100644
index 000000000000..147f216e7257
--- /dev/null
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -0,0 +1,18 @@
+[package]
+name = "hpet"
+version = "0.1.0"
+edition = "2021"
+authors = ["Zhao Liu <zhao1.liu@intel.com>"]
+license = "GPL-2.0-or-later"
+description = "IA-PC High Precision Event Timer emulation in Rust"
+rust-version = "1.63.0"
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
+qemu_api = { path = "../../../qemu-api" }
+qemu_api_macros = { path = "../../../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
new file mode 100644
index 000000000000..c2d7c0532ca4
--- /dev/null
+++ b/rust/hw/timer/hpet/meson.build
@@ -0,0 +1,18 @@
+_libhpet_rs = static_library(
+  'hpet',
+  files('src/lib.rs'),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [
+    qemu_api,
+    qemu_api_macros,
+  ],
+)
+
+rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
+  link_whole: [_libhpet_rs],
+  # Putting proc macro crates in `dependencies` is necessary for Meson to find
+  # them when compiling the root per-target static rust lib.
+  dependencies: [qemu_api_macros],
+  variables: {'crate': 'hpet'},
+)])
diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
new file mode 100644
index 000000000000..d4c24813063d
--- /dev/null
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -0,0 +1,80 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![allow(dead_code)]
+
+use std::ptr::addr_of_mut;
+
+use qemu_api::{cell::bql_locked, impl_zeroable, zeroable::Zeroable};
+
+/// Each HPETState represents a Event Timer Block. The v1 spec supports
+/// up to 8 blocks. QEMU only uses 1 block (in PC machine).
+const HPET_MAX_NUM_EVENT_TIMER_BLOCK: usize = 8;
+
+#[repr(C, packed)]
+#[derive(Copy, Clone, Default)]
+pub struct HPETFwEntry {
+    pub event_timer_block_id: u32,
+    pub address: u64,
+    pub min_tick: u16,
+    pub page_prot: u8,
+}
+
+unsafe impl Zeroable for HPETFwEntry {
+    const ZERO: Self = Self {
+        event_timer_block_id: 0,
+        address: 0,
+        min_tick: 0,
+        page_prot: 0,
+    };
+}
+
+#[repr(C, packed)]
+#[derive(Copy, Clone, Default)]
+pub struct HPETFwConfig {
+    pub count: u8,
+    pub hpet: [HPETFwEntry; HPET_MAX_NUM_EVENT_TIMER_BLOCK],
+}
+
+impl_zeroable!(HPETFwConfig);
+
+#[allow(non_upper_case_globals)]
+#[no_mangle]
+pub static mut hpet_fw_cfg: HPETFwConfig = HPETFwConfig {
+    count: u8::MAX,
+    ..Zeroable::ZERO
+};
+
+impl HPETFwConfig {
+    pub(crate) fn assign_hpet_id() -> usize {
+        assert!(bql_locked());
+        // SAFETY: all accesses go through these methods, which guarantee
+        // that the accesses are protected by the BQL.
+        let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
+
+        if fw_cfg.count == u8::MAX {
+            // first instance
+            fw_cfg.count = 0;
+        }
+
+        if fw_cfg.count == 8 {
+            // TODO: Add error binding: error_setg()
+            panic!("Only 8 instances of HPET is allowed");
+        }
+
+        let id: usize = fw_cfg.count.into();
+        fw_cfg.count += 1;
+        id
+    }
+
+    pub(crate) fn update_hpet_cfg(hpet_id: usize, timer_block_id: u32, address: u64) {
+        assert!(bql_locked());
+        // SAFETY: all accesses go through these methods, which guarantee
+        // that the accesses are protected by the BQL.
+        let mut fw_cfg = unsafe { *addr_of_mut!(hpet_fw_cfg) };
+
+        fw_cfg.hpet[hpet_id].event_timer_block_id = timer_block_id;
+        fw_cfg.hpet[hpet_id].address = address;
+    }
+}
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
new file mode 100644
index 000000000000..c2b9c64d0bfe
--- /dev/null
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -0,0 +1,13 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// HPET QEMU Device Model
+//
+// This library implements a device model for the IA-PC HPET (High
+// Precision Event Timers) device in QEMU.
+//
+
+#![deny(unsafe_op_in_unsafe_fn)]
+
+pub mod fw_cfg;
diff --git a/rust/hw/timer/meson.build b/rust/hw/timer/meson.build
new file mode 100644
index 000000000000..22a84f15536b
--- /dev/null
+++ b/rust/hw/timer/meson.build
@@ -0,0 +1 @@
+subdir('hpet')
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 53dc90da31a1..a2356cb2f24c 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -58,6 +58,7 @@ pub unsafe trait Zeroable: Default {
 /// ## Differences with `core::mem::zeroed`
 ///
 /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
+#[macro_export]
 macro_rules! const_zero {
     // This macro to produce a type-generic zero constant is taken from the
     // const_zero crate (v0.1.1):
@@ -79,10 +80,11 @@ union TypeAsBytes {
 }
 
 /// A wrapper to implement the `Zeroable` trait through the `const_zero` macro.
+#[macro_export]
 macro_rules! impl_zeroable {
     ($type:ty) => {
-        unsafe impl Zeroable for $type {
-            const ZERO: Self = unsafe { const_zero!($type) };
+        unsafe impl $crate::zeroable::Zeroable for $type {
+            const ZERO: Self = unsafe { $crate::const_zero!($type) };
         }
     };
 }
-- 
2.34.1


