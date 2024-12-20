Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DF1E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1d-0004Yg-0x; Fri, 20 Dec 2024 09:30:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1F-0004RP-Rp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1D-0006Zn-80
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s6nygS97dluqx/BeGp3uSmNclmtr8ycVi93iMqAtirw=;
 b=hbyxJrsumY7grtRxAi60qNz8+jZDZM60SvpTc88W8XObeAYjGyvRBklOFcLjdow7TdGR28
 2ejQvBtRCusAkHykp9COqc1o4w5n73w9faaQQoy3skQnzv67W4LVGeHBfcGx6iSuHxLV/j
 N18jJX/yyI5JuKgycJiby35r5b0qxXs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-9SU16gcNOpmwkdiZ6S-30Q-1; Fri, 20 Dec 2024 09:30:14 -0500
X-MC-Unique: 9SU16gcNOpmwkdiZ6S-30Q-1
X-Mimecast-MFC-AGG-ID: 9SU16gcNOpmwkdiZ6S-30Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43610eba55bso15129105e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705013; x=1735309813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6nygS97dluqx/BeGp3uSmNclmtr8ycVi93iMqAtirw=;
 b=uunILdms2Nt3mC4fafjROzb+ITbw5Chwo+P/FSLrsja74oQE+7khgxqVX1y/L8C37r
 c35qFHV9pL+rjRZPxCoByMLXMOIJ6ZK+oPG9Eluk/Bm+sH467iqVp0MuxrrSN3CUEA4o
 SzPzP5l4UffCuvE8Txo53xY9GY9PsX3BfbbU2RtK/6Fc9Dj7qhpws4Vxb5DcEEfhzCCy
 S395BFNa8MumSLuP1mw4MSf+s0C5ZYLLt1cx7BA30EKSAINfh7RywPqoyecRWFyvHanW
 ZvtcU+6i+DMpR7mDxo85JvXpnLjK/OVT6s6w5xk3UjYiwyAQiX2asJYUJbCGKweP8AzK
 MSsA==
X-Gm-Message-State: AOJu0Yxy1gVixSUWJXf3MQzz9zJIYYVal5PJFLjsmgdG2mxfB31/n7NQ
 +3rdcX5dliDb/s1PRG/vPWJewJDkEGho8M5MOx2Hci3BKZ8J2yxawyNx6lCTVo4GFi3l6q4OYlk
 38aTulcOGfngRVHfKwDUGW8ZFBr10Q8CFohng/OpCiyokFIS2WQvNwVNsH1yKel17r4xqElZyan
 8MtM0MDuMFHjcQyr51i1ylzXtAAlTXO4OWdOCx
X-Gm-Gg: ASbGncu99KKhpDe+KSXFIPukamMMfIE1xq/6ZYvf4ot9raUqQtoQAsEz7fu2GGA84qK
 zuU0Jzb8U6Jul2pFUBsk2VdzfngBLJdSyzRJ/oG+WT6/1btSxc0x7pJhRXC05GDbxruOj16cGa/
 8vMKa/Qb7ZLrDJ+Q+DrMQV3keXLgWyqk8L4eLGaikqClicXBBsUuNd+3is7N3ux7eXlVAjVte0/
 W+bn3VBCVZgDK9mb+aV9Fxi/U7w6EICG9DpaO+lbffvR8QmMRfZuF6blwUZ
X-Received: by 2002:a05:600c:524c:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-43668b93c61mr23054155e9.33.1734705012880; 
 Fri, 20 Dec 2024 06:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRBzfFniF4aiwf7rQItG/gdmPYjXGEn2f00FBMhasWdZgWSbzoExjwoyxTtHmrzLnCjc3Z3g==
X-Received: by 2002:a05:600c:524c:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-43668b93c61mr23053905e9.33.1734705012500; 
 Fri, 20 Dec 2024 06:30:12 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119ccsm81386065e9.24.2024.12.20.06.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 06/12] rust: qom: move device_id to PL011 class side
Date: Fri, 20 Dec 2024 15:29:48 +0100
Message-ID: <20241220142955.652636-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


