Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41237CCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPg-00059x-PG; Wed, 12 Nov 2025 23:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPQ-00054A-48; Wed, 12 Nov 2025 23:58:12 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPN-0001cD-W3; Wed, 12 Nov 2025 23:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009890; x=1794545890;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9FjEDY+GF/YArWJ05FOcZ+WtDQiE6q6wuBg3+lsy+ZU=;
 b=UI9y0AQd27cG6tKr623muZgfsGwYGno69lRO/m7E9+6SDZ4MGbCwfzt+
 75TZ6rhujc39rzMDeBVudjyr4dy7BNdUqiFDJ1FElr2ACrMPncDVnVki8
 IBx/KaPkBt/bd+5BsXrHxpJUr/pQhlAFFDN+5Un8J8gh0zZI7zsG31WC5
 Y6EyiKbfRQmWLGHpSs0R2Le4RnHk5tVRorKGpUSMvS62VuDCdQ5KSq+/e
 jDACq/MJGJAKY9aM48uO4Y5BuUfbPHc5unXQNxT4V5G53ltaEhyq5SFYq
 p2CuTwIur3MajWonntTloUfKTNFly4ulK3YsCP/4N+7EJ+kS6Tl+25M8D Q==;
X-CSE-ConnectionGUID: TSLtYhBdRxOpWAUxxlhv1w==
X-CSE-MsgGUID: STkdW5IaSB2K2r++2WwLsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682124"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682124"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:49 -0800
X-CSE-ConnectionGUID: wHBKprh9T+KSm6Kq1rmjNw==
X-CSE-MsgGUID: oJVtCOlJRPi58XRybDLwCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663276"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:47 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 13/22] rust/hpet: Make global register accessors as methods of
 HPETRegisters
Date: Thu, 13 Nov 2025 13:19:28 +0800
Message-Id: <20251113051937.4017675-14-zhao1.liu@intel.com>
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

Implement helper accessors as methods of HPETRegisters. Then
HPETRegisters can be accessed without going through HPETState.

In subsequent refactoring, coarser-grained BQL lock protection will be
implemented. Specifically, BqlRefCell<HPETRegisters> will be borrowed
only once during MMIO accesses, and the scope of borrowed `regs` will
be extended to cover the entire MMIO access. Consequently, repeated
borrow() attempts within function calls will no longer be allowed.

Therefore, refactor the accessors of HPETRegisters to bypass HPETState,
which help to reduce borrow() in deep function calls.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 60 ++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 503ceee4c445..738ebb374fc9 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -286,7 +286,10 @@ fn get_state(&self) -> &HPETState {
     }
 
     fn is_int_active(&self) -> bool {
-        self.get_state().is_timer_int_active(self.index.into())
+        self.get_state()
+            .regs
+            .borrow()
+            .is_timer_int_active(self.index.into())
     }
 
     /// calculate next value of the general counter that matches the
@@ -305,7 +308,7 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
     }
 
     fn get_int_route(&self) -> usize {
-        if self.index <= 1 && self.get_state().is_legacy_mode() {
+        if self.index <= 1 && self.get_state().regs.borrow().is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -332,7 +335,7 @@ fn get_int_route(&self) -> usize {
     fn set_irq(&self, set: bool) {
         let route = self.get_int_route();
 
-        if set && self.regs.is_int_enabled() && self.get_state().is_hpet_enabled() {
+        if set && self.regs.is_int_enabled() && self.get_state().regs.borrow().is_hpet_enabled() {
             if self.regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
@@ -430,7 +433,7 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
             self.period = u64::from(self.period as u32); // truncate!
         }
 
-        if self.get_state().is_hpet_enabled() {
+        if self.get_state().regs.borrow().is_hpet_enabled() {
             self.set_timer();
         }
     }
@@ -460,7 +463,7 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         }
 
         self.regs.clear_valset();
-        if self.get_state().is_hpet_enabled() {
+        if self.get_state().regs.borrow().is_hpet_enabled() {
             self.set_timer();
         }
     }
@@ -542,6 +545,20 @@ pub struct HPETRegisters {
     counter: u64,
 }
 
+impl HPETRegisters {
+    fn is_legacy_mode(&self) -> bool {
+        self.config & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
+    }
+
+    fn is_hpet_enabled(&self) -> bool {
+        self.config & (1 << HPET_CFG_ENABLE_SHIFT) != 0
+    }
+
+    fn is_timer_int_active(&self, index: usize) -> bool {
+        self.int_status & (1 << index) != 0
+    }
+}
+
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
 #[derive(qom::Object, hwcore::Device)]
@@ -589,18 +606,6 @@ const fn has_msi_flag(&self) -> bool {
         self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
     }
 
-    fn is_legacy_mode(&self) -> bool {
-        self.regs.borrow().config & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
-    }
-
-    fn is_hpet_enabled(&self) -> bool {
-        self.regs.borrow().config & (1 << HPET_CFG_ENABLE_SHIFT) != 0
-    }
-
-    fn is_timer_int_active(&self, index: usize) -> bool {
-        self.regs.borrow().int_status & (1 << index) != 0
-    }
-
     fn get_ticks(&self) -> u64 {
         ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset.get())
     }
@@ -610,13 +615,14 @@ fn get_ns(&self, tick: u64) -> u64 {
     }
 
     fn handle_legacy_irq(&self, irq: u32, level: u32) {
+        let regs = self.regs.borrow();
         if irq == HPET_LEGACY_PIT_INT {
-            if !self.is_legacy_mode() {
+            if !regs.is_legacy_mode() {
                 self.irqs[0].set(level != 0);
             }
         } else {
             self.rtc_irq_level.set(level);
-            if !self.is_legacy_mode() {
+            if !regs.is_legacy_mode() {
                 self.irqs[RTC_ISA_IRQ].set(level != 0);
             }
         }
@@ -699,7 +705,8 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
 
     /// Main Counter Value Register
     fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
-        if self.is_hpet_enabled() {
+        let mut regs = self.regs.borrow_mut();
+        if regs.is_hpet_enabled() {
             // TODO: Add trace point -
             // trace_hpet_ram_write_counter_write_while_enabled()
             //
@@ -710,7 +717,6 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
             // tick count (i.e., the previously calculated offset will
             // not be changed as well).
         }
-        let mut regs = self.regs.borrow_mut();
         regs.counter = regs.counter.deposit(shift, len, val);
     }
 
@@ -829,12 +835,13 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
             Global(CFG) => self.regs.borrow().config,
             Global(INT_STATUS) => self.regs.borrow().int_status,
             Global(COUNTER) => {
+                let regs = self.regs.borrow();
                 // TODO: Add trace point
                 // trace_hpet_ram_read_reading_counter(addr & 4, cur_tick)
-                if self.is_hpet_enabled() {
+                if regs.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
-                    self.regs.borrow().counter
+                    regs.counter
                 }
             }
             Unknown(_) => {
@@ -863,8 +870,9 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
     }
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
-        if self.is_hpet_enabled() {
-            self.regs.borrow_mut().counter = self.get_ticks();
+        let mut regs = self.regs.borrow_mut();
+        if regs.is_hpet_enabled() {
+            regs.counter = self.get_ticks();
         }
 
         /*
@@ -899,7 +907,7 @@ fn is_rtc_irq_level_needed(&self) -> bool {
     }
 
     fn is_offset_needed(&self) -> bool {
-        self.is_hpet_enabled() && self.hpet_offset_saved
+        self.regs.borrow().is_hpet_enabled() && self.hpet_offset_saved
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-- 
2.34.1


