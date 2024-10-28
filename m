Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B63D33990
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QnT-0002g1-Dc; Mon, 28 Oct 2024 10:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlN-0000Xo-Tk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5QlL-00040C-E7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2dZTvoQGa7EAtC2HDpwzcBQ7yI0kzC/1TBZHRMxmWE=;
 b=iobwSw82fTeGX9+3y+Nl1jB3FdEwHe/RdxCOJPTolkKyZCaNJ3cMcljeMehPmB5N5WwUhs
 Nt1bqb5N+BPwYbdoTX3geNDZc/3NI/JvK9Yxn2D7qt04HY8Cd2TtxzBO8hReIQxmvvUIt5
 urtjoa6QHW/kz2mxSXfkiwmDN28fifA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-QcvWxDNAMIKIgCrjojb0bQ-1; Mon, 28 Oct 2024 10:30:26 -0400
X-MC-Unique: QcvWxDNAMIKIgCrjojb0bQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso2056644f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125824; x=1730730624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2dZTvoQGa7EAtC2HDpwzcBQ7yI0kzC/1TBZHRMxmWE=;
 b=YWxedlJHQhdCNiMfd1SHDnb6nnPkyiS+HebelfNUS1QZsn3+gl8vkmcM+p1RUFwzxu
 ER5yONo8G3V/1fymiTDAFwbcY/9pEwOk5oNnQCjsbZiDUaKZsFlrzoAiu89ou6h/a3/2
 rPM8jpCOmuh6agfRbxna9m+D6yUvBYbQXv4Ad00dJdkflCOUz5GBunblK9qAI9taxDiU
 AsjHEOjrEKMRzKtDiNU7l2PorkKzjrIUGxbTpi1r7iJa2bhq9SkPwPEdLTNkwtnxGDGR
 0nUE2tRgkX4aKkVZTcLcsKAMLyI5LpqGItMBO/lHfZAc+SOGtBjEId+qOffloAc3BVgd
 yqRA==
X-Gm-Message-State: AOJu0YzQb540ls2S/dgrV1vfqz4pJHkftcxAZmdGSIWjkv7ocD8zs0Wl
 m4zxrW/X4A6FuVQqLDpnynVtLsLXRVPA+GfUkPehc2s8A7IVMsnDlr/n0jzc8hZ+jY23c+u1qVW
 79sgAZSkloV5Nr+9a8ZJXX2ZglegQiVQRDjNVeLF5mQwqPdGeGGtwLFFNnqINsJI/8WDhnE1FvH
 PGyEYW3f7EIDh3XUn6+wmmArW3c3zyMb6QTjD5GMs=
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id
 ffacd0b85a97d-380610f2ea6mr6909465f8f.6.1730125824035; 
 Mon, 28 Oct 2024 07:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHliULZ09D9TFEeJkCu6YjZs6/4REuclSBRzSKiyt9qiczytFZ6oy/6+601UVQTXjY2U2PBGw==
X-Received: by 2002:a5d:49c2:0:b0:37d:39c1:4d3 with SMTP id
 ffacd0b85a97d-380610f2ea6mr6909429f8f.6.1730125823472; 
 Mon, 28 Oct 2024 07:30:23 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47f59sm9624269f8f.54.2024.10.28.07.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:30:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 19/24] rust: make properties array immutable
Date: Mon, 28 Oct 2024 15:29:26 +0100
Message-ID: <20241028142932.363687-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Now that device_class_set_props() takes a const pointer, the only part of
"define_property!" that needs to be non-const is the call to try_into().
This in turn will only break if offset_of returns a value with the most
significant bit set (i.e. a struct size that is >=2^31 or >= 2^63,
respectively on 32- and 64-bit system), which is impossible.

Just use a cast and clean everything up to remove the run-time
initialization.  This also removes a use of OnceLock, which was only
stabilized in 1.70.0.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 42 ++++++-------------------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index aab60484096..4b14cb3ffd6 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -2,10 +2,6 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::sync::OnceLock;
-
-use crate::bindings::Property;
-
 #[macro_export]
 macro_rules! device_class_init {
     ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
@@ -19,7 +15,7 @@ macro_rules! device_class_init {
                 dc.as_mut().realize = $realize_fn;
                 dc.as_mut().vmsd = &$vmsd;
                 $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
-                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
+                $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_ptr());
             }
         }
     };
@@ -32,9 +28,7 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
-                .try_into()
-                .expect("Could not fit offset value to type"),
+            offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: true,
             defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
             ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
@@ -45,47 +39,27 @@ macro_rules! define_property {
             // use associated function syntax for type checking
             name: ::core::ffi::CStr::as_ptr($name),
             info: $prop,
-            offset: ::core::mem::offset_of!($state, $field)
-                .try_into()
-                .expect("Could not fit offset value to type"),
+            offset: ::core::mem::offset_of!($state, $field) as isize,
             set_default: false,
             ..unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() }
         }
     };
 }
 
-#[repr(C)]
-pub struct Properties<const N: usize>(pub OnceLock<[Property; N]>, pub fn() -> [Property; N]);
-
-impl<const N: usize> Properties<N> {
-    pub fn as_mut_ptr(&mut self) -> *mut Property {
-        _ = self.0.get_or_init(self.1);
-        self.0.get_mut().unwrap().as_mut_ptr()
-    }
-}
-
 #[macro_export]
 macro_rules! declare_properties {
     ($ident:ident, $($prop:expr),*$(,)*) => {
-
-        const fn _calc_prop_len() -> usize {
+        pub static $ident: [$crate::bindings::Property; {
             let mut len = 1;
             $({
                 _ = stringify!($prop);
                 len += 1;
             })*
             len
-        }
-        const PROP_LEN: usize = _calc_prop_len();
-
-        fn _make_properties() -> [$crate::bindings::Property; PROP_LEN] {
-            [
-                $($prop),*,
-                    unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
-            ]
-        }
-
-        pub static mut $ident: $crate::device_class::Properties<PROP_LEN> = $crate::device_class::Properties(::std::sync::OnceLock::new(), _make_properties);
+        }] = [
+            $($prop),*,
+            unsafe { ::core::mem::MaybeUninit::<$crate::bindings::Property>::zeroed().assume_init() },
+        ];
     };
 }
 
-- 
2.47.0


