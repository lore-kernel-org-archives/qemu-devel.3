Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA784C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMR-0002XI-5c; Wed, 04 Jun 2025 13:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsME-0002LM-3I
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM9-0000VS-1e
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YaP71lX/QL+N9yRdn5gWmcHSnY/m+rE+kqYfamaKahU=;
 b=Fl/oNuqpMpDo5ANH5PmsAAgFdhcZPiuPgxCNK50Cn77o+7P+/9IV22vzb1E30ljrZajdc+
 xWxtnr7AqaCufJ9UpTdjDuIduuZXrvQB9kIXf10qQd4TC9x9KDEtGqUTMx3oQhhaPEe0Y7
 bvciTHp5WhiiRFUiQrXjOvwz3hBcVjs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-qcNwAaThMASM7qVept-FBw-1; Wed,
 04 Jun 2025 13:56:49 -0400
X-MC-Unique: qcNwAaThMASM7qVept-FBw-1
X-Mimecast-MFC-AGG-ID: qcNwAaThMASM7qVept-FBw_1749059808
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FA411800A06; Wed,  4 Jun 2025 17:56:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B98D18003FD; Wed,  4 Jun 2025 17:56:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/24] block: move drain outside of quorum_del_child()
Date: Wed,  4 Jun 2025 19:56:05 +0200
Message-ID: <20250604175613.344113-17-kwolf@redhat.com>
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

The quorum_del_child() callback runs under the graph lock, so it is
not allowed to drain. It is only called as the .bdrv_del_child()
callback, which is only called in the bdrv_del_child() function, which
also runs under the graph lock.

The bdrv_del_child() function is called by qmp_x_blockdev_change().
A drained section was already introduced there by commit "block: move
drain out of quorum_add_child()".

This finally finishes moving out the drain to places that are not
under the graph lock started in "block: move draining out of
bdrv_change_aio_context() and mark GRAPH_RDLOCK".

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-17-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 7 +++++++
 block.c                          | 2 ++
 block/quorum.c                   | 2 --
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index f9e742f812..925a3e7353 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -406,6 +406,13 @@ struct BlockDriver {
     void GRAPH_WRLOCK_PTR (*bdrv_add_child)(
         BlockDriverState *parent, BlockDriverState *child, Error **errp);
 
+    /**
+     * Hot remove a BDS's child. Used in combination with bdrv_add_child, so the
+     * user can take a child offline when it is broken and take a new child
+     * online.
+     *
+     * All block nodes must be drained.
+     */
     void GRAPH_WRLOCK_PTR (*bdrv_del_child)(
         BlockDriverState *parent, BdrvChild *child, Error **errp);
 
diff --git a/block.c b/block.c
index 15a8ccb822..bfd4340b24 100644
--- a/block.c
+++ b/block.c
@@ -8276,6 +8276,8 @@ void bdrv_add_child(BlockDriverState *parent_bs, BlockDriverState *child_bs,
 /*
  * Hot remove a BDS's child. Used in combination with bdrv_add_child, so the
  * user can take a child offline when it is broken and take a new child online.
+ *
+ * All block nodes must be drained.
  */
 void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 {
diff --git a/block/quorum.c b/block/quorum.c
index 81407a38ee..cc3bc5f4e7 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1147,9 +1147,7 @@ quorum_del_child(BlockDriverState *bs, BdrvChild *child, Error **errp)
             (s->num_children - i - 1) * sizeof(BdrvChild *));
     s->children = g_renew(BdrvChild *, s->children, --s->num_children);
 
-    bdrv_drain_all_begin();
     bdrv_unref_child(bs, child);
-    bdrv_drain_all_end();
 
     quorum_refresh_flags(bs);
 }
-- 
2.49.0


