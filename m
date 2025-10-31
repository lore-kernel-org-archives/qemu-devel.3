Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39851CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr0y-000197-Mc; Fri, 31 Oct 2025 11:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0w-000180-Pw
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEr0o-0000oR-JI
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XWOdxSuJQXd9jwTAwyQvGMryTPeaJlfg/6hUIbTKrr8=;
 b=FnL+YFPQnSvM+rmqfjWGsdjLzhOgvEpzyBkfV8yesLo1U8OoyOi1lLMx50koOW+CQl1ERr
 Mg18rWK3k4qJ0nmwDJiMc5NunVblhUVHw3hv1Q+kimhPtUYJjoFmTV8Rxb4rsDl3QRjVCj
 HxAHlr2Q3vmLM0UaAPPUVjhLI+d2VoY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-IaVXdanwM9mPX41edaW1FA-1; Fri, 31 Oct 2025 11:25:51 -0400
X-MC-Unique: IaVXdanwM9mPX41edaW1FA-1
X-Mimecast-MFC-AGG-ID: IaVXdanwM9mPX41edaW1FA_1761924350
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-46e47d14dceso13689795e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 08:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761924349; x=1762529149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWOdxSuJQXd9jwTAwyQvGMryTPeaJlfg/6hUIbTKrr8=;
 b=YisopkbtI131FDlRLTjsJ1F4QGe/rOxZGz0dc4hL9Sj3ytLp0NeALUAoB7mK4E4vhC
 477gga5DPDXa3EEwSftxvZ6oaehYtu/+tpiBMvIxhE3GZv/8sLS05fiTdxoN3GFBMaQD
 dMog/AIVw8RywrymUM569aqGTV99nw2dPooyPIrarGaSw96MOFzsK8CQwyC1jBoINI86
 fsBjV0vWVAyrHSdAlKl5+1OoXyo0IxF2nMf4BgPrVD8XYd2FcQN/aDIZUOs22/UpqqG3
 7jLP845aNCj2iwwyRqOurSCc4vmVYIvxYvEWm4GYadZ1WNpiSddIv/wiDxV3hbvoIelV
 wk3A==
X-Gm-Message-State: AOJu0Yx8yxfyCzm1xZIYLmdyou6x48E9OHQPSQ8GjirMotSh9rrt7kgk
 kWuL1HDB3dMrqUWS/fVFQBMco15NqD3Lu7q8vRg1k4PH1FD5dtKVcxbeoY9oWIeRG9co1OfcbSn
 Y04n0vwfMUOuY49ygK/VbmWOaZp+1VcDEuOZ7ThrCzPCailg/WWDR7t4+txbKctUJ2nQCZRTdE/
 5d9ydOlR7GwZZv8/gDsYTVYoNOaoDYoq+EFxhVihPL
X-Gm-Gg: ASbGncvQ4skOTx/EJqJSbXzmkXYKJjHJlNlJ1aD77/wFIwoY4wTNr0uKB34XxhFKjLS
 C1ockoFeVmZsBVPivRtjCDJM7DmwLldSrkhUEq+EepL7VtFBdwskb38kl8xdTEubnQuZlWuzvRZ
 b3cIqGwZCoXBfUgEjgqN2GyF+Puy9gn2pdl1eSuj8328e3LqT3mYeEUF+4HX6RBhzwHkl+choWJ
 qgLENj9zDXEubuwVQC/DD1qk3MSgpaiFtRxOPWr9YEuNvZpIvMUIofT4FVXfdBk31teLI8rIxlf
 vKeI6fu6oJvB1rY1Bs2hv2xfPyvK3A95O76JVQoYExNqFTmFrDmV1z3dD00588nNmlawLr7Roth
 X1MUJ++dTCsHc792B+aBf4jlUCy6IEKp+6pd261QKuaR5vGcGy0GksduNqOw4VPjdXQSXKNz1dB
 +zLCSB
X-Received: by 2002:a05:600c:530f:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-477308be7a8mr38543955e9.30.1761924349376; 
 Fri, 31 Oct 2025 08:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbfH1Ib1RMX6MlVQQ2pbfK8DgAS7484UnHe8O958VBsgNQ4OSTKnM93Eogb5CR+yfxi/+yaw==
X-Received: by 2002:a05:600c:530f:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-477308be7a8mr38543595e9.30.1761924348734; 
 Fri, 31 Oct 2025 08:25:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48daa0sm2089525e9.3.2025.10.31.08.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 08:25:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/4] rust/util: use anyhow's native chaining capabilities
Date: Fri, 31 Oct 2025 16:25:37 +0100
Message-ID: <20251031152540.293293-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031152540.293293-1-pbonzini@redhat.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


