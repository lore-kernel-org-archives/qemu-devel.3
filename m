Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0114C5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx79-0001Mq-Ul; Sun, 03 Mar 2024 20:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx75-0001FB-Lw
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6o-0002Em-9B
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hJGmWnbooz2CMut3kruNHzhEFGJqsD9uISC81AxmzUI=;
 b=A2N5hwQgKQCEZuhfRcTdP8rRxA4B6ZeI6gKfUEiLc/m8vXHY+TwjuZTmJEBMMlxcHN41hA
 XAtG88dt867Bp8ZlELso0pr2jzWJq4YUZ8FHOZmMu9SHcDK5fycfov/mDorltC63CljrEV
 XDfVvCRkEw/9gZ6rdedtP7FKxurNfz8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-re0_uwB9OraZFsKMiXwm6A-1; Sun,
 03 Mar 2024 20:27:09 -0500
X-MC-Unique: re0_uwB9OraZFsKMiXwm6A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF1613814E8D;
 Mon,  4 Mar 2024 01:27:08 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF3F740C6EBA;
 Mon,  4 Mar 2024 01:27:04 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: [PULL 06/27] io: Add generic pwritev/preadv interface
Date: Mon,  4 Mar 2024 09:26:13 +0800
Message-ID: <20240304012634.95520-7-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nikolay Borisov <nborisov@suse.com>

Introduce basic pwritev/preadv support in the generic channel layer.
Specific implementation will follow for the file channel as this is
required in order to support migration streams with fixed location of
each ram page.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel.h | 82 ++++++++++++++++++++++++++++++++++++++++++++
 io/channel.c         | 58 +++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index fcb19fd672..7986c49c71 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -131,6 +131,16 @@ struct QIOChannelClass {
                            Error **errp);
 
     /* Optional callbacks */
+    ssize_t (*io_pwritev)(QIOChannel *ioc,
+                          const struct iovec *iov,
+                          size_t niov,
+                          off_t offset,
+                          Error **errp);
+    ssize_t (*io_preadv)(QIOChannel *ioc,
+                         const struct iovec *iov,
+                         size_t niov,
+                         off_t offset,
+                         Error **errp);
     int (*io_shutdown)(QIOChannel *ioc,
                        QIOChannelShutdown how,
                        Error **errp);
@@ -529,6 +539,78 @@ void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled);
 int qio_channel_close(QIOChannel *ioc,
                       Error **errp);
 
+/**
+ * qio_channel_pwritev
+ * @ioc: the channel object
+ * @iov: the array of memory regions to write data from
+ * @niov: the length of the @iov array
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error. To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ * Behaves as qio_channel_writev_full, apart from not supporting
+ * sending of file handles as well as beginning the write at the
+ * passed @offset
+ *
+ */
+ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp);
+
+/**
+ * qio_channel_pwrite
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error. To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ */
+ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+                           off_t offset, Error **errp);
+
+/**
+ * qio_channel_preadv
+ * @ioc: the channel object
+ * @iov: the array of memory regions to read data into
+ * @niov: the length of the @iov array
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error.  To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ * Behaves as qio_channel_readv_full, apart from not supporting
+ * receiving of file handles as well as beginning the read at the
+ * passed @offset
+ *
+ */
+ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp);
+
+/**
+ * qio_channel_pread
+ * @ioc: the channel object
+ * @buf: the memory region to write data into
+ * @buflen: the number of bytes to @buf
+ * @offset: offset in the channel where writes should begin
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Not all implementations will support this facility, so may report
+ * an error.  To avoid errors, the caller may check for the feature
+ * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
+ *
+ */
+ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+                          off_t offset, Error **errp);
+
 /**
  * qio_channel_shutdown:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 86c5834510..a1f12f8e90 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -454,6 +454,64 @@ GSource *qio_channel_add_watch_source(QIOChannel *ioc,
 }
 
 
+ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
+                            size_t niov, off_t offset, Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_pwritev) {
+        error_setg(errp, "Channel does not support pwritev");
+        return -1;
+    }
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
+        error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
+        return -1;
+    }
+
+    return klass->io_pwritev(ioc, iov, niov, offset, errp);
+}
+
+ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+                           off_t offset, Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_pwritev(ioc, &iov, 1, offset, errp);
+}
+
+ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
+                           size_t niov, off_t offset, Error **errp)
+{
+    QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
+
+    if (!klass->io_preadv) {
+        error_setg(errp, "Channel does not support preadv");
+        return -1;
+    }
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_SEEKABLE)) {
+        error_setg_errno(errp, EINVAL, "Requested channel is not seekable");
+        return -1;
+    }
+
+    return klass->io_preadv(ioc, iov, niov, offset, errp);
+}
+
+ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+                          off_t offset, Error **errp)
+{
+    struct iovec iov = {
+        .iov_base = buf,
+        .iov_len = buflen
+    };
+
+    return qio_channel_preadv(ioc, &iov, 1, offset, errp);
+}
+
 int qio_channel_shutdown(QIOChannel *ioc,
                          QIOChannelShutdown how,
                          Error **errp)
-- 
2.44.0


