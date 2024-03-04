Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A56C5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:28:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7J-0001W2-Tl; Sun, 03 Mar 2024 20:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7F-0001Tt-K9
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx6z-0002Jy-Db
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DesdufDtGYfA1p4c4k9QF7KmvVTn3HtsAA5zhrljpmY=;
 b=JTGZNqVgCrudo8Y8FRSAwtZUKGVAONL78YqqDLyjXzVmNfYvyGYczfVtii9qLl0lhQbwAL
 Seu2U1WGTUH49jud1WC70WsF3yUhTyn5m1JtYC0g4hbb0QCGD/4FIV3qer2ZNlGVHyigiC
 dnz0OsVf5xHwRsI2tB6qwE262+BZJB0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-LwlqkKlyO96hOEFGNFQbzg-1; Sun,
 03 Mar 2024 20:27:21 -0500
X-MC-Unique: LwlqkKlyO96hOEFGNFQbzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FBED29ABA08;
 Mon,  4 Mar 2024 01:27:21 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6183B40C6EBA;
 Mon,  4 Mar 2024 01:27:18 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 09/27] migration/qemu-file: add utility methods for working
 with seekable channels
Date: Mon,  4 Mar 2024 09:26:16 +0800
Message-ID: <20240304012634.95520-10-peterx@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

Add utility methods that will be needed when implementing 'mapped-ram'
migration capability.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Link: https://lore.kernel.org/r/20240229153017.2221-7-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/qemu-file-types.h |   2 +
 migration/qemu-file.h               |   6 ++
 migration/qemu-file.c               | 106 ++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index 9ba163f333..adec5abc07 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -50,6 +50,8 @@ unsigned int qemu_get_be16(QEMUFile *f);
 unsigned int qemu_get_be32(QEMUFile *f);
 uint64_t qemu_get_be64(QEMUFile *f);
 
+bool qemu_file_is_seekable(QEMUFile *f);
+
 static inline void qemu_put_be64s(QEMUFile *f, const uint64_t *pv)
 {
     qemu_put_be64(f, *pv);
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 8aec9fabf7..32fd4a34fd 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -75,6 +75,12 @@ QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 int qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
+void qemu_set_offset(QEMUFile *f, off_t off, int whence);
+off_t qemu_get_offset(QEMUFile *f);
+void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                        off_t pos);
+size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                          off_t pos);
 
 QIOChannel *qemu_file_get_ioc(QEMUFile *file);
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 94231ff295..b10c882629 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -33,6 +33,7 @@
 #include "options.h"
 #include "qapi/error.h"
 #include "rdma.h"
+#include "io/channel-file.h"
 
 #define IO_BUF_SIZE 32768
 #define MAX_IOV_SIZE MIN_CONST(IOV_MAX, 64)
@@ -255,6 +256,10 @@ static void qemu_iovec_release_ram(QEMUFile *f)
     memset(f->may_free, 0, sizeof(f->may_free));
 }
 
+bool qemu_file_is_seekable(QEMUFile *f)
+{
+    return qio_channel_has_feature(f->ioc, QIO_CHANNEL_FEATURE_SEEKABLE);
+}
 
 /**
  * Flushes QEMUFile buffer
@@ -447,6 +452,107 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
     }
 }
 
+void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                        off_t pos)
+{
+    Error *err = NULL;
+    size_t ret;
+
+    if (f->last_error) {
+        return;
+    }
+
+    qemu_fflush(f);
+    ret = qio_channel_pwrite(f->ioc, (char *)buf, buflen, pos, &err);
+
+    if (err) {
+        qemu_file_set_error_obj(f, -EIO, err);
+        return;
+    }
+
+    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
+        qemu_file_set_error_obj(f, -EAGAIN, NULL);
+        return;
+    }
+
+    if (ret != buflen) {
+        error_setg(&err, "Partial write of size %zu, expected %zu", ret,
+                   buflen);
+        qemu_file_set_error_obj(f, -EIO, err);
+        return;
+    }
+
+    stat64_add(&mig_stats.qemu_file_transferred, buflen);
+
+    return;
+}
+
+
+size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
+                          off_t pos)
+{
+    Error *err = NULL;
+    size_t ret;
+
+    if (f->last_error) {
+        return 0;
+    }
+
+    ret = qio_channel_pread(f->ioc, (char *)buf, buflen, pos, &err);
+
+    if ((ssize_t)ret == -1 || err) {
+        qemu_file_set_error_obj(f, -EIO, err);
+        return 0;
+    }
+
+    if ((ssize_t)ret == QIO_CHANNEL_ERR_BLOCK) {
+        qemu_file_set_error_obj(f, -EAGAIN, NULL);
+        return 0;
+    }
+
+    if (ret != buflen) {
+        error_setg(&err, "Partial read of size %zu, expected %zu", ret, buflen);
+        qemu_file_set_error_obj(f, -EIO, err);
+        return 0;
+    }
+
+    return ret;
+}
+
+void qemu_set_offset(QEMUFile *f, off_t off, int whence)
+{
+    Error *err = NULL;
+    off_t ret;
+
+    if (qemu_file_is_writable(f)) {
+        qemu_fflush(f);
+    } else {
+        /* Drop all cached buffers if existed; will trigger a re-fill later */
+        f->buf_index = 0;
+        f->buf_size = 0;
+    }
+
+    ret = qio_channel_io_seek(f->ioc, off, whence, &err);
+    if (ret == (off_t)-1) {
+        qemu_file_set_error_obj(f, -EIO, err);
+    }
+}
+
+off_t qemu_get_offset(QEMUFile *f)
+{
+    Error *err = NULL;
+    off_t ret;
+
+    qemu_fflush(f);
+
+    ret = qio_channel_io_seek(f->ioc, 0, SEEK_CUR, &err);
+    if (ret == (off_t)-1) {
+        qemu_file_set_error_obj(f, -EIO, err);
+    }
+    return ret;
+}
+
+
 void qemu_put_byte(QEMUFile *f, int v)
 {
     if (f->last_error) {
-- 
2.44.0


