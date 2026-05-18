Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55594CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vs-0000lR-2f; Mon, 18 May 2026 17:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vi-0000Vr-FK
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:26 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vg-0000as-B1
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:26 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479f7e75a6bso1006780b6e.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139703; x=1779744503;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M1JQVOiuc+A4ksNToUTMbfJYQEFXRR5y86p07JOscgc=;
 b=JHi5mFqpIkXIQas63BSuCTzeRQn+LsHjVtV1UgL/i+0OM2Ki4CQUGM0oa2I9aQ/oOI
 NxX/VqR7BkRnNe55Zj41Uw2KxfvJSUPc8o/kurKx0f/X+n7zkbtqTkjF5/9bVcDJ1hnM
 TGg/KtRsdjpHtm113zqUT/XmJRj7m13ajSkEgQLO2U4+k4rGi+J39/8sN8HgJ53eKdIr
 A9KuFtr3CDsdOUbyGZJq3IgXBed9x/Oy6ENFeU8okbpaPiWB0Br1CqD3ULnBKFOkwkbN
 FZHd/1JTs7jKrhMAn2rplZtwyQ7Jnl16X7jIFmAY5fdgv7+DWxkmtYWhCbzCT4B4wZDu
 D1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139703; x=1779744503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M1JQVOiuc+A4ksNToUTMbfJYQEFXRR5y86p07JOscgc=;
 b=PM8e5Yi/ol+gb5IV3HQZnzTpsA5ZZd0eUh4R4QATobqZaVcTV/jxOW/w38ykkspGv0
 o3zL/UKM77NUAXwan5FuaS7Ih9cayVyEogiAO4s9CUUNwTXW3I3cGqn7Ki9L4i3KQFao
 tLbSN9r2aNDgQfgHGMZdLtShDE+vnSL+rp+gSUwG47Z3QX8l0b7MPeKkDcUUam3tuo7K
 wHrcE9ogF68btb8cFyjxuiKmV6CkWUrGeyvUMrZkGKXJ/XJPmLwwW9ySjHipRtfQ6n1c
 YoIggNTJN1I0SlqO8iYew+2ccyjFcBdc4J5iRkp0nYDdEOy5qHYfq7acMK8klsw4aKlR
 Zv4A==
X-Gm-Message-State: AOJu0YyYFzgi2eJkka5utWpN/mRwCsRpleFgArOuJ68nbHzQA7zXy0kJ
 yi5wO/P+uh3/y1o09epmIU3hZxO0y7d3Z9zdAGVcsGP/7pVf8hT360j6gwqqwQMkdl4=
X-Gm-Gg: Acq92OH1RVYNMQb+TsY7dAvlT5FuK7lHhPnxKGTry6OP/EQ6+l9Po2o8uHkNWRH6b80
 uFWhrwywqPGrNK36BnZOmBzYgbh+2UNYqhMCaRbV+6Zj2DKvPhlK78O8bJUzY97oYAxCzPu6dCH
 NLMLPDo6bmJ12OICmg9QwFq8oY42WiBxX7Ts52WtNAT5/qNa/S2aFha7E00gVIcuKkNdU6wmOBU
 yHlHK4MNJJJVwbCoUa/OpHm25DIxMBfHfcPLOq+LAWZUoOCZnS/6Pv4j/+I797u6KWiI4MN7zNl
 w5aqEBoq9dQ//HAv4WtV1XxddDOUO6I8OVDAkjYLLu2kzaERZs1KdNhrUMl1FiZEcZl9oGf11Za
 dXP17Ry7UF5aEcZgleng5k63SpqRTmWlogwn0uI/wcAhpQrd0BcCDqNROy1PJi6ofOQ6CALVuZu
 wX7RHdw9lo/A==
X-Received: by 2002:a05:6808:c1e6:b0:47b:bd7b:10e5 with SMTP id
 5614622812f47-482e55e6829mr10953018b6e.3.1779139703350; 
 Mon, 18 May 2026 14:28:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:48 -0600
Subject: [PATCH v2 30/37] bsd-user: Add os-extattr.h with file and fd
 extattr functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-30-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6734; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Mm8GHafCndpbMfsQZNiUocUTnedWT7NJI/bDY50K/R0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RINy1INaeXWug354SI7pRmAGneCXYV3+a7t
 p4ZpDdFNFeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AE7pD/0YrY9FyD5ypFx8E/SHhnbO4Q1JGDVe/0vtbUCsWp5Pr0tmsHqp0p53lNWaTzG6rEmz655
 Ol5FNz4khSCVNYPHoBht9V4rTZvmkCzyQbj/UJaaJVjVCL2mnm7DpUP0JIQ+nagFbyPCRe3cl4l
 6XSvozriuxsBQu+xaZC5tvZDfq8yRYQxq29efkAsFWJkesd7NhIXrGEHdyLCp4o5IvbMMzidhhx
 T3JBEluxwjsFKZ4a3bFbwTixl3Bde2JwZtwTASNJwd4Exny+rCYjC1cOUr0o/NpZW2QTfwUNkSG
 4trVp3XXYhTLI2Y0peraKAw9ydNv6Lzd4RcpS3UcR8vO8iw0O6sIMW6OArUYlNHtKk9GGQGN6V4
 iAziOhYgiZ3sUzIXSd+HmlFD0kOfPXiOA2ikbxgXqXOPfDyg1cc6YDGlqeu1zKV6xLxHnQCEmKL
 eF6QhZ0mtb5eVWE2Ud4po1HrHJ9ndcL0K0QqQpWGJFdynCT+Q2HindGA7I5+kUsmhUesEGx8H3v
 SHcwqkP2/zycJur27ND2A0FGOjbxKl4JL30rNU3rpOjTgZl/NPTe0YXEM9uCLl/ASkg46pF42B/
 L4xKHMBcg9+iKnL1NDV44SA6aB0hKezAxmgzEDe1XndOR6TtTDCQ6wJdG1wH8WyXCfqV78JcW6g
 UyddGnAGKahBBOA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 208 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
new file mode 100644
index 0000000000..f1dfa344cf
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
+static inline abi_long do_freebsd_extattr_set_file(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
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
+static inline abi_long do_freebsd_extattr_get_file(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
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
+static inline abi_long do_freebsd_extattr_delete_file(abi_ulong arg1,
+                                                      abi_long arg2,
+                                                      abi_ulong arg3)
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
+                                                 abi_ulong arg3, abi_ulong arg4,
+                                                 abi_ulong arg5)
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
+                                                 abi_ulong arg3, abi_ulong arg4,
+                                                 abi_ulong arg5)
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
+                                                    abi_ulong arg3)
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
2.52.0


