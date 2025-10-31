Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB46CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEl8h-0003S6-2N; Fri, 31 Oct 2025 05:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEl8e-0003RZ-RI
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:09:41 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEl8b-0008CE-Ak
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:09:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4770c34ca8eso17666665e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761901773; x=1762506573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4MHmy3wxWhV8hOlGBOvn/gt7F0v/XH1uGfGmkzDzWxs=;
 b=vtg0K95c+NbrO3j2ZM/8TOVA4dMPwqxNf87hrQK1DWgk179rYC9s2nIambu7XifmV+
 1xml2MGpDGf660vQnMpUKmDYbhOZGiKraHsgobnL/ppPtwhOmbQboWoahxBvYeE5DW6H
 PSULV1xPf2YGDlpeJxCkhVfl+fE9OuiqFVAp+OmsSAhF/91BXgCDoGjVFjVJyS+vVUGP
 sXAGTAYmKlOXoFA7FYh5KImuSef8hBj1pdaN10igYH+Lh0jbYWm4LLIGNXlLARfR1wBZ
 8AHVTCLGA7JZ7rdqV6OD/bDxiX2k/yIPhQD95O7GFBnY9qN2s7LwPN89+7g9hjr7+r4H
 Qnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761901773; x=1762506573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4MHmy3wxWhV8hOlGBOvn/gt7F0v/XH1uGfGmkzDzWxs=;
 b=MBRymlom27zgsU3TW/2FBgAVV1Xt+GBkMydePrmMH766cnzy+FhEGsd00aa3x3YC0a
 pGZT1erML29i3ZNBZWrqbezLlGS4pEnQ7MishenRlPdytehLM3Y0cqid8epyzs8tUeA5
 vnUQqGro1ncQ7vWc4yEpcNP/n/iqsBqCbS2IDWLXfvNGVfmcIgqyupxOZ7tsrNZelIs3
 yDGY+unMSPQVwqH1zqMavZkzulKgHUqsM/bmwii/FXJDQByXdkh/R7JP1RE7RizNEyCB
 ONDLsSLAKhaMZqIBwhW27j1lAHFbf+d0oTUL5wLyUmBrOV05YkCgtgDVTxFDtotDtAJl
 m9dw==
X-Gm-Message-State: AOJu0Yy3lSjib+35tWGz9kzRuPm7Y+hl9NUQWs7t7pd55py5anfoveRJ
 3omRXmwJJu71vo9P8jEXNaNNnsEG0srVPdmMQSiWzeD9kXm/oaTYNf6zWuqhhO/twDS8sRKx5dP
 bN+x+DDi+p1F8
X-Gm-Gg: ASbGncvsLKl09JgVNqAsnFYMbFrSHBIA059tl4+t9FP8ESdovKfmp12YsHWZv1VPIgD
 YcY/Z6VWaEeZs81TJDzANlsokA+xXx2pQ1XyOieELdceTUfLAjuEVRRWDFO9fpauz5d6JSzByWj
 +NXWrFQSmzht1gOEO/7d/T6pcHAHhjeNTi8M2E0MPBf5Kv34cFgs8gfMymOKuT6ldVSLEuA6ESK
 ZTBkt8yyEnY3b3Hkb9IZ6FlUJ9um9tkcYRsYHVryNzc8nCmnrjg/TLUXsNFylfq7ZvJzJcddW5x
 OSYtHxqL234fvFgRcFHBc52klf3lCPR1A2P+iHhGvKGgXx5EpvVNVQW9eNG+76Tl1sj4RHX1aXX
 MDGNXwDCff+nMf189og05S3zkxKp6o4w/TQWuBY5RESoDXAOTD44JotQmxcRqJU8FizslKu3Mui
 NqDwR1uitl4icRjg8Y45lUswSpzFtVnhd4tDpVF3A5oR8951B/7Jiqik0OQp4=
X-Google-Smtp-Source: AGHT+IEQpEWO6d0onfQ13+enrnHAWbwbEuCv0GfRK9j9n0OfWSUFL+1a6fSpsJmLFUwgZRjim9N7Ng==
X-Received: by 2002:a05:600c:840a:b0:471:131f:85b7 with SMTP id
 5b1f17b1804b1-477307e7004mr27957355e9.15.1761901773217; 
 Fri, 31 Oct 2025 02:09:33 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e16d8sm2461522f8f.31.2025.10.31.02.09.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 02:09:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] crypto/hash: Have hashing functions take void * buffer
 argument
Date: Fri, 31 Oct 2025 10:09:30 +0100
Message-ID: <20251031090930.27159-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Cryptographic hash function can operate on any area of memory,
regardless of the content their represent. Do not restrict to
array of char, use the void* type, which is also the type of
the underlying iovec::iov_base field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/crypto/hash.h |  8 ++++----
 include/crypto/hmac.h |  4 ++--
 crypto/hash.c         | 16 ++++++++--------
 crypto/hmac.c         |  8 ++++----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 1868d4a0f78..43525098c51 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -122,7 +122,7 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_bytes(QCryptoHashAlgo alg,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
@@ -180,7 +180,7 @@ int qcrypto_hash_updatev(QCryptoHash *hash,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_update(QCryptoHash *hash,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         Error **errp);
 
@@ -289,7 +289,7 @@ G_DEFINE_AUTOPTR_CLEANUP_FUNC(QCryptoHash, qcrypto_hash_free)
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_digest(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp);
@@ -335,7 +335,7 @@ int qcrypto_hash_base64v(QCryptoHashAlgo alg,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hash_base64(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **base64,
                         Error **errp);
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index af3d5f8feb2..0885ae22d1d 100644
--- a/include/crypto/hmac.h
+++ b/include/crypto/hmac.h
@@ -139,7 +139,7 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
  *  0 on success, -1 on error
  */
 int qcrypto_hmac_bytes(QCryptoHmac *hmac,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
@@ -187,7 +187,7 @@ int qcrypto_hmac_digestv(QCryptoHmac *hmac,
  * Returns: 0 on success, -1 on error
  */
 int qcrypto_hmac_digest(QCryptoHmac *hmac,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp);
diff --git a/crypto/hash.c b/crypto/hash.c
index 7513769e42d..6ffb88bf541 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -67,13 +67,13 @@ int qcrypto_hash_bytesv(QCryptoHashAlgo alg,
 
 
 int qcrypto_hash_bytes(QCryptoHashAlgo alg,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf,
+    struct iovec iov = { .iov_base = (void *)buf,
                          .iov_len = len };
     return qcrypto_hash_bytesv(alg, &iov, 1, result, resultlen, errp);
 }
@@ -89,11 +89,11 @@ int qcrypto_hash_updatev(QCryptoHash *hash,
 }
 
 int qcrypto_hash_update(QCryptoHash *hash,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+    struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
 
     return qcrypto_hash_updatev(hash, &iov, 1, errp);
 }
@@ -206,12 +206,12 @@ int qcrypto_hash_digestv(QCryptoHashAlgo alg,
 }
 
 int qcrypto_hash_digest(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+    struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
 
     return qcrypto_hash_digestv(alg, &iov, 1, digest, errp);
 }
@@ -237,12 +237,12 @@ int qcrypto_hash_base64v(QCryptoHashAlgo alg,
 }
 
 int qcrypto_hash_base64(QCryptoHashAlgo alg,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **base64,
                         Error **errp)
 {
-    struct iovec iov = { .iov_base = (char *)buf, .iov_len = len };
+    struct iovec iov = { .iov_base = (void *)buf, .iov_len = len };
 
     return qcrypto_hash_base64v(alg, &iov, 1, base64, errp);
 }
diff --git a/crypto/hmac.c b/crypto/hmac.c
index 422e005182a..2f0d044cf27 100644
--- a/crypto/hmac.c
+++ b/crypto/hmac.c
@@ -28,14 +28,14 @@ int qcrypto_hmac_bytesv(QCryptoHmac *hmac,
 }
 
 int qcrypto_hmac_bytes(QCryptoHmac *hmac,
-                       const char *buf,
+                       const void *buf,
                        size_t len,
                        uint8_t **result,
                        size_t *resultlen,
                        Error **errp)
 {
     struct iovec iov = {
-            .iov_base = (char *)buf,
+            .iov_base = (void *)buf,
             .iov_len = len
     };
 
@@ -70,13 +70,13 @@ int qcrypto_hmac_digestv(QCryptoHmac *hmac,
 }
 
 int qcrypto_hmac_digest(QCryptoHmac *hmac,
-                        const char *buf,
+                        const void *buf,
                         size_t len,
                         char **digest,
                         Error **errp)
 {
     struct iovec iov = {
-            .iov_base = (char *)buf,
+            .iov_base = (void *)buf,
             .iov_len = len
     };
 
-- 
2.51.0


