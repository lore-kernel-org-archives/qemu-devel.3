Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A59E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRo-0000dV-Lk; Sat, 27 Dec 2025 04:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRm-0000IM-GN
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRk-0004H4-8w
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwyQTgzPobAZmx3kBA+jclwVD+zv80vSUor+sTPtx4s=;
 b=RNKrhmfrmg7jAAcYBTD4sAKuIEEjyoxcdsYhknfR3kCC+AJV7o6iYu5LYv9edoULLpMxKM
 ZFC+K4U7Af3RfV3jHXf3cG/i3pntRClXGb0ziMz5ioo68Khz9pqrngLl/AUEUYhbqqh5/T
 c2djDnIdNJqlQIf0RY9N/BCNXkutZXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-q3oZI9hlMoS1k0IpLxIKcg-1; Sat, 27 Dec 2025 04:18:39 -0500
X-MC-Unique: q3oZI9hlMoS1k0IpLxIKcg-1
X-Mimecast-MFC-AGG-ID: q3oZI9hlMoS1k0IpLxIKcg_1766827118
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so53227935e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827117; x=1767431917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwyQTgzPobAZmx3kBA+jclwVD+zv80vSUor+sTPtx4s=;
 b=HUFHC0PFQPW0gJ7T5HnFhrmRTN/8IgTuTX2VYINCUH717FigSM0bZDdEAYDRyvX8X/
 SRWVrUGyAhwN03zsldrUmvt72BHVj1SM9/l9K+DSA4m94ajaPKwQJe5Xir6BoAZ1OHBd
 MMHoIimJuXcaRsNfoDoDhm+6jiHyg9nReuL/Q29lTTJG8ioIbK90bOt77/XLA+sEF0hI
 ytqtid1KPecSdmg5ymG9HtQeGc+rsNSfj1LIx8Wi/SWJg9Tp0cRRgMcihhp+LKVwpZGE
 ECgmQ2ePQRCAnK/1Xfdsg8ogUvEeshhZGnmSPr+XC2rUULC61X4m4SZgJKxamqTYK0QF
 Aa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827117; x=1767431917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FwyQTgzPobAZmx3kBA+jclwVD+zv80vSUor+sTPtx4s=;
 b=Ai2yhHGPEj0HJUiEBBsipY+R3UFCoKTz+ln5sYgd9e0fsyOUNLQGSCL4NHoqfjtYMl
 LjKQ13a2zKh+jFK00CALfEFiuv6/DYjTmraH2Mgdmu2kjlJVTqJ1epyXbDomPqPBe71V
 65o+XXCNyyYSEcdggVLSO5ww8/b1jyd5w95SKIce524A1vW/0cCnWU1UkFVzSW+gEybV
 z59/OcK8GWNR9SIc0qO20+P8h1R1ln5h9v8JoGB24D8SpMbOKJXrBcVBt7KKbWmiJ8oc
 L6d+IRVsbhKhYReQRQalnCT94luAauCuGFUuQgPSh1nD+UOzNxmEr5ubKZfC7MtUWnKd
 +Qng==
X-Gm-Message-State: AOJu0YzsirSJl1yCMa1gZEL6zdRK0IRXB9uSI9Hyk3/EUKX663OVfdWM
 bs49v//Cdxb7NhGtlR+iboFMQAEHphnJVKX03irSTU7WbYwCQjaqwIYMKpkjlz6OLzDe2+B4Dv9
 eY3hABtdI00KNLyD96+5u7QQgAs6Dwl4nnrfhEfkZG0x9XOn0MqoMnJOUr3m/XhH5y9QIZySRCa
 qgfoiQE7OuMfX9yBtF2MIMTHV/Cf/KL/pHMpzdXT+S
X-Gm-Gg: AY/fxX5n4uKljJh0AMzlJIxEfrByeqLfRgwO9Hcx/H8zb0g6DI0vys95wk1+0uattMD
 /CllxGSLFlGxdja1/FHZ1LEo6V0vJIqTDvUr9EJchUK0+alYf7BoDb1R2mQhysIfmsDp9tT1DAd
 X9AunZOrv6artMMLt/UH/yg45Z2nY4e8Tbgd7rLnpUT/uG9UyDXdp6USlorCiuemVocXOsWryfP
 y9pPH8fnaJJG0uuEcvqMp+EmQGEpH2vc0rdzFCfPVKLncm/V8swHe/ysDKmRNqVFeBvMQ5LYnuF
 dovHSNdjjJOA6UWgeVnkOl6hAwoFzdnMu8GEA6KyoOuVPo2AiIZCZtY1OC5TgMFoZqu+Dv2si2s
 vQJTJiI7MiVj+nSM2xROX6VWzdavYhOkbreP7hTsF3kWuZwBCEwQmtIoHQzxPCsawYkAi7Od1OK
 Ng+NloDMogywSxNXE=
X-Received: by 2002:a05:600c:4d98:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-47be29f362amr218501555e9.16.1766827117112; 
 Sat, 27 Dec 2025 01:18:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC2A9ttI2vvn2d4GyHD6Rm2yvmZXTPTwLyOpqnEL/0hWFXItsVEC66hL0FWlWsHa1RPwEDiw==
X-Received: by 2002:a05:600c:4d98:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-47be29f362amr218501345e9.16.1766827116597; 
 Sat, 27 Dec 2025 01:18:36 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2278dsm50622918f8f.18.2025.12.27.01.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 068/153] rust/hpet: Apply Migratable<> wrapper and
 ToMigrationState
Date: Sat, 27 Dec 2025 10:14:55 +0100
Message-ID: <20251227091622.20725-69-pbonzini@redhat.com>
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

Before using Mutex<> to protect HPETRegisters, it's necessary to apply
Migratable<> wrapper and ToMigrationState first since there's no
pre-defined VMState for Mutex<>.

In addition, this allows to move data from HPETRegisters' vmstate
to HPETTimer's, so as to preserve the original migration format of the C
implementation.  To do that, HPETTimer is wrapped with Migratable<>
as well but the implementation of ToMigrationStateShared is
hand-written.

Note that even though the HPETRegistersMigration struct is
generated by ToMigrationState macro, its VMState still needs to be
implemented by hand.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20251113051937.4017675-21-zhao1.liu@intel.com
[Added HPETTimer implementation and restored compatible migration format. - Paolo]
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/hpet/src/device.rs | 139 +++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 37 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 375bea4c96b..a0c122d42bb 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -13,7 +13,7 @@
 use bql::prelude::*;
 use common::prelude::*;
 use hwcore::prelude::*;
-use migration::{self, prelude::*};
+use migration::{self, prelude::*, ToMigrationStateShared};
 use qom::prelude::*;
 use system::{
     bindings::{address_space_memory, address_space_stl_le},
@@ -176,7 +176,6 @@ fn timer_handler(t: &HPETTimer) {
     t.callback(&mut hpet_regs.borrow_mut())
 }
 
-#[repr(C)]
 #[derive(Debug, Default)]
 pub struct HPETTimerRegisters {
     // Memory-mapped, software visible timer registers
@@ -563,11 +562,13 @@ fn write(
     }
 }
 
-#[repr(C)]
-#[derive(Default)]
+#[derive(Default, ToMigrationState)]
 pub struct HPETRegisters {
     // HPET block Registers: Memory-mapped, software visible registers
     /// General Capabilities and ID Register
+    ///
+    /// Constant and therefore not migrated.
+    #[migration_state(omit)]
     capability: u64,
     ///  General Configuration Register
     config: u64,
@@ -579,9 +580,15 @@ pub struct HPETRegisters {
     counter: u64,
 
     /// HPET Timer N Registers
+    ///
+    /// Migrated as part of `Migratable<HPETTimer>`
+    #[migration_state(omit)]
     tn_regs: [HPETTimerRegisters; HPET_MAX_TIMERS],
 
     /// Offset of main counter relative to qemu clock.
+    ///
+    /// Migrated as a subsection and therefore snapshotted into [`HPETState`]
+    #[migration_state(omit)]
     pub hpet_offset: u64,
 }
 
@@ -613,7 +620,7 @@ fn is_timer_int_active(&self, index: usize) -> bool {
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
-    regs: BqlRefCell<HPETRegisters>,
+    regs: Migratable<BqlRefCell<HPETRegisters>>,
 
     // Internal state
     /// Capabilities that QEMU HPET supports.
@@ -639,7 +646,7 @@ pub struct HPETState {
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
-    timers: [HPETTimer; HPET_MAX_TIMERS],
+    timers: [Migratable<HPETTimer>; HPET_MAX_TIMERS],
     #[property(rename = "timers", default = HPET_MIN_TIMERS)]
     num_timers: usize,
     num_timers_save: BqlCell<u8>,
@@ -674,9 +681,12 @@ fn init_timers(this: &mut MaybeUninit<Self>) {
 
             // Initialize in two steps, to avoid calling Timer::init_full on a
             // temporary that can be moved.
-            let timer = timer.write(HPETTimer::new(index.try_into().unwrap(), state));
+            let timer = timer.write(Migratable::new(HPETTimer::new(
+                index.try_into().unwrap(),
+                state,
+            )));
             // SAFETY: HPETState is pinned
-            let timer = unsafe { Pin::new_unchecked(timer) };
+            let timer = unsafe { Pin::new_unchecked(&mut **timer) };
             HPETTimer::init_timer(timer);
         }
     }
@@ -1001,47 +1011,102 @@ impl ObjectImpl for HPETState {
         })
         .build();
 
-impl_vmstate_struct!(
-    HPETTimerRegisters,
-    VMStateDescriptionBuilder::<HPETTimerRegisters>::new()
-        .name(c"hpet_timer/regs")
+#[derive(Default)]
+pub struct HPETTimerMigration {
+    index: u8,
+    config: u64,
+    cmp: u64,
+    fsb: u64,
+    period: u64,
+    wrap_flag: u8,
+    qemu_timer: i64,
+}
+
+impl ToMigrationState for HPETTimer {
+    type Migrated = HPETTimerMigration;
+
+    fn snapshot_migration_state(
+        &self,
+        target: &mut Self::Migrated,
+    ) -> Result<(), migration::InvalidError> {
+        let state = self.get_state();
+        let regs = state.regs.borrow_mut();
+        let tn_regs = &regs.tn_regs[self.index as usize];
+
+        target.index = self.index;
+        target.config = tn_regs.config;
+        target.cmp = tn_regs.cmp;
+        target.fsb = tn_regs.fsb;
+        target.period = tn_regs.period;
+        target.wrap_flag = tn_regs.wrap_flag;
+        self.qemu_timer
+            .snapshot_migration_state(&mut target.qemu_timer)?;
+
+        Ok(())
+    }
+
+    fn restore_migrated_state_mut(
+        &mut self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), migration::InvalidError> {
+        self.restore_migrated_state(source, version_id)
+    }
+}
+
+impl ToMigrationStateShared for HPETTimer {
+    fn restore_migrated_state(
+        &self,
+        source: Self::Migrated,
+        version_id: u8,
+    ) -> Result<(), migration::InvalidError> {
+        let state = self.get_state();
+        let mut regs = state.regs.borrow_mut();
+        let tn_regs = &mut regs.tn_regs[self.index as usize];
+
+        tn_regs.config = source.config;
+        tn_regs.cmp = source.cmp;
+        tn_regs.fsb = source.fsb;
+        tn_regs.period = source.period;
+        tn_regs.wrap_flag = source.wrap_flag;
+        self.qemu_timer
+            .restore_migrated_state(source.qemu_timer, version_id)?;
+
+        Ok(())
+    }
+}
+
+const VMSTATE_HPET_TIMER: VMStateDescription<HPETTimerMigration> =
+    VMStateDescriptionBuilder::<HPETTimerMigration>::new()
+        .name(c"hpet_timer")
         .version_id(1)
         .minimum_version_id(1)
         .fields(vmstate_fields! {
-            vmstate_of!(HPETTimerRegisters, config),
-            vmstate_of!(HPETTimerRegisters, cmp),
-            vmstate_of!(HPETTimerRegisters, fsb),
-            vmstate_of!(HPETTimerRegisters, period),
-            vmstate_of!(HPETTimerRegisters, wrap_flag),
-        })
-        .build()
-);
-
-const VMSTATE_HPET_TIMER: VMStateDescription<HPETTimer> =
-    VMStateDescriptionBuilder::<HPETTimer>::new()
-        .name(c"hpet_timer")
-        .version_id(2)
-        .minimum_version_id(2)
-        .fields(vmstate_fields! {
-            vmstate_of!(HPETTimer, qemu_timer),
+            vmstate_of!(HPETTimerMigration, index),
+            vmstate_of!(HPETTimerMigration, config),
+            vmstate_of!(HPETTimerMigration, cmp),
+            vmstate_of!(HPETTimerMigration, fsb),
+            vmstate_of!(HPETTimerMigration, period),
+            vmstate_of!(HPETTimerMigration, wrap_flag),
+            vmstate_of!(HPETTimerMigration, qemu_timer),
         })
         .build();
 
-impl_vmstate_struct!(HPETTimer, VMSTATE_HPET_TIMER);
+impl_vmstate_struct!(HPETTimerMigration, VMSTATE_HPET_TIMER);
 
 const VALIDATE_TIMERS_NAME: &CStr = c"num_timers must match";
 
+// HPETRegistersMigration is generated by ToMigrationState macro.
 impl_vmstate_struct!(
-    HPETRegisters,
-    VMStateDescriptionBuilder::<HPETRegisters>::new()
+    HPETRegistersMigration,
+    VMStateDescriptionBuilder::<HPETRegistersMigration>::new()
         .name(c"hpet/regs")
         .version_id(2)
         .minimum_version_id(2)
         .fields(vmstate_fields! {
-            vmstate_of!(HPETRegisters, config),
-            vmstate_of!(HPETRegisters, int_status),
-            vmstate_of!(HPETRegisters, counter),
-            vmstate_of!(HPETRegisters, tn_regs),
+            vmstate_of!(HPETRegistersMigration, config),
+            vmstate_of!(HPETRegistersMigration, int_status),
+            vmstate_of!(HPETRegistersMigration, counter),
         })
         .build()
 );
@@ -1049,8 +1114,8 @@ impl ObjectImpl for HPETState {
 const VMSTATE_HPET: VMStateDescription<HPETState> =
     VMStateDescriptionBuilder::<HPETState>::new()
         .name(c"hpet")
-        .version_id(3)
-        .minimum_version_id(3)
+        .version_id(2)
+        .minimum_version_id(2)
         .pre_save(&HPETState::pre_save)
         .post_load(&HPETState::post_load)
         .fields(vmstate_fields! {
-- 
2.52.0


