Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D90C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFW-00035r-Cc; Sat, 19 Sep 2026 12:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFS-00034X-IV
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:10 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFP-0008JU-Fw
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:09 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae721872so820106eaf.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836546; x=1790441346;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/lNUllA4wnNkYj3WCNFgTQT0OeFLJZ9KOvngG6yRhjk=;
 b=MYNI7kQa0qpIdgOe+1sS78ooPkCS7by2rzPufSCj/wSMUJGQe6prd0q697XWhXXXr6
 h/qH49V2HP4VpZgqoaewYqS+MTtEayZU4xnx8JieRgqMMi4NN7m/DE/vCNDnPML1/NkG
 vkwzdu+NS/d2srckdXByQasRzky8GoktFx4CB4fB3OP0lwVx8AzLGqozyYqWoXqdfmGs
 Nx7mQx64jH0dcjPbLtVkIKm63v0MEeE6MJaCVQ9ELvsC9nsHmKAU/yzempYevhUmd+cZ
 JFHeyBaPBtyaJXPwQjNuW4XWU8HuXj++ztkS1MEnpkVDXKeR6AbNxMrmtwws5bbBNVTd
 DZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836546; x=1790441346;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/lNUllA4wnNkYj3WCNFgTQT0OeFLJZ9KOvngG6yRhjk=;
 b=FDo0zEhR0dWK6/botxXKSxDjaQ108wLr/B54FY9TGwIozB+sZKCHrynACXP8L3vJHY
 YMEYc30KPsROIT4Z6Ml7vGtxWewvGfIEuO+L07vtWw5aUDb/Bry1IVbWy7Fh9NKMz8SA
 +xNwRTz594yuxibcwsny6I7XVJ3Iz0oP4OR8xeoQa48Os6m5agKJl01ZRBDq6dp/oZMO
 t6017GrWLJyYllzjS8ObZNYE6EOxow3I5hTC1weKR1mD6Gm6vzF0oBlqtNuzWhejkq3z
 NIEPGjwust+1KF+xt4nxD6W8ouV95q90yl8YraEpoTZCrJH13Xn46KYmCI1vXLsasKM9
 kDrw==
X-Gm-Message-State: AFuF++mpfTtvQr2mgvBYNnhl2QRJLm6DpGkTI65aJga4h+9RM77jjlQJ
 1U+qCGOsd1xk7Zl2aLvN6iyVHjkzzjU6msB9U142ih4YFfO0Skvh1DBy6ZyLPCr+NknCTo7Ufpf
 SpUi4hpU=
X-Gm-Gg: AYBFou3qhUtHImbFR3iHeHcr7TPrdZc20x3BATdLo9vIeRvEg4qoz+Eve/IVb5QAdGm
 Szm4MeMSQcWNDpLH8U8YKQ2GW48KsuTagY0JqIAMx0B3UOxv9pTlqYlQp/K/WjLve9tnhNChjqn
 SNPWDA4hezRNSmKz1F9jBHsN0mxgmDMGxkZw6DUUuBWC1HNR3OD3FlMOzKLGLQI33UGa/8eZi5K
 IUIoj6csSATAUBdBN2Reo8X9vaPYbiA7FpaaGpwZV4PHJiQn57hX5wb+na7my2Wvj1UDYcB57DK
 NAnXMnIh1p6jhmsNiO688oty5qKhWQnbNbArsPSM2D+9wk9MeFB4oNjtcTlGpUtfbx7vNOGySAy
 7rKjgdjMAKfYKkgmQ+XibZbB8MzwOSnvgWzcV6axOXh9PQwroyh/B57OxY9pAwUOZtiRIF+BexH
 XeIx3f6ZGUZT0MVhlCk+Qsz5ovou0OOMStnRSyOlhER/M/FxHPiY4kz9s2+6w=
X-Received: by 2002:a05:6820:4b92:b0:6b7:83d6:2925 with SMTP id
 006d021491bc7-6ca9c654345mr5602551eaf.40.1789836546276; 
 Sat, 19 Sep 2026 09:49:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:05 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/41] bsd-user: Add os-socket.[ch] sendmsg, recvmsg and cmsg
Date: Sat, 19 Sep 2026 10:47:48 -0600
Message-ID: <20260919164810.70151-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
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

Add the first part of FreeBSD socket support: do_sendrecvmsg_locked and
do_sendrecvmsg functions. Also add target_msghdr, target_cmsghdr, and
CMSG macros structures to syscall_defs.h.  Add target-to-host and
host-to-target control message conversion functions (t2h_freebsd_cmsg
and h2t_freebsd_cmsg) for sendmsg/recvmsg support, and add os-socket.c
to the FreeBSD build.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build  |   3 +-
 bsd-user/freebsd/os-socket.c  | 239 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-socket.h  |  13 +-
 bsd-user/freebsd/os-syscall.c |   3 +
 4 files changed, 253 insertions(+), 5 deletions(-)
 create mode 100644 bsd-user/freebsd/os-socket.c

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 38f2debf7e..83593a1e20 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -4,8 +4,9 @@ bsd_syscall_nr = custom_target('bsd-syscall-h',
     command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
 
 bsd_user_ss.add(files(
-  'os-stat.c',
   'os-proc.c',
+  'os-socket.c',
+  'os-stat.c',
   'os-sys.c',
   'os-syscall.c'),
   bsd_syscall_nr
diff --git a/bsd-user/freebsd/os-socket.c b/bsd-user/freebsd/os-socket.c
new file mode 100644
index 0000000000..9c723d7608
--- /dev/null
+++ b/bsd-user/freebsd/os-socket.c
@@ -0,0 +1,239 @@
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
+        struct target_msghdr *target_msgh);
+abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
+        struct msghdr *msgh);
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
diff --git a/bsd-user/freebsd/os-socket.h b/bsd-user/freebsd/os-socket.h
index b0f2498ff7..12e9ec3da8 100644
--- a/bsd-user/freebsd/os-socket.h
+++ b/bsd-user/freebsd/os-socket.h
@@ -19,9 +19,14 @@
 ssize_t safe_recvmsg(int s, struct msghdr *msg, int flags);
 ssize_t safe_sendmsg(int s, const struct msghdr *msg, int flags);
 
+abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
+        struct target_msghdr *target_msgh);
+abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
+        struct msghdr *msgh);
+
 /* do_sendrecvmsg_locked() Must return target values and target errnos. */
-static abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
-                                      int flags, int send)
+static inline abi_long do_sendrecvmsg_locked(int fd, struct target_msghdr *msgp,
+                                             int flags, int send)
 {
     abi_long ret, len;
     struct msghdr msg;
@@ -122,8 +127,8 @@ out2:
 }
 
 
-static abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
-                               int flags, int send)
+static inline abi_long do_sendrecvmsg(int fd, abi_ulong target_msg,
+                                      int flags, int send)
 {
     abi_long ret;
     struct target_msghdr *msgp;
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7bc9fedfb7..46fee46336 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -47,6 +47,7 @@
 #include "os-proc.h"
 #include "os-signal.h"
 #include "os-file.h"
+#include "os-socket.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -85,6 +86,8 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, buf, size_t, len, int, flags,
     struct sockaddr *restrict, from, socklen_t *restrict, fromlen);
 safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
     flags, const struct sockaddr *, to, socklen_t, tolen);
+safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
+safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
-- 
2.55.0


