Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793B9E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFQ-0001mI-0M; Thu, 19 Dec 2024 11:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOP-00066M-MW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFON-00089d-Vg
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6nygS97dluqx/BeGp3uSmNclmtr8ycVi93iMqAtirw=;
 b=ZY/IY5mHC74yyMzxsyHsm2szV1iMhebsxpz2DjHLMtDBdkDPjWGTmRLHa6i8Vj/X1a5n0W
 CJYssrnHfyvhWhNGfnLiaPLcaiC8RF/nZxrkJLchnJ3EQ3Jm5lSQrU7BGDzRF4TB7rFFtw
 ZEN76AUDE3NyKfBEhWPgcsVHFJ0Lpa4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-LX4o54gSPBaM84RnFei4Qw-1; Thu, 19 Dec 2024 07:12:34 -0500
X-MC-Unique: LX4o54gSPBaM84RnFei4Qw-1
X-Mimecast-MFC-AGG-ID: LX4o54gSPBaM84RnFei4Qw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so4351855e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610352; x=1735215152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6nygS97dluqx/BeGp3uSmNclmtr8ycVi93iMqAtirw=;
 b=e8LXmcg6aYsM2M54fszjkVOSlTWgrrDBwkWhT+gPf6ltHicPxLg49n1MxYnIaO8dm+
 /IV63oouP4Fd7OKtVm8yA/idkhalpJNa4tX1rQNnDdDxdlQALcsHusNFEWe7YTDQWHWv
 v1dXi/tSC++IxSx63krLX5UjtP6UixnSPkxW/GKE+GiP3R9n/6fEsi9EbLgWSxtwoZdY
 TE0Zb9mmbaTv+LIFG6q1jq9p2CHapQWh/vf61xKk5y69Lu4YmQ3hD+McsUxt+DbEfAtW
 GP3QrGfiCzYu6PTONghurJ/TyTISPjqSy/iCjLECQt7XAEqmVFak0Od+SBzON67+l6T/
 lBJg==
X-Gm-Message-State: AOJu0Yyu+MvvHZEjI7E8hT5Gc6GBbmIprgSJ8PgLwcZT03RGUH0IICiO
 l7lEMI5Nj1XeWYCvtfcaPZFu9BdqMRkz3fxXSBNJWseDz0zcJF+UHLmX2BiCjNbQjLMFsWYkpXz
 ShHTLpVKg+bEwE3TTuKLYrLOW5XGcH6QYN16Xi2b4QiHMxNioOo0X5nLFAgX7LSyJsXS7fgc4zw
 lxgz2FI5WY2qCWflCsklCBuIrjfo5YGyJmREv+
X-Gm-Gg: ASbGncs8S7jbHZz7SFSbVxlb4QEezOn1Po5nD9JCOosrq5X3isnCRbJeQN+8vlnxyhw
 f8D0jf/YGJ+6aNq64JI1RLFRMtuT40prfkgAVsYxacXwWtjH7EZx4ipC4XXZrqA++tIgQEbXiF7
 4lwj5kAtzlhT01zqNePBHlnigV9ihDRmNCydRmXTJdSMLwAZghB/ByQPZjVXz9gm6TVQ7MztFHK
 tLyBXgoozA7lyrVYl8p1GeoCvWcQFe4xmPEhtXEXE3R+p5LSB+QeCBFKkZL
X-Received: by 2002:a05:6000:156c:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-388e4dad7b7mr6318064f8f.48.1734610351694; 
 Thu, 19 Dec 2024 04:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXLEWpbID6WJom2RkjUcAVDjCHTbt5/SVlufliM1MucKhzTOpUxdcYhp/FoZZdM13qfJFoaw==
X-Received: by 2002:a05:6000:156c:b0:385:f220:f788 with SMTP id
 ffacd0b85a97d-388e4dad7b7mr6318033f8f.48.1734610351240; 
 Thu, 19 Dec 2024 04:12:31 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e1bsm1427795f8f.31.2024.12.19.04.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 06/10] rust: qom: move device_id to PL011 class side
Date: Thu, 19 Dec 2024 13:12:12 +0100
Message-ID: <20241219121216.416905-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


