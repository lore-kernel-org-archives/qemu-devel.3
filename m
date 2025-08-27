Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093D1CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDeh-0000Jm-HR; Wed, 27 Aug 2025 06:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDeD-00005b-BS
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDe1-0003L5-SN
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ko57smFf+5OpTIsqKRWP10DJwgLTh0NmxUjsXMuJ4s=;
 b=SyAiB1U0QTbw3Gr3Tajig8ZsG/VhX0dwRxeuA1J14Tet08XPwHnnDMKUE205LrBaCzneSx
 NYceCk9lZ6plUAA6DjLcVm+aWF9yD/fZg27awbDIYxQyzAVfZ9bDsILvP7uHLCHITGbvTz
 g9DkVpS0X0k7qTxCdCEIP4umY0sBUZk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-hUdD0fEwPuassMqMAFH-HA-1; Wed,
 27 Aug 2025 06:44:39 -0400
X-MC-Unique: hUdD0fEwPuassMqMAFH-HA-1
X-Mimecast-MFC-AGG-ID: hUdD0fEwPuassMqMAFH-HA_1756291478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08057195608A; Wed, 27 Aug 2025 10:44:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEC0D18003FC; Wed, 27 Aug 2025 10:44:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 21/22] rust: re-export qemu macros from common/qom/hwcore
Date: Wed, 27 Aug 2025 14:41:43 +0400
Message-ID: <20250827104147.717203-22-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

This is just a bit nicer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/rust.rst                 | 2 +-
 rust/Cargo.lock                     | 9 +--------
 rust/chardev/Cargo.toml             | 1 -
 rust/chardev/meson.build            | 4 ++--
 rust/chardev/src/chardev.rs         | 2 +-
 rust/common/Cargo.toml              | 1 +
 rust/common/meson.build             | 2 +-
 rust/common/src/lib.rs              | 2 ++
 rust/common/src/opaque.rs           | 4 +---
 rust/hw/char/pl011/Cargo.toml       | 1 -
 rust/hw/char/pl011/meson.build      | 3 +--
 rust/hw/char/pl011/src/device.rs    | 4 ++--
 rust/hw/char/pl011/src/registers.rs | 2 +-
 rust/hw/core/Cargo.toml             | 1 -
 rust/hw/core/meson.build            | 4 ++--
 rust/hw/core/src/irq.rs             | 2 +-
 rust/hw/core/src/qdev.rs            | 4 ++--
 rust/hw/core/src/sysbus.rs          | 2 +-
 rust/hw/core/tests/tests.rs         | 4 ++--
 rust/hw/timer/hpet/Cargo.toml       | 1 -
 rust/hw/timer/hpet/meson.build      | 4 ----
 rust/hw/timer/hpet/src/device.rs    | 6 +++---
 rust/meson.build                    | 3 ++-
 rust/migration/Cargo.toml           | 1 -
 rust/qom/src/lib.rs                 | 2 ++
 rust/qom/src/qom.rs                 | 4 ++--
 rust/system/Cargo.toml              | 1 -
 rust/system/meson.build             | 5 ++---
 rust/system/src/memory.rs           | 2 +-
 rust/tests/Cargo.toml               | 1 -
 rust/util/Cargo.toml                | 1 -
 rust/util/meson.build               | 2 +-
 rust/util/src/timer.rs              | 4 ++--
 33 files changed, 37 insertions(+), 54 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index f52da6f97e..1e77a1c2b1 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -290,7 +290,7 @@ a raw pointer, for use in calls to C functions.  It can be used for
 example as follows::
 
     #[repr(transparent)]
-    #[derive(Debug, qemu_api_macros::Wrapper)]
+    #[derive(Debug, common::Wrapper)]
     pub struct Object(Opaque<bindings::Object>);
 
 where the special ``derive`` macro provides useful methods such as
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index b7e55e0129..8e8ab6fd8c 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -58,7 +58,6 @@ dependencies = [
  "bql",
  "common",
  "migration",
- "qemu_macros",
  "qom",
  "util",
 ]
@@ -68,6 +67,7 @@ name = "common"
 version = "0.1.0"
 dependencies = [
  "libc",
+ "qemu_macros",
 ]
 
 [[package]]
@@ -93,7 +93,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -107,7 +106,6 @@ dependencies = [
  "chardev",
  "common",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -133,7 +131,6 @@ name = "migration"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_macros",
  "util",
 ]
 
@@ -149,7 +146,6 @@ dependencies = [
  "common",
  "hwcore",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -232,7 +228,6 @@ name = "system"
 version = "0.1.0"
 dependencies = [
  "common",
- "qemu_macros",
  "qom",
  "util",
 ]
@@ -249,7 +244,6 @@ dependencies = [
  "hwcore",
  "libc",
  "migration",
- "qemu_macros",
  "qom",
  "system",
  "util",
@@ -269,7 +263,6 @@ dependencies = [
  "common",
  "foreign",
  "libc",
- "qemu_macros",
 ]
 
 [[package]]
diff --git a/rust/chardev/Cargo.toml b/rust/chardev/Cargo.toml
index c139177307..3e77972546 100644
--- a/rust/chardev/Cargo.toml
+++ b/rust/chardev/Cargo.toml
@@ -18,7 +18,6 @@ bql = { path = "../bql" }
 migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 487f36e27d..b0fd415686 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -39,10 +39,10 @@ _chardev_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _chardev_cfg,
-  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_macros, qom_rs, util_rs, chardev],
+  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qom_rs, util_rs, chardev],
 )
 
-chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [qemu_macros, chardev])
+chardev_rs = declare_dependency(link_with: [_chardev_rs], dependencies: [chardev])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
diff --git a/rust/chardev/src/chardev.rs b/rust/chardev/src/chardev.rs
index 0e0a8f5556..07b02bdd76 100644
--- a/rust/chardev/src/chardev.rs
+++ b/rust/chardev/src/chardev.rs
@@ -26,7 +26,7 @@
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
-#[derive(qemu_macros::Wrapper)]
+#[derive(common::Wrapper)]
 pub struct Chardev(Opaque<bindings::Chardev>);
 
 pub type ChardevClass = bindings::ChardevClass;
diff --git a/rust/common/Cargo.toml b/rust/common/Cargo.toml
index 5e106427e8..0e1b4fc505 100644
--- a/rust/common/Cargo.toml
+++ b/rust/common/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 libc.workspace = true
+qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/common/meson.build b/rust/common/meson.build
index 230a967760..b805e0faf5 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -19,7 +19,7 @@ _common_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _common_cfg,
-  dependencies: [libc_rs],
+  dependencies: [libc_rs, qemu_macros],
 )
 
 common_rs = declare_dependency(link_with: [_common_rs])
diff --git a/rust/common/src/lib.rs b/rust/common/src/lib.rs
index 25216503aa..8311bf945d 100644
--- a/rust/common/src/lib.rs
+++ b/rust/common/src/lib.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use qemu_macros::{TryInto, Wrapper};
+
 pub mod assertions;
 
 pub mod bitops;
diff --git a/rust/common/src/opaque.rs b/rust/common/src/opaque.rs
index 06f6b8cd29..ffc749aa0e 100644
--- a/rust/common/src/opaque.rs
+++ b/rust/common/src/opaque.rs
@@ -194,7 +194,7 @@ pub unsafe fn new() -> Self {
 
 /// Annotates [`Self`] as a transparent wrapper for another type.
 ///
-/// Usually defined via the [`qemu_macros::Wrapper`] derive macro.
+/// Usually defined via the [`crate::Wrapper`] derive macro.
 ///
 /// # Examples
 ///
@@ -229,8 +229,6 @@ pub unsafe fn new() -> Self {
 /// ```
 ///
 /// They are not defined here to allow them to be `const`.
-///
-/// [`qemu_macros::Wrapper`]: ../../qemu_macros/derive.Wrapper.html
 pub unsafe trait Wrapper {
     type Wrapped;
 }
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 285d25c217..b2418abc4b 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -24,7 +24,6 @@ qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
-qemu_macros = { path = "../../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index a14993f692..cee6beff87 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -35,7 +35,6 @@ _libpl011_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_macros,
     qom_rs,
     chardev_rs,
     system_rs,
@@ -47,6 +46,6 @@ rust_devices_ss.add(when: 'CONFIG_X_PL011_RUST', if_true: [declare_dependency(
   link_whole: [_libpl011_rs],
   # Putting proc macro crates in `dependencies` is necessary for Meson to find
   # them when compiling the root per-target static rust lib.
-  dependencies: [bilge_impl_rs, qemu_macros],
+  dependencies: [bilge_impl_rs],
   variables: {'crate': 'pl011'},
 )])
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5ce39b002e..c3a729b59f 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -103,7 +103,7 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_macros::Object)]
+#[derive(qom::Object)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
@@ -688,7 +688,7 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 }
 
 #[repr(C)]
-#[derive(qemu_macros::Object)]
+#[derive(qom::Object)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index a1c41347ed..0c3a4d7d21 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -16,7 +16,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug, Eq, PartialEq, qemu_macros::TryInto)]
+#[derive(Debug, Eq, PartialEq, common::TryInto)]
 pub enum RegisterOffset {
     /// Data Register
     ///
diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index 0eb9ffee26..cc7321cfb4 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -20,7 +20,6 @@ chardev = { path = "../../chardev" }
 migration = { path = "../../migration" }
 system = { path = "../../system" }
 util = { path = "../../util" }
-qemu_macros = { path = "../../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 692c4b8e0f..394df40e88 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -62,7 +62,7 @@ _hwcore_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _hwcore_cfg,
-  dependencies: [qemu_macros, common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
+  dependencies: [common_rs, bql_rs, chardev_rs, migration_rs, qemuutil_rs, qom_rs, system_rs, util_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -85,7 +85,7 @@ test('rust-hwcore-rs-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, qemu_macros, util_rs]),
+        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, util_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
index d8d964cad2..e0d7784d97 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -18,7 +18,7 @@
 
 /// An opaque wrapper around [`bindings::IRQState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct IRQState(Opaque<bindings::IRQState>);
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 69d8a7f4c1..ffb88948af 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -23,7 +23,7 @@
 
 /// A safe wrapper around [`bindings::Clock`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct Clock(Opaque<bindings::Clock>);
 
 unsafe impl Send for Clock {}
@@ -31,7 +31,7 @@ unsafe impl Sync for Clock {}
 
 /// A safe wrapper around [`bindings::DeviceState`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct DeviceState(Opaque<bindings::DeviceState>);
 
 unsafe impl Send for DeviceState {}
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 020d650b50..45203229b1 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -19,7 +19,7 @@
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct SysBusDevice(Opaque<bindings::SysBusDevice>);
 
 unsafe impl Send for SysBusDevice {}
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index dff2daae35..53979ead8f 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -22,7 +22,7 @@
 };
 
 #[repr(C)]
-#[derive(qemu_macros::Object)]
+#[derive(qom::Object)]
 pub struct DummyState {
     parent: ParentField<DeviceState>,
     migrate_clock: bool,
@@ -74,7 +74,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 }
 
 #[repr(C)]
-#[derive(qemu_macros::Object)]
+#[derive(qom::Object)]
 pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 08bf97af55..f781b28d8b 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -17,7 +17,6 @@ migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
-qemu_macros = { path = "../../../qemu-macros" }
 hwcore = { path = "../../../hw/core" }
 
 [lints]
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 8ab26630d9..bb64b96672 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -8,7 +8,6 @@ _libhpet_rs = static_library(
     util_rs,
     migration_rs,
     bql_rs,
-    qemu_macros,
     qom_rs,
     system_rs,
     hwcore_rs,
@@ -17,8 +16,5 @@ _libhpet_rs = static_library(
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
   link_whole: [_libhpet_rs],
-  # Putting proc macro crates in `dependencies` is necessary for Meson to find
-  # them when compiling the root per-target static rust lib.
-  dependencies: [qemu_macros],
   variables: {'crate': 'hpet'},
 )])
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 0ada7fcfde..43ee39fbf9 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -97,7 +97,7 @@
 /// Timer N Interrupt Routing Capability (bits 32:63)
 const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
 
-#[derive(qemu_macros::TryInto)]
+#[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Timer registers, masked by 0x18
@@ -110,7 +110,7 @@ enum TimerRegister {
     ROUTE = 16,
 }
 
-#[derive(qemu_macros::TryInto)]
+#[derive(common::TryInto)]
 #[repr(u64)]
 #[allow(non_camel_case_types)]
 /// Global registers
@@ -516,7 +516,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_macros::Object)]
+#[derive(qom::Object)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
diff --git a/rust/meson.build b/rust/meson.build
index 32d569f871..6b50aa39b6 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -22,8 +22,9 @@ qemuutil_rs = qemuutil.partial_dependency(link_args: true, links: true)
 
 genrs = []
 
-subdir('common')
 subdir('qemu-macros')
+
+subdir('common')
 subdir('bits')
 subdir('util')
 subdir('migration')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index 66af81e0a3..708bfaaa68 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,7 +15,6 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../common" }
 util = { path = "../util" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/qom/src/lib.rs b/rust/qom/src/lib.rs
index 35ddc51bb0..007b604d73 100644
--- a/rust/qom/src/lib.rs
+++ b/rust/qom/src/lib.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+pub use qemu_macros::Object;
+
 pub mod bindings;
 
 pub mod prelude;
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index 880bef6c47..06a7f1c3b0 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -112,7 +112,7 @@
 
 /// A safe wrapper around [`bindings::Object`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct Object(Opaque<bindings::Object>);
 
 unsafe impl Send for Object {}
@@ -173,7 +173,7 @@ fn as_ref(&self) -> &$parent {
 ///
 /// ```ignore
 /// #[repr(C)]
-/// #[derive(qemu_macros::Object)]
+/// #[derive(qom::Object)]
 /// pub struct MyDevice {
 ///     parent: ParentField<DeviceState>,
 ///     ...
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index d8338c8348..7fd369b9e3 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -16,7 +16,6 @@ rust-version.workspace = true
 common = { path = "../common" }
 qom = { path = "../qom" }
 util = { path = "../util" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 710462376d..13cf4ed9cb 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -39,12 +39,12 @@ _system_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _system_cfg,
-  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_macros, qom_rs, util_rs,
+  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qom_rs, util_rs,
                 hwcore],
 )
 
 system_rs = declare_dependency(link_with: [_system_rs],
-  dependencies: [qemu_macros, hwcore])
+  dependencies: [hwcore])
 
 # Doctests are essentially integration tests, so they need the same dependencies.
 # Note that running them requires the object files for C code, so place them
@@ -54,4 +54,3 @@ rust.doctest('rust-system-rs-doctests',
      protocol: 'rust',
      dependencies: system_rs,
      suite: ['doc', 'rust'])
-
diff --git a/rust/system/src/memory.rs b/rust/system/src/memory.rs
index 7312f809f5..02aa3af7b1 100644
--- a/rust/system/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -129,7 +129,7 @@ fn default() -> Self {
 
 /// A safe wrapper around [`bindings::MemoryRegion`].
 #[repr(transparent)]
-#[derive(qemu_macros::Wrapper)]
+#[derive(common::Wrapper)]
 pub struct MemoryRegion(Opaque<bindings::MemoryRegion>);
 
 unsafe impl Send for MemoryRegion {}
diff --git a/rust/tests/Cargo.toml b/rust/tests/Cargo.toml
index 079c490363..50d63afa02 100644
--- a/rust/tests/Cargo.toml
+++ b/rust/tests/Cargo.toml
@@ -19,7 +19,6 @@ hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
-qemu_macros = { path = "../qemu-macros" }
 qom = { path = "../qom" }
 system = { path = "../system" }
 anyhow = "~1.0"
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
index c5d1adb8fe..cbc8e5675d 100644
--- a/rust/util/Cargo.toml
+++ b/rust/util/Cargo.toml
@@ -17,7 +17,6 @@ anyhow = "~1.0"
 libc = "0.2.162"
 foreign = "~0.3.1"
 common = { path = "../common" }
-qemu_macros = { path = "../qemu-macros" }
 
 [lints]
 workspace = true
diff --git a/rust/util/meson.build b/rust/util/meson.build
index a7a5bd8d99..c2fbf49d11 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -44,7 +44,7 @@ _util_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _util_cfg,
-  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs, qemu_macros],
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs],
 )
 
 util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil_rs, qom])
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index 42096cef0d..a87d299ebc 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -15,14 +15,14 @@
 
 /// A safe wrapper around [`bindings::QEMUTimer`].
 #[repr(transparent)]
-#[derive(Debug, qemu_macros::Wrapper)]
+#[derive(Debug, common::Wrapper)]
 pub struct Timer(Opaque<bindings::QEMUTimer>);
 
 unsafe impl Send for Timer {}
 unsafe impl Sync for Timer {}
 
 #[repr(transparent)]
-#[derive(qemu_macros::Wrapper)]
+#[derive(common::Wrapper)]
 pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
 
 unsafe impl Send for TimerListGroup {}
-- 
2.50.1


