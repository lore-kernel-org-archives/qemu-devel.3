Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426CBC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWXs-0002mO-IG; Mon, 10 Feb 2025 11:22:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXe-0002Uv-OA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:52 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXc-0002lk-Lr
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:50 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38dcf8009f0so1505807f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204507; x=1739809307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qsTRNQTUfL2h+m/cpyp4nywBspQp5fByW/Zolmcu5/c=;
 b=RhrCs16tns4F9azXDP5mH+5jDQAMZ3ZbFgwrhBDzO+rh+B0PZrFK50gSQozMi4JZbg
 cOtf/BP9rxxtDgnxfbOqCes412TFbo7L9ieR6N/hfgwC7G3GexWLn9ag3hGUFVhzyVQ8
 xt313L6apj9hzOaCCz0AG93ACiieFCFgWp0BACqCAC11rLKEm+5uca4hZcUdT39Q51Iw
 sgAPRiEGNOv6Th1HyW5dHaPyVnMv/669THgCd5+HWIU4uQjES94jB0HNxtV8PlFjdRvR
 2YSazkpKtrDJWYFl8pmwfehbZRNNbZAmF2FAC87LAG7ITi1kb9FFy28Bgjtk/plDEsC7
 kYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204507; x=1739809307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsTRNQTUfL2h+m/cpyp4nywBspQp5fByW/Zolmcu5/c=;
 b=mIyqDkUEgMcdlhEc6CFOuu1IUSTDxdxmfbnLUWhCZsL4sB5OToSt33pnroO7be3E9p
 qMMvqa6tbJViEYvdKuHN9O5TfChtFyoore8F2l/KDZoeiRY+XHbPzz8O4ewnILlmSXkp
 UcT41Ik4nFeIxXWyJiTMIsdGq2t8vVnwpgyALjQY7MasihbAfPdV4gxAtCcEHxcSuC+N
 pzSx6n9w4fH2fZLg091KsHLcu4aFQm3NoubULdG4iMJnSvkIOA8eSh6lB0lWG4/2dmR7
 g6dTtSSf6MTwu9IrweIf5U9gA43eSboBsIW5OI2+dxRJ5vaZ82yZZCtRHN/V41QTzF4q
 zd8A==
X-Gm-Message-State: AOJu0Yz7qIjJ9OFBXFNBkinDVn+4m9IUp8H+gx0peVzM+KZ6Izcxgtmw
 e5HL35TTqd7uLMADBGEbRnATbrB30U+P1M5yww+Y4ukQza6jUh28MbiEOKhOPYfAL3R7zrpX5wG
 PpQ0=
X-Gm-Gg: ASbGncvBxR/fI/OCLpL0AerTY6I2JbyhmxCZdS2hQ+CkFLcTmyv0f3rikv5/+UVCg1W
 eb1AP1TG8mSYna3WrNYnpZ3iJujDv9sRufEhQCCrTGl66/cjywWbLyPGC8UI6AJFznB3REpvlJq
 X/SzbYohlaxqJxj2H8VosKvwKH0Cv/vAEA1l06uuLyYStuop/b8s5MW3B/aw7jPug7uEoCwBDSt
 Z/G0UFr+xbOLQbaPSryMQNcq9tr2O8E4F8YFulEJ9rmTnFScKkw3dEepLl9ivIj2mQh746Cg2Bz
 LJC3bYVcv6lo+TTG9yeTlBqoGlI9A6Qq26W4Ch5XVfM61fmpxutrtu7Ylhlm1bQZbw==
X-Google-Smtp-Source: AGHT+IH9i08OvSTkWg2SEjmSm+UVeusF0LVJsxdYUU2i33MkaJ4cti53SA4guSQcShTU6ZQc/e8pEg==
X-Received: by 2002:a05:6000:1f83:b0:38d:de92:adab with SMTP id
 ffacd0b85a97d-38dde92ae55mr4463016f8f.29.1739204506832; 
 Mon, 10 Feb 2025 08:21:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc7711bbbsm10303526f8f.47.2025.02.10.08.21.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:21:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] crypto/tlscredsx509: Access QOM parent via
 QCRYPTO_TLS_CREDS() macro
Date: Mon, 10 Feb 2025 17:21:31 +0100
Message-ID: <20250210162135.14123-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210162135.14123-1-philmd@linaro.org>
References: <20250210162135.14123-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Prefer accessing QCryptoTLSCredsX509's QOM parent via the
QCRYPTO_TLS_CREDS() cast macro, rather than parent_obj.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/tlscredsx509.c | 45 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index eb197e145f3..84b88747f21 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -534,40 +534,41 @@ static int
 qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *x509_creds,
                             Error **errp)
 {
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(x509_creds);
     char *cacert = NULL, *cacrl = NULL, *cert = NULL,
         *key = NULL, *dhparams = NULL;
     int ret;
     int rv = -1;
 
     trace_qcrypto_tls_creds_x509_load(x509_creds,
-            x509_creds->parent_obj.dir ? x509_creds->parent_obj.dir : "<nodir>");
+                                      creds->dir ? creds->dir : "<nodir>");
 
-    if (x509_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+    if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_CA_CERT,
                                        true, &cacert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_CA_CRL,
                                        false, &cacrl, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_SERVER_CERT,
                                        true, &cert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_SERVER_KEY,
                                        true, &key, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
             goto cleanup;
         }
     } else {
-        if (qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+        if (qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_CA_CERT,
                                        true, &cacert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
                                        false, &cert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
                                        false, &key, errp) < 0) {
             goto cleanup;
@@ -576,7 +577,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *x509_creds,
 
     if (x509_creds->sanityCheck &&
         qcrypto_tls_creds_x509_sanity_check(x509_creds,
-            x509_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
+            creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
             cacert, cert, errp) < 0) {
         goto cleanup;
     }
@@ -630,14 +631,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *x509_creds,
         }
     }
 
-    if (x509_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_dh_params_file(&x509_creds->parent_obj, dhparams,
-                                                 &x509_creds->parent_obj.dh_params,
+    if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (qcrypto_tls_creds_get_dh_params_file(creds, dhparams,
+                                                 &creds->dh_params,
                                                  errp) < 0) {
             goto cleanup;
         }
         gnutls_certificate_set_dh_params(x509_creds->data,
-                                         x509_creds->parent_obj.dh_params);
+                                         creds->dh_params);
     }
 
     rv = 0;
@@ -654,13 +655,15 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *x509_creds,
 static void
 qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *x509_creds)
 {
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(x509_creds);
+
     if (x509_creds->data) {
         gnutls_certificate_free_credentials(x509_creds->data);
         x509_creds->data = NULL;
     }
-    if (x509_creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(x509_creds->parent_obj.dh_params);
-        x509_creds->parent_obj.dh_params = NULL;
+    if (creds->dh_params) {
+        gnutls_dh_params_deinit(creds->dh_params);
+        creds->dh_params = NULL;
     }
 }
 
@@ -746,15 +749,15 @@ qcrypto_tls_creds_x509_reload(QCryptoTLSCreds *creds, Error **errp)
     QCryptoTLSCredsX509 *x509_creds = QCRYPTO_TLS_CREDS_X509(creds);
     Error *local_err = NULL;
     gnutls_certificate_credentials_t creds_data = x509_creds->data;
-    gnutls_dh_params_t creds_dh_params = x509_creds->parent_obj.dh_params;
+    gnutls_dh_params_t creds_dh_params = creds->dh_params;
 
     x509_creds->data = NULL;
-    x509_creds->parent_obj.dh_params = NULL;
+    creds->dh_params = NULL;
     qcrypto_tls_creds_x509_load(x509_creds, &local_err);
     if (local_err) {
         qcrypto_tls_creds_x509_unload(x509_creds);
         x509_creds->data = creds_data;
-        x509_creds->parent_obj.dh_params = creds_dh_params;
+        creds->dh_params = creds_dh_params;
         error_propagate(errp, local_err);
         return false;
     }
-- 
2.47.1


