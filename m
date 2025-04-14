Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4FFC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoH-0003IL-5v; Mon, 14 Apr 2025 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoE-0003EN-OQ; Mon, 14 Apr 2025 10:29:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoC-00066W-QB; Mon, 14 Apr 2025 10:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640953; x=1776176953;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MkLNEpnpcLhgai3+Po2Gspb+1XP4R8BQt/F1Wa8b/DA=;
 b=CLSfz/wLXKe0jr36qxTqL9L61V/9CSURFb0NIYdvpBuLWXyntZlm8jMF
 ndu+u22vRQ1TZJgZfRpomVkbVkmPgic3Tv3YjCS8Uebu/QiCA4Nlxriu1
 11ge8E8B58db4W4G7+IeeT3R30SdlB8+HAVBdGTupQCICPaqq2iUizfaA
 d4PITAKTCz4T/QMm/ghBC1DTyhu/pnGAwSFkm8MqCa9lPcfE2H5S5f+xB
 ov825up4Ihjm5ZVwCj82IljE2F4nGh94LEtmwaFcGYjO32CrP5XuCgpf2
 j7rw6mYgxQc/tqoub7tQnHFSCiLqLDN5vMYUgWGev0VJhUTG93dyceE9B g==;
X-CSE-ConnectionGUID: hUJMBXb3Qe+wSvGaXyuQGw==
X-CSE-MsgGUID: tJMsCzOBRBaMSUpJK4b4qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501860"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501860"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:10 -0700
X-CSE-ConnectionGUID: TsmYX6uBTtSRQ9ukbU3vOw==
X-CSE-MsgGUID: /T3YErtERqq4HOOUjF5oxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606091"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:08 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 8/9] rust/hpet: Support migration
Date: Mon, 14 Apr 2025 22:49:42 +0800
Message-Id: <20250414144943.1112885-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Based on commit 1433e38cc8 ("hpet: do not overwrite properties on
post_load"), add the basic migration support to Rust HPET.

The current migration implementation introduces multiple unsafe
callbacks. Before the vmstate builder, one possible cleanup approach is
to wrap callbacks in the vmstate binding using a method similar to the
vmstate_exist_fn macro.

However, this approach would also create a lot of repetitive code (since
vmstate has so many callbacks: pre_load, post_load, pre_save, post_save,
needed and dev_unplug_pending). Although it would be cleaner, it would
somewhat deviate from the path of the vmstate builder.

Therefore, firstly focus on completing the functionality of HPET, and
those current unsafe callbacks can at least clearly indicate the needed
functionality of vmstate. The next step is to consider refactoring
vmstate to move towards the vmstate builder direction.

Additionally, update rust.rst about Rust HPET can support migration.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/devel/rust.rst            |   3 +-
 rust/hw/timer/hpet/src/hpet.rs | 146 ++++++++++++++++++++++++++++++++-
 2 files changed, 146 insertions(+), 3 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 88bdec1eb28f..3cc2841d4d1f 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -153,8 +153,7 @@ QEMU includes four crates:
 
 .. [#issues] The ``pl011`` crate is synchronized with ``hw/char/pl011.c``
    as of commit 02b1f7f61928.  The ``hpet`` crate is synchronized as of
-   commit f32352ff9e.  Both are lacking tracing functionality; ``hpet``
-   is also lacking support for migration.
+   commit 1433e38cc8.  Both are lacking tracing functionality.
 
 This section explains how to work with them.
 
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index dc8a23f29d95..983f3882f8d3 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -4,6 +4,7 @@
 
 use std::{
     ffi::CStr,
+    os::raw::{c_int, c_void},
     pin::Pin,
     ptr::{addr_of_mut, null_mut, NonNull},
     slice::from_ref,
@@ -25,7 +26,10 @@
     qom::{ObjectImpl, ObjectType, ParentField},
     qom_isa,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
-    timer::{Timer, CLOCK_VIRTUAL},
+    timer::{Timer, CLOCK_VIRTUAL, NANOSECONDS_PER_SECOND},
+    vmstate::VMStateDescription,
+    vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_validate,
+    zeroable::Zeroable,
 };
 
 use crate::fw_cfg::HPETFwConfig;
@@ -561,6 +565,7 @@ pub struct HPETState {
     #[doc(alias = "timer")]
     timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS as usize],
     num_timers: BqlCell<u8>,
+    num_timers_save: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
     hpet_id: BqlCell<usize>,
@@ -839,6 +844,49 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
             }
         }
     }
+
+    fn pre_save(&self) -> i32 {
+        if self.is_hpet_enabled() {
+            self.counter.set(self.get_ticks());
+        }
+
+        /*
+         * The number of timers must match on source and destination, but it was
+         * also added to the migration stream.  Check that it matches the value
+         * that was configured.
+         */
+        self.num_timers_save.set(self.num_timers.get());
+        0
+    }
+
+    fn post_load(&self, _version_id: u8) -> i32 {
+        for timer in self.timers.iter().take(self.get_num_timers()) {
+            let mut t = timer.borrow_mut();
+
+            t.cmp64 = t.calculate_cmp64(t.get_state().counter.get(), t.cmp);
+            t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
+        }
+
+        // Recalculate the offset between the main counter and guest time
+        if !self.hpet_offset_saved {
+            self.hpet_offset
+                .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
+        }
+
+        0
+    }
+
+    fn is_rtc_irq_level_needed(&self) -> bool {
+        self.rtc_irq_level.get() != 0
+    }
+
+    fn is_offset_needed(&self) -> bool {
+        self.is_hpet_enabled() && self.hpet_offset_saved
+    }
+
+    fn validate_num_timers(&self, _version_id: u8) -> bool {
+        self.num_timers.get() == self.num_timers_save.get()
+    }
 }
 
 qom_isa!(HPETState: SysBusDevice, DeviceState, Object);
@@ -895,11 +943,107 @@ impl ObjectImpl for HPETState {
     ),
 }
 
+unsafe extern "C" fn hpet_rtc_irq_level_needed(opaque: *mut c_void) -> bool {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
+    state.is_rtc_irq_level_needed()
+}
+
+unsafe extern "C" fn hpet_offset_needed(opaque: *mut c_void) -> bool {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &HPETState = unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_ref() };
+    state.is_offset_needed()
+}
+
+unsafe extern "C" fn hpet_pre_save(opaque: *mut c_void) -> c_int {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &mut HPETState =
+        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
+    state.pre_save() as c_int
+}
+
+unsafe extern "C" fn hpet_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &mut HPETState =
+        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
+    let version: u8 = version_id.try_into().unwrap();
+    state.post_load(version) as c_int
+}
+
+static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet/rtc_irq_level").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(hpet_rtc_irq_level_needed),
+    fields: vmstate_fields! {
+        vmstate_of!(HPETState, rtc_irq_level),
+    },
+    ..Zeroable::ZERO
+};
+
+static VMSTATE_HPET_OFFSET: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet/offset").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(hpet_offset_needed),
+    fields: vmstate_fields! {
+        vmstate_of!(HPETState, hpet_offset),
+    },
+    ..Zeroable::ZERO
+};
+
+static VMSTATE_HPET_TIMER: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet_timer").as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    fields: vmstate_fields! {
+        vmstate_of!(HPETTimer, index),
+        vmstate_of!(HPETTimer, config),
+        vmstate_of!(HPETTimer, cmp),
+        vmstate_of!(HPETTimer, fsb),
+        vmstate_of!(HPETTimer, period),
+        vmstate_of!(HPETTimer, wrap_flag),
+        vmstate_of!(HPETTimer, qemu_timer),
+    },
+    ..Zeroable::ZERO
+};
+
+const VALIDATE_TIMERS_NAME: &CStr = c_str!("num_timers must match");
+
+static VMSTATE_HPET: VMStateDescription = VMStateDescription {
+    name: c_str!("hpet").as_ptr(),
+    version_id: 2,
+    minimum_version_id: 1,
+    pre_save: Some(hpet_pre_save),
+    post_load: Some(hpet_post_load),
+    fields: vmstate_fields! {
+        vmstate_of!(HPETState, config),
+        vmstate_of!(HPETState, int_status),
+        vmstate_of!(HPETState, counter),
+        vmstate_of!(HPETState, num_timers_save).with_version_id(2),
+        vmstate_validate!(HPETState, VALIDATE_TIMERS_NAME, HPETState::validate_num_timers),
+        vmstate_struct!(HPETState, timers[0 .. num_timers], &VMSTATE_HPET_TIMER, BqlRefCell<HPETTimer>, HPETState::validate_num_timers).with_version_id(0),
+    },
+    subsections: vmstate_subsections! {
+        VMSTATE_HPET_RTC_IRQ_LEVEL,
+        VMSTATE_HPET_OFFSET,
+    },
+    ..Zeroable::ZERO
+};
+
 impl DeviceImpl for HPETState {
     fn properties() -> &'static [Property] {
         &HPET_PROPERTIES
     }
 
+    fn vmsd() -> Option<&'static VMStateDescription> {
+        Some(&VMSTATE_HPET)
+    }
+
     const REALIZE: Option<fn(&Self)> = Some(Self::realize);
 }
 
-- 
2.34.1


