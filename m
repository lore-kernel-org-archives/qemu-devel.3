Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFF4C7115D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeo7-0006aF-2E; Fri, 20 Jun 2025 12:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo4-0006Zj-TH
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeo1-0000Gv-Ty
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wUb33t/Ddy47dv9hj5zcbOKfPHOBFw+S7xvVBLDYZiQ=;
 b=SkPwrtrGdvblv2uMi8SQsoZCXzdoXqWaljpQku+yKw6va7W099rHn3Oj6twE7uEJ+xT1de
 7hxuGS9szXL55MFEG3qDwG3fOBKmiHLvHdUt/PtKItDmNipWuSxDI2p5nPdTzGfRVGU81o
 vWbN5Onbi92q7egUe+b5zNiHRYSwv2I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-B6Z7r6faNzCzAuvZBIm-cg-1; Fri, 20 Jun 2025 12:41:31 -0400
X-MC-Unique: B6Z7r6faNzCzAuvZBIm-cg-1
X-Mimecast-MFC-AGG-ID: B6Z7r6faNzCzAuvZBIm-cg_1750437690
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6023d9a86ffso1283070a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437689; x=1751042489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wUb33t/Ddy47dv9hj5zcbOKfPHOBFw+S7xvVBLDYZiQ=;
 b=CXiHHGL3bEyOUQgkYgeSi1V9y+x4ZieJHt+riTpfe72bYErm7YNU2HISWKnMru8xDP
 GQ9mSIoSaTOVdRL3WVtQmuUnQbmyk8JM+f3wwfdn21jcNSoSb+B085gv2ivDcpjYTCrI
 KYpm6IKk7R8sQnlQFkeAzolOwtieVnkRbqlcWa0A+wJMS3zeqGEX5IlwDuI3i7kcyEqa
 b3tY5ovRRxb9SsMtIbpEFTn56aSXh6av3djTVGc2eOHIydqBqheqW8XyIPQmRxnHrty6
 iult+VF/FPIO8nezWOVD8zPrjsOnpqC6ywP+lnEoTYA9fBVAR1SxQhQ3pIbUlFhwwRxY
 ArZg==
X-Gm-Message-State: AOJu0Yx/A8sjyljZbm/OfzNKNgYTV0+uC9p2ihVXcYJ7pj/KC/Ks2LqE
 mL+RYsnmsU/lakXq4SnFs9suNzpK3XcRd3h4MpVuHXWfzvnWfJe22SdI5dpnCF0yaqSEoxnNTp8
 wRWeN1SWXGzZKUcX2Y7D66RbZlVjgGF9i8GljVWF9fFIB8LIGbCFSrfrLWaIkKWJdLu8lEXaCIx
 d8G2YISwEE9Jmdy9FtfQ/UWYbRU8ufLxl85yU0fQRe
X-Gm-Gg: ASbGncsd0T7JQwNbsFc/2cw/IkUVOKX8Dnhl7AMlCJxViC7+RVFOOLlQuH2PXPwEJKD
 PlXTomg3NZ9y5gncTfRxwVWbQq9RwmSkm9zP4PgyxwR7ebVU/0nshFF313YBiLfTpudoZTLA5n6
 wFnjMbCrjv6epaAbCU2uxjQ+LHiQJ0Gv/QQk65yFmhVVBYYdQJb5KkLQMAtYvofN1YH1WxsC3xW
 X0NZtks2wMuP4svVHrUFryLYnPJhzuLhEfll8AVwVYbdvHnkNEujfxreabkQMZOjttoQ4X5eb5U
 p1p4LHNerFRewMNSyZtmGEdcTg==
X-Received: by 2002:a17:906:dc95:b0:ae0:16db:1b62 with SMTP id
 a640c23a62f3a-ae057c8e314mr344551866b.59.1750437688702; 
 Fri, 20 Jun 2025 09:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk5NiQkEvw3hQWWNAuMQ4R/Inc7qCXwqsyHVrmecTMyVzC4XHagtWPMwSTcTgWwRx08DL69g==
X-Received: by 2002:a17:906:dc95:b0:ae0:16db:1b62 with SMTP id
 a640c23a62f3a-ae057c8e314mr344548666b.59.1750437688076; 
 Fri, 20 Jun 2025 09:41:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae05408301fsm188247066b.96.2025.06.20.09.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:41:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 12/24] rust/qemu-api: Add initial logging support based on C API
Date: Fri, 20 Jun 2025 18:40:40 +0200
Message-ID: <20250620164053.579416-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

A log_mask_ln!() macro is provided which expects similar arguments as the
C version. However, the formatting works as one would expect from Rust.

To maximize code reuse the macro is just a thin wrapper around
qemu_log(). Also, just the bare minimum of logging masks is provided
which should suffice for the current use case of Rust in QEMU.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Link: https://lore.kernel.org/r/20250615112037.11992-2-shentey@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst          |  1 +
 rust/qemu-api/wrapper.h      |  2 +
 rust/qemu-api/meson.build    |  1 +
 rust/qemu-api/src/lib.rs     |  1 +
 rust/qemu-api/src/log.rs     | 73 ++++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/prelude.rs |  2 +
 6 files changed, 80 insertions(+)
 create mode 100644 rust/qemu-api/src/log.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 47e9677fcb0..dc8c44109e1 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -162,6 +162,7 @@ module           status
 ``errno``        complete
 ``error``        stable
 ``irq``          complete
+``log``          proof of concept
 ``memory``       stable
 ``module``       complete
 ``qdev``         stable
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 6060d3ba1ab..15a1b19847f 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -48,6 +48,8 @@ typedef enum memory_order {
 #endif /* __CLANG_STDATOMIC_H */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/log-for-trace.h"
 #include "qemu/module.h"
 #include "qemu-io.h"
 #include "system/system.h"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 5b8c7e5e8d5..a090297c458 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -62,6 +62,7 @@ _qemu_api_rs = static_library(
       'src/errno.rs',
       'src/error.rs',
       'src/irq.rs',
+      'src/log.rs',
       'src/memory.rs',
       'src/module.rs',
       'src/prelude.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index c78198f0f41..86dcd8ef17a 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -21,6 +21,7 @@
 pub mod errno;
 pub mod error;
 pub mod irq;
+pub mod log;
 pub mod memory;
 pub mod module;
 pub mod qdev;
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
new file mode 100644
index 00000000000..d6c3d6c1b63
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,73 @@
+// Copyright 2025 Bernhard Beschow <shentey@gmail.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for QEMU's logging infrastructure
+
+#[repr(u32)]
+/// Represents specific error categories within QEMU's logging system.
+///
+/// The `Log` enum provides a Rust abstraction for logging errors, corresponding
+/// to a subset of the error categories defined in the C implementation.
+pub enum Log {
+    /// Log invalid access caused by the guest.
+    /// Corresponds to `LOG_GUEST_ERROR` in the C implementation.
+    GuestError = crate::bindings::LOG_GUEST_ERROR,
+
+    /// Log guest access of unimplemented functionality.
+    /// Corresponds to `LOG_UNIMP` in the C implementation.
+    Unimp = crate::bindings::LOG_UNIMP,
+}
+
+/// A macro to log messages conditionally based on a provided mask.
+///
+/// The `log_mask_ln` macro checks whether the given mask matches the current
+/// log level and, if so, formats and logs the message. It is the Rust
+/// counterpart of the `qemu_log_mask()` macro in the C implementation.
+///
+/// # Parameters
+///
+/// - `$mask`: A log level mask. This should be a variant of the `Log` enum.
+/// - `$fmt`: A format string following the syntax and rules of the `format!`
+///   macro. It specifies the structure of the log message.
+/// - `$args`: Optional arguments to be interpolated into the format string.
+///
+/// # Example
+///
+/// ```
+/// use qemu_api::{log::Log, log_mask_ln};
+///
+/// let error_address = 0xbad;
+/// log_mask_ln!(Log::GuestError, "Address 0x{error_address:x} out of range");
+/// ```
+///
+/// It is also possible to use printf-style formatting, as well as having a
+/// trailing `,`:
+///
+/// ```
+/// use qemu_api::{log::Log, log_mask_ln};
+///
+/// let error_address = 0xbad;
+/// log_mask_ln!(
+///     Log::GuestError,
+///     "Address 0x{:x} out of range",
+///     error_address,
+/// );
+/// ```
+#[macro_export]
+macro_rules! log_mask_ln {
+    ($mask:expr, $fmt:tt $($args:tt)*) => {{
+        // Type assertion to enforce type `Log` for $mask
+        let _: Log = $mask;
+
+        if unsafe {
+            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+        } {
+            let formatted_string = format!("{}\n", format_args!($fmt $($args)*));
+            let c_string = std::ffi::CString::new(formatted_string).unwrap();
+
+            unsafe {
+                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
+            }
+        }
+    }};
+}
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 43bfcd5fcab..8f9e23ee2c5 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -11,6 +11,8 @@
 
 pub use crate::errno;
 
+pub use crate::log_mask_ln;
+
 pub use crate::qdev::DeviceMethods;
 
 pub use crate::qom::InterfaceType;
-- 
2.49.0


