Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CC0C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAg-0005me-Tp; Fri, 18 Sep 2026 00:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAc-0005ca-3c
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:54 -0400
Received: from mail-oi2-x12.google.com ([2607:f8b0:4864:32::12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAa-0004PP-Cr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:53 -0400
Received: by mail-oi2-x12.google.com with SMTP id
 46e09a7af769-7f4f0c89e35so188107a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705551; x=1790310351;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AoLGhyh/3DbQaFrz1mwedk8KGADJ7uNsJAgXPxyYP2A=;
 b=FO+grGidg7fekZMbq0s6/CU2QY9jPLkg47g89x3IXge+NTMK7tSk0C2dr2C7oWg1iB
 yJx39pk9RAl9VmNhTh8w25d3hqLngsX4MLd0tdNTsHsxzziWVvgUbI9j416/eTWOGAYf
 f1P/xQfdDR83/IMSMjk2nzbIIEiXBA50IWz6483q0Jy9kk+CYlpbR6RjW97iFjTkCKEj
 w5lEj9a/4yB/5UC088NP7JnFyflemNEVz5ScMxjWuEZ9sy982N/R4KU2xX8u0jInc3i0
 n5uh+qLiN4CxUXgQkRAqwu0KVPGGVLMKGQKmtcxQt9FYhyxboKVP4GtJXVRvTyNurA89
 jmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705551; x=1790310351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AoLGhyh/3DbQaFrz1mwedk8KGADJ7uNsJAgXPxyYP2A=;
 b=Zfbk8a/C4oNJVttSc6cOObGkwMHeNbz/pNnFEPwro0vcH9WNrgIAfQu8PgSFtEOscU
 sJJbdcie6cz+PS5MKvapenCWL+4JA5reOjVmKkPI4ChFLjhJlCK780it9VL4mC5Xv6nn
 K0LTH4nKArVvmRQiqjX22EQJ0+5+GG5m/JmW2qm25o6P3M7wLfr/uqjdzeJu4NRBhwvN
 bNOXA9xdUnlvD42yhC48CtVeLxWq2eckuztSXmYFHJFmulRUSF76VC9fvhdDASy/ZRXM
 TRJf08T61vdEddL/TRqZS8rAHgayw2O/v4JO46cE+4dSKr0S1BisI8mlfuLNeR0UHDaZ
 P+3Q==
X-Gm-Message-State: AFuF++nnOHMua1FvFF+svSQKjWISYocHVTPMByqfJX6SYoEjOSNjpOGT
 Q+RKWpwf1RDnJQqjfeA8XM9a+lzEb/YEgrHevn3sagcLT3mYqv/9eZ8RUx2n2t1MtxLXt/cI4MP
 UQFs8XQU=
X-Gm-Gg: AYBFou34EYKuDnhpTZSF8UnReNcwLuZqwUG8t35xYMRWIQKfHVh0hSIOCp+XVN31we6
 W7KcanIrEhee8GoT3mPyv36QQ8/XrZe21Kh2CtQgvqP9bGmG6QRbsQgvI6NvqpynF7veHUIys7f
 XWFqkCPFFqOTgzGgz5DpHWNmb85+bIVr69p6/+WV6JleO8Ix/V8Y8HYRU8jZKi7pktzCJp2l1/Q
 M+IazHvNsLmP6dl1ggaJVMeGzLUW8k+NH7aN3cLYvy78wqW6K4N8tbG/+JPqQi+zyUz0VctYCYK
 zDpmzLz55l/kig6U57thwDdVaqT+WY56uDOEZw1s7rkNO39L1u9pBDBo9CBwPg+tKTL30klq+Wu
 V8mz/SokjGCx1b8pUNJ0vblfdjd0CUXpU9DcmwrNzWg5r1TD213aHFBuzfMwwtPRPruW/97AQ/o
 2N7dZtL2NTxg/NpcBTN5JdMU6uQjl9+ek9AfQ/++uUEiJnJBl6vLCAN7z3fQ==
X-Received: by 2002:a05:6830:2115:b0:7f4:e4a4:5d9c with SMTP id
 46e09a7af769-80de064e70emr1498621a34.6.1789705550555; 
 Thu, 17 Sep 2026 21:25:50 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/41] bsd-user: Add link and list extattr functions to
 os-extattr.h
Date: Thu, 17 Sep 2026 22:24:15 -0600
Message-ID: <20260918042422.38713-35-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::12;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x12.google.com
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

Add extattr_get_link, extattr_set_link, extattr_delete_link,
extattr_list_fd, extattr_list_file, and extattr_list_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 172 ++++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index fb3ef27346..90f0c64c93 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -204,5 +204,177 @@ static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
     return ret;
 }
 
+/* extattr_get_link(2) */
+static inline abi_long do_freebsd_extattr_get_link(abi_long arg1,
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
+        ret = get_errno(extattr_get_link(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_link(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_link(2) */
+static inline abi_long do_freebsd_extattr_set_link(abi_long arg1,
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
+    ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_link(2) */
+static inline abi_long do_freebsd_extattr_delete_link(abi_long arg1,
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
+    ret = get_errno(extattr_delete_link(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_fd(2) */
+static inline abi_long do_freebsd_extattr_list_fd(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *d;
+
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_fd(arg1, arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_fd(arg1, arg2, NULL, arg4));
+    }
+    return ret;
+}
+
+/* extattr_list_file(2) */
+static inline abi_long do_freebsd_extattr_list_file(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_file(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_file(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_list_link(2) */
+static inline abi_long do_freebsd_extattr_list_link(
+    abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4)
+{
+    abi_long ret;
+    void *p, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    if (arg3 && arg4 > 0) {
+        d = lock_user(VERIFY_WRITE, arg3, arg4, 0);
+        if (d == NULL) {
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_list_link(path(p), arg2, d, arg4));
+        unlock_user(d, arg3, arg4);
+    } else {
+        ret = get_errno(extattr_list_link(path(p), arg2, NULL, arg4));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/*
+ *  Access Control Lists
+ */
+
 
 #endif /* FREEBSD_OS_EXTATTR_H */
-- 
2.55.0


