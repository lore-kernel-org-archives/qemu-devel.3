Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39CEC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMV-0002ZG-LV; Wed, 04 Jun 2025 13:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsME-0002LT-MP
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMA-0000Wb-VD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qa2nagy+k4YUIF8BffyxJims+i6IqA1schOl/axi3A8=;
 b=Le+2CizTuZWrbBoKDIxAZRoRnAdHBN4l1v85t17qyD0CSFLQVCbLdX40cnoNr469LztUs4
 T+tmyOhp44nWlJM4L9nxVk/b92JalS2ML4Oc5XamWYvJPnt8+Ll+UtRiryn/ZhY7iaiHb8
 623BoEYJ+SVfNAMJhH0cKGHo1FH7OLw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-dGwNOz07NHOdx5a8PzaVow-1; Wed,
 04 Jun 2025 13:56:51 -0400
X-MC-Unique: dGwNOz07NHOdx5a8PzaVow-1
X-Mimecast-MFC-AGG-ID: dGwNOz07NHOdx5a8PzaVow_1749059810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 339C018001D6; Wed,  4 Jun 2025 17:56:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E659518003FD; Wed,  4 Jun 2025 17:56:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/24] blockdev: drain while unlocked in
 internal_snapshot_action()
Date: Wed,  4 Jun 2025 19:56:06 +0200
Message-ID: <20250604175613.344113-18-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-18-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index bd5ca77619..506755bef1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1208,7 +1208,7 @@ static void internal_snapshot_action(BlockdevSnapshotInternal *internal,
     Error *local_err = NULL;
     const char *device;
     const char *name;
-    BlockDriverState *bs;
+    BlockDriverState *bs, *check_bs;
     QEMUSnapshotInfo old_sn, *sn;
     bool ret;
     int64_t rt;
@@ -1216,7 +1216,7 @@ static void internal_snapshot_action(BlockdevSnapshotInternal *internal,
     int ret1;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    bdrv_graph_rdlock_main_loop();
 
     tran_add(tran, &internal_snapshot_drv, state);
 
@@ -1225,14 +1225,29 @@ static void internal_snapshot_action(BlockdevSnapshotInternal *internal,
 
     bs = qmp_get_root_bs(device, errp);
     if (!bs) {
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
 
     state->bs = bs;
 
+    /* Need to drain while unlocked. */
+    bdrv_graph_rdunlock_main_loop();
     /* Paired with .clean() */
     bdrv_drained_begin(bs);
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    /* Make sure the root bs did not change with the drain. */
+    check_bs = qmp_get_root_bs(device, errp);
+    if (bs != check_bs) {
+        if (check_bs) {
+            error_setg(errp, "Block node of device '%s' unexpectedly changed",
+                       device);
+        } /* else errp is already set */
+        return;
+    }
+
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_INTERNAL_SNAPSHOT, errp)) {
         return;
     }
-- 
2.49.0


