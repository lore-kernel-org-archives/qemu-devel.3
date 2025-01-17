Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41077C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiF7-0002tL-Cn; Fri, 17 Jan 2025 04:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiF0-0002ag-At
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:02:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYiEx-0008Bi-9S
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737104526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcKUQtrDueRo7pBQ0SWKWSoQ8r+x6BtzsurQvn4mXbk=;
 b=JKq3n+1XRUMf1oW5o96wzsM923qsimntJRhspO9/TecPZesEY2Jv1wXdK9A1cP1UOpCVep
 OADDb9b7fmq2j+eGxoYJg6DerYBQ6o09T4aENtOvgOOpZZVoxRjYtvWiXW8EIo7gJHi1kX
 ZCgP0o4z9SZoIzaE/5XDE9IOPhQUM0c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-k64KPMpxN_Kur8GO7tj0QA-1; Fri, 17 Jan 2025 04:00:57 -0500
X-MC-Unique: k64KPMpxN_Kur8GO7tj0QA-1
X-Mimecast-MFC-AGG-ID: k64KPMpxN_Kur8GO7tj0QA
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa6a7bea04cso142818966b.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:00:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737104456; x=1737709256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcKUQtrDueRo7pBQ0SWKWSoQ8r+x6BtzsurQvn4mXbk=;
 b=cfBzl7Jb9p+kZ8j1SP32FgmtNbzuhlZu0j/cfoQBoZjArnO6C/lozg8SAQwc/Vnqfv
 8iVUCrlFdNv1HSx5PzddZdg9jTqSkf+ahCjH0VCDD5g7Gc3XFdxnYRS04Yu7kilHcjTx
 n7ILzfE3kmNKms1w+9RwxT7wWYnlbIpTDBMZhjhdtvm/4q+hkB8S99kJXVu4ikxJ2IDZ
 Qq1j7YhQ9awRsO0aw2zqE2CyHgf66tXfYusFgYr/f+PcNZ9o8HyLPXethnPY095UyD27
 IdPMdndKRFWeFiA6nV9f4RYo7bWRvtNJucDj0YZQEsB+sv1u0r+G1CyWjknIcUKfwrVZ
 NkIg==
X-Gm-Message-State: AOJu0YwKIFnCC2Ssk2BsB6CkZYXvViu/4w22QUU6jYQvza5ehA6PiZte
 iiUcsTUFpPM958KGe67/KgGRFktrpTa1XXM2RevdaeQHpSvTUG4uZICvpI/kbMFOZAMmwZqUBPp
 CxNV/1aMlhy9wO5pF4sqcUAn0rHM9IqsWNEV/O07zgj6EJpMCwIrnBsskrf9TZR4IJlm3vl12zQ
 m4BQD2ImS1MvED9E3fiMITevog2mYIsSMXoE7tnAo=
X-Gm-Gg: ASbGnctBp86uldt2SGBh6CrHgjSWqnfx+VQc4JT9mjf9U/g3SwKyQslhROghCuBdOUw
 oKkC9cdTCDmqQFZhmLQTm429UhfXxMQJHVopyL0ceGaQlK3scdDc3q9K2vlHaxgGzyvp0CVuO+/
 2gY+zjj0rcwzHwNqWcYpM6uTaQa1+rovRS5C8W7+whx9g6brL7NbhW5FEPFRj/zFWNgcaYJU1qu
 HR1T1Ae46ECsLM0lisjlOeErxw3iug7cF36T6bfAQ0Gii3BWPqNHsSqq+Xj
X-Received: by 2002:a17:907:7e92:b0:aab:eefc:92e5 with SMTP id
 a640c23a62f3a-ab38b1f33e1mr162784566b.14.1737104455598; 
 Fri, 17 Jan 2025 01:00:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ7Vgh8tE9VcpYMeLU4Fo6rPJMcIyAgL7R/UTRL3pnynHVBJn2jPO6XB7YvXYDHkRMvb27Dw==
X-Received: by 2002:a17:907:7e92:b0:aab:eefc:92e5 with SMTP id
 a640c23a62f3a-ab38b1f33e1mr162778966b.14.1737104454943; 
 Fri, 17 Jan 2025 01:00:54 -0800 (PST)
Received: from [192.168.10.3] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c5700bsm135155566b.24.2025.01.17.01.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 01:00:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	qemu-rust@nongnu.org
Subject: [PATCH 02/10] rust: vmstate: implement VMState for non-leaf types
Date: Fri, 17 Jan 2025 10:00:38 +0100
Message-ID: <20250117090046.1045010-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117090046.1045010-1-pbonzini@redhat.com>
References: <20250117090046.1045010-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Arrays, pointers and cells use a VMStateField that is based on that
for the inner type.  The implementation therefore delegates to the
VMState implementation of the inner type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 79 +++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index b839a7d6b7f..abe15c96011 100644
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
@@ -102,6 +103,15 @@ macro_rules! vmstate_of {
     };
 }
 
+impl VMStateFlags {
+    const VMS_VARRAY_FLAGS: VMStateFlags = VMStateFlags(
+        VMStateFlags::VMS_VARRAY_INT32.0 |
+        VMStateFlags::VMS_VARRAY_UINT8.0 |
+        VMStateFlags::VMS_VARRAY_UINT16.0 |
+        VMStateFlags::VMS_VARRAY_UINT32.0
+    );
+}
+
 // Add a couple builder-style methods to VMStateField, allowing
 // easy derivation of VMStateField constants from other types.
 impl VMStateField {
@@ -111,6 +121,73 @@ pub const fn with_version_id(mut self, version_id: i32) -> Self {
         self.version_id = version_id;
         self
     }
+
+    #[must_use]
+    pub const fn with_array_flag(mut self, num: usize) -> Self {
+        assert!(num <= 0x7FFF_FFFFusize);
+        assert!((self.flags.0 & VMStateFlags::VMS_ARRAY.0) == 0);
+        assert!((self.flags.0 & VMStateFlags::VMS_VARRAY_FLAGS.0) == 0);
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
+// Note that references are not supported, though references to cells
+// could be allowed.
+
+macro_rules! impl_vmstate_pointer {
+    ($type:ty where $base:tt: VMState $($where:tt)*) => {
+        unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
+            const BASE: VMStateField = <$base as VMState>::BASE.with_pointer_flag();
+        }
+    };
+}
+
+impl_vmstate_pointer!(*const T where T: VMState);
+impl_vmstate_pointer!(*mut T where T: VMState);
+impl_vmstate_pointer!(NonNull<T> where T: VMState);
+
+// Unlike C pointers, Box is always non-null therefore there is no need
+// to specify VMS_ALLOC.
+impl_vmstate_pointer!(Box<T> where T: VMState);
+
+// Arrays using the underlying type's VMState plus
+// VMS_ARRAY/VMS_ARRAY_OF_POINTER
+
+unsafe impl<T: VMState, const N: usize> VMState for [T; N] {
+    const BASE: VMStateField = <T as VMState>::BASE.with_array_flag(N);
 }
 
 #[doc(alias = "VMSTATE_UNUSED_BUFFER")]
-- 
2.47.1


