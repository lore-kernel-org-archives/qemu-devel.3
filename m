Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAB9E7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 05:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4kM-0006Kn-NQ; Thu, 05 Dec 2024 00:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kK-0006K7-MJ; Thu, 05 Dec 2024 00:49:52 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4kI-0007By-89; Thu, 05 Dec 2024 00:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733377790; x=1764913790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LDckMvXhJNI3rW7CA66Qk7TmJwbv6cFDKjeds0sFlc4=;
 b=AWeLB4gYZZmR+cqopAHEAlnMK5YcKUDW7rbT9uWMekqn/FmK9+5PR4l2
 PYsc5PjPmVnIHW08xXDgJvDhFNBBAwqGj/N32FlemgJ6HUg0fq4ziOuez
 F+t1T5Mtx+giFPlZj47OJ1eaMvXhgnHBIAVmVShNC3JfpL0rYKcOv1g2P
 fZbuiSmSXs9lNkxKbXFty6Gb04nsdlA61WL1SowCZQwvJdPPTjMvbi/bO
 qcVYb5+4r1TvyrdHlmrgV2E0zLgCK/jP+g7z5+774tbnRUop0XWsVszWd
 QwAftNq521aid+RGEz1EGj9qZoXjji/KYjVnsmubHqWcFsm3aG1XUwyAK w==;
X-CSE-ConnectionGUID: 9BysKVV1T2OztSQRvfLMeQ==
X-CSE-MsgGUID: m22BqopKSWSx/fuTphi7Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="33815685"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="33815685"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 21:49:49 -0800
X-CSE-ConnectionGUID: FPGRTD/oSd6+Vs04Q2AR0w==
X-CSE-MsgGUID: ulAAKIxcTHOHyGHhgZGiUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="94455077"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 04 Dec 2024 21:49:46 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 12/13] rust/timer/hpet: add qdev APIs support
Date: Thu,  5 Dec 2024 14:07:13 +0800
Message-Id: <20241205060714.256270-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

Implement QAPI support for HPET device in qdev.rs.

Additionally, wrap the handling of HPET internal details as traits to be
specifically implemented in hpet.rs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/fw_cfg.rs |   2 -
 rust/hw/timer/hpet/src/hpet.rs   | 232 ++++++++++++++++++++++++++++++-
 rust/hw/timer/hpet/src/lib.rs    |   5 +
 rust/hw/timer/hpet/src/qdev.rs   | 133 ++++++++++++++++++
 4 files changed, 365 insertions(+), 7 deletions(-)
 create mode 100644 rust/hw/timer/hpet/src/qdev.rs

diff --git a/rust/hw/timer/hpet/src/fw_cfg.rs b/rust/hw/timer/hpet/src/fw_cfg.rs
index a057c2778be4..6515a428cebb 100644
--- a/rust/hw/timer/hpet/src/fw_cfg.rs
+++ b/rust/hw/timer/hpet/src/fw_cfg.rs
@@ -2,8 +2,6 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
 use qemu_api::{cell::BqlCell, zeroable::Zeroable};
 
 // Each HPETState represents a Event Timer Block. The v1 spec supports
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 9550d8fe438a..9480633a77dd 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -2,10 +2,8 @@
 // Author(s): Zhao Liu <zhai1.liu@intel.com>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#![allow(dead_code)]
-
-use core::ptr::{null_mut, NonNull};
-use std::os::raw::c_int;
+use core::ptr::{addr_of_mut, null_mut, NonNull};
+use std::os::raw::{c_uint, c_void};
 
 use qemu_api::{
     bindings::*,
@@ -13,9 +11,14 @@
     cell::{BqlCell, BqlRefCell},
     irq::InterruptSource,
     memattrs::MEMTXATTRS_UNSPECIFIED,
+    qdev::DeviceGPIOImpl,
+    qom::ObjectType,
     timer::{qemu_clock_get_virtual_ns, QEMUTimerImpl},
+    zeroable::Zeroable,
 };
 
+use crate::{fw_cfg::*, qdev::*};
+
 // Register space for each timer block. (HPET_BASE isn't defined here.)
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
@@ -453,6 +456,38 @@ fn callback(&mut self) {
     }
 }
 
+impl RamOps for HPETTimer {
+    fn read(&mut self, addr: hwaddr, _size: c_uint) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        match addr & 0x18 {
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
+    fn write(&mut self, addr: hwaddr, value: u64, size: u64) {
+        let shift = ((addr & 4) * 8) as usize;
+        let len = std::cmp::min(size * 8, 64 - shift as u64) as usize;
+
+        match addr & 0x18 {
+            HPET_TN_CFG_REG => self.set_tn_cfg_reg(shift, len, value),
+            HPET_TN_CMP_REG => self.set_tn_cmp_reg(shift, len, value),
+            HPET_TN_FSB_ROUTE_REG => self.set_tn_fsb_route_reg(shift, len, value),
+            _ => {
+                // TODO: Add trace point - trace_hpet_ram_write_invalid()
+                // Reserved.
+            }
+        }
+    }
+}
+
 #[derive(Debug)]
 pub struct HPETTimerInstance(BqlRefCell<HPETTimer>);
 
@@ -466,7 +501,7 @@ fn timer_handler(timer: &mut HPETTimerInstance) {
 /// Note: Wrap all items that may be changed in the callback called by C
 /// into the BqlCell/BqlRefCell.
 #[repr(C)]
-#[derive(Debug, qemu_api_macros::offsets)]
+#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
 pub struct HPETState {
     parent_obj: SysBusDevice,
     iomem: MemoryRegion,
@@ -636,3 +671,190 @@ impl QEMUTimerImpl for HPETState {
     const QEMU_TIMER_CB: Option<fn(opaque: &mut HPETTimerInstance)> =
         Some(HPETTimerInstance::timer_handler);
 }
+
+impl ObjOps for HPETState {
+    // TODO: Add binding to register idiomatic Rust callback.
+    const HPET_RAM_OPS: MemoryRegionOps = MemoryRegionOps {
+        read: Some(hpet_ram_read),
+        write: Some(hpet_ram_write),
+        read_with_attrs: None,
+        write_with_attrs: None,
+        valid: MemoryRegionOps__bindgen_ty_1 {
+            min_access_size: 4,
+            max_access_size: 8,
+            ..Zeroable::ZERO
+        },
+        impl_: MemoryRegionOps__bindgen_ty_2 {
+            min_access_size: 4,
+            max_access_size: 8,
+            ..Zeroable::ZERO
+        },
+        endianness: device_endian::DEVICE_NATIVE_ENDIAN,
+    };
+
+    unsafe fn init(&mut self) {
+        // SAFETY:
+        // self and self.iomem are guaranteed to be valid at this point since callers
+        // must make sure the `self` reference is valid.
+        unsafe {
+            memory_region_init_io(
+                addr_of_mut!(self.iomem),
+                addr_of_mut!(*self).cast::<Object>(),
+                &Self::HPET_RAM_OPS,
+                addr_of_mut!(*self).cast::<c_void>(),
+                Self::TYPE_NAME.as_ptr(),
+                HPET_REG_SPACE_LEN,
+            );
+            let sbd = addr_of_mut!(*self).cast::<SysBusDevice>();
+            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
+        }
+    }
+}
+
+impl DeviceGPIOImpl for HPETState {
+    const GPIO_IRQ_HANDLER: Option<fn(&mut Self, lines_num: u32, level: u32)> =
+        Some(HPETState::handle_legacy_irq);
+}
+
+impl QDevOps for HPETState {
+    fn realize(&mut self) {
+        // SAFETY:
+        // caller of C Qdev guarantees that the "self" passed in is a
+        // valid HPETState reference, so it is able to cast as SysBusDevice.
+        let sbd = unsafe { &mut *(addr_of_mut!(*self).cast::<SysBusDevice>()) };
+
+        if self.int_route_cap == 0 {
+            // TODO: Add error binding: warn_report()
+            println!("Hpet's hpet-intcap property not initialized");
+        }
+
+        // SAFETY:
+        // hpet_fw_cfg is contained in a BqlCell and is protected by BQL,
+        // so it's safe to modify it.
+        self.hpet_id.set(unsafe { hpet_fw_cfg.assign_hpet_id() });
+
+        for irq in self.irqs.iter() {
+            sbd.init_irq(irq);
+        }
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
+        self.init_gpio_in(2);
+        self.init_gpio_out(&self.pit_enabled, 1);
+    }
+
+    fn reset(&mut self) {
+        let sbd: *mut SysBusDevice = addr_of_mut!(*self).cast::<SysBusDevice>();
+
+        for i in 0..self.num_timers.get() {
+            self.get_timer(i).borrow_mut().reset();
+        }
+
+        self.pit_enabled.set(true);
+        self.counter.set(0);
+        self.hpet_offset.set(0);
+        self.config.set(0);
+        // SAFETY:
+        // hpet_fw_cfg is contained in a BqlCell and is protected by BQL,
+        // so it's safe to modify it.
+        unsafe {
+            hpet_fw_cfg.update_hpet_cfg(
+                self.hpet_id.get(),
+                Some(self.capability.get() as u32),
+                Some((*sbd).mmio[0].addr),
+            )
+        };
+
+        // to document that the RTC lowers its output on reset as well
+        self.rtc_irq_level.set(0);
+    }
+}
+
+impl RamOps for HPETState {
+    fn read(&mut self, addr: hwaddr, size: c_uint) -> u64 {
+        let shift: u64 = (addr & 4) * 8;
+
+        // address range of all TN regs
+        if (0x100..=0x3ff).contains(&addr) {
+            let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
+
+            // TODO: Add trace point - trace_hpet_ram_read(addr)
+            if timer_id > self.num_timers.get() {
+                // TODO: Add trace point - trace_hpet_timer_id_out_of_range(timer_id)
+                // Reserved.
+                return 0;
+            }
+
+            self.get_timer(timer_id).borrow_mut().read(addr, size)
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
+    fn write(&mut self, addr: hwaddr, value: u64, size: u64) {
+        let shift = ((addr & 4) * 8) as usize;
+        let len = std::cmp::min(size * 8, 64 - shift as u64) as usize;
+
+        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
+        if (0x100..=0x3ff).contains(&addr) {
+            let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
+
+            // TODO: Add trace point - trace_hpet_ram_write_timer_id(timer_id)
+            if timer_id > self.num_timers.get() {
+                // TODO: Add trace point - trace_hpet_timer_id_out_of_range(timer_id)
+                return;
+            }
+
+            self.get_timer(timer_id)
+                .borrow_mut()
+                .write(addr, value, size)
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
diff --git a/rust/hw/timer/hpet/src/lib.rs b/rust/hw/timer/hpet/src/lib.rs
index 387913bbdfb9..1692dbf19a85 100644
--- a/rust/hw/timer/hpet/src/lib.rs
+++ b/rust/hw/timer/hpet/src/lib.rs
@@ -10,7 +10,12 @@
 
 #![deny(unsafe_op_in_unsafe_fn)]
 
+use qemu_api::c_str;
+
 extern crate qemu_api;
 
 pub mod fw_cfg;
 pub mod hpet;
+pub mod qdev;
+
+pub const TYPE_HPET: &::std::ffi::CStr = c_str!("hpet");
diff --git a/rust/hw/timer/hpet/src/qdev.rs b/rust/hw/timer/hpet/src/qdev.rs
new file mode 100644
index 000000000000..6ddfc9422d78
--- /dev/null
+++ b/rust/hw/timer/hpet/src/qdev.rs
@@ -0,0 +1,133 @@
+// Copyright (C) 2024 Intel Corporation.
+// Author(s): Zhao Liu <zhai1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use core::ptr::NonNull;
+use std::{
+    ffi::CStr,
+    os::raw::{c_uint, c_void},
+};
+
+use qemu_api::{
+    bindings::*,
+    c_str,
+    qdev::DeviceImpl,
+    qom::{ClassInitImpl, ObjectImpl, ObjectType},
+    qom_isa,
+};
+
+use crate::hpet::*;
+
+qom_isa!(HPETState : SysBusDevice, DeviceState, Object);
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
+pub(crate) trait ObjOps {
+    const HPET_RAM_OPS: MemoryRegionOps;
+    unsafe fn init(&mut self);
+}
+
+impl ObjectImpl for HPETState {
+    type ParentType = SysBusDevice;
+
+    const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+}
+
+pub(crate) trait RamOps {
+    fn read(&mut self, addr: hwaddr, _size: c_uint) -> u64;
+    fn write(&mut self, addr: hwaddr, value: u64, size: u64);
+}
+
+pub(crate) unsafe extern "C" fn hpet_ram_read(
+    opaque: *mut c_void,
+    addr: hwaddr,
+    size: c_uint,
+) -> u64 {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &mut HPETState =
+        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
+
+    state.read(addr, size)
+}
+
+pub(crate) unsafe extern "C" fn hpet_ram_write(
+    opaque: *mut c_void,
+    addr: hwaddr,
+    data: u64,
+    size: c_uint,
+) {
+    // SAFETY:
+    // the pointer is convertible to a reference
+    let state: &mut HPETState =
+        unsafe { NonNull::new(opaque.cast::<HPETState>()).unwrap().as_mut() };
+
+    state.write(addr, data, size as u64);
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
+pub(crate) trait QDevOps {
+    fn realize(&mut self);
+    fn reset(&mut self);
+}
+
+impl DeviceImpl for HPETState {
+    fn properties() -> &'static [Property] {
+        &HPET_PROPERTIES
+    }
+
+    const REALIZE: Option<fn(&mut Self)> = Some(Self::realize);
+    const RESET: Option<fn(&mut Self)> = Some(Self::reset);
+}
-- 
2.34.1


