Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80546CCF9E5
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 14:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCfEk-0003yy-3Z; Sat, 25 Oct 2025 10:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZG-0001bh-Aa
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:22 -0400
Received: from sg-1-19.ptr.blmpb.com ([118.26.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZ8-0003k0-IZ
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761395941;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=MytP5lhPp5eL9SG/hOPfOaxRIPzTXGCToTafD3OYWs4=;
 b=rdMSUbG8P0axhMZkiUahwjKqyfSCBM3fL8Zv1ySmcHwMq427+2StbRjkUMYn4XTf/uB0Wv
 6hOxHosWASJsqcdTzC6qM6IX+XF6/FADqqLglXUJCdh2zxxb6Ue0gVDLFGROV3yE1K+EeD
 zRsp69tvxy1h/DOYrO6WWm2ClS5LKV9LBGiCvpl3Dgvx/58UESvJH1/XbxVen8qhDsq8Xq
 FJNvH9SHOdBO2zFv8QDDMHqNu1bjPBp+ALeRelCt8yGZqtowtIKlJvsZDAcsc9Vo+l/oSk
 w1UaHSOMOjff4MSrD9CszeVLNTbgSZMBG9gpLLt/pNChvq5UH2YlPuahs9veNA==
X-Original-From: chenmiao <chenmiao@openatom.club>
From: "chenmiao" <chenmiao@openatom.club>
Subject: [RFC 5/5] rust: hw: gpio: Add the the first gpio device pcf8574
X-Lms-Return-Path: <lba+268fcc4e4+522adf+nongnu.org+chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Oct 2025 12:38:53 +0000
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Sat, 25 Oct 2025 20:38:59 +0800
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>
Message-Id: <20251025123853.63139-6-chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
To: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>
Mime-Version: 1.0
Received-SPF: pass client-ip=118.26.132.19;
 envelope-from=chenmiao@openatom.club; helo=sg-1-19.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Oct 2025 10:27:12 -0400
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

After implementing the I2CBus and I2CSlave, we proceeded to implement a bas=
ic
GPIO device =E2=80=94 the PCF8574 =E2=80=94 which depends on I2CSlave.

If we had directly referred to the PL011 implementation, we would have been
able to achieve a basic version of the PCF8574. However, during the
implementation, the excessive number of types and conversions led to variou=
s
comprehension conflicts and cognitive overhead.

The most significant insight I gained during this process is that the curre=
nt
approach in Rust appears to be more complex and harder to understand than i=
ts
C counterpart. This trend poses a substantial barrier for developers intere=
sted
in Rust for QEMU, preventing them from efficiently, quickly, and safely mod=
eling
QEMU devices in Rust. In my opinion, this deviates from the original intent=
 of
adopting Rust.

Moreover, the mechanisms of bindings and wrappers are overly redundant, and
there is no clear indication that they are mandatory. These constructs gene=
rate
a large number of similar structures in the final compilation artifacts. Co=
uld
we design a more generic approach to bindings and wrappers?

Additionally, vmstate has not been fully implemented for the PCF8574 (to be
precise, it is not yet complete). During the implementation, I encountered =
an
issue: initially, I tried to directly transliterate the C struct =E2=80=94 =
that is, I
attempted to configure vmstate and handle other aspects directly via field
mappings. However, I eventually found that some internal APIs were incompat=
ible.
To make it work, I had to isolate those "potentially mutable values" into a
separate structure, akin to something like a "PL011Register", in order for =
it
to function correctly. Moreover, the vmstate configuration also needed to b=
e
declared separately. Although I could infer its meaning, I still hope that =
a
more rational and streamlined process can be established.

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

Signed-off-by: chenmiao <chenmiao@openatom.club>
---
 hw/gpio/Kconfig                      |   5 +
 hw/gpio/meson.build                  |   2 +-
 rust/Cargo.lock                      |  21 +++-
 rust/Cargo.toml                      |   1 +
 rust/hw/Kconfig                      |   1 +
 rust/hw/core/src/i2cbus.rs           |  22 ++++
 rust/hw/gpio/Kconfig                 |   2 +
 rust/hw/gpio/meson.build             |   1 +
 rust/hw/gpio/pcf8574/Cargo.toml      |  31 +++++
 rust/hw/gpio/pcf8574/build.rs        |   1 +
 rust/hw/gpio/pcf8574/meson.build     |  50 ++++++++
 rust/hw/gpio/pcf8574/src/bindings.rs |  29 +++++
 rust/hw/gpio/pcf8574/src/device.rs   | 174 +++++++++++++++++++++++++++
 rust/hw/gpio/pcf8574/src/lib.rs      |   4 +
 rust/hw/gpio/pcf8574/wrapper.h       |  51 ++++++++
 rust/hw/meson.build                  |   1 +
 16 files changed, 394 insertions(+), 2 deletions(-)
 create mode 100644 rust/hw/gpio/Kconfig
 create mode 100644 rust/hw/gpio/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/Cargo.toml
 create mode 120000 rust/hw/gpio/pcf8574/build.rs
 create mode 100644 rust/hw/gpio/pcf8574/meson.build
 create mode 100644 rust/hw/gpio/pcf8574/src/bindings.rs
 create mode 100644 rust/hw/gpio/pcf8574/src/device.rs
 create mode 100644 rust/hw/gpio/pcf8574/src/lib.rs
 create mode 100644 rust/hw/gpio/pcf8574/wrapper.h

diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index a209294..1be534a 100644
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
index 7484061..9e4b1a8 100644
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
index 1108513..e974498 100644
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
@@ -203,6 +203,25 @@ dependencies =3D [
  "util",
 ]
=20
+[[package]]
+name =3D "pcf8574"
+version =3D "0.1.0"
+dependencies =3D [
+ "bilge",
+ "bilge-impl",
+ "bits",
+ "bql",
+ "chardev",
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
index 783e626..6a17eef 100644
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
index 36f92ec..ba1297c 100644
--- a/rust/hw/Kconfig
+++ b/rust/hw/Kconfig
@@ -1,3 +1,4 @@
 # devices Kconfig
 source char/Kconfig
+source gpio/Kconfig
 source timer/Kconfig
diff --git a/rust/hw/core/src/i2cbus.rs b/rust/hw/core/src/i2cbus.rs
index c026955..71ce356 100644
--- a/rust/hw/core/src/i2cbus.rs
+++ b/rust/hw/core/src/i2cbus.rs
@@ -185,6 +185,15 @@ pub trait I2CSlaveImpl: DeviceImpl + IsA<I2CSlave> {
     const MATCH_AND_ADD: Option<Self::AddressMatcher> =3D None;
 }
=20
+// const I2C_BROADCAST: usize =3D 0x0;
+
+// impl I2CSlave {
+//     pub unsafe fn post_load(&self, _version_id: u32) -> Result<(), migr=
ation::InvalidError> {
+//         // TODO
+//         Ok(())
+//     }
+// }
+
 impl I2CSlaveClass {
     /// Fill in the virtual methods of `I2CSlaveClass` based on the
     /// definitions in the `I2CSlaveImpl` trait.
@@ -289,3 +298,16 @@ fn from(event: I2CEvent) -> Self {
         }
     }
 }
+
+// impl_vmstate_struct!(
+//     I2CSlave,
+//     VMStateDescriptionBuilder::<I2CSlave>::new()
+//         .name(c"I2CSlave")
+//         .version_id(1)
+//         .minimum_version_id(1)
+//         .post_load(&I2CSlave::post_load)
+//         .fields(vmstate_fields! {
+//             vmstate_of!(I2CSlave, address),
+//         })
+//         .build()
+// );
diff --git a/rust/hw/gpio/Kconfig b/rust/hw/gpio/Kconfig
new file mode 100644
index 0000000..c47aa76
--- /dev/null
+++ b/rust/hw/gpio/Kconfig
@@ -0,0 +1,2 @@
+config X_PCF8574_RUST
+    bool
diff --git a/rust/hw/gpio/meson.build b/rust/hw/gpio/meson.build
new file mode 100644
index 0000000..908991a
--- /dev/null
+++ b/rust/hw/gpio/meson.build
@@ -0,0 +1 @@
+subdir('pcf8574')
diff --git a/rust/hw/gpio/pcf8574/Cargo.toml b/rust/hw/gpio/pcf8574/Cargo.t=
oml
new file mode 100644
index 0000000..e3647f6
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/Cargo.toml
@@ -0,0 +1,31 @@
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
+bilge =3D { version =3D "0.2.0" }
+bilge-impl =3D { version =3D "0.2.0" }
+bits =3D { path =3D "../../../bits" }
+common =3D { path =3D "../../../common" }
+util =3D { path =3D "../../../util" }
+bql =3D { path =3D "../../../bql" }
+migration =3D { path =3D "../../../migration" }
+qom =3D { path =3D "../../../qom" }
+chardev =3D { path =3D "../../../chardev" }
+system =3D { path =3D "../../../system" }
+hwcore =3D { path =3D "../../../hw/core" }
+trace =3D { path =3D "../../../trace" }
+
+[lints]
+workspace =3D true
diff --git a/rust/hw/gpio/pcf8574/build.rs b/rust/hw/gpio/pcf8574/build.rs
new file mode 120000
index 0000000..5f5060d
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/build.rs
@@ -0,0 +1 @@
+../../../util/build.rs
\ No newline at end of file
diff --git a/rust/hw/gpio/pcf8574/meson.build b/rust/hw/gpio/pcf8574/meson.=
build
new file mode 100644
index 0000000..64de866
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/meson.build
@@ -0,0 +1,50 @@
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
+_libpcf8574_bindings_inc_rs =3D rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=3D0.60.0'],
+  args: bindgen_args_common,
+  c_args: bindgen_c_args,
+)
+
+_libpcf8574_rs =3D static_library(
+  'pcf8574',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/device.rs',
+    ],
+    {'.' : _libpcf8574_bindings_inc_rs},
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
diff --git a/rust/hw/gpio/pcf8574/src/bindings.rs b/rust/hw/gpio/pcf8574/sr=
c/bindings.rs
new file mode 100644
index 0000000..2c1b236
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/src/bindings.rs
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#![allow(
+    dead_code,
+    improper_ctypes_definitions,
+    improper_ctypes,
+    non_camel_case_types,
+    non_snake_case,
+    non_upper_case_globals,
+    unnecessary_transmutes,
+    unsafe_op_in_unsafe_fn,
+    clippy::pedantic,
+    clippy::restriction,
+    clippy::style,
+    clippy::missing_const_for_fn,
+    clippy::ptr_offset_with_cast,
+    clippy::useless_transmute,
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
+)]
+
+//! `bindgen`-generated declarations.
+
+use glib_sys::{GHashTable, GHashTableIter, GList, GPtrArray, GQueue, GSLis=
t};
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/hw/gpio/pcf8574/src/device.rs b/rust/hw/gpio/pcf8574/src/=
device.rs
new file mode 100644
index 0000000..e4d2228
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/src/device.rs
@@ -0,0 +1,174 @@
+// Copyright 2025 HUST OpenAtom Open Source Club.
+// Author(s): Chen Miao <chenmiao@openatom.club>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{marker::PhantomData, slice::from_ref};
+
+// use common::static_assert;
+use bql::BqlRefCell;
+use hwcore::{
+    DeviceClass, DeviceImpl, DeviceMethods, DeviceState, I2CSlave, I2CSlav=
eImpl, InterruptSource,
+    ResetType, ResettablePhasesImpl,
+};
+use migration::{
+    self, impl_vmstate_struct, vmstate_fields, vmstate_of, VMStateDescript=
ion,
+    VMStateDescriptionBuilder,
+};
+use qom::{qom_isa, IsA, Object, ObjectImpl, ObjectType, ParentField};
+use util::Result;
+
+const PORTS_COUNT: usize =3D 8;
+
+#[repr(C)]
+#[derive(Debug, Default)]
+pub struct PCF8574StateInner {
+    pub lastrq: u8,
+    pub input: u8,
+    pub output: u8,
+}
+
+#[repr(C)]
+#[derive(qom::Object, hwcore::Device)]
+pub struct PCF8574State {
+    pub parent_obj: ParentField<I2CSlave>,
+    pub inner: BqlRefCell<PCF8574StateInner>,
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
+    const SEND: Option<fn(&Self, data: u8) -> util::Result<bool>> =3D Some=
(Self::send);
+    const RECV: Option<fn(&Self) -> util::Result<bool>> =3D Some(Self::rec=
v);
+    const SEND_ASYNC: Option<fn(&Self, data: u8) -> util::Result<()>> =3D =
None;
+    const EVENT: Option<fn(&Self, event: hwcore::I2CEvent) -> util::Result=
<hwcore::I2CEvent>> =3D
+        None;
+    type AddressMatcher =3D PhantomData<()>;
+    const MATCH_AND_ADD: Option<Self::AddressMatcher> =3D None;
+}
+
+impl PCF8574State {
+    fn send(&self, data: u8) -> Result<bool> {
+        let prev =3D self.line_state();
+        self.inner.borrow_mut().output =3D data;
+        let actual =3D self.line_state();
+
+        let mut diff =3D actual ^ prev;
+        while diff !=3D 0 {
+            let line =3D diff.trailing_zeros() as u8;
+            if let Some(handler) =3D self.handler.get(line as usize) {
+                if handler.get() {
+                    handler.set((actual >> line) & 1 =3D=3D 1);
+                }
+            }
+            diff &=3D !(1 << line);
+        }
+
+        if self.intrq.get() {
+            self.intrq.set(actual =3D=3D self.inner.borrow().lastrq);
+        }
+
+        Ok(true)
+    }
+
+    fn recv(&self) -> Result<bool> {
+        let line_state =3D self.line_state();
+        if self.inner.borrow().lastrq !=3D line_state {
+            self.inner.borrow_mut().lastrq =3D line_state;
+            if self.intrq.get() {
+                self.intrq.raise();
+            }
+        }
+
+        Ok(true)
+    }
+
+    fn realize(&self) -> util::Result<()> {
+        self.init_gpio_in(self.handler_size(), PCF8574State::gpio_set);
+        self.init_gpio_out(from_ref(&self.handler[0]));
+        self.init_gpio_out_named(from_ref(&self.intrq), "nINT", 1);
+        Ok(())
+        // unsafe {
+        //   bindings::qdev_init_gpio_in(addr_of_mut!(*self), Self::gpio_s=
et, Self::handler_size as c_int);
+        //   bindings::qdev_init_gpio_out(addr_of_mut!(*self), InterruptSo=
urce::slice_as_ptr(self.handler), Self::handler_size as c_int);
+        //   bindings::qdev_init_gpio_out_named(addr_of_mut!(*self), self.=
intrq, c"nINT", 1);
+        // }
+    }
+
+    fn gpio_set(&self, line: u32, level: u32) {
+        assert!(line < self.handler_size());
+
+        match level {
+            0 =3D> self.inner.borrow_mut().input &=3D !(1 << line),
+            _ =3D> self.inner.borrow_mut().input |=3D 1 << line,
+        }
+
+        if self.line_state() !=3D self.inner.borrow().lastrq && self.intrq=
.get() {
+            self.intrq.raise();
+        }
+    }
+
+    fn handler_size(&self) -> u32 {
+        self.handler.len() as u32
+    }
+
+    fn line_state(&self) -> u8 {
+        let inner =3D self.inner.borrow();
+        inner.input & inner.output
+    }
+
+    fn reset_hold(&self, _type: ResetType) {}
+}
+
+impl_vmstate_struct!(
+    PCF8574StateInner,
+    VMStateDescriptionBuilder::<PCF8574StateInner>::new()
+        .name(c"pcf8574/inner")
+        .version_id(0)
+        .minimum_version_id(0)
+        .fields(vmstate_fields! {
+            vmstate_of!(PCF8574StateInner, lastrq),
+            vmstate_of!(PCF8574StateInner, input),
+            vmstate_of!(PCF8574StateInner, output),
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
+            // TODO
+            // vmstate_of!(PCF8574State, parent_obj),
+            vmstate_of!(PCF8574State, inner),
+        })
+        .build();
diff --git a/rust/hw/gpio/pcf8574/src/lib.rs b/rust/hw/gpio/pcf8574/src/lib=
.rs
new file mode 100644
index 0000000..0dec733
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/src/lib.rs
@@ -0,0 +1,4 @@
+mod bindings;
+mod device;
+
+pub const TYPE_PCF8574: &::std::ffi::CStr =3D c"pcf8574";
diff --git a/rust/hw/gpio/pcf8574/wrapper.h b/rust/hw/gpio/pcf8574/wrapper.=
h
new file mode 100644
index 0000000..29c7bdf
--- /dev/null
+++ b/rust/hw/gpio/pcf8574/wrapper.h
@@ -0,0 +1,51 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a=
 copy
+ * of this software and associated documentation files (the "Software"), t=
o deal
+ * in the Software without restriction, including without limitation the r=
ights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or se=
ll
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OT=
HER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
 FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS =
IN
+ * THE SOFTWARE.
+ */
+
+
+/*
+ * This header file is meant to be used as input to the `bindgen` applicat=
ion
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert=
 the
+ * correct libclang header paths on its own. We do not use stdatomic.h sym=
bols
+ * in QEMU code, so it's fine to declare dummy types instead.
+ */
+typedef enum memory_order {
+  memory_order_relaxed,
+  memory_order_consume,
+  memory_order_acquire,
+  memory_order_release,
+  memory_order_acq_rel,
+  memory_order_seq_cst,
+} memory_order;
+#endif /* __CLANG_STDATOMIC_H */
+
+#include "qemu/osdep.h"
+#include "hw/gpio/pcf8574.h"
diff --git a/rust/hw/meson.build b/rust/hw/meson.build
index 9749d4a..d6b2731 100644
--- a/rust/hw/meson.build
+++ b/rust/hw/meson.build
@@ -1,2 +1,3 @@
 subdir('char')
+subdir('gpio')
 subdir('timer')
--=20
2.43.0

