Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB51CD4F56
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VN-0000Om-6P; Mon, 18 May 2026 17:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VM-0000Nt-03
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:04 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VK-0000Ri-2r
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:03 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso2714638a34.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139681; x=1779744481;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X139v/fq6kIlZd7LLSuaNP39cVFCILWMkztN9EqyH7E=;
 b=ReCidHy/jDbtRVYUPUTmuvduggPQAd7wgk3sBfeGhZ9JTMLnrsbuA/JAQ+oQDxrOif
 3KgJf4Fwc7f+CkTBshlKtqJAUQpS6sfyRP8JPdYr7jPTTf2PcGsYP35Vp7Tf95pSP4wr
 Z1B2DgYJybrHHB+J4VclBCkdF8NWTkLpeC5/klCzGlzUFQemMnHw+f9eJAOboZhCs/mq
 H92BZClq0z+Yl+jw4LcWFjijbpeTDYkCy0oZRiuE9e+ixCxKppX3qJ35/yKv8R78AV9m
 VRys6KSxKl4aAYTb7VT4nT9k9C+4UBwm482q81xg36AR4qlxUqW4SQFFLCp5DRD+LzHy
 VDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139681; x=1779744481;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X139v/fq6kIlZd7LLSuaNP39cVFCILWMkztN9EqyH7E=;
 b=T+lmJ1IeDR1zXeydnUZvoPAPyID4kjslO44i5wxl26yWwYvyFRXDA/hYyEhFwTP4Jj
 4rR1awdLoiDek20AQRPHKihIlz/KnUmLEp9I4vdNl42pS1fEbYT1x90wzP+6hSDfVCTx
 luo627lm8eVvwz8CO99VdOI6ajc/xxQ2tEmwxe9E4kLEltDmpNyo3kz7I6r8P0hqSAgn
 shZlXL/9dNx29UhQWn+7I8zlVzcSVl1c1m6YMbMzKybsRHkeMAt0aO+GeD1RwU3NuUYV
 8vQnO6Q8Xg7n+m76HnftleFdttKaTxM8oeevq6xzhZ0TTA0wY+mGkz0PYqFu2DIe4bM5
 p9BQ==
X-Gm-Message-State: AOJu0Yx0tQ9CN/WbT/LLxm8T4c5QOiNGZXx85TTAMDcEPxrIlcSudzAF
 GkpqWmBjx+uM4OLqoOdKU7b9/J9SV+tl+khetOzmTgOULjHAZjhsCs+FQDJg0trBxgv0N0AREdF
 nDAk6rvg=
X-Gm-Gg: Acq92OFhVtEuMFKsTJVBKtky4t10yOTY3uiFHw06Mya8BbHtk5t5BSGj/c5bXysbqoc
 D5EtS2OwoBBoak7VHMr9csERLjURE60wELYG3i+gLDxbS/hKLVf02iyiHJdzoOUW1qEqRUrf3XO
 uySETq2e6I/ZlSAlRW1o2fdvNEwT0FacEFQJ81DacIMYsIw55E+5S9BJqU1Fbt/YfJt2CTgvj3y
 ThHf9qp09/Y1h6CviLkWqtnwINE5/bIF30HQzGnQq201rDCH9hsb0/QHSk9RJLFgAw0NBAw3E0v
 Wty27uBWb89oX09sS88jyyV6EY0A76D1hn52c+vg1UvSIR63OV5IQR4Vd9qdLXBDe15NNMRmgC0
 kzkPuAT6ipluZ1rvWVtyvd0OldM2wBTr/xWWTYITY5ePhq0+2Mlz2Xdh/VfvTd4hiPV1MaetkLi
 uwldOPpk0hqg==
X-Received: by 2002:a05:6830:349e:b0:7d9:f50f:9691 with SMTP id
 46e09a7af769-7e4de6b026fmr11827528a34.0.1779139680895; 
 Mon, 18 May 2026 14:28:00 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:27 -0600
Subject: [PATCH v2 09/37] bsd-user: Add bsd-socket.h with bind through
 getsockname
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-9-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7095; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=r4P6eqFpteuxxeqRzsUj7FYwHABI/v6ZFvzXHh1X9Fk=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGqKuWaGO+P/UGAlD0L4z1OhcTt5i6gFRQF
 X44I9CwOMOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 AHaXEADKIGGvCc11N3NhBhNBzrWQUsLhcvyd0HZiMsH52U1QskU7O+u+yaBq36ExrPLbl/Xai2v
 QcTZw0eZCXC4+CwUT8DsIuzEtJCJikmxEJl+IuoBYT/1vrgDVbFRF8EVU7Mw0nHn2jtTTAi7WUl
 jpL1H/SK0EITHdt+N0AlEVKCz+FXBaUajQfOgjbEmvQAfjpabu2Rf/4OQc9GvIppBTg8eRB0p1f
 zEZGNID+3IaWwo7HTqf7jBfUso3D1ApbWknwF6tv0yzCGJ1Ak+A4h6K+fWmTKAAnqZ2ldLeWFMB
 OtZXDCWOrFKDphDTN433gVpFSbb9ARPQAoPb9Qhbbop7KM+HgjFuoaYWhRdlF5vFMXmiahPdoWL
 WxFPELcoKrza2BENZ6aWMlAo0iUesbH2ZLl0lMmlKzbdrSuW+PW979AsoKmDAzi6azg2oUJGpCv
 owEvmt/Ifw/5P/V8usMSfJhAYNo1MqDteOoaNVqQK3N+67WVv0a5mvbXplhB1A9DhYLJeWpTlF6
 srAep60FzGlNtEANlOTwTUDCxtWiRZo2Ocu9OmyG3+Pvo+BUetPa83fG+GGGWLpH/oMM6Aj+td3
 NmOo2hkAb1WuG/fIHqpMzqCyGz2LSSPgZ0feEvUsm7R3URIMDCItmUh2S1V5igQdiXcA6xMaRYK
 TQizpvaxINCKlkg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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
 bsd-user/bsd-socket.h         | 167 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  15 ++++
 2 files changed, 182 insertions(+)

diff --git a/bsd-user/bsd-socket.h b/bsd-user/bsd-socket.h
new file mode 100644
index 0000000000..c786d6717a
--- /dev/null
+++ b/bsd-user/bsd-socket.h
@@ -0,0 +1,167 @@
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
+        if (is_error(host_to_target_sockaddr(target_addr, addr, addrlen))) {
+            close(ret);
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
+            close(ret);
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
+        ret = host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (is_error(ret)) {
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
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
+        ret = host_to_target_sockaddr(target_addr, addr, addrlen);
+        if (is_error(ret)) {
+            ret = -TARGET_EFAULT;
+        } else if (put_user_u32(addrlen, target_addrlen_addr)) {
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


