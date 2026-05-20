Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9953CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 09:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPd0W-0004gz-6h; Wed, 20 May 2026 05:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPd0R-0004gG-T8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPd0K-0005eL-Js
 for qemu-devel@nongnu.org; Wed, 20 May 2026 05:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779268455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bDPJ/rA4TRt7vjgNzC7L2s8kaU1MKdXtrs0Sj3PEP7k=;
 b=CAnA16ZjjFP/lpHDd56vDVZmZMkR8ssL5tMM1HpKGXpKfsh1Z3U9KfHokUI5iAW+vMq7HZ
 YWm56e6XXrO5PMpbU35Vryp+LJ/9ySVhKp4lNbenACiyEGP+lhbEHPGGzczCWkJszQW9rl
 +Pc1KlAXw9ZE+GmHlxANwDzDMAyaMsY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-JTv4NIHEO--gY3jlGInGqg-1; Wed,
 20 May 2026 05:14:11 -0400
X-MC-Unique: JTv4NIHEO--gY3jlGInGqg-1
X-Mimecast-MFC-AGG-ID: JTv4NIHEO--gY3jlGInGqg_1779268450
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D4619560A6; Wed, 20 May 2026 09:14:09 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.211])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B19071800673; Wed, 20 May 2026 09:14:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Snow <jsnow@redhat.com>, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PULL 02/29] crypto: fix client side anonymous TLS credentials
Date: Wed, 20 May 2026 10:13:24 +0100
Message-ID: <20260520091351.1160442-3-berrange@redhat.com>
In-Reply-To: <20260520091351.1160442-1-berrange@redhat.com>
References: <20260520091351.1160442-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The previous refactoring of credential creation failed to allocate
storage fo the anonymous TLS credentials on the client endpoint.

Fixes: 70f9fd8dbf7233bee497055a9b7825e3729ce853
Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsanon.c               |   2 +
 tests/unit/test-crypto-tlssession.c | 120 +++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

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
2.54.0


