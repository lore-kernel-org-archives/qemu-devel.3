Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD9ED2CE17
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 04:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vS6TN-0001cd-U6; Sat, 06 Dec 2025 23:34:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5XI-0002wK-2e
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:12 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5XD-0002VU-S9
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:10 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7baf61be569so3891635b3a.3
 for <qemu-devel@nongnu.org>; Sat, 06 Dec 2025 19:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765078446; x=1765683246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxHzwdNs0hmfF7X9ON6zGAVj61NHy2UgBo4Qhmy9qRg=;
 b=Xktd5gAVgq8tvF7aEBf4s783dstXV1e1WDayGZRaEYxCxyRrMKCut7w6BToK4nSd6n
 Q/Hn1HhMTTXBydTQI8Eg5h3p1A6wSqSOSXxDn5WBvUBfmmtTVfGX28xDCaQxOB0QwK7t
 +RcunEeWhDm3HKrWltaMH9EyzzLMdIE5Kf4w3duJxc/UcpJnqem8nZ0xC1FNfzDZY/xp
 x+apGb4l0UhXlyiUVbOQqXrL2ztuXFr+YSGyt9F/rGcTEEH55vD1N1XOwAuC9zvSPYYO
 FJ2GPnzapqPIjnePPXE4KYzVV2nCKA+C3dw/kc4cEtP6EC6setmhBVjrSFjaDRgGLczZ
 0LEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765078446; x=1765683246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZxHzwdNs0hmfF7X9ON6zGAVj61NHy2UgBo4Qhmy9qRg=;
 b=YwaLgIIl6Vhv4+8hPwbiX6h48FG82mFqtjLNd41OKLvGFg1Z8lt2lbJcUsrnDRATVQ
 hNZpgsb1hxb25497VT/Fl7HmO2PSp/Uyy8W9LeRYYDpc4UWCBdnZaHJ7kF4Y9II2gxO8
 AHb0s7szFs4Px1tbupqTS8eRxfp+ptyqC7U9UZ5VyFPrzBPEIhQyPjXv32mBdqhhbRbA
 pRhN2iKQHs//nGIJEbUD5ihJdoqEjWKdm73ng6RlZYt4xiv7wL8XlID1UKeKY0KoZ578
 XgnJHX0NrJ0ypN2Tb+Vzv0W4Miq5s41N0A22Ujg+Us0MjaEfjasitbGeiIRRpoqw+rx0
 0u8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXZtxQUR3RVHk12JIsSK092DyG8Q/k2K7IpV8WMZrNs9ompXSCEp/ULGeSz7Ym1oErjpKLdygojOZA@nongnu.org
X-Gm-Message-State: AOJu0YxBOnwkLMR93zs+CkfXMjvJiGEKYJrXjjZ8ZOBvl4xQX8GRfJOI
 dRD2YsfEekXnbGfhpnz8FAj+CjVwKpyLRRk1jjI/JP7f5LifwV0nDrI2
X-Gm-Gg: ASbGnctlrx526uymf4fAZXr+yEL1LhCLdHfwFfFyNLT4uvDuqiyViIO9YBuv4SWKBRT
 LEz9vDTVxl4c7gxLMX3fEitVruDV79RB+8sdeyyxK667deExaw0dglWRVtBGJFcTt81G0RxlY11
 rj+r8vhO4BnDRlwnsFtEbTzVnZCvrW4c1hrsnkFRbIVRpPahfb19rGXXIFlbTKRod4XoGoQPBxb
 5OcV0nPDpDDUlPpPjR9tQvk+B6yowDpu96aJQP3eg20+axYYo82FQk20jpPNGdM4c/2QvXI87fU
 BHyAJG5ZeSUtl2u83Hu5MHzkiV+4aaTW2UzlCQ4XeKg//BJv7qbWHx/jcpsmwLtdMQd/BL8pQ0O
 XIcIMpNM7D7nUUZsY9zN/0DkE8V3k3Bk+WpyBr85woHAuBDOpjoNooqopEFhBzilYZvFLb9VmPC
 KzzfcgkwSxeKryhq8kwClNFDcFSfBdgNx/AsYUCFdPVvs4Nw==
X-Google-Smtp-Source: AGHT+IEGdl4AcEdp6fnOnIkDHPCApJLwV+uvX1qwxP+tEwBPi7CwhIzyGaCMlazySnHdJturiTzAXQ==
X-Received: by 2002:a05:6a21:998b:b0:35d:7f7:4aac with SMTP id
 adf61e73a8af0-36617ed7cc7mr3771999637.47.1765078446332; 
 Sat, 06 Dec 2025 19:34:06 -0800 (PST)
Received: from nyaos.localdomain ([166.0.199.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bf6a1caeea7sm8496390a12.24.2025.12.06.19.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 19:34:05 -0800 (PST)
From: ChenMiao <chenmiao.ku@gmail.com>
To: zhao1.liu@intel.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
Cc: chao.liu@openatom.club , dzm91@openatom.club , qemu-rust@nongnu.org,
 qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 chenmiao <chenmiao@openatom.club>
Subject: [PATCH v3 4/4] rust/hw/gpio: Add the the first gpio device pcf8574
Date: Sun,  7 Dec 2025 03:33:31 +0000
Message-ID: <2d5800af31f4d8f4b33aadef49f0e6999067bd16.1765077679.git.chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765077679.git.chenmiao@openatom.club>
References: <cover.1765077679.git.chenmiao@openatom.club>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=chenmiao.ku@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Dec 2025 23:34:11 -0500
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

From: chenmiao <chenmiao@openatom.club>

After implementing the I2CBus and I2CSlave, we proceeded to implement a basic
GPIO device — the PCF8574 — which depends on I2CSlave.

This patch must depend on the below link to compile normally:

https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg07356.html

At present, I have summarized the general workflow for device modeling in Rust
as follows:

1. Modify the configuration under hw/deviceto distinguish between C and Rust
   versions.
2. Create a device crate under rust/hw.
3. Add (or copy) the necessary wrappers, build.rs, and bindings.
4. Begin the device modeling process.
5. Construct the corresponding structures in Rust that mirror those in C,
   especially for “members that may change”.
6. Referencing the C implementation, define initialization functions and
   establish parent-class relationships for the Rust structure.
7. Set up ObjectImpl, DeviceImpl, and ResettablePhasesImpl.
8. Configure vmstate.
9. Implement other functional methods.

Signed-off-by: Chen Miao <chenmiao@openatom.club>
---
 hw/gpio/Kconfig                  |   5 +
 hw/gpio/meson.build              |   2 +-
 rust/Cargo.lock                  |  18 +++-
 rust/Cargo.toml                  |   1 +
 rust/hw/Kconfig                  |   1 +
 rust/hw/gpio/Kconfig             |   2 +
 rust/hw/gpio/meson.build         |   1 +
 rust/hw/gpio/pcf8574/Cargo.toml  |  28 +++++
 rust/hw/gpio/pcf8574/meson.build |  37 +++++++
 rust/hw/gpio/pcf8574/src/lib.rs  | 178 +++++++++++++++++++++++++++++++
 rust/hw/meson.build              |   1 +
 11 files changed, 272 insertions(+), 2 deletions(-)
 create mode 100644 rust/hw/gpio/Kconfig
 create mode 100644 rust/hw/gpio/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/Cargo.toml
 create mode 100644 rust/hw/gpio/pcf8574/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/src/lib.rs

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294c20..1be534aaf6 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -27,6 +27,11 @@ config PCA9554
 config PCF8574
     bool
     depends on I2C
+    select PCF8574_C if !HAVE_RUST
+    select X_PCF8574_RUST if HAVE_RUST
+
+config PCF8574_C
+    bool
 
 config ZAURUS_SCOOP
     bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c0..9e4b1a8fd7 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -17,4 +17,4 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
-system_ss.add(when: 'CONFIG_PCF8574', if_true: files('pcf8574.c'))
+system_ss.add(when: 'CONFIG_PCF8574_C', if_true: files('pcf8574.c'))
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 0c1df625df..2db2f70e8a 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -1,6 +1,6 @@
 # This file is automatically @generated by Cargo.
 # It is not intended for manual editing.
-version = 3
+version = 4
 
 [[package]]
 name = "anyhow"
@@ -204,6 +204,22 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "pcf8574"
+version = "0.1.0"
+dependencies = [
+ "bits",
+ "bql",
+ "common",
+ "glib-sys",
+ "hwcore",
+ "migration",
+ "qom",
+ "system",
+ "trace",
+ "util",
+]
+
 [[package]]
 name = "pkg-config"
 version = "0.3.32"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 783e626802..6a17eefe49 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -10,6 +10,7 @@ members = [
     "system",
     "hw/core",
     "hw/char/pl011",
+    "hw/gpio/pcf8574",
     "hw/timer/hpet",
     "trace",
     "util",
diff --git a/rust/hw/Kconfig b/rust/hw/Kconfig
index 36f92ec028..ba1297ca2d 100644
--- a/rust/hw/Kconfig
+++ b/rust/hw/Kconfig
@@ -1,3 +1,4 @@
 # devices Kconfig
 source char/Kconfig
+source gpio/Kconfig
 source timer/Kconfig
diff --git a/rust/hw/gpio/Kconfig b/rust/hw/gpio/Kconfig
new file mode 100644
index 0000000000..c47aa76f14
--- /dev/null
+++ b/rust/hw/gpio/Kconfig
@@ -0,0 +1,2 @@
+config X_PCF8574_RUST
+    bool
diff --git a/rust/hw/gpio/meson.build b/rust/hw/gpio/meson.build
new file mode 100644
index 0000000000..908991ad13
--- /dev/null
+++ b/rust/hw/gpio/meson.build
@@ -0,0 +1 @@
+subdir('pcf8574')
diff --git a/rust/hw/gpio/pcf8574/Cargo.toml b/rust/hw/gpio/pcf8574/Cargo.toml
new file mode 100644
index 0000000000..a3bd82f93d
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name = "pcf8574"
+version = "0.1.0"
+authors = ["Chen Miao <chenmiao@openatom.club>"]
+description = "pcf8574 device model for QEMU"
+resolver = "2"
+publish = false
+
+edition.workspace = true
+homepage.workspace = true
+license.workspace = true
+repository.workspace = true
+rust-version.workspace = true
+
+[dependencies]
+glib-sys.workspace = true
+bits = { path = "../../../bits" }
+common = { path = "../../../common" }
+util = { path = "../../../util" }
+bql = { path = "../../../bql" }
+migration = { path = "../../../migration" }
+qom = { path = "../../../qom" }
+system = { path = "../../../system" }
+hwcore = { path = "../../../hw/core" }
+trace = { path = "../../../trace" }
+
+[lints]
+workspace = true
diff --git a/rust/hw/gpio/pcf8574/meson.build b/rust/hw/gpio/pcf8574/meson.build
new file mode 100644
index 0000000000..f0b7f9e687
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/meson.build
@@ -0,0 +1,37 @@
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_libpcf8574_rs = static_library(
+  'pcf8574',
+  structured_sources(
+    [
+      'src/lib.rs',
+    ],
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  dependencies: [
+    bilge_rs,
+    bilge_impl_rs,
+    bits_rs,
+    common_rs,
+    glib_sys_rs,
+    util_rs,
+    migration_rs,
+    bql_rs,
+    qom_rs,
+    chardev_rs,
+    system_rs,
+    hwcore_rs,
+    trace_rs
+  ],
+)
+
+rust_devices_ss.add(when: 'CONFIG_X_PCF8574_RUST', if_true: [declare_dependency(
+  link_whole: [_libpcf8574_rs],
+  variables: {'crate': 'pcf8574'},
+)])
diff --git a/rust/hw/gpio/pcf8574/src/lib.rs b/rust/hw/gpio/pcf8574/src/lib.rs
new file mode 100644
index 0000000000..4bec081876
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/src/lib.rs
@@ -0,0 +1,178 @@
+// Copyright 2025 HUST OpenAtom Open Source Club.
+// Author(s): Chen Miao <chenmiao@openatom.club>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::slice::from_ref;
+
+use bql::BqlRefCell;
+use common::bitops::IntegerExt;
+use hwcore::{
+    DeviceClass, DeviceImpl, DeviceMethods, DeviceState, I2CResult, I2CSlave, I2CSlaveImpl,
+    InterruptSource, ResetType, ResettablePhasesImpl,
+};
+use migration::{
+    self, impl_vmstate_struct, vmstate_fields, vmstate_of, VMStateDescription,
+    VMStateDescriptionBuilder,
+};
+use qom::{qom_isa, IsA, Object, ObjectImpl, ObjectType, ParentField};
+
+pub const TYPE_PCF8574: &::std::ffi::CStr = c"pcf8574";
+const PORTS_COUNT: usize = 8;
+
+#[repr(C)]
+#[derive(Clone, Copy, Debug, Default)]
+pub struct PCF8574Inner {
+    pub lastrq: u8,
+    pub input: u8,
+    pub output: u8,
+}
+
+impl PCF8574Inner {
+    pub fn line_state(&self) -> u8 {
+        self.input & self.output
+    }
+
+    pub fn set_output(&mut self, data: u8) -> (u8, u8) {
+        let prev = self.line_state();
+        self.output = data;
+        let actual = self.line_state();
+        (prev, actual)
+    }
+
+    pub fn set_input(&mut self, start: u32, value: u8) -> bool {
+        self.input = self.input.deposit(start, 1, value);
+        self.has_state_changed()
+    }
+
+    pub fn receive(&mut self) -> (bool, u8) {
+        let state_changed = self.has_state_changed();
+        if state_changed {
+            self.lastrq = self.line_state();
+        }
+        (state_changed, self.lastrq)
+    }
+
+    pub fn has_state_changed(&self) -> bool {
+        self.line_state() != self.lastrq
+    }
+}
+
+#[repr(C)]
+#[derive(qom::Object, hwcore::Device)]
+pub struct PCF8574State {
+    pub parent_obj: ParentField<I2CSlave>,
+    pub inner: BqlRefCell<PCF8574Inner>,
+    pub handler: [InterruptSource; PORTS_COUNT],
+    pub intrq: InterruptSource,
+}
+
+// static_assert!(size_of::<PCF8574State>() <= size_of::<crate::bindings::PCF8574State>());
+
+qom_isa!(PCF8574State: I2CSlave, DeviceState, Object);
+
+#[allow(dead_code)]
+trait PCF8574Impl: I2CSlaveImpl + IsA<PCF8574State> {}
+
+unsafe impl ObjectType for PCF8574State {
+    type Class = DeviceClass;
+    const TYPE_NAME: &'static std::ffi::CStr = crate::TYPE_PCF8574;
+}
+
+impl PCF8574Impl for PCF8574State {}
+
+impl ObjectImpl for PCF8574State {
+    type ParentType = I2CSlave;
+    const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
+}
+
+impl DeviceImpl for PCF8574State {
+    const VMSTATE: Option<migration::VMStateDescription<Self>> = Some(VMSTATE_PCF8574);
+    const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
+}
+
+impl ResettablePhasesImpl for PCF8574State {
+    const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
+}
+
+impl I2CSlaveImpl for PCF8574State {
+    const SEND: Option<fn(&Self, data: u8) -> I2CResult> = Some(Self::send);
+    const RECV: Option<fn(&Self) -> u8> = Some(Self::recv);
+}
+
+impl PCF8574State {
+    fn send(&self, data: u8) -> I2CResult {
+        let (prev, actual) = self.inner.borrow_mut().set_output(data);
+
+        let mut diff = actual ^ prev;
+        while diff != 0 {
+            let line = diff.trailing_zeros() as u8;
+            if let Some(handler) = self.handler.get(line as usize) {
+                handler.set((actual >> line) & 1 == 1);
+            }
+            diff &= !(1 << line);
+        }
+
+        self.intrq.set(actual == self.inner.borrow().lastrq);
+
+        I2CResult::ACK
+    }
+
+    fn recv(&self) -> u8 {
+        let (has_changed, actual) = self.inner.borrow_mut().receive();
+        if has_changed {
+            self.intrq.raise();
+        }
+
+        actual
+    }
+
+    fn realize(&self) -> util::Result<()> {
+        self.init_gpio_in(self.handler_size(), PCF8574State::gpio_set);
+        self.init_gpio_out(from_ref(&self.handler[0]));
+        self.init_gpio_out_named(from_ref(&self.intrq), "nINT", 1);
+        Ok(())
+    }
+
+    fn gpio_set(&self, line: u32, level: u32) {
+        assert!(line < self.handler_size());
+
+        if self
+            .inner
+            .borrow_mut()
+            .set_input(line, u8::from(level != 0))
+        {
+            self.intrq.raise();
+        }
+    }
+
+    fn handler_size(&self) -> u32 {
+        self.handler.len() as u32
+    }
+
+    fn reset_hold(&self, _type: ResetType) {}
+}
+
+impl_vmstate_struct!(
+    PCF8574Inner,
+    VMStateDescriptionBuilder::<PCF8574Inner>::new()
+        .name(c"pcf8574/inner")
+        .version_id(0)
+        .minimum_version_id(0)
+        .fields(vmstate_fields! {
+            vmstate_of!(PCF8574Inner, lastrq),
+            vmstate_of!(PCF8574Inner, input),
+            vmstate_of!(PCF8574Inner, output),
+        })
+        .build()
+);
+
+pub const VMSTATE_PCF8574: VMStateDescription<PCF8574State> =
+    VMStateDescriptionBuilder::<PCF8574State>::new()
+        .name(c"pcf8574")
+        .version_id(0)
+        .minimum_version_id(0)
+        .fields(vmstate_fields! {
+            vmstate_of!(PCF8574State, parent_obj),
+            vmstate_of!(PCF8574State, inner),
+        })
+        .build();
diff --git a/rust/hw/meson.build b/rust/hw/meson.build
index 9749d4adfc..d6b273170e 100644
--- a/rust/hw/meson.build
+++ b/rust/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('char')
+subdir('gpio')
 subdir('timer')
-- 
2.43.0


