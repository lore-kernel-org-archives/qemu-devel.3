Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B74E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd4G-0006fv-Nb; Mon, 09 Dec 2024 07:40:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1W-00041S-Ey
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1U-0007UR-7Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mN7zrOvP9fPOWB30Q4ZH63TTQ13EdvwykjuYF0Tturg=;
 b=aEUNvG80RAxW8xY1i6IY0CXYmIbckSIxxZF3LaDTJ6VUppoXm0OOAycsJ3WxmjCCm/Uo1p
 Y2tLZz6MlbsLXRc83uJYi2s+S9FzsWdneX+LlS8HFnX2G2lUdKDZSC5Ll+v8QHj82jkGKB
 hiFpgFA0ntZPlEmFYRxeCIzmFVo+ucs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-BqU_4apUPwO1vQZp7b9ilw-1; Mon, 09 Dec 2024 07:37:58 -0500
X-MC-Unique: BqU_4apUPwO1vQZp7b9ilw-1
X-Mimecast-MFC-AGG-ID: BqU_4apUPwO1vQZp7b9ilw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-386333ea577so759525f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747877; x=1734352677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mN7zrOvP9fPOWB30Q4ZH63TTQ13EdvwykjuYF0Tturg=;
 b=QzaQQHaEJK9nks4aYEH6bBlvtJuPlHMQcB+f1vEKPzsMO57PdSq1opSS2HU6Cv2GBI
 ZTwvEy5BvcC/WpAQXMKnlgOE/l/exPTdgKxyMFjPRJE7u3sJTczBZg9n4AZmpU5+/E+n
 sgLIrQ6C8D1j9wFh45kjmFQHkdSrKHUhGjx1atCh0O5I7UTThSvuz4t00q7sBbrLwSoy
 N9kieeQEUr9Tw/91IdpfNyVQOcqTKDb0fEeGAxPjZbmE+rQDicBJKCEPdfisE6c+8bVc
 rw8i/vlmInuF/wkSm8FsRxwQjr9ZQi5c2i/hX2NFZuLWPv/wTuuqHQtl7X2gkSQuHr41
 MZSQ==
X-Gm-Message-State: AOJu0YxIa0CaeE1X67I+zN4qwLV6EHLgGbvF8jpwqy0r4ZfO4OV3qGFF
 WsaBCW1J+Gbi0nxlp/FWBAphLJc/FeUD3kmz+g2/ADah/2rsAcv1+IYex8UuzsKJAL1vriWkmYM
 iIATcCNzWn40OVMNKHxf8ftnSjF6eV7948AH1sNZeyb7zT+rbBR7g3GgyNOMW7MwNbW43+g2dSc
 LcQqjkNLff02RXYdPGlXJj8+XsSNvlCvzIjMTA
X-Gm-Gg: ASbGncvZQryfCh8fFRO5hg2YG7ZAk2LpddMxka3tfI6qxgerTEadOR1YtejYkM2xtPo
 mrQizvlPjQ3M82L1S/Hqj+Uw3e+bJMTy+juV63AXebRWCI5v5yQKiqtVsF3EhwfWu6W3bEQU+TG
 9HW/s4ljSLGUH+ECLkIuaZ9Qy+pTUMVJGOwTIukNNLjgwQCgyTFSXSiWKr1s9mdjKR/hnP0DUBh
 W5D80H+Ia+N/5easxz28A1j+0IAX+EYuhjbqQ4pb306wfD8wpA9ZQ==
X-Received: by 2002:a05:6000:178e:b0:385:df73:2f3a with SMTP id
 ffacd0b85a97d-386453d4a54mr160174f8f.14.1733747876731; 
 Mon, 09 Dec 2024 04:37:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK/bmRmdfEMxIc0cApSfDYi7hd5M035oIFTVRxbtpUO8gW1R+kgunjwoZRfGCg4ObKF9jehA==
X-Received: by 2002:a05:6000:178e:b0:385:df73:2f3a with SMTP id
 ffacd0b85a97d-386453d4a54mr160147f8f.14.1733747876315; 
 Mon, 09 Dec 2024 04:37:56 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219095desm12945066f8f.64.2024.12.09.04.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:37:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 15/26] rust: qom: split ObjectType from ObjectImpl trait
Date: Mon,  9 Dec 2024 13:37:06 +0100
Message-ID: <20241209123717.99077-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Define a separate trait for fields that also applies to classes that are
defined by C code.  This makes it possible to add metadata to core classes,
which has multiple uses:

- it makes it possible to access the parent struct's TYPE_* for types
  that are defined in Rust code, and to avoid repeating it in every subclass

- implementors of ObjectType will be allowed to implement the IsA<> trait and
  therefore to perform typesafe casts from one class to another.

- in the future, an ObjectType could be created with Foo::new() in a type-safe
  manner, without having to pass a TYPE_* constant.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs  | 17 ++++++++++++-----
 rust/qemu-api/src/definitions.rs  |  9 ++++++---
 rust/qemu-api/src/device_class.rs | 11 ++++++-----
 rust/qemu-api/src/prelude.rs      |  2 ++
 rust/qemu-api/src/sysbus.rs       | 10 ++++++++--
 rust/qemu-api/tests/tests.rs      | 12 +++++++++---
 6 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index b9f8fb134b5..0ab825b1ca4 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,9 +12,10 @@
     bindings::{self, *},
     c_str,
     definitions::ObjectImpl,
-    device_class::{DeviceImpl, TYPE_SYS_BUS_DEVICE},
+    device_class::DeviceImpl,
     impl_device_class,
     irq::InterruptSource,
+    prelude::*,
 };
 
 use crate::{
@@ -106,10 +107,13 @@ pub struct PL011State {
     device_id: DeviceId,
 }
 
-impl ObjectImpl for PL011State {
+unsafe impl ObjectType for PL011State {
     type Class = PL011Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
+}
+
+impl ObjectImpl for PL011State {
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(<SysBusDevice as ObjectType>::TYPE_NAME);
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
@@ -640,10 +644,13 @@ unsafe fn init(&mut self) {
     }
 }
 
-impl ObjectImpl for PL011Luminary {
+unsafe impl ObjectType for PL011Luminary {
     type Class = PL011LuminaryClass;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011_LUMINARY;
-    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(crate::TYPE_PL011);
+}
+
+impl ObjectImpl for PL011Luminary {
+    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(<PL011State as ObjectType>::TYPE_NAME);
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
diff --git a/rust/qemu-api/src/definitions.rs b/rust/qemu-api/src/definitions.rs
index 078ba30d61a..1c412dbc876 100644
--- a/rust/qemu-api/src/definitions.rs
+++ b/rust/qemu-api/src/definitions.rs
@@ -33,7 +33,7 @@
     unsafe { std::ptr::drop_in_place(obj.cast::<T>()) }
 }
 
-/// Trait a type must implement to be registered with QEMU.
+/// Trait exposed by all structs corresponding to QOM objects.
 ///
 /// # Safety
 ///
@@ -43,15 +43,18 @@
 ///   automatic if the class is defined via `ObjectImpl`).
 ///
 /// - the first field of the struct must be of the instance struct corresponding
-///   to the superclass declared as `PARENT_TYPE_NAME`
-pub trait ObjectImpl: ClassInitImpl + Sized {
+///   to the superclass declared in the `TypeInfo`
+pub unsafe trait ObjectType: Sized {
     /// The QOM class object corresponding to this struct.  Not used yet.
     type Class;
 
     /// The name of the type, which can be passed to `object_new()` to
     /// generate an instance of this type.
     const TYPE_NAME: &'static CStr;
+}
 
+/// Trait a type must implement to be registered with QEMU.
+pub trait ObjectImpl: ObjectType + ClassInitImpl {
     /// The parent of the type.  This should match the first field of
     /// the struct that implements `ObjectImpl`:
     const PARENT_TYPE_NAME: Option<&'static CStr>;
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index f25904be4f6..03d03feee83 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -6,6 +6,7 @@
 
 use crate::{
     bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
+    prelude::*,
     zeroable::Zeroable,
 };
 
@@ -146,8 +147,8 @@ macro_rules! declare_properties {
     };
 }
 
-// workaround until we can use --generate-cstr in bindgen.
-pub const TYPE_DEVICE: &CStr =
-    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
-pub const TYPE_SYS_BUS_DEVICE: &CStr =
-    unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
+unsafe impl ObjectType for bindings::DeviceState {
+    type Class = bindings::DeviceClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
+}
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index a39e228babf..1b8677b2d9a 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -6,3 +6,5 @@
 
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
+
+pub use crate::definitions::ObjectType;
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 4e192c75898..5ee068541cf 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -2,11 +2,17 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ptr::addr_of;
+use std::{ffi::CStr, ptr::addr_of};
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
-use crate::{bindings, cell::bql_locked, irq::InterruptSource};
+use crate::{bindings, cell::bql_locked, irq::InterruptSource, prelude::*};
+
+unsafe impl ObjectType for SysBusDevice {
+    type Class = SysBusDeviceClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_SYS_BUS_DEVICE) };
+}
 
 impl SysBusDevice {
     /// Return `self` cast to a mutable pointer, for use in calls to C code.
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index b8b12a40422..1be03eb685c 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,8 +8,9 @@
     bindings::*,
     c_str, declare_properties, define_property,
     definitions::ObjectImpl,
-    device_class::{self, DeviceImpl},
+    device_class::DeviceImpl,
     impl_device_class,
+    prelude::*,
     zeroable::Zeroable,
 };
 
@@ -46,10 +47,15 @@ pub struct DummyClass {
             ),
     }
 
-    impl ObjectImpl for DummyState {
+    unsafe impl ObjectType for DummyState {
         type Class = DummyClass;
         const TYPE_NAME: &'static CStr = c_str!("dummy");
-        const PARENT_TYPE_NAME: Option<&'static CStr> = Some(device_class::TYPE_DEVICE);
+    }
+
+    impl ObjectImpl for DummyState {
+        const PARENT_TYPE_NAME: Option<&'static CStr> =
+            Some(<DeviceState as ObjectType>::TYPE_NAME);
+        const ABSTRACT: bool = false;
     }
 
     impl DeviceImpl for DummyState {
-- 
2.47.1


