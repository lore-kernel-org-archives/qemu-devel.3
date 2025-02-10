Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E54C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 02:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thJkA-0000Ga-Tn; Sun, 09 Feb 2025 21:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJk9-0000FW-Ef; Sun, 09 Feb 2025 21:41:53 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thJk6-00089t-Nn; Sun, 09 Feb 2025 21:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739155311; x=1770691311;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NEngzAgZUUj2+InwtM7JC2HHlZDmoIzcFKYdZbw8euY=;
 b=k4kYvZcxmcRFkJVvtDm/uClm0/buPDxDq8+JexXF32QSj0XexA5VgTuo
 Ynvw4dogxHBj1vO2ZgHc0v8E3P19wZdku+4jMGaq7jX7yvhhle8Q5/JlF
 AeU5TS7CYlbVERSFbXaqkgDduRWjoUjcGNwGW05lWB/ht0zzpaJHUZu8l
 pwkR+zJXa4Lm5U3W95YXuiOVkBTUOxVNPdLCg4QxZahBljhWkGJ8rVLfZ
 cpbPiCoUskfhs9j7W0k/4mv5Pa1LdUuM+Z80oH532KeJX3NHsjaFGGcS1
 DYzT23Bz9rVCEvSoXkjl2k+oTqq0t8wTyLppL7GxJp5uWThT/PAKwXmY7 A==;
X-CSE-ConnectionGUID: NLEG1jNwT4ePUY4m74ikJQ==
X-CSE-MsgGUID: 5Ks8UpE9SaGQw+Th9tZtHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50351286"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; d="scan'208";a="50351286"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2025 18:41:50 -0800
X-CSE-ConnectionGUID: 9SHC4bWYS7yxBNCzcscYTw==
X-CSE-MsgGUID: +4xPYdD3TvuzPSv355NOsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="142938253"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 09 Feb 2025 18:41:47 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 09/10] rust/timer/hpet: add qom and qdev APIs support
Date: Mon, 10 Feb 2025 11:00:50 +0800
Message-Id: <20250210030051.2562726-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210030051.2562726-1-zhao1.liu@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
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

Implement QOM & QAPI support for HPET device.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Merge qdev.rs to hpet.rs.
 * Apply memory and Resettable bindings.
 * Consolidate inmutable &self and QOM casting.
 * Prefer timer iterator over loop.
 * Move init_mmio() and init_irq() to post_init().

Changes since Patch v1:
 * Fix complaints from cargo (+nightly) doc/clippy/fmt (v1.84.0).
 * Drop HPETClass.
 * Do `addr & !4` in timer's register read and write.
 * Mask the timer N's register address with 0x1F (timer_and_addr()).
 * Optimize variable naming for clarity.
---
 rust/hw/timer/hpet/src/fw_cfg.rs |   2 -
 rust/hw/timer/hpet/src/hpet.rs   | 275 ++++++++++++++++++++++++++++++-
 rust/hw/timer/hpet/src/lib.rs    |   4 +
 3 files changed, 272 insertions(+), 9 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index d4c24813063d..f548a3f4f8e1 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -2,8 +2,6 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
 use std::ptr::addr_of_mut;
 
 use qemu_api::{cell::bql_locked, impl_zeroable, zeroable::Zeroable};
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 7d10c4205348..1fb4986dd688 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -2,21 +2,33 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
-use std::ptr::{addr_of_mut, null_mut, NonNull};
+use std::{
+    ffi::CStr,
+    ptr::{addr_of_mut, null_mut, NonNull},
+    slice::from_ref,
+};
 
 use qemu_api::{
-    bindings::{address_space_memory, address_space_stl_le},
+    bindings::{
+        address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
+        qdev_prop_uint32, qdev_prop_uint8,
+    },
+    c_str,
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
-    memory::{MemoryRegion, MEMTXATTRS_UNSPECIFIED},
+    memory::{
+        hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+    },
     prelude::*,
-    qom::ParentField,
+    qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qom::{ObjectImpl, ObjectType, ParentField},
+    qom_isa,
     sysbus::SysBusDevice,
     timer::{Timer, CLOCK_VIRTUAL, NS},
 };
 
+use crate::fw_cfg::HPETFwConfig;
+
 /// Register space for each timer block (`HPET_BASE` is defined in hpet.h).
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
@@ -451,11 +463,41 @@ fn callback(&mut self) {
         }
         self.update_irq(true);
     }
+
+    const fn read(&self, addr: hwaddr, _size: u32) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        match addr & !4 {
+            HPET_TN_CFG_REG => self.config >> shift, // including interrupt capabilities
+            HPET_TN_CMP_REG => self.cmp >> shift,    // comparator register
+            HPET_TN_FSB_ROUTE_REG => self.fsb >> shift,
+            _ => {
+                // TODO: Add trace point - trace_hpet_ram_read_invalid()
+                // Reserved.
+                0
+            }
+        }
+    }
+
+    fn write(&mut self, addr: hwaddr, value: u64, size: u32) {
+        let shift = ((addr & 4) * 8) as u32;
+        let len = std::cmp::min(size * 8, 64 - shift);
+
+        match addr & !4 {
+            HPET_TN_CFG_REG => self.set_tn_cfg_reg(shift, len, value),
+            HPET_TN_CMP_REG => self.set_tn_cmp_reg(shift, len, value),
+            HPET_TN_FSB_ROUTE_REG => self.set_tn_fsb_route_reg(shift, len, value),
+            _ => {
+                // TODO: Add trace point - trace_hpet_ram_write_invalid()
+                // Reserved.
+            }
+        }
+    }
 }
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
@@ -626,4 +668,223 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
         self.counter
             .set(self.counter.get().deposit(shift, len, val));
     }
+
+    unsafe fn init(&mut self) {
+        static HPET_RAM_OPS: MemoryRegionOps<HPETState> =
+            MemoryRegionOpsBuilder::<HPETState>::new()
+                .read(&HPETState::read)
+                .write(&HPETState::write)
+                .native_endian()
+                .valid_sizes(4, 8)
+                .impl_sizes(4, 8)
+                .build();
+
+        // SAFETY:
+        // self and self.iomem are guaranteed to be valid at this point since callers
+        // must make sure the `self` reference is valid.
+        MemoryRegion::init_io(
+            unsafe { &mut *addr_of_mut!(self.iomem) },
+            addr_of_mut!(*self),
+            &HPET_RAM_OPS,
+            "hpet",
+            HPET_REG_SPACE_LEN,
+        );
+    }
+
+    fn post_init(&self) {
+        self.init_mmio(&self.iomem);
+        for irq in self.irqs.iter() {
+            self.init_irq(irq);
+        }
+    }
+
+    fn realize(&self) {
+        if self.int_route_cap == 0 {
+            // TODO: Add error binding: warn_report()
+            println!("Hpet's hpet-intcap property not initialized");
+        }
+
+        self.hpet_id.set(HPETFwConfig::assign_hpet_id());
+
+        if self.num_timers.get() < HPET_MIN_TIMERS {
+            self.num_timers.set(HPET_MIN_TIMERS);
+        } else if self.num_timers.get() > HPET_MAX_TIMERS {
+            self.num_timers.set(HPET_MAX_TIMERS);
+        }
+
+        self.init_timer();
+        // 64-bit General Capabilities and ID Register; LegacyReplacementRoute.
+        self.capability.set(
+            HPET_CAP_REV_ID_VALUE << HPET_CAP_REV_ID_SHIFT |
+            1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
+            1 << HPET_CAP_LEG_RT_CAP_SHIFT |
+            HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
+            ((self.num_timers.get() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
+            (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
+        );
+
+        self.init_gpio_in(2, HPETState::handle_legacy_irq);
+        self.init_gpio_out(from_ref(&self.pit_enabled));
+    }
+
+    fn reset_hold(&self, _type: ResetType) {
+        let sbd = self.upcast::<SysBusDevice>();
+
+        for timer in self.timers.iter().take(self.num_timers.get()) {
+            timer.borrow_mut().reset();
+        }
+
+        self.counter.set(0);
+        self.config.set(0);
+        self.pit_enabled.set(true);
+        self.hpet_offset.set(0);
+
+        HPETFwConfig::update_hpet_cfg(
+            self.hpet_id.get(),
+            self.capability.get() as u32,
+            sbd.mmio[0].addr,
+        );
+
+        // to document that the RTC lowers its output on reset as well
+        self.rtc_irq_level.set(0);
+    }
+
+    fn timer_and_addr(&self, addr: hwaddr) -> Option<(&BqlRefCell<HPETTimer>, hwaddr)> {
+        let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
+
+        // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
+        if timer_id > self.num_timers.get() {
+            // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
+            None
+        } else {
+            // Keep the complete address so that HPETTimer's read and write could
+            // detect the invalid access.
+            Some((&self.timers[timer_id], addr & 0x1F))
+        }
+    }
+
+    fn read(&self, addr: hwaddr, size: u32) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        // address range of all TN regs
+        // TODO: Add trace point - trace_hpet_ram_read(addr)
+        if (0x100..=0x3ff).contains(&addr) {
+            match self.timer_and_addr(addr) {
+                None => 0, // Reserved,
+                Some((timer, tn_addr)) => timer.borrow_mut().read(tn_addr, size),
+            }
+        } else {
+            match addr & !4 {
+                HPET_CAP_REG => self.capability.get() >> shift, /* including HPET_PERIOD 0x004 */
+                // (CNT_CLK_PERIOD field)
+                HPET_CFG_REG => self.config.get() >> shift,
+                HPET_COUNTER_REG => {
+                    let cur_tick: u64 = if self.is_hpet_enabled() {
+                        self.get_ticks()
+                    } else {
+                        self.counter.get()
+                    };
+
+                    // TODO: Add trace point - trace_hpet_ram_read_reading_counter(addr & 4,
+                    // cur_tick)
+                    cur_tick >> shift
+                }
+                HPET_INT_STATUS_REG => self.int_status.get() >> shift,
+                _ => {
+                    // TODO: Add trace point- trace_hpet_ram_read_invalid()
+                    // Reserved.
+                    0
+                }
+            }
+        }
+    }
+
+    fn write(&self, addr: hwaddr, value: u64, size: u32) {
+        let shift = ((addr & 4) * 8) as u32;
+        let len = std::cmp::min(size * 8, 64 - shift);
+
+        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
+        if (0x100..=0x3ff).contains(&addr) {
+            match self.timer_and_addr(addr) {
+                None => (), // Reserved.
+                Some((timer, tn_addr)) => timer.borrow_mut().write(tn_addr, value, size),
+            }
+        } else {
+            match addr & !0x4 {
+                HPET_CAP_REG => {} // General Capabilities and ID Register: Read Only
+                HPET_CFG_REG => self.set_cfg_reg(shift, len, value),
+                HPET_INT_STATUS_REG => self.set_int_status_reg(shift, len, value),
+                HPET_COUNTER_REG => self.set_counter_reg(shift, len, value),
+                _ => {
+                    // TODO: Add trace point - trace_hpet_ram_write_invalid()
+                    // Reserved.
+                }
+            }
+        }
+    }
+}
+
+qom_isa!(HPETState: SysBusDevice, DeviceState, Object);
+
+unsafe impl ObjectType for HPETState {
+    // No need for HPETClass. Just like OBJECT_DECLARE_SIMPLE_TYPE in C.
+    type Class = <SysBusDevice as ObjectType>::Class;
+    const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
+}
+
+impl ObjectImpl for HPETState {
+    type ParentType = SysBusDevice;
+
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
+}
+
+// TODO: Make these properties user-configurable!
+qemu_api::declare_properties! {
+    HPET_PROPERTIES,
+    qemu_api::define_property!(
+        c_str!("timers"),
+        HPETState,
+        num_timers,
+        unsafe { &qdev_prop_uint8 },
+        u8,
+        default = HPET_MIN_TIMERS
+    ),
+    qemu_api::define_property!(
+        c_str!("msi"),
+        HPETState,
+        flags,
+        unsafe { &qdev_prop_bit },
+        u32,
+        bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8,
+        default = false,
+    ),
+    qemu_api::define_property!(
+        c_str!("hpet-intcap"),
+        HPETState,
+        int_route_cap,
+        unsafe { &qdev_prop_uint32 },
+        u32,
+        default = 0
+    ),
+    qemu_api::define_property!(
+        c_str!("hpet-offset-saved"),
+        HPETState,
+        hpet_offset_saved,
+        unsafe { &qdev_prop_bool },
+        bool,
+        default = true
+    ),
+}
+
+impl DeviceImpl for HPETState {
+    fn properties() -> &'static [Property] {
+        &HPET_PROPERTIES
+    }
+
+    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
+}
+
+impl ResettablePhasesImpl for HPETState {
+    const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 027f7f83349a..25251112a86d 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -10,5 +10,9 @@
 
 #![deny(unsafe_op_in_unsafe_fn)]
 
+use qemu_api::c_str;
+
 pub mod fw_cfg;
 pub mod hpet;
+
+pub const TYPE_HPET: &::std::ffi::CStr = c_str!("hpet");
-- 
2.34.1


