Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F56CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJe-0006KG-NO; Tue, 26 Aug 2025 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJc-0006JZ-3f
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJQ-000773-5R
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CilHACdL4z9JOWOy0kMpOGpK5N/BedxoPNtfBQCFjbY=;
 b=M8ypXzWBi1LueBzzVOZLsQ8yNv/u7UkbZESTlQgZe3neLP/JYCzEKg5TJSfMEwGb5L+u7Y
 9M++7Xeml5naqgQKD+CkyIrbB2C7VoGMR35oTg/b/umqmShwk3o63Nme+ztnlxwhcX1Yah
 4zmYZD7TxUaibOypELP3BeKHg0/ELv0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-bRTbLMeiNDKFZfKAz8dmWw-1; Tue,
 26 Aug 2025 10:06:04 -0400
X-MC-Unique: bRTbLMeiNDKFZfKAz8dmWw-1
X-Mimecast-MFC-AGG-ID: bRTbLMeiNDKFZfKAz8dmWw_1756217152
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4CE5180024D; Tue, 26 Aug 2025 14:05:51 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EE7F1800446; Tue, 26 Aug 2025 14:05:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 10/18] rust: split "qom" crate
Date: Tue, 26 Aug 2025 18:04:38 +0400
Message-ID: <20250826140449.4190022-11-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
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
 MAINTAINERS                       |  1 +
 rust/qom/wrapper.h                | 27 ++++++++++++++
 rust/Cargo.lock                   | 14 +++++++
 rust/Cargo.toml                   |  1 +
 rust/hw/char/pl011/Cargo.toml     |  1 +
 rust/hw/char/pl011/meson.build    |  1 +
 rust/hw/char/pl011/src/device.rs  |  5 ++-
 rust/hw/timer/hpet/Cargo.toml     |  1 +
 rust/hw/timer/hpet/meson.build    |  1 +
 rust/hw/timer/hpet/src/device.rs  |  3 +-
 rust/meson.build                  |  1 +
 rust/migration/src/vmstate.rs     |  2 +-
 rust/qemu-api-macros/src/lib.rs   |  4 +-
 rust/qemu-api-macros/src/tests.rs |  4 +-
 rust/qemu-api/Cargo.toml          |  1 +
 rust/qemu-api/meson.build         | 15 +++++---
 rust/qemu-api/src/bindings.rs     |  1 +
 rust/qemu-api/src/chardev.rs      |  5 ++-
 rust/qemu-api/src/irq.rs          | 12 +++---
 rust/qemu-api/src/lib.rs          |  1 -
 rust/qemu-api/src/memory.rs       |  9 ++---
 rust/qemu-api/src/prelude.rs      | 11 ------
 rust/qemu-api/src/qdev.rs         | 22 +++++++----
 rust/qemu-api/src/sysbus.rs       |  8 ++--
 rust/qemu-api/tests/tests.rs      | 12 +++---
 rust/qom/Cargo.toml               | 23 ++++++++++++
 rust/qom/build.rs                 | 43 ++++++++++++++++++++++
 rust/qom/meson.build              | 61 +++++++++++++++++++++++++++++++
 rust/qom/src/bindings.rs          | 25 +++++++++++++
 rust/qom/src/lib.rs               |  4 ++
 rust/{qemu-api => qom}/src/qom.rs |  4 +-
 rust/qom/tests/tests.rs           | 47 ++++++++++++++++++++++++
 32 files changed, 313 insertions(+), 57 deletions(-)
 create mode 100644 rust/qom/wrapper.h
 create mode 100644 rust/qom/Cargo.toml
 create mode 100644 rust/qom/build.rs
 create mode 100644 rust/qom/meson.build
 create mode 100644 rust/qom/src/bindings.rs
 create mode 100644 rust/qom/src/lib.rs
 rename rust/{qemu-api => qom}/src/qom.rs (99%)
 create mode 100644 rust/qom/tests/tests.rs

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b5f327d4f..8054913502 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3515,6 +3515,7 @@ F: rust/common/
 F: rust/migration/
 F: rust/qemu-api
 F: rust/qemu-api-macros
+F: rust/qom/
 F: rust/rustfmt.toml
 F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
diff --git a/rust/qom/wrapper.h b/rust/qom/wrapper.h
new file mode 100644
index 0000000000..3b71bcd3f5
--- /dev/null
+++ b/rust/qom/wrapper.h
@@ -0,0 +1,27 @@
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
+#include "qom/object.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 76ff79f81a..0f1dcea6e4 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -79,6 +79,7 @@ dependencies = [
  "migration",
  "qemu_api",
  "qemu_api_macros",
+ "qom",
  "util",
 ]
 
@@ -118,6 +119,7 @@ dependencies = [
  "migration",
  "qemu_api",
  "qemu_api_macros",
+ "qom",
  "util",
 ]
 
@@ -164,6 +166,7 @@ dependencies = [
  "libc",
  "migration",
  "qemu_api_macros",
+ "qom",
  "util",
 ]
 
@@ -176,6 +179,17 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "qom"
+version = "0.1.0"
+dependencies = [
+ "bql",
+ "common",
+ "migration",
+ "qemu_api_macros",
+ "util",
+]
+
 [[package]]
 name = "quote"
 version = "1.0.36"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 3ce1977ee0..fd7cf9b0e1 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -7,6 +7,7 @@ members = [
     "migration",
     "qemu-api-macros",
     "qemu-api",
+    "qom",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 1a1d4ba715..da89f78727 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -20,6 +20,7 @@ common = { path = "../../../common" }
 util = { path = "../../../util" }
 bql = { path = "../../../bql" }
 migration = { path = "../../../migration" }
+qom = { path = "../../../qom" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 7062497b7c..cd855408a5 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -13,6 +13,7 @@ _libpl011_rs = static_library(
     bql_rs,
     qemu_api,
     qemu_api_macros,
+    qom_rs,
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 7cffb894a8..a3bcd1297a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -21,10 +21,13 @@
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, Owned, ParentField, ParentInit},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     vmstate_clock,
 };
+use qom::{
+    qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods, ObjectType,
+    Owned, ParentField, ParentInit,
+};
 use util::{log::Log, log_mask_ln};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 9fcec38bfa..19456ec72b 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -15,6 +15,7 @@ common = { path = "../../../common" }
 util = { path = "../../../util" }
 migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
+qom = { path = "../../../qom" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 5e01e57210..195dc48e1c 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -10,6 +10,7 @@ _libhpet_rs = static_library(
     bql_rs,
     qemu_api,
     qemu_api_macros,
+    qom_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index c0e52ce415..b876b35a43 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -27,10 +27,9 @@
     },
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
-    qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
-    qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
 };
+use qom::{qom_isa, Object, ObjectImpl, ObjectType, ParentField, ParentInit};
 use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
 use crate::fw_cfg::HPETFwConfig;
diff --git a/rust/meson.build b/rust/meson.build
index 2ba1ea2280..043603d416 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -28,6 +28,7 @@ subdir('bits')
 subdir('util')
 subdir('migration')
 subdir('bql')
+subdir('qom')
 subdir('qemu-api')
 
 subdir('hw')
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 243f31baf6..58a4396c30 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -200,7 +200,7 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 ///
 /// [`BqlCell`]: ../../bql/cell/struct.BqlCell.html
 /// [`BqlRefCell`]: ../../bql/cell/struct.BqlRefCell.html
-/// [`Owned`]: ../../qemu_api/qom/struct.Owned.html
+/// [`Owned`]: ../../qom/qom/struct.Owned.html
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index b5f77f06f5..5d52f22441 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -89,11 +89,11 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
 
     Ok(quote! {
         ::common::assert_field_type!(#name, #parent,
-            ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
+            ::qom::ParentField<<#name as ::qom::ObjectImpl>::ParentType>);
 
         ::util::module_init! {
             MODULE_INIT_QOM => unsafe {
-                ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
+                ::qom::type_register_static(&<#name as ::qom::ObjectImpl>::TYPE_INFO);
             }
         }
     })
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 52683e46d5..b6da07f24c 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -61,11 +61,11 @@ struct Foo {
             ::common::assert_field_type!(
                 Foo,
                 _unused,
-                ::qemu_api::qom::ParentField<<Foo as ::qemu_api::qom::ObjectImpl>::ParentType>
+                ::qom::ParentField<<Foo as ::qom::ObjectImpl>::ParentType>
             );
             ::util::module_init! {
                 MODULE_INIT_QOM => unsafe {
-                    ::qemu_api::bindings::type_register_static(&<Foo as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
+                    ::qom::type_register_static(&<Foo as ::qom::ObjectImpl>::TYPE_INFO);
                 }
             }
         }
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index 511eb6cb89..333cef1c5d 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -19,6 +19,7 @@ migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
 qemu_api_macros = { path = "../qemu-api-macros" }
+qom = { path = "../qom" }
 anyhow = "~1.0"
 libc = "0.2.162"
 foreign = "~0.3.1"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index dd829e3348..c5038aa5bd 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -22,9 +22,15 @@ foreach enum : c_bitfields
   _qemu_api_bindgen_args += ['--bitfield-enum', enum]
 endforeach
 
-_qemu_api_bindgen_args += ['--blocklist-type', 'VMStateDescription']
+blocked_type = [
+  'ObjectClass',
+  'VMStateDescription',
+  'Error',
+]
+foreach type: blocked_type
+  _qemu_api_bindgen_args += ['--blocklist-type', type]
+endforeach
 
-_qemu_api_bindgen_args += ['--blocklist-type', 'Error']
 # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
 #
 # Rust bindings generation with `bindgen` might fail in some cases where the
@@ -52,7 +58,6 @@ _qemu_api_rs = static_library(
       'src/memory.rs',
       'src/prelude.rs',
       'src/qdev.rs',
-      'src/qom.rs',
       'src/sysbus.rs',
     ],
     {'.' : _qemu_api_bindings_inc_rs},
@@ -60,7 +65,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs,
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs,
                  qom, hwcore, chardev, migration],
 )
 
@@ -86,7 +91,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qemu_api]),
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs, qemu_api]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index ce00a6e0e4..525f136ae2 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -22,6 +22,7 @@
 
 use common::Zeroable;
 use migration::bindings::VMStateDescription;
+use qom::bindings::ObjectClass;
 use util::bindings::Error;
 
 #[cfg(MESON)]
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index d07e263193..1a6795a938 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -20,8 +20,9 @@
 
 use bql::{BqlRefCell, BqlRefMut};
 use common::{callbacks::FnCall, Opaque};
+use qom::{Object, ObjectType};
 
-use crate::{bindings, prelude::*};
+use crate::bindings;
 
 /// A safe wrapper around [`bindings::Chardev`].
 #[repr(transparent)]
@@ -257,4 +258,4 @@ unsafe impl ObjectType for Chardev {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CHARDEV) };
 }
-qom_isa!(Chardev: Object);
+qom::qom_isa!(Chardev: Object);
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 3063fbe97a..5a380923fe 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -12,12 +12,9 @@
 
 use bql::BqlCell;
 use common::Opaque;
+use qom::{Object, ObjectClass, ObjectType};
 
-use crate::{
-    bindings::{self, qemu_set_irq},
-    prelude::*,
-    qom::ObjectClass,
-};
+use crate::bindings::{self, qemu_set_irq};
 
 /// An opaque wrapper around [`bindings::IRQState`].
 #[repr(transparent)]
@@ -36,7 +33,7 @@
 ///
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
-/// a function such as [`SysBusDeviceMethods::init_irq`], and
+/// a function such as [`crate::sysbus::SysBusDeviceMethods::init_irq`], and
 /// initially leaves the pointer to a NULL value, representing an unconnected
 /// interrupt. To connect it, whoever creates the device fills the pointer with
 /// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
@@ -114,4 +111,5 @@ unsafe impl ObjectType for IRQState {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_IRQ) };
 }
-qom_isa!(IRQState: Object);
+
+qom::qom_isa!(IRQState: Object);
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 37e6c21946..f9551c13a5 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -17,5 +17,4 @@
 pub mod irq;
 pub mod memory;
 pub mod qdev;
-pub mod qom;
 pub mod sysbus;
diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
index f790cb5fd2..480cc6b0c5 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/qemu-api/src/memory.rs
@@ -11,11 +11,9 @@
 
 pub use bindings::{hwaddr, MemTxAttrs};
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
+use qom::{IsA, Object, ObjectType};
 
-use crate::{
-    bindings::{self, device_endian, memory_region_init_io},
-    prelude::*,
-};
+use crate::bindings::{self, device_endian, memory_region_init_io};
 
 pub struct MemoryRegionOps<T>(
     bindings::MemoryRegionOps,
@@ -186,7 +184,8 @@ unsafe impl ObjectType for MemoryRegion {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_MEMORY_REGION) };
 }
-qom_isa!(MemoryRegion: Object);
+
+qom::qom_isa!(MemoryRegion: Object);
 
 /// A special `MemTxAttrs` constant, used to indicate that no memory
 /// attributes are specified.
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 9da7313016..9e9d1c8247 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -6,15 +6,4 @@
 
 pub use crate::qdev::DeviceMethods;
 
-pub use crate::qom::InterfaceType;
-pub use crate::qom::IsA;
-pub use crate::qom::Object;
-pub use crate::qom::ObjectCast;
-pub use crate::qom::ObjectClassMethods;
-pub use crate::qom::ObjectDeref;
-pub use crate::qom::ObjectMethods;
-pub use crate::qom::ObjectType;
-
-pub use crate::qom_isa;
-
 pub use crate::sysbus::SysBusDeviceMethods;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 6875c32be7..a94af90bb1 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -12,14 +12,16 @@
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use common::{callbacks::FnCall, Opaque};
 use migration::vmstate::VMStateDescription;
+use qom::{
+    InterfaceType, IsA, Object, ObjectCast, ObjectClass, ObjectDeref, ObjectImpl, ObjectType,
+    Owned, ParentInit,
+};
 pub use util::{Error, Result};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     chardev::Chardev,
     irq::InterruptSource,
-    prelude::*,
-    qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
 };
 
 /// A safe wrapper around [`bindings::Clock`].
@@ -164,10 +166,14 @@ pub fn class_init<T: ResettablePhasesImpl>(&mut self) {
     }
 }
 
-impl DeviceClass {
+pub trait DeviceClassExt {
+    fn class_init<T: DeviceImpl>(&mut self);
+}
+
+impl DeviceClassExt for DeviceClass {
     /// Fill in the virtual methods of `DeviceClass` based on the definitions in
     /// the `DeviceImpl` trait.
-    pub fn class_init<T: DeviceImpl>(&mut self) {
+    fn class_init<T: DeviceImpl>(&mut self) {
         if <T as DeviceImpl>::REALIZE.is_some() {
             self.realize = Some(rust_realize_fn::<T>);
         }
@@ -244,7 +250,8 @@ unsafe impl ObjectType for DeviceState {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
-qom_isa!(DeviceState: Object);
+
+qom::qom_isa!(DeviceState: Object);
 
 /// Initialization methods take a [`ParentInit`] and can be called as
 /// associated functions.
@@ -406,7 +413,8 @@ unsafe impl ObjectType for Clock {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
 }
-qom_isa!(Clock: Object);
+
+qom::qom_isa!(Clock: Object);
 
 #[doc(alias = "VMSTATE_CLOCK")]
 #[macro_export]
@@ -420,7 +428,7 @@ macro_rules! vmstate_clock {
                 ::common::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    $crate::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
+                    ::qom::Owned<$crate::qdev::Clock> $(, num = $num)?
                 );
                 ::std::mem::offset_of!($struct_name, $field_name)
             },
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index b21883246e..016e57935a 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -8,14 +8,13 @@
 
 pub use bindings::SysBusDeviceClass;
 use common::Opaque;
+use qom::{IsA, Object, ObjectCast, ObjectDeref, ObjectType, Owned};
 
 use crate::{
     bindings,
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
-    prelude::*,
-    qdev::{DeviceImpl, DeviceState},
-    qom::Owned,
+    qdev::{DeviceClassExt, DeviceImpl, DeviceState},
 };
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
@@ -31,7 +30,8 @@ unsafe impl ObjectType for SysBusDevice {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
 }
-qom_isa!(SysBusDevice: DeviceState, Object);
+
+qom::qom_isa!(SysBusDevice: DeviceState, Object);
 
 // TODO: add virtual methods
 pub trait SysBusDeviceImpl: DeviceImpl + IsA<SysBusDevice> {}
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index bc4bd320ce..821aabe831 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -10,11 +10,13 @@
 use qemu_api::{
     bindings::qdev_prop_bool,
     declare_properties, define_property,
-    prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
-    qom::{ObjectImpl, ParentField},
+    qdev::{DeviceClassExt, DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
     sysbus::SysBusDevice,
 };
+use qom::{
+    Object, ObjectCast, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods, ObjectType,
+    ParentField,
+};
 use util::bindings::{module_call_init, module_init_type};
 
 mod vmstate_tests;
@@ -33,7 +35,7 @@ pub struct DummyState {
     migrate_clock: bool,
 }
 
-qom_isa!(DummyState: Object, DeviceState);
+qom::qom_isa!(DummyState: Object, DeviceState);
 
 pub struct DummyClass {
     parent_class: <DeviceState as ObjectType>::Class,
@@ -84,7 +86,7 @@ pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
 
-qom_isa!(DummyChildState: Object, DeviceState, DummyState);
+qom::qom_isa!(DummyChildState: Object, DeviceState, DummyState);
 
 pub struct DummyChildClass {
     parent_class: <DummyState as ObjectType>::Class,
diff --git a/rust/qom/Cargo.toml b/rust/qom/Cargo.toml
new file mode 100644
index 0000000000..46bbf7c7fe
--- /dev/null
+++ b/rust/qom/Cargo.toml
@@ -0,0 +1,23 @@
+[package]
+name = "qom"
+version = "0.1.0"
+description = "Rust bindings for QEMU/QOM"
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
+bql = { path = "../bql" }
+migration = { path = "../migration" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+util = { path = "../util" }
+
+[lints]
+workspace = true
diff --git a/rust/qom/build.rs b/rust/qom/build.rs
new file mode 100644
index 0000000000..aca1c54cb8
--- /dev/null
+++ b/rust/qom/build.rs
@@ -0,0 +1,43 @@
+// Copyright 2024, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[cfg(unix)]
+use std::os::unix::fs::symlink as symlink_file;
+#[cfg(windows)]
+use std::os::windows::fs::symlink_file;
+use std::{env, fs::remove_file, io::Result, path::Path};
+
+fn main() -> Result<()> {
+    let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
+        format!("{root}/rust/qom/bindings.inc.rs")
+    } else {
+        // Placing bindings.inc.rs in the source directory is supported
+        // but not documented or encouraged.
+        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+    };
+
+    let file = Path::new(&file);
+    if !Path::new(&file).exists() {
+        panic!(concat!(
+            "\n",
+            "    No generated C bindings found! Maybe you wanted one of\n",
+            "    `make clippy`, `make rustfmt`, `make rustdoc`?\n",
+            "\n",
+            "    For other uses of `cargo`, start a subshell with\n",
+            "    `pyvenv/bin/meson devenv`, or point MESON_BUILD_ROOT to\n",
+            "    the top of the build tree."
+        ));
+    }
+
+    let out_dir = env::var("OUT_DIR").unwrap();
+    let dest_path = format!("{out_dir}/bindings.inc.rs");
+    let dest_path = Path::new(&dest_path);
+    if dest_path.symlink_metadata().is_ok() {
+        remove_file(dest_path)?;
+    }
+    symlink_file(file, dest_path)?;
+
+    println!("cargo:rerun-if-changed=build.rs");
+    Ok(())
+}
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
new file mode 100644
index 0000000000..6e95d75fa0
--- /dev/null
+++ b/rust/qom/meson.build
@@ -0,0 +1,61 @@
+_qom_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_qom_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common,
+)
+
+_qom_rs = static_library(
+  'qom',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/qom.rs',
+    ],
+    {'.': _qom_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _qom_cfg,
+  dependencies: [qemuutil_rs, bql_rs, common_rs, migration_rs, qemu_api_macros, qom],
+)
+
+qom_rs = declare_dependency(link_with: [_qom_rs], dependencies: [qemu_api_macros, qom])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-qom-rs-doctests',
+     _qom_rs,
+     protocol: 'rust',
+     dependencies: qom_rs,
+     suite: ['doc', 'rust'])
+
+test('rust-qom-rs-integration',
+    executable(
+        'rust-qom-rs-integration',
+        files('tests/tests.rs'),
+        override_options: ['rust_std=2021', 'build.rust_std=2021'],
+        rust_args: ['--test'],
+        install: false,
+        dependencies: [common_rs, qom_rs, bql_rs, util_rs]),
+    args: [
+        '--test', '--test-threads', '1',
+        '--format', 'pretty',
+    ],
+    protocol: 'rust',
+    suite: ['unit', 'rust'])
diff --git a/rust/qom/src/bindings.rs b/rust/qom/src/bindings.rs
new file mode 100644
index 0000000000..9ffff12cde
--- /dev/null
+++ b/rust/qom/src/bindings.rs
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
diff --git a/rust/qom/src/lib.rs b/rust/qom/src/lib.rs
new file mode 100644
index 0000000000..22520906cf
--- /dev/null
+++ b/rust/qom/src/lib.rs
@@ -0,0 +1,4 @@
+pub mod bindings;
+
+mod qom;
+pub use qom::*;
diff --git a/rust/qemu-api/src/qom.rs b/rust/qom/src/qom.rs
similarity index 99%
rename from rust/qemu-api/src/qom.rs
rename to rust/qom/src/qom.rs
index e797958e4e..a632ec43f2 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -101,7 +101,6 @@
     ptr::NonNull,
 };
 
-pub use bindings::ObjectClass;
 use common::Opaque;
 use migration::impl_vmstate_pointer;
 
@@ -109,6 +108,7 @@
     self, object_class_dynamic_cast, object_dynamic_cast, object_get_class, object_get_typename,
     object_new, object_ref, object_unref, TypeInfo,
 };
+pub use crate::bindings::{type_register_static, ObjectClass};
 
 /// A safe wrapper around [`bindings::Object`].
 #[repr(transparent)]
@@ -146,7 +146,7 @@ macro_rules! qom_isa {
         $(
             // SAFETY: it is the caller responsibility to have $parent as the
             // first field
-            unsafe impl $crate::qom::IsA<$parent> for $struct {}
+            unsafe impl $crate::IsA<$parent> for $struct {}
 
             impl AsRef<$parent> for $struct {
                 fn as_ref(&self) -> &$parent {
diff --git a/rust/qom/tests/tests.rs b/rust/qom/tests/tests.rs
new file mode 100644
index 0000000000..49f1cbecf5
--- /dev/null
+++ b/rust/qom/tests/tests.rs
@@ -0,0 +1,47 @@
+use std::{ffi::CStr, sync::LazyLock};
+
+use qom::{qom_isa, Object, ObjectClassMethods, ObjectImpl, ObjectType, ParentField};
+use util::bindings::{module_call_init, module_init_type};
+
+#[repr(C)]
+#[derive(qemu_api_macros::Object)]
+pub struct DummyObject {
+    parent: ParentField<Object>,
+}
+
+qom_isa!(DummyObject: Object);
+
+pub struct DummyClass {}
+
+impl DummyClass {
+    pub fn class_init(self: &mut DummyClass) {
+        //
+    }
+}
+
+unsafe impl ObjectType for DummyObject {
+    type Class = DummyClass;
+    const TYPE_NAME: &'static CStr = c"dummy";
+}
+
+impl ObjectImpl for DummyObject {
+    type ParentType = Object;
+    const ABSTRACT: bool = false;
+    const CLASS_INIT: fn(&mut DummyClass) = DummyClass::class_init;
+}
+
+fn init_qom() {
+    static ONCE: LazyLock<()> = LazyLock::new(|| unsafe {
+        module_call_init(module_init_type::MODULE_INIT_QOM);
+    });
+
+    bql::start_test();
+    LazyLock::force(&ONCE);
+}
+
+#[test]
+/// Create and immediately drop an instance.
+fn test_object_new() {
+    init_qom();
+    drop(DummyObject::new());
+}
-- 
2.50.1


