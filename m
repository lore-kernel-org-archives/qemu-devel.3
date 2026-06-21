Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48F5CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hC-0002zF-2c; Sun, 21 Jun 2026 00:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h9-0002yw-9S
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:07 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9h6-0005DM-Sz
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:06 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a0e55e82d0so1037012eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015724; x=1782620524;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PDA57y7T/u82EOrhccnp/KOrt4ISbcqtkgZL3o0RYiM=;
 b=MEP8ilpSglREeag4/imMCrUcXxsCc9Lu70i2Gk6KKF9DPOrw7eLVP3g7r/Zixnwbsr
 qLCQcFgKyDxknZE7eVVrDBhS58QUNY7ubsutFQBVMspefKiCsGR7Hm8Bv/k3VVDCCAs4
 J1LSpTeiZfQf+wFRHGM1C41wI1w/kPj1gHE4dfPSgPaY7k3uf5PV/sV7v+Zc4XyI00Dn
 W8qT4b7IEvgOXqp1NrJjj5AK+IdguXyRgMrHt5RjUHGoFSH8SinWik4qF1uWPbh58DBv
 fX0rV3JECgSaUdT5A6FQ33a+Enn5mBChGDXJxPbfkcGJzNi+DPnzd5k8tMH3RtT9l/mZ
 VzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015724; x=1782620524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PDA57y7T/u82EOrhccnp/KOrt4ISbcqtkgZL3o0RYiM=;
 b=R9JmWadXi95821eOh0LHGbc/pNt1X30VcqqDiiQlAQU1SbnaobrE9nw1ICV2hW/3S9
 4XcGV2aqrBtNwgHavfJhIBoiPpNvMO0GH1dmq+G5Wg/ySt0ajjCJlWBaPBxaP7qhDGS3
 w7J5dZAmC0Dhaaf1magABEOG0QLjG9G6sIbbLczU5/UEw7Pc/vUT2+57E9CHwrT5t89A
 omjKngO5kncnRY5QQ5rwNzWo6ClYLKklpoBO1KUCnfFGt3NKlUwCudbO2QvEU7HBlV6D
 74f11bAWVT8JAv00Zw3GZ3j36URhLzjsYtvw/qoayzlU4OMhxwzKHtI7N2XTgXUrlqpL
 SWWw==
X-Gm-Message-State: AOJu0YwxhV72GaI+5iBUKJ+mnLz9PEWWFYq6/EnL1w3L/VCGoQq1BJLo
 iqs+3hkHVOCGR4vmYOP2qex4GkyQmqYwdIRZ6DyLgd89WUx4mcBLaWqsoTG02yD/I0g=
X-Gm-Gg: AfdE7clufVJ7GaOgwmoUEixp7CtnL3vmqmBRgp/XbNw51voihIFpE1BfhhInbkPNJOI
 HCGhC6A3dk7hxhfAaLhbGfFimsrBuTTNJc+WG1ESawWHk2OW5QITM/tgr3OTffYzkwbbiWdnSoZ
 C5PBCp1d46iqbkz2d/vlGToUkqYEoUhorp5Rxv35ELRVvhcXKXkfEdGgi12C0jDV7qkHsbzs4eo
 3Z0qoLocwMh4XM0lw8dslUEjrluPNEYAuOzqUpH1KYbOf2we8uvGxldf+L1ZDlY6CLwu+KkMOPK
 tAUC3kgt+vC3vHWCRuxiKmAPcxq12diFqUxOBObnbofPUSIy2sw180I6JpWMxJBbfjVjuUSyYrV
 De3iqnrqz5RkRiW5n714cgPrAITiquoCI1CMJZll91FcxwRCShqxnOx2f+KAZBjTbenboiuXTjb
 w=
X-Received: by 2002:a4a:e909:0:b0:69d:7a88:9cde with SMTP id
 006d021491bc7-6a0d8cd334amr7753533eaf.26.1782015723649; 
 Sat, 20 Jun 2026 21:22:03 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:04 -0600
Subject: [PATCH v3 17/40] bsd-user: Add os-socket.c with cmsg conversion
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-17-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11621; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=rvWzWDb5MGyZlxapoym65Xxltnm6yr7kYGOaJpB4ubs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z+xqSJars/upLdB1zC1C4fCz5uiaE/naX8a
 lTbuDOM0P+JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfgAKCRBsHNEofbAR
 AHgCEACCG7saicQ2ZLtqFBfqMS2wdj5kiEQ8L9klRdNnkaTz4azvBTfVTlyGKeAy0ppG0DXtd5g
 /DIDHBI88uGDpqKAiadczQIRhCktxa3D+odd2/GAQPLpW+la6H3i5A4w8VUHevDhArjeZU5wodE
 125trfIL//9/g7vnpS96gY+CtWbKuRtpr3LkvzvOBWsaJlcKTYAnpAnEld8AWjS5AJVDKqjzsyZ
 mSZ9WlnlgMebjuVd3YsWAGMQPhtmOesQHtQztCGSe1r2qp3tJGJ7UYsWG1GhKhUtLfZqKGY1L3W
 E+IwrWPec3kNbl8WB8529Ph8QaAobY9iqAR3B4ajfQpywHg8XDKaNSqdqp7/UhHWu9cXTgLechF
 pCa2z3+WyEldIyby0tknW0P4nzga/x40kJKd+4zKZjF+Cp1hZrppjWB972Vo9zymsY1Pxb2YjYI
 hrxMmJMD22DdsiXJkTUWRZC4ShCZ6jWCV+FNoswxxnRY/fj0QmnbSQx1ZTImYQVC1NTgNWYb549
 zT6HTwrbLUXOnGz1mQhfv2I1BvCHam1meujJZYkyjyYJx4JeUePalQ9BGsbITYT7MLbm0Mlw7jj
 1uRb8D6MZymUmwMi1wkhaeEk9EQVegUlKlTkUSleNjkINLbZV/YyIGK+/oa8MyjaS9kybCpgmX5
 IKdZWJUScH4nlDw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc32.google.com
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
 bsd-user/freebsd/meson.build |   3 +-
 bsd-user/freebsd/os-socket.c | 239 +++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-socket.h |  13 ++-
 3 files changed, 250 insertions(+), 5 deletions(-)

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
index 0b41e87b68..a85263e9b5 100644
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

-- 
2.52.0


