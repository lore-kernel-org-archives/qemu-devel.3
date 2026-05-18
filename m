Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E70BCD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VU-0000T0-H7; Mon, 18 May 2026 17:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VR-0000S6-Pw
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:09 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VP-0000Sx-JK
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:09 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de431da8fbso2619104a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139686; x=1779744486;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FbApW7rZI6sL6Z/Hr+ekwEC9JyWrh50/L7jk7LMyAm4=;
 b=KHC5iFxe+7LVXGZZzKJPFPMaOg1L98Ovmoz7qDCesoGpy/8sV3+0brn2OlzgF/Yk2z
 k3vaKLTv7fEv7ZPvB5TljuHsJWmi9a9osj0z8tHKcSODyzPciFREzAIh3kBpy9xNIsC0
 H/qhMol6z/ABQtqjEfMeJItMaOZrPZbTnVCh/MYU/ZNQ1I7+ltsWXPWmt91HYbZv70SC
 BXZL5QDZWUMQ7yNor1xDdTskdzowfnL0eVRfMuY+GWNWUIcV4h2FWqdJbiO7MyFBqO+x
 DSzxgAykl9qMf+VWQhmX8knmtjVbF3PFezS0FHEK5Pl9BRlAfvNNLeSX4Czwj0phhqhQ
 x3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139686; x=1779744486;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FbApW7rZI6sL6Z/Hr+ekwEC9JyWrh50/L7jk7LMyAm4=;
 b=IhGomYYsO08tJEDuyEtKhp16vjUFfDgLg07qJEEvybATGLUgS+er7Rm/xZ34CwxlFb
 mQg4LSzxw6jmh2z1gWqZaFT7jQBK1W7F2riUAsCdI68Uu6vmqR3VW05Co2RjTvxYD+A8
 i99AsLjcecL0UP4ZetsT2skPyFoaF2U5F+ebYeF7gktMlBdXhKj2aaoHyDZdIPLciwTp
 79HtFuYjKMecsB+r552rJn4rj+MZfV0elHNTzxnf6yJFj55K2+qpcgLp1k92i8Iqu9Nn
 zaVv+B8VYSpNkYc9UaMCTH9KtL9NyRN/u6KAThuV6LAd0hexde7ZWZ97h4knyhj9L1V4
 w7Cg==
X-Gm-Message-State: AOJu0Yx7j74rZk5NiIQT4g/TJeTimfeRY78MnhTh7E0phNlDFSpAUlwY
 exHWoNfrsH/TP9JB+dJbav6CW98owkf0JdY3bO5XDgWLMGRYmfzcMwA/AxxFYl/FMjc=
X-Gm-Gg: Acq92OEik8/tuKhouU2E92OYwZZOpIqsPhimWvNbgiAwvDJ6lRaQUgMMuL/tqq/CX+W
 cGXK9nYZgWTBSDpTavn0qiIRzGHbD2PJx16zfPzvUzOQi9vJ4cKJaoOPmt+Py016JJPYw7YCUaU
 vT++K8dcxyjE6ErIoDJ6lCDEhnUZx0g61rzgu9A7j7ITeuLHLCy6yO2X/XJZUKTlowXbB+ZCzaP
 KV4tj3R31OtXtF6dNjbnS9Iuu5Pcflw79RP90EFtqTJ4MkvevGyE3g8l98zrnh28eb0AvGcoii5
 goF0RXUf4pPcYf2pXmtQOZUDNdzysddwzPwvjBa26EDDlqxFuN0aK72VUicBXcvlT7gNzBhHJkp
 xJ5eIvWX8Yo/c+EC2ZljtHanBK8frrp+kZZu8+M+HEnVjoky3FotNtIDQK/PU7tFJ2653TLwjVZ
 yMCSWiZhXKLg==
X-Received: by 2002:a05:6830:6315:b0:7dc:e2fc:53f5 with SMTP id
 46e09a7af769-7e4f2a39a1emr11195664a34.9.1779139686612; 
 Mon, 18 May 2026 14:28:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:33 -0600
Subject: [PATCH v2 15/37] bsd-user: Add os-socket.c with cmsg conversion
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-15-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10178; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=JqmPhzahuDeg5rc6BZHHnP/NICMAIXOd7HLZVHZaNGM=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RHKoB+2vxLSuj6WkKxWdKCmfSOdgcfjUylg
 WVkOPY8CrqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 ALUWD/0a5aNp/ZlDIKAUYmLBGuTxFcedglsERX0ts5gffuhPa+eUc8g8ZZMQXY2nm7TNZNwQ2hZ
 X9lHSLbVDDj01eeowx0YonBC1Ga8O28s2L7AzKp451iP+SX0Q9JzytUMIQ8FMBliEHUgKcC3jPW
 Dnxer+HRigaxOvkg8VYKEh0za3Gw97VWJ8VnUwUNyEi/qHZbV948biq7jme2dcdI6BFzx3c7ODS
 WvFDRWyFgo5086Ujdf8FE+h9yTLIaovOFuQRicKPaDP5HdsBWmMwAY2wB7i80UvT6vYpTEjh+Ux
 v8e/MBk8DipNv7cSCuRr7h9/QVG3Jl8KL+ddN1oavREgmsPlApXPhSq6hwpfYPl/SM9gW0rkB4X
 p9Pm0lbdgiAC/6Tkkh4/8tawksKwJUtiziB5AmFLxjSiZUbkYhD092GSehwxMF+6bhNQe8acVoO
 4tCvzYhsfFCIBKbeUCVnZjx5p6GivTp3KxbaYL+LMIZDlGgXvoTUbE51M88j33SoAxZn9bJ/jKn
 MGIehl6mL9/MQU6fZNXT8eTFtlR6nGrR99Ckbm6D/UFABNuEIKOwIGuRG2qLPauD0m+T6/zAXBm
 2YFa5/dBpBNJhsxhm8lT8d3D1hNiyFG6p+ktdi8m4WSHkRrVZdJJJFlzItSF5fi72f8JU/pOADX
 sTZ64lWeN8p0f2Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Add target-to-host and host-to-target control message conversion
functions (t2h_freebsd_cmsg and h2t_freebsd_cmsg) for sendmsg/recvmsg
support, and add os-socket.c to the FreeBSD build.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/meson.build |   8 +-
 bsd-user/freebsd/os-socket.c | 234 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 38f2debf7e..0fc779749d 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -4,9 +4,13 @@ bsd_syscall_nr = custom_target('bsd-syscall-h',
     command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
 
 bsd_user_ss.add(files(
-  'os-stat.c',
+  'os-extattr.c',
   'os-proc.c',
+  'os-socket.c',
+  'os-stat.c',
   'os-sys.c',
-  'os-syscall.c'),
+  'os-syscall.c',
+  'os-thread.c',
+  'os-time.c'),
   bsd_syscall_nr
 )
diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.c
new file mode 100644
index 0000000000..8eb728240d
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.c
@@ -0,0 +1,234 @@
+/*
+ * FreeBSD socket related system call helpers
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
+        struct target_msghdr *target_msgh)
+{
+    struct cmsghdr *cmsg = CMSG_FIRSTHDR(msgh);
+    socklen_t msg_controllen;
+    abi_ulong target_cmsg_addr;
+    struct target_cmsghdr *target_cmsg, *target_cmsg_start;
+    socklen_t space = 0;
+
+    msg_controllen = tswap32(target_msgh->msg_controllen);
+    if (msg_controllen < sizeof(struct target_cmsghdr)) {
+        goto the_end;
+    }
+    target_cmsg_addr = tswapal(target_msgh->msg_control);
+    target_cmsg = lock_user(VERIFY_READ, target_cmsg_addr, msg_controllen, 1);
+    target_cmsg_start = target_cmsg;
+    if (!target_cmsg) {
+        return -TARGET_EFAULT;
+    }
+
+    while (cmsg && target_cmsg) {
+        void *data = CMSG_DATA(cmsg);
+        void *target_data = TARGET_CMSG_DATA(target_cmsg);
+        int len = (unsigned char *)(target_cmsg) +
+            tswap32(target_cmsg->cmsg_len) - (unsigned char *)target_data;
+
+        space += CMSG_SPACE(len);
+        if (space > msgh->msg_controllen) {
+            space -= CMSG_SPACE(len);
+            /*
+             * This is a QEMU bug, since we allocated the payload area ourselves
+             * (unlike overflow in host-to-target conversion, which is just the
+             * guest giving us a buffer that's too small). It can't happen for
+             * the payload types we currently support; if it becomes an issue in
+             * future we would need to improve our allocation strategy to
+             * something more intelligent than "twice the size of the target
+             * buffer we're reading from".
+             */
+            gemu_log("Host cmsg overflow\n");
+            break;
+        }
+
+        if (tswap32(target_cmsg->cmsg_level) == TARGET_SOL_SOCKET) {
+            cmsg->cmsg_level = SOL_SOCKET;
+        } else {
+            cmsg->cmsg_level = tswap32(target_cmsg->cmsg_level);
+        }
+        cmsg->cmsg_type = tswap32(target_cmsg->cmsg_type);
+        cmsg->cmsg_len = CMSG_LEN(len);
+
+        if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
+            int *fd = (int *)data;
+            int *target_fd = (int *)target_data;
+            int i, numfds = len / sizeof(int);
+
+            for (i = 0; i < numfds; i++) {
+                __get_user(fd[i], target_fd + i);
+            }
+        } else if ((cmsg->cmsg_level == SOL_SOCKET) &&
+            (cmsg->cmsg_type == SCM_TIMESTAMP) &&
+            (len == sizeof(struct target_freebsd_timeval)))  {
+            /* copy struct timeval to host */
+            struct timeval *tv = (struct timeval *)data;
+            struct target_freebsd_timeval *target_tv =
+                (struct target_freebsd_timeval *)target_data;
+            __get_user(tv->tv_sec, &target_tv->tv_sec);
+            __get_user(tv->tv_usec, &target_tv->tv_usec);
+        } else {
+            gemu_log("Unsupported target ancillary data: %d/%d\n",
+                     cmsg->cmsg_level, cmsg->cmsg_type);
+            memcpy(data, target_data, len);
+        }
+
+        cmsg = CMSG_NXTHDR(msgh, cmsg);
+        target_cmsg = TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
+                                         target_cmsg_start);
+    }
+    unlock_user(target_cmsg_start, target_cmsg_addr, 0);
+the_end:
+    msgh->msg_controllen = space;
+    return 0;
+}
+
+abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
+        struct msghdr *msgh)
+{
+    struct cmsghdr *cmsg = CMSG_FIRSTHDR(msgh);
+    socklen_t msg_controllen;
+    abi_ulong target_cmsg_addr;
+    struct target_cmsghdr *target_cmsg, *target_cmsg_start;
+    socklen_t space = 0;
+
+    msg_controllen = tswap32(target_msgh->msg_controllen);
+    if (msg_controllen < sizeof(struct target_cmsghdr)) {
+        goto the_end;
+    }
+    target_cmsg_addr = tswapal(target_msgh->msg_control);
+    target_cmsg = lock_user(VERIFY_WRITE, target_cmsg_addr, msg_controllen, 0);
+    target_cmsg_start = target_cmsg;
+    if (!target_cmsg) {
+        return -TARGET_EFAULT;
+    }
+
+    while (cmsg && target_cmsg) {
+        void *data = CMSG_DATA(cmsg);
+        void *target_data = TARGET_CMSG_DATA(target_cmsg);
+        int len = (unsigned char *)(cmsg) + cmsg->cmsg_len -
+            (unsigned char *)data;
+
+        int tgt_len, tgt_space;
+
+        /*
+         * We never copy a half-header but may copy half-data; this is Linux's
+         * behaviour in put_cmsg(). Note that truncation here is a guest problem
+         * (which we report to the guest via the CTRUNC bit), unlike truncation
+         * in target_to_host_cmsg, which is a QEMU bug.
+         */
+        if (msg_controllen < sizeof(struct target_cmsghdr)) {
+            target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
+            break;
+        }
+
+        if (cmsg->cmsg_level == SOL_SOCKET) {
+            target_cmsg->cmsg_level = tswap32(TARGET_SOL_SOCKET);
+        } else {
+            target_cmsg->cmsg_level = tswap32(cmsg->cmsg_level);
+        }
+        target_cmsg->cmsg_type = tswap32(cmsg->cmsg_type);
+
+        /*
+         * Payload types which need a different size of payload on the target
+         * must adjust tgt_len here.
+         */
+        tgt_len = len;
+        switch (cmsg->cmsg_level) {
+        case SOL_SOCKET:
+            switch (cmsg->cmsg_type) {
+            case SCM_TIMESTAMP:
+                tgt_len = sizeof(struct target_freebsd_timeval);
+                break;
+            default:
+                break;
+            }
+            break;
+        default:
+            break;
+        }
+
+        if (msg_controllen < TARGET_CMSG_LEN(tgt_len)) {
+            target_msgh->msg_flags |= tswap32(MSG_CTRUNC);
+            tgt_len = msg_controllen - sizeof(struct target_cmsghdr);
+        }
+
+        /*
+         * We must now copy-and-convert len bytes of payload into tgt_len bytes
+         * of destination space. Bear in mind that in both source and
+         * destination we may be dealing with a truncated value!
+         */
+        switch (cmsg->cmsg_level) {
+        case SOL_SOCKET:
+            switch (cmsg->cmsg_type) {
+            case SCM_RIGHTS:
+            {
+                int *fd = (int *)data;
+                int *target_fd = (int *)target_data;
+                int i, numfds = tgt_len / sizeof(int);
+
+                for (i = 0; i < numfds; i++) {
+                    __put_user(fd[i], target_fd + i);
+                }
+                break;
+            }
+            case SCM_TIMESTAMP:
+            {
+                struct timeval *tv = (struct timeval *)data;
+                struct target_freebsd_timeval *target_tv =
+                    (struct target_freebsd_timeval *)target_data;
+
+                if (len != sizeof(struct timeval) ||
+                    tgt_len != sizeof(struct target_freebsd_timeval)) {
+                    goto unimplemented;
+                }
+
+                /* copy struct timeval to target */
+                __put_user(tv->tv_sec, &target_tv->tv_sec);
+                __put_user(tv->tv_usec, &target_tv->tv_usec);
+                break;
+            }
+            default:
+                goto unimplemented;
+            }
+            break;
+        default:
+        unimplemented:
+            gemu_log("Unsupported host ancillary data: %d/%d\n",
+                     cmsg->cmsg_level, cmsg->cmsg_type);
+            memcpy(target_data, data, MIN(len, tgt_len));
+            if (tgt_len > len) {
+                memset(target_data + len, 0, tgt_len - len);
+            }
+        }
+
+        target_cmsg->cmsg_len = tswap32(TARGET_CMSG_LEN(tgt_len));
+        tgt_space = TARGET_CMSG_SPACE(tgt_len);
+        if (msg_controllen < tgt_space) {
+            tgt_space = msg_controllen;
+        }
+        msg_controllen -= tgt_space;
+        space += tgt_space;
+        cmsg = CMSG_NXTHDR(msgh, cmsg);
+        target_cmsg = TARGET_CMSG_NXTHDR(target_msgh, target_cmsg,
+                                         target_cmsg_start);
+    }
+    unlock_user(target_cmsg_start, target_cmsg_addr, space);
+the_end:
+    target_msgh->msg_controllen = tswap32(space);
+    return 0;
+}

-- 
2.52.0


