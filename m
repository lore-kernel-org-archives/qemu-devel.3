Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A93C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWYe-0004c0-SJ; Mon, 10 Feb 2025 11:23:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXn-0002kl-9t
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:59 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXh-0002mW-OO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:21:58 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso5236055e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204512; x=1739809312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPAQvpFRjPctQI6PmGKtxnrUvgxo4boPkJkljtp3rbA=;
 b=rFqmg6tYWSQO4SyTjSyVUZkts21QlOTAHYKyh2z/+tzQe/h//E4cqilVp12DIhEXr5
 qejxvBtHKmthplJ2ZhBPMzn+GxdqFq/J8oPAuSbijTnPuBQVDLavv6djD5s8D5wh4D04
 b5BrC91qEMHOlfLt+w65HYA5TYFMcJNFO1Y4U4jpPuUVOrAjLMxJr4gEwAG0w9cFsiL/
 PoVnppORbdjQnnR/YBD/ocvJbVKeS10d657Sqa5LvVu+RCxGOt/dQ2QuxxYgyLOCSSin
 BX+WDL5r9A7Dm9igiNeAZyh4FVnvcHunw1I1dvGlrJV5lkvTjJKucQeQTaIaADwOmsLu
 U7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204512; x=1739809312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPAQvpFRjPctQI6PmGKtxnrUvgxo4boPkJkljtp3rbA=;
 b=o/nUW0VwQMBYdUhwtr6fbMhTNYIKQ6iOEYmM15WcN53O73Fi7NZjgqOtzUnGRzsO67
 AyHr9hWEqwff2phDJyfRfp2Q7iTMTj2E8xroxq/mNbbMiv8y3O0y9JyyJGQI3C+NGG5g
 OKTGPIBpRE/L7MFFDHNwa36ZBhxNJvr/trnuBGvzAGK85XqGG0+7S53YLkv0lKgmpe8x
 DxEoqpHq1fyUqfhEJbbvl0XsN8xb0GmqT0LzmHktYtpPIs/jMoE2BehibBlDELgQow9M
 /X44uFYkawFoaEx6XWHYB8U8ofiXqoXLMGzpEQShus5xZXz3yOIwW2Nj0N0t0VLFwA+t
 PNqw==
X-Gm-Message-State: AOJu0YwK2eA4A8z0QXTlU6K21tRoq1iRONT6s7M/iY8ALFwkmGhykgWk
 vlbgA1afGC0g5yOvQGAic0/ZKe55IGX5JEMAuZKSiW4CwVupWfBiqlloHITRFvEw0UHxAvzjAO6
 USH8=
X-Gm-Gg: ASbGncvYJayQXv010K+PhUa7mIDcNJG3zgCrXYAyzdNQC32dVmRoPCjxzH5yJBhos66
 YHpRWZSdKUtxleVjpojKr3sSuLg64RvvrtzoL3F7IJs++uZy4SiYD+fHq0HxkZpB5dbl7gr4nH/
 6TZklmaJfE5tnCwYIwjKTLeoLPn6CXEX1Bkpl07uDJLnrJ4rduPju1AKkY4c6iPDvhkKBy2gRDS
 7JtnLXwSmhgnp9IwDrg5URm64AFsspATVNtVrhblJ6JNHXleKv0O2v9DC4oV7Opkxw5BOMXN+sn
 eEcYPlIIYsJvzOD8OgLEUFR52pQkuXueG6KrNaysXk/VSwOdKsz5ih5PDHNkYuPz4A==
X-Google-Smtp-Source: AGHT+IFKTjEUo1qmbmcNyXTlCbqxzKehTTXJi6tKZcVQrLxPIi1FM7DzNN6Yf4mIRYo5bdtIvgyEWw==
X-Received: by 2002:a5d:598b:0:b0:38d:d026:5af8 with SMTP id
 ffacd0b85a97d-38dd0265e43mr8776674f8f.12.1739204511617; 
 Mon, 10 Feb 2025 08:21:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc3a10fffsm11812283f8f.12.2025.02.10.08.21.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:21:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] crypto/tlscredspsk: Rename 'creds' -> 'psk_creds'
Date: Mon, 10 Feb 2025 17:21:32 +0100
Message-ID: <20250210162135.14123-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210162135.14123-1-philmd@linaro.org>
References: <20250210162135.14123-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
next commit, rename QCryptoTLSCredsPSK creds as 'psk_creds'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/tlscredspsk.c | 58 ++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index aa270d7988b..033f1d4287b 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -68,7 +68,7 @@ lookup_key(const char *pskfile, const char *username, gnutls_datum_t *key,
 }
 
 static int
-qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
+qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *psk_creds,
                            Error **errp)
 {
     g_autofree char *pskfile = NULL;
@@ -78,54 +78,54 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
     int rv = -1;
     gnutls_datum_t key = { .data = NULL };
 
-    trace_qcrypto_tls_creds_psk_load(creds,
-            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
+    trace_qcrypto_tls_creds_psk_load(psk_creds,
+            psk_creds->parent_obj.dir ? psk_creds->parent_obj.dir : "<nodir>");
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (creds->username) {
+    if (psk_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (psk_creds->username) {
             error_setg(errp, "username should not be set when endpoint=server");
             goto cleanup;
         }
 
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+        if (qcrypto_tls_creds_get_path(&psk_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&creds->parent_obj,
+            qcrypto_tls_creds_get_path(&psk_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_PSKFILE,
                                        true, &pskfile, errp) < 0) {
             goto cleanup;
         }
 
-        ret = gnutls_psk_allocate_server_credentials(&creds->data.server);
+        ret = gnutls_psk_allocate_server_credentials(&psk_creds->data.server);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
             goto cleanup;
         }
 
-        if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
-                                                 &creds->parent_obj.dh_params,
+        if (qcrypto_tls_creds_get_dh_params_file(&psk_creds->parent_obj, dhparams,
+                                                 &psk_creds->parent_obj.dh_params,
                                                  errp) < 0) {
             goto cleanup;
         }
 
-        ret = gnutls_psk_set_server_credentials_file(creds->data.server, pskfile);
+        ret = gnutls_psk_set_server_credentials_file(psk_creds->data.server, pskfile);
         if (ret < 0) {
             error_setg(errp, "Cannot set PSK server credentials: %s",
                        gnutls_strerror(ret));
             goto cleanup;
         }
-        gnutls_psk_set_server_dh_params(creds->data.server,
-                                        creds->parent_obj.dh_params);
+        gnutls_psk_set_server_dh_params(psk_creds->data.server,
+                                        psk_creds->parent_obj.dh_params);
     } else {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+        if (qcrypto_tls_creds_get_path(&psk_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_PSKFILE,
                                        true, &pskfile, errp) < 0) {
             goto cleanup;
         }
 
-        if (creds->username) {
-            username = creds->username;
+        if (psk_creds->username) {
+            username = psk_creds->username;
         } else {
             username = "qemu";
         }
@@ -133,14 +133,14 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
             goto cleanup;
         }
 
-        ret = gnutls_psk_allocate_client_credentials(&creds->data.client);
+        ret = gnutls_psk_allocate_client_credentials(&psk_creds->data.client);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
             goto cleanup;
         }
 
-        ret = gnutls_psk_set_client_credentials(creds->data.client,
+        ret = gnutls_psk_set_client_credentials(psk_creds->data.client,
                                                 username, &key, GNUTLS_PSK_KEY_HEX);
         if (ret < 0) {
             error_setg(errp, "Cannot set PSK client credentials: %s",
@@ -157,22 +157,22 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
 
 
 static void
-qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds)
+qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *psk_creds)
 {
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
-        if (creds->data.client) {
-            gnutls_psk_free_client_credentials(creds->data.client);
-            creds->data.client = NULL;
+    if (psk_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+        if (psk_creds->data.client) {
+            gnutls_psk_free_client_credentials(psk_creds->data.client);
+            psk_creds->data.client = NULL;
         }
     } else {
-        if (creds->data.server) {
-            gnutls_psk_free_server_credentials(creds->data.server);
-            creds->data.server = NULL;
+        if (psk_creds->data.server) {
+            gnutls_psk_free_server_credentials(psk_creds->data.server);
+            psk_creds->data.server = NULL;
         }
     }
-    if (creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
-        creds->parent_obj.dh_params = NULL;
+    if (psk_creds->parent_obj.dh_params) {
+        gnutls_dh_params_deinit(psk_creds->parent_obj.dh_params);
+        psk_creds->parent_obj.dh_params = NULL;
     }
 }
 
-- 
2.47.1


