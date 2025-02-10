Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4099C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWYZ-0004Ga-Aq; Mon, 10 Feb 2025 11:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXy-0002yu-AB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:22:13 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXv-0002oR-H9
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:22:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso31665525e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204525; x=1739809325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgL4Fc/bavoIHIDwcU+jgf+XwNfl7HHKSxC0Pl5Yjqo=;
 b=wTQPjVC7MZwkPbRCc0yj80oQ50P71/kow28aOq2v73a4GHTevzv3uCN+TlkgWWIhR1
 Gd9eT2VhEAZDfSxNEfnKutqW0D6pxGUk83n0SBv8Q/SkbUrfYWY6R6Mmhdl47R+gdjjT
 VCHobpvDeqoDDmneaNkMShsFb0UvTmkUMZ1B9AzNHfU0iXbMUuUZHdn76cE3j9/VZyXb
 IL70ZaB22ipy10WL3uy8359bvUIerGSrR8NoWUQOYakwQAdI9kOXkyT3bkHHgy3ei5tn
 dMHA9iB4/VRE5sbK6BaPMhsFjIIViw8JN+Xscml35BMNknw6IwlMFz2haFhw7/8E47xy
 B60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204525; x=1739809325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgL4Fc/bavoIHIDwcU+jgf+XwNfl7HHKSxC0Pl5Yjqo=;
 b=k7/LSBMLXAdQ+A6LKQafRVqaGpIbMk8hpnaLwx1Kkjv/4rUiz4a6Ug++26rgG6L1mf
 j/edFQ0yHkwXHG96mVvLn/Z6ZsgVzYvG/Cx51ZVTBb85fpf9ZDkhRk6ECIncQDCjbzhS
 Q2qnDmJRXFA64aKG9xvgg/DWQ1ZcWoohys8tFFfPv89+z+gobrygQEvqjkYMFyOrCsPk
 3An+gHVQES+unLwxPrnEmLITfi5nYffTBliNGAhefmBWS01yMRXxkrWjUUtkBWF8azQ/
 KBVSjqu1XjiOs98dUTJvDbKXN4ljjEhB8jdVMaqG0x8mvliloxFZQ1ibiW7Jd5Lpq1cU
 PZZw==
X-Gm-Message-State: AOJu0Yxl6a391t0XcGotrtAl12Kvau0RLXzzOvyHuJ19fHyWKwfWDU31
 BDDesWawpZB6etDT8UGeVSE0t0cKvuiL2r3XkkYJbyx8p9O7wByVvsPncNykAEVlpb3yb5M2OB6
 +ZB8=
X-Gm-Gg: ASbGncurOukurB89WZPwYgUvVNT/qw0cNSnnO+k6UBh4kBpTMbYurmwXMy/rWEKT+v6
 7Fq6ea9yFZOAd6TyM0S12zE1lUZCykteQDarofgTZ/a/oW1JwOpTYFSkQ3N/JPLFIjktNwmDRsY
 +J28d4vtxzmOFHKmkOUvQXUi6FKw42KYwIdkxceUU7HskZkwqHV1ah4HJdsAgUOoiSoyrYpfsLX
 zVYIAfRbb4+Gzn4NsHJfYOzXnX4JaCLfs1z+MfrOCR0jmWSMzRIW89HPbx2KFD9uT3T57N0APe/
 71PSzQAWLSfG1O4xgpN41w+eY+Go1kFWJxh7svXrY+MMMPCTaNhrY9xg146bjquyvg==
X-Google-Smtp-Source: AGHT+IGo6F3alYT8NXvS6ffLMwKueb7QtCi6I1rPcZp1YM6K8iKYj8z/l/8l4Cmk3Y/is0P7VExKTg==
X-Received: by 2002:a05:600c:1ca8:b0:439:3d5c:a028 with SMTP id
 5b1f17b1804b1-4394c81a33amr5066465e9.12.1739204525633; 
 Mon, 10 Feb 2025 08:22:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd1093bb2sm7978079f8f.40.2025.02.10.08.22.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:22:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] crypto/tlscredsanon: Access QOM parent via
 QCRYPTO_TLS_CREDS() macro
Date: Mon, 10 Feb 2025 17:21:35 +0100
Message-ID: <20250210162135.14123-7-philmd@linaro.org>
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

Prefer accessing QCryptoTLSCredsAnon's QOM parent via the
QCRYPTO_TLS_CREDS() cast macro, rather than parent_obj.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/tlscredsanon.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 15808329d89..d42404acd8b 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -36,14 +36,15 @@ static int
 qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *anon_creds,
                             Error **errp)
 {
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(anon_creds);
     g_autofree char *dhparams = NULL;
     int ret;
 
     trace_qcrypto_tls_creds_anon_load(anon_creds,
-            anon_creds->parent_obj.dir ? anon_creds->parent_obj.dir : "<nodir>");
+                                      creds->dir ? creds->dir : "<nodir>");
 
-    if (anon_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_path(&anon_creds->parent_obj,
+    if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (qcrypto_tls_creds_get_path(creds,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
             return -1;
@@ -56,14 +57,14 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *anon_creds,
             return -1;
         }
 
-        if (qcrypto_tls_creds_get_dh_params_file(&anon_creds->parent_obj, dhparams,
-                                                 &anon_creds->parent_obj.dh_params,
+        if (qcrypto_tls_creds_get_dh_params_file(creds, dhparams,
+                                                 &creds->dh_params,
                                                  errp) < 0) {
             return -1;
         }
 
         gnutls_anon_set_server_dh_params(anon_creds->data.server,
-                                         anon_creds->parent_obj.dh_params);
+                                         creds->dh_params);
     } else {
         ret = gnutls_anon_allocate_client_credentials(&anon_creds->data.client);
         if (ret < 0) {
@@ -80,7 +81,9 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *anon_creds,
 static void
 qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *anon_creds)
 {
-    if (anon_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+    QCryptoTLSCreds *creds = QCRYPTO_TLS_CREDS(anon_creds);
+
+    if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
         if (anon_creds->data.client) {
             gnutls_anon_free_client_credentials(anon_creds->data.client);
             anon_creds->data.client = NULL;
@@ -91,9 +94,9 @@ qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *anon_creds)
             anon_creds->data.server = NULL;
         }
     }
-    if (anon_creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(anon_creds->parent_obj.dh_params);
-        anon_creds->parent_obj.dh_params = NULL;
+    if (creds->dh_params) {
+        gnutls_dh_params_deinit(creds->dh_params);
+        creds->dh_params = NULL;
     }
 }
 
-- 
2.47.1


