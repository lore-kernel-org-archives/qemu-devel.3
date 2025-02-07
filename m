Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDEEC0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQh-0008LK-W9; Fri, 07 Feb 2025 05:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQV-00089n-Ac
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQT-0004Nq-9w
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oC4sSczyHUPcW1OOZ38NHr8TjI3/9SwgCw7OQNwY7a8=;
 b=dkdr8XWp5T2b/AMVWspnyvaQ9qcwp/GzK8vTXnPH+/Tkd1VLAn1yiIV4VBuE3WqvEp2422
 GBw6QuBEEUcHkpqznN7RwSInb30mz6VFuSa4HCjNh+rMNVc/KQZaoN+3VoNVntlY83Xcli
 KFi3MXSmGEC/kW4O1LJGsztWOY65bnc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-HLDGdtmWO6WdQakRnONK8Q-1; Fri, 07 Feb 2025 05:17:31 -0500
X-MC-Unique: HLDGdtmWO6WdQakRnONK8Q-1
X-Mimecast-MFC-AGG-ID: HLDGdtmWO6WdQakRnONK8Q
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab7912ce928so24637266b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923449; x=1739528249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oC4sSczyHUPcW1OOZ38NHr8TjI3/9SwgCw7OQNwY7a8=;
 b=MVavbQDi66lxcjcciR3rXxJJYvhZjLXYhpVtbafXmG+JLFBqxrdLq1oWKzMg0e4Y+U
 wa8vWWItVjLyBHA4Xz3xpvKe9LH4QsbCb1Hl4Jhj1qLy5/fuTY5Qi9gFjjfLOCxBOBoz
 UNbnVwjeIBMl7U5zQJ8h5kWrQBavcRow21kfmyxkWoFNu4Nb/ArugrawBmrWku4K4xaB
 zgwmCytjn/AXhaZDeSvfP8fNar4bLzYgXRev4a0W3ZdHWv+JKNXJOtASI3GmKrxL0BC+
 p6V2Q/85KwtGxDStqV5AGcRjugp+Di6D9xTRya5G8BuqxE0X/0/gOnvXykRHL2txmQcD
 oXMw==
X-Gm-Message-State: AOJu0YzuXHpa/wE+y2Gh3ulE0/mIKBRLHiwWiQZlirOYGD+95vfTT1mO
 mffduzdrQFsooZnC+bOidBgpdTYgEhf6ePR5Af252ZtbtOP7RKIVgHa2VvpnsrQagGyQAfxjZOi
 QuMo6Hi8RBO0cdpaNwdzokB7WzwCnZKmNsvIhalJgM4HyWxMK0VvRz93uRbNCM8MajIWOxrJkTR
 IipTJB99zvmQ3jMqHwvRI7ixgV5fHavp8rf8K4vlc=
X-Gm-Gg: ASbGncuO2LFVv1auo/Pr+Mg+cuVpv6Ai8ZNIBsipTo/jfoJd4OdWym5rYqWIJUBx7TP
 w6o+/HA13jTriOSzr9wsmpAt9/JRphwZ4wOFANnVPu+jGLWRq7M7EDeIEhidYkOUtdoQVB828Qv
 aakX91tDChAo9ckJwCC5DTL9TvhBafPTxkr10kLLTpAOYPyDf0ELuZBYf+hDmp4zY2R8i2GzZ6a
 uWBf1msGpdU0jZ5LSey+P//KCW5VdR6SGKu5OBUmUoNUopyePLseZjqMmN3HSvpE1m72mzmfTcU
 dZm7GQ==
X-Received: by 2002:a17:907:d08d:b0:ab7:6d49:2c03 with SMTP id
 a640c23a62f3a-ab789c60410mr215138466b.19.1738923449222; 
 Fri, 07 Feb 2025 02:17:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFe0xsu8AxCXKMVsluGB+rII8w3U/NIqVdeJNW6ztpaWVv5HgBhXR4pXND5uDrb6wiZzetH/g==
X-Received: by 2002:a17:907:d08d:b0:ab7:6d49:2c03 with SMTP id
 a640c23a62f3a-ab789c60410mr215134966b.19.1738923448776; 
 Fri, 07 Feb 2025 02:17:28 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7732e6192sm238995966b.121.2025.02.07.02.17.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:17:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 12/12] rust: pl011: convert pl011_create to safe Rust
Date: Fri,  7 Feb 2025 11:16:23 +0100
Message-ID: <20250207101623.2443552-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Not a major change but, as a small but significant step in creating
qdev bindings, show how pl011_create can be written without "unsafe"
calls (apart from converting pointers to references).

This also provides a starting point for creating Error** bindings.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 39 ++++++++++++++++----------------
 rust/qemu-api/src/sysbus.rs      | 34 +++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 22f3ca3b4e8..7e936b50eb0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,14 +10,12 @@
 
 use qemu_api::{
     bindings::{
-        error_fatal, qdev_prop_set_chr, qemu_chr_fe_accept_input, qemu_chr_fe_ioctl,
-        qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq,
-        sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, QEMUChrEvent,
-        CHR_IOCTL_SERIAL_SET_BREAK,
+        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
+        qemu_chr_fe_write_all, CharBackend, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
     },
     chardev::Chardev,
-    c_str, impl_vmstate_forward,
-    irq::InterruptSource,
+    impl_vmstate_forward,
+    irq::{IRQState, InterruptSource},
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
@@ -698,26 +696,27 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 
 /// # Safety
 ///
-/// We expect the FFI user of this function to pass a valid pointer for `chr`.
+/// We expect the FFI user of this function to pass a valid pointer for `chr`
+/// and `irq`.
 #[no_mangle]
 pub unsafe extern "C" fn pl011_create(
     addr: u64,
-    irq: qemu_irq,
+    irq: *mut IRQState,
     chr: *mut Chardev,
 ) -> *mut DeviceState {
-    let pl011 = PL011State::new();
-    unsafe {
-        let dev = pl011.as_mut_ptr::<DeviceState>();
-        qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
+    // SAFETY: The callers promise that they have owned references.
+    // They do not gift them to pl011_create, so use `Owned::from`.
+    let irq = unsafe { Owned::<IRQState>::from(&*irq) };
+    let chr = unsafe { Owned::<Chardev>::from(&*chr) };
 
-        let sysbus = pl011.as_mut_ptr::<SysBusDevice>();
-        sysbus_realize(sysbus, addr_of_mut!(error_fatal));
-        sysbus_mmio_map(sysbus, 0, addr);
-        sysbus_connect_irq(sysbus, 0, irq);
-
-        // return the pointer, which is kept alive by the QOM tree; drop owned ref
-        pl011.as_mut_ptr()
-    }
+    let dev = PL011State::new();
+    dev.prop_set_chr("chardev", &chr);
+    dev.realize();
+    dev.mmio_map(0, addr);
+    dev.connect_irq(0, &irq);
+    // SAFETY: return the pointer, which has to be mutable and is kept alive
+    // by the QOM tree; drop owned ref
+    unsafe { dev.as_mut_ptr() }
 }
 
 #[repr(C)]
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index c27dbf79e43..1f071706ce8 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -2,18 +2,18 @@
 // Author(s): Paolo Bonzini <pbonzini@redhat.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ffi::CStr;
+use std::{ffi::CStr, ptr::addr_of_mut};
 
 pub use bindings::{SysBusDevice, SysBusDeviceClass};
 
 use crate::{
     bindings,
     cell::bql_locked,
-    irq::InterruptSource,
+    irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
     qdev::{DeviceClass, DeviceState},
-    qom::ClassInitImpl,
+    qom::{ClassInitImpl, Owned},
 };
 
 unsafe impl ObjectType for SysBusDevice {
@@ -60,6 +60,34 @@ fn init_irq(&self, irq: &InterruptSource) {
             bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
         }
     }
+
+    // TODO: do we want a type like GuestAddress here?
+    fn mmio_map(&self, id: u32, addr: u64) {
+        assert!(bql_locked());
+        let id: i32 = id.try_into().unwrap();
+        unsafe {
+            bindings::sysbus_mmio_map(self.as_mut_ptr(), id, addr);
+        }
+    }
+
+    // Owned<> is used here because sysbus_connect_irq (via
+    // object_property_set_link) adds a reference to the IRQState,
+    // which can prolong its life
+    fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
+        assert!(bql_locked());
+        let id: i32 = id.try_into().unwrap();
+        unsafe {
+            bindings::sysbus_connect_irq(self.as_mut_ptr(), id, irq.as_mut_ptr());
+        }
+    }
+
+    fn realize(&self) {
+        // TODO: return an Error
+        assert!(bql_locked());
+        unsafe {
+            bindings::sysbus_realize(self.as_mut_ptr(), addr_of_mut!(bindings::error_fatal));
+        }
+    }
 }
 
 impl<R: ObjectDeref> SysBusDeviceMethods for R where R::Target: IsA<SysBusDevice> {}
-- 
2.48.1


