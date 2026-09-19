Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1BCC982DA
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yHq-0005z3-8T; Sat, 19 Sep 2026 12:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFr-0003lS-Cw
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:35 -0400
Received: from mail-oi2-x11.google.com ([2607:f8b0:4864:32::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFp-0008QF-Jw
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:34 -0400
Received: by mail-oi2-x11.google.com with SMTP id
 5614622812f47-4c206dc8b0dso1318918b6e.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836572; x=1790441372;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txxZEGmgiR65GvH6Ifffpx5njMN/4m8TrPzV4WhVh9U=;
 b=OtWBPqPxRPI3/HauUWkiMVl0zDC803+YQyuxX5h0RtgZVscK/ycIxL2/kPiVBDQ8UC
 HkC6wlZN8s/BfPpXHg3FVLX1s3YJfP237sFOzOvQGAmAg/YX/f25wlUqorkwqwVDwaKE
 DeewqD2A8WlJNxdh75C6MPA/vOLDSYCJN2WONUF+bn+qsJt9YWdGIgt4DR2WRzij0zMb
 HQqv9nlQRRY8cgmMH+YPcUDXQiSGE9vm0PB2K5iaInZU2Dm1jDOtZOxtmHZT8cNaUrIv
 XJ096/ODauHRdwiMcT8wTMsLKS+Rg/ArodAYXsB9FIXOerrdsNhy5iOreH0PIM6Rl7Vi
 C89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836572; x=1790441372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=txxZEGmgiR65GvH6Ifffpx5njMN/4m8TrPzV4WhVh9U=;
 b=OCPExIohRFJtw/8bORHewlDE0qf814goB+Cc09AFBA5SQDU86AUhti6FHGZ/21jL0R
 uArQnPu5erd8KbeTH+A2FgE+xfwW3QAYcS8QE6WTejFeUMW+YmgQMnxjd4Jcg9UuxKKn
 MBC7LYpu0uWXSQB0rkD6bbAWgWQ+tVXNNUZqwyAuUcpjhx46tuCyKZnpMkzZJfGKoxWH
 zArMCFpKBrwnK+l/mX7Xu+ZINciGzQeryAp+k4c+I9O6nD1ZG2SMPHYeRYpgR3lDjUI0
 sCRuMeK/YuUokaHwppmYGLLX2Bu5tjaP3yt/0S5iaCo7ktMf5iW3bXrRz8JtOVYY0PHT
 0Nnw==
X-Gm-Message-State: AFuF++mCB5h0oQ1LdcpiwnaJyZBK5CHGlKOdl0mu0Ar/Tq7QDRqOFFgQ
 lC8FDFVqb0vvWjlZTlxql5T6Gx6e7qRAMoWQcW0aXvJIh5Kr6kz45RMBBTYCy+6QVvqEsBFw2yR
 cCMvsGPs=
X-Gm-Gg: AYBFou3xB+essLpREnOzI77tfUL0e88gUXrOgOd88UYGWODIdinQ97FxxztRyMhJ+Ow
 lK4tQbvHkywXpvO0QqLXKPOxhKG5IH3guzFGrI24zqhTjuNLikkrAYlafJSKrgcxPTEoPBwoo1p
 PoOxW3xfpik1x3teXRIOnNJh68q32QA7FEXoPE8IawmXLI6txIK2xwpeTqOJCcFP++B9Oy0QvEJ
 au8+fx5BQBROmTVSWiGj+Emw/wGDgOEk4YQxXL2zAx+Dp1wedEG0PKZT3Ml3/b7dxUg7r6GbA7L
 v91746ie1JUqnF/K/0oLbQmQqtUsyixJr0gNJCN8qB5/efy7nyoV9QN8qhfScut9avoCEdUBWXT
 QSL35lP11Iu6Nv8XpomCWoCgHbGzVOB/XgHR7eThUc1aOUkWxZRnYMVhU0k2fIF9aIGPUVh3TOd
 EzcY3BZL6b65PUEY7fCQjrBcsDuDuwVN1K45MnybEPHKaAQnMzU94W1mO4cw==
X-Received: by 2002:a05:6820:60c:b0:6bd:a88f:c8cb with SMTP id
 006d021491bc7-6ca99d2cdafmr5904067eaf.6.1789836572461; 
 Sat, 19 Sep 2026 09:49:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 33/41] bsd-user: Add os-extattr.h with file and fd extattr
 functions
Date: Sat, 19 Sep 2026 10:48:01 -0600
Message-ID: <20260919164810.70151-34-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::11;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x11.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add the first part of extended attribute support: extattrctl,
extattr_set_file, extattr_get_file, extattr_delete_file,
extattr_set_fd, extattr_get_fd, and extattr_delete_fd.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 208 ++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 bsd-user/freebsd/os-extattr.h

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
new file mode 100644
index 0000000000..fb3ef27346
--- /dev/null
+++ b/bsd-user/freebsd/os-extattr.h
@@ -0,0 +1,208 @@
+/*
+ * FreeBSD extended attributes and ACL system call support
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <sys/extattr.h>
+#include <sys/acl.h>
+
+/* extattrctl() */
+static inline abi_long do_freebsd_extattrctl(abi_ulong arg1, abi_ulong arg2,
+                                             abi_ulong arg3, abi_ulong arg4,
+                                             abi_ulong arg5)
+{
+    abi_long ret;
+    void *p, *a, *f;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    f = lock_user_string(arg3);
+    if (f == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg5);
+    if (a == NULL) {
+        unlock_user(f, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattrctl(path(p), arg2, f, arg4, a));
+    unlock_user(a, arg5, 0);
+    unlock_user(f, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_file(2) */
+static inline abi_long do_freebsd_extattr_set_file(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_file(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_get_file(2) */
+static inline abi_long do_freebsd_extattr_get_file(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_file(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_file(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_file(2) */
+static inline abi_long do_freebsd_extattr_delete_file(abi_long arg1,
+                                                      abi_long arg2,
+                                                      abi_long arg3)
+{
+    abi_long ret;
+    void *p, *a;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_file(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_fd(2) */
+static inline abi_long do_freebsd_extattr_set_fd(abi_long arg1, abi_long arg2,
+                                                 abi_long arg3, abi_long arg4,
+                                                 abi_long arg5)
+{
+    abi_long ret;
+    void *a, *d;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_fd(arg1, arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+/* extattr_get_fd(2) */
+static inline abi_long do_freebsd_extattr_get_fd(abi_long arg1, abi_long arg2,
+                                                 abi_long arg3, abi_long arg4,
+                                                 abi_long arg5)
+{
+    abi_long ret;
+    void *a, *d;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_fd(arg1, arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_fd(arg1, arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+/* extattr_delete_fd(2) */
+static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
+                                                    abi_long arg2,
+                                                    abi_long arg3)
+{
+    abi_long ret;
+    void *a;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_fd(arg1, arg2, a));
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+
+#endif /* FREEBSD_OS_EXTATTR_H */
-- 
2.55.0


