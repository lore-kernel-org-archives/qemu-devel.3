Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF99C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgm-00025A-AH; Tue, 18 Aug 2026 19:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgl-000252-Aj
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:51 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgj-0005ER-Jh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:51 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4b28d965adcso331289b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097468; x=1787702268;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z492YrGq3t0Ma77Uz/OtV3SUo95r8bp5MtFKwiBLnwc=;
 b=Yimd8yxq4p5D1dc0hd1uodPAM46DfOBwgTSRgDW7sGYVQeOI5bCaNWwa2ULuwEaFNk
 kzoFowDPlMvfcKZdbpvzy3xjO/R4tBSH4wW2DtuCwTYIAbu3XA1ZVmGsMNfkNR5f3SUl
 18UamStsPruhYr9oJLspYHXo6zDwWOPmGU7QTUJj0G5TvGgNKzDrDLTk5n+2PTAtf75V
 ufyFlDa4i8/gOkwFeNZUGLD3y7v3AY26JY2mWttW660TlZhWW7oIqd0Pc5eusq9NnzEe
 L0S1fen08Is8VPlF3PYIBoQ3VEsfg72PbP8WdNtScn9SmXMjsZZKwl0A3ZGz0+5vZEfj
 AnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097468; x=1787702268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z492YrGq3t0Ma77Uz/OtV3SUo95r8bp5MtFKwiBLnwc=;
 b=Fmr3RmJMTKjvZTwVYWBsYNFR4I6g00i6JEhPCKDwkubaBCjI9cWpg31i6QJ7KmOXU2
 hTBeHVgaHvV30M/4j/+wfLBIT2k2cFkH4qVzEn680nY2O0YP3qGLJKX+T4xQlFuXK26G
 1SlKWma/xR1MpCBpRGnzzS0aPuNk+92naSinyU9nQh9cGIFqizcpCGR6f9ofD7OxLuxC
 FWe/ERmSQBUkY0yZ3JzL67v6oXDzigPJu8hwv6SwASeWigO/qj5ru0IF2AlQpQbSrHPQ
 qPqgcsuNfKaAgCnA68I1jdbjHv2cGOSNffzoRt49YMWS0mGG2ZRjJM+nGU+C7nngAVTW
 R0fg==
X-Gm-Message-State: AOJu0Yyhixww0p202UasKgrNq7eFfTHhYR/2dXZtsPF78vadOtqEAhh0
 m9x95JsEnYg3UneSZLpb0bPBPCqqCmMI223FCTwxVQxQzcY8UhobAlH9p8n+S3IpRBk=
X-Gm-Gg: AR+sD120YPlhFN7iaAz4SWbBhhQADARWGWkqWGmCVjeP50qVxz3xq60y6sPDSESTmuq
 8Rdd8lHHgji/xSbKuqf8FBpX5hzG3MzxrmSdlBrjjbivmjOYF/XBoDybyUd9WRras42Of5oqBJ6
 XwXJuBQGrEbkBe6L6Dsdb/m0FscaL0Yeu4zYoLLD4+513L2XhlUK2iVLhyNfYdf5vf2lBKt06jF
 7Yi4nhjE3aUXUnSDrKCZdN1ujGPFSN75jGck4+Hy4588T+m+zoIRFbj2EQryKPQdtwVOdwLQx1O
 +Ibj9kDi/V1cMK/I6qLmU7l5brREiQa9hpCDMJa4zwlf2s0aAN4KkSSlKEKFBLc+/A19z011Vya
 mX6hP9dP4OVKK6lqQiomJTjWGEZ9Wkjy6n479MK7pAuFklIurPG+9HBLwjj3PkUoMEZShHcO7eW
 fSS08dH4e2cwSyTFuJitFDF+k+jqJFfzJNPeZVLvWXOzWSW7foWxXM
X-Received: by 2002:a05:6808:d51:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4b2bcbebed1mr281885b6e.18.1787097468274; 
 Tue, 18 Aug 2026 16:57:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:04 -0600
Subject: [PATCH v4 11/40] bsd-user: Add os-file.h with chflagsat,
 close_range, and more
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-11-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6056; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=UZ8BkUb5dczCiuWUQgyyadQHaUWOnI0O7OOYUJ7kBfg=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEvJ6ubwk/ehtvO9jO10jkwnLr9UkLNERKe+
 UldTyUMohaJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxLxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDZEw//XgtCKfDNAO/hXoBjdDMzHheebTXnwWj
 YzaNZCDPx9uYlpO1oQpu/hQEAAhJr3R6dV24J2gLwA5m/s+93ZPZg/ti4pyEajOZ5rGEiRcpJ3d
 /bmSUjpThaKp1CVQdP0+tZz9Ja0J7u4V6kCOq6Y0q1oaVM8+uRQrVTRkc9hg5Kv/JyyDMy+QyZ3
 El/FLVKupYr8f/J5rQRdXTCiAlhL3oAh1Hyd6DXaCKkhqlS6fCS9c2WC5D6CNcxDAcuENE1Kbxd
 wHN+hmO2ry61FRqjpVc6bVMJ2dCPJ6RqTEfwCXPLYhnl1DRIHD7L5gds/Vn3lG7z7K4DTMFzK6C
 pcEIfRLbRPRUx/4nxYSNgNxC31HbG73+zty/4IVDXIy2X02Aov1MbyO3IpMZhPFo8fmQMudp2ms
 utGEtQ7YjZ/rgdBzcWmHS1sfzSZOtpxYgxUm7N3krKpPLv0a5nRu0LOgdZHzeHUn6dJyUa0chL7
 u55taoLPLC51yvwUsyXbJnGxMcWc1/+bnYSuKTWgwyIuHUbanJ93iHmVOXOK2B9ZRVCamxayG8x
 VTZZcBa1ZtgGOBDTVyCfjpizXHKzgDJaem9gQWZt+2NyshCcGc32f6R7QvRRH6Fw4re5cCm/Yo7
 eeKqH+EDyNQ7/kAyZuMVNOEQHYZDzGFmn/FZOfRgHYRpPnf2/ots=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22f.google.com
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

Add FreeBSD-specific file operation shims: chflagsat, close_range,
copy_file_range, and __specialfd. Also add the safe_copy_file_range and
safe_ppoll syscall wrappers and the target_specialfd_eventfd type
definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-file.h    | 103 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  25 ++++++++++
 bsd-user/syscall_defs.h       |  10 ++++
 3 files changed, 138 insertions(+)

diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
new file mode 100644
index 0000000000..d5d91336ea
--- /dev/null
+++ b/bsd-user/freebsd/os-file.h
@@ -0,0 +1,103 @@
+/*
+ * FreeBSD file related system call shims and definitions
+ *
+ * Copyright (c) 2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_FILE_H
+#define FREEBSD_OS_FILE_H
+
+#include <sys/specialfd.h>
+
+/*
+ * Asynchronous I/O.
+ */
+
+/* chflagsat(2) */
+static inline abi_long do_bsd_chflagsat(int fd, abi_ulong path,
+        abi_ulong flags, int atflags)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, path);
+    ret = get_errno(chflagsat(fd, p, flags, atflags)); /* XXX path(p)? */
+    UNLOCK_PATH(p, path);
+
+    return ret;
+}
+
+/* close_range(2) */
+static inline abi_long do_freebsd_close_range(unsigned int lowfd,
+    unsigned int highfd, int flags)
+{
+
+    return get_errno(close_range(lowfd, highfd, flags));
+}
+
+ssize_t safe_copy_file_range(int, off_t *, int, off_t *, size_t, unsigned int);
+
+/* copy_file_range(2) */
+static inline abi_long do_freebsd_copy_file_range(int infd,
+    abi_ulong inofftp, int outfd, abi_ulong outofftp, size_t len,
+    unsigned int flags)
+{
+    off_t inoff, outoff, *inp, *outp;
+    abi_long ret;
+
+    inp = outp = NULL;
+    if (inofftp != 0 && !access_ok(VERIFY_WRITE, inofftp, sizeof(off_t))) {
+        return -TARGET_EFAULT;
+    } else if (inofftp != 0) {
+        inoff = tswap64(*(off_t *)g2h_untagged(inofftp));
+        inp = &inoff;
+    }
+    if (outofftp != 0 && !access_ok(VERIFY_WRITE, outofftp, sizeof(off_t))) {
+        return -TARGET_EFAULT;
+    } else if (outofftp != 0) {
+        outoff = tswap64(*(off_t *)g2h_untagged(outofftp));
+        outp = &outoff;
+    }
+
+    ret = get_errno(safe_copy_file_range(infd, inp, outfd, outp, len,
+        flags));
+
+    if (!is_error(ret)) {
+        if (inofftp != 0) {
+            *(off_t *)g2h_untagged(inofftp) = tswap64(inoff);
+        }
+        if (outofftp != 0) {
+            *(off_t *)g2h_untagged(outofftp) = tswap64(outoff);
+        }
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd___specialfd(int type, abi_ulong req,
+    size_t len)
+{
+    abi_long ret;
+
+    ret = -TARGET_EINVAL;
+    switch (type) {
+    case TARGET_SPECIALFD_EVENT: {
+        struct specialfd_eventfd evfd;
+        struct target_specialfd_eventfd *target_eventfd;
+
+        if (!lock_user_struct(VERIFY_READ, target_eventfd, req, 1)) {
+            return -TARGET_EFAULT;
+        }
+
+        evfd.initval = tswap32(target_eventfd->initval);
+        evfd.flags = tswap32(target_eventfd->flags);
+        ret = get_errno(syscall(SYS___specialfd, type, &evfd, sizeof(evfd)));
+        unlock_user_struct(target_eventfd, req, 0);
+        break;
+    }
+    }
+
+    return ret;
+}
+
+#endif /* FREEBSD_OS_FILE_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 06148fe3ce..4fc230e8e5 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -44,6 +44,7 @@
 #include "os-stat.h"
 #include "os-proc.h"
 #include "os-signal.h"
+#include "os-file.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -65,6 +66,9 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
     off_t, offset);
 
+safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
+    off_t *, outoffp, size_t, len, unsigned int, flags);
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
@@ -692,6 +696,27 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
+        ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_close_range: /* close_range(2) */
+        ret = do_freebsd_close_range(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___realpathat:
+        /* __realpathat(2) (XXX no realpathat()) */
+        ret = do_freebsd_realpathat(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_copy_file_range:
+        ret = do_freebsd_copy_file_range(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR___specialfd:
+        ret = do_freebsd___specialfd(arg1, arg2, arg3);
+        break;
+
         /*
          * ioctl(2)
          */
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 47aa01fbb5..88dd7a763a 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -418,6 +418,16 @@ struct target_freebsd_flock {
 /* user: vfork(2) semantics, clear signals */
 #define TARGET_RFSPAWN (1U << 31)
 
+/* sys/specialfd.h */
+enum target_specialfd_type {
+    TARGET_SPECIALFD_EVENT         = 1,
+};
+
+struct target_specialfd_eventfd {
+    unsigned int initval;
+    int flags;
+};
+
 /*
  *  sys/uuid.h
  */

-- 
2.55.0


