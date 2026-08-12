Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA2C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAQc-0001Zx-8u; Wed, 12 Aug 2026 10:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQU-0001V8-WB; Wed, 12 Aug 2026 10:59:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQT-0001Sl-7K; Wed, 12 Aug 2026 10:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=aiZCSFnMz0pMtvyoburQ32EHLBOXmosP6GCIUFFOIi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oK6AsQkDK7QtLX8eO96A9VGRvSd85evzab6QP2tpYfPGkLdEbmFg4t4X95VmzSvVr
 2/ti8juBxt5qT7e6nuHUS/7ew5+QYvTWgpQBlEA4+LCNZyjO6ngW6+RUi8ed3+Xd7F
 MNpzuO6nkiOpAG/WUYMaYdvynsBv0uXov+AEZlmleZA5HUaYrNKXb5xvjheCjuDNxV
 xxE8MAIKmyKo3jZwQi5qCtJ59xegzkTtlV9yQbnI511eRAE175w88zfU/tKdKU8VCN
 YGNOgL6g0eU9ILeCoqx1+vV9NwdXTw4L4upW8wAazwx5wrF+e0MPfSv9GHmFBhTmZR
 EqE/zydrCEjGg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 36B601CA65B;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 91703409D9D;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EE95D2FA11; Wed, 12 Aug 2026 17:50:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, no92 <leo@managarm.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 087/120] linux-user: fix incorrect msg_l[sr]pid
 members of target_msqid_ds
Date: Wed, 12 Aug 2026 17:49:10 +0300
Message-ID: <20260812144955.649205-87-mjt@tls.msk.ru>
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

From: no92 <leo@managarm.org>

The members are declared as __kernel_pid_t in Linux UAPI headers.
Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
declared as abi_int.

Cc: qemu-stable@nongnu.org
Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc calls handling")
Signed-off-by: no92 <leo@managarm.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 518a4aa01b88ff814dbf8668016f3ec910426283)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index bf7c9af691e..dcf461806ad 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4228,8 +4228,8 @@ struct target_msqid_ds
     abi_ulong __msg_cbytes;
     abi_ulong msg_qnum;
     abi_ulong msg_qbytes;
-    abi_ulong msg_lspid;
-    abi_ulong msg_lrpid;
+    abi_int msg_lspid;
+    abi_int msg_lrpid;
     abi_ulong __unused4;
     abi_ulong __unused5;
 };
@@ -4249,8 +4249,8 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
     host_md->__msg_cbytes = tswapal(target_md->__msg_cbytes);
     host_md->msg_qnum = tswapal(target_md->msg_qnum);
     host_md->msg_qbytes = tswapal(target_md->msg_qbytes);
-    host_md->msg_lspid = tswapal(target_md->msg_lspid);
-    host_md->msg_lrpid = tswapal(target_md->msg_lrpid);
+    host_md->msg_lspid = tswap32(target_md->msg_lspid);
+    host_md->msg_lrpid = tswap32(target_md->msg_lrpid);
     unlock_user_struct(target_md, target_addr, 0);
     return 0;
 }
@@ -4270,8 +4270,8 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
     target_md->__msg_cbytes = tswapal(host_md->__msg_cbytes);
     target_md->msg_qnum = tswapal(host_md->msg_qnum);
     target_md->msg_qbytes = tswapal(host_md->msg_qbytes);
-    target_md->msg_lspid = tswapal(host_md->msg_lspid);
-    target_md->msg_lrpid = tswapal(host_md->msg_lrpid);
+    target_md->msg_lspid = tswap32(host_md->msg_lspid);
+    target_md->msg_lrpid = tswap32(host_md->msg_lrpid);
     unlock_user_struct(target_md, target_addr, 1);
     return 0;
 }
-- 
2.47.3


