Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB51CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPO-00051i-Jb; Wed, 12 Nov 2025 23:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPP3-0004nC-Uj; Wed, 12 Nov 2025 23:57:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPP1-0001cQ-RL; Wed, 12 Nov 2025 23:57:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009868; x=1794545868;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+YdbXeEqE+puvWdAroyG8RJQQsXOeSTyzDteFo5UZjI=;
 b=ejn6P63Y22gpgzVut57KHsA6WlmGdUijfRdimZBV8kRhIQoG8fuujuWn
 SkpJzfRcJOV3VGsduVN9r6Wa5vTGZwwRNzMpaTeNJQxWPO1xVX8l8tlDP
 ehcaTNu7pyldAaeWHwqApahGUQDqqHEt0huVEkcNgX11z3rWT+rvjBO8t
 vkuocKmMvU733USI/KihXP9++Zw2R6WXjiIIzOLuuDpITWNF3qQ6pzii5
 BuB8PXFgDP4J671MYH95Ipl57Osk8CcHO3VTfOXKx5OufI9A37Bw01UvO
 r4/YBwU0wCRH9d4JRQF/ZG0yGWz26kufNLX0h3yG2ZX1+HuzDqRnejhJR A==;
X-CSE-ConnectionGUID: KcwOQTqhS6udJoIm59aeeQ==
X-CSE-MsgGUID: vrMPHNQXSEe09qaJOhpBcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682109"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682109"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:45 -0800
X-CSE-ConnectionGUID: JDzN5jJXS7iiptlyndL6Sw==
X-CSE-MsgGUID: VTgN1wJmQHWx1aWEUlvUiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663265"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:42 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 11/22] rust/hpet: Make timer register accessors as methods of
 HPETTimerRegisters
Date: Thu, 13 Nov 2025 13:19:26 +0800
Message-Id: <20251113051937.4017675-12-zhao1.liu@intel.com>
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
---
 rust/hw/timer/hpet/src/device.rs | 108 ++++++++++++++++---------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index c7c0987aeb71..13123c257522 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -192,6 +192,41 @@ pub struct HPETTimerRegisters {
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
@@ -254,40 +289,11 @@ fn is_int_active(&self) -> bool {
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
@@ -298,10 +304,6 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
         }
     }
 
-    const fn get_individual_route(&self) -> usize {
-        ((self.regs.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
-    }
-
     fn get_int_route(&self) -> usize {
         if self.index <= 1 && self.get_state().is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
@@ -323,15 +325,15 @@ fn get_int_route(&self) -> usize {
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
@@ -343,12 +345,12 @@ fn set_irq(&self, set: bool) {
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
@@ -358,7 +360,7 @@ fn update_irq(&self, set: bool) {
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
         self.get_state()
-            .update_int_status(self.index.into(), set && self.is_int_level_triggered());
+            .update_int_status(self.index.into(), set && self.regs.is_int_level_triggered());
         self.set_irq(set);
     }
 
@@ -366,7 +368,7 @@ fn arm_timer(&mut self, tick: u64) {
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
-        if self.is_periodic() && ns - self.last < 1000 {
+        if self.regs.is_periodic() && ns - self.last < 1000 {
             ns = self.last + 1000;
         }
 
@@ -379,10 +381,10 @@ fn set_timer(&mut self) {
 
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
@@ -423,7 +425,7 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
             self.update_irq(true);
         }
 
-        if self.is_32bit_mod() {
+        if self.regs.is_32bit_mod() {
             self.regs.cmp = u64::from(self.regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
@@ -439,7 +441,7 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         let mut value = val;
 
         // TODO: Add trace point - trace_hpet_ram_write_tn_cmp(addr & 4)
-        if self.is_32bit_mod() {
+        if self.regs.is_32bit_mod() {
             // High 32-bits are zero, leave them untouched.
             if shift != 0 {
                 // TODO: Add trace point - trace_hpet_ram_write_invalid_tn_cmp()
@@ -449,15 +451,15 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
             value = u64::from(value as u32); // truncate!
         }
 
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
@@ -488,11 +490,11 @@ fn callback(&mut self) {
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
@@ -651,7 +653,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
 
-                if t.is_int_enabled() && t.is_int_active() {
+                if t.regs.is_int_enabled() && t.is_int_active() {
                     t.update_irq(true);
                 }
                 t.set_timer();
@@ -810,8 +812,8 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         // TODO: Add trace point - trace_hpet_ram_read(addr)
         let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
 
-        use GlobalRegister::*;
         use DecodedRegister::*;
+        use GlobalRegister::*;
         (match target {
             Timer(timer, tn_target) => timer.borrow_mut().read(tn_target),
             Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
@@ -837,8 +839,8 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
-        use GlobalRegister::*;
         use DecodedRegister::*;
+        use GlobalRegister::*;
         match target {
             Timer(timer, tn_target) => timer.borrow_mut().write(tn_target, value, shift, len),
             Global(CAP) => {} // General Capabilities and ID Register: Read Only
-- 
2.34.1


