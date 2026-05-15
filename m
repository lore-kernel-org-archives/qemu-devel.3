Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9859CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx7-0001Bg-KA; Fri, 15 May 2026 17:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx6-0001Ah-Er
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:12 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx4-0002rM-Gx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:12 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso312780a34.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880009; x=1779484809;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dhzXJy3OEpRA4uBwKk/HCvyifLHxiSUo68RBlzjPfO8=;
 b=PzoYbP9CHic6ePrirRK/xWz+8vhjF3SWlq/scOviITTPO+RWycOkahb7ZkwaHC3WXA
 pTAI/R/nIEIxbRFgTlWU58xFuv+1uHTHfjg3Rrz6fHaQts5iH7HvwXq6o/Zrxr6WaEid
 NJYU1sZNAlikZ69QWdeEb+KbikaNLjZEC3Y9Gorfb3iuruBLWxsN6mdXFZSSS62czPuC
 Pd6NLY62aciyBkV+nLwCNg8MvZ67TQIF518n+j6Er8LK33/0tK0AHkDcFRr5JK0NMiid
 egl15PZIkGZK5JItdeiZgZtrllWk79oxtRGRPeAtdmnxMrs9Vih7wldMYFcCjTdElxYp
 d1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880009; x=1779484809;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dhzXJy3OEpRA4uBwKk/HCvyifLHxiSUo68RBlzjPfO8=;
 b=g4amXoSLDyyCxGHgR9DK1HtAnPWy9AnxQGEn8AWYjS1I6QJ/CTQ5/BR9cUrOXYdyQL
 8JOhb73AIc6Gf3wJbilx3XLWVyMvSSvmfMvrxD6umDrYO557rZxhJDflh0PmrSsa+vSa
 c+Xmu/Aw2sJ7FhKD1DNr7SwfFrlib5FE2FJ3mKYo4TKUFWFcAlt9B8b1NaPphWbn8a/q
 p3pQyQcR5NbFDvbWRuDEWG+xovvo6aOLWdi/YytOnMaJ3MzeQlf78yg6u5HbtSCHY3GD
 bc9vqVU5Kly1yBNG2urFXCA/SiC9x3xm5kGjyp3hSz8ssH4T5vMqnsos7oLYsxp+SN9+
 yEjg==
X-Gm-Message-State: AOJu0YyUVZKkZTuFwz5AZB4+kVWdb+DFdZMM5CAtL2hP18qaZArcSx9c
 3FAKp68ZWYWKxUX85hROdJ6i+hMmm0AKDH0Fut6odXn7QRGRHSZ5hwoys9O70VrApTM=
X-Gm-Gg: Acq92OH4g83qXBF5AL7ue4lLVoTS4OYedxPdvL3K/CpKNUg06sS8EH4UJcf5vB87Lqf
 7a8eTaO5TV7k2OYUjLDSqEFG2doEExhnx/X3qsXiFcDhZ1LfgY/yH5jd8JOgAGZWVUhlLI0nsoR
 CBWfeavdaOPECQUc9VYHDeL2B9Y0gszmnN9yuzfxTIEyu/DSffYzrw+KcUggO0pT96pZS90Rm1d
 wGKHNJE4gLv3YrXyfkJOxJfTJozXHLIw1Ack6D7ExIXEpwKL9+BQ8Qkfabi+3SriiWAh5E5zj1w
 dTmXaIFIBUmFfZ6cMSTe/QqdPgmmUVg+/geDmQG8a7rbc37k+YvZQeAPMQjsI/ZjgDtkdALKKet
 3b/Q9crdurSQJZATYimp3P7Y/hoSYsk/xPjHrJci73TxstWIT7+5tmcAJE9cTGD68BOoXAJCYbX
 12lEXgJu8+3w==
X-Received: by 2002:a05:6830:4128:b0:7d9:b2b8:e06f with SMTP id
 46e09a7af769-7e4f2b6f1f6mr4034266a34.21.1778880009140; 
 Fri, 15 May 2026 14:20:09 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:08 -0600
Subject: [PATCH 09/66] bsd-user: Add bsd-socket.h with bind through getsockname
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-9-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6824; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=fqu9+KzJbMBPt8l/2aDcgObMouWx7lPgmNU+jL1ZR/A=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43igUlr0lWqzA60T38xtzEOAQ6vA2Q9Ft7BB
 IXOqTLgo+SJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 ABLaEADcVrHbSHxu80ZlX5f7gz5GAaoOsENabOmFXYFfhc/HmLEb8MWgbrG+eeJZ1jM1yW6axCn
 8ad7w+6bZ5D4h1hyTOblcPFUqz6j12IxUmTMCvyjibGKB0tygqQpTmA3cP+dg4VpPYcQWeCQA9i
 M4JxvVAtaLwDh0QL8zPn/4jKjEVC5HAn/bwtQJWG8wkcyMbi3rOTfc3xS422CVQoZreDYJA2c8+
 KxENGuhvyV0teK6F76O/pHf99AVY+YjylqonsaznsT0hdnL5LKtQ8LFSELbubWlDy2RGmso/psm
 cZ1s39caJHJ01MYODIoS7ZM7KVxYoDUgq75pX3tzfxq7qjjgaz81o6IkUn+m9ibPjJW6NmRuiRW
 eocA/2Xs1tf3DnF5VZcL0R8Ty4duo4X31T7djlkG9yuFkKTf981VOnC1rC5nFo/RE78RbmHeA1I
 IzxpbyPcg/Eo8L5CjxfG44yPJ8tGLG1GcD/2qbTmPqnKjpkgfkKyZ5c2lmoqMphOoEvtTlAwzMM
 e5g5Pdr+5gJ70CICG4xK/dLvpi9yAy/D2/8sem0fcLM93xFQCxAt3JiEAm1+RduXW5L1WRvruWN
 nhey3nJVWUm3/4VLIylPbTVLbuoOzAcKp0DMfJZHa7fNvJajoBsXfjjjU2DmtFmW+/16w8/8X4b
 O4TqwyTK6ujN48g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32a;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32a.google.com
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

Add the first set of socket system call shims: bind, connect,
accept, getpeername, and getsockname. Also add safe_syscall wrappers
for sendto, recvfrom, select, pselect, recvmsg, and sendmsg.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-socket.h         | 160 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  15 ++++
 2 files changed, 175 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
new file mode 100644
index 0000000000..121d3e2a05
--- /dev/null
+++ b/bsd-user/bsd-socket.h
@@ -0,0 +1,160 @@
+/*
+ * socket related system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_SOCKET_H
+#define BSD_SOCKET_H
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "qemu-bsd.h"
+
+ssize_t safe_recvfrom(int s, void *buf, size_t len, int flags,
+    struct sockaddr *restrict from, socklen_t *restrict fromlen);
+ssize_t safe_sendto(int s, const void *buf, size_t len, int flags,
+    const struct sockaddr *to, socklen_t tolen);
+int safe_select(int nfds, fd_set *readfs, fd_set *writefds, fd_set *exceptfds,
+    struct timeval *timeout);
+int safe_pselect(int nfds, fd_set *restrict readfds,
+    fd_set *restrict writefds, fd_set *restrict exceptfds,
+    const struct timespec *restrict timeout,
+    const sigset_t *restrict newsigmask);
+
+/* bind(2) */
+static inline abi_long do_bsd_bind(int sockfd, abi_ulong target_addr,
+                                   socklen_t addrlen)
+{
+    abi_long ret;
+    void *addr;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+
+    addr = alloca(addrlen + 1);
+    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(bind(sockfd, addr, addrlen));
+}
+
+/* connect(2) */
+static inline abi_long do_bsd_connect(int sockfd, abi_ulong target_addr,
+                                      socklen_t addrlen)
+{
+    abi_long ret;
+    void *addr;
+
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    addr = alloca(addrlen + 1);
+
+    ret = target_to_host_sockaddr(addr, target_addr, addrlen);
+
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    return get_errno(connect(sockfd, addr, addrlen));
+}
+
+/* accept(2) */
+static inline abi_long do_bsd_accept(int fd, abi_ulong target_addr,
+                                     abi_ulong target_addrlen_addr)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (target_addr == 0) {
+        return get_errno(accept(fd, NULL, NULL));
+    }
+    /* return EINVAL if addrlen pointer is invalid */
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EINVAL;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EINVAL;
+    }
+    addr = alloca(addrlen);
+
+    ret = get_errno(accept(fd, addr, &addrlen));
+    if (!is_error(ret)) {
+        host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (put_user_u32(addrlen, target_addrlen_addr)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* getpeername(2) */
+static inline abi_long do_bsd_getpeername(int fd, abi_ulong target_addr,
+                                          abi_ulong target_addrlen_addr)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EFAULT;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EFAULT;
+    }
+    addr = alloca(addrlen);
+    ret = get_errno(getpeername(fd, addr, &addrlen));
+    if (!is_error(ret)) {
+        host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (put_user_u32(addrlen, target_addrlen_addr)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+/* getsockname(2) */
+static inline abi_long do_bsd_getsockname(int fd, abi_ulong target_addr,
+                                          abi_ulong target_addrlen_addr)
+{
+    socklen_t addrlen;
+    void *addr;
+    abi_long ret;
+
+    if (get_user_u32(addrlen, target_addrlen_addr)) {
+        return -TARGET_EFAULT;
+    }
+    if ((int)addrlen < 0) {
+        return -TARGET_EINVAL;
+    }
+    if (!access_ok(VERIFY_WRITE, target_addr, addrlen)) {
+        return -TARGET_EFAULT;
+    }
+    addr = alloca(addrlen);
+
+    ret = get_errno(getsockname(fd, addr, &addrlen));
+    if (!is_error(ret)) {
+        host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (put_user_u32(addrlen, target_addrlen_addr)) {
+            ret = -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+#endif /* BSD_SOCKET_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 228daed4c4..737de36514 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -40,6 +40,7 @@
 #include "bsd-proc.h"
 #include "bsd-misc.h"
 #include "bsd-signal.h"
+#include "bsd-socket.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
@@ -73,6 +74,20 @@ safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
 safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
     off_t *, outoffp, size_t, len, unsigned int, flags);
 
+/* used in bsd-socket */
+safe_syscall5(int, select, int, nfds, fd_set *, readfs, fd_set *, writefds,
+    fd_set *, exceptfds, struct timeval *, timeout);
+safe_syscall6(int, pselect, int, nfds, fd_set *restrict, readfs,
+    fd_set *restrict, writefds, fd_set *restrict, exceptfds,
+    const struct timespec *restrict, timeout, const sigset_t *restrict,
+    newsigmask);
+safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len, int, flags,
+    struct sockaddr *restrict, from, socklen_t *restrict, fromlen);
+safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
+    flags, const struct sockaddr *, to, socklen_t, tolen);
+safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
+safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);

-- 
2.52.0


