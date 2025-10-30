Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C87DCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETzo-0002iY-Rv; Thu, 30 Oct 2025 10:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyw-0001nL-Tj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyc-0001gk-WD
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9iLP7M7Vi5pc1c6uLFjWenHWv0UUttMVV55YFRBohM=;
 b=XmGFpAVSiDoM1CpE2rG7DlNgsz/rkQ1fO0c06ca7F6Jc916yVmICAgupUoPAFR1yiFm+OO
 DVs9GOU64RWVl0U4sz8mB5ws/aoP7ww6/QjJU9R31HJ3k+cmD3Q224FgL1QTAvzhZiWaUs
 UdRT7NMo5dIwTuvfp8s8SE1gt13TFoA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-T-Vs6CXzNz-O3j6p4h7rsg-1; Thu,
 30 Oct 2025 10:50:05 -0400
X-MC-Unique: T-Vs6CXzNz-O3j6p4h7rsg-1
X-Mimecast-MFC-AGG-ID: T-Vs6CXzNz-O3j6p4h7rsg_1761835805
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16DE0195607C; Thu, 30 Oct 2025 14:50:05 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7F8430001A1; Thu, 30 Oct 2025 14:50:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 18/21] crypto: avoid loading the identity certs twice
Date: Thu, 30 Oct 2025 14:49:24 +0000
Message-ID: <20251030144927.2241109-19-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The x509 TLS credentials code will load the identity certs once to
perform sanity chcking on the certs, then discard the certificate
objects and let gnutls load them a second time.

This extends the previous QCryptoTLSCredsX509Files struct to also
hold the identity certificates & key loaded for sanity checking
and pass them on to gnutls, avoiding the duplicated loading.

The unit tests need updating because we now correctly diagnose the
error scenario where the cert PEM file exists, without its matching
key PEM file. Previously that error was mistakenly ignored.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c                 | 247 +++++++++++++++++---------
 tests/unit/test-crypto-tlscredsx509.c |   8 +-
 2 files changed, 164 insertions(+), 91 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 6a830af50d..3cb0a6c31f 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -45,6 +45,12 @@ struct QCryptoTLSCredsX509Files {
     char *cacertpath;
     gnutls_x509_crt_t *cacerts;
     unsigned int ncacerts;
+
+    char *certpath;
+    char *keypath;
+    gnutls_x509_crt_t *certs;
+    unsigned int ncerts;
+    gnutls_x509_privkey_t key;
 };
 
 static QCryptoTLSCredsX509Files *
@@ -63,6 +69,13 @@ qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
     }
     g_free(files->cacerts);
     g_free(files->cacertpath);
+    for (i = 0; i < files->ncerts; i++) {
+        gnutls_x509_crt_deinit(files->certs[i]);
+    }
+    gnutls_x509_privkey_deinit(files->key);
+    g_free(files->certs);
+    g_free(files->certpath);
+    g_free(files->keypath);
     g_free(files);
 }
 
@@ -477,14 +490,13 @@ qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX509 *creds,
                                  const char *certFile,
                                  gnutls_x509_crt_t **certs,
                                  unsigned int *ncerts,
-                                 bool isServer,
-                                 bool isCA,
                                  Error **errp)
 {
     gnutls_datum_t data;
     g_autofree char *buf = NULL;
     gsize buflen;
     GError *gerr = NULL;
+    int ret;
 
     *ncerts = 0;
     trace_qcrypto_tls_creds_x509_load_cert_list(creds, certFile);
@@ -499,13 +511,60 @@ qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX509 *creds,
     data.data = (unsigned char *)buf;
     data.size = strlen(buf);
 
-    if (gnutls_x509_crt_list_import2(certs, ncerts, &data,
-                                     GNUTLS_X509_FMT_PEM, 0) < 0) {
-        error_setg(errp,
-                   isCA ? "Unable to import CA certificate list %s" :
-                   (isServer ? "Unable to import server certificate %s" :
-                    "Unable to import client certificate %s"),
-                   certFile);
+    ret = gnutls_x509_crt_list_import2(certs, ncerts, &data,
+                                       GNUTLS_X509_FMT_PEM, 0);
+    if (ret < 0) {
+        error_setg(errp, "Unable to import certificate %s: %s",
+                   certFile, gnutls_strerror(ret));
+        return -1;
+    }
+
+    return 0;
+}
+
+
+static int
+qcrypto_tls_creds_load_privkey(QCryptoTLSCredsX509 *creds,
+                               const char *keyFile,
+                               gnutls_x509_privkey_t *key,
+                               Error **errp)
+{
+    gnutls_datum_t data;
+    g_autofree char *buf = NULL;
+    g_autofree char *password = NULL;
+    gsize buflen;
+    GError *gerr = NULL;
+    int ret;
+
+    ret = gnutls_x509_privkey_init(key);
+    if (ret < 0) {
+        error_setg(errp, "Unable to initialize private key: %s",
+                   gnutls_strerror(ret));
+        return -1;
+    }
+
+    if (!g_file_get_contents(keyFile, &buf, &buflen, &gerr)) {
+        error_setg(errp, "Cannot load private key %s: %s",
+                   keyFile, gerr->message);
+        g_error_free(gerr);
+        return -1;
+    }
+
+    data.data = (unsigned char *)buf;
+    data.size = strlen(buf);
+
+    if (creds->passwordid) {
+        password = qcrypto_secret_lookup_as_utf8(creds->passwordid,
+                                                 errp);
+        if (!password) {
+            return -1;
+        }
+    }
+
+    if (gnutls_x509_privkey_import2(*key, &data,
+                                    GNUTLS_X509_FMT_PEM,
+                                    password, 0) < 0) {
+        error_setg(errp, "Unable to import private key %s", keyFile);
         return -1;
     }
 
@@ -517,56 +576,34 @@ static int
 qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
                                     QCryptoTLSCredsX509Files *files,
                                     bool isServer,
-                                    const char *certFile,
                                     Error **errp)
 {
-    gnutls_x509_crt_t *certs = NULL;
-    unsigned int ncerts = 0;
     size_t i;
-    int ret = -1;
-
-    if (certFile) {
-        if (qcrypto_tls_creds_load_cert_list(creds,
-                                             certFile,
-                                             &certs,
-                                             &ncerts,
-                                             isServer,
-                                             false,
-                                             errp) < 0) {
-            goto cleanup;
-        }
-    }
 
-    for (i = 0; i < ncerts; i++) {
+    for (i = 0; i < files->ncerts; i++) {
         if (qcrypto_tls_creds_check_cert(creds,
-                                         certs[i], certFile,
+                                         files->certs[i], files->certpath,
                                          isServer, i != 0, errp) < 0) {
-            goto cleanup;
+            return -1;
         }
     }
 
-    if (ncerts &&
+    if (files->ncerts &&
         qcrypto_tls_creds_check_authority_chain(creds, files,
-                                                certs, ncerts,
+                                                files->certs, files->ncerts,
                                                 isServer, errp) < 0) {
-        goto cleanup;
-    }
-
-    if (ncerts &&
-        qcrypto_tls_creds_check_cert_pair(files, certs, ncerts, certFile,
-                                          isServer, errp) < 0) {
-        goto cleanup;
+        return -1;
     }
 
-    ret = 0;
-
- cleanup:
-    for (i = 0; i < ncerts; i++) {
-        gnutls_x509_crt_deinit(certs[i]);
+    if (files->ncerts &&
+        qcrypto_tls_creds_check_cert_pair(files,
+                                          files->certs, files->ncerts,
+                                          files->certpath, isServer,
+                                          errp) < 0) {
+        return -1;
     }
-    g_free(certs);
 
-    return ret;
+    return 0;
 }
 
 
@@ -589,8 +626,6 @@ qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
                                          files->cacertpath,
                                          &files->cacerts,
                                          &files->ncacerts,
-                                         isServer,
-                                         true,
                                          errp) < 0) {
         return -1;
     }
@@ -606,6 +641,79 @@ qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
     return 0;
 }
 
+
+static int
+qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
+                                     QCryptoTLSCredsBox *box,
+                                     QCryptoTLSCredsX509Files *files,
+                                     bool isServer,
+                                     Error **errp)
+{
+    int ret;
+
+    if (isServer) {
+        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_X509_SERVER_CERT,
+                                       true, &files->certpath, errp) < 0 ||
+            qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_X509_SERVER_KEY,
+                                       true, &files->keypath, errp) < 0) {
+            return -1;
+        }
+    } else {
+        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
+                                       false, &files->certpath, errp) < 0 ||
+            qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
+                                       false, &files->keypath, errp) < 0) {
+            return -1;
+        }
+    }
+
+    if (!files->certpath &&
+        !files->keypath) {
+        return 0;
+    }
+    if (files->certpath && !files->keypath) {
+        error_setg(errp, "Cert '%s' without corresponding key",
+                   files->certpath);
+        return -1;
+    }
+    if (!files->certpath && files->keypath) {
+        error_setg(errp, "Key '%s' without corresponding cert",
+                   files->keypath);
+        return -1;
+    }
+
+    if (qcrypto_tls_creds_load_cert_list(creds,
+                                         files->certpath,
+                                         &files->certs,
+                                         &files->ncerts,
+                                         errp) < 0) {
+        return -1;
+    }
+
+    if (qcrypto_tls_creds_load_privkey(creds,
+                                       files->keypath,
+                                       &files->key,
+                                       errp) < 0) {
+        return -1;
+    }
+
+    ret = gnutls_certificate_set_x509_key(box->data.cert,
+                                          files->certs,
+                                          files->ncerts,
+                                          files->key);
+    if (ret < 0) {
+        error_setg(errp, "Cannot set certificate '%s' & key '%s': %s",
+                   files->certpath, files->keypath, gnutls_strerror(ret));
+        return -1;
+    }
+    return 0;
+}
+
+
 static int
 qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
                             Error **errp)
@@ -613,8 +721,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     g_autoptr(QCryptoTLSCredsBox) box = NULL;
     g_autoptr(QCryptoTLSCredsX509Files) files = NULL;
     g_autofree char *cacrl = NULL;
-    g_autofree char *cert = NULL;
-    g_autofree char *key = NULL;
     g_autofree char *dhparams = NULL;
     bool isServer = (creds->parent_obj.endpoint ==
                      QCRYPTO_TLS_CREDS_ENDPOINT_SERVER);
@@ -646,60 +752,27 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         return -1;
     }
 
+    if (qcrypto_tls_creds_x509_load_identity(creds, box, files,
+                                             isServer, errp) < 0) {
+        return -1;
+    }
+
     if (isServer) {
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CA_CRL,
                                        false, &cacrl, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_SERVER_CERT,
-                                       true, &cert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_SERVER_KEY,
-                                       true, &key, errp) < 0 ||
             qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
             return -1;
         }
-    } else {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
-                                       false, &cert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
-                                       false, &key, errp) < 0) {
-            return -1;
-        }
     }
 
     if (creds->sanityCheck &&
-        qcrypto_tls_creds_x509_sanity_check(creds, files, isServer,
-                                            cert, errp) < 0) {
+        qcrypto_tls_creds_x509_sanity_check(creds, files, isServer, errp) < 0) {
         return -1;
     }
 
-    if (cert != NULL && key != NULL) {
-        char *password = NULL;
-        if (creds->passwordid) {
-            password = qcrypto_secret_lookup_as_utf8(creds->passwordid,
-                                                     errp);
-            if (!password) {
-                return -1;
-            }
-        }
-        ret = gnutls_certificate_set_x509_key_file2(box->data.cert,
-                                                    cert, key,
-                                                    GNUTLS_X509_FMT_PEM,
-                                                    password,
-                                                    0);
-        g_free(password);
-        if (ret < 0) {
-            error_setg(errp, "Cannot load certificate '%s' & key '%s': %s",
-                       cert, key, gnutls_strerror(ret));
-            return -1;
-        }
-    }
-
     if (cacrl != NULL) {
         ret = gnutls_certificate_set_x509_crl_file(box->data.cert,
                                                    cacrl,
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index a5f21728d4..b1ad7d5c0d 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -95,16 +95,16 @@ static void test_tls_creds(const void *opaque)
         if (access(data->crt, R_OK) == 0) {
             g_assert(link(data->crt,
                           CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT) == 0);
+            g_assert(link(KEYFILE,
+                          CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) == 0);
         }
-        g_assert(link(KEYFILE,
-                      CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_KEY) == 0);
     } else {
         if (access(data->crt, R_OK) == 0) {
             g_assert(link(data->crt,
                           CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_CERT) == 0);
+            g_assert(link(KEYFILE,
+                          CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) == 0);
         }
-        g_assert(link(KEYFILE,
-                      CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) == 0);
     }
 
     creds = test_tls_creds_create(
-- 
2.51.1


