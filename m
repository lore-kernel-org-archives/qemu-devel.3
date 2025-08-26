Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2EACA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 14:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uquJe-0006KP-Pk; Tue, 26 Aug 2025 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJd-0006Jx-Bw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uquJY-00078d-JJ
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 10:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756217176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9WZ7F+XP0Vd0E4zHWQW+CEf4jTjZrCq4Obs8JQIWJzc=;
 b=fmWCW+sOe91UMJjb0YPB6qkaKbUeEf3zptSmhVYn1qT7QN6K0SAWC4LABCmvBH/dj/RDSZ
 ajyJuMOK7xFjHMbybRrByZ6Gt7EQElgK3Fe7Jje55rNaHUAOnpErIyJNPzBZpMO3KsRXt1
 MggZ4GDiTlac81Kmw4s1n5lAK8Nv1tI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-vwPEL4FsNVC32u4bsDg0xA-1; Tue,
 26 Aug 2025 10:06:12 -0400
X-MC-Unique: vwPEL4FsNVC32u4bsDg0xA-1
X-Mimecast-MFC-AGG-ID: vwPEL4FsNVC32u4bsDg0xA_1756217163
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CFF1195609F; Tue, 26 Aug 2025 14:06:03 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E715419560AB; Tue, 26 Aug 2025 14:06:01 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC 12/18] rust: split "system" crate
Date: Tue, 26 Aug 2025 18:04:40 +0400
Message-ID: <20250826140449.4190022-13-marcandre.lureau@redhat.com>
In-Reply-To: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
References: <20250826140449.4190022-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 MAINTAINERS                             |  1 +
 rust/qemu-api/wrapper.h                 |  3 --
 rust/system/wrapper.h                   | 29 +++++++++++++
 rust/Cargo.lock                         | 13 ++++++
 rust/Cargo.toml                         |  1 +
 rust/bql/src/cell.rs                    |  5 +--
 rust/hw/char/pl011/Cargo.toml           |  1 +
 rust/hw/char/pl011/meson.build          |  1 +
 rust/hw/char/pl011/src/device.rs        |  2 +-
 rust/hw/timer/hpet/Cargo.toml           |  1 +
 rust/hw/timer/hpet/meson.build          |  1 +
 rust/hw/timer/hpet/src/device.rs        | 12 +++---
 rust/meson.build                        |  1 +
 rust/qemu-api/Cargo.toml                |  1 +
 rust/qemu-api/meson.build               |  7 +--
 rust/qemu-api/src/bindings.rs           | 14 +-----
 rust/qemu-api/src/lib.rs                |  1 -
 rust/qemu-api/src/sysbus.rs             |  2 +-
 rust/system/Cargo.toml                  | 22 ++++++++++
 rust/system/build.rs                    | 43 +++++++++++++++++++
 rust/system/meson.build                 | 57 +++++++++++++++++++++++++
 rust/system/src/bindings.rs             | 41 ++++++++++++++++++
 rust/system/src/lib.rs                  |  4 ++
 rust/{qemu-api => system}/src/memory.rs |  2 +-
 24 files changed, 232 insertions(+), 33 deletions(-)
 create mode 100644 rust/system/wrapper.h
 create mode 100644 rust/system/Cargo.toml
 create mode 100644 rust/system/build.rs
 create mode 100644 rust/system/meson.build
 create mode 100644 rust/system/src/bindings.rs
 create mode 100644 rust/system/src/lib.rs
 rename rust/{qemu-api => system}/src/memory.rs (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ab89b208c..ce8bb3c076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3518,6 +3518,7 @@ F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/qom/
 F: rust/rustfmt.toml
+F: rust/system/
 F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
 
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 07dbc9987a..564733b903 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -49,14 +49,11 @@ typedef enum memory_order {
 
 #include "qemu/osdep.h"
 #include "qemu-io.h"
-#include "system/system.h"
 #include "hw/sysbus.h"
-#include "system/memory.h"
 #include "hw/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/irq.h"
 #include "exec/memattrs.h"
-#include "system/address-spaces.h"
 #include "hw/char/pl011.h"
diff --git a/rust/system/wrapper.h b/rust/system/wrapper.h
new file mode 100644
index 0000000000..48abde8505
--- /dev/null
+++ b/rust/system/wrapper.h
@@ -0,0 +1,29 @@
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
+#include "system/system.h"
+#include "system/memory.h"
+#include "system/address-spaces.h"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index ac325969cc..e4946549c0 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -92,6 +92,7 @@ dependencies = [
  "qemu_api",
  "qemu_api_macros",
  "qom",
+ "system",
  "util",
 ]
 
@@ -133,6 +134,7 @@ dependencies = [
  "qemu_api",
  "qemu_api_macros",
  "qom",
+ "system",
  "util",
 ]
 
@@ -181,6 +183,7 @@ dependencies = [
  "migration",
  "qemu_api_macros",
  "qom",
+ "system",
  "util",
 ]
 
@@ -224,6 +227,16 @@ dependencies = [
  "unicode-ident",
 ]
 
+[[package]]
+name = "system"
+version = "0.1.0"
+dependencies = [
+ "common",
+ "qemu_api_macros",
+ "qom",
+ "util",
+]
+
 [[package]]
 name = "unicode-ident"
 version = "1.0.12"
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index fd7cf9b0e1..1c18e69660 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -8,6 +8,7 @@ members = [
     "qemu-api-macros",
     "qemu-api",
     "qom",
+    "system",
     "hw/char/pl011",
     "hw/timer/hpet",
     "util",
diff --git a/rust/bql/src/cell.rs b/rust/bql/src/cell.rs
index 43109130c5..23b21f0214 100644
--- a/rust/bql/src/cell.rs
+++ b/rust/bql/src/cell.rs
@@ -77,9 +77,8 @@
 //!
 //! ```ignore
 //! # use bql::BqlRefCell;
-//! # use qemu_api::prelude::*;
-//! # use qemu_api::{irq::InterruptSource, irq::IRQState};
-//! # use qemu_api::{sysbus::SysBusDevice, qom::Owned, qom::ParentField};
+//! # use qom::{Owned, ParentField};
+//! # use system::{InterruptSource, IRQState, SysBusDevice};
 //! # const N_GPIOS: usize = 8;
 //! # struct PL061Registers { /* ... */ }
 //! # unsafe impl ObjectType for PL061State {
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index f7ad5f8e08..e4b1c3f1eb 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -22,6 +22,7 @@ bql = { path = "../../../bql" }
 migration = { path = "../../../migration" }
 qom = { path = "../../../qom" }
 chardev = { path = "../../../chardev" }
+system = { path = "../../../system" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 552ccc0d60..06ebaf7ab9 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -15,6 +15,7 @@ _libpl011_rs = static_library(
     qemu_api_macros,
     qom_rs,
     chardev_rs,
+    system_rs,
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index b1c65bd79c..5307ac480b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -18,7 +18,6 @@
 use qemu_api::{
     bindings::{qdev_prop_bool, qdev_prop_chr},
     irq::{IRQState, InterruptSource},
-    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -28,6 +27,7 @@
     qom_isa, IsA, Object, ObjectClassMethods, ObjectDeref, ObjectImpl, ObjectMethods, ObjectType,
     Owned, ParentField, ParentInit,
 };
+use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
 use util::{log::Log, log_mask_ln};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 19456ec72b..a95b1271c6 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -16,6 +16,7 @@ util = { path = "../../../util" }
 migration = { path = "../../../migration" }
 bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
+system = { path = "../../../system" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 195dc48e1c..74cbe27df8 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -11,6 +11,7 @@ _libhpet_rs = static_library(
     qemu_api,
     qemu_api_macros,
     qom_rs,
+    system_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index b876b35a43..f5cc4ee0ad 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -17,19 +17,17 @@
     VMStateDescription, VMStateFieldHelper,
 };
 use qemu_api::{
-    bindings::{
-        address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_usize,
-    },
+    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
     irq::InterruptSource,
-    memory::{
-        hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
-    },
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
 };
 use qom::{qom_isa, Object, ObjectImpl, ObjectType, ParentField, ParentInit};
+use system::{
+    bindings::{address_space_memory, address_space_stl_le, hwaddr},
+    MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+};
 use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
 use crate::fw_cfg::HPETFwConfig;
diff --git a/rust/meson.build b/rust/meson.build
index 4d9e291223..d8b71f5506 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -29,6 +29,7 @@ subdir('util')
 subdir('migration')
 subdir('bql')
 subdir('qom')
+subdir('system')
 subdir('chardev')
 subdir('qemu-api')
 
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index b8aa6d037c..2429c4eb9f 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -21,6 +21,7 @@ util = { path = "../util" }
 bql = { path = "../bql" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 qom = { path = "../qom" }
+system = { path = "../system" }
 anyhow = "~1.0"
 libc = "0.2.162"
 foreign = "~0.3.1"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index e3af8f86c1..644ca44573 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -8,7 +8,6 @@ c_enums = [
   'MachineInitPhase',
   'MemoryDeviceInfoKind',
   'ResetType',
-  'device_endian',
 ]
 _qemu_api_bindgen_args = []
 foreach enum : c_enums
@@ -24,8 +23,11 @@ endforeach
 blocked_type = [
   'Chardev',
   'Error',
+  'MemTxAttrs',
+  'MemoryRegion',
   'ObjectClass',
   'VMStateDescription',
+  'device_endian',
 ]
 foreach type: blocked_type
   _qemu_api_bindgen_args += ['--blocklist-type', type]
@@ -54,7 +56,6 @@ _qemu_api_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/irq.rs',
-      'src/memory.rs',
       'src/prelude.rs',
       'src/qdev.rs',
       'src/sysbus.rs',
@@ -64,7 +65,7 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs,
+  dependencies: [anyhow_rs, common_rs, chardev_rs, foreign_rs, libc_rs, qemu_api_macros, qemuutil_rs, util_rs, migration_rs, bql_rs, qom_rs, system_rs,
                  qom, hwcore, chardev, migration],
 )
 
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 526bcf8e31..63b805c76e 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -24,6 +24,7 @@
 use common::Zeroable;
 use migration::bindings::VMStateDescription;
 use qom::bindings::ObjectClass;
+use system::bindings::{device_endian, MemTxAttrs, MemoryRegion};
 use util::bindings::Error;
 
 #[cfg(MESON)]
@@ -32,15 +33,6 @@
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
 
-// SAFETY: this is a pure data struct
-unsafe impl Send for CoalescedMemoryRange {}
-unsafe impl Sync for CoalescedMemoryRange {}
-
-// SAFETY: these are constants and vtables; the Send and Sync requirements
-// are deferred to the unsafe callbacks that they contain
-unsafe impl Send for MemoryRegionOps {}
-unsafe impl Sync for MemoryRegionOps {}
-
 unsafe impl Send for Property {}
 unsafe impl Sync for Property {}
 
@@ -49,7 +41,3 @@ unsafe impl Sync for TypeInfo {}
 
 unsafe impl Zeroable for crate::bindings::Property__bindgen_ty_1 {}
 unsafe impl Zeroable for crate::bindings::Property {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_1 {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps__bindgen_ty_2 {}
-unsafe impl Zeroable for crate::bindings::MemoryRegionOps {}
-unsafe impl Zeroable for crate::bindings::MemTxAttrs {}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 712116b585..38ff102b86 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -14,6 +14,5 @@
 pub mod prelude;
 
 pub mod irq;
-pub mod memory;
 pub mod qdev;
 pub mod sysbus;
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 016e57935a..66b618c705 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -9,11 +9,11 @@
 pub use bindings::SysBusDeviceClass;
 use common::Opaque;
 use qom::{IsA, Object, ObjectCast, ObjectDeref, ObjectType, Owned};
+use system::MemoryRegion;
 
 use crate::{
     bindings,
     irq::{IRQState, InterruptSource},
-    memory::MemoryRegion,
     qdev::{DeviceClassExt, DeviceImpl, DeviceState},
 };
 
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
new file mode 100644
index 0000000000..6803895e08
--- /dev/null
+++ b/rust/system/Cargo.toml
@@ -0,0 +1,22 @@
+[package]
+name = "system"
+version = "0.1.0"
+description = "Rust bindings for QEMU/system"
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
+qom = { path = "../qom" }
+util = { path = "../util" }
+qemu_api_macros = { path = "../qemu-api-macros" }
+
+[lints]
+workspace = true
diff --git a/rust/system/build.rs b/rust/system/build.rs
new file mode 100644
index 0000000000..34ba641373
--- /dev/null
+++ b/rust/system/build.rs
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
+        format!("{root}/rust/system/bindings.inc.rs")
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
diff --git a/rust/system/meson.build b/rust/system/meson.build
new file mode 100644
index 0000000000..cbd3eb4717
--- /dev/null
+++ b/rust/system/meson.build
@@ -0,0 +1,57 @@
+_system_cfg = run_command(rustc_args,
+  '--config-headers', config_host_h, '--features', files('Cargo.toml'),
+  capture: true, check: true).stdout().strip().splitlines()
+
+c_enums = [
+  'device_endian',
+]
+_system_bindgen_args = []
+foreach enum : c_enums
+  _system_bindgen_args += ['--rustified-enum', enum]
+endforeach
+
+# TODO: Remove this comment when the clang/libclang mismatch issue is solved.
+#
+# Rust bindings generation with `bindgen` might fail in some cases where the
+# detected `libclang` does not match the expected `clang` version/target. In
+# this case you must pass the path to `clang` and `libclang` to your build
+# command invocation using the environment variables CLANG_PATH and
+# LIBCLANG_PATH
+_system_bindings_inc_rs = rust.bindgen(
+  input: 'wrapper.h',
+  dependencies: common_ss.all_dependencies(),
+  output: 'bindings.inc.rs',
+  include_directories: bindings_incdir,
+  bindgen_version: ['>=0.60.0'],
+  args: bindgen_args_common + _system_bindgen_args,
+)
+
+_system_rs = static_library(
+  'system',
+  structured_sources(
+    [
+      'src/lib.rs',
+      'src/bindings.rs',
+      'src/memory.rs',
+    ],
+    {'.': _system_bindings_inc_rs}
+  ),
+  override_options: ['rust_std=2021', 'build.rust_std=2021'],
+  rust_abi: 'rust',
+  rust_args: _system_cfg,
+  dependencies: [qemuutil_rs, common_rs, bql_rs, migration_rs, qemu_api_macros, qom_rs, util_rs,
+                hwcore],
+)
+
+system_rs = declare_dependency(link_with: [_system_rs],
+  dependencies: [qemu_api_macros, hwcore])
+
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-system-rs-doctests',
+     _system_rs,
+     protocol: 'rust',
+     dependencies: system_rs,
+     suite: ['doc', 'rust'])
+
diff --git a/rust/system/src/bindings.rs b/rust/system/src/bindings.rs
new file mode 100644
index 0000000000..43edd98807
--- /dev/null
+++ b/rust/system/src/bindings.rs
@@ -0,0 +1,41 @@
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
+// SAFETY: these are constants and vtables; the Send and Sync requirements
+// are deferred to the unsafe callbacks that they contain
+unsafe impl Send for MemoryRegionOps {}
+unsafe impl Sync for MemoryRegionOps {}
+
+// SAFETY: this is a pure data struct
+unsafe impl Send for CoalescedMemoryRange {}
+unsafe impl Sync for CoalescedMemoryRange {}
+
+unsafe impl Zeroable for MemoryRegionOps__bindgen_ty_1 {}
+unsafe impl Zeroable for MemoryRegionOps__bindgen_ty_2 {}
+unsafe impl Zeroable for MemoryRegionOps {}
+unsafe impl Zeroable for MemTxAttrs {}
diff --git a/rust/system/src/lib.rs b/rust/system/src/lib.rs
new file mode 100644
index 0000000000..dfb68d3ea0
--- /dev/null
+++ b/rust/system/src/lib.rs
@@ -0,0 +1,4 @@
+pub mod bindings;
+
+mod memory;
+pub use memory::*;
diff --git a/rust/qemu-api/src/memory.rs b/rust/system/src/memory.rs
similarity index 99%
rename from rust/qemu-api/src/memory.rs
rename to rust/system/src/memory.rs
index 480cc6b0c5..af69fb30bf 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -9,11 +9,11 @@
     marker::PhantomData,
 };
 
-pub use bindings::{hwaddr, MemTxAttrs};
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 use qom::{IsA, Object, ObjectType};
 
 use crate::bindings::{self, device_endian, memory_region_init_io};
+pub use crate::bindings::{hwaddr, MemTxAttrs};
 
 pub struct MemoryRegionOps<T>(
     bindings::MemoryRegionOps,
-- 
2.50.1


