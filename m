Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E147BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbzS-0007NM-Cx; Tue, 15 Jul 2025 05:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbyy-00076S-3i
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbyv-0005Mr-2z
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752571787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AUPVGBXS/Kui/rrOIuFW46BClYNN60cHLU9rgFNq00=;
 b=Zweff70l9iNwRxDLd8skxPzojKaSg9YZPK11tr/TTl8vMYdVq293wOC2y25tuj7hcyUZYM
 pnHG7y7miugFnIZA/0Lyyh3baU3eXOI0TwveaZDHXOCytoHSmRSTgatqUFc+kkSu/x61Gw
 I/0tSHwWY8//rJL0dckFvo5B3cG76RA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-mqshwitKPG-LucKGaI2aGg-1; Tue,
 15 Jul 2025 05:29:45 -0400
X-MC-Unique: mqshwitKPG-LucKGaI2aGg-1
X-Mimecast-MFC-AGG-ID: mqshwitKPG-LucKGaI2aGg_1752571785
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BDE418011DF
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:29:45 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C48D1977000; Tue, 15 Jul 2025 09:29:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/7] crypto: fix error reporting in cert chain checks
Date: Tue, 15 Jul 2025 10:29:31 +0100
Message-ID: <20250715092932.1395271-7-berrange@redhat.com>
In-Reply-To: <20250715092932.1395271-1-berrange@redhat.com>
References: <20250715092932.1395271-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
than is not present in the chain. In this case, the outer loop
'while (checking_issuer)' will terminate after failing to find
the issuer, and no error message will be reported.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 95ddfe2f98..d6897ca57b 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -318,11 +318,11 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
                                         Error **errp)
 {
     gnutls_x509_crt_t cert_to_check = cert;
-    int checking_issuer = 1;
-    int retval = 0;
+    gnutls_datum_t dn = {};
+    int rv;
 
-    while (checking_issuer) {
-        checking_issuer = 0;
+    for (;;) {
+        gnutls_x509_crt_t cert_issuer = NULL;
 
         if (gnutls_x509_crt_check_issuer(cert_to_check,
                                          cert_to_check)) {
@@ -337,19 +337,30 @@ qcrypto_tls_creds_check_authority_chain(QCryptoTLSCredsX509 *creds,
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
-                checking_issuer = 1;
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
 
+    rv = gnutls_x509_crt_get_dn2(cert_to_check, &dn);
+    if (rv < 0) {
+        error_setg(errp, "Unable to fetch cert DN: %s",
+                   gnutls_strerror(rv));
+        return -1;
+    }
+    error_setg(errp, "Cert '%s' has no issuer in CA chain", dn.data);
+    gnutls_free(dn.data);
     return -1;
 }
 
-- 
2.49.0


