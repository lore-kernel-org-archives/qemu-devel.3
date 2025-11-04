Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9D2CCFA03
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 02:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG6pB-0007dp-96; Mon, 03 Nov 2025 21:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oG-00074R-HL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vG6oE-0004BY-TT
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 21:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762223410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J21vM0J2NKXZ9mcytYzZdrXeR0GXtkJ/tCwjYIPg+gc=;
 b=F14XVIebo0DgME19iiouKI5p83VZOzk4l1jLh/zuEKZk0XYziJ3JnSogE4ZVVA/AaSHcVj
 KlXTcxCeKIo70kx8DHXQ3veR1DZsScqZf4AM3uydiJpqIho6qYSs8KX0Qzt6o/j9zIq77W
 m+y/pVSyNaIA5PpThQIlKFvkaPkpvtM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-QKMbSYCoMR6y7p-kfvWUZQ-1; Mon,
 03 Nov 2025 21:30:06 -0500
X-MC-Unique: QKMbSYCoMR6y7p-kfvWUZQ-1
X-Mimecast-MFC-AGG-ID: QKMbSYCoMR6y7p-kfvWUZQ_1762223405
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1CAF1956059; Tue,  4 Nov 2025 02:30:05 +0000 (UTC)
Received: from localhost (unknown [10.2.16.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19E4B180045B; Tue,  4 Nov 2025 02:30:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 eblake@redhat.com, Hanna Czenczek <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hibriansong@gmail.com
Subject: [PATCH v6 11/15] aio-posix: unindent fdmon_io_uring_destroy()
Date: Mon,  3 Nov 2025 21:29:29 -0500
Message-ID: <20251104022933.618123-12-stefanha@redhat.com>
In-Reply-To: <20251104022933.618123-1-stefanha@redhat.com>
References: <20251104022933.618123-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reduce the level of indentation to make further code changes easier to
read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v5:
- Add patch to unindent fdmon_io_uring_destroy() [Kevin]
---
 util/fdmon-io_uring.c | 46 ++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index 9f25d6d6db..a06bbe2715 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -395,33 +395,35 @@ bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 
 void fdmon_io_uring_destroy(AioContext *ctx)
 {
-    if (ctx->fdmon_ops == &fdmon_io_uring_ops) {
-        AioHandler *node;
+    AioHandler *node;
 
-        io_uring_queue_exit(&ctx->fdmon_io_uring);
+    if (ctx->fdmon_ops != &fdmon_io_uring_ops) {
+        return;
+    }
 
-        /* Move handlers due to be removed onto the deleted list */
-        while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
-            unsigned flags = qatomic_fetch_and(&node->flags,
-                    ~(FDMON_IO_URING_PENDING |
-                      FDMON_IO_URING_ADD |
-                      FDMON_IO_URING_REMOVE |
-                      FDMON_IO_URING_DELETE_AIO_HANDLER));
+    io_uring_queue_exit(&ctx->fdmon_io_uring);
 
-            if ((flags & FDMON_IO_URING_REMOVE) ||
-                (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
-                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
-                                      node, node_deleted);
-            }
+    /* Move handlers due to be removed onto the deleted list */
+    while ((node = QSLIST_FIRST_RCU(&ctx->submit_list))) {
+        unsigned flags = qatomic_fetch_and(&node->flags,
+                ~(FDMON_IO_URING_PENDING |
+                  FDMON_IO_URING_ADD |
+                  FDMON_IO_URING_REMOVE |
+                  FDMON_IO_URING_DELETE_AIO_HANDLER));
 
-            QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
+        if ((flags & FDMON_IO_URING_REMOVE) ||
+            (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
+            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
+                                  node, node_deleted);
         }
 
-        g_source_remove_unix_fd(&ctx->source, ctx->io_uring_fd_tag);
-        ctx->io_uring_fd_tag = NULL;
-
-        qemu_lockcnt_lock(&ctx->list_lock);
-        fdmon_poll_downgrade(ctx);
-        qemu_lockcnt_unlock(&ctx->list_lock);
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


