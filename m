Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6804BCD4F2F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPQI-0006lr-Ls; Wed, 12 Nov 2025 23:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPQE-0006Up-BI; Wed, 12 Nov 2025 23:59:02 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPQB-0001cD-PL; Wed, 12 Nov 2025 23:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009940; x=1794545940;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NByp9GlRcnKCjuGuzYahaesOPgBgWoE4KIym/eggq9U=;
 b=H7HP+r1f6Ez5kylC53A9Apk28nCPG36Nxjm+06dtF+29YerwBlRga5cq
 uQQ0ayKe5IJuDrQ2+cqJiCyBrGwGmslB+eA1DasLKUfM4KmIeFKkuqY3h
 +8jq5d/nsL0+6ybl5B68FeLvc+DW4yzhJdekjWgplhgyFI/1Jp7U/96hp
 uEcWO9Gq64m/CnYGSLkjaUZEYIOR0XVv9aCTJXjUjvzCJtYD1cEfgcksJ
 srb/SHaNz06NvV9+M7sFdNGqrI747rhbX1RkgSMRsQu1Kyyt5oTa2QwAX
 9zAW9rUxbi5I0a1ScXydq5c8EyGSx865Nx8/1VgHcKz3LWwGADgiBU1dX w==;
X-CSE-ConnectionGUID: 5T5la64GRfKcHzhFk0p+IQ==
X-CSE-MsgGUID: udnGn26tSqSd730x5MlPmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682187"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682187"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:58:08 -0800
X-CSE-ConnectionGUID: FHVIfBqMToO1PEa0FQN/ZQ==
X-CSE-MsgGUID: wTSgmMP7T2y6V9+6FjLZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663501"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:58:06 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 22/22] rust/hpet: Enable lockless IO
Date: Thu, 13 Nov 2025 13:19:37 +0800
Message-Id: <20251113051937.4017675-23-zhao1.liu@intel.com>
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

Enable lockless IO for HPET to allow BQL free MMIO access.

But BQL context is still needed for some cases during MMIO:
 * IRQ handling:

   Like C version of HPET did (commit d99041a20328 ("hpet: guard IRQ
   handling with BQL"), BQL context is needed during IRQ handling.

   But Rust HPET has an extra reason that InterruptSource is placed in
   BqlCell, which requires BQL context explicitly. (This also shows
   that the BQL limitation in the design of the InterruptSource binding
   is reasonable.)

 * BqlCell/BqlRefCell access.

   Except InterruptSource, HPETState has other BqlCell and BqlRefCell:
   hpet_offset (BqlCell<u64>), rtc_irq_level (BqlCell<u32>) and timers
   ([BqlRefCell<HPETTimer>; HPET_MAX_TIMERS]).

   Their data may change during runtime, so the atomic context is
   required.

Therefore, use BqlGuard to provide BQL context in the MMIO path.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Q: HPET C version doesn't guard BQL for hpet_offset, rtc_irq_level and
   timers. Should we add the guard for these fields?
---
 rust/hw/timer/hpet/src/device.rs | 67 ++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index db3e2c8fa23c..f96dfe1ebd06 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -356,12 +356,12 @@ fn set_irq(&self, regs: &MutexGuard<HPETRegisters>, set: bool) {
                     );
                 }
             } else if tn_regs.is_int_level_triggered() {
-                self.get_state().irqs[route].raise();
+                bql::with_guard(|| self.get_state().irqs[route].raise());
             } else {
-                self.get_state().irqs[route].pulse();
+                bql::with_guard(|| self.get_state().irqs[route].pulse());
             }
         } else if !tn_regs.is_fsb_route_enabled() {
-            self.get_state().irqs[route].lower();
+            bql::with_guard(|| self.get_state().irqs[route].lower());
         }
     }
 
@@ -672,14 +672,20 @@ const fn has_msi_flag(&self) -> bool {
     }
 
     fn get_ticks(&self) -> u64 {
-        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset.get())
+        // Protect hpet_offset in lockless IO case which would not lock BQL.
+        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + bql::with_guard(|| self.hpet_offset.get()))
     }
 
     fn get_ns(&self, tick: u64) -> u64 {
-        ticks_to_ns(tick) - self.hpet_offset.get()
+        // Protect hpet_offset in lockless IO case which would not lock BQL.
+        ticks_to_ns(tick) - bql::with_guard(|| self.hpet_offset.get())
     }
 
     fn handle_legacy_irq(&self, irq: u32, level: u32) {
+        // Protect both rtc_irq_level and irqs[] in lockless IO case which
+        // would not lock BQL.
+        let _bql_guard = bql::BqlGuard::new();
+
         let regs = self.regs.lock().unwrap();
         if irq == HPET_LEGACY_PIT_INT {
             if !regs.is_legacy_mode() {
@@ -718,38 +724,49 @@ fn set_cfg_reg(&self, regs: &mut MutexGuard<HPETRegisters>, shift: u32, len: u32
 
         if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Enable main counter and interrupt generation.
-            self.hpet_offset
-                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
+            // Protect hpet_offset in lockless IO case which would not lock BQL.
+            bql::with_guard(|| {
+                self.hpet_offset
+                    .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns())
+            });
 
             for timer in self.timers.iter().take(self.num_timers) {
-                let mut t = timer.borrow_mut();
-                let id = t.index as usize;
-                let tn_regs = &regs.tn_regs[id];
-
-                if tn_regs.is_int_enabled() && t.is_int_active(regs) {
-                    t.update_irq(regs, true);
-                }
-                t.set_timer(regs);
+                // Protect timer in lockless IO case which would not lock BQL.
+                bql::with_guard(|| {
+                    let mut t = timer.borrow_mut();
+                    let id = t.index as usize;
+                    let tn_regs = &regs.tn_regs[id];
+
+                    if tn_regs.is_int_enabled() && t.is_int_active(regs) {
+                        t.update_irq(regs, true);
+                    }
+                    t.set_timer(regs);
+                });
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
             regs.counter = self.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
-                timer.borrow().del_timer(regs);
+                // Protect timer in lockless IO case which would not lock BQL.
+                bql::with_guard(|| timer.borrow().del_timer(regs));
             }
         }
 
         // i8254 and RTC output pins are disabled when HPET is in legacy mode
         if activating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
-            self.pit_enabled.set(false);
-            self.irqs[0].lower();
-            self.irqs[RTC_ISA_IRQ].lower();
+            bql::with_guard(|| {
+                self.pit_enabled.set(false);
+                self.irqs[0].lower();
+                self.irqs[RTC_ISA_IRQ].lower();
+            });
         } else if deactivating_bit(old_val, new_val, HPET_CFG_LEG_RT_SHIFT) {
-            // TODO: Add irq binding: qemu_irq_lower(s->irqs[0])
-            self.irqs[0].lower();
-            self.pit_enabled.set(true);
-            self.irqs[RTC_ISA_IRQ].set(self.rtc_irq_level.get() != 0);
+            bql::with_guard(|| {
+                // TODO: Add irq binding: qemu_irq_lower(s->irqs[0])
+                self.irqs[0].lower();
+                self.pit_enabled.set(true);
+                self.irqs[RTC_ISA_IRQ].set(self.rtc_irq_level.get() != 0);
+            });
         }
     }
 
@@ -766,7 +783,8 @@ fn set_int_status_reg(
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
-                timer.borrow().update_irq(regs, false);
+                // Protect timer in lockless IO case which would not lock BQL.
+                bql::with_guard(|| timer.borrow().update_irq(regs, false));
             }
         }
     }
@@ -827,6 +845,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
 
     fn post_init(&self) {
         self.init_mmio(&self.iomem);
+        self.iomem.enable_lockless_io();
         for irq in self.irqs.iter() {
             self.init_irq(irq);
         }
-- 
2.34.1


