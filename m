Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFC9C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonUV-0006by-Sn; Tue, 28 Jul 2026 15:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wonUQ-0006Nl-6j
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:29:23 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wonUO-0002Dw-CN
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:29:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4D89432E2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 19:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB151F00A3D
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785266958;
 bh=CU5s4qqUWifX1CTp9WyajGqX++iED0BKn8CbAdmdA8M=;
 h=From:To:Subject:Date;
 b=ZB4aUqF1f5C73xQ30IYsWFNsyiNxYfWNw4SiH7G7aemRwELk/2LVtl9Ygojyh+cV7
 eOzGbajEHb3Zd8S65q9nBFpimS2T6edC02gn/RgHUOLrtOTc+j1gKxXDgFQDxclgD6
 oFcI7Hq4O/sIwtK2Lr+8V6mqnfnAhyFVPmm7+Yu4ZL/QypaUZRFxUGz2Zjd3SpBOwA
 a5Y1s9/g0PRSKXsJeIwCAdIMtadgSMWtxdexFavOg3yudRFotCg2NbA8LCq0VrjmIK
 LZf6Ze1p35romzh1t31ypGjbBirOPiSzp4eYya66WSf4xKT56TqLwgTYSNS+Br9d+p
 qspTF0Ty+0NbA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
Date: Tue, 28 Jul 2026 21:29:13 +0200
Message-ID: <20260728192913.61279-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
are defined as 64-bit time_t values, since the userspace may access
the whole 64-bit value. By this change we fix the word ordering for
32-bit big endian architectures as well.

This fixes the msgctl01 LTP testcase on hppa32.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 740142825d..c93b770ced 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int semid,
 }
 #endif
 
+#define target_time64_t         abi_ullong
+#define target_swap_time64(x)   tswap64(x)
+
 struct target_msqid_ds
 {
     struct target_ipc_perm msg_perm;
-    abi_ulong msg_stime;
-#if TARGET_ABI_BITS == 32
-    abi_ulong __unused1;
-#endif
-    abi_ulong msg_rtime;
-#if TARGET_ABI_BITS == 32
-    abi_ulong __unused2;
-#endif
-    abi_ulong msg_ctime;
-#if TARGET_ABI_BITS == 32
-    abi_ulong __unused3;
-#endif
+    target_time64_t msg_stime;
+    target_time64_t msg_rtime;
+    target_time64_t msg_ctime;
     abi_ulong __msg_cbytes;
     abi_ulong msg_qnum;
     abi_ulong msg_qbytes;
@@ -4249,9 +4243,9 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
         return -TARGET_EFAULT;
     if (target_to_host_ipc_perm(&(host_md->msg_perm),target_addr))
         return -TARGET_EFAULT;
-    host_md->msg_stime = tswapal(target_md->msg_stime);
-    host_md->msg_rtime = tswapal(target_md->msg_rtime);
-    host_md->msg_ctime = tswapal(target_md->msg_ctime);
+    host_md->msg_stime = target_swap_time64(target_md->msg_stime);
+    host_md->msg_rtime = target_swap_time64(target_md->msg_rtime);
+    host_md->msg_ctime = target_swap_time64(target_md->msg_ctime);
     host_md->__msg_cbytes = tswapal(target_md->__msg_cbytes);
     host_md->msg_qnum = tswapal(target_md->msg_qnum);
     host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
@@ -4270,9 +4264,9 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
         return -TARGET_EFAULT;
     if (host_to_target_ipc_perm(target_addr,&(host_md->msg_perm)))
         return -TARGET_EFAULT;
-    target_md->msg_stime = tswapal(host_md->msg_stime);
-    target_md->msg_rtime = tswapal(host_md->msg_rtime);
-    target_md->msg_ctime = tswapal(host_md->msg_ctime);
+    target_md->msg_stime = target_swap_time64(host_md->msg_stime);
+    target_md->msg_rtime = target_swap_time64(host_md->msg_rtime);
+    target_md->msg_ctime = target_swap_time64(host_md->msg_ctime);
     target_md->__msg_cbytes = tswapal(host_md->__msg_cbytes);
     target_md->msg_qnum = tswapal(host_md->msg_qnum);
     target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
-- 
2.54.0


