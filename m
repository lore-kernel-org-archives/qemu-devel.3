Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2198EC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMS-0002Xn-Rs; Wed, 04 Jun 2025 13:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMA-0002Iz-QR
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM4-0000Px-CI
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vLph1FOmot9axnFpJW6oz5uWeKY/Ute71g5wIqE0ZM=;
 b=Ycp/9wLaFEfsmdtfPA/FK+sqYOv73uu1E4Ct15XkJwqNkWN5Z/9RbjwhGyjfXFk66F3J0H
 5OkePqHuhBJQv38Vn6BXxI7oxXKQa4nOpZQi0MW/RFsuAlB02Rgx2aKDlb09srLgf1LUWp
 OqY11f1375alX2JiQTnPWhklx2BHfIw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-1FRMo6wAPUyeDIAqCcTJ6w-1; Wed,
 04 Jun 2025 13:56:27 -0400
X-MC-Unique: 1FRMo6wAPUyeDIAqCcTJ6w-1
X-Mimecast-MFC-AGG-ID: 1FRMo6wAPUyeDIAqCcTJ6w_1749059787
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7B3E19560AA; Wed,  4 Jun 2025 17:56:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A46D118003FD; Wed,  4 Jun 2025 17:56:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/24] block: move drain outside of read-locked
 bdrv_inactivate_recurse()
Date: Wed,  4 Jun 2025 19:55:53 +0200
Message-ID: <20250604175613.344113-5-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

More granular draining is not trivially possible, because
bdrv_inactivate_recurse() can recursively call itself.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250530151125.955508-5-f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 3065d5c91e..fa55dfba68 100644
--- a/block.c
+++ b/block.c
@@ -6989,6 +6989,8 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
 
     GLOBAL_STATE_CODE();
 
+    assert(bs->quiesce_counter > 0);
+
     if (!bs->drv) {
         return -ENOMEDIUM;
     }
@@ -7032,9 +7034,7 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
         return -EPERM;
     }
 
-    bdrv_drained_begin(bs);
     bs->open_flags |= BDRV_O_INACTIVE;
-    bdrv_drained_end(bs);
 
     /*
      * Update permissions, they may differ for inactive nodes.
@@ -7059,20 +7059,26 @@ int bdrv_inactivate(BlockDriverState *bs, Error **errp)
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     if (bdrv_has_bds_parent(bs, true)) {
         error_setg(errp, "Node has active parent node");
-        return -EPERM;
+        ret = -EPERM;
+        goto out;
     }
 
     ret = bdrv_inactivate_recurse(bs, true);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Failed to inactivate node");
-        return ret;
+        goto out;
     }
 
-    return 0;
+out:
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+    return ret;
 }
 
 int bdrv_inactivate_all(void)
@@ -7082,7 +7088,9 @@ int bdrv_inactivate_all(void)
     int ret = 0;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_drain_all_begin();
+    bdrv_graph_rdlock_main_loop();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         /* Nodes with BDS parents are covered by recursion from the last
@@ -7098,6 +7106,9 @@ int bdrv_inactivate_all(void)
         }
     }
 
+    bdrv_graph_rdunlock_main_loop();
+    bdrv_drain_all_end();
+
     return ret;
 }
 
-- 
2.49.0


