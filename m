Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99517C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuqb-00079I-4m; Fri, 02 Feb 2024 09:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVuqR-00074h-Q8
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rVuqP-0002pA-HT
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706885318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxQY+7ko3W9v0eh+vuzLr5ZuuX1slmfDJFHBVuZHIl8=;
 b=VvqOivEI2uAB9X1xQanwd8HTVZ3bilQiQMAeW0wqr1BmY+OSwNDQm43r3zfvLWWgnS7D7Z
 kMzIE74b4xv/j6UePJcke/0JeK0Pk6WXe2xpIKP2cFbg4X/AftNW2DcSh2rh471j5pBAU9
 wt+rYFXaEEfADohrd6Txr3pgPsjoRxA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-_LHxjTqEN_OkezwQkuGIww-1; Fri, 02 Feb 2024 09:48:35 -0500
X-MC-Unique: _LHxjTqEN_OkezwQkuGIww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E69B318A6513;
 Fri,  2 Feb 2024 14:48:24 +0000 (UTC)
Received: from localhost (unknown [10.39.194.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 786C8900;
 Fri,  2 Feb 2024 14:48:24 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/2] block-backend: Allow concurrent context changes
Date: Fri,  2 Feb 2024 15:47:54 +0100
Message-ID: <20240202144755.671354-2-hreitz@redhat.com>
In-Reply-To: <20240202144755.671354-1-hreitz@redhat.com>
References: <20240202144755.671354-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since AioContext locks have been removed, a BlockBackend's AioContext
may really change at any time (only exception is that it is often
confined to a drained section, as noted in this patch).  Therefore,
blk_get_aio_context() cannot rely on its root node's context always
matching that of the BlockBackend.

In practice, whether they match does not matter anymore anyway: Requests
can be sent to BDSs from any context, so anyone who requests the BB's
context should have no reason to require the root node to have the same
context.  Therefore, we can and should remove the assertion to that
effect.

In addition, because the context can be set and queried from different
threads concurrently, it has to be accessed with atomic operations.

Buglink: https://issues.redhat.com/browse/RHEL-19381
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/block-backend.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 209eb07528..9c4de79e6b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -44,7 +44,7 @@ struct BlockBackend {
     char *name;
     int refcnt;
     BdrvChild *root;
-    AioContext *ctx;
+    AioContext *ctx; /* access with atomic operations only */
     DriveInfo *legacy_dinfo;    /* null unless created by drive_new() */
     QTAILQ_ENTRY(BlockBackend) link;         /* for block_backends */
     QTAILQ_ENTRY(BlockBackend) monitor_link; /* for monitor_block_backends */
@@ -2414,22 +2414,22 @@ void blk_op_unblock_all(BlockBackend *blk, Error *reason)
     }
 }
 
+/**
+ * Return BB's current AioContext.  Note that this context may change
+ * concurrently at any time, with one exception: If the BB has a root node
+ * attached, its context will only change through bdrv_try_change_aio_context(),
+ * which creates a drained section.  Therefore, incrementing such a BB's
+ * in-flight counter will prevent its context from changing.
+ */
 AioContext *blk_get_aio_context(BlockBackend *blk)
 {
-    BlockDriverState *bs;
     IO_CODE();
 
     if (!blk) {
         return qemu_get_aio_context();
     }
 
-    bs = blk_bs(blk);
-    if (bs) {
-        AioContext *ctx = bdrv_get_aio_context(blk_bs(blk));
-        assert(ctx == blk->ctx);
-    }
-
-    return blk->ctx;
+    return qatomic_read(&blk->ctx);
 }
 
 int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
@@ -2442,7 +2442,7 @@ int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
     GLOBAL_STATE_CODE();
 
     if (!bs) {
-        blk->ctx = new_context;
+        qatomic_set(&blk->ctx, new_context);
         return 0;
     }
 
@@ -2471,7 +2471,7 @@ static void blk_root_set_aio_ctx_commit(void *opaque)
     AioContext *new_context = s->new_ctx;
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
 
-    blk->ctx = new_context;
+    qatomic_set(&blk->ctx, new_context);
     if (tgm->throttle_state) {
         throttle_group_detach_aio_context(tgm);
         throttle_group_attach_aio_context(tgm, new_context);
-- 
2.43.0


