Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99CBE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIc-00010M-NN; Thu, 19 Dec 2024 11:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOG-00065E-A6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOE-000868-Ha
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1QIUW+QMqWVmHcaXDZQKBZwBUp/d4OJo6fmKpU6JGs=;
 b=OSJyNE7IL+LJbN9x8/1A7BccOFFsF5XvcsHzsx+XTDqtbUDObb6YBA0EWj7QDFhJM+J/yc
 RnFLRrkaOlAGjWNm+xvAVpnZGnLk55GDq8E7URXw7lj5atNOXbCAQfgrfbbJhBqeBiexZf
 nc4/C9WyU8U3uNqj9vh3Tw7XmjJl5rY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-J4jy_740NEexWbWrfoxVzw-1; Thu, 19 Dec 2024 07:12:24 -0500
X-MC-Unique: J4jy_740NEexWbWrfoxVzw-1
X-Mimecast-MFC-AGG-ID: J4jy_740NEexWbWrfoxVzw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso4268415e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610342; x=1735215142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a1QIUW+QMqWVmHcaXDZQKBZwBUp/d4OJo6fmKpU6JGs=;
 b=YCl/gqO85c4lZ8dvBlGIqetk5wpOm18wAi1qwB5CkZjA/q6DTJYdQU5HCkGB5VuKnF
 DkMAf/oiS9pwmfdhzu9AdhSYE/lcEsIDwuQoYbstWaUjqmkMYk7Rf9ulLFnrWXf1K3qw
 3ETiCoVFvPtqdvCOnKqQmKRkvkArfGHZrMNlAMXawgrBPmY3V0qhsSMvQ+1RbVMm3v3y
 mR+hmyGGeHkBPH6KzHOmx8nqdowt1Rv1dB6fadVBGNi2x0tCOgjCEeNXHtiadP/Gz7Md
 cETTDJzv1N0WJWoMe+eCPmpYLc8qCakjG43ek5A7QQdUku08MPklhXpSdx5eqQccrI0T
 yYaA==
X-Gm-Message-State: AOJu0YyoRMVBEkX3kYvFbrHwQ43Z9D8MnzgQiJxGN+fcHpcBoMJ34w5v
 XUook+XQW+xMOuFjzDQXmOzkjph+D64DEvp4RRoqTHjJWdR3gw6uwE/aNmL+5s8h57FVQS8Ixa6
 v1FlV7u0lVEj6p+dmh8jB4opup81cweaRur2I5kXM+Xiz3B7xRFC1QRo5ctV6HRK6srKz6z+5ri
 yilBRVmoR2/ZvQW51SaFA4KnrOZIRt5PBQculH
X-Gm-Gg: ASbGnctUTkLyrDP/JbiJG6U+qB4xcSjaiY4KkJJaDRIS6c8PdfBhfGigbSTLN8TdR/a
 nOUKh9WcjbI8S3OZywFndzQdvzofcZV59iEov3Uk1cp1DWP0phxzAblpRhc8t6xyqS+i71s+0/G
 Ui+2kYbZxoV6oPk3hNBr6ruZEXHcJjlK8Nf6AEunck5NgzOG01oMqAXSheyuhWprWDKXOIxCvhX
 /qRUqIFe3ttwgnKfIgUJGSqPb9Xn+9hVzH/LrhF26k4nU6JAo/0uMl9A/tg
X-Received: by 2002:a05:600c:4587:b0:434:fbd5:2f0a with SMTP id
 5b1f17b1804b1-4365535bb16mr63670305e9.9.1734610341690; 
 Thu, 19 Dec 2024 04:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlxnMhNVSuRZhbDqNK8VxR6LB6C2XxexG7+EKTiKcgRwBoOLjTHxckGDlqMNqTcOUasS08AA==
X-Received: by 2002:a05:600c:4587:b0:434:fbd5:2f0a with SMTP id
 5b1f17b1804b1-4365535bb16mr63669945e9.9.1734610341177; 
 Thu, 19 Dec 2024 04:12:21 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6e19sm1410520f8f.100.2024.12.19.04.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 02/10] rust: add a utility module for compile-time type checks
Date: Thu, 19 Dec 2024 13:12:08 +0100
Message-ID: <20241219121216.416905-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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
index 8c82c5e96c2..321c025354c 100644
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
index 00000000000..8371cf8f66b
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
+/// # use assertions::*;
+/// # use std::ops::Deref;
+/// assert_same_type!(u32, u32);
+/// assert_same_type!(<Box<u32> as Deref>::Target, u32);
+/// ```
+///
+/// Different types will cause a compile failure
+///
+/// ```compile_fail
+/// # use assertions::*;
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
+/// # use assertions::*;
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
+/// # use assertions::*;
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


