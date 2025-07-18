Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDB3C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 07:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfEY-0005JM-Tj; Fri, 18 Jul 2025 03:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucf5g-0003yT-Me
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:01:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucf5e-00080j-3J
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:01:08 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so341998166b.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752822064; x=1753426864; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TRv14jTjaPNdfV9WYIP6YBJPUP2EWuiScVG97tOiKS8=;
 b=ZXTNzYu4WtnkZ0V6pZgTcoSUOw3l2GuMmckcC0J+wMpmb/niSaywPX39PbHaXdZJ78
 wD+7je0+SUcxTuEMhTfOdJPiClJatRzgAOzofOEX2sWypFNOQIreyPy7/TcIqoGGzcru
 8t3jYx4L1WcqNTY430C/Szp4e47By665NcXUCDitvGbaF1nDmbYVVLQ3hvLjmEun0obM
 Xbh9WNFFcpLTsrgFJdoxwO+KHsLcUe3FbUjXEiQgs+xS2wULf4y1MR0sXYD05bhkNQ5I
 rSZI903qqtvamnyGd6EjgD5sGPVT/qP1Cy+qKKFj0OIkOK7PP2/RMRylNcunZm9giqzL
 d8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752822064; x=1753426864;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRv14jTjaPNdfV9WYIP6YBJPUP2EWuiScVG97tOiKS8=;
 b=dj3OpzaCakWGUJdSTcQ1EcVnIAB2j8kxEbCbICHqd2Odvs5qEjDHkaAkp5cfW1a/IW
 /weN+iABupAjbsK1nPB/BJwx6ybMRI29YMOohoch+FSZpvSpF00U+YT65abevkdiRrwi
 kEBG6GBL0rj2aIyUdQyh1gZVmUCTrUuYoe298l72nyPDX0T47q8A0f4+pJBSuIYthZI7
 mri2LaCUJXgRpmEl95a/Sjr582ImPUczM+OFleOHXd+MkGflv1EeAKyC4SF3kCc1SFf6
 Dc7WrxqPxVL/LK+ZAFy0HLeIrARbJ2XGVnLdXQX7ctMqQ9IsOJ2EQl/Iq/AYGQ7+fZrV
 yxlw==
X-Gm-Message-State: AOJu0Yw45KiV9qN/NGrVu0oRxpz90173z+I+Oh3ZNLtjFq8DgCf/qN3W
 wmPkgd1iw7a+zptYHEAOGP3ojTQU13awY1tv4PAkogTNxSvEu+MRemB+KAX1A7xpPVLOqsxRxH/
 w8Np/
X-Gm-Gg: ASbGncsWO+XtK39nhdExcZo93d2r7KQVuJT1uwyNqK9OSLCYyyejMTjRhVXYgLltZ/i
 FMFKQsExzggEb/L2NMhzeAMgpqDWmQt3uaUxUl3CaHJS5vUwqOo6G+TuY6mHBT4ssrdVcJAFLbD
 0Y/vIt05CIsigbq4kmAVLrlZLhVbhbqsU5qwbJj3nO8liGazhys42BplZwoIJ3I2NtfuJ4ypOLZ
 tcPbYRiF+lEacZOzG2T69Kn/GDzkCSBYaBrEuAD84jAPj/lh/Uyxrwj5/w7clNDQ11Sp1rrvUJR
 CLMp8J7HwAILFz3FlXWY8yT0gAHz7yn52tbsbYKlN06o2ucW0JFLGMm7CMzkMyJ+MxGweiGbBaL
 /oP7ZjbjDA1zLCzdGGf9A2ekKWYDLHlAKf2OakqzE1pIqru/ka4deJIHoA7BKQWbI8i0=
X-Google-Smtp-Source: AGHT+IE8PWlLlR1eB7SbgP7hUeKe4KuNytKCv8e511RBPlmXrUtC6M0+m0tu2PiBdsFPXA6rWnEvGg==
X-Received: by 2002:a17:907:a588:b0:ae0:a813:1bc0 with SMTP id
 a640c23a62f3a-ae9ce1addc0mr1002408566b.53.1752822063373; 
 Fri, 18 Jul 2025 00:01:03 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-210-241.home.otenet.gr. [2.86.210.241])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6ca7bc8esm65500166b.106.2025.07.18.00.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 00:01:02 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 10:00:52 +0300
Subject: [PATCH] rust/pl011: merge device_class.rs into device.rs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-rust-pl011-cleanup-v1-1-c71b1d6a69a5@linaro.org>
X-B4-Tracking: v=1; b=H4sIACPxeWgC/x3MQQqAIBBA0avErBtwpEi6SrSQGmtATLQikO6et
 HyL/wtkTsIZxqZA4luyHKGC2gaW3YaNUdZq0Er3aiCD6conRq+IcPFswxWRrGHSPVunOqhhTOz
 k+afT/L4fWCbO52QAAAA=
X-Change-ID: 20250718-rust-pl011-cleanup-1a8e125eaf04
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9245;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=2iVVbLOnqB09NHa0a042eLDGvvrb+k6avN3yeC1C2EM=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9lZkV1bmtVOWV3YkltUU4zdkQ5RE1lQlp4TVFqCmZUNVhJWjNacTN4UkJGSXQ0
 T3lKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhueExnQUt
 DUkIzS2Nkd2YzNEowTzYyRC85bERCTzhia05GSWcvaXRtazJPd2U5MldQZHo0QTFORkYyb3BROA
 pLbDAxeVc1QTZUK1I2S0xOeEN1WTE3RUYrV2I1WEQ4cnhmQmJrRHVDYS9LZG80V0o3V0pGNGtyZ
 WVhTDExeEkvCk5LcENwK0xTZ3lOYzRwalExWlRFSHZZV2F3T1VhYkZMU2NtSEVhT0gxUTRYbjVZ
 M0JmbDYxMzRpQ3R5T3E5QWcKWjl0d2VCNmhPc1I1d3B2bkdjaFJsRXQ0K2tzMTVFZ2FsODBTUG1
 Bak9UNU9TYzNtMW01c3diekVyM1ZzcmZJaApKUGZYS2xVdHIwQXJveVZHVUNEcGVFalYzZUU3aV
 JFWjBxTDV6RXk5U3dWL01ZWmQvdHY0OGpVVGFnZnp2NGo3CkxqSFFYNmI3bjVoelpuc3ZDU2FFY
 zBBODZVci9XeHE1TEpBWU9aSWZubXptaFV2eGpFL0gwcCtleUl1WFZTc04KbEZqYWo3NHRYbFN1
 dHZ3NVpsNFgwMmdaR213MHpKcW45MmVmMkU0a3FFUXA5SkM4dFNIZ1QzcTA0R2h0TFJKVgpVZEI
 vMzBQTHVDamVIVEpGMnZLNXA5Z01oaWhRVG1jaXk0MDBTaGVMRy9UZmFvN1NXdThwKzY5RDBIaE
 RRODBzCmw1QW4zaTYzT0ZDK2N5Z2RhMDdmakFSSzJtaGMvRWkydnI1U0FBcEFPUUlCMmVjbHBiV
 GN3WUdrcjJvVDZKNy8KYWhGcU83ZVlSaytMMk9UZXVkZEFXbDkyOWVRTTh2SVBTM0FwVjNWYVA0
 bFlaWDMwVE9xTVNVMlRSallJMUFHTgppUHZqWmM2VGRZY0k2WGthNGwyUmJjdW5OL2N1OUFDd2J
 XTzJPeGlScVl2Uldmc0FHMUVNdGpjNTU0c2lrZ0RaCkxOWldzQT09Cj1tRDdFCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The split was a relic of early development and is not necessary.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs       | 103 ++++++++++++++++++++++++++++++---
 rust/hw/char/pl011/src/device_class.rs | 103 ---------------------------------
 rust/hw/char/pl011/src/lib.rs          |   1 -
 3 files changed, 96 insertions(+), 111 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5b53f2649f161287f40f79075afba47db6d9315c..ceb71dd99b661b9f4da98f2dbabe18e82142035b 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,9 +2,14 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of};
+use std::{
+    ffi::{c_int, c_void, CStr},
+    mem::size_of,
+    ptr::NonNull,
+};
 
 use qemu_api::{
+    bindings::{qdev_prop_bool, qdev_prop_chr},
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
@@ -18,12 +23,11 @@
     sysbus::{SysBusDevice, SysBusDeviceImpl},
     uninit_field_mut,
     vmstate::VMStateDescription,
+    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
+    zeroable::Zeroable,
 };
 
-use crate::{
-    device_class,
-    registers::{self, Interrupt, RegisterOffset},
-};
+use crate::registers::{self, Interrupt, RegisterOffset};
 
 // TODO: You must disable the UART before any of the control registers are
 // reprogrammed. When the UART is disabled in the middle of transmission or
@@ -173,10 +177,10 @@ impl ObjectImpl for PL011State {
 
 impl DeviceImpl for PL011State {
     fn properties() -> &'static [Property] {
-        &device_class::PL011_PROPERTIES
+        &PL011_PROPERTIES
     }
     fn vmsd() -> Option<&'static VMStateDescription> {
-        Some(&device_class::VMSTATE_PL011)
+        Some(&VMSTATE_PL011)
     }
     const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
@@ -712,3 +716,88 @@ impl PL011Impl for PL011Luminary {
 impl DeviceImpl for PL011Luminary {}
 impl ResettablePhasesImpl for PL011Luminary {}
 impl SysBusDeviceImpl for PL011Luminary {}
+
+extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    unsafe { state.as_ref().migrate_clock }
+}
+
+/// Migration subsection for [`PL011State`] clock.
+static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
+    name: c"pl011/clock".as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(pl011_clock_needed),
+    fields: vmstate_fields! {
+        vmstate_clock!(PL011State, clock),
+    },
+    ..Zeroable::ZERO
+};
+
+extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
+    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
+    let result = unsafe { state.as_ref().post_load(version_id as u32) };
+    if result.is_err() {
+        -1
+    } else {
+        0
+    }
+}
+
+static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
+    name: c"pl011/regs".as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    fields: vmstate_fields! {
+        vmstate_of!(PL011Registers, flags),
+        vmstate_of!(PL011Registers, line_control),
+        vmstate_of!(PL011Registers, receive_status_error_clear),
+        vmstate_of!(PL011Registers, control),
+        vmstate_of!(PL011Registers, dmacr),
+        vmstate_of!(PL011Registers, int_enabled),
+        vmstate_of!(PL011Registers, int_level),
+        vmstate_of!(PL011Registers, read_fifo),
+        vmstate_of!(PL011Registers, ilpr),
+        vmstate_of!(PL011Registers, ibrd),
+        vmstate_of!(PL011Registers, fbrd),
+        vmstate_of!(PL011Registers, ifl),
+        vmstate_of!(PL011Registers, read_pos),
+        vmstate_of!(PL011Registers, read_count),
+        vmstate_of!(PL011Registers, read_trigger),
+    },
+    ..Zeroable::ZERO
+};
+
+pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
+    name: c"pl011".as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    post_load: Some(pl011_post_load),
+    fields: vmstate_fields! {
+        vmstate_unused!(core::mem::size_of::<u32>()),
+        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
+    },
+    subsections: vmstate_subsections! {
+        VMSTATE_PL011_CLOCK
+    },
+    ..Zeroable::ZERO
+};
+
+qemu_api::declare_properties! {
+    PL011_PROPERTIES,
+    qemu_api::define_property!(
+        c"chardev",
+        PL011State,
+        char_backend,
+        unsafe { &qdev_prop_chr },
+        CharBackend
+    ),
+    qemu_api::define_property!(
+        c"migrate-clk",
+        PL011State,
+        migrate_clock,
+        unsafe { &qdev_prop_bool },
+        bool,
+        default = true
+    ),
+}
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
deleted file mode 100644
index d328d846323f6080a9573053767e51481eb32941..0000000000000000000000000000000000000000
--- a/rust/hw/char/pl011/src/device_class.rs
+++ /dev/null
@@ -1,103 +0,0 @@
-// Copyright 2024, Linaro Limited
-// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-use std::{
-    ffi::{c_int, c_void},
-    ptr::NonNull,
-};
-
-use qemu_api::{
-    bindings::{qdev_prop_bool, qdev_prop_chr},
-    prelude::*,
-    vmstate::VMStateDescription,
-    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
-    zeroable::Zeroable,
-};
-
-use crate::device::{PL011Registers, PL011State};
-
-extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    unsafe { state.as_ref().migrate_clock }
-}
-
-/// Migration subsection for [`PL011State`] clock.
-static VMSTATE_PL011_CLOCK: VMStateDescription = VMStateDescription {
-    name: c"pl011/clock".as_ptr(),
-    version_id: 1,
-    minimum_version_id: 1,
-    needed: Some(pl011_clock_needed),
-    fields: vmstate_fields! {
-        vmstate_clock!(PL011State, clock),
-    },
-    ..Zeroable::ZERO
-};
-
-extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
-    let state = NonNull::new(opaque).unwrap().cast::<PL011State>();
-    let result = unsafe { state.as_ref().post_load(version_id as u32) };
-    if result.is_err() {
-        -1
-    } else {
-        0
-    }
-}
-
-static VMSTATE_PL011_REGS: VMStateDescription = VMStateDescription {
-    name: c"pl011/regs".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    fields: vmstate_fields! {
-        vmstate_of!(PL011Registers, flags),
-        vmstate_of!(PL011Registers, line_control),
-        vmstate_of!(PL011Registers, receive_status_error_clear),
-        vmstate_of!(PL011Registers, control),
-        vmstate_of!(PL011Registers, dmacr),
-        vmstate_of!(PL011Registers, int_enabled),
-        vmstate_of!(PL011Registers, int_level),
-        vmstate_of!(PL011Registers, read_fifo),
-        vmstate_of!(PL011Registers, ilpr),
-        vmstate_of!(PL011Registers, ibrd),
-        vmstate_of!(PL011Registers, fbrd),
-        vmstate_of!(PL011Registers, ifl),
-        vmstate_of!(PL011Registers, read_pos),
-        vmstate_of!(PL011Registers, read_count),
-        vmstate_of!(PL011Registers, read_trigger),
-    },
-    ..Zeroable::ZERO
-};
-
-pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
-    name: c"pl011".as_ptr(),
-    version_id: 2,
-    minimum_version_id: 2,
-    post_load: Some(pl011_post_load),
-    fields: vmstate_fields! {
-        vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_struct!(PL011State, regs, &VMSTATE_PL011_REGS, BqlRefCell<PL011Registers>),
-    },
-    subsections: vmstate_subsections! {
-        VMSTATE_PL011_CLOCK
-    },
-    ..Zeroable::ZERO
-};
-
-qemu_api::declare_properties! {
-    PL011_PROPERTIES,
-    qemu_api::define_property!(
-        c"chardev",
-        PL011State,
-        char_backend,
-        unsafe { &qdev_prop_chr },
-        CharBackend
-    ),
-    qemu_api::define_property!(
-        c"migrate-clk",
-        PL011State,
-        migrate_clock,
-        unsafe { &qdev_prop_bool },
-        bool,
-        default = true
-    ),
-}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 5c4fbc9d148fc4cebfe45adfd31a4fd215c87363..2b70d2ff5604179b367b91cbcfdbf9480fa30180 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -13,7 +13,6 @@
 //! the [`registers`] module for register types.
 
 mod device;
-mod device_class;
 mod registers;
 
 pub use device::pl011_create;

---
base-commit: 3656e761bcdd207b7759cdcd608212d2a6f9c12d
change-id: 20250718-rust-pl011-cleanup-1a8e125eaf04

--
γαῖα πυρί μιχθήτω


