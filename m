Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DBFE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2v-0000tJ-IC; Fri, 10 Jan 2025 13:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1y-0000Dg-EQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1v-000164-DX
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oM5g6F4YfpoFPC4IDdAwTmKbiMsdCMsOt3B3qFLoUYk=;
 b=hsX7HI23dGg+fHDNpDzvIlw8hrgxOZjKDFi+8POr2zST7gOq/C4/m5ij60DKyMDp+f7frn
 qw/4e5yYO5hOcT7aOYmcFhtykoIrLbTXU9vVJ8M++LvYKrGGfFf+7t4iG3Zgs8qS0fCeDo
 3N2ZC5tlEjgSlC6U0FourLbUTXBeJ6w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-eK5bjl9-NsergkTmhB73Cg-1; Fri, 10 Jan 2025 13:46:42 -0500
X-MC-Unique: eK5bjl9-NsergkTmhB73Cg-1
X-Mimecast-MFC-AGG-ID: eK5bjl9-NsergkTmhB73Cg
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d43ec75bc4so2329311a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534800; x=1737139600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oM5g6F4YfpoFPC4IDdAwTmKbiMsdCMsOt3B3qFLoUYk=;
 b=rwHPbCqgsNIzk5TN3QyYhC6bWaBkH493Yk9LK5Fyk9Gg0J8sO2UKYC1HVEjIKmA13r
 X5KctayOjZukofXXkGA66B+ir+Y9aImpo5+xPhQoIRWWUGYpRsu8x3c5/Hf+7nAlzowp
 3c4ccDuIfU+V5y0jmM9lQe1XjsNnuCjEF6sR+esOC9Be8FucpVwWmeGHkoQpONSRj/QI
 nnHn8VjV/vAHPHce/spL+IX5sIPfNzvz3tI5ESkCGPPR0b6EYeu3w92Q98J8woOtp9wd
 aCvI3vSc7RKH+cWNQLbxHP/kDMlhT3eWExNOz30leg385itfoAtmljWl2QXE3qxw6/Ag
 VYLw==
X-Gm-Message-State: AOJu0YzQck1fo1tIwlKcBj7fMOgYJPBR92VeHFL7Pa2z9O3MxUckKUG6
 vi3s1ScFoFuu5CCB5Oxgbcnzd71gM142Aj+9MfOH93B8yiT0TddpSmF7WXDNUgTXeUXdOnkhcaS
 UQKatwDEPoYgwZabQanY2k+9uSS0d5/tntt7MYVsi+0WOHKrO2exwXWH9lF7bA9n0md9do4RX7G
 pXpumPEkfMPRxtdmsb7Zu5ac6zR01LGKFz3qk5s5E=
X-Gm-Gg: ASbGncvpITgKBBK/+oS+6IDDOo6BIFHfw6xJDCo0czdxKcOrrU/oOY8JPTfhmnSN9FN
 oG9P/F5fWkRTWLYqJRdmhW3DsLM61R07iWpwmanJMZPa6YgiZixyBjb1Dumq+StQWPwJbbNGMTo
 8rhvNsEVU1LcQAXkOBjvKMioHo63Dc/sM/+q8olh810+Sy+a/YB0smTDmDSabQ+3vL2SHH530wm
 MiJI3qYqx8U0G2AJO4o7Tyy9USK5bLCXretuk0nC41BIY2KUCpUGF/BFt4=
X-Received: by 2002:a05:6402:354b:b0:5d3:eceb:9c6c with SMTP id
 4fb4d7f45d1cf-5d972e6cf63mr10771365a12.29.1736534800413; 
 Fri, 10 Jan 2025 10:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQ0AN9agflhE/kpP30UyIwTg5OxImpp8QkX9J4x/wpJ6aT+Rbfv07lC1hK1OiseZNq0a7tng==
X-Received: by 2002:a05:6402:354b:b0:5d3:eceb:9c6c with SMTP id
 4fb4d7f45d1cf-5d972e6cf63mr10771343a12.29.1736534799911; 
 Fri, 10 Jan 2025 10:46:39 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c394sm1932559a12.7.2025.01.10.10.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 08/38] rust: qom: move device_id to PL011 class side
Date: Fri, 10 Jan 2025 19:45:49 +0100
Message-ID: <20250110184620.408302-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There is no need to monkeypatch DeviceId::Luminary into the already-initialized
PL011State.  Instead, now that we can define a class hierarchy, we can define
PL011Class and make device_id a field in there.

There is also no need anymore to have "Arm" as zero, so change DeviceId into a
wrapper for the array; all it does is provide an Index<hwaddr> implementation
because arrays can only be indexed by usize.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 59 +++++++++++++++-----------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 689202f4550..215f94a6e4a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -5,7 +5,7 @@
 use core::ptr::{addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
-    os::raw::{c_int, c_uchar, c_uint, c_void},
+    os::raw::{c_int, c_uint, c_void},
 };
 
 use qemu_api::{
@@ -14,7 +14,7 @@
     irq::InterruptSource,
     prelude::*,
     qdev::DeviceImpl,
-    qom::{ObjectImpl, ParentField},
+    qom::{ClassInitImpl, ObjectImpl, ParentField},
 };
 
 use crate::{
@@ -33,27 +33,20 @@
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: u32 = 16;
 
-#[derive(Clone, Copy, Debug)]
-enum DeviceId {
-    #[allow(dead_code)]
-    Arm = 0,
-    Luminary,
-}
+#[derive(Clone, Copy)]
+struct DeviceId(&'static [u8; 8]);
 
 impl std::ops::Index<hwaddr> for DeviceId {
-    type Output = c_uchar;
+    type Output = u8;
 
     fn index(&self, idx: hwaddr) -> &Self::Output {
-        match self {
-            Self::Arm => &Self::PL011_ID_ARM[idx as usize],
-            Self::Luminary => &Self::PL011_ID_LUMINARY[idx as usize],
-        }
+        &self.0[idx as usize]
     }
 }
 
 impl DeviceId {
-    const PL011_ID_ARM: [c_uchar; 8] = [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1];
-    const PL011_ID_LUMINARY: [c_uchar; 8] = [0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1];
+    const ARM: Self = Self(&[0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1]);
+    const LUMINARY: Self = Self(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
 }
 
 // FIFOs use 32-bit indices instead of usize, for compatibility with
@@ -126,17 +119,28 @@ pub struct PL011State {
     pub clock: NonNull<Clock>,
     #[doc(alias = "migrate_clk")]
     pub migrate_clock: bool,
-    /// The byte string that identifies the device.
-    device_id: DeviceId,
 }
 
 qom_isa!(PL011State : SysBusDevice, DeviceState, Object);
 
+pub struct PL011Class {
+    parent_class: <SysBusDevice as ObjectType>::Class,
+    /// The byte string that identifies the device.
+    device_id: DeviceId,
+}
+
 unsafe impl ObjectType for PL011State {
-    type Class = <SysBusDevice as ObjectType>::Class;
+    type Class = PL011Class;
     const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
 }
 
+impl ClassInitImpl<PL011Class> for PL011State {
+    fn class_init(klass: &mut PL011Class) {
+        klass.device_id = DeviceId::ARM;
+        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
+    }
+}
+
 impl ObjectImpl for PL011State {
     type ParentType = SysBusDevice;
 
@@ -214,7 +218,8 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
 
         let value = match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
-                u32::from(self.device_id[(offset - 0xfe0) >> 2])
+                let device_id = self.get_class().device_id;
+                u32::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
@@ -648,16 +653,10 @@ pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
 }
 
-impl PL011Luminary {
-    /// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
-    ///
-    /// # Safety
-    ///
-    /// We expect the FFI user of this function to pass a valid pointer, that
-    /// has the same size as [`PL011Luminary`]. We also expect the device is
-    /// readable/writeable from one thread at any time.
-    unsafe fn init(&mut self) {
-        self.parent_obj.device_id = DeviceId::Luminary;
+impl ClassInitImpl<PL011Class> for PL011Luminary {
+    fn class_init(klass: &mut PL011Class) {
+        klass.device_id = DeviceId::LUMINARY;
+        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
     }
 }
 
@@ -670,8 +669,6 @@ unsafe impl ObjectType for PL011Luminary {
 
 impl ObjectImpl for PL011Luminary {
     type ParentType = PL011State;
-
-    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
 }
 
 impl DeviceImpl for PL011Luminary {}
-- 
2.47.1


