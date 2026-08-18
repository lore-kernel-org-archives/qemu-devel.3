Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1560C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgr-000284-IB; Tue, 18 Aug 2026 19:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgp-00027k-PE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:55 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgn-0005Eu-W7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:55 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4b1bf68b387so301902b6e.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097473; x=1787702273;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CMrW+huNEl4YQloyIhdem/HVGGc9kbaQ9NQmJpLap6Y=;
 b=vJ1uv7ZioMIY9zV8ITYFoR1d72Hb7XREljHtZMtSnejZ7pKQHa/QEVAeYY7WIRN2c7
 4jw2ujfKv2cz/CFOfnjRQhC7KWd/kOOM9j+pAg91HBMxcyyyC4AMPCs91fk5cMDQFeKg
 f8q/ZQNn0HuJYCcehvfLvT7UCIe+gydoZ9/Sx4j6OphXU8HC933FRRVIOFgc2Nn4PLtI
 wzCISfa0pKDhyn3z3BynPGnjdGW5pvR0fy/s4sAIZXKT/RyXPWCMqD8M0WKNphqk/s9i
 37QqpNDWBQesyQNnzfz7y9plGRAKVgBwLSGbFsFvnuvkkkwnSdFAPhe/ins5E2l7ZkRO
 L7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097473; x=1787702273;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CMrW+huNEl4YQloyIhdem/HVGGc9kbaQ9NQmJpLap6Y=;
 b=afOYycrH7+tkFut5rpdWe5FJFk0gE1NtEGfTEp5O0zWA36LvAWeDJdPLaNk0G6wAYD
 cBvHldGm03W+SK4UWbcL+HkjADlDxjNS8+UnVY7w548GyE7swJ94RDflWX4YjlFsEiSX
 RepMTXuj4yovVAywDJa0fNMYX8qOI49/r2kwlZ56MNq0Z//YCBX+6asrVHqYmjv1xwEe
 SKzI8exScHkAueNjU2wOxYUZZ5OeCq6ZuOQlZKFhVHswjTO1hOK7WemE3TOY1+paqAGJ
 Lg+bH9ZGQ5dvf8cXV7yndmgHPjSrWqGGUc/c2/IS+nE6cy7O3WCnWfESWXKQ6GzKcsFo
 xhXA==
X-Gm-Message-State: AOJu0YwoO+QCcEEdGsMss+ClZmJF+tq/EBSlFEi0E7lhxxpMRpb0xw70
 1zp7y9CBo4MBhcVQ/M17218wvg++WeyJOndO8XFsLydARaxWBG1Ol8RqrC4Q/XpidV1wH+Ypo5K
 XNLc9Mqs=
X-Gm-Gg: AR+sD13S6DOp20G00X65iUpShagLtjReFBaMwnp2Y+9Fsi/erb1/Gh9sz3w8+0RZ4EN
 I79CLtelp2IxDXnOtJM1lJyzcZbVbSGZIUWLVGE2rhbFMEWJ+AGgj7KBM4G1tNyfnsmBCwBHD74
 v/WM7PwvqGAG2S7NaT8yxFf4manKYSLVYHKuVCL7GcR6aCrWM8cYdHhq5uxTv0Zwj0QVxUakDDB
 2rT7zlzwTy5wRvCUtyuXxo+CQw/J1KtrV/9JK8EfwYlvPT8PSS33cQ0hF6gmTk9/Gb1hN+F6Rql
 ibnF24f5+pIcaupVxvmEU1RZtvpoZozcysmIgzSssVO3NoI3NjEz4UazenEMcw59QzIhMMRJJca
 YkdZJ+pa3iImLuQIQ3urr2gSb6moZIP6D5rB7GY7KnwHzdYkhwSUD9NG3ZDAmLn4M6osIA1EuZ/
 Juv5z/+d45bRFi0lnYaRVXTTQydc+pzkbDGT1HvMX/W2kc4m8=
X-Received: by 2002:a05:6808:c1f2:b0:497:d371:21c8 with SMTP id
 5614622812f47-4b2bcb4f9f3mr372626b6e.19.1787097472965; 
 Tue, 18 Aug 2026 16:57:52 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:51 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:06 -0600
Subject: [PATCH v4 13/40] bsd-user: Add FreeBSD socket helpers and sockaddr
 conversion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-13-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6764; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=QZHMhzUVP/6EvE5l/MWtcU36jkSP+XISYtDFwS0owRA=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEzjcPRr+mELG99dqvWeRhIYI9iwnGtXjg6F
 LoIZ09lGkCJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxMxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBa+BAAmXDWpbcddcUEN2Ka2WLKXhOMsmqx+va
 aSm8ELU/QECpXnrpnrYHYklAOko3HlmETZJWkC539tfLXzsqs8AQulVk6d1fh7UAHVKC4AqJu4Z
 bMkwq1xd3YJvKihhGnoeZnkq9U5Jhqz/AtnsmQfwhDdR4SNfy45sETeDbn5xNwMNg8uLyMaEvQa
 hD2b+vtxyBRBwpRNZIMLjSgEAyJjz4FPC+VAL1eCb5vdn843fhi/h4GwMf/vPDsA+3fKxmH7D3V
 hE++DFGbySDpa/L421QY2pny6RtuDw8ftrThBBkos9NVzlJSuS3WvHOViFEgQQd5JPVzM21IbID
 in02X5SUcgAw8JoXijwCCT1AYnHl3Ji89lwUE2sIHBt+HvWM4rm8cp8nfA9O3gHLsac0VSFKnCs
 rXewc+SDKyxJY9LhN0nRSYozGaSkuqCXh4ZbklZCP4HZNeiX35a2zbRXz+ZUJU3zdW4d2OfnChq
 ktmCTehmIZg6Cds3dHKhNs3bbNh5LgS7Q00A8/EekdYAZGeoD5Ck0iZeL4bGATKUlrON4SnPn2y
 A9Bl6c44KMbDgc19tnZcyDKkEVnvzFMlMbs66EYFBW72i0J52D0DnE6b+ey1RePlkJ5Uyg94TLc
 tlhauGBtap9Uy/6dQkute6g0giUaHWfw/AAunxl88z+tIDDhZ8ms=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x232.google.com
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

Add bsd-socket.c with target_to_host_sockaddr, host_to_target_sockaddr,
and target_to_host_ip_mreq helper functions, and add it to the build.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-socket.c   | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
 bsd-user/meson.build    |  1 +
 bsd-user/qemu-bsd.h     |  8 ++++
 bsd-user/syscall_defs.h | 49 ++++++++++++++++++-------
 4 files changed, 143 insertions(+), 13 deletions(-)

diff --git a/bsd-user/bsd-socket.c b/bsd-user/bsd-socket.c
new file mode 100644
index 0000000000..cc45400e4c
--- /dev/null
+++ b/bsd-user/bsd-socket.c
@@ -0,0 +1,98 @@
+/*
+ * BSD socket system call related helpers
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <netinet/in.h>
+
+#include "qemu.h"
+#include "qemu-bsd.h"
+
+/*
+ * socket conversion
+ */
+abi_long target_to_host_sockaddr(struct sockaddr *addr, abi_ulong target_addr,
+                                 socklen_t len)
+{
+    const socklen_t unix_maxlen = sizeof(struct sockaddr_un);
+    sa_family_t sa_family;
+    struct target_sockaddr *target_saddr;
+
+    target_saddr = lock_user(VERIFY_READ, target_addr, len, 1);
+    if (target_saddr == 0) {
+        return -TARGET_EFAULT;
+    }
+
+    sa_family = target_saddr->sa_family;
+
+    /*
+     * Oops. The caller might send a incomplete sun_path; sun_path
+     * must be terminated by \0 (see the manual page), but unfortunately
+     * it is quite common to specify sockaddr_un length as
+     * "strlen(x->sun_path)" while it should be "strlen(...) + 1". We will
+     * fix that here if needed.
+     */
+    if (target_saddr->sa_family == AF_UNIX) {
+        if (len < unix_maxlen && len > 0) {
+            char *cp = (char *)target_saddr;
+
+            if (cp[len - 1] && !cp[len]) {
+                len++;
+            }
+        }
+        if (len > unix_maxlen) {
+            len = unix_maxlen;
+        }
+    }
+
+    memcpy(addr, target_saddr, len);
+    addr->sa_family = sa_family;        /* type uint8_t */
+    addr->sa_len = target_saddr->sa_len;    /* type uint8_t */
+    unlock_user(target_saddr, target_addr, 0);
+
+    return 0;
+}
+
+abi_long host_to_target_sockaddr(abi_ulong target_addr, struct sockaddr *addr,
+                                 socklen_t len)
+{
+    struct target_sockaddr *target_saddr;
+
+    target_saddr = lock_user(VERIFY_WRITE, target_addr, len, 0);
+    if (target_saddr == 0) {
+        return -TARGET_EFAULT;
+    }
+    memcpy(target_saddr, addr, len);
+    target_saddr->sa_family = addr->sa_family;  /* type uint8_t */
+    target_saddr->sa_len = addr->sa_len;        /* type uint8_t */
+    unlock_user(target_saddr, target_addr, len);
+
+    return 0;
+}
+
+abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn, abi_ulong target_addr,
+                                socklen_t len)
+{
+    struct target_ip_mreqn *target_smreqn;
+
+    target_smreqn = lock_user(VERIFY_READ, target_addr, len, 1);
+    if (target_smreqn == 0) {
+        return -TARGET_EFAULT;
+    }
+    mreqn->imr_multiaddr.s_addr = target_smreqn->imr_multiaddr.s_addr;
+    mreqn->imr_address.s_addr = target_smreqn->imr_address.s_addr;
+    if (len == sizeof(struct target_ip_mreqn)) {
+        mreqn->imr_ifindex = tswap32(target_smreqn->imr_ifindex);
+    }
+    unlock_user(target_smreqn, target_addr, 0);
+
+    return 0;
+}
+
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 2abcae5122..ab6ddf2e9f 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -11,6 +11,7 @@ bsd_user_ss.add(files(
   'bsd-mem.c',
   'bsd-misc.c',
   'bsd-proc.c',
+  'bsd-socket.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index 756425d18e..e32a09b37c 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -32,6 +32,14 @@ int host_to_target_waitstatus(int status);
 void h2g_rusage(const struct rusage *rusage,
         struct target_freebsd_rusage *target_rusage);
 
+/* bsd-socket.c */
+abi_long target_to_host_sockaddr(struct sockaddr *addr, abi_ulong target_addr,
+        socklen_t len);
+abi_long host_to_target_sockaddr(abi_ulong target_addr, struct sockaddr *addr,
+        socklen_t len);
+abi_long target_to_host_ip_mreq(struct ip_mreqn *mreqn, abi_ulong target_addr,
+        socklen_t len);
+
 /* bsd-mem.c */
 void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
         struct target_ipc_perm *target_ip);
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 75122ad521..1a85ceb464 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -203,6 +203,42 @@ struct target_freebsd__wrusage {
     struct target_freebsd_rusage wru_children;
 };
 
+/*
+ * sys/socket.h
+ */
+struct target_msghdr {
+    abi_long    msg_name;       /* Socket name */
+    int32_t     msg_namelen;    /* Length of name */
+    abi_long    msg_iov;        /* Data blocks */
+    int32_t     msg_iovlen;     /* Number of blocks */
+    abi_long    msg_control;    /* Per protocol magic (eg BSD fd passing) */
+    int32_t     msg_controllen; /* Length of cmsg list */
+    int32_t     msg_flags;      /* flags on received message */
+};
+
+struct target_sockaddr {
+    uint8_t sa_len;
+    uint8_t sa_family;
+    uint8_t sa_data[14];
+} QEMU_PACKED;
+
+struct target_in_addr {
+    uint32_t s_addr; /* big endian */
+};
+/*
+ * netinet/in.h
+ */
+struct target_ip_mreq {
+    struct target_in_addr   imr_multiaddr;
+    struct target_in_addr   imr_interface;
+};
+
+struct target_ip_mreqn {
+    struct target_in_addr   imr_multiaddr;
+    struct target_in_addr   imr_address;
+    int32_t                 imr_ifindex;
+};
+
 /*
  * sys/stat.h
  */
@@ -531,19 +567,6 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
-/*
- * sys/socket.h
- */
-struct target_sockaddr {
-    uint8_t sa_len;
-    uint8_t sa_family;
-    uint8_t sa_data[14];
-} QEMU_PACKED;
-
-struct target_in_addr {
-    uint32_t s_addr; /* big endian */
-};
-
 #define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 

-- 
2.55.0


