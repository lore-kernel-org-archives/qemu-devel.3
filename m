Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E574DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx6u-0001ET-Qy; Sun, 03 Mar 2024 20:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6t-0001E5-4m
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6r-0002Ev-It
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BsTsSZj0lyl+eM84vQxVcYu/bCjr0mDEg/MlpEYR7ts=;
 b=Bb6SDdtcOp0VEz8/Jwm4y6huF/xrWeYuhJEKHahnP7y0wO0nCm3VKnqRXDNUajKT5dWQjQ
 JZoBc8neOSofbpCkqWRJG5jxDFwqhRXUv4ItMfqmjLx6HA0K0o6W9zlBaJoovQy93UrWKx
 Q3TtycreEEivZbB9iMF5nIgX1xt/gFA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Ywm8vJiXNqKD4p9LGfX6SA-1; Sun,
 03 Mar 2024 20:27:13 -0500
X-MC-Unique: Ywm8vJiXNqKD4p9LGfX6SA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 606631C0512A;
 Mon,  4 Mar 2024 01:27:13 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F46640C6EBA;
 Mon,  4 Mar 2024 01:27:09 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [PULL 07/27] io: implement io_pwritev/preadv for QIOChannelFile
Date: Mon,  4 Mar 2024 09:26:14 +0800
Message-ID: <20240304012634.95520-8-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nikolay Borisov <nborisov@suse.com>

The upcoming 'mapped-ram' feature will require qemu to write data to
(and restore from) specific offsets of the migration file.

Add a minimal implementation of pwritev/preadv and expose them via the
io_pwritev and io_preadv interfaces.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-5-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 io/channel-file.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index f91bf6db1c..a6ad7770c6 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -146,6 +146,58 @@ static ssize_t qio_channel_file_writev(QIOChannel *ioc,
     return ret;
 }
 
+#ifdef CONFIG_PREADV
+static ssize_t qio_channel_file_preadv(QIOChannel *ioc,
+                                       const struct iovec *iov,
+                                       size_t niov,
+                                       off_t offset,
+                                       Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    ssize_t ret;
+
+ retry:
+    ret = preadv(fioc->fd, iov, niov, offset);
+    if (ret < 0) {
+        if (errno == EAGAIN) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
+        if (errno == EINTR) {
+            goto retry;
+        }
+
+        error_setg_errno(errp, errno, "Unable to read from file");
+        return -1;
+    }
+
+    return ret;
+}
+
+static ssize_t qio_channel_file_pwritev(QIOChannel *ioc,
+                                        const struct iovec *iov,
+                                        size_t niov,
+                                        off_t offset,
+                                        Error **errp)
+{
+    QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
+    ssize_t ret;
+
+ retry:
+    ret = pwritev(fioc->fd, iov, niov, offset);
+    if (ret <= 0) {
+        if (errno == EAGAIN) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
+        if (errno == EINTR) {
+            goto retry;
+        }
+        error_setg_errno(errp, errno, "Unable to write to file");
+        return -1;
+    }
+    return ret;
+}
+#endif /* CONFIG_PREADV */
+
 static int qio_channel_file_set_blocking(QIOChannel *ioc,
                                          bool enabled,
                                          Error **errp)
@@ -231,6 +283,10 @@ static void qio_channel_file_class_init(ObjectClass *klass,
     ioc_klass->io_writev = qio_channel_file_writev;
     ioc_klass->io_readv = qio_channel_file_readv;
     ioc_klass->io_set_blocking = qio_channel_file_set_blocking;
+#ifdef CONFIG_PREADV
+    ioc_klass->io_pwritev = qio_channel_file_pwritev;
+    ioc_klass->io_preadv = qio_channel_file_preadv;
+#endif
     ioc_klass->io_seek = qio_channel_file_seek;
     ioc_klass->io_close = qio_channel_file_close;
     ioc_klass->io_create_watch = qio_channel_file_create_watch;
-- 
2.44.0


