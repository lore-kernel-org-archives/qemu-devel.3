Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1AFCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gy-0002wc-Qn; Sun, 21 Jun 2026 00:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gv-0002vy-S8
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:53 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gu-000552-1l
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:53 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a0b1edbe32so2780568eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015711; x=1782620511;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kvUGahSEkdtAJdO2FteQD4GPP2ZsdlVT6D+xHuojI5k=;
 b=rYqHZvDXSmWsDSebKJkQowMS1jvEZ6O9wa423zHUyQ5hEg5EZL+YK1BuP9ALS9W9Jj
 3EyhQ5SAxkOgglAwjXl3qVZyUZHFVI1O8BMQZ9QzBoByRSemYS6ItUrKkwkl+1ht46pq
 IElD1izmRmA4zuD2otmjkzbNOeTEp8nxXtkOw+7NKr50yDTcVUqZ3wheQ76R0hAHxm9A
 KtWTt9BwznVFqi10or65XHASpaaTcrNuCgZmrtd50H+IhvB2k2JY9iJeawZp5lsldfUN
 EQuyypQfUdpM5pNN/IrCMcKJeSLN3kYESNazQ7sZFuS5WslD+odtUquC5RBk6K8d+dxv
 0Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015711; x=1782620511;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kvUGahSEkdtAJdO2FteQD4GPP2ZsdlVT6D+xHuojI5k=;
 b=FDVEjHMeSGBGay2dNCeLbCvH9WX2Kijz4tJWk7hrOQJ4XCGSk8786fRxW+7CfJTYE/
 +xfroJoEm456GRD6VO6Gw3KRPEjr/HcyIt9Yi4d+horSaojhHi9ZhzcBoCMheGdNfOPK
 3KxTpZiwVDp085iz3DRcjzhHWwR8LLdxyqZRitCx3QRuv1te3/E7gK0do8HfzLOoN8JM
 zjyR0llw/28kxPzQrdKaE1N+XQZB2Xc5bBHWMSar3CoggcK6/aKRWlR6RCJe5qAkp6C3
 csyyT+A0woPmGsDyYrTvswM84uG+mx7ntoyTJ6XERv+kRmu4Hccwvp3f43LPgazKAB7E
 13Cg==
X-Gm-Message-State: AOJu0YyvrPNDSNlxrGxO6/PZJp9R5U1u1qOiQnIxjjiOpTUzmuVfFmIh
 FXzS+1t2FQt7tEonihe7r0raOhSwen+dBwp1Q13Bupi0LM+ZEx8WI08+NTL1TRX4bySX2HNwuaX
 AhrSMswC8ow==
X-Gm-Gg: AfdE7ckGk1zrvQ2tvzgS/XIHJnXSh9TvHsBT9mjMI1JHiHy0GszQj/v/s3nncEmq6Lo
 jvTruOk/YOGicHIJ6mJt10ntBImZYThMX1w7izW3FmO6/aFh8hjTIREkjamupdgp2m184KFr7Db
 aamVGZXcsvNOjGVaz9mxwzu2py3QwXbZoKFI8tgC68Ui9aUhAbAJQbeLiPVJP9h8vJJ+fzbM5dW
 Xdb5Qqis4pHx2DazTyBZ/XB4QlhbFU6ZaMCQXPZfL1HUh4Lww9zQs8nm7i6Sw7dJt/tp1bizYFF
 5n4C67u96CLxoCiBpKDpYM6QeSWdyUMwMAtCDHl0o8h1V3F6VARFoVH70WKoJGXPdMfDsG/BPn2
 zX+uthX5Z/dD+eJO4tjrPRXr1Ee2vb/lDDK8oFE32CAM2vAyN3K0BZeS4IMcQjMBLz2k1xkOu0o
 Q=
X-Received: by 2002:a05:6820:828:b0:69e:34f1:9690 with SMTP id
 006d021491bc7-6a0de08c212mr7287708eaf.35.1782015710763; 
 Sat, 20 Jun 2026 21:21:50 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:50 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:56 -0600
Subject: [PATCH v3 09/40] bsd-user: Add os-file.h with pipe2, chflagsat,
 close_range, and more
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-9-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5387; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=ruAHVIgTwv2WPSDGUkKvT7snhR5AW/NAdfEJwFTECnc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z9cZobdqktg9QeO4O5x8Sg+kohoLh78VZmC
 BHK/1yU3N6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AHTtD/45JogC/VlXTLfTDMuSNtD0Oiin2SBBnrx7suNmVmfvYjCEGYkh3unvYhAm1sascHicjYy
 7BFjA6wL5jsIeYLC8MpvffqWhO7rqR+B6pcl4MukB4k4anMuJJlUzE2pFqqfmqvC4w0/H8KeK0p
 fZVCQ9nxuYLiWFpNpinX+oYvIxfAwVvhhRRDXVwBRSOBAM85ZwEdiegPq4P6cc3dswgaZPN/+Xf
 4Po+selBpNyKBo28p+4EOUgoXL1jnKpvFoD7g940UlsitBb8d9nrOp/IhaZCtdx4NA5KvFqB5cc
 SW2yNj+acCCEzntia8z7+kEqUyCkavJVCCPhsW84FoY8lwKTn61eL2wzpUTpH4TWjZFXK8nB6+c
 nvbMPZ5Bq578Fgt77AwwiNFxXUyBYtNjCHGjkYATtCfI4o7D1Yquz+fMZKdz1ibJ98eqF/wI/lu
 XQhOAqT+4g0c+L8mxo/1El7TeqYDqBbc56YCt6DRFPcfTPYLFnPvHsYjRu+ySKlAsPh3egwskco
 xfkDW7mDit+EA8eY3tE/Bz9n/BUEP4yZhOWDP1RPpnLh0jalQNCPWpKUxVIKiVptgQekPZA2MWj
 hQgmW+gT82Ur+XtoclLtz4Z05phjmAIoa4wmN/ec3z0l7PGSV0LUexqCW6TyyGzTrDSGIu7B5fH
 e2WCy3IIuVv7WVA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2c.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
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


