Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4652E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3B-0003O9-Hv; Mon, 30 Dec 2024 19:23:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ35-0003MZ-Qe
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ32-0001xU-7o
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yrvskb2D803b6Tb5PEEJxzJcjtmA0kgwvizPrvOFV8=;
 b=RhOxg43INTddAfMiHaiSl1aCSlpCL9NyqclKYqqcLbFh4ZaHtiDz4TwuG/43549NE53cCn
 888OpJ4YsmXQj1XAS1YKpqzUSUB9FaDFV5yon9Xh4it+u3BdkSs0M/wLpIPQJDpjHkTxA4
 zPJcUKkyBhUg3XICfXccF2wHX7+j9MI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-iRKEXAKgPQq22oZrcMJoSQ-1; Mon, 30 Dec 2024 19:23:43 -0500
X-MC-Unique: iRKEXAKgPQq22oZrcMJoSQ-1
X-Mimecast-MFC-AGG-ID: iRKEXAKgPQq22oZrcMJoSQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so5570401f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604622; x=1736209422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yrvskb2D803b6Tb5PEEJxzJcjtmA0kgwvizPrvOFV8=;
 b=vhPMAamWsbRIyCI8Z+F+0LbVDSHwfIQt2nX4zPj6D5yC5DqetdkCOFHw5gVEQms1wg
 OV8a0DAQoD6Gze2r3U65NrdJwWBExsUr3NcLFm0NNWcIK/5p2rWNlwMN/6jrZTKYbcyN
 qFnRTSPSN0K469/q0p8u22+n43N12QPt9/+9tfjKR80+VULKYCFmAQNoY9P5B6ujkNV+
 +NEbLBXFr0sr6GVzhORrBioMy4GWERMZSMd1hRk7G8hzprrqTStKuEIbfSHoGPV8Yy9Y
 +DJmKX7NhN3CP65tig3TOw36kshlJPUPCIMgyPu4kngp39tgct3gv+IU0T5lynvHriE2
 3o4g==
X-Gm-Message-State: AOJu0YzdZuEtyf2o4k0o8VpDj4isUN6sqM9fB1Ep83//xvFD+gTVIXZU
 CZ6T+5sJu560DX9g5eiZI3lr6bKK1E4s/4wqWgstKFiACjXraZ/PgyHuVAgJp1tLRe6fbYEa1fV
 1QUkAAcjauzLnkNBFT7dKjY5K35Uda93NRMvyFa6HmNI7ulrUgEtOXwxgllw5WJIGUlfIfctdZg
 9Imp9r4Ko7PAHkT/8zySv8swxBiqKPcWDLLjh8f6k=
X-Gm-Gg: ASbGncsWwnF3GKoKAPFNDiw9Xp4jIcf6bymnFTY0U2lf86xVLC2gv89sEtRHCJwhfdE
 WQLuFllIv9gXdVlOhzj0b/iPEclGb7un9tU47z/ye7oZfwA/GhaXVGOTc/YvcQnSaBJryvZJ/Lo
 adnNc2Qjul49EqpLSQu/luIrUx215mDP9EPjI/rixeydVvLuXMb49UiwR/lWrCU8+OIRqw6Yfm9
 ir0IvqL5iB7mcxvhrasf7OgA5ZOIgOfpVn64Rs9FXeXJVfuD40v8lo9vmo=
X-Received: by 2002:a05:6000:186d:b0:386:1cd3:8a08 with SMTP id
 ffacd0b85a97d-38a221ed256mr35915088f8f.5.1735604621666; 
 Mon, 30 Dec 2024 16:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtl/T8uUgFQg3X/UlgbxZp9ebALLEi3aH1NNheYA7s6VWC6o0Xpyqr53UDpwCeVGVOLm+POg==
X-Received: by 2002:a05:6000:186d:b0:386:1cd3:8a08 with SMTP id
 ffacd0b85a97d-38a221ed256mr35915070f8f.5.1735604621252; 
 Mon, 30 Dec 2024 16:23:41 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8332absm30926426f8f.38.2024.12.30.16.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 1/9] rust: vmstate: add new type safe implementation
Date: Tue, 31 Dec 2024 01:23:28 +0100
Message-ID: <20241231002336.25931-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231002336.25931-1-pbonzini@redhat.com>
References: <20241231002336.25931-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The existing translation of the C macros for vmstate does not make
any attempt to type-check vmstate declarations against the struct, so
introduce a new system that computes VMStateField based on the actual
struct declaration.

Macros do not have full access to the type system, therefore a full
implementation of this scheme requires a helper trait to analyze the
type and produce a VMStateField from it; a macro "vmstate_of!" accepts
arguments similar to "offset_of!" and tricks the compiler into looking
up the trait for the right type.

The patch introduces not just vmstate_of!, but also the slightly too
clever enabling macro call_func_with_field!.  The particular trick used
here was proposed on the users.rust-lang.org forum, so I take no merit
and all the blame.

Introduce the trait and some functions to access it; the actual
implementation comes later.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/prelude.rs |   2 +
 rust/qemu-api/src/vmstate.rs | 110 +++++++++++++++++++++++++++++++++--
 2 files changed, 106 insertions(+), 6 deletions(-)

diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 4ea70b9c823..2dc86e19b29 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -18,3 +18,5 @@
 pub use crate::qom_isa;
 
 pub use crate::sysbus::SysBusDeviceMethods;
+
+pub use crate::vmstate::VMState;
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 63c897abcdf..bfcf06e8f1d 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -4,13 +4,111 @@
 
 //! Helper macros to declare migration state for device models.
 //!
-//! Some macros are direct equivalents to the C macros declared in
-//! `include/migration/vmstate.h` while
-//! [`vmstate_subsections`](crate::vmstate_subsections) and
-//! [`vmstate_fields`](crate::vmstate_fields) are meant to be used when
-//! declaring a device model state struct.
+//! This module includes three families of macros:
+//!
+//! * [`vmstate_unused!`](crate::vmstate_unused) and
+//!   [`vmstate_of!`](crate::vmstate_of), which are used to express the
+//!   migration format for a struct.  This is based on the [`VMState`] trait,
+//!   which is defined by all migrateable types.
+//!
+//! * helper macros to declare a device model state struct, in particular
+//!   [`vmstate_subsections`](crate::vmstate_subsections) and
+//!   [`vmstate_fields`](crate::vmstate_fields).
+//!
+//! * direct equivalents to the C macros declared in
+//!   `include/migration/vmstate.h`. These are not type-safe and should not be
+//!   used if the equivalent functionality is available with `vmstate_of!`.
 
-pub use crate::bindings::VMStateDescription;
+use core::marker::PhantomData;
+
+pub use crate::bindings::{VMStateDescription, VMStateField};
+
+/// This macro is used to call a function with a generic argument bound
+/// to the type of a field.  The function must take a
+/// [`PhantomData`]`<T>` argument; `T` is the type of
+/// field `$field` in the `$typ` type.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::call_func_with_field;
+/// # use core::marker::PhantomData;
+/// const fn size_of_field<T>(_: PhantomData<T>) -> usize {
+///     std::mem::size_of::<T>()
+/// }
+///
+/// struct Foo {
+///     x: u16,
+/// };
+/// // calls size_of_field::<u16>()
+/// assert_eq!(call_func_with_field!(size_of_field, Foo, x), 2);
+/// ```
+#[macro_export]
+macro_rules! call_func_with_field {
+    ($func:expr, $typ:ty, $($field:tt).+) => {
+        $func(loop {
+            #![allow(unreachable_code)]
+            const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> { ::core::marker::PhantomData }
+            // Unreachable code is exempt from checks on uninitialized values.
+            // Use that trick to infer the type of this PhantomData.
+            break ::core::marker::PhantomData;
+            break phantom__(&{ let value__: $typ; value__.$($field).+ });
+        })
+    };
+}
+
+/// A trait for types that can be included in a device's migration stream.  It
+/// provides the base contents of a `VMStateField` (minus the name and offset).
+///
+/// # Safety
+///
+/// The contents of this trait go straight into structs that are parsed by C
+/// code and used to introspect into other structs.  Be careful.
+pub unsafe trait VMState {
+    /// The base contents of a `VMStateField` (minus the name and offset) for
+    /// the type that is implementing the trait.
+    const BASE: VMStateField;
+}
+
+/// Internal utility function to retrieve a type's `VMStateField`;
+/// used by [`vmstate_of!`](crate::vmstate_of).
+pub const fn vmstate_base<T: VMState>(_: PhantomData<T>) -> VMStateField {
+    T::BASE
+}
+
+/// Return the `VMStateField` for a field of a struct.  The field must be
+/// visible in the current scope.
+///
+/// In order to support other types, the trait `VMState` must be implemented
+/// for them.
+#[macro_export]
+macro_rules! vmstate_of {
+    ($struct_name:ty, $field_name:ident $(,)?) => {
+        $crate::bindings::VMStateField {
+            name: ::core::concat!(::core::stringify!($field_name), "\0")
+                .as_bytes()
+                .as_ptr() as *const ::std::os::raw::c_char,
+            offset: $crate::offset_of!($struct_name, $field_name),
+            // Compute most of the VMStateField from the type of the field.
+            ..$crate::call_func_with_field!(
+                $crate::vmstate::vmstate_base,
+                $struct_name,
+                $field_name
+            )
+        }
+    };
+}
+
+// Add a couple builder-style methods to VMStateField, allowing
+// easy derivation of VMStateField constants from other types.
+impl VMStateField {
+    #[must_use]
+    pub const fn with_version_id(mut self, version_id: i32) -> Self {
+        assert!(version_id >= 0);
+        self.version_id = version_id;
+        self
+    }
+}
 
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
 #[macro_export]
-- 
2.47.1


