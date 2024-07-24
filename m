Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031EBC3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYjq-0007aa-Tl; Wed, 24 Jul 2024 05:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYjY-0006bZ-3L
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sWYjW-0005gS-8s
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721814989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqy17IpTKEiWQUqPxuwYUXlRoxDMs+tjUrAJ+DPEPKw=;
 b=QNvGcTjeKPeG5Ftyj4LVJf2SzvnqSQ3Z5yhAB26smrexiR6qs7Bgam49cONFtxR6CCioKl
 Z0aU3/foNg7NJwsSdAkb7BuuZ+G2ac74KagGcSiq4ShZz6InBpA3UeX6qk5OYk5EFnCyMO
 oBcC5S+Qhl3Nor5L6ZFrZlXiCRosGpQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-UtG8R4RiMaOozuMFq5AmeA-1; Wed,
 24 Jul 2024 05:49:02 -0400
X-MC-Unique: UtG8R4RiMaOozuMFq5AmeA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F39DE19560AB; Wed, 24 Jul 2024 09:49:00 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.141])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53A4F195605A; Wed, 24 Jul 2024 09:48:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 10/11] crypto: push error reporting into TLS session I/O APIs
Date: Wed, 24 Jul 2024 10:47:05 +0100
Message-ID: <20240724094706.30396-11-berrange@redhat.com>
In-Reply-To: <20240724094706.30396-1-berrange@redhat.com>
References: <20240724094706.30396-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The current TLS session I/O APIs just return a synthetic errno
value on error, which has been translated from a gnutls error
value. This looses a large amount of valuable information that
distinguishes different scenarios.

Pushing population of the "Error *errp" object into the TLS
session I/O APIs gives more detailed error information.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c         | 60 ++++++++++++++++++-------------------
 include/crypto/tlssession.h | 23 +++++++++++---
 io/channel-tls.c            | 48 +++++++++++++----------------
 3 files changed, 68 insertions(+), 63 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 1e98f44e0d..926f19c115 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -441,23 +441,20 @@ qcrypto_tls_session_set_callbacks(QCryptoTLSSession *session,
 ssize_t
 qcrypto_tls_session_write(QCryptoTLSSession *session,
                           const char *buf,
-                          size_t len)
+                          size_t len,
+                          Error **errp)
 {
     ssize_t ret = gnutls_record_send(session->handle, buf, len);
 
     if (ret < 0) {
-        switch (ret) {
-        case GNUTLS_E_AGAIN:
-            errno = EAGAIN;
-            break;
-        case GNUTLS_E_INTERRUPTED:
-            errno = EINTR;
-            break;
-        default:
-            errno = EIO;
-            break;
+        if (ret == GNUTLS_E_AGAIN) {
+            return QCRYPTO_TLS_SESSION_ERR_BLOCK;
+        } else {
+            error_setg(errp,
+                       "Cannot write to TLS channel: %s",
+                       gnutls_strerror(ret));
+            return -1;
         }
-        ret = -1;
     }
 
     return ret;
@@ -467,26 +464,24 @@ qcrypto_tls_session_write(QCryptoTLSSession *session,
 ssize_t
 qcrypto_tls_session_read(QCryptoTLSSession *session,
                          char *buf,
-                         size_t len)
+                         size_t len,
+                         bool gracefulTermination,
+                         Error **errp)
 {
     ssize_t ret = gnutls_record_recv(session->handle, buf, len);
 
     if (ret < 0) {
-        switch (ret) {
-        case GNUTLS_E_AGAIN:
-            errno = EAGAIN;
-            break;
-        case GNUTLS_E_INTERRUPTED:
-            errno = EINTR;
-            break;
-        case GNUTLS_E_PREMATURE_TERMINATION:
-            errno = ECONNABORTED;
-            break;
-        default:
-            errno = EIO;
-            break;
+        if (ret == GNUTLS_E_AGAIN) {
+            return QCRYPTO_TLS_SESSION_ERR_BLOCK;
+        } else if ((ret == GNUTLS_E_PREMATURE_TERMINATION) &&
+                   gracefulTermination){
+            return 0;
+        } else {
+            error_setg(errp,
+                       "Cannot read from TLS channel: %s",
+                       gnutls_strerror(ret));
+            return -1;
         }
-        ret = -1;
     }
 
     return ret;
@@ -605,9 +600,10 @@ qcrypto_tls_session_set_callbacks(
 ssize_t
 qcrypto_tls_session_write(QCryptoTLSSession *sess,
                           const char *buf,
-                          size_t len)
+                          size_t len,
+                          Error **errp)
 {
-    errno = -EIO;
+    error_setg(errp, "TLS requires GNUTLS support");
     return -1;
 }
 
@@ -615,9 +611,11 @@ qcrypto_tls_session_write(QCryptoTLSSession *sess,
 ssize_t
 qcrypto_tls_session_read(QCryptoTLSSession *sess,
                          char *buf,
-                         size_t len)
+                         size_t len,
+                         bool gracefulTermination,
+                         Error **errp)
 {
-    errno = -EIO;
+    error_setg(errp, "TLS requires GNUTLS support");
     return -1;
 }
 
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 571049bd0e..291e602540 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -107,6 +107,7 @@
 
 typedef struct QCryptoTLSSession QCryptoTLSSession;
 
+#define QCRYPTO_TLS_SESSION_ERR_BLOCK -2
 
 /**
  * qcrypto_tls_session_new:
@@ -212,6 +213,7 @@ void qcrypto_tls_session_set_callbacks(QCryptoTLSSession *sess,
  * @sess: the TLS session object
  * @buf: the plain text to send
  * @len: the length of @buf
+ * @errp: pointer to hold returned error object
  *
  * Encrypt @len bytes of the data in @buf and send
  * it to the remote peer using the callback previously
@@ -221,32 +223,45 @@ void qcrypto_tls_session_set_callbacks(QCryptoTLSSession *sess,
  * qcrypto_tls_session_get_handshake_status() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
- * Returns: the number of bytes sent, or -1 on error
+ * Returns: the number of bytes sent,
+ * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the write would block,
+ * or -1 on error.
  */
 ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
                                   const char *buf,
-                                  size_t len);
+                                  size_t len,
+                                  Error **errp);
 
 /**
  * qcrypto_tls_session_read:
  * @sess: the TLS session object
  * @buf: to fill with plain text received
  * @len: the length of @buf
+ * @gracefulTermination: treat premature termination as graceful EOF
+ * @errp: pointer to hold returned error object
  *
  * Receive up to @len bytes of data from the remote peer
  * using the callback previously registered with
  * qcrypto_tls_session_set_callbacks(), decrypt it and
  * store it in @buf.
  *
+ * If @gracefulTermination is true, then a premature termination
+ * of the TLS session will be treated as indicating EOF, as
+ * opposed to an error.
+ *
  * It is an error to call this before
  * qcrypto_tls_session_get_handshake_status() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
- * Returns: the number of bytes received, or -1 on error
+ * Returns: the number of bytes received,
+ * or QCRYPTO_TLS_SESSION_ERR_BLOCK if the receive would block,
+ * or -1 on error.
  */
 ssize_t qcrypto_tls_session_read(QCryptoTLSSession *sess,
                                  char *buf,
-                                 size_t len);
+                                 size_t len,
+                                 bool gracefulTermination,
+                                 Error **errp);
 
 /**
  * qcrypto_tls_session_check_pending:
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 67b9700006..9d8bb158d1 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -277,24 +277,19 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
     ssize_t got = 0;
 
     for (i = 0 ; i < niov ; i++) {
-        ssize_t ret = qcrypto_tls_session_read(tioc->session,
-                                               iov[i].iov_base,
-                                               iov[i].iov_len);
-        if (ret < 0) {
-            if (errno == EAGAIN) {
-                if (got) {
-                    return got;
-                } else {
-                    return QIO_CHANNEL_ERR_BLOCK;
-                }
-            } else if (errno == ECONNABORTED &&
-                       (qatomic_load_acquire(&tioc->shutdown) &
-                        QIO_CHANNEL_SHUTDOWN_READ)) {
-                return 0;
+        ssize_t ret = qcrypto_tls_session_read(
+            tioc->session,
+            iov[i].iov_base,
+            iov[i].iov_len,
+            qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
+            errp);
+        if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
+            if (got) {
+                return got;
+            } else {
+                return QIO_CHANNEL_ERR_BLOCK;
             }
-
-            error_setg_errno(errp, errno,
-                             "Cannot read from TLS channel");
+        } else if (ret < 0) {
             return -1;
         }
         got += ret;
@@ -321,18 +316,15 @@ static ssize_t qio_channel_tls_writev(QIOChannel *ioc,
     for (i = 0 ; i < niov ; i++) {
         ssize_t ret = qcrypto_tls_session_write(tioc->session,
                                                 iov[i].iov_base,
-                                                iov[i].iov_len);
-        if (ret <= 0) {
-            if (errno == EAGAIN) {
-                if (done) {
-                    return done;
-                } else {
-                    return QIO_CHANNEL_ERR_BLOCK;
-                }
+                                                iov[i].iov_len,
+                                                errp);
+        if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
+            if (done) {
+                return done;
+            } else {
+                return QIO_CHANNEL_ERR_BLOCK;
             }
-
-            error_setg_errno(errp, errno,
-                             "Cannot write to TLS channel");
+        } else if (ret < 0) {
             return -1;
         }
         done += ret;
-- 
2.45.2


