Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F76C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVZj-0001zI-Mb; Wed, 26 Mar 2025 14:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txVZg-0001xx-RB
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:34:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1txVZc-0003Uh-St
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 14:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743014033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2LwDGoefYs4dtuMbGxSdhyMxKOv3aYPw7i40OKBxVw=;
 b=She9SF7HOQtN7USM/zNG+BV4surlssMLj0IcRrDknmrVmEpbwwDrveOYDDcaEKltmjQYJC
 3NodPP8tKM/P66wFnZCX7wFxTNOWLEJqRIjQmUhw530/ICiObfNX6wNY7gzlkXKOd2EkGT
 diEoaQw/DhrCAHPi2m4/jlZ7EPjk0Ss=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-rQCIxpsaOh6_4okITr1sfw-1; Wed,
 26 Mar 2025 14:33:48 -0400
X-MC-Unique: rQCIxpsaOh6_4okITr1sfw-1
X-Mimecast-MFC-AGG-ID: rQCIxpsaOh6_4okITr1sfw_1743014027
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 720E7180035C; Wed, 26 Mar 2025 18:33:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A522619541A5; Wed, 26 Mar 2025 18:33:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 1/4] aio-posix: fix polling mode with fdmon-io_uring
Date: Wed, 26 Mar 2025 14:33:37 -0400
Message-ID: <20250326183340.1010531-2-stefanha@redhat.com>
In-Reply-To: <20250326183340.1010531-1-stefanha@redhat.com>
References: <20250326183340.1010531-1-stefanha@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The io_uring(7) file descriptor monitor cannot enter polling mode
because it needs to submit a POLL_ADD SQE every time a file descriptor
becomes active. Submitting SQEs only happens in FDMonOps->wait() outside
of polling mode.

Fix this using the multi-shot mechanism introduced in Linux 5.13 and
liburing 2.1. Stable and enterprise Linux distros ship 5.14+ as of March
2025, so it is safe to require this. Note that fdmon-io_uring is
currently not enabled at runtime and is not essential, so QEMU can still
be built without it on older hosts.

In multi-shot mode, a POLL_ADD SQE remains active until canceled with
POLL_REMOVE. This avoids the need to submit a new SQE every time a file
descriptor becomes active.

When POLL_REMOVE is processed by the host kernel, the multi-shot
POLL_ADD operation completes with -ECANCELED. Adjust the code slightly
to take this into account.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build           |  2 +-
 util/fdmon-io_uring.c | 34 +++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/meson.build b/meson.build
index 41f68d3806..9f5f31ac46 100644
--- a/meson.build
+++ b/meson.build
@@ -1144,7 +1144,7 @@ linux_io_uring_test = '''
 
 linux_io_uring = not_found
 if not get_option('linux_io_uring').auto() or have_block
-  linux_io_uring = dependency('liburing', version: '>=0.3',
+  linux_io_uring = dependency('liburing', version: '>=2.1',
                               required: get_option('linux_io_uring'),
                               method: 'pkg-config')
   if not cc.links(linux_io_uring_test)
diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b0d68bdc44..6cd665e565 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -124,8 +124,7 @@ static AioHandler *dequeue(AioHandlerSList *head, unsigned *flags)
     /*
      * Don't clear FDMON_IO_URING_REMOVE.  It's sticky so it can serve two
      * purposes: telling fill_sq_ring() to submit IORING_OP_POLL_REMOVE and
-     * telling process_cqe() to delete the AioHandler when its
-     * IORING_OP_POLL_ADD completes.
+     * telling process_cqe() to ignore IORING_OP_POLL_ADD completions.
      */
     *flags = qatomic_fetch_and(&node->flags, ~(FDMON_IO_URING_PENDING |
                                               FDMON_IO_URING_ADD));
@@ -166,12 +165,12 @@ static void fdmon_io_uring_update(AioContext *ctx,
     }
 }
 
-static void add_poll_add_sqe(AioContext *ctx, AioHandler *node)
+static void add_poll_multishot_sqe(AioContext *ctx, AioHandler *node)
 {
     struct io_uring_sqe *sqe = get_sqe(ctx);
     int events = poll_events_from_pfd(node->pfd.events);
 
-    io_uring_prep_poll_add(sqe, node->pfd.fd, events);
+    io_uring_prep_poll_multishot(sqe, node->pfd.fd, events);
     io_uring_sqe_set_data(sqe, node);
 }
 
@@ -213,7 +212,7 @@ static void fill_sq_ring(AioContext *ctx)
     while ((node = dequeue(&submit_list, &flags))) {
         /* Order matters, just in case both flags were set */
         if (flags & FDMON_IO_URING_ADD) {
-            add_poll_add_sqe(ctx, node);
+            add_poll_multishot_sqe(ctx, node);
         }
         if (flags & FDMON_IO_URING_REMOVE) {
             add_poll_remove_sqe(ctx, node);
@@ -234,21 +233,30 @@ static bool process_cqe(AioContext *ctx,
         return false;
     }
 
+    flags = qatomic_read(&node->flags);
+
     /*
-     * Deletion can only happen when IORING_OP_POLL_ADD completes.  If we race
-     * with enqueue() here then we can safely clear the FDMON_IO_URING_REMOVE
-     * bit before IORING_OP_POLL_REMOVE is submitted.
+     * poll_multishot cancelled by poll_remove? Or completed early because fd
+     * was closed before poll_remove finished?
      */
-    flags = qatomic_fetch_and(&node->flags, ~FDMON_IO_URING_REMOVE);
-    if (flags & FDMON_IO_URING_REMOVE) {
+    if (cqe->res == -ECANCELED || cqe->res == -EBADF) {
+        assert(!(cqe->flags & IORING_CQE_F_MORE));
+        assert(flags & FDMON_IO_URING_REMOVE);
         QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
         return false;
     }
 
-    aio_add_ready_handler(ready_list, node, pfd_events_from_poll(cqe->res));
+    /* Ignore if it becomes ready during removal */
+    if (flags & FDMON_IO_URING_REMOVE) {
+        return false;
+    }
 
-    /* IORING_OP_POLL_ADD is one-shot so we must re-arm it */
-    add_poll_add_sqe(ctx, node);
+    /* Multi-shot can stop at any time, so re-arm if necessary */
+    if (!(cqe->flags & IORING_CQE_F_MORE)) {
+        add_poll_multishot_sqe(ctx, node);
+    }
+
+    aio_add_ready_handler(ready_list, node, pfd_events_from_poll(cqe->res));
     return true;
 }
 
-- 
2.49.0


