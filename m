Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF83D19515
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfXt-0000hE-HN; Tue, 27 Jan 2026 04:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXg-0000e6-T2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vkfXd-0008Tf-Cd
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrMf5KEy7l8I9I0C7YHruq+Mnzy9WjT6abXoIiW6jCg=;
 b=Y97OAiHHY4ReZQJV735dNwVt4i6MRg8CULUEpGwdkQC6xrtjjA+0g39CVftVYAEZ1VBtoA
 ymJIB4Pf3kAH453hpB/vBIt2h+tLidhlWvi3mhyX2hzNfI0HLovybLPnA4ltBuhGPWId1u
 LHBRDySTpCOPY2pvSqh5WPYcH1qalgo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-uFOKjRx2OVCwwyJMnTB1Ig-1; Tue, 27 Jan 2026 04:39:16 -0500
X-MC-Unique: uFOKjRx2OVCwwyJMnTB1Ig-1
X-Mimecast-MFC-AGG-ID: uFOKjRx2OVCwwyJMnTB1Ig_1769506755
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43591aacca2so4204224f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506755; x=1770111555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rrMf5KEy7l8I9I0C7YHruq+Mnzy9WjT6abXoIiW6jCg=;
 b=eYZ8ImyvUUMZn952pdn5CnKlmBifaSx1/4EV7dm0baVZ478XsIwOO6Qsdysd0X8Lyv
 atqPGGbyV7hu0jm3bJ7PhH2edc4nw1U5KaV/HQyO8Sd61E81ApS4kdirUTkqYmxWQc3c
 2KRKEhq76To5OCJjO+pt8HV2VCRIJI9xgjm6p9HG3m1QEajlamcre9EoYVrxTqpTsgvx
 U5Nflt6U0+zpf7l+45N8hrihnXnGLDPgCHrAprTULbHTkEMp6RbIQJjbi5+i09FNLll4
 7rEjH6Pi+BPqD9MnhKLPwMnbPk6Ramy/uHZ+nt/x8y/KM6aRBdw9rRHjZ5qd/xeM6kuo
 /oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506755; x=1770111555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rrMf5KEy7l8I9I0C7YHruq+Mnzy9WjT6abXoIiW6jCg=;
 b=TgRN4euFY7dkATlZJRQxcRBJbpDJ5903Eq8jlVz+DTaQ9dOSXi1BFzOh9jJyHVBmOX
 1lN1pvDPIGP3NeYo20lB8DuaJJLAkAc2cqvoRcPap4CGehNTFs8kqU115pKjuDR73Hp8
 UlvNVVOvwpWGjE/nw9rKWf99gbXYnt5VBfRi5b4ZDzIizFIu7yl4/mGJKIrVtrE5yHWz
 Wnb24jz1+D1Ytt0eVHQbzTkpZQyKiY+isZXcZX6MTy2YpOSUgjn3VCSeMPzDlHvngTax
 qUozyUuEzvTsk5wI9bGwL12Lx1D43cVb2Oswrw43hKE/gUQNSMQ874ocKfyM+S7rIaf+
 3CdQ==
X-Gm-Message-State: AOJu0YzyIwHSj9XL4VudUo9Qq4E0k/M7+kHCvX69mNqJzNriUmJpGmnI
 cYv3YrxesrCaAc7tNEu9FQluxxO7bW348OlS0wChVv2nCaHxQrtPuq/I6kT8X6QX/UzmsclW4rE
 NFNx8tZyLK86MKhsprjxKEo2XJLkKl4/ii83E9QliXlmmTnD9z4jqMMpJ4bPUdrw4VarfM2N6/L
 ySXk2xGlFTemfD8ffYbeKdgPOezoNg9hcNHfmPCkKH
X-Gm-Gg: AZuq6aLUzNVYPeXMWPkWcOGazcgSbB1GKtVxU2j57X23P5Cop3xRAmO4V44V9hTAara
 l2Lyk34TkhQS5lsOoJ+KKSXC+wmE7pPYsihyXGQq5ScwRShUkjmyyChtIJfC0A150hsyDcOMncK
 qZAIqPVTMY+2v6joe6EggnxGKieNyVo+SXOtfzTlyw9FEpJun7XSm47cxcNTcWEYC6wT4NgNRYN
 axL7Xq7U3fyKwUo6T+kgOChuAKH6KKsKcoStA/yeaCI+jj4FFDdL2Q/lzwkQflg7CCl06cKdmzt
 OkUCeQS/RJaRJsjFI2GvcXcYy9lOg5QYIecBCbkL7TBTZxpiKOn2BxTAEiKN/FqKBwhnIeZbIYw
 dCZJnEMot10z1UK1eQAsagl1zokhAR9lP4s0cnk+Z39Kiwcq2lve9I4yxiW63d9Dym/8C9UbYjg
 yysc+pKtjHEcILBw==
X-Received: by 2002:a05:6000:1786:b0:430:f68f:ee97 with SMTP id
 ffacd0b85a97d-435dd1c1d82mr1700959f8f.40.1769506754581; 
 Tue, 27 Jan 2026 01:39:14 -0800 (PST)
X-Received: by 2002:a05:6000:1786:b0:430:f68f:ee97 with SMTP id
 ffacd0b85a97d-435dd1c1d82mr1700900f8f.40.1769506753973; 
 Tue, 27 Jan 2026 01:39:13 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c24f15sm37780880f8f.18.2026.01.27.01.39.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:39:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/13] rust: move class_init to an extension trait
Date: Tue, 27 Jan 2026 10:38:56 +0100
Message-ID: <20260127093906.353741-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127093906.353741-1-pbonzini@redhat.com>
References: <20260127093906.353741-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prepare for having ObjectClass, DeviceClass and SysbusDeviceClass
defined outside the hwcore and qom crates.  It then becomes
impossible to add a method to them.

Extracted from a patch by Marc-André Lureau.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/core/src/prelude.rs |  3 +++
 rust/hw/core/src/qdev.rs    | 25 +++++++++++++++----------
 rust/hw/core/src/sysbus.rs  | 10 +++++++---
 rust/qom/src/prelude.rs     |  1 +
 rust/qom/src/qom.rs         |  8 ++++++--
 5 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/rust/hw/core/src/prelude.rs b/rust/hw/core/src/prelude.rs
index c544c317b39..13f7dfc6809 100644
--- a/rust/hw/core/src/prelude.rs
+++ b/rust/hw/core/src/prelude.rs
@@ -1,6 +1,8 @@
 //! Essential types and traits intended for blanket imports.
 
 pub use crate::qdev::Clock;
+
+pub use crate::qdev::DeviceClassExt;
 pub use crate::qdev::DeviceState;
 pub use crate::qdev::DeviceImpl;
 pub use crate::qdev::DeviceMethods;
@@ -8,6 +10,7 @@
 pub use crate::qdev::ResetType;
 
 pub use crate::sysbus::SysBusDevice;
+pub use crate::sysbus::SysBusDeviceClassExt;
 pub use crate::sysbus::SysBusDeviceImpl;
 pub use crate::sysbus::SysBusDeviceMethods;
 
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 87232becbad..f6037fbdcae 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -15,9 +15,9 @@
 use qom::{prelude::*, ObjectClass};
 use util::{Error, Result};
 
-pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
+pub use crate::bindings::{ClockEvent, ResetType};
 use crate::{
-    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, DeviceClass, Property},
     irq::InterruptSource,
 };
 
@@ -206,6 +206,9 @@ pub trait DeviceImpl:
     }
 }
 
+#[repr(transparent)]
+pub struct ResettableClass(bindings::ResettableClass);
+
 unsafe impl InterfaceType for ResettableClass {
     const TYPE_NAME: &'static CStr =
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_RESETTABLE_INTERFACE) };
@@ -214,23 +217,25 @@ unsafe impl InterfaceType for ResettableClass {
 impl ResettableClass {
     /// Fill in the virtual methods of `ResettableClass` based on the
     /// definitions in the `ResettablePhasesImpl` trait.
-    pub fn class_init<T: ResettablePhasesImpl>(&mut self) {
+    fn class_init<T: ResettablePhasesImpl>(&mut self) {
         if <T as ResettablePhasesImpl>::ENTER.is_some() {
-            self.phases.enter = Some(rust_resettable_enter_fn::<T>);
+            self.0.phases.enter = Some(rust_resettable_enter_fn::<T>);
         }
         if <T as ResettablePhasesImpl>::HOLD.is_some() {
-            self.phases.hold = Some(rust_resettable_hold_fn::<T>);
+            self.0.phases.hold = Some(rust_resettable_hold_fn::<T>);
         }
         if <T as ResettablePhasesImpl>::EXIT.is_some() {
-            self.phases.exit = Some(rust_resettable_exit_fn::<T>);
+            self.0.phases.exit = Some(rust_resettable_exit_fn::<T>);
         }
     }
 }
 
-impl DeviceClass {
-    /// Fill in the virtual methods of `DeviceClass` based on the definitions in
-    /// the `DeviceImpl` trait.
-    pub fn class_init<T: DeviceImpl>(&mut self) {
+pub trait DeviceClassExt {
+    fn class_init<T: DeviceImpl>(&mut self);
+}
+
+impl DeviceClassExt for DeviceClass {
+    fn class_init<T: DeviceImpl>(&mut self) {
         if <T as DeviceImpl>::REALIZE.is_some() {
             self.realize = Some(rust_realize_fn::<T>);
         }
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 071fccff1e6..81fab3f1910 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -15,7 +15,7 @@
 use crate::{
     bindings,
     irq::{IRQState, InterruptSource},
-    qdev::{DeviceImpl, DeviceState},
+    qdev::{DeviceClassExt, DeviceImpl, DeviceState},
 };
 
 /// A safe wrapper around [`bindings::SysBusDevice`].
@@ -37,10 +37,14 @@ unsafe impl ObjectType for SysBusDevice {
 // TODO: add virtual methods
 pub trait SysBusDeviceImpl: DeviceImpl + IsA<SysBusDevice> {}
 
-impl SysBusDeviceClass {
+pub trait SysBusDeviceClassExt {
+    fn class_init<T: SysBusDeviceImpl>(&mut self);
+}
+
+impl SysBusDeviceClassExt for SysBusDeviceClass {
     /// Fill in the virtual methods of `SysBusDeviceClass` based on the
     /// definitions in the `SysBusDeviceImpl` trait.
-    pub fn class_init<T: SysBusDeviceImpl>(self: &mut SysBusDeviceClass) {
+    fn class_init<T: SysBusDeviceImpl>(&mut self) {
         self.parent_class.class_init::<T>();
     }
 }
diff --git a/rust/qom/src/prelude.rs b/rust/qom/src/prelude.rs
index 6a1ecaef2a7..1d1177f1e0d 100644
--- a/rust/qom/src/prelude.rs
+++ b/rust/qom/src/prelude.rs
@@ -4,6 +4,7 @@
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
+pub use crate::qom::ObjectClassExt;
 pub use crate::qom::ObjectClassMethods;
 pub use crate::qom::ObjectDeref;
 pub use crate::qom::ObjectImpl;
diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
index 84455cea79b..cc00ddcfc98 100644
--- a/rust/qom/src/qom.rs
+++ b/rust/qom/src/qom.rs
@@ -729,10 +729,14 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     T::UNPARENT.unwrap()(unsafe { state.as_ref() });
 }
 
-impl ObjectClass {
+pub trait ObjectClassExt {
+    fn class_init<T: ObjectImpl>(&mut self);
+}
+
+impl ObjectClassExt for ObjectClass {
     /// Fill in the virtual methods of `ObjectClass` based on the definitions in
     /// the `ObjectImpl` trait.
-    pub fn class_init<T: ObjectImpl>(&mut self) {
+    fn class_init<T: ObjectImpl>(&mut self) {
         if <T as ObjectImpl>::UNPARENT.is_some() {
             self.unparent = Some(rust_unparent_fn::<T>);
         }
-- 
2.52.0


