Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED34CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLMe-0000eF-N6; Sat, 13 Sep 2025 04:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLMF-00004x-HF
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLM9-00056s-O3
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lTJX030jGIXxdWLIHlrJmsv7ikGBg/AznKP+WA/tsVA=;
 b=DUdhPi2JmRDIQ/KFdKMGgSWKdt2NTC/8JPyBX/BdX58YgrHDimcotNHNYekiQCHKyfCyMi
 UfHr8mKGtuOoN2rLPqernP4lEl5QzefhOcVf++yxA7hTMgLSpcIAeI1acnqZ3ar8KFSGV4
 2KErD6Pap+ZaDECQkFEk4NDIu9Slk7k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-dVLlLauFOVGWBERCAOb1Eg-1; Sat, 13 Sep 2025 04:11:35 -0400
X-MC-Unique: dVLlLauFOVGWBERCAOb1Eg-1
X-Mimecast-MFC-AGG-ID: dVLlLauFOVGWBERCAOb1Eg_1757751094
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de18e7eccso14187955e9.0
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751094; x=1758355894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTJX030jGIXxdWLIHlrJmsv7ikGBg/AznKP+WA/tsVA=;
 b=SmPAjmKlqovubJNDRpSxQ3psziosNujmwftM+2trtsPaYJXIJrhLZTuEz/ws/d/wHK
 q5idy7vr49ItxcDLztHc0kRja3KWSa0t1OSJoqR9W8DCQyoWfcTaE+bE0TJUqTjQxxnK
 7vgaIfDUgjKR/6mJXgVoJWzDRQ0XdPzSar9JmpXvjFGgto411qob5hHpSjSgxNxIFSmm
 TiWhgpabUftftWNb9wnYKwFoudzPk6KaI8cMUs9KWVZR0cCLZeP9mp2iuTYEv9TRwne/
 Ti2fDEoyLPYeDxhFQ5N2MMGgui6km6JXt8DAW+FWzRwgoUXpkF86m5CEeVaoJJ/I/L6Q
 LXqw==
X-Gm-Message-State: AOJu0Yx1N7FYIKCGXUGZnv7kTbVJCavngJs2+2B0K0P73wRv9knRDd3J
 iMw/73Irw+6UOA3C/RFrKJeyCEheVKmcpsP3E4DoRMnc8LifNb+m2b1WlAz3gfpYws3V5vGfybI
 d7lEoFSM/YsBmnEn2aDOypRvGoZ4ZX5OytLIUGj+Ifzm6ol4rHKgn6m3C+ATeiN38Z37VFGqI8U
 c3yrBQHenGxMQeI3/uIl121T6KlJECnJZ1nQr2oCbf
X-Gm-Gg: ASbGnctxm8u9Zm2oGkVsUp3rwD7XiH4mrqE11KhM68S4hRZX7r0tu6x8bhLY0eaD+Ve
 l1KPm0AW9qkCcqGRjlVTbPCymRDWNM+8xsLdr4prwjR8HmTnPJBonQQQqa/41iNmlMmuV1U5cC3
 Rdv/t31JgP+kFGKhtjfpcaDztMIkg54YwRkJhy4/40aLnxEVkbGc5libDq3IIVRdxr/EcjcMcJi
 cAOs1ji7x3dbw76U/ZS2bwP7OH7MC0W6Gfeh4lTAZQhA3+xKODili0hd+PBbbnfnSPrxYt8gEnB
 HSbt5X0ZjIc9waCiS9IJk5wo5X9o1Dze+D7OaxqnxKFKZT152C/UaTht9yF9H5sDZKvSQ6k1ERE
 yudi4pHm4HzhEsEZUs6eWxV80DWA9a8Dm0WBHbuQeOyo=
X-Received: by 2002:a05:600c:8a1b:20b0:45d:d3a1:70dd with SMTP id
 5b1f17b1804b1-45f21221e50mr40102685e9.35.1757751093065; 
 Sat, 13 Sep 2025 01:11:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq26x+xmjoGayu35ffcrnB0QRQ0/MjzPvc4yOIcBq3MHhlQbdpVEhGuSh1wb5nYsKlUuUjqA==
X-Received: by 2002:a05:600c:8a1b:20b0:45d:d3a1:70dd with SMTP id
 5b1f17b1804b1-45f21221e50mr40102385e9.35.1757751092291; 
 Sat, 13 Sep 2025 01:11:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e016b5cbcsm93547525e9.11.2025.09.13.01.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 38/61] rust: split "migration" crate
Date: Sat, 13 Sep 2025 10:09:19 +0200
Message-ID: <20250913080943.11710-39-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20250827104147.717203-11-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                 |  1 +
 rust/migration/wrapper.h                    | 51 ++++++++++++++++++++
 rust/qemu-api/wrapper.h                     |  1 -
 rust/Cargo.lock                             | 12 +++++
 rust/Cargo.toml                             |  1 +
 rust/hw/char/pl011/Cargo.toml               |  1 +
 rust/hw/char/pl011/meson.build              |  1 +
 rust/hw/char/pl011/src/device.rs            | 13 ++---
 rust/hw/char/pl011/src/registers.rs         |  2 +-
 rust/hw/timer/hpet/Cargo.toml               |  1 +
 rust/hw/timer/hpet/meson.build              |  1 +
 rust/hw/timer/hpet/src/device.rs            | 11 +++--
 rust/meson.build                            |  1 +
 rust/migration/Cargo.toml                   | 21 ++++++++
 rust/migration/build.rs                     |  1 +
 rust/migration/meson.build                  | 53 +++++++++++++++++++++
 rust/migration/src/bindings.rs              | 48 +++++++++++++++++++
 rust/migration/src/lib.rs                   |  6 +++
 rust/{qemu-api => migration}/src/vmstate.rs | 42 +++++++++-------
 rust/qemu-api/Cargo.toml                    |  1 +
 rust/qemu-api/meson.build                   | 12 ++---
 rust/qemu-api/src/bindings.rs               | 21 +-------
 rust/qemu-api/src/cell.rs                   |  4 +-
 rust/qemu-api/src/lib.rs                    |  1 -
 rust/qemu-api/src/prelude.rs                |  2 -
 rust/qemu-api/src/qdev.rs                   |  3 +-
 rust/qemu-api/src/qom.rs                    |  2 +-
 rust/qemu-api/tests/tests.rs                |  2 +-
 rust/qemu-api/tests/vmstate_tests.rs        |  4 +-
 29 files changed, 252 insertions(+), 68 deletions(-)
 create mode 100644 rust/migration/wrapper.h
 create mode 100644 rust/migration/Cargo.toml
 create mode 120000 rust/migration/build.rs
 create mode 100644 rust/migration/meson.build
 create mode 100644 rust/migration/src/bindings.rs
 create mode 100644 rust/migration/src/lib.rs
 rename rust/{qemu-api => migration}/src/vmstate.rs (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d7b47873f8..76dcf6ceb23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3516,6 +3516,7 @@ Rust
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 S: Maintained
 F: rust/common/
+F: rust/migration/
 F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
diff --git a/rust/migration/wrapper.h b/rust/migration/wrapper.h
new file mode 100644
index 00000000000..daf316aed41
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
index cc7112406b2..b99df9f568a 100644
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
index 757c03cbdec..048dd74757f 100644
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
@@ -141,6 +152,7 @@ name = "qemu_api"
 version = "0.1.0"
 dependencies = [
  "common",
+ "migration",
  "qemu_api_macros",
  "util",
 ]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index cfdd535e3bd..e0958ef28a8 100644
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
index 0cf9943fe86..7fd7531823d 100644
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
index 8a931a4d03d..2198fcee9bc 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -10,6 +10,7 @@ _libpl011_rs = static_library(
     common_rs,
     qemu_api_rs,
     util_rs,
+    migration_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ab38d57fc41..225be34e08b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,17 +5,18 @@
 use std::{ffi::CStr, mem::size_of};
 
 use common::{static_assert, uninit_field_mut};
+use migration::{
+    self, impl_vmstate_forward, impl_vmstate_struct, vmstate_fields, vmstate_of,
+    vmstate_subsections, vmstate_unused, VMStateDescription, VMStateDescriptionBuilder,
+};
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
-    impl_vmstate_forward, impl_vmstate_struct,
     irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, Owned, ParentField, ParentInit},
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
-    vmstate_fields, vmstate_of, vmstate_subsections, vmstate_unused,
 };
 use util::{log::Log, log_mask_ln};
 
@@ -458,10 +459,10 @@ pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         false
     }
 
-    pub fn post_load(&mut self) -> Result<(), vmstate::InvalidError> {
+    pub fn post_load(&mut self) -> Result<(), migration::InvalidError> {
         /* Sanity-check input state */
         if self.read_pos >= self.read_fifo.len() || self.read_count > self.read_fifo.len() {
-            return Err(vmstate::InvalidError);
+            return Err(migration::InvalidError);
         }
 
         if !self.fifo_enabled() && self.read_count > 0 && self.read_pos > 0 {
@@ -640,7 +641,7 @@ fn update(&self) {
         }
     }
 
-    pub fn post_load(&self, _version_id: u8) -> Result<(), vmstate::InvalidError> {
+    pub fn post_load(&self, _version_id: u8) -> Result<(), migration::InvalidError> {
         self.regs.borrow_mut().post_load()
     }
 }
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index 7ececd39f86..2bfbd81095e 100644
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
index dd9a5ed3d43..70acdf03d6e 100644
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
index ca09660bf47..8cd70091e63 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -7,6 +7,7 @@ _libhpet_rs = static_library(
     common_rs,
     qemu_api_rs,
     util_rs,
+    migration_rs,
     qemu_api_macros,
   ],
 )
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 2be180fdedd..1c2253466d9 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -11,13 +11,16 @@
 };
 
 use common::{bitops::IntegerExt, uninit_field_mut};
+use migration::{
+    self, impl_vmstate_struct, vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
+    VMStateDescription, VMStateDescriptionBuilder,
+};
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
         qdev_prop_uint32, qdev_prop_usize,
     },
     cell::{BqlCell, BqlRefCell},
-    impl_vmstate_struct,
     irq::InterruptSource,
     memory::{
         hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
@@ -27,8 +30,6 @@
     qom::{ObjectImpl, ObjectType, ParentField, ParentInit},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    vmstate::{self, VMStateDescription, VMStateDescriptionBuilder},
-    vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
 };
 use util::timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND};
 
@@ -845,7 +846,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
         }
     }
 
-    fn pre_save(&self) -> Result<(), vmstate::Infallible> {
+    fn pre_save(&self) -> Result<(), migration::Infallible> {
         if self.is_hpet_enabled() {
             self.counter.set(self.get_ticks());
         }
@@ -859,7 +860,7 @@ fn pre_save(&self) -> Result<(), vmstate::Infallible> {
         Ok(())
     }
 
-    fn post_load(&self, _version_id: u8) -> Result<(), vmstate::Infallible> {
+    fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
 
diff --git a/rust/meson.build b/rust/meson.build
index a9d715e6e94..826949b2e60 100644
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
index 00000000000..98e6df2109d
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
index 00000000000..71a3167885c
--- /dev/null
+++ b/rust/migration/build.rs
@@ -0,0 +1 @@
+../util/build.rs
\ No newline at end of file
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
new file mode 100644
index 00000000000..5e820d43f50
--- /dev/null
+++ b/rust/migration/meson.build
@@ -0,0 +1,53 @@
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
+  link_with: [_util_rs],
+  dependencies: [common_rs],
+)
+
+migration_rs = declare_dependency(link_with: [_migration_rs],
+  dependencies: [migration, qemuutil])
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
index 00000000000..8ce13a9000e
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
index 00000000000..5f51dde4406
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
similarity index 95%
rename from rust/qemu-api/src/vmstate.rs
rename to rust/migration/src/vmstate.rs
index 37e47cc4c6f..537d54e4368 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -52,7 +52,7 @@
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::call_func_with_field;
+/// # use migration::call_func_with_field;
 /// # use core::marker::PhantomData;
 /// const fn size_of_field<T>(_: PhantomData<T>) -> usize {
 ///     std::mem::size_of::<T>()
@@ -125,17 +125,19 @@ pub const fn vmstate_varray_flag<T: VMState>(_: PhantomData<T>) -> VMStateFlags
 /// * scalar types (integer and `bool`)
 /// * the C struct `QEMUTimer`
 /// * a transparent wrapper for any of the above (`Cell`, `UnsafeCell`,
-///   [`BqlCell`](crate::cell::BqlCell),
-///   [`BqlRefCell`](crate::cell::BqlRefCell)),
+///   [`BqlCell`], [`BqlRefCell`])
 /// * a raw pointer to any of the above
-/// * a `NonNull` pointer, a `Box` or an [`Owned`](crate::qom::Owned) for any of
-///   the above
+/// * a `NonNull` pointer, a `Box` or an [`Owned`] for any of the above
 /// * an array of any of the above
 ///
 /// In order to support other types, the trait `VMState` must be implemented
 /// for them.  The macros [`impl_vmstate_forward`](crate::impl_vmstate_forward),
 /// [`impl_vmstate_bitsized`](crate::impl_vmstate_bitsized), and
 /// [`impl_vmstate_struct`](crate::impl_vmstate_struct) help with this.
+///
+/// [`BqlCell`]: ../../qemu_api/cell/struct.BqlCell.html
+/// [`BqlRefCell`]: ../../qemu_api/cell/struct.BqlRefCell.html
+/// [`Owned`]: ../../qemu_api/qom/struct.Owned.html
 #[macro_export]
 macro_rules! vmstate_of {
     ($struct_name:ty, $field_name:ident $([0 .. $num:ident $(* $factor:expr)?])? $(, $test_fn:expr)? $(,)?) => {
@@ -161,7 +163,11 @@ macro_rules! vmstate_of {
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
@@ -207,7 +213,7 @@ pub const fn with_pointer_flag(mut self) -> Self {
     }
 
     #[must_use]
-    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> VMStateField {
+    pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> Self {
         self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_ARRAY.0);
         self.flags = VMStateFlags(self.flags.0 | flag.0);
         self.num = 0; // varray uses num_offset instead of num.
@@ -216,13 +222,13 @@ pub const fn with_varray_flag_unchecked(mut self, flag: VMStateFlags) -> VMState
 
     #[must_use]
     #[allow(unused_mut)]
-    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> VMStateField {
+    pub const fn with_varray_flag(mut self, flag: VMStateFlags) -> Self {
         assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) != 0);
         self.with_varray_flag_unchecked(flag)
     }
 
     #[must_use]
-    pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
+    pub const fn with_varray_multiply(mut self, num: u32) -> Self {
         assert!(num <= 0x7FFF_FFFFu32);
         self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_MULTIPLY_ELEMENTS.0);
         self.num = num as i32;
@@ -237,7 +243,7 @@ pub const fn with_varray_multiply(mut self, num: u32) -> VMStateField {
 /// # Examples
 ///
 /// ```
-/// # use qemu_api::impl_vmstate_forward;
+/// # use migration::impl_vmstate_forward;
 /// pub struct Fifo([u8; 16]);
 /// impl_vmstate_forward!(Fifo);
 /// ```
@@ -272,7 +278,7 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
 impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
-impl_vmstate_transparent!(::common::Opaque<T> where T: VMState);
+impl_vmstate_transparent!(common::Opaque<T> where T: VMState);
 
 #[macro_export]
 macro_rules! impl_vmstate_bitsized {
@@ -294,12 +300,12 @@ unsafe impl $crate::vmstate::VMState for $type {
 
 macro_rules! impl_vmstate_scalar {
     ($info:ident, $type:ty$(, $varray_flag:ident)?) => {
-        unsafe impl VMState for $type {
-            const BASE: VMStateField = VMStateField {
+        unsafe impl $crate::vmstate::VMState for $type {
+            const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
                 info: addr_of!(bindings::$info),
                 size: mem::size_of::<$type>(),
-                flags: VMStateFlags::VMS_SINGLE,
-                ..Zeroable::ZERO
+                flags: $crate::vmstate::VMStateFlags::VMS_SINGLE,
+                ..::common::zeroable::Zeroable::ZERO
             };
             $(const VARRAY_FLAG: VMStateFlags = VMStateFlags::$varray_flag;)?
         }
@@ -320,12 +326,12 @@ unsafe impl VMState for $type {
 #[macro_export]
 macro_rules! impl_vmstate_c_struct {
     ($type:ty, $vmsd:expr) => {
-        unsafe impl VMState for $type {
+        unsafe impl $crate::vmstate::VMState for $type {
             const BASE: $crate::bindings::VMStateField = $crate::bindings::VMStateField {
                 vmsd: ::std::ptr::addr_of!($vmsd),
                 size: ::std::mem::size_of::<$type>(),
                 flags: $crate::bindings::VMStateFlags::VMS_STRUCT,
-                ..common::zeroable::Zeroable::ZERO
+                ..::common::zeroable::Zeroable::ZERO
             };
         }
     };
@@ -391,7 +397,7 @@ pub extern "C" fn rust_vms_test_field_exists<T, F: for<'a> FnCall<(&'a T, u8), b
 #[macro_export]
 macro_rules! vmstate_exist_fn {
     ($struct_name:ty, $test_fn:expr) => {{
-        const fn test_cb_builder__<T, F: for<'a> ::common::callbacks::FnCall<(&'a T, u8), bool>>(
+        const fn test_cb_builder__<T, F: for<'a> ::common::FnCall<(&'a T, u8), bool>>(
             _phantom: ::core::marker::PhantomData<F>,
         ) -> $crate::vmstate::VMSFieldExistCb {
             const { assert!(F::IS_SOME) };
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index fbfb894421d..7276e67aa97 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 
 [dependencies]
 common = { path = "../common" }
+migration = { path = "../migration" }
 util = { path = "../util" }
 qemu_api_macros = { path = "../qemu-api-macros" }
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 7734f656a26..a6b5772d194 100644
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
@@ -60,15 +59,14 @@ _qemu_api_rs = static_library(
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
-  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, qemu_api_macros, util_rs,
-                 qom, hwcore, chardev, migration],
+  dependencies: [anyhow_rs, common_rs, foreign_rs, libc_rs, migration_rs, qemu_api_macros,
+                 util_rs, qom, hwcore, chardev],
 )
 
 qemu_api_rs = declare_dependency(link_with: [_qemu_api_rs],
@@ -90,7 +88,7 @@ test('rust-qemu-api-integration',
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
         rust_args: ['--test'],
         install: false,
-        dependencies: [common_rs, util_rs, qemu_api_rs]),
+        dependencies: [common_rs, util_rs, migration_rs, qemu_api_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index aedf42b652c..ce00a6e0e4c 100644
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
index d13848df200..b80a0fd80b7 100644
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
index 54b252fb2c5..55386f66978 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -20,7 +20,6 @@
 pub mod qdev;
 pub mod qom;
 pub mod sysbus;
-pub mod vmstate;
 
 // Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this
 // crate).
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 3d771481e40..c10c1711581 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -21,5 +21,3 @@
 pub use crate::qom_isa;
 
 pub use crate::sysbus::SysBusDeviceMethods;
-
-pub use crate::vmstate::VMState;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index d87479ce13b..c81ae7cf45c 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -11,17 +11,16 @@
 
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use common::{callbacks::FnCall, Opaque};
+use migration::{impl_vmstate_c_struct, VMStateDescription};
 use util::{Error, Result};
 
 use crate::{
     bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     cell::bql_locked,
     chardev::Chardev,
-    impl_vmstate_c_struct,
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned, ParentInit},
-    vmstate::VMStateDescription,
 };
 
 /// A safe wrapper around [`bindings::Clock`].
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 49b4f03ccfc..7f2f7797e44 100644
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
index 70ef4a80d57..92e3534d3c1 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -4,13 +4,13 @@
 
 use std::{ffi::CStr, ptr::addr_of};
 
+use migration::{VMStateDescription, VMStateDescriptionBuilder};
 use qemu_api::{
     cell::{self, BqlCell},
     prelude::*,
     qdev::{DeviceImpl, DeviceState, ResettablePhasesImpl},
     qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
-    vmstate::{VMStateDescription, VMStateDescriptionBuilder},
 };
 use util::bindings::{module_call_init, module_init_type};
 
diff --git a/rust/qemu-api/tests/vmstate_tests.rs b/rust/qemu-api/tests/vmstate_tests.rs
index d9e5bcc4987..47fc15149b4 100644
--- a/rust/qemu-api/tests/vmstate_tests.rs
+++ b/rust/qemu-api/tests/vmstate_tests.rs
@@ -10,16 +10,16 @@
 };
 
 use common::Opaque;
-use qemu_api::{
+use migration::{
     bindings::{
         vmstate_info_bool, vmstate_info_int32, vmstate_info_int64, vmstate_info_int8,
         vmstate_info_uint64, vmstate_info_uint8, vmstate_info_unused_buffer, VMStateFlags,
     },
-    cell::BqlCell,
     impl_vmstate_forward, impl_vmstate_struct,
     vmstate::{VMStateDescription, VMStateDescriptionBuilder, VMStateField},
     vmstate_fields, vmstate_of, vmstate_unused, vmstate_validate,
 };
+use qemu_api::cell::BqlCell;
 
 const FOO_ARRAY_MAX: usize = 3;
 
-- 
2.51.0


