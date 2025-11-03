Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832D3CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuoG-0001yW-4x; Mon, 03 Nov 2025 08:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuoA-0001jC-6m
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuo0-0004ll-38
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+4yftrUZg3uTbuzR4wx/X192jBUfkk4YqQFxscmreWM=;
 b=VLho1ssoA7fHAdP/yMkBZ3/UVSisHRIFvpOcWlU03/AlLKNszvaItI3i6YWfIUWjYEq/mZ
 rpFQZl3E+k8/9YlvKTPzJDAOUDZtGez2RwURZ+rIgPGoOdX3m+CIX4Hut6zxmfMv7rTxhg
 s2E1vP7MqnZ0Ta7IPfiq9VXD73wY+mQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-1-ARyqrvOja48pQXFC7CfQ-1; Mon,
 03 Nov 2025 08:41:01 -0500
X-MC-Unique: 1-ARyqrvOja48pQXFC7CfQ-1
X-Mimecast-MFC-AGG-ID: 1-ARyqrvOja48pQXFC7CfQ_1762177260
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3C6D1955F2E; Mon,  3 Nov 2025 13:41:00 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52CEB1800578; Mon,  3 Nov 2025 13:40:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 30/32] crypto: expand logic to cope with multiple certificate
 identities
Date: Mon,  3 Nov 2025 13:37:24 +0000
Message-ID: <20251103133727.423041-31-berrange@redhat.com>
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

Currently only a single set of certificates can be loaded for a
server / client. Certificates are created using a particular
key algorithm and in some scenarios it can be useful to support
multiple algorithms in parallel. This requires the ability to
load multiple sets of certificates.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 165 +++++++++++++++++++++++++++++-------------
 1 file changed, 113 insertions(+), 52 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index c016633d65..ecffde67c5 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -40,17 +40,23 @@ struct QCryptoTLSCredsX509 {
 #include <gnutls/x509.h>
 
 
+typedef struct QCryptoTLSCredsX509IdentFiles QCryptoTLSCredsX509IdentFiles;
+struct QCryptoTLSCredsX509IdentFiles {
+    char *certpath;
+    char *keypath;
+    gnutls_x509_crt_t *certs;
+    unsigned int ncerts;
+    gnutls_x509_privkey_t key;
+};
+
 typedef struct QCryptoTLSCredsX509Files QCryptoTLSCredsX509Files;
 struct QCryptoTLSCredsX509Files {
     char *cacertpath;
     gnutls_x509_crt_t *cacerts;
     unsigned int ncacerts;
 
-    char *certpath;
-    char *keypath;
-    gnutls_x509_crt_t *certs;
-    unsigned int ncerts;
-    gnutls_x509_privkey_t key;
+    QCryptoTLSCredsX509IdentFiles **identities;
+    size_t nidentities;
 };
 
 static QCryptoTLSCredsX509Files *
@@ -61,14 +67,9 @@ qcrypto_tls_creds_x509_files_new(void)
 
 
 static void
-qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
+qcrypto_tls_creds_x509_ident_files_free(QCryptoTLSCredsX509IdentFiles *files)
 {
     size_t i;
-    for (i = 0; i < files->ncacerts; i++) {
-        gnutls_x509_crt_deinit(files->cacerts[i]);
-    }
-    g_free(files->cacerts);
-    g_free(files->cacertpath);
     for (i = 0; i < files->ncerts; i++) {
         gnutls_x509_crt_deinit(files->certs[i]);
     }
@@ -79,6 +80,26 @@ qcrypto_tls_creds_x509_files_free(QCryptoTLSCredsX509Files *files)
     g_free(files);
 }
 
+G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsX509IdentFiles,
+                              qcrypto_tls_creds_x509_ident_files_free);
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
+    for (i = 0; i < files->nidentities; i++) {
+        qcrypto_tls_creds_x509_ident_files_free(files->identities[i]);
+    }
+    g_free(files->identities);
+    g_free(files);
+}
+
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoTLSCredsX509Files,
                               qcrypto_tls_creds_x509_files_free);
 
@@ -573,33 +594,32 @@ qcrypto_tls_creds_load_privkey(QCryptoTLSCredsX509 *creds,
 
 
 static int
-qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
-                                    QCryptoTLSCredsX509Files *files,
-                                    bool isServer,
-                                    Error **errp)
+qcrypto_tls_creds_x509_sanity_check_identity(QCryptoTLSCredsX509 *creds,
+                                             QCryptoTLSCredsX509Files *files,
+                                             QCryptoTLSCredsX509IdentFiles *ifiles,
+                                             bool isServer,
+                                             Error **errp)
 {
     size_t i;
 
-    for (i = 0; i < files->ncerts; i++) {
+    for (i = 0; i < ifiles->ncerts; i++) {
         if (qcrypto_tls_creds_check_cert(creds,
-                                         files->certs[i], files->certpath,
+                                         ifiles->certs[i], ifiles->certpath,
                                          isServer, i != 0, errp) < 0) {
             return -1;
         }
     }
 
-    if (files->ncerts &&
+    if (ifiles->ncerts &&
         qcrypto_tls_creds_check_authority_chain(creds, files,
-                                                files->certs, files->ncerts,
+                                                ifiles->certs, ifiles->ncerts,
                                                 isServer, errp) < 0) {
         return -1;
     }
 
-    if (files->ncerts &&
-        qcrypto_tls_creds_check_cert_pair(files,
-                                          files->certs, files->ncerts,
-                                          files->certpath, isServer,
-                                          errp) < 0) {
+    if (ifiles->ncerts &&
+        qcrypto_tls_creds_check_cert_pair(files, ifiles->certs, ifiles->ncerts,
+                                          ifiles->certpath, isServer, errp) < 0) {
         return -1;
     }
 
@@ -607,6 +627,26 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
 }
 
 
+static int
+qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
+                                    QCryptoTLSCredsX509Files *files,
+                                    bool isServer,
+                                    Error **errp)
+{
+    size_t i;
+    for (i = 0; i < files->nidentities; i++) {
+        if (qcrypto_tls_creds_x509_sanity_check_identity(creds,
+                                                         files,
+                                                         files->identities[i],
+                                                         isServer,
+                                                         errp) < 0) {
+            return -1;
+        }
+    }
+    return 0;
+}
+
+
 static int
 qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
                                QCryptoTLSCredsBox *box,
@@ -642,48 +682,38 @@ qcrypto_tls_creds_x509_load_ca(QCryptoTLSCredsX509 *creds,
 }
 
 
-static int
+static QCryptoTLSCredsX509IdentFiles *
 qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
                                      QCryptoTLSCredsBox *box,
-                                     QCryptoTLSCredsX509Files *files,
-                                     bool isServer,
+                                     const char *certbase,
+                                     const char *keybase,
+                                     bool isOptional,
                                      Error **errp)
 {
+    g_autoptr(QCryptoTLSCredsX509IdentFiles) files =
+        g_new0(QCryptoTLSCredsX509IdentFiles, 1);
     int ret;
 
-    if (isServer) {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_SERVER_CERT,
-                                       true, &files->certpath, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_SERVER_KEY,
-                                       true, &files->keypath, errp) < 0) {
-            return -1;
-        }
-    } else {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
-                                       false, &files->certpath, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
-                                       QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
-                                       false, &files->keypath, errp) < 0) {
-            return -1;
-        }
+    if (qcrypto_tls_creds_get_path(&creds->parent_obj, certbase,
+                                   !isOptional, &files->certpath, errp) < 0 ||
+        qcrypto_tls_creds_get_path(&creds->parent_obj, keybase,
+                                   !isOptional, &files->keypath, errp) < 0) {
+        return NULL;
     }
 
     if (!files->certpath &&
         !files->keypath) {
-        return 0;
+        return NULL;
     }
     if (files->certpath && !files->keypath) {
         error_setg(errp, "Cert '%s' without corresponding key",
                    files->certpath);
-        return -1;
+        return NULL;
     }
     if (!files->certpath && files->keypath) {
         error_setg(errp, "Key '%s' without corresponding cert",
                    files->keypath);
-        return -1;
+        return NULL;
     }
 
     if (qcrypto_tls_creds_load_cert_list(creds,
@@ -691,14 +721,14 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
                                          &files->certs,
                                          &files->ncerts,
                                          errp) < 0) {
-        return -1;
+        return NULL;
     }
 
     if (qcrypto_tls_creds_load_privkey(creds,
                                        files->keypath,
                                        &files->key,
                                        errp) < 0) {
-        return -1;
+        return NULL;
     }
 
     ret = gnutls_certificate_set_x509_key(box->data.cert,
@@ -708,8 +738,39 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
     if (ret < 0) {
         error_setg(errp, "Cannot set certificate '%s' & key '%s': %s",
                    files->certpath, files->keypath, gnutls_strerror(ret));
+        return NULL;
+    }
+    return g_steal_pointer(&files);
+}
+
+
+static int
+qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX509 *creds,
+                                       QCryptoTLSCredsBox *box,
+                                       QCryptoTLSCredsX509Files *files,
+                                       bool isServer,
+                                       Error **errp)
+{
+    QCryptoTLSCredsX509IdentFiles *ifiles;
+
+    ifiles = qcrypto_tls_creds_x509_load_identity(
+        creds, box,
+        isServer ?
+        QCRYPTO_TLS_CREDS_X509_SERVER_CERT :
+        QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
+        isServer ?
+        QCRYPTO_TLS_CREDS_X509_SERVER_KEY :
+        QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
+        !isServer, errp);
+    if (!ifiles) {
         return -1;
     }
+
+    files->identities = g_renew(QCryptoTLSCredsX509IdentFiles *,
+                                files->identities,
+                                files->nidentities + 1);
+    files->identities[files->nidentities++] = ifiles;
+
     return 0;
 }
 
@@ -752,8 +813,8 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         return -1;
     }
 
-    if (qcrypto_tls_creds_x509_load_identity(creds, box, files,
-                                             isServer, errp) < 0) {
+    if (qcrypto_tls_creds_x509_load_identities(creds, box, files,
+                                               isServer, errp) < 0) {
         return -1;
     }
 
-- 
2.51.1


