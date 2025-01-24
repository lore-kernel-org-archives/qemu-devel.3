Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5181C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGIH-0005qn-4b; Fri, 24 Jan 2025 04:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGH-0007c9-1F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGGD-0003xN-Hs
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2oD6fS2wUWrP/tzWspSWPbZz4DpoC2JTpmignvtp7I=;
 b=VY/11RigmTD4vgzqK13ASpKwY38TMo7e8gBxSdEoeJwskVnNWCDWOFCLMxAZAAPqxzYUru
 ti+MfreU8xoKwifkzIX8VhFgRfTMU1p4wVEugmucc1COS/ABC+TOSGSEBbjgNx/rtKPwEC
 Bs84hLV/C+TJWA2cUSze6PH9SJhyhx8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-8NOYgB5BPsOYl8YNg2VaNw-1; Fri, 24 Jan 2025 04:45:51 -0500
X-MC-Unique: 8NOYgB5BPsOYl8YNg2VaNw-1
X-Mimecast-MFC-AGG-ID: 8NOYgB5BPsOYl8YNg2VaNw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361efc9dc6so10144415e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711949; x=1738316749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2oD6fS2wUWrP/tzWspSWPbZz4DpoC2JTpmignvtp7I=;
 b=oCa+aU+Uf3DbexRHdCzYOwlCx4ggSXGPbCdg1akZMsrCLMmSFuKQI/H6qaxiKrMU0q
 8+fFqylHiyfvFCojH0qNQgyqWyh3ZcTCZ5Nb5ALhfxEtIuVBBFkl4fEFZXN6KObEHXvU
 27QhUU/ab0MUs3dLr2U6/pMOcumhYTTB2hXCIlzBWwFFot55ZsuB101AI5xg6wCYEC14
 6yLCArD6J8UMyHFdDMBrpqSJP+t2iuW/6KiNdOkhf4kR1qpDTs2om6YKsDmFBFsEl+ui
 hBUskjeQXiDQ5R3yxTIwnVzZBUBotK2698BzZMnrdhvBhz/TPmbosGGKM0OU5lEOkLar
 WI8Q==
X-Gm-Message-State: AOJu0Yy3QF8gkOkQOH7BoAM7jWCCScp++DVhv/Hn1tCYxRhZdT9OotCw
 ZOl8ZmnkX3eGIdbfBI+6ODY1lWi6cHztMClLVRYThPvPRnmvEmOmROk0Y69JEIABoim6mmo6XKP
 RudJTm8khzTHRDGpOTPkRAJkgKAbngJjYY/JIPoe/ISjtJj4/1f/hOrBq9dXzRH4cVQosj4Jhld
 1yQ48YxXj5G8KnyaLVk7/ODpE0vWIcf8PojfJGwMc=
X-Gm-Gg: ASbGnct6B5iVGqfzbHRsyCdbdl0ftNq92NbwK7nYE3rFzKDIK8bVGlFD9J9+fO9P/N4
 b3aHtplBIEXruYpnCBfXecQIcZK4wOEMbkDMVF6PaxzQt8dV1VLuxqKvfwNEaPfa02OoEaLeh3W
 auBPSh5QDU0M5kkBafnquwdRj/tQn/p9RAZvWizNnp5dMv1LUo4qhHHsgwFClaLTrfWtov2whFD
 5eXvSHce30E/VEw05ZxRK7ZoLtV1bbtqA5tY2swN2dUDjuBB85+wmw0lz+JP7pgNG9mQQwYSg==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-43891439d5fmr243279845e9.20.1737711949312; 
 Fri, 24 Jan 2025 01:45:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV4vSi1Wy0Y7v32Q2fKMYDf1L3K8Ry4dXnvYP1JLOBHmN49SVX/mLbHiu4qbhqsFP8IPSxPA==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-43891439d5fmr243279655e9.20.1737711948874; 
 Fri, 24 Jan 2025 01:45:48 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd57545dsm20148715e9.40.2025.01.24.01.45.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/48] rust: pl011: switch vmstate to new-style macros
Date: Fri, 24 Jan 2025 10:44:26 +0100
Message-ID: <20250124094442.13207-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs       |  3 ++-
 rust/hw/char/pl011/src/device_class.rs | 36 +++++++++++++-------------
 rust/hw/char/pl011/src/lib.rs          |  6 +++++
 3 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 4f1080ff19f..a1a522fdcdb 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -15,7 +15,7 @@
         qemu_irq, sysbus_connect_irq, sysbus_mmio_map, sysbus_realize_and_unref, CharBackend,
         Chardev, Clock, ClockEvent, MemoryRegion, QEMUChrEvent, CHR_IOCTL_SERIAL_SET_BREAK,
     },
-    c_str,
+    c_str, impl_vmstate_forward,
     irq::InterruptSource,
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property},
@@ -61,6 +61,7 @@ impl DeviceId {
 #[repr(transparent)]
 #[derive(Debug, Default)]
 pub struct Fifo([registers::Data; PL011_FIFO_DEPTH as usize]);
+impl_vmstate_forward!(Fifo);
 
 impl Fifo {
     const fn len(&self) -> u32 {
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 7f3ca895071..e0d3532e956 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -6,11 +6,11 @@
 use std::os::raw::{c_int, c_void};
 
 use qemu_api::{
-    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_subsections, vmstate_uint32,
-    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_of, vmstate_subsections,
+    vmstate_unused, zeroable::Zeroable,
 };
 
-use crate::device::{PL011State, PL011_FIFO_DEPTH};
+use crate::device::PL011State;
 
 extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
     unsafe {
@@ -52,21 +52,21 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     post_load: Some(pl011_post_load),
     fields: vmstate_fields! {
         vmstate_unused!(core::mem::size_of::<u32>()),
-        vmstate_uint32!(flags, PL011State),
-        vmstate_uint32!(line_control, PL011State),
-        vmstate_uint32!(receive_status_error_clear, PL011State),
-        vmstate_uint32!(control, PL011State),
-        vmstate_uint32!(dmacr, PL011State),
-        vmstate_uint32!(int_enabled, PL011State),
-        vmstate_uint32!(int_level, PL011State),
-        vmstate_uint32_array!(read_fifo, PL011State, PL011_FIFO_DEPTH),
-        vmstate_uint32!(ilpr, PL011State),
-        vmstate_uint32!(ibrd, PL011State),
-        vmstate_uint32!(fbrd, PL011State),
-        vmstate_uint32!(ifl, PL011State),
-        vmstate_uint32!(read_pos, PL011State),
-        vmstate_uint32!(read_count, PL011State),
-        vmstate_uint32!(read_trigger, PL011State),
+        vmstate_of!(PL011State, flags),
+        vmstate_of!(PL011State, line_control),
+        vmstate_of!(PL011State, receive_status_error_clear),
+        vmstate_of!(PL011State, control),
+        vmstate_of!(PL011State, dmacr),
+        vmstate_of!(PL011State, int_enabled),
+        vmstate_of!(PL011State, int_level),
+        vmstate_of!(PL011State, read_fifo),
+        vmstate_of!(PL011State, ilpr),
+        vmstate_of!(PL011State, ibrd),
+        vmstate_of!(PL011State, fbrd),
+        vmstate_of!(PL011State, ifl),
+        vmstate_of!(PL011State, read_pos),
+        vmstate_of!(PL011State, read_count),
+        vmstate_of!(PL011State, read_trigger),
     },
     subsections: vmstate_subsections! {
         VMSTATE_PL011_CLOCK
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 0a89d393e0f..f30f9850ad4 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -106,6 +106,7 @@ pub mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
     use bilge::prelude::*;
+    use qemu_api::impl_vmstate_bitsized;
 
     /// Receive Status Register / Data Register common error bits
     ///
@@ -172,6 +173,7 @@ pub struct Data {
         pub errors: Errors,
         _reserved: u16,
     }
+    impl_vmstate_bitsized!(Data);
 
     impl Data {
         // bilge is not very const-friendly, unfortunately
@@ -208,6 +210,7 @@ pub struct ReceiveStatusErrorClear {
         pub errors: Errors,
         _reserved_unpredictable: u24,
     }
+    impl_vmstate_bitsized!(ReceiveStatusErrorClear);
 
     impl ReceiveStatusErrorClear {
         pub fn set_from_data(&mut self, data: Data) {
@@ -280,6 +283,7 @@ pub struct Flags {
         pub ring_indicator: bool,
         _reserved_zero_no_modify: u23,
     }
+    impl_vmstate_bitsized!(Flags);
 
     impl Flags {
         pub fn reset(&mut self) {
@@ -354,6 +358,7 @@ pub struct LineControl {
         /// 31:8 - Reserved, do not modify, read as zero.
         _reserved_zero_no_modify: u24,
     }
+    impl_vmstate_bitsized!(LineControl);
 
     impl LineControl {
         pub fn reset(&mut self) {
@@ -498,6 +503,7 @@ pub struct Control {
         /// 31:16 - Reserved, do not modify, read as zero.
         _reserved_zero_no_modify2: u16,
     }
+    impl_vmstate_bitsized!(Control);
 
     impl Control {
         pub fn reset(&mut self) {
-- 
2.48.1


