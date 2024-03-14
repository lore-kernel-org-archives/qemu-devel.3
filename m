Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5B7C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 11:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkj4p-0004Vc-Vt; Thu, 14 Mar 2024 07:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkj4k-0004Uv-Vm
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rkj4h-0003KU-L7
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 07:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710414998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=cdX6ov4AtD+Ch6QCrlz5w4MVVmmUapIHlamKpnx3uuk=;
 b=clPcUmtxUWPwrtRxBwh2Oh/uUlBpskYUk0eR3OgnYcipSfy95eOkK2c5LG8N3eaJZ5Ne1V
 ucGAOunQUxZWkH3D8X8/zYbfnAqcs5spk7A5PSDBTrhpJmIn68cSsv34hcRPP1VEt0L2Ur
 jNhYkmi13TnqvwEpZdAb89ROsQLluXM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-rIqjPqmOOR6NkcT4-KWkqQ-1; Thu, 14 Mar 2024 07:16:36 -0400
X-MC-Unique: rIqjPqmOOR6NkcT4-KWkqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F392800264;
 Thu, 14 Mar 2024 11:16:36 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5AEE111E3F3;
 Thu, 14 Mar 2024 11:16:33 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: stefanha@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 mtosatti@redhat.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v4] linux-aio: add IO_CMD_FDSYNC command support
Date: Thu, 14 Mar 2024 16:46:28 +0530
Message-ID: <20240314111628.1508636-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
disk storage.

Enable linux-aio to submit such aio request. This helps to
reduce latency induced via pthread_create calls by
thread-pool (aio=threads).

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 block/file-posix.c      |  7 +++++++
 block/linux-aio.c       | 21 ++++++++++++++++++++-
 include/block/raw-aio.h |  1 +
 3 files changed, 28 insertions(+), 1 deletion(-)

v4: New boolean field to indicate if aio_fdsync is available or not.
    It is set at file open time and checked before AIO_FLUSH call.
  - https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg03701.html

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..78a8cea03b 100644
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
@@ -718,6 +719,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
         ret = -EINVAL;
         goto fail;
     }
+    s->has_laio_fdsync = laio_has_fdsync(s->fd);
 #else
     if (s->use_linux_aio) {
         error_setg(errp, "aio=native was specified, but is not supported "
@@ -2599,6 +2601,11 @@ static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
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
-- 
2.44.0


