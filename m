Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B76DCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNjU-000746-Iv; Wed, 24 Jun 2026 09:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNjJ-00070R-P2; Wed, 24 Jun 2026 09:33:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNjG-0000Nx-V6; Wed, 24 Jun 2026 09:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307995; bh=sIl/tdh7IsN9ArdeDKreQuQNxHNbY82eRu4BG+AwbgQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C1f/GyDDdRn1rb7dGQqeWN1jgZYwH2u7V2c3IQj87tLe/cqIaId0XjWITUrir3v+U
 RR269IovBj5sVBouB91IkIQpF2OeUZKUxmoFCRnxiXPeIbwm+5YjqSK2mMT+o9rF4O
 9XT0z1I34INdkmGGQgl0pIANfsdFmd8f4ph3MjoH/N4OrqOd1rt2qAihMTYwrYk5c+
 NDp4y1spQnUTeKdJkozQy1EUO/RkrmLA9eCwtyko5TvNmj3ji1DaNlqhfHWYD8fpQy
 5oT1tD3pXu+FfBFTZeKbFF03Uai7g3J1IiG8+To9uLk/0v2isskdsM0zDeXbd7FBPk
 kUynYDp9YpBvg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EA081BA9B3;
 Wed, 24 Jun 2026 16:33:15 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CDBE23DEA02;
 Wed, 24 Jun 2026 16:33:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 001/107] crypto: fix client side anonymous TLS
 credentials
Date: Wed, 24 Jun 2026 16:30:06 +0300
Message-ID: <20260624133301.403266-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

The previous refactoring of credential creation failed to allocate
storage fo the anonymous TLS credentials on the client endpoint.

Fixes: 70f9fd8dbf7233bee497055a9b7825e3729ce853
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit 27b127d7348a922ef91ce607776407407f9c2a3e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1551382e1f..190c9833a7 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -73,6 +73,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
                                              box->dh_params);
         }
     } else {
+        box = qcrypto_tls_creds_box_new_client(GNUTLS_CRD_ANON);
+
         ret = gnutls_anon_allocate_client_credentials(&box->data.anonclient);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
index 0d06a6892e..dc7a01bb06 100644
--- a/tests/unit/test-crypto-tlssession.c
+++ b/tests/unit/test-crypto-tlssession.c
@@ -24,6 +24,7 @@
 #include "crypto-tls-psk-helpers.h"
 #include "crypto/tlscredsx509.h"
 #include "crypto/tlscredspsk.h"
+#include "crypto/tlscredsanon.h"
 #include "crypto/tlssession.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
@@ -190,6 +191,121 @@ static void test_crypto_tls_session_psk(void)
 }
 
 
+static QCryptoTLSCreds *test_tls_creds_anon_create(
+    QCryptoTLSCredsEndpoint endpoint)
+{
+    Object *parent = object_get_objects_root();
+    Object *creds = object_new_with_props(
+        TYPE_QCRYPTO_TLS_CREDS_ANON,
+        parent,
+        (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
+         "testtlscredsserver" : "testtlscredsclient"),
+        &error_abort,
+        "endpoint", (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
+                     "server" : "client"),
+        "priority", "NORMAL",
+        NULL
+        );
+    return QCRYPTO_TLS_CREDS(creds);
+}
+
+
+static void test_crypto_tls_session_anon(void)
+{
+    QCryptoTLSCreds *clientCreds;
+    QCryptoTLSCreds *serverCreds;
+    QCryptoTLSSession *clientSess = NULL;
+    QCryptoTLSSession *serverSess = NULL;
+    int channel[2];
+    bool clientShake = false;
+    bool serverShake = false;
+    int ret;
+
+    /* We'll use this for our fake client-server connection */
+    ret = qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
+    g_assert(ret == 0);
+
+    /*
+     * We have an evil loop to do the handshake in a single
+     * thread, so we need these non-blocking to avoid deadlock
+     * of ourselves
+     */
+    qemu_set_blocking(channel[0], false, &error_abort);
+    qemu_set_blocking(channel[1], false, &error_abort);
+
+    clientCreds = test_tls_creds_anon_create(
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT);
+    g_assert(clientCreds != NULL);
+
+    serverCreds = test_tls_creds_anon_create(
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER);
+    g_assert(serverCreds != NULL);
+
+    /* Now the real part of the test, setup the sessions */
+    clientSess = qcrypto_tls_session_new(
+        clientCreds, NULL, NULL,
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &error_abort);
+    g_assert(clientSess != NULL);
+
+    serverSess = qcrypto_tls_session_new(
+        serverCreds, NULL, NULL,
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &error_abort);
+    g_assert(serverSess != NULL);
+
+    /* For handshake to work, we need to set the I/O callbacks
+     * to read/write over the socketpair
+     */
+    qcrypto_tls_session_set_callbacks(serverSess,
+                                      testWrite, testRead,
+                                      &channel[0]);
+    qcrypto_tls_session_set_callbacks(clientSess,
+                                      testWrite, testRead,
+                                      &channel[1]);
+
+    /*
+     * Finally we loop around & around doing handshake on each
+     * session until we get an error, or the handshake completes.
+     * This relies on the socketpair being nonblocking to avoid
+     * deadlocking ourselves upon handshake
+     */
+    do {
+        int rv;
+        if (!serverShake) {
+            rv = qcrypto_tls_session_handshake(serverSess,
+                                               &error_abort);
+            g_assert(rv >= 0);
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+                serverShake = true;
+            }
+        }
+        if (!clientShake) {
+            rv = qcrypto_tls_session_handshake(clientSess,
+                                               &error_abort);
+            g_assert(rv >= 0);
+            if (rv == QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+                clientShake = true;
+            }
+        }
+    } while (!clientShake || !serverShake);
+
+
+    /* Finally make sure the server & client validation is successful. */
+    g_assert(qcrypto_tls_session_check_credentials(serverSess,
+                                                   &error_abort) == 0);
+    g_assert(qcrypto_tls_session_check_credentials(clientSess,
+                                                   &error_abort) == 0);
+
+    object_unparent(OBJECT(serverCreds));
+    object_unparent(OBJECT(clientCreds));
+
+    qcrypto_tls_session_free(serverSess);
+    qcrypto_tls_session_free(clientSess);
+
+    close(channel[0]);
+    close(channel[1]);
+}
+
+
 struct QCryptoTLSSessionTestData {
     const char *servercacrt;
     const char *clientcacrt;
@@ -421,9 +537,11 @@ int main(int argc, char **argv)
     test_tls_init(KEYFILE);
     test_tls_psk_init(PSKFILE);
 
-    /* Simple initial test using Pre-Shared Keys. */
+    /* Simple initial tests using Pre-Shared Keys & anon creds */
     g_test_add_func("/qcrypto/tlssession/psk",
                     test_crypto_tls_session_psk);
+    g_test_add_func("/qcrypto/tlssession/anon",
+                    test_crypto_tls_session_anon);
 
     /* More complex tests using X.509 certificates. */
 # define TEST_SESS_REG(name, caCrt,                                     \
-- 
2.47.3


