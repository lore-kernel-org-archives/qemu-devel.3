Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CBFE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRa-0007KF-4V; Sat, 27 Dec 2025 04:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRI-0006oB-Qe
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRG-0003gP-UD
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkC95+QEJXnEvaNYkvGGuoEWgNXpEhyP0YGy73T68So=;
 b=bp/WZAo5+QwNKcHYB7SptOtVRHhdyWyq9zJ8wR2pj5K1vG4NCiqFQ2E3NcnS5/I7FINV6H
 DZz38gX4umZ+PrpSTiko0jJ/T158203PYV/ASlyRKFvgKaWrFVF5x/UiTD0zXlJfo1j+lv
 EK6byUg0dovyUI/xDyceXfNIC/jCYmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-SZ6Wppi9NKCQc6bkiuuIag-1; Sat, 27 Dec 2025 04:18:16 -0500
X-MC-Unique: SZ6Wppi9NKCQc6bkiuuIag-1
X-Mimecast-MFC-AGG-ID: SZ6Wppi9NKCQc6bkiuuIag_1766827095
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso4347628f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827094; x=1767431894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkC95+QEJXnEvaNYkvGGuoEWgNXpEhyP0YGy73T68So=;
 b=rUp02qTZlUTnM1PRd8NbZ+BzewvCwqOy9mEiDKrO/sRKUi9WxIkuYUYgsfHKPC31bp
 bWShAqRaLgaiozTqADEWgmU8QtU5EeqsndEax5sIvgt7mYarnuHi3I9RbCFIRBMkP8Kv
 Co+7ZZVI31QCRjKLss+LyXq+/6UeyeeAlOYy1BiZksn/kvKgfgSMnMnotSkgritfvVR0
 lHxKSRV9PfH5NC95RyvGdJj/KTyhGJswfVXc5Jeb0ZyM3tUDIchoGXXQsOo9ndT+n2Ta
 OLGfCZpetpt8Cf9L0E6hG9TMIMiAeaA1kxlmL58nG2lWcwKV7u3qbDJmPdxwmUPQFbZ3
 4TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827094; x=1767431894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jkC95+QEJXnEvaNYkvGGuoEWgNXpEhyP0YGy73T68So=;
 b=tqgPT8Kd4slhyjcwcYfdrRcpMdgg7lv5Hg45D0RSi8+TYUhYL/FGWPbWak9CJOan8f
 zw0RThzK48iRL1zALFor3vaZArB451nhw5owNi99nbYEwlLisWIockpdZDbu2O/ZX1I6
 NyC6QIS0ZSVAuHpT+v4IDABRcQ1b1MBFZ5G2ycKtTWJTQ5NEc4lsGkYIdXaNpByCBlYz
 kPV7D1rUGR8cGeUVoaYmmTKwkaabJI3XOEYl1vNK3813yo8n+4SM8yO539NLSEZVaRHP
 KQgFgdtiELRKusQ5JDmocp2nfiifpzie32KQsNXZo5945Y31gEF+cHY+emt7r23gL0xA
 F9XA==
X-Gm-Message-State: AOJu0YweetGgPnCji2nDbBLireuOsWwom5nB8ujdOujP0DcX6BpKbN8X
 yysV4Pn6wNxudHgc/pkpqOJ98dXlN0x39RWQhlxfZ1+PZ3ngOMfCe1VDiZ/PqnNrWJwxAhzmZ9a
 8QgHWDT5yQkk5K/x6Rp+OOsGHaHzLpfWrs2JU/eHjAYIR3lYsdWUQ7EWzh46iy2uH6mT3WNYSQ+
 XR87TJeJiTqojCcpCaBD2i23Bay9WprNFF95mE1sVJ
X-Gm-Gg: AY/fxX4Rpn9PeYxW/CMSVPveNmw4HVl0+8TQFDT4X0gYs6ZO0DJv1uKVfRsKRC0ldhd
 Vl/3f3vrYH9UCcr67pIz1D2ByANZaftXqMxHzdZNIsRZfNVGk2WAsJIUH1iuUUJS2FYoroZv92F
 t+TjrnqPk958JzsUYc6sMDM14OMAQDjVlT6TAR8CCcW44togarnmDaZqVWeamTaFM9V/W5Wiiot
 nLGU3dueOxbIeDax/TSAJNfdcyNF3rscUA/Vtm/Akg72Hh7zXelwHAimkF5MoX90Xu2z8kVSsbG
 PCoyQTUi6Vld6Jd5njgaGsPFjMd8/LtyPnDZ32jRivbxnr2+DhVLJVi2r//9nnjHBc5FTwlkGNj
 +oatjmwhgQA0kwTCxvRteda3n/PCunxddyx/xl8E6bcI/W3yEomQE10hOxAoOq2lgqYghatwpsx
 BIG7fc06m9LGOiTrE=
X-Received: by 2002:a05:6000:25c8:b0:430:fdc8:8be3 with SMTP id
 ffacd0b85a97d-4324e4f938fmr30133575f8f.29.1766827093796; 
 Sat, 27 Dec 2025 01:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzo3YNrl9fvsEexixfKvLP8kTB+O1gGU0JaiOoOOwBNUBxPnNeEofUdeB8W2QAZqdXXD2y3A==
X-Received: by 2002:a05:6000:25c8:b0:430:fdc8:8be3 with SMTP id
 ffacd0b85a97d-4324e4f938fmr30133543f8f.29.1766827093273; 
 Sat, 27 Dec 2025 01:18:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08efsm50446158f8f.29.2025.12.27.01.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 057/153] rust/hpet: Make global register accessors as methods
 of HPETRegisters
Date: Sat, 27 Dec 2025 10:14:44 +0100
Message-ID: <20251227091622.20725-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Link: https://lore.kernel.org/r/20251113051937.4017675-14-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 60 ++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index bf9f4936718..da938f356e9 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -280,7 +280,10 @@ fn get_state(&self) -> &HPETState {
     }
 
     fn is_int_active(&self) -> bool {
-        self.get_state().is_timer_int_active(self.index.into())
+        self.get_state()
+            .regs
+            .borrow()
+            .is_timer_int_active(self.index.into())
     }
 
     /// calculate next value of the general counter that matches the
@@ -299,7 +302,7 @@ fn calculate_cmp64(&self, cur_tick: u64, target: u64) -> u64 {
     }
 
     fn get_int_route(&self) -> usize {
-        if self.index <= 1 && self.get_state().is_legacy_mode() {
+        if self.index <= 1 && self.get_state().regs.borrow().is_legacy_mode() {
             // If LegacyReplacement Route bit is set, HPET specification requires
             // timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
             // timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
@@ -326,7 +329,7 @@ fn get_int_route(&self) -> usize {
     fn set_irq(&self, set: bool) {
         let route = self.get_int_route();
 
-        if set && self.regs.is_int_enabled() && self.get_state().is_hpet_enabled() {
+        if set && self.regs.is_int_enabled() && self.get_state().regs.borrow().is_hpet_enabled() {
             if self.regs.is_fsb_route_enabled() {
                 // SAFETY:
                 // the parameters are valid.
@@ -425,7 +428,7 @@ fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
             self.period = u64::from(self.period as u32); // truncate!
         }
 
-        if self.get_state().is_hpet_enabled() {
+        if self.get_state().regs.borrow().is_hpet_enabled() {
             self.set_timer();
         }
     }
@@ -456,7 +459,7 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         }
 
         self.regs.clear_valset();
-        if self.get_state().is_hpet_enabled() {
+        if self.get_state().regs.borrow().is_hpet_enabled() {
             self.set_timer();
         }
     }
@@ -540,6 +543,20 @@ pub struct HPETRegisters {
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
@@ -587,18 +604,6 @@ const fn has_msi_flag(&self) -> bool {
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
@@ -608,13 +613,14 @@ fn get_ns(&self, tick: u64) -> u64 {
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
@@ -697,7 +703,8 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
 
     /// Main Counter Value Register
     fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
-        if self.is_hpet_enabled() {
+        let mut regs = self.regs.borrow_mut();
+        if regs.is_hpet_enabled() {
             // HPET spec says that writes to this register should only be
             // done while the counter is halted. So this is an undefined
             // behavior. There's no need to forbid it, but when HPET is
@@ -706,7 +713,6 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
             // not be changed as well).
             trace::trace_hpet_ram_write_counter_write_while_enabled();
         }
-        let mut regs = self.regs.borrow_mut();
         regs.counter = regs.counter.deposit(shift, len, val);
     }
 
@@ -825,10 +831,11 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
             Global(CFG) => self.regs.borrow().config,
             Global(INT_STATUS) => self.regs.borrow().int_status,
             Global(COUNTER) => {
-                let cur_tick = if self.is_hpet_enabled() {
+                let regs = self.regs.borrow();
+                let cur_tick = if regs.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
-                    self.regs.borrow().counter
+                    regs.counter
                 };
 
                 trace::trace_hpet_ram_read_reading_counter((addr & 4) as u8, cur_tick);
@@ -860,8 +867,9 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
     }
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
-        if self.is_hpet_enabled() {
-            self.regs.borrow_mut().counter = self.get_ticks();
+        let mut regs = self.regs.borrow_mut();
+        if regs.is_hpet_enabled() {
+            regs.counter = self.get_ticks();
         }
 
         /*
@@ -896,7 +904,7 @@ fn is_rtc_irq_level_needed(&self) -> bool {
     }
 
     fn is_offset_needed(&self) -> bool {
-        self.is_hpet_enabled() && self.hpet_offset_saved
+        self.regs.borrow().is_hpet_enabled() && self.hpet_offset_saved
     }
 
     fn validate_num_timers(&self, _version_id: u8) -> bool {
-- 
2.52.0


