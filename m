Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AEBCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFulM-0005J7-QR; Mon, 03 Nov 2025 08:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulL-0005IT-LG
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFulE-0004O7-Nm
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSSIy3EiM2AVloR1JXFub00eTZguXOQQn8qfl7WQFB0=;
 b=M/VVFQNyO+7BwKBUjRWzz9JcoNoVNzQqyuvds845EJFGSM5t3I+7P/d1v91eazkBL4lpZI
 VLnmJafig85k15O1tRyi6uL8k8Xz9XR6oocekPclva5COZXCOYRg7ormgUz2p8D7MgM6Au
 QeicIKrgVQYq1/xPKqYqStBN7SaDNRU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-2SOzGpWqOImXZ8oxiIxnTw-1; Mon,
 03 Nov 2025 08:38:10 -0500
X-MC-Unique: 2SOzGpWqOImXZ8oxiIxnTw-1
X-Mimecast-MFC-AGG-ID: 2SOzGpWqOImXZ8oxiIxnTw_1762177089
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 151AE1956063; Mon,  3 Nov 2025 13:38:09 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 960621800576; Mon,  3 Nov 2025 13:38:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 04/32] io/channel: Have read/write functions take void * buffer
 argument
Date: Mon,  3 Nov 2025 13:36:58 +0000
Message-ID: <20251103133727.423041-5-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

I/O channel read/write functions can operate on any area of
memory, regardless of the content their represent. Do not
restrict to array of char, use the void* type, which is also
the type of the underlying iovec::iov_base field.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[DB: also adapt test-crypto-tlssession.c func signatures]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/crypto/tlssession.h         |  4 ++--
 include/io/channel.h                | 14 +++++++-------
 io/channel-tls.c                    |  4 ++--
 io/channel.c                        | 14 +++++++-------
 tests/unit/test-crypto-tlssession.c |  4 ++--
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 2e9fe11cf6..28e419681e 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -199,11 +199,11 @@ int qcrypto_tls_session_check_credentials(QCryptoTLSSession *sess,
  * These must return QCRYPTO_TLS_SESSION_ERR_BLOCK if the I/O
  * would block, but on other errors, must fill 'errp'
  */
-typedef ssize_t (*QCryptoTLSSessionWriteFunc)(const char *buf,
+typedef ssize_t (*QCryptoTLSSessionWriteFunc)(const void *buf,
                                               size_t len,
                                               void *opaque,
                                               Error **errp);
-typedef ssize_t (*QCryptoTLSSessionReadFunc)(char *buf,
+typedef ssize_t (*QCryptoTLSSessionReadFunc)(void *buf,
                                              size_t len,
                                              void *opaque,
                                              Error **errp);
diff --git a/include/io/channel.h b/include/io/channel.h
index 0f25ae0069..db893a3628 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -437,7 +437,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
  * a single memory region.
  */
 ssize_t qio_channel_read(QIOChannel *ioc,
-                         char *buf,
+                         void *buf,
                          size_t buflen,
                          Error **errp);
 
@@ -453,7 +453,7 @@ ssize_t qio_channel_read(QIOChannel *ioc,
  * single memory region.
  */
 ssize_t qio_channel_write(QIOChannel *ioc,
-                          const char *buf,
+                          const void *buf,
                           size_t buflen,
                           Error **errp);
 
@@ -475,7 +475,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
  *          without data, or -1 on error
  */
 int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
-                                                char *buf,
+                                                void *buf,
                                                 size_t buflen,
                                                 Error **errp);
 
@@ -495,7 +495,7 @@ int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
  * Returns: 0 if all bytes were read, or -1 on error
  */
 int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
-                                            char *buf,
+                                            void *buf,
                                             size_t buflen,
                                             Error **errp);
 
@@ -514,7 +514,7 @@ int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
  * Returns: 0 if all bytes were written, or -1 on error
  */
 int coroutine_mixed_fn qio_channel_write_all(QIOChannel *ioc,
-                                             const char *buf,
+                                             const void *buf,
                                              size_t buflen,
                                              Error **errp);
 
@@ -595,7 +595,7 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
  * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
  *
  */
-ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
                            off_t offset, Error **errp);
 
 /**
@@ -631,7 +631,7 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
  * flag QIO_CHANNEL_FEATURE_SEEKABLE prior to calling this method.
  *
  */
-ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
                           off_t offset, Error **errp);
 
 /**
diff --git a/io/channel-tls.c b/io/channel-tls.c
index ce041795c1..b0cec27cb9 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -26,7 +26,7 @@
 #include "qemu/atomic.h"
 
 
-static ssize_t qio_channel_tls_write_handler(const char *buf,
+static ssize_t qio_channel_tls_write_handler(const void *buf,
                                              size_t len,
                                              void *opaque,
                                              Error **errp)
@@ -43,7 +43,7 @@ static ssize_t qio_channel_tls_write_handler(const char *buf,
     return ret;
 }
 
-static ssize_t qio_channel_tls_read_handler(char *buf,
+static ssize_t qio_channel_tls_read_handler(void *buf,
                                             size_t len,
                                             void *opaque,
                                             Error **errp)
diff --git a/io/channel.c b/io/channel.c
index 852e684938..8e8bd2efa8 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -310,7 +310,7 @@ ssize_t qio_channel_writev(QIOChannel *ioc,
 
 
 ssize_t qio_channel_read(QIOChannel *ioc,
-                         char *buf,
+                         void *buf,
                          size_t buflen,
                          Error **errp)
 {
@@ -320,7 +320,7 @@ ssize_t qio_channel_read(QIOChannel *ioc,
 
 
 ssize_t qio_channel_write(QIOChannel *ioc,
-                          const char *buf,
+                          const void *buf,
                           size_t buflen,
                           Error **errp)
 {
@@ -330,7 +330,7 @@ ssize_t qio_channel_write(QIOChannel *ioc,
 
 
 int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
-                                                char *buf,
+                                                void *buf,
                                                 size_t buflen,
                                                 Error **errp)
 {
@@ -340,7 +340,7 @@ int coroutine_mixed_fn qio_channel_read_all_eof(QIOChannel *ioc,
 
 
 int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
-                                            char *buf,
+                                            void *buf,
                                             size_t buflen,
                                             Error **errp)
 {
@@ -350,7 +350,7 @@ int coroutine_mixed_fn qio_channel_read_all(QIOChannel *ioc,
 
 
 int coroutine_mixed_fn qio_channel_write_all(QIOChannel *ioc,
-                                             const char *buf,
+                                             const void *buf,
                                              size_t buflen,
                                              Error **errp)
 {
@@ -475,7 +475,7 @@ ssize_t qio_channel_pwritev(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_pwritev(ioc, iov, niov, offset, errp);
 }
 
-ssize_t qio_channel_pwrite(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pwrite(QIOChannel *ioc, void *buf, size_t buflen,
                            off_t offset, Error **errp)
 {
     struct iovec iov = {
@@ -504,7 +504,7 @@ ssize_t qio_channel_preadv(QIOChannel *ioc, const struct iovec *iov,
     return klass->io_preadv(ioc, iov, niov, offset, errp);
 }
 
-ssize_t qio_channel_pread(QIOChannel *ioc, char *buf, size_t buflen,
+ssize_t qio_channel_pread(QIOChannel *ioc, void *buf, size_t buflen,
                           off_t offset, Error **errp)
 {
     struct iovec iov = {
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index d0baf3b304..0d06a6892e 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -36,7 +36,7 @@
 #define KEYFILE WORKDIR "key-ctx.pem"
 
 static ssize_t
-testWrite(const char *buf, size_t len, void *opaque, Error **errp)
+testWrite(const void *buf, size_t len, void *opaque, Error **errp)
 {
     int *fd = opaque;
     int ret;
@@ -54,7 +54,7 @@ testWrite(const char *buf, size_t len, void *opaque, Error **errp)
 }
 
 static ssize_t
-testRead(char *buf, size_t len, void *opaque, Error **errp)
+testRead(void *buf, size_t len, void *opaque, Error **errp)
 {
     int *fd = opaque;
     int ret;
-- 
2.51.1


