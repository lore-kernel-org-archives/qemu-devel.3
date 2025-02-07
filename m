Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51400C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPLC-0001W6-0z; Fri, 07 Feb 2025 09:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPLA-0001VN-Jh
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPL5-0008Co-Pb
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:28:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D5642115F;
 Fri,  7 Feb 2025 14:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQj+mXq6EHQUvS4SW9yvgtTrr/OpMRPh5pjA/ogVtoU=;
 b=UkY6FDDerKIU766pHwhFJgzZEhul2WQbqDDAanKc2DzQ3jwE+yxYHq0lFQmP4d7D6j+rGG
 CmYeq8zAuKXq/UfmwEpF+OXBVKE0+3ZmehmsbYFxrStPtI+XAvQ8jgvnoGjGme7dIWk7X5
 gdcZc90hO/yyS8+Lq+rKRkdpTfOf6To=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQj+mXq6EHQUvS4SW9yvgtTrr/OpMRPh5pjA/ogVtoU=;
 b=vzp9hkqWba88OPuaXVf/OlS3hPp7Q+QPxQGiSK7rz6DkoFdHS4LYCwDFYfHnP+U4MIdkG0
 gATHozdvHT2VrVCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UkY6FDDe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vzp9hkqW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738938493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQj+mXq6EHQUvS4SW9yvgtTrr/OpMRPh5pjA/ogVtoU=;
 b=UkY6FDDerKIU766pHwhFJgzZEhul2WQbqDDAanKc2DzQ3jwE+yxYHq0lFQmP4d7D6j+rGG
 CmYeq8zAuKXq/UfmwEpF+OXBVKE0+3ZmehmsbYFxrStPtI+XAvQ8jgvnoGjGme7dIWk7X5
 gdcZc90hO/yyS8+Lq+rKRkdpTfOf6To=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738938493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQj+mXq6EHQUvS4SW9yvgtTrr/OpMRPh5pjA/ogVtoU=;
 b=vzp9hkqWba88OPuaXVf/OlS3hPp7Q+QPxQGiSK7rz6DkoFdHS4LYCwDFYfHnP+U4MIdkG0
 gATHozdvHT2VrVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAAFE139CB;
 Fri,  7 Feb 2025 14:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QAp2IXsYpmcoOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:28:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH v2 5/8] crypto: Remove
 qcrypto_tls_session_get_handshake_status
Date: Fri,  7 Feb 2025 11:27:55 -0300
Message-Id: <20250207142758.6936-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250207142758.6936-1-farosas@suse.de>
References: <20250207142758.6936-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D5642115F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The correct way of calling qcrypto_tls_session_handshake() requires
calling qcrypto_tls_session_get_handshake_status() right after it so
there's no reason to have a separate method.

Refactor qcrypto_tls_session_handshake() to inform the status in its
own return value and alter the callers accordingly.

No functional change.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 crypto/tlssession.c                 | 64 +++++++++++------------------
 include/crypto/tlssession.h         | 32 ++++-----------
 io/channel-tls.c                    |  7 ++--
 tests/unit/test-crypto-tlssession.c | 12 ++----
 4 files changed, 39 insertions(+), 76 deletions(-)

diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index d769d7a304..567698f5d9 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -546,45 +546,35 @@ qcrypto_tls_session_handshake(QCryptoTLSSession *session,
                               Error **errp)
 {
     int ret = gnutls_handshake(session->handle);
-    if (ret == 0) {
+    if (!ret) {
         session->handshakeComplete = true;
-    } else {
-        if (ret == GNUTLS_E_INTERRUPTED ||
-            ret == GNUTLS_E_AGAIN) {
-            ret = 1;
-        } else {
-            if (session->rerr || session->werr) {
-                error_setg(errp, "TLS handshake failed: %s: %s",
-                           gnutls_strerror(ret),
-                           error_get_pretty(session->rerr ?
-                                            session->rerr : session->werr));
-            } else {
-                error_setg(errp, "TLS handshake failed: %s",
-                           gnutls_strerror(ret));
-            }
-            ret = -1;
-        }
-    }
-    error_free(session->rerr);
-    error_free(session->werr);
-    session->rerr = session->werr = NULL;
-
-    return ret;
-}
-
-
-QCryptoTLSSessionHandshakeStatus
-qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *session)
-{
-    if (session->handshakeComplete) {
         return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
-    } else if (gnutls_record_get_direction(session->handle) == 0) {
-        return QCRYPTO_TLS_HANDSHAKE_RECVING;
+    }
+
+    if (ret == GNUTLS_E_INTERRUPTED || ret == GNUTLS_E_AGAIN) {
+        int direction = gnutls_record_get_direction(session->handle);
+        return direction ? QCRYPTO_TLS_HANDSHAKE_SENDING :
+            QCRYPTO_TLS_HANDSHAKE_RECVING;
+    }
+
+    if (session->rerr || session->werr) {
+        error_setg(errp, "TLS handshake failed: %s: %s",
+                   gnutls_strerror(ret),
+                   error_get_pretty(session->rerr ?
+                                    session->rerr : session->werr));
     } else {
-        return QCRYPTO_TLS_HANDSHAKE_SENDING;
+        error_setg(errp, "TLS handshake failed: %s",
+                   gnutls_strerror(ret));
     }
+
+    error_free(session->rerr);
+    error_free(session->werr);
+    session->rerr = session->werr = NULL;
+
+    return -1;
 }
 
+
 int
 qcrypto_tls_session_bye(QCryptoTLSSession *session, Error **errp)
 {
@@ -720,14 +710,6 @@ qcrypto_tls_session_check_pending(QCryptoTLSSession *session)
 int
 qcrypto_tls_session_handshake(QCryptoTLSSession *sess,
                               Error **errp)
-{
-    error_setg(errp, "TLS requires GNUTLS support");
-    return -1;
-}
-
-
-QCryptoTLSSessionHandshakeStatus
-qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess)
 {
     return QCRYPTO_TLS_HANDSHAKE_COMPLETE;
 }
diff --git a/include/crypto/tlssession.h b/include/crypto/tlssession.h
index c0f64ce989..d77ae0d423 100644
--- a/include/crypto/tlssession.h
+++ b/include/crypto/tlssession.h
@@ -75,12 +75,14 @@
  *                                      GINT_TO_POINTER(fd));
  *
  *    while (1) {
- *       if (qcrypto_tls_session_handshake(sess, errp) < 0) {
+ *       int ret = qcrypto_tls_session_handshake(sess, errp);
+ *
+ *       if (ret < 0) {
  *           qcrypto_tls_session_free(sess);
  *           return -1;
  *       }
  *
- *       switch(qcrypto_tls_session_get_handshake_status(sess)) {
+ *       switch(ret) {
  *       case QCRYPTO_TLS_HANDSHAKE_COMPLETE:
  *           if (qcrypto_tls_session_check_credentials(sess, errp) < )) {
  *               qcrypto_tls_session_free(sess);
@@ -170,7 +172,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSSession, qcrypto_tls_session_free)
  *
  * Validate the peer's credentials after a successful
  * TLS handshake. It is an error to call this before
- * qcrypto_tls_session_get_handshake_status() returns
+ * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns 0 if the credentials validated, -1 on error
@@ -226,7 +228,7 @@ void qcrypto_tls_session_set_callbacks(QCryptoTLSSession *sess,
  * registered with qcrypto_tls_session_set_callbacks()
  *
  * It is an error to call this before
- * qcrypto_tls_session_get_handshake_status() returns
+ * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns: the number of bytes sent,
@@ -256,7 +258,7 @@ ssize_t qcrypto_tls_session_write(QCryptoTLSSession *sess,
  * opposed to an error.
  *
  * It is an error to call this before
- * qcrypto_tls_session_get_handshake_status() returns
+ * qcrypto_tls_session_handshake() returns
  * QCRYPTO_TLS_HANDSHAKE_COMPLETE
  *
  * Returns: the number of bytes received,
@@ -289,8 +291,7 @@ size_t qcrypto_tls_session_check_pending(QCryptoTLSSession *sess);
  * the underlying data channel is non-blocking, then
  * this method may return control before the handshake
  * is complete. On non-blocking channels the
- * qcrypto_tls_session_get_handshake_status() method
- * should be used to determine whether the handshake
+ * return value determines whether the handshake
  * has completed, or is waiting to send or receive
  * data. In the latter cases, the caller should setup
  * an event loop watch and call this method again
@@ -306,23 +307,6 @@ typedef enum {
     QCRYPTO_TLS_HANDSHAKE_RECVING,
 } QCryptoTLSSessionHandshakeStatus;
 
-/**
- * qcrypto_tls_session_get_handshake_status:
- * @sess: the TLS session object
- *
- * Check the status of the TLS handshake. This
- * is used with non-blocking data channels to
- * determine whether the handshake is waiting
- * to send or receive further data to/from the
- * remote peer.
- *
- * Once this returns QCRYPTO_TLS_HANDSHAKE_COMPLETE
- * it is permitted to send/receive payload data on
- * the channel
- */
-QCryptoTLSSessionHandshakeStatus
-qcrypto_tls_session_get_handshake_status(QCryptoTLSSession *sess);
-
 typedef enum {
     QCRYPTO_TLS_BYE_COMPLETE,
     QCRYPTO_TLS_BYE_SENDING,
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 517ce190a4..ecde6b57bf 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -162,16 +162,17 @@ static void qio_channel_tls_handshake_task(QIOChannelTLS *ioc,
                                            GMainContext *context)
 {
     Error *err = NULL;
-    QCryptoTLSSessionHandshakeStatus status;
+    int status;
 
-    if (qcrypto_tls_session_handshake(ioc->session, &err) < 0) {
+    status = qcrypto_tls_session_handshake(ioc->session, &err);
+
+    if (status < 0) {
         trace_qio_channel_tls_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
         return;
     }
 
-    status = qcrypto_tls_session_get_handshake_status(ioc->session);
     if (status == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
         trace_qio_channel_tls_handshake_complete(ioc);
         if (qcrypto_tls_session_check_credentials(ioc->session,
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 3395f73560..554054e934 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -158,8 +158,7 @@ static void test_crypto_tls_session_psk(void)
             rv = qcrypto_tls_session_handshake(serverSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(serverSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 serverShake = true;
             }
         }
@@ -167,8 +166,7 @@ static void test_crypto_tls_session_psk(void)
             rv = qcrypto_tls_session_handshake(clientSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(clientSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 clientShake = true;
             }
         }
@@ -352,8 +350,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
             rv = qcrypto_tls_session_handshake(serverSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(serverSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 serverShake = true;
             }
         }
@@ -361,8 +358,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
             rv = qcrypto_tls_session_handshake(clientSess,
                                                &error_abort);
             g_assert(rv >= 0);
-            if (qcrypto_tls_session_get_handshake_status(clientSess) ==
-                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
                 clientShake = true;
             }
         }
-- 
2.35.3


