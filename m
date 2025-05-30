Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76710C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiR-0002Y8-4y; Fri, 30 May 2025 04:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiD-0002Wn-U8
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiA-0004bk-BY
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1iO/8dhA6WpfMpyaQHb2m/rin5HTfnhVCocpzfrKwgI=;
 b=IF2j4iavN37If3GcI+OJDZPAU3xoSsV2xgWozBBvvSE59Zo5zFmZZlkzueBSQ8lbj/BoAJ
 utvhHdDJVS67Wo1YshvghjudiYNih+BXoUl8MKKWkY6IiFIiNgLed9fZiZxc9eVEbIF64z
 RGA51I0KqrxMJ+ujhA5GzObppeMC5go=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-eAAom6RlPMenz7mZif1_lw-1; Fri, 30 May 2025 04:03:28 -0400
X-MC-Unique: eAAom6RlPMenz7mZif1_lw-1
X-Mimecast-MFC-AGG-ID: eAAom6RlPMenz7mZif1_lw_1748592207
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad8816c50e1so125200766b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592206; x=1749197006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iO/8dhA6WpfMpyaQHb2m/rin5HTfnhVCocpzfrKwgI=;
 b=fTS+mbHydhcNj46DThGy3fjx5DzXHQ9Srw0vgcvX7kCX1YJK4CLpnl3eqqNs/CRVZH
 DT5brDubddECw45Fnb0NhP7CLPxI63YM0yFXjMWb+dsZpPjiGklO9DT1NXKXZLRQDGLx
 WXwxXRQCdCVZ82v2/6fL8rfI9zDfrt9+hQ/i9rLd4TH+ek0WkcS94B/aVu0u9hAGIyun
 Qw+RN4mrie6KVmMs+0MNmD5X+P1aaOkupsZKbXYvv4b8NLnxwnHv8hEBlQTtF8uH6xCQ
 kQlzAkNf8/leu+m+G8x2+DrDXhpZas3UxVX6h0Ei68O6BTcWsKpkuKva6Y6ohhhd8gtp
 CNLA==
X-Gm-Message-State: AOJu0YytUBNo4CUjAUJD4oD9tW2gp/U1c0wo8c5MPQQDS728tEa+FEx7
 gDGTMzZPkUmQC+yiw6y8X+/aofIJYI1mtOymdGIZ8USAjc/0d/9v4Fl8mla4co1P3tijVK9GKTb
 hYD/EfFajitC73K6R1tjQdtjp7bys8/+Ksa+47sLaWf6oCsTMX4hWcy3kyuYuJf8lzqph9UudpN
 Hn3YFdm1jLK6U6FAtrofPO9ibQKM3I3TVKrR989sNf
X-Gm-Gg: ASbGnctdQZH8//WJ6GLS7pDxXZWhFY+JdUyImEAMd85Gc2HzwYRnDgENsDIL8P/3uta
 xZeFLkrX+oWyhIA4nMQFDablSN/nTCUoOneYT+QlYGtQChOkqD13EZM9rxB9gD5JG84nadjBCy6
 XPtVVxb3rqsnsSfqbNLL4IzdCNAAq0RY/g08+wjPQVw5U1cBciOn0R0iuf7jpvvP3n1Am1nCfwA
 mgRzE0uKrFd1+UJ+Wzw08BYsyDPt8wNz2KjQBBk/TDxYtdD8eH6uUB99yEdEyg3pb0ULvjXGBrf
 CdaeSd0Dp3YDrVY40T870gW0
X-Received: by 2002:a17:907:971e:b0:ad8:81c2:64e9 with SMTP id
 a640c23a62f3a-adb322b3326mr182221766b.8.1748592205717; 
 Fri, 30 May 2025 01:03:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPxF5qdEz3NKmDsuaFYI9b4VZqJVJYtzQtdLrNKwmuV5jFnsqnu8IIE1GfTQcpkdq3mSSH/g==
X-Received: by 2002:a17:907:971e:b0:ad8:81c2:64e9 with SMTP id
 a640c23a62f3a-adb322b3326mr182218966b.8.1748592205171; 
 Fri, 30 May 2025 01:03:25 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adb2fb63cdasm140343566b.120.2025.05.30.01.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 07/14] rust: qemu-api: add tests for Error bindings
Date: Fri, 30 May 2025 10:02:59 +0200
Message-ID: <20250530080307.2055502-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/error.rs | 104 +++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/rust/qemu-api/src/error.rs b/rust/qemu-api/src/error.rs
index 0bdd413a0a2..a91ce6fefaf 100644
--- a/rust/qemu-api/src/error.rs
+++ b/rust/qemu-api/src/error.rs
@@ -297,3 +297,107 @@ unsafe fn cloned_from_foreign(c_error: *const bindings::Error) -> Self {
         }
     }
 }
+
+#[cfg(test)]
+mod tests {
+    use std::ffi::CStr;
+
+    use anyhow::anyhow;
+    use foreign::OwnedPointer;
+
+    use super::*;
+    use crate::{assert_match, bindings};
+
+    #[track_caller]
+    fn error_for_test(msg: &CStr) -> OwnedPointer<Error> {
+        // SAFETY: all arguments are controlled by this function
+        let location = panic::Location::caller();
+        unsafe {
+            let err: *mut c_void = libc::malloc(std::mem::size_of::<bindings::Error>());
+            let err: &mut bindings::Error = &mut *err.cast();
+            *err = bindings::Error {
+                msg: msg.clone_to_foreign_ptr(),
+                err_class: bindings::ERROR_CLASS_GENERIC_ERROR,
+                src_len: location.file().len() as c_int,
+                src: location.file().as_ptr().cast::<c_char>(),
+                line: location.line() as c_int,
+                func: ptr::null_mut(),
+                hint: ptr::null_mut(),
+            };
+            OwnedPointer::new(err)
+        }
+    }
+
+    unsafe fn error_get_pretty<'a>(local_err: *mut bindings::Error) -> &'a CStr {
+        unsafe { CStr::from_ptr(bindings::error_get_pretty(local_err)) }
+    }
+
+    #[test]
+    #[allow(deprecated)]
+    fn test_description() {
+        use std::error::Error;
+
+        assert_eq!(super::Error::from("msg").description(), "msg");
+        assert_eq!(super::Error::from("msg".to_owned()).description(), "msg");
+    }
+
+    #[test]
+    fn test_display() {
+        assert_eq!(&*format!("{}", Error::from("msg")), "msg");
+        assert_eq!(&*format!("{}", Error::from("msg".to_owned())), "msg");
+        assert_eq!(&*format!("{}", Error::from(anyhow!("msg"))), "msg");
+
+        assert_eq!(
+            &*format!("{}", Error::with_error("msg", anyhow!("cause"))),
+            "msg: cause"
+        );
+    }
+
+    #[test]
+    fn test_bool_or_propagate() {
+        unsafe {
+            let mut local_err: *mut bindings::Error = ptr::null_mut();
+
+            assert!(Error::bool_or_propagate(Ok(()), &mut local_err));
+            assert_eq!(local_err, ptr::null_mut());
+
+            let my_err = Error::from("msg");
+            assert!(!Error::bool_or_propagate(Err(my_err), &mut local_err));
+            assert_ne!(local_err, ptr::null_mut());
+            assert_eq!(error_get_pretty(local_err), c"msg");
+            bindings::error_free(local_err);
+        }
+    }
+
+    #[test]
+    fn test_ptr_or_propagate() {
+        unsafe {
+            let mut local_err: *mut bindings::Error = ptr::null_mut();
+
+            let ret = Error::ptr_or_propagate(Ok("abc".to_owned()), &mut local_err);
+            assert_eq!(String::from_foreign(ret), "abc");
+            assert_eq!(local_err, ptr::null_mut());
+
+            let my_err = Error::from("msg");
+            assert_eq!(
+                Error::ptr_or_propagate(Err::<String, _>(my_err), &mut local_err),
+                ptr::null_mut()
+            );
+            assert_ne!(local_err, ptr::null_mut());
+            assert_eq!(error_get_pretty(local_err), c"msg");
+            bindings::error_free(local_err);
+        }
+    }
+
+    #[test]
+    fn test_err_or_unit() {
+        unsafe {
+            let result = Error::err_or_unit(ptr::null_mut());
+            assert_match!(result, Ok(()));
+
+            let err = error_for_test(c"msg");
+            let err = Error::err_or_unit(err.into_inner()).unwrap_err();
+            assert_eq!(&*format!("{err}"), "msg");
+        }
+    }
+}
-- 
2.49.0


