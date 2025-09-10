Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EADCA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 18:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwPDc-00043Y-VN; Wed, 10 Sep 2025 14:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDX-0003gi-69
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uwPDQ-000538-RB
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 14:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757527601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uq/ffucX0LrsPavRUjZZ8ksU3DGad+yaH3VgAUHZsZo=;
 b=fSKjbcwwn41cSTCRnBzJ6qlXFtFq9LHLG6tl653IFKzKSvTfkwN7rW1O8khDcFDLUh53Zq
 wGevrc95sB+hTNFwX10D1g0A9CwgAhLvxBUvFj6PYOM7jqGN4CrDjg/qq2BcWJgGW/tIRd
 vZ5fCTzhylr+H2NRzoUVUzEW2ytMFfo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-xmhrZunnO8WCF9k4-hZkpQ-1; Wed,
 10 Sep 2025 14:06:40 -0400
X-MC-Unique: xmhrZunnO8WCF9k4-hZkpQ-1
X-Mimecast-MFC-AGG-ID: xmhrZunnO8WCF9k4-hZkpQ_1757527599
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 850DC195608D; Wed, 10 Sep 2025 18:06:39 +0000 (UTC)
Received: from localhost (unknown [10.2.17.66])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA66319560AB; Wed, 10 Sep 2025 18:06:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, hibriansong@gmail.com, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 01/12] aio-posix: fix race between io_uring CQE and
 AioHandler deletion
Date: Wed, 10 Sep 2025 13:56:52 -0400
Message-ID: <20250910175703.374499-2-stefanha@redhat.com>
In-Reply-To: <20250910175703.374499-1-stefanha@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.51.0


