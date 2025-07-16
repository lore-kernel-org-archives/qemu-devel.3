Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4DCC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzTo-0004J1-IK; Wed, 16 Jul 2025 06:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubzPA-0000GU-DF
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubzP7-0005cO-T1
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752661824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2rYVYVs6sXy1gz4yL8gzBsPaxm//UYf+b2pevdPpx8=;
 b=Tp8xy4pJybNGjr+GerTGKZgc4ZmKySraMobr9xULHxSMkeALGSQRpbvWTweZ5FBTX3BL2i
 oqY/YeeGNfL6epEKy/FUYCBBj+GpthYY7uhFa6LSbS/N4FvI0mUK9p4EJ+yC4ljdSNFuF0
 qy8yKLPt2scBnnC4m/NTzLcaBYIbPNU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-IUhhF_5_MFaXFpBTyW00Eg-1; Wed,
 16 Jul 2025 06:30:22 -0400
X-MC-Unique: IUhhF_5_MFaXFpBTyW00Eg-1
X-Mimecast-MFC-AGG-ID: IUhhF_5_MFaXFpBTyW00Eg_1752661822
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBD7119560A1; Wed, 16 Jul 2025 10:30:21 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.68])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 500081954214; Wed, 16 Jul 2025 10:30:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Henry Kleynhans <hkleynhans@fb.com>
Subject: [PULL 4/4] crypto: load all certificates in X509 CA file
Date: Wed, 16 Jul 2025 11:30:09 +0100
Message-ID: <20250716103009.2047433-5-berrange@redhat.com>
In-Reply-To: <20250716103009.2047433-1-berrange@redhat.com>
References: <20250716103009.2047433-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Henry Kleynhans <hkleynhans@fb.com>

Some CA files may contain multiple intermediaries and roots of trust.
These may not fit into the hard-coded limit of 16.

Extend the validation code to allocate enough space to load all of the
certificates present in the CA file and ensure they are cleaned up.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Henry Kleynhans <hkleynhans@fb.com>
[DB: drop MAX_CERTS constant & whitespace tweaks]
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/tlscredsx509.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 63a72fe47c..143a4caef2 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -426,9 +426,8 @@ qcrypto_tls_creds_load_cert(QCryptoTLSCredsX509 *creds,
 static int
 qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX509 *creds,
                                     const char *certFile,
-                                    gnutls_x509_crt_t *certs,
-                                    unsigned int certMax,
-                                    size_t *ncerts,
+                                    gnutls_x509_crt_t **certs,
+                                    unsigned int *ncerts,
                                     Error **errp)
 {
     gnutls_datum_t data;
@@ -449,20 +448,18 @@ qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX509 *creds,
     data.data = (unsigned char *)buf;
     data.size = strlen(buf);
 
-    if (gnutls_x509_crt_list_import(certs, &certMax, &data,
-                                    GNUTLS_X509_FMT_PEM, 0) < 0) {
+    if (gnutls_x509_crt_list_import2(certs, ncerts, &data,
+                                     GNUTLS_X509_FMT_PEM, 0) < 0) {
         error_setg(errp,
                    "Unable to import CA certificate list %s",
                    certFile);
         return -1;
     }
-    *ncerts = certMax;
 
     return 0;
 }
 
 
-#define MAX_CERTS 16
 static int
 qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
                                     bool isServer,
@@ -471,12 +468,11 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
                                     Error **errp)
 {
     gnutls_x509_crt_t cert = NULL;
-    gnutls_x509_crt_t cacerts[MAX_CERTS];
-    size_t ncacerts = 0;
+    gnutls_x509_crt_t *cacerts = NULL;
+    unsigned int ncacerts = 0;
     size_t i;
     int ret = -1;
 
-    memset(cacerts, 0, sizeof(cacerts));
     if (certFile &&
         access(certFile, R_OK) == 0) {
         cert = qcrypto_tls_creds_load_cert(creds,
@@ -488,8 +484,9 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
     }
     if (access(cacertFile, R_OK) == 0) {
         if (qcrypto_tls_creds_load_ca_cert_list(creds,
-                                                cacertFile, cacerts,
-                                                MAX_CERTS, &ncacerts,
+                                                cacertFile,
+                                                &cacerts,
+                                                &ncacerts,
                                                 errp) < 0) {
             goto cleanup;
         }
@@ -526,6 +523,8 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
     for (i = 0; i < ncacerts; i++) {
         gnutls_x509_crt_deinit(cacerts[i]);
     }
+    gnutls_free(cacerts);
+
     return ret;
 }
 
-- 
2.49.0


