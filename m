Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4EFE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRk-0008RR-VF; Sat, 27 Dec 2025 04:18:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRb-0007PD-3F
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRZ-0004Bh-4G
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJg73JCP5bk90I6eF87pOlmwqjr/KR3OYSz/2lMy7Lo=;
 b=A1jRbETd/SILeAf+9rl+Lm03V0iZUvplZs/vlbfpb5UQ2wb3gKe1RgdFfiUmfrDb8LEJyN
 RgRHjHCdsMpY9IAjgkJLUWBiuQWGy8ET14VsEyrBsCqGp4prLy3XT6NkesFdG0Fwur/ZWc
 GKD+duX7T6mE40IwbcCFIV5VORW+v8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84--IIT5waaMqWW5_FA3yzWwA-1; Sat, 27 Dec 2025 04:18:33 -0500
X-MC-Unique: -IIT5waaMqWW5_FA3yzWwA-1
X-Mimecast-MFC-AGG-ID: -IIT5waaMqWW5_FA3yzWwA_1766827113
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so73398945e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827112; x=1767431912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xJg73JCP5bk90I6eF87pOlmwqjr/KR3OYSz/2lMy7Lo=;
 b=KY9tad2y4nmqWF4zgMWb7VMJBeWiMIP3nQ+IGgCLyXrGB8giHY7Ga7R4eAxnCnKESb
 oQ09ZzSJet9SBCbH9vHtkXfGpiz7CRhn5KJcjXH98hsXPlFIMHp9vyIulIHKDxd2Z2WO
 kxVZ5RpPkRQ/OmstUS4SAxfWxlyxSaTBsU0VpnogUieOpE0Mut6aXZG+yk93Eb3cDLig
 dysxZXQoqX1AM8kZm3zSNTJ0gsueFACr96lYKfmMbThrNkdb6XwHeACndS5Jc5rhBNVZ
 v5UGKiKAsd/Tj2AJSCidn2UTeqaptQqIUWyioGkaW9RdqNGOeg5MgUnpO+uyYO03LK5K
 o5ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827112; x=1767431912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xJg73JCP5bk90I6eF87pOlmwqjr/KR3OYSz/2lMy7Lo=;
 b=YJWBRnPR8MpxGsuTy1ahjUYwep2XCC9b3OL2dgUTbbOKVkxNugogP13uOBSPvLSCac
 OhzzPMi5oQTOIQ6P0+ilYlcnP+DKYH2e6VqmAhNnooJabXmczW3fLUqajPsGk8vcsJ6x
 fiShrLKUUqrEqOnaY3/GlQyeJdPIy/OfpHd0xTIkOicn3vNfJGMHnKKVIUPRB+BuiMFN
 gl1Wf3kboGXflQSivTgGDARVp2ZRQTE/blniBzI0EjBom5/j9LVtWc7NS2C7biVqtt9v
 a5ae9YvXxmuu1WR7jPgDRfHsLYoYZdVhg2ZYZm+76CAzZADrnrkNNlt2g9EeBqgAk7kV
 Z2Tw==
X-Gm-Message-State: AOJu0YxxTOueZkmCejK9gqB9t+t5uwTgFWmjrC3/2P4xcymjcrASn/Iz
 oQwyqu88Z4HrNjGFkW3O7K/K02swERAJjB9urXlmJjYllw6BzXNuO119JkNSL+N3BSwxUJ6QB3W
 lFiWRZlheI8p1e0i02/JohNFdB0cvi3zvSjPxerxzlHXJpLGgnLc3ZXQpcj16nOH3TVv4JtZlHp
 VdswxkbEDja2r2P7rsL9A84dpMQDo3AaTrV2TGUQ8b
X-Gm-Gg: AY/fxX5h4WbgS0zyTwYP4JpakVkqraXnl41Gzo+ezc7YgcYGn5RYGiYnWj46jQretGu
 0+PukbeOW9Yr84CJxZoNvwfy8X3l6Ix1AAGtCy5xsbky0yVI2UioG2AgaaFAgc8g56WgHAkEzc5
 cIMMzuRLhbX+hsAP5BjKJzUp7Ie9ymuYrAXJahWDUu4VpFdmTwnJ+esQIbOA75Nom9CvNvRSeoX
 luuSKa2mC2RnZmVeeruVEbL4g+Qjbtr8J5rQCil4IHGl87ElomqCmCvC8MEQVvPIKQWjGfGzpuq
 /8MjpTON0PnqGSAx+e2QClfAM1rqjFItNjXPUjo53MMAg+YrUg7hYeBtHSkFs+35afPeVRrUhOb
 hKZ7RaQpBUghHUUdarNIxbzB8kQzkE9NU1jkzxpoZMCPEyPSZzFIczIyO0e2l/2uK7atSUIYXpc
 +yeVCg5KFsztkKzXA=
X-Received: by 2002:a05:600c:1385:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-47d3a5f47b3mr133615155e9.7.1766827111893; 
 Sat, 27 Dec 2025 01:18:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH16AAAEs8WOB3izfhztSHCIKz03DbffUWBXBoaojP8vqKu2zBDnjrrWhqPVWUjKhV2d8RZmw==
X-Received: by 2002:a05:600c:1385:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-47d3a5f47b3mr133614875e9.7.1766827111446; 
 Sat, 27 Dec 2025 01:18:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193621c8sm429301655e9.7.2025.12.27.01.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 065/153] rust/hpet: move hpet_offset to HPETRegisters
Date: Sat, 27 Dec 2025 10:14:52 +0100
Message-ID: <20251227091622.20725-66-pbonzini@redhat.com>
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

Likewise, do not separate hpet_offset from the other registers.
However, because it is migrated in a subsection it is necessary
to copy it out of HPETRegisters and into a BqlCell<>.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 69 ++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 0dbfc5b3bab..41d5c8fea0e 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -362,8 +362,9 @@ fn update_irq(&self, regs: &mut HPETRegisters, set: bool) {
         self.set_irq(regs, set);
     }
 
-    fn arm_timer(&self, tn_regs: &mut HPETTimerRegisters, tick: u64) {
-        let mut ns = self.get_state().get_ns(tick);
+    fn arm_timer(&self, regs: &mut HPETRegisters, tick: u64) {
+        let mut ns = regs.get_ns(tick);
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
 
         // Clamp period to reasonable min value (1 us)
         if tn_regs.is_periodic() && ns - tn_regs.last < 1000 {
@@ -375,21 +376,22 @@ fn arm_timer(&self, tn_regs: &mut HPETTimerRegisters, tick: u64) {
     }
 
     fn set_timer(&self, regs: &mut HPETRegisters) {
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
@@ -506,10 +508,10 @@ fn reset(&self, regs: &mut HPETRegisters) {
 
     /// timer expiration callback
     fn callback(&self, regs: &mut HPETRegisters) {
+        let cur_tick: u64 = regs.get_ticks();
         let tn_regs = &mut regs.tn_regs[self.index as usize];
-        let cur_tick: u64 = self.get_state().get_ticks();
 
-        if tn_regs.is_periodic() && tn_regs.period != 0 {
+        let next_tick = if tn_regs.is_periodic() && tn_regs.period != 0 {
             while hpet_time_after(cur_tick, tn_regs.cmp64) {
                 tn_regs.cmp64 += tn_regs.period;
             }
@@ -518,10 +520,16 @@ fn callback(&self, regs: &mut HPETRegisters) {
             } else {
                 tn_regs.cmp = tn_regs.cmp64;
             }
-            self.arm_timer(tn_regs, tn_regs.cmp64);
+            Some(tn_regs.cmp64)
         } else if tn_regs.wrap_flag != 0 {
             tn_regs.wrap_flag = 0;
-            self.arm_timer(tn_regs, tn_regs.cmp64);
+            Some(tn_regs.cmp64)
+        } else {
+            None
+        };
+
+        if let Some(tick) = next_tick {
+            self.arm_timer(regs, tick);
         }
         self.update_irq(regs, true);
     }
@@ -573,9 +581,20 @@ pub struct HPETRegisters {
 
     /// HPET Timer N Registers
     tn_regs: [HPETTimerRegisters; HPET_MAX_TIMERS],
+
+    /// Offset of main counter relative to qemu clock.
+    pub hpet_offset: u64,
 }
 
 impl HPETRegisters {
+    fn get_ticks(&self) -> u64 {
+        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset)
+    }
+
+    fn get_ns(&self, tick: u64) -> u64 {
+        ticks_to_ns(tick) - self.hpet_offset
+    }
+
     fn is_legacy_mode(&self) -> bool {
         self.config & (1 << HPET_CFG_LEG_RT_SHIFT) != 0
     }
@@ -603,8 +622,7 @@ pub struct HPETState {
     #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT, default = false)]
     flags: u32,
 
-    /// Offset of main counter relative to qemu clock.
-    hpet_offset: BqlCell<u64>,
+    hpet_offset_migration: BqlCell<u64>,
     #[property(rename = "hpet-offset-saved", default = true)]
     hpet_offset_saved: bool,
 
@@ -636,14 +654,6 @@ const fn has_msi_flag(&self) -> bool {
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
@@ -682,8 +692,7 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
 
         if activating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Enable main counter and interrupt generation.
-            self.hpet_offset
-                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
+            regs.hpet_offset = ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns();
 
             for t in self.timers.iter().take(self.num_timers) {
                 let id = t.index as usize;
@@ -696,7 +705,7 @@ fn set_cfg_reg(&self, regs: &mut HPETRegisters, shift: u32, len: u32, val: u64)
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            regs.counter = self.get_ticks();
+            regs.counter = regs.get_ticks();
 
             for t in self.timers.iter().take(self.num_timers) {
                 t.del_timer(regs);
@@ -763,7 +772,7 @@ unsafe fn init(mut this: ParentInit<Self>) {
         // initialized memory to all zeros - simple types (bool/u32/usize) can
         // rely on this without explicit initialization.
         uninit_field_mut!(*this, regs).write(Default::default());
-        uninit_field_mut!(*this, hpet_offset).write(Default::default());
+        uninit_field_mut!(*this, hpet_offset_migration).write(Default::default());
         // Set null_mut for now and post_init() will fill it.
         uninit_field_mut!(*this, irqs).write(Default::default());
         uninit_field_mut!(*this, rtc_irq_level).write(Default::default());
@@ -814,6 +823,7 @@ fn reset_hold(&self, _type: ResetType) {
 
         regs.counter = 0;
         regs.config = 0;
+        regs.hpet_offset = 0;
         HPETFwConfig::update_hpet_cfg(
             self.hpet_id.get(),
             regs.capability as u32,
@@ -826,7 +836,6 @@ fn reset_hold(&self, _type: ResetType) {
         drop(regs);
 
         self.pit_enabled.set(true);
-        self.hpet_offset.set(0);
 
         // to document that the RTC lowers its output on reset as well
         self.rtc_irq_level.set(0);
@@ -871,7 +880,7 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
             Global(INT_STATUS) => regs.int_status,
             Global(COUNTER) => {
                 let cur_tick = if regs.is_hpet_enabled() {
-                    self.get_ticks()
+                    regs.get_ticks()
                 } else {
                     regs.counter
                 };
@@ -907,8 +916,9 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
         let mut regs = self.regs.borrow_mut();
+        self.hpet_offset_migration.set(regs.hpet_offset);
         if regs.is_hpet_enabled() {
-            regs.counter = self.get_ticks();
+            regs.counter = regs.get_ticks();
         }
 
         /*
@@ -933,9 +943,10 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
 
         // Recalculate the offset between the main counter and guest time
         if !self.hpet_offset_saved {
-            self.hpet_offset
+            self.hpet_offset_migration
                 .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
         }
+        regs.hpet_offset = self.hpet_offset_migration.get();
 
         Ok(())
     }
@@ -987,7 +998,7 @@ impl ObjectImpl for HPETState {
         .minimum_version_id(1)
         .needed(&HPETState::is_offset_needed)
         .fields(vmstate_fields! {
-            vmstate_of!(HPETState, hpet_offset),
+            vmstate_of!(HPETState, hpet_offset_migration),
         })
         .build();
 
-- 
2.52.0


