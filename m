Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320C6CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxE-0001Lr-Vj; Fri, 15 May 2026 17:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxD-0001La-WA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:20 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxB-0002wb-W8
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:19 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so343842a34.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880017; x=1779484817;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eWEMp+EulfjlanvuHGlMABpvVLKlelZghJdgaBSbgVo=;
 b=AkxXuzsrbDdMcrzNNYS9pVhdrdqyZA6E/NyRs5/IbzHvdqklj3iNZ/hhrzDN9TJinP
 bGBuAuWfBo5T4vUbaiEtn5yDSy6kuzElbN1PZT0gOJK972zqIJVPr5KIo41WMhGiaISl
 7+VomhSQKv6Pig5oPgAa3cMhwmwGLNQCX50EaYKEuytLfZVo9oiNR9Fae+2/Cd8xF6QG
 F93ghjTuxKRx2WAKFqpn3/T/lWD8d6od7WZZalGhfNjAFJk5kHhFMhhgDl6sqPCX9okl
 IPJ2gV4PncOjE4ui1Sm9FcHkT1z4vM7J4DLZoWruMNzjomllgsMvZeUB8WrZCDcRJDBz
 eGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880017; x=1779484817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eWEMp+EulfjlanvuHGlMABpvVLKlelZghJdgaBSbgVo=;
 b=GuwhS7QUC/s8VTzyrPtPyOjiDtjlVNIk+HY/iKRTgJdMJDC7buES9r3ATIPfTqPYZT
 mypgGOgGbiGvcqGkf0zWfsGBSh9JotcsDCbAagtVrJpnqsCspHB+2MeFBeN3hXA9snno
 lQtPdPfL58V1wv0NWA27Ho/9DN5u3Z0tm/Nk3mEzrxlSHWPTdePCKpg80sHE9xzQcCO2
 G6jPIHIdl8/ZFifjvtLnQLUKJMlIHmGbh4AiwuTUHPST+8Ovzia+H03V5WZO+lFI+g3H
 08srdxa6sbPnyK9Y/j9J/Q9HL/dslHjjkWhGat0U1ShjNhXRgUvJMwcaJss6ZhxFG0d9
 qbVA==
X-Gm-Message-State: AOJu0YwUtFb/xGaQTpc7bG96JmAcmVR4D2Ihylcec1so491sLLeuYru2
 H1t8Qowr1GhCo1Q6ovT73gzWECIL+psml0Q3d9AY7U4UW32L8CVrVZblPKH1FxWDooo=
X-Gm-Gg: Acq92OE1zsES+HHwLT2oyDQHh245fzx4v5Rwx9pKmudLG75FQC7aTzi3M/bcf5UO7xz
 NyTsNt7gMhNNMZk6GHGBPRYaGG3wMiCO+R1Itql/vcVfRfV2QvTsIYVMZFrdgl5IYRi1cKukgCt
 Y+v3cPx0hb635E8I4LJ6O/PhwryFS/3V5I+5IPcTLT95qtFgfqHQcHzdsGAJH6LdF4eJM54cDUW
 6QZ90hqlRXB1DR/mNc3FXJixP1TYphCmXqvJIhLwPiKtvhZ0BoN5ztnbwZniQNX+MjAwaeVM38S
 dgIyy3fHqKztvB8zZwzgOApJpCWqmKYWoCqT3CuF2vNoDSrbO0Huc/EXywfPbgom2rK2b06ROlh
 1Wx17qCTIIDzTqKMum4ja8DeL0Qcp1RyFAYFYuSF7NJxdK61M4v53wJc6dSHXmZ1Vds5Pahmdtt
 Zsj4fbawASow8bjWH2fAB7
X-Received: by 2002:a05:6830:4412:b0:7dc:c501:afbd with SMTP id
 46e09a7af769-7e3f14becc7mr5760884a34.10.1778880016810; 
 Fri, 15 May 2026 14:20:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:14 -0600
Subject: [PATCH 15/66] bsd-user: Add os-socket.c with cmsg conversion functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-15-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10175; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=GRbi9hs4fneyJlRiW99omuykY/76dCQ7oE8fK/Gd6Tc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43iTfdRWtK6PX7VHCOdaK7t3wzvpI2Xc/fZV
 vA1ES6FOPCJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4gAKCRBsHNEofbAR
 ADFxEAChXRYFGyPh2EGR/0nrfrrJqUDk8WSbE1s/rnjYXTh8uA7mC6NXWZI8p+mzPHtSvyvppHu
 HDHVuzQwhx+/lwmb6aa5WSQ5Yt/OA58Azhd4uhYgp11WIUF0WKfmgtWkCFce/yxFESanGQg91K5
 pxB5KifiwkKkjLpuVhvhhQE2fbbTGNKTCkLDPo0vKZkwXAnrfBJFz52iDkBxwMh/4jVyJWjhC+U
 pOm+DPD3G98lo6CsbMkzr5NNe3qDLPj1AAhw8oBgJlpMGrWgD/GYqIQb7fMNXLVPqh9aqMVshX4
 +BjTDnVDBE+L0KYXKSsyQsSxJZqDuoUfANwa349ku9EhMckngZ0IcV0FGuR9qHY8bYWINCoYmrW
 SVnCdGR/Z78aFxP+xne7NZq+Dvxz5eaJ3cgMrS/uCEb60rfgyGJvjLqag3RMdWG/P4c2RHhpDWH
 LP7JuBmY3ZnggbPvVjS4S2XFw/wXcPs+cqVL2AcOdRZrx07R0pxX0YhGUKyqvIQQiabqvJUynRS
 VpEqh6tRYS1svO2QbWXPra30fILrVxydrtVyDFvQytBkBAoYk2WvvP/rXnpREpWPQTNxnY7hw9M
 F/T1xa5tn0rhaaHThPrhSHOCkLe3+PmMtv/rn/3SNL1Q2fky3hv1nnmoPK3xkKSwjyH49AVKCrf
 WDL8RmIfLruJA1w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x335.google.com
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
 bsd-user/freebsd/os-socket.c | 235 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 241 insertions(+), 2 deletions(-)

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
index 0000000000..543c9c10a6
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.c
@@ -0,0 +1,235 @@
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
+        } else if ((cmsg->cmsg_level == TARGET_SOL_SOCKET) &&
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
+    unlock_user(target_cmsg, target_cmsg_addr, 0);
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
+            case SO_TIMESTAMP:
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
+    unlock_user(target_cmsg, target_cmsg_addr, space);
+the_end:
+    target_msgh->msg_controllen = tswap32(space);
+    return 0;
+}
+

-- 
2.52.0


