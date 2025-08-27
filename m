Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F40DCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDcH-00049o-Fk; Wed, 27 Aug 2025 06:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDcC-00048R-Uq
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDc8-00031a-Lv
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnWLsnMdWkvLUAFeFp9vJRXfrMOL4jLsxN8bMejzR/k=;
 b=b2N2l9Ye/ozt+KI3jSrGOZAWfzSZGAmzzMG9nqrDMX9EXv33aNu6YrlOoxjVThjLlN0Dw7
 EQyJXQN9NQJlJp1jvKqBicnJHnxVNr0Lz7GpM+T8T/caHJCGH5xDlRRkfsfms1aN7CKF5P
 5nz3UHd9WFViwsZzL/zxmsSQ2kc4oyM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-xJwzmNoJM2KhpMobgHX4FQ-1; Wed,
 27 Aug 2025 06:42:43 -0400
X-MC-Unique: xJwzmNoJM2KhpMobgHX4FQ-1
X-Mimecast-MFC-AGG-ID: xJwzmNoJM2KhpMobgHX4FQ_1756291362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF4B819560A0; Wed, 27 Aug 2025 10:42:41 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD51218003FC; Wed, 27 Aug 2025 10:42:39 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 06/22] rust: split "util" crate
Date: Wed, 27 Aug 2025 14:41:28 +0400
Message-ID: <20250827104147.717203-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 MAINTAINERS                           |  1 +
 rust/qemu-api/wrapper.h               |  6 ---
 rust/util/wrapper.h                   | 32 ++++++++++++++
 rust/Cargo.lock                       | 14 +++++++
 rust/Cargo.toml                       |  5 +--
 rust/common/src/errno.rs              |  2 +-
 rust/hw/char/pl011/Cargo.toml         |  1 +
 rust/hw/char/pl011/meson.build        |  1 +
 rust/hw/char/pl011/src/device.rs      |  7 ++--
 rust/hw/timer/hpet/Cargo.toml         |  1 +
 rust/hw/timer/hpet/meson.build        |  1 +
 rust/hw/timer/hpet/src/device.rs      |  6 +--
 rust/meson.build                      |  1 +
 rust/qemu-api-macros/src/lib.rs       |  2 +-
 rust/qemu-api-macros/src/tests.rs     |  2 +-
 rust/qemu-api/Cargo.toml              |  1 +
 rust/qemu-api/meson.build             | 11 ++---
 rust/qemu-api/src/bindings.rs         |  1 +
 rust/qemu-api/src/lib.rs              |  6 ---
 rust/qemu-api/src/prelude.rs          |  2 -
 rust/qemu-api/src/qdev.rs             |  4 +-
 rust/qemu-api/src/sysbus.rs           |  2 +-
 rust/qemu-api/src/vmstate.rs          |  2 +-
 rust/qemu-api/tests/tests.rs          |  3 +-
 rust/util/Cargo.toml                  | 23 ++++++++++
 rust/{qemu-api => util}/build.rs      |  0
 rust/util/meson.build                 | 60 +++++++++++++++++++++++++++
 rust/util/src/bindings.rs             | 25 +++++++++++
 rust/{qemu-api => util}/src/error.rs  |  7 ++--
 rust/util/src/lib.rs                  |  9 ++++
 rust/{qemu-api => util}/src/log.rs    | 12 +++---
 rust/{qemu-api => util}/src/module.rs |  2 +-
 rust/{qemu-api => util}/src/timer.rs  |  0
 33 files changed, 201 insertions(+), 51 deletions(-)
 create mode 100644 rust/util/wrapper.h
 create mode 100644 rust/util/Cargo.toml
 rename rust/{qemu-api => util}/build.rs (100%)
 create mode 100644 rust/util/meson.build
 create mode 100644 rust/util/src/bindings.rs
 rename rust/{qemu-api => util}/src/error.rs (98%)
 create mode 100644 rust/util/src/lib.rs
 rename rust/{qemu-api => util}/src/log.rs (93%)
 rename rust/{qemu-api => util}/src/module.rs (97%)
 rename rust/{qemu-api => util}/src/timer.rs (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80c0f80657..22d7847804 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3514,6 +3514,7 @@ F: rust/common/
 F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
+F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
 
 Rust-related patches CC here
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 15a1b19847..cc7112406b 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -48,9 +48,6 @@ typedef enum memory_order {
 #endif /* __CLANG_STDATOMIC_H */
 
 #include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "qemu/log-for-trace.h"
-#include "qemu/module.h"
 #include "qemu-io.h"
 #include "system/system.h"
 #include "hw/sysbus.h"
@@ -61,11 +58,8 @@ typedef enum memory_order {
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
-#include "qapi/error.h"
-#include "qapi/error-internal.h"
 #include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
-#include "qemu/timer.h"
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
new file mode 100644
index 0000000000..b9ed68a01d
--- /dev/null
+++ b/rust/util/wrapper.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/*
+ * This header file is meant to be used as input to the `bindgen` application
+ * in order to generate C FFI compatible Rust bindings.
+ */
+
+#ifndef __CLANG_STDATOMIC_H
+#define __CLANG_STDATOMIC_H
+/*
+ * Fix potential missing stdatomic.h error in case bindgen does not insert the
+ * correct libclang header paths on its own. We do not use stdatomic.h symbols
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
+
+#include "qapi/error.h"
+#include "qapi/error-internal.h"
+#include "qemu/log-for-trace.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index c098301eaa..0a0b2668a5 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -73,6 +73,7 @@ dependencies = [
  "common",
  "qemu_api",
  "qemu_api_macros",
+ "util",
 ]
 
 [[package]]
@@ -100,6 +101,7 @@ dependencies = [
  "common",
  "qemu_api",
  "qemu_api_macros",
+ "util",
 ]
 
 [[package]]
@@ -143,6 +145,7 @@ dependencies = [
  "foreign",
  "libc",
  "qemu_api_macros",
+ "util",
 ]
 
 [[package]]
@@ -180,6 +183,17 @@ version = "1.0.12"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b"
 
+[[package]]
+name = "util"
+version = "0.1.0"
+dependencies = [
+ "anyhow",
+ "common",
+ "foreign",
+ "libc",
+ "qemu_api_macros",
+]
+
 [[package]]
 name = "version_check"
 version = "0.9.4"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 49484913e7..3574c882fc 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -7,6 +7,7 @@ members = [
     "qemu-api",
     "hw/char/pl011",
     "hw/timer/hpet",
+    "util",
 ]
 
 [workspace.package]
@@ -22,9 +23,7 @@ authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 libc = "0.2.162"
 
 [workspace.lints.rust]
-unexpected_cfgs = { level = "deny", check-cfg = [
-    'cfg(MESON)',
-] }
+unexpected_cfgs = { level = "deny", check-cfg = ['cfg(MESON)'] }
 
 # Occasionally, we may need to silence warnings and clippy lints that
 # were only introduced in newer Rust compiler versions.  Do not croak
diff --git a/rust/common/src/errno.rs b/rust/common/src/errno.rs
index b48247b947..a7b23b4092 100644
--- a/rust/common/src/errno.rs
+++ b/rust/common/src/errno.rs
@@ -240,7 +240,7 @@ pub fn into_neg_errno<T: MergeErrno, E: Into<Errno>>(value: Result<T, E>) -> T::
 mod tests {
     use std::io::ErrorKind;
 
-    use common::assert_match;
+    use bindings::assert_match;
 
     use super::*;
 
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 6d15f107df..0cf9943fe8 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -17,6 +17,7 @@ bilge = { version = "0.2.0" }
 bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
 common = { path = "../../../common" }
+util = { path = "../../../util" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 67bd295c3d..41cf46ead1 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -8,6 +8,7 @@ _libpl011_rs = static_library(
     bilge_impl_rs,
     bits_rs,
     common_rs,
+    util_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 0c27c42c31..eb94cf6ba7 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -14,8 +14,6 @@
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
-    log::Log,
-    log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -24,6 +22,7 @@
     vmstate::VMStateDescription,
     vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
 };
+use util::{log::Log, log_mask_ln};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
 
@@ -180,7 +179,7 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_PL011)
     }
-    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for PL011State {
@@ -627,7 +626,7 @@ fn event(&self, event: Event) {
         }
     }
 
-    fn realize(&self) -> qemu_api::Result<()> {
+    fn realize(&self) -> util::Result<()> {
         self.char_backend
             .enable_handlers(self, Self::can_receive, Self::receive, Self::event);
         Ok(())
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index ba7354f07e..dd9a5ed3d4 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -12,6 +12,7 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../../../common" }
+util = { path = "../../../util" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 05f8bd240a..f413893aa5 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -5,6 +5,7 @@ _libhpet_rs = static_library(
   rust_abi: 'rust',
   dependencies: [
     common_rs,
+    util_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index f3c324f243..672c88c46c 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -26,10 +26,10 @@
     qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
     vmstate::VMStateDescription,
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
 };
+use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
 use crate::fw_cfg::HPETFwConfig;
 
@@ -723,7 +723,7 @@ fn post_init(&self) {
         }
     }
 
-    fn realize(&self) -> qemu_api::Result<()> {
+    fn realize(&self) -> util::Result<()> {
         if self.num_timers < HPET_MIN_TIMERS || self.num_timers > HPET_MAX_TIMERS {
             Err(format!(
                 "hpet.num_timers must be between {HPET_MIN_TIMERS} and {HPET_MAX_TIMERS}"
@@ -1039,7 +1039,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_HPET)
     }
 
-    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for HPETState {
diff --git a/rust/meson.build b/rust/meson.build
index 402f8d6600..a9d715e6e9 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -25,6 +25,7 @@ genrs = []
 subdir('common')
 subdir('qemu-api-macros')
 subdir('bits')
+subdir('util')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 850e3b1596..b5f77f06f5 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -91,7 +91,7 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
         ::common::assert_field_type!(#name, #parent,
             ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
 
-        ::qemu_api::module_init! {
+        ::util::module_init! {
             MODULE_INIT_QOM => unsafe {
                 ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
             }
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 42d5fa50bd..52683e46d5 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -63,7 +63,7 @@ struct Foo {
                 _unused,
                 ::qemu_api::qom::ParentField<<Foo as ::qemu_api::qom::ObjectImpl>::ParentType>
             );
-            ::qemu_api::module_init! {
+            ::util::module_init! {
                 MODULE_INIT_QOM => unsafe {
                     ::qemu_api::bindings::type_register_static(&<Foo as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
                 }
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index feb049c608..6d97a8ab05 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../common" }
+util = { path = "../util" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 anyhow = "~1.0"
 libc.workspace = true
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index fe34861a8e..8a2950dfe4 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -14,10 +14,8 @@ c_enums = [
   'MigrationPolicy',
   'MigrationPriority',
   'QEMUChrEvent',
-  'QEMUClockType',
   'ResetType',
   'device_endian',
-  'module_init_type',
 ]
 _qemu_api_bindgen_args = []
 foreach enum : c_enums
@@ -31,6 +29,7 @@ foreach enum : c_bitfields
   _qemu_api_bindgen_args += ['--bitfield-enum', enum]
 endforeach
 
+_qemu_api_bindgen_args += ['--blocklist-type', 'Error']
 # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
 #
 # Rust bindings generation with `bindgen` might fail in some cases where the
@@ -55,16 +54,12 @@ _qemu_api_rs = static_library(
       'src/bindings.rs',
       'src/cell.rs',
       'src/chardev.rs',
-      'src/error.rs',
       'src/irq.rs',
-      'src/log.rs',
       'src/memory.rs',
-      'src/module.rs',
       'src/prelude.rs',
       'src/qdev.rs',
       'src/qom.rs',
       'src/sysbus.rs',
-      'src/timer.rs',
       'src/vmstate.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
@@ -72,7 +67,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs,
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -98,7 +93,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, qemu_api]),
+        dependencies: [common_rs, util_rs, qemu_api]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 3acdd903b5..aedf42b652 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,6 +21,7 @@
 //! `bindgen`-generated declarations.
 
 use common::Zeroable;
+use util::bindings::Error;
 
 #[cfg(MESON)]
 include!("bindings.inc.rs");
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index a256eeb44e..db81841a8f 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -15,15 +15,9 @@
 
 pub mod cell;
 pub mod chardev;
-pub mod error;
 pub mod irq;
-pub mod log;
 pub mod memory;
-pub mod module;
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
-pub mod timer;
 pub mod vmstate;
-
-pub use error::{Error, Result};
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index dcfe71497f..3d771481e4 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -7,8 +7,6 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
-pub use crate::log_mask_ln;
-
 pub use crate::qdev::DeviceMethods;
 
 pub use crate::qom::InterfaceType;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index bf17558cdb..02e9d55e6a 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -11,12 +11,12 @@
 
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use common::{callbacks::FnCall, Opaque};
+pub use util::{Error, Result};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     cell::bql_locked,
     chardev::Chardev,
-    error::{Error, Result},
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
@@ -135,7 +135,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
     dev: *mut bindings::DeviceState,
-    errp: *mut *mut bindings::Error,
+    errp: *mut *mut util::bindings::Error,
 ) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
     let result = T::REALIZE.unwrap()(unsafe { state.as_ref() });
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 4a5b4cbbf6..2dbfc31dbd 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -114,7 +114,7 @@ fn sysbus_realize(&self) {
         unsafe {
             bindings::sysbus_realize(
                 self.upcast().as_mut_ptr(),
-                addr_of_mut!(bindings::error_fatal),
+                addr_of_mut!(util::bindings::error_fatal),
             );
         }
     }
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 6a9cc0b975..4e2b7e2db0 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -390,7 +390,7 @@ unsafe impl VMState for $type {
 impl_vmstate_scalar!(vmstate_info_uint16, u16, VMS_VARRAY_UINT16);
 impl_vmstate_scalar!(vmstate_info_uint32, u32, VMS_VARRAY_UINT32);
 impl_vmstate_scalar!(vmstate_info_uint64, u64);
-impl_vmstate_scalar!(vmstate_info_timer, crate::timer::Timer);
+impl_vmstate_scalar!(vmstate_info_timer, util::timer::Timer);
 
 // Pointer types using the underlying type's VMState plus VMS_POINTER
 // Note that references are not supported, though references to cells
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 2594e5465d..1dd4e29754 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -6,7 +6,7 @@
 
 use common::Zeroable;
 use qemu_api::{
-    bindings::{module_call_init, module_init_type, qdev_prop_bool},
+    bindings::qdev_prop_bool,
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
@@ -15,6 +15,7 @@
     sysbus::SysBusDevice,
     vmstate::VMStateDescription,
 };
+use util::bindings::{module_call_init, module_init_type};
 
 mod vmstate_tests;
 
diff --git a/rust/util/Cargo.toml b/rust/util/Cargo.toml
new file mode 100644
index 0000000000..aa10f03384
--- /dev/null
+++ b/rust/util/Cargo.toml
@@ -0,0 +1,23 @@
+[package]
+name = "util"
+version = "0.1.0"
+description = "Rust bindings for QEMU/util"
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
+anyhow = "~1.0"
+libc = "0.2.162"
+foreign = "~0.3.1"
+common = { path = "../common" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/qemu-api/build.rs b/rust/util/build.rs
similarity index 100%
rename from rust/qemu-api/build.rs
rename to rust/util/build.rs
diff --git a/rust/util/meson.build b/rust/util/meson.build
new file mode 100644
index 0000000000..8f3ebf5415
--- /dev/null
+++ b/rust/util/meson.build
@@ -0,0 +1,60 @@
+_util_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+_util_bindgen_args = []
+c_enums = [
+  'module_init_type',
+  'QEMUClockType',
+]
+foreach enum : c_enums
+  _util_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+#
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_util_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _util_bindgen_args,
+)
+
+_util_rs = static_library(
+  'util',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/error.rs',
+      'src/log.rs',
+      'src/module.rs',
+      'src/timer.rs',
+    ],
+    {'.': _util_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _util_cfg,
+  dependencies: [anyhow_rs, libc_rs, foreign_rs, qemuutil_rs, common_rs, qemu_api_macros],
+)
+
+util_rs = declare_dependency(link_with: [_util_rs], dependencies: [qemuutil_rs, qom])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-util-rs-doctests',
+     _util_rs,
+     protocol: 'rust',
+     dependencies: util_rs,
+     suite: ['doc', 'rust']
+)
diff --git a/rust/util/src/bindings.rs b/rust/util/src/bindings.rs
new file mode 100644
index 0000000000..9ffff12cde
--- /dev/null
+++ b/rust/util/src/bindings.rs
@@ -0,0 +1,25 @@
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
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
diff --git a/rust/qemu-api/src/error.rs b/rust/util/src/error.rs
similarity index 98%
rename from rust/qemu-api/src/error.rs
rename to rust/util/src/error.rs
index 8bac3cbec8..a1b11a97ca 100644
--- a/rust/qemu-api/src/error.rs
+++ b/rust/util/src/error.rs
@@ -19,7 +19,7 @@
 //!
 //! This module is most commonly used at the boundary between C and Rust code;
 //! other code will usually access it through the
-//! [`qemu_api::Result`](crate::Result) type alias, and will use the
+//! [`utils::Result`](crate::Result) type alias, and will use the
 //! [`std::error::Error`] interface to let C errors participate in Rust's error
 //! handling functionality.
 //!
@@ -30,7 +30,7 @@
 //! type up to C code, or from a combination of the two.
 //!
 //! The third case, corresponding to [`Error::with_error`], is the only one that
-//! requires mentioning [`qemu_api::Error`](crate::Error) explicitly.  Similar
+//! requires mentioning [`utils::Error`](crate::Error) explicitly.  Similar
 //! to how QEMU's C code handles errno values, the string and the
 //! `anyhow::Error` object will be concatenated with `:` as the separator.
 
@@ -316,11 +316,10 @@ mod tests {
     use std::ffi::CStr;
 
     use anyhow::anyhow;
-    use common::assert_match;
+    use bindings::assert_match;
     use foreign::OwnedPointer;
 
     use super::*;
-    use crate::bindings;
 
     #[track_caller]
     fn error_for_test(msg: &CStr) -> OwnedPointer<Error> {
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
new file mode 100644
index 0000000000..16c89b9517
--- /dev/null
+++ b/rust/util/src/lib.rs
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+pub mod error;
+pub mod log;
+pub mod module;
+pub mod timer;
+
+pub use error::{Error, Result};
diff --git a/rust/qemu-api/src/log.rs b/rust/util/src/log.rs
similarity index 93%
rename from rust/qemu-api/src/log.rs
rename to rust/util/src/log.rs
index d07f6272dc..af9a3e9123 100644
--- a/rust/qemu-api/src/log.rs
+++ b/rust/util/src/log.rs
@@ -49,7 +49,7 @@ impl LogGuard {
     /// # Examples
     ///
     /// ```
-    /// # use qemu_api::log::LogGuard;
+    /// # use util::log::LogGuard;
     /// # use std::io::Write;
     /// if let Some(mut log) = LogGuard::new() {
     ///     writeln!(log, "test");
@@ -116,7 +116,7 @@ fn drop(&mut self) {
 /// # Example
 ///
 /// ```
-/// use qemu_api::{log::Log, log_mask_ln};
+/// use util::{log::Log, log_mask_ln};
 ///
 /// let error_address = 0xbad;
 /// log_mask_ln!(Log::GuestError, "Address 0x{error_address:x} out of range");
@@ -126,7 +126,7 @@ fn drop(&mut self) {
 /// trailing `,`:
 ///
 /// ```
-/// use qemu_api::{log::Log, log_mask_ln};
+/// use util::{log::Log, log_mask_ln};
 ///
 /// let error_address = 0xbad;
 /// log_mask_ln!(
@@ -139,12 +139,12 @@ fn drop(&mut self) {
 macro_rules! log_mask_ln {
     ($mask:expr, $fmt:tt $($args:tt)*) => {{
         // Type assertion to enforce type `Log` for $mask
-        let _: Log = $mask;
+        let _: $crate::log::Log = $mask;
 
         if unsafe {
-            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+            ($crate::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
         } {
-            _ = ::qemu_api::log::LogGuard::log_fmt(
+            _ = $crate::log::LogGuard::log_fmt(
                 format_args!("{}\n", format_args!($fmt $($args)*)));
         }
     }};
diff --git a/rust/qemu-api/src/module.rs b/rust/util/src/module.rs
similarity index 97%
rename from rust/qemu-api/src/module.rs
rename to rust/util/src/module.rs
index fa5cea3598..06c45fc142 100644
--- a/rust/qemu-api/src/module.rs
+++ b/rust/util/src/module.rs
@@ -36,7 +36,7 @@ extern "C" fn ctor_fn() {
 
     // shortcut because it's quite common that $body needs unsafe {}
     ($type:ident => unsafe $body:block) => {
-        $crate::module_init! {
+        ::util::module_init! {
             $type => { unsafe { $body } }
         }
     };
diff --git a/rust/qemu-api/src/timer.rs b/rust/util/src/timer.rs
similarity index 100%
rename from rust/qemu-api/src/timer.rs
rename to rust/util/src/timer.rs
-- 
2.50.1


