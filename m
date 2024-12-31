Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55287E7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3F-0003RN-QL; Mon, 30 Dec 2024 19:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3D-0003PT-RY
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ3A-0001yX-AZ
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLRyhLZCkB8ac2Pq1tt07simH7oDZNcXTrRpW5qQGiA=;
 b=bszdViMBDzZfu5ndFMLcR9yqbZ2dUCxyH126w09xE2p/ifPnZJyb4ZGmgyVsOoLUzJ1oBq
 iBJaY4tuyG80o5Kq2j76Li7aDrHrVJRbFv0BEupc4FY5Q62cdpSdU8v3PgduqEFNwxcL0k
 beVoFnaPNRjLcFcaiEqKwA/u3ZEc4QI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-hpbGKioZPLWVgFOsBG_b8A-1; Mon, 30 Dec 2024 19:23:51 -0500
X-MC-Unique: hpbGKioZPLWVgFOsBG_b8A-1
X-Mimecast-MFC-AGG-ID: hpbGKioZPLWVgFOsBG_b8A
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385fdff9db5so1289758f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604629; x=1736209429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLRyhLZCkB8ac2Pq1tt07simH7oDZNcXTrRpW5qQGiA=;
 b=LHG4daIQr5NeEJUmLvLRgB/EVhfhDmGNpF/dTiWfNQTU7U10HG9r62rU6qIB4XLsyi
 60qjpfBlbvyHO+aJtQFfVGDUpwFuis7fEFlahJZG9GOOEF9zt6CtxTVDnOO6ekGIesSP
 Epf4quUfmzuK1te4yWwpMGHU6g/Xb4cagLVT+0dMz1nSvhoVjtmlJxpLv+rBrx+CiJnk
 jIXgGy5U4hjedGi+piKMafYnq/eaXLqQ5pUlWvGgOVQ8pmDGutd86wISsWeSh5jfGHsD
 zGgbmvLMV0FNVynBg9krF2GIhHWuqX1oPideD29EfUfZJSCBByQ3gvrhtMDt3hnqgbCx
 n4NQ==
X-Gm-Message-State: AOJu0Yz89ecXyu3SUDFiX1nR6n/72L73nk9gL0di0Y+fJT9xSOYmFPK1
 ZQUGBoJtKyg9LHHEmSQWGuW4lEkAEBJD4l7pEhZnFZai3MShzcWZRgJKLDqI8Im+sm9ut2fOXwN
 +CF15QseJf/bMJoEwboP70Le2tcJaUesg6rE3uzKZ4VMS5/3uYSiTSu7NWmsYknY+2jx/FbDt7w
 WmL7BAP1DLPa1kUXLx1ZXHTwn+38aJk2CtICM2QOw=
X-Gm-Gg: ASbGnct1YH9UWhjmacmq3iy9V3EWhcREkqFqcR0O9v6jZqQMyR9sOIdJtQrOXtVFRxX
 1IYBd2ZS14n67I3/CfJxLbPye7aiOUgH/7j1sBkQ1lIjhvUML+LUhCZjICs/QM1ySy2gshqCaX+
 4bgse9kSYnG7MS87vrH3xgY/P9qkp3hKjmhnWxrl93u/l1qAqw3KsqeyFqXhF4iV8uDyN0z6XbD
 IDt/GpwYuifQuk+67tw6k1pa0mA3dlDru5PIAINse+OXKOblzmwGkLpqC4=
X-Received: by 2002:adf:a19b:0:b0:38a:418e:21c7 with SMTP id
 ffacd0b85a97d-38a418e22c3mr14300670f8f.53.1735604629288; 
 Mon, 30 Dec 2024 16:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPSSd6h75+IGdiryn3rjZa15qMs3HnUtJ0l0Tv4kKFN5rJ1pSZQBZ70HWW88GqUGQEv/F1Pw==
X-Received: by 2002:adf:a19b:0:b0:38a:418e:21c7 with SMTP id
 ffacd0b85a97d-38a418e22c3mr14300657f8f.53.1735604628829; 
 Mon, 30 Dec 2024 16:23:48 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e26csm31849972f8f.78.2024.12.30.16.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 4/9] rust: vmstate: implement Zeroable for VMStateField
Date: Tue, 31 Dec 2024 01:23:31 +0100
Message-ID: <20241231002336.25931-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231002336.25931-1-pbonzini@redhat.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This shortens a bit the constants.  Do not bother using it
in the vmstate macros since most of them will go away soon.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs  | 18 +++---------------
 rust/qemu-api/src/zeroable.rs | 31 +++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 079c19c687b..49d0a3c31d4 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -21,8 +21,8 @@
 
 use core::{marker::PhantomData, mem, ptr::NonNull};
 
-use crate::bindings::VMStateFlags;
 pub use crate::bindings::{VMStateDescription, VMStateField};
+use crate::bindings::VMStateFlags;
 
 /// This macro is used to call a function with a generic argument bound
 /// to the type of a field.  The function must take a
@@ -488,20 +488,8 @@ macro_rules! vmstate_fields {
         static _FIELDS: &[$crate::bindings::VMStateField] = &[
             $($field),*,
             $crate::bindings::VMStateField {
-                name: ::core::ptr::null(),
-                err_hint: ::core::ptr::null(),
-                offset: 0,
-                size: 0,
-                start: 0,
-                num: 0,
-                num_offset: 0,
-                size_offset: 0,
-                info: ::core::ptr::null(),
-                flags: VMStateFlags::VMS_END,
-                vmsd: ::core::ptr::null(),
-                version_id: 0,
-                struct_version_id: 0,
-                field_exists: None,
+                flags: $crate::bindings::VMStateFlags::VMS_END,
+                ..$crate::zeroable::Zeroable::ZERO
             }
         ];
         _FIELDS.as_ptr()
diff --git a/rust/qemu-api/src/zeroable.rs b/rust/qemu-api/src/zeroable.rs
index 6125aeed8b4..57cac96de06 100644
--- a/rust/qemu-api/src/zeroable.rs
+++ b/rust/qemu-api/src/zeroable.rs
@@ -49,6 +49,37 @@ unsafe impl Zeroable for crate::bindings::Property {
     };
 }
 
+// bindgen does not derive Default here
+#[allow(clippy::derivable_impls)]
+impl Default for crate::bindings::VMStateFlags {
+    fn default() -> Self {
+        Self(0)
+    }
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateFlags {
+    const ZERO: Self = Self(0);
+}
+
+unsafe impl Zeroable for crate::bindings::VMStateField {
+    const ZERO: Self = Self {
+        name: ptr::null(),
+        err_hint: ptr::null(),
+        offset: 0,
+        size: 0,
+        start: 0,
+        num: 0,
+        num_offset: 0,
+        size_offset: 0,
+        info: ptr::null(),
+        flags: Zeroable::ZERO,
+        vmsd: ptr::null(),
+        version_id: 0,
+        struct_version_id: 0,
+        field_exists: None,
+    };
+}
+
 unsafe impl Zeroable for crate::bindings::VMStateDescription {
     const ZERO: Self = Self {
         name: ptr::null(),
-- 
2.47.1


