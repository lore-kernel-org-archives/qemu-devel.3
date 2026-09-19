Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A0BC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFD-0002qU-Lx; Sat, 19 Sep 2026 12:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFB-0002q1-94
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:53 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yF9-0008Fl-8E
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:52 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6bd42f1c01cso1143730eaf.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836530; x=1790441330;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1md8Q5IGeth07Sa1XguPxqxA55w0N697rIHuBKnwpxg=;
 b=FXW34iQyOoSITpOvVC5+Ri+Vxi20PM2S3TigrSbYL6zjM1+iEDw5H35TJafuR+tR8O
 chGDcGfuPyfSYpPh6vuxKor7WHi7ZcmcqwzgDytuo+9xnPy4aNPO9toUbWj+BPZ0EbIR
 9ljZJ7cigtdN8/P928pPbdy/IF3CRw7d0sMSWoaY1TkfR7YWqTqq2GOOaMXLTXxq612A
 dbbKI8s3THk6PyA8OBnLjYXMPoK+bH2y7Ov2zGBCNuyXN+WcIQ20qP0ZvR4K+3QKSp/j
 S5g+4VqcxTwoYLWA6W3KFvpnHKiQDrOESvXJjGDLn410jSWMU62c4lABLGA8FDZ0xhJ6
 rQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836530; x=1790441330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1md8Q5IGeth07Sa1XguPxqxA55w0N697rIHuBKnwpxg=;
 b=uk38bIi24Ln9ijX0UAxQugeEu4+YTzOsLf+yWhVPxxgoupDzgFpAu0n99Be38AEr6U
 1b7HyQbpu55WnnFPIb0tJLLaAM5WlsgLsUpe08GyLXEJplGn5ExxSxDyn9kElz7kPMNy
 6mpk65cU2FyY573taUiLxFJc427FVXvVAgJDFI2slu78uVgYumEg0mbWw9IE50eXQqso
 sIZdL61g66OUZcJteIUyb5oP4vVa77TH1PzEijSmOP/liJXhMaV6yzephhaKSfcG0FAp
 o064bqOTLzfqHRGH1uxTx5Wt5LB/AtxCMSbx4gW7UqgctMrNwKOIDQnSFZ84CIiRn+ex
 W6ig==
X-Gm-Message-State: AFuF++l6rAlfFPhZsfIdVhfMpFpYNsVP6K69Hco8IayBvpxckFYcbb05
 AevvIhsik+yiAbY3F8ppfDhrurBeKxN3BL/uvVt1OKclX9c8LPWi8FBYAtv2wc6lSq2JX9zELgx
 S9BflwiY=
X-Gm-Gg: AYBFou1Y1W82IobHhHO1SQ8kV0+D2w3MvTCSIEtW1jNxg2Fe94YK2s99tB8GUDa88UE
 6WXBIwb2wAhhx8lweYXONvmLM3iM/TpgTjeYxEiQqvaBKFjkT5enldVmkTivWAK2sZrfhpjEA/p
 cBBxAIUJtVpgew9qTzpbLiajouLVyIOSPEIP00Qiy9cK7NY/Y/7OfUUYxH12c2VwFHxQsjz2vTl
 r+2DVp56fSWOxAoDiXK5mKys/fAYNdHydBDzm5cny2bZUjmU2kx7WJ64qMRaULEPjuHq5KJOHPr
 bEs5X/IGUOY5d0j9t6SJuClNNWUageaH+5u5Sr/TpbMXXbFqSflTABip6mw8rrmC78/k9rFkq9l
 2X9t9ezoooqlism3jFlLdtBRbiGUrlrDatO9UD0GJxrD0zoHpq9/ottIL8LmbqBWpRvCpt7nh38
 NMyh4FGeqdpfN+zE15J+oom/cFABbJUWrfCpyRPUMLxl2fuX3iZL8Sq4Olkw==
X-Received: by 2002:a05:6820:1ca3:b0:6c4:6699:53b7 with SMTP id
 006d021491bc7-6ca9c659e48mr5371952eaf.52.1789836529975; 
 Sat, 19 Sep 2026 09:48:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/41] bsd-user: Add os-file.h with chflagsat, close_range,
 and more
Date: Sat, 19 Sep 2026 10:47:40 -0600
Message-ID: <20260919164810.70151-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::f; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0f.google.com
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
 bsd-user/freebsd/os-file.h    | 103 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  25 +++++++++
 bsd-user/syscall_defs.h       |  10 ++++
 3 files changed, 138 insertions(+)
 create mode 100644 bsd-user/freebsd/os-file.h

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


