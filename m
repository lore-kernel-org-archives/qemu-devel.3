Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DCBC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWYS-0003jw-FU; Mon, 10 Feb 2025 11:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXu-0002xd-Vw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:22:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thWXr-0002nm-0i
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:22:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43946b5920cso6644695e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204521; x=1739809321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yqG8v8WSQiv1ErGVoG3M0wvKSSpp25E6v1a1sbfsZk=;
 b=JWKEMYmXOzafoRyF0ayYsezYIZylxyhFeCp6AEUV4rVhuSyuAeIzPJkogE4gjbzwOx
 zF6PAj7/y3VUiM1nrzgcDfhViuG7nf4Jn1XFh+FbojBvxnbpvgEm4e02HqLYvbvPG/T0
 sZz+ATWrYAzbGzIMWUoajfrrBasRWWlnaLsV4hVAsqRl6aTZZp8L8q/l2ddJ/0YP3q0P
 T9urcsRm+MBGo3a+lNHiPAU52T9k226dQJmt8bnk2rZvOMV6PHEw8ZqE9ut8pMBfiACQ
 +M8jRA/r/P7lxZb8Vbt0rzckAkGR9R7pwPnU8r6zZW8XDwqS1H3j8dUyS/wMiUwsYj/n
 OLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204521; x=1739809321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yqG8v8WSQiv1ErGVoG3M0wvKSSpp25E6v1a1sbfsZk=;
 b=iW07g/AhBpj5DZTafPR1JAKXGn3AZ+5IYqg+E6XN7SMGgYVt2kSUlb8OoHS81Gs+u9
 eEe0ERLxAQZcXk+b8LxqVi1ue07i67YUiGbQHWEvRCVQZjVPLIrbhAJaunQvhmDoo8MH
 2PQyHYkoj8NB/THKzRBZ9/QJAQ5Coicl14tKrQzylYem1oMuXTlpw3fS+bp2NQDNXro6
 FFFpmxnfzV+tuAgCQ1bM/y/TpAHOf/PCbvjfTklUE7uwg+Yb/AX1klY8bI0GjqGD78TT
 GxWWD5Q/zzYnPhTkuOPxMtYoEgdiu+BuA3ZJXK6m0T/B6JJicTZR5TOmkGYiSpild1tG
 mA8g==
X-Gm-Message-State: AOJu0YyDr6wkx5NhhE0x4gLYyvNU8MCaWVArPhJIKFbM/BPyYu1w1Dld
 DTBlP9tNwx4PhZw6t1GfrRvxEyPDUQPrB+3TypXjIGeTCj8p1mddbRU+lHiXXiFu3TkG79c8pW3
 C5EA=
X-Gm-Gg: ASbGncssVPk9a46Q2YsYN3GomhwDt5IryX7orAtGeMrudUAHWR0Z/+PtTPAFYcE8Scy
 hEGdYOlLnpdIDURP2/60uUgbuiD/DsBzCj5Z7vIMI6PgexmJeEGCS32dad8DyX0PkTUubWV74FC
 PDGmQZOGrCMz9tlSOo4MY5uA7+h6Yvi7XIVkuD5m/kVVvZw3gcY4XcvmMDEebgldl7i/kvVNZsC
 MoeHHrbxFsiiHZNTOErFBYMVOJiNhnXGNBp9xNLZXdIzX/W0hC/kA/Rt/wxvOy0u7KBCIxiprPY
 XB70/bGWvGz3tkUH/By/bzOKep2seWd70TvLHaKRS9bbZUBJf90HEuDjOPOIt7ZkIQ==
X-Google-Smtp-Source: AGHT+IEas8fB8elFJzbZObPR2JRo+mID134ucAm+DCOyZtaaaNeUti7ww8jWUpDh4HrEx6J1Ed+fag==
X-Received: by 2002:a05:600c:458e:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-439249abc43mr106424325e9.22.1739204521001; 
 Mon, 10 Feb 2025 08:22:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5c8c37esm10944371f8f.2.2025.02.10.08.22.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 08:22:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/6] crypto/tlscredsanon: Rename 'creds' -> 'anon_creds'
Date: Mon, 10 Feb 2025 17:21:34 +0100
Message-ID: <20250210162135.14123-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210162135.14123-1-philmd@linaro.org>
References: <20250210162135.14123-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
next commit, rename QCryptoTLSCredsAnon creds as 'anon_creds'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 crypto/tlscredsanon.c | 44 +++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 476cf89c963..15808329d89 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -33,39 +33,39 @@
 
 
 static int
-qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
+qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *anon_creds,
                             Error **errp)
 {
     g_autofree char *dhparams = NULL;
     int ret;
 
-    trace_qcrypto_tls_creds_anon_load(creds,
-            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
+    trace_qcrypto_tls_creds_anon_load(anon_creds,
+            anon_creds->parent_obj.dir ? anon_creds->parent_obj.dir : "<nodir>");
 
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+    if (anon_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (qcrypto_tls_creds_get_path(&anon_creds->parent_obj,
                                        QCRYPTO_TLS_CREDS_DH_PARAMS,
                                        false, &dhparams, errp) < 0) {
             return -1;
         }
 
-        ret = gnutls_anon_allocate_server_credentials(&creds->data.server);
+        ret = gnutls_anon_allocate_server_credentials(&anon_creds->data.server);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
             return -1;
         }
 
-        if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
-                                                 &creds->parent_obj.dh_params,
+        if (qcrypto_tls_creds_get_dh_params_file(&anon_creds->parent_obj, dhparams,
+                                                 &anon_creds->parent_obj.dh_params,
                                                  errp) < 0) {
             return -1;
         }
 
-        gnutls_anon_set_server_dh_params(creds->data.server,
-                                         creds->parent_obj.dh_params);
+        gnutls_anon_set_server_dh_params(anon_creds->data.server,
+                                         anon_creds->parent_obj.dh_params);
     } else {
-        ret = gnutls_anon_allocate_client_credentials(&creds->data.client);
+        ret = gnutls_anon_allocate_client_credentials(&anon_creds->data.client);
         if (ret < 0) {
             error_setg(errp, "Cannot allocate credentials: %s",
                        gnutls_strerror(ret));
@@ -78,22 +78,22 @@ qcrypto_tls_creds_anon_load(QCryptoTLSCredsAnon *creds,
 
 
 static void
-qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *creds)
+qcrypto_tls_creds_anon_unload(QCryptoTLSCredsAnon *anon_creds)
 {
-    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
-        if (creds->data.client) {
-            gnutls_anon_free_client_credentials(creds->data.client);
-            creds->data.client = NULL;
+    if (anon_creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+        if (anon_creds->data.client) {
+            gnutls_anon_free_client_credentials(anon_creds->data.client);
+            anon_creds->data.client = NULL;
         }
     } else {
-        if (creds->data.server) {
-            gnutls_anon_free_server_credentials(creds->data.server);
-            creds->data.server = NULL;
+        if (anon_creds->data.server) {
+            gnutls_anon_free_server_credentials(anon_creds->data.server);
+            anon_creds->data.server = NULL;
         }
     }
-    if (creds->parent_obj.dh_params) {
-        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
-        creds->parent_obj.dh_params = NULL;
+    if (anon_creds->parent_obj.dh_params) {
+        gnutls_dh_params_deinit(anon_creds->parent_obj.dh_params);
+        anon_creds->parent_obj.dh_params = NULL;
     }
 }
 
-- 
2.47.1


