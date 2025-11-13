Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525B8CD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPQg-0007cf-9u; Wed, 12 Nov 2025 23:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPQD-0006RS-Kx; Wed, 12 Nov 2025 23:59:02 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPQA-0001c6-Pv; Wed, 12 Nov 2025 23:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009939; x=1794545939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jZWrwQ2AW7+fPoABLcPfgMVSR/0A/1eZD7+ca/f/FZ0=;
 b=ADVDHluFIdfWqQRvE81XaXM+wyWIT/Y2/wR0WF9ux09KUnHL2ZIxZVB7
 H9B6lNleaE4WpAGioRM5ol7sXPYHY0Ij5DsQOsJ7Qyl/4DSZ1ztae+5wY
 YZvMoAcyoYtjuVqH4eE05fN1HFswnLpjeJH+ryUMf1CootISvc5Ve7v1a
 zCKJpChh/mPzEPwdGyuT1HGJzugjEpLADY7TmFWSxeqOhw9zES7XcRFeR
 sVLxFSR5sJXJe5KGpCZusDASzAE4GcZNcEpAbgU4kthzh5jUY7s9GG59p
 ORw1iHIzF6UALXAfiead7juvPV3bxFrfAWmiINnUwUBxzSxVyv4MOntyE g==;
X-CSE-ConnectionGUID: +Plh5C2XTCWHCzzfwZbeFw==
X-CSE-MsgGUID: 57IPNU9ARwayZvmXwAvFfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682178"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682178"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:58:06 -0800
X-CSE-ConnectionGUID: yPz/nlBsTpOUJ6SbgBFIVQ==
X-CSE-MsgGUID: bGAYdnICQo6/XzsFxABRrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663492"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:58:04 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 21/22] rust/hpet: Replace BqlRefCell<HPETRegisters> with
 Mutex<HPETRegisters>
Date: Thu, 13 Nov 2025 13:19:36 +0800
Message-Id: <20251113051937.4017675-22-zhao1.liu@intel.com>
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

Replace BqlRefCell<HPETRegisters> with Mutex<HPETRegisters> and pass
&MutexGuard<HPETRegisters>/&mut MutexGuard<HPETRegisters> as argument
type to child method calls.

Since the MutexGuard could clearly reflect the register data is
protected under Mutex, remove bql::is_locked() checks.

Then Mutex could lock at top level, including locking once during MMIO
access. Though the lockless IO hasn't been enabled for HPET, Mutex
doesn't have any conflict with BQL for now. So it's safe do such
replacement.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 199 ++++++++++---------------------
 1 file changed, 62 insertions(+), 137 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 42e2e8d070c3..db3e2c8fa23c 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -8,6 +8,7 @@
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
+    sync::{Mutex, MutexGuard},
 };
 
 use bql::{BqlCell, BqlRefCell};
@@ -179,8 +180,8 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
     let mut t = timer_cell.borrow_mut();
     // SFAETY: state field is valid after timer initialization.
-    let regs = &mut unsafe { t.state.as_mut() }.regs.borrow_mut();
-    t.callback(regs)
+    let mut regs = unsafe { t.state.as_ref() }.regs.lock().unwrap();
+    t.callback(&mut regs)
 }
 
 #[repr(C)]
@@ -299,13 +300,7 @@ fn is_int_active(&self, regs: &HPETRegisters) -> bool {
     /// calculate next value of the general counter that matches the
     /// target (either entirely, or the low 32-bit only depending on
     /// the timer mode).
-    fn calculate_cmp64(&self, regs: &HPETRegisters, cur_tick: u64, target: u64) -> u64 {
-        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn calculate_cmp64(&self, regs: &MutexGuard<HPETRegisters>, cur_tick: u64, target: u64) -> u64 {
         let tn_regs = &regs.tn_regs[self.index as usize];
         if tn_regs.is_32bit_mod() {
             let mut result: u64 = cur_tick.deposit(0, 32, target);
@@ -318,13 +313,7 @@ fn calculate_cmp64(&self, regs: &HPETRegisters, cur_tick: u64, target: u64) -> u
         }
     }
 
-    fn get_int_route(&self, regs: &HPETRegisters) -> usize {
-        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn get_int_route(&self, regs: &MutexGuard<HPETRegisters>) -> usize {
         if self.index <= 1 && regs.is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
@@ -349,13 +338,7 @@ fn get_int_route(&self, regs: &HPETRegisters) -> usize {
         }
     }
 
-    fn set_irq(&self, regs: &HPETRegisters, set: bool) {
-        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_irq(&self, regs: &MutexGuard<HPETRegisters>, set: bool) {
         let tn_regs = &regs.tn_regs[self.index as usize];
         let route = self.get_int_route(regs);
 
@@ -382,13 +365,7 @@ fn set_irq(&self, regs: &HPETRegisters, set: bool) {
         }
     }
 
-    fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn update_irq(&self, regs: &mut MutexGuard<HPETRegisters>, set: bool) {
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
@@ -400,13 +377,7 @@ fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
         self.set_irq(regs, set);
     }
 
-    fn arm_timer(&mut self, regs: &HPETRegisters, tick: u64) {
-        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn arm_timer(&mut self, regs: &MutexGuard<HPETRegisters>, tick: u64) {
         let tn_regs = &regs.tn_regs[self.index as usize];
         let mut ns = self.get_state().get_ns(tick);
 
@@ -419,13 +390,7 @@ fn arm_timer(&mut self, regs: &HPETRegisters, tick: u64) {
         self.qemu_timer.modify(self.last);
     }
 
-    fn set_timer(&mut self, regs: &HPETRegisters) {
-        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_timer(&mut self, regs: &MutexGuard<HPETRegisters>) {
         let tn_regs = &regs.tn_regs[self.index as usize];
         let cur_tick: u64 = self.get_state().get_ticks();
 
@@ -443,13 +408,7 @@ fn set_timer(&mut self, regs: &HPETRegisters) {
         self.arm_timer(regs, self.cmp64);
     }
 
-    fn del_timer(&self, regs: &mut HPETRegisters) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn del_timer(&self, regs: &mut MutexGuard<HPETRegisters>) {
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
         self.qemu_timer.delete();
@@ -463,17 +422,11 @@ fn del_timer(&self, regs: &mut HPETRegisters) {
 
     fn prepare_tn_cfg_reg_new(
         &self,
-        regs: &mut HPETRegisters,
+        regs: &mut MutexGuard<HPETRegisters>,
         shift: u32,
         len: u32,
         val: u64,
     ) -> (u64, u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
         let tn_regs = &regs.tn_regs[self.index as usize];
         // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
         let old_val: u64 = tn_regs.config;
@@ -491,13 +444,13 @@ fn prepare_tn_cfg_reg_new(
     }
 
     /// Configuration and Capability Register
-    fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_tn_cfg_reg(
+        &mut self,
+        regs: &mut MutexGuard<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         // Factor out a prepare_tn_cfg_reg_new() to better handle immutable scope.
         let (new_val, old_val) = self.prepare_tn_cfg_reg_new(regs, shift, len, val);
         // After prepare_tn_cfg_reg_new(), it's safe to access int_status with a
@@ -523,13 +476,13 @@ fn set_tn_cfg_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val
     }
 
     /// Comparator Value Register
-    fn set_tn_cmp_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_tn_cmp_reg(
+        &mut self,
+        regs: &mut MutexGuard<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         let tn_regs = &mut regs.tn_regs[self.index as usize];
         let mut length = len;
         let mut value = val;
@@ -560,24 +513,18 @@ fn set_tn_cmp_reg(&mut self, regs: &mut HPETRegisters, shift: u32, len: u32, val
     }
 
     /// FSB Interrupt Route Register
-    fn set_tn_fsb_route_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_tn_fsb_route_reg(
+        &self,
+        regs: &mut MutexGuard<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         let tn_regs = &mut regs.tn_regs[self.index as usize];
         tn_regs.fsb = tn_regs.fsb.deposit(shift, len, val);
     }
 
-    fn reset(&mut self, regs: &mut HPETRegisters) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn reset(&mut self, regs: &mut MutexGuard<HPETRegisters>) {
         self.del_timer(regs);
 
         let tn_regs = &mut regs.tn_regs[self.index as usize];
@@ -594,13 +541,7 @@ fn reset(&mut self, regs: &mut HPETRegisters) {
     }
 
     /// timer expiration callback
-    fn callback(&mut self, regs: &mut HPETRegisters) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn callback(&mut self, regs: &mut MutexGuard<HPETRegisters>) {
         let tn_regs = &mut regs.tn_regs[self.index as usize];
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
@@ -622,13 +563,7 @@ fn callback(&mut self, regs: &mut HPETRegisters) {
         self.update_irq(regs, true);
     }
 
-    fn read(&self, target: TimerRegister, regs: &HPETRegisters) -> u64 {
-        // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn read(&self, target: TimerRegister, regs: &MutexGuard<HPETRegisters>) -> u64 {
         let tn_regs = &regs.tn_regs[self.index as usize];
 
         use TimerRegister::*;
@@ -642,17 +577,11 @@ fn read(&self, target: TimerRegister, regs: &HPETRegisters) -> u64 {
     fn write(
         &mut self,
         target: TimerRegister,
-        regs: &mut HPETRegisters,
+        regs: &mut MutexGuard<HPETRegisters>,
         value: u64,
         shift: u32,
         len: u32,
     ) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
         use TimerRegister::*;
         match target {
             CFG => self.set_tn_cfg_reg(regs, shift, len, value),
@@ -701,7 +630,7 @@ fn is_timer_int_active(&self, index: usize) -> bool {
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
-    regs: Migratable<BqlRefCell<HPETRegisters>>,
+    regs: Migratable<Mutex<HPETRegisters>>,
 
     // Internal state
     /// Capabilities that QEMU HPET supports.
@@ -751,7 +680,7 @@ fn get_ns(&self, tick: u64) -> u64 {
     }
 
     fn handle_legacy_irq(&self, irq: u32, level: u32) {
-        let regs = self.regs.borrow();
+        let regs = self.regs.lock().unwrap();
         if irq == HPET_LEGACY_PIT_INT {
             if !regs.is_legacy_mode() {
                 self.irqs[0].set(level != 0);
@@ -780,13 +709,7 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
     }
 
     /// General Configuration Register
-    fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_cfg_reg(&self, regs: &mut MutexGuard<HPETRegisters>, shift: u32, len: u32, val: u64) {
         let old_val = regs.config;
         let mut new_val = old_val.deposit(shift, len, val);
 
@@ -831,13 +754,13 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
     }
 
     /// General Interrupt Status Register: Read/Write Clear
-    fn set_int_status_reg(&self, regs: &mut HPETRegisters, shift: u32, _len: u32, val: u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_int_status_reg(
+        &self,
+        regs: &mut MutexGuard<HPETRegisters>,
+        shift: u32,
+        _len: u32,
+        val: u64,
+    ) {
         let new_val = val << shift;
         let cleared = new_val & regs.int_status;
 
@@ -849,13 +772,13 @@ fn set_int_status_reg(&self, regs: &mut HPETRegisters, shift: u32, _len: u32, va
     }
 
     /// Main Counter Value Register
-    fn set_counter_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64) {
-        // &mut HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
-        // but there's no lock guard to guarantee this. So we have to check BQL
-        // context explicitly. This check should be removed when we switch to
-        // Mutex<HPETRegisters>.
-        assert!(bql::is_locked());
-
+    fn set_counter_reg(
+        &self,
+        regs: &mut MutexGuard<HPETRegisters>,
+        shift: u32,
+        len: u32,
+        val: u64,
+    ) {
         if regs.is_hpet_enabled() {
             // TODO: Add trace point -
             // trace_hpet_ram_write_counter_write_while_enabled()
@@ -922,7 +845,7 @@ fn realize(&self) -> util::Result<()> {
         self.hpet_id.set(HPETFwConfig::assign_hpet_id()?);
 
         // 64-bit General Capabilities and ID Register; LegacyReplacementRoute.
-        self.regs.borrow_mut().capability = HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
+        self.regs.lock().unwrap().capability = HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
             1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
             1 << HPET_CAP_LEG_RT_CAP_SHIFT |
             HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
@@ -939,7 +862,7 @@ fn reset_hold(&self, _type: ResetType) {
         // again. We cannot borrow BqlRefCell twice at once. Minimize the
         // scope of regs to ensure it will be dropped before irq callback.
         {
-            let mut regs = self.regs.borrow_mut();
+            let mut regs = self.regs.lock().unwrap();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow_mut().reset(&mut regs);
@@ -989,7 +912,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
         // TODO: Add trace point - trace_hpet_ram_read(addr)
         let HPETAddrDecode { shift, target, .. } = self.decode(addr, size);
-        let regs = &self.regs.borrow();
+        let regs = &self.regs.lock().unwrap();
 
         use DecodedRegister::*;
         use GlobalRegister::*;
@@ -1016,7 +939,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
-        let regs = &mut self.regs.borrow_mut();
+        let regs = &mut self.regs.lock().unwrap();
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
         use DecodedRegister::*;
@@ -1034,9 +957,10 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
     }
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
-        let mut regs = self.regs.borrow_mut();
+        let mut regs = self.regs.lock().unwrap();
         if regs.is_hpet_enabled() {
             regs.counter = self.get_ticks();
+            drop(regs); // required by clippy::significant-drop-tightening
         }
 
         /*
@@ -1049,7 +973,7 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
     }
 
     fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
-        let regs = self.regs.borrow();
+        let regs = self.regs.lock().unwrap();
 
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
@@ -1064,6 +988,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         if !self.hpet_offset_saved {
             self.hpet_offset
                 .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
+            drop(regs); // required by clippy::significant-drop-tightening
         }
 
         Ok(())
@@ -1074,7 +999,7 @@ fn is_rtc_irq_level_needed(&self) -> bool {
     }
 
     fn is_offset_needed(&self) -> bool {
-        self.regs.borrow().is_hpet_enabled() && self.hpet_offset_saved
+        self.regs.lock().unwrap().is_hpet_enabled() && self.hpet_offset_saved
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-- 
2.34.1


