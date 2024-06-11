Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD23C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5Qw-00008h-9I; Tue, 11 Jun 2024 13:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qu-00007f-P9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qt-0008Ul-2K
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718127438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pic+NTGR2xDZGvJdSIIWUg6ye59mZnjGjver02Rud84=;
 b=JNBSZ6KpPTXcX2sYEBJ7C9irFR3XhyG3rWxJ2d5TGAVjEDgK+yYs35rHY9pIKFIwNyDNaN
 6f/UEoFOMg38Q87ZIMVuhiZ8EYBCO7c/rteAI1lZgD+95vQuQrLQDzAVu+uZYu9NfBbLZP
 8TrwoC51hthba4SI6uUgHdvJ6ZY1v/U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-FUDJC3w9OQaijwwYgsIhrA-1; Tue,
 11 Jun 2024 13:37:16 -0400
X-MC-Unique: FUDJC3w9OQaijwwYgsIhrA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEA7A19560BC; Tue, 11 Jun 2024 17:37:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.130])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B38B19560AF; Tue, 11 Jun 2024 17:37:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 6/8] linux-aio: add IO_CMD_FDSYNC command support
Date: Tue, 11 Jun 2024 19:36:56 +0200
Message-ID: <20240611173658.231831-7-kwolf@redhat.com>
In-Reply-To: <20240611173658.231831-1-kwolf@redhat.com>
References: <20240611173658.231831-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Prasad Pandit <pjp@fedoraproject.org>

Libaio defines IO_CMD_FDSYNC command to sync all outstanding
asynchronous I/O operations, by flushing out file data to the
disk storage. Enable linux-aio to submit such aio request.

When using aio=native without fdsync() support, QEMU creates
pthreads, and destroying these pthreads results in TLB flushes.
In a real-time guest environment, TLB flushes cause a latency
spike. This patch helps to avoid such spikes.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Message-ID: <20240425070412.37248-1-ppandit@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/raw-aio.h |  1 +
 block/file-posix.c      |  9 +++++++++
 block/linux-aio.c       | 21 ++++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 20e000b8ef..626706827f 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -60,6 +60,7 @@ void laio_cleanup(LinuxAioState *s);
 int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
                                 int type, uint64_t dev_max_batch);
 
+bool laio_has_fdsync(int);
 void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context);
 void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
 #endif
diff --git a/block/file-posix.c b/block/file-posix.c
index 5c46938936..be25e35ff6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -159,6 +159,7 @@ typedef struct BDRVRawState {
     bool has_discard:1;
     bool has_write_zeroes:1;
     bool use_linux_aio:1;
+    bool has_laio_fdsync:1;
     bool use_linux_io_uring:1;
     int page_cache_inconsistent; /* errno from fdatasync failure */
     bool has_fallocate;
@@ -718,6 +719,9 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         ret = -EINVAL;
         goto fail;
     }
+    if (s->use_linux_aio) {
+        s->has_laio_fdsync = laio_has_fdsync(s->fd);
+    }
 #else
     if (s->use_linux_aio) {
         error_setg(errp, "aio=native was specified, but is not supported "
@@ -2598,6 +2602,11 @@ static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
     if (raw_check_linux_io_uring(s)) {
         return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH);
     }
+#endif
+#ifdef CONFIG_LINUX_AIO
+    if (s->has_laio_fdsync && raw_check_linux_aio(s)) {
+        return laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
+    }
 #endif
     return raw_thread_pool_submit(handle_aiocb_flush, &acb);
 }
diff --git a/block/linux-aio.c b/block/linux-aio.c
index ec05d946f3..e3b5ec9aba 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -384,6 +384,9 @@ static int laio_do_submit(int fd, struct qemu_laiocb *laiocb, off_t offset,
     case QEMU_AIO_READ:
         io_prep_preadv(iocbs, fd, qiov->iov, qiov->niov, offset);
         break;
+    case QEMU_AIO_FLUSH:
+        io_prep_fdsync(iocbs, fd);
+        break;
     /* Currently Linux kernel does not support other operations */
     default:
         fprintf(stderr, "%s: invalid AIO request type 0x%x.\n",
@@ -412,7 +415,7 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
     AioContext *ctx = qemu_get_current_aio_context();
     struct qemu_laiocb laiocb = {
         .co         = qemu_coroutine_self(),
-        .nbytes     = qiov->size,
+        .nbytes     = qiov ? qiov->size : 0,
         .ctx        = aio_get_linux_aio(ctx),
         .ret        = -EINPROGRESS,
         .is_read    = (type == QEMU_AIO_READ),
@@ -486,3 +489,19 @@ void laio_cleanup(LinuxAioState *s)
     }
     g_free(s);
 }
+
+bool laio_has_fdsync(int fd)
+{
+    struct iocb cb;
+    struct iocb *cbs[] = {&cb, NULL};
+
+    io_context_t ctx = 0;
+    io_setup(1, &ctx);
+
+    /* check if host kernel supports IO_CMD_FDSYNC */
+    io_prep_fdsync(&cb, fd);
+    int ret = io_submit(ctx, 1, cbs);
+
+    io_destroy(ctx);
+    return (ret == -EINVAL) ? false : true;
+}
-- 
2.45.2


