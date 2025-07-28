Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DCCC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 12:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugMyk-0001SH-8x; Mon, 28 Jul 2025 08:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ugMLQ-0000oZ-0E
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:48:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ugMLM-0003TO-Fs
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:48:39 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so38823455e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753703309; x=1754308109; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XF5+LSZYZazbjmjjD/zVta9N0XJQHpjuSTLdKCII5AE=;
 b=y8RHEEohnuuf19xtFIPVLqnbTgy2H6y2uymkZiD8pA8JGR31oLLPJ5BelJps4mIiKS
 B8kO7/hMcMQ1YjlesgaiyOH7UYCWVfleUXwcRIBFztSZ56w6aOk4dft7jZPT/3RsDlOG
 yMYmvQHC1AWuboZecWpfz2cYQ4r5X7tIs/Og3b6vhM28u/dzAOe6ISbPo7nlnyqrX26d
 3l4vO2NRB6JeMJcP37YpSNzK6MAYMnx8su4erXR8m0GIqcdh5X+84G8NX3Q+HaklCpIB
 qEGQ08Uj64ZtBkL2af4QnpX3gJCWWzBlZef5DyGqO5tez/lNXCKvzMFtLNapc7QMGoig
 EgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753703309; x=1754308109;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XF5+LSZYZazbjmjjD/zVta9N0XJQHpjuSTLdKCII5AE=;
 b=BkRMDnqLDeHg+++Hg9YYmGZaZUnCau45iv70I1F9GOYhNpswEXW2Q7ytm5drZHy8u6
 2QXP+WmO8VwJv+GFKeY+01Fag3tT/8Q6DnFSnXqsGhVK1XihOUTCA2oJUJh9lmUXiR5N
 XdNnVitGjNZPbvqEaIX0yevGFAAHknhJukD1waeoysScHmQwyy9lM65A4vyrvWXc6Dy1
 pm4x/jR8VBvy4rgImTQXUqfCG6gXRvcwaHvfznF3Fu4qzXkh6zvQr1sntnoEq9a9SzNU
 ERDp3QLYa8H9k96e3WGdNmGUAZoQsmORBT6k+0kCxukRs+fs9PqRzjYE5sG7KEGSxEqa
 lHCw==
X-Gm-Message-State: AOJu0Yzm+X8qBPSZJlCWBCmQilI0glUgxNhzIxFWAZzSuty7Efl1HlFk
 /YgTKPV8wR51XIV20m1qWteFQa0XUEc+vqy8N0DRqD5UoNlw5FdYockuGbpB2SZyBeo=
X-Gm-Gg: ASbGnctVYj8CoN9pT7T6Hawt9p54wlBY9on67svtU5+PRg0UTZJLlqMEmQ2OrQAup5i
 aIgPJA5Wrz1ga+815i9Ub9gRYLb/+Gz8/b3Jg8Xz5Oyz2L6WOK9fsCow1AyIiq044EtAlp9jVb6
 r5RjIko93a+4h90GR6e12ryaq7ClSHjPlp1nBhCu3x0LChKdkPsJc51E6EdYYV9vq5lgG584W+x
 0r9GBH5EHH5vwzVsAe+yBvuig7x5CCVvzCJOOah0MsOZf6mtQ/2sYIUsVrdfC5J3mJQ1uQXMsf4
 8Dxdgh+sYxjUHb60Vr1JItERU0JpbLd4Xv6VsdPJvOVrpJ15VbqZS4u4kZd/ziosAMPOIKP+7iW
 s98hs8OkncS+mLOf2JB/HPakVdwyWvIiJ5Q==
X-Google-Smtp-Source: AGHT+IFpkJ1rPsEbVvsm7A3jC2M9rMhtCqhAeTciQOMqFVDLJRuNiiVd7bnlfdalIXmHBmr8gLk3vQ==
X-Received: by 2002:a05:600c:4e4d:b0:453:7713:476c with SMTP id
 5b1f17b1804b1-4587555067bmr90539045e9.2.1753703309243; 
 Mon, 28 Jul 2025 04:48:29 -0700 (PDT)
Received: from [127.0.1.1] ([80.106.57.42]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586ec77799sm123346535e9.2.2025.07.28.04.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 04:48:28 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 28 Jul 2025 14:48:23 +0300
Subject: [PATCH] rust: declare self as qemu_api for proc-macros
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250728-self-as-qemu_api-v1-1-001c339cccc8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIZjh2gC/x3MSQqAMAxA0atI1gZqVRyuIiLBRg04NiiCeHeLy
 7f4/wFlL6xQRw94vkRlWwOSOIJ+onVkFBcM1tjcFLZE5XlAUjx4OTvaBR3n5EpbkUkzCNnueZD
 7Xzbt+37rOg1TYgAAAA==
X-Change-ID: 20250728-self-as-qemu_api-de5ad829a034
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3338;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=nO/5Rn87DP20nFAymwMnIX4VjoCVPzTL929nkSdMZCQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9oMk9NUTl4UDljdDZFRTFSVWdKWDQxZXFwUjY5CmxtQy84SmVUcGJuQXhMclIr
 UUdKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUlkampBQUt
 DUkIzS2Nkd2YzNEowSmhCRUFDRjJqUWNsdEZ3dzc1b3V5SDUxQjY0Y2JLWHYwVXdPQXNFZytUUA
 p6aHVhTG5ZMFVYUkpFekFpY0xqM01WWVJzeUwwNUtZWHhsSWtZY1pWYlFwZmF5U0o0c2g5czBsS
 25ha3BhNHFvCktqTmZkTnNDQjJvUkRZUmc5SjIyUk9ZTVBBdE9YWUYzS1VrY25iMHhxZ1h2aExo
 V2xFQ3Y0MWlzQmhMOHZNR2kKS0htRUpJZlEya0NFQ0h5K05FV3lGRXdWSG15bEJ1TzBuYmFTd3p
 0azhXZXVNTkdTV3M3SVA5MmJPUmU3S1phNwpxWWZOdlJ0MHN3MS84UnVSZ1E2YWZhYVFrQkdaQz
 hMLy9DREVHblMxemNYRG1uWWsxemdleEJ0WmlsQy8yYytECkJKZUlrb0RPMzBzNUtOSUR6R3ovN
 DEzUjBzVEhoNk91V001R2JyS1hyNTRGQmhWelF2b2NnMHZ0SjVRWnkybTEKRStLbUZFYTNqSTZn
 RWZ2U05aWWZoOHVjbXNGRnlBdUJJd1EyOTBQZTNBR3pTMTJHTmF5WDA0R2FWcnFkS0FvdApHWUE
 yZFpyazVGYS95Y3dSKytkY2pnN3o0ZUF5R2t0bDQ3M2xaL243UW9SMXlrRS9aVVhlVHpkZDBXUn
 ZtMldlCktWNllBY05hZmZscHh6VktROVYwMkI4RkRkS2gyQTFqa0lwZTdsYXA4amxXWkd3OHRRN
 nRtb1JzamNkS1YrSmoKSFUxSEtlN3dLVEFnZ0xWYVIrQ29pdUc1QkVlS3BFYnppRER1dkRHdk5o
 dmZZekNMRVdJR0hzS0RkaFJ3amVUSgpQOS9vT1pZQmdGMlpXRVNVVE9HRkd5Ylk4Z3pWOFRsajN
 OY2FNTEFlMjhScU5FemZQSG14S2h2WjNYQjlubXpSCmVLa1E4Zz09Cj0xTVk0Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Fix an outstanding TODO.

Declaring `extern crate self as qemu_api` allows use of `qemu_api`
within the qemu_api crate; this allows the Wrapper derive macro and
future proc macros to be used interchangeably in the qemu_api crate and
other crates. This is not required currently and is only for
future-proofing.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/qemu-api-macros/src/lib.rs | 14 ++++++--------
 rust/qemu-api/src/lib.rs        |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index b525d89c09e496a1f7f5582dc6d994e318f62bca..e01ac26cf3dd5a1b06ce095ef32b27a67e0def19 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -115,23 +115,21 @@ fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
     let typ = &field.ty;
 
-    // TODO: how to add "::qemu_api"?  For now, this is only used in the
-    // qemu_api crate so it's not a problem.
     Ok(quote! {
-        unsafe impl crate::cell::Wrapper for #name {
-            type Wrapped = <#typ as crate::cell::Wrapper>::Wrapped;
+        unsafe impl ::qemu_api::cell::Wrapper for #name {
+            type Wrapped = <#typ as ::qemu_api::cell::Wrapper>::Wrapped;
         }
         impl #name {
-            pub unsafe fn from_raw<'a>(ptr: *mut <Self as crate::cell::Wrapper>::Wrapped) -> &'a Self {
+            pub unsafe fn from_raw<'a>(ptr: *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped) -> &'a Self {
                 let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
                 unsafe { ptr.as_ref() }
             }
 
-            pub const fn as_mut_ptr(&self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+            pub const fn as_mut_ptr(&self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
                 self.0.as_mut_ptr()
             }
 
-            pub const fn as_ptr(&self) -> *const <Self as crate::cell::Wrapper>::Wrapped {
+            pub const fn as_ptr(&self) -> *const <Self as ::qemu_api::cell::Wrapper>::Wrapped {
                 self.0.as_ptr()
             }
 
@@ -139,7 +137,7 @@ pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
                 self.0.as_void_ptr()
             }
 
-            pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+            pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
                 slot.cast()
             }
         }
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 86dcd8ef17a9ecd040742a99e4b0421e19ec88f6..44d995cfdb990e0d17e7216cf4d1f04a5a980a1f 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -32,6 +32,9 @@
 pub mod vmstate;
 pub mod zeroable;
 
+// Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this crate).
+extern crate self as qemu_api;
+
 use std::{
     alloc::{GlobalAlloc, Layout},
     ffi::c_void,

---
base-commit: c017386f28c03a03b8f14444f8671d3d8f7180fe
change-id: 20250728-self-as-qemu_api-de5ad829a034

--
γαῖα πυρί μιχθήτω


