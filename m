Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1BBD37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1Fe-0008GK-Ui; Wed, 14 Jan 2026 08:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1Fb-0008CS-Lq
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vg1FZ-0002G6-5S
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768398567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrMf5KEy7l8I9I0C7YHruq+Mnzy9WjT6abXoIiW6jCg=;
 b=SNc1ru4S/l+gWCIq4A2ce938jCtCU35n7WB6Z8eDPO1chBarymJw/EtpmZMhCJPfOt1+qG
 /EHkFW++/jT/v8kr2wOhtqkU/RliVd8t/oeQwDcs15gvIWntB48omAFJm14HU4377ih85h
 84gfpISDU4S5BPcQNpyP7lbAKk5iHM0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-1zyyI9lcOMuHPYT571Mvbw-1; Wed, 14 Jan 2026 08:49:26 -0500
X-MC-Unique: 1zyyI9lcOMuHPYT571Mvbw-1
X-Mimecast-MFC-AGG-ID: 1zyyI9lcOMuHPYT571Mvbw_1768398565
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so6428477f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 05:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768398564; x=1769003364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rrMf5KEy7l8I9I0C7YHruq+Mnzy9WjT6abXoIiW6jCg=;
 b=gvIwCcj01YjanNzbbQ4yuGvBjYeHeqKgdielJRzs9QXPKfggFFyMF748ndfJHkfJjR
 QlEIdwLJdu9KHWWRt+RCfOniYfJNPgb/GM/eIuat5yKS1hcXlosKvZWvBq5cdRNFPfZe
 MT3ihGjhWXpw88p2OPKU9LR6g9saTduMg4gJHCNDbYefIkRUxwT22tQvIxZ2ehGwA5AN
 XEF4FLm+h/L4N+NE3tsy5JNfeF11P9x9p5MXEPF7lZdWlZuBJ4M6EuKUlG48A1znLecm
 XKYdhGAoMlA1Iv1tm5HiWaS6Gut935s8W8xnrz7ag7hf47LiVAnudG/3/fO7jcOm9NpZ
 Dzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768398564; x=1769003364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rrMf5KEy7l8I9I0C7YHruq+Mnzy9WjT6abXoIiW6jCg=;
 b=lVGLbsbUKTqXd2+vMQvK7cqCO4AsY7wu7SQLF/RdiYbM6ojeT0XbdLtxReuZqdwTQk
 1XXdW24H5+uWtoBoV5t6rlSlfrS5rb5VSbKZNHJ23UHLqwlMlfIPWHNoKxU4oJtDqa0S
 07CArcB/y4+KjIXviJowV8r/GyEOKzonodFKR1OymvYKXpZab1vQCSR60EZ8PIEnoH5U
 9tWW3Kw6FsVo/8HDlmikLj1fg2TZLvanetKYswUlx3Wx2hh7Apv4+0k5CQc8gyYWMmcb
 xhnd1DFRIhgj9kNC6QlMYqAVJ+sgefsMEN7u3HnR94oSx+7tMHe3jYgpZslkzkBbQgDs
 GbPg==
X-Gm-Message-State: AOJu0Yz4BrlLcmjvE/kJJTmVlDYdYcMeehmz8SeGVpmb64OyfIe2UaBZ
 XRlc98L3NJ0b4NFFXT5rVKP3qq/aIXuRxh0AfZEmLTrN8UxITQq0EMCQOCxnBkBWvPakoKVItlF
 Y8KzZVYdZa4D3cb8uIl6fs4Itj0vlUKjWJ6K7isjg11uDgkrezsZabcy3tndWQKClFv7oeo9vs6
 uXADOpVLL76tpxPQH3iWL8wOLEGHeMUM1yaRjT+fHW
X-Gm-Gg: AY/fxX7qdxN+1KeG8/XrhjdrO9ta6MLKU3XtfcOPRW/ZAyUwKjMI25lgahLrV3vDue+
 nlSoKbCaEjFU7nG/7OUTY+5psjeLHYQBoX7bEPrG0S95uzFczO8YcJ3lbkbZ275bIIzMm2pIgZi
 5tTUBAb03cTpazE6SB1L7p5c6biRGy9tp0T1cX47zQmsEWswFGEIa3aBGBOUjvyFihPr0uorlL1
 WweMVlsx1xC+eii6ENGvFLlHCVCDwhy292P5+scnPpC33b7BRI3Zz5dQwhi/lAtWIUsB+Vc1z1o
 ZpH2bX15LSQuGyo0geVrUzf7OLy7gPATqEwWbBruX28DJphO1wzaPfaEfPXTMtdbXbFd9H96QM9
 FSxrdduTW+KpNgVjj0T98cJOuTe58s3nnx2XHCtFK5dMCSQSHHNyxHMluJNIByMzlDWZFYyVnuX
 qv1gIfYevZxhKfuw==
X-Received: by 2002:a05:6000:290e:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-4342c543ba7mr3600392f8f.29.1768398564330; 
 Wed, 14 Jan 2026 05:49:24 -0800 (PST)
X-Received: by 2002:a05:6000:290e:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-4342c543ba7mr3600347f8f.29.1768398563778; 
 Wed, 14 Jan 2026 05:49:23 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm51726274f8f.13.2026.01.14.05.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 05:49:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 1/3] rust: move class_init to an extension trait
Date: Wed, 14 Jan 2026 14:49:17 +0100
Message-ID: <20260114134919.1476518-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114134919.1476518-1-pbonzini@redhat.com>
References: <20260114134919.1476518-1-pbonzini@redhat.com>
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


