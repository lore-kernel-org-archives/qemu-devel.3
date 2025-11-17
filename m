Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4FBCEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKuuC-00046Q-Ab; Mon, 17 Nov 2025 03:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuu9-00044C-Hz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKuu7-00071R-EZ
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmfGcUcX6SbGzzDYoFBngcqcgk8heYgOyWXNHnYO7GU=;
 b=BWaLFOKPZpgHIdpJuJTri8hkCf9dRJXEyE3YV6fE53BE9UmNZ/GOWEhqJKGsUrjNrCde8L
 UFlIr+7ONmCu+MQeag91dfbEwCeB5WG0qAPRwiKh2lSdUgvdL2MeV5lVO9UOXTdJ3Qakwf
 aSWtCS1EJ/tDK6gtkk5FTDBbAxnvUss=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-3s7R7A5UMEyfyf8v_PWCQw-1; Mon, 17 Nov 2025 03:48:03 -0500
X-MC-Unique: 3s7R7A5UMEyfyf8v_PWCQw-1
X-Mimecast-MFC-AGG-ID: 3s7R7A5UMEyfyf8v_PWCQw_1763369282
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so10531365e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 00:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763369281; x=1763974081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hmfGcUcX6SbGzzDYoFBngcqcgk8heYgOyWXNHnYO7GU=;
 b=n26Lq/6jdb86iWC/lXlYXi+YS845dGzCqpV4wbF7q6MSKRUm6XoCgTvUrGTlwV0m3M
 eAKZTWV6B1XpvpVMQtqO/hgyu3ceXYSPbWZRlqSlY13pnZ/D4V2AMpbrHUHxpdvR6Zuh
 IRhOx3Ye7/FInSOKRsL1PmNdg6LKtBDTJyDwtaoyqDIFIQOsx2KQpw+Vm4+W6LtUjlda
 9qWVnZvRbmcZaHmK9mE3Nuc05MJWaD6QsSIZU9Svj890tXQ+qU++aZ2c4Yyqg/Xxtw5R
 EOdVWsb9FAJzO+CtmT+BChrW46JNYkPRzjiRX7Jd4idaaZEofUnWxdqtFLQKIzuYDFkn
 +E5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369281; x=1763974081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hmfGcUcX6SbGzzDYoFBngcqcgk8heYgOyWXNHnYO7GU=;
 b=a65jP2bRqEQVJ4JGSbmPepT+qJHJgv7NoP9xQfcCDB4QYIqT5k0LjK17r7cAzRfJx3
 dyKkJ/8eLQLMd6b3es5Ktfyvo0YYnyPbLeV8iW/nxBW5WxVIqvzUUJOnrJsc0Oxp1/F2
 +9urimTY7I53yiP+uVGYhcjatgCVGkhxe+OaHlhQemkOi692U5olLSG4jBbdksaamyAd
 Fb6llriU6YhOlBOWtniBmf+/d+d6+kzTEmu5RH4jQln58CiTGsWRFr/276cK7B9kzXZJ
 Ff6Xt5kX/iv9eOLpvq7GhyIVlVKab1LneBxM79hKcX1ERf9XfJba2kr6CG0g9WRiet2K
 WUVA==
X-Gm-Message-State: AOJu0YzXTw0saIA5ZX4VtFMsETAvtBUIgLFMt4JKK+6A/74c+ThFza4M
 g3y+/6Duf7ROSrBcE8cjEZmJxfbWbV1xE/g18KKHSQgeL+wPv+XQAJLVj31l6oodU9mj/HKLw7b
 btlZHdnP0ONN/Cvz6fcL0H7cLq2zPcBjCRchKzWruSneXTa1bcq5WB1C/BxCgLS+4tqJMqoLaaN
 Dd6mfXxh9sgeFejTD3LB+tU0Z2z/JKXxQ7yA7W4aU/
X-Gm-Gg: ASbGnct//g7veYGHhHJKLSphQfqb6kMg6d8giY6//d4g+4kGJeoXE5kSNeMqcMy0MJn
 WjFgLkrkE1Ohow6b06MI+fbX95U3+WUfK4CRbpwOYY9V3EWpcDy6Hvh0tPZjHdeymLngz9LUV5N
 XQuHOeIReDrOCEvIr04L06/eZLR/zRoygMUFX/wt4nBEvI4du5g1jUOnXyPet58JYovz+I7xIIe
 WQBNvx51oMAnCiTXoHPGmSmz9ytbuCsXs6U0Z3hqpL3yse6K6AWtkncUnOzUKBuDVQqHgw1u6GY
 OKidYWtFQOLlnkQstUNklJaD7JKtJ1X12D9IcRkCIxR6MiR4XF0qorxchsB16adxSTwBQW/JOhQ
 DHsECoMouda2sUeHBUzOUEahAOt1Kyu756o+E6fiaIMj02f5vSaL4Fv+nY6U5h7Yvmf8KQrX16E
 ZSTQEu
X-Received: by 2002:a05:600c:8b4c:b0:477:7f4a:44ba with SMTP id
 5b1f17b1804b1-4778fe60072mr91365475e9.4.1763369281484; 
 Mon, 17 Nov 2025 00:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4RnIczh/+SFD3CcfUVb3uKUYsCASYYfuBGZiETyuF4yws/fukm0fcfrZaWn8D0q4lwww3MA==
X-Received: by 2002:a05:600c:8b4c:b0:477:7f4a:44ba with SMTP id
 5b1f17b1804b1-4778fe60072mr91365105e9.4.1763369280698; 
 Mon, 17 Nov 2025 00:48:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779fab9b0esm76902095e9.12.2025.11.17.00.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 00:47:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 2/5] rust/hpet: move hpet_offset to HPETRegisters
Date: Mon, 17 Nov 2025 09:47:49 +0100
Message-ID: <20251117084752.203219-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117084752.203219-1-pbonzini@redhat.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Likewise, do not separate hpet_offset from the other registers.
However, because it is migrated in a subsection it is necessary
to copy it out of HPETRegisters and into a BqlCell<>.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 63 ++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 79d818b43da..19676af74bc 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -383,14 +383,15 @@ fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
         self.set_irq(regs, set);
     }
 
-    fn arm_timer(&self, tn_regs: &mut HPETTimerRegisters, tick: u64) {
+    fn arm_timer(&self, regs: &mut HPETRegisters, tick: u64) {
         // &HPETRegisters should be gotten from BqlRefCell<HPETRegisters>,
         // but there's no lock guard to guarantee this. So we have to check BQL
         // context explicitly. This check should be removed when we switch to
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
-        let mut ns = self.get_state().get_ns(tick);
+        let mut ns = regs.get_ns(tick);
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
 
         // Clamp period to reasonable min value (1 us)
         if tn_regs.is_periodic() && ns - tn_regs.last < 1000 {
@@ -408,21 +409,22 @@ fn set_timer(&self, regs: &mut HPETRegisters) {
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
+        let cur_tick: u64 = regs.get_ticks();
         let tn_regs = &mut regs.tn_regs[self.index as usize];
-        let cur_tick: u64 = self.get_state().get_ticks();
 
         tn_regs.wrap_flag = 0;
         tn_regs.update_cmp64(cur_tick);
+
+        let mut next_tick: u64 = tn_regs.cmp64;
         if tn_regs.is_32bit_mod() {
             // HPET spec says in one-shot 32-bit mode, generate an interrupt when
             // counter wraps in addition to an interrupt with comparator match.
             if !tn_regs.is_periodic() && tn_regs.cmp64 > hpet_next_wrap(cur_tick) {
                 tn_regs.wrap_flag = 1;
-                self.arm_timer(tn_regs, hpet_next_wrap(cur_tick));
-                return;
+                next_tick = hpet_next_wrap(cur_tick);
             }
         }
-        self.arm_timer(tn_regs, tn_regs.cmp64);
+        self.arm_timer(regs, next_tick);
     }
 
     fn del_timer(&self, regs: &mut HPETRegisters) {
@@ -584,8 +586,8 @@ fn callback(&self, regs: &mut HPETRegisters) {
         // Mutex<HPETRegisters>.
         assert!(bql::is_locked());
 
+        let cur_tick: u64 = regs.get_ticks();
         let tn_regs = &mut regs.tn_regs[self.index as usize];
-        let cur_tick: u64 = self.get_state().get_ticks();
 
         if tn_regs.is_periodic() && tn_regs.period != 0 {
             while hpet_time_after(cur_tick, tn_regs.cmp64) {
@@ -596,11 +598,11 @@ fn callback(&self, regs: &mut HPETRegisters) {
             } else {
                 tn_regs.cmp = tn_regs.cmp64;
             }
-            self.arm_timer(tn_regs, tn_regs.cmp64);
         } else if tn_regs.wrap_flag != 0 {
             tn_regs.wrap_flag = 0;
-            self.arm_timer(tn_regs, tn_regs.cmp64);
         }
+        let next_tick = tn_regs.cmp64;
+        self.arm_timer(regs, next_tick);
         self.update_irq(regs, true);
     }
 
@@ -663,9 +665,22 @@ pub struct HPETRegisters {
 
     /// HPET Timer N Registers
     tn_regs: [HPETTimerRegisters; HPET_MAX_TIMERS],
+
+    /// Offset of main counter relative to qemu clock.
+    pub hpet_offset: u64,
 }
 
 impl HPETRegisters {
+    fn get_ticks(&self) -> u64 {
+        // Protect hpet_offset in lockless IO case which would not lock BQL.
+        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset)
+    }
+
+    fn get_ns(&self, tick: u64) -> u64 {
+        // Protect hpet_offset in lockless IO case which would not lock BQL.
+        ticks_to_ns(tick) - self.hpet_offset
+    }
+
     fn is_legacy_mode(&self) -> bool {
         self.config & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
     }
@@ -693,8 +708,7 @@ pub struct HPETState {
     #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT, default = false)]
     flags: u32,
 
-    /// Offset of main counter relative to qemu clock.
-    hpet_offset: BqlCell<u64>,
+    hpet_offset_migration: BqlCell<u64>,
     #[property(rename = "hpet-offset-saved", default = true)]
     hpet_offset_saved: bool,
 
@@ -726,14 +740,6 @@ const fn has_msi_flag(&self) -> bool {
         self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
     }
 
-    fn get_ticks(&self) -> u64 {
-        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset.get())
-    }
-
-    fn get_ns(&self, tick: u64) -> u64 {
-        ticks_to_ns(tick) - self.hpet_offset.get()
-    }
-
     fn handle_legacy_irq(&self, irq: u32, level: u32) {
         let regs = self.regs.borrow();
         if irq == HPET_LEGACY_PIT_INT {
@@ -779,8 +785,7 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
 
         if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Enable main counter and interrupt generation.
-            self.hpet_offset
-                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
+            regs.hpet_offset = ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 let t = timer.borrow();
@@ -794,7 +799,7 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            regs.counter = self.get_ticks();
+            regs.counter = regs.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow().del_timer(regs);
@@ -873,7 +878,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
         // initialized memory to all zeros - simple types (bool/u32/usize) can
         // rely on this without explicit initialization.
         uninit_field_mut!(*this, regs).write(Default::default());
-        uninit_field_mut!(*this, hpet_offset).write(Default::default());
+        uninit_field_mut!(*this, hpet_offset_migration).write(Default::default());
         // Set null_mut for now and post_init() will fill it.
         uninit_field_mut!(*this, irqs).write(Default::default());
         uninit_field_mut!(*this, rtc_irq_level).write(Default::default());
@@ -929,6 +934,7 @@ fn reset_hold(&self, _type: ResetType) {
 
             regs.counter = 0;
             regs.config = 0;
+            regs.hpet_offset = 0;
             HPETFwConfig::update_hpet_cfg(
                 self.hpet_id.get(),
                 regs.capability as u32,
@@ -937,7 +943,6 @@ fn reset_hold(&self, _type: ResetType) {
         }
 
         self.pit_enabled.set(true);
-        self.hpet_offset.set(0);
 
         // to document that the RTC lowers its output on reset as well
         self.rtc_irq_level.set(0);
@@ -982,7 +987,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
             Global(INT_STATUS) => regs.int_status,
             Global(COUNTER) => {
                 let cur_tick = if regs.is_hpet_enabled() {
-                    self.get_ticks()
+                    regs.get_ticks()
                 } else {
                     regs.counter
                 };
@@ -1018,8 +1023,9 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
         let mut regs = self.regs.borrow_mut();
+        self.hpet_offset_migration.set(regs.hpet_offset);
         if regs.is_hpet_enabled() {
-            regs.counter = self.get_ticks();
+            regs.counter = regs.get_ticks();
         }
 
         /*
@@ -1044,9 +1050,10 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
 
         // Recalculate the offset between the main counter and guest time
         if !self.hpet_offset_saved {
-            self.hpet_offset
+            self.hpet_offset_migration
                 .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
         }
+        regs.hpet_offset = self.hpet_offset_migration.get();
 
         Ok(())
     }
@@ -1098,7 +1105,7 @@ impl ObjectImpl for HPETState {
         .minimum_version_id(1)
         .needed(&HPETState::is_offset_needed)
         .fields(vmstate_fields! {
-            vmstate_of!(HPETState, hpet_offset),
+            vmstate_of!(HPETState, hpet_offset_migration),
         })
         .build();
 
-- 
2.51.1


