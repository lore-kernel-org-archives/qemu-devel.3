Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941E4CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETzg-0002MD-JQ; Thu, 30 Oct 2025 10:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyq-0001Wf-LK
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyX-0001Ul-6w
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/D70kzgtrLBwWgSU65b5pxR7c12Wlbw6pWyofFb2I4=;
 b=cXsDslGvnsBOcKibO8UJQXr5f2k/4tpzBwviyn6LOacvZ91NJL0V40MbniCp4M8spEGoFw
 eYiZ010vKJUt9fl40IGbC47aug8HxQXvET4nTQ9JnBPzCPNWy/fm6KXD2YzCmbXlib83Iw
 At3Rq8bzgxnPGHpXUuqX6llEGgOCfQc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-c3kzRg5zOjyZMHzvv7eSEA-1; Thu,
 30 Oct 2025 10:49:58 -0400
X-MC-Unique: c3kzRg5zOjyZMHzvv7eSEA-1
X-Mimecast-MFC-AGG-ID: c3kzRg5zOjyZMHzvv7eSEA_1761835797
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938861801A13; Thu, 30 Oct 2025 14:49:57 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1890B30001A1; Thu, 30 Oct 2025 14:49:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 14/21] crypto: fix lifecycle handling of gnutls credentials
 objects
Date: Thu, 30 Oct 2025 14:49:20 +0000
Message-ID: <20251030144927.2241109-15-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-1-berrange@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

As described in the previous commit, the gnutls credentials need to
be kept alive for as long as the gnutls session object exists. Convert
the QCryptoTLSCreds objects to use QCryptoTLSCredsBox and holding the
gnutls credential objects. When loading the credentials into a gnutls
session, store a reference to the box into the QCryptoTLSSession object.

This has the useful side effect that the QCryptoTLSSession code no
longer needs to know about all the different credential types, it can
use the generic pointer stored in the box.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c     |  5 +--
 crypto/tlscredsanon.c | 48 +++++---------------------
 crypto/tlscredspriv.h | 20 ++---------
 crypto/tlscredspsk.c  | 46 ++++++++-----------------
 crypto/tlscredsx509.c | 71 +++++++++++++-------------------------
 crypto/tlssession.c   | 80 ++++++++++++++-----------------------------
 6 files changed, 75 insertions(+), 195 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 9433b4c363..798c9712fb 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -246,10 +246,7 @@ qcrypto_tls_creds_finalize(Object *obj)
 {
     QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(obj);
 
-    if (creds->dh_params) {
-        gnutls_dh_params_deinit(creds->dh_params);
-    }
-
+    qcrypto_tls_creds_box_unref(creds->box);
     g_free(creds->dir);
     g_free(creds->priority);
 }
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 5c55b07b2f..0a728ccbf6 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -36,6 +36,7 @@ static int
 qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
                             Error **errp)
 {
+    g_autoptr(QCryptoTLSCredsBox) box = NULL;
     g_autofree char *dhparams = NULL;
     int ret;
 
@@ -43,6 +44,8 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
             creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
 
     if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        box = qcrypto_tls_creds_box_new_server(GNUTLS_CRD_ANON);
+
         if (creds->parent_obj.dir &&
             qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
@@ -50,7 +53,7 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
             return -1;
         }
 
-        ret = gnutls_anon_allocate_server_credentials(&creds->data.server);
+        ret = gnutls_anon_allocate_server_credentials(&box->data.anonserver);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
@@ -58,42 +61,26 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
         }
 
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
-                                                 &creds->parent_obj.dh_params,
-                                                 errp) < 0) {
+                                                 &box->dh_params, errp) < 0) {
             return -1;
         }
 
-        gnutls_anon_set_server_dh_params(creds->data.server,
-                                         creds->parent_obj.dh_params);
+        gnutls_anon_set_server_dh_params(box->data.anonserver,
+                                         box->dh_params);
     } else {
-        ret = gnutls_anon_allocate_client_credentials(&creds->data.client);
+        ret = gnutls_anon_allocate_client_credentials(&box->data.anonclient);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
             return -1;
         }
     }
+    creds->parent_obj.box = g_steal_pointer(&box);
 
     return 0;
 }
 
 
-static void
-qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds)
-{
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
-        if (creds->data.client) {
-            gnutls_anon_free_client_credentials(creds->data.client);
-            creds->data.client = NULL;
-        }
-    } else {
-        if (creds->data.server) {
-            gnutls_anon_free_server_credentials(creds->data.server);
-            creds->data.server = NULL;
-        }
-    }
-}
-
 #else /* ! CONFIG_GNUTLS */
 
 
@@ -105,13 +92,6 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds G_GNUC_UNUSED,
 }
 
 
-static void
-qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds G_GNUC_UNUSED)
-{
-    /* nada */
-}
-
-
 #endif /* ! CONFIG_GNUTLS */
 
 
@@ -124,15 +104,6 @@ qcrypto_tls_creds_anon_complete(UserCreatable *uc, Error **errp)
 }
 
 
-static void
-qcrypto_tls_creds_anon_finalize(Object *obj)
-{
-    QCryptoTLSCredsAnon *creds = QCRYPTO_TLS_CREDS_ANON(obj);
-
-    qcrypto_tls_creds_anon_unload(creds);
-}
-
-
 static void
 qcrypto_tls_creds_anon_class_init(ObjectClass *oc, const void *data)
 {
@@ -148,7 +119,6 @@ static const TypeInfo qcrypto_tls_creds_anon_info = {
     .parent = TYPE_QCRYPTO_TLS_CREDS,
     .name = TYPE_QCRYPTO_TLS_CREDS_ANON,
     .instance_size = sizeof(QCryptoTLSCredsAnon),
-    .instance_finalize = qcrypto_tls_creds_anon_finalize,
     .class_size = sizeof(QCryptoTLSCredsAnonClass),
     .class_init = qcrypto_tls_creds_anon_class_init,
     .interfaces = (const InterfaceInfo[]) {
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
index df9815a286..4e6dffa22f 100644
--- a/crypto/tlscredspriv.h
+++ b/crypto/tlscredspriv.h
@@ -22,6 +22,7 @@
 #define QCRYPTO_TLSCREDSPRIV_H
 
 #include "crypto/tlscreds.h"
+#include "crypto/tlscredsbox.h"
 
 #ifdef CONFIG_GNUTLS
 #include <gnutls/gnutls.h>
@@ -31,39 +32,22 @@ struct QCryptoTLSCreds {
     Object parent_obj;
     char *dir;
     QCryptoTLSCredsEndpoint endpoint;
-#ifdef CONFIG_GNUTLS
-    gnutls_dh_params_t dh_params;
-#endif
     bool verifyPeer;
     char *priority;
+    QCryptoTLSCredsBox *box;
 };
 
 struct QCryptoTLSCredsAnon {
     QCryptoTLSCreds parent_obj;
-#ifdef CONFIG_GNUTLS
-    union {
-        gnutls_anon_server_credentials_t server;
-        gnutls_anon_client_credentials_t client;
-    } data;
-#endif
 };
 
 struct QCryptoTLSCredsPSK {
     QCryptoTLSCreds parent_obj;
     char *username;
-#ifdef CONFIG_GNUTLS
-    union {
-        gnutls_psk_server_credentials_t server;
-        gnutls_psk_client_credentials_t client;
-    } data;
-#endif
 };
 
 struct QCryptoTLSCredsX509 {
     QCryptoTLSCreds parent_obj;
-#ifdef CONFIG_GNUTLS
-    gnutls_certificate_credentials_t data;
-#endif
     bool sanityCheck;
     char *passwordid;
 };
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 6c2feae077..5568f1ad0c 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -71,6 +71,7 @@ static int
 qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
                            Error **errp)
 {
+    g_autoptr(QCryptoTLSCredsBox) box = NULL;
     g_autofree char *pskfile = NULL;
     g_autofree char *dhparams = NULL;
     const char *username;
@@ -87,6 +88,8 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
     }
 
     if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        box = qcrypto_tls_creds_box_new_server(GNUTLS_CRD_PSK);
+
         if (creds->username) {
             error_setg(errp, "username should not be set when endpoint=server");
             goto cleanup;
@@ -101,7 +104,7 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
             goto cleanup;
         }
 
-        ret = gnutls_psk_allocate_server_credentials(&creds->data.server);
+        ret = gnutls_psk_allocate_server_credentials(&box->data.pskserver);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
@@ -109,20 +112,23 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
         }
 
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
-                                                 &creds->parent_obj.dh_params,
+                                                 &box->dh_params,
                                                  errp) < 0) {
             goto cleanup;
         }
 
-        ret = gnutls_psk_set_server_credentials_file(creds->data.server, pskfile);
+        ret = gnutls_psk_set_server_credentials_file(box->data.pskserver,
+                                                     pskfile);
         if (ret < 0) {
             error_setg(errp, "Cannot set PSK server credentials: %s",
                        gnutls_strerror(ret));
             goto cleanup;
         }
-        gnutls_psk_set_server_dh_params(creds->data.server,
-                                        creds->parent_obj.dh_params);
+        gnutls_psk_set_server_dh_params(box->data.pskserver,
+                                        box->dh_params);
     } else {
+        box = qcrypto_tls_creds_box_new_client(GNUTLS_CRD_PSK);
+
         if (qcrypto_tls_creds_get_path(&creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_PSKFILE,
                                        true, &pskfile, errp) < 0) {
@@ -138,14 +144,14 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
             goto cleanup;
         }
 
-        ret = gnutls_psk_allocate_client_credentials(&creds->data.client);
+        ret = gnutls_psk_allocate_client_credentials(&box->data.pskclient);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
             goto cleanup;
         }
 
-        ret = gnutls_psk_set_client_credentials(creds->data.client,
+        ret = gnutls_psk_set_client_credentials(box->data.pskclient,
                                                 username, &key, GNUTLS_PSK_KEY_HEX);
         if (ret < 0) {
             error_setg(errp, "Cannot set PSK client credentials: %s",
@@ -153,6 +159,7 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
             goto cleanup;
         }
     }
+    creds->parent_obj.box = g_steal_pointer(&box);
 
     rv = 0;
  cleanup:
@@ -160,23 +167,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
     return rv;
 }
 
-
-static void
-qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds)
-{
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
-        if (creds->data.client) {
-            gnutls_psk_free_client_credentials(creds->data.client);
-            creds->data.client = NULL;
-        }
-    } else {
-        if (creds->data.server) {
-            gnutls_psk_free_server_credentials(creds->data.server);
-            creds->data.server = NULL;
-        }
-    }
-}
-
 #else /* ! CONFIG_GNUTLS */
 
 
@@ -188,13 +178,6 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds G_GNUC_UNUSED,
 }
 
 
-static void
-qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds G_GNUC_UNUSED)
-{
-    /* nada */
-}
-
-
 #endif /* ! CONFIG_GNUTLS */
 
 
@@ -212,7 +195,6 @@ qcrypto_tls_creds_psk_finalize(Object *obj)
 {
     QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
 
-    qcrypto_tls_creds_psk_unload(creds);
     g_free(creds->username);
 }
 
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index f2f1aa2815..ef31ea664c 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -562,6 +562,7 @@ static int
 qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
                             Error **errp)
 {
+    g_autoptr(QCryptoTLSCredsBox) box = NULL;
     g_autofree char *cacert = NULL;
     g_autofree char *cacrl = NULL;
     g_autofree char *cert = NULL;
@@ -578,6 +579,19 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
 
     trace_qcrypto_tls_creds_x509_load(creds, creds->parent_obj.dir);
 
+    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        box = qcrypto_tls_creds_box_new_server(GNUTLS_CRD_CERTIFICATE);
+    } else {
+        box = qcrypto_tls_creds_box_new_client(GNUTLS_CRD_CERTIFICATE);
+    }
+
+    ret = gnutls_certificate_allocate_credentials(&box->data.cert);
+    if (ret < 0) {
+        error_setg(errp, "Cannot allocate credentials: '%s'",
+                   gnutls_strerror(ret));
+        return -1;
+    }
+
     if (qcrypto_tls_creds_get_path(&creds->parent_obj,
                                    QCRYPTO_TLS_CREDS_X509_CA_CERT,
                                    true, &cacert, errp) < 0) {
@@ -616,14 +630,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         return -1;
     }
 
-    ret = gnutls_certificate_allocate_credentials(&creds->data);
-    if (ret < 0) {
-        error_setg(errp, "Cannot allocate credentials: '%s'",
-                   gnutls_strerror(ret));
-        return -1;
-    }
-
-    ret = gnutls_certificate_set_x509_trust_file(creds->data,
+    ret = gnutls_certificate_set_x509_trust_file(box->data.cert,
                                                  cacert,
                                                  GNUTLS_X509_FMT_PEM);
     if (ret < 0) {
@@ -641,7 +648,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
                 return -1;
             }
         }
-        ret = gnutls_certificate_set_x509_key_file2(creds->data,
+        ret = gnutls_certificate_set_x509_key_file2(box->data.cert,
                                                     cert, key,
                                                     GNUTLS_X509_FMT_PEM,
                                                     password,
@@ -655,7 +662,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     }
 
     if (cacrl != NULL) {
-        ret = gnutls_certificate_set_x509_crl_file(creds->data,
+        ret = gnutls_certificate_set_x509_crl_file(box->data.cert,
                                                    cacrl,
                                                    GNUTLS_X509_FMT_PEM);
         if (ret < 0) {
@@ -667,28 +674,18 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
 
     if (isServer) {
         if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
-                                                 &creds->parent_obj.dh_params,
+                                                 &box->dh_params,
                                                  errp) < 0) {
             return -1;
         }
-        gnutls_certificate_set_dh_params(creds->data,
-                                         creds->parent_obj.dh_params);
+        gnutls_certificate_set_dh_params(box->data.cert, box->dh_params);
     }
+    creds->parent_obj.box = g_steal_pointer(&box);
 
     return 0;
 }
 
 
-static void
-qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds)
-{
-    if (creds->data) {
-        gnutls_certificate_free_credentials(creds->data);
-        creds->data = NULL;
-    }
-}
-
-
 #else /* ! CONFIG_GNUTLS */
 
 
@@ -700,13 +697,6 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds G_GNUC_UNUSED,
 }
 
 
-static void
-qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds G_GNUC_UNUSED)
-{
-    /* nada */
-}
-
-
 #endif /* ! CONFIG_GNUTLS */
 
 
@@ -769,29 +759,17 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds, Error **errp)
 {
     QCryptoTLSCredsX509 *x509_creds = QCRYPTO_TLS_CREDS_X509(creds);
     Error *local_err = NULL;
-    gnutls_certificate_credentials_t creds_data = x509_creds->data;
-    gnutls_dh_params_t creds_dh_params = creds->dh_params;
+    QCryptoTLSCredsBox *creds_box = creds->box;
 
-    x509_creds->data = NULL;
-    creds->dh_params = NULL;
+    creds->box = NULL;
     qcrypto_tls_creds_x509_load(x509_creds, &local_err);
     if (local_err) {
-        qcrypto_tls_creds_x509_unload(x509_creds);
-        if (creds->dh_params) {
-            gnutls_dh_params_deinit(creds->dh_params);
-        }
-        x509_creds->data = creds_data;
-        creds->dh_params = creds_dh_params;
+        creds->box = creds_box;
         error_propagate(errp, local_err);
         return false;
     }
 
-    if (creds_data) {
-        gnutls_certificate_free_credentials(creds_data);
-    }
-    if (creds_dh_params) {
-        gnutls_dh_params_deinit(creds_dh_params);
-    }
+    qcrypto_tls_creds_box_unref(creds_box);
     return true;
 }
 
@@ -824,7 +802,6 @@ qcrypto_tls_creds_x509_finalize(Object *obj)
     QCryptoTLSCredsX509 *creds = QCRYPTO_TLS_CREDS_X509(obj);
 
     g_free(creds->passwordid);
-    qcrypto_tls_creds_x509_unload(creds);
 }
 
 
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 77f334add3..a1dc3b3ce0 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -38,6 +38,7 @@
 
 struct QCryptoTLSSession {
     QCryptoTLSCreds *creds;
+    QCryptoTLSCredsBox *credsbox;
     gnutls_session_t handle;
     char *hostname;
     char *authzid;
@@ -78,6 +79,7 @@ qcrypto_tls_session_free(QCryptoTLSSession *session)
     g_free(session->hostname);
     g_free(session->peername);
     g_free(session->authzid);
+    qcrypto_tls_creds_box_unref(session->credsbox);
     object_unref(OBJECT(session->creds));
     qemu_mutex_destroy(&session->lock);
     g_free(session);
@@ -206,63 +208,31 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
         goto error;
     }
 
-    if (object_dynamic_cast(OBJECT(creds),
-                            TYPE_QCRYPTO_TLS_CREDS_ANON)) {
-        QCryptoTLSCredsAnon *acreds = QCRYPTO_TLS_CREDS_ANON(creds);
-        if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-            ret = gnutls_credentials_set(session->handle,
-                                         GNUTLS_CRD_ANON,
-                                         acreds->data.server);
-        } else {
-            ret = gnutls_credentials_set(session->handle,
-                                         GNUTLS_CRD_ANON,
-                                         acreds->data.client);
-        }
-        if (ret < 0) {
-            error_setg(errp, "Cannot set session credentials: %s",
-                       gnutls_strerror(ret));
-            goto error;
-        }
-    } else if (object_dynamic_cast(OBJECT(creds),
-                                   TYPE_QCRYPTO_TLS_CREDS_PSK)) {
-        QCryptoTLSCredsPSK *pcreds = QCRYPTO_TLS_CREDS_PSK(creds);
-        if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-            ret = gnutls_credentials_set(session->handle,
-                                         GNUTLS_CRD_PSK,
-                                         pcreds->data.server);
-        } else {
-            ret = gnutls_credentials_set(session->handle,
-                                         GNUTLS_CRD_PSK,
-                                         pcreds->data.client);
-        }
-        if (ret < 0) {
-            error_setg(errp, "Cannot set session credentials: %s",
-                       gnutls_strerror(ret));
-            goto error;
-        }
-    } else if (object_dynamic_cast(OBJECT(creds),
-                                   TYPE_QCRYPTO_TLS_CREDS_X509)) {
-        QCryptoTLSCredsX509 *tcreds = QCRYPTO_TLS_CREDS_X509(creds);
+    ret = gnutls_credentials_set(session->handle,
+                                 creds->box->type,
+                                 creds->box->data.any);
+    if (ret < 0) {
+        error_setg(errp, "Cannot set session credentials: %s",
+                   gnutls_strerror(ret));
+        goto error;
+    }
 
-        ret = gnutls_credentials_set(session->handle,
-                                     GNUTLS_CRD_CERTIFICATE,
-                                     tcreds->data);
-        if (ret < 0) {
-            error_setg(errp, "Cannot set session credentials: %s",
-                       gnutls_strerror(ret));
-            goto error;
-        }
+    /*
+     * creds->box->data.any must be kept alive for as long
+     * as the gnutls_session_t is alive, so acquire a ref
+     */
+    qcrypto_tls_creds_box_ref(creds->box);
+    session->credsbox = creds->box;
 
-        if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-            /* This requests, but does not enforce a client cert.
-             * The cert checking code later does enforcement */
-            gnutls_certificate_server_set_request(session->handle,
-                                                  GNUTLS_CERT_REQUEST);
-        }
-    } else {
-        error_setg(errp, "Unsupported TLS credentials type %s",
-                   object_get_typename(OBJECT(creds)));
-        goto error;
+    if (object_dynamic_cast(OBJECT(creds),
+                            TYPE_QCRYPTO_TLS_CREDS_X509) &&
+        creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        /*
+         * This requests, but does not enforce a client cert.
+         * The cert checking code later does enforcement
+         */
+        gnutls_certificate_server_set_request(session->handle,
+                                              GNUTLS_CERT_REQUEST);
     }
 
     gnutls_transport_set_ptr(session->handle, session);
-- 
2.51.1


