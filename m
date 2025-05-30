Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5B4C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiT-0002b9-GC; Fri, 30 May 2025 04:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiD-0002Wm-U0
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKui9-0004bO-GV
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1azCmbJZuAfWQgPSVyPr6AsyjXwV0of9HtRemDDmemU=;
 b=DSjEiKHopEmnNkz2D7+7XMWXWPIcWw4XfdV2K7LfrZhOxylUjcTtMwR7wk9kUXT4CrHjFs
 C4YCvGxmHBkzy6eHn7BOmgmJ3hl6f/g43AZZdjLV5a5rw4MIV/j4E7TllMcLlb8bqIqTxm
 lxi7ra7NpZECpLQ3ZJ25HP2GUOxPViw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Y21pxoK2OG2PZD9WWpDsUg-1; Fri, 30 May 2025 04:03:26 -0400
X-MC-Unique: Y21pxoK2OG2PZD9WWpDsUg-1
X-Mimecast-MFC-AGG-ID: Y21pxoK2OG2PZD9WWpDsUg_1748592206
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acb61452b27so137795066b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592204; x=1749197004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1azCmbJZuAfWQgPSVyPr6AsyjXwV0of9HtRemDDmemU=;
 b=YBeYRbn//fiZ6lEvoiYwNBxLZonvC2lrLy9Wew1tlYx1XxlNUzgeOlDKlmthR/CspF
 myLhuK/r+dMEVLHdYY7xqnR+5ZSHicrAdd6ICH90gjGaBVNA7L0ltyPJNES+xBAQCPNR
 SfIA5wfUumEpDwPqwIyO4BLg5vjljWP2tiR9iY0Q66aRWQhi7atobyYtOzoLzocWdLT4
 gLgFQfx809F+4IgAomYC3cwvRHs08RN+R/UkwoTjmYHQhAAwDyJYPl5i0CArdsYAXsNk
 ejZE86jWqXxK09J6rkSaRuS3asviYxM+NjNfVRJUHYHT7oc/Jw9THExqfMO0arkUNDAe
 b47g==
X-Gm-Message-State: AOJu0Yxfh5ahwVZo0fZHPrNq0kQhNoutRcj57PRRWM4HtkbMwS/wa5NW
 NlE6Oak5+AtoxdIQGF07sUZsRM3dMMMxEPX0jhFsLkSsKHAqJlH06b+MIHDGex2jJTAkoPuOM13
 i6eHDW9QIjkFNlWMvjRAKp/BbuBfnBCjXxzMauVaGlB6jGRsLkNNnphHzF/sMCV46xtwj5xce9y
 /dZHM5B4AavGz9RezZqmRn5+r1/bZngD9XBjCGHeLW
X-Gm-Gg: ASbGncsLAcymU0MYX3ELmuhMAU8ibJofosG4y7UMM4l1Di0QzleLPP6ShQrNNZqTOI5
 hEw9Rv6ZrGhXP8wZYP0I/m/ggJv4EF3/YwZO0BkAS9hjq9hSde81dieWnQQiSxVM4brgHAiIC10
 gcz93XVmjPBis6txxRexHo3opEGxPkyYVnZTIecTT5evlweX5XYZSCtr2D7MuhvNLnC+pO7Jp+S
 7XJ5//VOC5bhtzY2fEfWN0kBQG44JEVav0g1axVP8fvHPLV0E4NxBwvXjVRN3zv5meea7aVX/Bh
 qakEx/VH0yfcdA==
X-Received: by 2002:a17:907:1c8c:b0:ad5:2d77:7ca7 with SMTP id
 a640c23a62f3a-adb3230513fmr221919066b.43.1748592204167; 
 Fri, 30 May 2025 01:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEObLGVlMkxoHvdK//Zs9TBV2/VXjAaS4OCBscamgFKTe2ucV1UnEPBC0YVEAf3+nrdgH5OA==
X-Received: by 2002:a17:907:1c8c:b0:ad5:2d77:7ca7 with SMTP id
 a640c23a62f3a-adb3230513fmr221916066b.43.1748592203646; 
 Fri, 30 May 2025 01:03:23 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad395dfsm281759766b.127.2025.05.30.01.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 06/14] rust: qemu-api: add bindings to Error
Date: Fri, 30 May 2025 10:02:58 +0200
Message-ID: <20250530080307.2055502-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

Provide an implementation of std::error::Error that bridges the Rust
anyhow::Error and std::panic::Location types with QEMU's Error*.
It also has several utility methods, analogous to error_propagate(),
that convert a Result into a return value + Error** pair.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock            |  17 +++
 rust/Cargo.toml            |   1 +
 rust/qemu-api/Cargo.toml   |   2 +
 rust/qemu-api/meson.build  |   1 +
 rust/qemu-api/src/error.rs | 299 +++++++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs   |   3 +
 6 files changed, 323 insertions(+)
 create mode 100644 rust/qemu-api/src/error.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 13d580c693b..961005bb513 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -2,6 +2,12 @@
 # It is not intended for manual editing.
 version = 3
 
+[[package]]
+name = "anyhow"
+version = "1.0.98"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487"
+
 [[package]]
 name = "arbitrary-int"
 version = "1.2.7"
@@ -37,6 +43,15 @@ version = "1.12.0"
 source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b"
 
+[[package]]
+name = "foreign"
+version = "0.3.1"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846"
+dependencies = [
+ "libc",
+]
+
 [[package]]
 name = "hpet"
 version = "0.1.0"
@@ -106,6 +121,8 @@ dependencies = [
 name = "qemu_api"
 version = "0.1.0"
 dependencies = [
+ "anyhow",
+ "foreign",
  "libc",
  "qemu_api_macros",
 ]
diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index a00b8ad0bcd..26f3ec09d3d 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -66,6 +66,7 @@ missing_safety_doc = "deny"
 mut_mut = "deny"
 needless_bitwise_bool = "deny"
 needless_pass_by_ref_mut = "deny"
+needless_update = "deny"
 no_effect_underscore_binding = "deny"
 option_option = "deny"
 or_fun_call = "deny"
diff --git a/rust/qemu-api/Cargo.toml b/rust/qemu-api/Cargo.toml
index c96cf50e7a1..db7000dee44 100644
--- a/rust/qemu-api/Cargo.toml
+++ b/rust/qemu-api/Cargo.toml
@@ -15,7 +15,9 @@ rust-version.workspace = true
 
 [dependencies]
 qemu_api_macros = { path = "../qemu-api-macros" }
+anyhow = "~1.0"
 libc = "0.2.162"
+foreign = "~0.3.1"
 
 [features]
 default = ["debug_cell"]
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index aa22252866d..ef0de51266b 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -19,6 +19,7 @@ _qemu_api_rs = static_library(
       'src/cell.rs',
       'src/chardev.rs',
       'src/errno.rs',
+      'src/error.rs',
       'src/irq.rs',
       'src/memory.rs',
       'src/module.rs',
diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
new file mode 100644
index 00000000000..0bdd413a0a2
--- /dev/null
+++ b/rust/qemu-api/src/error.rs
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Error propagation for QEMU Rust code
+//!
+//! In QEMU, an `Error` usually consists of a message and an errno value.
+//! In this wrapper, the errno value is replaced by an [`anyhow::Error`]
+//! so that it is easy to pass any other Rust error type up to C code.
+//! Note that the backtrace that is provided by `anyhow` is not used yet,
+//! only the message ends up in the QEMU `Error*`.
+//!
+//! The message part can be used to clarify the inner error, similar to
+//! `error_prepend`, and of course to describe an erroneous condition that
+//! does not come from another [`Error`](std::error::Error) (for example an
+//! invalid argument).
+//!
+//! On top of implementing [`std::error::Error`], [`Error`] provides functions
+//! to simplify conversion between [`Result<>`](std::result::Result) and
+//! C `Error**` conventions.  In particular:
+//!
+//! * [`ok_or_propagate`](qemu_api::Error::ok_or_propagate),
+//!   [`bool_or_propagate`](qemu_api::Error::bool_or_propagate),
+//!   [`ptr_or_propagate`](qemu_api::Error::ptr_or_propagate) can be used to
+//!   build a C return value while also propagating an error condition
+//!
+//! * [`err_or_else`](qemu_api::Error::err_or_else) and
+//!   [`err_or_unit`](qemu_api::Error::err_or_unit) can be used to build a
+//!   `Result`
+//!
+//! While these facilities are useful at the boundary between C and Rust code,
+//! other Rust code need not care about the existence of this module; it can
+//! just use the [`qemu_api::Result`] type alias and rely on the `?` operator as
+//! usual.
+//!
+//! @author Paolo Bonzini
+
+use std::{
+    borrow::Cow,
+    ffi::{c_char, c_int, c_void, CStr},
+    fmt::{self, Display},
+    panic, ptr,
+};
+
+use foreign::{prelude::*, OwnedPointer};
+
+use crate::bindings;
+
+pub type Result<T> = std::result::Result<T, Error>;
+
+#[derive(Debug)]
+pub struct Error {
+    msg: Option<Cow<'static, str>>,
+    /// Appends the print string of the error to the msg if not None
+    cause: Option<anyhow::Error>,
+    file: &'static str,
+    line: u32,
+}
+
+impl std::error::Error for Error {
+    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
+        self.cause.as_ref().map(AsRef::as_ref)
+    }
+
+    #[allow(deprecated)]
+    fn description(&self) -> &str {
+        self.msg
+            .as_deref()
+            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
+            .unwrap_or("unknown error")
+    }
+}
+
+impl Display for Error {
+    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
+        let mut prefix = "";
+        if let Some(ref msg) = self.msg {
+            write!(f, "{msg}")?;
+            prefix = ": ";
+        }
+        if let Some(ref cause) = self.cause {
+            write!(f, "{prefix}{cause}")?;
+        } else if prefix.is_empty() {
+            f.write_str("unknown error")?;
+        }
+        Ok(())
+    }
+}
+
+impl From<String> for Error {
+    #[track_caller]
+    fn from(msg: String) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(Cow::Owned(msg)),
+            cause: None,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
+impl From<&'static str> for Error {
+    #[track_caller]
+    fn from(msg: &'static str) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(Cow::Borrowed(msg)),
+            cause: None,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
+impl From<anyhow::Error> for Error {
+    #[track_caller]
+    fn from(error: anyhow::Error) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: None,
+            cause: Some(error),
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+}
+
+impl Error {
+    /// Create a new error, prepending `msg` to the
+    /// description of `cause`
+    #[track_caller]
+    pub fn with_error(msg: impl Into<Cow<'static, str>>, cause: impl Into<anyhow::Error>) -> Self {
+        let location = panic::Location::caller();
+        Error {
+            msg: Some(msg.into()),
+            cause: Some(cause.into()),
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+
+    /// Consume a result, returning `false` if it is an error and
+    /// `true` if it is successful.  The error is propagated into
+    /// `errp` like the C API `error_propagate` would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    pub unsafe fn bool_or_propagate(result: Result<()>, errp: *mut *mut bindings::Error) -> bool {
+        // SAFETY: caller guarantees errp is valid
+        unsafe { Self::ok_or_propagate(result, errp) }.is_some()
+    }
+
+    /// Consume a result, returning a `NULL` pointer if it is an
+    /// error and a C representation of the contents if it is
+    /// successful.  The error is propagated into `errp` like
+    /// the C API `error_propagate` would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    #[must_use]
+    pub unsafe fn ptr_or_propagate<T: CloneToForeign>(
+        result: Result<T>,
+        errp: *mut *mut bindings::Error,
+    ) -> *mut T::Foreign {
+        // SAFETY: caller guarantees errp is valid
+        unsafe { Self::ok_or_propagate(result, errp) }.clone_to_foreign_ptr()
+    }
+
+    /// Consume a result in the same way as `self.ok()`, but also propagate
+    /// a possible error into `errp`, like the C API `error_propagate`
+    /// would do.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    pub unsafe fn ok_or_propagate<T>(
+        result: Result<T>,
+        errp: *mut *mut bindings::Error,
+    ) -> Option<T> {
+        result.map_err(|err| unsafe { err.propagate(errp) }).ok()
+    }
+
+    /// Equivalent of the C function `error_propagate`.  Fill `*errp`
+    /// with the information container in `self` if `errp` is not NULL;
+    /// then consume it.
+    ///
+    /// # Safety
+    ///
+    /// `errp` must be a valid argument to `error_propagate`;
+    /// typically it is received from C code and need not be
+    /// checked further at the Rust↔C boundary.
+    pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
+        if errp.is_null() {
+            return;
+        }
+
+        let err = self.clone_to_foreign_ptr();
+
+        // SAFETY: caller guarantees errp is valid
+        unsafe {
+            errp.write(err);
+        }
+    }
+
+    /// Convert a C `Error*` into a Rust `Result`, using
+    /// `Ok(())` if `c_error` is NULL.  Free the `Error*`.
+    ///
+    /// # Safety
+    ///
+    /// `c_error` must be `NULL` or valid; typically it was initialized
+    /// with `ptr::null_mut()` and passed by reference to a C function.
+    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Result<()> {
+        // SAFETY: caller guarantees c_error is valid
+        unsafe { Self::err_or_else(c_error, || ()) }
+    }
+
+    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
+    /// obtain an `Ok` value if `c_error` is NULL.  Free the `Error*`.
+    ///
+    /// # Safety
+    ///
+    /// `c_error` must be `NULL` or valid; typically it was initialized
+    /// with `ptr::null_mut()` and passed by reference to a C function.
+    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
+        c_error: *mut bindings::Error,
+        f: F,
+    ) -> Result<T> {
+        // SAFETY: caller guarantees c_error is valid
+        let err = unsafe { Option::<Self>::from_foreign(c_error) };
+        match err {
+            None => Ok(f()),
+            Some(err) => Err(err),
+        }
+    }
+}
+
+impl FreeForeign for Error {
+    type Foreign = bindings::Error;
+
+    unsafe fn free_foreign(p: *mut bindings::Error) {
+        // SAFETY: caller guarantees p is valid
+        unsafe {
+            bindings::error_free(p);
+        }
+    }
+}
+
+impl CloneToForeign for Error {
+    fn clone_to_foreign(&self) -> OwnedPointer<Self> {
+        // SAFETY: all arguments are controlled by this function
+        unsafe {
+            let err: *mut c_void = libc::malloc(std::mem::size_of::<bindings::Error>());
+            let err: &mut bindings::Error = &mut *err.cast();
+            *err = bindings::Error {
+                msg: format!("{self}").clone_to_foreign_ptr(),
+                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
+                src_len: self.file.len() as c_int,
+                src: self.file.as_ptr().cast::<c_char>(),
+                line: self.line as c_int,
+                func: ptr::null_mut(),
+                hint: ptr::null_mut(),
+            };
+            OwnedPointer::new(err)
+        }
+    }
+}
+
+impl FromForeign for Error {
+    unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
+        // SAFETY: caller guarantees c_error is valid
+        unsafe {
+            let error = &*c_error;
+            let file = if error.src_len < 0 {
+                // NUL-terminated
+                CStr::from_ptr(error.src).to_str()
+            } else {
+                // Can become str::from_utf8 with Rust 1.87.0
+                std::str::from_utf8(std::slice::from_raw_parts(
+                    &*error.src.cast::<u8>(),
+                    error.src_len as usize,
+                ))
+            };
+
+            Error {
+                msg: FromForeign::cloned_from_foreign(error.msg),
+                cause: None,
+                file: file.unwrap(),
+                line: error.line as u32,
+            }
+        }
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 234a94e3c29..93902fc94bc 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -19,6 +19,7 @@
 pub mod cell;
 pub mod chardev;
 pub mod errno;
+pub mod error;
 pub mod irq;
 pub mod memory;
 pub mod module;
@@ -34,6 +35,8 @@
     ffi::c_void,
 };
 
+pub use error::{Error, Result};
+
 #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
 extern "C" {
     fn g_aligned_alloc0(
-- 
2.49.0


