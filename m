Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B2BCAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMX-0000VZ-9R; Sat, 13 Sep 2025 04:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMO-0000Bc-RY
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLML-00058X-Ha
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIfvFGk4qan/Mo6Ocp8y4g8+xo8GQK64aMfGU1lbIlo=;
 b=BxqENhMv6mjWcw5fyItn7bnX20I0utOSAHOn/jp2edb7Rc7jrlJ9tKm2x+iMhKJLKFbnyA
 NqYcbgd7cmw7aXJwUXuZMZdyowlOI18qhKUuN0SFv1pMPPrmYWJWyFKLxMkShY94rdaLxJ
 h2/M9O/ekmaQaD1qvhLTdjRQjxiLmGE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-KLdho2shOviquZx0dGhGsg-1; Sat, 13 Sep 2025 04:11:47 -0400
X-MC-Unique: KLdho2shOviquZx0dGhGsg-1
X-Mimecast-MFC-AGG-ID: KLdho2shOviquZx0dGhGsg_1757751106
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e8ef75b196so117069f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751105; x=1758355905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIfvFGk4qan/Mo6Ocp8y4g8+xo8GQK64aMfGU1lbIlo=;
 b=qeIUcb09pzWLBRTAriT9J52j/WLDhoZpUCWqE5ySm2CQxVsbLR18A2jSyyxQKeCEu0
 BNPiRV681yaIJIhmm6XhSLUyaUFcvNwa1qwlwlkeXJKdI0Rf1qwPtGF5yX9/M+LviJke
 2aUcQxxe9Hr6EYfqZDt6OoJcroISGk1O8KYzP0tuI3AopDhmqPjaV8a/ldUc1WDA5Qu/
 S2c7cOh1vUgZ+MmcXWO52+rtXoaUMa9tqhoxyA7A0+oMYLs2aGu1kvVMuHnzEx9egVnz
 gHxx1Ab1o3TLb81/3zZ+jJo/KzkmVQ5PaxQXjPfe9/OFJIFhxN26LczlvwCIUA7eZENv
 OinQ==
X-Gm-Message-State: AOJu0YyqJ77MT3qYq49++KyoE+MfOmjpig5Bspg/EJYjtJZpiKqyJ72P
 2X7Ypd/9QWWFjubuFpTp8+2syJNaC7sEpl048KN8EuSBFX2M+TgUOhXfVg/tcqY8ZYK9zelHnXy
 yNsyfMDjSAYCneqTf9ZhnXdQO6iC9mFzEAXQlFjktJXpq0QSGJkLqv31k3lW1umuWlGuRJbpD39
 /Ys/kNnYz3KpTED/zwFDh+179uOUkVmE9/j5VUWdwC
X-Gm-Gg: ASbGncuBKg8+LQ68YikVkwBvCs5tAiuYu0YY4IDaJI4om6/BOxi4qy0aRxRSPpCAOBU
 oRW9/oLGksJsPYftgLuJoAWtXcOVOKvu/Hq9f08Xp0tS7FhjQ3COm2cJJwHVKRRB+br7rfWtT4X
 E/+sCtT4PhY9EeYr2DtfHTjKHi5Ynf2LXl0Qrf9+OzrKYTL/BB8MCGQ4JNOxjboSUKPK0/tbjJk
 79egeYPqf4aUhk4S4wCF4lig4/nFhASQPE8hA2BTWR0+7TuIMJtAXJIDFEpW+UZp/dHqJl2O1gP
 Mytxcbjli8PjDT+m8IZSIKEBDF7O5Dn98qLjP6z32Zn/mYdhnfWqg1oymWAIzdg1uPFiHmR7JPO
 b6NGbvXH2eWhUlBFU5s4S+q8y1H4NXJETqUbM61a2M5Y=
X-Received: by 2002:a05:6000:208a:b0:3e7:48ab:7660 with SMTP id
 ffacd0b85a97d-3e7659e1746mr5575179f8f.27.1757751104616; 
 Sat, 13 Sep 2025 01:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGejjOd+tvEHduwW1k3OieaDrmrbEfTNN7bEY/y5x+jC41lb04bBDfyCR7Xjur7q/8ynLWmIA==
X-Received: by 2002:a05:6000:208a:b0:3e7:48ab:7660 with SMTP id
 ffacd0b85a97d-3e7659e1746mr5575148f8f.27.1757751104061; 
 Sat, 13 Sep 2025 01:11:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e76077584esm9606312f8f.11.2025.09.13.01.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 42/61] rust: split "system" crate
Date: Sat, 13 Sep 2025 10:09:23 +0200
Message-ID: <20250913080943.11710-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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
Link: https://lore.kernel.org/r/20250827104147.717203-15-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                             |  1 +
 rust/qemu-api/wrapper.h                 |  3 --
 rust/system/wrapper.h                   | 29 +++++++++++++++++
 rust/Cargo.lock                         | 13 ++++++++
 rust/Cargo.toml                         |  1 +
 rust/bql/src/cell.rs                    |  5 ++-
 rust/hw/char/pl011/Cargo.toml           |  1 +
 rust/hw/char/pl011/meson.build          |  1 +
 rust/hw/char/pl011/src/device.rs        |  2 +-
 rust/hw/timer/hpet/Cargo.toml           |  1 +
 rust/hw/timer/hpet/meson.build          |  1 +
 rust/hw/timer/hpet/src/device.rs        | 12 +++----
 rust/meson.build                        |  1 +
 rust/qemu-api/Cargo.toml                |  1 +
 rust/qemu-api/meson.build               |  7 +++--
 rust/qemu-api/src/bindings.rs           | 14 +--------
 rust/qemu-api/src/lib.rs                |  1 -
 rust/qemu-api/src/sysbus.rs             |  2 +-
 rust/system/Cargo.toml                  | 22 +++++++++++++
 rust/system/build.rs                    |  1 +
 rust/system/meson.build                 | 42 +++++++++++++++++++++++++
 rust/system/src/bindings.rs             | 41 ++++++++++++++++++++++++
 rust/system/src/lib.rs                  |  6 ++++
 rust/{qemu-api => system}/src/memory.rs |  2 +-
 24 files changed, 177 insertions(+), 33 deletions(-)
 create mode 100644 rust/system/wrapper.h
 create mode 100644 rust/system/Cargo.toml
 create mode 120000 rust/system/build.rs
 create mode 100644 rust/system/meson.build
 create mode 100644 rust/system/src/bindings.rs
 create mode 100644 rust/system/src/lib.rs
 rename rust/{qemu-api => system}/src/memory.rs (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cac6dcdc658..432ed513545 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3523,6 +3523,7 @@ F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/qom/
 F: rust/rustfmt.toml
+F: rust/system/
 F: rust/util/
 F: scripts/get-wraps-from-cargo-registry.py
 
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 07dbc9987a8..564733b9035 100644
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
index 00000000000..48abde85052
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
index ae852c55508..e6b75f30bef 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -95,6 +95,7 @@ dependencies = [
  "qemu_api",
  "qemu_api_macros",
  "qom",
+ "system",
  "util",
 ]
 
@@ -136,6 +137,7 @@ dependencies = [
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
index 0516c16591c..8e210d277a2 100644
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
index 25007427edc..24ab294b60d 100644
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
index f7ad5f8e08f..e4b1c3f1eb8 100644
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
index aaf911c5f42..fae6e1b9c9d 100644
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
index bc64061fb39..c65db5a5174 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,12 +13,12 @@
 };
 use qemu_api::{
     irq::{IRQState, InterruptSource},
-    memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
 };
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
+use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
 use util::{log::Log, log_mask_ln};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index 19456ec72b5..a95b1271c64 100644
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
index 50ccdee4a93..c4ffe020f6b 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -11,6 +11,7 @@ _libhpet_rs = static_library(
     bql_rs,
     qemu_api_macros,
     qom_rs,
+    system_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 404569aa2de..841c2ba3375 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -17,19 +17,17 @@
     VMStateDescription, VMStateDescriptionBuilder,
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
 use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
+use system::{
+    bindings::{address_space_memory, address_space_stl_le, hwaddr},
+    MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+};
 use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
 use crate::fw_cfg::HPETFwConfig;
diff --git a/rust/meson.build b/rust/meson.build
index 4d9e2912232..d8b71f55061 100644
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
index 3bf2dafa6df..2884c1d460b 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -20,6 +20,7 @@ migration = { path = "../migration" }
 util = { path = "../util" }
 bql = { path = "../bql" }
 qom = { path = "../qom" }
+system = { path = "../system" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 
 [lints]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a47f178b698..92e2581a64e 100644
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
@@ -65,7 +66,7 @@ _qemu_api_rs = static_library(
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
   dependencies: [anyhow_rs, bql_rs, chardev_rs, common_rs, foreign_rs, libc_rs, migration_rs, qemu_api_macros,
-                 qom_rs, util_rs, hwcore],
+                 qom_rs, system_rs, util_rs, hwcore],
 )
 
 qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 526bcf8e31b..63b805c76e4 100644
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
index d96096899d0..8d574404789 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -14,7 +14,6 @@
 pub mod prelude;
 
 pub mod irq;
-pub mod memory;
 pub mod qdev;
 pub mod sysbus;
 
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index b883d7eaf18..dda71ebda70 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -9,11 +9,11 @@
 pub use bindings::SysBusDeviceClass;
 use common::Opaque;
 use qom::{prelude::*, Owned};
+use system::MemoryRegion;
 
 use crate::{
     bindings,
     irq::{IRQState, InterruptSource},
-    memory::MemoryRegion,
     qdev::{DeviceImpl, DeviceState},
 };
 
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
new file mode 100644
index 00000000000..6803895e080
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
new file mode 120000
index 00000000000..71a3167885c
--- /dev/null
+++ b/rust/system/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/system/meson.build b/rust/system/meson.build
new file mode 100644
index 00000000000..ae9b932d29d
--- /dev/null
+++ b/rust/system/meson.build
@@ -0,0 +1,42 @@
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
+  link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
+  dependencies: [common_rs, qemu_api_macros],
+)
+
+system_rs = declare_dependency(link_with: [_system_rs],
+  dependencies: [qemu_api_macros, hwcore])
diff --git a/rust/system/src/bindings.rs b/rust/system/src/bindings.rs
new file mode 100644
index 00000000000..43edd98807a
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
index 00000000000..aafe9a866c9
--- /dev/null
+++ b/rust/system/src/lib.rs
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub mod bindings;
+
+mod memory;
+pub use memory::*;
diff --git a/rust/qemu-api/src/memory.rs b/rust/system/src/memory.rs
similarity index 99%
rename from rust/qemu-api/src/memory.rs
rename to rust/system/src/memory.rs
index ecbbd9b6046..29568ed7676 100644
--- a/rust/qemu-api/src/memory.rs
+++ b/rust/system/src/memory.rs
@@ -9,11 +9,11 @@
     marker::PhantomData,
 };
 
-pub use bindings::{hwaddr, MemTxAttrs};
 use common::{callbacks::FnCall, uninit::MaybeUninitField, zeroable::Zeroable, Opaque};
 use qom::prelude::*;
 
 use crate::bindings::{self, device_endian, memory_region_init_io};
+pub use crate::bindings::{hwaddr, MemTxAttrs};
 
 pub struct MemoryRegionOps<T>(
     bindings::MemoryRegionOps,
-- 
2.51.0


