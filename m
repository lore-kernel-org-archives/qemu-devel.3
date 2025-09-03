Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39913CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 06:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uthNB-0005Qv-DW; Wed, 03 Sep 2025 02:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <l.stelmach@samsung.com>)
 id 1uthMo-0005FB-71
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:53:15 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <l.stelmach@samsung.com>)
 id 1uthMi-0007U0-Fn
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:53:12 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20250903065257euoutp02976a21ff37daf42fcefcb405bee6275b~hsza7_VAi0182901829euoutp02u
 for <qemu-devel@nongnu.org>; Wed,  3 Sep 2025 06:52:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20250903065257euoutp02976a21ff37daf42fcefcb405bee6275b~hsza7_VAi0182901829euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1756882377;
 bh=G8pm8csBH7j/dyiPtTLbtE+MlN04OoBetGz/VcfOiQs=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Zdml5kxBkksFxe+pNMAu/WaEO7OtGWibRIFbMrst3bTdbagmiXla2Hj48/jbrsixl
 U1q2ORP2UfcXI4HZ5Mxdcv+P9g9sjfY6NUQpBN7IgwOJqFVXE0N9nmXoYNfycJAKx6
 oiZBtwVdPVvQjeuZlHAwCQeooTFZzdidynGC2pb8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20250903065257eucas1p152c3fd1c45081012b39f0fb6da48ba8a~hszavyl6B2654726547eucas1p1I;
 Wed,  3 Sep 2025 06:52:57 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20250903065257eusmtip298582f251f8fa86d3734a6c6a7f8d672~hszasGY710564205642eusmtip2n;
 Wed,  3 Sep 2025 06:52:57 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, =?UTF-8?q?=C5=81ukasz=20Stelmach?=
 <l.stelmach@samsung.com>
Subject: [PATCH] linux-user: add y2038 safe socket timeout options
Date: Wed,  3 Sep 2025 08:52:39 +0200
Message-Id: <20250903065239.2629776-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903065257eucas1p152c3fd1c45081012b39f0fb6da48ba8a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250903065257eucas1p152c3fd1c45081012b39f0fb6da48ba8a
X-EPHeader: CA
X-CMS-RootMailID: 20250903065257eucas1p152c3fd1c45081012b39f0fb6da48ba8a
References: <CGME20250903065257eucas1p152c3fd1c45081012b39f0fb6da48ba8a@eucas1p1.samsung.com>
Received-SPF: pass client-ip=210.118.77.12;
 envelope-from=l.stelmach@samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Linux kernel has redefined some socket options values and
introduces y2038 safe code paths on 32-bit architectures.
See include/uapi/asm-generic/socket.h in the kernel sources.

The argument for SO_RCVTIMEO_NEW (66) SO_SNDTIMEO_NEW (67) is
struct __kernel_sock_timeval which always comprises two 64-bit
fields regardless of the architecture.

Unlike the kernel QEMU needs to support both old and new values
so SO_SNDTIME and SO_RCVTIMEO have been renamed to *_OLD,
but neither old nor new values have been marked as "default".

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 linux-user/alpha/sockbits.h   |  8 ++++--
 linux-user/generic/sockbits.h |  8 ++++--
 linux-user/hppa/sockbits.h    |  8 ++++--
 linux-user/mips/sockbits.h    |  8 ++++--
 linux-user/ppc/sockbits.h     |  8 +++---
 linux-user/sparc/sockbits.h   |  8 ++++--
 linux-user/strace.c           |  6 +++--
 linux-user/syscall.c          | 47 +++++++++++++++++++++--------------
 8 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/linux-user/alpha/sockbits.h b/linux-user/alpha/sockbits.h
index d54dc98c09..114e808693 100644
--- a/linux-user/alpha/sockbits.h
+++ b/linux-user/alpha/sockbits.h
@@ -28,8 +28,8 @@
 #define TARGET_SO_RCVBUFFORCE   0x100b
 #define TARGET_SO_RCVLOWAT  0x1010
 #define TARGET_SO_SNDLOWAT  0x1011
-#define TARGET_SO_RCVTIMEO  0x1012
-#define TARGET_SO_SNDTIMEO  0x1013
+#define TARGET_SO_RCVTIMEO_OLD  0x1012
+#define TARGET_SO_SNDTIMEO_OLD  0x1013
 #define TARGET_SO_ACCEPTCONN    0x1014
 #define TARGET_SO_PROTOCOL  0x1028
 #define TARGET_SO_DOMAIN    0x1029
@@ -75,6 +75,10 @@
 /* Instruct lower device to use last 4-bytes of skb data as FCS */
 #define TARGET_SO_NOFCS     43
 
+/* New socket timeout options that are y2038 safe. */
+#define TARGET_SO_RCVTIMEO_NEW 66
+#define TARGET_SO_SNDTIMEO_NEW 67
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/generic/sockbits.h b/linux-user/generic/sockbits.h
index b3b4a8e44c..7b78b9dcaa 100644
--- a/linux-user/generic/sockbits.h
+++ b/linux-user/generic/sockbits.h
@@ -34,8 +34,8 @@
 #define TARGET_SO_PEERCRED     17
 #define TARGET_SO_RCVLOWAT     18
 #define TARGET_SO_SNDLOWAT     19
-#define TARGET_SO_RCVTIMEO     20
-#define TARGET_SO_SNDTIMEO     21
+#define TARGET_SO_RCVTIMEO_OLD 20
+#define TARGET_SO_SNDTIMEO_OLD 21
 
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define TARGET_SO_SECURITY_AUTHENTICATION              22
@@ -58,4 +58,8 @@
 
 #define TARGET_SO_PROTOCOL             38
 #define TARGET_SO_DOMAIN               39
+
+/* New socket timeout options that are y2038 safe. */
+#define TARGET_SO_RCVTIMEO_NEW 66
+#define TARGET_SO_SNDTIMEO_NEW 67
 #endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 23f69a3293..4206cf5a35 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -17,8 +17,8 @@
 #define TARGET_SO_RCVBUFFORCE  0x100b
 #define TARGET_SO_SNDLOWAT     0x1003
 #define TARGET_SO_RCVLOWAT     0x1004
-#define TARGET_SO_SNDTIMEO     0x1005
-#define TARGET_SO_RCVTIMEO     0x1006
+#define TARGET_SO_SNDTIMEO_OLD 0x1005
+#define TARGET_SO_RCVTIMEO_OLD 0x1006
 #define TARGET_SO_ERROR        0x1007
 #define TARGET_SO_TYPE         0x1008
 #define TARGET_SO_PROTOCOL     0x1028
@@ -67,6 +67,10 @@
 
 #define TARGET_SO_CNX_ADVICE           0x402E
 
+/* New socket timeout options that are y2038 safe. */
+#define SO_RCVTIMEO_NEW        0x4040
+#define SO_SNDTIMEO_NEW        0x4041
+
 /* TARGET_O_NONBLOCK clashes with the bits used for socket types.  Therefore we
  * have to define SOCK_NONBLOCK to a different value here.
  */
diff --git a/linux-user/mips/sockbits.h b/linux-user/mips/sockbits.h
index 562cad88e2..1b7c5266f8 100644
--- a/linux-user/mips/sockbits.h
+++ b/linux-user/mips/sockbits.h
@@ -37,8 +37,8 @@
 #define TARGET_SO_RCVBUF       0x1002  /* Receive buffer. */
 #define TARGET_SO_SNDLOWAT     0x1003  /* send low-water mark */
 #define TARGET_SO_RCVLOWAT     0x1004  /* receive low-water mark */
-#define TARGET_SO_SNDTIMEO     0x1005  /* send timeout */
-#define TARGET_SO_RCVTIMEO     0x1006  /* receive timeout */
+#define TARGET_SO_SNDTIMEO_OLD 0x1005  /* send timeout */
+#define TARGET_SO_RCVTIMEO_OLD 0x1006  /* receive timeout */
 #define TARGET_SO_ACCEPTCONN   0x1009
 #define TARGET_SO_PROTOCOL     0x1028  /* protocol type */
 #define TARGET_SO_DOMAIN       0x1029  /* domain/socket family */
@@ -71,6 +71,10 @@
 #define TARGET_SO_RCVBUFFORCE          33
 #define TARGET_SO_PASSSEC              34
 
+/* New socket timeout options that are y2038 safe. */
+#define SO_RCVTIMEO_NEW                66
+#define SO_SNDTIMEO_NEW                67
+
 /** sock_type - Socket types
  *
  * Please notice that for binary compat reasons MIPS has to
diff --git a/linux-user/ppc/sockbits.h b/linux-user/ppc/sockbits.h
index ee453347a3..25455a948e 100644
--- a/linux-user/ppc/sockbits.h
+++ b/linux-user/ppc/sockbits.h
@@ -14,10 +14,10 @@
 #define TARGET_SO_RCVLOWAT     16
 #undef  TARGET_SO_SNDLOWAT
 #define TARGET_SO_SNDLOWAT     17
-#undef  TARGET_SO_RCVTIMEO
-#define TARGET_SO_RCVTIMEO     18
-#undef  TARGET_SO_SNDTIMEO
-#define TARGET_SO_SNDTIMEO     19
+#undef  TARGET_SO_RCVTIMEO_OLD
+#define TARGET_SO_RCVTIMEO_OLD 18
+#undef  TARGET_SO_SNDTIMEO_OLD
+#define TARGET_SO_SNDTIMEO_OLD 19
 #undef  TARGET_SO_PASSCRED
 #define TARGET_SO_PASSCRED     20
 #undef  TARGET_SO_PEERCRED
diff --git a/linux-user/sparc/sockbits.h b/linux-user/sparc/sockbits.h
index 0a822e3e1f..1d3f1186e1 100644
--- a/linux-user/sparc/sockbits.h
+++ b/linux-user/sparc/sockbits.h
@@ -24,8 +24,8 @@
 #define TARGET_SO_BSDCOMPAT    0x0400
 #define TARGET_SO_RCVLOWAT     0x0800
 #define TARGET_SO_SNDLOWAT     0x1000
-#define TARGET_SO_RCVTIMEO     0x2000
-#define TARGET_SO_SNDTIMEO     0x4000
+#define TARGET_SO_RCVTIMEO_OLD 0x2000
+#define TARGET_SO_SNDTIMEO_OLD 0x4000
 #define TARGET_SO_ACCEPTCONN   0x8000
 
 #define TARGET_SO_SNDBUF       0x1001
@@ -104,6 +104,10 @@
 
 #define TARGET_SO_ZEROCOPY             0x003e
 
+/* New socket timeout options that are y2038 safe. */
+#define SO_RCVTIMEO_NEW                0x0044
+#define SO_SNDTIMEO_NEW                0x0045
+
 /* Security levels - as per NRL IPv6 - don't actually do anything */
 #define TARGET_SO_SECURITY_AUTHENTICATION              0x5001
 #define TARGET_SO_SECURITY_ENCRYPTION_TRANSPORT        0x5002
diff --git a/linux-user/strace.c b/linux-user/strace.c
index 1233ebceb0..9639d47d70 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2970,11 +2970,13 @@ print_optint:
         case TARGET_SO_RCVLOWAT:
             qemu_log("SO_RCVLOWAT,");
             goto print_optint;
-        case TARGET_SO_RCVTIMEO:
+        case TARGET_SO_RCVTIMEO_OLD:
+        case TARGET_SO_RCVTIMEO_NEW:
             qemu_log("SO_RCVTIMEO,");
             print_timeval(optval, 0);
             break;
-        case TARGET_SO_SNDTIMEO:
+        case TARGET_SO_SNDTIMEO_OLD:
+        case TARGET_SO_SNDTIMEO_NEW:
             qemu_log("SO_SNDTIMEO,");
             print_timeval(optval, 0);
             break;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 91360a072c..fb37b516db 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1132,7 +1132,8 @@ static inline abi_long copy_to_user_timeval(abi_ulong target_tv_addr,
     return 0;
 }
 
-#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME)
+#if defined(TARGET_NR_clock_adjtime64) && defined(CONFIG_CLOCK_ADJTIME) || \
+    defined(TARGET_NR_getsockopt) || defined(TARGET_NR_setsockopt)
 static inline abi_long copy_from_user_timeval64(struct timeval *tv,
                                                 abi_ulong target_tv_addr)
 {
@@ -2358,21 +2359,28 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
 #endif
     case TARGET_SOL_SOCKET:
         switch (optname) {
-        case TARGET_SO_RCVTIMEO:
-        case TARGET_SO_SNDTIMEO:
+        case TARGET_SO_RCVTIMEO_OLD:
+        case TARGET_SO_SNDTIMEO_OLD:
+        case TARGET_SO_RCVTIMEO_NEW:
+        case TARGET_SO_SNDTIMEO_NEW:
         {
                 struct timeval tv;
+                bool old_timeval = (optname == TARGET_SO_RCVTIMEO_OLD ||
+                                    optname == TARGET_SO_SNDTIMEO_OLD);
 
-                if (optlen != sizeof(struct target_timeval)) {
+                if (optlen != (old_timeval ? sizeof(struct target_timeval) : \
+                               sizeof(struct target__kernel_sock_timeval))) {
                     return -TARGET_EINVAL;
                 }
 
-                if (copy_from_user_timeval(&tv, optval_addr)) {
+                if ((old_timeval && copy_from_user_timeval(&tv, optval_addr)) ||
+                    (!old_timeval && copy_from_user_timeval64(&tv, optval_addr))) {
                     return -TARGET_EFAULT;
                 }
 
                 ret = get_errno(setsockopt(sockfd, SOL_SOCKET,
-                                optname == TARGET_SO_RCVTIMEO ?
+                                optname == TARGET_SO_RCVTIMEO_OLD || \
+                                optname == TARGET_SO_RCVTIMEO_NEW ?
                                     SO_RCVTIMEO : SO_SNDTIMEO,
                                 &tv, sizeof(tv)));
                 return ret;
@@ -2590,13 +2598,16 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         /* These don't just return a single integer */
         case TARGET_SO_PEERNAME:
             goto unimplemented;
-        case TARGET_SO_RCVTIMEO: {
+        case TARGET_SO_RCVTIMEO_OLD:
+        case TARGET_SO_RCVTIMEO_NEW:
+        case TARGET_SO_SNDTIMEO_OLD:
+        case TARGET_SO_SNDTIMEO_NEW:
+        {
             struct timeval tv;
             socklen_t tvlen;
+            bool old_timeval = (optname == TARGET_SO_RCVTIMEO_OLD ||
+                                optname == TARGET_SO_SNDTIMEO_OLD);
 
-            optname = SO_RCVTIMEO;
-
-get_timeout:
             if (get_user_u32(len, optlen)) {
                 return -TARGET_EFAULT;
             }
@@ -2605,15 +2616,18 @@ get_timeout:
             }
 
             tvlen = sizeof(tv);
-            ret = get_errno(getsockopt(sockfd, level, optname,
+            ret = get_errno(getsockopt(sockfd, level,
+                                       optname == TARGET_SO_RCVTIMEO_OLD || \
+                                       optname == TARGET_SO_RCVTIMEO_NEW ?
+                                       SO_RCVTIMEO : SO_SNDTIMEO,
                                        &tv, &tvlen));
             if (ret < 0) {
                 return ret;
             }
-            if (len > sizeof(struct target_timeval)) {
-                len = sizeof(struct target_timeval);
-            }
-            if (copy_to_user_timeval(optval_addr, &tv)) {
+            len = MIN(len, (old_timeval ? sizeof(struct target_timeval) : \
+                            sizeof(struct target__kernel_sock_timeval)));
+            if ((old_timeval && copy_to_user_timeval(optval_addr, &tv)) ||
+                (!old_timeval && copy_to_user_timeval64(optval_addr, &tv))) {
                 return -TARGET_EFAULT;
             }
             if (put_user_u32(len, optlen)) {
@@ -2621,9 +2635,6 @@ get_timeout:
             }
             break;
         }
-        case TARGET_SO_SNDTIMEO:
-            optname = SO_SNDTIMEO;
-            goto get_timeout;
         case TARGET_SO_PEERCRED: {
             struct ucred cr;
             socklen_t crlen;
-- 
2.39.5


