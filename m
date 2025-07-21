Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AD6C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 21:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udxpm-0007XF-E7; Mon, 21 Jul 2025 17:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxln-0003xH-4V
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1udxll-0007fq-EJ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 17:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753132196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8eB6zFHnrGGu+GQFNY1p1uC3YsNL6E1fZyhtsLRjF4=;
 b=AEjiEkjik9X8Fh7w098Unr8OsPhDXx6ju09R2kefY9UcR5fHkjvStUej3udyxrssKIgHwj
 Be8H0XnJHDDOgHEM0HD4ypB1sLb37K1Xn6aLxmXQNTKOcBo2YXtntqha3Dpw3UBF+V8IcR
 KnzKszl6kXaAXBTC+NPDSW0mIVxaYjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-zCcJXmJnNNqllVG_EyqGPQ-1; Mon,
 21 Jul 2025 17:09:52 -0400
X-MC-Unique: zCcJXmJnNNqllVG_EyqGPQ-1
X-Mimecast-MFC-AGG-ID: zCcJXmJnNNqllVG_EyqGPQ_1753132191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC7BF1800371; Mon, 21 Jul 2025 21:09:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.31])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E45FF1800D82; Mon, 21 Jul 2025 21:09:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, hibriansong@gmail.com, eblake@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH v3 01/12] aio-posix: fix race between io_uring CQE and
 AioHandler deletion
Date: Mon, 21 Jul 2025 17:07:48 -0400
Message-ID: <20250721210759.179709-2-stefanha@redhat.com>
In-Reply-To: <20250721210759.179709-1-stefanha@redhat.com>
References: <20250721210759.179709-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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

When an AioHandler is enqueued on ctx->submit_list for removal, the
fill_sq_ring() function will submit an io_uring POLL_REMOVE operation to
cancel the in-flight POLL_ADD operation.

There is a race when another thread enqueues an AioHandler for deletion
on ctx->submit_list when the POLL_ADD CQE has already appeared. In that
case POLL_REMOVE is unnecessary. The code already handled this, but
forgot that the AioHandler itself is still on ctx->submit_list when the
POLL_ADD CQE is being processed. It's unsafe to delete the AioHandler at
that point in time (use-after-free).

Solve this problem by keeping the AioHandler alive but setting a flag so
that it will be deleted by fill_sq_ring() when it runs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/fdmon-io_uring.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b0d68bdc44..ad89160f31 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -52,9 +52,10 @@ enum {
     FDMON_IO_URING_ENTRIES  = 128, /* sq/cq ring size */
 
     /* AioHandler::flags */
-    FDMON_IO_URING_PENDING  = (1 << 0),
-    FDMON_IO_URING_ADD      = (1 << 1),
-    FDMON_IO_URING_REMOVE   = (1 << 2),
+    FDMON_IO_URING_PENDING            = (1 << 0),
+    FDMON_IO_URING_ADD                = (1 << 1),
+    FDMON_IO_URING_REMOVE             = (1 << 2),
+    FDMON_IO_URING_DELETE_AIO_HANDLER = (1 << 3),
 };
 
 static inline int poll_events_from_pfd(int pfd_events)
@@ -218,6 +219,16 @@ static void fill_sq_ring(AioContext *ctx)
         if (flags & FDMON_IO_URING_REMOVE) {
             add_poll_remove_sqe(ctx, node);
         }
+        if (flags & FDMON_IO_URING_DELETE_AIO_HANDLER) {
+            /*
+             * process_cqe() sets this flag after ADD and REMOVE have been
+             * cleared. They cannot be set again, so they must be clear.
+             */
+            assert(!(flags & FDMON_IO_URING_ADD));
+            assert(!(flags & FDMON_IO_URING_REMOVE));
+
+            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
+        }
     }
 }
 
@@ -241,7 +252,12 @@ static bool process_cqe(AioContext *ctx,
      */
     flags = qatomic_fetch_and(&node->flags, ~FDMON_IO_URING_REMOVE);
     if (flags & FDMON_IO_URING_REMOVE) {
-        QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
+        if (flags & FDMON_IO_URING_PENDING) {
+            /* Still on ctx->submit_list, defer deletion until fill_sq_ring() */
+            qatomic_or(&node->flags, FDMON_IO_URING_DELETE_AIO_HANDLER);
+        } else {
+            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
+        }
         return false;
     }
 
@@ -347,10 +363,13 @@ void fdmon_io_uring_destroy(AioContext *ctx)
             unsigned flags = qatomic_fetch_and(&node->flags,
                     ~(FDMON_IO_URING_PENDING |
                       FDMON_IO_URING_ADD |
-                      FDMON_IO_URING_REMOVE));
+                      FDMON_IO_URING_REMOVE |
+                      FDMON_IO_URING_DELETE_AIO_HANDLER));
 
-            if (flags & FDMON_IO_URING_REMOVE) {
-                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
+            if ((flags & FDMON_IO_URING_REMOVE) ||
+                (flags & FDMON_IO_URING_DELETE_AIO_HANDLER)) {
+                QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers,
+                                      node, node_deleted);
             }
 
             QSLIST_REMOVE_HEAD_RCU(&ctx->submit_list, node_submitted);
-- 
2.50.1


