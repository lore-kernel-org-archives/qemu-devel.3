Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BCBCD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VL-0000Nr-UJ; Mon, 18 May 2026 17:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VJ-0000N5-Rn
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:01 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VI-0000RR-6U
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:01 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7de46b8e432so3023516a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139679; x=1779744479;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=enfB29ZT++A6esf/xt68p8+6rURzXiv6x7129bGT2E8=;
 b=R9QTpCqzRajqK7zwItB/FObMrkFgrd0cjNub/v9mE0SkaP13M+pLOCH+yNd6Ms10QC
 y/TqkBnqYVS4wiSQS+3Fzyxwe4xEF9ymz3T2WZ/xa/RmxS9VEt0PgpizOSPMycutowCf
 EppVw2LyHXytxUxXRZQKXtR08AKxEOx8UZGgaJoq3qkA7FIcA0AgMu7ztMgjMSJ6nsBn
 f+mfAEHLMDdN6U/9YLDrmgvPSqf4/7B0xDEv9iAr965Pe6/DTJMqsljCi9EUfS5qNCxt
 sWT2jULPP9G3/0GIzO8sLh7vAdzBqZjme+mFDBeboBXFi2cXPMLp8bDhPnvsUhLTvP7N
 aEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139679; x=1779744479;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=enfB29ZT++A6esf/xt68p8+6rURzXiv6x7129bGT2E8=;
 b=mjAHhXrTRUFihP10nhUP6C4CA83vKYXcol7ps7eyVCNRHjQqt9+Z5ltbCkkF/fUWAn
 tOjvzubqQvHvvlGGvXYRTQrcE7h2sweNk2vvC7g6KNsfni1C88qqeQXovnm5neurPwJZ
 Y2JrOaIHWmsTkx5D5LHxAz5yPCo0rMjBeytPm5ChTa4Ywuqo32615/8EJoKxkysf4tRh
 XwQ32fynyznZ3yKqMtslAQA0y2ujeXNyDBkgku3vof4z70ArzecxO1GgsJDMf3AINAvI
 4UtRgAVoW5kHDJVvl0e6GdzZHwgj3n3vqcGlzgw7WreCbxatPdD3odH8q5blp+elfhKx
 o9Uw==
X-Gm-Message-State: AOJu0Ywxa95iwOl/f+fiMffZAg70CwxfEi9J3zs4Ojdqdrt+p6QRl3oy
 q3S97yXiLUMiHrhZ3sWIQnrHTWOZR/MgnXameV3qOJWFv8vk5qOtl/HO7gOCwBruKTs=
X-Gm-Gg: Acq92OF7fF+AXE3EnzJQQfc2zt0zHwH59iZvo7vNqjQRfh7TFFbB3CDkGG/4HQ6gY95
 pkMrjxRTxYjVsIbAKbBwpBQ0Jc71vr8ITKBmUCzERn8CEq+LMgndcgV94nNZIBESorhl1rOYSsB
 hwt/rx/5BvmP8Hbh4e/52iwnJHyck74MTKkjGiApZIrb/re+dyshmJks/+hA7jwzrnZXXIdkayk
 UFVoZ5q4VnMHO3IYmwYGIvJ3IYH0ZKNfeqgLvdPxGNEgksaErZUNijqF7At7AFs4pfcE22Bho9d
 xxk3SIZqQfKNDDVpK7YLSBodFXlfs3G/zmoElpS3FX5iFZKS97bRltsBUYZuBzaZvL6ykClOdKw
 kmTJQSEpOI/C/cM3O/58XS5HGKidJTqdpvOI4akX4qy084aCUswZ/JKN0z5Q/728Ejy3kpIQEQx
 jZmA1O+0+T+g==
X-Received: by 2002:a05:6830:3491:b0:7dc:d2ad:fb17 with SMTP id
 46e09a7af769-7e4f2badcfbmr11158504a34.20.1779139678870; 
 Mon, 18 May 2026 14:27:58 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:58 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:25 -0600
Subject: [PATCH v2 07/37] bsd-user: Add os-file.h with pipe2, chflagsat,
 close_range, and more
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-7-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5320; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Ozt5eWI3K63GhGf+oDsW6s0bMNMzgP0Gg1AeLwpTn9U=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGKfvaPLObdPFwn3rFrp73epRUZR4KMJYVA
 CTGPfYrxR2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 AJ0DD/95LW4NmHTXhy3BbB6n0CZWMuecq2jOdAtaRy2arUuR1wTp+ovzMWLjOrYcQtkVIlq21Am
 /kcAi6yNvPqNXKtPqYw7jLvM3QceWobtJQ6N+Ece2hxf+NP+EFwxtkxkUM2XCJjdPs9umv6AJOF
 MxEndTiozzbBiDMNvKoUtHS6BEjmna61UFUemvZscCGkH5Mjr/CpkIIZfvtJ0OJuygV2Ciq3Bgz
 I/m0ODpOoe/TcJyGx68UpEJksYI9xmPLg4DA8XBaYRLlG1SmEJhVLj34iOmP4y9pXGlWwuOnAs1
 /g08rpR7cqGmuUPvo6KvhJGnKOiAxRX+Fv3M7g2JUZ8bQoosR4VHtxM0bB2RInAfdQFe/LhyNGo
 v3Ix1qe0pen0Rnc6OJAmm6V1btXc88tiDuLrc7tLVVdbNH5qoLu+pgdjlOJ+IQsCPRJtHg8x/rn
 zGVDI0KIuXflTfq0MtMNfDnywItg7PI/e9K/mbPWyx1OYGY8V01GjOEkArOJ4jb0ocV+JWKBVvg
 bunx0QpjboYQ/haPIxuzXcp17JnulgbUM6HJ3/ahTgRrwqqZpFuhYEE+5UtJxbdJ2ktI/4t+SMV
 LZyfWeSJ7BNW7iOWlw79+Kxm4SPr53punC59sT88g+1B71jgWXSGidf5idlAiA3qpmb5zw3Tn6w
 N4AqVo2Sqjod7mw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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

Add FreeBSD-specific file operation shims: pipe2, chflagsat,
close_range, copy_file_range, and __specialfd. Also add the
safe_copy_file_range and safe_ppoll syscall wrappers and the
target_specialfd_eventfd type definitions.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-file.h    | 129 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   7 +++
 2 files changed, 136 insertions(+)

diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
new file mode 100644
index 0000000000..c1da52789a
--- /dev/null
+++ b/bsd-user/freebsd/os-file.h
@@ -0,0 +1,129 @@
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
+/* pipe2(2) */
+static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, int flags)
+{
+    int host_pipe[2];
+    int host_ret = pipe2(host_pipe, flags);
+    /* XXXss - flags should be translated from target to host. */
+
+    if (host_ret == -1) {
+        return get_errno(host_ret);
+    }
+
+    /*
+     * pipe2() returns it's second FD by copying it back to userspace and not in
+     * a second register like pipe(2): set_second_rval(env, host_pipe[1]);
+     *
+     * Copy the FD's back to userspace:
+     */
+    if (put_user_s32(host_pipe[0], pipedes) ||
+        put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
+        close(host_pipe[0]);
+        close(host_pipe[1]);
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
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
index fc6273a780..8a25be4ac7 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -45,6 +45,7 @@
 #include "os-stat.h"
 #include "os-proc.h"
 #include "os-signal.h"
+#include "os-file.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -66,6 +67,12 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
     off_t, offset);
 
+safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
+    const struct timespec *, restrict_timeout, const sigset_t *,
+    restrict_newsigmask);
+safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
+    off_t *, outoffp, size_t, len, unsigned int, flags);
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);

-- 
2.52.0


