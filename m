Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78123E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRe-0007gz-Fx; Sat, 27 Dec 2025 04:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRZ-0007GE-CI
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRW-00049N-0m
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIU29rCd+LxhpC3MSMAwtQsowNWKj0bEzD+0h4XZ9Y8=;
 b=JTVL5LPLH4Y5k5pBQWJXHKwPRA4UpwTOv/LiaKZVxMic7ym/HDg/cbrJyCx2TZ53P9C1d9
 Z6O8g/neVkYBkb5MpsON6h9txxAkuethvr8G350n0gSt94gcseGnYbEJztDxZZ0Dm8Tb8R
 IRYg+aubd/n5Fx+SlCkw12evYM9k8BI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-6hz0Trz2MZiz4tqr3XU_qA-1; Sat, 27 Dec 2025 04:18:31 -0500
X-MC-Unique: 6hz0Trz2MZiz4tqr3XU_qA-1
X-Mimecast-MFC-AGG-ID: 6hz0Trz2MZiz4tqr3XU_qA_1766827111
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so73398815e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827110; x=1767431910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIU29rCd+LxhpC3MSMAwtQsowNWKj0bEzD+0h4XZ9Y8=;
 b=FH+IZnFjwKCdevGsGyeXZMONAMOg8LwMjWKJRnJoTvHjxEy2YHFEa2lNocN8QRPr1u
 lq7kAunF/Pev0DH9fTNbGXqAwQV2DTbfk9eOA0Dpyn1NiN60moWH63wVo3//HD30JL+n
 4mgmWrazB3V3yQBKf+wCTxPVZH95q3EbJlTt0UO92bNaX7O4x3bhYLvsBKK6A8nK3aRL
 jlk92WXAWN0PGEZuvXIZFFMZTyfA6hdo0yodll16T7hPh7Qsz10GJJaJqfa1AQkbM99y
 Yy/k1r8mw0r9eOEYSJHcody1/XYGqp7mQTMc25GPtG+kV+N8io5QLLc7pO4K7W9bZT3X
 P5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827110; x=1767431910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TIU29rCd+LxhpC3MSMAwtQsowNWKj0bEzD+0h4XZ9Y8=;
 b=pu+LEJaBTSIbjl45+eV5Xzh4Iokun3lIdqAfMk1TtYvIhbpNOZFZNtnsj8Qlh1v89c
 q30XBMnpy6nyAMzkXM+N5EKH1iA8KtMxm1s0VNlHQ11ZaGfvw7E9Rjy474vNBzRG/VrH
 GmRh2acgY98DRsb3HG88YMeIGfMes2aT55gREI8RBPTrc7CjYCI8ZIX5KB5BtftkT1BR
 LwGgHbo0n7SfYhY/V/uocYAWoGUErvIQaBZIJwKg5ldX6Zvz6IoiJIEDkf84BT5roYMP
 z4RqGWMrGVU0BOSEykUYNXU9c4zZ4Iv+af+VHM0gw9R/C5wINYzH8W/RK5t8VadtCLYS
 +X8g==
X-Gm-Message-State: AOJu0Yy7UiZzX2TR/KkFrzMwqX9CjyjZIOtGYRW7nC5YYrVKGYB678Gj
 G36ZTySl/AB5+K1BuDRr4tD6OMD7fSNizPpoO7v/s3UJRpFAr51Bv3bXCkbspGjSOkTRhm1FSxz
 O3s2hSK2hiHt7W07YRxqGyz3lohZDqnZP7ROZIs1rRLDOCPTpq+f58OAqu/tHpX6E6jO0hLG8kh
 X+0gqCj2epZPqnkeNUEke1VKqiFv4+FpDWJpl/ZcJ+
X-Gm-Gg: AY/fxX7WbxgAXwA0cPbxRYwN6hFWke5KimoBNHiPFP4VMcOu/OV7epzVbVCkDQw5PQj
 ge8l8LgT/XzuYX2/O9fyQGSOTm8/b5rkF07h4igdHwlp8Nk9RYcgKrNB5GhhVTcoDmAHb2Jv01b
 Uafvkzm1oYKIRZAHHDvxMZcw8iD6KbWLQCRCU/zpU5bigpZnIGcoMmqcb7wYXmNNnDgK7q8lZu8
 DB+IG250bBLmywl7ix8P3CkFmn+2qadzlyT0kIwSzAi5QynnLGN5EloAQnKeC/85jL2Xyrnlb6F
 bAphfPzv2bXv0CewzhwQP40g08osjE9jTqHvz/uj68V54IITQNY84HBkJPFoPHLIqXyIHhqQG3o
 jCQ3a8BFjFzC6iy8c0oEuKJxEwNMTEhQg1tbF9+zlZyQdiCrGk5cBSuzHMs1atLx7g2H2AdyO/j
 3p5p7z68AOXvqYXNA=
X-Received: by 2002:a05:600c:444b:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47d1959fa3emr276877785e9.25.1766827109704; 
 Sat, 27 Dec 2025 01:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEz4iDWNydYWwaLoj6tY+myOl2zIKD894Mg73uq8euM6LeRrRMWUjYJPjyNzNrdXg0TxRisw==
X-Received: by 2002:a05:600c:444b:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47d1959fa3emr276877585e9.25.1766827109260; 
 Sat, 27 Dec 2025 01:18:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aea77bsm188463155e9.17.2025.12.27.01.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 064/153] rust/hpet: remove BqlRefCell around HPETTimer
Date: Sat, 27 Dec 2025 10:14:51 +0100
Message-ID: <20251227091622.20725-65-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

HPETTimer now has all of its state stored in HPETRegisters, so it does not
need its own BqlRefCell anymore.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 55 ++++++++++++++++----------------
 rust/util/src/timer.rs           | 12 ++++---
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 005e41aec47..0dbfc5b3bab 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -126,7 +126,7 @@ enum DecodedRegister<'a> {
     Global(GlobalRegister),
 
     /// Register in the timer block `0x100`...`0x3ff`
-    Timer(&'a BqlRefCell<HPETTimer>, TimerRegister),
+    Timer(&'a HPETTimer, TimerRegister),
 
     /// Invalid address
     #[allow(dead_code)]
@@ -170,8 +170,7 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
     (old & mask != 0) && (new & mask == 0)
 }
 
-fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
-    let t = timer_cell.borrow();
+fn timer_handler(t: &HPETTimer) {
     // SFAETY: state field is valid after timer initialization.
     let hpet_regs = &unsafe { t.state.as_ref() }.regs;
     t.callback(&mut hpet_regs.borrow_mut())
@@ -277,12 +276,16 @@ fn new(index: u8, state: *const HPETState) -> HPETTimer {
         }
     }
 
-    fn init_timer_with_cell(cell: &BqlRefCell<Self>) {
-        let mut timer = cell.borrow_mut();
-        // SAFETY: HPETTimer is only used as part of HPETState, which is
-        // always pinned.
-        let qemu_timer = unsafe { Pin::new_unchecked(&mut timer.qemu_timer) };
-        qemu_timer.init_full(None, CLOCK_VIRTUAL, Timer::NS, 0, timer_handler, cell);
+    fn init_timer(timer: Pin<&mut Self>) {
+        Timer::init_full(
+            timer,
+            None,
+            CLOCK_VIRTUAL,
+            Timer::NS,
+            0,
+            timer_handler,
+            |t| &mut t.qemu_timer,
+        );
     }
 
     fn get_state(&self) -> &HPETState {
@@ -619,7 +622,7 @@ pub struct HPETState {
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
-    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    timers: [HPETTimer; HPET_MAX_TIMERS],
     #[property(rename = "timers", default = HPET_MIN_TIMERS)]
     num_timers: usize,
     num_timers_save: BqlCell<u8>,
@@ -662,11 +665,10 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
 
             // Initialize in two steps, to avoid calling Timer::init_full on a
             // temporary that can be moved.
-            let timer = timer.write(BqlRefCell::new(HPETTimer::new(
-                index.try_into().unwrap(),
-                state,
-            )));
-            HPETTimer::init_timer_with_cell(timer);
+            let timer = timer.write(HPETTimer::new(index.try_into().unwrap(), state));
+            // SAFETY: HPETState is pinned
+            let timer = unsafe { Pin::new_unchecked(timer) };
+            HPETTimer::init_timer(timer);
         }
     }
 
@@ -683,8 +685,7 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
             self.hpet_offset
                 .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
 
-            for timer in self.timers.iter().take(self.num_timers) {
-                let t = timer.borrow();
+            for t in self.timers.iter().take(self.num_timers) {
                 let id = t.index as usize;
                 let tn_regs = &regs.tn_regs[id];
 
@@ -697,8 +698,8 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
             // Halt main counter and disable interrupt generation.
             regs.counter = self.get_ticks();
 
-            for timer in self.timers.iter().take(self.num_timers) {
-                timer.borrow().del_timer(regs);
+            for t in self.timers.iter().take(self.num_timers) {
+                t.del_timer(regs);
             }
         }
 
@@ -720,9 +721,9 @@ fn set_int_status_reg(&self, regs: &mut HPETRegisters, shift: u32, _len: u32, va
         let new_val = val << shift;
         let cleared = new_val & regs.int_status;
 
-        for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
-            if cleared & (1 << index) != 0 {
-                timer.borrow().update_irq(regs, false);
+        for t in self.timers.iter().take(self.num_timers) {
+            if cleared & (1 << t.index) != 0 {
+                t.update_irq(regs, false);
             }
         }
     }
@@ -807,8 +808,8 @@ fn realize(&self) -> util::Result<()> {
 
     fn reset_hold(&self, _type: ResetType) {
         let mut regs = self.regs.borrow_mut();
-        for timer in self.timers.iter().take(self.num_timers) {
-            timer.borrow().reset(&mut regs);
+        for t in self.timers.iter().take(self.num_timers) {
+            t.reset(&mut regs);
         }
 
         regs.counter = 0;
@@ -864,7 +865,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         use DecodedRegister::*;
         use GlobalRegister::*;
         (match target {
-            Timer(timer, tn_target) => timer.borrow().read(tn_target, regs),
+            Timer(t, tn_target) => t.read(tn_target, regs),
             Global(CAP) => regs.capability, /* including HPET_PERIOD 0x004 */
             Global(CFG) => regs.config,
             Global(INT_STATUS) => regs.int_status,
@@ -895,9 +896,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
         use DecodedRegister::*;
         use GlobalRegister::*;
         match target {
-            Timer(timer, tn_target) => timer
-                .borrow()
-                .write(tn_target, &mut regs, value, shift, len),
+            Timer(t, tn_target) => t.write(tn_target, &mut regs, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
             Global(CFG) => self.set_cfg_reg(&mut regs, shift, len, value),
             Global(INT_STATUS) => self.set_int_status_reg(&mut regs, shift, len, value),
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index c6b3e4088ec..829f52d111e 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -45,14 +45,14 @@ impl Timer {
     }
 
     /// Create a new timer with the given attributes.
-    pub fn init_full<'timer, 'opaque: 'timer, T, F>(
-        self: Pin<&'timer mut Self>,
+    pub fn init_full<T, F>(
+        opaque: Pin<&mut T>,
         timer_list_group: Option<&TimerListGroup>,
         clk_type: ClockType,
         scale: u32,
         attributes: u32,
         _cb: F,
-        opaque: &'opaque T,
+        field: impl FnOnce(&mut T) -> &mut Self,
     ) where
         F: for<'a> FnCall<(&'a T,)>,
     {
@@ -70,8 +70,10 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
 
         // SAFETY: the opaque outlives the timer
         unsafe {
+            let opaque = Pin::into_inner_unchecked(opaque);
+            let timer = field(opaque).as_mut_ptr();
             timer_init_full(
-                self.as_mut_ptr(),
+                timer,
                 if let Some(g) = timer_list_group {
                     g as *const TimerListGroup as *mut _
                 } else {
@@ -81,7 +83,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
                 scale as c_int,
                 attributes as c_int,
                 Some(timer_cb),
-                (opaque as *const T).cast::<c_void>().cast_mut(),
+                (opaque as *mut T).cast::<c_void>(),
             )
         }
     }
-- 
2.52.0


