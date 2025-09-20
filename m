Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E785CAC5A9
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzlB-000863-UM; Sat, 20 Sep 2025 11:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzl7-00085H-9A; Sat, 20 Sep 2025 11:44:21 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzl5-0001zY-Go; Sat, 20 Sep 2025 11:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383060; x=1789919060;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Ft6/zWuJrh1XDhFRWHRyCggIiXG4AZeWLOxo0l8lu0=;
 b=LW1QtDb5dWFyek73oxymhulEsFI4NAkqYxGXLuW9KP8uKSLVJR34vGO7
 scm4twneVIrhrPbOb/JEMWC3Yy+ARyq5zDDj2J0ZAazNuDd0JgQBArEwR
 Qg9L3KqnpmsuB5gjjp7ENrJWe4jZENjM5T+fwbR4ryYbVD6JFNa/jtMN1
 W9KIPVZVVOhF2n5L/yGmm1+mRBx9SFpKsqpiNtktvhDazrE78o9/izJrv
 CuTu09wE35wtAdIgq63HxwXu5I20a0l/GFOBGRgv+cz0iZJ6ULhQ0H6I1
 WHxiq8Stbzc8l7Bd7/faOeKuViswjiWnpm2iCs7cq8zsON732PKadz53j A==;
X-CSE-ConnectionGUID: XrO5SKy1RrigQGnfei4faQ==
X-CSE-MsgGUID: a/gceFDQQyG7sPQd2PhjlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955569"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955569"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:57 -0700
X-CSE-ConnectionGUID: OIRHsUfHSNOBoiJonCYaew==
X-CSE-MsgGUID: bIiqnjL9TfO6aN9uwJQvqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349489"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:55 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 11/12] rust/hpet: Convert qdev properties to #property macro
Date: Sun, 21 Sep 2025 00:05:19 +0800
Message-Id: <20250920160520.3699591-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

Convert HPET's properties to #property macro:
 * num_timers: usize property.
 * flags: u32 bit property.
 * int_route_cap: u32 property.
 * hpet_offset_saved: bool property.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 55 ++++----------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index fce75415579d..86638c076666 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -13,9 +13,8 @@
 use bql::{BqlCell, BqlRefCell};
 use common::{bitops::IntegerExt, uninit_field_mut};
 use hwcore::{
-    bindings::{qdev_prop_bit, qdev_prop_bool, qdev_prop_uint32, qdev_prop_usize},
-    declare_properties, define_property, DeviceImpl, DeviceMethods, DeviceState, InterruptSource,
-    Property, ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
+    DeviceImpl, DeviceMethods, DeviceState, InterruptSource, ResetType, ResettablePhasesImpl,
+    SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
 };
 use migration::{
     self, impl_vmstate_struct, vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
@@ -520,7 +519,7 @@ fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
 
 /// HPET Event Timer Block Abstraction
 #[repr(C)]
-#[derive(qom::Object)]
+#[derive(qom::Object, hwcore::Device)]
 pub struct HPETState {
     parent_obj: ParentField<SysBusDevice>,
     iomem: MemoryRegion,
@@ -540,10 +539,12 @@ pub struct HPETState {
     // Internal state
     /// Capabilities that QEMU HPET supports.
     /// bit 0: MSI (or FSB) support.
+    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
     flags: u32,
 
     /// Offset of main counter relative to qemu clock.
     hpet_offset: BqlCell<u64>,
+    #[property(rename = "hpet-offset-saved", default = true)]
     hpet_offset_saved: bool,
 
     irqs: [InterruptSource; HPET_NUM_IRQ_ROUTES],
@@ -555,11 +556,13 @@ pub struct HPETState {
     /// the timers' interrupt can be routed, and is encoded in the
     /// bits 32:64 of timer N's config register:
     #[doc(alias = "intcap")]
+    #[property(rename = "hpet-intcap", default = 0)]
     int_route_cap: u32,
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
     timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
+    #[property(rename = "timers", default = HPET_MIN_TIMERS)]
     num_timers: usize,
     num_timers_save: BqlCell<u8>,
 
@@ -901,44 +904,6 @@ impl ObjectImpl for HPETState {
     const CLASS_INIT: fn(&mut Self::Class) = Self::Class::class_init::<Self>;
 }
 
-// TODO: Make these properties user-configurable!
-declare_properties! {
-    HPET_PROPERTIES,
-    define_property!(
-        c"timers",
-        HPETState,
-        num_timers,
-        unsafe { &qdev_prop_usize },
-        usize,
-        default = HPET_MIN_TIMERS
-    ),
-    define_property!(
-        c"msi",
-        HPETState,
-        flags,
-        unsafe { &qdev_prop_bit },
-        u32,
-        bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8,
-        default = false,
-    ),
-    define_property!(
-        c"hpet-intcap",
-        HPETState,
-        int_route_cap,
-        unsafe { &qdev_prop_uint32 },
-        u32,
-        default = 0
-    ),
-    define_property!(
-        c"hpet-offset-saved",
-        HPETState,
-        hpet_offset_saved,
-        unsafe { &qdev_prop_bool },
-        bool,
-        default = true
-    ),
-}
-
 static VMSTATE_HPET_RTC_IRQ_LEVEL: VMStateDescription<HPETState> =
     VMStateDescriptionBuilder::<HPETState>::new()
         .name(c"hpet/rtc_irq_level")
@@ -1001,12 +966,6 @@ impl ObjectImpl for HPETState {
         ))
         .build();
 
-// SAFETY: HPET_PROPERTIES is a valid Property array constructed with the
-// hwcore::declare_properties macro.
-unsafe impl hwcore::DevicePropertiesImpl for HPETState {
-    const PROPERTIES: &'static [Property] = &HPET_PROPERTIES;
-}
-
 impl DeviceImpl for HPETState {
     const VMSTATE: Option<VMStateDescription<Self>> = Some(VMSTATE_HPET);
     const REALIZE: Option<fn(&Self) -> util::Result<()>> = Some(Self::realize);
-- 
2.34.1


