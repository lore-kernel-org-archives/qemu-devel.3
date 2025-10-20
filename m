Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D0ECCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqdM-0004SD-Ar; Mon, 20 Oct 2025 10:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqd4-0004On-1T
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqcy-0007Kw-L2
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760969566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCObt3x+cEciUOh6vncOKwvla1QzbKPqBuEb/0PEtVo=;
 b=ayJfZ8zlCscbP9ib6vet8pePVFqMvBuFPfWWVHqLxqGakLWs3g61bm6whLSnNUY7atfj1B
 wnulF3yCeTLJsc7ye8Pt9IO8NhPLiZfZCGbwkHbjCzWcTerXv/VGHQyoJXHBurtbITQGTu
 pV6PfeYKsujdYlfND34XtPCiFapWo8k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-Sps3p1uvMvaqG71dN6VgVw-1; Mon,
 20 Oct 2025 10:12:42 -0400
X-MC-Unique: Sps3p1uvMvaqG71dN6VgVw-1
X-Mimecast-MFC-AGG-ID: Sps3p1uvMvaqG71dN6VgVw_1760969562
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 051A8195609D; Mon, 20 Oct 2025 14:12:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA3241800451; Mon, 20 Oct 2025 14:12:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Henry Kleynhans <hkleynhans@fb.com>
Subject: [PATCH v3 1/7] crypto: only verify CA certs in chain of trust
Date: Mon, 20 Oct 2025 15:12:31 +0100
Message-ID: <20251020141237.2621796-2-berrange@redhat.com>
In-Reply-To: <20251020141237.2621796-1-berrange@redhat.com>
References: <20251020141237.2621796-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

From: Henry Kleynhans <hkleynhans@fb.com>

The CA file provided to qemu may contain CA certificates which do not
form part of the chain of trust for the specific certificate we are
sanity checking.

This patch changes the sanity checking from validating every CA
certificate to only checking the CA certificates which are part of the
chain of trust (issuer chain).  Other certificates are ignored.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Henry Kleynhans <hkleynhans@fb.com>
[DB: changed 'int' to 'bool' in 'checking_issuer' variable]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c                 | 57 ++++++++++++++++++++++++---
 tests/unit/test-crypto-tlscredsx509.c | 25 +++++++++++-
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index cd1f504471..3df2a33b0b 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -315,6 +315,51 @@ qcrypto_tls_creds_check_cert(QCryptoTLSCredsX509 *creds,
     return 0;
 }
 
+static int
+qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
+                                        gnutls_x509_crt_t cert,
+                                        gnutls_x509_crt_t *cacerts,
+                                        unsigned int ncacerts,
+                                        const char *cacertFile,
+                                        bool isServer,
+                                        bool isCA,
+                                        Error **errp)
+{
+    gnutls_x509_crt_t *cert_to_check = &cert;
+    bool checking_issuer = true;
+    int retval = 0;
+
+    while (checking_issuer) {
+        checking_issuer = false;
+
+        if (gnutls_x509_crt_check_issuer(*cert_to_check,
+                                         *cert_to_check)) {
+            /*
+             * The cert is self-signed indicating we have
+             * reached the root of trust.
+             */
+            return qcrypto_tls_creds_check_cert(
+                creds, *cert_to_check, cacertFile,
+                isServer, isCA, errp);
+        }
+        for (int i = 0; i < ncacerts; i++) {
+            if (gnutls_x509_crt_check_issuer(*cert_to_check,
+                                             cacerts[i])) {
+                retval = qcrypto_tls_creds_check_cert(
+                    creds, cacerts[i], cacertFile,
+                    isServer, isCA, errp);
+                if (retval < 0) {
+                    return retval;
+                }
+                cert_to_check = &cacerts[i];
+                checking_issuer = true;
+                break;
+            }
+        }
+    }
+
+    return -1;
+}
 
 static int
 qcrypto_tls_creds_check_cert_pair(gnutls_x509_crt_t cert,
@@ -499,12 +544,12 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
         goto cleanup;
     }
 
-    for (i = 0; i < ncacerts; i++) {
-        if (qcrypto_tls_creds_check_cert(creds,
-                                         cacerts[i], cacertFile,
-                                         isServer, true, errp) < 0) {
-            goto cleanup;
-        }
+    if (cert &&
+        qcrypto_tls_creds_check_authority_chain(creds, cert,
+                                                cacerts, ncacerts,
+                                                cacertFile, isServer,
+                                                true, errp) < 0) {
+        goto cleanup;
     }
 
     if (cert && ncacerts &&
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index 3c25d75ca1..a7ea5f422d 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -589,6 +589,12 @@ int main(int argc, char **argv)
                  true, true, GNUTLS_KEY_KEY_CERT_SIGN,
                  false, false, NULL, NULL,
                  0, 0);
+    TLS_CERT_REQ(cacertlevel1creq_invalid, cacertrootreq,
+                 "UK", "qemu level 1c invalid", NULL, NULL, NULL, NULL,
+                 true, true, true,
+                 true, true, GNUTLS_KEY_KEY_CERT_SIGN,
+                 false, false, NULL, NULL,
+                 360, 400);
     TLS_CERT_REQ(cacertlevel2areq, cacertlevel1areq,
                  "UK", "qemu level 2a", NULL, NULL, NULL, NULL,
                  true, true, true,
@@ -617,16 +623,32 @@ int main(int argc, char **argv)
         cacertlevel2areq.crt,
     };
 
+
     test_tls_write_cert_chain(WORKDIR "cacertchain-ctx.pem",
                               certchain,
                               G_N_ELEMENTS(certchain));
 
+    gnutls_x509_crt_t certchain_with_invalid[] = {
+        cacertrootreq.crt,
+        cacertlevel1areq.crt,
+        cacertlevel1breq.crt,
+        cacertlevel1creq_invalid.crt,
+        cacertlevel2areq.crt,
+    };
+
+    test_tls_write_cert_chain(WORKDIR "cacertchain-with-invalid-ctx.pem",
+                              certchain_with_invalid,
+                              G_N_ELEMENTS(certchain_with_invalid));
+
     TLS_TEST_REG(chain1, true,
                  WORKDIR "cacertchain-ctx.pem",
                  servercertlevel3areq.filename, false);
     TLS_TEST_REG(chain2, false,
                  WORKDIR "cacertchain-ctx.pem",
                  clientcertlevel2breq.filename, false);
+    TLS_TEST_REG(certchainwithexpiredcert, false,
+                 WORKDIR "cacertchain-with-invalid-ctx.pem",
+                 clientcertlevel2breq.filename, false);
 
     /* Some missing certs - first two are fatal, the last
      * is ok
@@ -640,7 +662,6 @@ int main(int argc, char **argv)
     TLS_TEST_REG(missingclient, false,
                  cacert1req.filename,
                  "clientcertdoesnotexist.pem", false);
-
     ret = g_test_run();
 
     test_tls_discard_cert(&cacertreq);
@@ -694,10 +715,12 @@ int main(int argc, char **argv)
     test_tls_discard_cert(&cacertrootreq);
     test_tls_discard_cert(&cacertlevel1areq);
     test_tls_discard_cert(&cacertlevel1breq);
+    test_tls_discard_cert(&cacertlevel1creq_invalid);
     test_tls_discard_cert(&cacertlevel2areq);
     test_tls_discard_cert(&servercertlevel3areq);
     test_tls_discard_cert(&clientcertlevel2breq);
     unlink(WORKDIR "cacertchain-ctx.pem");
+    unlink(WORKDIR "cacertchain-with-invalid-ctx.pem");
 
     test_tls_cleanup(KEYFILE);
     rmdir(WORKDIR);
-- 
2.50.1


