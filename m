Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666C9C61CE8
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Jun 2025 11:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQlQO-0003eo-6I; Sun, 15 Jun 2025 07:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQK-0003dv-Ld; Sun, 15 Jun 2025 07:21:16 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uQlQH-0007xw-U7; Sun, 15 Jun 2025 07:21:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so2952077f8f.2; 
 Sun, 15 Jun 2025 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749986471; x=1750591271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GOSazWwN655AIgokLtohZGPN+qL0XFCzquoeB/U0TnE=;
 b=LweUYbxypWkWvyuHKma4O5xBFKl9wQiX0EsPpF6JaMnQRlch60xfAcmj2FhwuRwKSe
 mNJD2uGEDCGnQXigXLkCBmFZpm0G8Pz3C1bgx81dqvydq7/HsfUmrq4M6Ms78oq8B6n3
 jb99ioPySMiEYid/Kwl9P6g9X2bgzTSOxNdSkJm0B7XSmGk9MOybDRyHGr39EFmi/uSP
 sWErApPJ3y3z6uQ8HH70pAQoVV0aLi0mZQ6srLnp3aW0bD2Iri6x9439uYR2js5N5kA1
 Ha+fGpyvdQneVxvzXhoJIu/PkiTmAWyzCxz0S4/lsU3U5f7SzpWUYoIvgJM1Jx+eAyBE
 AVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749986471; x=1750591271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GOSazWwN655AIgokLtohZGPN+qL0XFCzquoeB/U0TnE=;
 b=mluymFCNUww8lok4tE7PyrZ2q5jVwMrAAni5T/+JbBQBuNuuVAHzXi3diwJ7WUoRQI
 Mf4oyJaSNbTdUf0D2Xg7ugr6HC+TP9dd9RAkSO+AJ3R8Ss7pgRZ8I7Fm89/OS/0OzgBZ
 ZpIIANnWfqXRq9/MraInPJ+YKrDG3FkVJtzmYw9d0Q5AfoPWAT01RmNZMG80n4qtkWZb
 Bm/OWBVVSlP2mUZQwUwfrgeFhx8KLWioUCVqRAZXu1jXAB8cX1J4TJJc3cy8VFECgdZm
 H/A4JQRMTs0+x6g17zuAuIb8U43hD/sDg4Cb6aRRcByE0oBNSS4e47M2mb043wd0+qDx
 TTDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoo9OBgtS1famHev8eFf7BYukt7BopeaVP0yMjCxaCSxJPX1hhQYW6LmHlSg4VDTPxljK9AtwWioU=@nongnu.org
X-Gm-Message-State: AOJu0Yw7+bL5xSq0WykLCT/iTrjvfKOyprc/5VsbSzcv5e84d5rwPslU
 qzC5fwoFDe0Kk5Mb1FI9dbp23NrGWJsyJrxZO5QQt1pYyCxUZ0Gz0xu4/OAJZQ==
X-Gm-Gg: ASbGncuGHZk5WnXLHY88aVV0I+ij+V0/b59SSLg6AJor5gMc//sdXD4IPMsVH5AhXuF
 3M43Nd2pQ33GOcAU9z78AEa9RgB3/qL1dTVhqZ4LpphY2+v55WBJaH2k11qa0C+muNZTS/floW/
 6v8dsGAUt0yVJp6PRTnvTGJcTytTwALNh4qedz9uGBUe6Hz9UmlgFQwsXF2otAlNKTraa9xGb8u
 CnMRBuAqQrhTjdPJzGIQWdxgcFmbiJe/6IJbx5y8TTenYj3CuJc21DREA2nlaQ8lvmlCxcHCu9e
 NA4/pgfjcOn9mcEo2bqBZ8rcRrlJ12QyrNsP2hGHKp06DfBMi4i/2355xDdPgADVoi5PU6D791H
 POHCBRsTWnwFeazuNbCuLQI9963Z/OvSrICJRqFBzfWeb8GWkCxXMfYuyNISR2SWUoj3CaFRmy0
 8//Y1x1g==
X-Google-Smtp-Source: AGHT+IHRcKJm2uEfjPxwsJtfrZob2XRVen8PUExl2auoG8Byuob7lnyGPPHm9Q+KXzHbnGibo5Wx7w==
X-Received: by 2002:a05:6000:2dc3:b0:3a5:1471:d885 with SMTP id
 ffacd0b85a97d-3a572e58cb3mr4350729f8f.56.1749986471301; 
 Sun, 15 Jun 2025 04:21:11 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-231b-9b00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:231b:9b00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b5c372sm7327099f8f.89.2025.06.15.04.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Jun 2025 04:21:10 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 1/4] rust/qemu-api: Add initial logging support based on C
 API
Date: Sun, 15 Jun 2025 13:20:34 +0200
Message-ID: <20250615112037.11992-2-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250615112037.11992-1-shentey@gmail.com>
References: <20250615112037.11992-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A log_mask_ln!() macro is provided which expects similar arguments as the
C version. However, the formatting works as one would expect from Rust.

To maximize code reuse the macro is just a thin wrapper around
qemu_log(). Also, just the bare minimum of logging masks is provided
which should suffice for the current use case of Rust in QEMU.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/devel/rust.rst          |  1 +
 rust/wrapper.h               |  2 +
 rust/qemu-api/meson.build    |  1 +
 rust/qemu-api/src/lib.rs     |  1 +
 rust/qemu-api/src/log.rs     | 78 ++++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/prelude.rs |  2 +
 6 files changed, 85 insertions(+)
 create mode 100644 rust/qemu-api/src/log.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 47e9677fcb..dc8c44109e 100644
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
diff --git a/rust/wrapper.h b/rust/wrapper.h
index 6060d3ba1a..15a1b19847 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -48,6 +48,8 @@ typedef enum memory_order {
 #endif /* __CLANG_STDATOMIC_H */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/log-for-trace.h"
 #include "qemu/module.h"
 #include "qemu-io.h"
 #include "system/system.h"
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index cac8595a14..33caee3c4f 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -21,6 +21,7 @@ _qemu_api_rs = static_library(
       'src/errno.rs',
       'src/error.rs',
       'src/irq.rs',
+      'src/log.rs',
       'src/memory.rs',
       'src/module.rs',
       'src/prelude.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 93902fc94b..e20be35460 100644
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
index 0000000000..0d7f06e63c
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,78 @@
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
+/// use qemu_api::log::Log;
+/// use qemu_api::log_mask_ln;
+///
+/// let error_address = 0xbad;
+/// log_mask_ln!(
+///     Log::GuestError,
+///     "Address 0x{error_address:x} out of range"
+/// );
+/// ```
+///
+/// It is also possible to use printf-style formatting, as well as having a
+/// trailing `,`:
+///
+/// ```
+/// use qemu_api::log::Log;
+/// use qemu_api::log_mask_ln;
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
index 43bfcd5fca..8f9e23ee2c 100644
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


