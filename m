Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4108E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 00:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSQ3A-0003NC-DI; Mon, 30 Dec 2024 19:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ37-0003Md-93
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tSQ33-0001xr-V4
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 19:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735604629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Fu9qvACQbuwh95JzWOQa80TwLOYjoE9iF7rJ1YNRcg=;
 b=P/ESo/DHgnKXhWwiFCysbLAnviDNFsG0f8zouK+rh8Pq/BDHagE6w+n+S4fXvKP7n41yJ8
 OO3T+bzkSrH6QwzXwymBubeqi4qKcXnAtfO57xDTKM78X247oshFkqjcX3k6wQULL/gn1I
 T9l7onoMZUCKMQS+jdwES9oG5qbjqQo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-fK_g3WJlNVmwHYTyYIMPfg-1; Mon, 30 Dec 2024 19:23:46 -0500
X-MC-Unique: fK_g3WJlNVmwHYTyYIMPfg-1
X-Mimecast-MFC-AGG-ID: fK_g3WJlNVmwHYTyYIMPfg
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38a540ea7c1so726275f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 16:23:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735604624; x=1736209424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Fu9qvACQbuwh95JzWOQa80TwLOYjoE9iF7rJ1YNRcg=;
 b=szaqNSiX44S3pSkh4rg1FbOmbi46q5TH2cZIqqVATuGBVpmXinZgB540rlVvVEy2Vv
 +CP/997zGjFTAn6Z+0VrTC6CYmctiNiqlJ+AMedbER3ChLj/DcMpFUNyTNO4KwNhxL+c
 deuqf45w8Qh+gt/wQWSk5l5wSK1tF+HpMdwJH9fQwyqKVVAXmuLoEjoPCr+R4Fs0SN84
 rtsVeh8PFRj1Ps1bQGheIyhqnvlWqnTD8j3RHF/VtDAKu3WNUUbWpT6RGbhwBSbqFnNS
 DIPnyDaJODdiL2+ljJF/gIDXy8t43D+CmgOlZEANR6KP6Rok0AFpA4Zm2E4g6ye1DMQk
 NLag==
X-Gm-Message-State: AOJu0YzVcKqzqTHmo12EiaKCt88Bkg+EjZhA3Df0U1PnPvzsgBGla47P
 UtV6EYmmqfBttrQTVDRDGYqV5gkcRGDKZCc5rfGSl2VjIV4MqNZJWqfB600yP9h3G1fbeHDYisQ
 Ym37kKRZedrf+trD/mXBO1JQKi8zvqEkE+4CmUhICdpCwtUzX6dqkzphcl4hoTu6kIifs+NMuyp
 m133hF/f0nvuqcejLT4MhxRcOK2OPVssJr1zD5Wr4=
X-Gm-Gg: ASbGncvU+jDeTB2h/JtDDwdIBa3FV4UDdo9t9qrqwSvy8SMP9t3gth8beTGKReEEqyG
 7DfRMXs7pllKtAw6RwXZbzp9rsz7yXiiMLYJ/kKRkrG760JaSEkXzIWwPhSQ3uwrs/RDyU8YzKl
 jTNwoZ5YwfS/DQjZ9LCA6PgC5jBhy5OcJppl3ANqKPsEku0N92ohkjJVnT3tRPxYXXUMn+uBd/x
 KjaGg7km9IQRVcY9kygktssdy+6PFybF2s1ie0bjSl1nGDXA5KeDmYXSWk=
X-Received: by 2002:a05:6000:154d:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-38a221fe106mr36711157f8f.35.1735604623824; 
 Mon, 30 Dec 2024 16:23:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkX0qw5aMnHDsAZCYl2xPPTUYBILaP+RU6Wv1Q5eGQxDredEQO8S1d7G6wVi3LI9tOOJR0fw==
X-Received: by 2002:a05:6000:154d:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-38a221fe106mr36711138f8f.35.1735604623358; 
 Mon, 30 Dec 2024 16:23:43 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828f5fsm31710670f8f.8.2024.12.30.16.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 16:23:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [RFC PATCH 2/9] rust: vmstate: implement VMState for non-leaf types
Date: Tue, 31 Dec 2024 01:23:29 +0100
Message-ID: <20241231002336.25931-3-pbonzini@redhat.com>
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

Arrays, pointers and cells use a VMStateField that is based on that
for the inner type.  The implementation therefore delegates to the
VMState implementation of the inner type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 66 +++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index bfcf06e8f1d..e20f27b172b 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -19,8 +19,9 @@
 //!   `include/migration/vmstate.h`. These are not type-safe and should not be
 //!   used if the equivalent functionality is available with `vmstate_of!`.
 
-use core::marker::PhantomData;
+use core::{marker::PhantomData, mem, ptr::NonNull};
 
+use crate::bindings::VMStateFlags;
 pub use crate::bindings::{VMStateDescription, VMStateField};
 
 /// This macro is used to call a function with a generic argument bound
@@ -108,6 +109,69 @@ pub const fn with_version_id(mut self, version_id: i32) -> Self {
         self.version_id = version_id;
         self
     }
+
+    #[must_use]
+    pub const fn with_array_flag(mut self, num: usize) -> Self {
+        assert!(num <= 0x7FFF_FFFFusize);
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
+        if (self.flags.0 & VMStateFlags::VMS_POINTER.0) != 0 {
+            self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_POINTER.0);
+            self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY_OF_POINTER.0);
+        }
+        self.flags = VMStateFlags(self.flags.0 & !VMStateFlags::VMS_SINGLE.0);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_ARRAY.0);
+        self.num = num as i32;
+        self
+    }
+
+    #[must_use]
+    pub const fn with_pointer_flag(mut self) -> Self {
+        assert!((self.flags.0 & VMStateFlags::VMS_POINTER.0) == 0);
+        self.flags = VMStateFlags(self.flags.0 | VMStateFlags::VMS_POINTER.0);
+        self
+    }
+}
+
+// Transparent wrappers: just use the internal type
+
+macro_rules! impl_vmstate_transparent {
+    ($type:ty where $base:tt: VMState $($where:tt)*) => {
+        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const BASE: VMStateField = VMStateField {
+                size: mem::size_of::<$type>(),
+                ..<$base as VMState>::BASE
+            };
+        }
+    };
+}
+
+impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
+impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
+impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
+
+// Pointer types using the underlying type's VMState plus VMS_POINTER
+
+macro_rules! impl_vmstate_pointer {
+    ($type:ty where $base:tt: VMState $($where:tt)*) => {
+        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
+            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
+        }
+    };
+}
+
+impl_vmstate_pointer!(*const T where T: VMState);
+impl_vmstate_pointer!(*mut T where T: VMState);
+impl_vmstate_pointer!(NonNull<T> where T: VMState);
+impl_vmstate_pointer!(Option<NonNull<T>> where T: VMState);
+
+// Arrays using the underlying type's VMState plus
+// VMS_ARRAY/VMS_ARRAY_OF_POINTER
+
+unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
+    const SCALAR_TYPE: VMStateFieldType = <T as VMState>::SCALAR_TYPE;
+    const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
 }
 
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
-- 
2.47.1


