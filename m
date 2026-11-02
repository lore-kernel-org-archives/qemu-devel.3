Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC6606AA0A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SePryHVu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr51-00066k-Fm; Mon, 02 Nov 2026 07:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr4y-00066M-9E
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr4v-0001PQ-9K
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INvTgZSdQ7+HVJvkjanBtO4MoKUVwdhTiernyxLhUSE=;
 b=SePryHVuMknbSlpt54GInoKSPxtncWxd824PlVxlVA6mxMOOC2NxiedBbEdrkO6y+Leu5s
 49Va1TKd8Z9zUaMejFsGSrMM9zFN5Qh7Chb8TGH2f0AmBFCdM+GZfl5z6AqeJRT5LmmtSN
 rOjp9XYU0SHegYGXHVPrqb0Mwfdf8DE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-xP_KByenPB6dASTULsbe6Q-1; Mon,
 02 Nov 2026 07:23:52 -0500
X-MC-Unique: xP_KByenPB6dASTULsbe6Q-1
X-Mimecast-MFC-AGG-ID: xP_KByenPB6dASTULsbe6Q_1793622231
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 043581802578; Mon,  2 Nov 2026 12:23:51 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E56671800480; Mon,  2 Nov 2026 12:23:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/4] tests/unit: register one test per hash/hmac algorithm
Date: Mon,  2 Nov 2026 12:23:43 +0000
Message-ID: <20261102122343.3348956-5-berrange@redhat.com>
In-Reply-To: <20261102122343.3348956-1-berrange@redhat.com>
References: <20261102122343.3348956-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The hash/hmac tests iterate over all support algorithms testing
each one in turn, but this is not visible from the test output.
Register one test per algorithm so the test result directly
reflect what algorithms were tested. This is useful information
since different crypto backends support different subsets of
algorithms.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-hash.c | 315 ++++++++++++++++------------------
 tests/unit/test-crypto-hmac.c | 268 ++++++++++++++---------------
 2 files changed, 271 insertions(+), 312 deletions(-)

diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index 1813e77b5a5..fbdae46fd64 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -92,218 +92,191 @@ static const int expected_lens[] = {
 static const char hex[] = "0123456789abcdef";
 
 /* Test with dynamic allocation */
-static void test_hash_alloc(void)
+static void test_hash_alloc(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        uint8_t *result = NULL;
-        size_t resultlen = 0;
-        int ret;
-        size_t j;
-
-        if (!qcrypto_hash_supports(i)) {
-            continue;
-        }
-
-        ret = qcrypto_hash_bytes(i,
-                                 INPUT_TEXT,
-                                 strlen(INPUT_TEXT),
-                                 &result,
-                                 &resultlen,
-                                 &error_fatal);
-        g_assert(ret == 0);
-        g_assert(resultlen == expected_lens[i]);
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+    int ret;
+    size_t j;
+
+    ret = qcrypto_hash_bytes(alg,
+                             INPUT_TEXT,
+                             strlen(INPUT_TEXT),
+                             &result,
+                             &resultlen,
+                             &error_fatal);
+    g_assert(ret == 0);
+    g_assert(resultlen == expected_lens[alg]);
 
-        for (j = 0; j < resultlen; j++) {
-            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
-        }
-        g_free(result);
+    for (j = 0; j < resultlen; j++) {
+        g_assert(expected_outputs[alg][j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(expected_outputs[alg][j * 2 + 1] == hex[result[j] & 0xf]);
     }
+    g_free(result);
 }
 
 /* Test with caller preallocating */
-static void test_hash_prealloc(void)
+static void test_hash_prealloc(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        uint8_t *result, *origresult;
-        size_t resultlen;
-        int ret;
-        size_t j;
-
-        if (!qcrypto_hash_supports(i)) {
-            continue;
-        }
-
-        resultlen = expected_lens[i];
-        origresult = result = g_new0(uint8_t, resultlen);
-
-        ret = qcrypto_hash_bytes(i,
-                                 INPUT_TEXT,
-                                 strlen(INPUT_TEXT),
-                                 &result,
-                                 &resultlen,
-                                 &error_fatal);
-        g_assert(ret == 0);
-        /* Validate that our pre-allocated pointer was not replaced */
-        g_assert(result == origresult);
-        g_assert(resultlen == expected_lens[i]);
-        for (j = 0; j < resultlen; j++) {
-            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
-        }
-        g_free(result);
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    uint8_t *result, *origresult;
+    size_t resultlen;
+    int ret;
+    size_t j;
+
+    resultlen = expected_lens[alg];
+    origresult = result = g_new0(uint8_t, resultlen);
+
+    ret = qcrypto_hash_bytes(alg,
+                             INPUT_TEXT,
+                             strlen(INPUT_TEXT),
+                             &result,
+                             &resultlen,
+                             &error_fatal);
+    g_assert(ret == 0);
+    /* Validate that our pre-allocated pointer was not replaced */
+    g_assert(result == origresult);
+    g_assert(resultlen == expected_lens[alg]);
+    for (j = 0; j < resultlen; j++) {
+        g_assert(expected_outputs[alg][j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(expected_outputs[alg][j * 2 + 1] == hex[result[j] & 0xf]);
     }
+    g_free(result);
 }
 
 
 /* Test with dynamic allocation */
-static void test_hash_iov(void)
+static void test_hash_iov(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        struct iovec iov[3] = {
-            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
-            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
-            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
-        };
-        uint8_t *result = NULL;
-        size_t resultlen = 0;
-        int ret;
-        size_t j;
-
-        if (!qcrypto_hash_supports(i)) {
-            continue;
-        }
-
-        ret = qcrypto_hash_bytesv(i,
-                                  iov, 3,
-                                  &result,
-                                  &resultlen,
-                                  &error_fatal);
-        g_assert(ret == 0);
-        g_assert(resultlen == expected_lens[i]);
-        for (j = 0; j < resultlen; j++) {
-            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
-        }
-        g_free(result);
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    struct iovec iov[3] = {
+        { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
+        { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
+        { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
+    };
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+    int ret;
+    size_t j;
+
+    ret = qcrypto_hash_bytesv(alg,
+                              iov, 3,
+                              &result,
+                              &resultlen,
+                              &error_fatal);
+    g_assert(ret == 0);
+    g_assert(resultlen == expected_lens[alg]);
+    for (j = 0; j < resultlen; j++) {
+        g_assert(expected_outputs[alg][j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(expected_outputs[alg][j * 2 + 1] == hex[result[j] & 0xf]);
     }
+    g_free(result);
 }
 
 
 /* Test with printable hashing */
-static void test_hash_digest(void)
+static void test_hash_digest(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        int ret;
-        char *digest;
-        size_t digestsize;
-
-        if (!qcrypto_hash_supports(i)) {
-            continue;
-        }
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    int ret;
+    char *digest;
+    size_t digestsize;
 
-        digestsize = qcrypto_hash_digest_len(i);
+    digestsize = qcrypto_hash_digest_len(alg);
 
-        g_assert_cmpint(digestsize * 2, ==, strlen(expected_outputs[i]));
+    g_assert_cmpint(digestsize * 2, ==, strlen(expected_outputs[alg]));
 
-        ret = qcrypto_hash_digest(i,
-                                  INPUT_TEXT,
-                                  strlen(INPUT_TEXT),
-                                  &digest,
-                                  &error_fatal);
-        g_assert(ret == 0);
-        g_assert_cmpstr(digest, ==, expected_outputs[i]);
-        g_free(digest);
-    }
+    ret = qcrypto_hash_digest(alg,
+                              INPUT_TEXT,
+                              strlen(INPUT_TEXT),
+                              &digest,
+                              &error_fatal);
+    g_assert(ret == 0);
+    g_assert_cmpstr(digest, ==, expected_outputs[alg]);
+    g_free(digest);
 }
 
 /* Test with base64 encoding */
-static void test_hash_base64(void)
+static void test_hash_base64(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        int ret;
-        char *digest;
-
-        if (!qcrypto_hash_supports(i)) {
-            continue;
-        }
-
-        ret = qcrypto_hash_base64(i,
-                                  INPUT_TEXT,
-                                  strlen(INPUT_TEXT),
-                                  &digest,
-                                  &error_fatal);
-        g_assert(ret == 0);
-        g_assert_cmpstr(digest, ==, expected_outputs_b64[i]);
-        g_free(digest);
-    }
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    int ret;
+    char *digest;
+
+    ret = qcrypto_hash_base64(alg,
+                              INPUT_TEXT,
+                              strlen(INPUT_TEXT),
+                              &digest,
+                              &error_fatal);
+    g_assert(ret == 0);
+    g_assert_cmpstr(digest, ==, expected_outputs_b64[alg]);
+    g_free(digest);
 }
 
-static void test_hash_accumulate(void)
+static void test_hash_accumulate(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(expected_outputs) ; i++) {
-        g_autoptr(QCryptoHash) hash = NULL;
-        struct iovec iov[] = {
-            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
-            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
-            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
-        };
-        g_autofree uint8_t *result = NULL;
-        size_t resultlen = 0;
-        int ret;
-        size_t j;
-
-        if (!qcrypto_hash_supports(i)) {
-            continue;
-        }
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    g_autoptr(QCryptoHash) hash = NULL;
+    struct iovec iov[] = {
+        { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
+        { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
+        { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
+    };
+    g_autofree uint8_t *result = NULL;
+    size_t resultlen = 0;
+    int ret;
+    size_t j;
+
+    hash = qcrypto_hash_new(alg, &error_fatal);
+    g_assert(hash != NULL);
+
+    /* Add each iovec to the hash context separately */
+    for (j = 0; j < G_N_ELEMENTS(iov); j++) {
+        ret = qcrypto_hash_updatev(hash,
+                                   &iov[j], 1,
+                                   &error_fatal);
 
-        hash = qcrypto_hash_new(i, &error_fatal);
-        g_assert(hash != NULL);
+        g_assert(ret == 0);
+    }
 
-        /* Add each iovec to the hash context separately */
-        for (j = 0; j < G_N_ELEMENTS(iov); j++) {
-            ret = qcrypto_hash_updatev(hash,
-                                      &iov[j], 1,
+    ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen,
                                       &error_fatal);
 
-            g_assert(ret == 0);
-        }
-
-        ret = qcrypto_hash_finalize_bytes(hash, &result, &resultlen,
-                                          &error_fatal);
-
-        g_assert(ret == 0);
-        g_assert(resultlen == expected_lens[i]);
-        for (j = 0; j < resultlen; j++) {
-            g_assert(expected_outputs[i][j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(expected_outputs[i][j * 2 + 1] == hex[result[j] & 0xf]);
-        }
+    g_assert(ret == 0);
+    g_assert(resultlen == expected_lens[alg]);
+    for (j = 0; j < resultlen; j++) {
+        g_assert(expected_outputs[alg][j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(expected_outputs[alg][j * 2 + 1] == hex[result[j] & 0xf]);
     }
 }
 
 int main(int argc, char **argv)
 {
+    size_t i;
     int ret = qcrypto_init(&error_fatal);
     g_assert(ret == 0);
 
     g_test_init(&argc, &argv, NULL);
-    g_test_add_func("/crypto/hash/iov", test_hash_iov);
-    g_test_add_func("/crypto/hash/alloc", test_hash_alloc);
-    g_test_add_func("/crypto/hash/prealloc", test_hash_prealloc);
-    g_test_add_func("/crypto/hash/digest", test_hash_digest);
-    g_test_add_func("/crypto/hash/base64", test_hash_base64);
-    g_test_add_func("/crypto/hash/accumulate", test_hash_accumulate);
+
+#define ADD_TEST(alg, prefix, meth) \
+    { \
+        g_autofree char *name = g_strdup_printf( \
+            "%s/%s", prefix, QCryptoHashAlgo_str(alg)); \
+        g_test_add_data_func(name, GINT_TO_POINTER(alg), meth); \
+    }
+
+    for (i = 0; i < QCRYPTO_HASH_ALGO__MAX ; i++) {
+        if (!qcrypto_hash_supports(i)) {
+            continue;
+        }
+
+        ADD_TEST(i, "/crypto/hash/iov", test_hash_iov);
+        ADD_TEST(i, "/crypto/hash/alloc", test_hash_alloc);
+        ADD_TEST(i, "/crypto/hash/prealloc", test_hash_prealloc);
+        ADD_TEST(i, "/crypto/hash/digest", test_hash_digest);
+        ADD_TEST(i, "/crypto/hash/base64", test_hash_base64);
+        ADD_TEST(i, "/crypto/hash/accumulate", test_hash_accumulate);
+    }
     return g_test_run();
 }
diff --git a/tests/unit/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c
index f7158621908..9c2ee8c17f8 100644
--- a/tests/unit/test-crypto-hmac.c
+++ b/tests/unit/test-crypto-hmac.c
@@ -86,177 +86,163 @@ static QCryptoHmacTestData test_data[] = {
 
 static const char hex[] = "0123456789abcdef";
 
-static void test_hmac_alloc(void)
+static void test_hmac_alloc(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        QCryptoHmacTestData *data = &test_data[i];
-        QCryptoHmac *hmac = NULL;
-        uint8_t *result = NULL;
-        size_t resultlen = 0;
-        const char *exp_output = NULL;
-        int ret;
-        size_t j;
-
-        if (!qcrypto_hmac_supports(data->alg)) {
-            return;
-        }
-
-        exp_output = data->hex_digest;
-
-        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
-                                strlen(KEY), &error_fatal);
-        g_assert(hmac != NULL);
-
-        ret = qcrypto_hmac_bytes(hmac, (const char *)INPUT_TEXT,
-                                 strlen(INPUT_TEXT), &result,
-                                 &resultlen, &error_fatal);
-        g_assert(ret == 0);
-
-        for (j = 0; j < resultlen; j++) {
-            g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
-        }
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    QCryptoHmacTestData *data = &test_data[alg];
+    QCryptoHmac *hmac = NULL;
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+    const char *exp_output = NULL;
+    int ret;
+    size_t j;
+
+    exp_output = data->hex_digest;
+
+    hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                            strlen(KEY), &error_fatal);
+    g_assert(hmac != NULL);
+
+    ret = qcrypto_hmac_bytes(hmac, (const char *)INPUT_TEXT,
+                             strlen(INPUT_TEXT), &result,
+                             &resultlen, &error_fatal);
+    g_assert(ret == 0);
+
+    for (j = 0; j < resultlen; j++) {
+        g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
+    }
 
-        qcrypto_hmac_free(hmac);
+    qcrypto_hmac_free(hmac);
 
-        g_free(result);
-    }
+    g_free(result);
 }
 
-static void test_hmac_prealloc(void)
+static void test_hmac_prealloc(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        QCryptoHmacTestData *data = &test_data[i];
-        QCryptoHmac *hmac = NULL;
-        uint8_t *result = NULL, *origresult = NULL;
-        size_t resultlen = 0;
-        const char *exp_output = NULL;
-        int ret;
-        size_t j;
-
-        if (!qcrypto_hmac_supports(data->alg)) {
-            return;
-        }
-
-        exp_output = data->hex_digest;
-
-        resultlen = strlen(exp_output) / 2;
-        origresult = result = g_new0(uint8_t, resultlen);
-
-        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
-                                strlen(KEY), &error_fatal);
-        g_assert(hmac != NULL);
-
-        ret = qcrypto_hmac_bytes(hmac, (const char *)INPUT_TEXT,
-                                 strlen(INPUT_TEXT), &result,
-                                 &resultlen, &error_fatal);
-        g_assert(ret == 0);
-        /* Validate that our pre-allocated pointer was not replaced */
-        g_assert(result == origresult);
-
-        exp_output = data->hex_digest;
-        for (j = 0; j < resultlen; j++) {
-            g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
-        }
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    QCryptoHmacTestData *data = &test_data[alg];
+    QCryptoHmac *hmac = NULL;
+    uint8_t *result = NULL, *origresult = NULL;
+    size_t resultlen = 0;
+    const char *exp_output = NULL;
+    int ret;
+    size_t j;
+
+    exp_output = data->hex_digest;
+
+    resultlen = strlen(exp_output) / 2;
+    origresult = result = g_new0(uint8_t, resultlen);
+
+    hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                            strlen(KEY), &error_fatal);
+    g_assert(hmac != NULL);
+
+    ret = qcrypto_hmac_bytes(hmac, (const char *)INPUT_TEXT,
+                             strlen(INPUT_TEXT), &result,
+                             &resultlen, &error_fatal);
+    g_assert(ret == 0);
+    /* Validate that our pre-allocated pointer was not replaced */
+    g_assert(result == origresult);
+
+    exp_output = data->hex_digest;
+    for (j = 0; j < resultlen; j++) {
+        g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
+    }
 
-        qcrypto_hmac_free(hmac);
+    qcrypto_hmac_free(hmac);
 
-        g_free(result);
-    }
+    g_free(result);
 }
 
-static void test_hmac_iov(void)
+static void test_hmac_iov(const void *opaque)
 {
-    size_t i;
-
-    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        QCryptoHmacTestData *data = &test_data[i];
-        QCryptoHmac *hmac = NULL;
-        uint8_t *result = NULL;
-        size_t resultlen = 0;
-        const char *exp_output = NULL;
-        int ret;
-        size_t j;
-        struct iovec iov[3] = {
-            { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
-            { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
-            { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
-        };
-
-        if (!qcrypto_hmac_supports(data->alg)) {
-            return;
-        }
-
-        exp_output = data->hex_digest;
-
-        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
-                                strlen(KEY), &error_fatal);
-        g_assert(hmac != NULL);
-
-        ret = qcrypto_hmac_bytesv(hmac, iov, 3, &result,
-                                  &resultlen, &error_fatal);
-        g_assert(ret == 0);
-
-        for (j = 0; j < resultlen; j++) {
-            g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
-            g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
-        }
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    QCryptoHmacTestData *data = &test_data[alg];
+    QCryptoHmac *hmac = NULL;
+    uint8_t *result = NULL;
+    size_t resultlen = 0;
+    const char *exp_output = NULL;
+    int ret;
+    size_t j;
+    struct iovec iov[3] = {
+        { .iov_base = (char *)INPUT_TEXT1, .iov_len = strlen(INPUT_TEXT1) },
+        { .iov_base = (char *)INPUT_TEXT2, .iov_len = strlen(INPUT_TEXT2) },
+        { .iov_base = (char *)INPUT_TEXT3, .iov_len = strlen(INPUT_TEXT3) },
+    };
+
+    exp_output = data->hex_digest;
+
+    hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                            strlen(KEY), &error_fatal);
+    g_assert(hmac != NULL);
+
+    ret = qcrypto_hmac_bytesv(hmac, iov, 3, &result,
+                              &resultlen, &error_fatal);
+    g_assert(ret == 0);
+
+    for (j = 0; j < resultlen; j++) {
+        g_assert(exp_output[j * 2] == hex[(result[j] >> 4) & 0xf]);
+        g_assert(exp_output[j * 2 + 1] == hex[result[j] & 0xf]);
+    }
 
-        qcrypto_hmac_free(hmac);
+    qcrypto_hmac_free(hmac);
 
-        g_free(result);
-    }
+    g_free(result);
 }
 
-static void test_hmac_digest(void)
+static void test_hmac_digest(const void *opaque)
 {
-    size_t i;
+    QCryptoHashAlgo alg = GPOINTER_TO_INT(opaque);
+    QCryptoHmacTestData *data = &test_data[alg];
+    QCryptoHmac *hmac = NULL;
+    uint8_t *result = NULL;
+    const char *exp_output = NULL;
+    int ret;
 
-    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        QCryptoHmacTestData *data = &test_data[i];
-        QCryptoHmac *hmac = NULL;
-        uint8_t *result = NULL;
-        const char *exp_output = NULL;
-        int ret;
+    exp_output = data->hex_digest;
 
-        if (!qcrypto_hmac_supports(data->alg)) {
-            return;
-        }
-
-        exp_output = data->hex_digest;
-
-        hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
-                                strlen(KEY), &error_fatal);
-        g_assert(hmac != NULL);
+    hmac = qcrypto_hmac_new(data->alg, (const uint8_t *)KEY,
+                            strlen(KEY), &error_fatal);
+    g_assert(hmac != NULL);
 
-        ret = qcrypto_hmac_digest(hmac, (const char *)INPUT_TEXT,
-                                  strlen(INPUT_TEXT), (char **)&result,
-                                  &error_fatal);
-        g_assert(ret == 0);
+    ret = qcrypto_hmac_digest(hmac, (const char *)INPUT_TEXT,
+                              strlen(INPUT_TEXT), (char **)&result,
+                              &error_fatal);
+    g_assert(ret == 0);
 
-        g_assert_cmpstr((const char *)result, ==, exp_output);
+    g_assert_cmpstr((const char *)result, ==, exp_output);
 
-        qcrypto_hmac_free(hmac);
+    qcrypto_hmac_free(hmac);
 
-        g_free(result);
-    }
+    g_free(result);
 }
 
 int main(int argc, char **argv)
 {
+    size_t i;
     g_test_init(&argc, &argv, NULL);
 
     g_assert(qcrypto_init(NULL) == 0);
 
-    g_test_add_func("/crypto/hmac/iov", test_hmac_iov);
-    g_test_add_func("/crypto/hmac/alloc", test_hmac_alloc);
-    g_test_add_func("/crypto/hmac/prealloc", test_hmac_prealloc);
-    g_test_add_func("/crypto/hmac/digest", test_hmac_digest);
+#define ADD_TEST(alg, prefix, meth) \
+    { \
+        g_autofree char *name = g_strdup_printf( \
+            "%s/%s", prefix, QCryptoHashAlgo_str(alg)); \
+        g_test_add_data_func(name, GINT_TO_POINTER(alg), meth); \
+    }
+
+    for (i = 0; i < QCRYPTO_HASH_ALGO__MAX ; i++) {
+        if (!qcrypto_hmac_supports(i)) {
+            continue;
+        }
+
+        ADD_TEST(i, "/crypto/hmac/iov", test_hmac_iov);
+        ADD_TEST(i, "/crypto/hmac/alloc", test_hmac_alloc);
+        ADD_TEST(i, "/crypto/hmac/prealloc", test_hmac_prealloc);
+        ADD_TEST(i, "/crypto/hmac/digest", test_hmac_digest);
+    }
 
     return g_test_run();
 }
-- 
2.56.0


