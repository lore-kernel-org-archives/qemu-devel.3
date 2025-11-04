Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7BCCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwg-0007g8-Sh; Tue, 04 Nov 2025 11:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwN-0007ct-Pp
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwI-0003zf-KN
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjIcfLdvLe3Kq7hGsddlUyAZz5HeU5g0QLiH7INvZwM=;
 b=PrMjQEK5MLrj5x1BnzEVvUKv1CrmtXJ7d2OJBJMlgkNwAE39s7rgRxjrpRb0Jt0gBEAgox
 RR3iAINt6UxRoa1jqL1wQhVD+0j4o7pXU5muczcijQ2gasP8NeZb6PK5GdXJCNjNIbf2va
 LYxZLZsde83XoriEF62wEEGEfN+97O0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-0IR5SQRoPkq1-AYPv_DHhQ-1; Tue, 04 Nov 2025 11:31:18 -0500
X-MC-Unique: 0IR5SQRoPkq1-AYPv_DHhQ-1
X-Mimecast-MFC-AGG-ID: 0IR5SQRoPkq1-AYPv_DHhQ_1762273877
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b448c864d45so532432766b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273876; x=1762878676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjIcfLdvLe3Kq7hGsddlUyAZz5HeU5g0QLiH7INvZwM=;
 b=m7wchAK5GLUJj14FE4Oe6Zk4zHd8HWguFjcTwrJCLM7rhqt9xg1qZo6qgj1RVKdVOO
 EHktAE8Z2ynPHhH95JMxAl1VYlkWvfDuV/ImIIjBIk1/kVkKOpJTPQ1iL90ecIyA60cd
 MzRF/MQ6ui0ozSpQp/ndfzIOuP84rBhsOznUARSsuyZUAAORx8RiQ+M/oq2Gp8h/aVVV
 8jxGp2rdQCKibDM/7Hs1iIY97w/Z4nkOgJveGIMn7xakKCUHfWcxW8FWj738nw7+MO+A
 cBEtIeX16fEDENJYSN5bdqTaV1pGsRXh1tk+aezJqr5RZNKghp6v2Q6lCIuxhkYmCmpr
 cjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273876; x=1762878676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjIcfLdvLe3Kq7hGsddlUyAZz5HeU5g0QLiH7INvZwM=;
 b=lWYE+FD2UXQjzy0ZODe52qDs0GCzJ/YpNkAdHMDIaBEWxYgSd92Q0fLoLP1hAAQdrc
 3a5zds7wFhFel2OLZrg7CUvsOAJg9uiML1GOhmnqlEVA7WIEaK8sdCDnFSbEtBYxn10c
 eLD+M2Iwxq2hou5lYpZ7rswDuOnC2i1GcfBEdFCwxJkQwF/gfBFFhDf/PaNgV+ifIl0b
 cQ3MIQ5PNuskIsz6PsGLu1J3O+IqEZNuy9eouxxURdIRL5gf46qZ/C2NbUNwMNI1jvxJ
 OM8oXNkg6F5C3NEFh/idc42/UbV4liese0IVqWDYA/1bDgSSKuGgXz4KC8D0Zbtfcvd2
 rf4g==
X-Gm-Message-State: AOJu0YyNc7+glzsrT/quTcKbmTgYGvtOBQy9bGW1U7upmXK9lDlrrYUq
 AAFSw9mtTBrehGVO69waHV2LTkGclRTB7zO508nKLbYS1xQ24hETF8bIZOpyrFayuzSNA1obE2v
 MZ2+nPG4zAuBzHoZJvgsYi3TFa2Z4VG4UQi/VXS64lZQWBis5atVM6/OyT31siKfNvZheu/vdZa
 RplAtJgylxzEyx6NVKbD1bdUIMzdRGEXNPM9UmEuC1
X-Gm-Gg: ASbGnctu1giWAiWLVhaDi7UAobUMQZMquwgi2r0ky3hfSn5HwnLrOdjFd30ZWHiFb9Z
 /nMRNEspch4NmheuVJneL+M0cbpeKwlL9OcAbnDTdQRnPAiSTFHLzCvlzMKc8PdWfdk2/CBoTNi
 x09yO4vbbbyYAA1l+98PVxumXVPWgPWuEmLVqLw3xNCnGApsSNDvN93/sm23FJ3TAHiDoF6SPSx
 L0CIpujKFHDLmtJUHdoV9ILUYq/o8KW+gjmm4J0qa2OK6TxtAlTKQnFOelsVN0JWIs2BBOICsSG
 Iav0cgYH0GM63/ljYctXZc/glUp/u0ZxmXkAukWFXWL/8yFTObmPF23syOuiCgM/pJ+PcA1R0k3
 VyyHXFnD6r0lY00dB4GBxqhbsulvxDlv2B07hoM+TO+mjBe6q6HTm22Kfpdd1UALneSOdLySt9d
 ukMGcs
X-Received: by 2002:a17:906:6a21:b0:b3c:bd91:28a4 with SMTP id
 a640c23a62f3a-b70701c77b9mr1674699166b.28.1762273876382; 
 Tue, 04 Nov 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLmBHtEgcUwSIVU7aW7EucrM39V4zDnnFiAIgwlGJchSXd82rTJV4No1ow5l8krtxVu36bSA==
X-Received: by 2002:a17:906:6a21:b0:b3c:bd91:28a4 with SMTP id
 a640c23a62f3a-b70701c77b9mr1674694866b.28.1762273875739; 
 Tue, 04 Nov 2025 08:31:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7240348d93sm244436066b.68.2025.11.04.08.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 5/8] rust: pull error_fatal out of
 SysbusDeviceMethods::sysbus_realize
Date: Tue,  4 Nov 2025 17:30:59 +0100
Message-ID: <20251104163102.738889-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Return a Result<()> from the method, and "unwrap" it into error_fatal
in the caller.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  4 ++--
 rust/hw/core/src/sysbus.rs       | 13 ++++++-------
 rust/util/src/error.rs           | 31 ++++++++++++++++++++++++++++++-
 rust/util/src/lib.rs             |  2 +-
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5e9b13fdf92..04155dabe1a 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -17,7 +17,7 @@
 };
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
 use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
-use util::{log::Log, log_mask_ln};
+use util::{log::Log, log_mask_ln, ResultExt};
 
 use crate::registers::{self, Interrupt, RegisterOffset};
 
@@ -697,7 +697,7 @@ pub fn post_load(&self, _version_id: u8) -> Result<(), migration::InvalidError>
         let chr = unsafe { Owned::<Chardev>::from(&*chr) };
         dev.prop_set_chr("chardev", &chr);
     }
-    dev.sysbus_realize();
+    dev.sysbus_realize().unwrap_fatal();
     dev.mmio_map(0, addr);
     dev.connect_irq(0, &irq);
 
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index 282315fce99..68165e89295 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -4,12 +4,13 @@
 
 //! Bindings to access `sysbus` functionality from Rust.
 
-use std::{ffi::CStr, ptr::addr_of_mut};
+use std::ffi::CStr;
 
 pub use bindings::SysBusDeviceClass;
 use common::Opaque;
 use qom::{prelude::*, Owned};
 use system::MemoryRegion;
+use util::{Error, Result};
 
 use crate::{
     bindings,
@@ -107,14 +108,12 @@ fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
         }
     }
 
-    fn sysbus_realize(&self) {
-        // TODO: return an Error
+    fn sysbus_realize(&self) -> Result<()> {
         assert!(bql::is_locked());
         unsafe {
-            bindings::sysbus_realize(
-                self.upcast().as_mut_ptr(),
-                addr_of_mut!(util::bindings::error_fatal),
-            );
+            Error::with_errp(|errp| {
+                bindings::sysbus_realize(self.upcast().as_mut_ptr(), errp);
+            })
         }
     }
 }
diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index 346577e2e53..4edceff42f3 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -38,7 +38,8 @@
     ffi::{c_char, c_int, c_void, CStr},
     fmt::{self, Display},
     ops::Deref,
-    panic, ptr,
+    panic,
+    ptr::{self, addr_of_mut},
 };
 
 use foreign::{prelude::*, OwnedPointer};
@@ -231,6 +232,34 @@ pub unsafe fn with_errp<T, F: FnOnce(&mut *mut bindings::Error) -> T>(f: F) -> R
     }
 }
 
+/// Extension trait for `std::result::Result`, providing extra
+/// methods when the error type can be converted into a QEMU
+/// Error.
+pub trait ResultExt {
+    /// The success type `T` in `Result<T, E>`.
+    type OkType;
+
+    /// Report a fatal error and exit QEMU, or return the success value.
+    /// Note that, unlike [`unwrap()`](std::result::Result::unwrap), this
+    /// is not an abort and can be used for user errors.
+    fn unwrap_fatal(self) -> Self::OkType;
+}
+
+impl<T, E> ResultExt for std::result::Result<T, E>
+where
+    Error: From<E>,
+{
+    type OkType = T;
+
+    fn unwrap_fatal(self) -> T {
+        // SAFETY: errp is valid
+        self.map_err(|err| unsafe {
+            Error::from(err).propagate(addr_of_mut!(bindings::error_fatal))
+        })
+        .unwrap()
+    }
+}
+
 impl FreeForeign for Error {
     type Foreign = bindings::Error;
 
diff --git a/rust/util/src/lib.rs b/rust/util/src/lib.rs
index 16c89b95174..d14aa14ca77 100644
--- a/rust/util/src/lib.rs
+++ b/rust/util/src/lib.rs
@@ -6,4 +6,4 @@
 pub mod module;
 pub mod timer;
 
-pub use error::{Error, Result};
+pub use error::{Error, Result, ResultExt};
-- 
2.51.1


