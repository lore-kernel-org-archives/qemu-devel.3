Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D13C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jI-00016j-2s; Wed, 12 Aug 2026 09:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8j6-0000JR-Qu; Wed, 12 Aug 2026 09:10:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8j4-000622-MH; Wed, 12 Aug 2026 09:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=qEDrbBsfTF8WE2NAezqByD57qYB/HIVEbFKlYdnvRgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cjk9o5Ris0/QkcjZbj0tomv+sHXCOtEiDbWoNlZamSKfDkL8n80r7YkAXlbqStRWG
 wsKnYqFJe7e9IUFHtLGzkll8SzCfMQ1ZPcWzrNLPtggKXqBkaw80HehMdki4kRuSkc
 J+7WYvwyrVEBbmUY42Cu8FQZaQigd7d/0GUFHDysT+wIjUeTXvRR8Wsbq3L58sdduV
 8nMspwE2OR1BjUimGvT6Qv+2kqpyv/HI09QmaoLb1Y/+kWAtpTHESlEB+t2fTYQcvL
 XeJJQ3APySRtLK1zqCSgYgp/UAg+V+U7H2++MRdxRSRBTqyW5ts52r6wEbeUi7JLnF
 bzTwN5kwYberQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 719671CA4CB;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A8098409BAE;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 95A8B2F92C; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, no92 <leo@managarm.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 076/102] linux-user: fix incorrect msg_l[sr]pid
 members of target_msqid_ds
Date: Wed, 12 Aug 2026 16:01:51 +0300
Message-ID: <20260812130233.621965-76-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
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
index adb9ced9f89..9a58d0a2175 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4232,8 +4232,8 @@ struct target_msqid_ds
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
@@ -4253,8 +4253,8 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
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
@@ -4274,8 +4274,8 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
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


