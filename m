Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638A2CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VP-0000Pe-2P; Mon, 18 May 2026 17:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VO-0000PO-1y
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:06 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VM-0000SH-2m
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:05 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e582b3bcaaso2128751a34.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139683; x=1779744483;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=73NLJsALVR7wgtLvwEyY7coBbyzbT922pF86YJa6DFs=;
 b=0ZmpF2obx2iRP89QKl16gxOUdxFHHD14GGP/mJL7Z7dLsrz2u0KANF6TIClXxfvSFK
 w+1VA0xkKohDREw1a6YY5Brw7StpjCSc0dIXo/c1K+9ASPWSq8dUSjKEzJJf5lBpefeo
 0HOWy2HdE/HxDGN6+DbkTlmq++0WV6Na9H8fx+9vifnvVLkrmPb8VShb8x9KznQTZtUn
 eDe9YsugT6rpOcyvsGl1/8pCWigDKBJLBFOwAGlJkM5JXyb4Y82GY3SC0QTnWddip4c7
 OEfimAvWxEEMCGEVNdft0C2Cmv7Ga9Hc4MHOLGUYbfbuphDbNE1JfRmzn0l9bi8H4bGj
 lifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139683; x=1779744483;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=73NLJsALVR7wgtLvwEyY7coBbyzbT922pF86YJa6DFs=;
 b=gvOU+F/k2EDVSYasV5PVOTs08F56IVlglNur8h9b726W1DKJUrWjVGROKatruLARts
 d6oDJeFHtbQdmdrYHo5sKMCFLyX42NKLyvT9CpR1uIDTDchBBSFdB7Y1AIHi7GsWuj/8
 SAlYhgScsfBOufuHIxNpvZi3n2B0bGdDTnuMkZfsxVZP54LpXUzG3E2658NosanOpdQQ
 dvv3RUynKm0y8L/5LOw7GwgauOTJY85LYEM5dZ9/EdSV8DxRex91DfKIAUHxQ6qNFdRt
 cnxYOURf1UCI95nfYeHZtSTI8c+TzoL64zRIYDp9cTJxTX8okuvVp1GEB+1nYn7T+je1
 j8Ww==
X-Gm-Message-State: AOJu0Yw8+Uy9+wn/rOvoMl2X57vjFgkmUoq+TSMARjtgpppjSBnSMF5+
 xVDFDvS/+dyyyzcvAdjuN6xOFMmid9+7SluBT/hmdbumt0QsyC0pbErGudhgLA6unc8=
X-Gm-Gg: Acq92OE28P8MtrzLQorIzz6/k/iEG8MJQxHDWzR3W3aJrTaILL91+VPlltCBJVcwRXq
 XJr0vT59qbwT1L//cSYHqv49IVol+vIXl9MOwFaoxE05l4NPKtYcnucTVuqF9XvaE+xIkDyqtBz
 km4y6vv5WdghZBJ+/ua7ivTAqtRPoGRTDGfpN+0/L9qqbqWEz+AZdRa7NPr029DxvIvGPJyDRwd
 fptCq67Kw2I3ugQfRm6DKUWb7nckYPveWYnaODph4qQaXzzS6Ofmq3o3tCqg+3iXiWiMCuCVuZB
 imIUK2uBp1IUyjiYRi5QDzLt+zLUYUbIyMQ4LgQuNs4gg7TtFy07U/mr6pWcxd+Mg2wwvc6UT+x
 E/u90ILvsfg7T5qFn5xybixzA5zWy46xPd9+DL/dax1P91LgkCp151OsQ83o+tD4TkO5dakTUFq
 zoZctK6oQKjw==
X-Received: by 2002:a05:6830:3591:b0:7d7:e59c:80e6 with SMTP id
 46e09a7af769-7e4f2b24530mr11346780a34.12.1779139683003; 
 Mon, 18 May 2026 14:28:03 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:29 -0600
Subject: [PATCH v2 11/37] bsd-user: Add os-socket.h with sendrecvmsg and
 message structures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-11-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5633; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=dlzoPbvTwfzSlndR4y6PsCvuZS9DmNaeKGJhZVcl21Q=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGwt8Ax2frI9dH1y/Jlp2+1AgJlmmDzaZUe
 B8vVVV7KAqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 AAM6EADaDQR/D3YMhvq68JuLoIRN8yAmIEJ2IaHzTEzuSLKLyVaS1mGsBtcME+HpPtq5+Resscc
 NDKkQXkCsJ5xmCO4wDwHKqthRv6iYOEpLQax7KtiR9eLqoF5bzwW4OYPK5zvBIFrZw9Il7F5iWD
 r1kVgZvbggMpw7MpivcANBFJKGqZHbF8jJX7aKYISBQX2d1kmpuP7mVc0wkhT9ZuNJwg28b3yGx
 r12R6cKTqdbfsFVP2HMiOyWdQfE2TRuNgWTwHNBo4AKqfHL2VvJhX0utB/0l7exIIoPwllSfexc
 IP3QCaOgxf00j4Ru82H3LOArBNFW33tQoNmJ4M4jscrxjjJInJi4TAy2TXHdO/QGr4a38vOTJpd
 dvUlC3+fwI+hyCnY2BF3cnB45E8V5IlTVGWhZem1+dDEurbxnTlBXi4DDZwZjynMJrT+kYsA6Uz
 Xp1+wH0xaJxbqSEHwVThU05G+wFspPX9pXMI9JVhiboHuyvsGCKcz2DyTcaHideky3YSUUIeebX
 qKq1I7i6+WKcoTLkUY+7wBJ9jvJ2T+8/UdAStuMEe6O/PbTpE12K+uL2EpM+twFwc+F6VZfN30Q
 9hp3bp7gCLXo7xJl4unCccGPjCXmvoknJNUbOT/Gz3pfG3Du+Qs6++n1yB9cpZKNMgkJOFj5735
 9US7tXma2ZBJJag==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32d;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32d.google.com
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


