Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695F7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:49:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDcp-0004j5-7z; Wed, 27 Aug 2025 06:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDcl-0004fM-S8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:43:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1urDcd-00036h-J8
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756291396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJ2blqP3vLUJERqrxsPZudtvDlc2mIPn0vRjd+gge68=;
 b=Vfkzgz6hl5Lg3+3vao1LnsiE1liL7rpOqhZGxRt39thTORlf/84DXsLHUxNJ1xEAYavvaL
 K36cOpumjzI/nTKbogucDkRC5nVdBPpTxEdGZ0Fc4+tsEE0W5xdKwV2o6c+NkbxIPtTJJ6
 CU0qYUqOwLwtqoEPyeJpIGDHXwlWsF4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-JbhDoP4PNbixRqMHW5MGRQ-1; Wed,
 27 Aug 2025 06:43:13 -0400
X-MC-Unique: JbhDoP4PNbixRqMHW5MGRQ-1
X-Mimecast-MFC-AGG-ID: JbhDoP4PNbixRqMHW5MGRQ_1756291392
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 408AC19560B1; Wed, 27 Aug 2025 10:43:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0F4B30001A5; Wed, 27 Aug 2025 10:43:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 10/22] rust: split "migration" crate
Date: Wed, 27 Aug 2025 14:41:32 +0400
Message-ID: <20250827104147.717203-11-marcandre.lureau@redhat.com>
In-Reply-To: <20250827104147.717203-1-marcandre.lureau@redhat.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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
 MAINTAINERS                                 |   1 +
 rust/migration/wrapper.h                    |  51 ++++++++++
 rust/qemu-api/wrapper.h                     |   1 -
 rust/Cargo.lock                             |  12 +++
 rust/Cargo.toml                             |   1 +
 rust/hw/char/pl011/Cargo.toml               |   1 +
 rust/hw/char/pl011/meson.build              |   1 +
 rust/hw/char/pl011/src/device.rs            |   8 +-
 rust/hw/char/pl011/src/registers.rs         |   2 +-
 rust/hw/timer/hpet/Cargo.toml               |   1 +
 rust/hw/timer/hpet/meson.build              |   1 +
 rust/hw/timer/hpet/src/device.rs            |   8 +-
 rust/meson.build                            |   1 +
 rust/migration/Cargo.toml                   |  21 ++++
 rust/migration/build.rs                     |   1 +
 rust/migration/meson.build                  |  57 +++++++++++
 rust/migration/src/bindings.rs              |  48 +++++++++
 rust/migration/src/lib.rs                   |   6 ++
 rust/{qemu-api => migration}/src/vmstate.rs | 104 +++++++++++---------
 rust/qemu-api/Cargo.toml                    |   1 +
 rust/qemu-api/meson.build                   |  10 +-
 rust/qemu-api/src/bindings.rs               |  21 +---
 rust/qemu-api/src/cell.rs                   |   4 +-
 rust/qemu-api/src/lib.rs                    |   1 -
 rust/qemu-api/src/prelude.rs                |   2 -
 rust/qemu-api/src/qdev.rs                   |  10 +-
 rust/qemu-api/src/qom.rs                    |   2 +-
 rust/qemu-api/tests/tests.rs                |   2 +-
 rust/qemu-api/tests/vmstate_tests.rs        |  16 +--
 29 files changed, 298 insertions(+), 97 deletions(-)
 create mode 100644 rust/migration/wrapper.h
 create mode 100644 rust/migration/Cargo.toml
 create mode 120000 rust/migration/build.rs
 create mode 100644 rust/migration/meson.build
 create mode 100644 rust/migration/src/bindings.rs
 create mode 100644 rust/migration/src/lib.rs
 rename rust/{qemu-api => migration}/src/vmstate.rs (86%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22d7847804..bb4f5f011f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3511,6 +3511,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/common/
+F: rust/migration/
 F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
diff --git a/rust/migration/wrapper.h b/rust/migration/wrapper.h
new file mode 100644
index 0000000000..daf316aed4
--- /dev/null
+++ b/rust/migration/wrapper.h
@@ -0,0 +1,51 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * Authors: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
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
+#include "migration/vmstate.h"
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index cc7112406b..b99df9f568 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -58,7 +58,6 @@ typedef enum memory_order {
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
-#include "migration/vmstate.h"
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
 #include "system/address-spaces.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 0a0b2668a5..b3a810a653 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -71,6 +71,7 @@ name = "hpet"
 version = "0.1.0"
 dependencies = [
  "common",
+ "migration",
  "qemu_api",
  "qemu_api_macros",
  "util",
@@ -91,6 +92,15 @@ version = "0.2.162"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398"
 
+[[package]]
+name = "migration"
+version = "0.1.0"
+dependencies = [
+ "common",
+ "qemu_api_macros",
+ "util",
+]
+
 [[package]]
 name = "pl011"
 version = "0.1.0"
@@ -99,6 +109,7 @@ dependencies = [
  "bilge-impl",
  "bits",
  "common",
+ "migration",
  "qemu_api",
  "qemu_api_macros",
  "util",
@@ -144,6 +155,7 @@ dependencies = [
  "common",
  "foreign",
  "libc",
+ "migration",
  "qemu_api_macros",
  "util",
 ]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 3574c882fc..0640a21580 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -3,6 +3,7 @@ resolver = "2"
 members = [
     "bits",
     "common",
+    "migration",
     "qemu-api-macros",
     "qemu-api",
     "hw/char/pl011",
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 0cf9943fe8..7fd7531823 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -18,6 +18,7 @@ bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
 common = { path = "../../../common" }
 util = { path = "../../../util" }
+migration = { path = "../../../migration" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 41cf46ead1..e3ddd17351 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -9,6 +9,7 @@ _libpl011_rs = static_library(
     bits_rs,
     common_rs,
     util_rs,
+    migration_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index eb94cf6ba7..904faa80a9 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,18 +9,20 @@
 };
 
 use common::{static_assert, uninit_field_mut, Zeroable};
+use migration::{
+    impl_vmstate_forward, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections,
+    vmstate_unused, VMStateDescription,
+};
 use qemu_api::{
     bindings::{qdev_prop_bool, qdev_prop_chr},
     chardev::{CharBackend, Chardev, Event},
-    impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, Owned, ParentField, ParentInit},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    vmstate::VMStateDescription,
-    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
+    vmstate_clock,
 };
 use util::{log::Log, log_mask_ln};
 
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 7ececd39f8..2bfbd81095 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -10,7 +10,7 @@
 
 use bilge::prelude::*;
 use bits::bits;
-use qemu_api::{impl_vmstate_bitsized, impl_vmstate_forward};
+use migration::{impl_vmstate_bitsized, impl_vmstate_forward};
 
 /// Offset of each register from the base memory address of the device.
 #[doc(alias = "offset")]
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index dd9a5ed3d4..70acdf03d6 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -13,6 +13,7 @@ rust-version.workspace = true
 [dependencies]
 common = { path = "../../../common" }
 util = { path = "../../../util" }
+migration = { path = "../../../migration" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index f413893aa5..2c605dcf9d 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -6,6 +6,7 @@ _libhpet_rs = static_library(
   dependencies: [
     common_rs,
     util_rs,
+    migration_rs,
     qemu_api,
     qemu_api_macros,
   ],
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 672c88c46c..35b968cca7 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -11,6 +11,10 @@
 };
 
 use common::{bitops::IntegerExt, uninit_field_mut, Zeroable};
+use migration::{
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
+    VMStateDescription, VMStateFieldHelper,
+};
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
@@ -26,8 +30,6 @@
     qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    vmstate::VMStateDescription,
-    vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
 };
 use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
@@ -1021,7 +1023,7 @@ impl ObjectImpl for HPETState {
         vmstate_of!(HPETState, counter),
         vmstate_of!(HPETState, num_timers_save),
         vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
-        vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+        VMStateFieldHelper(vmstate_struct!(HPETState, timers[0 .. num_timers_save], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers)).with_version_id(0).0,
     },
     subsections: vmstate_subsections! {
         VMSTATE_HPET_RTC_IRQ_LEVEL,
diff --git a/rust/meson.build b/rust/meson.build
index a9d715e6e9..826949b2e6 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -26,6 +26,7 @@ subdir('common')
 subdir('qemu-api-macros')
 subdir('bits')
 subdir('util')
+subdir('migration')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
new file mode 100644
index 0000000000..98e6df2109
--- /dev/null
+++ b/rust/migration/Cargo.toml
@@ -0,0 +1,21 @@
+[package]
+name = "migration"
+version = "0.1.0"
+description = "Rust bindings for QEMU/migration"
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
+common = { path = "../common" }
+util = { path = "../util" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/migration/build.rs b/rust/migration/build.rs
new file mode 120000
index 0000000000..71a3167885
--- /dev/null
+++ b/rust/migration/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
new file mode 100644
index 0000000000..d6d6a7c98e
--- /dev/null
+++ b/rust/migration/meson.build
@@ -0,0 +1,57 @@
+_migration_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+_migration_bindgen_args = []
+c_bitfields = [
+  'MigrationPolicy',
+  'MigrationPriority',
+  'VMStateFlags',
+]
+foreach enum : c_bitfields
+  _migration_bindgen_args += ['--bitfield-enum', enum]
+endforeach
+#
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_migration_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _migration_bindgen_args,
+  )
+
+_migration_rs = static_library(
+  'migration',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/vmstate.rs',
+    ],
+    {'.' : _migration_bindings_inc_rs},
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _migration_cfg,
+  dependencies: [qemuutil_rs, common_rs, util_rs, migration],
+)
+
+migration_rs = declare_dependency(link_with: [_migration_rs],
+  dependencies: [migration])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-migration-rs-doctests',
+     _migration_rs,
+     protocol: 'rust',
+     dependencies: migration_rs,
+     suite: ['doc', 'rust'])
diff --git a/rust/migration/src/bindings.rs b/rust/migration/src/bindings.rs
new file mode 100644
index 0000000000..8ce13a9000
--- /dev/null
+++ b/rust/migration/src/bindings.rs
@@ -0,0 +1,48 @@
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
+use common::Zeroable;
+
+#[cfg(MESON)]
+include!("bindings.inc.rs");
+
+#[cfg(not(MESON))]
+include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
+
+unsafe impl Send for VMStateDescription {}
+unsafe impl Sync for VMStateDescription {}
+
+unsafe impl Send for VMStateField {}
+unsafe impl Sync for VMStateField {}
+
+unsafe impl Send for VMStateInfo {}
+unsafe impl Sync for VMStateInfo {}
+
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
+
+unsafe impl Zeroable for VMStateFlags {}
+unsafe impl Zeroable for VMStateField {}
+unsafe impl Zeroable for VMStateDescription {}
diff --git a/rust/migration/src/lib.rs b/rust/migration/src/lib.rs
new file mode 100644
index 0000000000..5f51dde440
--- /dev/null
+++ b/rust/migration/src/lib.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+
+pub mod vmstate;
+pub use vmstate::*;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/migration/src/vmstate.rs
similarity index 86%
rename from rust/qemu-api/src/vmstate.rs
rename to rust/migration/src/vmstate.rs
index 9d33997c57..4f95ab0d49 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -27,7 +27,7 @@
 use core::{marker::PhantomData, mem, ptr::NonNull};
 use std::ffi::{c_int, c_void};
 
-use common::{callbacks::FnCall, Zeroable};
+use common::callbacks::FnCall;
 
 pub use crate::bindings::{VMStateDescription, VMStateField, VMStateFlags};
 
@@ -39,7 +39,7 @@
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::call_func_with_field;
+/// # use migration::call_func_with_field;
 /// # use core::marker::PhantomData;
 /// const fn size_of_field<T>(_: PhantomData<T>) -> usize {
 ///     std::mem::size_of::<T>()
@@ -197,6 +197,10 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// for them.  The macros
 /// [`impl_vmstate_bitsized!`](crate::impl_vmstate_bitsized)
 /// and [`impl_vmstate_forward!`](crate::impl_vmstate_forward) help with this.
+///
+/// [`BqlCell`]: ../../qemu_api/cell/struct.BqlCell.html
+/// [`BqlRefCell`]: ../../qemu_api/cell/struct.BqlRefCell.html
+/// [`Owned`]: ../../qemu_api/qom/struct.Owned.html
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
@@ -214,20 +218,25 @@ macro_rules! vmstate_of {
                 $struct_name,
                 $field_name
             )),
-            ..$crate::call_func_with_field!(
+            ..$crate::vmstate::VMStateFieldHelper($crate::call_func_with_field!(
                 $crate::vmstate::vmstate_base,
                 $struct_name,
                 $field_name
-            )$(.with_varray_flag($crate::call_func_with_field!(
+            ))$(.with_varray_flag($crate::call_func_with_field!(
                     $crate::vmstate::vmstate_varray_flag,
                     $struct_name,
                     $num))
                $(.with_varray_multiply($factor))?)?
+            .0
         }
     };
 }
 
-impl VMStateFlags {
+pub trait VMStateFlagsExt {
+    const VMS_VARRAY_FLAGS: VMStateFlags;
+}
+
+impl VMStateFlagsExt for VMStateFlags {
     const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
         VMStateFlags::VMS_VARRAY_INT32.0
             | VMStateFlags::VMS_VARRAY_UINT8.0
@@ -236,62 +245,66 @@ impl VMStateFlags {
     );
 }
 
+// using extension traits would be nicer, unfortunately it doesn't allow const
+// fn yet
+pub struct VMStateFieldHelper(pub VMStateField);
+
 // Add a couple builder-style methods to VMStateField, allowing
 // easy derivation of VMStateField constants from other types.
-impl VMStateField {
+impl VMStateFieldHelper {
     #[must_use]
     pub const fn with_version_id(mut self, version_id: i32) -> Self {
         assert!(version_id >= 0);
-        self.version_id = version_id;
+        self.0.version_id = version_id;
         self
     }
 
     #[must_use]
     pub const fn with_array_flag(mut self, num: usize) -> Self {
         assert!(num <= 0x7FFF_FFFFusize);
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
-        assert!((self.flags.0 & VMStateFlags::VMS_VARRAY_FLAGS.0) == 0);
-        if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
-            self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
-            self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
+        assert!((self.0.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
+        assert!((self.0.flags.0 & VMStateFlags::VMS_VARRAY_FLAGS.0) == 0);
+        if (self.0.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
+            self.0.flags = VMStateFlags(self.0.flags.0 & !VMStateFlags::VMS_POINTER.0);
+            self.0.flags = VMStateFlags(self.0.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
             // VMS_ARRAY_OF_POINTER flag stores the size of pointer.
             // FIXME: *const, *mut, NonNull and Box<> have the same size as usize.
             //        Resize if more smart pointers are supported.
-            self.size = std::mem::size_of::<usize>();
+            self.0.size = std::mem::size_of::<usize>();
         }
-        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
-        self.num = num as i32;
+        self.0.flags = VMStateFlags(self.0.flags.0 & !VMStateFlags::VMS_SINGLE.0);
+        self.0.flags = VMStateFlags(self.0.flags.0 | VMStateFlags::VMS_ARRAY.0);
+        self.0.num = num as i32;
         self
     }
 
     #[must_use]
     pub const fn with_pointer_flag(mut self) -> Self {
-        assert!((self.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
+        assert!((self.0.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);
+        self.0.flags = VMStateFlags(self.0.flags.0 | VMStateFlags::VMS_POINTER.0);
         self
     }
 
     #[must_use]
-    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> VMStateField {
-        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
-        self.flags = VMStateFlags(self.flags.0 | flag.0);
-        self.num = 0; // varray uses num_offset instead of num.
+    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> Self {
+        self.0.flags = VMStateFlags(self.0.flags.0 & !VMStateFlags::VMS_ARRAY.0);
+        self.0.flags = VMStateFlags(self.0.flags.0 | flag.0);
+        self.0.num = 0; // varray uses num_offset instead of num.
         self
     }
 
     #[must_use]
     #[allow(unused_mut)]
-    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
-        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
+        assert!((self.0.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.with_varray_flag_unchecked(flag)
     }
 
     #[must_use]
-    pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
+    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
         assert!(num <= 0x7FFF_FFFFu32);
-        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
-        self.num = num as i32;
+        self.0.flags = VMStateFlags(self.0.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
+        self.0.num = num as i32;
         self
     }
 }
@@ -303,7 +316,7 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::impl_vmstate_forward;
+/// # use migration::impl_vmstate_forward;
 /// pub struct Fifo([u8; 16]);
 /// impl_vmstate_forward!(Fifo);
 /// ```
@@ -341,7 +354,7 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-impl_vmstate_transparent!(::common::Opaque<T> where T: VMState);
+impl_vmstate_transparent!(common::Opaque<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
@@ -367,12 +380,12 @@ unsafe impl $crate::vmstate::VMState for $type {
 
 macro_rules! impl_vmstate_scalar {
     ($info:ident, $type:ty$(, $varray_flag:ident)?) => {
-        unsafe impl VMState for $type {
-            const SCALAR_TYPE: VMStateFieldType = VMStateFieldType::$info;
-            const BASE: VMStateField = VMStateField {
-                size: mem::size_of::<$type>(),
-                flags: VMStateFlags::VMS_SINGLE,
-                ..Zeroable::ZERO
+        unsafe impl $crate::vmstate::VMState for $type {
+            const SCALAR_TYPE: $crate::vmstate::VMStateFieldType = $crate::vmstate::VMStateFieldType::$info;
+            const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
+                size: ::std::mem::size_of::<$type>(),
+                flags: $crate::vmstate::VMStateFlags::VMS_SINGLE,
+                ..::common::zeroable::Zeroable::ZERO
             };
             $(const VARRAY_FLAG: VMStateFlags = VMStateFlags::$varray_flag;)?
         }
@@ -399,7 +412,7 @@ macro_rules! impl_vmstate_pointer {
     ($type:ty where $base:tt: VMState $($where:tt)*) => {
         unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
             const SCALAR_TYPE: $crate::vmstate::VMStateFieldType = <T as $crate::vmstate::VMState>::SCALAR_TYPE;
-            const BASE: $crate::vmstate::VMStateField = <$base as $crate::vmstate::VMState>::BASE.with_pointer_flag();
+            const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateFieldHelper(<$base as $crate::vmstate::VMState>::BASE).with_pointer_flag().0;
         }
     };
 }
@@ -417,7 +430,9 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
 
 unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
     const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
-    const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
+    const BASE: VMStateField = VMStateFieldHelper(<T as VMState>::BASE)
+        .with_array_flag(N)
+        .0;
 }
 
 #[doc(alias = "VMSTATE_UNUSED")]
@@ -429,7 +444,7 @@ macro_rules! vmstate_unused {
             size: $size,
             info: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_info_unused_buffer) },
             flags: $crate::bindings::VMStateFlags::VMS_BUFFER,
-            ..::common::zeroable::Zeroable::ZERO
+            ..::common::Zeroable::ZERO
         }
     }};
 }
@@ -452,7 +467,7 @@ pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), b
 #[macro_export]
 macro_rules! vmstate_exist_fn {
     ($struct_name:ty, $test_fn:expr) => {{
-        const fn test_cb_builder__<T, F: for<'a> ::common::callbacks::FnCall<(&'a T, u8), bool>>(
+        const fn test_cb_builder__<T, F: for<'a> ::common::FnCall<(&'a T, u8), bool>>(
             _phantom: ::core::marker::PhantomData<F>,
         ) -> $crate::vmstate::VMSFieldExistCb {
             let _: () = F::ASSERT_IS_SOME;
@@ -477,7 +492,7 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
 #[macro_export]
 macro_rules! vmstate_struct {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?, $vmsd:expr, $type:ty $(, $test_fn:expr)? $(,)?) => {
-        $crate::bindings::VMStateField {
+        $crate::vmstate::VMStateFieldHelper($crate::bindings::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
@@ -490,8 +505,8 @@ macro_rules! vmstate_struct {
             flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
             vmsd: $vmsd,
             $(field_exists: $crate::vmstate_exist_fn!($struct_name, $test_fn),)?
-            ..::common::zeroable::Zeroable::ZERO
-         } $(.with_varray_flag_unchecked(
+            ..::common::Zeroable::ZERO
+         }) $(.with_varray_flag_unchecked(
                   $crate::call_func_with_field!(
                       $crate::vmstate::vmstate_varray_flag,
                       $struct_name,
@@ -499,6 +514,7 @@ macro_rules! vmstate_struct {
                   )
               )
            $(.with_varray_multiply($factor))?)?
+         .0
     };
 }
 
@@ -512,7 +528,7 @@ macro_rules! vmstate_fields {
             $($field),*,
             $crate::bindings::VMStateField {
                 flags: $crate::bindings::VMStateFlags::VMS_END,
-                ..::common::zeroable::Zeroable::ZERO
+                ..::common::Zeroable::ZERO
             }
         ];
         _FIELDS.as_ptr()
@@ -531,7 +547,7 @@ macro_rules! vmstate_validate {
                     | $crate::bindings::VMStateFlags::VMS_ARRAY.0,
             ),
             num: 0, // 0 elements: no data, only run test_fn callback
-            ..::common::zeroable::Zeroable::ZERO
+            ..common::Zeroable::ZERO
         }
     };
 }
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 6d97a8ab05..4e44737843 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../common" }
+migration = { path = "../migration" }
 util = { path = "../util" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 anyhow = "~1.0"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 8a2950dfe4..ee6311cd3f 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -11,8 +11,6 @@ c_enums = [
   'GpioPolarity',
   'MachineInitPhase',
   'MemoryDeviceInfoKind',
-  'MigrationPolicy',
-  'MigrationPriority',
   'QEMUChrEvent',
   'ResetType',
   'device_endian',
@@ -23,12 +21,13 @@ foreach enum : c_enums
 endforeach
 c_bitfields = [
   'ClockEvent',
-  'VMStateFlags',
 ]
 foreach enum : c_bitfields
   _qemu_api_bindgen_args += ['--bitfield-enum', enum]
 endforeach
 
+_qemu_api_bindgen_args += ['--blocklist-type', 'VMStateDescription']
+
 _qemu_api_bindgen_args += ['--blocklist-type', 'Error']
 # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
 #
@@ -60,14 +59,13 @@ _qemu_api_rs = static_library(
       'src/qdev.rs',
       'src/qom.rs',
       'src/sysbus.rs',
-      'src/vmstate.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs,
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -93,7 +91,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, util_rs, qemu_api]),
+        dependencies: [common_rs, util_rs, migration_rs, qemu_api]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index aedf42b652..ce00a6e0e4 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,6 +21,7 @@
 //! `bindgen`-generated declarations.
 
 use common::Zeroable;
+use migration::bindings::VMStateDescription;
 use util::bindings::Error;
 
 #[cfg(MESON)]
@@ -51,28 +52,8 @@ unsafe impl Sync for Property {}
 unsafe impl Send for TypeInfo {}
 unsafe impl Sync for TypeInfo {}
 
-unsafe impl Send for VMStateDescription {}
-unsafe impl Sync for VMStateDescription {}
-
-unsafe impl Send for VMStateField {}
-unsafe impl Sync for VMStateField {}
-
-unsafe impl Send for VMStateInfo {}
-unsafe impl Sync for VMStateInfo {}
-
-// bindgen does not derive Default here
-#[allow(clippy::derivable_impls)]
-impl Default for crate::bindings::VMStateFlags {
-    fn default() -> Self {
-        Self(0)
-    }
-}
-
 unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
 unsafe impl Zeroable for crate::bindings::Property {}
-unsafe impl Zeroable for crate::bindings::VMStateFlags {}
-unsafe impl Zeroable for crate::bindings::VMStateField {}
-unsafe impl Zeroable for crate::bindings::VMStateDescription {}
 unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
 unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
 unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 4bce526e45..70cee2ca7a 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -152,7 +152,9 @@
     ptr::NonNull,
 };
 
-use crate::{bindings, impl_vmstate_transparent};
+use migration::impl_vmstate_transparent;
+
+use crate::bindings;
 
 /// An internal function that is used by doctests.
 pub fn bql_start_test() {
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index db81841a8f..52e4d5889b 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -20,4 +20,3 @@
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
-pub mod vmstate;
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 3d771481e4..c10c171158 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -21,5 +21,3 @@
 pub use crate::qom_isa;
 
 pub use crate::sysbus::SysBusDeviceMethods;
-
-pub use crate::vmstate::VMState;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 5469eef22a..15e1fdff96 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -11,6 +11,7 @@
 
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use common::{callbacks::FnCall, Opaque};
+use migration::vmstate::VMStateDescription;
 pub use util::{Error, Result};
 
 use crate::{
@@ -20,7 +21,6 @@
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
-    vmstate::VMStateDescription,
 };
 
 /// A safe wrapper around [`bindings::Clock`].
@@ -413,7 +413,7 @@ unsafe impl ObjectType for Clock {
 #[macro_export]
 macro_rules! vmstate_clock {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])?) => {{
-        $crate::bindings::VMStateField {
+        ::migration::VMStateField {
             name: ::core::concat!(::core::stringify!($field_name), "\0")
                 .as_bytes()
                 .as_ptr() as *const ::std::os::raw::c_char,
@@ -426,9 +426,9 @@ macro_rules! vmstate_clock {
                 ::std::mem::offset_of!($struct_name, $field_name)
             },
             size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
-            flags: $crate::bindings::VMStateFlags(
-                $crate::bindings::VMStateFlags::VMS_STRUCT.0
-                    | $crate::bindings::VMStateFlags::VMS_POINTER.0,
+            flags: ::migration::VMStateFlags(
+                ::migration::VMStateFlags::VMS_STRUCT.0
+                    | ::migration::VMStateFlags::VMS_POINTER.0,
             ),
             vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
             ..::common::zeroable::Zeroable::ZERO
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 56feff3e17..901445013c 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -103,6 +103,7 @@
 
 pub use bindings::ObjectClass;
 use common::Opaque;
+use migration::impl_vmstate_pointer;
 
 use crate::{
     bindings::{
@@ -110,7 +111,6 @@
         object_get_typename, object_new, object_ref, object_unref, TypeInfo,
     },
     cell::bql_locked,
-    impl_vmstate_pointer,
 };
 
 /// A safe wrapper around [`bindings::Object`].
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 1dd4e29754..2ea4f88dd1 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -5,6 +5,7 @@
 use std::{ffi::CStr, ptr::addr_of};
 
 use common::Zeroable;
+use migration::VMStateDescription;
 use qemu_api::{
     bindings::qdev_prop_bool,
     cell::{self, BqlCell},
@@ -13,7 +14,6 @@
     qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
     qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
-    vmstate::VMStateDescription,
 };
 use util::bindings::{module_call_init, module_init_type};
 
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index 1ec80c483e..3f64eb46c0 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -10,16 +10,16 @@
 };
 
 use common::{Opaque, Zeroable};
-use qemu_api::{
+use migration::{
     bindings::{
         vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
-    cell::BqlCell,
     impl_vmstate_forward,
-    vmstate::{VMStateDescription, VMStateField},
+    vmstate::{VMStateDescription, VMStateField, VMStateFieldHelper},
     vmstate_fields, vmstate_of, vmstate_struct, vmstate_unused, vmstate_validate,
 };
+use qemu_api::cell::BqlCell;
 
 const FOO_ARRAY_MAX: usize = 3;
 
@@ -48,7 +48,7 @@ struct FooA {
     fields: vmstate_fields! {
         vmstate_of!(FooA, elem),
         vmstate_unused!(size_of::<i64>()),
-        vmstate_of!(FooA, arr[0 .. num]).with_version_id(0),
+        VMStateFieldHelper(vmstate_of!(FooA, arr[0 .. num])).with_version_id(0).0,
         vmstate_of!(FooA, arr_mul[0 .. num_mul * 16]),
     },
     ..Zeroable::ZERO
@@ -176,10 +176,10 @@ fn validate_foob(_state: &FooB, _version_id: u8) -> bool {
     version_id: 2,
     minimum_version_id: 1,
     fields: vmstate_fields! {
-        vmstate_of!(FooB, val).with_version_id(2),
+        VMStateFieldHelper(vmstate_of!(FooB, val)).with_version_id(2).0,
         vmstate_of!(FooB, wrap),
-        vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA).with_version_id(1),
-        vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA).with_version_id(2),
+        VMStateFieldHelper(vmstate_struct!(FooB, arr_a[0 .. num_a], &VMSTATE_FOOA, FooA)).with_version_id(1).0,
+        VMStateFieldHelper(vmstate_struct!(FooB, arr_a_mul[0 .. num_a_mul * 32], &VMSTATE_FOOA, FooA)).with_version_id(2).0,
         vmstate_of!(FooB, arr_i64),
         vmstate_struct!(FooB, arr_a_wrap[0 .. num_a_wrap], &VMSTATE_FOOA, FooA, validate_foob),
     },
@@ -340,7 +340,7 @@ struct FooC {
     version_id: 3,
     minimum_version_id: 1,
     fields: vmstate_fields! {
-        vmstate_of!(FooC, ptr).with_version_id(2),
+        VMStateFieldHelper(vmstate_of!(FooC, ptr)).with_version_id(2).0,
         // FIXME: Currently vmstate_struct doesn't support the pointer to structure.
         // VMSTATE_STRUCT_POINTER: vmstate_struct!(FooC, ptr_a, VMSTATE_FOOA, NonNull<FooA>)
         vmstate_unused!(size_of::<NonNull<FooA>>()),
-- 
2.50.1


