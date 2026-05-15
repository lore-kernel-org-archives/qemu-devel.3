Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE88BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxA-0001EJ-3F; Fri, 15 May 2026 17:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx8-0001CR-TD
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:14 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx6-0002t0-R2
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:14 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-47c7b282d73so277876b6e.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880011; x=1779484811;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=73NLJsALVR7wgtLvwEyY7coBbyzbT922pF86YJa6DFs=;
 b=YfTs3wbm6xtl+oht0SPx0n5JJOBB1tt5+UeE3wDWidDiKLtAF9aL1S43dJrhSfBTrW
 fVWhSFC6R/1ui/KWHQc0niNe6/FcH3p2UTsVYs78T6Ek/oPJR3VPVkhwEbiZ9MMQbS+k
 6g1MBxb3cV7Ip6grY52yyPpqQFgaJsG5rlFi/4nEJDPPkycTBcztnmTWaW9OmHYOJkL7
 nKsigcmgmIn9aWQkPOfunXOH4kUPGTmgn7O69d3gDqyOK6qBCsMfCFUJ01arpnkR7ENt
 hu8De8uFoPunL73yEYjCF8Mfj3CTI7HpgzWsrnpYizeZe+acWERwASxx1+NybXrok0WT
 cdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880011; x=1779484811;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=73NLJsALVR7wgtLvwEyY7coBbyzbT922pF86YJa6DFs=;
 b=IYdWTJZTFh+AyDDOCITxlNIBscHyO+31LlIIIPtPSypgjtzwrA3EyHuQ8iD5n108c/
 NCwQiFwLaJWY38lSUj+qwJdsuIz+tyI6US9vuttacdpgdLdBVaXlDRZyZcYhtgzFJ2rq
 /QciYPDu6WL1Pa0QpvcwI5PfDLO6JjRMSa0d+DtbVVssHPnyRurlDPcvNQB5f5GAKxRl
 XESuK7Fr+XNzXruc+YlYaRE5YCGwfhzA5NYB58VVzX6sh9kfPdZCDS/kbLU1p+uAGuc8
 48jjjA766ooKumiUW9POG5I/qamYaKZoPa8truLsat9ZW0nbM7IeZQzdO89UEgXMvWi+
 nk/A==
X-Gm-Message-State: AOJu0YzyC45D/K0ZY00lMHtQ5SUZGlYSQI+zJMbejdHM43gnrkoG4vE0
 pLK7/RfEJFbKJXakf9qbZEOlu6GoxI/RXSXMbuVzkIZ92UE1NOQIKd/lgomoVQSH8Uo=
X-Gm-Gg: Acq92OGpcwaOGMp3oYgTb8ybeQLb8/0skXVPCjHwR8Ft01ZHC6yaNBO+7gVlMb2ya++
 pKJwFMDmD2JGGX8aSyVpiyx9hWwRCXnz4+iB4899iXH2eLF0ovi5qzRNDKFUz5wndD0/xwWBkqj
 OXaNuCXeomdWeyoOvwLNyKpbhYe9dDqJpZ8KVbJCEi+p8hN1N6JYxhqM2DFJotiVrZFddMNotBS
 nB6HcKm6Xmg36cIC7Iap+kKXR5U/d3AvCXwpskK0hCJVTLuMIZThE9nkSY6s/d38eo2d3uhcZhE
 duKqvMVMNDGldS112soDk+9S0zVPavlPnB/ZQBNlK3RH6s8uj0KxxGuNkNljSpz2RaXVVuBLRYz
 Z9/9nZ0xG9ZNMelAktNc8mwtMwfL7ZsYtE8WHRfy8eshas6MRLvvIgkA/eQb/CwCrKVATsn4gif
 Tlh+a9d+IvO/8+Pz6ghe57
X-Received: by 2002:a05:6808:6788:b0:479:646c:f701 with SMTP id
 5614622812f47-482e5991ee2mr3838306b6e.41.1778880011478; 
 Fri, 15 May 2026 14:20:11 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:10 -0600
Subject: [PATCH 11/66] bsd-user: Add os-socket.h with sendrecvmsg and
 message structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-11-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5633; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=dlzoPbvTwfzSlndR4y6PsCvuZS9DmNaeKGJhZVcl21Q=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43i2S/mIRicYdyvQAraXNW6QfE7RxpCx8C6T
 eWLxOY1KnuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 AG40EAC/sRRhQrybzWomqxuq/TG5spNn4PpQXwzr9yuXhmtokqu7DUYW7u2MMuq7zoGbiTL7BZG
 /QOTRIpuYmQ7sCZzKpPzKWqtuxOgAlR7JLXq6Pj3QcWNjpfvANnKFGiOx461vmflWLzfa9W91hx
 o6vmZd19RSaCA3s0FmZxHpaaKK+eUmj6Snej6Q2EkBw+TXSilIomJfVyfcP6LPecjRjj5Wfllcr
 OzJ/RSA2VnLBSba8y7ixwzS6xJllA7bYzkkhhaFKwy3Y7cq96QZ7l8D/CKi4InItfeoP6bs2tUR
 4p1+qfOFmhSoKmSOzkBIjZW50Xj0FtLSMFj+fni+Zhe5DBnaLvKrUaRVhl8gMHKfwKZSBnYyEII
 t/2Hy+gtVvl/Ur1rdn0yMSMCSBEyxLUlyDZWgpPw46RH9glhzKjfgCN0PKqJjUtHREC2YUwm8Wx
 HE5fIsf1ndJqcgP9fHdx7k+0vr+V6VHbCWGEk0Q/4negR8/GM5cJWPdx0HmBYdOH0NpTtExZwVh
 qDAdClGuqkJQn7jKWk6T7WwjdDZPuLcncY21+C+cRQLKcZuRCKuiF+E3AJc7pc/I/YfNEXofmuW
 syaEe1KebBJX5Xmqcm9cwFdSOcU/HAOX4j+29O5UzLtxXzRScxOTVj9LAic//ANSLENGsQZnYFB
 AEx8OppM/VKUGKw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
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

Add the first part of FreeBSD socket support: do_sendrecvmsg_locked
and do_sendrecvmsg functions. Also add target_msghdr, target_cmsghdr,
CMSG macros, target_ip_mreq, and target_ip_mreqn structures to
syscall_defs.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-socket.h  | 142 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   1 +
 2 files changed, 143 insertions(+)

diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
new file mode 100644
index 0000000000..279157dd05
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.h
@@ -0,0 +1,142 @@
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
+
+#endif /* BSD_USER_FREEBSD_OS_SOCKET_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 737de36514..46fee46336 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -47,6 +47,7 @@
 #include "os-proc.h"
 #include "os-signal.h"
 #include "os-file.h"
+#include "os-socket.h"
 #include "os-misc.h"
 
 /* I/O */

-- 
2.52.0


