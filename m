Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C90AC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublX5-0008QY-Jv; Tue, 15 Jul 2025 15:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwo-0003xc-EX
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwm-0001KN-If
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TEp5F51Wr4fzDNqxQrYHyGc/wDiNmCHrnHqf+CaHzk=;
 b=Yt+iSr2M5w4k+liqqiiaNSpCcxAaEyBr6WLd8VPy9OrIa5IhgpbNoTqM344QloKZxRqeRe
 ycgD+RG0HbYKLMBwu9IKrdQe2zyqwKBlxk965wIJuWLsXAO7IlaPIHHSeMbe2ghyDyTS73
 ZtT2Ja/0KoGTFFB7inaeq6Hsu/QczcE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-uIkVnprzMLWczPbjCP7yDA-1; Tue,
 15 Jul 2025 15:04:10 -0400
X-MC-Unique: uIkVnprzMLWczPbjCP7yDA-1
X-Mimecast-MFC-AGG-ID: uIkVnprzMLWczPbjCP7yDA_1752606249
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A0CE1956086; Tue, 15 Jul 2025 19:04:09 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01EB1197702B; Tue, 15 Jul 2025 19:04:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 15/57] block: mark blk_remove_bs() as GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:48 +0200
Message-ID: <20250715190330.378764-16-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

The function blk_remove_bs() calls bdrv_graph_wrlock_drained() and can
also call bdrv_drained_begin(), both of which which must be called with
the graph unlocked.

Marking blk_remove_bs() as GRAPH_UNLOCKED requires temporarily
unlocking in hmp_drive_del().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-38-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/system/block-backend-global-state.h |  2 +-
 block/monitor/block-hmp-cmds.c              | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index a62dbdf0dc..1a134083b7 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -55,7 +55,7 @@ void monitor_remove_blk(BlockBackend *blk);
 
 BlockBackendPublic *blk_get_public(BlockBackend *blk);
 
-void blk_remove_bs(BlockBackend *blk);
+void GRAPH_UNLOCKED blk_remove_bs(BlockBackend *blk);
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
 int blk_replace_bs(BlockBackend *blk, BlockDriverState *new_bs, Error **errp);
 bool GRAPH_RDLOCK bdrv_has_blk(BlockDriverState *bs);
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 6919a49bf5..282d1c386e 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -144,7 +144,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_graph_rdlock_main_loop();
 
     bs = bdrv_find_node(id);
     if (bs) {
@@ -152,29 +152,31 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
         if (local_err) {
             error_report_err(local_err);
         }
-        return;
+        goto unlock;
     }
 
     blk = blk_by_name(id);
     if (!blk) {
         error_report("Device '%s' not found", id);
-        return;
+        goto unlock;
     }
 
     if (!blk_legacy_dinfo(blk)) {
         error_report("Deleting device added with blockdev-add"
                      " is not supported");
-        return;
+        goto unlock;
     }
 
     bs = blk_bs(blk);
     if (bs) {
         if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_DRIVE_DEL, &local_err)) {
             error_report_err(local_err);
-            return;
+            goto unlock;
         }
 
+        bdrv_graph_rdunlock_main_loop();
         blk_remove_bs(blk);
+        bdrv_graph_rdlock_main_loop();
     }
 
     /* Make the BlockBackend and the attached BlockDriverState anonymous */
@@ -191,6 +193,9 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
     } else {
         blk_unref(blk);
     }
+
+unlock:
+    bdrv_graph_rdunlock_main_loop();
 }
 
 void hmp_commit(Monitor *mon, const QDict *qdict)
-- 
2.50.1


