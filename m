Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313D2E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRb-0007Qn-EJ; Sat, 27 Dec 2025 04:18:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRR-00071n-8V
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRO-0003tZ-R8
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NisvLOvlFj34dGny5Nm7Ra+7kuex4jcPKLIx0SYwBt8=;
 b=AomICaZtApSH7Z1iCr0KbsCWalZgXGWJ37bD4c43FBpcB38IslxFlsRCVIl9Oiewsu2Uzs
 xbckJbKCeW9qesuWE4+JYMgBsWGpdDVHkFMA6Juzk+IaTmBAtgse6UnvkmRvdThel6dn/I
 t+PlqUyjG4p1gqfM7cnRrpplYFvtwN0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-c-3PMj55NwCMyz69YvMtRA-1; Sat, 27 Dec 2025 04:18:24 -0500
X-MC-Unique: c-3PMj55NwCMyz69YvMtRA-1
X-Mimecast-MFC-AGG-ID: c-3PMj55NwCMyz69YvMtRA_1766827103
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso4744487f8f.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827101; x=1767431901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NisvLOvlFj34dGny5Nm7Ra+7kuex4jcPKLIx0SYwBt8=;
 b=BNkG4+/NB6id1AZj9oEgII8zQH57+7CTzv4/OnY1xvfV6Jjp9VBKV9iSSuwPoXUYJi
 dqPwCTAXkEpWFYZzYrM62WCs3z8WbaIUlsa2FZ7UU8xdmtkoVtyPv76dnb2krd0DjN/5
 cwAXOscsevsD6/95YECtCNLaFbvBY/iONhDFrjaQK2QIL4muWM1d8yVNeJnYIMA43rSP
 43LPENTOm+Hwz9gV4mr5sR2CBL8GHWkVHpf2fs3RsoPCxR4rquILhMucboyQSq8AtaZ7
 Sir5v6SqKOHEIeJg3O2TJzBTpc/vRVQbVCfaCafJf4TYdxVcVY/zWl98iytWQQAhWhDR
 mUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827101; x=1767431901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NisvLOvlFj34dGny5Nm7Ra+7kuex4jcPKLIx0SYwBt8=;
 b=gbs3lwUhRweP0SwzQAS9pfICXLUZiNVaRak4UK5MG5Riynm9qAkTDML7QOlyVXzw5T
 kjwYy7bUV/60zC2vjbbv2PePVjVT55H6uTAZloL+rD2g8D+pTl3JrNhfdFlYMXiYIGs9
 T5Y10iwKU8frS7qdcb0s6g4JZagbk+xjKFpOq6BvlgnMkwyKEPZXx6FXjX1rer7WNNxV
 a6Al3RoMryokvl7nUJuPsFgIAayrZUCJrIF/LcDR9VIm0UHbijRibdee7kX0smYj0LjX
 k0sp9UFtYKrGTdhkppdEnYBF0Ear6cNGb/JrdxpiMUEKWq3LD3OjFhYmAVliQRHtRi0/
 i8eg==
X-Gm-Message-State: AOJu0YzdQ+PQjgXqYFOyt80H0TxIeSL+JxWGY6TQ3uMvaIS7GuASBfpz
 y165H8cHnUWHc6FJIfthGP+g9Cxr0Jjd/DWHFqN/XtGmbRKjkvYcNGQiBP7xg8vN9oqFnY85LLp
 Q+ip6xKdp8wdBmVJfZt5vs16oYOGN9jJj7fjBTAGdAPNKPda6r/QiGdOlVr6RPV6lFJgnVIaTsa
 dqpcuoe/U7/1KF81R5sKdWFKaku/FJ1TIZDp3aUu+r
X-Gm-Gg: AY/fxX4JKxQDdMflagkav4F3JiIAJz3vFzhO4BYB7OXClPy+jaIh26LsalfRFPPoF07
 u/meabXszxTesnBt0/LnmILKIQ+MljdCv8Gkf9zO3Vd7sSnXG+l6WVJR5bvwbcqzdRc+ErxukMh
 ju/FumuJyS1hsRbqlzGjwpb1f98llhERBOwjitdHSlHBC1UnnA2L/pvpJMp1wrXw6lkpyRgFYfg
 6HX3KO1qIlgsBlvuLW9EmBhTOlw7UwjcQzHqbCkPb5IA9/W6MID/eCur4cDweTmQpvCseZFK1F0
 Ki98FpCajAjBk8JLIiB1KEZlqsps96XnAHg5BqeJmGdpA9YdgM98pEJzVPxVzpSJuJiwXOnKWSM
 2EUhppSYuKyA85DpLJtNub++qiwXAlVqgn4EOSQ89+mQn2+K1pmVGpz/LINL2EvDM1REWrp267y
 pSKCvTIjqlExPodWA=
X-Received: by 2002:a05:6000:2c12:b0:432:88be:27ae with SMTP id
 ffacd0b85a97d-43288be281fmr1364290f8f.23.1766827101168; 
 Sat, 27 Dec 2025 01:18:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZzFd0hE0HcQ2CUV0d17axRTaSOStMN0jGSAaofWYcOEYkqzML6h5QwqIkZDUSJZI8mWeDHw==
X-Received: by 2002:a05:6000:2c12:b0:432:88be:27ae with SMTP id
 ffacd0b85a97d-43288be281fmr1364254f8f.23.1766827100565; 
 Sat, 27 Dec 2025 01:18:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2278dsm50621825f8f.18.2025.12.27.01.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 060/153] rust/hpet: Pass &BqlRefCell<HPETRegisters> as argument
 during MMIO access
Date: Sat, 27 Dec 2025 10:14:47 +0100
Message-ID: <20251227091622.20725-61-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Link: https://lore.kernel.org/r/20251113051937.4017675-17-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 161 +++++++++++++++++++------------
 1 file changed, 97 insertions(+), 64 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index d622a6920a8..0e076a7f1d8 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -171,7 +171,10 @@ const fn deactivating_bit(old: u64, new: u64, shift: usize) -> bool {
 }
 
 fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
-    timer_cell.borrow_mut().callback()
+    let mut t = timer_cell.borrow_mut();
+    // SFAETY: state field is valid after timer initialization.
+    let hpet_regs = &mut unsafe { t.state.as_mut() }.regs;
+    t.callback(hpet_regs)
 }
 
 #[repr(C)]
@@ -279,11 +282,8 @@ fn get_state(&self) -> &HPETState {
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
@@ -301,8 +301,8 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
         }
     }
 
-    fn get_int_route(&self) -> usize {
-        if self.index <= 1 && self.get_state().regs.borrow().is_legacy_mode() {
+    fn get_int_route(&self, regs: &HPETRegisters) -> usize {
+        if self.index <= 1 && regs.is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -326,10 +326,10 @@ fn get_int_route(&self) -> usize {
         }
     }
 
-    fn set_irq(&self, set: bool) {
-        let route = self.get_int_route();
+    fn set_irq(&self, regs: &HPETRegisters, set: bool) {
+        let route = self.get_int_route(regs);
 
-        if set && self.regs.is_int_enabled() && self.get_state().regs.borrow().is_hpet_enabled() {
+        if set && self.regs.is_int_enabled() && regs.is_hpet_enabled() {
             if self.regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
@@ -352,13 +352,17 @@ fn set_irq(&self, set: bool) {
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
+        self.set_irq(&regs, set);
     }
 
     fn arm_timer(&mut self, tick: u64) {
@@ -390,22 +394,27 @@ fn set_timer(&mut self) {
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
         trace::trace_hpet_ram_write_tn_cfg((shift / 8).try_into().unwrap());
-
         let old_val: u64 = self.regs.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
         new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
@@ -414,13 +423,15 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
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
@@ -428,13 +439,19 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
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
 
@@ -459,18 +476,24 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
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
@@ -485,7 +508,7 @@ fn reset(&mut self) {
     }
 
     /// timer expiration callback
-    fn callback(&mut self) {
+    fn callback(&mut self, hpet_regs: &BqlRefCell<HPETRegisters>) {
         let period: u64 = self.period;
         let cur_tick: u64 = self.get_state().get_ticks();
 
@@ -503,10 +526,10 @@ fn callback(&mut self) {
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
@@ -515,14 +538,21 @@ const fn read(&self, target: TimerRegister) -> u64 {
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
 
         trace::trace_hpet_ram_write_timer_id(self.index);
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
@@ -641,38 +671,33 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
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
 
@@ -690,20 +715,26 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
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
             // HPET spec says that writes to this register should only be
             // done while the counter is halted. So this is an undefined
@@ -782,7 +813,7 @@ fn realize(&self) -> util::Result<()> {
 
     fn reset_hold(&self, _type: ResetType) {
         for timer in self.timers.iter().take(self.num_timers) {
-            timer.borrow_mut().reset();
+            timer.borrow_mut().reset(&self.regs);
         }
 
         // pit_enabled.set(true) will call irq handler and access regs
@@ -834,16 +865,17 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
         trace::trace_hpet_ram_read(addr);
 
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
                 let cur_tick = if regs.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
@@ -863,17 +895,18 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, target } = self.decode(addr, size);
+        let regs = &self.regs;
 
         trace::trace_hpet_ram_write(addr, value);
 
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
             Unknown(_) => trace::trace_hpet_ram_write_invalid(),
         }
     }
-- 
2.52.0


