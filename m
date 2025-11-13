Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD11DCD5BC7
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 11:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJVSP-0005zN-FR; Thu, 13 Nov 2025 06:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJVR6-0004wY-J3
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:24:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJVR3-0004jP-Ao
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 06:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763033054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8Z2rsvFsRHtNo5+guLuIKBXUqNmxGpadym/vy8UXaCI=;
 b=WW9M2qoOwOgG6IJfUt1fEHTnNo/ksYQSRe2+sHcdzLZHQ4oGr0dwbKFDflIGb+ODUBiDD0
 OfDB1UklPPA9tRAPchDoJjUHkJuvYMpt7Fk9fvUtlu7LjNbJWV215kAFnFkcZ9gv/a8zfK
 ol9Sj/2UG0ilDIqEnbgiWP9vW5sTei4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-mQZILI_uPDicuo_jQHodFw-1; Thu, 13 Nov 2025 06:24:13 -0500
X-MC-Unique: mQZILI_uPDicuo_jQHodFw-1
X-Mimecast-MFC-AGG-ID: mQZILI_uPDicuo_jQHodFw_1763033052
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c7b0ae36so395211f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763033052; x=1763637852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8Z2rsvFsRHtNo5+guLuIKBXUqNmxGpadym/vy8UXaCI=;
 b=cTbmNdqNqNN++xey/NCKaAQcfv8WwpP6a9okL4Rs/zK2SBJbf4aZAO8OYAsHnmbaDF
 gMeYcmJM0HyfypFTXKW7ayzfRQlWR+P8/cyrM7CW5IOP2f1EUmHRAjpeuKhSbo4cwv/B
 /sT8faeoGZFw6CncbW7yrjcgiulKeMezAqlQ3DcOgryYis+dUJHnLvH4OK/mLUte11Ka
 eQAFb5+BG7s7a6XzDGHXefs4aO7wdy88beOx6AFmjYbQr8AkXBE3S/84AE09PMtyggUW
 b2+PsXpSMqilmdhKKyp/k/nrzC/meBr9yII+xJD3e+X88qyGm0eljR2907uH//9yZh5f
 wgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763033052; x=1763637852;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Z2rsvFsRHtNo5+guLuIKBXUqNmxGpadym/vy8UXaCI=;
 b=vPYmgVNRkfHE1xOoPhq9dKgremUbjMg3m5/Rw13M+szg3I8yVdJYA+VxpQqUBY2Cm2
 7YYJRLsgqlqZfTb42J1MD5O8Nt4d47Fk/R/FR3P9ICru7+AP/PKD8Yr5kDM7ebPF+75b
 zsH1nMhqlmH5pZsXiYk375ZLBS7XSIacacx9tvwQnfWmeSrYpsRZTDbK06HYiJZIr+GA
 XqB8oVZyzwpqSX8nCw2VLvUgDM3ya9isLyiveLadXB3qQXfPFDuf0g7ayrrcskfevLN2
 BpSbv7u8SzHr2mwGg0hC4FD+HelLHx5/+OiuSpNkh6OvbIi4c7auJtZPrA+ijxf1IycZ
 LGug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU3XoYDNlNempZhEhDnfltytC5Xovoivk0+jQHc74gmKzQ6Nb8h67b9dkY9h/cNvjvjvqhhfAyenyo@nongnu.org
X-Gm-Message-State: AOJu0YxbLt7sFIfgAqVu2a2pbjcKltJj1Zb+AY8HquTLMyu+jHWL5mu/
 PWSeOg6559dbfMCmUK8/FmjohHiPwsxouFyM7n5X0ylYqz3Qx3+caVzZe921S5qg2iq8/ebQ1jm
 CkKUk9VEV16tSK+QvqFJB80OlXOFIKljGS0RzG6E27y9rfIMlzc3si4VI
X-Gm-Gg: ASbGncuo1F/4pD1LiO5IO7th0+IQXqoMMsg7Ffwstp0EFDuvF4dqSQ3EvXR/nOufAbn
 TeGKMKu47bvTae0tFeSv3mE9U7JO26UXcCiS0XMMK3EeTSgaSo9fhphoDof4EM9eHeimyTy+Rmu
 Qt62h0BkC9ms7c47VDhzvK9o0m+q0+AzbKeXC6eA/b43DGdQyetyLGtgKUwx5QWziKbZn9Mm8kI
 ZSC8f4j6wO1P1GIP+YqTcZ7m0zH/t13iDsx26sm4ezXyxy0s3aQAMYdRlohSzneJomj0EiYlA/m
 UCN0xt9nlCP1nGDOGO40Kt0zt0lfXjMzw0Gi4wDt0y0htdIeYZwJTxWO9wZ1oUjQYOqOseWX5dn
 Q45w8FxoX7YpLRDETFPYyPujmCDQpZqs9UpPAT9Cfi5EKH3ea
X-Received: by 2002:a05:6000:2889:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-42b52845265mr2838982f8f.30.1763033049651; 
 Thu, 13 Nov 2025 03:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsENULbT24iZNKgIUmRxnPeMntc+zfqzKc8S+B4+fVTnyqFquPrw4c1VoElDvkknoJN/e3Tw==
X-Received: by 2002:a05:6000:2889:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-42b52845265mr2838940f8f.30.1763033049103; 
 Thu, 13 Nov 2025 03:24:09 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae47sm3317190f8f.4.2025.11.13.03.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 03:24:08 -0800 (PST)
Message-ID: <12e93226-b70d-4c9c-bf8a-db7e0e05b585@redhat.com>
Date: Thu, 13 Nov 2025 12:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] rust/hpet: Abstract HPETTimerRegisters struct
To: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-11-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251113051937.4017675-11-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/13/25 06:19, Zhao Liu wrote:
> Place all timer N's registers in a HPETTimerRegisters struct.
> 
> This allows all Timer N registers to be grouped together with global
> registers and managed using a single lock (BqlRefCell or Mutex) in
> future. And this makes it easier to apply ToMigrationState macro.

This is pretty much the crucial patch in the series and it's the only
one that needs more work, or some fixup at the end.

In particular, more fields of HPETTimer need to be moved to the
HPETTimerRegisters.  It's possible that it would be a problem to move
the timer itself inside the mutex but, at least, the HPETTimer could be
changed to just

pub struct HPETTimer {
     timer: QemuTimer,
     state: NonNull<HPETState>,
     index: u8,
}

as in the patch included at the end (compile-tested only).  Then, the
BqlRefCell<HPETTimer> can be changed to just HPETTimer because all the
fields handle their interior-mutable fields.

Preserving the old migration format can then be solved in two ways:

1) with a handwritten ToMigrationStateShared implementation for
HPETTimer (and marking the tn_regs array as #[migration_state(omit)])

2) by also adding num_timers_save and the timer's expiration to
HPETRegisters and HPETTimerRegisters, respectively.

I think I prefer the former, but I haven't written the code so it's
not my choice. :)

I'm okay with doing these changes on top of these patches as well.

Paolo

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 75a6fd8a050..5ff02c01539 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -172,7 +172,7 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
  }
  
  fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
-    let mut t = timer_cell.borrow_mut();
+    let t = timer_cell.borrow();
      // SFAETY: state field is valid after timer initialization.
      let mut regs = unsafe { t.state.as_ref() }.regs.lock().unwrap();
      t.callback(&mut regs)
@@ -181,6 +181,9 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
  #[repr(C)]
  #[derive(Debug, Default, ToMigrationState)]
  pub struct HPETTimerRegisters {
+    // Only needed for migration
+    index: u8,
+
      // Memory-mapped, software visible timer registers
      /// Timer N Configuration and Capability Register
      config: u64,
@@ -188,9 +191,35 @@ pub struct HPETTimerRegisters {
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
@@ -235,17 +264,6 @@ pub struct HPETTimer {
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
@@ -260,10 +278,6 @@ fn new(index: u8, state: *const HPETState) -> HPETTimer {
              // is initialized below.
              qemu_timer: unsafe { Timer::new() },
              state: NonNull::new(state.cast_mut()).unwrap(),
-            cmp64: 0,
-            period: 0,
-            wrap_flag: 0,
-            last: 0,
          }
      }
  
@@ -291,22 +305,6 @@ fn is_int_active(&self, regs: &HPETRegisters) -> bool {
          regs.is_timer_int_active(self.index.into())
      }
  
-    /// calculate next value of the general counter that matches the
-    /// target (either entirely, or the low 32-bit only depending on
-    /// the timer mode).
-    fn calculate_cmp64(&self, regs: &MutexGuard<HPETRegisters>, cur_tick: u64, target: u64) -> u64 {
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
      fn get_int_route(&self, regs: &MutexGuard<HPETRegisters>) -> usize {
          if self.index <= 1 && regs.is_legacy_mode() {
              // If LegacyReplacement Route bit is set, HPET specification requires
@@ -371,35 +369,34 @@ fn update_irq(&self, regs: &mut MutexGuard<HPETRegisters>, set: bool) {
          self.set_irq(regs, set);
      }
  
-    fn arm_timer(&mut self, regs: &MutexGuard<HPETRegisters>, tick: u64) {
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
  
-    fn set_timer(&mut self, regs: &MutexGuard<HPETRegisters>) {
-        let tn_regs = &regs.tn_regs[self.index as usize];
+    fn set_timer(&self, regs: &mut MutexGuard<HPETRegisters>) {
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
  
      fn del_timer(&self, regs: &mut MutexGuard<HPETRegisters>) {
@@ -440,7 +437,7 @@ fn prepare_tn_cfg_reg_new(
  
      /// Configuration and Capability Register
      fn set_tn_cfg_reg(
-        &mut self,
+        &self,
          regs: &mut MutexGuard<HPETRegisters>,
          shift: u32,
          len: u32,
@@ -462,7 +459,7 @@ fn set_tn_cfg_reg(
          let tn_regs = &mut regs.tn_regs[self.index as usize];
          if tn_regs.is_32bit_mod() {
              tn_regs.cmp = u64::from(tn_regs.cmp as u32); // truncate!
-            self.period = u64::from(self.period as u32); // truncate!
+            tn_regs.period = u64::from(tn_regs.period as u32); // truncate!
          }
  
          if regs.is_hpet_enabled() {
@@ -472,7 +469,7 @@ fn set_tn_cfg_reg(
  
      /// Comparator Value Register
      fn set_tn_cmp_reg(
-        &mut self,
+        &self,
          regs: &mut MutexGuard<HPETRegisters>,
          shift: u32,
          len: u32,
@@ -499,7 +496,7 @@ fn set_tn_cmp_reg(
          }
  
          if tn_regs.is_periodic() {
-            self.period = self.period.deposit(shift, length, value);
+            tn_regs.period = tn_regs.period.deposit(shift, length, value);
          }
  
          tn_regs.clear_valset();
@@ -520,10 +517,11 @@ fn set_tn_fsb_route_reg(
          tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
      }
  
-    fn reset(&mut self, regs: &mut MutexGuard<HPETRegisters>) {
+    fn reset(&self, regs: &mut MutexGuard<HPETRegisters>) {
          self.del_timer(regs);
  
          let tn_regs = &mut regs.tn_regs[self.index as usize];
+        tn_regs.index = self.index;
          tn_regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
          tn_regs.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
          if self.get_state().has_msi_flag() {
@@ -532,29 +530,28 @@ fn reset(&mut self, regs: &mut MutexGuard<HPETRegisters>) {
          // advertise availability of ioapic int
          tn_regs.config |=
              (u64::from(self.get_state().int_route_cap)) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
-        self.period = 0;
-        self.wrap_flag = 0;
+        tn_regs.period = 0;
+        tn_regs.wrap_flag = 0;
      }
  
      /// timer expiration callback
-    fn callback(&mut self, regs: &mut MutexGuard<HPETRegisters>) {
+    fn callback(&self, regs: &mut MutexGuard<HPETRegisters>) {
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
@@ -571,7 +568,7 @@ fn read(&self, target: TimerRegister, regs: &MutexGuard<HPETRegisters>) -> u64 {
      }
  
      fn write(
-        &mut self,
+        &self,
          target: TimerRegister,
          regs: &mut MutexGuard<HPETRegisters>,
          value: u64,
@@ -731,7 +728,7 @@ fn set_cfg_reg(&self, regs: &mut MutexGuard<HPETRegisters>, shift: u32, len: u32
              for timer in self.timers.iter().take(self.num_timers) {
                  // Protect timer in lockless IO case which would not lock BQL.
                  bql::with_guard(|| {
-                    let mut t = timer.borrow_mut();
+                    let t = timer.borrow_mut();
                      let id = t.index as usize;
                      let tn_regs = &regs.tn_regs[id];
  
@@ -992,15 +989,14 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
      }
  
      fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
-        let regs = self.regs.lock().unwrap();
+        let mut regs = self.regs.lock().unwrap();
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
@@ -1072,9 +1068,12 @@ impl ObjectImpl for HPETState {
          .version_id(1)
          .minimum_version_id(1)
          .fields(vmstate_fields! {
+            vmstate_of!(HPETTimerRegistersMigration, index),
              vmstate_of!(HPETTimerRegistersMigration, config),
              vmstate_of!(HPETTimerRegistersMigration, cmp),
              vmstate_of!(HPETTimerRegistersMigration, fsb),
+            vmstate_of!(HPETTimerRegistersMigration, period),
+            vmstate_of!(HPETTimerRegistersMigration, wrap_flag),
          })
          .build()
  );
@@ -1085,9 +1084,6 @@ impl ObjectImpl for HPETState {
          .version_id(2)
          .minimum_version_id(2)
          .fields(vmstate_fields! {
-            vmstate_of!(HPETTimer, index),
-            vmstate_of!(HPETTimer, period),
-            vmstate_of!(HPETTimer, wrap_flag),
              vmstate_of!(HPETTimer, qemu_timer),
          })
          .build();


