Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DC1CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETz2-0001hu-Vv; Thu, 30 Oct 2025 10:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyq-0001ZI-VM
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyY-0001aO-Hj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1U4pzjNfu8oJgRpaD00KUGO9poOiqlcj3lvTJn8MMAQ=;
 b=Aa+CFuAxyt3IOA4PAkDf9V+sLn/W+dIx9BjWo03dsq3tV6zaPRfSrFLozP+otKxnx3b5Zu
 94YXhpXQJn+ABYupekKRVys/rX5Z949Bo7Dl27aM+oqNLjjv6qmaDxNObi/5QeMYsCaKFa
 hMRtq03m5p6tdMahUxQ9Ay5YOwv+Z3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47-i34hIp8eP36gxRs9Z26gvA-1; Thu,
 30 Oct 2025 10:50:02 -0400
X-MC-Unique: i34hIp8eP36gxRs9Z26gvA-1
X-Mimecast-MFC-AGG-ID: i34hIp8eP36gxRs9Z26gvA_1761835801
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 375F0195607C; Thu, 30 Oct 2025 14:50:01 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E463E30001A1; Thu, 30 Oct 2025 14:49:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 16/21] crypto: deprecate use of external dh-params.pem file
Date: Thu, 30 Oct 2025 14:49:22 +0000
Message-ID: <20251030144927.2241109-17-berrange@redhat.com>
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
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

GNUTLS has deprecated use of externally provided diffie-hellman
parameters, since it will automatically negotiate DH params in
accordance with RFC7919.

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
index 798c9712fb..85268f3b57 100644
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
index 69ed1d792a..777cc4f5bb 100644
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
index e437985260..801da50625 100644
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
index 2fc0872627..7e79af4266 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -684,7 +684,9 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
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
index ca6b3769b5..694a69da64 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -365,6 +365,15 @@ Options are:
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


