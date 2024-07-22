Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0301BC3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVsuX-0000GQ-7j; Mon, 22 Jul 2024 09:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuJ-0008VP-J0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sVsuG-0007cD-6p
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721654205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iz7gdYSSGyBra3y/0Srn+q7HWefemtlpPT4z6ITk7Z8=;
 b=IJ7ky6ZmDHNG7qkQLXuZ+XJ5LPe+upHFdjBshZXHuPHqqp+vsYf1/PMbqDovX3eg0jz5+2
 2/m36I21VWAXNUmkaKkXTC9yIog570VwKhlDDj5/esDOLQVFmossNLIP7TwSeJaWk1vByD
 8xHLuzfmRtdVHt/ZOfBhPVJflCnuWQI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-Z9V9Gd5yM5mAu8_T8xB7-A-1; Mon,
 22 Jul 2024 09:16:43 -0400
X-MC-Unique: Z9V9Gd5yM5mAu8_T8xB7-A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 706B41955D4C; Mon, 22 Jul 2024 13:16:42 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 657061944F2E; Mon, 22 Jul 2024 13:16:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/5] crypto: propagate errors from TLS session I/O callbacks
Date: Mon, 22 Jul 2024 14:16:11 +0100
Message-ID: <20240722131611.2820041-6-berrange@redhat.com>
In-Reply-To: <20240722131611.2820041-1-berrange@redhat.com>
References: <20240722131611.2820041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

GNUTLS doesn't know how to perform I/O on anything other than plain
FDs, so the TLS session provides it with some I/O callbacks. The
GNUTLS API design requires these callbacks to return a unix errno
value, which means we're currently loosing the useful QEMU "Error"
object.

This changes the I/O callbacks in QEMU to stash the "Error" object
in the QCryptoTLSSession class, and fetch it when seeing an I/O
error returned from GNUTLS, thus preserving useful error messages.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlssession.c                 | 71 +++++++++++++++++++++++++----
 include/crypto/tlssession.h         | 10 +++-
 io/channel-tls.c                    | 18 ++++----
 tests/unit/test-crypto-tlssession.c | 28 ++++++++++--
 4 files changed, 103 insertions(+), 24 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index f0076a4add..e5cbe86bf0 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -44,6 +44,13 @@ struct QCryptoTLSSession {
     QCryptoTLSSessionReadFunc readFunc;
     void *opaque;
     char *peername;
+
+    /*
+     * Allow concurrent reads and writes, so track
+     * errors separately
+     */
+    Error *rerr;
+    Error *werr;
 };
 
 
@@ -54,6 +61,9 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)
         return;
     }
 
+    error_free(session->rerr);
+    error_free(session->werr);
+
     gnutls_deinit(session->handle);
     g_free(session->hostname);
     g_free(session->peername);
@@ -67,13 +77,26 @@ static ssize_t
 qcrypto_tls_session_push(void *opaque, const void *buf, size_t len)
 {
     QCryptoTLSSession *session = opaque;
+    ssize_t ret;
 
     if (!session->writeFunc) {
         errno = EIO;
         return -1;
     };
 
-    return session->writeFunc(buf, len, session->opaque);
+    error_free(session->werr);
+    session->werr = NULL;
+
+    ret = session->writeFunc(buf, len, session->opaque, &session->werr);
+    if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
+        errno = EAGAIN;
+        return -1;
+    } else if (ret < 0) {
+        errno = EIO;
+        return -1;
+    } else {
+        return ret;
+    }
 }
 
 
@@ -81,13 +104,26 @@ static ssize_t
 qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
 {
     QCryptoTLSSession *session = opaque;
+    ssize_t ret;
 
     if (!session->readFunc) {
         errno = EIO;
         return -1;
     };
 
-    return session->readFunc(buf, len, session->opaque);
+    error_free(session->rerr);
+    session->rerr = NULL;
+
+    ret = session->readFunc(buf, len, session->opaque, &session->rerr);
+    if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
+        errno = EAGAIN;
+        return -1;
+    } else if (ret < 0) {
+        errno = EIO;
+        return -1;
+    } else {
+        return ret;
+    }
 }
 
 #define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
@@ -450,8 +486,13 @@ qcrypto_tls_session_write(QCryptoTLSSession *session,
         if (ret == GNUTLS_E_AGAIN) {
             return QCRYPTO_TLS_SESSION_ERR_BLOCK;
         } else {
-            error_setg(errp,
-                       "Cannot write to TLS channel: %s", gnutls_strerror(ret));
+            if (session->werr) {
+                error_propagate(errp, session->werr);
+                session->werr = NULL;
+            } else {
+                error_setg(errp,
+                           "Cannot write to TLS channel: %s", gnutls_strerror(ret));
+            }
             return -1;
         }
     }
@@ -476,8 +517,13 @@ qcrypto_tls_session_read(QCryptoTLSSession *session,
                    gracefulTermination){
             return 0;
         } else {
-            error_setg(errp,
-                       "Cannot read from TLS channel: %s", gnutls_strerror(ret));
+            if (session->rerr) {
+                error_propagate(errp, session->rerr);
+                session->rerr = NULL;
+            } else {
+                error_setg(errp,
+                           "Cannot read from TLS channel: %s", gnutls_strerror(ret));
+            }
             return -1;
         }
     }
@@ -505,11 +551,20 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
             ret == GNUTLS_E_AGAIN) {
             ret = 1;
         } else {
-            error_setg(errp, "TLS handshake failed: %s",
-                       gnutls_strerror(ret));
+            if (session->rerr || session->werr) {
+                error_setg(errp, "TLS handshake failed: %s: %s",
+                           gnutls_strerror(ret),
+                           error_get_pretty(session->rerr ? session->rerr : session->werr));
+            } else {
+                error_setg(errp, "TLS handshake failed: %s",
+                           gnutls_strerror(ret));
+            }
             ret = -1;
         }
     }
+    error_free(session->rerr);
+    error_free(session->werr);
+    session->rerr = session->werr = NULL;
 
     return ret;
 }
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index 291e602540..f694a5c3c5 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -178,12 +178,18 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSSession, qcrypto_tls_session_free)
 int qcrypto_tls_session_check_credentials(QCryptoTLSSession *sess,
                                           Error **errp);
 
+/*
+ * These must return QCRYPTO_TLS_SESSION_ERR_BLOCK if the I/O
+ * would block, but on other errors, must fill 'errp'
+ */
 typedef ssize_t (*QCryptoTLSSessionWriteFunc)(const char *buf,
                                               size_t len,
-                                              void *opaque);
+                                              void *opaque,
+                                              Error **errp);
 typedef ssize_t (*QCryptoTLSSessionReadFunc)(char *buf,
                                              size_t len,
-                                             void *opaque);
+                                             void *opaque,
+                                             Error **errp);
 
 /**
  * qcrypto_tls_session_set_callbacks:
diff --git a/io/channel-tls.c b/io/channel-tls.c
index eab64b0706..980dc5b89f 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -28,17 +28,16 @@
 
 static ssize_t qio_channel_tls_write_handler(const char *buf,
                                              size_t len,
-                                             void *opaque)
+                                             void *opaque,
+                                             Error **errp)
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(opaque);
     ssize_t ret;
 
-    ret = qio_channel_write(tioc->master, buf, len, NULL);
+    ret = qio_channel_write(tioc->master, buf, len, errp);
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        errno = EAGAIN;
-        return -1;
+        return QCRYPTO_TLS_SESSION_ERR_BLOCK;
     } else if (ret < 0) {
-        errno = EIO;
         return -1;
     }
     return ret;
@@ -46,17 +45,16 @@ static ssize_t qio_channel_tls_write_handler(const char *buf,
 
 static ssize_t qio_channel_tls_read_handler(char *buf,
                                             size_t len,
-                                            void *opaque)
+                                            void *opaque,
+                                            Error **errp)
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(opaque);
     ssize_t ret;
 
-    ret = qio_channel_read(tioc->master, buf, len, NULL);
+    ret = qio_channel_read(tioc->master, buf, len, errp);
     if (ret == QIO_CHANNEL_ERR_BLOCK) {
-        errno = EAGAIN;
-        return -1;
+        return QCRYPTO_TLS_SESSION_ERR_BLOCK;
     } else if (ret < 0) {
-        errno = EIO;
         return -1;
     }
     return ret;
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index b12e7b6879..34f1f4e1a4 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -35,18 +35,38 @@
 #define PSKFILE WORKDIR "keys.psk"
 #define KEYFILE WORKDIR "key-ctx.pem"
 
-static ssize_t testWrite(const char *buf, size_t len, void *opaque)
+static ssize_t testWrite(const char *buf, size_t len, void *opaque, Error **errp)
 {
     int *fd = opaque;
+    int ret;
 
-    return write(*fd, buf, len);
+    ret = write(*fd, buf, len);
+    if (ret < 0) {
+        if (errno == EAGAIN) {
+            return QCRYPTO_TLS_SESSION_ERR_BLOCK;
+        } else {
+            error_setg_errno(errp, errno, "unable to write");
+            return -1;
+        }
+    }
+    return ret;
 }
 
-static ssize_t testRead(char *buf, size_t len, void *opaque)
+static ssize_t testRead(char *buf, size_t len, void *opaque, Error **errp)
 {
     int *fd = opaque;
+    int ret;
 
-    return read(*fd, buf, len);
+    ret = read(*fd, buf, len);
+    if (ret < 0) {
+        if (errno == EAGAIN) {
+            return QCRYPTO_TLS_SESSION_ERR_BLOCK;
+        } else {
+            error_setg_errno(errp, errno, "unable to read");
+            return -1;
+        }
+    }
+    return ret;
 }
 
 static QCryptoTLSCreds *test_tls_creds_psk_create(
-- 
2.45.2


