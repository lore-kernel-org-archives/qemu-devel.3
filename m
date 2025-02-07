Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C342C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQN-0007lM-Cs; Fri, 07 Feb 2025 05:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPp-0007Nd-3R
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPn-0004GU-2a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPLe8n7w4lU+JK6BULn/ii43xbBtY2BZigYuJPo3FFQ=;
 b=iII3ZBDf2LGLyi/VU3r2enK8wQP/OsOVRmFXIKO9uatgQ49YHI5Kr2YBP/ZRIVhJugIq1n
 DcIhr6V850c7cyKRUR49mgyE8ww4fPJ6Zh1fxLD3e063w7xGzxyatxGN4U/1PAWLyNYfCk
 V3lxMHi0BHRaFqv38kyQV+Vnclj9nDA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-RAEH24RFN4CgJKh44eEXqA-1; Fri, 07 Feb 2025 05:16:49 -0500
X-MC-Unique: RAEH24RFN4CgJKh44eEXqA-1
X-Mimecast-MFC-AGG-ID: RAEH24RFN4CgJKh44eEXqA
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5dc5beb5eb0so1501294a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:16:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923407; x=1739528207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qPLe8n7w4lU+JK6BULn/ii43xbBtY2BZigYuJPo3FFQ=;
 b=SxQdV+qcXeMXZZjE9q4r5rOtAL5US+HjThVYNS2jlkRmRB02IoDdWMliDMlE03pCNA
 Ea01XNBK8a7UtQyf992SmQ1ye3EQLqoWhI8JLG4deCV14qBfwvk1OINgkNfF+0IkdOcs
 Qgi2J7JN6Ny8gCrcEJU5Fgnjhyu5qkQxrTYYg09VannzKRQF2DlAjC++26D6KoGJ4kyD
 CGebmAmQNaNrp6pOhAMxOViiBJCL87ZVx1qUaPFx+0VHfnmBSq7m31StVUc4v7fTHaXp
 oz0sOrEHCioHIhe9maXqfV+z9nJ8mvNDkgBnSzqk/CD1uv6qL0os6vjQts3L5FkEmcoi
 N7kA==
X-Gm-Message-State: AOJu0YzYQ93FJPfEQc5EU0G9aOzCi6FvjVAIQz6XHiNV6rJIirR0WLxF
 pzEBYfUeJzIFILXJfzwQdKDI0Q55+juNfXeYlS6YnSrYe3YVZSLXQZbjfyVLyfqNnePiC5ATvfE
 nTVKufV7X46j/tPb3rihp2TN+w6i4ZEQ9VAh+Q1PdmfWdqHDFJgvpy6AhoVxzF9t+Y4rq5rlbV/
 g0NM73GXv3trldXYGkX7j809cClhI4GQ9PMtUJjNM=
X-Gm-Gg: ASbGncuDuETHADvOIvtYr2mUQp4ijcGpITT0Ez1PKogWehGJbKhnj0wUG0CN53gWjUy
 9q+ZfB1pNCg2JAhlWDBFyAqIM3+r04vcPzBaNgE2qSV+nXLFuZB804hrkoO7Dux4cutTAH4oJN+
 ue9wGYNT3DpUJGIH3hIKxlS+NphNPwtdP/bBJDIU/hBh6sNwJtxQqu/XkR6pgjRnvoEiFwJrG1Y
 C5l3IwRBjQYyt8uk3gRGtaPvFLPulDKJhMUPWl9Lzz+UQ220KlKFzkRhvI5e5nW9fY8a34HRZ6S
 rzBkpw==
X-Received: by 2002:a05:6402:4588:b0:5db:e91a:6baf with SMTP id
 4fb4d7f45d1cf-5de45015f49mr7206872a12.14.1738923406475; 
 Fri, 07 Feb 2025 02:16:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyLaRlLhMDi0sic2b81oIjyoDiKQ8HxFyoPHsUiHz/TTRI0oQR/+PmMjzhrWK8g7PQ3Zf3VQ==
X-Received: by 2002:a05:6402:4588:b0:5db:e91a:6baf with SMTP id
 4fb4d7f45d1cf-5de45015f49mr7206826a12.14.1738923405955; 
 Fri, 07 Feb 2025 02:16:45 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f904sm2276175a12.58.2025.02.07.02.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 04/12] rust: qdev: add clock creation
Date: Fri,  7 Feb 2025 11:16:15 +0100
Message-ID: <20250207101623.2443552-5-pbonzini@redhat.com>
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

Add a Rust version of qdev_init_clock_in, which can be used in
instance_init.  There are a couple differences with the C
version:

- in Rust the object keeps its own reference to the clock (in addition to
  the one embedded in the NamedClockList), and the reference is dropped
  automatically by instance_finalize(); this is encoded in the signature
  of DeviceClassMethods::init_clock_in, which makes the lifetime of the
  clock independent of that of the object it holds.  This goes unnoticed
  in the C version and is due to the existence of aliases.

- also, anything that happens during instance_init uses the pinned_init
  framework to operate on a partially initialized object, and is done
  through class methods (i.e. through DeviceClassMethods rather than
  DeviceMethods) because the device does not exist yet.  Therefore, Rust
  code *must* create clocks from instance_init, which is stricter than C.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  43 +++++-------
 rust/qemu-api/src/prelude.rs     |   2 +
 rust/qemu-api/src/qdev.rs        | 109 ++++++++++++++++++++++++++++++-
 rust/qemu-api/src/vmstate.rs     |   4 +-
 4 files changed, 127 insertions(+), 31 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index f5db114b0c7..37936a328b8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -10,17 +10,16 @@
 
 use qemu_api::{
     bindings::{
-        error_fatal, hwaddr, memory_region_init_io, qdev_init_clock_in, qdev_prop_set_chr,
-        qemu_chr_fe_accept_input, qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers,
-        qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq, sysbus_mmio_map, sysbus_realize,
-        CharBackend, Chardev, Clock, ClockEvent, MemoryRegion, QEMUChrEvent,
-        CHR_IOCTL_SERIAL_SET_BREAK,
+        error_fatal, hwaddr, memory_region_init_io, qdev_prop_set_chr, qemu_chr_fe_accept_input,
+        qemu_chr_fe_ioctl, qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq,
+        sysbus_connect_irq, sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, MemoryRegion,
+        QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
     },
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
     prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property},
-    qom::{ClassInitImpl, ObjectImpl, ParentField},
+    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property},
+    qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
     sysbus::{SysBusDevice, SysBusDeviceClass},
     vmstate::VMStateDescription,
 };
@@ -131,7 +130,7 @@ pub struct PL011State {
     #[doc(alias = "irq")]
     pub interrupts: [InterruptSource; IRQMASK.len()],
     #[doc(alias = "clk")]
-    pub clock: NonNull<Clock>,
+    pub clock: Owned<Clock>,
     #[doc(alias = "migrate_clk")]
     pub migrate_clock: bool,
 }
@@ -485,8 +484,6 @@ impl PL011State {
     /// location/instance. All its fields are expected to hold unitialized
     /// values with the sole exception of `parent_obj`.
     unsafe fn init(&mut self) {
-        const CLK_NAME: &CStr = c_str!("clk");
-
         // SAFETY:
         //
         // self and self.iomem are guaranteed to be valid at this point since callers
@@ -506,22 +503,16 @@ unsafe fn init(&mut self) {
 
         // SAFETY:
         //
-        // self.clock is not initialized at this point; but since `NonNull<_>` is Copy,
-        // we can overwrite the undefined value without side effects. This is
-        // safe since all PL011State instances are created by QOM code which
-        // calls this function to initialize the fields; therefore no code is
-        // able to access an invalid self.clock value.
-        unsafe {
-            let dev: &mut DeviceState = self.upcast_mut();
-            self.clock = NonNull::new(qdev_init_clock_in(
-                dev,
-                CLK_NAME.as_ptr(),
-                None, /* pl011_clock_update */
-                addr_of_mut!(*self).cast::<c_void>(),
-                ClockEvent::ClockUpdate.0,
-            ))
-            .unwrap();
-        }
+        // self.clock is not initialized at this point; but since `Owned<_>` is
+        // not Drop, we can overwrite the undefined value without side effects;
+        // it's not sound but, because for all PL011State instances are created
+        // by QOM code which calls this function to initialize the fields, at
+        // leastno code is able to access an invalid self.clock value.
+        self.clock = self.init_clock_in("clk", &Self::clock_update, ClockEvent::ClockUpdate);
+    }
+
+    const fn clock_update(&self, _event: ClockEvent) {
+        /* pl011_trace_baudrate_change(s); */
     }
 
     fn post_init(&self) {
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 3df6a5c21ec..87e3ce90f26 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -7,6 +7,8 @@
 pub use crate::cell::BqlCell;
 pub use crate::cell::BqlRefCell;
 
+pub use crate::qdev::DeviceMethods;
+
 pub use crate::qom::IsA;
 pub use crate::qom::Object;
 pub use crate::qom::ObjectCast;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index f4c75c752f1..8f6744c5e26 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -4,14 +4,20 @@
 
 //! Bindings to create devices and access device functionality from Rust.
 
-use std::{ffi::CStr, ptr::NonNull};
+use std::{
+    ffi::{CStr, CString},
+    os::raw::c_void,
+    ptr::NonNull,
+};
 
-pub use bindings::{DeviceClass, DeviceState, Property};
+pub use bindings::{Clock, ClockEvent, DeviceClass, DeviceState, Property};
 
 use crate::{
     bindings::{self, Error},
+    callbacks::FnCall,
+    cell::bql_locked,
     prelude::*,
-    qom::{ClassInitImpl, ObjectClass},
+    qom::{ClassInitImpl, ObjectClass, Owned},
     vmstate::VMStateDescription,
 };
 
@@ -143,3 +149,100 @@ unsafe impl ObjectType for DeviceState {
         unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_DEVICE) };
 }
 qom_isa!(DeviceState: Object);
+
+/// Trait for methods exposed by the [`DeviceState`] class.  The methods can be
+/// called on all objects that have the trait `IsA<DeviceState>`.
+///
+/// The trait should only be used through the blanket implementation,
+/// which guarantees safety via `IsA`.
+pub trait DeviceMethods: ObjectDeref
+where
+    Self::Target: IsA<DeviceState>,
+{
+    /// Add an input clock named `name`.  Invoke the callback with
+    /// `self` as the first parameter for the events that are requested.
+    ///
+    /// The resulting clock is added as a child of `self`, but it also
+    /// stays alive until after `Drop::drop` is called because C code
+    /// keeps an extra reference to it until `device_finalize()` calls
+    /// `qdev_finalize_clocklist()`.  Therefore (unlike most cases in
+    /// which Rust code has a reference to a child object) it would be
+    /// possible for this function to return a `&Clock` too.
+    #[inline]
+    fn init_clock_in<F: for<'a> FnCall<(&'a Self::Target, ClockEvent)>>(
+        &self,
+        name: &str,
+        _cb: &F,
+        events: ClockEvent,
+    ) -> Owned<Clock> {
+        fn do_init_clock_in(
+            dev: *mut DeviceState,
+            name: &str,
+            cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)>,
+            events: ClockEvent,
+        ) -> Owned<Clock> {
+            assert!(bql_locked());
+
+            // SAFETY: the clock is heap allocated, but qdev_init_clock_in()
+            // does not gift the reference to its caller; so use Owned::from to
+            // add one.  The callback is disabled automatically when the clock
+            // is unparented, which happens before the device is finalized.
+            unsafe {
+                let cstr = CString::new(name).unwrap();
+                let clk = bindings::qdev_init_clock_in(
+                    dev,
+                    cstr.as_ptr(),
+                    cb,
+                    dev.cast::<c_void>(),
+                    events.0,
+                );
+
+                Owned::from(&*clk)
+            }
+        }
+
+        let cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)> = if F::is_some() {
+            unsafe extern "C" fn rust_clock_cb<T, F: for<'a> FnCall<(&'a T, ClockEvent)>>(
+                opaque: *mut c_void,
+                event: ClockEvent,
+            ) {
+                // SAFETY: the opaque is "this", which is indeed a pointer to T
+                F::call((unsafe { &*(opaque.cast::<T>()) }, event))
+            }
+            Some(rust_clock_cb::<Self::Target, F>)
+        } else {
+            None
+        };
+
+        // SAFETY: self can be cast to DeviceState because its type has an
+        // IsA<DeviceState> bound.
+        do_init_clock_in(unsafe { self.as_mut_ptr() }, name, cb, events)
+    }
+
+    /// Add an output clock named `name`.
+    ///
+    /// The resulting clock is added as a child of `self`, but it also
+    /// stays alive until after `Drop::drop` is called because C code
+    /// keeps an extra reference to it until `device_finalize()` calls
+    /// `qdev_finalize_clocklist()`.  Therefore (unlike most cases in
+    /// which Rust code has a reference to a child object) it would be
+    /// possible for this function to return a `&Clock` too.
+    #[inline]
+    fn init_clock_out(&self, name: &str) -> Owned<Clock> {
+        unsafe {
+            let cstr = CString::new(name).unwrap();
+            let clk = bindings::qdev_init_clock_out(self.as_mut_ptr(), cstr.as_ptr());
+
+            Owned::from(&*clk)
+        }
+    }
+}
+
+impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
+
+unsafe impl ObjectType for Clock {
+    type Class = ObjectClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CLOCK) };
+}
+qom_isa!(Clock: Object);
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 11d21b8791c..164effc6553 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -470,11 +470,11 @@ macro_rules! vmstate_clock {
                 $crate::assert_field_type!(
                     $struct_name,
                     $field_name,
-                    core::ptr::NonNull<$crate::bindings::Clock>
+                    $crate::qom::Owned<$crate::bindings::Clock>
                 );
                 $crate::offset_of!($struct_name, $field_name)
             },
-            size: ::core::mem::size_of::<*const $crate::bindings::Clock>(),
+            size: ::core::mem::size_of::<*const $crate::qdev::Clock>(),
             flags: VMStateFlags(VMStateFlags::VMS_STRUCT.0 | VMStateFlags::VMS_POINTER.0),
             vmsd: unsafe { ::core::ptr::addr_of!($crate::bindings::vmstate_clock) },
             ..$crate::zeroable::Zeroable::ZERO
-- 
2.48.1


