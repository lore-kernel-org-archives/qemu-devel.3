Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC7C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPN-0005vJ-G2; Tue, 11 Aug 2026 12:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOm-0005NH-Ku
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOh-00010U-Sq
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbx61egu4QZOerHJIdYU42yPYYnsbqBrXjCXSw+bulQ=;
 b=RpshmAiT3INhLYHR4BXmZ72sZL4Aq6Z46eXP4RO4gjzVqK0HNkqcfbZbVINR2z+OoJ85MF
 g9Bc2aoiGlj3KrQy9m4thiCecFey/jPzrbzQEDsMIWbZW/Jis9klAh0mjW43H+85M43hVF
 IxctI3Jdu2tJJs6uj8ROFdUWJCIApSA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-INtzkG3XN_qvM3unBneD9A-1; Tue,
 11 Aug 2026 12:32:11 -0400
X-MC-Unique: INtzkG3XN_qvM3unBneD9A-1
X-Mimecast-MFC-AGG-ID: INtzkG3XN_qvM3unBneD9A_1786465930
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703AF19560A2; Tue, 11 Aug 2026 16:32:10 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB9E6195DF91; Tue, 11 Aug 2026 16:32:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 69/83] tests/qtest/aspeed-hace: Test the crypto command on the
 AST2500
Date: Tue, 11 Aug 2026 18:29:24 +0200
Message-ID: <20260811162938.1403216-70-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a crypto known-answer test harness and exercise the AST2500, which
uses the crypto engine's direct access mode. Each mode (AES/DES/3DES in
ECB and CBC) is a separate test that checks the ciphertext, the
plaintext round-trip and, for CBC, the chaining IV written back to the
context buffer.

The key/IV/plaintext/ciphertext values are taken verbatim from the Linux
kernel crypto self-test templates in crypto/testmgr.h.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-hace-utils.h |  16 ++
 tests/qtest/aspeed-hace-utils.c | 325 ++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_hace-test.c  |   6 +
 tests/qtest/meson.build         |   6 +-
 4 files changed, 351 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index 27ab2bb97585..13feaa61e446 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -79,5 +79,21 @@ void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
 void aspeed_test_addresses(const char *machine, const uint32_t base,
                            const struct AspeedMasks *expected);
 
+/*
+ * Cipher modes a SoC's crypto engine supports, for aspeed_add_crypto_tests().
+ */
+enum {
+    CRYPT_MODE_ECB = 1 << 0,
+    CRYPT_MODE_CBC = 1 << 1,
+};
+
+/*
+ * Register the crypto known-answer tests that @modes selects (a mask of
+ * CRYPT_MODE_*) for the given machine. Each test is named
+ * "<prefix>/hace/crypto/<mode>".
+ */
+void aspeed_add_crypto_tests(const char *prefix, const char *machine,
+                             uint32_t base, uint64_t dram, uint32_t modes);
+
 #endif /* TESTS_ASPEED_HACE_UTILS_H */
 
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 25450a296bf4..0355dd47af15 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -9,6 +9,7 @@
 #include "libqtest.h"
 #include "qemu/bitops.h"
 #include "qemu/bswap.h"
+#include "crypto/cipher.h"
 #include "aspeed-hace-utils.h"
 
 /*
@@ -645,3 +646,327 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
     qtest_quit(s);
 }
 
+/*
+ * Crypto engine register layout (offsets from the HACE base).
+ */
+#define HACE_CRYPTO_SRC          0x00
+#define HACE_CRYPTO_DEST         0x04
+#define HACE_CRYPTO_CONTEXT      0x08
+#define HACE_CRYPTO_DATA_LEN     0x0c
+#define HACE_CRYPTO_CMD          0x10
+
+/* Crypto command bits */
+#define HACE_CMD_ENCRYPT         BIT(7)
+#define HACE_CMD_ISR_EN          BIT(12)
+#define HACE_CMD_DES_SELECT      BIT(16)
+#define HACE_CMD_TRIPLE_DES      BIT(17)
+#define HACE_CMD_SRC_SG_CTRL     BIT(18)
+#define HACE_CMD_DST_SG_CTRL     BIT(19)
+#define HACE_CMD_OP_MODE_MASK    (0x7 << 4)
+#define HACE_CMD_ECB             (0x0 << 4)
+#define HACE_CMD_CBC             (0x1 << 4)
+#define HACE_CMD_AES128          (0x0 << 2)
+
+/* Context buffer layout: IV (DES at +8), key at +0x10 */
+#define HACE_CTX_KEY_OFFSET      0x10
+#define HACE_CTX_SIZE            0x30
+
+/*
+ * Crypto known-answer test vectors, taken verbatim from the Linux kernel
+ * crypto self-test templates in crypto/testmgr.h:
+ *
+ *   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/crypto/testmgr.h?h=v6.18
+ *
+ * The originating template is noted above each block. CTR and the longer CBC
+ * vectors are truncated to a single block (still a valid known-answer test as
+ * the first block only depends on the IV).
+ */
+
+/* aes_tv_template[0] (FIPS-197) */
+static const uint8_t aes128_ecb_key[16] = {
+    0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+    0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f };
+static const uint8_t aes128_ecb_ptext[16] = {
+    0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+    0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
+static const uint8_t aes128_ecb_ctext[16] = {
+    0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30,
+    0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a };
+
+/* aes_cbc_tv_template[0] (RFC 3602) */
+static const uint8_t aes128_cbc_key[16] = {
+    0x06, 0xa9, 0x21, 0x40, 0x36, 0xb8, 0xa1, 0x5b,
+    0x51, 0x2e, 0x03, 0xd5, 0x34, 0x12, 0x00, 0x06 };
+static const uint8_t aes128_cbc_iv[16] = {
+    0x3d, 0xaf, 0xba, 0x42, 0x9d, 0x9e, 0xb4, 0x30,
+    0xb4, 0x22, 0xda, 0x80, 0x2c, 0x9f, 0xac, 0x41 };
+static const uint8_t aes128_cbc_ptext[16] = {
+    0x53, 0x69, 0x6e, 0x67, 0x6c, 0x65, 0x20, 0x62,
+    0x6c, 0x6f, 0x63, 0x6b, 0x20, 0x6d, 0x73, 0x67 };
+static const uint8_t aes128_cbc_ctext[16] = {
+    0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,
+    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a };
+static const uint8_t aes128_cbc_ivout[16] = {
+    0xe3, 0x53, 0x77, 0x9c, 0x10, 0x79, 0xae, 0xb8,
+    0x27, 0x08, 0x94, 0x2d, 0xbe, 0x77, 0x18, 0x1a };
+
+/* des_tv_template[0] (Applied Cryptography) */
+static const uint8_t des_ecb_key[8] = {
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };
+static const uint8_t des_ecb_ptext[8] = {
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xe7 };
+static const uint8_t des_ecb_ctext[8] = {
+    0xc9, 0x57, 0x44, 0x25, 0x6a, 0x5e, 0xd3, 0x1d };
+
+/* des_cbc_tv_template[0] (OpenSSL), first block */
+static const uint8_t des_cbc_key[8] = {
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef };
+static const uint8_t des_cbc_iv[8] = {
+    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 };
+static const uint8_t des_cbc_ptext[8] = {
+    0x37, 0x36, 0x35, 0x34, 0x33, 0x32, 0x31, 0x20 };
+static const uint8_t des_cbc_ctext[8] = {
+    0xcc, 0xd1, 0x73, 0xff, 0xab, 0x20, 0x39, 0xf4 };
+
+/* des3_ede_tv_template[0] (OpenSSL) */
+static const uint8_t tdes_ecb_key[24] = {
+    0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef,
+    0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55, 0x55,
+    0xfe, 0xdc, 0xba, 0x98, 0x76, 0x54, 0x32, 0x10 };
+static const uint8_t tdes_ecb_ptext[8] = {
+    0x73, 0x6f, 0x6d, 0x65, 0x64, 0x61, 0x74, 0x61 };
+static const uint8_t tdes_ecb_ctext[8] = {
+    0x18, 0xd7, 0x48, 0xe5, 0x63, 0x62, 0x05, 0x72 };
+
+/* des3_ede_cbc_tv_template[0] (OpenSSL), first block */
+static const uint8_t tdes_cbc_key[24] = {
+    0xe9, 0xc0, 0xff, 0x2e, 0x76, 0x0b, 0x64, 0x24,
+    0x44, 0x4d, 0x99, 0x5a, 0x12, 0xd6, 0x40, 0xc0,
+    0xea, 0xc2, 0x84, 0xe8, 0x14, 0x95, 0xdb, 0xe8 };
+static const uint8_t tdes_cbc_iv[8] = {
+    0x7d, 0x33, 0x88, 0x93, 0x0f, 0x93, 0xb2, 0x42 };
+static const uint8_t tdes_cbc_ptext[8] = {
+    0x6f, 0x54, 0x20, 0x6f, 0x61, 0x4d, 0x79, 0x6e };
+static const uint8_t tdes_cbc_ctext[8] = {
+    0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };
+
+typedef struct CryptTest {
+    QCryptoCipherMode mode;
+    QCryptoCipherAlgo alg;
+    /* expected context IV after encrypt, or NULL */
+    const uint8_t *iv_out;
+    const uint8_t *ptext;
+    const uint8_t *ctext;
+    const uint8_t *key;
+    const uint8_t *iv;
+    const char *name;
+    size_t keylen;
+    /* algorithm | mode | key size selection */
+    uint32_t cmd;
+    size_t ivlen;
+    size_t len;
+} CryptTest;
+
+static const CryptTest crypt_tests[] = {
+    {
+        .name = "aes128-ecb",
+        .cmd = HACE_CMD_AES128 | HACE_CMD_ECB,
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .mode = QCRYPTO_CIPHER_MODE_ECB,
+        .key = aes128_ecb_key,
+        .keylen = sizeof(aes128_ecb_key),
+        .ptext = aes128_ecb_ptext,
+        .ctext = aes128_ecb_ctext,
+        .len = sizeof(aes128_ecb_ptext),
+    },
+    {
+        .name = "aes128-cbc",
+        .cmd = HACE_CMD_AES128 | HACE_CMD_CBC,
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .mode = QCRYPTO_CIPHER_MODE_CBC,
+        .key = aes128_cbc_key,
+        .keylen = sizeof(aes128_cbc_key),
+        .iv = aes128_cbc_iv,
+        .ivlen = sizeof(aes128_cbc_iv),
+        .ptext = aes128_cbc_ptext,
+        .ctext = aes128_cbc_ctext,
+        .iv_out = aes128_cbc_ivout,
+        .len = sizeof(aes128_cbc_ptext),
+    },
+    {
+        .name = "des-ecb",
+        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_ECB,
+        .alg = QCRYPTO_CIPHER_ALGO_DES,
+        .mode = QCRYPTO_CIPHER_MODE_ECB,
+        .key = des_ecb_key,
+        .keylen = sizeof(des_ecb_key),
+        .ptext = des_ecb_ptext,
+        .ctext = des_ecb_ctext,
+        .len = sizeof(des_ecb_ptext),
+    },
+    {
+        .name = "des-cbc",
+        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_CBC,
+        .alg = QCRYPTO_CIPHER_ALGO_DES,
+        .mode = QCRYPTO_CIPHER_MODE_CBC,
+        .key = des_cbc_key,
+        .keylen = sizeof(des_cbc_key),
+        .iv = des_cbc_iv,
+        .ivlen = sizeof(des_cbc_iv),
+        .ptext = des_cbc_ptext,
+        .ctext = des_cbc_ctext,
+        .len = sizeof(des_cbc_ptext),
+    },
+    {
+        .name = "des3_ede-ecb",
+        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_ECB,
+        .alg = QCRYPTO_CIPHER_ALGO_3DES,
+        .mode = QCRYPTO_CIPHER_MODE_ECB,
+        .key = tdes_ecb_key,
+        .keylen = sizeof(tdes_ecb_key),
+        .ptext = tdes_ecb_ptext,
+        .ctext = tdes_ecb_ctext,
+        .len = sizeof(tdes_ecb_ptext),
+    },
+    {
+        .name = "des3_ede-cbc",
+        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_CBC,
+        .alg = QCRYPTO_CIPHER_ALGO_3DES,
+        .mode = QCRYPTO_CIPHER_MODE_CBC,
+        .key = tdes_cbc_key,
+        .keylen = sizeof(tdes_cbc_key),
+        .iv = tdes_cbc_iv,
+        .ivlen = sizeof(tdes_cbc_iv),
+        .ptext = tdes_cbc_ptext,
+        .ctext = tdes_cbc_ctext,
+        .len = sizeof(tdes_cbc_ptext),
+    },
+};
+
+/* DRAM offsets for the crypto test source, destination and context buffers. */
+#define CRYPT_OFF_SRC   0x10000
+#define CRYPT_OFF_DST   0x20000
+#define CRYPT_OFF_CTX   0x30000
+
+/* Describes one registered crypto test (qtest_add_data_func() data pointer). */
+typedef struct AspeedCryptoTest {
+    const char *machine;
+    uint64_t dram;
+    uint32_t base;
+    int index;
+} AspeedCryptoTest;
+
+/* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_* flag. */
+static uint32_t crypt_mode_flag(uint32_t cmd)
+{
+    switch (cmd & HACE_CMD_OP_MODE_MASK) {
+    case HACE_CMD_ECB:
+        return CRYPT_MODE_ECB;
+    case HACE_CMD_CBC:
+        return CRYPT_MODE_CBC;
+    default:
+        return 0;
+    }
+}
+
+static void crypt_write_ctx(QTestState *s, uint64_t ctx_addr,
+                            const CryptTest *t)
+{
+    size_t iv_off = (t->cmd & HACE_CMD_DES_SELECT) ? 8 : 0;
+    uint8_t ctx[HACE_CTX_SIZE] = { 0 };
+
+    if (t->iv) {
+        memcpy(ctx + iv_off, t->iv, t->ivlen);
+    }
+    memcpy(ctx + HACE_CTX_KEY_OFFSET, t->key, t->keylen);
+    qtest_memwrite(s, ctx_addr, ctx, sizeof(ctx));
+}
+
+/* Run one crypto operation in direct access mode and read back the result. */
+static void crypt_run_direct(QTestState *s, uint32_t base, uint64_t dram,
+                             const CryptTest *t, bool encrypt, uint8_t *out)
+{
+    const uint8_t *in = encrypt ? t->ptext : t->ctext;
+    uint32_t cmd = t->cmd | HACE_CMD_ISR_EN;
+    uint64_t src = dram + CRYPT_OFF_SRC;
+    uint64_t dst = dram + CRYPT_OFF_DST;
+    uint64_t ctx = dram + CRYPT_OFF_CTX;
+
+    if (encrypt) {
+        cmd |= HACE_CMD_ENCRYPT;
+    }
+
+    crypt_write_ctx(s, ctx, t);
+    qtest_memwrite(s, src, in, t->len);
+
+    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src);
+    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst);
+    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);
+    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
+
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, ==,
+                    HACE_CRYPTO_ISR);
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
+
+    qtest_memread(s, dst, out, t->len);
+}
+
+static void aspeed_test_crypto_direct(const void *data)
+{
+    const AspeedCryptoTest *c = data;
+    const CryptTest *t = &crypt_tests[c->index];
+    QTestState *s = qtest_init(c->machine);
+    uint8_t out[64];
+    uint8_t iv[16];
+    size_t iv_off;
+
+    g_assert_cmpuint(t->len, <=, sizeof(out));
+
+    /* Encrypt: ptext -> ctext */
+    crypt_run_direct(s, c->base, c->dram, t, true, out);
+    g_assert_cmpmem(out, t->len, t->ctext, t->len);
+
+    if (t->iv_out) {
+        iv_off = (t->cmd & HACE_CMD_DES_SELECT) ? 8 : 0;
+        qtest_memread(s, c->dram + CRYPT_OFF_CTX + iv_off, iv, t->ivlen);
+        g_assert_cmpmem(iv, t->ivlen, t->iv_out, t->ivlen);
+    }
+
+    /* Decrypt: ctext -> ptext */
+    crypt_run_direct(s, c->base, c->dram, t, false, out);
+    g_assert_cmpmem(out, t->len, t->ptext, t->len);
+
+    qtest_quit(s);
+}
+
+void aspeed_add_crypto_tests(const char *prefix, const char *machine,
+                             uint32_t base, uint64_t dram, uint32_t modes)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(crypt_tests); i++) {
+        g_autofree char *path = NULL;
+        AspeedCryptoTest *t;
+
+        if (!(modes & crypt_mode_flag(crypt_tests[i].cmd))) {
+            continue;
+        }
+
+        if (!qcrypto_cipher_supports(crypt_tests[i].alg,
+                                     crypt_tests[i].mode)) {
+            g_printerr("# skip unsupported %s\n", crypt_tests[i].name);
+            continue;
+        }
+
+        path = g_strdup_printf("%s/hace/crypto/%s", prefix,
+                               crypt_tests[i].name);
+        t = g_new0(AspeedCryptoTest, 1);
+        t->machine = machine;
+        t->base = base;
+        t->dram = dram;
+        t->index = i;
+        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct, g_free);
+    }
+}
+
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.c
index 38777020ca34..4cb4c475e9d8 100644
--- a/tests/qtest/aspeed_hace-test.c
+++ b/tests/qtest/aspeed_hace-test.c
@@ -229,6 +229,12 @@ int main(int argc, char **argv)
     qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500);
     qtest_add_func("ast2500/hace/md5", test_md5_ast2500);
 
+    /*
+     * The AST2500 crypto engine uses direct access mode and supports ECB/CBC.
+     */
+    aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb", 0x1e6e3000,
+                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC);
+
     qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);
     qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);
     qtest_add_func("ast2400/hace/sha256", test_sha256_ast2400);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4d81857174ae..dcdbfe288931 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -392,9 +392,11 @@ if get_option('replication').allowed()
 endif
 
 qtests = {
-  'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
+  'aspeed_hace-test': [files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
+                       crypto],
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
-  'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
+  'ast2700-hace-test': [files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
+                        crypto],
   'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-- 
2.55.0


