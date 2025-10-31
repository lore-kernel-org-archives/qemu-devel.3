Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23174CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr15-0001CU-G1; Fri, 31 Oct 2025 11:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr12-0001Ba-Hs
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0u-0000pK-0h
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y54ade2XN2F/JSqNfaUsi9myG2OIy0vlK46SL95guqc=;
 b=XZ2FIXtPZYzGwdJONG8VbOTw9OcYNEeXNaWhgMtwIpZbOCY2vmDQNDXLkJXjZD+TPTtZfC
 Pdz5TFsMpYjgu+23WuPnV2vfgIxxSwNlYJkp1dBhwlc/0+ZyMWXLkWU0FOI0jFZczF9+yV
 anMfkhxziRqZ+Ixmo0078Oyg66Xyb+8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-q2KmYUX1M5CUmdEw9GPd0Q-1; Fri, 31 Oct 2025 11:25:56 -0400
X-MC-Unique: q2KmYUX1M5CUmdEw9GPd0Q-1
X-Mimecast-MFC-AGG-ID: q2KmYUX1M5CUmdEw9GPd0Q_1761924355
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4770e0910e4so16165825e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761924354; x=1762529154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y54ade2XN2F/JSqNfaUsi9myG2OIy0vlK46SL95guqc=;
 b=b4i65MEi/GVm3Hii/GBFt/9p77h0Vx4HRqqS1mGth//saMtCzwp4RKB5gVxZdbclWA
 14hrJtNQUn96SIVRtJqTZBz2t4rRsQB78BrT6GlLi0qUKWf8Sx4HoW3IzwToqnSPDkNC
 aGT42oBJbaDDf5eDUCP30LzGFXp9VsMWX7GsNaDWa79PJjfpTDot4MdNYjKUveUhZ5wx
 fk1GnGcB50gxP+y8BOMDGBO8pFIlY/LShUPNnvt+bcNX2sprPkF6A2TJnkApZGVEl3X4
 pIivRieLx9nN9HPIfhy5ToK5hvLHWqIrEeERQ0/yWB8WfT3QRo5rsIBKdjyN1fBDyqTn
 1yxA==
X-Gm-Message-State: AOJu0YzirojPl83kbdoQ7eAZhbzQXOsykTKKMGKSa4BrAXiNPGPfw/M/
 EC3T5hDoa2X+Ut65UPI/vs8eLGqy0iJOtZdly/g5IUEKfTn37jlTo28oYofQ6H/DUcrG1YoS1UN
 bse+Ak/BCyFKXx7KyuqBQfBWPgDAlBFR/JODLL5Q5Qo0AWpzasC234XxyzCdhbMI4xAVRJuOrh8
 hNHTCEfkgvCBdlObl7JNW+IIyHipLLxoL70pj/CJ08
X-Gm-Gg: ASbGncufGctfktWhJR0VfSyvrlEjzjH+FyDgGK+bpp1JNvBH7z/puTY/DdlyH/zdaP2
 TaFq7yuc8vxS/o8XU260UtucmP21IqIzLO9g8t9MI4yNozscjx7vMrFpKaB01yQ4SVCIPLWno4O
 P1YSmcF+V6GU/b20Dnen+87HyJtZmn8EH495kvOpVOzdYdjz4YmxFD/RRLVMXNXX3nXjw4JPq3r
 Uhn7NC4pO8QcitUc8sIjpoq3V78ftM31hpwdSPPRA6VIRtubDmEpm30B9si9hgI3MEEYA9eulm1
 KC6/MuX+4gfObESJn/M2uP7UcnHYX0+nzNJPcm3uWqknUPFuoXXXPVoOOic3dRI9B1+lupY8/iY
 e4cQE+UsHm4vaysrW3VlsTQ3XduOWMY5BbfG2T11Dz6rbA6lXByxOsGed3vwtNCZ202WrenoRZ5
 jZMkk7
X-Received: by 2002:a05:600c:8b32:b0:46e:37af:f90e with SMTP id
 5b1f17b1804b1-4773bfd5c53mr4646815e9.6.1761924354497; 
 Fri, 31 Oct 2025 08:25:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiF9cLOwqTbhei6ZD8E5j2VEgtk6DkFVBUlIx/9wGnm5I0w+yDV9H7hne6mXSLPf5FKO68nA==
X-Received: by 2002:a05:600c:8b32:b0:46e:37af:f90e with SMTP id
 5b1f17b1804b1-4773bfd5c53mr4646495e9.6.1761924354023; 
 Fri, 31 Oct 2025 08:25:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383ba6sm2721745e9.10.2025.10.31.08.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:25:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/4] rust: pull error_fatal out of
 SysbusDeviceMethods::sysbus_realize
Date: Fri, 31 Oct 2025 16:25:39 +0100
Message-ID: <20251031152540.293293-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031152540.293293-1-pbonzini@redhat.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  4 ++--
 rust/hw/core/src/sysbus.rs       | 13 ++++++-------
 rust/util/src/error.rs           | 31 ++++++++++++++++++++++++++++++-
 rust/util/src/lib.rs             |  2 +-
 4 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5e9b13fdf92..26be6ef57f2 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -17,7 +17,7 @@
 };
 use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
 use system::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder};
-use util::{log::Log, log_mask_ln};
+use util::{ResultExt, log::Log, log_mask_ln};
 
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


