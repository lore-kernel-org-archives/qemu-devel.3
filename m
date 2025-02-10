Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5618AC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWY9-0003DN-ED; Mon, 10 Feb 2025 11:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXo-0002pS-HK
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:22:01 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXm-0002n2-QR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:22:00 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so30300535e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204516; x=1739809316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjYHACE69TKRgftmtMmsnjmBnOemI4kgCBT6PrMcoww=;
 b=C+40x2iiOb37CNZKwwWsuDMniTQd12omwLkkJQ1TQThiUSJZJL57zu5Iu+cMJrsOdt
 6faTyWL6we52xqTQ1/EHTAYXQ6mzsaS5kgRvAEd3GdNIcif/bjcjnkf8NNYpxoyT7Jag
 AYWn+Y1YnjmffFo7GVKakzKlvVLprEzUiQ/Kx2r2nSPxvMveeJj4gYpUIp7Y937iKk9D
 tCAuNeD3WMId99N327QabgolYP77tZMgB0t6Gi1TIZPFfjBLcSJp1L3degbWAn4nYZr/
 UR4uS+UbCkKff9uxCEw3TRKCTGMf8zCk0FvW3M/j+G+5PwuVkxkHspRvNyeXp3HWKB55
 fd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204516; x=1739809316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjYHACE69TKRgftmtMmsnjmBnOemI4kgCBT6PrMcoww=;
 b=FESQJ9xQu9XMa1u9yHKZPtdRb18fXsOQVTPfVLuHWJKxe4NTlE5OQxOS81J1noDzYv
 jZTRm5wfTZ8n9zlt06ykzqsxc+YwxuRvyA9i+8i2N18pQFKqDBvkhzy/MFph+cUOL2xF
 DaxAg8jaGka+sw4QQjrTB3ivmuYAh13LJ8S/yd47SmiccWlYcDjc/LOtwg3pj4cabARb
 ryHK7N8jmtKJWt+BS1xzpfMC7kK9c3IVifQe6tTE3FInC0wjZyWn6i6Hi8putpLy8+3a
 FfM1nITIAAuKgwZ63A6Sw1Fea3n97F2rZpaIXWxn9qPpkKV7WEra9GlHr0RxZuVmZYDq
 gyLg==
X-Gm-Message-State: AOJu0YwCApbUZEWDwCR9bls3vv64ntqHGn2iXbDOdXmyY0scUvmALZ6v
 VJc+vAFAyyJP1pV42pTIul+sGPEp7retjanB3JTV84Jc48Z0qUKC8iB5J5dRqnIeKMAeh4gAO7U
 Ccp4=
X-Gm-Gg: ASbGnctn8TpnOj4cDUqtyKGnwSoGMC7TEnw9FNCH0PQRpNb3bj1yF0DsRX6gjkBeoGz
 mmqVfFltcpkQYaoCPh275cBMoQMIavHK9uwMsKx+74l31bLsQ4Sr6bnkfSOPG0yJF4xfF5OfZxO
 Ir+tY55RB7nUFonXj9xgNvBftuZwMxxLTHbAixQs8qRQVfILNZOgY9wiqgEjR1TzTTBYSXN1ScV
 n/bE2mAplBCgLhJv7pvm1Iiqyo+0VTB0Ih0rdJFt3xwjk00bLyS9POHElZPM5/ZQZmfs6+weWK6
 mIhcqwC7CAbxFC5SOmsh8utXTBE3Iw6aDZA3zaNfKavx8Om8tlSEV/RLRMa7Sbv6BQ==
X-Google-Smtp-Source: AGHT+IFs47S5IkLE12VtOG13mIG2SP9bFsbJvmQ9kg+3ktLS4GHYNq3w9MgLL9kBS6DynBJwZzhO9g==
X-Received: by 2002:a05:600c:4f89:b0:439:4bb0:aba0 with SMTP id
 5b1f17b1804b1-4394bb0adb6mr12135845e9.8.1739204516360; 
 Mon, 10 Feb 2025 08:21:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcb781bdcsm9583869f8f.23.2025.02.10.08.21.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:21:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] crypto/tlscredspsk: Access QOM parent via
 QCRYPTO_TLS_CREDS() macro
Date: Mon, 10 Feb 2025 17:21:33 +0100
Message-ID: <20250210162135.14123-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210162135.14123-1-philmd@linaro.org>
References: <20250210162135.14123-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Prefer accessing QCryptoTLSCredsPSK's QOM parent via the
QCRYPTO_TLS_CREDS() cast macro, rather than parent_obj.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/tlscredspsk.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index 033f1d4287b..69769bc0b28 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -71,6 +71,7 @@ static int
 qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *psk_creds,
                            Error **errp)
 {
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(psk_creds);
     g_autofree char *pskfile = NULL;
     g_autofree char *dhparams = NULL;
     const char *username;
@@ -79,18 +80,18 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *psk_creds,
     gnutls_datum_t key = { .data = NULL };
 
     trace_qcrypto_tls_creds_psk_load(psk_creds,
-            psk_creds->parent_obj.dir ? psk_creds->parent_obj.dir : "<nodir>");
+                                     creds->dir ? creds->dir : "<nodir>");
 
-    if (psk_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+    if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
         if (psk_creds->username) {
             error_setg(errp, "username should not be set when endpoint=server");
             goto cleanup;
         }
 
-        if (qcrypto_tls_creds_get_path(&psk_creds->parent_obj,
+        if (qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0 ||
-            qcrypto_tls_creds_get_path(&psk_creds->parent_obj,
+            qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_PSKFILE,
                                        true, &pskfile, errp) < 0) {
             goto cleanup;
@@ -103,8 +104,8 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *psk_creds,
             goto cleanup;
         }
 
-        if (qcrypto_tls_creds_get_dh_params_file(&psk_creds->parent_obj, dhparams,
-                                                 &psk_creds->parent_obj.dh_params,
+        if (qcrypto_tls_creds_get_dh_params_file(creds, dhparams,
+                                                 &creds->dh_params,
                                                  errp) < 0) {
             goto cleanup;
         }
@@ -116,9 +117,9 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *psk_creds,
             goto cleanup;
         }
         gnutls_psk_set_server_dh_params(psk_creds->data.server,
-                                        psk_creds->parent_obj.dh_params);
+                                        creds->dh_params);
     } else {
-        if (qcrypto_tls_creds_get_path(&psk_creds->parent_obj,
+        if (qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_PSKFILE,
                                        true, &pskfile, errp) < 0) {
             goto cleanup;
@@ -159,7 +160,9 @@ qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *psk_creds,
 static void
 qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *psk_creds)
 {
-    if (psk_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(psk_creds);
+
+    if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
         if (psk_creds->data.client) {
             gnutls_psk_free_client_credentials(psk_creds->data.client);
             psk_creds->data.client = NULL;
@@ -170,9 +173,9 @@ qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *psk_creds)
             psk_creds->data.server = NULL;
         }
     }
-    if (psk_creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(psk_creds->parent_obj.dh_params);
-        psk_creds->parent_obj.dh_params = NULL;
+    if (creds->dh_params) {
+        gnutls_dh_params_deinit(creds->dh_params);
+        creds->dh_params = NULL;
     }
 }
 
-- 
2.47.1


