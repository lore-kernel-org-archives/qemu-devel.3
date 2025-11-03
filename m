Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A25CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuoC-0001e3-Gm; Mon, 03 Nov 2025 08:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunu-0001Pd-89
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuno-0004kk-JK
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i+wl3Y233lrhS1xjLwDeX9h6halIAMNlbqNzecBa4Sk=;
 b=SoY0ZiGiwa/tfIe2KruKc3MFsqgjnPF3VjyKFc++7VSQyVnrGriUCjCLh9vOa9avOkUqyO
 FKARO1pBMtiNrQnF7nsRkOSHcVW+v+QY7npfQVdwLz5E02VCIPPFvJgZnPNqkkpMG3cCOG
 H4JcUiNpeRduyAcGgiihHHfUOn+gShQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-rdWFTPlIPnmiAeQ_MwaOpQ-1; Mon,
 03 Nov 2025 08:40:49 -0500
X-MC-Unique: rdWFTPlIPnmiAeQ_MwaOpQ-1
X-Mimecast-MFC-AGG-ID: rdWFTPlIPnmiAeQ_MwaOpQ_1762177248
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35D1518009C2; Mon,  3 Nov 2025 13:40:48 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D58AD180057A; Mon,  3 Nov 2025 13:40:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 28/32] crypto: avoid loading the CA certs twice
Date: Mon,  3 Nov 2025 13:37:22 +0000
Message-ID: <20251103133727.423041-29-berrange@redhat.com>
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

The x509 TLS credentials code will load the CA certs once to perform
sanity chcking on the certs, then discard the certificate objects
and let gnutls load them a second time.

This introduces a new QCryptoTLSCredsX509Files struct which will
hold the CA certificates loaded for sanity checking and pass them on
to gnutls, avoiding the duplicated loading.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 141 ++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 54 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index e28fcdc6ff..911942a1a1 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -40,6 +40,35 @@ struct QCryptoTLSCredsX509 {
 #include <gnutls/x509.h>
 
 
+typedef struct QCryptoTLSCredsX509Files QCryptoTLSCredsX509Files;
+struct QCryptoTLSCredsX509Files {
+    char *cacertpath;
+    gnutls_x509_crt_t *cacerts;
+    unsigned int ncacerts;
+};
+
+static QCryptoTLSCredsX509Files *
+qcrypto_tls_creds_x509_files_new(void)
+{
+    return g_new0(QCryptoTLSCredsX509Files, 1);
+}
+
+
+static void
+qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
+{
+    size_t i;
+    for (i = 0; i < files->ncacerts; i++) {
+        gnutls_x509_crt_deinit(files->cacerts[i]);
+    }
+    g_free(files->cacerts);
+    g_free(files->cacertpath);
+    g_free(files);
+}
+
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsX509Files,
+                              qcrypto_tls_creds_x509_files_free);
+
 static int
 qcrypto_tls_creds_check_cert_times(gnutls_x509_crt_t cert,
                                    const char *certFile,
@@ -315,11 +344,9 @@ qcrypto_tls_creds_check_cert(QCryptoTLSCredsX509 *creds,
 
 static int
 qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
+                                        QCryptoTLSCredsX509Files *files,
                                         gnutls_x509_crt_t *certs,
                                         unsigned int ncerts,
-                                        gnutls_x509_crt_t *cacerts,
-                                        unsigned int ncacerts,
-                                        const char *cacertFile,
                                         bool isServer,
                                         Error **errp)
 {
@@ -360,13 +387,13 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
              * reached the root of trust.
              */
             return qcrypto_tls_creds_check_cert(
-                creds, cert_to_check, cacertFile,
+                creds, cert_to_check, files->cacertpath,
                 isServer, true, errp);
         }
-        for (int i = 0; i < ncacerts; i++) {
+        for (int i = 0; i < files->ncacerts; i++) {
             if (gnutls_x509_crt_check_issuer(cert_to_check,
-                                             cacerts[i])) {
-                cert_issuer = cacerts[i];
+                                             files->cacerts[i])) {
+                cert_issuer = files->cacerts[i];
                 break;
             }
         }
@@ -374,7 +401,7 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
             break;
         }
 
-        if (qcrypto_tls_creds_check_cert(creds, cert_issuer, cacertFile,
+        if (qcrypto_tls_creds_check_cert(creds, cert_issuer, files->cacertpath,
                                          isServer, true, errp) < 0) {
             return -1;
         }
@@ -394,19 +421,17 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
 }
 
 static int
-qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t *certs,
+qcrypto_tls_creds_check_cert_pair(QCryptoTLSCredsX509Files *files,
+                                  gnutls_x509_crt_t *certs,
                                   size_t ncerts,
                                   const char *certFile,
-                                  gnutls_x509_crt_t *cacerts,
-                                  size_t ncacerts,
-                                  const char *cacertFile,
                                   bool isServer,
                                   Error **errp)
 {
     unsigned int status;
 
     if (gnutls_x509_crt_list_verify(certs, ncerts,
-                                    cacerts, ncacerts,
+                                    files->cacerts, files->ncacerts,
                                     NULL, 0,
                                     0, &status) < 0) {
         error_setg(errp, isServer ?
@@ -414,7 +439,7 @@ qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t *certs,
                    "CA certificate %s" :
                    "Unable to verify client certificate %s against "
                    "CA certificate %s",
-                   certFile, cacertFile);
+                   certFile, files->cacertpath);
         return -1;
     }
 
@@ -439,7 +464,7 @@ qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t *certs,
 
         error_setg(errp,
                    "Our own certificate %s failed validation against %s: %s",
-                   certFile, cacertFile, reason);
+                   certFile, files->cacertpath, reason);
         return -1;
     }
 
@@ -490,15 +515,13 @@ qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX509 *creds,
 
 static int
 qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
+                                    QCryptoTLSCredsX509Files *files,
                                     bool isServer,
-                                    const char *cacertFile,
                                     const char *certFile,
                                     Error **errp)
 {
     gnutls_x509_crt_t *certs = NULL;
     unsigned int ncerts = 0;
-    gnutls_x509_crt_t *cacerts = NULL;
-    unsigned int ncacerts = 0;
     size_t i;
     int ret = -1;
 
@@ -514,16 +537,6 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
         }
     }
 
-    if (qcrypto_tls_creds_load_cert_list(creds,
-                                         cacertFile,
-                                         &cacerts,
-                                         &ncacerts,
-                                         isServer,
-                                         true,
-                                         errp) < 0) {
-        goto cleanup;
-    }
-
     for (i = 0; i < ncerts; i++) {
         if (qcrypto_tls_creds_check_cert(creds,
                                          certs[i], certFile,
@@ -533,17 +546,14 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
     }
 
     if (ncerts &&
-        qcrypto_tls_creds_check_authority_chain(creds,
+        qcrypto_tls_creds_check_authority_chain(creds, files,
                                                 certs, ncerts,
-                                                cacerts, ncacerts,
-                                                cacertFile, isServer,
-                                                errp) < 0) {
+                                                isServer, errp) < 0) {
         goto cleanup;
     }
 
-    if (ncerts && ncacerts &&
-        qcrypto_tls_creds_check_cert_pair(certs, ncerts, certFile,
-                                          cacerts, ncacerts, cacertFile,
+    if (ncerts &&
+        qcrypto_tls_creds_check_cert_pair(files, certs, ncerts, certFile,
                                           isServer, errp) < 0) {
         goto cleanup;
     }
@@ -555,21 +565,53 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
         gnutls_x509_crt_deinit(certs[i]);
     }
     g_free(certs);
-    for (i = 0; i < ncacerts; i++) {
-        gnutls_x509_crt_deinit(cacerts[i]);
-    }
-    g_free(cacerts);
 
     return ret;
 }
 
 
+static int
+qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
+                               QCryptoTLSCredsBox *box,
+                               QCryptoTLSCredsX509Files *files,
+                               bool isServer,
+                               Error **errp)
+{
+    int ret;
+
+    if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                   QCRYPTO_TLS_CREDS_X509_CA_CERT,
+                                   true, &files->cacertpath, errp) < 0) {
+        return -1;
+    }
+
+    if (qcrypto_tls_creds_load_cert_list(creds,
+                                         files->cacertpath,
+                                         &files->cacerts,
+                                         &files->ncacerts,
+                                         isServer,
+                                         true,
+                                         errp) < 0) {
+        return -1;
+    }
+
+    ret = gnutls_certificate_set_x509_trust(box->data.cert,
+                                            files->cacerts, files->ncacerts);
+    if (ret < 0) {
+        error_setg(errp, "Cannot set CA certificate '%s': %s",
+                   files->cacertpath, gnutls_strerror(ret));
+        return -1;
+    }
+
+    return 0;
+}
+
 static int
 qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
                             Error **errp)
 {
     g_autoptr(QCryptoTLSCredsBox) box = NULL;
-    g_autofree char *cacert = NULL;
+    g_autoptr(QCryptoTLSCredsX509Files) files = NULL;
     g_autofree char *cacrl = NULL;
     g_autofree char *cert = NULL;
     g_autofree char *key = NULL;
@@ -598,9 +640,9 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         return -1;
     }
 
-    if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                   QCRYPTO_TLS_CREDS_X509_CA_CERT,
-                                   true, &cacert, errp) < 0) {
+    files = qcrypto_tls_creds_x509_files_new();
+
+    if (qcrypto_tls_creds_x509_load_ca(creds, box, files, isServer, errp) < 0) {
         return -1;
     }
 
@@ -631,17 +673,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     }
 
     if (creds->sanityCheck &&
-        qcrypto_tls_creds_x509_sanity_check(creds, isServer,
-                                            cacert, cert, errp) < 0) {
-        return -1;
-    }
-
-    ret = gnutls_certificate_set_x509_trust_file(box->data.cert,
-                                                 cacert,
-                                                 GNUTLS_X509_FMT_PEM);
-    if (ret < 0) {
-        error_setg(errp, "Cannot load CA certificate '%s': %s",
-                   cacert, gnutls_strerror(ret));
+        qcrypto_tls_creds_x509_sanity_check(creds, files, isServer,
+                                            cert, errp) < 0) {
         return -1;
     }
 
-- 
2.51.1


