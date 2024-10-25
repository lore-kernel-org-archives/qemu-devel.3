Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA7BD149C0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Mlv-0001gA-0o; Fri, 25 Oct 2024 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mls-0001eM-G5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Mlp-0004n3-HH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729872156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKfrIinsgj9j+tvfQg1SYIKrObbRxPY5XNT1F0GLBRk=;
 b=HHAeYTt1yqQP18svBgUvWYTyH0C+9SsB0C0bQJC91tB1vqJ2VEqExFTAoZlSJn31suIVJu
 r5o9NG5BoLvyJqxw9a/oPwsRxaa6c7hGikjgDGaUMHV2dWwCHIL7WEQz1UpJRu3TAnWiEr
 yrPCZZH0NSZ2ib5j9iUiAatlZ2C8KnA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-tfBkLRVNNECT9WEby9NTDA-1; Fri, 25 Oct 2024 12:02:35 -0400
X-MC-Unique: tfBkLRVNNECT9WEby9NTDA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5c999f254aeso1929996a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729872154; x=1730476954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKfrIinsgj9j+tvfQg1SYIKrObbRxPY5XNT1F0GLBRk=;
 b=sCnAGpeaX+6v5ZVRAetENkwNoC59TOUCXi16hKu+xvMEaxzqmDQz47zdM1VceDQlKo
 yS/iXPVXrgfmD4XEohNv0FKclfzPzodh4MnyLiIiyKIl9rSK3nXRSMJotOK0ut9YG5TE
 O3GQR60S4AE5aPNtl9NFUQ/+gOw3MfDhDG9LrU6oLaBnbzXsTmInHKF50i30vA/pgYNN
 S5DnzsEvQPVzcjkOrM4RWPzEWe53Mnt5CfQp30AcHG3riIQm6WsCZNiNNEdifWkOq3wR
 pzudJ+R04hTvMHVIQZsYzZuPaNrxDHKfPNhypjEZ/tEKO0i4YxKthgkoRuccBntzqR6G
 CyBA==
X-Gm-Message-State: AOJu0YyRfGCadAKV9eovuOdFWHXQd0edUf7RcthrvpTeRkPf278gDgaV
 F83Uz3Q9zUDMY9WDFJIDA7Fi9WEAOyWAAhdeHM8yBtycgBUgT1l0CcRWmkLP1KywblsmP7K1e2s
 eplpLFidNsWA6Ik1EWn7dwl94OqDn3fyFCSS68/oV2ftJuquETZLg8kWaUmtltXqDrept9qlWxp
 m5DvMe5dGuCIn/AyvlumLSu4XUNpkmpucHh6KW8M4=
X-Received: by 2002:a05:6402:3814:b0:5c9:367a:68d9 with SMTP id
 4fb4d7f45d1cf-5cb8b1c1b13mr8213338a12.15.1729872153856; 
 Fri, 25 Oct 2024 09:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7yU9yqwH3xS3296qTOuOhl/lc6/xFAIlF0HVEt+ayJm+UwhI/SN91Hx6eBRrdb5z5sOHhYw==
X-Received: by 2002:a05:6402:3814:b0:5c9:367a:68d9 with SMTP id
 4fb4d7f45d1cf-5cb8b1c1b13mr8213266a12.15.1729872153234; 
 Fri, 25 Oct 2024 09:02:33 -0700 (PDT)
Received: from [192.168.10.47] ([151.81.112.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629c250sm759850a12.27.2024.10.25.09.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 09:02:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
Subject: [PATCH 05/23] rust/pl011: add TYPE_PL011_LUMINARY device
Date: Fri, 25 Oct 2024 18:01:50 +0200
Message-ID: <20241025160209.194307-6-pbonzini@redhat.com>
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

Add a device specialization for the Luminary UART device.

This commit adds a DeviceId enum that utilizes the Index trait to return
different bytes depending on what device id the UART has (Arm -default-
or Luminary)

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241024-rust-round-2-v1-6-051e7a25b978@lin=
aro.org
---
 rust/hw/char/pl011/src/device.rs | 77 ++++++++++++++++++++++++++++++--
 rust/hw/char/pl011/src/lib.rs    |  1 +
 2 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/devi=
ce.rs
index f91790ff185..051c59f39ae 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -18,8 +18,6 @@
     RegisterOffset,
 };
=20
-static PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0,=
 0x05, 0xb1];
-
 /// Integer Baud Rate Divider, `UARTIBRD`
 const IBRD_MASK: u32 =3D 0x3f;
=20
@@ -31,6 +29,29 @@
 /// QEMU sourced constant.
 pub const PL011_FIFO_DEPTH: usize =3D 16_usize;
=20
+#[derive(Clone, Copy, Debug)]
+enum DeviceId {
+    #[allow(dead_code)]
+    Arm =3D 0,
+    Luminary,
+}
+
+impl std::ops::Index<hwaddr> for DeviceId {
+    type Output =3D c_uchar;
+
+    fn index(&self, idx: hwaddr) -> &Self::Output {
+        match self {
+            Self::Arm =3D> &Self::PL011_ID_ARM[idx as usize],
+            Self::Luminary =3D> &Self::PL011_ID_LUMINARY[idx as usize],
+        }
+    }
+}
+
+impl DeviceId {
+    const PL011_ID_ARM: [c_uchar; 8] =3D [0x11, 0x10, 0x14, 0x00, 0x0d, 0x=
f0, 0x05, 0xb1];
+    const PL011_ID_LUMINARY: [c_uchar; 8] =3D [0x11, 0x00, 0x18, 0x01, 0x0=
d, 0xf0, 0x05, 0xb1];
+}
+
 #[repr(C)]
 #[derive(Debug, qemu_api_macros::Object)]
 /// PL011 Device Model in QEMU
@@ -75,6 +96,8 @@ pub struct PL011State {
     pub clock: NonNull<Clock>,
     #[doc(alias =3D "migrate_clk")]
     pub migrate_clock: bool,
+    /// The byte string that identifies the device.
+    device_id: DeviceId,
 }
=20
 impl ObjectImpl for PL011State {
@@ -162,7 +185,7 @@ pub fn read(
=20
         std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset=
) {
             Err(v) if (0x3f8..0x400).contains(&v) =3D> {
-                u64::from(PL011_ID_ARM[((offset - 0xfe0) >> 2) as usize])
+                u64::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) =3D> {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset =
0x%x\n", (int)offset);
@@ -619,3 +642,51 @@ pub fn post_load(&mut self, _version_id: u32) -> Resul=
t<(), ()> {
         state.as_mut().init();
     }
 }
+
+#[repr(C)]
+#[derive(Debug, qemu_api_macros::Object)]
+/// PL011 Luminary device model.
+pub struct PL011Luminary {
+    parent_obj: PL011State,
+}
+
+#[repr(C)]
+pub struct PL011LuminaryClass {
+    _inner: [u8; 0],
+}
+
+/// Initializes a pre-allocated, unitialized instance of `PL011Luminary`.
+///
+/// # Safety
+///
+/// We expect the FFI user of this function to pass a valid pointer, that =
has
+/// the same size as [`PL011Luminary`]. We also expect the device is
+/// readable/writeable from one thread at any time.
+pub unsafe extern "C" fn pl011_luminary_init(obj: *mut Object) {
+    unsafe {
+        debug_assert!(!obj.is_null());
+        let mut state =3D NonNull::new_unchecked(obj.cast::<PL011Luminary>=
());
+        let state =3D state.as_mut();
+        state.parent_obj.device_id =3D DeviceId::Luminary;
+    }
+}
+
+impl qemu_api::definitions::Class for PL011LuminaryClass {
+    const CLASS_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
+    > =3D None;
+    const CLASS_BASE_INIT: Option<
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut core::ffi=
::c_void),
+    > =3D None;
+}
+
+impl ObjectImpl for PL011Luminary {
+    type Class =3D PL011LuminaryClass;
+    const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type_info!=
 { Self };
+    const TYPE_NAME: &'static CStr =3D crate::TYPE_PL011_LUMINARY;
+    const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(crate::TYPE_PL0=
11);
+    const ABSTRACT: bool =3D false;
+    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> =
=3D Some(pl011_luminary_init);
+    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object=
)> =3D None;
+    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)=
> =3D None;
+}
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2939ee50c99..c6bb76a7926 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -46,6 +46,7 @@
 pub mod memory_ops;
=20
 pub const TYPE_PL011: &::core::ffi::CStr =3D c"pl011";
+pub const TYPE_PL011_LUMINARY: &::core::ffi::CStr =3D c"pl011_luminary";
=20
 /// Offset of each register from the base memory address of the device.
 ///
--=20
2.47.0


