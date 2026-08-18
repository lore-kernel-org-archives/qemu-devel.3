Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C234BC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTh5-0002BV-RC; Tue, 18 Aug 2026 19:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh4-0002BF-F8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:10 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh2-0005Gg-6s
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:10 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-499f6e0bbabso354544b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097487; x=1787702287;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6E8INjzxJXr9KwFH46m1NeXnpRMIGd6BTvLbPm7Ex6s=;
 b=ycB2ljxepelOxKSwTawHZy8fMOD6/Zv2831BA17qgDEo1NFPTilQ0pwz34Hq40p3Bo
 N5hPIK4ncnlKrL3q1LXoA+JlyJPL/AHTuM9L+JyoODiYQBRlTiKfYSThlAxWTYa8lrmk
 Xwr3BYZ3E5nCHMwKafmN1OmJ98Ara4Dg1Y3rM6Sd0vDmlt4EJyyNfJQisRWcN0W++SNf
 h8vEW6RPNWych1uKjIlo3lD0cgiOl5t0vWTdxwHLq/j/PG2fNHTcSDsjqU1GRfkEyfAl
 pSTT4o86lH+7HAYSFaIVrYj7xznYxu5WEaZbzfNX+Cookq6nfFTC4zs6iOlQGsRa90YF
 dSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097487; x=1787702287;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6E8INjzxJXr9KwFH46m1NeXnpRMIGd6BTvLbPm7Ex6s=;
 b=Qbg1Fq939bjGkXX67yxoNYkaaih3+U6LmT+ym6Fku6uZNIOkbq+1xFsSLYZaqqsyqR
 w+kuxeP+8r5k3gwmGvUW/ugoHE95NiRiutPTaurEmlbfoad6wjWGXzTFWlcOqVSyRGW1
 odBpmYQ4PEhOavR+zYK/z34cwP1QjTUWV8CmtbpbpdRWUP8VR3OVbIq/jKz7rWwS9zHU
 PQYuRodGypyDvlDIKIhhUSZ7sCI+ZRrMqmHOVR+f49n6KIL0Pdj2tMfO1u4TKqeObxcL
 HhT1hzaRT4jcn5a1+BBQMJqRMk/sb1Rj130rgv6gZ5D+UMfDzgX/DzY8wC8kMqjSH8K3
 3mxA==
X-Gm-Message-State: AOJu0YxwWoMJjP7ZVX88LYp5WdhcR9QdY2PybYgED6aqRE+fLuVlBuTX
 NfzW5J3v0RrfpyTlaUyW6AhU9aFJNeagN9p67v83iS4p7ItayVr80MkTcJvI7SisDQYDyIOLdQK
 dKcJZbwg=
X-Gm-Gg: AR+sD13F8zffsrH+f3Pt1bexXx17Z27x+BNh5dtBWFO8HXoNeivh364rPtTsFXV291F
 j3PjXjpwZfOzChWwy34ehxiRxQPVYcw0clwaKH398NOKx/eI0CAeK61n9IZjeDb8l/XWH5eYZkK
 g3YkKP+vfl3NtGYshCNrVBnHu8bAHtqcWQ8uUxjhb7XcfPdjtlt/nJsrfGYkx3+ECRst+b1hY3/
 wW2IMyZ5vDgrEW6Zh4nuOs/r/YsCbgP5bcQmtUT4zs1vZ70w9IpUKZ24SBAv6Ynq9kAA6siL426
 TlLbd1HE28e0S3YQZ6ctyOAPA96Zb8R3C0XjmSt9CQd77x/7Y1okqqm8Z7zUZWOBHimeqfOgNTB
 1N/VcI/WEqKx7usnYZzFR7ciUb2LdMiMy3cLlhfiJYc7+Ppud+owiT72TL1zYk7aMlp+5UjNrTM
 VEM+1aYqKsFexdT5aFS+MAB+WurK+htmvslswqZzp6Ol1kaO0TT7I6YkDHog==
X-Received: by 2002:a05:6808:c2d6:b0:4a4:933:b20f with SMTP id
 5614622812f47-4b2bc95f49emr362866b6e.7.1787097487067; 
 Tue, 18 Aug 2026 16:58:07 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:04 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:12 -0600
Subject: [PATCH v4 19/40] bsd-user: Add os-socket.[ch] sendmsg, recvmsg and
 cmsg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-19-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12886; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=omMVtbAu8HlMop6aLpFoZ/FFEhIaHmzfJpZkuhQKW0A=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPE8NJOfY6yEzVPFFC+xHW9o1aMdvnsvqZpse
 d4AFILF+QiJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxPBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAGKRAA5PY2WuZuyWiQ8Rjg+C9EFS28WFUTA9z
 pU1Jc4DqBd+aMDZEeCVAZHTo7pJ2zvgg7xHjO7YaXNj2zyP1WbGfNbj+L0ZPkIYj29wUg5XEdmL
 y0osOXdyqZYPt0wugzyO4EVZe3cifSyEwpviCsTEQWeycGCsa7DRUQSi05m2/81x7Mq0pQBUg1d
 lEEoaAIbPEvjKiIh3Tz8x11ihf0y9M3Sg2ONWP6m+Dn7HQh8srrf4OzUez4DI9BCFti21YmJxVy
 NdUtQdghZBeEdBN6esi+8WlB6idpJaGH7xkBvGV/TIcXH4K0KFMeIsDJJVkUQUNwzN+J3MMDjLO
 Ra8Cm3eBuEm2NBhv9/4f1qn56zQzeksULWP1/bAbuHKwWEttyv6UK5vYcoEM4qZX0P3WgrKxOyr
 udGcx4Ly/8nUy0Crkpw3vA964PgrXZjKV5yX7IbgCUHcAQ9DrPnWb8eXkVbWB+dNouK/bHbG5iv
 FEHy2oUfaKhyvI4FNO+/q5wI+G8B/Z6rVAeoipmDpzFC+Nenfkxh8BwbR3Hbu7/N0dWurRkT81r
 2z/ZEYx+jcP6Adh0aSFVDgHfXs/ddw3v8i35R8jYwuvr+CcMcgvEqNqJREUeF5pXIOcTPHokSEP
 tdLcm+s5TXVCzux4Ewt9MJaCr53tjELeV4ymFNDQHA3+7r2rFzOA=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x234.google.com
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
 bsd-user/freebsd/os-socket.c  | 239 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-socket.h  |  13 ++-
 bsd-user/freebsd/os-syscall.c |   3 +
 4 files changed, 253 insertions(+), 5 deletions(-)

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


