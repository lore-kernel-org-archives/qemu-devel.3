Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38FAC982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAL-0005Yx-Cq; Fri, 18 Sep 2026 00:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAI-0005Xr-Ay
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:34 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAG-0004N1-1w
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:34 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-801a8bf8112so93212a34.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705531; x=1790310331;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/lNUllA4wnNkYj3WCNFgTQT0OeFLJZ9KOvngG6yRhjk=;
 b=y3lZVeudKn7zs/WdQ6Tx50fcHdwTU6otdtZppffe0WRtchfa4ddE9Q5B493YpYyvk6
 Wjg7joQgF/6//nKfqjdoR6BnC0DfyyLKfr6eoHnGavOQ9e6PtpgrlrTTsw9A+s40URNx
 4S/lVjnpEPp4yyHsiqP/3xcWTPF0S17ik5xEwd8LbhNEKyUSlf9tMnEIK+Q9j96EQKbV
 FIg+/V2RvduvUkl52E8fF1ibIY2ok4dsVwcqJ+pd0keilo7o0nxtLJckQRmptbmYqg/2
 nqYyJ97nL7FJeS4TVR4BW593bXR4dxuANkknd0O7ErQN3vbSdW68uwrYWxG9Pm2AXIir
 joOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705531; x=1790310331;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/lNUllA4wnNkYj3WCNFgTQT0OeFLJZ9KOvngG6yRhjk=;
 b=X1Mq7edOC+vVGuLWMDfL/6oOaIkMa822B0GifsyGB2CefwimyrtBGF3KziQ1ejchfX
 4e5/SV5YZbnEAUdR/M4HNUEiftMhI/SnzX/l0MssYJY2wrCWoLWLzv1OvA8O7/dH+JW2
 K9rReYIANHYoLWo7VRIg32MpvDWY2l8n47iPQXpKncENXU6p7HgJEtnFFF4TElrwMVDX
 2jftWxjlyuK4XeaR2D3YLYalYRwTinULbBcDoRveq5Uw1LRADNHSygeWvJqAGH4w79qa
 Jye5FEZmL+o/Ump7Ni9NKJOTDCcpO6BY6p1gUbtOSvNnv4pFD/CbuVrqlPJvJy5ic0xV
 FoOQ==
X-Gm-Message-State: AFuF++kiMH9tRa7gkExboa5cg9VFcdu3ZB3JPTYwfA7eJN3le4qLthZ8
 inPs9M03fOJgLUlF4HPs6xE9c4NVPuXKQ/+PaA22yzHCzccw7pHtesmoGUcYEwl2amjNsLX3x+t
 1Cb6Ucs0=
X-Gm-Gg: AYBFou3/DnU9Qu/4Isf56grbGyD7F6skC69uBF6efOMpKS6EwYUNeWIWUsvtDy3Lqbx
 FncQdyaAZuFrIIjtEB982+CmkC73GupIURAUxSEtRgETrOGwUPXVRvyeJsMMqCtk1kzFbeeiiTJ
 bEyK58Xyiyq9Jq15qqMeV+D1u44qS4gLUCqzxHZ0YQWwPw96V/w9UFjt1qiCO7qP/3ARq/2gZpP
 kDck0lWsodReIq4ZZ7EwbDP34GWgAsrqODrIp56XrkKFeqzzbkpvjYtUh2GLKwp2T+a4KERYtzV
 6G7ggeh+eXSBEvept0SMik34jhzyVPR9CYj+U6MFoS/l0bCV/CatO/VyMtvdLSyNEJBNDmmNqVK
 7qqMos5HJigPFSJf/tqcwDikQ4U8QqjNLYP4HQdecy53H+dvZsNw/sG/5Gp300i7rzew+HUaZFS
 A0fT8nKfKojoCNcx7p6J0Y0b4JnJ19YbhH076zCLpX7uHPrNQM6LNEvnGDGblWQ1HzRZDZ
X-Received: by 2002:a05:6830:3150:b0:802:68c:1b51 with SMTP id
 46e09a7af769-80de159c164mr1474142a34.11.1789705530630; 
 Thu, 17 Sep 2026 21:25:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/41] bsd-user: Add os-socket.[ch] sendmsg, recvmsg and cmsg
Date: Thu, 17 Sep 2026 22:24:01 -0600
Message-ID: <20260918042422.38713-21-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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


