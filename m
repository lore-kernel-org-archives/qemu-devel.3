Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC431C36014
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 21:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyzkZ-0004YY-Uv; Sun, 30 Mar 2025 16:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tyzkN-0004WW-K7; Sun, 30 Mar 2025 16:59:13 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tyzkL-0007SE-BG; Sun, 30 Mar 2025 16:59:11 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac25520a289so642981666b.3; 
 Sun, 30 Mar 2025 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743368346; x=1743973146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cek3cJWsvZ6MdwbFA7s2RJwyG7zwaguVw8CQjdNA8Y0=;
 b=Ijdva06Cx4JT+QdUnk4UDNotUiBASXao5CvwbB+Sm2SHG47TnsA/rs1vt9MNwn9KeZ
 qoS8DMUmHlSQleDTET7Ls6BfndJ7hrntLR9Jur3cdKqcrp94yp0ClcrO2E80cH+OOA0O
 +NcKcSYH1RIgxe9fE13sqdPofF0SMbGP4H4MqyMGNGY9KkIXzzxMSz1FvieGu8beKfPL
 XLWFil1itnkKaz3hN+VTbzEArHaqcxS9Q//XWWiKmMQBDo3IFj9JpYr2whCKbX4V2/8E
 RBgoq+FB1UCSePBsLfSJDb3mad22ZZI9wF+vJpF7vapPree1N0ygbhS9rmAI+F9H6RZg
 2WAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743368346; x=1743973146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cek3cJWsvZ6MdwbFA7s2RJwyG7zwaguVw8CQjdNA8Y0=;
 b=FulwHHcZS8qRxQdoNgT4DTjXQmQrl9xRRRvsPm/UCHpeA+uy35I+WTkDbOsv+1oGo7
 rx3Op/5ifTWplCxmstGfKLRelGQPc3m7eUUrotN53Yub0hAV+6ayDbJXETCvSOoxP+Qw
 YhV+E6EprzUxzDvoqmTg/XSquBGdZ1K0s+jlp9J/998rttUhUMDDiYwojAE6ppXSLtUU
 9MR2IkgJL3zYuyQLO8qIhBdaIZUwkETSq+NtsVFWRZPysJKjJhV2gqKOYdJKdhigQEj4
 CBkB1dS8F0+15G++hyLVTuIWO6heUxQbr5a60KyYCpfTztQ6/SntxYOAj19rZNx+h3g3
 h+zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/0Cf1HUDXDtSkr50wdl+PUNO0i2BXkWvweThBUIH+DgVT8cczrI3bUiYy7hqevxlHGCknmdRWrzY=@nongnu.org
X-Gm-Message-State: AOJu0YwGsc3RyDsACXrHvh6Pwus7nJZoI78pgzRvGhOUjNzCrpnaMnIP
 vSg6hQDMxgF8E5SKN2o4KJip7opBOVKxv8SCCQeS66teycDKJEb/va2xkg==
X-Gm-Gg: ASbGncsDvcK12CdqQP5kAJdjHgVL5otSbBH5+vdcGnM6XZTVpwLiKQcpz+mXpn56as7
 shuwGfgxquwjoSck2VXKzg2g1B+fHhYxkd6MwxcNjUHHV+X30BTEHTgZOP2ecpBtkybr0+OMRT4
 l9e77Zxc+O9Ndrt388uKqWxNlZXto/w6a+cuZsfCahralCMUdF80cfOcQX74Lkque2Oqu5CXBev
 EZLkyEhnoGI5SBk0oQM78llsIObKjMZ4J8PMrUQ3b4fHPx3vsWFtkfSypwN0x+k3hh8Fl8CIOBI
 tRRxHN2PcOyAdtjx9Gv1KiLnRX81wYnZRPE4AWXrWbFIMhRtO97VkpKNGRAuQn7nTleTkMogSEQ
 ZLhEL5+JS7aPHI+X8pV2UueZF4WgGXOd4fSxXWuMbpnC5fF0c9d2aTShLhBsTE1VqxA==
X-Google-Smtp-Source: AGHT+IGogq+fSsWaZq0sZ9KWsNLWSqa65uXR2a2Dqd28lnZj6BYsfviZpWXUw2WnZQVgKejczoAm0Q==
X-Received: by 2002:a17:907:981:b0:ac4:4d2:3867 with SMTP id
 a640c23a62f3a-ac738a374fbmr576726266b.23.1743368346330; 
 Sun, 30 Mar 2025 13:59:06 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-2ddd-7900-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2ddd:7900:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71967fdbbsm520902466b.135.2025.03.30.13.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 13:59:05 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/2] rust/qemu-api: Add initial logging support based on C API
Date: Sun, 30 Mar 2025 22:58:56 +0200
Message-ID: <20250330205857.1615-2-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250330205857.1615-1-shentey@gmail.com>
References: <20250330205857.1615-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

A qemu_log_mask!() macro is provided which expects similar arguments as the C
version. However, the formatting works as one would expect from Rust.

To maximize code reuse the macro is just a thin wrapper around qemu_log().
Also, just the bare minimum of logging masks is provided which should suffice
for the current use case of Rust in QEMU.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/devel/rust.rst       |  1 +
 rust/wrapper.h            |  2 ++
 rust/qemu-api/meson.build |  1 +
 rust/qemu-api/src/lib.rs  |  1 +
 rust/qemu-api/src/log.rs  | 55 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)
 create mode 100644 rust/qemu-api/src/log.rs

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 88bdec1eb2..bc50216dc6 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -187,6 +187,7 @@ module           status
 ``c_str``        complete
 ``errno``        complete
 ``irq``          complete
+``log``          proof of concept
 ``memory``       stable
 ``module``       complete
 ``offset_of``    stable
diff --git a/rust/wrapper.h b/rust/wrapper.h
index d4fec54657..9518face53 100644
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
index 858685ddd4..112f6735a9 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -26,6 +26,7 @@ _qemu_api_rs = static_library(
       'src/c_str.rs',
       'src/errno.rs',
       'src/irq.rs',
+      'src/log.rs',
       'src/memory.rs',
       'src/module.rs',
       'src/offset_of.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 05f38b51d3..b54989a243 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -21,6 +21,7 @@
 pub mod chardev;
 pub mod errno;
 pub mod irq;
+pub mod log;
 pub mod memory;
 pub mod module;
 pub mod offset_of;
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
new file mode 100644
index 0000000000..3103a86efa
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,55 @@
+// Copyright 2025 Bernhard Beschow <shentey@gmail.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+pub use crate::bindings::{LOG_GUEST_ERROR, LOG_INVALID_MEM, LOG_UNIMP};
+
+/// A macro to log messages conditionally based on a provided mask.
+///
+/// The `qemu_log_mask` macro checks whether the given mask matches the
+/// current log level and, if so, formats and logs the message.
+///
+/// # Parameters
+///
+/// - `$mask`: The log mask to check. This should be an integer value
+///   indicating the log level mask.
+/// - `$fmt`: A format string following the syntax and rules of the `format!`
+///   macro. It specifies the structure of the log message.
+/// - `$args`: Optional arguments to be interpolated into the format string.
+///
+/// # Example
+///
+/// ```
+/// use qemu_api::log::LOG_GUEST_ERROR;
+///
+/// qemu_log_mask!(
+///     LOG_GUEST_ERROR,
+///     "Address 0x{error_address:x} out of range\n"
+/// );
+/// ```
+///
+/// It is also possible to use printf style:
+///
+/// ```
+/// use qemu_api::log::LOG_GUEST_ERROR;
+///
+/// qemu_log_mask!(
+///     LOG_GUEST_ERROR,
+///     "Address 0x{:x} out of range\n",
+///     error_address
+/// );
+/// ```
+#[macro_export]
+macro_rules! qemu_log_mask {
+    ($mask:expr, $fmt:expr $(, $args:expr)*) => {{
+        if unsafe {
+            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+        } {
+            let formatted_string = format!($fmt, $($args),*);
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


