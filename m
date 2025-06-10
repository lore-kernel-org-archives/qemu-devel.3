Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABD0C71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5TW-0008WU-2F; Tue, 10 Jun 2025 16:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5TL-0008VP-J1; Tue, 10 Jun 2025 16:21:28 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uP5TJ-0001JA-NL; Tue, 10 Jun 2025 16:21:27 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-adb2bd27c7bso950015266b.2; 
 Tue, 10 Jun 2025 13:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749586882; x=1750191682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hcp9cg9W7f8WjQhRw5f9FpDz7zN4s9hAjNEuNZIHKbA=;
 b=ngXVYZo6UMOo3DTO+aqi7eaEQo8wav/K09j8yz9wQrOUBZZFcOj8lYIjt4n/PlHm3Q
 Upt/WnDvIOqVlWThvRsqvnBFnuFWDb+xVAgemS0sc55FGE+nFumOYAuuwo4wJi9GdBlm
 +gpQZ9bNRWb0OoYysbn1jj+5pjIqfZHZCtvk7A2Fg6YCk7uyP5qMx+VLCmnEpFU5fJjt
 OvL0jTia2eC/fUGCVyW4zSc1ueEkH76kVHYDjqPYJqzOWKwV6LNhGWBw8MxycogVX1XO
 ieapPWd87KQTVSd7qOIWGDMo6/Cz6wqNjUSL9I99Cywp3ztnPDYRJFH8hGGHKDnGqUhi
 wGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749586882; x=1750191682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hcp9cg9W7f8WjQhRw5f9FpDz7zN4s9hAjNEuNZIHKbA=;
 b=UMFZsnFv0s0L1jJa7nQDoOG/plhSFaeNxckXeJ+ofwoQRYEI5r2EERh7CVPQBZEWuW
 IXLTjr/BEgVFGoQV67KRW7hk6JCdVOe16JD4MtkLy047iFgcJSpL5N/FEviZVXK6qLge
 XGWE4a97Tp2JOerrjhZSP+my1E6KB9KLBpFl6DqQwGtKQVtYfCdm9UPVqyOEyvgCjGR/
 eCf4lPYJRQOmcuoIRojMmbJ8AApNMkSOsABmtawZ3e2hmOxdtCvpOjtMtNHPdupYnlTy
 kgqSVq301kN2FvfPNQywlkqwrryo166yA+dlopxp8rtbVUjUF7w8OPszGWvgfp7sB9HQ
 oN/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3UqzLRf9m8wfZyAbOcTs4VY27aNyUxxAFtL1uMPKC6Fx+WZuo7G+9qYs5Wl1YXbWARsadKRpc/GQ=@nongnu.org
X-Gm-Message-State: AOJu0YzDVzgvVKXj/XFkffKNcrC8kqTRoDLqvF5TYiChaX89GKqVr/Y3
 JJB5ktBL/ivnR7IQvlNy9Wsrw7fotfuAGPmHsTxqEnV3RiTpDtf10OgCtEkQvA==
X-Gm-Gg: ASbGnctCIo+H2BDMojLEszKb4LiGPQpOk8VhFhzgWT+clZY/DsKXpXR4VT4Lx8xwfNv
 T2eP2t0xnhRLq7qhCqjkMZhOFW91NPpvpdEYMxTUCMipZiP3tHGME993ARiyMrXL2KGfM5q8OqE
 AHHzSAP/qzwq/Zz53b6GTzbFCYe7Z/vK2QVh7deinsvynWWrsmliO+hv8pxOMdnIuPrTHtNCFKn
 kj7Vi0E/ezMonW34SeiY7Z6CAdwtUsdew81F4i3XDuARfVPwS9/Q7QwWDW/LihCeZxI7ONsRUP6
 I+Zr2TV1bUeo4++NOAMM9mAh28x6DDvb+PlULgetDTzh+OTVnkcvBVebAEbiKa0fC6UttnuHfRO
 WcHtXc1Cp0EbOMlRuIZJ1gzqcXT60G0qYKl2RAUCuGJyhV1R1b8zWyX4R+LOgPjZCjP19QDgqfv
 2avTYAYw==
X-Google-Smtp-Source: AGHT+IFGP+aU1otc8K0JHPdFB34HabH20kTObIz9MH652uLsMHfleAVen3u2h7urlc10VxvO7YkOIA==
X-Received: by 2002:a17:907:9414:b0:ad8:a329:b4a0 with SMTP id
 a640c23a62f3a-ade8955eeffmr77501766b.24.1749586881373; 
 Tue, 10 Jun 2025 13:21:21 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2cbf-5d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2cbf:5d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc7c786sm793135166b.172.2025.06.10.13.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 13:21:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/2] rust/qemu-api: Add initial logging support based on C
 API
Date: Tue, 10 Jun 2025 22:21:09 +0200
Message-ID: <20250610202110.2243-2-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610202110.2243-1-shentey@gmail.com>
References: <20250610202110.2243-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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

A log_mask!() macro is provided which expects similar arguments as the
C version. However, the formatting works as one would expect from Rust.

To maximize code reuse the macro is just a thin wrapper around
qemu_log(). Also, just the bare minimum of logging masks is provided
which should suffice for the current use case of Rust in QEMU.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/devel/rust.rst       |  1 +
 rust/wrapper.h            |  2 ++
 rust/qemu-api/meson.build |  1 +
 rust/qemu-api/src/lib.rs  |  1 +
 rust/qemu-api/src/log.rs  | 76 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+)
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
index 0000000000..9e3c61b8b7
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,76 @@
+// Copyright 2025 Bernhard Beschow <shentey@gmail.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#[repr(u32)]
+/// Represents specific error categories within QEMU's logging system.
+///
+/// The `Log` enum provides a Rust abstraction for logging errors, corresponding
+/// to a subset of the error categories defined in the C implementation.
+pub enum Log {
+    /// Log an invalid access caused by the guest.
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
+/// The `log_mask` macro checks whether the given mask matches the current log
+/// level and, if so, formats and logs the message. It is the Rust counterpart
+/// of the qemu_log_mask() macro in the C implementation.
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
+/// use qemu_api::log_mask;
+///
+/// let error_address = 0xbad;
+/// log_mask!(
+///     Log::GuestError,
+///     "Address 0x{error_address:x} out of range\n"
+/// );
+/// ```
+///
+/// It is also possible to use printf-style formatting, as well as having a
+/// trailing `,`:
+///
+/// ```
+/// use qemu_api::log::Log;
+/// use qemu_api::log_mask;
+///
+/// let error_address = 0xbad;
+/// log_mask!(
+///     Log::GuestError,
+///     "Address 0x{:x} out of range\n",
+///     error_address,
+/// );
+/// ```
+#[macro_export]
+macro_rules! log_mask {
+    ($mask:expr, $fmt:tt $($args:tt)*) => {{
+        // Type assertion to enforce type `Log` for $mask
+        let _: Log = $mask;
+
+        if unsafe {
+            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+        } {
+            let formatted_string = format!($fmt $($args)*);
+            let c_string = std::ffi::CString::new(formatted_string).unwrap();
+
+            unsafe {
+                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
+            }
+        }
+    }};
+}
-- 
2.49.0


