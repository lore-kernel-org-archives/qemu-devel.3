Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BBDE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRk-0008Ne-Hf; Sat, 27 Dec 2025 04:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRZ-0007GS-Ci
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRU-00043y-FN
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OR2XGfrAI6MMQ/VUl3zvivBWqmGu/o9Ocde5KCOxOWA=;
 b=gI5LiAjO1RYB9qAP2zBYMgZtw28kAO3ULcLnG4nlsreYvP50X/vW0d5qvoLxS4eHxBnUxS
 tPcELQ3bnxGf3JU5TXGbTO6kpd/MICybMRnZpnAIdDNJy4CQGRJyKeYYVyCn7LNKFeoJQZ
 GfF2quMR7y6q2sEZuq/5GoE2cT1gYUg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-cX41jstnPJ-bHq55vp0HPQ-1; Sat, 27 Dec 2025 04:18:29 -0500
X-MC-Unique: cX41jstnPJ-bHq55vp0HPQ-1
X-Mimecast-MFC-AGG-ID: cX41jstnPJ-bHq55vp0HPQ_1766827108
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430ffc4dc83so8257515f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827107; x=1767431907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OR2XGfrAI6MMQ/VUl3zvivBWqmGu/o9Ocde5KCOxOWA=;
 b=St0dby/cM8k126py9cykM7AdTeSDNQdiuK/S8H16YpEc95B2GmdMkuRz9GFi7IZlvp
 TZ432dkuhpV5eByWFTcjnh5JqJzuHIzJGXkA/JSAZUTm8f2R7hmQZMTHyV/YMRT9McNl
 uPm4ZLMbmsbHDCGGekVG2vyHddrvGTIS2MoWUSMIgTU422DUrE/dJ6XN3xWMh7R+6NCs
 C2Nv87WjVUgYlo8rhjfiwWyt+fpdPes2sGPktsKcOBMrnd51ZWJdbocuRTZAw/3tolir
 bRGUjlSovvfmvt05RVxwzMlxX6HPixJzpZQYJU3jZDQxfIx07wIFy1VNI748VBN/PoDJ
 uefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827107; x=1767431907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OR2XGfrAI6MMQ/VUl3zvivBWqmGu/o9Ocde5KCOxOWA=;
 b=fN8IY5FWy0GLGHdFXrclf99L/ToPWdTQdCqOYOgVjzJWje2EsyeJ0Vz4f+G0Uq63A5
 z29ec/zSDmlekzVrgmJF4oOrrQn5rl55zD8An9BYb2LbXjW0MUE6vIufq498XwjaDeAe
 3rJHt1vqq/u7Naqk1RALv52sPZR5f9OLQoUl39N4ptkCx/l+9mpuTLOI5xTNEG2m6h4T
 o1HiE3eBTHt3b6HZsvou8nPY10SPKWbBMETJruJeFVJfdKLlcIHEuWnWKb1L68lY/jqC
 Yf7PV3fPta73J62dNfwioKqhwSaqOGJdAioTaAcnwYJNfH4BUwwNvj/WJcmAoqi0MQUW
 q0ag==
X-Gm-Message-State: AOJu0YxPe9B4JbmNAOIfzvDCp8+U8b3kzoGlxxlRJYFDzmJwftsucFIr
 y9TTyR4NWrkb3cPWtq5BemOoGZfqrudaafDKBjwdajLrXmuxcAzPZpLDcMUdUsb25+IJG3qle0l
 2lPMvmvP8+2Osk+GVc+BNFdLN0mBShTTtOs8zCULiT/iZKV4eFBqHg0PNeI8BOuRFpdYDrSiVRK
 VHjO9sKJTq/JrdlJsjGQ9kc4znANSFzDEGQIHHVSbB
X-Gm-Gg: AY/fxX48nUzip+pi+XV4+GfSdlSTnAN6QKHMkRH09tDUix6EFZnmn0MFT+fEx7qefKb
 btDBPiJ1DgvriLuzWfX7G+euQMP+ggZg16tZ7wRv3UNhw1VAN7yc5H/TxPcOWJJEhSNEEamBcFS
 uDyon+YEKnc1xDDuDt5qmd6UQJSUoRdSXDRow/jYHTd2MZNikvRMZIHwlxA3x3J5Z6IbAFvASJx
 UYL49DPZoq9jkz5PSAM+ZNVABZVjakAtOxp/MIyUFwvtgoJt7RdGQ2psgJVVdkHccSo7PfSqcq1
 LgYhZS/mUZTkiDBN84xeUqZdvgRWHfWgOMOLCh/BZE/8pCNWA+BI6XADXns0qnuSC9dAOi2gpfm
 c0T2Mc4UdNZpPvFc43x5r0eiHPev1T6dG1zZOwXdAgzJNwbaStZy/HLduPeYL1ApWm/zfVWzwT7
 8gTasVzsfxIH8DTrs=
X-Received: by 2002:a05:600c:3b1f:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-47d36c75e0cmr152016485e9.35.1766827106612; 
 Sat, 27 Dec 2025 01:18:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmmVlUhETPcOo/UpkCg5r4JBwiiVgn0woBfgtYG8S9fYDBnIey6PAiPtoICDmTKxXka9tCuQ==
X-Received: by 2002:a05:600c:3b1f:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-47d36c75e0cmr152016185e9.35.1766827106053; 
 Sat, 27 Dec 2025 01:18:26 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm472916695e9.8.2025.12.27.01.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 063/153] rust/hpet: move hidden registers to HPETTimerRegisters
Date: Sat, 27 Dec 2025 10:14:50 +0100
Message-ID: <20251227091622.20725-64-pbonzini@redhat.com>
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

Do not separate visible and hidden state; both of them are used in the
same circumstances and it's easiest to place both of them under the
same BqlRefCell.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 151 +++++++++++++++----------------
 1 file changed, 71 insertions(+), 80 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 916ae587b08..005e41aec47 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -171,9 +171,9 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 }
 
 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
-    let mut t = timer_cell.borrow_mut();
+    let t = timer_cell.borrow();
     // SFAETY: state field is valid after timer initialization.
-    let hpet_regs = &mut unsafe { t.state.as_mut() }.regs;
+    let hpet_regs = &unsafe { t.state.as_ref() }.regs;
     t.callback(&mut hpet_regs.borrow_mut())
 }
 
@@ -187,9 +187,35 @@ pub struct HPETTimerRegisters {
     cmp: u64,
     /// Timer N FSB Interrupt Route Register
     fsb: u64,
+
+    // Hidden register state
+    /// comparator (extended to counter width)
+    cmp64: u64,
+    /// Last value written to comparator
+    period: u64,
+    /// timer pop will indicate wrap for one-shot 32-bit
+    /// mode. Next pop will be actual timer expiration.
+    wrap_flag: u8,
+    /// last value armed, to avoid timer storms
+    last: u64,
 }
 
 impl HPETTimerRegisters {
+    /// calculate next value of the general counter that matches the
+    /// target (either entirely, or the low 32-bit only depending on
+    /// the timer mode).
+    fn update_cmp64(&mut self, cur_tick: u64) {
+        self.cmp64 = if self.is_32bit_mod() {
+            let mut result: u64 = cur_tick.deposit(0, 32, self.cmp);
+            if result < cur_tick {
+                result += 0x100000000;
+            }
+            result
+        } else {
+            self.cmp
+        }
+    }
+
     const fn is_fsb_route_enabled(&self) -> bool {
         self.config & (1 << HPET_TN_CFG_FSB_ENABLE_SHIFT) != 0
     }
@@ -234,17 +260,6 @@ pub struct HPETTimer {
     qemu_timer: Timer,
     /// timer block abstraction containing this timer
     state: NonNull<HPETState>,
-
-    // Hidden register state
-    /// comparator (extended to counter width)
-    cmp64: u64,
-    /// Last value written to comparator
-    period: u64,
-    /// timer pop will indicate wrap for one-shot 32-bit
-    /// mode. Next pop will be actual timer expiration.
-    wrap_flag: u8,
-    /// last value armed, to avoid timer storms
-    last: u64,
 }
 
 // SAFETY: Sync is not automatically derived due to the `state` field,
@@ -259,10 +274,6 @@ fn new(index: u8, state: *const HPETState) -> HPETTimer {
             // is initialized below.
             qemu_timer: unsafe { Timer::new() },
             state: NonNull::new(state.cast_mut()).unwrap(),
-            cmp64: 0,
-            period: 0,
-            wrap_flag: 0,
-            last: 0,
         }
     }
 
@@ -284,22 +295,6 @@ fn is_int_active(&self, regs: &HPETRegisters) -> bool {
         regs.is_timer_int_active(self.index.into())
     }
 
-    /// calculate next value of the general counter that matches the
-    /// target (either entirely, or the low 32-bit only depending on
-    /// the timer mode).
-    fn calculate_cmp64(&self, regs: &HPETRegisters, cur_tick: u64, target: u64) -> u64 {
-        let tn_regs = &regs.tn_regs[self.index as usize];
-        if tn_regs.is_32bit_mod() {
-            let mut result: u64 = cur_tick.deposit(0, 32, target);
-            if result < cur_tick {
-                result += 0x100000000;
-            }
-            result
-        } else {
-            target
-        }
-    }
-
     fn get_int_route(&self, regs: &HPETRegisters) -> usize {
         if self.index <= 1 && regs.is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
@@ -364,35 +359,34 @@ fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
         self.set_irq(regs, set);
     }
 
-    fn arm_timer(&mut self, regs: &HPETRegisters, tick: u64) {
-        let tn_regs = &regs.tn_regs[self.index as usize];
+    fn arm_timer(&self, tn_regs: &mut HPETTimerRegisters, tick: u64) {
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
-        if tn_regs.is_periodic() && ns - self.last < 1000 {
-            ns = self.last + 1000;
+        if tn_regs.is_periodic() && ns - tn_regs.last < 1000 {
+            ns = tn_regs.last + 1000;
         }
 
-        self.last = ns;
-        self.qemu_timer.modify(self.last);
+        tn_regs.last = ns;
+        self.qemu_timer.modify(tn_regs.last);
     }
 
-    fn set_timer(&mut self, regs: &HPETRegisters) {
-        let tn_regs = &regs.tn_regs[self.index as usize];
+    fn set_timer(&self, regs: &mut HPETRegisters) {
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         let cur_tick: u64 = self.get_state().get_ticks();
 
-        self.wrap_flag = 0;
-        self.cmp64 = self.calculate_cmp64(regs, cur_tick, tn_regs.cmp);
+        tn_regs.wrap_flag = 0;
+        tn_regs.update_cmp64(cur_tick);
         if tn_regs.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
-            if !tn_regs.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
-                self.wrap_flag = 1;
-                self.arm_timer(regs, hpet_next_wrap(cur_tick));
+            if !tn_regs.is_periodic() && tn_regs.cmp64 > hpet_next_wrap(cur_tick) {
+                tn_regs.wrap_flag = 1;
+                self.arm_timer(tn_regs, hpet_next_wrap(cur_tick));
                 return;
             }
         }
-        self.arm_timer(regs, self.cmp64);
+        self.arm_timer(tn_regs, tn_regs.cmp64);
     }
 
     fn del_timer(&self, regs: &mut HPETRegisters) {
@@ -431,7 +425,7 @@ fn prepare_tn_cfg_reg_new(
     }
 
     /// Configuration and Capability Register
-    fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+    fn set_tn_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         // Factor out a prepare_tn_cfg_reg_new() to better handle immutable scope.
         let (new_val, old_val) = self.prepare_tn_cfg_reg_new(regs, shift, len, val);
         regs.tn_regs[self.index as usize].config = new_val;
@@ -445,7 +439,7 @@ fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val
         let tn_regs = &mut regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             tn_regs.cmp = u64::from(tn_regs.cmp as u32); // truncate!
-            self.period = u64::from(self.period as u32); // truncate!
+            tn_regs.period = u64::from(tn_regs.period as u32); // truncate!
         }
 
         if regs.is_hpet_enabled() {
@@ -454,7 +448,7 @@ fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val
     }
 
     /// Comparator Value Register
-    fn set_tn_cmp_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+    fn set_tn_cmp_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         let tn_regs = &mut regs.tn_regs[self.index as usize];
         let mut length = len;
         let mut value = val;
@@ -476,7 +470,7 @@ fn set_tn_cmp_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val
         }
 
         if tn_regs.is_periodic() {
-            self.period = self.period.deposit(shift, length, value);
+            tn_regs.period = tn_regs.period.deposit(shift, length, value);
         }
 
         tn_regs.clear_valset();
@@ -491,7 +485,7 @@ fn set_tn_fsb_route_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, v
         tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
     }
 
-    fn reset(&mut self, regs: &mut HPETRegisters) {
+    fn reset(&self, regs: &mut HPETRegisters) {
         self.del_timer(regs);
 
         let tn_regs = &mut regs.tn_regs[self.index as usize];
@@ -503,29 +497,28 @@ fn reset(&mut self, regs: &mut HPETRegisters) {
         // advertise availability of ioapic int
         tn_regs.config |=
             (u64::from(self.get_state().int_route_cap)) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
-        self.period = 0;
-        self.wrap_flag = 0;
+        tn_regs.period = 0;
+        tn_regs.wrap_flag = 0;
     }
 
     /// timer expiration callback
-    fn callback(&mut self, regs: &mut HPETRegisters) {
+    fn callback(&self, regs: &mut HPETRegisters) {
         let tn_regs = &mut regs.tn_regs[self.index as usize];
-        let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
-        if tn_regs.is_periodic() && period != 0 {
-            while hpet_time_after(cur_tick, self.cmp64) {
-                self.cmp64 += period;
+        if tn_regs.is_periodic() && tn_regs.period != 0 {
+            while hpet_time_after(cur_tick, tn_regs.cmp64) {
+                tn_regs.cmp64 += tn_regs.period;
             }
             if tn_regs.is_32bit_mod() {
-                tn_regs.cmp = u64::from(self.cmp64 as u32); // truncate!
+                tn_regs.cmp = u64::from(tn_regs.cmp64 as u32); // truncate!
             } else {
-                tn_regs.cmp = self.cmp64;
+                tn_regs.cmp = tn_regs.cmp64;
             }
-            self.arm_timer(regs, self.cmp64);
-        } else if self.wrap_flag != 0 {
-            self.wrap_flag = 0;
-            self.arm_timer(regs, self.cmp64);
+            self.arm_timer(tn_regs, tn_regs.cmp64);
+        } else if tn_regs.wrap_flag != 0 {
+            tn_regs.wrap_flag = 0;
+            self.arm_timer(tn_regs, tn_regs.cmp64);
         }
         self.update_irq(regs, true);
     }
@@ -542,7 +535,7 @@ fn read(&self, target: TimerRegister, regs: &HPETRegisters) -> u64 {
     }
 
     fn write(
-        &mut self,
+        &self,
         target: TimerRegister,
         regs: &mut HPETRegisters,
         value: u64,
@@ -691,7 +684,7 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
                 .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
 
             for timer in self.timers.iter().take(self.num_timers) {
-                let mut t = timer.borrow_mut();
+                let t = timer.borrow();
                 let id = t.index as usize;
                 let tn_regs = &regs.tn_regs[id];
 
@@ -815,7 +808,7 @@ fn realize(&self) -> util::Result<()> {
     fn reset_hold(&self, _type: ResetType) {
         let mut regs = self.regs.borrow_mut();
         for timer in self.timers.iter().take(self.num_timers) {
-            timer.borrow_mut().reset(&mut regs);
+            timer.borrow().reset(&mut regs);
         }
 
         regs.counter = 0;
@@ -871,7 +864,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         use DecodedRegister::*;
         use GlobalRegister::*;
         (match target {
-            Timer(timer, tn_target) => timer.borrow_mut().read(tn_target, regs),
+            Timer(timer, tn_target) => timer.borrow().read(tn_target, regs),
             Global(CAP) => regs.capability, /* including HPET_PERIOD 0x004 */
             Global(CFG) => regs.config,
             Global(INT_STATUS) => regs.int_status,
@@ -903,7 +896,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
         use GlobalRegister::*;
         match target {
             Timer(timer, tn_target) => timer
-                .borrow_mut()
+                .borrow()
                 .write(tn_target, &mut regs, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
             Global(CFG) => self.set_cfg_reg(&mut regs, shift, len, value),
@@ -929,15 +922,14 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
     }
 
     fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
-        let regs = self.regs.borrow();
+        let mut regs = self.regs.borrow_mut();
+        let cnt = regs.counter;
 
-        for timer in self.timers.iter().take(self.num_timers) {
-            let mut t = timer.borrow_mut();
-            let cnt = regs.counter;
-            let cmp = regs.tn_regs[t.index as usize].cmp;
+        for index in 0..self.num_timers {
+            let tn_regs = &mut regs.tn_regs[index];
 
-            t.cmp64 = t.calculate_cmp64(&regs, cnt, cmp);
-            t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
+            tn_regs.update_cmp64(cnt);
+            tn_regs.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
         // Recalculate the offset between the main counter and guest time
@@ -1010,6 +1002,8 @@ impl ObjectImpl for HPETState {
             vmstate_of!(HPETTimerRegisters, config),
             vmstate_of!(HPETTimerRegisters, cmp),
             vmstate_of!(HPETTimerRegisters, fsb),
+            vmstate_of!(HPETTimerRegisters, period),
+            vmstate_of!(HPETTimerRegisters, wrap_flag),
         })
         .build()
 );
@@ -1020,9 +1014,6 @@ impl ObjectImpl for HPETState {
         .version_id(2)
         .minimum_version_id(2)
         .fields(vmstate_fields! {
-            vmstate_of!(HPETTimer, index),
-            vmstate_of!(HPETTimer, period),
-            vmstate_of!(HPETTimer, wrap_flag),
             vmstate_of!(HPETTimer, qemu_timer),
         })
         .build();
-- 
2.52.0


