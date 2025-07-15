Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615E7C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublMS-0001of-L3; Tue, 15 Jul 2025 15:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwR-0003Yr-Ou
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwP-0001FN-S8
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VozVVm7+4vUKUcxr3dAo1lApjn1lz5m0QkTvFup66SM=;
 b=eBFtaJ9FANQl133d6BZ3Uwn6wz0wC4v66UT/Mb5JyfUAcpNKw1qRzLqMGGaqM/V5B790BO
 UMbEtfeQfqIXwa3Lw4UrGRnEiSOqRcxvLoFbss8PMtR+jU0cY4b6/RzHWljCGM6vrA4Iwv
 VVNP0Ucsvt0LEStHnZMmDSiiBhhSVjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-IYg0NmTrMCy18Kgdf7BWpg-1; Tue,
 15 Jul 2025 15:03:46 -0400
X-MC-Unique: IYg0NmTrMCy18Kgdf7BWpg-1
X-Mimecast-MFC-AGG-ID: IYg0NmTrMCy18Kgdf7BWpg_1752606225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C70D1800368; Tue, 15 Jul 2025 19:03:45 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5B09197702B; Tue, 15 Jul 2025 19:03:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/57] block/commit: switch to bdrv_set_backing_hd_drained()
 variant
Date: Tue, 15 Jul 2025 21:02:37 +0200
Message-ID: <20250715190330.378764-5-kwolf@redhat.com>
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

This is in preparation to mark bdrv_set_backing_hd() as
GRAPH_UNLOCKED.

Switch to using the bdrv_set_backing_hd_drained() variant. For the
first pair of calls to avoid draining and locking twice in a row
within the individual calls. For the third call, so that the drained
and locked section can also cover bdrv_cow_bs().

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-27-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/commit.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index dc1942483b..c9690a5da0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -514,28 +514,32 @@ int bdrv_commit(BlockDriverState *bs)
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!drv)
         return -ENOMEDIUM;
 
+    bdrv_graph_rdlock_main_loop();
+
     backing_file_bs = bdrv_cow_bs(bs);
 
     if (!backing_file_bs) {
-        return -ENOTSUP;
+        ret = -ENOTSUP;
+        goto out;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
         bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET, NULL))
     {
-        return -EBUSY;
+        ret = -EBUSY;
+        goto out;
     }
 
     ro = bdrv_is_read_only(backing_file_bs);
 
     if (ro) {
         if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
-            return -EACCES;
+            ret = -EACCES;
+            goto out;
         }
     }
 
@@ -559,8 +563,14 @@ int bdrv_commit(BlockDriverState *bs)
         goto ro_cleanup;
     }
 
-    bdrv_set_backing_hd(commit_top_bs, backing_file_bs, &error_abort);
-    bdrv_set_backing_hd(bs, commit_top_bs, &error_abort);
+    bdrv_graph_rdunlock_main_loop();
+
+    bdrv_graph_wrlock_drained();
+    bdrv_set_backing_hd_drained(commit_top_bs, backing_file_bs, &error_abort);
+    bdrv_set_backing_hd_drained(bs, commit_top_bs, &error_abort);
+    bdrv_graph_wrunlock();
+
+    bdrv_graph_rdlock_main_loop();
 
     ret = blk_insert_bs(backing, backing_file_bs, &local_err);
     if (ret < 0) {
@@ -635,9 +645,14 @@ int bdrv_commit(BlockDriverState *bs)
     ret = 0;
 ro_cleanup:
     blk_unref(backing);
+
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_graph_wrlock_drained();
     if (bdrv_cow_bs(bs) != backing_file_bs) {
-        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
+        bdrv_set_backing_hd_drained(bs, backing_file_bs, &error_abort);
     }
+    bdrv_graph_wrunlock();
+    bdrv_graph_rdlock_main_loop();
     bdrv_unref(commit_top_bs);
     blk_unref(src);
 
@@ -646,5 +661,8 @@ ro_cleanup:
         bdrv_reopen_set_read_only(backing_file_bs, true, NULL);
     }
 
+out:
+    bdrv_graph_rdunlock_main_loop();
+
     return ret;
 }
-- 
2.50.1


