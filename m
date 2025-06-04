Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D1FC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 17:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMD-0002K4-Pg; Wed, 04 Jun 2025 13:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM4-0002FF-5d
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM0-0000PE-2W
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749059786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F5aNrHF/jgPGxszjIoqnvA0x6tLHNb0Kq+VNyq8kn8k=;
 b=BoGk9OZ4RXsQtFImVPKJlOTRYnf4xDC8Br+flX7BqbULxJZHdwklSUVfpVT7vGGHUrHoWo
 M2tLhsHitZPexV8ZDh0/btBhbRs6QAx5utozgf1kq5WYU6E+qbIYDlE2BcpP4m02+b/5pO
 7YnDFN17JxqULpFUTre2gFpcKYCIQn4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-_15El3oDPLupz-dtmLs43w-1; Wed,
 04 Jun 2025 13:56:23 -0400
X-MC-Unique: _15El3oDPLupz-dtmLs43w-1
X-Mimecast-MFC-AGG-ID: _15El3oDPLupz-dtmLs43w_1749059782
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1741195609F; Wed,  4 Jun 2025 17:56:21 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71F2A18002A5; Wed,  4 Jun 2025 17:56:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/24] block: remove outdated comments about AioContext locking
Date: Wed,  4 Jun 2025 19:55:50 +0200
Message-ID: <20250604175613.344113-2-kwolf@redhat.com>
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

AioContext locking was removed in commit b49f4755c7 ("block: remove
AioContext locking").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250530151125.955508-2-f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block.c b/block.c
index f222e1a50a..a5399888ba 100644
--- a/block.c
+++ b/block.c
@@ -4359,8 +4359,6 @@ bdrv_recurse_has_child(BlockDriverState *bs, BlockDriverState *child)
  * bs_queue, or the existing bs_queue being used.
  *
  * bs is drained here and undrained by bdrv_reopen_queue_free().
- *
- * To be called with bs->aio_context locked.
  */
 static BlockReopenQueue * GRAPH_RDLOCK
 bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
@@ -4519,7 +4517,6 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
     return bs_queue;
 }
 
-/* To be called with bs->aio_context locked */
 BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, bool keep_old_opts)
@@ -7278,10 +7275,6 @@ bool bdrv_op_blocker_is_empty(BlockDriverState *bs)
     return true;
 }
 
-/*
- * Must not be called while holding the lock of an AioContext other than the
- * current one.
- */
 void bdrv_img_create(const char *filename, const char *fmt,
                      const char *base_filename, const char *base_fmt,
                      char *options, uint64_t img_size, int flags, bool quiet,
-- 
2.49.0


