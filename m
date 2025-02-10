Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7B9C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWY6-00034Q-OB; Mon, 10 Feb 2025 11:22:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXa-0002Ty-3u
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:50 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXY-0002lO-8R
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43944181e68so12882475e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204502; x=1739809302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGsIufIqKlssjun5TXHkqohjkAkuZtcXK/WYSEIHmcE=;
 b=sYr6vG0yEL1Frbl0mWNb2X2vqgL9AVX7/MSPpt62cqUqR9M0/dJXEh3UUc/d51hBt3
 e57EtMwSJKitJHtINirfaVph+rzCKXIrJNrKaoRS+fjxhzKITNceXIz8KntKnUkSCqpW
 f32+dz1y8pr7P8C+jiQLdq1Gv20mKsjpsO8PxaKKWzyqASEPnTwYFzd3b8lk0Kpz4xPQ
 H5gV31Gsi0kt+QV4KUxGIQD1FLNwP/IVQsPYEDkfZKMntZNKjXZut+oXVwO/AWx4Aheo
 HEgdVa/qacqh2LHPQzO9XJvAMfWalx4+orwSSiWnVhHZWubO9E7pJ6UFQemcm/+P3mzr
 /w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204502; x=1739809302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGsIufIqKlssjun5TXHkqohjkAkuZtcXK/WYSEIHmcE=;
 b=opFmZTUjRuB+K3Ztv1QJ1l06TOvuTwqDiR4fkm3iHcUJ0mO632VrHwso2ZA0oXIojS
 PkewrTqwYuiCoRDHc8wq1AWgRp9hOOvYxNATev0Gei9cF+hhnICbHIdRZ1vl0/CcvTty
 gtFXc2S3jOV07WTyaTAF2500xMX0aLPum1tkyY9983Zfwo/KmH9lZ5aVeU2Ps9rrCxBo
 8ZU4M5icYSpl7nEUcN1No1XamrxBqiXaKtohunq9h7YtNTN87iGQS+d7y/1IRRQqBdeK
 72slzsIqRPTWRC96/Yb4M7B29lQ5nV6LlJ15y0GnlUAriITZhupTy1J0i+2HXi0pLWVA
 uw+A==
X-Gm-Message-State: AOJu0YxedntLxy1ODavGtNpF+ta7LxjrkGs8I6Qb6M2/veGWf+nv+j1U
 l38wVLwdoP7Mpzr38C/BAHVsGOr1L8EOd8lllNg/oj7kHUJE1sxqZKS92rsg5Tn4tbEmki0yPaM
 auVM=
X-Gm-Gg: ASbGncvs2EECIDmUJyCzcW8BS17VZXFJ5PPVWJARw45slKmYIY6o5hJrJEGWf4pkX8r
 MdV0wdJ9rmsJVRQQ0tcwZHvYcnyKuZYuxtAwraSxcmltKO1eENTcMJOgXZDtJfehp4azAUo0ho2
 gcjwuuirV8MLkGUSiObhnWPOOICjWYKjxHfMuVsPTHvZWG+vNA6pMTr/HPUOYm/DMfF3Vq5utol
 qDFhrelHiIi+jpiyCCLtqTFDVOEitoFJtlHlzilIdBpuaeyk3sIawbcDdPIUhuZwfOTPJFJU0lr
 SyIgBladan1eun7vz0TUqukaFcglfMHAi+C2M+8a6bPQyCXmW/x1WLYP3q/Q5I1/Ow==
X-Google-Smtp-Source: AGHT+IHsfwDJgQBfqY7PR/Fu+9BiYEwvsKbG2y5hVZePDUBBSJyIjll25pF+1vvmJuIPSwR1VlrpYQ==
X-Received: by 2002:a05:600c:4f05:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-43924989da5mr135420505e9.7.1739204502137; 
 Mon, 10 Feb 2025 08:21:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4394328fcb8sm40812425e9.32.2025.02.10.08.21.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:21:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] crypto/tlscredsx509: Rename 'creds' -> 'x509_creds'
Date: Mon, 10 Feb 2025 17:21:30 +0100
Message-ID: <20250210162135.14123-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210162135.14123-1-philmd@linaro.org>
References: <20250210162135.14123-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

In preparation of naming the QCryptoTLSCreds 'creds' in the
next commit, rename QCryptoTLSCredsX509 creds as 'x509_creds'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/tlscredsx509.c | 66 +++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 24ec5849222..eb197e145f3 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -531,7 +531,7 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
 
 
 static int
-qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
+qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *x509_creds,
                             Error **errp)
 {
     char *cacert = NULL, *cacrl = NULL, *cert = NULL,
@@ -539,56 +539,56 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     int ret;
     int rv = -1;
 
-    trace_qcrypto_tls_creds_x509_load(creds,
-            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
+    trace_qcrypto_tls_creds_x509_load(x509_creds,
+            x509_creds->parent_obj.dir ? x509_creds->parent_obj.dir : "<nodir>");
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+    if (x509_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CA_CERT,
                                        true, &cacert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CA_CRL,
                                        false, &cacrl, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_SERVER_CERT,
                                        true, &cert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_SERVER_KEY,
                                        true, &key, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
             goto cleanup;
         }
     } else {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+        if (qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CA_CERT,
                                        true, &cacert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CLIENT_CERT,
                                        false, &cert, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&x509_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_X509_CLIENT_KEY,
                                        false, &key, errp) < 0) {
             goto cleanup;
         }
     }
 
-    if (creds->sanityCheck &&
-        qcrypto_tls_creds_x509_sanity_check(creds,
-            creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
+    if (x509_creds->sanityCheck &&
+        qcrypto_tls_creds_x509_sanity_check(x509_creds,
+            x509_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
             cacert, cert, errp) < 0) {
         goto cleanup;
     }
 
-    ret = gnutls_certificate_allocate_credentials(&creds->data);
+    ret = gnutls_certificate_allocate_credentials(&x509_creds->data);
     if (ret < 0) {
         error_setg(errp, "Cannot allocate credentials: '%s'",
                    gnutls_strerror(ret));
         goto cleanup;
     }
 
-    ret = gnutls_certificate_set_x509_trust_file(creds->data,
+    ret = gnutls_certificate_set_x509_trust_file(x509_creds->data,
                                                  cacert,
                                                  GNUTLS_X509_FMT_PEM);
     if (ret < 0) {
@@ -599,14 +599,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
 
     if (cert != NULL && key != NULL) {
         char *password = NULL;
-        if (creds->passwordid) {
-            password = qcrypto_secret_lookup_as_utf8(creds->passwordid,
+        if (x509_creds->passwordid) {
+            password = qcrypto_secret_lookup_as_utf8(x509_creds->passwordid,
                                                      errp);
             if (!password) {
                 goto cleanup;
             }
         }
-        ret = gnutls_certificate_set_x509_key_file2(creds->data,
+        ret = gnutls_certificate_set_x509_key_file2(x509_creds->data,
                                                     cert, key,
                                                     GNUTLS_X509_FMT_PEM,
                                                     password,
@@ -620,7 +620,7 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
     }
 
     if (cacrl != NULL) {
-        ret = gnutls_certificate_set_x509_crl_file(creds->data,
+        ret = gnutls_certificate_set_x509_crl_file(x509_creds->data,
                                                    cacrl,
                                                    GNUTLS_X509_FMT_PEM);
         if (ret < 0) {
@@ -630,14 +630,14 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
         }
     }
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
-                                                 &creds->parent_obj.dh_params,
+    if (x509_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (qcrypto_tls_creds_get_dh_params_file(&x509_creds->parent_obj, dhparams,
+                                                 &x509_creds->parent_obj.dh_params,
                                                  errp) < 0) {
             goto cleanup;
         }
-        gnutls_certificate_set_dh_params(creds->data,
-                                         creds->parent_obj.dh_params);
+        gnutls_certificate_set_dh_params(x509_creds->data,
+                                         x509_creds->parent_obj.dh_params);
     }
 
     rv = 0;
@@ -652,15 +652,15 @@ qcrypto_tls_creds_x509_load(QCryptoTLSCredsX509 *creds,
 
 
 static void
-qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *creds)
+qcrypto_tls_creds_x509_unload(QCryptoTLSCredsX509 *x509_creds)
 {
-    if (creds->data) {
-        gnutls_certificate_free_credentials(creds->data);
-        creds->data = NULL;
+    if (x509_creds->data) {
+        gnutls_certificate_free_credentials(x509_creds->data);
+        x509_creds->data = NULL;
     }
-    if (creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
-        creds->parent_obj.dh_params = NULL;
+    if (x509_creds->parent_obj.dh_params) {
+        gnutls_dh_params_deinit(x509_creds->parent_obj.dh_params);
+        x509_creds->parent_obj.dh_params = NULL;
     }
 }
 
-- 
2.47.1


