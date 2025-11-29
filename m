Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56EAD116F1
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLwg-00021l-SN; Sat, 29 Nov 2025 09:29:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwR-0001zB-CR
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:53 -0500
Received: from sg-1-14.ptr.blmpb.com ([118.26.132.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwL-0000xL-1s
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764426512;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=x9BgFcy5n1ZzHge4ReLN//FSVIJ1Lq1rkBIghQ1I/Q8=;
 b=IntsHH8tkn+GNhAoB/F7QU0Vudd6iXn7KJjT9z8KxtL6W+K5gv0udypn/fYkNbIRJ9aMLo
 jt+axrzlL8l7VaYDaAf8VQWgSPK4Vu8vunN6ZnU75vnewKraxdg+drlTmSHiPHcD9/JeCi
 e169VDZPSs+wLuVlDh4cte0q2PjCeX8MMgi5Bmep17alwnLiTYE92+Vn936YAh3U16/enV
 vqxcuIDE75qZMAOl+Y+X2KlCwWn4QGn0hDIi4gE89/HjApeXi/WWuJqMLF1S1IE/v6Lp1N
 GpwFM5kjcTHXoCuBAiRhtyNbEmjik5QRE0TX1h22AOIe8rbpnkVRRp0rD2EbqA==
Received: from nyaos.localdomain ([114.249.49.233]) by smtp.feishu.cn with
 ESMTPS; Sat, 29 Nov 2025 22:28:29 +0800
Message-Id: <2d5800af31f4d8f4b33aadef49f0e6999067bd16.1764426204.git.chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
Cc: <chao.liu@openatom.club>, <dzm91@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>, 
 "chenmiao" <chenmiao@openatom.club>
From: "Chen Miao" <chenmiao@openatom.club>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
X-Original-From: Chen Miao <chenmiao@openatom.club>
X-Lms-Return-Path: <lba+2692b030e+5c56aa+nongnu.org+chenmiao@openatom.club>
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
Subject: [RFC PATCH V3 4/4] rust/hw/gpio: Add the the first gpio device pcf8574
Date: Sat, 29 Nov 2025 14:28:22 +0000
Received-SPF: pass client-ip=118.26.132.14;
 envelope-from=chenmiao@openatom.club; helo=sg-1-14.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: chenmiao <chenmiao@openatom.club>

After implementing the I2CBus and I2CSlave, we proceeded to implement a bas=
ic
GPIO device =E2=80=94 the PCF8574 =E2=80=94 which depends on I2CSlave.

This patch must depend on the below link to compile normally:

https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg07356.html

At present, I have summarized the general workflow for device modeling in R=
ust
as follows:

1. Modify the configuration under hw/deviceto distinguish between C and Rus=
t
   versions.
2. Create a device crate under rust/hw.
3. Add (or copy) the necessary wrappers, build.rs, and bindings.
4. Begin the device modeling process.
5. Construct the corresponding structures in Rust that mirror those in C,
   especially for =E2=80=9Cmembers that may change=E2=80=9D.
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
=20
 config ZAURUS_SCOOP
     bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 74840619c0..9e4b1a8fd7 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -17,4 +17,4 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gpio=
.c'))
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
-version =3D 3
+version =3D 4
=20
 [[package]]
 name =3D "anyhow"
@@ -204,6 +204,22 @@ dependencies =3D [
  "util",
 ]
=20
+[[package]]
+name =3D "pcf8574"
+version =3D "0.1.0"
+dependencies =3D [
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
 name =3D "pkg-config"
 version =3D "0.3.32"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 783e626802..6a17eefe49 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -10,6 +10,7 @@ members =3D [
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
diff --git a/rust/hw/gpio/pcf8574/Cargo.toml b/rust/hw/gpio/pcf8574/Cargo.t=
oml
new file mode 100644
index 0000000000..a3bd82f93d
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/Cargo.toml
@@ -0,0 +1,28 @@
+[package]
+name =3D "pcf8574"
+version =3D "0.1.0"
+authors =3D ["Chen Miao <chenmiao@openatom.club>"]
+description =3D "pcf8574 device model for QEMU"
+resolver =3D "2"
+publish =3D false
+
+edition.workspace =3D true
+homepage.workspace =3D true
+license.workspace =3D true
+repository.workspace =3D true
+rust-version.workspace =3D true
+
+[dependencies]
+glib-sys.workspace =3D true
+bits =3D { path =3D "../../../bits" }
+common =3D { path =3D "../../../common" }
+util =3D { path =3D "../../../util" }
+bql =3D { path =3D "../../../bql" }
+migration =3D { path =3D "../../../migration" }
+qom =3D { path =3D "../../../qom" }
+system =3D { path =3D "../../../system" }
+hwcore =3D { path =3D "../../../hw/core" }
+trace =3D { path =3D "../../../trace" }
+
+[lints]
+workspace =3D true
diff --git a/rust/hw/gpio/pcf8574/meson.build b/rust/hw/gpio/pcf8574/meson.=
build
new file mode 100644
index 0000000000..f0b7f9e687
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/meson.build
@@ -0,0 +1,37 @@
+# TODO: Remove this comment when the clang/libclang mismatch issue is solv=
ed.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where t=
he
+# detected `libclang` does not match the expected `clang` version/target. =
In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_libpcf8574_rs =3D static_library(
+  'pcf8574',
+  structured_sources(
+    [
+      'src/lib.rs',
+    ],
+  ),
+  override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
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
+rust_devices_ss.add(when: 'CONFIG_X_PCF8574_RUST', if_true: [declare_depen=
dency(
+  link_whole: [_libpcf8574_rs],
+  variables: {'crate': 'pcf8574'},
+)])
diff --git a/rust/hw/gpio/pcf8574/src/lib.rs b/rust/hw/gpio/pcf8574/src/lib=
.rs
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
+    DeviceClass, DeviceImpl, DeviceMethods, DeviceState, I2CResult, I2CSla=
ve, I2CSlaveImpl,
+    InterruptSource, ResetType, ResettablePhasesImpl,
+};
+use migration::{
+    self, impl_vmstate_struct, vmstate_fields, vmstate_of, VMStateDescript=
ion,
+    VMStateDescriptionBuilder,
+};
+use qom::{qom_isa, IsA, Object, ObjectImpl, ObjectType, ParentField};
+
+pub const TYPE_PCF8574: &::std::ffi::CStr =3D c"pcf8574";
+const PORTS_COUNT: usize =3D 8;
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
+        let prev =3D self.line_state();
+        self.output =3D data;
+        let actual =3D self.line_state();
+        (prev, actual)
+    }
+
+    pub fn set_input(&mut self, start: u32, value: u8) -> bool {
+        self.input =3D self.input.deposit(start, 1, value);
+        self.has_state_changed()
+    }
+
+    pub fn receive(&mut self) -> (bool, u8) {
+        let state_changed =3D self.has_state_changed();
+        if state_changed {
+            self.lastrq =3D self.line_state();
+        }
+        (state_changed, self.lastrq)
+    }
+
+    pub fn has_state_changed(&self) -> bool {
+        self.line_state() !=3D self.lastrq
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
+// static_assert!(size_of::<PCF8574State>() <=3D size_of::<crate::bindings=
::PCF8574State>());
+
+qom_isa!(PCF8574State: I2CSlave, DeviceState, Object);
+
+#[allow(dead_code)]
+trait PCF8574Impl: I2CSlaveImpl + IsA<PCF8574State> {}
+
+unsafe impl ObjectType for PCF8574State {
+    type Class =3D DeviceClass;
+    const TYPE_NAME: &'static std::ffi::CStr =3D crate::TYPE_PCF8574;
+}
+
+impl PCF8574Impl for PCF8574State {}
+
+impl ObjectImpl for PCF8574State {
+    type ParentType =3D I2CSlave;
+    const CLASS_INIT: fn(&mut Self::Class) =3D Self::Class::class_init::<S=
elf>;
+}
+
+impl DeviceImpl for PCF8574State {
+    const VMSTATE: Option<migration::VMStateDescription<Self>> =3D Some(VM=
STATE_PCF8574);
+    const REALIZE: Option<fn(&Self) -> util::Result<()>> =3D Some(Self::re=
alize);
+}
+
+impl ResettablePhasesImpl for PCF8574State {
+    const HOLD: Option<fn(&Self, ResetType)> =3D Some(Self::reset_hold);
+}
+
+impl I2CSlaveImpl for PCF8574State {
+    const SEND: Option<fn(&Self, data: u8) -> I2CResult> =3D Some(Self::se=
nd);
+    const RECV: Option<fn(&Self) -> u8> =3D Some(Self::recv);
+}
+
+impl PCF8574State {
+    fn send(&self, data: u8) -> I2CResult {
+        let (prev, actual) =3D self.inner.borrow_mut().set_output(data);
+
+        let mut diff =3D actual ^ prev;
+        while diff !=3D 0 {
+            let line =3D diff.trailing_zeros() as u8;
+            if let Some(handler) =3D self.handler.get(line as usize) {
+                handler.set((actual >> line) & 1 =3D=3D 1);
+            }
+            diff &=3D !(1 << line);
+        }
+
+        self.intrq.set(actual =3D=3D self.inner.borrow().lastrq);
+
+        I2CResult::ACK
+    }
+
+    fn recv(&self) -> u8 {
+        let (has_changed, actual) =3D self.inner.borrow_mut().receive();
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
+            .set_input(line, u8::from(level !=3D 0))
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
+pub const VMSTATE_PCF8574: VMStateDescription<PCF8574State> =3D
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
--=20
2.43.0

