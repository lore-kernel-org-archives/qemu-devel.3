Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73CCAC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHwm-0006j0-Fg; Fri, 25 Jul 2025 08:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwT-0006TT-08
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ufHwO-0007wc-GC
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753448063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2jO7BQduqFPUM/wSkRuI1L6TOFWqvNqtxtv6cfTXpJM=;
 b=Rag5OP4SyE4nFORtEgng2QQfqviktTlUMoFYoJ5f234Gm5Hx266feePPS1tR52QAv8KlDC
 v7fvWqiJtXKuNq00Ao2lTFBiXKyHoEJRj6g59vB8GCn95PztmqUFjB3IDXyn29jL90LFEJ
 vysYP01SWds3b3Ngel0RpnqMvAqWC0o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-WqdRHMXAM--9Fu2AqWZBSQ-1; Fri, 25 Jul 2025 08:54:22 -0400
X-MC-Unique: WqdRHMXAM--9Fu2AqWZBSQ-1
X-Mimecast-MFC-AGG-ID: WqdRHMXAM--9Fu2AqWZBSQ_1753448061
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a6d1394b07so1262779f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448060; x=1754052860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jO7BQduqFPUM/wSkRuI1L6TOFWqvNqtxtv6cfTXpJM=;
 b=EWki3YzZ+SfRu3R0UonsyL7o8pQW6PeWRmVAGZx1p4sY9K15hXa1+IK+zmT9VwQd8J
 158iwaFxIEhZJ2J80KtMlSy/WIXWQefY4efkbHHbzwvbkhcfszbshMgGhMQV+w/bhyaE
 wJRiz0hjIVAr1Ov3B6w33nxjIOv68B9NMmmV92VxYFbJ0V5zzkXrsu9hFhrYUwIT89Tm
 dlijjOPpjvShxkmBUyPe1JyJVduXtH7DVU8HYMYml5yV2zVOTW0bluYt6HLYozh225SY
 X6XjbuXXGcahNnPF3C9z99l9LzdoZ0zW4kE4JtiYEM19gvkOVjswLqFqwNoT+JuVpwnn
 YnBg==
X-Gm-Message-State: AOJu0Yx2uR1ltLDhRtLpu8h98bGfL9Zxll9Et18xERQFsu3iPHxmM9ox
 Pq7DK4PQcdKNMC2kSWbRWvSQ+MYNnH99NuWApqBmndu3slRhjPZ9X7xnoE25onjYIkBXu/kKFqA
 LlPm5BPPah0etLbwcgYEPwqq+RwExQ4mQZTgh+Jsde/FNYrFjIJsgPOVpBW4tGEvvBBKUtmTWwX
 5KsIBZKcTGG+PSTkUWY940z50zVsfwN1LIAQTHMRXN
X-Gm-Gg: ASbGncsiH2PxOUXDk/EP0ppxFtOj668uQk4jZvtMipC3Waq8Id+8cN8jpPrik69W4oZ
 fjoexOQDO9JLjXSkSdbPKIa9HCUAJQoCrKDdDyTrXB3wt/qy2MkdgQGbT5POpn1Vp22XOFyrutq
 ySKMqAGllGijzVEptyl6VT+u5dhLviJk6+2owKPWtvzZ0KsU6V9t+DmEtXeWowFG8Yxk06iY0rK
 gTyOewPRVC/ag1jcdMBv1EbQrxWZnHg3GtT4Fa4+8xGBYkjP3Td6mJjdITg2MUvKrnBOw6+idnF
 rio9lbAiEvvelPlZD8fajVsPiYDXbKoee6Qz5BfZyMrn
X-Received: by 2002:a05:6000:4a1b:b0:3b7:78c8:9392 with SMTP id
 ffacd0b85a97d-3b778c89859mr70183f8f.19.1753448059576; 
 Fri, 25 Jul 2025 05:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNZ8V2vpphxMjHeheOcBuLzg2WmLEqab90Oj5UDaO09V3wh2/jJweBJ2Tm6zrUcprUTLM+g==
X-Received: by 2002:a05:6000:4a1b:b0:3b7:78c8:9392 with SMTP id
 ffacd0b85a97d-3b778c89859mr70149f8f.19.1753448058887; 
 Fri, 25 Jul 2025 05:54:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.154.122])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bcbe8sm56044665e9.17.2025.07.25.05.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:54:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 2/4] rust/pl011: merge device_class.rs into device.rs
Date: Fri, 25 Jul 2025 14:54:01 +0200
Message-ID: <20250725125412.1128617-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250725125412.1128617-1-pbonzini@redhat.com>
References: <20250725125412.1128617-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The split was a relic of early development and is not necessary.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250718-rust-pl011-cleanup-v1-1-c71b1d6a69a5@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       | 103 +++++++++++++++++++++++--
 rust/hw/char/pl011/src/device_class.rs | 103 -------------------------
 rust/hw/char/pl011/src/lib.rs          |   1 -
 3 files changed, 96 insertions(+), 111 deletions(-)
 delete mode 100644 rust/hw/char/pl011/src/device_class.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5b53f2649f1..ceb71dd99b6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,9 +2,14 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of};
+use std::{
+    ffi::{c_int, c_void, CStr},
+    mem::size_of,
+    ptr::NonNull,
+};
 
 use qemu_api::{
+    bindings::{qdev_prop_bool, qdev_prop_chr},
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
@@ -18,12 +23,11 @@
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     uninit_field_mut,
     vmstate::VMStateDescription,
+    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
+    zeroable::Zeroable,
 };
 
-use crate::{
-    device_class,
-    registers::{self, Interrupt, RegisterOffset},
-};
+use crate::registers::{self, Interrupt, RegisterOffset};
 
 // TODO: You must disable the UART before any of the control registers are
 // reprogrammed. When the UART is disabled in the middle of transmission or
@@ -173,10 +177,10 @@ impl ObjectImpl for PL011State {
 
 impl DeviceImpl for PL011State {
     fn properties() -> &'static [Property] {
-        &device_class::PL011_PROPERTIES
+        &PL011_PROPERTIES
     }
     fn vmsd() -> Option<&'static VMStateDescription> {
-        Some(&device_class::VMSTATE_PL011)
+        Some(&VMSTATE_PL011)
     }
     const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
@@ -712,3 +716,88 @@ impl PL011Impl for PL011Luminary {
 impl DeviceImpl for PL011Luminary {}
 impl ResettablePhasesImpl for PL011Luminary {}
 impl SysBusDeviceImpl for PL011Luminary {}
+
+extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_ref().migrate_clock }
+}
+
+/// Migration subsection for [`PL011State`] clock.
+static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
+    name: c"pl011/clock".as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(pl011_clock_needed),
+    fields: vmstate_fields! {
+        vmstate_clock!(PL011State, clock),
+    },
+    ..Zeroable::ZERO
+};
+
+extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    let result = unsafe { state.as_ref().post_load(version_id as u32) };
+    if result.is_err() {
+        -1
+    } else {
+        0
+    }
+}
+
+static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
+    name: c"pl011/regs".as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    fields: vmstate_fields! {
+        vmstate_of!(PL011Registers, flags),
+        vmstate_of!(PL011Registers, line_control),
+        vmstate_of!(PL011Registers, receive_status_error_clear),
+        vmstate_of!(PL011Registers, control),
+        vmstate_of!(PL011Registers, dmacr),
+        vmstate_of!(PL011Registers, int_enabled),
+        vmstate_of!(PL011Registers, int_level),
+        vmstate_of!(PL011Registers, read_fifo),
+        vmstate_of!(PL011Registers, ilpr),
+        vmstate_of!(PL011Registers, ibrd),
+        vmstate_of!(PL011Registers, fbrd),
+        vmstate_of!(PL011Registers, ifl),
+        vmstate_of!(PL011Registers, read_pos),
+        vmstate_of!(PL011Registers, read_count),
+        vmstate_of!(PL011Registers, read_trigger),
+    },
+    ..Zeroable::ZERO
+};
+
+pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
+    name: c"pl011".as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    post_load: Some(pl011_post_load),
+    fields: vmstate_fields! {
+        vmstate_unused!(core::mem::size_of::<u32>()),
+        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
+    },
+    subsections: vmstate_subsections! {
+        VMSTATE_PL011_CLOCK
+    },
+    ..Zeroable::ZERO
+};
+
+qemu_api::declare_properties! {
+    PL011_PROPERTIES,
+    qemu_api::define_property!(
+        c"chardev",
+        PL011State,
+        char_backend,
+        unsafe { &qdev_prop_chr },
+        CharBackend
+    ),
+    qemu_api::define_property!(
+        c"migrate-clk",
+        PL011State,
+        migrate_clock,
+        unsafe { &qdev_prop_bool },
+        bool,
+        default = true
+    ),
+}
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
deleted file mode 100644
index d328d846323..00000000000
--- a/rust/hw/char/pl011/src/device_class.rs
+++ /dev/null
@@ -1,103 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use std::{
-    ffi::{c_int, c_void},
-    ptr::NonNull,
-};
-
-use qemu_api::{
-    bindings::{qdev_prop_bool, qdev_prop_chr},
-    prelude::*,
-    vmstate::VMStateDescription,
-    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
-    zeroable::Zeroable,
-};
-
-use crate::device::{PL011Registers, PL011State};
-
-extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().migrate_clock }
-}
-
-/// Migration subsection for [`PL011State`] clock.
-static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
-    name: c"pl011/clock".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(pl011_clock_needed),
-    fields: vmstate_fields! {
-        vmstate_clock!(PL011State, clock),
-    },
-    ..Zeroable::ZERO
-};
-
-extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    let result = unsafe { state.as_ref().post_load(version_id as u32) };
-    if result.is_err() {
-        -1
-    } else {
-        0
-    }
-}
-
-static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
-    name: c"pl011/regs".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    fields: vmstate_fields! {
-        vmstate_of!(PL011Registers, flags),
-        vmstate_of!(PL011Registers, line_control),
-        vmstate_of!(PL011Registers, receive_status_error_clear),
-        vmstate_of!(PL011Registers, control),
-        vmstate_of!(PL011Registers, dmacr),
-        vmstate_of!(PL011Registers, int_enabled),
-        vmstate_of!(PL011Registers, int_level),
-        vmstate_of!(PL011Registers, read_fifo),
-        vmstate_of!(PL011Registers, ilpr),
-        vmstate_of!(PL011Registers, ibrd),
-        vmstate_of!(PL011Registers, fbrd),
-        vmstate_of!(PL011Registers, ifl),
-        vmstate_of!(PL011Registers, read_pos),
-        vmstate_of!(PL011Registers, read_count),
-        vmstate_of!(PL011Registers, read_trigger),
-    },
-    ..Zeroable::ZERO
-};
-
-pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: c"pl011".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    post_load: Some(pl011_post_load),
-    fields: vmstate_fields! {
-        vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
-    },
-    subsections: vmstate_subsections! {
-        VMSTATE_PL011_CLOCK
-    },
-    ..Zeroable::ZERO
-};
-
-qemu_api::declare_properties! {
-    PL011_PROPERTIES,
-    qemu_api::define_property!(
-        c"chardev",
-        PL011State,
-        char_backend,
-        unsafe { &qdev_prop_chr },
-        CharBackend
-    ),
-    qemu_api::define_property!(
-        c"migrate-clk",
-        PL011State,
-        migrate_clock,
-        unsafe { &qdev_prop_bool },
-        bool,
-        default = true
-    ),
-}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 5c4fbc9d148..2b70d2ff560 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -13,7 +13,6 @@
 //! the [`registers`] module for register types.
 
 mod device;
-mod device_class;
 mod registers;
 
 pub use device::pl011_create;
-- 
2.50.1


