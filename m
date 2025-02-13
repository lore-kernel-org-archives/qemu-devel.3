Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D977C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibfJ-00015M-Gy; Thu, 13 Feb 2025 11:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibf7-000117-QR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibf5-0005c8-EX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:02:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9eIPT4SqTnanKoz0+BJuTe5SIxIAvdPZ6BH+2W1Vt4=;
 b=Lj4rXuBs+/0xA2bV6J6bmZNnoQxzDRlMj5Cnhnn0ozxvXDwpK+kQtG+NFwhtL4sL5qu4ED
 R91AXRpfgfyJ8a+gHyf1ye+TLRAal9jy23qUdBfLtffIV/S2DZBulywpDstrfGOu8pf02h
 ZrENYfIF9ieRk35EyIUDP+3Ff4Wgwfo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-PqNQ5l7JPl-Usg-sK9FBAA-1; Thu, 13 Feb 2025 11:01:56 -0500
X-MC-Unique: PqNQ5l7JPl-Usg-sK9FBAA-1
X-Mimecast-MFC-AGG-ID: PqNQ5l7JPl-Usg-sK9FBAA_1739462515
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43935bcec79so8421605e9.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462514; x=1740067314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9eIPT4SqTnanKoz0+BJuTe5SIxIAvdPZ6BH+2W1Vt4=;
 b=V9DfWwP7mZ7WLeyX2itUT4KPEKH8LGNgtq7jEmqnnEYMcI9p4mHzlaymXNQWds3RLO
 OI8UGni9E3jnx8PoezO+0b4BWpTvpK3AEaYN+OC6ZWZlMDHOu41rIU1Grce0vrKE4C3q
 EEOgHsgSKowE0dHzbX/trlke+hsAquR4Emo2fL6WTiUO2YuEepMXjHRYylToKj1LhYJ/
 1Vpbk1vKnLHCFg48fyrsVQat2UYTin/4DgfyVGODUjA/JJKO60OuA5pSlsPxRzQ6QTWB
 KufhZrS8+STJvMVO59wdrA6O3pk4lhwda6b7P4stiFZfLW6tzmZ4Gtg1vwBxK9rb35mT
 bb0g==
X-Gm-Message-State: AOJu0Yz3qkXGqAFX4GbqfvInm+5VM7a0JpcyzSKgeSYbe60WjC85ap+n
 ZIRE00XZXOni2MB5OO1Dl7Yi90pv4Xqz8GTGZFjhpxgychk/sbqRRhVmmad6RsnLg9KsoACZLxy
 SXql8rFHgeQ18wGXRc8v8XaA8tM4S3OITNPwUbMTfYtegwl2smFu5gxyqQLly9kwJgYEWiW20Vg
 AmSQNC8NEvTh1si6NxfVe63DIsyse9iPt/DLMddZE=
X-Gm-Gg: ASbGncu4ZKWZiP+AESY1HzpURqov+RDKY2jc/AkyRFX5LYwaZE9wIDqoeYJZE9CPOBf
 SQOvPpA5XiZ1Kf56JsrAvAlqi7eLlApCiK5LwA+DYvRKSH8e5Z61nZEDKilVp7yXVyvy5fjNHIJ
 ijsNXlQPCmvPIhVF0GMN7gjA5vChC72a2PQrrAGhnW6Z35DexsOLuriE+rwe1Jdy04cpUzj3M/c
 EaS5M3HhDNkvPIazQNQDrBNOLNdFNQjgJmV6JFgnJWEH/PYyG+hrgk0SLoJPWDp5LzV+UIGO3dj
 HaM2t4ajQe1J+Sc3PlgtANjwL+2Fp5Elu2I8CFNRSI2Kww==
X-Received: by 2002:a05:6000:1a8b:b0:38d:d8b2:cf14 with SMTP id
 ffacd0b85a97d-38dea28cffemr7631072f8f.30.1739462513856; 
 Thu, 13 Feb 2025 08:01:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu7ftjSrsulhgq/qsGntZ/7C+sn6rupvgD/hZR4vjcYcRQY9CJb7o0IN+g4uvK43nd+dC5sA==
X-Received: by 2002:a05:6000:1a8b:b0:38d:d8b2:cf14 with SMTP id
 ffacd0b85a97d-38dea28cffemr7630980f8f.30.1739462513012; 
 Thu, 13 Feb 2025 08:01:53 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a055859sm52907205e9.10.2025.02.13.08.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 20/27] rust/timer/hpet: define hpet_fw_cfg
Date: Thu, 13 Feb 2025 17:00:47 +0100
Message-ID: <20250213160054.3937012-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Define HPETFwEntry structure with the same memory layout as
hpet_fw_entry in C.

Further, define the global hpet_cfg variable in Rust which is the
same as the C version. This hpet_cfg variable in Rust will replace
the C version one and allows both Rust code and C code to access it.

The Rust version of hpet_cfg is self-contained, avoiding unsafe
access to C code.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250210030051.2562726-8-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                  |  8 ++++
 rust/Cargo.toml                  |  1 +
 rust/hw/meson.build              |  1 +
 rust/hw/timer/hpet/Cargo.toml    | 18 ++++++++
 rust/hw/timer/hpet/meson.build   | 18 ++++++++
 rust/hw/timer/hpet/src/fw_cfg.rs | 71 ++++++++++++++++++++++++++++++++
 rust/hw/timer/hpet/src/lib.rs    | 10 +++++
 rust/hw/timer/meson.build        |  1 +
 rust/qemu-api/src/zeroable.rs    |  6 ++-
 9 files changed, 132 insertions(+), 2 deletions(-)
 create mode 100644 rust/hw/timer/hpet/Cargo.toml
 create mode 100644 rust/hw/timer/hpet/meson.build
 create mode 100644 rust/hw/timer/hpet/src/fw_cfg.rs
 create mode 100644 rust/hw/timer/hpet/src/lib.rs
 create mode 100644 rust/hw/timer/meson.build

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c0c6069247a..79e142723b8 100644
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
index 5b0cb559286..5041d6291fd 100644
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
index 860196645e7..9749d4adfc9 100644
--- a/rust/hw/meson.build
+++ b/rust/hw/meson.build
@@ -1 +1,2 @@
 subdir('char')
+subdir('timer')
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
new file mode 100644
index 00000000000..147f216e725
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
index 00000000000..c2d7c0532ca
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
index 00000000000..849e277d483
--- /dev/null
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -0,0 +1,71 @@
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
+/// Each `HPETState` represents a Event Timer Block. The v1 spec supports
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
+impl_zeroable!(HPETFwEntry);
+
+#[repr(C, packed)]
+#[derive(Copy, Clone, Default)]
+pub struct HPETFwConfig {
+    pub count: u8,
+    pub hpet: [HPETFwEntry; HPET_MAX_NUM_EVENT_TIMER_BLOCK],
+}
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
index 00000000000..44e9f3fb8ab
--- /dev/null
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -0,0 +1,10 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! # HPET QEMU Device Model
+//!
+//! This library implements a device model for the IA-PC HPET (High
+//! Precision Event Timers) device in QEMU.
+
+pub mod fw_cfg;
diff --git a/rust/hw/timer/meson.build b/rust/hw/timer/meson.build
new file mode 100644
index 00000000000..22a84f15536
--- /dev/null
+++ b/rust/hw/timer/meson.build
@@ -0,0 +1 @@
+subdir('hpet')
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 9f009606b1a..cd424e6ea05 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -56,6 +56,7 @@ pub unsafe trait Zeroable: Default {
 /// ## Differences with `core::mem::zeroed`
 ///
 /// `const_zero` zeroes padding bits, while `core::mem::zeroed` doesn't
+#[macro_export]
 macro_rules! const_zero {
     // This macro to produce a type-generic zero constant is taken from the
     // const_zero crate (v0.1.1):
@@ -77,10 +78,11 @@ union TypeAsBytes {
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
2.48.1


