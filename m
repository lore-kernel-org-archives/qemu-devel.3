Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB381C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 05:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjYRw-0007c0-B6; Mon, 11 Mar 2024 01:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rjYRt-0007bE-ML
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 01:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rjYRr-0002iX-Pa
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 01:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710135822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IEAFON+hr5+n1awEgCwMEXAzM+U05ZCkmeleR6HDrlU=;
 b=HcyWgtO++1EefDyNfHcIKkxNzyeQkAUj0E3y1xld9w/ePhaqWzg22Ngprw3TCn6rpe77dK
 Cwin5Nql9RjxdVpPsQ+6PV2GcBcbo+KMUPCY2sZMZ6ciEbkq87Ut64snXcUy4ooIEmxud6
 F8F9XrB4h2KCnLhxDBxnmtr/2SUSwIA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-NfF8E6MEP6igM5QSH257xA-1; Mon,
 11 Mar 2024 01:43:40 -0400
X-MC-Unique: NfF8E6MEP6igM5QSH257xA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A9D13801F5B;
 Mon, 11 Mar 2024 05:43:40 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E21F2C017A2;
 Mon, 11 Mar 2024 05:43:37 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH v2] linux-aio: add IO_CMD_FDSYNC command support
Date: Mon, 11 Mar 2024 11:13:33 +0530
Message-ID: <20240311054333.1264776-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 block/file-posix.c | 12 ++++++++++++
 block/linux-aio.c  |  5 ++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

v2: if IO_CMD_FDSYNC is not supported by the kernel,
    fallback on thread-pool flush.
  -> https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg01986.html

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..4f2195d01d 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2599,6 +2599,18 @@ static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
     if (raw_check_linux_io_uring(s)) {
         return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH);
     }
+#endif
+#ifdef CONFIG_LINUX_AIO
+    if (raw_check_linux_aio(s)) {
+        ret = laio_co_submit(s->fd, 0, NULL, QEMU_AIO_FLUSH, 0);
+        if (ret >= 0) {
+            /*
+             * if AIO_FLUSH is supported return
+             * else fallback on thread-pool flush.
+             */
+            return ret;
+        }
+    }
 #endif
     return raw_thread_pool_submit(handle_aiocb_flush, &acb);
 }
diff --git a/block/linux-aio.c b/block/linux-aio.c
index ec05d946f3..d940d029e3 100644
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
-- 
2.44.0


