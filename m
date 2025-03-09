Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6898DC28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwg-00082G-PU; Sun, 09 Mar 2025 06:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwe-00081x-SC
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwd-00040v-2i
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKG0+7vvmzJjH9RZ/kZaNMaiamUMnuHG7RF4nx4rnY8=;
 b=MIrF61OtPJViGNOYX7cH5M/W4bXyp5W+5hjdxsRa2S7Zo4XM7YzExtY+PGiI2oKBm6o+dZ
 QPmm5cOm+yZhUa6xQklbBuKDgmrcT3jEBN3kZibjOCykbzOBqQVyeO26mPu09L0MjZCxm7
 RyCJzQK8cJo9buIpG4PBPPZeA+y6Yp0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-pYuEZ0n_P9WnqoFmZXjImg-1; Sun, 09 Mar 2025 06:31:40 -0400
X-MC-Unique: pYuEZ0n_P9WnqoFmZXjImg-1
X-Mimecast-MFC-AGG-ID: pYuEZ0n_P9WnqoFmZXjImg_1741516299
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912fe32b08so1541298f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516299; x=1742121099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKG0+7vvmzJjH9RZ/kZaNMaiamUMnuHG7RF4nx4rnY8=;
 b=u2UKPYfqPadgHk4enQVSg+C2ezVStZUhjxAXk4Uh8VJ8pEs0p8bnqSlSfIJ6rlMeCs
 2ycPXiCqpP6bCRSlYqPDRe6ApXValM9X3xZAqmiL3r/tAd4d/QLyuV1525RFg/lEiHQB
 DfH+GktdoMfOzxipCoLcq+3YSPjr+FFRMKbYswnPMShrt1Z7IRK98Wa5MvQ7QQ3yeljf
 xjDXagJD8hbhqaqGUwZB9I4kgFNb/IACY0pYOOMG72iLauVLr7tJlBnHYPntKNyWYjUd
 DdJNefTXk0nAcaYSuO32RvSGPaLVUGaXKQieSFDGgLY5GPIpyqVwq/AzyA/XgqX80Bmn
 csnA==
X-Gm-Message-State: AOJu0Yy4BYCn7uS6VUNTWyJzQucuQ5Z2IxZ9nL1etfifKuE8WXAsjzi1
 I6j8iYJVM0vzf7/ww/kQOxgt8g2ZM3+cez8riWuoNMzbGZAfT91rDbWHvQMEZo0rNli8ZBLcS+J
 Z75We9jl7zKM3QgauH0moP7SBJztHrEyPxJ0p6wP5of4gX1JOC9iT+gtz1TnVZDyLuvEaXC0nXM
 YyNlFFjbSDI/caxeGpsHpyPnzxXr+7JJ+427Iys5s=
X-Gm-Gg: ASbGncvRKyRkHr7vC3gQeABWSjfWaMtQdh86/BFwng/rS0DvGauvcm/KwL2UIgG0JUH
 o9BFqff0oj4RgU+LE/xyZ+eVgtychoJ7InNnR+klZPrp3fdhclmj3AbNfcL06KEezP9/AW72eEg
 5Ebw6CQjPPZfRT2CdpFvTmstxxU01cowDDtvRHUTD7IzfGNA6dVak1Cs0idAveELIhoseY2qFSs
 Vdp9htiVfWJ1KausTvcJ0KQyt63vbZsYSRXNT3eie7Z11oc7Yv0eY+bl9H9HXZdMQQnEGbQmrJx
 8G4Z9bOce6bQnEezVHFklQ==
X-Received: by 2002:a05:6000:4107:b0:391:441b:baac with SMTP id
 ffacd0b85a97d-391441bbe46mr842848f8f.50.1741516298940; 
 Sun, 09 Mar 2025 03:31:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElMvNAk97L6LFWmT2+LvqrPo//7Saw/7zAClcolLQrawQNjp67Uu+oNtBuPb9VACiTztamPg==
X-Received: by 2002:a05:6000:4107:b0:391:441b:baac with SMTP id
 ffacd0b85a97d-391441bbe46mr842829f8f.50.1741516298397; 
 Sun, 09 Mar 2025 03:31:38 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da097sm113501555e9.17.2025.03.09.03.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/25] rust: timer: wrap QEMUTimer with Opaque<> and express
 pinning requirements
Date: Sun,  9 Mar 2025 11:31:01 +0100
Message-ID: <20250309103120.1116448-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
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

Timers must be pinned in memory, because modify() stores a pointer to them
in the TimerList.  To express this requirement, change init_full() to take
a pinned reference.  Because the only way to obtain a Timer is through
Timer::new(), which is unsafe, modify() can assume that the timer it got
was later initialized; and because the initialization takes a Pin<&mut
Timer> modify() can assume that the timer is pinned.  In the future the
pinning requirement will be expressed through the pin_init crate instead.

Note that Timer is a bit different from other users of Opaque, in that
it is created in Rust code rather than C code.  This is why it has to
use the unsafe constructors provided by Opaque; and in fact Timer::new()
is also unsafe, because it leaves it to the caller to invoke init_full()
before modify().  Without a call to init_full(), modify() will cause a
NULL pointer dereference.

An alternative could be to combine new() + init_full() by returning a
pinned box; however, using a reference makes it easier to express
the requirement that the opaque outlives the timer.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                    |  7 -----
 rust/hw/timer/hpet/src/hpet.rs | 10 ++++++--
 rust/qemu-api/src/timer.rs     | 47 ++++++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/meson.build b/meson.build
index 67ec2b78319..6da4eb317c2 100644
--- a/meson.build
+++ b/meson.build
@@ -4100,13 +4100,6 @@ if have_rust
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
index 02c81ae048f..3d3d6ef8eec 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -4,6 +4,7 @@
 
 use std::{
     ffi::CStr,
+    pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
 };
@@ -184,7 +185,9 @@ impl HPETTimer {
     fn init(&mut self, index: usize, state: &HPETState) {
         *self = HPETTimer {
             index,
-            qemu_timer: Timer::new(),
+            // SAFETY: the HPETTimer will only be used after the timer
+            // is initialized below.
+            qemu_timer: unsafe { Timer::new() },
             state: NonNull::new(state as *const _ as *mut _).unwrap(),
             config: 0,
             cmp: 0,
@@ -195,7 +198,10 @@ fn init(&mut self, index: usize, state: &HPETState) {
             last: 0,
         };
 
-        self.qemu_timer.init_full(
+        // SAFETY: HPETTimer is only used as part of HPETState, which is
+        // always pinned.
+        let qemu_timer = unsafe { Pin::new_unchecked(&mut self.qemu_timer) };
+        qemu_timer.init_full(
             None,
             CLOCK_VIRTUAL,
             Timer::NS,
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index a593538917a..f0b04ef95d7 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -2,31 +2,51 @@
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
+    /// Create a `Timer` struct without initializing it.
+    ///
+    /// # Safety
+    ///
+    /// The timer must be initialized before it is armed with
+    /// [`modify`](Self::modify).
+    pub unsafe fn new() -> Self {
+        // SAFETY: requirements relayed to callers of Timer::new
+        Self(unsafe { Opaque::zeroed() })
     }
 
+    /// Create a new timer with the given attributes.
     pub fn init_full<'timer, 'opaque: 'timer, T, F>(
-        &'timer mut self,
+        self: Pin<&'timer mut Self>,
         timer_list_group: Option<&TimerListGroup>,
         clk_type: ClockType,
         scale: u32,
@@ -51,7 +71,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
         // SAFETY: the opaque outlives the timer
         unsafe {
             timer_init_full(
-                self,
+                self.as_mut_ptr(),
                 if let Some(g) = timer_list_group {
                     g as *const TimerListGroup as *mut _
                 } else {
@@ -67,14 +87,19 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
     }
 
     pub fn modify(&self, expire_time: u64) {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
         unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
     }
 
     pub fn delete(&self) {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned
         unsafe { timer_del(self.as_mut_ptr()) }
     }
 }
 
+// FIXME: use something like PinnedDrop from the pinned_init crate
 impl Drop for Timer {
     fn drop(&mut self) {
         self.delete()
-- 
2.48.1


