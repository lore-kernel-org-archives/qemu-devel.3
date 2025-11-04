Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E6CCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwg-0007fz-Ou; Tue, 04 Nov 2025 11:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwM-0007co-Im
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwG-0003z2-RS
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyCxCICrU/SDz5D9OgrxQf/TXwBgksmHHfJEONyqPro=;
 b=RHI57N1Ys7g9itu9gmtKj6AOMFtNUggHSaDMdGwFfvad5sNpsBHGP2Ev5+/eWno5aYNgTo
 ScgA6yHGq5yiRzi3U3vI0jalaT+xwwr1KUKAoUGoqCxVhjDKqlHzh6YR75EFsBhWVz13Z3
 AdLtiR01MUMRm58CoFG2qyS7Fl1CSi4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-2wQZ-jcQNpu6TY_P9VINcw-1; Tue, 04 Nov 2025 11:31:15 -0500
X-MC-Unique: 2wQZ-jcQNpu6TY_P9VINcw-1
X-Mimecast-MFC-AGG-ID: 2wQZ-jcQNpu6TY_P9VINcw_1762273874
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b70b974b818so226714366b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273873; x=1762878673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyCxCICrU/SDz5D9OgrxQf/TXwBgksmHHfJEONyqPro=;
 b=BhiLZWrWTGr49iYI60hW3yzO4cb7xSCWi8H5/VscGQL+HGB41zL6IM0i7sjacLH40B
 OjHWSdp/c66ogXkGnrO2bM92kQciZ0JXRNdFPenr8vkn3xgC43iwOIZM8E/nF335r229
 TEGZa86fFA8j1MLjjF5v8+RjW1yvSLcyhPK0RHh3XXYomPDLghzjqpdRcKe5JYBD+nFh
 5jcxnw1w/tbpQXbixEr6JAyKsiLPpQuAsuqTUeoKfNKMfCrg3rTT/glXRQ11nRqlz+sX
 G/cJfkWoW15z4ORWKl/fIlD46erBtyvz4TZDFEfHMqPbYBpLR7BCCiqhVqFU4yh5Kuky
 Z7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273873; x=1762878673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyCxCICrU/SDz5D9OgrxQf/TXwBgksmHHfJEONyqPro=;
 b=YtrvUJ0bVk25K3WL98rn6Qg3l/UmPE/A4PtUgqbi/5fktApNE/vzz4kyHp3T7syMxM
 VcDUaaMB58dzkt2lElsxZVEUOJmK/DMR0EOy/GNCRsgYJhHWBZGn+WeDqC+XU7delKdU
 OlQ5YX/vUd4xQlyVSuHMqItpOwJYgMEiU2c9zIi22C+g4qMargh9OBrV9fXCrpmvDRkz
 lBKzCH+yuLna0VjLQCTxKcbTADMjIfLBDzGP1f4lmavQBw7cxh3rOV1qOHXAcgXrD1pL
 93rN4swws5GxSkpM/Vc1CxJgG5F7lFrtGOCRG6XQ28cV0yQCf4Gb1E7cyM0gwU1ZE6gq
 WNig==
X-Gm-Message-State: AOJu0YyTrvfBNBxt0XTC35V6FVGq2zinisSQRvk2MF1/CL/EXsSgqOJx
 otKBdsBLvZq6v8YI8MMb/MonqFokiRJXHWoQaj1QXKbv1vb2AGWfJxTSFbpdcCyqch4tja4FnBA
 MI7yV2HzprgSa0LtkxXapSQLbyrDLMuliz/0Dws4mBc/by2/ss504IeccgJII7RT+j8Pt5NOT7g
 4po3dGtJWUppa4vLDcrUwniIhmQBzXbY1WY0mxBTnf
X-Gm-Gg: ASbGncsldw3CoXBNx+jc7Ia8vhT1NjWEsjBY4c2svS/kCVO3lJqPV2PUFpffUtwv0cG
 HSTPwNLR+vimNb/rQAVP3RbgcG1fBiply5un3xSp+pSqtUp9DcrdAiX009BADnfB9UjM4BQ9vuP
 ADFq9jtwc64cMJufmMKmxiLJUe6RBNKSTAgBMFZieS/qo/CRUATVZ2dCGS5+cYhxgFcHQvxi7Yo
 fhN6bxcyCULIJKXbumedCNvZ9a2UxET9OkhanHU0O/y7zm1chQ09Ela745SHenUY+PH23dNptnw
 2erJnsBUScX/g7s6VNWWKIsv52KFzTI9a9xbZEGkF69S5LZ8bKnxiAgdZJ83A9l6G3cimpqpkuW
 X+w/UR6BLArDSejJFzGHCS7ndwGDIupnS8UaDeG5bY8IKJLx2/rIPg0NFyTqRT60+MVX/OVCCaH
 0ihig2
X-Received: by 2002:a17:907:6d20:b0:b70:b83a:73e5 with SMTP id
 a640c23a62f3a-b70b83a8c35mr824454766b.44.1762273872940; 
 Tue, 04 Nov 2025 08:31:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdlbU944pOfr+uBd52FjeS2yoL85K6gDfy6iDRgAm/01jC2vbIewQPGSPt1k68q/yicnURaw==
X-Received: by 2002:a17:907:6d20:b0:b70:b83a:73e5 with SMTP id
 a640c23a62f3a-b70b83a8c35mr824451666b.44.1762273872157; 
 Tue, 04 Nov 2025 08:31:12 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3082sm251379166b.11.2025.11.04.08.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 4/8] rust/util: replace Error::err_or_unit/err_or_else with
 Error::with_errp
Date: Tue,  4 Nov 2025 17:30:58 +0100
Message-ID: <20251104163102.738889-5-pbonzini@redhat.com>
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

Introduce a simpler function that hides the creation of the Error**.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/error.rs | 52 ++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/rust/util/src/error.rs b/rust/util/src/error.rs
index 11b574ca593..346577e2e53 100644
--- a/rust/util/src/error.rs
+++ b/rust/util/src/error.rs
@@ -14,8 +14,7 @@
 //!   [`ptr_or_propagate`](crate::Error::ptr_or_propagate) can be used to build
 //!   a C return value while also propagating an error condition
 //!
-//! * [`err_or_else`](crate::Error::err_or_else) and
-//!   [`err_or_unit`](crate::Error::err_or_unit) can be used to build a `Result`
+//! * [`with_errp`](crate::Error::with_errp) can be used to build a `Result`
 //!
 //! This module is most commonly used at the boundary between C and Rust code;
 //! other code will usually access it through the
@@ -213,35 +212,21 @@ pub unsafe fn propagate(self, errp: *mut *mut bindings::Error) {
         }
     }
 
-    /// Convert a C `Error*` into a Rust `Result`, using
-    /// `Ok(())` if `c_error` is NULL.  Free the `Error*`.
+    /// Pass a C `Error*` to the closure, and convert the result
+    /// (either the return value of the closure, or the error)
+    /// into a Rust `Result`.
     ///
     /// # Safety
     ///
-    /// `c_error` must be `NULL` or valid; typically it was initialized
-    /// with `ptr::null_mut()` and passed by reference to a C function.
-    pub unsafe fn err_or_unit(c_error: *mut bindings::Error) -> Result<()> {
-        // SAFETY: caller guarantees c_error is valid
-        unsafe { Self::err_or_else(c_error, || ()) }
-    }
+    /// One exit from `f`, `c_error` must be unchanged or point to a
+    /// valid C [`struct Error`](bindings::Error).
+    pub unsafe fn with_errp<T, F: FnOnce(&mut *mut bindings::Error) -> T>(f: F) -> Result<T> {
+        let mut c_error: *mut bindings::Error = ptr::null_mut();
 
-    /// Convert a C `Error*` into a Rust `Result`, calling `f()` to
-    /// obtain an `Ok` value if `c_error` is NULL.  Free the `Error*`.
-    ///
-    /// # Safety
-    ///
-    /// `c_error` must be `NULL` or point to a valid C [`struct
-    /// Error`](bindings::Error); typically it was initialized with
-    /// `ptr::null_mut()` and passed by reference to a C function.
-    pub unsafe fn err_or_else<T, F: FnOnce() -> T>(
-        c_error: *mut bindings::Error,
-        f: F,
-    ) -> Result<T> {
-        // SAFETY: caller guarantees c_error is valid
-        let err = unsafe { Option::<Self>::from_foreign(c_error) };
-        match err {
-            None => Ok(f()),
-            Some(err) => Err(err),
+        // SAFETY: guaranteed by the postcondition of `f`
+        match (f(&mut c_error), unsafe { c_error.into_native() }) {
+            (result, None) => Ok(result),
+            (_, Some(err)) => Err(err),
         }
     }
 }
@@ -432,13 +417,16 @@ fn test_ptr_or_propagate() {
     }
 
     #[test]
-    fn test_err_or_unit() {
+    fn test_with_errp() {
         unsafe {
-            let result = Error::err_or_unit(ptr::null_mut());
-            assert_match!(result, Ok(()));
+            let result = Error::with_errp(|_errp| true);
+            assert_match!(result, Ok(true));
 
-            let err = error_for_test(c"msg");
-            let err = Error::err_or_unit(err.into_inner()).unwrap_err();
+            let err = Error::with_errp(|errp| {
+                *errp = error_for_test(c"msg").into_inner();
+                false
+            })
+            .unwrap_err();
             assert_eq!(&*format!("{err}"), "msg");
         }
     }
-- 
2.51.1


