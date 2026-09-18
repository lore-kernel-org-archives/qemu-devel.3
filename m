Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAC1C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAG-0005XG-IR; Fri, 18 Sep 2026 00:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA8-0005Mx-FW
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:24 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA6-0004Az-OM
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:24 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7f4f0d37f93so193850a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705521; x=1790310321;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1md8Q5IGeth07Sa1XguPxqxA55w0N697rIHuBKnwpxg=;
 b=UhjfdejzhzsuVHYEcgunhVWWR+hPm/oXHftVq2atxraryPtH996gYhCO+O3GVuNbxh
 MdBDaG6ufbX2RDC34AJmvlxN0aLpjH9wjLdAmiLTWzl9kg/pT2PC2H+ynPyWq4qn6c1m
 Sj+zLXnDB5/Uky72RK0fndzfp02mU/ZkWjxUpFe9ueIPGTLKwEbWGgbspZtN5blfA9pn
 QuFnG9aiX6A7l5fGJ8qnlldxN4XtfduxYUchHZeqSatW7F/AJAN2awvBBI+zKOcvQNHT
 Xj2r/ne2BnM0pbpkWHqwQiDPnTGhLUDlOqKoXkZymlV9Z5EPXwrxiaI9YMX1xVdXEyJj
 8VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705521; x=1790310321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1md8Q5IGeth07Sa1XguPxqxA55w0N697rIHuBKnwpxg=;
 b=mhZF0IkeauqKTnox4UcNUsscwhyytez3FDVAnEmrOKwMKMOwQQ4QDIYUfNX79ZYJHM
 gls6Q67RS74VlyY8NqOR4Q5/PFWrvAf7F3LSGEGwy5nTFjN68ZvvtK93VnBmars4AbZY
 WGf06/Wte+e529xCe8cE59B2vS6H8sbzlRkLY7FT8V59N6YjjFP0m7SDzRpayK90J6gG
 Co52Rl4nGO99saNucb/BNeZx++8QAKgCKjKsAyTkxUKxFMGCGX5Ah5mcnv6HKpCHtHwt
 YcBFf2ishYQA6F3hio2qYvhqgsGEFIkZ3lH6eyj4I+QnbQlVkQf6IBG6pcCWcrQMM2Dm
 Vzkg==
X-Gm-Message-State: AFuF++nIRpsgPelEwJ51gDDaFcLGVoT3Uk+I0yw8HhsEOsxyzjHhmovJ
 GgR3ES509i6Hlr13fuHfYBgHexVhi9hOm44GITsUGDaFP7CIqnQerT2I3dOUBRE9+PwoU1nVO9N
 CC3q5oeA=
X-Gm-Gg: AYBFou3F8EWbunznZNiIBNVUwXlRnw0umfbHx+EJUZh7x6WqawrRB4n8ml/gYN7zqJu
 csA6JpxSj98KUqSVxQ50IceJydx1rR0axyxOBPSzRSLisN4g4gUijgTeZM3mpcp7pCmHkD5GlfF
 Esmk22CnGADfCFGiUBeANBsZ/PiRd8JC/PLrX+Kk8dlr/YbHx7byNcbdE8tkNVKC4BKjJPU5VtE
 dQUSitA139o1GnfrmXsEfQW+9mjZAn0jAegt5+jfx5EF54DvjVxyu2lMicmMUgpm2guukQx1NkI
 Yf+XNccZcfkJHoK6Q9i/DIhNMwkJmpSzTMAEafeyzNqXGk5C6PB3OhPFlnphUe9QTFaLrgpW+Ij
 mRAkI8lhRLA/UtlEOMAEDIfwq7fNV5yD3OMTHum+3wp141jBW+GbCLFWpvzCFpIGYpRjgubHdUR
 cBBGF1r6b9Sjs8O3pc1wAuChbMIf27/87wgiTS/UFOpTU9HdBczod+jzMJSQ==
X-Received: by 2002:a05:6830:7318:b0:803:3878:bf56 with SMTP id
 46e09a7af769-80de38f0c33mr1412728a34.25.1789705521571; 
 Thu, 17 Sep 2026 21:25:21 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/41] bsd-user: Add os-file.h with chflagsat, close_range,
 and more
Date: Thu, 17 Sep 2026 22:23:53 -0600
Message-ID: <20260918042422.38713-13-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
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


