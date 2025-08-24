Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0520ECA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 07:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uq59u-0006Sc-0e; Sun, 24 Aug 2025 03:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202508240718430f8a9a1b4a50f90b60-rw1433@rts-flowmailer.siemens.com>)
 id 1uq59r-0006RX-QX
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 03:28:56 -0400
Received: from mta-64-225.siemens.flowmailer.net ([185.136.64.225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <fm-294854-202508240718430f8a9a1b4a50f90b60-rw1433@rts-flowmailer.siemens.com>)
 id 1uq59k-0005Mm-Km
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 03:28:55 -0400
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 202508240718430f8a9a1b4a50f90b60 for <qemu-devel@nongnu.org>;
 Sun, 24 Aug 2025 09:18:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SIKQRmNfznvZEbxFQHjPE4pGJUEzLHeeKpiYiSJr/po=;
 b=D6r87iljbI0hUpLzqLUnJrX4lpBpobqoGrdvhfKMRSFqvg3ky1kHXlZBeaLpEf/svJWoq2
 gxR+sY+6FuqWaquv5tE2TaAtVk8iOdjgOeQ639MSOrrFHbnYbXHMN9Az+0MuVmzODF9GD7hS
 6YifHSkEbVo3Km6x+2XEq8szbpUL+j+bl5ZiOfpBw+Ljmn8+AsZ9ZP8W8zUAqvSsOIumth4G
 QxQvHKmeBmMgWJNMvL/OPTaR4wRySFL5L7DEb8fx8ihI1zB5dUXSQYNZ4G6nS5AS+VhFUUSG
 e7C1wUCquzIm2VRLc2tVxLRy1/N8RH5W43HDoNAUcPglzM3tILVvGNUA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/8] crypto/hmac: Allow to build hmac over multiple
 qcrypto_gnutls_hmac_bytes[v] calls
Date: Sun, 24 Aug 2025 09:18:38 +0200
Message-ID: <b9eadde84d8189635362e4e73a4941259be91a8f.1756019920.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1756019920.git.jan.kiszka@siemens.com>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
Received-SPF: pass client-ip=185.136.64.225;
 envelope-from=fm-294854-202508240718430f8a9a1b4a50f90b60-rw1433@rts-flowmailer.siemens.com;
 helo=mta-64-225.siemens.flowmailer.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
---
 crypto/hmac-gcrypt.c  |  4 +++-
 crypto/hmac-glib.c    |  4 +++-
 crypto/hmac-gnutls.c  |  4 +++-
 crypto/hmac-nettle.c  |  4 +++-
 include/crypto/hmac.h | 12 ++++++++++++
 5 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 5273086eb9..e428d17479 100644
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
index ea80c8d1b2..b845133a05 100644
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
index 822995505c..3c5bcbe80b 100644
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
index dd5b2ab7a1..2cff7931e1 100644
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
diff --git a/include/crypto/hmac.h b/include/crypto/hmac.h
index da8a1e3ceb..af3d5f8feb 100644
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
-- 
2.43.0


