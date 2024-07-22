Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F818C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVsuV-00009C-N8; Mon, 22 Jul 2024 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuD-0008Sb-Lf
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuB-0007bZ-P8
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721654201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5DJJUVbon9TskouPJ1tJwzGjEbnwiy/XcJutS09hwM=;
 b=LxyiUi4uHORy/o/AuJxnmbaqq2c7gD1PPD4oltdnqEpcLbvUglvh2sqK3v/LFGGkWKdHi4
 f/egz1y1+3DSIoPMTnLfZvMkUrgIdn6scYIU9r0aOFqR/ksXsGO7ec9E7Zmcj2rJbOJ0pd
 QT/BGP1OFVZR73LVgnX9clf1vxKCtFY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-WUc1m6GQNZGAVb2vmdiPxg-1; Mon,
 22 Jul 2024 09:16:38 -0400
X-MC-Unique: WUc1m6GQNZGAVb2vmdiPxg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48A4D1944AAD; Mon, 22 Jul 2024 13:16:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 738121932D85; Mon, 22 Jul 2024 13:16:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/5] crypto: push error reporting into TLS session I/O APIs
Date: Mon, 22 Jul 2024 14:16:10 +0100
Message-ID: <20240722131611.2820041-5-berrange@redhat.com>
In-Reply-To: <20240722131611.2820041-1-berrange@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c         | 47 ++++++++++++++++---------------------
 include/crypto/tlssession.h | 23 ++++++++++++++----
 io/channel-tls.c            | 44 ++++++++++++++--------------------
 3 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 1e98f44e0d..f0076a4add 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -441,23 +441,19 @@ qcrypto_tls_session_set_callbacks(QCryptoTLSSession *session,
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
+                       "Cannot write to TLS channel: %s", gnutls_strerror(ret));
+            return -1;
         }
-        ret = -1;
     }
 
     return ret;
@@ -467,26 +463,23 @@ qcrypto_tls_session_write(QCryptoTLSSession *session,
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
+                       "Cannot read from TLS channel: %s", gnutls_strerror(ret));
+            return -1;
         }
-        ret = -1;
     }
 
     return ret;
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
index 67b9700006..eab64b0706 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -279,22 +279,17 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
     for (i = 0 ; i < niov ; i++) {
         ssize_t ret = qcrypto_tls_session_read(tioc->session,
                                                iov[i].iov_base,
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
+                                               iov[i].iov_len,
+                                               (qatomic_load_acquire(&tioc->shutdown) &
+                                                QIO_CHANNEL_SHUTDOWN_READ),
+                                               errp);
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


