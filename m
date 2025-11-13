Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28CACD4F4B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPy-0005XR-U6; Wed, 12 Nov 2025 23:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPn-0005S7-Kg; Wed, 12 Nov 2025 23:58:38 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPl-0001cD-5q; Wed, 12 Nov 2025 23:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009913; x=1794545913;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uXoJUkOhZjdwhX5KNjMRR98nVVQYV3obvpK5cPPhy7Y=;
 b=PgPioLBhvtLUtQRwMoVDFuXExW3aSACJS4qZCqG7DILNmzcGEOih0v+x
 LSe+ecPDhb0L8GZyMUlN6McUQKYdDcuAkTCeRcA7CFFkgj4qybGsXGCN/
 EEDNum0t8bFbvFwZjoQoaSdKw2TUJKU836Ie1CCBbztsuxOKZ/r8EVxNP
 FZvJRIXHz27WJkwzLT1iKoeuJ/iuWiquZ8xK0JQ3o0W3dt5Ty43JlGpBC
 WthnOl60d5rLfquaHcHKKECnZbgVyoUHAIewgD9ZSjb3ubVo/Y3DUglTG
 KrtbfQxoGNw+TIotw2CO0IGWgYFKcUaRxj0vUa29zrbgQuOUcz9c2OWph g==;
X-CSE-ConnectionGUID: MI98ytdnR1CEQxJKxan9Nw==
X-CSE-MsgGUID: IPyA0HhiRnC6YGXmp9dDpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682141"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682141"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:55 -0800
X-CSE-ConnectionGUID: sJk4RytKRLqLuHeqU4DMsQ==
X-CSE-MsgGUID: lIf3cytHQP+PvOLDsy/BlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663299"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:52 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 16/22] rust/hpet: Pass &BqlRefCell<HPETRegisters> as argument
 during MMIO access
Date: Thu, 13 Nov 2025 13:19:31 +0800
Message-Id: <20251113051937.4017675-17-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113051937.4017675-1-zhao1.liu@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently in HPETTimer context, the global registers are accessed by
dereferring a HPETState raw pointer stored in NonNull<>, and then
borrowing the BqlRefCel<>.

This blocks borrowing HPETRegisters once during MMIO access, and
furthermore prevents replacing BqlRefCell<> with Mutex<>.

Therefore, do not access global registers through NonNull<HPETState>
and instead passing &BqlRefCell<HPETRegisters> as argument in
function calls within MMIO access.

But there's one special case that is timer handler, which still needs
to access HPETRegistsers through NonNull<HPETState>. It's okay for now
since this case doesn't have any repeated borrow() or lock reentrancy
issues.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 160 +++++++++++++++++++------------
 1 file changed, 97 insertions(+), 63 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 1bef94e560f6..13e88df66d6f 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -177,7 +177,10 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 }
 
 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
-    timer_cell.borrow_mut().callback()
+    let mut t = timer_cell.borrow_mut();
+    // SFAETY: state field is valid after timer initialization.
+    let hpet_regs = &mut unsafe { t.state.as_mut() }.regs;
+    t.callback(hpet_regs)
 }
 
 #[repr(C)]
@@ -285,11 +288,8 @@ fn get_state(&self) -> &HPETState {
         unsafe { self.state.as_ref() }
     }
 
-    fn is_int_active(&self) -> bool {
-        self.get_state()
-            .regs
-            .borrow()
-            .is_timer_int_active(self.index.into())
+    fn is_int_active(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> bool {
+        hpet_regs.borrow().is_timer_int_active(self.index.into())
     }
 
     /// calculate next value of the general counter that matches the
@@ -307,8 +307,8 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
         }
     }
 
-    fn get_int_route(&self) -> usize {
-        if self.index <= 1 && self.get_state().regs.borrow().is_legacy_mode() {
+    fn get_int_route(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> usize {
+        if self.index <= 1 && hpet_regs.borrow().is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -332,10 +332,10 @@ fn get_int_route(&self) -> usize {
         }
     }
 
-    fn set_irq(&self, set: bool) {
-        let route = self.get_int_route();
+    fn set_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
+        let route = self.get_int_route(hpet_regs);
 
-        if set && self.regs.is_int_enabled() && self.get_state().regs.borrow().is_hpet_enabled() {
+        if set && self.regs.is_int_enabled() && hpet_regs.borrow().is_hpet_enabled() {
             if self.regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
@@ -358,13 +358,17 @@ fn set_irq(&self, set: bool) {
         }
     }
 
-    fn update_irq(&self, set: bool) {
+    fn update_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
+        let mut regs = hpet_regs.borrow_mut();
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
-        self.get_state()
-            .update_int_status(self.index.into(), set && self.regs.is_int_level_triggered());
-        self.set_irq(set);
+        regs.int_status = regs.int_status.deposit(
+            self.index.into(),
+            1,
+            u64::from(set && self.regs.is_int_level_triggered()),
+        );
+        self.set_irq(hpet_regs, set);
     }
 
     fn arm_timer(&mut self, tick: u64) {
@@ -396,20 +400,26 @@ fn set_timer(&mut self) {
         self.arm_timer(self.cmp64);
     }
 
-    fn del_timer(&self) {
+    fn del_timer(&self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
         self.qemu_timer.delete();
 
-        if self.is_int_active() {
+        if self.is_int_active(hpet_regs) {
             // For level-triggered interrupt, this leaves interrupt status
             // register set but lowers irq.
-            self.update_irq(true);
+            self.update_irq(hpet_regs, true);
         }
     }
 
     /// Configuration and Capability Register
-    fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
+    fn set_tn_cfg_reg(
+        &mut self,
+        hpet_regs: &BqlRefCell<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
         let old_val: u64 = self.regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
@@ -419,13 +429,15 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
         if deactivating_bit(old_val, new_val, HPET_TN_CFG_INT_TYPE_SHIFT) {
             // Do this before changing timer.regs.config; otherwise, if
             // HPET_TN_FSB is set, update_irq will not lower the qemu_irq.
-            self.update_irq(false);
+            self.update_irq(hpet_regs, false);
         }
 
         self.regs.config = new_val;
 
-        if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT) && self.is_int_active() {
-            self.update_irq(true);
+        if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT)
+            && self.is_int_active(hpet_regs)
+        {
+            self.update_irq(hpet_regs, true);
         }
 
         if self.regs.is_32bit_mod() {
@@ -433,13 +445,19 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
             self.period = u64::from(self.period as u32); // truncate!
         }
 
-        if self.get_state().regs.borrow().is_hpet_enabled() {
+        if hpet_regs.borrow().is_hpet_enabled() {
             self.set_timer();
         }
     }
 
     /// Comparator Value Register
-    fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
+    fn set_tn_cmp_reg(
+        &mut self,
+        hpet_regs: &BqlRefCell<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         let mut length = len;
         let mut value = val;
 
@@ -463,18 +481,24 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         }
 
         self.regs.clear_valset();
-        if self.get_state().regs.borrow().is_hpet_enabled() {
+        if hpet_regs.borrow().is_hpet_enabled() {
             self.set_timer();
         }
     }
 
     /// FSB Interrupt Route Register
-    fn set_tn_fsb_route_reg(&mut self, shift: u32, len: u32, val: u64) {
+    fn set_tn_fsb_route_reg(
+        &mut self,
+        _hpet_regs: &BqlRefCell<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         self.regs.fsb = self.regs.fsb.deposit(shift, len, val);
     }
 
-    fn reset(&mut self) {
-        self.del_timer();
+    fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
+        self.del_timer(hpet_regs);
         self.regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
         self.regs.config =
             (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
@@ -489,7 +513,7 @@ fn reset(&mut self) {
     }
 
     /// timer expiration callback
-    fn callback(&mut self) {
+    fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
@@ -507,10 +531,10 @@ fn callback(&mut self) {
             self.wrap_flag = 0;
             self.arm_timer(self.cmp64);
         }
-        self.update_irq(true);
+        self.update_irq(hpet_regs, true);
     }
 
-    const fn read(&self, target: TimerRegister) -> u64 {
+    const fn read(&self, target: TimerRegister, _hpet_regs: &BqlRefCell<HPETRegisters>) -> u64 {
         use TimerRegister::*;
         match target {
             CFG => self.regs.config, // including interrupt capabilities
@@ -519,12 +543,19 @@ const fn read(&self, target: TimerRegister) -> u64 {
         }
     }
 
-    fn write(&mut self, target: TimerRegister, value: u64, shift: u32, len: u32) {
+    fn write(
+        &mut self,
+        target: TimerRegister,
+        hpet_regs: &BqlRefCell<HPETRegisters>,
+        value: u64,
+        shift: u32,
+        len: u32,
+    ) {
         use TimerRegister::*;
         match target {
-            CFG => self.set_tn_cfg_reg(shift, len, value),
-            CMP => self.set_tn_cmp_reg(shift, len, value),
-            ROUTE => self.set_tn_fsb_route_reg(shift, len, value),
+            CFG => self.set_tn_cfg_reg(hpet_regs, shift, len, value),
+            CMP => self.set_tn_cmp_reg(hpet_regs, shift, len, value),
+            ROUTE => self.set_tn_fsb_route_reg(hpet_regs, shift, len, value),
         }
     }
 }
@@ -643,38 +674,33 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
         }
     }
 
-    fn update_int_status(&self, index: u32, level: bool) {
-        let mut regs = self.regs.borrow_mut();
-        regs.int_status = regs.int_status.deposit(index, 1, u64::from(level));
-    }
-
     /// General Configuration Register
-    fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
-        let old_val = self.regs.borrow().config;
+    fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, val: u64) {
+        let old_val = regs.borrow().config;
         let mut new_val = old_val.deposit(shift, len, val);
 
         new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-        self.regs.borrow_mut().config = new_val;
+        regs.borrow_mut().config = new_val;
 
         if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Enable main counter and interrupt generation.
             self.hpet_offset
-                .set(ticks_to_ns(self.regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
+                .set(ticks_to_ns(regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
 
             for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
 
-                if t.regs.is_int_enabled() && t.is_int_active() {
-                    t.update_irq(true);
+                if t.regs.is_int_enabled() && t.is_int_active(regs) {
+                    t.update_irq(regs, true);
                 }
                 t.set_timer();
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            self.regs.borrow_mut().counter = self.get_ticks();
+            regs.borrow_mut().counter = self.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
-                timer.borrow().del_timer();
+                timer.borrow().del_timer(regs);
             }
         }
 
@@ -692,20 +718,26 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
     }
 
     /// General Interrupt Status Register: Read/Write Clear
-    fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
+    fn set_int_status_reg(
+        &self,
+        regs: &BqlRefCell<HPETRegisters>,
+        shift: u32,
+        _len: u32,
+        val: u64,
+    ) {
         let new_val = val << shift;
-        let cleared = new_val & self.regs.borrow().int_status;
+        let cleared = new_val & regs.borrow().int_status;
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
-                timer.borrow().update_irq(false);
+                timer.borrow().update_irq(regs, false);
             }
         }
     }
 
     /// Main Counter Value Register
-    fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
-        let mut regs = self.regs.borrow_mut();
+    fn set_counter_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, val: u64) {
+        let mut regs = regs.borrow_mut();
         if regs.is_hpet_enabled() {
             // TODO: Add trace point -
             // trace_hpet_ram_write_counter_write_while_enabled()
@@ -786,7 +818,7 @@ fn realize(&self) -> util::Result<()> {
 
     fn reset_hold(&self, _type: ResetType) {
         for timer in self.timers.iter().take(self.num_timers) {
-            timer.borrow_mut().reset();
+            timer.borrow_mut().reset(&self.regs);
         }
 
         // pit_enabled.set(true) will call irq handler and access regs
@@ -838,16 +870,17 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
         // TODO: Add trace point - trace_hpet_ram_read(addr)
         let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
+        let regs = &self.regs;
 
         use DecodedRegister::*;
         use GlobalRegister::*;
         (match target {
-            Timer(timer, tn_target) => timer.borrow_mut().read(tn_target),
-            Global(CAP) => self.regs.borrow().capability, /* including HPET_PERIOD 0x004 */
-            Global(CFG) => self.regs.borrow().config,
-            Global(INT_STATUS) => self.regs.borrow().int_status,
+            Timer(timer, tn_target) => timer.borrow_mut().read(tn_target, regs),
+            Global(CAP) => regs.borrow().capability, /* including HPET_PERIOD 0x004 */
+            Global(CFG) => regs.borrow().config,
+            Global(INT_STATUS) => regs.borrow().int_status,
             Global(COUNTER) => {
-                let regs = self.regs.borrow();
+                let regs = regs.borrow();
                 // TODO: Add trace point
                 // trace_hpet_ram_read_reading_counter(addr & 4, cur_tick)
                 if regs.is_hpet_enabled() {
@@ -865,16 +898,17 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
+        let regs = &self.regs;
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
         use DecodedRegister::*;
         use GlobalRegister::*;
         match target {
-            Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, value, shift, len),
+            Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, regs, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
-            Global(CFG) => self.set_cfg_reg(shift, len, value),
-            Global(INT_STATUS) => self.set_int_status_reg(shift, len, value),
-            Global(COUNTER) => self.set_counter_reg(shift, len, value),
+            Global(CFG) => self.set_cfg_reg(regs, shift, len, value),
+            Global(INT_STATUS) => self.set_int_status_reg(regs, shift, len, value),
+            Global(COUNTER) => self.set_counter_reg(regs, shift, len, value),
             Unknown(_) => {
                 // TODO: Add trace point - trace_hpet_ram_write_invalid()
             }
-- 
2.34.1


