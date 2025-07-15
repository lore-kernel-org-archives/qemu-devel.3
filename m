Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A29CC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQk-0004dX-Aw; Tue, 15 Jul 2025 15:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwj-0003t5-0y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkwh-0001J8-Be
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dsMwsThFLoJaZZKZ4zj+/Nv7SnOyR7h5y7MYGS1V5ug=;
 b=fQkwW3DjlOEgkNq31CcaIXSMqizT1e24IyKOPF4kuH2iF//havEyhaJNMchw6os9KsIIY5
 dtKakqlancbPv3xbnbddS7g/c9QMFpmCo6LAVLy/redEkfDhG2HBSHx0scGpjNyr1dlqn+
 0TeGRtCx7XyV1c93ZtND9Msf7NMeGL4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-vELb6pa-PLWpepkxvfZwvA-1; Tue,
 15 Jul 2025 15:04:03 -0400
X-MC-Unique: vELb6pa-PLWpepkxvfZwvA-1
X-Mimecast-MFC-AGG-ID: vELb6pa-PLWpepkxvfZwvA_1752606242
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62FF61956087; Tue, 15 Jul 2025 19:04:02 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6DCB197702C; Tue, 15 Jul 2025 19:04:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/57] block: mark bdrv_reopen_queue() and
 bdrv_reopen_multiple() as GRAPH_UNLOCKED
Date: Tue, 15 Jul 2025 21:02:45 +0200
Message-ID: <20250715190330.378764-13-kwolf@redhat.com>
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

The function bdrv_reopen_queue() can call bdrv_drain_all_begin(),
which must be called with the graph unlocked.

The function bdrv_reopen_multiple() calls bdrv_reopen_prepare() which
must be called with the graph unlocked.

To mark bdrv_reopen_queue() as GRAPH_UNLOCKED, it is necessary to make
the locked section in reopen_backing_file() shorter.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-35-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 9 +++++----
 block/replication.c                | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index bcbb624a7b..f25c65c1b4 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -121,11 +121,12 @@ BlockDriverState *bdrv_new_open_driver_opts(BlockDriver *drv,
                                             Error **errp);
 BlockDriverState *bdrv_new_open_driver(BlockDriver *drv, const char *node_name,
                                        int flags, Error **errp);
-BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
-                                    BlockDriverState *bs, QDict *options,
-                                    bool keep_old_opts);
+BlockReopenQueue * GRAPH_UNLOCKED
+bdrv_reopen_queue(BlockReopenQueue *bs_queue, BlockDriverState *bs,
+                  QDict *options, bool keep_old_opts);
 void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue);
-int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp);
+int GRAPH_UNLOCKED
+bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp);
 int bdrv_reopen(BlockDriverState *bs, QDict *opts, bool keep_old_opts,
                 Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
diff --git a/block/replication.c b/block/replication.c
index 83978b61f5..3a431e908c 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -364,14 +364,15 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     BlockReopenQueue *reopen_queue = NULL;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    bdrv_graph_rdlock_main_loop();
     /*
      * s->hidden_disk and s->secondary_disk may not be set yet, as they will
      * only be set after the children are writable.
      */
     hidden_disk = bs->file->bs->backing;
     secondary_disk = hidden_disk->bs->backing;
+    bdrv_graph_rdunlock_main_loop();
 
     if (writable) {
         s->orig_hidden_read_only = bdrv_is_read_only(hidden_disk->bs);
-- 
2.50.1


