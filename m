Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAA5C369D7
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8NEi-000139-IE; Fri, 25 Apr 2025 13:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEd-0000vC-Pu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1u8NEb-0007QU-6U
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745603588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3g0fPuHvk3asu5clMmWIWFWOoC9eZtoZihOH1k2nN0=;
 b=I3F7qbOYefNkQJ+AfPnzGe/hpXT9dlyJSxr4MKtzUwUBRT9wOmO57aHosWmDCel01ef2t9
 eIKYZGUeW0n5NqhPfCGLoU7GHOt46+H4FExHxNzF9YHKFrwqZ9Okz0nY7gDCGTN2S27jGQ
 F4WtORK2eK6X+vfaDSzXjGtw296/byY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-EU6naOjLP1mMjNxSbWh3bg-1; Fri,
 25 Apr 2025 13:53:03 -0400
X-MC-Unique: EU6naOjLP1mMjNxSbWh3bg-1
X-Mimecast-MFC-AGG-ID: EU6naOjLP1mMjNxSbWh3bg_1745603582
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCA21180034A; Fri, 25 Apr 2025 17:53:01 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.183])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99B52180045C; Fri, 25 Apr 2025 17:53:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/4] block: Remove unused callback function *bdrv_aio_pdiscard
Date: Fri, 25 Apr 2025 19:52:51 +0200
Message-ID: <20250425175252.316807-4-kwolf@redhat.com>
In-Reply-To: <20250425175252.316807-1-kwolf@redhat.com>
References: <20250425175252.316807-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Sunny Zhu <sunnyzhyy@qq.com>

The bytes type in *bdrv_aio_pdiscard should be int64_t rather than int.

There are no drivers implementing the *bdrv_aio_pdiscard() callback,
it appears to be an unused function. Therefore, we'll simply remove it
instead of fixing it.

Additionally, coroutine-based callbacks are preferred. If someone needs
to implement bdrv_aio_pdiscard, a coroutine-based version would be
straightforward to implement.

Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
Message-ID: <tencent_7140D2E54157D98CF3D9E64B1A007A1A7906@qq.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  4 ----
 block/io.c                       | 22 +++-------------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a50..0d8187f656 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -506,10 +506,6 @@ struct BlockDriver {
     BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_flush)(
         BlockDriverState *bs, BlockCompletionFunc *cb, void *opaque);
 
-    BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_pdiscard)(
-        BlockDriverState *bs, int64_t offset, int bytes,
-        BlockCompletionFunc *cb, void *opaque);
-
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_readv)(BlockDriverState *bs,
         int64_t sector_num, int nb_sectors, QEMUIOVector *qiov);
 
diff --git a/block/io.c b/block/io.c
index ccec11386b..6d98b0abb9 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3102,7 +3102,7 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
         return 0;
     }
 
-    if (!bs->drv->bdrv_co_pdiscard && !bs->drv->bdrv_aio_pdiscard) {
+    if (!bs->drv->bdrv_co_pdiscard) {
         return 0;
     }
 
@@ -3162,24 +3162,8 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
             ret = -ENOMEDIUM;
             goto out;
         }
-        if (bs->drv->bdrv_co_pdiscard) {
-            ret = bs->drv->bdrv_co_pdiscard(bs, offset, num);
-        } else {
-            BlockAIOCB *acb;
-            CoroutineIOCompletion co = {
-                .coroutine = qemu_coroutine_self(),
-            };
-
-            acb = bs->drv->bdrv_aio_pdiscard(bs, offset, num,
-                                             bdrv_co_io_em_complete, &co);
-            if (acb == NULL) {
-                ret = -EIO;
-                goto out;
-            } else {
-                qemu_coroutine_yield();
-                ret = co.ret;
-            }
-        }
+
+        ret = bs->drv->bdrv_co_pdiscard(bs, offset, num);
         if (ret && ret != -ENOTSUP) {
             if (ret == -EINVAL && (offset % align != 0 || num % align != 0)) {
                 /* Silently skip rejected unaligned head/tail requests */
-- 
2.49.0


