Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66D7CCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzo-0007gJ-Dw; Tue, 11 Nov 2025 16:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzg-0007QX-Rs
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzf-0001vc-AH
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTY5t+mi42Og4AXvn+4mUT3pJyYT+KoDFmfS0kG2Pro=;
 b=JcBE/Z5ZwzT9Ffc0AKUcex4gJT4qO5tetM2Yw66rmUqajCnwPrXIzHRNsCpeg2OgIHD6Xw
 4lqERnIAy550lMME433/UaN/Q/bnx5clE7NvVQMb4N8GeeDiyxKSktv8WqVRz7h8+KR/TQ
 RbGJNPbzFNEyNCuFDFqAzmErCv9SgiQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-I29Pz94mMCelgrQOSLk2eg-1; Tue,
 11 Nov 2025 16:33:35 -0500
X-MC-Unique: I29Pz94mMCelgrQOSLk2eg-1
X-Mimecast-MFC-AGG-ID: I29Pz94mMCelgrQOSLk2eg_1762896814
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 084BA1800358; Tue, 11 Nov 2025 21:33:34 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F8B330044E0; Tue, 11 Nov 2025 21:33:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 15/28] block/io_uring: use non-vectored read/write when
 possible
Date: Tue, 11 Nov 2025 22:32:25 +0100
Message-ID: <20251111213238.181992-16-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The io_uring_prep_readv2/writev2() man pages recommend using the
non-vectored read/write operations when possible for performance
reasons.

I didn't measure a significant difference but it doesn't hurt to have
this optimization in place.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251104022933.618123-16-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io_uring.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index dd930ee57e..f1514cf024 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -46,17 +46,28 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
 
     switch (req->type) {
     case QEMU_AIO_WRITE:
-#ifdef HAVE_IO_URING_PREP_WRITEV2
     {
         int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
-        io_uring_prep_writev2(sqe, fd, qiov->iov,
-                              qiov->niov, offset, luring_flags);
-    }
+        if (luring_flags != 0 || qiov->niov > 1) {
+#ifdef HAVE_IO_URING_PREP_WRITEV2
+            io_uring_prep_writev2(sqe, fd, qiov->iov,
+                                  qiov->niov, offset, luring_flags);
 #else
-        assert(flags == 0);
-        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+            /*
+             * FUA should only be enabled with HAVE_IO_URING_PREP_WRITEV2, see
+             * luring_has_fua().
+             */
+            assert(luring_flags == 0);
+
+            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
 #endif
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
+        }
         break;
+    }
     case QEMU_AIO_ZONE_APPEND:
         io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
         break;
@@ -65,8 +76,15 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
         if (req->resubmit_qiov.iov != NULL) {
             qiov = &req->resubmit_qiov;
         }
-        io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
-                            offset + req->total_read);
+        if (qiov->niov > 1) {
+            io_uring_prep_readv(sqe, fd, qiov->iov, qiov->niov,
+                                offset + req->total_read);
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_read(sqe, fd, iov->iov_base, iov->iov_len,
+                               offset + req->total_read);
+        }
         break;
     }
     case QEMU_AIO_FLUSH:
-- 
2.51.1


