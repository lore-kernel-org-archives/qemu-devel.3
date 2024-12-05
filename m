Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C355E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4kF-0006Iq-55; Thu, 05 Dec 2024 00:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kD-0006IR-Fl; Thu, 05 Dec 2024 00:49:45 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kB-0007B2-Jf; Thu, 05 Dec 2024 00:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377784; x=1764913784;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ku9jHA4GvDjfowVdl0cDhGNs9WRaPIDchgZut6j+nUI=;
 b=fK99LW7KsQTEmYtQ1Q6QdUrdKukOH6CPZekfKKdnjzSVXMAXf3Ot9BkN
 Naj98JfyeYo72YSI75c9MA7CFrI5fzXK70ICsDgcrsaUqDVwUDesodC0A
 hRcJ9dXOpCVxpBrhZfHbJ5RvWO0zZunbuGUuPGTtqbhjjoa3dKP1sVGji
 KZ58CYni4eT7OoBnUNxgYwQ7RcEHF94O9sa4knOeVFNd16uRbGYEmrUcV
 DsQEjBWY4c0CZzE6xtvf7ohLsbLO9JeCkEwXrucAtX1XfQlmU3HeA//gI
 cpReoWlliKhLgxReP9CtjKjF5ryDjBjekRigquQCOb7Mqz4UF7teL94/a Q==;
X-CSE-ConnectionGUID: 1YFj52kGRZyn3f8zLe+VRw==
X-CSE-MsgGUID: KXgHlihgR4CM+KxFavc89Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815674"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815674"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:43 -0800
X-CSE-ConnectionGUID: KsnE5wCOR3y45eadn9Z8Jg==
X-CSE-MsgGUID: lb7XB3GZTzqmwA13mkfQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455050"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:40 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 10/13] rust/timer/hpet: define hpet_fw_cfg
Date: Thu,  5 Dec 2024 14:07:11 +0800
Message-Id: <20241205060714.256270-11-zhao1.liu@intel.com>
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

Define HPETFwEntry structure with the same memory layout as
hpet_fw_entry in C.

Further, define the global hpet_fw_cfg variable in Rust which is the
same as the C version. This hpet_fw_cfg variable in Rust will replace
the C version one and allows both Rust code and C code to access it.

The Rust version of hpet_fw_cfg is self-contained, avoiding unsafe
access to C code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/Cargo.lock                  |  8 +++
 rust/Cargo.toml                  |  1 +
 rust/hw/meson.build              |  1 +
 rust/hw/timer/hpet/Cargo.toml    | 14 +++++
 rust/hw/timer/hpet/meson.build   | 18 +++++++
 rust/hw/timer/hpet/src/fw_cfg.rs | 88 ++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs    | 15 ++++++
 rust/hw/timer/meson.build        |  1 +
 8 files changed, 146 insertions(+)
 create mode 100644 rust/hw/timer/hpet/Cargo.toml
 create mode 100644 rust/hw/timer/hpet/meson.build
 create mode 100644 rust/hw/timer/hpet/src/fw_cfg.rs
 create mode 100644 rust/hw/timer/hpet/src/lib.rs
 create mode 100644 rust/hw/timer/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 6b19553b6d10..996454af03cf 100644
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
index de0835bf5b5c..fc620bcaac00 100644
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
index 000000000000..db2ef4642b4f
--- /dev/null
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -0,0 +1,14 @@
+[package]
+name = "hpet"
+version = "0.1.0"
+edition = "2021"
+authors = ["Zhao Liu <zhao1.liu@intel.com>"]
+license = "GPL-2.0-or-later"
+description = "IA-PC High Precision Event Timer emulation in Rust"
+
+[lib]
+crate-type = ["staticlib"]
+
+[dependencies]
+qemu_api = { path = "../../../qemu-api" }
+qemu_api_macros = { path = "../../../qemu-api-macros" }
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
index 000000000000..a057c2778be4
--- /dev/null
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -0,0 +1,88 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![allow(dead_code)]
+
+use qemu_api::{cell::BqlCell, zeroable::Zeroable};
+
+// Each HPETState represents a Event Timer Block. The v1 spec supports
+// up to 8 blocks. QEMU only uses 1 block (in PC machine).
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
+unsafe impl Zeroable for HPETFwConfig {
+    const ZERO: Self = Self {
+        count: 0,
+        hpet: [Zeroable::ZERO; HPET_MAX_NUM_EVENT_TIMER_BLOCK],
+    };
+}
+
+// Expose to C code to configure firmware.
+// BqlCell<HPETFwConfig> is picked since it has the same memory layout
+// as HPETFwConfig (just like Cell<T>/UnsafeCell<T>/T).
+pub struct HPETFwConfigCell(BqlCell<HPETFwConfig>);
+
+#[allow(non_upper_case_globals)]
+#[no_mangle]
+pub static mut hpet_fw_cfg: HPETFwConfigCell = HPETFwConfigCell(BqlCell::new(HPETFwConfig {
+    count: u8::MAX,
+    ..Zeroable::ZERO
+}));
+
+impl HPETFwConfigCell {
+    pub(crate) fn assign_hpet_id(&mut self) -> usize {
+        if self.0.get().count == u8::MAX {
+            // first instance
+            self.0.get_mut().count = 0;
+        }
+
+        if self.0.get().count == 8 {
+            // TODO: Add error binding: error_setg()
+            panic!("Only 8 instances of HPET is allowed");
+        }
+
+        let id: usize = self.0.get().count.into();
+        self.0.get_mut().count += 1;
+        id
+    }
+
+    pub(crate) fn update_hpet_cfg(
+        &mut self,
+        hpet_id: usize,
+        event_timer_block_id: Option<u32>,
+        address: Option<u64>,
+    ) {
+        if let Some(e) = event_timer_block_id {
+            self.0.get_mut().hpet[hpet_id].event_timer_block_id = e;
+        }
+
+        if let Some(a) = address {
+            self.0.get_mut().hpet[hpet_id].address = a;
+        }
+    }
+}
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
new file mode 100644
index 000000000000..04cb41372b94
--- /dev/null
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -0,0 +1,15 @@
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
+extern crate qemu_api;
+
+pub mod fw_cfg;
diff --git a/rust/hw/timer/meson.build b/rust/hw/timer/meson.build
new file mode 100644
index 000000000000..22a84f15536b
--- /dev/null
+++ b/rust/hw/timer/meson.build
@@ -0,0 +1 @@
+subdir('hpet')
-- 
2.34.1


