Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C7CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqdM-0004SR-Ua; Mon, 20 Oct 2025 10:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqd9-0004Ps-1H
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAqd1-0007MD-5p
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760969568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIg4ibiegQVk6RIUfT2XAEW8SEIIE1PfZIYQeghdcfI=;
 b=bakEl/z+cpAmvqP5k8A2qFzhL0Ry95JWmudqUJDm0tnHjG3psU/FRTNJ7Pg8a57plSq0iB
 2iPLwgiB6A+podcVKIpntm62cjur/Cr+wweTjaTwxvBvjSf54/Xy1K4Q8EhWobOebrPGno
 MG20BPyOB46fmj4mBKxeJX0m66XYPzw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-MjwRTiSPNL21817tVGLxlQ-1; Mon,
 20 Oct 2025 10:12:47 -0400
X-MC-Unique: MjwRTiSPNL21817tVGLxlQ-1
X-Mimecast-MFC-AGG-ID: MjwRTiSPNL21817tVGLxlQ_1760969566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 796E918002F5
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 14:12:46 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.161])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F3891800451; Mon, 20 Oct 2025 14:12:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v3 4/7] crypto: fix error reporting in cert chain checks
Date: Mon, 20 Oct 2025 15:12:34 +0100
Message-ID: <20251020141237.2621796-5-berrange@redhat.com>
In-Reply-To: <20251020141237.2621796-1-berrange@redhat.com>
References: <20251020141237.2621796-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

The loop that checks the CA certificate chain can fail to report
an error message if one of the certs in the chain has an issuer
that is not present in the chain. In this case, the outer loop
'while (checking_issuer)' will terminate after failing to find
the issuer, and no error message will be reported.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c                 | 33 ++++++++++++++++++---------
 tests/unit/test-crypto-tlscredsx509.c | 12 ++++++++++
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 4169ad9a75..e1f82f1cdc 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -326,11 +326,11 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                                         Error **errp)
 {
     gnutls_x509_crt_t cert_to_check = cert;
-    bool checking_issuer = true;
     int retval = 0;
+    gnutls_datum_t dn = {};
 
-    while (checking_issuer) {
-        checking_issuer = false;
+    for (;;) {
+        gnutls_x509_crt_t cert_issuer = NULL;
 
         if (gnutls_x509_crt_check_issuer(cert_to_check,
                                          cert_to_check)) {
@@ -345,19 +345,30 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
         for (int i = 0; i < ncacerts; i++) {
             if (gnutls_x509_crt_check_issuer(cert_to_check,
                                              cacerts[i])) {
-                retval = qcrypto_tls_creds_check_cert(
-                    creds, cacerts[i], cacertFile,
-                    isServer, isCA, errp);
-                if (retval < 0) {
-                    return retval;
-                }
-                cert_to_check = cacerts[i];
-                checking_issuer = true;
+                cert_issuer = cacerts[i];
                 break;
             }
         }
+        if (!cert_issuer) {
+            break;
+        }
+
+        if (qcrypto_tls_creds_check_cert(creds, cert_issuer, cacertFile,
+                                         isServer, isCA, errp) < 0) {
+            return -1;
+        }
+
+        cert_to_check = cert_issuer;
     }
 
+    retval = gnutls_x509_crt_get_dn2(cert_to_check, &dn);
+    if (retval < 0) {
+        error_setg(errp, "Unable to fetch cert DN: %s",
+                   gnutls_strerror(retval));
+        return -1;
+    }
+    error_setg(errp, "Cert '%s' has no issuer in CA chain", dn.data);
+    gnutls_free(dn.data);
     return -1;
 }
 
diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index 85f51aee1b..5f78fe7d6f 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -643,6 +643,15 @@ int main(int argc, char **argv)
                               certchain_with_invalid,
                               G_N_ELEMENTS(certchain_with_invalid));
 
+    gnutls_x509_crt_t certchain_incomplete[] = {
+        cacertrootreq.crt,
+        cacertlevel2areq.crt,
+    };
+
+    test_tls_write_cert_chain(WORKDIR "cacertchain-incomplete-ctx.pem",
+                              certchain_incomplete,
+                              G_N_ELEMENTS(certchain_incomplete));
+
     TLS_TEST_REG(chain1, true,
                  WORKDIR "cacertchain-ctx.pem",
                  servercertlevel3areq.filename, false);
@@ -652,6 +661,9 @@ int main(int argc, char **argv)
     TLS_TEST_REG(certchainwithexpiredcert, false,
                  WORKDIR "cacertchain-with-invalid-ctx.pem",
                  clientcertlevel2breq.filename, false);
+    TLS_TEST_REG(chainincomlpete, true,
+                 WORKDIR "cacertchain-incomplete-ctx.pem",
+                 servercertlevel3areq.filename, true);
 
     /* Some missing certs - first two are fatal, the last
      * is ok
-- 
2.50.1


