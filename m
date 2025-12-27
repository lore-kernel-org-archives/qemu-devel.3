Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9398E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRT-00074U-SB; Sat, 27 Dec 2025 04:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRE-0006kz-Ue
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRB-0003ec-Tw
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paa+WcSbaqh3C78vzKBguRWQhtas8zYMwVuB+87aW10=;
 b=fPDm/KtbcH0KhOI0WmFXm34Pi8BCgZe1iLr6j8vSOyYiKMr+KyfpK7XcN/XPm0m8MPmNZj
 cIVmKlaQwrLOftkcpEYtiT9u+IFs45WZmC5qwDn2entC0Zbw5HmM58YxF9u8UXhtAYaupQ
 XYVrWHf0hBsWvPBaVB21wxc/aTQ0prE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-Nr5NrB48OW6w2G2EIeni-Q-1; Sat, 27 Dec 2025 04:18:12 -0500
X-MC-Unique: Nr5NrB48OW6w2G2EIeni-Q-1
X-Mimecast-MFC-AGG-ID: Nr5NrB48OW6w2G2EIeni-Q_1766827091
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477cf25ceccso85499645e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827089; x=1767431889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paa+WcSbaqh3C78vzKBguRWQhtas8zYMwVuB+87aW10=;
 b=qBut3O9X37xd5mhCJqdb+kxh5TLK8s3wBlYkiM5UXyMU5S2F3wmwddCHkMFft7g+q2
 URN6YYtNfoZ8/5VeDwLX3IJYaS4R1s+FwrEBguMApKEa5qgOlz5s11ee6IqINJGL8iK7
 YIiKWIvONb3jW8X0k20ii7lOz1AUBxyCqm8nl2SzYLJFBAnWMqrvGY/3YTyn5Lm1jkgq
 M+DFe8JjBH+HdwXjvVJZiP3257QIhfqwe2YHl6Odu9Tcbkiw/pglv3ofYWVzO+vysG3q
 PQOokirF9+7/tDPQThtQpkpi5DjNUJoXmBpWgK6eN2iZuBEgEiubveMmy4w2wiQi97lw
 5aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827089; x=1767431889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=paa+WcSbaqh3C78vzKBguRWQhtas8zYMwVuB+87aW10=;
 b=a7HKKWgzHde5zEKoKhwUf2O/ula42CzSvk7Z4abxxvjdP2lJAe6o/Cp7mQO0mX8Px5
 DbPKAhOH5DAhqyXevUElJJR3Gstf6v8aKuFdiHzDlINyl21NoNBnJ9ryai/HgIrPEt0g
 U8gTdb6I//57ct2nY6OmChU5KJ/oULP3enDNoPwWXWJVecKi3oJ5VrB09xUt69MsUi30
 prhLZPr+XnFPIHqhiuE1QthxmXQF9hLJQlJ6iXHd14RFV16Y8EJ9sQGvMYKKA4V+L99g
 W8xGErjwGTXAMWVgwlGbgYXY/atMp813A0/Hf1XvjCK7gqcXmjMgonM9qUHOfQlw1QVf
 DTFw==
X-Gm-Message-State: AOJu0YwzG+giRnPWLosnXhKiUC84FeM6H35yvNFsB9q2KXnlw9621Vgs
 tRFUjFEMcPKQDiTTZcJ9lIM6ohh0bMQMi0nHkdIkRmTarCDk5VeKAZY1njlCvUKpePpqkqOphtW
 Y+QWXfyZvN+Bq9ijmfcQtJ3W+VKhKAQORky6gD1MdbCqQcvvcvski/p1SWPgGv3rYw2446raL5k
 /6wtBQtFkY/ANfJ+FcwZs/M0acKRjvjks/Wiq/zzrM
X-Gm-Gg: AY/fxX4J5MXNhu/OI3uURJpQiW+za5ERvfI4y3vQ6cN2cnhI2m/jtAwJ55vzAdmI91h
 aMcdgQEGiP77BqFROT/H3PH1Z52BA+PZPQ7lpvU2V/ttKgqiA13mRqsyESvoPuvUPT2NwzQL4F/
 sFFFv8A28PpkhxAQY/OMfieH/TCDzYzh8WuXdnCSAWmMAvGqLPKL4uKFEyMptv082Do9Xuo9ame
 8/DXAW/VIq8xZdDw8xFy/LXYsHrr8P77v7QMNXH+oW4XHO5/X7WUGqejxsoMQLGZ6TGCz6P6Zgo
 wPV3h4UhJ+xppzQTw3xNFDZaNy9IJ6A5D1D7mCZFgNNW2ZmzR22cAMnc9+2JfxY0uFpiUsUJsU6
 3W+LItU5e2NoKyN7sLLUJm1KN1rNpikUVH1ASEySKAwqkurBq2LNropidGYYBmpoiS84BO3vlH5
 mjHwQ2rkitMWyhc+8=
X-Received: by 2002:a05:600c:3b05:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-47d19594d77mr259864015e9.18.1766827089433; 
 Sat, 27 Dec 2025 01:18:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENMd7J/Fq5qOXZagPgvbnI5Sq0u0xBK2YiqrizHlK+7MRQ+cOo8C5qSww4QfeLFq6syBMK/Q==
X-Received: by 2002:a05:600c:3b05:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-47d19594d77mr259863715e9.18.1766827088847; 
 Sat, 27 Dec 2025 01:18:08 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3bbe1c8sm192137825e9.11.2025.12.27.01.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 055/153] rust/hpet: Make timer register accessors as methods of
 HPETTimerRegisters
Date: Sat, 27 Dec 2025 10:14:42 +0100
Message-ID: <20251227091622.20725-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Implement helper accessors as methods of HPETTimerRegisters. Then
HPETTimerRegisters can be accessed without going through HPETTimer or
HPETState.

In subsequent refactoring, HPETTimerRegisters will be maintained at the
HPETState level. However, accessing it through HPETState requires the
lock (lock BQL or mutex), which would cause troublesome nested locks or
reentrancy issues.

Therefore, refactor the accessors of HPETTimerRegisters to bypass
HPETTimer or HPETState.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-12-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 108 ++++++++++++++++---------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 1bdee064d43..8dc3cc59c98 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -186,6 +186,41 @@ pub struct HPETTimerRegisters {
     fsb: u64,
 }
 
+impl HPETTimerRegisters {
+    const fn is_fsb_route_enabled(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_FSB_ENABLE_SHIFT) != 0
+    }
+
+    const fn is_periodic(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_PERIODIC_SHIFT) != 0
+    }
+
+    const fn is_int_enabled(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_INT_ENABLE_SHIFT) != 0
+    }
+
+    const fn is_32bit_mod(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_32BIT_SHIFT) != 0
+    }
+
+    const fn is_valset_enabled(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_SETVAL_SHIFT) != 0
+    }
+
+    /// True if timer interrupt is level triggered; otherwise, edge triggered.
+    const fn is_int_level_triggered(&self) -> bool {
+        self.config & (1 << HPET_TN_CFG_INT_TYPE_SHIFT) != 0
+    }
+
+    const fn clear_valset(&mut self) {
+        self.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
+    }
+
+    const fn get_individual_route(&self) -> usize {
+        ((self.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
+    }
+}
+
 /// HPET Timer Abstraction
 #[repr(C)]
 #[derive(Debug)]
@@ -248,40 +283,11 @@ fn is_int_active(&self) -> bool {
         self.get_state().is_timer_int_active(self.index.into())
     }
 
-    const fn is_fsb_route_enabled(&self) -> bool {
-        self.regs.config & (1 << HPET_TN_CFG_FSB_ENABLE_SHIFT) != 0
-    }
-
-    const fn is_periodic(&self) -> bool {
-        self.regs.config & (1 << HPET_TN_CFG_PERIODIC_SHIFT) != 0
-    }
-
-    const fn is_int_enabled(&self) -> bool {
-        self.regs.config & (1 << HPET_TN_CFG_INT_ENABLE_SHIFT) != 0
-    }
-
-    const fn is_32bit_mod(&self) -> bool {
-        self.regs.config & (1 << HPET_TN_CFG_32BIT_SHIFT) != 0
-    }
-
-    const fn is_valset_enabled(&self) -> bool {
-        self.regs.config & (1 << HPET_TN_CFG_SETVAL_SHIFT) != 0
-    }
-
-    fn clear_valset(&mut self) {
-        self.regs.config &= !(1 << HPET_TN_CFG_SETVAL_SHIFT);
-    }
-
-    /// True if timer interrupt is level triggered; otherwise, edge triggered.
-    const fn is_int_level_triggered(&self) -> bool {
-        self.regs.config & (1 << HPET_TN_CFG_INT_TYPE_SHIFT) != 0
-    }
-
     /// calculate next value of the general counter that matches the
     /// target (either entirely, or the low 32-bit only depending on
     /// the timer mode).
     fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
-        if self.is_32bit_mod() {
+        if self.regs.is_32bit_mod() {
             let mut result: u64 = cur_tick.deposit(0, 32, target);
             if result < cur_tick {
                 result += 0x100000000;
@@ -292,10 +298,6 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
         }
     }
 
-    const fn get_individual_route(&self) -> usize {
-        ((self.regs.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
-    }
-
     fn get_int_route(&self) -> usize {
         if self.index <= 1 && self.get_state().is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
@@ -317,15 +319,15 @@ fn get_int_route(&self) -> usize {
             // ...
             // If the LegacyReplacement Route bit is not set, the individual
             // routing bits for each of the timers are used.
-            self.get_individual_route()
+            self.regs.get_individual_route()
         }
     }
 
     fn set_irq(&self, set: bool) {
         let route = self.get_int_route();
 
-        if set && self.is_int_enabled() && self.get_state().is_hpet_enabled() {
-            if self.is_fsb_route_enabled() {
+        if set && self.regs.is_int_enabled() && self.get_state().is_hpet_enabled() {
+            if self.regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
                 unsafe {
@@ -337,12 +339,12 @@ fn set_irq(&self, set: bool) {
                         null_mut(),
                     );
                 }
-            } else if self.is_int_level_triggered() {
+            } else if self.regs.is_int_level_triggered() {
                 self.get_state().irqs[route].raise();
             } else {
                 self.get_state().irqs[route].pulse();
             }
-        } else if !self.is_fsb_route_enabled() {
+        } else if !self.regs.is_fsb_route_enabled() {
             self.get_state().irqs[route].lower();
         }
     }
@@ -352,7 +354,7 @@ fn update_irq(&self, set: bool) {
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
         self.get_state()
-            .update_int_status(self.index.into(), set && self.is_int_level_triggered());
+            .update_int_status(self.index.into(), set && self.regs.is_int_level_triggered());
         self.set_irq(set);
     }
 
@@ -360,7 +362,7 @@ fn arm_timer(&mut self, tick: u64) {
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
-        if self.is_periodic() && ns - self.last < 1000 {
+        if self.regs.is_periodic() && ns - self.last < 1000 {
             ns = self.last + 1000;
         }
 
@@ -373,10 +375,10 @@ fn set_timer(&mut self) {
 
         self.wrap_flag = 0;
         self.cmp64 = self.calculate_cmp64(cur_tick, self.regs.cmp);
-        if self.is_32bit_mod() {
+        if self.regs.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
-            if !self.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
+            if !self.regs.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
                 self.wrap_flag = 1;
                 self.arm_timer(hpet_next_wrap(cur_tick));
                 return;
@@ -418,7 +420,7 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
             self.update_irq(true);
         }
 
-        if self.is_32bit_mod() {
+        if self.regs.is_32bit_mod() {
             self.regs.cmp = u64::from(self.regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
@@ -433,7 +435,7 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         let mut length = len;
         let mut value = val;
 
-        if self.is_32bit_mod() {
+        if self.regs.is_32bit_mod() {
             // High 32-bits are zero, leave them untouched.
             if shift != 0 {
                 trace::trace_hpet_ram_write_invalid_tn_cmp();
@@ -445,15 +447,15 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
 
         trace::trace_hpet_ram_write_tn_cmp((shift / 8).try_into().unwrap());
 
-        if !self.is_periodic() || self.is_valset_enabled() {
+        if !self.regs.is_periodic() || self.regs.is_valset_enabled() {
             self.regs.cmp = self.regs.cmp.deposit(shift, length, value);
         }
 
-        if self.is_periodic() {
+        if self.regs.is_periodic() {
             self.period = self.period.deposit(shift, length, value);
         }
 
-        self.clear_valset();
+        self.regs.clear_valset();
         if self.get_state().is_hpet_enabled() {
             self.set_timer();
         }
@@ -484,11 +486,11 @@ fn callback(&mut self) {
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
-        if self.is_periodic() && period != 0 {
+        if self.regs.is_periodic() && period != 0 {
             while hpet_time_after(cur_tick, self.cmp64) {
                 self.cmp64 += period;
             }
-            if self.is_32bit_mod() {
+            if self.regs.is_32bit_mod() {
                 self.regs.cmp = u64::from(self.cmp64 as u32); // truncate!
             } else {
                 self.regs.cmp = self.cmp64;
@@ -649,7 +651,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
 
-                if t.is_int_enabled() && t.is_int_active() {
+                if t.regs.is_int_enabled() && t.is_int_active() {
                     t.update_irq(true);
                 }
                 t.set_timer();
@@ -806,8 +808,8 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
 
         let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
 
-        use GlobalRegister::*;
         use DecodedRegister::*;
+        use GlobalRegister::*;
         (match target {
             Timer(timer, tn_target) => timer.borrow_mut().read(tn_target),
             Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
@@ -836,8 +838,8 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
 
         trace::trace_hpet_ram_write(addr, value);
 
-        use GlobalRegister::*;
         use DecodedRegister::*;
+        use GlobalRegister::*;
         match target {
             Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
-- 
2.52.0


