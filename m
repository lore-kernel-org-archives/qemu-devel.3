Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F68C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PP-00043V-Nk; Fri, 30 May 2025 11:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PB-0003LA-Oh; Fri, 30 May 2025 11:12:22 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P8-0002Hu-Qc; Fri, 30 May 2025 11:12:21 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 31ACF44B18;
 Fri, 30 May 2025 17:11:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 27/48] block: call bdrv_set_backing_hd() while unlocked in
 bdrv_open_backing_file()
Date: Fri, 30 May 2025 17:11:04 +0200
Message-Id: <20250530151125.955508-28-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
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

This is in preparation to mark bdrv_set_backing_hd() as
GRAPH_UNLOCKED.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 1da10d55f0..ca3b67b233 100644
--- a/block.c
+++ b/block.c
@@ -3632,7 +3632,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_graph_rdlock_main_loop();
 
     if (bs->backing != NULL) {
         goto free_exit;
@@ -3711,9 +3712,12 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                 backing_hd->filename);
     }
 
+
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
+    bdrv_graph_rdunlock_main_loop();
     ret = bdrv_set_backing_hd(bs, backing_hd, errp);
+    bdrv_graph_rdlock_main_loop();
     bdrv_unref(backing_hd);
 
     if (ret < 0) {
@@ -3725,6 +3729,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 free_exit:
     g_free(backing_filename);
     qobject_unref(tmp_parent_options);
+    bdrv_graph_rdunlock_main_loop();
     return ret;
 }
 
-- 
2.39.5



