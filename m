Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7101C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEM-00079S-Gr; Mon, 14 Jul 2025 07:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGz6-0000bo-Bz
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyz-0001XI-Rh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhCvQkGWRngHOw7qyfN17pVt/8jmU8Gd43OpCo3NXd4=;
 b=Bc+BnJ5qRVlQ0D2LQFGWzR962XlWpk4H54Ks+dPojWBk3xK1O71rGjtBDoPa3oXO+MQFjw
 YMVwNvVOpxSL+i5pL5RTMUnQQzt3CgT+7UFilRKACOUFoDk/LlTF3mwVfRpLcjaH0F64Hr
 IRrk21/zoQT+cq8ZjpyDUuWqk1NvF2M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-JEdMMTU0PUmIXesd-uyh8g-1; Mon, 14 Jul 2025 07:04:27 -0400
X-MC-Unique: JEdMMTU0PUmIXesd-uyh8g-1
X-Mimecast-MFC-AGG-ID: JEdMMTU0PUmIXesd-uyh8g_1752491066
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f6ba526eso2170451f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491066; x=1753095866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhCvQkGWRngHOw7qyfN17pVt/8jmU8Gd43OpCo3NXd4=;
 b=BQ3+mxrJodWbCQ6LJDjttKikVXK7JVlSO8xTKU6YxmzPqRUuAmfGR951SCOYOGWr+u
 J5KO341NJWE7LQOieR2a6Bk84L1iS/c9q7Co0Fk/j8GrHy6rDMM0qYcldTe3QgZDKl0P
 ILNrr3tB8Fy0woWyec3oMS93RKO6qpzNuT6rZzJuevHJWSEI1ryiUH5smEkAZXaC3BU6
 krwiPEOJFiDFmmauDp1UMCuIQuT/n9A80kvgWjGYrhFD7XQNXUyx3yS0Zzy6QK+cgoW3
 ISucHk7r/4ynfSVJlvDDlzBPKY2u6JGaFg3UyWHOc1qRz4JgktuNavbl50N3aCMGan6F
 y9kQ==
X-Gm-Message-State: AOJu0YxudkPaMgC/1L2HdHABlIYIu+HxL7hGzdHUpnN3MQZCYF14ZS+3
 rXNWVhi+/plHATJaV41UmDlpLI+0eSLDMUNRD108unqIldz5sCNUyACniWVZNXm2frXV08UmTut
 kafkO1Vi0P6PUEcaYdxj8v8dg4mJbb7jS1IfAXE6pil32gcKeZ60B7ZHEKxgTToLqOXNedysOGD
 W23vhPK00wx5+FXH2WnGg4SdbHksrh4o6TAM24vWuS
X-Gm-Gg: ASbGncu0ZvpN9Dh8jw25UFiEd57ZxyyMCl53nh/KzDdGPmYk4MlfsKEqfON4SmBsBfy
 GM9HfD+k9JnzLDQdMDi2frtJ3qu9/3soEat5f4DTpigsHmxt4sEG+LyYll/w6nIl/gRUiQwLpJz
 g9lzFgLJUc8mQfk+FHULr8N406+PQDN+efavIyv/Jpr5PyrUXjOgVhk8x7SYMmz39EnTfGcJKaJ
 7EskocEKUXkVJCas3w9D94XIxchSyvDgu9zj/IzMCp2VhI01CvxokwjtdDayPUC0sN1iHUeIE0H
 iLCPowBzjKwQt6K0oh43/KojKfqGYNLWYC1tHim7xx0=
X-Received: by 2002:a05:6000:26cc:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3b5f187d0b9mr10639573f8f.10.1752491065360; 
 Mon, 14 Jul 2025 04:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwASem7VyqV+rh7WcIhESOBDMZh37ODncYUmljd8Qc0UQf307ScSVoht8kt9qXGtOTPx/+YA==
X-Received: by 2002:a05:6000:26cc:b0:3a4:efbb:6df3 with SMTP id
 ffacd0b85a97d-3b5f187d0b9mr10639536f8f.10.1752491064751; 
 Mon, 14 Jul 2025 04:04:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc217esm11772335f8f.28.2025.07.14.04.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 06/77] rust/qemu-api: log: implement io::Write
Date: Mon, 14 Jul 2025 13:02:55 +0200
Message-ID: <20250714110406.117772-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This makes it possible to lock the log file; it also makes log_mask_ln!
not allocate memory when logging a constant string.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/log.h       |  2 +
 util/log.c               | 12 ++++++
 rust/qemu-api/src/log.rs | 92 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index 60da703e670..aae72985f0d 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -84,6 +84,8 @@ typedef struct QEMULogItem {
 
 extern const QEMULogItem qemu_log_items[];
 
+ssize_t rust_fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
+
 bool qemu_set_log(int log_flags, Error **errp);
 bool qemu_set_log_filename(const char *filename, Error **errp);
 bool qemu_set_log_filename_flags(const char *name, int flags, Error **errp);
diff --git a/util/log.c b/util/log.c
index b87d399e4cb..58d24de48a0 100644
--- a/util/log.c
+++ b/util/log.c
@@ -558,3 +558,15 @@ void qemu_print_log_usage(FILE *f)
     fprintf(f, "\nUse \"-d trace:help\" to get a list of trace events.\n\n");
 #endif
 }
+
+#ifdef CONFIG_HAVE_RUST
+ssize_t rust_fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream)
+{
+    /*
+     * Same as fwrite, but return -errno because Rust libc does not provide
+     * portable access to errno. :(
+     */
+    int ret = fwrite(ptr, size, nmemb, stream);
+    return ret < 0 ? -errno : 0;
+}
+#endif
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
index d6c3d6c1b63..a441b8c1f2e 100644
--- a/rust/qemu-api/src/log.rs
+++ b/rust/qemu-api/src/log.rs
@@ -3,6 +3,13 @@
 
 //! Bindings for QEMU's logging infrastructure
 
+use std::{
+    io::{self, Write},
+    ptr::NonNull,
+};
+
+use crate::{bindings, errno};
+
 #[repr(u32)]
 /// Represents specific error categories within QEMU's logging system.
 ///
@@ -11,11 +18,82 @@
 pub enum Log {
     /// Log invalid access caused by the guest.
     /// Corresponds to `LOG_GUEST_ERROR` in the C implementation.
-    GuestError = crate::bindings::LOG_GUEST_ERROR,
+    GuestError = bindings::LOG_GUEST_ERROR,
 
     /// Log guest access of unimplemented functionality.
     /// Corresponds to `LOG_UNIMP` in the C implementation.
-    Unimp = crate::bindings::LOG_UNIMP,
+    Unimp = bindings::LOG_UNIMP,
+}
+
+/// A RAII guard for QEMU's logging infrastructure.  Creating the guard
+/// locks the log file, and dropping it (letting it go out of scope) unlocks
+/// the file.
+///
+/// As long as the guard lives, it can be written to using [`std::io::Write`].
+///
+/// The locking is recursive, therefore owning a guard does not prevent
+/// using [`log_mask_ln!()`](crate::log_mask_ln).
+pub struct LogGuard(NonNull<bindings::FILE>);
+
+impl LogGuard {
+    /// Return a RAII guard that writes to QEMU's logging infrastructure.
+    /// The log file is locked while the guard exists, ensuring that there
+    /// is no tearing of the messages.
+    ///
+    /// Return `None` if the log file is closed and could not be opened.
+    /// Do *not* use `unwrap()` on the result; failure can be handled simply
+    /// by not logging anything.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use qemu_api::log::LogGuard;
+    /// # use std::io::Write;
+    /// if let Some(mut log) = LogGuard::new() {
+    ///     writeln!(log, "test");
+    /// }
+    /// ```
+    pub fn new() -> Option<Self> {
+        let f = unsafe { bindings::qemu_log_trylock() }.cast();
+        NonNull::new(f).map(Self)
+    }
+
+    /// Writes a formatted string into the log, returning any error encountered.
+    ///
+    /// This method is primarily used by the
+    /// [`log_mask_ln!()`](crate::log_mask_ln) macro, and it is rare for it
+    /// to be called explicitly.  It is public because it is the only way to
+    /// examine the error, which `log_mask_ln!()` ignores
+    ///
+    /// Unlike `log_mask_ln!()`, it does *not* append a newline at the end.
+    pub fn log_fmt(args: std::fmt::Arguments) -> io::Result<()> {
+        if let Some(mut log) = Self::new() {
+            log.write_fmt(args)?;
+        }
+        Ok(())
+    }
+}
+
+impl Write for LogGuard {
+    fn write(&mut self, bytes: &[u8]) -> io::Result<usize> {
+        let ret = unsafe {
+            bindings::rust_fwrite(bytes.as_ptr().cast(), 1, bytes.len(), self.0.as_ptr())
+        };
+        errno::into_io_result(ret)
+    }
+
+    fn flush(&mut self) -> io::Result<()> {
+        // Do nothing, dropping the guard takes care of flushing
+        Ok(())
+    }
+}
+
+impl Drop for LogGuard {
+    fn drop(&mut self) {
+        unsafe {
+            bindings::qemu_log_unlock(self.0.as_ptr());
+        }
+    }
 }
 
 /// A macro to log messages conditionally based on a provided mask.
@@ -24,6 +102,8 @@ pub enum Log {
 /// log level and, if so, formats and logs the message. It is the Rust
 /// counterpart of the `qemu_log_mask()` macro in the C implementation.
 ///
+/// Errors from writing to the log are ignored.
+///
 /// # Parameters
 ///
 /// - `$mask`: A log level mask. This should be a variant of the `Log` enum.
@@ -62,12 +142,8 @@ macro_rules! log_mask_ln {
         if unsafe {
             (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
         } {
-            let formatted_string = format!("{}\n", format_args!($fmt $($args)*));
-            let c_string = std::ffi::CString::new(formatted_string).unwrap();
-
-            unsafe {
-                ::qemu_api::bindings::qemu_log(c_string.as_ptr());
-            }
+            _ = ::qemu_api::log::LogGuard::log_fmt(
+                format_args!("{}\n", format_args!($fmt $($args)*)));
         }
     }};
 }
-- 
2.50.0


