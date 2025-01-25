Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB68FC0218F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLL-0008L9-WF; Sat, 25 Jan 2025 07:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfLJ-0008KN-Tq; Sat, 25 Jan 2025 07:32:53 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfLH-0005VT-Ik; Sat, 25 Jan 2025 07:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808371; x=1769344371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eFUwjFzTVKRhcXepiDbF+oaPA8AdihqKAnBWplXvQ+w=;
 b=McCltVUfXb4rwccz74FyqoMw8jVwoM/d5VLdZ/RHMAlCzO8RyUgt1y+8
 kA6rALbYWUs03CpYvNc0+gr27IWk/G/ZlFUL8hPTmwQaXWxuxaPUzGPuk
 rjRLOsdM0Dt6aAxJ9XTed4ySOYtN/TKNJ9D/8DcFIYda0j7COkllY8vhk
 hbr2btg5UAz6wZyC18dzbwx+6xdq70Zl0wh83QfhhGaKBBdTh+fWqdCAI
 GvuN1ANiv0Ulwd5rkwkoBUlPyeTBTycIM7IN0+FBXZCIu6X1H2KHTRiRL
 Nvb1V6Xd1exogws02u7kHnUyqzVD1z2XX5fU/NCXPtxcu0LJwS1/JmLDt A==;
X-CSE-ConnectionGUID: 99fOIYOiTkKwKbwxv+Gl2w==
X-CSE-MsgGUID: lqdt4CXxT7OPG8lRlgQlRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434736"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434736"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:50 -0800
X-CSE-ConnectionGUID: pFpXTXrUQeO7CueiiuKVDw==
X-CSE-MsgGUID: CRrONNDBSlObCBeu6wrQ2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897778"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:47 -0800
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
Subject: [PATCH 09/10] rust/timer/hpet: add qom and qdev APIs support
Date: Sat, 25 Jan 2025 20:51:36 +0800
Message-Id: <20250125125137.1223277-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125125137.1223277-1-zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
---
 rust/hw/timer/hpet/src/fw_cfg.rs |   2 -
 rust/hw/timer/hpet/src/hpet.rs   | 283 ++++++++++++++++++++++++++++++-
 rust/hw/timer/hpet/src/lib.rs    |   4 +
 3 files changed, 279 insertions(+), 10 deletions(-)

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index 2f72bf854a66..5223629576a1 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -2,8 +2,6 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
 use qemu_api::{cell::bql_locked, impl_zeroable, zeroable::Zeroable};
 
 // Each HPETState represents a Event Timer Block. The v1 spec supports
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 0884a2ac73c4..7a717dbcfdd0 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -2,21 +2,30 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
-use core::ptr::{null_mut, NonNull};
+use core::ptr::{addr_of_mut, null_mut, NonNull};
+use std::{ffi::CStr, slice::from_ref};
 
 use qemu_api::{
-    bindings::{address_space_memory, address_space_stl_le, MemoryRegion, SCALE_NS},
+    bindings::{
+        address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
+        qdev_prop_uint32, qdev_prop_uint8, SCALE_NS,
+    },
+    c_str,
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
-    memory::MEMTXATTRS_UNSPECIFIED,
+    memory::{
+        hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder, MEMTXATTRS_UNSPECIFIED,
+    },
     prelude::*,
-    qom::ParentField,
-    sysbus::SysBusDevice,
+    qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qom::{ClassInitImpl, ObjectImpl, ObjectType, ParentField},
+    qom_isa,
+    sysbus::{SysBusDevice, SysBusDeviceClass},
     timer::{QEMUTimer, CLOCK_VIRTUAL},
 };
 
+use crate::fw_cfg::HPETFwConfig;
+
 // Register space for each timer block. (HPET_BASE isn't defined here.)
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
@@ -451,13 +460,43 @@ fn callback(&mut self) {
         }
         self.update_irq(true);
     }
+
+    fn read(&mut self, addr: hwaddr, _size: u32) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        match addr {
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
+        match addr {
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
 /// Note: Wrap all items that may be changed in the callback called by C
 /// into the BqlCell/BqlRefCell.
 #[repr(C)]
-#[derive(qemu_api_macros::offsets)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
@@ -630,4 +669,232 @@ fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
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
+            Some(self.capability.get() as u32),
+            Some((*sbd).mmio[0].addr),
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
+            Some((&self.timers[timer_id], addr & 0x18))
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
+                Some((timer, addr)) => timer.borrow_mut().read(addr, size),
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
+                None => return, // Reserved.
+                Some((timer, addr)) => timer.borrow_mut().write(addr, value, size),
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
+// TODO: add OBJECT_DECLARE_SIMPLE_TYPE.
+#[repr(C)]
+pub struct HPETClass {
+    parent_class: <SysBusDevice as ObjectType>::Class,
+}
+
+unsafe impl ObjectType for HPETState {
+    type Class = HPETClass;
+    const TYPE_NAME: &'static CStr = crate::TYPE_HPET;
+}
+
+impl ClassInitImpl<HPETClass> for HPETState {
+    fn class_init(klass: &mut HPETClass) {
+        <Self as ClassInitImpl<SysBusDeviceClass>>::class_init(&mut klass.parent_class);
+    }
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


