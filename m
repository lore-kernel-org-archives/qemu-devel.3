Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E530CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETzs-00030C-2B; Thu, 30 Oct 2025 10:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETz7-0001vc-SF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vETyh-0001hg-3w
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b0G7DlKryO7aA2zIVWjWtCI0gCcKIDrnDbWNJYakbg=;
 b=RQMYrPAxdS3i/bixSnfzOwc1vZ8vyHjtDfOz5SUjdXO14dGIUKJG44mTBwx2/b+0IdT7CO
 FuTh9kPX8d3fR9o663LoHtZEKzCwaw2ZEQsBEO3Po57F/6hJdorA3Ka3DcFEptgFr790Fx
 IMiHQ7xovQ/9TdlE8Bs+UmtpwUw51jA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-Ww4pMXJ-NrKZFr_8l92wzQ-1; Thu,
 30 Oct 2025 10:50:09 -0400
X-MC-Unique: Ww4pMXJ-NrKZFr_8l92wzQ-1
X-Mimecast-MFC-AGG-ID: Ww4pMXJ-NrKZFr_8l92wzQ_1761835809
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD1331955F19; Thu, 30 Oct 2025 14:50:08 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.122])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51F5F30001A1; Thu, 30 Oct 2025 14:50:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org
Subject: [PATCH 20/21] crypto: support upto 5 parallel certificate identities
Date: Thu, 30 Oct 2025 14:49:26 +0000
Message-ID: <20251030144927.2241109-21-berrange@redhat.com>
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

The default (required) identity is stored in server-cert.pem /
client-cert.pem and server-key.pem / client-key.pem.

The 4 extra (optional) identities are stored in server-cert-$N.pem /
client-cert-$N.pem and server-key-$N.pem / client-key-$N.pem. The
numbering starts at 0 and the first missing cert/key pair will
terminate the loading process.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscreds.c             | 10 +++++-
 crypto/tlscredspriv.h         |  3 ++
 crypto/tlscredsx509.c         | 68 ++++++++++++++++++++++++++++-------
 crypto/tlssession.c           |  1 +
 crypto/trace-events           |  1 +
 docs/system/tls.rst           | 54 ++++++++++++++++++++++++++--
 include/crypto/tlscredsx509.h |  6 ++++
 7 files changed, 127 insertions(+), 16 deletions(-)

diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index 85268f3b57..b7e77f6285 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -85,6 +85,14 @@ qcrypto_tls_creds_get_dh_params_file(QCryptoTLSCreds *creds,
 }
 
 
+char *
+qcrypto_tls_creds_build_path(QCryptoTLSCreds *creds,
+                             const char *filename)
+{
+    return g_strdup_printf("%s/%s", creds->dir, filename);
+}
+
+
 int
 qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
                            const char *filename,
@@ -94,7 +102,7 @@ qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
 {
     int ret = -1;
 
-    *cred = g_strdup_printf("%s/%s", creds->dir, filename);
+    *cred = qcrypto_tls_creds_build_path(creds, filename);
 
     if (access(*cred, R_OK) < 0) {
         if (errno == ENOENT && !required) {
diff --git a/crypto/tlscredspriv.h b/crypto/tlscredspriv.h
index 69dac02437..8f2d096c7f 100644
--- a/crypto/tlscredspriv.h
+++ b/crypto/tlscredspriv.h
@@ -39,6 +39,9 @@ struct QCryptoTLSCreds {
 
 #ifdef CONFIG_GNUTLS
 
+char *qcrypto_tls_creds_build_path(QCryptoTLSCreds *creds,
+                                   const char *filename);
+
 int qcrypto_tls_creds_get_path(QCryptoTLSCreds *creds,
                                const char *filename,
                                bool required,
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index d7d1f594c0..fa92431906 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -686,7 +686,6 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
                                      QCryptoTLSCredsBox *box,
                                      const char *certbase,
                                      const char *keybase,
-                                     bool isOptional,
                                      Error **errp)
 {
     g_autoptr(QCryptoTLSCredsX509IdentFiles) files =
@@ -694,9 +693,9 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
     int ret;
 
     if (qcrypto_tls_creds_get_path(&creds->parent_obj, certbase,
-                                   !isOptional, &files->certpath, errp) < 0 ||
+                                   false, &files->certpath, errp) < 0 ||
         qcrypto_tls_creds_get_path(&creds->parent_obj, keybase,
-                                   !isOptional, &files->keypath, errp) < 0) {
+                                   false, &files->keypath, errp) < 0) {
         return NULL;
     }
 
@@ -705,13 +704,17 @@ qcrypto_tls_creds_x509_load_identity(QCryptoTLSCredsX509 *creds,
         return NULL;
     }
     if (files->certpath && !files->keypath) {
-        error_setg(errp, "Cert '%s' without corresponding key",
-                   files->certpath);
+        g_autofree char *keypath =
+            qcrypto_tls_creds_build_path(&creds->parent_obj, keybase);
+        error_setg(errp, "Cert '%s' without corresponding key '%s'",
+                   files->certpath, keypath);
         return NULL;
     }
     if (!files->certpath && files->keypath) {
-        error_setg(errp, "Key '%s' without corresponding cert",
-                   files->keypath);
+        g_autofree char *certpath =
+            qcrypto_tls_creds_build_path(&creds->parent_obj, certbase);
+        error_setg(errp, "Key '%s' without corresponding cert '%s'",
+                   files->keypath, certpath);
         return NULL;
     }
 
@@ -750,7 +753,9 @@ qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX509 *creds,
                                        bool isServer,
                                        Error **errp)
 {
+    ERRP_GUARD();
     QCryptoTLSCredsX509IdentFiles *ifiles;
+    size_t i;
 
     ifiles = qcrypto_tls_creds_x509_load_identity(
         creds, box,
@@ -760,15 +765,52 @@ qcrypto_tls_creds_x509_load_identities(QCryptoTLSCredsX509 *creds,
         isServer ?
         QCRYPTO_TLS_CREDS_X509_SERVER_KEY :
         QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
-        !isServer, errp);
-    if (!ifiles) {
+        errp);
+    if (!ifiles && *errp) {
         return -1;
     }
 
-    files->identities = g_renew(QCryptoTLSCredsX509IdentFiles *,
-                                files->identities,
-                                files->nidentities + 1);
-    files->identities[files->nidentities++] = ifiles;
+    if (ifiles) {
+        files->identities = g_renew(QCryptoTLSCredsX509IdentFiles *,
+                                    files->identities,
+                                    files->nidentities + 1);
+        files->identities[files->nidentities++] = ifiles;
+    }
+
+    for (i = 0; i < QCRYPTO_TLS_CREDS_X509_IDENTITY_MAX; i++) {
+        g_autofree char *cert = g_strdup_printf(
+            isServer ?
+            QCRYPTO_TLS_CREDS_X509_SERVER_CERT_N :
+            QCRYPTO_TLS_CREDS_X509_CLIENT_CERT_N, i);
+        g_autofree char *key = g_strdup_printf(
+            isServer ?
+            QCRYPTO_TLS_CREDS_X509_SERVER_KEY_N :
+            QCRYPTO_TLS_CREDS_X509_CLIENT_KEY_N, i);
+
+        ifiles = qcrypto_tls_creds_x509_load_identity(creds, box,
+                                                      cert, key, errp);
+        if (!ifiles && *errp) {
+            return -1;
+        }
+        if (!ifiles) {
+            break;
+        }
+
+        files->identities = g_renew(QCryptoTLSCredsX509IdentFiles *,
+                                    files->identities,
+                                    files->nidentities + 1);
+        files->identities[files->nidentities++] = ifiles;
+    }
+
+    if (files->nidentities == 0 && isServer) {
+        g_autofree char *certpath = qcrypto_tls_creds_build_path(
+            &creds->parent_obj, QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
+        g_autofree char *keypath = qcrypto_tls_creds_build_path(
+            &creds->parent_obj, QCRYPTO_TLS_CREDS_X509_SERVER_KEY);
+        error_setg(errp, "Missing server cert '%s' & key '%s'",
+                   certpath, keypath);
+        return -1;
+    }
 
     return 0;
 }
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index a1dc3b3ce0..314e3e96ba 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -345,6 +345,7 @@ qcrypto_tls_session_check_certificate(QCryptoTLSSession *session,
                 goto error;
             }
             session->peername = (char *)g_steal_pointer(&dname.data);
+            trace_qcrypto_tls_session_check_x509_dn(session, session->peername);
             if (session->authzid) {
                 bool allow;
 
diff --git a/crypto/trace-events b/crypto/trace-events
index d0e33427fa..771f9b8a6e 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -21,6 +21,7 @@ qcrypto_tls_creds_x509_load_cert_list(void *creds, const char *file) "TLS creds
 # tlssession.c
 qcrypto_tls_session_new(void *session, void *creds, const char *hostname, const char *authzid, int endpoint) "TLS session new session=%p creds=%p hostname=%s authzid=%s endpoint=%d"
 qcrypto_tls_session_check_creds(void *session, const char *status) "TLS session check creds session=%p status=%s"
+qcrypto_tls_session_check_x509_dn(void *session, const char *dname) "TLS session check x509 distinguished name session=%p dname=%s"
 qcrypto_tls_session_parameters(void *session, int threadSafety, int protocol, int cipher) "TLS session parameters session=%p threadSafety=%d protocol=%d cipher=%d"
 qcrypto_tls_session_bug1717_workaround(void *session) "TLS session bug1717 workaround session=%p"
 
diff --git a/docs/system/tls.rst b/docs/system/tls.rst
index 44c4bf04e9..7cec4ac3df 100644
--- a/docs/system/tls.rst
+++ b/docs/system/tls.rst
@@ -36,8 +36,58 @@ server and exposing it directly to remote browser clients. In such a
 case it might be useful to use a commercial CA to avoid needing to
 install custom CA certs in the web browsers.
 
-The recommendation is for the server to keep its certificates in either
-``/etc/pki/qemu`` or for unprivileged users in ``$HOME/.pki/qemu``.
+.. _tls_cert_file_naming:
+
+Certificate file naming
+~~~~~~~~~~~~~~~~~~~~~~~
+
+In a simple setup, where all QEMU instances on a machine share the
+same TLS configuration, it is suggested that QEMU certificates be
+kept in either ``/etc/pki/qemu`` or, for unprivileged users, in
+``$HOME/.pki/qemu``. Where different QEMU subsystems require
+different certificate configurations, sub-dirs of these locations
+may be chosen.
+
+The default file names that QEMU will traditionally load are:
+
+* ``ca-cert.pem`` - mandatory; for both client and server configurations
+* ``ca-crl.pem`` - optional; for server configurations only
+* ``server-cert.pem`` - mandatory; for server configurations only
+* ``server-key.pem`` - mandatory; for server configurations only
+* ``client-cert.pem`` - optional; for client configurations only
+* ``client-key.pem`` - optional; for client configurations only
+* ``dh-params.pem`` - optional; for server configurations only
+
+Since QEMU 10.2.0, there is support for loading upto four additional
+identities:
+
+* ``server-cert-[IDX].pem`` - optional; for server configurations only
+* ``server-key-[IDX].pem`` - optional; for server configurations only
+* ``client-cert-[IDX].pem`` - optional; for client configurations only
+* ``client-key-[IDX].pem`` - optional; for client configurations only
+
+where ``-[IDX]`` is one of the digits 0-3. Loading will terminate at
+the first absent index. The index based certificate files may be used
+as a replacement for, or in addition to, the traditional non-index
+based certificate files. The traditional certificate files will be
+loaded first, if present, then the index based certificates. Where
+multiple certificates are compatible with a TLS session, the first
+loaded certificate will preferred. IOW file naming can influence
+which certificates are used for a session.
+
+The use of multiple sets of certificates is intended to allow an
+incremental transition to certificates using different crytographic
+algorithms. This allows a newly deployed QEMU to introduce use of
+stronger cryptographic algorithms that will be preferred when talking
+to other newly deployed QEMU instances, while retaining compatbility
+with certificates issued to a historically deployed QEMU. This is
+notably useful to support live migration from an old QEMU deployed
+on older operating system releases, which may support fewer crypto
+algorithm choices than the current OS.
+
+The certificate creation commands below will be illustrated using
+the traditional naming scheme, but their args can be substituted
+to use the indexed naming in the obvious manner.
 
 .. _tls_005fgenerate_005fca:
 
diff --git a/include/crypto/tlscredsx509.h b/include/crypto/tlscredsx509.h
index c4daba21a6..61b7f73573 100644
--- a/include/crypto/tlscredsx509.h
+++ b/include/crypto/tlscredsx509.h
@@ -37,7 +37,13 @@ typedef struct QCryptoTLSCredsX509Class QCryptoTLSCredsX509Class;
 #define QCRYPTO_TLS_CREDS_X509_SERVER_CERT "server-cert.pem"
 #define QCRYPTO_TLS_CREDS_X509_CLIENT_KEY "client-key.pem"
 #define QCRYPTO_TLS_CREDS_X509_CLIENT_CERT "client-cert.pem"
+#define QCRYPTO_TLS_CREDS_X509_SERVER_KEY_N "server-key-%zu.pem"
+#define QCRYPTO_TLS_CREDS_X509_SERVER_CERT_N "server-cert-%zu.pem"
+#define QCRYPTO_TLS_CREDS_X509_CLIENT_KEY_N "client-key-%zu.pem"
+#define QCRYPTO_TLS_CREDS_X509_CLIENT_CERT_N "client-cert-%zu.pem"
 
+/* Max number of additional cert/key pairs (ie _N constants) */
+#define QCRYPTO_TLS_CREDS_X509_IDENTITY_MAX 4
 
 /**
  * QCryptoTLSCredsX509:
-- 
2.51.1


