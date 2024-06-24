Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A25AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLqkJ-0004wi-Ck; Mon, 24 Jun 2024 16:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3md15ZgQKCnYZfqoaiiafY.WigkYgo-XYpYfhihaho.ila@flex--flwu.bounces.google.com>)
 id 1sLqkH-0004w8-Nc
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:57:01 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3md15ZgQKCnYZfqoaiiafY.WigkYgo-XYpYfhihaho.ila@flex--flwu.bounces.google.com>)
 id 1sLqkG-0001jG-1i
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:57:01 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-70683497777so2654817b3a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719262617; x=1719867417; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9dgEvbUS8KhHzYAh7hJ0Gt03Iu7NI5Y4SX3YZrGnyMc=;
 b=4kZc7+RBmJhWSyV9ERkjlzqc9GKDJUCHAVxIW7xm4zRGbVMf8Zo5f0j4tGfGbsjOuo
 0H7/iZg+8VpBCklziGJ9GftH3UQx6buTinlHW7/WI29qk0YoHsnaGnhsTa/1pWRVSqiK
 z2YjtsCJsslyvZ8Gn7DMPeG6dS46sYBixCznT0+Skx0d9NKAgMWE2hqHJVfdzVezYFXN
 o+Gs0C4iLTZOwprz229e1UgVYcNnggGc7N/ZY/fNWa/74i2kSxAoN2/x7PXYrgUtC+1H
 HcEeXjmOnGVlX/18tYX63Vr4/zDf6oO9S60I02dxUCBXpcJ093EgMmovoBz4BYkPXhBu
 WZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719262617; x=1719867417;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9dgEvbUS8KhHzYAh7hJ0Gt03Iu7NI5Y4SX3YZrGnyMc=;
 b=SjVBA1LUaZ41cAAkYAYWVLQ5kBrT7Mu4EYykE0cMwcaw7H5Sv3mYlETkGukaomuE+T
 JEtIV9KQCw/Aqv6DM5l4H0uw32xpEDY34H5ugYniZ7XM2pvK3ff4xrENOYWmrZ6ZDRJr
 sEJjPGCqOfL1ZRQNqgaSSTp/e05JT1rIDclXH1lUEyrZ5WExRh7J9W7aFDzz3ST+CSxB
 XcLaCxnrvuD4NLrwq2wgzb/Pero3slnx0GbehHBxo2cPPKWGzrHOpL/1fXZ7CYvQVQM1
 M4XRRp6eexSnV4x0oMZNieu8K8uzSZCIBEdErnrUuTJv54SFOoqDyPYVky/PjdyEayw8
 1Y4Q==
X-Gm-Message-State: AOJu0YzKh/eYB5JWK0DWhtw8aJPL4/KrFbth4NVlLW2CoPoHeFncJRBt
 7Le87kkFSS1Y4qdGHS4gmG0x0XohDRYYyLZ77g+ZM/mWE9KtoxdVjjLr8qWg/ohPEP0vtA==
X-Google-Smtp-Source: AGHT+IEu5vUTTMY6UMRttocu5BLuRwNmowXHP/Xy3+omma8PvXjdnL5fwd2jWSisVQUGOjAYE6beFxuN
X-Received: from flwu-kvm.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5ceb])
 (user=flwu job=sendgmr) by 2002:a05:6a00:6c84:b0:705:dbf5:190a with SMTP id
 d2e1a72fcca58-706747c1216mr168522b3a.6.1719262617015; Mon, 24 Jun 2024
 13:56:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 20:56:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624205647.112034-1-flwu@google.com>
Subject: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
From: Felix Wu <flwu@google.com>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Roman Kiryanov <rkir@google.com>,
 Felix Wu <flwu@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3md15ZgQKCnYZfqoaiiafY.WigkYgo-XYpYfhihaho.ila@flex--flwu.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.453,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

From: Roman Kiryanov <rkir@google.com>

to use the QEMU headers with a C++ compiler.

Signed-off-by: Felix Wu <flwu@google.com>
Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/qemu/atomic.h   |  8 ++++++++
 include/qemu/atomic.hpp | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 include/qemu/atomic.hpp

diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index 99110abefb..aeaecc440a 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -20,6 +20,13 @@
 /* Compiler barrier */
 #define barrier()   ({ asm volatile("" ::: "memory"); (void)0; })
 
+#ifdef __cplusplus
+
+#ifndef typeof_strip_qual
+#error Use the typeof_strip_qual(expr) definition from atomic.hpp on C++ builds.
+#endif
+
+#else  /* __cpluplus */
 /* The variable that receives the old value of an atomically-accessed
  * variable must be non-qualified, because atomic builtins return values
  * through a pointer-type argument as in __atomic_load(&var, &old, MODEL).
@@ -61,6 +68,7 @@
         __builtin_types_compatible_p(typeof(expr), const volatile unsigned short), \
         (unsigned short)1,                                                         \
       (expr)+0))))))
+#endif  /* __cpluplus */
 
 #ifndef __ATOMIC_RELAXED
 #error "Expecting C11 atomic ops"
diff --git a/include/qemu/atomic.hpp b/include/qemu/atomic.hpp
new file mode 100644
index 0000000000..5844e3d427
--- /dev/null
+++ b/include/qemu/atomic.hpp
@@ -0,0 +1,38 @@
+/*
+ * The C++ definition for typeof_strip_qual used in atomic.h.
+ *
+ * Copyright (C) 2024 Google, Inc.
+ *
+ * Author: Roman Kiryanov <rkir@google.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * See docs/devel/atomics.rst for discussion about the guarantees each
+ * atomic primitive is meant to provide.
+ */
+
+#ifndef QEMU_ATOMIC_HPP
+#define QEMU_ATOMIC_HPP
+
+#include <type_traits>
+
+/* Match the integer promotion behavior of typeof_strip_qual, see atomic.h */
+template <class T> struct typeof_strip_qual_cpp { using result = decltype(+T(0)); };
+
+template <> struct typeof_strip_qual_cpp<bool> { using result = bool; };
+template <> struct typeof_strip_qual_cpp<signed char> { using result = signed char; };
+template <> struct typeof_strip_qual_cpp<unsigned char> { using result = unsigned char; };
+template <> struct typeof_strip_qual_cpp<signed short> { using result = signed short; };
+template <> struct typeof_strip_qual_cpp<unsigned short> { using result = unsigned short; };
+
+#define typeof_strip_qual(expr) \
+    typeof_strip_qual_cpp< \
+        std::remove_cv< \
+            std::remove_reference< \
+                decltype(expr) \
+            >::type \
+        >::type \
+    >::result
+
+#endif /* QEMU_ATOMIC_HPP */
-- 
2.45.2.741.gdbec12cfda-goog


