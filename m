Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A177BC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFT-00034u-1a; Sat, 19 Sep 2026 12:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFP-0002yh-Ge
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:07 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFN-0008Iz-2V
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:06 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-80032c08611so1189015a34.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836543; x=1790441343;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eYUyMQoT40u2msHNKD8OftoQr7GgD9EvZv1AL0aAxu4=;
 b=y7I5UqtGzYbm//dwzWmZnx3D4mChy/L7UO8MnIWFnehUO86jakoVAiwKkDDcBq1fyA
 oGkjveO2GdAc5xLy2yXrMhujPMxwgFyXc+r3VLmVZJ1JvyquZzlGFQbIuqLlD4FrU1k9
 RERzz2PxY/A0ZnmzGyDbPSLpZpMFxtvhG8Ggdh/dQIYgoe09Y7mWqpYiPdzpTMRKJwcz
 pHlxy0WbgQICHLeE5HqZVd5QSbTK4swizQ1VkGuNvinDj6TJIGJxHo6YdJGdLxKHnyWb
 gUFgcraEbn/EJ6VWI4v4FPCd3+pZkvihgR3vER9lRQZhHIaCxZnXx0XVX7OH2oObzEgt
 ycqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836543; x=1790441343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eYUyMQoT40u2msHNKD8OftoQr7GgD9EvZv1AL0aAxu4=;
 b=Jr+3cnlWN0+bhQMGdUiKIEWqMCxT0eaaIOX3JF9amlRtX9keePU+tnD4U0A4wYNNN7
 hCyxXA/gSt76cNgOt0jSpKRGc11VItTDBcV6QXRW6eKbLQKYVrow/L3r3wmOxltKEAKG
 hyeNhEfbscLDMIlABvqbE0FK1Kri2NVgUOQSmh2LD8zcY1TO0UbqZR+i32LzdQd26QSa
 SZ+lPSymSu7IkUkhRgXJjTYDTLK1sGSdC7LF5675+xGxdSNHefcxqyitKVPMck9L/Wc+
 hvjOzbrkzBukYuZduDVwOoddZOwf995i/A5a75Krwm+ElNn/xz0LNQEtd5SGVDObkfE9
 crbw==
X-Gm-Message-State: AFuF++mKnfnIda7lXEd0tOBEqzl1qJDFVi1ILzxXmQakmdL6XGWxy9RK
 5Y+sksdrfX8YKoXRP6+zm7KsdoI0bwotK/G2aRi8MGDFwz4nfStFZq9THh5ajRgYkDUoTjrR46G
 5yZn/SJs=
X-Gm-Gg: AYBFou1QqKCjuOXOC7cYEf35N69MwbxcDm1drAjTUW0nSL5Hf7HJyHrMoZvLZGaKebb
 oaIFDRdR4rqwFpfWGNy+VInXTNof3qe3G/FiHTa9kqwCMolSgx/I67O6Dpr3rD4g3iwIJNV3LfL
 /0JjnoWHoI/gAgDdxVGupNBSiVVSJf/a0e8HM4V1H7mTiyTiPZRDDuEGZkMqvIa1UmJuFjZrarJ
 S5Ai+dhqjyfgFXSFW4T5bNcbJSPwkBPBhmxjUca4S6Jm+aOrC9CGBY3GelGYjcbaA0kljhMnv5E
 /sGMJTXawAwveiMJzGdKOmnAhGgVeh2NXN0fxmUH35a7Ao8Rg8th26rb7IzNUYKuhzhX/e2hL84
 mZ0NaKy6bBTerAGS5zS6rx+/sLuvEm8upemLio/gIQDBDLHSW4Z7UrK9w3lOpcntE1MWbEaZNTO
 E3MNQCqT7z7gzHg6I56hhC+UQdcQuuPcFaMZGkkYHBnk+FHBNVZOma73GBmA==
X-Received: by 2002:a05:6820:1845:b0:6c9:80d8:a1ec with SMTP id
 006d021491bc7-6ca9c24e998mr6293039eaf.41.1789836542589; 
 Sat, 19 Sep 2026 09:49:02 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:01 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/41] bsd-user: Implement both getsockopt and setsockopt
Date: Sat, 19 Sep 2026 10:47:46 -0600
Message-ID: <20260919164810.70151-19-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
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

Implement get/setsockopt with the generated file describing the socket
options. This uses a table driven conversion. At the moment, we only
implement the simple types. For 64 on 64 with the same endian, we also
try to just copy in/out since the representation should be the same.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-socket.h | 340 +++++++++++++++++++++++++++++++++++
 1 file changed, 340 insertions(+)
 create mode 100644 bsd-user/freebsd/os-socket.h

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


