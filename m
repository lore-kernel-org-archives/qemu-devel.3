Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AA2CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 20:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vECtl-0003ea-L4; Wed, 29 Oct 2025 16:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vECtJ-0003WW-3k
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vECsd-00056r-Fm
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 16:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761770078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rKD06Zh1LimJCOg8P85Zg613TQFXlBfxg67E/SB0OO8=;
 b=X1cxgWV1PenxENC5KvJEnOZzdAQ5tlwEvdvFNsOX+17wbbP1AprL5D4zST1M2FTwOWVKhf
 ZCHGeCM1WHSbPlB96hn4s12+zX+luWI2kP1jXHA5PumrATQfeTR9aywpyWPhV31Exvs+x4
 Qt9qsZDA5NVknlyP0F5R8NAMnKPpasI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-zJhVoI3SO7eTlRHNzUb47g-1; Wed,
 29 Oct 2025 16:34:33 -0400
X-MC-Unique: zJhVoI3SO7eTlRHNzUb47g-1
X-Mimecast-MFC-AGG-ID: zJhVoI3SO7eTlRHNzUb47g_1761770072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 915E71800D82; Wed, 29 Oct 2025 20:34:32 +0000 (UTC)
Received: from localhost (unknown [10.2.17.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7E8F180057C; Wed, 29 Oct 2025 20:34:31 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com,
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 eblake@redhat.com
Subject: [PATCH v5 09/12] aio-posix: unindent fdmon_io_uring_destroy()
Date: Wed, 29 Oct 2025 16:34:08 -0400
Message-ID: <20251029203411.445852-10-stefanha@redhat.com>
In-Reply-To: <20251029203411.445852-1-stefanha@redhat.com>
References: <20251029203411.445852-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index 730c1ee205..663e95d777 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -391,33 +391,35 @@ bool fdmon_io_uring_setup(AioContext *ctx, Error **errp)
 
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
2.51.0


