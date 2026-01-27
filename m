Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E3DD19515
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXw-0000mi-6o; Tue, 27 Jan 2026 04:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXh-0000eL-6W
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXf-0008Tt-3Y
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZHV5QfGAz1nuWmCIkw+CUNK4q/aU6e4q2VMG7wzU9M=;
 b=I/uH/zeHf++3ZpiiefTiBj9E0ZZuEq6grNotas5IcK6+hb1fxfjxG8gCXBjuSCc+dAKLE2
 h6vZKIvpsGOmgBYPQn5UQlv3fFEdBJKxA5lMQlcuz0uNtEMK5rbwMYTMEpomHfhJpjCUFt
 b9RAc2Wf5fxCT+GltPTI5bhKgC3R8mo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-KMiOfQv8PHqJMOr63jUsNw-1; Tue, 27 Jan 2026 04:39:20 -0500
X-MC-Unique: KMiOfQv8PHqJMOr63jUsNw-1
X-Mimecast-MFC-AGG-ID: KMiOfQv8PHqJMOr63jUsNw_1769506759
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806865a01bso4039985e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506758; x=1770111558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZHV5QfGAz1nuWmCIkw+CUNK4q/aU6e4q2VMG7wzU9M=;
 b=hG0EVyd8SEf2CFgeeaoGWOLADZJMKJWYoU1CTO1JJO+U1HxZ9x+UbpjJDPg3BSMX25
 QzPBjPeybH9qBR7QqVUhUxvXCrH5qfZpfY8UsKJu7yPBjeqrdjvB+NI+SOXK+I+0mNhy
 4dEWf1bc78Ezr2n9FsId3Km1znuywBdjHGejq/yXI3B1zJ5Ddmn4BGvLn0n5dMsBfDmG
 dF3M59hN2Pn8GDMAj8yzk0iivAqryE1RkvK6X0pn9MFy6pE0icTKQhPuIp1zaJRkil1y
 ozdcG8zBAAn/P93VrOfWXoQ74M7NMebeGADGUHRR/VEDLZNOYe2FcUnQGf2GeMxj3Ogr
 usHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506758; x=1770111558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wZHV5QfGAz1nuWmCIkw+CUNK4q/aU6e4q2VMG7wzU9M=;
 b=TO2Rv4PaN/lGF2zdh8sxLPbDud9kYpvBIhhggh8D/bu+nmuOAImJE35OFB4M4R5AyD
 lBY57QsR/Rf3fUCJT5PVYr0GWtRDlh7gWu0D0v93DxxKrgv6x2uU22D6ODoUBni7ZzgM
 hUStNJ3uomXsVEVURWVseHskKBbRCbEZ3T5oCbvKFKqn7AJEZEvG0QDkTujeEhPtl4gz
 oMRPKlI/WV08oRV6ieMBPJMMfw3Ee55UnkoYwMy2SCRb/gCa/1F/j9qH+C5EmYud+eLE
 ZWrxpUiT1MtdfqpV5pgkfy0mocFGJ6ga7bj1uLMpiTaz5Uj4y7tkBVizC8P89o67GFOb
 FWHw==
X-Gm-Message-State: AOJu0Yw7DJ+QRG7dcVGRjJ3HHJaV1UEiNYDJjteW3plcgU4xqH7b8L0L
 UzIZzXr8kK1BXSpqvH08uir0FqGJ3q7kGq0dZDmmlx6zQGRkVWpJxFssy2jJeZLQ6wvLdrt6lvR
 hjmJ8NLui9slmaWiZ73qQtmLDg7bdD4eKQPYU8gVJxBicECyY4LwJIQ6YELecmfmP5Sdy+Y1oyi
 ZXsdgFgvU8AZzUZ80/zX2i35oxzYG2FM5K4Xy2jGv7
X-Gm-Gg: AZuq6aI/Foe2FYGzYGKwJppd/ZtCk7TQcr6xtCIFobNCy3wER1NIL8phjQPEzuzR0Ck
 57N4IIu4pudGn2ymH+xMrSH4t4p8nH+U1UkuLu3lrpH4QrPVp8dDBPuXZV4YEwCRVlSANsdDLzD
 EOkPedx4RZLj7eWHdzjPPTz//AkPsL5x2R/hDecFX0Qhenn0FQSN3rgQbEYofJN4ivijWsrfc6L
 sHWNDQNG1MYktWly5/FnS2PSdKs6avIEqUd9mRF7I3/0MPnYHXAEcNmsOFPiWprGX2IjJBWmlBV
 Qab3+A4W7WsTwpFf+oa3CpaU49YMeJauDaGLIWaq3TAaUO3f4EP+xiDlJS4kt0UlISz9B4TWbV2
 aOpWe0pueRHmdLoqPsohFmNB+bzJ3DYkvocsJiOBYPN+/Je2DKFs5HG7my1Aga2TcYVM1f6VD5I
 dkJ+Q4tWj1F9xcWQ==
X-Received: by 2002:a05:600c:8681:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48069c487admr9667035e9.24.1769506758272; 
 Tue, 27 Jan 2026 01:39:18 -0800 (PST)
X-Received: by 2002:a05:600c:8681:b0:480:3ad0:93bf with SMTP id
 5b1f17b1804b1-48069c487admr9666685e9.24.1769506757682; 
 Tue, 27 Jan 2026 01:39:17 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm51363155e9.12.2026.01.27.01.39.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] rust: move hwcore::sysbus to system crate
Date: Tue, 27 Jan 2026 10:38:58 +0100
Message-ID: <20260127093906.353741-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 rust/hw/core/src/irq.rs                | 8 ++++----
 rust/hw/core/src/lib.rs                | 3 ---
 rust/hw/core/src/prelude.rs            | 5 -----
 rust/hw/core/tests/tests.rs            | 4 ++--
 rust/meson.build                       | 2 +-
 rust/system/Cargo.toml                 | 1 +
 rust/system/meson.build                | 2 +-
 rust/system/src/lib.rs                 | 3 +++
 rust/system/src/prelude.rs             | 5 +++++
 rust/{hw/core => system}/src/sysbus.rs | 7 ++-----
 12 files changed, 20 insertions(+), 23 deletions(-)
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
index e0d7784d97b..13ace921824 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -33,10 +33,10 @@
 ///
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
-/// a function such as [`crate::sysbus::SysBusDeviceMethods::init_irq`], and
+/// a function such as [`crate::DeviceMethods::init_gpio_out`], and
 /// initially leaves the pointer to a NULL value, representing an unconnected
 /// interrupt. To connect it, whoever creates the device fills the pointer with
-/// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
+/// the sink's `IRQState *`, for example using `qdev_connect_gpio_out`.  Because
 /// devices are generally shared objects, interrupt sources are an example of
 /// the interior mutability pattern.
 ///
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


