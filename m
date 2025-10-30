Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBA7CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUTe-0004YP-1O; Thu, 30 Oct 2025 11:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUTc-0004Wk-5K
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vEUTQ-0006R2-6i
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761837716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yh1cuy3K5qp2VDozwEZVvxqT8cIWctTXI1C9JRyj4wk=;
 b=QLek+Rhdaym7W6HMnFQrKeSrEV5KQYOiNcFkHK5UztGKPoh5GWRGryvnFu25/oOFTjC4hM
 UWSLtM2OFWHYShwqIeBbEKMoHWIbsc5O3ZxQxcjedGsDiAQO7KEVikHJidK0xkjyDGcup5
 /7l+rG4M5xGx+B5Q2zj0sDVjP+G4cAM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-FqVWffv4MUuDavsgGR2xAQ-1; Thu,
 30 Oct 2025 11:21:54 -0400
X-MC-Unique: FqVWffv4MUuDavsgGR2xAQ-1
X-Mimecast-MFC-AGG-ID: FqVWffv4MUuDavsgGR2xAQ_1761837713
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 785F61956058; Thu, 30 Oct 2025 15:21:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.94])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8A3B180029A; Thu, 30 Oct 2025 15:21:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 hibriansong@gmail.com, eblake@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Subject: [RESEND PATCH v5 01/13] aio-posix: fix race between io_uring CQE and
 AioHandler deletion
Date: Thu, 30 Oct 2025 11:21:37 -0400
Message-ID: <20251030152150.470170-2-stefanha@redhat.com>
In-Reply-To: <20251030152150.470170-1-stefanha@redhat.com>
References: <20251030152150.470170-1-stefanha@redhat.com>
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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


