Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F7CE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1F-0004OD-N3; Fri, 20 Dec 2024 09:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe12-0004Kc-L7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe10-00067o-Sa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdnJq0EU2A6dnq9zY8rdFIHGn/66sqWpQMYySJi7ef4=;
 b=HLmX+UV2C6Z5fOoP8wM+0Okwb5ose0GiI/XYhKcktQBgvxnVfkXHBn8jNBYVIrBrO6A7jd
 E0bsVyowbGqDaI35oC/qBcbsPZ6P3Zdk9XZX4ZKEi4WBfdFGaS3awjOlYKAg7Bfpc0tJt5
 HWcuF2pfWqZz1uZ/JTCR7TQK8jij/xQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-ohKqL5bVMM-0qMau_ZcrOw-1; Fri, 20 Dec 2024 09:30:04 -0500
X-MC-Unique: ohKqL5bVMM-0qMau_ZcrOw-1
X-Mimecast-MFC-AGG-ID: ohKqL5bVMM-0qMau_ZcrOw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862e986d17so963655f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705002; x=1735309802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdnJq0EU2A6dnq9zY8rdFIHGn/66sqWpQMYySJi7ef4=;
 b=Fxm10y8OV7TPTkEC/HdEi5aSwMb5WFlDANoARxnCIYwPEsMmIi6QeBXkDHAMLsr6Fb
 YEAcIXzjeVmgQnyuwLk+QAarI2mNf715WmIj6JbpPdG5fl0vdcBR3qJV4twnryLjyXP2
 z8hXMdzD8xvHmvHx+Gx0s48UwMp8B4oHhbgv8HuIbiO0PSHi/acEhI9Q1itjnIKzu7xi
 yb6c2ac6F2y0Wx21DeqjxtjWCLEU2/Uu0cGoknLMntdxHeyy+NYhBTDfNuwG3Wm5Uy++
 Fzva+B8XnSaAx8y0FI8URiFONdcJiTLPCkT91JRVUQeUBb02Z6uwAzlqKc7q8m9wDzTS
 YyLQ==
X-Gm-Message-State: AOJu0YzwrqJlqTWLuXWdqc+67JBLNUIjFaftDKajpuOiVAKX2l61Uv+m
 6w8SusbKWkmC3S0va0UuWhaDzIdJ3Zu4yEicinmrl5OaAEBigVYdp7+AkkY7HtCW+XKZp4tsjt3
 OeIR6/bPM6dm8KtYcazKjxMMTCh72m505A5P5r2jBIssGc5UBVAFvVDtV1MhPQ42Z/KARhKS+38
 P7pczNafPWtnqsuHKIq+h7gnNwL9RWh7A1cdEP
X-Gm-Gg: ASbGncv5ja1EOeZ48AzMwxNMJlakL4gH75ZWRCNy/x/Bd4CTFCbRjQ6FAfTazP0dJyg
 THXiwKgV4Mw6Q6jRoGGPCKuaVmEOj6nTKgyrL8Yiwd6mZLExP6/zXvtlwkUP3xQc2b6hc7Woev4
 mCMA3osj8StfeODwMkJHUuS5ORLUDdO90QeFUQfa4wsjCbMFITZnPCRfaT7ojlmXjPn9kq+PTcG
 op6Hf0VolPBwZRRHqj3Mxc4xi25Vwlp56yCveeVc5X1JZkqYX+cO9LvXeZw
X-Received: by 2002:a5d:584b:0:b0:385:fb40:e57b with SMTP id
 ffacd0b85a97d-38a221ea3a0mr3277808f8f.15.1734705002416; 
 Fri, 20 Dec 2024 06:30:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsN/tGqxbpEuciSu3DsWPQVZMQQt4LfvegEF6vhfjKypBmaLgecIVVuqgqNKpN4kmgvCVHrw==
X-Received: by 2002:a5d:584b:0:b0:385:fb40:e57b with SMTP id
 ffacd0b85a97d-38a221ea3a0mr3277778f8f.15.1734705001948; 
 Fri, 20 Dec 2024 06:30:01 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c639sm46735505e9.31.2024.12.20.06.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 02/12] rust: add a utility module for compile-time type checks
Date: Fri, 20 Dec 2024 15:29:44 +0100
Message-ID: <20241220142955.652636-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

It is relatively common in the low-level qemu_api code to assert that
a field of a struct has a specific type; for example, it can be used
to ensure that the fields match what the qemu_api and C code expects
for safety.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build       |  1 +
 rust/qemu-api/src/assertions.rs | 90 +++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs        |  1 +
 3 files changed, 92 insertions(+)
 create mode 100644 rust/qemu-api/src/assertions.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 9425ba7100c..60944a657de 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -15,6 +15,7 @@ _qemu_api_rs = static_library(
   structured_sources(
     [
       'src/lib.rs',
+      'src/assertions.rs',
       'src/bindings.rs',
       'src/bitops.rs',
       'src/callbacks.rs',
diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
new file mode 100644
index 00000000000..1a6cb3a6c7c
--- /dev/null
+++ b/rust/qemu-api/src/assertions.rs
@@ -0,0 +1,90 @@
+// Copyright 2024, Red Hat Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! This module provides macros to check the equality of types and
+//! the type of `struct` fields.  This can be useful to ensure that
+//! types match the expectations of C code.
+
+// Based on https://stackoverflow.com/questions/64251852/x/70978292#70978292
+// (stackoverflow answers are released under MIT license).
+
+#[doc(hidden)]
+pub trait EqType {
+    type Itself;
+}
+
+impl<T> EqType for T {
+    type Itself = T;
+}
+
+/// Assert that two types are the same.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::assert_same_type;
+/// # use std::ops::Deref;
+/// assert_same_type!(u32, u32);
+/// assert_same_type!(<Box<u32> as Deref>::Target, u32);
+/// ```
+///
+/// Different types will cause a compile failure
+///
+/// ```compile_fail
+/// # use qemu_api::assert_same_type;
+/// assert_same_type!(&Box<u32>, &u32);
+/// ```
+#[macro_export]
+macro_rules! assert_same_type {
+    ($t1:ty, $t2:ty) => {
+        const _: () = {
+            #[allow(unused)]
+            fn assert_same_type(v: $t1) {
+                fn types_must_be_equal<T, U>(_: T)
+                where
+                    T: $crate::assertions::EqType<Itself = U>,
+                {
+                }
+                types_must_be_equal::<_, $t2>(v);
+            }
+        };
+    };
+}
+
+/// Assert that a field of a struct has the given type.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::assert_field_type;
+/// pub struct A {
+///     field1: u32,
+/// }
+///
+/// assert_field_type!(A, field1, u32);
+/// ```
+///
+/// Different types will cause a compile failure
+///
+/// ```compile_fail
+/// # use qemu_api::assert_field_type;
+/// # pub struct A { field1: u32 }
+/// assert_field_type!(A, field1, i32);
+/// ```
+#[macro_export]
+macro_rules! assert_field_type {
+    ($t:ty, $i:ident, $ti:ty) => {
+        const _: () = {
+            #[allow(unused)]
+            fn assert_field_type(v: $t) {
+                fn types_must_be_equal<T, U>(_: T)
+                where
+                    T: $crate::assertions::EqType<Itself = U>,
+                {
+                }
+                types_must_be_equal::<_, $ti>(v.$i);
+            }
+        };
+    };
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 4b43e02c0f9..83c6a987c05 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -12,6 +12,7 @@
 #[rustfmt::skip]
 pub mod prelude;
 
+pub mod assertions;
 pub mod bitops;
 pub mod c_str;
 pub mod callbacks;
-- 
2.47.1


