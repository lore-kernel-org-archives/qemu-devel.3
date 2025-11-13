Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C907DCD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPH-0004vy-0C; Wed, 12 Nov 2025 23:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPP1-0004mw-HP; Wed, 12 Nov 2025 23:57:50 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOy-0001cD-7r; Wed, 12 Nov 2025 23:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009864; x=1794545864;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8y44TWWZ7YkqfY56EWmux3E/J0/0GlO70XheCGeJv7c=;
 b=ABPM439k2w1wL0PVkeJNbl2+QD0yjvNTLruin1eYdV1Pa20KlOFWgz/B
 LgJqssmK0Ul6pEy6KvEDjOxcMHTPBgruybMNg6xbKkfPwqhMWeufBp2cj
 1Rbv7AgkxgEvPV/2BegljcYlIYL/VfaVZ4z38eje0iS3g5xrT+3Ra636u
 wt4t24sh5NuF6gsNui4p4+sLHuBZjjzsH3XKLr0V4wVoqrKGt8G+1KKUM
 l8pEn5BxXW+n7vfNKMhpePU1f4xhjiaJv+WH9QT/Dx7HZeata9gnsFYoG
 /M2/8UfZaxI5PPZVgSU9fmaIy/NdmPROFMejF9CzhZJDaaZqLg7Va322d Q==;
X-CSE-ConnectionGUID: 7Z+oV4qaRV++8qdoeY1M6w==
X-CSE-MsgGUID: Av7fxogaTxCBHeVPws7QBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682098"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682098"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:42 -0800
X-CSE-ConnectionGUID: kiPO4nMpSr+3aUDsemopeA==
X-CSE-MsgGUID: 3dlrR08AR+SZPuLQv3f2eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663259"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:40 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 10/22] rust/hpet: Abstract HPETTimerRegisters struct
Date: Thu, 13 Nov 2025 13:19:25 +0800
Message-Id: <20251113051937.4017675-11-zhao1.liu@intel.com>
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

Place all timer N's registers in a HPETTimerRegisters struct.

This allows all Timer N registers to be grouped together with global
registers and managed using a single lock (BqlRefCell or Mutex) in
future. And this makes it easier to apply ToMigrationState macro.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 101 ++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 41 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 2105538cffe6..c7c0987aeb71 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -180,6 +180,18 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
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
@@ -191,14 +203,7 @@ pub struct HPETTimer {
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
@@ -223,9 +228,7 @@ fn new(index: u8, state: *const HPETState) -> HPETTimer {
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
@@ -252,32 +255,32 @@ fn is_int_active(&self) -> bool {
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
@@ -296,7 +299,7 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
     }
 
     const fn get_individual_route(&self) -> usize {
-        ((self.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
+        ((self.regs.config & HPET_TN_CFG_INT_ROUTE_MASK) >> HPET_TN_CFG_INT_ROUTE_SHIFT) as usize
     }
 
     fn get_int_route(&self) -> usize {
@@ -334,8 +337,8 @@ fn set_irq(&self, set: bool) {
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
@@ -375,7 +378,7 @@ fn set_timer(&mut self) {
         let cur_tick: u64 = self.get_state().get_ticks();
 
         self.wrap_flag = 0;
-        self.cmp64 = self.calculate_cmp64(cur_tick, self.cmp);
+        self.cmp64 = self.calculate_cmp64(cur_tick, self.regs.cmp);
         if self.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
@@ -403,25 +406,25 @@ fn del_timer(&self) {
     /// Configuration and Capability Register
     fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
         // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
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
 
@@ -447,7 +450,7 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         }
 
         if !self.is_periodic() || self.is_valset_enabled() {
-            self.cmp = self.cmp.deposit(shift, length, value);
+            self.regs.cmp = self.regs.cmp.deposit(shift, length, value);
         }
 
         if self.is_periodic() {
@@ -462,18 +465,19 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
 
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
@@ -489,9 +493,9 @@ fn callback(&mut self) {
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
@@ -504,9 +508,9 @@ fn callback(&mut self) {
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
 
@@ -865,7 +869,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
 
-            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.cmp);
+            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.regs.cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
@@ -929,6 +933,22 @@ impl ObjectImpl for HPETState {
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
@@ -936,14 +956,13 @@ impl ObjectImpl for HPETState {
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
2.34.1


