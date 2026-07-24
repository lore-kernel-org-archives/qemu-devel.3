Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D064C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnILs-0004Mh-43; Fri, 24 Jul 2026 12:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo@managarm.org>) id 1wnILa-000475-T2
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:02:11 -0400
Received: from hades.hosts.managarm.org ([195.201.36.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo@managarm.org>) id 1wnILZ-0006TV-3I
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=managarm.org; s=2021;
 t=1784908917; bh=kyMGBzHyhNvrLlDQQiEDsaUBYaz1xj8MSYWo+i3IWoc=;
 h=From:To:Cc:Subject:Date:From;
 b=zP2rFPSqRJH5U3m+8JujtmKElSmniTp/novaen8MavMC/DlV+sezOftRdv3XqjW2Z
 PC5Y7ckUwdTEoIrrKZYBApGfYR+7vvExkAxmpex2qdNBnOSzydQDlThEXhH+V5TVIM
 9BKjvhsC3CQCoTIxuc5tb4pkEQ2GHFb7pgmAKQK++w1Odgaoagb7i32ojcdYirVjru
 h19bbc6+fnmbAn1w8CIChrk17i0jSG/78+1XBhFkTjUAtcPOh85uG6EUOSY7jaVrne
 m3yS61nY/nNmToNPKsW4mwCyOcMbInzFVlMzQieVzAhqK7xXo9vjdWl1FxhV5L1NAw
 jnkfvAZE+pyvg==
Received: from white.localdomain (pd9f9de93.dip0.t-ipconnect.de
 [217.249.222.147])
 by hades.hosts.managarm.org (Postfix) with ESMTPSA id C9FFF3FB17;
 Fri, 24 Jul 2026 16:01:57 +0000 (UTC)
To: qemu-devel@nongnu.org
Cc: no92 <leo@managarm.org>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
Date: Fri, 24 Jul 2026 18:01:04 +0200
Message-ID: <20260724160105.3787888-1-leo@managarm.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.201.36.94; envelope-from=leo@managarm.org;
 helo=hades.hosts.managarm.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Reply-to:  no92 <leo@managarm.org>
From:  no92 via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The members are declared as __kernel_pid_t in Linux UAPI headers.
Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
declared as abi_int.

Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc calls handling")
Signed-off-by: no92 <leo@managarm.org>
---
 linux-user/syscall.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3da5530d42..616d543c7f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4234,8 +4234,8 @@ struct target_msqid_ds
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
@@ -4255,8 +4255,8 @@ static inline abi_long target_to_host_msqid_ds(struct msqid_ds *host_md,
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
@@ -4276,8 +4276,8 @@ static inline abi_long host_to_target_msqid_ds(abi_ulong target_addr,
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


