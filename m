Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178CFC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 20:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpBMw-0002eT-Hk; Wed, 29 Jul 2026 16:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wpBMt-0002d0-BV
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:59:11 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wpBMr-0003jx-Kh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 16:59:11 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8E64843AA0;
 Wed, 29 Jul 2026 20:59:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311291F000E9;
 Wed, 29 Jul 2026 20:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785358748;
 bh=D+7TI/A5weC4o5qGGiEE6Wy+v675CcpJHfbuWtjckgE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z9fCISCOL38OV+P0l0WsDsglWITnLzE2Q9ob9K5BJe5EciEPtIfjDJSiUKNrOVotQ
 nBR6H+yBl4wKK0JUt5I08H2FbRoIs1I9/KoGdMoLMbjH2HbyCkxCWI/2iTXoRGyafF
 mpyreMOU8HcRyDlaKkjC1DJnulYaL3IitOuDWykugY7sEUl5JztC4dfrM7698r6H+M
 BDLWcuNzl6FKYefUUlfzk1VpdbdV4FdWiQcb16rZwqSOuc+U5svkeFo7k+94nTRZN0
 jweiZN+xksQCqa4AJYmWYZPIxqtpe3B9wOzUd9nH3rUmP9tMkhm31JNByI2yI417D9
 rId5972KS8Kaw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, no92 <leo@managarm.org>
Subject: [PULL 2/3] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
Date: Wed, 29 Jul 2026 22:59:01 +0200
Message-ID: <20260729205902.3767-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729205902.3767-1-deller@kernel.org>
References: <20260729205902.3767-1-deller@kernel.org>
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

From: no92 <leo@managarm.org>

The members are declared as __kernel_pid_t in Linux UAPI headers.
Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
declared as abi_int.

Cc: qemu-stable@nongnu.org
Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc calls handling")
Signed-off-by: no92 <leo@managarm.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c93b770ced..547784d971 100644
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
2.54.0


