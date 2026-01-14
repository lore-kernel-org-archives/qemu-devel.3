Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E43D37E37
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1Fg-0008JK-Qx; Wed, 14 Jan 2026 08:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1Ff-0008Gb-5D
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1Fd-0002Gt-2h
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768398571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pY1hxDGlHJnTX02EQhzRBcSZ2T5rcDS1TiA2uBU1QQY=;
 b=P3G4H5ERPKJdMGIN+lklaHxmMx+Ur/tWSLN6YbmGy0sIMziZHyL2+rwsoYZ5BifGYvXtgc
 b5BIAF7/rI9L59JwrOuCcvunka2zH11VX0ASTQTRV+MT/qJ5ZjAjNnHKMITc6VtmAd7MLw
 7r8ZQWAsF2HvlGyq+OeMX2dkTNhY2yk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-rLPg_rviNpSfUkeNfke7Ug-1; Wed, 14 Jan 2026 08:49:30 -0500
X-MC-Unique: rLPg_rviNpSfUkeNfke7Ug-1
X-Mimecast-MFC-AGG-ID: rLPg_rviNpSfUkeNfke7Ug_1768398569
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d3c9b8c56so89551215e9.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 05:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768398568; x=1769003368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pY1hxDGlHJnTX02EQhzRBcSZ2T5rcDS1TiA2uBU1QQY=;
 b=AOKyKAai9j6mHWuP/wrdTXMtTzPJ9D4NOMufMjyCkiLBsz87O8NRO/jZtk8Xa5HEdZ
 1Je7DDE46tXU1b0e4LaNQYwYcU1sPxsmsMT8I5qNuglTh4V6P0YJJL4dGa/9sK7Qu+3/
 fe3hEt5k4sEEdsXVya+jXVLCADiGOBt2zR76oWA2HkhZ67vu4j4e4Sa3cEKr1GnEVQbM
 o/mKgYKQjgUUSH0/4+AnWx0bxS9OIgERdx22Ltis9mA8pdHrEFVcKi4ffup8l15cOV2b
 07SVyJ+BFtwQIIoqvdLzg1SYBYLVLfitxWxgrPv74zyYpymWb5nREXUE1igmnL+E/eta
 z3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768398568; x=1769003368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pY1hxDGlHJnTX02EQhzRBcSZ2T5rcDS1TiA2uBU1QQY=;
 b=L8NwzryzPMMgwrKwSe3Kx0dLyyrxbbL+iLoKO/pryEHZHUrMYB7IEQliAokv51CUYl
 0Jo4hpiwqQDc5t57OLI/IUDCx/TnKk4k7ZzZdZ3mo5yzvBydAgDn6XIjxd6Dow06Rq0W
 jGH2aAlQsBFuMR9dk0wsFxXmUwQt8FK53Piax1TKkKKHcLEVDAXfTcpugFBpAXHgJuqs
 c6hSrxl76NDXKnXTvM8izk9DAdqKZUmsmOMYXaLoBqyvExZj6s47sT/uIvzdHvkYEt6g
 5WYmnlNL7af2zxZZIqXeR/Uq0/b3pSTeXtLKwjBjR9QrrKAm6SX4RNnuc9LU28BrIhym
 wYrg==
X-Gm-Message-State: AOJu0YzplGwRk9fLX2Fq/1xKUsiZcqR/irVpvHkdkMsPHG3FwCJtPGg8
 Kdqrr7q8AUBpSnva8VuKC4UUsnvxocOIt8Vlafg69Yv2Mxe5zlZ0bR1IECiJAq5zGjfUcUZRD9d
 POR1yoz2rAuZoBW21Ru+1RR8a2wOca9m06x06HjpPWd82aPoM2BXty1T7fjfGA8tOlhhjZX+YYo
 Ph76kULAEx1Ua4mEaTKnIWQmuD9i0907LDhf+FAGkP
X-Gm-Gg: AY/fxX7J9keqejox4qy5r5m4h12QGSlFxKqRPpPa3SsVTkIOFP7S36/p5W9Nt2O876T
 Tamb4LBNA0G+elkS7OzuueueqfKXZfS6lb8HEKAxxXLMtS4zqY+LsDhRLeot+X1DdJCVBy7nHyI
 dpBzroUp3xK4BKicwzXQehzY9ugq1BBTbgmwxpt7lxIzKEJ55X7lFP5NLl8TVB14YQk/EVg1C9v
 YCOJdqEw4sTYxkA3lNwp3OnlMYwCxLu47bw7A49BUW2qzt3BAAD+YMYbXEIyz3jJIcYvjA9Ymr0
 EZRoOto8j4SwkJBxmjcsrVnPPOtntPwN6AAsUeBkXbNL7VyI0Wdkn7D+LrTknnZapPfe56T1Ihx
 H6Rq4MpPLv7eibW1xDbGTml+HVBgo3KloRU8Ivbvg8EPALP4+buViCtzS1pcN1OHmLOWxvufKvj
 0YhBY7YfkOJQllrQ==
X-Received: by 2002:a05:600c:528f:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47ee330fd26mr29192915e9.9.1768398568158; 
 Wed, 14 Jan 2026 05:49:28 -0800 (PST)
X-Received: by 2002:a05:600c:528f:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47ee330fd26mr29192525e9.9.1768398567566; 
 Wed, 14 Jan 2026 05:49:27 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee563ce5fsm29464335e9.13.2026.01.14.05.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 05:49:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 3/3] rust: move hwcore::sysbus to system crate
Date: Wed, 14 Jan 2026 14:49:19 +0100
Message-ID: <20260114134919.1476518-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114134919.1476518-1-pbonzini@redhat.com>
References: <20260114134919.1476518-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This inverts the dependency from hwcore to system, replacing it with
a dependency from system to hwcore.  It also matches how hw/core/sysbus.h
is part of the system-sys crate, and hw/core/sysbus.c is part of system_ss
on the C side.

This fixes a linker error in hwcore integration tests on msys2.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/core/Cargo.toml                | 1 -
 rust/hw/core/meson.build               | 2 +-
 rust/hw/core/src/irq.rs                | 4 ++--
 rust/hw/core/src/lib.rs                | 3 ---
 rust/hw/core/src/prelude.rs            | 5 -----
 rust/hw/core/tests/tests.rs            | 4 ++--
 rust/meson.build                       | 2 +-
 rust/system/Cargo.toml                 | 1 +
 rust/system/meson.build                | 2 +-
 rust/system/src/lib.rs                 | 3 +++
 rust/system/src/prelude.rs             | 5 +++++
 rust/{hw/core => system}/src/sysbus.rs | 7 ++-----
 12 files changed, 18 insertions(+), 21 deletions(-)
 rename rust/{hw/core => system}/src/sysbus.rs (96%)

diff --git a/rust/hw/core/Cargo.toml b/rust/hw/core/Cargo.toml
index 8cc514da202..d1ff71d5c37 100644
--- a/rust/hw/core/Cargo.toml
+++ b/rust/hw/core/Cargo.toml
@@ -21,7 +21,6 @@ bql = { path = "../../bql" }
 qom = { path = "../../qom" }
 chardev = { path = "../../chardev" }
 migration = { path = "../../migration" }
-system = { path = "../../system" }
 util = { path = "../../util" }
 
 [lints]
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 28ea00cdb4f..6d1bfd4d204 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -3,7 +3,7 @@ _hwcore_rs = static_library(
   'src/lib.rs',
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _system_rs, _util_rs],
+  link_with: [_bql_rs, _chardev_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, qemu_macros, common_rs, hwcore_sys_rs],
 )
 
diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
index e0d7784d97b..2a1ac9e6264 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -87,11 +87,11 @@ pub fn set(&self, level: T) {
         }
     }
 
-    pub(crate) const fn as_ptr(&self) -> *mut *mut bindings::IRQState {
+    pub const fn as_ptr(&self) -> *mut *mut bindings::IRQState {
         self.cell.as_ptr()
     }
 
-    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQState {
+    pub const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQState {
         assert!(!slice.is_empty());
         slice[0].as_ptr()
     }
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index 76689fe7db1..6701dc52b65 100644
--- a/rust/hw/core/src/lib.rs
+++ b/rust/hw/core/src/lib.rs
@@ -14,6 +14,3 @@
 
 mod qdev;
 pub use qdev::*;
-
-mod sysbus;
-pub use sysbus::*;
diff --git a/rust/hw/core/src/prelude.rs b/rust/hw/core/src/prelude.rs
index 13f7dfc6809..45e86e178b1 100644
--- a/rust/hw/core/src/prelude.rs
+++ b/rust/hw/core/src/prelude.rs
@@ -9,9 +9,4 @@
 pub use crate::qdev::ResettablePhasesImpl;
 pub use crate::qdev::ResetType;
 
-pub use crate::sysbus::SysBusDevice;
-pub use crate::sysbus::SysBusDeviceClassExt;
-pub use crate::sysbus::SysBusDeviceImpl;
-pub use crate::sysbus::SysBusDeviceMethods;
-
 pub use crate::irq::InterruptSource;
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 115dd7a860d..05aa5d4a377 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -142,7 +142,7 @@ fn test_cast() {
     let obj_ref: &Object = p_ref.upcast();
     assert_eq!(addr_of!(*obj_ref), p_ptr.cast());
 
-    let sbd_ref: Option<&SysBusDevice> = obj_ref.dynamic_cast();
+    let sbd_ref: Option<&DummyChildState> = obj_ref.dynamic_cast();
     assert!(sbd_ref.is_none());
 
     let dev_ref: Option<&DeviceState> = obj_ref.downcast();
@@ -150,7 +150,7 @@ fn test_cast() {
 
     // SAFETY: the cast is wrong, but the value is only used for comparison
     unsafe {
-        let sbd_ref: &SysBusDevice = obj_ref.unsafe_cast();
+        let sbd_ref: &DummyChildState = obj_ref.unsafe_cast();
         assert_eq!(addr_of!(*sbd_ref), p_ptr.cast());
     }
 }
diff --git a/rust/meson.build b/rust/meson.build
index 3a3e10d7b97..b6711fe77dd 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -42,9 +42,9 @@ subdir('util')
 subdir('bql')
 subdir('migration')
 subdir('qom')
-subdir('system')
 subdir('chardev')
 subdir('hw/core')
+subdir('system')
 subdir('tests')
 subdir('trace')
 subdir('hw')
diff --git a/rust/system/Cargo.toml b/rust/system/Cargo.toml
index f7fde9782ea..d6217370317 100644
--- a/rust/system/Cargo.toml
+++ b/rust/system/Cargo.toml
@@ -16,6 +16,7 @@ rust-version.workspace = true
 common = { path = "../common" }
 system-sys = { path = "../bindings/system-sys" }
 bql = { path = "../bql" }
+hwcore = { path = "../hw/core" }
 migration = { path = "../migration" }
 qom = { path = "../qom" }
 util = { path = "../util" }
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 4cbd63cbbd7..89c1f2b84d1 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -1,7 +1,7 @@
 _system_rs = static_library(
   'system',
   'src/lib.rs',
-  link_with: [_bql_rs, _migration_rs, _qom_rs, _util_rs],
+  link_with: [_bql_rs, _hwcore_rs, _migration_rs, _qom_rs, _util_rs],
   dependencies: [glib_sys_rs, common_rs, qemu_macros, system_sys_rs],
 )
 
diff --git a/rust/system/src/lib.rs b/rust/system/src/lib.rs
index 10741e0ee0a..3b1666e62ce 100644
--- a/rust/system/src/lib.rs
+++ b/rust/system/src/lib.rs
@@ -9,3 +9,6 @@
 // for prelude-like modules
 #[rustfmt::skip]
 pub mod prelude;
+
+mod sysbus;
+pub use sysbus::*;
diff --git a/rust/system/src/prelude.rs b/rust/system/src/prelude.rs
index 2d98524c36e..5a8688ca343 100644
--- a/rust/system/src/prelude.rs
+++ b/rust/system/src/prelude.rs
@@ -6,3 +6,8 @@
 pub use crate::memory::MemoryRegionOps;
 pub use crate::memory::MemoryRegionOpsBuilder;
 pub use crate::memory::MemTxAttrs;
+
+pub use crate::sysbus::SysBusDevice;
+pub use crate::sysbus::SysBusDeviceClassExt;
+pub use crate::sysbus::SysBusDeviceImpl;
+pub use crate::sysbus::SysBusDeviceMethods;
diff --git a/rust/hw/core/src/sysbus.rs b/rust/system/src/sysbus.rs
similarity index 96%
rename from rust/hw/core/src/sysbus.rs
rename to rust/system/src/sysbus.rs
index 7db09a82c63..3c9aff51be0 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/system/src/sysbus.rs
@@ -7,15 +7,12 @@
 use std::ffi::CStr;
 
 use common::Opaque;
+use hwcore::{prelude::*, IRQState};
 use qom::prelude::*;
-use system::MemoryRegion;
 pub use system_sys::SysBusDeviceClass;
 use util::{Error, Result};
 
-use crate::{
-    irq::{IRQState, InterruptSource},
-    qdev::{DeviceClassExt, DeviceImpl, DeviceState},
-};
+use crate::MemoryRegion;
 
 /// A safe wrapper around [`system_sys::SysBusDevice`].
 #[repr(transparent)]
-- 
2.52.0


