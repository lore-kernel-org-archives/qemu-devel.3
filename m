Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5127FCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoy-0006Wm-5l; Tue, 02 Sep 2025 09:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoj-0005q3-7r
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQoc-0004gy-Gs
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:12:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b9c35bc0aso3461185e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818766; x=1757423566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Cx2Ph72ijoyfFcoxY0iqeqWvvGQ7MDZ9eIBhS9a81eQ=;
 b=VNZCyNy8aSEcRKK8XMIQUjcok4Q/5tCmYzHAg5VldGn7ztT7PKo6bLRH3Al8nbTAgm
 EhN0LmeiXeWnanaQ87zubBUy1yqznEigfwlcL0XAo6duCmDbdetro/hT/2cocjDjspSQ
 gKnwf/STwcjfVRDcIBXUXp/SWRYQoEbhukRHydyellkHnNYL/aDt1AdBAuAodaeqECLU
 lso4sy5SrWYhjEWa0Cf0yl5K5y+HEPEpoiR6o5XYx24tt8JuOsIxeiPLeRD0BGF1ZHn5
 sD51nwuTwbZ17JiDH1tfcsU4w8+W5B+/vu6cQPfO2whRe7FA0aOQkaeXUK2McMPuB/oM
 IRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818766; x=1757423566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cx2Ph72ijoyfFcoxY0iqeqWvvGQ7MDZ9eIBhS9a81eQ=;
 b=oiq/bm9MchJL8BxiZTIztCOV35bFxQgc62D3J+ziRBSKc8hj9IX7S7nRAOtJLtTRu1
 xlFru+y+i/1xGgDZI0tatUAYqn8nb6q7ZcKLqHW0J0ogR+t+YdDVm2uGpGYzxl41gsaY
 gX/r1fUol7JFONMCe+9SfNMhngp/7sxz/6vMYDUPz59zP6uRfG+PcjclVwWdiGEYRXNz
 Y9Syf0JLkfeYG4JKqxLH7trQ0H1oL1w3rROd3Tflwr6zt/OiTvWxcsaiI1TKqQP6MGxJ
 VIwldf7mSSR4n5yK7NO3j9xpYvi3DNTpQusGqZdmt2IXMElkyGJwWVOX8Yn6Qlc1CT7C
 XaXA==
X-Gm-Message-State: AOJu0Yxn+1H2JY+36SZ+Nm1c/7L4fik45/1s34lnLxAjzeOx216DOPwO
 9nhbMUQ02OcjwerIBAWP0dQjtnNeYhhCGGyh4ghCsWBEgBRedFL2nWTxYgRkHSia86m5rOHCsOF
 kESyB
X-Gm-Gg: ASbGncu6c3MazNfYsDt2auMGpG5Y7kg2Fm1guYsN2tiy5FrRQqWVpQNu/9fWC1X3xAh
 GIXIaiZDhylHl+XZy5MCrpM099pL//dGHf7r3m1eD8vsVxB4fwhLwUoIYm7h0QMFkpe9QydjPnp
 BWBXOqzV/KdZZW9nRRxmDuw9kXbcCHjusEIpmtx/i+BYYOLnp83WF7LtvonI1UAiFfmxCkMF8EY
 Mim0dqkZ39hSOrhm8kHYhk8USXG9+F4QJRfPv1lIqILHZzAflxi4Lmhww/vZHEzUvLTutGU+5nF
 vJMxjf4V5HmyF7c4TGBJ0zaXBUoTINDdwK5FT3KLh39on1B9iYXKBMzFPbTi4yVCntbYmGhDuVK
 aDs4rDB6yTFoK5kLs61Uy0ID7A7BJ3z3PgcMmlN6TsjH53g7g6nJ54+nJeRzd6vLwSdEmgfDL
X-Google-Smtp-Source: AGHT+IE2z8thm6jZHM1jkGiZEJ3FTu7Euh3vcRzAJyo7mVyC4xSI9to9YOIlTyqCaZolByE9OGsptg==
X-Received: by 2002:a05:6000:2384:b0:3ce:d43c:673f with SMTP id
 ffacd0b85a97d-3d1dc5a2399mr7850647f8f.4.1756818765935; 
 Tue, 02 Sep 2025 06:12:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d15f7b012csm16517587f8f.63.2025.09.02.06.12.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/39] crypto/hmac: Allow to build hmac over multiple
 qcrypto_gnutls_hmac_bytes[v] calls
Date: Tue,  2 Sep 2025 15:10:09 +0200
Message-ID: <20250902131016.84968-33-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jan Kiszka <jan.kiszka@siemens.com>

If the buffers that should be considered for building the hmac are not
available at the same time, the current API is unsuitable. Extend it so
that passing a NULL pointer as result_len is used as indicator that
further buffers will be passed in succeeding calls to
qcrypto_gnutls_hmac_bytes[v].

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <2d3539c247a6c323491a3821f0e5b6fc382a4686.1756706188.git.jan.kiszka@siemens.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/crypto/hmac.h | 12 ++++++++++++
 crypto/hmac-gcrypt.c  |  4 +++-
 crypto/hmac-glib.c    |  4 +++-
 crypto/hmac-gnutls.c  |  4 +++-
 crypto/hmac-nettle.c  |  4 +++-
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index da8a1e3ceb9..af3d5f8feb2 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -90,6 +90,12 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHmac, qcrypto_hmac_free)
  * The memory referenced in @result must be released with a call
  * to g_free() when no longer required by the caller.
  *
+ * If @result_len is set to a NULL pointer, no result will be returned, and
+ * the hmac object can be used for further invocations of qcrypto_hmac_bytes()
+ * or qcrypto_hmac_bytesv() until a non-NULL pointer is provided. This allows
+ * to build the hmac across memory regions that are not available at the same
+ * time.
+ *
  * Returns:
  *  0 on success, -1 on error
  */
@@ -123,6 +129,12 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
  * The memory referenced in @result must be released with a call
  * to g_free() when no longer required by the caller.
  *
+ * If @result_len is set to a NULL pointer, no result will be returned, and
+ * the hmac object can be used for further invocations of qcrypto_hmac_bytes()
+ * or qcrypto_hmac_bytesv() until a non-NULL pointer is provided. This allows
+ * to build the hmac across memory regions that are not available at the same
+ * time.
+ *
  * Returns:
  *  0 on success, -1 on error
  */
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 5273086eb9a..e428d174798 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -121,7 +121,9 @@ qcrypto_gcrypt_hmac_bytesv(QCryptoHmac *hmac,
         return -1;
     }
 
-    if (*resultlen == 0) {
+    if (resultlen == NULL) {
+        return 0;
+    } else if (*resultlen == 0) {
         *resultlen = ret;
         *result = g_new0(uint8_t, *resultlen);
     } else if (*resultlen != ret) {
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index ea80c8d1b23..b845133a058 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -104,7 +104,9 @@ qcrypto_glib_hmac_bytesv(QCryptoHmac *hmac,
         return -1;
     }
 
-    if (*resultlen == 0) {
+    if (resultlen == NULL) {
+        return 0;
+    } else if (*resultlen == 0) {
         *resultlen = ret;
         *result = g_new0(uint8_t, *resultlen);
     } else if (*resultlen != ret) {
diff --git a/crypto/hmac-gnutls.c b/crypto/hmac-gnutls.c
index 822995505cd..3c5bcbe80be 100644
--- a/crypto/hmac-gnutls.c
+++ b/crypto/hmac-gnutls.c
@@ -119,7 +119,9 @@ qcrypto_gnutls_hmac_bytesv(QCryptoHmac *hmac,
         return -1;
     }
 
-    if (*resultlen == 0) {
+    if (resultlen == NULL) {
+        return 0;
+    } else if (*resultlen == 0) {
         *resultlen = ret;
         *result = g_new0(uint8_t, *resultlen);
     } else if (*resultlen != ret) {
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index dd5b2ab7a19..2cff7931e12 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -164,7 +164,9 @@ qcrypto_nettle_hmac_bytesv(QCryptoHmac *hmac,
         }
     }
 
-    if (*resultlen == 0) {
+    if (resultlen == NULL) {
+        return 0;
+    } else if (*resultlen == 0) {
         *resultlen = qcrypto_hmac_alg_map[hmac->alg].len;
         *result = g_new0(uint8_t, *resultlen);
     } else if (*resultlen != qcrypto_hmac_alg_map[hmac->alg].len) {
-- 
2.51.0


