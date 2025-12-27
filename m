Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6662FE8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRe-0007hA-Gc; Sat, 27 Dec 2025 04:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRV-0007AC-W5
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRS-00041T-EP
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+It6rXPbyRMS2BhIGgbQHCMr6/9Ea6F9PiZBE4rSII=;
 b=ObZNEVoQ4dHqdQO/C3/ftvI4vY9xGgfptifHvk98J7x0NSb+mfuLPy5a94pqjo/N8Vo0QK
 T6QpWT3sceG1nu49HzD5ibw6AAcsb5JEI+dw2EPFX80jDgJNUI/jk9+OXPY6QWKp1IrXUC
 Y7m3NXIkK8GrY6/iVBA3EAXnuToEtRY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380--cgTjsUiN8WBzffp4Tkf6w-1; Sat, 27 Dec 2025 04:18:27 -0500
X-MC-Unique: -cgTjsUiN8WBzffp4Tkf6w-1
X-Mimecast-MFC-AGG-ID: -cgTjsUiN8WBzffp4Tkf6w_1766827107
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d4029340aso23154545e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827106; x=1767431906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y+It6rXPbyRMS2BhIGgbQHCMr6/9Ea6F9PiZBE4rSII=;
 b=fYO+sTS8X5L4LahOfAj2XY7FL+tMVl7EJdRfEZDi2OOUJ524Csp81xm0TO7MV5Nj+U
 39Hb86A1ljRXH2aEdgFUCcGTnHaP78Wb6gpoif9hun+NIUsEIxqXStJEvvu3uNivbjrp
 kb6aMJEOS96xvde0fhk9T/EN1UW6ztWvNJxyT57/Eh0YJTfrSKARQhdF6jDiQFw0VzAT
 RDl0R1+k28Fkd29coowCBr5cQ7qIJqu69NzMNZH/DOmrXiq+r5REx8cOnHo5OFdIasbJ
 YwJFnQ6dgEStfXcDoupkt1Thgrr+Ethpg+bMjr91Iymd0jXVehiS5Xqc8yDdPyZWJJV/
 xW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827106; x=1767431906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y+It6rXPbyRMS2BhIGgbQHCMr6/9Ea6F9PiZBE4rSII=;
 b=WwKz2riYeUgCn0rehDM5eCWsfeepy9DV8++DykhRwI8Nt/9yqt318ws9oRDUUGZjLM
 zy4WGThTujfzZSLiwi2Zdb4n0hlgEQ16O5jvGBTARCaIW5T4d6GVD0trDzN3EOCR+Pp8
 pFFPm6recbzOlBTIusJVv0UVqfFBJ2otignlTRqBV2hGRMh1uRiWgZfMGACODwNxDzMX
 7oCVjOph6rKXa718iF7ksTsJPEVCIWGAIjWuRQbTbWdhL4u8TC6P+aCp24Ft6dgAVkE/
 jz86by8rpJNeudfp26ruMsxzm3mUpEvG2urbSdEM27ODBIn2POogDOrzi7RVV2fFNUCz
 hBvA==
X-Gm-Message-State: AOJu0Ywpxb2PPBq6Faj1PLMJFnrX+7Lh0lHQ05pqPaCVtP5Bhh1KldUS
 N+q/M0/acWFF7a2GKo0UwwH9JgaUM/pOpg/TFuOVVHS/tr5R417MKN0hjm9L5bfKnuComtvcjzs
 ZIzTUJqGt5mDg9vCJWTH60iYv11jZgMfCO58eTfYWCnYUn8x4XXQWncXdYhdKI5VRWGu67ZtY2T
 QwxiZ65aCq/kuWFu7a11mG47UOvWzU+drJKwMWzQPr
X-Gm-Gg: AY/fxX5Rg6uYcUK1gSUxFVb1MeHJarUIrmi8bf+PhRT1e7EP5PthJUroFx0cOE8LF8m
 F6JMRwvZdWdUrUagXUd3T/CMyjXbAr9pU5sT/URB4Je5fDH9gMA1tcP3g5/S7t1VtSlxWxpLXY2
 vBOs4/UMjv4jN024xh6aSn42lrwkYtJkTA9H0pFSQmGmt+UZFWSFk7yxp7m5/a73Od6TQTD90N3
 f0LkTiznLdONHxXjUUbpyo+pTe+ixRR1ustGPOq0W3ll2px0YqeOInKa1Uj2q3+gxK6pLSR0dUT
 Ny/OYRru2hb3ZI3PvdfVRUY7YfN+BsZT1JQBfMyIXAfqVCcjyojCcxKmrdhC99NWkAaDTnS1Rty
 b49L7ecMVgh1ti91Yruqda16MUS10rmTsGmm4dg1CmScYMp4GDewa9FCWgP9W6GV4TO22WruTey
 6sC6qzkN0lOelfq6g=
X-Received: by 2002:a05:600c:8905:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-47d1958b749mr236532575e9.26.1766827105399; 
 Sat, 27 Dec 2025 01:18:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrAaBIgwvDD3J63XBGfOFA5+B5jmyIlbxXr6cPIhpAMxjXeK68oO8H/A3G/jMIlRCJOOWUOg==
X-Received: by 2002:a05:600c:8905:b0:471:115e:87bd with SMTP id
 5b1f17b1804b1-47d1958b749mr236532325e9.26.1766827104841; 
 Sat, 27 Dec 2025 01:18:24 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm50402459f8f.28.2025.12.27.01.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 062/153] rust/hpet: Borrow BqlRefCell<HPETRegisters> at top
 level
Date: Sat, 27 Dec 2025 10:14:49 +0100
Message-ID: <20251227091622.20725-63-pbonzini@redhat.com>
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

Lockless IO requires to lock the registers during MMIO access. So it's
necessary to get (or borrow) registers data at top level, and not to
borrow again in child function calls.

Change the argument types from BqlRefCell<HPETRegisters> to
&HPETRegisters/&mut HPETRegisters in child methods, and do borrow the
data once at top level.

This allows BqlRefCell<HPETRegisters> to be directly replaced with
Mutex<HPETRegisters> in subsequent steps without causing lock reentrancy
issues.

Note, passing reference instead of BqlRef/BqlRefMut because BqlRefMut
cannot be re-borrowed as BqlRef, though BqlRef/BqlRefMut themselves play
as the "guard". Passing reference is directly and the extra
bql::is_locked check could help to consolidate safety guarantee.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-19-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 190 +++++++++++++------------------
 1 file changed, 80 insertions(+), 110 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index f9cdced5406..916ae587b08 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -174,7 +174,7 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
     let mut t = timer_cell.borrow_mut();
     // SFAETY: state field is valid after timer initialization.
     let hpet_regs = &mut unsafe { t.state.as_mut() }.regs;
-    t.callback(hpet_regs)
+    t.callback(&mut hpet_regs.borrow_mut())
 }
 
 #[repr(C)]
@@ -280,20 +280,15 @@ fn get_state(&self) -> &HPETState {
         unsafe { self.state.as_ref() }
     }
 
-    fn is_int_active(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> bool {
-        hpet_regs.borrow().is_timer_int_active(self.index.into())
+    fn is_int_active(&self, regs: &HPETRegisters) -> bool {
+        regs.is_timer_int_active(self.index.into())
     }
 
     /// calculate next value of the general counter that matches the
     /// target (either entirely, or the low 32-bit only depending on
     /// the timer mode).
-    fn calculate_cmp64(
-        &self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
-        cur_tick: u64,
-        target: u64,
-    ) -> u64 {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn calculate_cmp64(&self, regs: &HPETRegisters, cur_tick: u64, target: u64) -> u64 {
+        let tn_regs = &regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             let mut result: u64 = cur_tick.deposit(0, 32, target);
             if result < cur_tick {
@@ -357,8 +352,7 @@ fn set_irq(&self, regs: &HPETRegisters, set: bool) {
         }
     }
 
-    fn update_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
-        let mut regs = hpet_regs.borrow_mut();
+    fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
@@ -367,11 +361,11 @@ fn update_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
             1,
             u64::from(set && regs.tn_regs[self.index as usize].is_int_level_triggered()),
         );
-        self.set_irq(&regs, set);
+        self.set_irq(regs, set);
     }
 
-    fn arm_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>, tick: u64) {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn arm_timer(&mut self, regs: &HPETRegisters, tick: u64) {
+        let tn_regs = &regs.tn_regs[self.index as usize];
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
@@ -383,45 +377,45 @@ fn arm_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>, tick: u64) {
         self.qemu_timer.modify(self.last);
     }
 
-    fn set_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn set_timer(&mut self, regs: &HPETRegisters) {
+        let tn_regs = &regs.tn_regs[self.index as usize];
         let cur_tick: u64 = self.get_state().get_ticks();
 
         self.wrap_flag = 0;
-        self.cmp64 = self.calculate_cmp64(hpet_regs, cur_tick, tn_regs.cmp);
+        self.cmp64 = self.calculate_cmp64(regs, cur_tick, tn_regs.cmp);
         if tn_regs.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
             if !tn_regs.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
                 self.wrap_flag = 1;
-                self.arm_timer(hpet_regs, hpet_next_wrap(cur_tick));
+                self.arm_timer(regs, hpet_next_wrap(cur_tick));
                 return;
             }
         }
-        self.arm_timer(hpet_regs, self.cmp64);
+        self.arm_timer(regs, self.cmp64);
     }
 
-    fn del_timer(&self, hpet_regs: &BqlRefCell<HPETRegisters>) {
+    fn del_timer(&self, regs: &mut HPETRegisters) {
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
         self.qemu_timer.delete();
 
-        if self.is_int_active(hpet_regs) {
+        if self.is_int_active(regs) {
             // For level-triggered interrupt, this leaves interrupt status
             // register set but lowers irq.
-            self.update_irq(hpet_regs, true);
+            self.update_irq(regs, true);
         }
     }
 
     fn prepare_tn_cfg_reg_new(
         &self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
+        regs: &mut HPETRegisters,
         shift: u32,
         len: u32,
         val: u64,
     ) -> (u64, u64) {
         trace::trace_hpet_ram_write_tn_cfg((shift / 8).try_into().unwrap());
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+        let tn_regs = &regs.tn_regs[self.index as usize];
         let old_val: u64 = tn_regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
         new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
@@ -430,50 +424,38 @@ fn prepare_tn_cfg_reg_new(
         if deactivating_bit(old_val, new_val, HPET_TN_CFG_INT_TYPE_SHIFT) {
             // Do this before changing timer.regs.config; otherwise, if
             // HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
-            self.update_irq(hpet_regs, false);
+            self.update_irq(regs, false);
         }
 
         (new_val, old_val)
     }
 
     /// Configuration and Capability Register
-    fn set_tn_cfg_reg(
-        &mut self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
-        shift: u32,
-        len: u32,
-        val: u64,
-    ) {
+    fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         // Factor out a prepare_tn_cfg_reg_new() to better handle immutable scope.
-        let (new_val, old_val) = self.prepare_tn_cfg_reg_new(hpet_regs, shift, len, val);
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
-        tn_regs.config = new_val;
+        let (new_val, old_val) = self.prepare_tn_cfg_reg_new(regs, shift, len, val);
+        regs.tn_regs[self.index as usize].config = new_val;
 
         if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT)
-            && self.is_int_active(hpet_regs)
+            && self.is_int_active(regs)
         {
-            self.update_irq(hpet_regs, true);
+            self.update_irq(regs, true);
         }
 
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             tn_regs.cmp = u64::from(tn_regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
 
-        if hpet_regs.borrow().is_hpet_enabled() {
-            self.set_timer(hpet_regs);
+        if regs.is_hpet_enabled() {
+            self.set_timer(regs);
         }
     }
 
     /// Comparator Value Register
-    fn set_tn_cmp_reg(
-        &mut self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
-        shift: u32,
-        len: u32,
-        val: u64,
-    ) {
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+    fn set_tn_cmp_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         let mut length = len;
         let mut value = val;
 
@@ -498,27 +480,21 @@ fn set_tn_cmp_reg(
         }
 
         tn_regs.clear_valset();
-        if hpet_regs.borrow().is_hpet_enabled() {
-            self.set_timer(hpet_regs);
+        if regs.is_hpet_enabled() {
+            self.set_timer(regs);
         }
     }
 
     /// FSB Interrupt Route Register
-    fn set_tn_fsb_route_reg(
-        &self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
-        shift: u32,
-        len: u32,
-        val: u64,
-    ) {
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+    fn set_tn_fsb_route_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
     }
 
-    fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
-        self.del_timer(hpet_regs);
+    fn reset(&mut self, regs: &mut HPETRegisters) {
+        self.del_timer(regs);
 
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         tn_regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
         tn_regs.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
         if self.get_state().has_msi_flag() {
@@ -532,8 +508,8 @@ fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
     }
 
     /// timer expiration callback
-    fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+    fn callback(&mut self, regs: &mut HPETRegisters) {
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
@@ -546,16 +522,16 @@ fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
             } else {
                 tn_regs.cmp = self.cmp64;
             }
-            self.arm_timer(hpet_regs, self.cmp64);
+            self.arm_timer(regs, self.cmp64);
         } else if self.wrap_flag != 0 {
             self.wrap_flag = 0;
-            self.arm_timer(hpet_regs, self.cmp64);
+            self.arm_timer(regs, self.cmp64);
         }
-        self.update_irq(hpet_regs, true);
+        self.update_irq(regs, true);
     }
 
-    fn read(&self, target: TimerRegister, hpet_regs: &BqlRefCell<HPETRegisters>) -> u64 {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn read(&self, target: TimerRegister, regs: &HPETRegisters) -> u64 {
+        let tn_regs = &regs.tn_regs[self.index as usize];
 
         use TimerRegister::*;
         match target {
@@ -568,7 +544,7 @@ fn read(&self, target: TimerRegister, hpet_regs: &BqlRefCell<HPETRegisters>) ->
     fn write(
         &mut self,
         target: TimerRegister,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
+        regs: &mut HPETRegisters,
         value: u64,
         shift: u32,
         len: u32,
@@ -577,9 +553,9 @@ fn write(
 
         trace::trace_hpet_ram_write_timer_id(self.index);
         match target {
-            CFG => self.set_tn_cfg_reg(hpet_regs, shift, len, value),
-            CMP => self.set_tn_cmp_reg(hpet_regs, shift, len, value),
-            ROUTE => self.set_tn_fsb_route_reg(hpet_regs, shift, len, value),
+            CFG => self.set_tn_cfg_reg(regs, shift, len, value),
+            CMP => self.set_tn_cmp_reg(regs, shift, len, value),
+            ROUTE => self.set_tn_fsb_route_reg(regs, shift, len, value),
         }
     }
 }
@@ -702,22 +678,22 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
     }
 
     /// General Configuration Register
-    fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, val: u64) {
-        let old_val = regs.borrow().config;
+    fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        let old_val = regs.config;
         let mut new_val = old_val.deposit(shift, len, val);
 
         new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-        regs.borrow_mut().config = new_val;
+        regs.config = new_val;
 
         if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Enable main counter and interrupt generation.
             self.hpet_offset
-                .set(ticks_to_ns(regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
+                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
 
             for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
                 let id = t.index as usize;
-                let tn_regs = &regs.borrow().tn_regs[id];
+                let tn_regs = &regs.tn_regs[id];
 
                 if tn_regs.is_int_enabled() && t.is_int_active(regs) {
                     t.update_irq(regs, true);
@@ -726,7 +702,7 @@ fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, va
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            regs.borrow_mut().counter = self.get_ticks();
+            regs.counter = self.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow().del_timer(regs);
@@ -747,15 +723,9 @@ fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, va
     }
 
     /// General Interrupt Status Register: Read/Write Clear
-    fn set_int_status_reg(
-        &self,
-        regs: &BqlRefCell<HPETRegisters>,
-        shift: u32,
-        _len: u32,
-        val: u64,
-    ) {
+    fn set_int_status_reg(&self, regs: &mut HPETRegisters, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
-        let cleared = new_val & regs.borrow().int_status;
+        let cleared = new_val & regs.int_status;
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
@@ -765,8 +735,7 @@ fn set_int_status_reg(
     }
 
     /// Main Counter Value Register
-    fn set_counter_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, val: u64) {
-        let mut regs = regs.borrow_mut();
+    fn set_counter_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
         if regs.is_hpet_enabled() {
             // HPET spec says that writes to this register should only be
             // done while the counter is halted. So this is an undefined
@@ -844,23 +813,23 @@ fn realize(&self) -> util::Result<()> {
     }
 
     fn reset_hold(&self, _type: ResetType) {
+        let mut regs = self.regs.borrow_mut();
         for timer in self.timers.iter().take(self.num_timers) {
-            timer.borrow_mut().reset(&self.regs);
+            timer.borrow_mut().reset(&mut regs);
         }
 
+        regs.counter = 0;
+        regs.config = 0;
+        HPETFwConfig::update_hpet_cfg(
+            self.hpet_id.get(),
+            regs.capability as u32,
+            self.mmio_addr(0).unwrap(),
+        );
+
         // pit_enabled.set(true) will call irq handler and access regs
         // again. We cannot borrow BqlRefCell twice at once. Minimize the
         // scope of regs to ensure it will be dropped before irq callback.
-        {
-            let mut regs = self.regs.borrow_mut();
-            regs.counter = 0;
-            regs.config = 0;
-            HPETFwConfig::update_hpet_cfg(
-                self.hpet_id.get(),
-                regs.capability as u32,
-                self.mmio_addr(0).unwrap(),
-            );
-        }
+        drop(regs);
 
         self.pit_enabled.set(true);
         self.hpet_offset.set(0);
@@ -897,17 +866,16 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         trace::trace_hpet_ram_read(addr);
 
         let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
-        let regs = &self.regs;
+        let regs = &self.regs.borrow();
 
         use DecodedRegister::*;
         use GlobalRegister::*;
         (match target {
             Timer(timer, tn_target) => timer.borrow_mut().read(tn_target, regs),
-            Global(CAP) => regs.borrow().capability, /* including HPET_PERIOD 0x004 */
-            Global(CFG) => regs.borrow().config,
-            Global(INT_STATUS) => regs.borrow().int_status,
+            Global(CAP) => regs.capability, /* including HPET_PERIOD 0x004 */
+            Global(CFG) => regs.config,
+            Global(INT_STATUS) => regs.int_status,
             Global(COUNTER) => {
-                let regs = regs.borrow();
                 let cur_tick = if regs.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
@@ -927,18 +895,20 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
-        let regs = &self.regs;
+        let mut regs = self.regs.borrow_mut();
 
         trace::trace_hpet_ram_write(addr, value);
 
         use DecodedRegister::*;
         use GlobalRegister::*;
         match target {
-            Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, regs, value, shift, len),
+            Timer(timer, tn_target) => timer
+                .borrow_mut()
+                .write(tn_target, &mut regs, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
-            Global(CFG) => self.set_cfg_reg(regs, shift, len, value),
-            Global(INT_STATUS) => self.set_int_status_reg(regs, shift, len, value),
-            Global(COUNTER) => self.set_counter_reg(regs, shift, len, value),
+            Global(CFG) => self.set_cfg_reg(&mut regs, shift, len, value),
+            Global(INT_STATUS) => self.set_int_status_reg(&mut regs, shift, len, value),
+            Global(COUNTER) => self.set_counter_reg(&mut regs, shift, len, value),
             Unknown(_) => trace::trace_hpet_ram_write_invalid(),
         }
     }
@@ -966,7 +936,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
             let cnt = regs.counter;
             let cmp = regs.tn_regs[t.index as usize].cmp;
 
-            t.cmp64 = t.calculate_cmp64(&self.regs, cnt, cmp);
+            t.cmp64 = t.calculate_cmp64(&regs, cnt, cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
-- 
2.52.0


