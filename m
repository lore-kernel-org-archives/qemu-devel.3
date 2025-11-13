Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F107CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPj-0005Fj-A8; Wed, 12 Nov 2025 23:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPP-000548-L3; Wed, 12 Nov 2025 23:58:12 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPM-0001c6-8L; Wed, 12 Nov 2025 23:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009888; x=1794545888;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5qwBwF9cDpYkl6weo1isCPmPJ/BSVyfAE4sWRi97xHw=;
 b=nt2trsrB6/G20YN88XWMc2s6gjFl6DsoZzwC6IzQo35Nl7YguP24kr3L
 IprtOvMFiZIFZllrFJPZSLx4oTEkHAXJbVcpQivihfOyr2jmP8slOOMJ0
 nwtcuv1hw8aYf2NurZ5KwUR0HgWYfEW0Loz53EysGs+g7/oVjToyW7fir
 ibmmZsQ96yEkqmXPEz+BnFF3oX9A+dJilJoKeWhomaE58F96kFpNib61i
 yuUbYeZ5Qcuwl9HRCVkXMNIw5oUtSz4EudQA5SHOnZTd1Ll69cq1+IU8V
 pxs0jbHSodAcK+hW5z5TcldyWCaw52yLxdr1n7keLiCaW+Xgt2465cRzU w==;
X-CSE-ConnectionGUID: UfVDhgIPQQi5dqGt2/zS7w==
X-CSE-MsgGUID: M96QKJA0RnmEhG1uFLqyBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682120"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682120"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:47 -0800
X-CSE-ConnectionGUID: YPrU2naNSqOQ4McGZewbkA==
X-CSE-MsgGUID: 4JoERJbCTmShnailfkt6nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663269"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:44 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 12/22] rust/hpet: Abstract HPETRegisters struct
Date: Thu, 13 Nov 2025 13:19:27 +0800
Message-Id: <20251113051937.4017675-13-zhao1.liu@intel.com>
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

Place all HPET (global) timer block registers in a HPETRegisters struct,
and wrap the whole register struct with a BqlRefCell<>.

This allows to elevate the Bql check from individual register access to
register structure access, making the Bql check more coarse-grained. But
in current step, just treat BqlRefCell as BqlCell while maintaining
fine-grained BQL protection. This approach helps to use HPETRegisters
struct clearly without introducing the "already borrowed" around
BqlRefCell.

HPETRegisters struct makes it possible to take a Mutex<> to replace
BqlRefCell<>, like C side did.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 112 +++++++++++++++++++------------
 1 file changed, 68 insertions(+), 44 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 13123c257522..503ceee4c445 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -526,24 +526,29 @@ fn write(&mut self, target: TimerRegister, value: u64, shift: u32, len: u32) {
     }
 }
 
-/// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qom::Object, hwcore::Device)]
-pub struct HPETState {
-    parent_obj: ParentField<SysBusDevice>,
-    iomem: MemoryRegion,
-
+#[derive(Default)]
+pub struct HPETRegisters {
     // HPET block Registers: Memory-mapped, software visible registers
     /// General Capabilities and ID Register
-    capability: BqlCell<u64>,
+    capability: u64,
     ///  General Configuration Register
-    config: BqlCell<u64>,
+    config: u64,
     /// General Interrupt Status Register
     #[doc(alias = "isr")]
-    int_status: BqlCell<u64>,
+    int_status: u64,
     /// Main Counter Value Register
     #[doc(alias = "hpet_counter")]
-    counter: BqlCell<u64>,
+    counter: u64,
+}
+
+/// HPET Event Timer Block Abstraction
+#[repr(C)]
+#[derive(qom::Object, hwcore::Device)]
+pub struct HPETState {
+    parent_obj: ParentField<SysBusDevice>,
+    iomem: MemoryRegion,
+    regs: BqlRefCell<HPETRegisters>,
 
     // Internal state
     /// Capabilities that QEMU HPET supports.
@@ -585,15 +590,15 @@ const fn has_msi_flag(&self) -> bool {
     }
 
     fn is_legacy_mode(&self) -> bool {
-        self.config.get() & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
+        self.regs.borrow().config & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
     }
 
     fn is_hpet_enabled(&self) -> bool {
-        self.config.get() & (1 << HPET_CFG_ENABLE_SHIFT) != 0
+        self.regs.borrow().config & (1 << HPET_CFG_ENABLE_SHIFT) != 0
     }
 
     fn is_timer_int_active(&self, index: usize) -> bool {
-        self.int_status.get() & (1 << index) != 0
+        self.regs.borrow().int_status & (1 << index) != 0
     }
 
     fn get_ticks(&self) -> u64 {
@@ -633,22 +638,22 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
     }
 
     fn update_int_status(&self, index: u32, level: bool) {
-        self.int_status
-            .set(self.int_status.get().deposit(index, 1, u64::from(level)));
+        let mut regs = self.regs.borrow_mut();
+        regs.int_status = regs.int_status.deposit(index, 1, u64::from(level));
     }
 
     /// General Configuration Register
     fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
-        let old_val = self.config.get();
+        let old_val = self.regs.borrow().config;
         let mut new_val = old_val.deposit(shift, len, val);
 
         new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
-        self.config.set(new_val);
+        self.regs.borrow_mut().config = new_val;
 
         if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Enable main counter and interrupt generation.
             self.hpet_offset
-                .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
+                .set(ticks_to_ns(self.regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
 
             for timer in self.timers.iter().take(self.num_timers) {
                 let mut t = timer.borrow_mut();
@@ -660,7 +665,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            self.counter.set(self.get_ticks());
+            self.regs.borrow_mut().counter = self.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow().del_timer();
@@ -683,7 +688,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
     /// General Interrupt Status Register: Read/Write Clear
     fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
-        let cleared = new_val & self.int_status.get();
+        let cleared = new_val & self.regs.borrow().int_status;
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
@@ -705,8 +710,8 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
             // tick count (i.e., the previously calculated offset will
             // not be changed as well).
         }
-        self.counter
-            .set(self.counter.get().deposit(shift, len, val));
+        let mut regs = self.regs.borrow_mut();
+        regs.counter = regs.counter.deposit(shift, len, val);
     }
 
     unsafe fn init(mut this: ParentInit<Self>) {
@@ -749,14 +754,12 @@ fn realize(&self) -> util::Result<()> {
         self.hpet_id.set(HPETFwConfig::assign_hpet_id()?);
 
         // 64-bit General Capabilities and ID Register; LegacyReplacementRoute.
-        self.capability.set(
-            HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
+        self.regs.borrow_mut().capability = HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
             1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
             1 << HPET_CAP_LEG_RT_CAP_SHIFT |
             HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
             ((self.num_timers - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
-            (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
-        );
+            (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT; // 10 ns
 
         self.init_gpio_in(2, HPETState::handle_legacy_irq);
         self.init_gpio_out(from_ref(&self.pit_enabled));
@@ -768,17 +771,23 @@ fn reset_hold(&self, _type: ResetType) {
             timer.borrow_mut().reset();
         }
 
-        self.counter.set(0);
-        self.config.set(0);
+        // pit_enabled.set(true) will call irq handler and access regs
+        // again. We cannot borrow BqlRefCell twice at once. Minimize the
+        // scope of regs to ensure it will be dropped before irq callback.
+        {
+            let mut regs = self.regs.borrow_mut();
+            regs.counter = 0;
+            regs.config = 0;
+            HPETFwConfig::update_hpet_cfg(
+                self.hpet_id.get(),
+                regs.capability as u32,
+                self.mmio_addr(0).unwrap(),
+            );
+        }
+
         self.pit_enabled.set(true);
         self.hpet_offset.set(0);
 
-        HPETFwConfig::update_hpet_cfg(
-            self.hpet_id.get(),
-            self.capability.get() as u32,
-            self.mmio_addr(0).unwrap(),
-        );
-
         // to document that the RTC lowers its output on reset as well
         self.rtc_irq_level.set(0);
     }
@@ -816,16 +825,16 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         use GlobalRegister::*;
         (match target {
             Timer(timer, tn_target) => timer.borrow_mut().read(tn_target),
-            Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
-            Global(CFG) => self.config.get(),
-            Global(INT_STATUS) => self.int_status.get(),
+            Global(CAP) => self.regs.borrow().capability, /* including HPET_PERIOD 0x004 */
+            Global(CFG) => self.regs.borrow().config,
+            Global(INT_STATUS) => self.regs.borrow().int_status,
             Global(COUNTER) => {
                 // TODO: Add trace point
                 // trace_hpet_ram_read_reading_counter(addr & 4, cur_tick)
                 if self.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
-                    self.counter.get()
+                    self.regs.borrow().counter
                 }
             }
             Unknown(_) => {
@@ -855,7 +864,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
         if self.is_hpet_enabled() {
-            self.counter.set(self.get_ticks());
+            self.regs.borrow_mut().counter = self.get_ticks();
         }
 
         /*
@@ -870,15 +879,16 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
     fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
+            let cnt = t.get_state().regs.borrow().counter;
 
-            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.regs.cmp);
+            t.cmp64 = t.calculate_cmp64(cnt, t.regs.cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
         }
 
         // Recalculate the offset between the main counter and guest time
         if !self.hpet_offset_saved {
             self.hpet_offset
-                .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
+                .set(ticks_to_ns(self.regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
         }
 
         Ok(())
@@ -969,6 +979,22 @@ impl ObjectImpl for HPETState {
 
 const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
+// In fact, version_id and minimum_version_id for HPETRegisters are
+// unrelated to HPETState's version IDs. Does not affect compatibility.
+impl_vmstate_struct!(
+    HPETRegisters,
+    VMStateDescriptionBuilder::<HPETRegisters>::new()
+        .name(c"hpet/regs")
+        .version_id(1)
+        .minimum_version_id(1)
+        .fields(vmstate_fields! {
+            vmstate_of!(HPETRegisters, config),
+            vmstate_of!(HPETRegisters, int_status),
+            vmstate_of!(HPETRegisters, counter),
+        })
+        .build()
+);
+
 const VMSTATE_HPET: VMStateDescription<HPETState> =
     VMStateDescriptionBuilder::<HPETState>::new()
         .name(c"hpet")
@@ -977,9 +1003,7 @@ impl ObjectImpl for HPETState {
         .pre_save(&HPETState::pre_save)
         .post_load(&HPETState::post_load)
         .fields(vmstate_fields! {
-            vmstate_of!(HPETState, config),
-            vmstate_of!(HPETState, int_status),
-            vmstate_of!(HPETState, counter),
+            vmstate_of!(HPETState, regs),
             vmstate_of!(HPETState, num_timers_save),
             vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
             vmstate_of!(HPETState, timers[0 .. num_timers_save], HPETState::validate_num_timers).with_version_id(0),
-- 
2.34.1


