Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E39D149C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mln-0001Sx-8L; Fri, 25 Oct 2024 12:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlk-0001D6-2s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mli-0004m5-8z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYenrZdbFRD95Cc02SvS7HaWNevX9ALocJClM8PQTC8=;
 b=I5HWimJwBXKGW7mLZgDwcJfO1Y9gHZ4Y2Pzkm9EEoDmuPqNqgtNYiAJ34Ri/mcqG/FA5MK
 3VZsY3xSHdre07EHBjv+IAoSmTryhAxj5f/24ztFVWllEZ+zlmdk+UjD+PfT7m15hRqGgE
 FxNxMX0ectNzht11mYXIX48jn7ZHBek=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-mxOG-sIaMYqIZtxJFplhPg-1; Fri, 25 Oct 2024 12:02:27 -0400
X-MC-Unique: mxOG-sIaMYqIZtxJFplhPg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9a1af73615so154493066b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872146; x=1730476946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hYenrZdbFRD95Cc02SvS7HaWNevX9ALocJClM8PQTC8=;
 b=pcHuNVQ6q2CFV6cKtIF38hfv4xrOPULV8tykp+q5NHB4rCF821ykCeOuhSEuvDcPsp
 528jSRKDWX0lbWClonGUBjbaEOsiHxvqsEBVRhGgTb+SsdS4yVwIFm4fPQRvBu7umQb3
 vwOQB2627B4BdBwnFU+RZ/qBI1zzHm/CdgRDjx2eaoHMbAnPZ0gVRH5m74OnixwJpBhM
 v4peM8To6YTLoHwRpnHTpQ8Pe0Mh3haIs5wmhyW05Hc3pM0pJI2h5Rb6Vp3hV6wDHWMz
 scXeeqwOtmpwwjX2kEI798MlCsHerKl7g2cemH8UuAMzJNMH4Hv/S7CIssaZkDmkmLGK
 IeRg==
X-Gm-Message-State: AOJu0Yxe/m2/moEfJ4bORgFBZSMLP5bV0dS4W/L9qsEOVeNlBwLxA4Xt
 IORbPFVlKxtYORFXAHoexbhFM18DFK51xLgO6LGygHXrX0yKKdX9YURbLcxEt74Ieii4RPqjnPZ
 kEE5N4ywlcuTKk0h2NHV7dHHvL3hkFICKIxObReKptIkMjfx/E1mytA4QYBTPzLv+VxD+t642kq
 0sPds+0tWp9mRHyjKfUr4H3HnS1S8ucdL9Tg87vHc=
X-Received: by 2002:a17:907:3e90:b0:a9a:634:dd2 with SMTP id
 a640c23a62f3a-a9ad281453bmr586356466b.43.1729872145703; 
 Fri, 25 Oct 2024 09:02:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL1lIau8hjALEK5IsTkElQQJC8q6g69yC5YJmYQHzu0crs5ECA7I1tmkRyqwGvxbCkwVvRGg==
X-Received: by 2002:a17:907:3e90:b0:a9a:634:dd2 with SMTP id
 a640c23a62f3a-a9ad281453bmr586348866b.43.1729872145027; 
 Fri, 25 Oct 2024 09:02:25 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b1f03878bsm85143466b.87.2024.10.25.09.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 03/23] rust/pl011: add support for migration
Date: Fri, 25 Oct 2024 18:01:48 +0200
Message-ID: <20241025160209.194307-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025160209.194307-1-pbonzini@redhat.com>
References: <20241025160209.194307-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Declare the vmstate description of the PL011 device.

Based on a patch by Manos Pitsidianakis.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-4-051e7a25b978@lin=
aro.org
---
 rust/hw/char/pl011/src/device.rs       | 27 ++++++++++
 rust/hw/char/pl011/src/device_class.rs | 68 +++++++++++++++++++++++---
 2 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index b3d8bc004e0..dd9145669dc 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -20,6 +20,12 @@
=20
 static PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0,=
 0x05, 0xb1];
=20
+/// Integer Baud Rate Divider, `UARTIBRD`
+const IBRD_MASK: u32 =3D 0x3f;
+
+/// Fractional Baud Rate Divider, `UARTFBRD`
+const FBRD_MASK: u32 =3D 0xffff;
+
 const DATA_BREAK: u32 =3D 1 << 10;
=20
 /// QEMU sourced constant.
@@ -492,6 +498,27 @@ pub fn update(&self) {
             unsafe { qemu_set_irq(*irq, i32::from(flags & i !=3D 0)) };
         }
     }
+
+    pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
+        /* Sanity-check input state */
+        if self.read_pos >=3D self.read_fifo.len() || self.read_count > se=
lf.read_fifo.len() {
+            return Err(());
+        }
+
+        if !self.fifo_enabled() && self.read_count > 0 && self.read_pos > =
0 {
+            // Older versions of PL011 didn't ensure that the single
+            // character in the FIFO in FIFO-disabled mode is in
+            // element 0 of the array; convert to follow the current
+            // code's assumptions.
+            self.read_fifo[0] =3D self.read_fifo[self.read_pos];
+            self.read_pos =3D 0;
+        }
+
+        self.ibrd &=3D IBRD_MASK;
+        self.fbrd &=3D FBRD_MASK;
+
+        Ok(())
+    }
 }
=20
 /// Which bits in the interrupt status matter for each outbound IRQ line ?
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/sr=
c/device_class.rs
index 9282dc4d151..27cabbd6651 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -2,16 +2,73 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
=20
-use core::ptr::NonNull;
+use core::{
+    ffi::{c_int, c_void},
+    ptr::NonNull,
+};
=20
-use qemu_api::{bindings::*, definitions::ObjectImpl, zeroable::Zeroable};
+use qemu_api::{
+    bindings::*, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_sub=
sections, vmstate_uint32,
+    vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
+};
=20
-use crate::device::PL011State;
+use crate::device::{PL011State, PL011_FIFO_DEPTH};
+
+extern "C" fn pl011_clock_needed(opaque: *mut c_void) -> bool {
+    unsafe {
+        debug_assert!(!opaque.is_null());
+        let state =3D NonNull::new_unchecked(opaque.cast::<PL011State>());
+        state.as_ref().migrate_clock
+    }
+}
+
+/// Migration subsection for [`PL011State`] clock.
+pub static VMSTATE_PL011_CLOCK: VMStateDescription =3D VMStateDescription {
+    name: c"pl011/clock".as_ptr(),
+    version_id: 1,
+    minimum_version_id: 1,
+    needed: Some(pl011_clock_needed),
+    fields: vmstate_fields! {
+        vmstate_clock!(clock, PL011State),
+    },
+    ..Zeroable::ZERO
+};
+
+extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c=
_int {
+    unsafe {
+        debug_assert!(!opaque.is_null());
+        let mut state =3D NonNull::new_unchecked(opaque.cast::<PL011State>=
());
+        let result =3D state.as_mut().post_load(version_id as u32);
+        if result.is_err() { -1 } else { 0 }
+    }
+}
=20
-#[used]
 pub static VMSTATE_PL011: VMStateDescription =3D VMStateDescription {
-    name: PL011State::TYPE_INFO.name,
-    unmigratable: true,
+    name: c"pl011".as_ptr(),
+    version_id: 2,
+    minimum_version_id: 2,
+    post_load: Some(pl011_post_load),
+    fields: vmstate_fields! {
+        vmstate_unused!(::core::mem::size_of::<u32>()),
+        vmstate_uint32!(flags, PL011State),
+        vmstate_uint32!(line_control, PL011State),
+        vmstate_uint32!(receive_status_error_clear, PL011State),
+        vmstate_uint32!(control, PL011State),
+        vmstate_uint32!(dmacr, PL011State),
+        vmstate_uint32!(int_enabled, PL011State),
+        vmstate_uint32!(int_level, PL011State),
+        vmstate_uint32_array!(read_fifo, PL011State, PL011_FIFO_DEPTH),
+        vmstate_uint32!(ilpr, PL011State),
+        vmstate_uint32!(ibrd, PL011State),
+        vmstate_uint32!(fbrd, PL011State),
+        vmstate_uint32!(ifl, PL011State),
+        vmstate_int32!(read_pos, PL011State),
+        vmstate_int32!(read_count, PL011State),
+        vmstate_int32!(read_trigger, PL011State),
+    },
+    subsections: vmstate_subsections! {
+        VMSTATE_PL011_CLOCK
+    },
     ..Zeroable::ZERO
 };
=20
--=20
2.47.0


