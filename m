Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DD9D7830C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 11:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI4GC-00053N-6H; Mon, 02 Dec 2024 06:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tI4G4-00050p-SP
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:06:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tI4G2-0005Ge-FF
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 06:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733137584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CPvWGaC61x5SIWSt7f1hm5iB12nylqAohLxeFtFVppQ=;
 b=is+n1apB6zSF3kwAtIzavR+kibkvTrL2KqWaHTCXwGyvuHa0vw19qfP4jY/r+2kh13PFi9
 /xvZDSMHVWMDourTZsOGm50OVXT1JZqDUuxteGuApD5zBj4VktklFjhDhvU7l6rOnBXQ37
 DreTcr3t8Wn0SEYhF1ntFdKVrLh9028=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-JdJUyA7yMAuVzCqvymVO0g-1; Mon, 02 Dec 2024 06:06:20 -0500
X-MC-Unique: JdJUyA7yMAuVzCqvymVO0g-1
X-Mimecast-MFC-AGG-ID: JdJUyA7yMAuVzCqvymVO0g
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d88d56beb7so26875796d6.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 03:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733137579; x=1733742379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPvWGaC61x5SIWSt7f1hm5iB12nylqAohLxeFtFVppQ=;
 b=SnZxxEY7J4Knbtc9N1mBAjKJlevuGBkc9LSP6Bu3CNBfVMvUUULNFEgAkSfJ3J/efd
 dLq7QXUpRSkNIicsLhfTc807FlftHgD5H5JTQazJ6rLpMreGEBBi3sh/nHgajFGRTRNU
 NZuFrvrzs/dN9c5kodiDpekbshXpLp4E4VCEKNygPEE/qcEElt7nzF2mIhF2dP5yOj5t
 1EgJrR/OSfhAaAg0yGs540kcnSSx5xejGaC8b79Q/3KpRiOen3c7MKkqVzjwWHsn0Tl8
 FVtWL72uxP+LymC4L21tgP4DbxboPk63CcPlwEGzt7tymOpaBOItzYkyO5Au6zFwQuOd
 kyjQ==
X-Gm-Message-State: AOJu0Yz/fKv5brJk43hBjoAiAWRtm0U/YxD30LF8tEcmUPv6sFlGtWKZ
 7RGpznrIDeh0BJ8xguyw6HE3vEAbSMd23Ww03C7ioEJD9YhGFHdzV6PBiXnriuhAvHSizDH6OaG
 T6vhHbuZMajmokN+dZgd6KtYE09CZtoBHA5+2cRBuhkTJBb4nPA+9ce52/J1webit2ktJmejixk
 EL0uvJX4wMtFQXFcVBRj4ac2UvTz0w54aXOPkr
X-Gm-Gg: ASbGncvLpzOmOnO1MXjqp1P4XU7EeUTmwoLBG+R/Ru1NxbEx9R5o1nTk8k9BBjnH8oS
 viwh2rQIkyRi2LX9Ky+0KM2u73WczGpMVJQHE+BR7LbwsLFaiUdRYOL+/2UJUq5272lByLhvJPr
 ufDy2Amiw9noc4GUS99Zag16dRGD2zBqzsm75C90McYJVDxJTcPIL/+FqiMhI8tGF+/k89O4cKw
 tbwVYdDGPKEq/XbdOa+oF6fGvaALe0HXL61neFTZxJNmsLdS8L/VO1bAe4Tyx1DDPlzEQb5Tjju
 r1k=
X-Received: by 2002:ad4:5bef:0:b0:6d8:8f81:e2ea with SMTP id
 6a1803df08f44-6d88f81e6cdmr154491396d6.31.1733137578672; 
 Mon, 02 Dec 2024 03:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjzuewtsoavkEm3OOJit9AmU7UeGAiGac4Ty3pvp6DGtcjaNlWqbjRqJK9teeS8VTfhgGFBQ==
X-Received: by 2002:ad4:5bef:0:b0:6d8:8f81:e2ea with SMTP id
 6a1803df08f44-6d88f81e6cdmr154491026d6.31.1733137578164; 
 Mon, 02 Dec 2024 03:06:18 -0800 (PST)
Received: from [192.168.122.1] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849aabcasm390853385a.86.2024.12.02.03.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 03:06:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH v2 2/2] rust: add bindings for interrupt sources
Date: Mon,  2 Dec 2024 12:06:09 +0100
Message-ID: <20241202110609.36775-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202110609.36775-1-pbonzini@redhat.com>
References: <20241202110609.36775-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
 rust/hw/char/pl011/src/device.rs | 22 ++++----
 rust/qemu-api/meson.build        |  2 +
 rust/qemu-api/src/irq.rs         | 91 ++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs         |  2 +
 rust/qemu-api/src/sysbus.rs      | 26 +++++++++
 5 files changed, 133 insertions(+), 10 deletions(-)
 create mode 100644 rust/qemu-api/src/irq.rs
 create mode 100644 rust/qemu-api/src/sysbus.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 317a9b3c5ad..c5c8c463d37 100644
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
index 00000000000..011dbcf3dba
--- /dev/null
+++ b/rust/qemu-api/src/irq.rs
@@ -0,0 +1,91 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for interrupt sources
+
+use core::ptr;
+use std::{marker::PhantomData, os::raw::c_int};
+
+use crate::{
+    bindings::{qemu_set_irq, IRQState},
+    cell::BqlCell,
+};
+
+/// Interrupt sources are used by devices to pass changes to a value (typically
+/// a boolean).  The interrupt sink is usually an interrupt controller or
+/// GPIO controller.
+///
+/// As far as devices are concerned, interrupt sources are always active-high:
+/// for example, `InterruptSource<bool>`'s [`raise`](InterruptSource::raise)
+/// method sends a `true` value to the sink.  If the guest has to see a
+/// different polarity, that change is performed by the board between the
+/// device and the interrupt controller.
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
+/// Interrupt sources can only be triggered under the Big QEMU Lock; `BqlCell`
+/// allows access from whatever thread has it.
+#[derive(Debug)]
+#[repr(transparent)]
+pub struct InterruptSource<T = bool>
+where
+    c_int: From<T>,
+{
+    cell: BqlCell<*mut IRQState>,
+    _marker: PhantomData<T>,
+}
+
+impl InterruptSource<bool> {
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
+}
+
+impl<T> InterruptSource<T>
+where
+    c_int: From<T>,
+{
+    /// Send `level` to the interrupt sink.
+    pub fn set(&self, level: T) {
+        let ptr = self.cell.get();
+        // SAFETY: the pointer is retrieved under the BQL and remains valid
+        // until the BQL is released, which is after qemu_set_irq() is entered.
+        unsafe {
+            qemu_set_irq(ptr, level.into());
+        }
+    }
+
+    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
+        self.cell.as_ptr()
+    }
+}
+
+impl Default for InterruptSource {
+    fn default() -> Self {
+        InterruptSource {
+            cell: BqlCell::new(ptr::null_mut()),
+            _marker: PhantomData,
+        }
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


