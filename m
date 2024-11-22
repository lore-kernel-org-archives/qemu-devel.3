Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E285BE65D2F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 07:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOOh-00058Q-Tw; Fri, 22 Nov 2024 02:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOOg-00058I-A4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOOe-0003PH-CS
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 02:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732261687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkXxjzz1/Ou6IvHIAiqoZmLOReU2XBVksCsyChdWv20=;
 b=V1f0+oxrLpRl0tfChdqqmeF4ToYAcb3mtTCFh69QUhBPm6g+W4Ro7XXTE4LWxn0HOgXwkg
 PuBcMT7fq76Fp3hP5YFx0waGSBJw91NnN5S/skmn9/wy6+zZcwfTO4X0AyDwP40nG3W+Ho
 HcdQA7ehVqhHBRdlRnWJbWKno0gAYx0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-aegqa0Q-M7mFkioJUznwcQ-1; Fri, 22 Nov 2024 02:48:05 -0500
X-MC-Unique: aegqa0Q-M7mFkioJUznwcQ-1
X-Mimecast-MFC-AGG-ID: aegqa0Q-M7mFkioJUznwcQ
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-432d04b3d40so11227415e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 23:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732261682; x=1732866482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nkXxjzz1/Ou6IvHIAiqoZmLOReU2XBVksCsyChdWv20=;
 b=Y+a6WvXF6P4ho8/7Y9cW9WTEwgcxOuGbe1APQ9xghX95ik8s0c9WgkCPSa8QBI5F/6
 YHyAM20oEJ/hb8a+kLm7TVA5oBSKh8J1iw2C0JVUHb3/XXSp714h096b/mEZpYkiADAS
 vDXgPmc+gTBLHfj/7xaoWtUuUVf3bSvI40mqO6eS1da0ZOnRngkf/OvfNBs4ozMueN/m
 W7msYwHs3UroYB97HmpLu+2IUJGz802xfgY8tEYe4k82bi3FTvpjNmbRSeD3TZgI8LPf
 o09ADQt2nJLbMr/p+nOKmVNgThMsbcJIsK2+IyJl5XzIeAQ3uSZAZ0Zmb9atD09ujDFR
 XQfg==
X-Gm-Message-State: AOJu0YxjqUA41BF/G9VK0pU60ajyn6zli59/hT7F5huA0Aen3h0hQ3Wl
 YuCEJLS0ELtcUp2UC902VN9C8OTg7sfHs2jPb5cBr9BMdQXhmyCqTfH1CNj1OvZP03wK0t30SF9
 Raq1y2mZysSrdo6NpF1jQ0Re07f7aJ4rKn1jPXQLGFmlnIbdSiNUoPloa+PxHW76FVE1CW5giBg
 YtVUbdhBBEMXMjOLa7HpZMR1xZ8LPG9XUyaDKC
X-Gm-Gg: ASbGncvBnMb4FaKeeXby29GFH9LgY5JNAGow5Ate/1aS6vEkReRSfbWvqCaJxTLLtEk
 cTX1CPH536oTWrcO4Jb9AVUKTfsdgc2TKV4p5PTTZi/QEVIyqF5+Aufhe+NcR+6XPXuivoK+8fT
 yVv9bKZl+hSevLOX+5Sl0puVbAP/V9kwlJRsGH02T7HUlIO2yo0jnC1ayDaikD2r97zUvuzwx0u
 g/25HVIpKtWCGuvwnt63PqMgE5C6Z6cdBLb2yom/yc5mbbMnClNag==
X-Received: by 2002:a05:6000:188c:b0:382:2276:c93c with SMTP id
 ffacd0b85a97d-38260bce871mr1545615f8f.44.1732261681975; 
 Thu, 21 Nov 2024 23:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEESruyTio13ifrLzMjOAOsgqywStiCT1onPyGqRutu90TcKero1dmyjrUe1Ow8CvXsOvJ9tg==
X-Received: by 2002:a05:6000:188c:b0:382:2276:c93c with SMTP id
 ffacd0b85a97d-38260bce871mr1545594f8f.44.1732261681518; 
 Thu, 21 Nov 2024 23:48:01 -0800 (PST)
Received: from [192.168.10.3] ([151.49.204.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb30bfdsm1667602f8f.56.2024.11.21.23.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 23:48:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: junjie.mao@hotmail.com,
	zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 2/2] rust: add bindings for interrupt sources
Date: Fri, 22 Nov 2024 08:47:56 +0100
Message-ID: <20241122074756.282142-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122074756.282142-1-pbonzini@redhat.com>
References: <20241122074756.282142-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The InterruptSource bindings let us call qemu_set_irq() and sysbus_init_irq()
as safe code.

Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
They are QOM link properties and can be written to outside the control
of the device (i.e. from a shared reference); therefore they must be
interior-mutable in Rust.  Since thread-safety is provided by the BQL,
what we want here is the newly-introduced BqlCell.  A pointer to the
contents of the BqlCell (an IRQState**, or equivalently qemu_irq*)
is then passed to the C sysbus_init_irq function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 22 ++++++-----
 rust/qemu-api/meson.build        |  2 +
 rust/qemu-api/src/irq.rs         | 66 ++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs         |  2 +
 rust/qemu-api/src/sysbus.rs      | 26 +++++++++++++
 5 files changed, 108 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index e582a31e4d3..7e57634bba0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -13,6 +13,7 @@
     c_str,
     definitions::ObjectImpl,
     device_class::TYPE_SYS_BUS_DEVICE,
+    irq::InterruptSource,
 };
 
 use crate::{
@@ -94,7 +95,7 @@ pub struct PL011State {
     ///  * sysbus IRQ 5: `UARTEINTR` (error interrupt line)
     /// ```
     #[doc(alias = "irq")]
-    pub interrupts: [qemu_irq; 6usize],
+    pub interrupts: [InterruptSource; IRQMASK.len()],
     #[doc(alias = "clk")]
     pub clock: NonNull<Clock>,
     #[doc(alias = "migrate_clk")]
@@ -139,7 +140,8 @@ impl PL011State {
     unsafe fn init(&mut self) {
         const CLK_NAME: &CStr = c_str!("clk");
 
-        let dev = addr_of_mut!(*self).cast::<DeviceState>();
+        let sbd = unsafe { &mut *(addr_of_mut!(*self).cast::<SysBusDevice>()) };
+
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
@@ -153,12 +155,15 @@ unsafe fn init(&mut self) {
                 Self::TYPE_INFO.name,
                 0x1000,
             );
-            let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
             sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
-            for irq in self.interrupts.iter_mut() {
-                sysbus_init_irq(sbd, irq);
-            }
         }
+
+        for irq in self.interrupts.iter() {
+            sbd.init_irq(irq);
+        }
+
+        let dev = addr_of_mut!(*self).cast::<DeviceState>();
+
         // SAFETY:
         //
         // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
@@ -498,10 +503,7 @@ pub fn put_fifo(&mut self, value: c_uint) {
     pub fn update(&self) {
         let flags = self.int_level & self.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
-            // SAFETY: self.interrupts have been initialized in init().
-            unsafe {
-                qemu_set_irq(*irq, i32::from(flags & i != 0));
-            }
+            irq.set(flags & i != 0);
         }
     }
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index edc21e1a3f8..973cfbcfb4a 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -17,7 +17,9 @@ _qemu_api_rs = static_library(
       'src/c_str.rs',
       'src/definitions.rs',
       'src/device_class.rs',
+      'src/irq.rs',
       'src/offset_of.rs',
+      'src/sysbus.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
new file mode 100644
index 00000000000..7dbff007995
--- /dev/null
+++ b/rust/qemu-api/src/irq.rs
@@ -0,0 +1,66 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for interrupt sources
+
+use core::ptr;
+
+use crate::{
+    bindings::{qemu_set_irq, IRQState},
+    cell::BqlCell,
+};
+
+/// Interrupt sources are used by devices to pass changes to a boolean value to
+/// other devices (typically interrupt or GPIO controllers).  QEMU interrupt
+/// sources are always active-high.
+///
+/// Interrupts are implemented as a pointer to the interrupt "sink", which has
+/// type [`IRQState`].  A device exposes its source as a QOM link property using
+/// a function such as
+/// [`SysBusDevice::init_irq`](crate::sysbus::SysBusDevice::init_irq), and
+/// initially leaves the pointer to a NULL value, representing an unconnected
+/// interrupt. To connect it, whoever creates the device fills the pointer with
+/// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
+/// devices are generally shared objects, interrupt sources are an example of
+/// the interior mutability pattern.
+///
+/// Interrupt sources can only be triggered under the Big QEMU Lock; they are
+/// neither `Send` nor `Sync`.
+#[derive(Debug)]
+pub struct InterruptSource(BqlCell<*mut IRQState>);
+
+impl InterruptSource {
+    /// Send a low (`false`) value to the interrupt sink.
+    pub fn lower(&self) {
+        self.set(false);
+    }
+
+    /// Send a high-low pulse to the interrupt sink.
+    pub fn pulse(&self) {
+        self.set(true);
+        self.set(false);
+    }
+
+    /// Send a high (`true`) value to the interrupt sink.
+    pub fn raise(&self) {
+        self.set(true);
+    }
+
+    /// Send `level` to the interrupt sink.
+    pub fn set(&self, level: bool) {
+        unsafe {
+            qemu_set_irq(self.0.get(), level.into());
+        }
+    }
+
+    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
+        self.0.as_ptr()
+    }
+}
+
+impl Default for InterruptSource {
+    fn default() -> Self {
+        InterruptSource(BqlCell::new(ptr::null_mut()))
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index b04d110b3f5..aa692939688 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -11,7 +11,9 @@
 pub mod cell;
 pub mod definitions;
 pub mod device_class;
+pub mod irq;
 pub mod offset_of;
+pub mod sysbus;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
new file mode 100644
index 00000000000..1a9b8a1f971
--- /dev/null
+++ b/rust/qemu-api/src/sysbus.rs
@@ -0,0 +1,26 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::ptr::addr_of;
+
+pub use bindings::{SysBusDevice, SysBusDeviceClass};
+
+use crate::{bindings, irq::InterruptSource};
+
+impl SysBusDevice {
+    /// Return `self` cast to a mutable pointer, for use in calls to C code.
+    const fn as_mut_ptr(&self) -> *mut SysBusDevice {
+        addr_of!(*self) as *mut _
+    }
+
+    /// Expose an interrupt source outside the device as a qdev GPIO output.
+    /// Note that the ordering of calls to `init_irq` is important, since
+    /// whoever creates the sysbus device will refer to the interrupts with
+    /// a number that corresponds to the order of calls to `init_irq`.
+    pub fn init_irq(&self, irq: &InterruptSource) {
+        unsafe {
+            bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
+        }
+    }
+}
-- 
2.47.0


