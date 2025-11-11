Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820A3CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzZ-0007EM-N5; Tue, 11 Nov 2025 16:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzX-0007AN-PS
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzW-0001sZ-9m
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp2HhpVLeErR7H41RjTM9sLOi9rsqHpHrG7Qo1Z6S2w=;
 b=DhXv3s1MzHDnVFgWqh3vA4DJVIhofB5iDz9tCGotEOqyXnDxx5+plO2COOPL7/kVxa7NE5
 hVtOsJ5/ixduPV2jZgftDxAxnGSWSjHfPByxXC48b5tOdAzQ8Cv2eD6KwM9MiajC+nGjWn
 tzQEsaMge7MBZjrV568pV1Mul0VKQ28=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-17pEUVkkNvyEZz-n54qswA-1; Tue,
 11 Nov 2025 16:33:26 -0500
X-MC-Unique: 17pEUVkkNvyEZz-n54qswA-1
X-Mimecast-MFC-AGG-ID: 17pEUVkkNvyEZz-n54qswA_1762896805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F32918011EF; Tue, 11 Nov 2025 21:33:25 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FE5330044E0; Tue, 11 Nov 2025 21:33:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 11/28] aio-posix: unindent fdmon_io_uring_destroy()
Date: Tue, 11 Nov 2025 22:32:21 +0100
Message-ID: <20251111213238.181992-12-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Reduce the level of indentation to make further code changes easier to
read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251104022933.618123-12-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/fdmon-io_uring.c | 54 ++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index bcfdddf398..6ee6adbebb 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -397,33 +397,35 @@ bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 
 void fdmon_io_uring_destroy(AioContext *ctx)
 {
-    if (ctx->fdmon_ops == &fdmon_io_uring_ops) {
-        AioHandler *node;
-
-        io_uring_queue_exit(&ctx->fdmon_io_uring);
-
-        /* Move handlers due to be removed onto the deleted list */
-        while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
-            unsigned flags = qatomic_fetch_and(&node->flags,
-                    ~(FDMON_IO_URING_PENDING |
-                      FDMON_IO_URING_ADD |
-                      FDMON_IO_URING_REMOVE |
-                      FDMON_IO_URING_DELETE_AIO_HANDLER));
-
-            if ((flags & FDMON_IO_URING_REMOVE) ||
-                (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
-                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
-                                      node, node_deleted);
-            }
-
-            QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
-        }
+    AioHandler *node;
+
+    if (ctx->fdmon_ops != &fdmon_io_uring_ops) {
+        return;
+    }
+
+    io_uring_queue_exit(&ctx->fdmon_io_uring);
 
-        g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
-        ctx->io_uring_fd_tag = NULL;
+    /* Move handlers due to be removed onto the deleted list */
+    while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
+        unsigned flags = qatomic_fetch_and(&node->flags,
+                ~(FDMON_IO_URING_PENDING |
+                  FDMON_IO_URING_ADD |
+                  FDMON_IO_URING_REMOVE |
+                  FDMON_IO_URING_DELETE_AIO_HANDLER));
 
-        qemu_lockcnt_lock(&ctx->list_lock);
-        fdmon_poll_downgrade(ctx);
-        qemu_lockcnt_unlock(&ctx->list_lock);
+        if ((flags & FDMON_IO_URING_REMOVE) ||
+            (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
+            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
+                                  node, node_deleted);
+        }
+
+        QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
     }
+
+    g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
+    ctx->io_uring_fd_tag = NULL;
+
+    qemu_lockcnt_lock(&ctx->list_lock);
+    fdmon_poll_downgrade(ctx);
+    qemu_lockcnt_unlock(&ctx->list_lock);
 }
-- 
2.51.1


