Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10841C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 14:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1x6-0002Yi-Oa; Thu, 08 May 2025 10:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1x2-0002T7-Sk; Thu, 08 May 2025 10:10:18 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uD1x0-0008UD-UF; Thu, 08 May 2025 10:10:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 251EA432CA;
 Thu,  8 May 2025 16:09:42 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH 07/11] blockdev: drain while unlocked in
 external_snapshot_action()
Date: Thu,  8 May 2025 16:09:32 +0200
Message-Id: <20250508140936.3344485-8-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250508140936.3344485-1-f.ebner@proxmox.com>
References: <20250508140936.3344485-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Could the bs associated to the device change because of polling
when draining? If yes, does that mean we need to drain all in the
beginning and not temporarily unlock?

 blockdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index f2b4fdf1b3..4a672f9bac 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1368,7 +1368,7 @@ static void external_snapshot_action(TransactionAction *action,
     uint64_t perm, shared;
 
     /* TODO We'll eventually have to take a writer lock in this function */
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_graph_rdlock_main_loop();
 
     tran_add(tran, &external_snapshot_drv, state);
 
@@ -1401,11 +1401,14 @@ static void external_snapshot_action(TransactionAction *action,
 
     state->old_bs = bdrv_lookup_bs(device, node_name, errp);
     if (!state->old_bs) {
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
 
+    bdrv_graph_rdunlock_main_loop();
     /* Paired with .clean() */
     bdrv_drained_begin(state->old_bs);
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!bdrv_is_inserted(state->old_bs)) {
         error_setg(errp, "Device '%s' has no medium",
-- 
2.39.5



