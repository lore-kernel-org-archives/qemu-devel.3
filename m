Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C783CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwe-0007fo-1T; Tue, 04 Nov 2025 11:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwM-0007cn-Ir
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwH-0003z5-GF
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWcRKatFGdRs6oGcB9rOvC9PoikvUkyBckrYRemBUEA=;
 b=DqH1b6OkgmsUMdkYKRWq4JtU5cdrp/fEO+ikc6Kq34VGOVW5u7y6KP9PP2wQTXUFsgWoNN
 asf7KoGuAvPWlHey0QXpZenbotHZR/AS7nvALGKbArYjzkrI3QrGRytU5xtqV7qg5vkgKt
 +NBrXijgkw4yyYE7VTlMMgjJs8V78nk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Qmifns6QOT-cgTucMem2yw-1; Tue, 04 Nov 2025 11:31:14 -0500
X-MC-Unique: Qmifns6QOT-cgTucMem2yw-1
X-Mimecast-MFC-AGG-ID: Qmifns6QOT-cgTucMem2yw_1762273873
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b70b21e6cdbso257046966b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273871; x=1762878671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWcRKatFGdRs6oGcB9rOvC9PoikvUkyBckrYRemBUEA=;
 b=GyU6guDzXuFE9qANJQ9SLtBAJH9WkOUjhoPuFiD5xCkVyNvr+kW6p0dnEZKm3H/aoV
 ZEWMlcuOywkc9HEkoi0KggX/CUqZ086LpHBi+hmCwu6ja4WYJs3HRCV5x7EHTPF8YYIO
 h6OxBh9wWtLdB4IT6CM1GhoHTYM2FZisaZcw/VG9Waezeso8ggNGkcXwXs2i+5a9jChV
 yNYSjdipStPlXHTWIw2VhQWNBbAr8hVhSGwx15MZ4FMeRe02zQzUrfVkmahZqxfMA1CX
 2SyNkIwxYSt6p8ERjctLDJNyJWpv76jlDtEUl3SavF+0H6Ym2flGymFzyxoDI3z/3wog
 Sp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273871; x=1762878671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWcRKatFGdRs6oGcB9rOvC9PoikvUkyBckrYRemBUEA=;
 b=RDAWlcmFJ8xrza7ym0inZrNx3fSpK9cztQ/VAxidwNpXNgDIy+4xMZiKJaJsxaz0iG
 4RDfXgGwFK03AErgcMzujYiYbQ/U1BJMsLISBrIbAo/kI3lJrn53VbPjEf3MC6L/z8SP
 +M/9vSNH8vX6iLeEMcaePh6oLW/3Mwpv0bsHQoKeWVZZG0z0DCwq3LfWmzomMcO9OruN
 iVlPDnZ4czaZkk1cAWIZXQn43KWhxeGUH4yz41udtZtO3EyzQY0mxnBCaUy1VVDfuj+0
 AYx6g1aWJQNBjhPAKiH0FxR7U11PONc+DDjzSbl2eYAbfADui0ZCHQu0jAxRgvrqbJVI
 keUA==
X-Gm-Message-State: AOJu0YwfplYWqHaI1uoMNgky4a5rYIMq7FRnFBDn/tFC0Mc2eorZbVAY
 hnZaCdmfOn8CVoSEXXDUEODthwoSkAged00pI1RAlNMzjpUqlf3UNsTpHL6LrLzgJ84zfzWm3qJ
 6OCMcfG1AWq6Fxs836CRkPf5aG/jCdQOIiSPli0rsKQ4T3o+UfYDRQ0lfctZjAYfrr0WcjHdiQ/
 6oJCGAXXaryBT0LeJha7rW0qLpZKzMCojey+dOe7Ut
X-Gm-Gg: ASbGncv9w1TBL5sbffcl+bySPjYcHBSNCa+E1HXttfT/78WTR+HKLCuLI3DgpZKq/bO
 u32AE4xWLOfKWiX14gOEvhMLQ3c6Gm0SYOKabk6nkgQZ+0ZTL8fWQVhlcAlj79tnIhDMGUDcgTA
 9CTrASaLMNAs/K81mkL5yLscNgN286it9lX0iZBD11dG7WsDXZYWEUPK1ypDQyKiyZ0HyrVFnlH
 iNE1TJxPNX4BZrLHbS2XoM6MwaYRfRzenHnHmlk/OrBw+Xk/gLWKi9XdN1eTQ/FKnAVp4g0p4QO
 8LzhZ2CkKVouSfXMBbD+5G+8FdtOksxQ/VPa7wE9tNyhpkPTWb/enq67j+QjXCX4uX7tXzYu9xN
 Pay7pk8CblKcRo3M1AMsQACI+jJD/nv3sGhw9T3SMt6aLq688nE6aWOh8K+gBnYfNcVPt0XNFK8
 rmQY0H
X-Received: by 2002:a17:907:7241:b0:b57:d5de:444a with SMTP id
 a640c23a62f3a-b7216f64864mr475080666b.15.1762273871320; 
 Tue, 04 Nov 2025 08:31:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwjeR0HetxvAdI7EBecZiGIzZqrGtoblzDM8oCs5j+nR3r0Rv8iru+MOii/fH7kTP54D8v3g==
X-Received: by 2002:a17:907:7241:b0:b57:d5de:444a with SMTP id
 a640c23a62f3a-b7216f64864mr475076566b.15.1762273870711; 
 Tue, 04 Nov 2025 08:31:10 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a7f2a5sm2394441a12.34.2025.11.04.08.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 3/8] rust/util: use anyhow's native chaining capabilities
Date: Tue,  4 Nov 2025 17:30:57 +0100
Message-ID: <20251104163102.738889-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This simplifies conversions, making it possible to convert any error
into a QEMU util::Error with ".into()" (and therefore with "?").

The cost is having a separate constructor for when the error is a simple
string, but that is made easier by the ensure! macro.  If necessary,
another macro similar to "anyhow!" can be returned, but for now there
is no need for that.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/error.rs | 160 +++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 101 deletions(-)

diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index 2a57c7fd5fd..11b574ca593 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -38,6 +38,7 @@
     borrow::Cow,
     ffi::{c_char, c_int, c_void, CStr},
     fmt::{self, Display},
+    ops::Deref,
     panic, ptr,
 };
 
@@ -49,118 +50,85 @@
 
 #[derive(Debug)]
 pub struct Error {
-    msg: Option<Cow<'static, str>>,
-    /// Appends the print string of the error to the msg if not None
-    cause: Option<anyhow::Error>,
+    cause: anyhow::Error,
     file: &'static str,
     line: u32,
 }
 
-impl std::error::Error for Error {
-    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
-        self.cause.as_ref().map(AsRef::as_ref)
-    }
+impl Deref for Error {
+    type Target = anyhow::Error;
 
-    #[allow(deprecated)]
-    fn description(&self) -> &str {
-        self.msg
-            .as_deref()
-            .or_else(|| self.cause.as_deref().map(std::error::Error::description))
-            .expect("no message nor cause?")
+    fn deref(&self) -> &Self::Target {
+        &self.cause
     }
 }
 
 impl Display for Error {
     fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
-        let mut prefix = "";
-        if let Some(ref msg) = self.msg {
-            write!(f, "{msg}")?;
-            prefix = ": ";
-        }
-        if let Some(ref cause) = self.cause {
-            write!(f, "{prefix}{cause}")?;
-        } else if prefix.is_empty() {
-            panic!("no message nor cause?");
-        }
-        Ok(())
+        Display::fmt(&format_args!("{:#}", self.cause), f)
     }
 }
 
-impl From<Cow<'static, str>> for Error {
+impl<E> From<E> for Error
+where
+    anyhow::Error: From<E>,
+{
     #[track_caller]
-    fn from(msg: Cow<'static, str>) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(msg),
-            cause: None,
-            file: location.file(),
-            line: location.line(),
-        }
-    }
-}
-
-impl From<String> for Error {
-    #[track_caller]
-    fn from(msg: String) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(Cow::Owned(msg)),
-            cause: None,
-            file: location.file(),
-            line: location.line(),
-        }
-    }
-}
-
-impl From<&'static str> for Error {
-    #[track_caller]
-    fn from(msg: &'static str) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(Cow::Borrowed(msg)),
-            cause: None,
-            file: location.file(),
-            line: location.line(),
-        }
-    }
-}
-
-impl From<anyhow::Error> for Error {
-    #[track_caller]
-    fn from(error: anyhow::Error) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: None,
-            cause: Some(error),
-            file: location.file(),
-            line: location.line(),
-        }
+    fn from(src: E) -> Self {
+        Self::new(anyhow::Error::from(src))
     }
 }
 
 impl Error {
+    /// Create a new error from an [`anyhow::Error`].
+    ///
+    /// This wraps the error with QEMU's location tracking information.
+    /// Most code should use the `?` operator instead of calling this directly.
+    #[track_caller]
+    pub fn new(cause: anyhow::Error) -> Self {
+        let location = panic::Location::caller();
+        Self {
+            cause,
+            file: location.file(),
+            line: location.line(),
+        }
+    }
+
+    /// Create a new error from a string message.
+    ///
+    /// This is a convenience wrapper around [`Error::new`] for simple string
+    /// errors. Most code should use the [`ensure!`](crate::ensure) macro
+    /// instead of calling this directly.
+    #[track_caller]
+    pub fn msg(src: impl Into<Cow<'static, str>>) -> Self {
+        Self::new(anyhow::Error::msg(src.into()))
+    }
+
     #[track_caller]
     #[doc(hidden)]
+    #[inline(always)]
     pub fn format(args: fmt::Arguments) -> Self {
-        if let Some(msg) = args.as_str() {
-            Self::from(msg)
-        } else {
-            let msg = fmt::format(args);
-            Self::from(msg)
-        }
+        // anyhow::Error::msg will allocate anyway, might as well let fmt::format doit.
+        let msg = fmt::format(args);
+        Self::new(anyhow::Error::msg(msg))
     }
 
     /// Create a new error, prepending `msg` to the
     /// description of `cause`
     #[track_caller]
     pub fn with_error(msg: impl Into<Cow<'static, str>>, cause: impl Into<anyhow::Error>) -> Self {
-        let location = panic::Location::caller();
-        Error {
-            msg: Some(msg.into()),
-            cause: Some(cause.into()),
-            file: location.file(),
-            line: location.line(),
+        fn do_with_error(
+            msg: Cow<'static, str>,
+            cause: anyhow::Error,
+            location: &'static panic::Location<'static>,
+        ) -> Error {
+            Error {
+                cause: cause.context(msg),
+                file: location.file(),
+                line: location.line(),
+            }
         }
+        do_with_error(msg.into(), cause.into(), panic::Location::caller())
     }
 
     /// Consume a result, returning `false` if it is an error and
@@ -326,8 +294,7 @@ unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
             };
 
             Error {
-                msg: FromForeign::cloned_from_foreign(error.msg),
-                cause: None,
+                cause: anyhow::Error::msg(String::cloned_from_foreign(error.msg)),
                 file: file.unwrap(),
                 line: error.line as u32,
             }
@@ -376,8 +343,8 @@ macro_rules! ensure {
     };
     ($cond:expr, $err:expr $(,)?) => {
         if !$cond {
-            let s = ::std::borrow::Cow::<'static, str>::from($err);
-            return $crate::Result::Err(s.into());
+            let e = $crate::Error::msg($err);
+            return $crate::Result::Err(e);
         }
     };
 }
@@ -416,19 +383,10 @@ unsafe fn error_get_pretty<'a>(local_err: *mut bindings::Error) -> &'a CStr {
         unsafe { CStr::from_ptr(bindings::error_get_pretty(local_err)) }
     }
 
-    #[test]
-    #[allow(deprecated)]
-    fn test_description() {
-        use std::error::Error;
-
-        assert_eq!(super::Error::from("msg").description(), "msg");
-        assert_eq!(super::Error::from("msg".to_owned()).description(), "msg");
-    }
-
     #[test]
     fn test_display() {
-        assert_eq!(&*format!("{}", Error::from("msg")), "msg");
-        assert_eq!(&*format!("{}", Error::from("msg".to_owned())), "msg");
+        assert_eq!(&*format!("{}", Error::msg("msg")), "msg");
+        assert_eq!(&*format!("{}", Error::msg("msg".to_owned())), "msg");
         assert_eq!(&*format!("{}", Error::from(anyhow!("msg"))), "msg");
 
         assert_eq!(
@@ -445,7 +403,7 @@ fn test_bool_or_propagate() {
             assert!(Error::bool_or_propagate(Ok(()), &mut local_err));
             assert_eq!(local_err, ptr::null_mut());
 
-            let my_err = Error::from("msg");
+            let my_err = Error::msg("msg");
             assert!(!Error::bool_or_propagate(Err(my_err), &mut local_err));
             assert_ne!(local_err, ptr::null_mut());
             assert_eq!(error_get_pretty(local_err), c"msg");
@@ -462,7 +420,7 @@ fn test_ptr_or_propagate() {
             assert_eq!(String::from_foreign(ret), "abc");
             assert_eq!(local_err, ptr::null_mut());
 
-            let my_err = Error::from("msg");
+            let my_err = Error::msg("msg");
             assert_eq!(
                 Error::ptr_or_propagate(Err::<String, _>(my_err), &mut local_err),
                 ptr::null_mut()
-- 
2.51.1


