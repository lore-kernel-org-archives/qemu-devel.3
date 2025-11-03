Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD1ECCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFuoF-0001oW-4J; Mon, 03 Nov 2025 08:41:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFuny-0001RC-2C
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFunj-0004kR-25
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0aHV5ZwA+auvzXowWLXibx+g4bqRoA0nm01awGkq0pU=;
 b=HyCZqIOEIV7xHyYLZLrEsV6ELMNtSSDeJJXUeSum3vbMoghBsuhJ4FGNhGY2O5OrRWsqOH
 RjsVq+ffY5oLoPzGN0AquaRDgxXyWGI3n4BTSwavCXXiXnAyFx15GhJTIZejtHbrKd1VMm
 Zo4UL9XfpMjjFoiUrPDW7PdeirgB1Fs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-HV-bKrEdMtukRLCqi8curg-1; Mon,
 03 Nov 2025 08:40:43 -0500
X-MC-Unique: HV-bKrEdMtukRLCqi8curg-1
X-Mimecast-MFC-AGG-ID: HV-bKrEdMtukRLCqi8curg_1762177242
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 16D34180035D; Mon,  3 Nov 2025 13:40:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80F2F1800578; Mon,  3 Nov 2025 13:40:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 27/32] crypto: deprecate use of external dh-params.pem file
Date: Mon,  3 Nov 2025 13:37:21 +0000
Message-ID: <20251103133727.423041-28-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

GNUTLS has deprecated use of externally provided diffie-hellman
parameters. Since 3.6.0 it will automatically negotiate DH params
in accordance with RFC7919.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c         | 24 ++++++++----------------
 crypto/tlscredsanon.c     |  6 ++++--
 crypto/tlscredspsk.c      |  6 ++++--
 crypto/tlscredsx509.c     |  4 +++-
 docs/about/deprecated.rst |  9 +++++++++
 docs/system/tls.rst       | 12 +++++++-----
 6 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 9912e3ffbf..3d25efe425 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qapi-types-crypto.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "tlscredspriv.h"
 #include "trace.h"
 
@@ -38,22 +39,7 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *creds,
 
     trace_qcrypto_tls_creds_load_dh(creds, filename ? filename : "<generated>");
 
-    if (filename == NULL) {
-        ret = gnutls_dh_params_init(dh_params);
-        if (ret < 0) {
-            error_setg(errp, "Unable to initialize DH parameters: %s",
-                       gnutls_strerror(ret));
-            return -1;
-        }
-        ret = gnutls_dh_params_generate2(*dh_params, DH_BITS);
-        if (ret < 0) {
-            gnutls_dh_params_deinit(*dh_params);
-            *dh_params = NULL;
-            error_setg(errp, "Unable to generate DH parameters: %s",
-                       gnutls_strerror(ret));
-            return -1;
-        }
-    } else {
+    if (filename != NULL) {
         GError *gerr = NULL;
         gchar *contents;
         gsize len;
@@ -67,6 +53,10 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *creds,
             g_error_free(gerr);
             return -1;
         }
+        warn_report_once("Use of an external DH parameters file '%s' is "
+                         "deprecated and will be removed in a future release",
+                         filename);
+
         data.data = (unsigned char *)contents;
         data.size = len;
         ret = gnutls_dh_params_init(dh_params);
@@ -87,6 +77,8 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *creds,
                        filename, gnutls_strerror(ret));
             return -1;
         }
+    } else {
+        *dh_params = NULL;
     }
 
     return 0;
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 646574d6ae..1551382e1f 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -68,8 +68,10 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
             return -1;
         }
 
-        gnutls_anon_set_server_dh_params(box->data.anonserver,
-                                         box->dh_params);
+        if (box->dh_params) {
+            gnutls_anon_set_server_dh_params(box->data.anonserver,
+                                             box->dh_params);
+        }
     } else {
         ret = gnutls_anon_allocate_client_credentials(&box->data.anonclient);
         if (ret < 0) {
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 8879c84ea7..e1b1e1a613 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -129,8 +129,10 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
                        gnutls_strerror(ret));
             goto cleanup;
         }
-        gnutls_psk_set_server_dh_params(box->data.pskserver,
-                                        box->dh_params);
+        if (box->dh_params) {
+            gnutls_psk_set_server_dh_params(box->data.pskserver,
+                                            box->dh_params);
+        }
     } else {
         box = qcrypto_tls_creds_box_new_client(GNUTLS_CRD_PSK);
 
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 397ff4caa9..e28fcdc6ff 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -683,7 +683,9 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
                                                  errp) < 0) {
             return -1;
         }
-        gnutls_certificate_set_dh_params(box->data.cert, box->dh_params);
+        if (box->dh_params) {
+            gnutls_certificate_set_dh_params(box->data.cert, box->dh_params);
+        }
     }
     creds->parent_obj.box = g_steal_pointer(&box);
 
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4ee98d6646..03e29915f0 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -385,6 +385,15 @@ Options are:
     - move backing file to NVDIMM storage and keep ``pmem=on``
       (to have NVDIMM with persistence guaranties).
 
+Using an external DH (Diffie-Hellman) parameters file (since 10.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Loading of external Diffie-Hellman parameters from a 'dh-params.pem'
+file is deprecated and will be removed with no replacement in a
+future release. Where no 'dh-params.pem' file is provided, the DH
+parameters will be automatically negotiated in accordance with
+RFC7919.
+
 Device options
 --------------
 
diff --git a/docs/system/tls.rst b/docs/system/tls.rst
index a4f6781d62..44c4bf04e9 100644
--- a/docs/system/tls.rst
+++ b/docs/system/tls.rst
@@ -251,11 +251,13 @@ When specifying the object, the ``dir`` parameters specifies which
 directory contains the credential files. This directory is expected to
 contain files with the names mentioned previously, ``ca-cert.pem``,
 ``server-key.pem``, ``server-cert.pem``, ``client-key.pem`` and
-``client-cert.pem`` as appropriate. It is also possible to include a set
-of pre-generated Diffie-Hellman (DH) parameters in a file
-``dh-params.pem``, which can be created using the
-``certtool --generate-dh-params`` command. If omitted, QEMU will
-dynamically generate DH parameters when loading the credentials.
+``client-cert.pem`` as appropriate.
+
+While it is possible to include a set of pre-generated Diffie-Hellman
+(DH) parameters in a file ``dh-params.pem``, this facility is now
+deprecated and will be removed in a future release. When omitted the
+DH parameters will be automatically negotiated in accordance with
+RFC7919.
 
 The ``endpoint`` parameter indicates whether the credentials will be
 used for a network client or server, and determines which PEM files are
-- 
2.51.1


