Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9849C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTh0-0002AT-9h; Tue, 18 Aug 2026 19:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgy-0002A3-MW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:04 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgw-0005G3-Np
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:04 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-459281bc13bso333136fac.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097481; x=1787702281;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iow9qajfhmYMga59c+8d/X1ecDIlGCULjEyRaVzS7QY=;
 b=oQLy8XsndxtgOsS7i0LbTZPQCYLnY8S1kuDc9Q0tprXkTT7D+wrgEbo9gT4+0VjzgY
 0c3zzNdQr74uMTu9oiqzsLHj/9IUnVB/dnRBi5vqyvHHC6h+3EAxx5PKxO0LkPM9r5R+
 IVBAokrDO/lDsJiJJvvOhGbOjcGF4h5ipPNjSEXx9spKaCdDzQVlOnKMSrSB9XaiI7VJ
 HYlPDnbUIdbqOfMttRasdMocOKDw0zZDnj2xISNdw3I1hGklIa8DmJsex+q95hg3OTuw
 KbNquFxPdP0Np9T+wtqF+lO8SVUqBLs9DHCCaVD3fA8qwMUA9Qc4aeS5PTzZppfvl+9g
 Kogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097481; x=1787702281;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iow9qajfhmYMga59c+8d/X1ecDIlGCULjEyRaVzS7QY=;
 b=JYali/a0V+GJCpwHsl4Wz+bC05qgOGJ1lZktPKnK4CGY7VPewJI/l+JGKoXPphK8iA
 v4aIxFkIHcJ+EmuZGeKz+/JLLpQQW4vp19RAWTC9cFiY3iHWIirv+eZ0n3H/79wewpGL
 CjXTNFshQDI9xF/kauUP3zrcsE2T5pkNJwcQRDqJ/sbmA6bKSvw5/2Lciw1qVf9CnSWH
 kjWqGFb+XjU/XSIH3UfByopkUCFEQM7pPwxtAVJzBM3CRO7+KSpAwiobWL5rKTklS9yw
 Z0pQfYYnn2f1zRCNcvqr4VTVfSVM5eVyAjsOb/9t9JXYR6/eroEkcfUyu7FEtbr42BBo
 ZSpQ==
X-Gm-Message-State: AOJu0YwisFy9C0HBhcJtKlei3FrFKx2zTHW9PRxgsmHUfJgr5xvTzkmu
 oylqN777yJFoGEyHK39nDC0w2UmSpNB/fhTjDOMIQ+5Pn7EBnRBpw1XNkw/6q803/En19C1x1Du
 hNZ1TEZA=
X-Gm-Gg: AR+sD12k6aPIfrNsx0k0Ox7LzVo7pjREJmLbT69gmnnU/9RclqtPfIpl8XyJYHzuwps
 ii5GivQsLVAptC2wCf3xq59A/K7v08Rz2D21wU6jD88ESHyyd37y/cD+ZraAS94MjUoeLKFTyVl
 fR/2dqlcjBIvHkqWTk1unA0TQlvaUxWMXXEWlVl0GLDKQBcjGoHR5m6svtjHLUI796dHfSuvoW8
 iwrmnnYI1ztxm0RTtoxpw2C/ZuurxZJXa7kWJjyLu3mglDqFJ3+W4F3vefym5SVo1OFXpjv8hqR
 x53DwA+8j02GzNKyQ8nIfHCE/mGmwwbapHl/RfmOUo4rWQACFlPqXMe1BPevX63kxAsLlVVp88o
 pU3JHm8wMC4yEzFrAZ1zjZL0ekJgPBtU+BShDiWbIEn76w06uEyXjc5XansgtbWk0YbzJz1uVVC
 KdQum2pqemrfhd7xDML/GpsY3JGhoMsw4mmMlczYXdUv70FGk=
X-Received: by 2002:a05:6808:14c3:b0:4a4:88ab:126f with SMTP id
 5614622812f47-4b2bcc22492mr313584b6e.21.1787097481554; 
 Tue, 18 Aug 2026 16:58:01 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:10 -0600
Subject: [PATCH v4 17/40] bsd-user: Implement both getsockopt and
 setsockopt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-17-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11486; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=6ZuOfhsrPJ64+xItOZmhdVLc9V8Npqc+NdbZVNt62Hc=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPE5QkShbRyhVc+UlJFrguPSkXaYK+fqvEHz2
 08+xF5d4JeJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxORsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQD/2Q//TZi8vxtUh3YbaFywwb/XbrJWRfYheiH
 jbavst1TDJlUW+dpVZ2qNIEjyTW10fhEowCCmAAILNwvqTFNnvLxWGTEinaXX6CPGlZ7bsgY6RV
 DEOT5whrznf2j03BAMDi43YGysrfqROUpf9fVeAS9tEzR40kQdNmSgtEY7AxiKchNDWQ4tkcxqU
 oLIT09UxZO7o287CV3Qm/BMHtH03sL8L+iWhfCMktw/jQhEyeU5kUwwfCe53/mR0+YBLitodza4
 K2ZADYWBLdWLCLpbuxcC4NgXCnXfvUR0Dzi1eQZHdtgUzPzxpwpaFUYlDFcAEaN9NkAfaS0nL5A
 PlAGhCTdzT37wPJkLYf+1fBB0Qsp/WJUB5qSY0ADiNURUUBLcfdIU8pOGiNWiLUvj9ZM0uA8GsT
 flvdGvNcpQIxFeBBo8YA24WPNaPS94SHvGUqkAFWaSkmZfs8CrWovfyvWBJzZmKpIeb9mNzumVU
 eMsct4gnKGQkLejCAnvUjYRimnwJ/+jvRhfR+AC8LxQH7SEG1DinYISqJxzrQAaZxg4l+8F2NQf
 a63Afq07G7DdkwpChDU9bPxPbvl+T8Prorzhsz5hxt0THFfXALMvyF3AeT5oc20yWED0A87Rsu1
 4FvWHxOqMdYgRmsmgGzImSl5q8esuCmj9YWPs8gqKyHlO3Sb0Szk=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::31;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x31.google.com
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

Implement get/setsockopt with the generated file describing the socket
options. This uses a table driven conversion. At the moment, we only
implement the simple types. For 64 on 64 with the same endian, we also
try to just copy in/out since the representation should be the same.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h | 340 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
new file mode 100644
index 0000000000..126e49b282
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.h
@@ -0,0 +1,340 @@
+/*
+ * FreeBSD socket related system call shims
+ *
+ * Copyright (c) 2013-2014 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_USER_FREEBSD_OS_SOCKET_H
+#define BSD_USER_FREEBSD_OS_SOCKET_H
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "qemu-os.h"
+#include "os-sockopt.h"
+
+ssize_t safe_recvmsg(int s, struct msghdr *msg, int flags);
+ssize_t safe_sendmsg(int s, const struct msghdr *msg, int flags);
+
+/* do_sendrecvmsg_locked() Must return target values and target errnos. */
+static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
+                                      int flags, int send)
+{
+    abi_long ret, len;
+    struct msghdr msg;
+    abi_ulong count;
+    struct iovec *vec;
+    abi_ulong target_vec;
+
+    if (msgp->msg_name) {
+        msg.msg_namelen = tswap32(msgp->msg_namelen);
+        msg.msg_name = alloca(msg.msg_namelen + 1);
+        ret = target_to_host_sockaddr(msg.msg_name,
+                                      tswapal(msgp->msg_name),
+                                      msg.msg_namelen);
+        if (ret == -TARGET_EFAULT) {
+            /*
+             * For connected sockets msg_name and msg_namelen must be ignored,
+             * so returning EFAULT immediately is wrong.  Instead, pass a bad
+             * msg_name to the host kernel, and let it decide whether to return
+             * EFAULT or not.
+             */
+            msg.msg_name = (void *)-1;
+        } else if (ret) {
+            goto out2;
+        }
+    } else {
+        msg.msg_name = NULL;
+        msg.msg_namelen = 0;
+    }
+    msg.msg_controllen = 2 * tswap32(msgp->msg_controllen);
+    if (msgp->msg_control) {
+        msg.msg_control = alloca(msg.msg_controllen);
+        memset(msg.msg_control, 0, msg.msg_controllen);
+    } else {
+        msg.msg_control = NULL;
+    }
+
+    msg.msg_flags = tswap32(msgp->msg_flags);
+
+    count = tswap32(msgp->msg_iovlen);
+    target_vec = tswapal(msgp->msg_iov);
+
+    if (count > IOV_MAX) {
+        /*
+         * sendrcvmsg returns a different errno for this condition than
+         * readv/writev, so we must catch it here before lock_iovec() does.
+         */
+        ret = -TARGET_EMSGSIZE;
+        goto out2;
+    }
+
+    vec = lock_iovec(send ? VERIFY_READ : VERIFY_WRITE,
+                     target_vec, count, send);
+    if (vec == NULL) {
+        ret = -host_to_target_errno(errno);
+        goto out2;
+    }
+    msg.msg_iovlen = count;
+    msg.msg_iov = vec;
+
+    if (send) {
+        if (msg.msg_control != NULL) {
+            ret = t2h_freebsd_cmsg(&msg, msgp);
+        } else {
+            ret = 0;
+        }
+        if (ret == 0) {
+            ret = get_errno(safe_sendmsg(fd, &msg, flags));
+        }
+    } else {
+        ret = get_errno(safe_recvmsg(fd, &msg, flags));
+        if (!is_error(ret)) {
+            len = ret;
+            if (msg.msg_control != NULL) {
+                ret = h2t_freebsd_cmsg(msgp, &msg);
+            } else {
+                ret = 0;
+            }
+            if (!is_error(ret)) {
+                msgp->msg_namelen = tswap32(msg.msg_namelen);
+                msgp->msg_flags = tswap32(msg.msg_flags);
+                if (msg.msg_name != NULL && msg.msg_name != (void *)-1) {
+                    ret = host_to_target_sockaddr(tswapal(msgp->msg_name),
+                                    msg.msg_name, msg.msg_namelen);
+                    if (ret) {
+                        goto out;
+                    }
+                }
+
+                ret = len;
+            }
+        }
+    }
+
+out:
+    unlock_iovec(vec, target_vec, count, !send);
+out2:
+    return ret;
+}
+
+
+static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
+                               int flags, int send)
+{
+    abi_long ret;
+    struct target_msghdr *msgp;
+
+    if (!lock_user_struct(send ? VERIFY_READ : VERIFY_WRITE,
+                          msgp,
+                          target_msg,
+                          send ? 1 : 0)) {
+        return -TARGET_EFAULT;
+    }
+    ret = do_sendrecvmsg_locked(fd, msgp, flags, send);
+    unlock_user_struct(msgp, target_msg, send ? 0 : 1);
+    return ret;
+}
+
+static inline struct sockopt_entry *get_sockopt_entry(int level)
+{
+    for (int i = 0; i < ARRAY_SIZE(so_cache); i++) {
+        if (so_cache[i].level == level) {
+            return so_cache[i].entry;
+        }
+    }
+    return NULL;
+}
+
+/* setsockopt(2) */
+static inline abi_long do_bsd_setsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, socklen_t optlen)
+{
+    abi_long ret;
+    int val;
+    u_char ch;
+    uint64_t val64;
+    struct sockopt_entry *e = get_sockopt_entry(level);
+    void *p;
+
+    if (e == NULL) {
+        gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    while (e->level != SOCK_LEVEL_NONE && e->optname != optname) {
+        e++;
+    }
+
+    if (e->level == SOCK_LEVEL_NONE) {
+        gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(e->type) && e->type[i] != 0; i++) {
+        switch (e->type[i]) {
+        case SOCKOPT_TYPE_BOOL:
+        case SOCKOPT_TYPE_INT:
+        case SOCKOPT_TYPE_U_INT:
+        case SOCKOPT_TYPE_UINT32_T:
+            if (optlen != sizeof(int)) {
+                continue;
+            }
+            if (get_user_u32(val, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &val, sizeof(val)));
+        case SOCKOPT_TYPE_U_CHAR:
+            if (optlen != sizeof(u_char)) {
+                continue;
+            }
+            if (get_user_u8(ch, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &ch, sizeof(ch)));
+        case SOCKOPT_TYPE_UINT64_T:
+            if (optlen != sizeof(uint64_t)) {
+                continue;
+            }
+            if (get_user_u64(val64, optval_addr)) {
+                return -TARGET_EFAULT;
+            }
+            return get_errno(setsockopt(sockfd, level, optname, &val64, sizeof(val64)));
+        default:
+#if HOST_LONG_BITS != TARGET_ABI_BITS || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+            gemu_log("Unsupported setsockopt level=%d optname=%d\n",
+                     level, optname);
+            return -TARGET_ENOPROTOOPT;
+#endif
+            break;
+        }
+    }
+
+    /*
+     * When bit size and endian are the same, the structures are the same (we hope).
+     */
+    p = lock_user(VERIFY_READ, optval_addr, optlen, 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(setsockopt(sockfd, level, optname, p, optlen));
+    unlock_user(p, optval_addr, 0);
+    return ret;
+}
+
+/* getsockopt(2) */
+static inline abi_long do_bsd_getsockopt(int sockfd, int level, int optname,
+        abi_ulong optval_addr, abi_ulong optlen)
+{
+    abi_long ret;
+    int val;
+    u_char ch;
+    socklen_t len;
+    uint64_t val64;
+    struct sockopt_entry *e = get_sockopt_entry(level);
+    void *p;
+
+    if (e == NULL) {
+        gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    while (e->level != SOCK_LEVEL_NONE && e->optname != optname) {
+        e++;
+    }
+
+    if (e->level == SOCK_LEVEL_NONE) {
+        gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                 level, optname);
+        return -TARGET_ENOPROTOOPT;
+    }
+
+    if (get_user_u32(len, optlen)) {
+        return -TARGET_EFAULT;
+    }
+
+    for (int i = 0; i < ARRAY_SIZE(e->type) && e->type[i] != 0; i++) {
+        switch (e->type[i]) {
+        case SOCKOPT_TYPE_BOOL:
+        case SOCKOPT_TYPE_INT:
+        case SOCKOPT_TYPE_U_INT:
+        case SOCKOPT_TYPE_UINT32_T:
+            if (len != sizeof(int)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &val, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(int)) {
+                if (put_user_u32(val, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        case SOCKOPT_TYPE_U_CHAR:
+            if (len != sizeof(u_char)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &ch, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(u_char)) {
+                if (put_user_u8(ch, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        case SOCKOPT_TYPE_UINT64_T:
+            if (len != sizeof(uint64_t)) {
+                continue;
+            }
+            ret = get_errno(getsockopt(sockfd, level, optname, &val64, &len));
+            if (ret < 0) {
+                return ret;
+            }
+            if (len == sizeof(uint64_t)) {
+                if (put_user_u64(val64, optval_addr)) {
+                    return -TARGET_EFAULT;
+                }
+                goto done;
+            }
+            continue;
+        default:
+#if HOST_LONG_BITS != TARGET_ABI_BITS || HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
+            gemu_log("Unsupported getsockopt level=%d optname=%d\n",
+                     level, optname);
+            return -TARGET_ENOPROTOOPT;
+#endif
+            break;
+        }
+    }
+
+    /*
+     * When bit size and endian are the same, the structures are the same, and
+     * if not that is handled above.
+     */
+    p = lock_user(VERIFY_WRITE, optval_addr, len, 0);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(getsockopt(sockfd, level, optname, p, &len));
+    unlock_user(p, optval_addr, ret < 0 ? 0 : len);
+done:
+    if (put_user_u32(len, optlen)) {
+        return -TARGET_EFAULT;
+    }
+    return ret;
+}
+
+
+#endif /* BSD_USER_FREEBSD_OS_SOCKET_H */

-- 
2.55.0


