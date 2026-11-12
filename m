Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBE606A888
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=RX3eFSxC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZnj-000637-QP; Thu, 12 Nov 2026 13:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnW-0005sN-Jz; Thu, 12 Nov 2026 13:45:26 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xRZnS-0002x5-2n; Thu, 12 Nov 2026 13:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794509113; bh=5vORwUTmtvipn8W+vUnwryE3Vwbp+Mdvx5IYBvD/3gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RX3eFSxCvO7AM+FJ8f2cwcGpTIyMS9zMsJrfRNgn27pv1T5QANAK69mKw02Cr4DDM
 8CnhRiIUDIArQJCVdbWYxnCuwGCYkxJ/nEVqCsEWL4FXaPeuMVSz8ydSNw7oRDAJGl
 7KqmgWQ8LvY1Bgzhy2ri51G6ry946GH5+sN2CvzwogzsjFVSQXE+ye6tN+SX909Rhi
 SDcILydlI4tYRN5dnJx1eRNmQRvMdM2xCEdUAWo7Bu1QskRKnD240qLYCbvR4K19Uz
 hdkUdddzQpiilxPwPhaFNQIi5S3vEvfkpevJsf/AWnqMwWSFsEocRyugJLP19Y2snp
 jmkdQlAuWUWAg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E93F1E5D1C;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6AC2245AAD6;
 Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4EDDFB7C4E; Thu, 12 Nov 2026 21:45:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/6] io: avoid potential double close of qio_channel_file's fd
Date: Thu, 12 Nov 2026 21:45:04 +0300
Message-ID: <20261112184513.2324634-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112184513.2324634-1-mjt@tls.msk.ru>
References: <20261112184513.2324634-1-mjt@tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Filip Hejsek <filip.hejsek@gmail.com>

Make qio_channel_file_close() set fd to -1 even if qemu_close() returns
an error so that qio_channel_file_finalize() doesn't call close again.

On Linux, close() always closes the fd, even when it returns an error.
Because the fd can be reused after it is closed, the close must not
be retried.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 io/channel-file.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 4c9da6619b9..2487adaea2a 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -261,12 +261,24 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
-    if (qemu_close(fioc->fd) < 0) {
+    int ret = qemu_close(fioc->fd);
+    /*
+     * Set fioc->fd to -1, to prevent qio_channel_file_finalize() from
+     * closing it again.
+     *
+     * POSIX.1-2024 specifies that the fd is closed even when close()
+     * returns an error, except when the error is EINTR.  The systems that
+     * QEMU supports however violate the standard and always close the fd,
+     * even when returning EINTR.  If the fd was actually closed, we must not
+     * try to close it a second time as we could accidentally close someone
+     * else's fd. 
+     */
+    fioc->fd = -1;
+    if (ret < 0) {
         error_setg_errno(errp, errno,
-                         "Unable to close file");
+                         "Got an error while closing file");
         return -1;
     }
-    fioc->fd = -1;
     return 0;
 }
 
-- 
2.47.3


