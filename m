Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47B5CD4F4B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPQ4-0005sN-Ml; Wed, 12 Nov 2025 23:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPq-0005Sd-2Q; Wed, 12 Nov 2025 23:58:40 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPn-0001c6-10; Wed, 12 Nov 2025 23:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009915; x=1794545915;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N9AZpBd6/q/5oHUSzHqqPqrrk3vQsoyaWoV5xGqOOQw=;
 b=FSScF6FcsodMF4VrlQ+jKHQ7YDg7v3S8Rd2cF0F+ZvLuGaNJrFs97ktt
 IWl8eY/QjitalgIf0mbMjGojuZA/gTXN2q+E4U/ur2eBDF98VLCuMbrvG
 wUfePaLyipFCxbE3Xrf+6dDdx1UC/n7bS/umaRnz2CIL4MHH991b8bGYt
 HNrYBxlx2FX3smpyeQsAgKqi071LHKTH/kdd/2bxXpWqpks+PujHGB+xN
 15mXexKw1KFmmunG64AH02bDw1MrB/cErAqJeomKaqtuNIqX5eVzcdDkN
 iT3knJz3nxz0ST2ePZ27g/tpIgOqv9ClfrF+nLf5MgRaJ5MD9VXm/VFlq w==;
X-CSE-ConnectionGUID: rhPW0eSiRCqGJGpJGkGghw==
X-CSE-MsgGUID: O7YpBJgITXuf2yXQFF6LNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682162"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682162"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:58:00 -0800
X-CSE-ConnectionGUID: qswQX7xsQUGpyvVN3FJZAg==
X-CSE-MsgGUID: 39iw9uV4SSK019SCKs8yRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663397"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:57 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 18/22] rust/hpet: Borrow BqlRefCell<HPETRegisters> at top level
Date: Thu, 13 Nov 2025 13:19:33 +0800
Message-Id: <20251113051937.4017675-19-zhao1.liu@intel.com>
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
---
 rust/hw/timer/hpet/src/device.rs | 270 ++++++++++++++++++++-----------
 1 file changed, 177 insertions(+), 93 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 462a09880b61..f8a551fc0a78 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -179,7 +179,7 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
     let mut t = timer_cell.borrow_mut();
     // SFAETY: state field is valid after timer initialization.
-    let hpet_regs = &mut unsafe { t.state.as_mut() }.regs;
+    let hpet_regs = &mut unsafe { t.state.as_mut() }.regs.borrow_mut();
     t.callback(hpet_regs)
 }
 
@@ -286,20 +286,27 @@ fn get_state(&self) -> &HPETState {
         unsafe { self.state.as_ref() }
     }
 
-    fn is_int_active(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> bool {
-        hpet_regs.borrow().is_timer_int_active(self.index.into())
+    fn is_int_active(&self, hpet_regs: &HPETRegisters) -> bool {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        hpet_regs.is_timer_int_active(self.index.into())
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
+    fn calculate_cmp64(&self, hpet_regs: &HPETRegisters, cur_tick: u64, target: u64) -> u64 {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             let mut result: u64 = cur_tick.deposit(0, 32, target);
             if result < cur_tick {
@@ -311,9 +318,14 @@ fn calculate_cmp64(
         }
     }
 
-    fn get_int_route(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> usize {
-        let regs = hpet_regs.borrow();
-        if self.index <= 1 && regs.is_legacy_mode() {
+    fn get_int_route(&self, hpet_regs: &HPETRegisters) -> usize {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        if self.index <= 1 && hpet_regs.is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -333,16 +345,21 @@ fn get_int_route(&self, hpet_regs: &BqlRefCell<HPETRegisters>) -> usize {
             // ...
             // If the LegacyReplacement Route bit is not set, the individual
             // routing bits for each of the timers are used.
-            regs.tn_regs[self.index as usize].get_individual_route()
+            hpet_regs.tn_regs[self.index as usize].get_individual_route()
         }
     }
 
-    fn set_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
-        let regs = hpet_regs.borrow();
-        let tn_regs = &regs.tn_regs[self.index as usize];
+    fn set_irq(&self, hpet_regs: &HPETRegisters, set: bool) {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
         let route = self.get_int_route(hpet_regs);
 
-        if set && tn_regs.is_int_enabled() && regs.is_hpet_enabled() {
+        if set && tn_regs.is_int_enabled() && hpet_regs.is_hpet_enabled() {
             if tn_regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
@@ -365,21 +382,32 @@ fn set_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
         }
     }
 
-    fn update_irq(&self, hpet_regs: &BqlRefCell<HPETRegisters>, set: bool) {
-        let mut regs = hpet_regs.borrow_mut();
+    fn update_irq(&self, hpet_regs: &mut HPETRegisters, set: bool) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
-        regs.int_status = regs.int_status.deposit(
+        hpet_regs.int_status = hpet_regs.int_status.deposit(
             self.index.into(),
             1,
-            u64::from(set && regs.tn_regs[self.index as usize].is_int_level_triggered()),
+            u64::from(set && hpet_regs.tn_regs[self.index as usize].is_int_level_triggered()),
         );
         self.set_irq(hpet_regs, set);
     }
 
-    fn arm_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>, tick: u64) {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn arm_timer(&mut self, hpet_regs: &HPETRegisters, tick: u64) {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
         let mut ns = self.get_state().get_ns(tick);
 
         // Clamp period to reasonable min value (1 us)
@@ -391,8 +419,14 @@ fn arm_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>, tick: u64) {
         self.qemu_timer.modify(self.last);
     }
 
-    fn set_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn set_timer(&mut self, hpet_regs: &HPETRegisters) {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
         let cur_tick: u64 = self.get_state().get_ticks();
 
         self.wrap_flag = 0;
@@ -409,7 +443,13 @@ fn set_timer(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         self.arm_timer(hpet_regs, self.cmp64);
     }
 
-    fn del_timer(&self, hpet_regs: &BqlRefCell<HPETRegisters>) {
+    fn del_timer(&self, hpet_regs: &mut HPETRegisters) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
         self.qemu_timer.delete();
@@ -423,12 +463,18 @@ fn del_timer(&self, hpet_regs: &BqlRefCell<HPETRegisters>) {
 
     fn prepare_tn_cfg_reg_new(
         &self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
+        hpet_regs: &mut HPETRegisters,
         shift: u32,
         len: u32,
         val: u64,
     ) -> (u64, u64) {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
         // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
         let old_val: u64 = tn_regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
@@ -445,43 +491,46 @@ fn prepare_tn_cfg_reg_new(
     }
 
     /// Configuration and Capability Register
-    fn set_tn_cfg_reg(
-        &mut self,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
-        shift: u32,
-        len: u32,
-        val: u64,
-    ) {
+    fn set_tn_cfg_reg(&mut self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         // Factor out a prepare_tn_cfg_reg_new() to better handle immutable scope.
         let (new_val, old_val) = self.prepare_tn_cfg_reg_new(hpet_regs, shift, len, val);
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
-        tn_regs.config = new_val;
+        // After prepare_tn_cfg_reg_new(), it's safe to access int_status with a
+        // immutable reference before update_irq().
+        let tn_int_active = self.is_int_active(hpet_regs);
+        hpet_regs.tn_regs[self.index as usize].config = new_val;
 
-        if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT)
-            && self.is_int_active(hpet_regs)
-        {
+        if activating_bit(old_val, new_val, HPET_TN_CFG_INT_ENABLE_SHIFT) && tn_int_active {
             self.update_irq(hpet_regs, true);
         }
 
+        // Create the mutable reference after update_irq() to ensure that
+        // only one mutable reference exists at a time.
+        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             tn_regs.cmp = u64::from(tn_regs.cmp as u32); // truncate!
             self.period = u64::from(self.period as u32); // truncate!
         }
 
-        if hpet_regs.borrow().is_hpet_enabled() {
+        if hpet_regs.is_hpet_enabled() {
             self.set_timer(hpet_regs);
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
+    fn set_tn_cmp_reg(&mut self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
         let mut length = len;
         let mut value = val;
 
@@ -505,27 +554,33 @@ fn set_tn_cmp_reg(
         }
 
         tn_regs.clear_valset();
-        if hpet_regs.borrow().is_hpet_enabled() {
+        if hpet_regs.is_hpet_enabled() {
             self.set_timer(hpet_regs);
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
+    fn set_tn_fsb_route_reg(&self, hpet_regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
         tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
     }
 
-    fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
+    fn reset(&mut self, hpet_regs: &mut HPETRegisters) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         self.del_timer(hpet_regs);
 
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
         tn_regs.cmp = u64::MAX; // Comparator Match Registers reset to all 1's.
         tn_regs.config = (1 << HPET_TN_CFG_PERIODIC_CAP_SHIFT) | (1 << HPET_TN_CFG_SIZE_CAP_SHIFT);
         if self.get_state().has_msi_flag() {
@@ -539,8 +594,14 @@ fn reset(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
     }
 
     /// timer expiration callback
-    fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
-        let tn_regs = &mut hpet_regs.borrow_mut().tn_regs[self.index as usize];
+    fn callback(&mut self, hpet_regs: &mut HPETRegisters) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &mut hpet_regs.tn_regs[self.index as usize];
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
@@ -561,8 +622,14 @@ fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         self.update_irq(hpet_regs, true);
     }
 
-    fn read(&self, target: TimerRegister, hpet_regs: &BqlRefCell<HPETRegisters>) -> u64 {
-        let tn_regs = &hpet_regs.borrow().tn_regs[self.index as usize];
+    fn read(&self, target: TimerRegister, hpet_regs: &HPETRegisters) -> u64 {
+        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
+        let tn_regs = &hpet_regs.tn_regs[self.index as usize];
 
         use TimerRegister::*;
         match target {
@@ -575,11 +642,17 @@ fn read(&self, target: TimerRegister, hpet_regs: &BqlRefCell<HPETRegisters>) ->
     fn write(
         &mut self,
         target: TimerRegister,
-        hpet_regs: &BqlRefCell<HPETRegisters>,
+        hpet_regs: &mut HPETRegisters,
         value: u64,
         shift: u32,
         len: u32,
     ) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         use TimerRegister::*;
         match target {
             CFG => self.set_tn_cfg_reg(hpet_regs, shift, len, value),
@@ -707,22 +780,28 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
     }
 
     /// General Configuration Register
-    fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, val: u64) {
-        let old_val = regs.borrow().config;
+    fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
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
@@ -731,7 +810,7 @@ fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, va
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            regs.borrow_mut().counter = self.get_ticks();
+            regs.counter = self.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow().del_timer(regs);
@@ -752,15 +831,15 @@ fn set_cfg_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, va
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
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         let new_val = val << shift;
-        let cleared = new_val & regs.borrow().int_status;
+        let cleared = new_val & regs.int_status;
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
@@ -770,8 +849,13 @@ fn set_int_status_reg(
     }
 
     /// Main Counter Value Register
-    fn set_counter_reg(&self, regs: &BqlRefCell<HPETRegisters>, shift: u32, len: u32, val: u64) {
-        let mut regs = regs.borrow_mut();
+    fn set_counter_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
+        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
+        // but there's no lock guard to guarantee this. So we have to check BQL
+        // context explicitly. This check should be removed when we switch to
+        // Mutex<HPETRegisters>.
+        assert!(bql::is_locked());
+
         if regs.is_hpet_enabled() {
             // TODO: Add trace point -
             // trace_hpet_ram_write_counter_write_while_enabled()
@@ -851,15 +935,16 @@ fn realize(&self) -> util::Result<()> {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        for timer in self.timers.iter().take(self.num_timers) {
-            timer.borrow_mut().reset(&self.regs);
-        }
-
         // pit_enabled.set(true) will call irq handler and access regs
         // again. We cannot borrow BqlRefCell twice at once. Minimize the
         // scope of regs to ensure it will be dropped before irq callback.
         {
             let mut regs = self.regs.borrow_mut();
+
+            for timer in self.timers.iter().take(self.num_timers) {
+                timer.borrow_mut().reset(&mut regs);
+            }
+
             regs.counter = 0;
             regs.config = 0;
             HPETFwConfig::update_hpet_cfg(
@@ -904,17 +989,16 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
         // TODO: Add trace point - trace_hpet_ram_read(addr)
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
                 // TODO: Add trace point
                 // trace_hpet_ram_read_reading_counter(addr & 4, cur_tick)
                 if regs.is_hpet_enabled() {
@@ -932,7 +1016,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
-        let regs = &self.regs;
+        let regs = &mut self.regs.borrow_mut();
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
         use DecodedRegister::*;
@@ -972,7 +1056,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
             let cnt = regs.counter;
             let cmp = regs.tn_regs[t.index as usize].cmp;
 
-            t.cmp64 = t.calculate_cmp64(&self.regs, cnt, cmp);
+            t.cmp64 = t.calculate_cmp64(&regs, cnt, cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
-- 
2.34.1


