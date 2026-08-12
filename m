Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389C4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQC-0008Os-Qb; Wed, 12 Aug 2026 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQA-0008DX-8l; Wed, 12 Aug 2026 10:59:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQ8-0001Rx-0N; Wed, 12 Aug 2026 10:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=adCV0qxPnqF3ua6HniH7NBbIOmjJ3njwCW/SCZc48lQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bzh74M6xHeGSbhNCgO8xs6qxfH2hWXCL9+dL2ouZR1INNiRv2ReZMcp4AvMgYoU6v
 jKdOfFRQyKha7Ww+oVzCPj65ybHy655FTC2/lQHr3h8dZ+uBZ5mNf/dlA57kHhgjAM
 Cu+FO9zHMkfHWNRe4hB+v0b5We/ljc2nrtw5gIZ1uxNlhb9hNNeXDwPrupCEvsfhHm
 k+PJAWFyqdA1iC/N/73PAcXzzLhiHtS5Ghgw2iC118an+DW6Rgu3lmQ+QyOYINZQh9
 YzZteBpjt8SsscpibJRQFKU/D5aEAq5dlOLZ64hZG9OZaWqd7/ut/wdWXw5zBp4Lh6
 pzmtmhFpHcTLA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D7E11CA65A;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 88988409D9C;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E53F02FA0F; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 086/120] linux-user: Fix msqid_ds struct wrt 32-bit
 big endian architectures
Date: Wed, 12 Aug 2026 17:49:09 +0300
Message-ID: <20260812144955.649205-86-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 9e3df3019d21c54df435406fca31b3e145b29702)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 67106f1f59e..bf7c9af691e 100644
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
2.47.3


