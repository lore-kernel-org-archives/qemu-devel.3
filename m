Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BE3C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 00:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSPLw-0000oe-2D; Thu, 19 Jun 2025 20:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLp-0000l1-3X
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:11:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uSPLm-0004t7-9y
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 20:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750378271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2wgGl0241aAcmun6fHKvF/vKOHJKj8YAoZqW4DvBAw=;
 b=L/GB/6fqCRv6FDnNnlVDbOvlHrl+6x9enxZt9WHg/L1rnTkqRu5riEy9M8TqIZs8O6R6G0
 QF7h0LW1fPqAwCf15Q0JshzN7NUHvOOi0cfBOyr9RBqUESq/LokM9wGPZlb1ySkYrGj55U
 13HhCSJeSB2NPZNm1no0emvUjpJ99w8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-hPaIqw8DNYm1J9dMdpY0nQ-1; Thu,
 19 Jun 2025 20:11:10 -0400
X-MC-Unique: hPaIqw8DNYm1J9dMdpY0nQ-1
X-Mimecast-MFC-AGG-ID: hPaIqw8DNYm1J9dMdpY0nQ_1750378268
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAC45180028E; Fri, 20 Jun 2025 00:11:08 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 552B130001BB; Fri, 20 Jun 2025 00:11:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, eblake@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, hibriansong@gmail.com
Subject: [PATCH v2 12/12] block/io_uring: use non-vectored read/write when
 possible
Date: Thu, 19 Jun 2025 20:08:28 -0400
Message-ID: <20250620000829.1426291-13-stefanha@redhat.com>
In-Reply-To: <20250620000829.1426291-1-stefanha@redhat.com>
References: <20250620000829.1426291-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The io_uring_prep_readv2/writev2() man pages recommend using the
non-vectored read/write operations when possible for performance
reasons.

I didn't measure a significant difference but it doesn't hurt to have
this optimization in place.

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io_uring.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/block/io_uring.c b/block/io_uring.c
index dd930ee57e..bbefbddcc0 100644
--- a/block/io_uring.c
+++ b/block/io_uring.c
@@ -49,12 +49,24 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
 #ifdef HAVE_IO_URING_PREP_WRITEV2
     {
         int luring_flags = (flags & BDRV_REQ_FUA) ? RWF_DSYNC : 0;
-        io_uring_prep_writev2(sqe, fd, qiov->iov,
-                              qiov->niov, offset, luring_flags);
+        if (luring_flags != 0 || qiov->niov > 1) {
+            io_uring_prep_writev2(sqe, fd, qiov->iov,
+                                  qiov->niov, offset, luring_flags);
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
+        }
     }
 #else
         assert(flags == 0);
-        io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+        if (qiov->niov > 1) {
+            io_uring_prep_writev(sqe, fd, qiov->iov, qiov->niov, offset);
+        } else {
+            /* The man page says non-vectored is faster than vectored */
+            struct iovec *iov = qiov->iov;
+            io_uring_prep_write(sqe, fd, iov->iov_base, iov->iov_len, offset);
+        }
 #endif
         break;
     case QEMU_AIO_ZONE_APPEND:
@@ -65,8 +77,15 @@ static void luring_prep_sqe(struct io_uring_sqe *sqe, void *opaque)
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
2.49.0


