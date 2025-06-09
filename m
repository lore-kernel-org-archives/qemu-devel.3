Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3595C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 15:46:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOefs-0000Nc-WA; Mon, 09 Jun 2025 11:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefq-0000MP-PV
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uOefp-0007gW-4q
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 11:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749483872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wPitIwtRsJrMNIILebImcTxNfCDytC/cKtWdPcESChA=;
 b=S1RwrdFc2M8GVXqbrLDPt15iwirLEwtu4XVGVVa9QoJ+5Kpww+scHUDokswERUdrsBH6Fh
 fXrOSR0fFMLmhFSD1d46x6GhGhV+5kXLcj8l8Eo+X9VjM+xte3dCgfDWY2IRVGaIH3NrDi
 C21d+zI2u2DrFjJP3zNSJN9R26OwFsk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-XCyTK5edNJKt-QmVctJHIg-1; Mon, 09 Jun 2025 11:44:29 -0400
X-MC-Unique: XCyTK5edNJKt-QmVctJHIg-1
X-Mimecast-MFC-AGG-ID: XCyTK5edNJKt-QmVctJHIg_1749483868
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4eec544c6so1821575f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 08:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749483868; x=1750088668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPitIwtRsJrMNIILebImcTxNfCDytC/cKtWdPcESChA=;
 b=gYGyuOU48IWcxGjq4uYQRgugJ1h2OTKFKAsyCCA2INyoYMVHwm81MiuaOdr8I+XTu7
 VS8Vh7+7G0EchlBMHYUIoig5LxRTcoIpaq0Kdv+Lcq3gJVEQXZXKasVKR0qIu4YiSu4n
 LWVLZmWyU2mEGD41n0z7214NtWHnckz5p60j/A4jqBuf3Ol9VqP+OUcnfnp3vYfkGzYr
 1UDHsy3l1RZp9FBNQ0eOgTIQPvweVJ2vtyoJv/ULNXUS2YbVU/a5rNZithSfYr+9bTMG
 3nynoMUI2rNoEWuFwhBXCBYWSUydCw+3rzcVnzNhIw1/CcLpkl+DXcr2t7JC8fplcbwx
 Wwaw==
X-Gm-Message-State: AOJu0Yzl/qBhB842ZlnI/hk5kgQIR4XLRbIAh9qjCIBUnU4DHDI7EZzz
 B/mR8yHqNY5x4ggu/z+AklQjLKcJGLz8XPzXEbuvlTup7Se79FuBT8SLDRxn25sUdchNstPRt7I
 uQ5nPQRPNz9/ikzCioEt6GBegp9Jf4pV1esiCpNI2l6YuBYkjA8OYGzmbmeknVv5huPjtKbz0Eh
 0cRAkrElCf2yxnaJK22yU10aj9aQU7aEzXlA+gSiWx
X-Gm-Gg: ASbGncvfhJ11q3BqIlMsMq85vhsi5anYH+HMwTDJiKkum6k91sp4ctMrAl9p4Xi+54U
 QI01lSRVWt6x5b4sRoCZNtyXWfOk0BlHpkdeVPM7Glq+aq24o8A2Lb1k4+0LoG61EkFhNlJaj4w
 V1RHJBzQ7ZFrBUOK0JWhaY5he9eXYkkCU76O2KIgNyrS/oXAJr3Ds1UctbRP2XV+JW6rOvcUf5i
 V7L1dXuxaP2sbOSkdrrkBL9MEAxQNNVPtoK8P++ElnkW5pHBFeICpsdcmPp8VImBojxShTdm+vO
 1WOZEthuorLV1w==
X-Received: by 2002:a05:6000:2c0f:b0:3a5:222f:c0d0 with SMTP id
 ffacd0b85a97d-3a53166c269mr10426962f8f.0.1749483867669; 
 Mon, 09 Jun 2025 08:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFkwF1GAK1Q8MA9qw75TWqqQtRjZhcW7CjQjgwMId/TkFXlky45NF92JRCplH0YmqnglgC7Q==
X-Received: by 2002:a05:6000:2c0f:b0:3a5:222f:c0d0 with SMTP id
 ffacd0b85a97d-3a53166c269mr10426939f8f.0.1749483867177; 
 Mon, 09 Jun 2025 08:44:27 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45213709637sm113704375e9.26.2025.06.09.08.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 08:44:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 1/5] rust: qemu_api: introduce MaybeUninit field projection
Date: Mon,  9 Jun 2025 17:44:19 +0200
Message-ID: <20250609154423.706056-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609154423.706056-1-pbonzini@redhat.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a macro that makes it possible to convert a MaybeUninit<> into
another MaybeUninit<> for a single field within it.  Furthermore, it is
possible to use the resulting MaybeUninitField<> in APIs that take the
parent object, such as memory_region_init_io().

This allows removing some of the undefined behavior from instance_init()
functions, though this may not be the definitive implementation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build   |  1 +
 rust/qemu-api/src/lib.rs    |  1 +
 rust/qemu-api/src/uninit.rs | 85 +++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 rust/qemu-api/src/uninit.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cac8595a148..33653b4a28e 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -28,6 +28,7 @@ _qemu_api_rs = static_library(
       'src/qom.rs',
       'src/sysbus.rs',
       'src/timer.rs',
+      'src/uninit.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 93902fc94bc..c78198f0f41 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -27,6 +27,7 @@
 pub mod qom;
 pub mod sysbus;
 pub mod timer;
+pub mod uninit;
 pub mod vmstate;
 pub mod zeroable;
 
diff --git a/rust/qemu-api/src/uninit.rs b/rust/qemu-api/src/uninit.rs
new file mode 100644
index 00000000000..a7bed6935b1
--- /dev/null
+++ b/rust/qemu-api/src/uninit.rs
@@ -0,0 +1,85 @@
+//! Access fields of a [`MaybeUninit`](std::mem::MaybeUninit)
+
+use std::{
+    mem::MaybeUninit,
+    ops::{Deref, DerefMut},
+};
+
+pub struct MaybeUninitField<'a, T, U> {
+    parent: &'a mut MaybeUninit<T>,
+    child: *mut U,
+}
+
+impl<'a, T, U> MaybeUninitField<'a, T, U> {
+    #[doc(hidden)]
+    pub fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
+        MaybeUninitField { parent, child }
+    }
+
+    /// Return a constant pointer to the containing object of the field.
+    ///
+    /// Because the `MaybeUninitField` remembers the containing object,
+    /// it is possible to use it in foreign APIs that initialize the
+    /// child.
+    pub fn parent(f: &Self) -> *const T {
+        f.parent.as_ptr()
+    }
+
+    /// Return a mutable pointer to the containing object.
+    ///
+    /// Because the `MaybeUninitField` remembers the containing object,
+    /// it is possible to use it in foreign APIs that initialize the
+    /// child.
+    pub fn parent_mut(f: &mut Self) -> *mut T {
+        f.parent.as_mut_ptr()
+    }
+}
+
+impl<'a, T, U> Deref for MaybeUninitField<'a, T, U> {
+    type Target = MaybeUninit<U>;
+
+    fn deref(&self) -> &MaybeUninit<U> {
+        // SAFETY: self.child was obtained by dereferencing a valid mutable
+        // reference; the content of the memory may be invalid or uninitialized
+        // but MaybeUninit<_> makes no assumption on it
+        unsafe { &*(self.child.cast()) }
+    }
+}
+
+impl<'a, T, U> DerefMut for MaybeUninitField<'a, T, U> {
+    fn deref_mut(&mut self) -> &mut MaybeUninit<U> {
+        // SAFETY: self.child was obtained by dereferencing a valid mutable
+        // reference; the content of the memory may be invalid or uninitialized
+        // but MaybeUninit<_> makes no assumption on it
+        unsafe { &mut *(self.child.cast()) }
+    }
+}
+
+/// ```
+/// #[derive(Debug)]
+/// struct S {
+///     x: u32,
+///     y: u32,
+/// }
+///
+/// # use std::mem::MaybeUninit;
+/// # use qemu_api::{assert_match, uninit_field_mut};
+///
+/// let mut s: MaybeUninit<S> = MaybeUninit::zeroed();
+/// uninit_field_mut!(s, x).write(5);
+/// let s = unsafe { s.assume_init() };
+/// assert_match!(s, S { x: 5, y: 0 });
+/// ```
+#[macro_export]
+macro_rules! uninit_field_mut {
+    ($container:expr, $($field:tt)+) => {{
+        let container__: &mut ::std::mem::MaybeUninit<_> = &mut $container;
+        let container_ptr__ = container__.as_mut_ptr();
+
+        // SAFETY: the container is not used directly, only through a MaybeUninit<>,
+        // so the safety is delegated to the caller and to final invocation of
+        // assume_init()
+        let target__ = unsafe { std::ptr::addr_of_mut!((*container_ptr__).$($field)+) };
+        $crate::uninit::MaybeUninitField::new(container__, target__)
+    }};
+}
-- 
2.49.0


