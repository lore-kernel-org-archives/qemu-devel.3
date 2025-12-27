Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1416E8FDD9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRW-000778-J0; Sat, 27 Dec 2025 04:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRH-0006nc-Lf
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRF-0003gH-L0
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEQp1QeOCaVuElqN45AAQIvtGjAtReoau7wTk87mvLg=;
 b=RxXZcXM8OPrarMlQ2YoVwLeOJvAL+3MrQjCEzOaz6/ZyMSx4ki+fjDYYXvAghJ+dCLwB1O
 azBPnLvVHzXeujw4tchkeYgO0u5aTDx3uF69yaYNJHl9YswuhnAECBSH3dA4J4KOLkOUcw
 iMWENRJzybYm83EqmIJEZQrIe6l5Jmk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-92FXTLBdPjyNdWhjYtJESg-1; Sat, 27 Dec 2025 04:18:14 -0500
X-MC-Unique: 92FXTLBdPjyNdWhjYtJESg-1
X-Mimecast-MFC-AGG-ID: 92FXTLBdPjyNdWhjYtJESg_1766827093
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4327778efa9so1318090f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827093; x=1767431893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEQp1QeOCaVuElqN45AAQIvtGjAtReoau7wTk87mvLg=;
 b=O2X7doFI/alP+e97FJzVfieaGXpKF6BmAaXIstdHS5PTwvrgxmrx/B7oCM8FoY6OVg
 mcGz87qP0effSXqASFKhg0sztE9DljoPsbXrPdyETpxcenAFe4u/f4vFznhjamoXZ0qR
 qYpncM2/j1VsVMtC92nSQX+6X/TjAFOXz+2ugNwKkf5f/EIjJHViEBJRH2tt4AoIDd8I
 UDC5fVVvMqR7K7uocDclTDe4zyThQqI938G7LGNj2rUcZbRN87dxibH65R0b2UaMWJG5
 y2goXk93fPVoS+TBS2tv3RHDcPAevpMTPZjTGzyE2/TR44c5DTpcsrzjQiQgPkiLJhiW
 Vr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827093; x=1767431893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FEQp1QeOCaVuElqN45AAQIvtGjAtReoau7wTk87mvLg=;
 b=S6TN/DByYOQ3dYBKBFpu+fJQuIQ2gym+xd2A+Mnq6eA0S/6PepxeYPJmuMmk3CMmuO
 22Uw51ZQ64prUZvAWpTrXI75LSzGs/OXihU7QnE8sNIzm/UEZpLEQmivzdRERHCBorn0
 1sUiW8KxfwhGDuYL5chlDWReGNEld17o7Uo6tGAa93VbpSaU1FeZ4JzZdwyxKtgiLP2M
 HrkbbvI6Jxk317Vtp/+OmhprM+QONNABEyJNLUqklcuXiat+KGUl/zVTe8SKk2GSoqlz
 zL48e11CD9YsJ3ooZ4w2BJU7JiWt20LMr3dGMWXwRmWifWunSGFCe2khM2mgJcfZ+5dL
 0YpA==
X-Gm-Message-State: AOJu0YzGlQAr1xaeXC+JYZAcPRLLpZwzI54be5DV55Mt1GKoiC2Mp4QG
 1OaQiXl0jT0zehUrJOEMLNO5qxeaqS7A71FqVmVTbPlT1KLy3VBs2htoRqug6NkJmMeI9/+tlZg
 8UTqIn06ddxGs5X3kJEENUYcjhOUgu7QrArfqBcFoYD34Wh3Kjxq+HUKvMQEXMoQRxrwAu9th2n
 N5h79qbbpmKJj97lI4Iaxn/FlavwyZbQqeTotIOYe3
X-Gm-Gg: AY/fxX7p1GEmqPIc1v3vREnrvNFCrVyOXEvKNyMldVKKtsYkF3mpnyNtZy146LE6dqR
 YF3Mx3Xdz7HyxOR5O5GZ/SzPuoOYxVINujqhQPJuxkD2XojMAGIIigMx9Hfjy3kXxWBjNXpzhLO
 PwsSskI6H2pCyHcegziv1roMSGPvkWW4wSB/DKvkyfYESnnCS0dNFOiHtvGUWIeBnQ/JkOdhaVJ
 PvulDO2aPT9Hos4VbAZs9c6KSY+kOCtBbpXP4+hkIExca8LWfkd0GqWoyjKMjq+KrZtAQUa8U/o
 ipv85EXWLiDNvEJOgNQSmMUNiL5vYHaakiUZ69fllRTdD3X9xwI3h3xLCeMKSbwPtAWe05/Rb+R
 zkcBm+ALoQgQV/PwnbuU36pYaU5T10ulFKnuNodkTFAJih2wt3aDQzlWYpNABziuMzFH+BlHmUJ
 HQJAHkhB/OiIm45Z4=
X-Received: by 2002:a05:6000:2285:b0:430:fafd:f1d2 with SMTP id
 ffacd0b85a97d-4324e4c6848mr32383803f8f.11.1766827092713; 
 Sat, 27 Dec 2025 01:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO48PlqlieWihndh+EVkuTjcBEF8YXPXM6OWzbBD5XGzvQ6djlsm8DEl4voz3u8TsjR3UJBg==
X-Received: by 2002:a05:6000:2285:b0:430:fafd:f1d2 with SMTP id
 ffacd0b85a97d-4324e4c6848mr32383771f8f.11.1766827092196; 
 Sat, 27 Dec 2025 01:18:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea226d1sm50703204f8f.13.2025.12.27.01.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 056/153] rust/hpet: Abstract HPETRegisters struct
Date: Sat, 27 Dec 2025 10:14:43 +0100
Message-ID: <20251227091622.20725-57-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20251113051937.4017675-13-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 116 +++++++++++++++++++------------
 1 file changed, 70 insertions(+), 46 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 8dc3cc59c98..bf9f4936718 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -524,24 +524,29 @@ fn write(&mut self, target: TimerRegister, value: u64, shift: u32, len: u32) {
     }
 }
 
+#[repr(C)]
+#[derive(Default)]
+pub struct HPETRegisters {
+    // HPET block Registers: Memory-mapped, software visible registers
+    /// General Capabilities and ID Register
+    capability: u64,
+    ///  General Configuration Register
+    config: u64,
+    /// General Interrupt Status Register
+    #[doc(alias = "isr")]
+    int_status: u64,
+    /// Main Counter Value Register
+    #[doc(alias = "hpet_counter")]
+    counter: u64,
+}
+
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
 #[derive(qom::Object, hwcore::Device)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
-
-    // HPET block Registers: Memory-mapped, software visible registers
-    /// General Capabilities and ID Register
-    capability: BqlCell<u64>,
-    ///  General Configuration Register
-    config: BqlCell<u64>,
-    /// General Interrupt Status Register
-    #[doc(alias = "isr")]
-    int_status: BqlCell<u64>,
-    /// Main Counter Value Register
-    #[doc(alias = "hpet_counter")]
-    counter: BqlCell<u64>,
+    regs: BqlRefCell<HPETRegisters>,
 
     // Internal state
     /// Capabilities that QEMU HPET supports.
@@ -583,15 +588,15 @@ const fn has_msi_flag(&self) -> bool {
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
@@ -631,22 +636,22 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
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
@@ -658,7 +663,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             }
         } else if deactivating_bit(old_val, new_val, HPET_CFG_ENABLE_SHIFT) {
             // Halt main counter and disable interrupt generation.
-            self.counter.set(self.get_ticks());
+            self.regs.borrow_mut().counter = self.get_ticks();
 
             for timer in self.timers.iter().take(self.num_timers) {
                 timer.borrow().del_timer();
@@ -681,7 +686,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
     /// General Interrupt Status Register: Read/Write Clear
     fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
-        let cleared = new_val & self.int_status.get();
+        let cleared = new_val & self.regs.borrow().int_status;
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
@@ -701,8 +706,8 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
             // not be changed as well).
             trace::trace_hpet_ram_write_counter_write_while_enabled();
         }
-        self.counter
-            .set(self.counter.get().deposit(shift, len, val));
+        let mut regs = self.regs.borrow_mut();
+        regs.counter = regs.counter.deposit(shift, len, val);
     }
 
     unsafe fn init(mut this: ParentInit<Self>) {
@@ -745,14 +750,12 @@ fn realize(&self) -> util::Result<()> {
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
@@ -764,17 +767,23 @@ fn reset_hold(&self, _type: ResetType) {
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
@@ -812,14 +821,14 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
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
                 let cur_tick = if self.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
-                    self.counter.get()
+                    self.regs.borrow().counter
                 };
 
                 trace::trace_hpet_ram_read_reading_counter((addr & 4) as u8, cur_tick);
@@ -852,7 +861,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
 
     fn pre_save(&self) -> Result<(), migration::Infallible> {
         if self.is_hpet_enabled() {
-            self.counter.set(self.get_ticks());
+            self.regs.borrow_mut().counter = self.get_ticks();
         }
 
         /*
@@ -867,15 +876,16 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
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
@@ -966,6 +976,22 @@ impl ObjectImpl for HPETState {
 
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
@@ -974,9 +1000,7 @@ impl ObjectImpl for HPETState {
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
2.52.0


