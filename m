Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B632CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9F-0006xu-7M; Tue, 16 Sep 2025 04:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR9C-0006wc-T9; Tue, 16 Sep 2025 04:34:47 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR9A-000603-Pp; Tue, 16 Sep 2025 04:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011685; x=1789547685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3DpIAtVPe2GcmZt3Ew37XZkVJO/WxB+atKkvNLLCeOc=;
 b=YZWrYEGAossMaDR49VxaFnHLgN3b/dXUsXFWabE7BSoWn41xSD4ICCMb
 goxEABVJ/YxYuD5cWB+LpIStHVlWz5WW+4ltzAKsJVHB2JlYbNKT+PvOC
 IViEg7bw3GSs60b3SWleJ74Ns2ogjjs2riKPF7uIFZQBMbu8oqyflfAc5
 s6K7HucKU4cDQ4diDLcLm8DNqvxtaeCmOvG4SmpRg28xmzmK73Na/P1ub
 sOHNOvaU1wR9LfwE4LC5wqf55kAkWykhtQyQHjcvcyQgjgcjWFweEu0sl
 XrWB6P66/QJEqx2sAw+ph54DsNHplZ95QYK4DmCBT/CuTVk2+bh5lmKCS g==;
X-CSE-ConnectionGUID: 0yIEEV7kSNalv051fd3dRw==
X-CSE-MsgGUID: 1CgURh5NSKWVMEBRPEGGMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725207"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725207"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:29 -0700
X-CSE-ConnectionGUID: KpBMtPJ8RHmxLNtMg2pK8w==
X-CSE-MsgGUID: dMpdE2pHQZKSrNXfPK96hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691131"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:27 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 11/12] rust/hpet: Convert qdev properties to #property macro
Date: Tue, 16 Sep 2025 16:55:56 +0800
Message-Id: <20250916085557.2008344-12-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

Convert HPET's properties to #property macro:
 * num_timers: usize property.
 * flags: u32 bit property.
 * int_route_cap: u32 property.
 * hpet_offset_saved: bool property.

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


