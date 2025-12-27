Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9FAE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRM-0006oC-3L; Sat, 27 Dec 2025 04:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRD-0006gN-Qe
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRB-0003eY-H7
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0iF3982sft8+oFlrdUYWicQoJY4NOU6Cauxe2SgZGQ=;
 b=R6XtiAlr3ALtKAGl6lkPc+oT9Ltl+/qYbMRXax841+wQNWJXuKcdhGHVi40K7osHoPs+Sm
 vAjNm8cOp6Tai6RVzIyiYcdiYpTga0SHlRyiCgwWQawqmO9bPjQdMi+08tVyajcuEpygTS
 KmIO4m0EBYQtB87JWdUmZea+mIx9Kt4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-SkpRYjwDPTSVCezVyuCQmQ-1; Sat, 27 Dec 2025 04:18:10 -0500
X-MC-Unique: SkpRYjwDPTSVCezVyuCQmQ-1
X-Mimecast-MFC-AGG-ID: SkpRYjwDPTSVCezVyuCQmQ_1766827089
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so3153562f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827088; x=1767431888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r0iF3982sft8+oFlrdUYWicQoJY4NOU6Cauxe2SgZGQ=;
 b=sKBQSk2N6Wp2CPxW+rxOb0VcxE6lXwdv7LUZIFsTXxRWshftFcnBQZZ3ZjfUhjQqA6
 jJiWTgPy2JSdQBa5+OAGi0cUxsAeeueMq4qs5qQwNdp1i4SbQEBBWMZX7EqSvcoqx8HH
 6u2SoPlIuuIFn2xXTZ4b6NJvHoMhL8fPtpnNv5vSw0DOZ8CX3gunj9W/SwrddeCveyes
 7Ekz5L/hnLo4oodR5P8PZe4JYTu+Hl2A0YjYFIHhP8QgAQJC82zCCTtQFBOCEs4abWSA
 VOiaXI7KS07P48tSxR8PeNMq+06Aum7JBGUZHaxFlEBisuctB+uRLJwW8en02ylIMvAT
 wtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827088; x=1767431888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r0iF3982sft8+oFlrdUYWicQoJY4NOU6Cauxe2SgZGQ=;
 b=nGpt6R1HISyG3Ui4ilhwcnTyolAS3cGleUN6EjHAlEZGWeS9oSIMq8yuNLlXd7oaWv
 YOFEn6Jp9XWg1qHUA3Iz/OWq6rCFGoSkR7gRZubTvq/ge6dmW/uClp1BO5j3qtol36z5
 TLz1fYyWJvF1AMxdlfHDjw9TFMVHuAL9NLq2EzRYTd6xNxsgVHvcRZnAlo+StMLl7QCf
 V9S4/rKUjX50L1BxtXBo8lW+m1jYZKzszBJfs4DeDfB2oDod1zNiTRdUBjIb7jp7ea+i
 Em6MfHlbrqJuK8HtNNdCvACOaxyKVNpGEEDSXyW7zJmiDuKk+BCwd+U5hWWx0Cquw48I
 SQbQ==
X-Gm-Message-State: AOJu0YxfulYg7zbGVAXM9AR9ox0PqbeX1sxsDFJOAsZZoKksqEkkkNwx
 GYHdlbctPOGFErEW7hmXvSsoC5/DLqiF5iJTYreYo4kn7p9rXaCEYYKmZf4R7X0k1EVAHWzE171
 CyTpjlYFOhW+XHynUmB74og6uhOKzThL/lsUCFelI8/4sA1rIZS8Xxq/v6bzkjJPUQfngLPu7tO
 1rPT1KfZSOZXMsE60Y2M0A24u58vEUQvNLQ9Wb7v3i
X-Gm-Gg: AY/fxX491401/eMTvxJo5S/5N6p0UsABhZfhi0Fu5NZaCGWMTbkbWZoDmFy+nXC4l9A
 cWz39zlMljykFu+gwjji2tx+jR7sUOPICWOvarVgh394ibhVWUpwGlsQTXhrszWo0GHeQclU+X9
 zld5gBXJxgvcGjUEcp0qmZWLg3nnyoG8BuWekOQTB+O12N2D7zWD0eea1Mfz4LS5plV6Bx0pxvs
 +uDacwQbcXUHkS/HUN02h/99m8YT+yGVkdq0cZ6ldFy0A9CsV9oQrKRamoOjajUxW1N6h9AJfcq
 8XcXDuNLbRl/AcUeJ1LiVfdXLPIIvQBFQDlkeP/QsTs6vZmpm5AzjbPqiUOfr5PeG3/4Dn6jTAQ
 ZiqWrWS5ZbRHNiO1Q/gl9OOg7UFf2XkmbRWPRdG5yMKQ/M97UQDK7yMzEsjv/1l0UaZGKCEfVmw
 6ds/wtXw0gunYTZEY=
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr214052395e9.32.1766827088126; 
 Sat, 27 Dec 2025 01:18:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5rcsq30k1T3AMDnMq7LkrLVP9lk81w4s+x6+aXLsTQ8v7LH4Dci8lUTpINSPXoKkhHX9uwQ==
X-Received: by 2002:a05:600c:a31a:b0:477:b48d:ba7a with SMTP id
 5b1f17b1804b1-47d1afcd9e2mr214052125e9.32.1766827087531; 
 Sat, 27 Dec 2025 01:18:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d19346d33sm444601745e9.3.2025.12.27.01.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 054/153] rust/hpet: Abstract HPETTimerRegisters struct
Date: Sat, 27 Dec 2025 10:14:41 +0100
Message-ID: <20251227091622.20725-55-pbonzini@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

Place all timer N's registers in a HPETTimerRegisters struct.

This allows all Timer N registers to be grouped together with global
registers and managed using a single lock (BqlRefCell or Mutex) in
future. And this makes it easier to apply ToMigrationState macro.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-11-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 101 ++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index c5b58f8dee7..1bdee064d43 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -174,6 +174,18 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
     timer_cell.borrow_mut().callback()
 }
 
+#[repr(C)]
+#[derive(Debug, Default)]
+pub struct HPETTimerRegisters {
+    // Memory-mapped, software visible timer registers
+    /// Timer N Configuration and Capability Register
+    config: u64,
+    /// Timer N Comparator Value Register
+    cmp: u64,
+    /// Timer N FSB Interrupt Route Register
+    fsb: u64,
+}
+
 /// HPET Timer Abstraction
 #[repr(C)]
 #[derive(Debug)]
@@ -185,14 +197,7 @@ pub struct HPETTimer {
     /// timer block abstraction containing this timer
     state: NonNull<HPETState>,
 
-    // Memory-mapped, software visible timer registers
-    /// Timer N Configuration and Capability Register
-    config: u64,
-    /// Timer N Comparator Value Register
-    cmp: u64,
-    /// Timer N FSB Interrupt Route Register
-    fsb: u64,
-
+    regs: HPETTimerRegisters,
     // Hidden register state
     /// comparator (extended to counter width)
     cmp64: u64,
@@ -217,9 +222,7 @@ fn new(index: u8, state: *const HPETState) -> HPETTimer {
             // is initialized below.
             qemu_timer: unsafe { Timer::new() },
             state: NonNull::new(state.cast_mut()).unwrap(),
-            config: 0,
-            cmp: 0,
-            fsb: 0,
+            regs: Default::default(),
             cmp64: 0,
             period: 0,
             wrap_flag: 0,
@@ -246,32 +249,32 @@ fn is_int_active(&self) -> bool {
     }
 
     const fn is_fsb_route_enabled(&self) -> bool {
-        self.config & (1 << HPET_TN_CFG_FSB_ENABLE_SHIFT) != 0
+        self.regs.config & (1 << HPET_TN_CFG_FSB_ENABLE_SHIFT) != 0
     }
 
     const fn is_periodic(&self) -> bool {
-        self.config & (1 << HPET_TN_CFG_PERIODIC_SHIFT) != 0
+        self.regs.config & (1 << HPET_TN_CFG_PERIODIC_SHIFT) != 0
     }
 
     const fn is_int_enabled(&self) -> bool {
-        self.config & (1 << HPET_TN_CFG_INT_ENABLE_SHIFT) != 0
+        self.regs.config & (1 << HPET_TN_CFG_INT_ENABLE_SHIFT) != 0
     }
 
     const fn is_32bit_mod(&self) -> bool {
-        self.config & (1 << HPET_TN_CFG_32BIT_SHIFT) != 0
+        self.regs.config & (1 << HPET_TN_CFG_32BIT_SHIFT) != 0
     }
 
     const fn is_valset_enabled(&self) -> bool {
-        self.config & (1 << HPET_TN_CFG_SETVAL_SHIFT) != 0
+        self.regs.config & (1 << HPET_TN_CFG_SETVAL_SHIFT) != 0
     }
 
     fn clear_valset(&mut self) {
-        self.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
+        self.regs.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
     }
 
     /// True if timer interrupt is level triggered; otherwise, edge triggered.
     const fn is_int_level_triggered(&self) -> bool {
-        self.config & (1 << HPET_TN_CFG_INT_TYPE_SHIFT) != 0
+        self.regs.config & (1 << HPET_TN_CFG_INT_TYPE_SHIFT) != 0
     }
 
     /// calculate next value of the general counter that matches the
@@ -290,7 +293,7 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
     }
 
     const fn get_individual_route(&self) -> usize {
-        ((self.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
+        ((self.regs.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
     }
 
     fn get_int_route(&self) -> usize {
@@ -328,8 +331,8 @@ fn set_irq(&self, set: bool) {
                 unsafe {
                     address_space_stl_le(
                         addr_of_mut!(address_space_memory),
-                        self.fsb >> 32,  // Timer N FSB int addr
-                        self.fsb as u32, // Timer N FSB int value, truncate!
+                        self.regs.fsb >> 32,  // Timer N FSB int addr
+                        self.regs.fsb as u32, // Timer N FSB int value, truncate!
                         MEMTXATTRS_UNSPECIFIED,
                         null_mut(),
                     );
@@ -369,7 +372,7 @@ fn set_timer(&mut self) {
         let cur_tick: u64 = self.get_state().get_ticks();
 
         self.wrap_flag = 0;
-        self.cmp64 = self.calculate_cmp64(cur_tick, self.cmp);
+        self.cmp64 = self.calculate_cmp64(cur_tick, self.regs.cmp);
         if self.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
@@ -398,25 +401,25 @@ fn del_timer(&self) {
     fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
         trace::trace_hpet_ram_write_tn_cfg((shift / 8).try_into().unwrap());
 
-        let old_val: u64 = self.config;
+        let old_val: u64 = self.regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
         new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
 
         // Switch level-type interrupt to edge-type.
         if deactivating_bit(old_val, new_val, HPET_TN_CFG_INT_TYPE_SHIFT) {
-            // Do this before changing timer.config; otherwise, if
+            // Do this before changing timer.regs.config; otherwise, if
             // HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
             self.update_irq(false);
         }
 
-        self.config = new_val;
+        self.regs.config = new_val;
 
         if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT) && self.is_int_active() {
             self.update_irq(true);
         }
 
         if self.is_32bit_mod() {
-            self.cmp = u64::from(self.cmp as u32); // truncate!
+            self.regs.cmp = u64::from(self.regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
 
@@ -443,7 +446,7 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         trace::trace_hpet_ram_write_tn_cmp((shift / 8).try_into().unwrap());
 
         if !self.is_periodic() || self.is_valset_enabled() {
-            self.cmp = self.cmp.deposit(shift, length, value);
+            self.regs.cmp = self.regs.cmp.deposit(shift, length, value);
         }
 
         if self.is_periodic() {
@@ -458,18 +461,19 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
 
     /// FSB Interrupt Route Register
     fn set_tn_fsb_route_reg(&mut self, shift: u32, len: u32, val: u64) {
-        self.fsb = self.fsb.deposit(shift, len, val);
+        self.regs.fsb = self.regs.fsb.deposit(shift, len, val);
     }
 
     fn reset(&mut self) {
         self.del_timer();
-        self.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
-        self.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
+        self.regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
+        self.regs.config =
+            (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
         if self.get_state().has_msi_flag() {
-            self.config |= 1 << HPET_TN_CFG_FSB_CAP_SHIFT;
+            self.regs.config |= 1 << HPET_TN_CFG_FSB_CAP_SHIFT;
         }
         // advertise availability of ioapic int
-        self.config |=
+        self.regs.config |=
             (u64::from(self.get_state().int_route_cap)) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
         self.period = 0;
         self.wrap_flag = 0;
@@ -485,9 +489,9 @@ fn callback(&mut self) {
                 self.cmp64 += period;
             }
             if self.is_32bit_mod() {
-                self.cmp = u64::from(self.cmp64 as u32); // truncate!
+                self.regs.cmp = u64::from(self.cmp64 as u32); // truncate!
             } else {
-                self.cmp = self.cmp64;
+                self.regs.cmp = self.cmp64;
             }
             self.arm_timer(self.cmp64);
         } else if self.wrap_flag != 0 {
@@ -500,9 +504,9 @@ fn callback(&mut self) {
     const fn read(&self, target: TimerRegister) -> u64 {
         use TimerRegister::*;
         match target {
-            CFG => self.config, // including interrupt capabilities
-            CMP => self.cmp,    // comparator register
-            ROUTE => self.fsb,
+            CFG => self.regs.config, // including interrupt capabilities
+            CMP => self.regs.cmp,    // comparator register
+            ROUTE => self.regs.fsb,
         }
     }
 
@@ -862,7 +866,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
 
-            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.cmp);
+            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.regs.cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
@@ -926,6 +930,22 @@ impl ObjectImpl for HPETState {
         })
         .build();
 
+// In fact, version_id and minimum_version_id for HPETTimerRegisters are
+// unrelated to HPETTimer's version IDs. Does not affect compatibility.
+impl_vmstate_struct!(
+    HPETTimerRegisters,
+    VMStateDescriptionBuilder::<HPETTimerRegisters>::new()
+        .name(c"hpet_timer/regs")
+        .version_id(1)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETTimerRegisters, config),
+            vmstate_of!(HPETTimerRegisters, cmp),
+            vmstate_of!(HPETTimerRegisters, fsb),
+        })
+        .build()
+);
+
 const VMSTATE_HPET_TIMER: VMStateDescription<HPETTimer> =
     VMStateDescriptionBuilder::<HPETTimer>::new()
         .name(c"hpet_timer")
@@ -933,14 +953,13 @@ impl ObjectImpl for HPETState {
         .minimum_version_id(1)
         .fields(vmstate_fields! {
             vmstate_of!(HPETTimer, index),
-            vmstate_of!(HPETTimer, config),
-            vmstate_of!(HPETTimer, cmp),
-            vmstate_of!(HPETTimer, fsb),
+            vmstate_of!(HPETTimer, regs),
             vmstate_of!(HPETTimer, period),
             vmstate_of!(HPETTimer, wrap_flag),
             vmstate_of!(HPETTimer, qemu_timer),
         })
         .build();
+
 impl_vmstate_struct!(HPETTimer, VMSTATE_HPET_TIMER);
 
 const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
-- 
2.52.0


