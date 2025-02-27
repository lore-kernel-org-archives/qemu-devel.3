Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D36C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnenA-0005RM-Fu; Thu, 27 Feb 2025 09:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemc-0003qD-Ib
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemY-00045V-F8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nk4rG8BvOrBCUFxfsl3zj+sJAUqBN7gnD9BX4ggHZ8E=;
 b=Of8fQR6DKSW+gy895Yp1/se+99G5E6TNzTqqJkpPGZXjS1C51yISSv7maC7ZEj3gTWO6NQ
 C7RKOltVVUvI1TFlcQi0ARbEM6jNhkQyCqGLMLfpghsZgUlA9W06iPYYusFUaiKeXUqM0A
 tgGMdHVH5jLfvZBNS1GtIObdVrhjVhI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-cX38hNcHNGmPKacPrlPRLg-1; Thu, 27 Feb 2025 09:22:32 -0500
X-MC-Unique: cX38hNcHNGmPKacPrlPRLg-1
X-Mimecast-MFC-AGG-ID: cX38hNcHNGmPKacPrlPRLg_1740666151
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abb86503062so118528066b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666151; x=1741270951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nk4rG8BvOrBCUFxfsl3zj+sJAUqBN7gnD9BX4ggHZ8E=;
 b=gTCPcEwIMt6uw/xPUbXTTPYCI0G/fsfPk1HrnYfar0PaHNdRDmOtYuxS7h3IOwBRog
 H0lqk4wIsTAVOqLhJbmVDEJUsQo2PyNtat0xelkMIM7jDMOx9oLK0x3tykdzbjvfMzO3
 hmE7WsXkT5WjFL+hWfykZcCb/pOLyy3LayoqJvJ0//M7sMmr/wnDVDm9ukKbpo8OqPai
 A1pSdo8H6kuxJSTPg4uyq16ZLG+qh6YZARIFIXGPnWORFeYHbrS15N3eGEKNwL8E6vnJ
 x9jL/c3Zc0eVTCb4f3rSO7fvoLoozY4i06/OzRAKbdgSWCEbY7vmrMCPnk3KDqsAhANA
 1p4A==
X-Gm-Message-State: AOJu0YyiBlpvs3FkBLxwnu/UAIwCUN9HpYyGXvj/dFvgCBB1mrYkxxsT
 eq8VKfx5Z/s5JzH/JKYOqW//T2+gdg95wDMIC5KKsAyq7Zd3mRobXoKqgNFT3TnHAbeAxSMXQxM
 NObgzvY6YzZYnhtGdNrU3Imp7soI+0Ut9ZmrIeXIdgMBnmcDXxutNbGCtTTj8mwsOmq7NVp1jKq
 SW32W/TUxa5Mb7+VVMFhSG3rqPoGn0uezuNY+zJXQ=
X-Gm-Gg: ASbGncuJ+Hx6grhmsEeGNTsGeGvWqjidFd6MoErQKcRDX3G5nPdcC0VfDTCtumzInD9
 NLKXd+nzpPDh4MOxWqKyRtSTOYyp+XYyBauftDyGbJOa3gxneqF/Tbw8SHOBF4vGKgW6ioxp8vK
 byivXn7hiNVT6awQvk55WviypX8Z4YH7P7KVjiv+E49DMay6nHbFx6y5qLjOqw1xCOEAS4/ug2e
 9v/IHztnGeyvX1VcADfc9MT+4adIifRSK+IoNHsacboj6vLtIXlQo3ChQQXHnykh0jr3Wd675Rq
 Fuo36rgk6C+qQypAD9/S
X-Received: by 2002:a17:906:318a:b0:abb:fcbb:ab20 with SMTP id
 a640c23a62f3a-abeeed8bfdcmr836456366b.22.1740666150635; 
 Thu, 27 Feb 2025 06:22:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEre39vytYWAHhZhXaM95fI3eTfMy8Xz3vq9jO0H3LoqMNmrk3eKo/DJWQnPtAQh4wcgpPdlg==
X-Received: by 2002:a17:906:318a:b0:abb:fcbb:ab20 with SMTP id
 a640c23a62f3a-abeeed8bfdcmr836454166b.22.1740666150047; 
 Thu, 27 Feb 2025 06:22:30 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb4384sm1176263a12.49.2025.02.27.06.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and express
 pinning requirements
Date: Thu, 27 Feb 2025 15:22:11 +0100
Message-ID: <20250227142219.812270-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Timers must be pinned in memory, because modify() stores a pointer to them
in the TimerList.  To ensure this is the case, replace the separate new()
and init_full() with a single function that returns a pinned box.  Because
the only way to obtain a Timer is through Timer::new_full(), modify()
knows that the timer it got is also pinned.  In the future the pinning
requirement will be expressed through the pin_init crate instead.

Note that Timer is a bit different from other users of Opaque, in that
it is created in Rust code rather than C code.  This is why it has to
use the unsafe Opaque::new() function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  7 -----
 rust/hw/timer/hpet/src/hpet.rs | 23 ++++++++---------
 rust/qemu-api/src/timer.rs     | 47 ++++++++++++++++++++++------------
 3 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/meson.build b/meson.build
index 0a2c61d2bfa..fc02e5fc763 100644
--- a/meson.build
+++ b/meson.build
@@ -4098,13 +4098,6 @@ if have_rust
   foreach enum : c_bitfields
     bindgen_args += ['--bitfield-enum', enum]
   endforeach
-  c_nocopy = [
-    'QEMUTimer',
-  ]
-  # Used to customize Drop trait
-  foreach struct : c_nocopy
-    bindgen_args += ['--no-copy', struct]
-  endforeach
 
   # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
   #
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index be27eb0eff4..ce4b289d0c8 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -4,6 +4,7 @@
 
 use std::{
     ffi::CStr,
+    pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
 };
@@ -156,7 +157,7 @@ pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
     #[doc(alias = "tn")]
     index: usize,
-    qemu_timer: Option<Box<Timer>>,
+    qemu_timer: Option<Pin<Box<Timer>>>,
     /// timer block abstraction containing this timer
     state: Option<NonNull<HPETState>>,
 
@@ -189,18 +190,14 @@ fn init(&mut self, index: usize, state_ptr: *mut HPETState) -> &mut Self {
     }
 
     fn init_timer_with_state(&mut self) {
-        self.qemu_timer = Some(Box::new({
-            let mut t = Timer::new();
-            t.init_full(
-                None,
-                CLOCK_VIRTUAL,
-                Timer::NS,
-                0,
-                timer_handler,
-                &self.get_state().timers[self.index],
-            );
-            t
-        }));
+        self.qemu_timer = Some(Timer::new_full(
+            None,
+            CLOCK_VIRTUAL,
+            Timer::NS,
+            0,
+            timer_handler,
+            &self.get_state().timers[self.index],
+        ));
     }
 
     fn get_state(&self) -> &HPETState {
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index a593538917a..a8b2ab058b6 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -2,40 +2,51 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::os::raw::{c_int, c_void};
+use std::{
+    os::raw::{c_int, c_void},
+    pin::Pin,
+};
 
 use crate::{
     bindings::{self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType},
     callbacks::FnCall,
+    cell::Opaque,
 };
 
-pub type Timer = bindings::QEMUTimer;
-pub type TimerListGroup = bindings::QEMUTimerListGroup;
+/// A safe wrapper around [`bindings::QEMUTimer`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct Timer(Opaque<bindings::QEMUTimer>);
+
+unsafe impl Send for Timer {}
+unsafe impl Sync for Timer {}
+
+#[repr(transparent)]
+#[derive(qemu_api_macros::Wrapper)]
+pub struct TimerListGroup(Opaque<bindings::QEMUTimerListGroup>);
+
+unsafe impl Send for TimerListGroup {}
+unsafe impl Sync for TimerListGroup {}
 
 impl Timer {
     pub const MS: u32 = bindings::SCALE_MS;
     pub const US: u32 = bindings::SCALE_US;
     pub const NS: u32 = bindings::SCALE_NS;
 
-    pub fn new() -> Self {
-        Default::default()
-    }
-
-    const fn as_mut_ptr(&self) -> *mut Self {
-        self as *const Timer as *mut _
-    }
-
-    pub fn init_full<'timer, 'opaque: 'timer, T, F>(
-        &'timer mut self,
+    pub fn new_full<'opaque, T, F>(
         timer_list_group: Option<&TimerListGroup>,
         clk_type: ClockType,
         scale: u32,
         attributes: u32,
         _cb: F,
         opaque: &'opaque T,
-    ) where
+    ) -> Pin<Box<Self>>
         F: for<'a> FnCall<(&'a T,)>,
     {
+        // SAFETY: returning a pinned box makes it certain that the object
+        // will not move when added to a TimerList with `modify()`.
+        let t = unsafe { Box::pin(Self(Opaque::new())) };
         let _: () = F::ASSERT_IS_SOME;
 
         /// timer expiration callback
@@ -51,7 +62,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
         // SAFETY: the opaque outlives the timer
         unsafe {
             timer_init_full(
-                self,
+                t.as_mut_ptr(),
                 if let Some(g) = timer_list_group {
                     g as *const TimerListGroup as *mut _
                 } else {
@@ -62,11 +73,14 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
                 attributes as c_int,
                 Some(timer_cb),
                 (opaque as *const T).cast::<c_void>() as *mut c_void,
-            )
+            );
         }
+        t
     }
 
     pub fn modify(&self, expire_time: u64) {
+        // SAFETY: the only way to obtain a Timer is via methods that return a
+        // Pin<Box<Self>>, therefore the timer is pinned
         unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
     }
 
@@ -75,6 +89,7 @@ pub fn delete(&self) {
     }
 }
 
+// FIXME: use something like PinnedDrop from the pinned_init crate
 impl Drop for Timer {
     fn drop(&mut self) {
         self.delete()
-- 
2.48.1


