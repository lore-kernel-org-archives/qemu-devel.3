Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B51CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPQ7-00064b-Vf; Wed, 12 Nov 2025 23:58:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPp-0005Sc-Lb; Wed, 12 Nov 2025 23:58:40 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPm-0001cQ-Uw; Wed, 12 Nov 2025 23:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009915; x=1794545915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qjar8JPNJS0OVJcETUFDEyqdhwLuXMP4AVrLH04tbf4=;
 b=kvwpyFHxKwui+gKNui9EKBPI/il2S0+1zP2T6MhIztEDhLPfHx+pzCcW
 a4UBTldMOM+peXboaX0s0BZmCwC4qFnqiOtcF6ngxIak2diWWlY6zhXET
 4DHaDCNgmCn8DPFLMffyGwIMsQL9Ipjc28YMvDQgu76bzOgJqdQnBQqqz
 RIlin70hIuzz1lUU61FXAIck6nzG4XxzbgkyC2HvH9DoP6ZSwszVXRxzS
 wbxMvIlCjsT2mcZLih2aI01Acp+wUifCuOl+Wp3FlbsgaQP1lR5FS6Qf8
 nRPIZk3MGcYcGoh0no/IAM2eiO0agEADwTD5hiWcpDi/2/mY34bahwvPA Q==;
X-CSE-ConnectionGUID: tNqfNejyQwOTGsbXrPQp1A==
X-CSE-MsgGUID: X5PEZ5N2RaGieYe8ABwxxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682146"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682146"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:57 -0800
X-CSE-ConnectionGUID: 0XXvVLF+SJqP8ohZtpzmIA==
X-CSE-MsgGUID: psHm+WSpSmmTdOSstWdQuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663319"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:55 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 17/22] rust/hpet: Maintain HPETTimerRegisters in HPETRegisters
Date: Thu, 13 Nov 2025 13:19:32 +0800
Message-Id: <20251113051937.4017675-18-zhao1.liu@intel.com>
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

Lockless IO requires holding a single lock during MMIO access, so that
it's necessary to maintain timer N's registers (HPETTimerRegisters) with
global register in one place.

Therefore, move HPETTimerRegisters to HPETRegisters from HPETTimer, and
access timer registers from HPETRegisters struct for the whole HPET
code.

This changes HPETTimer and HPETRegisters, and the layout of VMState has
changed, which makes it incompatible to migrate with previous versions.
Thus, bump up the version IDs in VMStates of HPETState and HPETTimer.

The VMState version IDs of HPETRegisters doesn't need to change since
it's a newly added struct and its version IDs doesn't affect the
compatibility of HPETState's VMState.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 167 ++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 68 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 13e88df66d6f..462a09880b61 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -241,7 +241,6 @@ pub struct HPETTimer {
     /// timer block abstraction containing this timer
     state: NonNull<HPETState>,
 
-    regs: HPETTimerRegisters,
     // Hidden register state
     /// comparator (extended to counter width)
     cmp64: u64,
@@ -266,7 +265,6 @@ fn new(index: u8, state: *const HPETState) -> HPETTimer {
             // is initialized below.
             qemu_timer: unsafe { Timer::new() },
             state: NonNull::new(state.cast_mut()).unwrap(),
-            regs: Default::default(),
             cmp64: 0,
             period: 0,
             wrap_flag: 0,
@@ -295,8 +293,14 @@ fn is_int_active(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> bool {
     /// calculate next value of the general counter that matches the
     /// target (either entirely, or the low 32-bit only depending on
     /// the timer mode).
-    fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
-        if self.regs.is_32bit_mod() {
+    fn calculate_cmp64(
+        &self,
+        hpet_regs: &BqlRefCell<HPETRegisters>,
+        cur_tick: u64,
+        target: u64,
+    ) -> u64 {
+        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+        if tn_regs.is_32bit_mod() {
             let mut result: u64 = cur_tick.deposit(0, 32, target);
             if result < cur_tick {
                 result += 0x100000000;
@@ -308,7 +312,8 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
     }
 
     fn get_int_route(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> usize {
-        if self.index <= 1 && hpet_regs.borrow().is_legacy_mode() {
+        let regs = hpet_regs.borrow();
+        if self.index <= 1 && regs.is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -328,32 +333,34 @@ fn get_int_route(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> usize {
             // ...
             // If the LegacyReplacement Route bit is not set, the individual
             // routing bits for each of the timers are used.
-            self.regs.get_individual_route()
+            regs.tn_regs[self.index as usize].get_individual_route()
         }
     }
 
     fn set_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
+        let regs = hpet_regs.borrow();
+        let tn_regs = &regs.tn_regs[self.index as usize];
         let route = self.get_int_route(hpet_regs);
 
-        if set && self.regs.is_int_enabled() && hpet_regs.borrow().is_hpet_enabled() {
-            if self.regs.is_fsb_route_enabled() {
+        if set && tn_regs.is_int_enabled() && regs.is_hpet_enabled() {
+            if tn_regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
                 unsafe {
                     address_space_stl_le(
                         addr_of_mut!(address_space_memory),
-                        self.regs.fsb >> 32,  // Timer N FSB int addr
-                        self.regs.fsb as u32, // Timer N FSB int value, truncate!
+                        tn_regs.fsb >> 32,  // Timer N FSB int addr
+                        tn_regs.fsb as u32, // Timer N FSB int value, truncate!
                         MEMTXATTRS_UNSPECIFIED,
                         null_mut(),
                     );
                 }
-            } else if self.regs.is_int_level_triggered() {
+            } else if tn_regs.is_int_level_triggered() {
                 self.get_state().irqs[route].raise();
             } else {
                 self.get_state().irqs[route].pulse();
             }
-        } else if !self.regs.is_fsb_route_enabled() {
+        } else if !tn_regs.is_fsb_route_enabled() {
             self.get_state().irqs[route].lower();
         }
     }
@@ -366,16 +373,17 @@ fn update_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
         regs.int_status = regs.int_status.deposit(
             self.index.into(),
             1,
-            u64::from(set && self.regs.is_int_level_triggered()),
+            u64::from(set && regs.tn_regs[self.index as usize].is_int_level_triggered()),
         );
         self.set_irq(hpet_regs, set);
     }
 
-    fn arm_timer(&mut self, tick: u64) {
+    fn arm_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>, tick: u64) {
+        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
-        if self.regs.is_periodic() && ns - self.last < 1000 {
+        if tn_regs.is_periodic() && ns - self.last < 1000 {
             ns = self.last + 1000;
         }
 
@@ -383,21 +391,22 @@ fn arm_timer(&mut self, tick: u64) {
         self.qemu_timer.modify(self.last);
     }
 
-    fn set_timer(&mut self) {
+    fn set_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
+        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
         let cur_tick: u64 = self.get_state().get_ticks();
 
         self.wrap_flag = 0;
-        self.cmp64 = self.calculate_cmp64(cur_tick, self.regs.cmp);
-        if self.regs.is_32bit_mod() {
+        self.cmp64 = self.calculate_cmp64(hpet_regs, cur_tick, tn_regs.cmp);
+        if tn_regs.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
-            if !self.regs.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
+            if !tn_regs.is_periodic() && self.cmp64 > hpet_next_wrap(cur_tick) {
                 self.wrap_flag = 1;
-                self.arm_timer(hpet_next_wrap(cur_tick));
+                self.arm_timer(hpet_regs, hpet_next_wrap(cur_tick));
                 return;
             }
         }
-        self.arm_timer(self.cmp64);
+        self.arm_timer(hpet_regs, self.cmp64);
     }
 
     fn del_timer(&self, hpet_regs: &BqlRefCell<HPETRegisters>) {
@@ -412,16 +421,16 @@ fn del_timer(&self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         }
     }
 
-    /// Configuration and Capability Register
-    fn set_tn_cfg_reg(
-        &mut self,
+    fn prepare_tn_cfg_reg_new(
+        &self,
         hpet_regs: &BqlRefCell<HPETRegisters>,
         shift: u32,
         len: u32,
         val: u64,
-    ) {
+    ) -> (u64, u64) {
+        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
         // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
-        let old_val: u64 = self.regs.config;
+        let old_val: u64 = tn_regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
         new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
 
@@ -432,7 +441,21 @@ fn set_tn_cfg_reg(
             self.update_irq(hpet_regs, false);
         }
 
-        self.regs.config = new_val;
+        (new_val, old_val)
+    }
+
+    /// Configuration and Capability Register
+    fn set_tn_cfg_reg(
+        &mut self,
+        hpet_regs: &BqlRefCell<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
+        // Factor out a prepare_tn_cfg_reg_new() to better handle immutable scope.
+        let (new_val, old_val) = self.prepare_tn_cfg_reg_new(hpet_regs, shift, len, val);
+        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+        tn_regs.config = new_val;
 
         if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT)
             && self.is_int_active(hpet_regs)
@@ -440,13 +463,13 @@ fn set_tn_cfg_reg(
             self.update_irq(hpet_regs, true);
         }
 
-        if self.regs.is_32bit_mod() {
-            self.regs.cmp = u64::from(self.regs.cmp as u32); // truncate!
+        if tn_regs.is_32bit_mod() {
+            tn_regs.cmp = u64::from(tn_regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
 
         if hpet_regs.borrow().is_hpet_enabled() {
-            self.set_timer();
+            self.set_timer(hpet_regs);
         }
     }
 
@@ -458,11 +481,12 @@ fn set_tn_cmp_reg(
         len: u32,
         val: u64,
     ) {
+        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
         let mut length = len;
         let mut value = val;
 
         // TODO: Add trace point - trace_hpet_ram_write_tn_cmp(addr & 4)
-        if self.regs.is_32bit_mod() {
+        if tn_regs.is_32bit_mod() {
             // High 32-bits are zero, leave them untouched.
             if shift != 0 {
                 // TODO: Add trace point - trace_hpet_ram_write_invalid_tn_cmp()
@@ -472,41 +496,43 @@ fn set_tn_cmp_reg(
             value = u64::from(value as u32); // truncate!
         }
 
-        if !self.regs.is_periodic() || self.regs.is_valset_enabled() {
-            self.regs.cmp = self.regs.cmp.deposit(shift, length, value);
+        if !tn_regs.is_periodic() || tn_regs.is_valset_enabled() {
+            tn_regs.cmp = tn_regs.cmp.deposit(shift, length, value);
         }
 
-        if self.regs.is_periodic() {
+        if tn_regs.is_periodic() {
             self.period = self.period.deposit(shift, length, value);
         }
 
-        self.regs.clear_valset();
+        tn_regs.clear_valset();
         if hpet_regs.borrow().is_hpet_enabled() {
-            self.set_timer();
+            self.set_timer(hpet_regs);
         }
     }
 
     /// FSB Interrupt Route Register
     fn set_tn_fsb_route_reg(
-        &mut self,
-        _hpet_regs: &BqlRefCell<HPETRegisters>,
+        &self,
+        hpet_regs: &BqlRefCell<HPETRegisters>,
         shift: u32,
         len: u32,
         val: u64,
     ) {
-        self.regs.fsb = self.regs.fsb.deposit(shift, len, val);
+        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+        tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
     }
 
     fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         self.del_timer(hpet_regs);
-        self.regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
-        self.regs.config =
-            (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
+
+        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+        tn_regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
+        tn_regs.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
         if self.get_state().has_msi_flag() {
-            self.regs.config |= 1 << HPET_TN_CFG_FSB_CAP_SHIFT;
+            tn_regs.config |= 1 << HPET_TN_CFG_FSB_CAP_SHIFT;
         }
         // advertise availability of ioapic int
-        self.regs.config |=
+        tn_regs.config |=
             (u64::from(self.get_state().int_route_cap)) << HPET_TN_CFG_INT_ROUTE_CAP_SHIFT;
         self.period = 0;
         self.wrap_flag = 0;
@@ -514,32 +540,35 @@ fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
 
     /// timer expiration callback
     fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
+        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
-        if self.regs.is_periodic() && period != 0 {
+        if tn_regs.is_periodic() && period != 0 {
             while hpet_time_after(cur_tick, self.cmp64) {
                 self.cmp64 += period;
             }
-            if self.regs.is_32bit_mod() {
-                self.regs.cmp = u64::from(self.cmp64 as u32); // truncate!
+            if tn_regs.is_32bit_mod() {
+                tn_regs.cmp = u64::from(self.cmp64 as u32); // truncate!
             } else {
-                self.regs.cmp = self.cmp64;
+                tn_regs.cmp = self.cmp64;
             }
-            self.arm_timer(self.cmp64);
+            self.arm_timer(hpet_regs, self.cmp64);
         } else if self.wrap_flag != 0 {
             self.wrap_flag = 0;
-            self.arm_timer(self.cmp64);
+            self.arm_timer(hpet_regs, self.cmp64);
         }
         self.update_irq(hpet_regs, true);
     }
 
-    const fn read(&self, target: TimerRegister, _hpet_regs: &BqlRefCell<HPETRegisters>) -> u64 {
+    fn read(&self, target: TimerRegister, hpet_regs: &BqlRefCell<HPETRegisters>) -> u64 {
+        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+
         use TimerRegister::*;
         match target {
-            CFG => self.regs.config, // including interrupt capabilities
-            CMP => self.regs.cmp,    // comparator register
-            ROUTE => self.regs.fsb,
+            CFG => tn_regs.config, // including interrupt capabilities
+            CMP => tn_regs.cmp,    // comparator register
+            ROUTE => tn_regs.fsb,
         }
     }
 
@@ -574,6 +603,9 @@ pub struct HPETRegisters {
     /// Main Counter Value Register
     #[doc(alias = "hpet_counter")]
     counter: u64,
+
+    /// HPET Timer N Registers
+    tn_regs: [HPETTimerRegisters; HPET_MAX_TIMERS],
 }
 
 impl HPETRegisters {
@@ -689,11 +721,13 @@ fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, va
 
             for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
+                let id = t.index as usize;
+                let tn_regs = &regs.borrow().tn_regs[id];
 
-                if t.regs.is_int_enabled() && t.is_int_active(regs) {
+                if tn_regs.is_int_enabled() && t.is_int_active(regs) {
                     t.update_irq(regs, true);
                 }
-                t.set_timer();
+                t.set_timer(regs);
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
@@ -936,8 +970,9 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
             let cnt = regs.counter;
+            let cmp = regs.tn_regs[t.index as usize].cmp;
 
-            t.cmp64 = t.calculate_cmp64(cnt, t.regs.cmp);
+            t.cmp64 = t.calculate_cmp64(&self.regs, cnt, cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
@@ -1001,8 +1036,6 @@ impl ObjectImpl for HPETState {
         })
         .build();
 
-// In fact, version_id and minimum_version_id for HPETTimerRegisters are
-// unrelated to HPETTimer's version IDs. Does not affect compatibility.
 impl_vmstate_struct!(
     HPETTimerRegisters,
     VMStateDescriptionBuilder::<HPETTimerRegisters>::new()
@@ -1020,11 +1053,10 @@ impl ObjectImpl for HPETState {
 const VMSTATE_HPET_TIMER: VMStateDescription<HPETTimer> =
     VMStateDescriptionBuilder::<HPETTimer>::new()
         .name(c"hpet_timer")
-        .version_id(1)
-        .minimum_version_id(1)
+        .version_id(2)
+        .minimum_version_id(2)
         .fields(vmstate_fields! {
             vmstate_of!(HPETTimer, index),
-            vmstate_of!(HPETTimer, regs),
             vmstate_of!(HPETTimer, period),
             vmstate_of!(HPETTimer, wrap_flag),
             vmstate_of!(HPETTimer, qemu_timer),
@@ -1035,18 +1067,17 @@ impl ObjectImpl for HPETState {
 
 const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
-// In fact, version_id and minimum_version_id for HPETRegisters are
-// unrelated to HPETState's version IDs. Does not affect compatibility.
 impl_vmstate_struct!(
     HPETRegisters,
     VMStateDescriptionBuilder::<HPETRegisters>::new()
         .name(c"hpet/regs")
-        .version_id(1)
-        .minimum_version_id(1)
+        .version_id(2)
+        .minimum_version_id(2)
         .fields(vmstate_fields! {
             vmstate_of!(HPETRegisters, config),
             vmstate_of!(HPETRegisters, int_status),
             vmstate_of!(HPETRegisters, counter),
+            vmstate_of!(HPETRegisters, tn_regs),
         })
         .build()
 );
@@ -1054,8 +1085,8 @@ impl ObjectImpl for HPETState {
 const VMSTATE_HPET: VMStateDescription<HPETState> =
     VMStateDescriptionBuilder::<HPETState>::new()
         .name(c"hpet")
-        .version_id(2)
-        .minimum_version_id(2)
+        .version_id(3)
+        .minimum_version_id(3)
         .pre_save(&HPETState::pre_save)
         .post_load(&HPETState::post_load)
         .fields(vmstate_fields! {
-- 
2.34.1


