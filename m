Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D42C5CFE7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPW-0006rH-Pi; Tue, 11 Aug 2026 12:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOx-0005VF-RZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpOv-00012b-1A
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJRwrm2IYU6Ftv00wB/Dj61pP7nuo71Cj26DCTpj8I0=;
 b=G5sxjyW8t1P7Ei9Wu30Xe2QCoYPZV2YKxsRLjZkG7E/cKdsY+KQXGLfdI6+dQx785Of3ze
 OuQmxptqh+nn6D5v0qVAGK5Ojkuwlx1DwQ5xtnNLl+b3tI14Fv+JCCGBxusQX1t13aNWl2
 /C1alMCIexZI+DzORdBSlgrnG9k91F4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-avsQL7VVOOW6MZvZuBsrjA-1; Tue,
 11 Aug 2026 12:32:18 -0400
X-MC-Unique: avsQL7VVOOW6MZvZuBsrjA-1
X-Mimecast-MFC-AGG-ID: avsQL7VVOOW6MZvZuBsrjA_1786465937
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11CC11956047; Tue, 11 Aug 2026 16:32:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D357195DF91; Tue, 11 Aug 2026 16:32:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 72/83] tests/qtest/aspeed-hace: Test the crypto command on the
 AST2600
Date: Tue, 11 Aug 2026 18:29:27 +0200
Message-ID: <20260811162938.1403216-73-clg@redhat.com>
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

Extend the crypto known-answer tests to cover the AST2600 crypto engine,
which drives the source and destination through scatter-gather lists and
adds CTR mode on top of the ECB/CBC modes shared with the AST2500.

Add a scatter-gather runner that describes each buffer with three
non-adjacent fragments to exercise the gather/scatter path, add
AES/DES/3DES CTR vectors (verifying the counter written back to the
context buffer), and give aspeed_add_crypto_tests() a mode mask and a
scatter-gather flag so each SoC registers exactly the modes and transfer
method it supports. Register the AST2600 with ECB/CBC/CTR in
scatter-gather mode.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-hace-utils.h |   7 +-
 tests/qtest/aspeed-hace-utils.c | 217 +++++++++++++++++++++++++++++++-
 tests/qtest/aspeed_hace-test.c  |   8 +-
 3 files changed, 224 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index 13feaa61e446..82b0b3f93d77 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -85,15 +85,18 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
 enum {
     CRYPT_MODE_ECB = 1 << 0,
     CRYPT_MODE_CBC = 1 << 1,
+    CRYPT_MODE_CTR = 1 << 2,
 };
 
 /*
  * Register the crypto known-answer tests that @modes selects (a mask of
  * CRYPT_MODE_*) for the given machine. Each test is named
- * "<prefix>/hace/crypto/<mode>".
+ * "<prefix>/hace/crypto/<mode>". @sg selects scatter-gather mode (used by the
+ * AST2600 and later) instead of the AST2500 direct access mode.
  */
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,
-                             uint32_t base, uint64_t dram, uint32_t modes);
+                             uint32_t base, uint64_t dram, uint32_t modes,
+                             bool sg);
 
 #endif /* TESTS_ASPEED_HACE_UTILS_H */
 
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index 0355dd47af15..f582c88ef515 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -665,6 +665,7 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
 #define HACE_CMD_OP_MODE_MASK    (0x7 << 4)
 #define HACE_CMD_ECB             (0x0 << 4)
 #define HACE_CMD_CBC             (0x1 << 4)
+#define HACE_CMD_CTR             (0x4 << 4)
 #define HACE_CMD_AES128          (0x0 << 2)
 
 /* Context buffer layout: IV (DES at +8), key at +0x10 */
@@ -750,6 +751,49 @@ static const uint8_t tdes_cbc_ptext[8] = {
 static const uint8_t tdes_cbc_ctext[8] = {
     0x0e, 0x2d, 0xb6, 0x97, 0x3c, 0x56, 0x33, 0xf4 };
 
+/* aes_ctr_tv_template[0] (NIST SP800-38A F.5.1), first block */
+static const uint8_t aes128_ctr_key[16] = {
+    0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6,
+    0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c };
+static const uint8_t aes128_ctr_iv[16] = {
+    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff };
+static const uint8_t aes128_ctr_ptext[16] = {
+    0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96,
+    0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a };
+static const uint8_t aes128_ctr_ctext[16] = {
+    0x87, 0x4d, 0x61, 0x91, 0xb6, 0x20, 0xe3, 0x26,
+    0x1b, 0xef, 0x68, 0x64, 0x99, 0x0d, 0xb6, 0xce };
+static const uint8_t aes128_ctr_ivout[16] = {
+    0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
+    0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xff, 0x00 };
+
+/* des_ctr_tv_template[0] (Crypto++), first block */
+static const uint8_t des_ctr_key[8] = {
+    0xc9, 0x83, 0xa6, 0xc9, 0xec, 0x0f, 0x32, 0x55 };
+static const uint8_t des_ctr_iv[8] = {
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfd };
+static const uint8_t des_ctr_ptext[8] = {
+    0x50, 0xb9, 0x22, 0xae, 0x17, 0x80, 0x0c, 0x75 };
+static const uint8_t des_ctr_ctext[8] = {
+    0x2f, 0x96, 0x06, 0x0f, 0x50, 0xc9, 0x68, 0x03 };
+static const uint8_t des_ctr_ivout[8] = {
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xfe };
+
+/* des3_ede_ctr_tv_template[0] (Crypto++), first block */
+static const uint8_t tdes_ctr_key[24] = {
+    0x9c, 0xd6, 0xf3, 0x9c, 0xb9, 0x5a, 0x67, 0x00,
+    0x5a, 0x67, 0x00, 0x2d, 0xce, 0xeb, 0x2d, 0xce,
+    0xeb, 0xb4, 0x51, 0x72, 0xb4, 0x51, 0x72, 0x1f };
+static const uint8_t tdes_ctr_iv[8] = {
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+static const uint8_t tdes_ctr_ptext[8] = {
+    0x05, 0xec, 0x77, 0xfb, 0x42, 0xd5, 0x59, 0x20 };
+static const uint8_t tdes_ctr_ctext[8] = {
+    0x07, 0xc2, 0x08, 0x20, 0x72, 0x1f, 0x49, 0xef };
+static const uint8_t tdes_ctr_ivout[8] = {
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+
 typedef struct CryptTest {
     QCryptoCipherMode mode;
     QCryptoCipherAlgo alg;
@@ -841,12 +885,65 @@ static const CryptTest crypt_tests[] = {
         .ctext = tdes_cbc_ctext,
         .len = sizeof(tdes_cbc_ptext),
     },
+    {
+        .name = "aes128-ctr",
+        .cmd = HACE_CMD_AES128 | HACE_CMD_CTR,
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .mode = QCRYPTO_CIPHER_MODE_CTR,
+        .key = aes128_ctr_key,
+        .keylen = sizeof(aes128_ctr_key),
+        .iv = aes128_ctr_iv,
+        .ivlen = sizeof(aes128_ctr_iv),
+        .ptext = aes128_ctr_ptext,
+        .ctext = aes128_ctr_ctext,
+        .iv_out = aes128_ctr_ivout,
+        .len = sizeof(aes128_ctr_ptext),
+    },
+    {
+        .name = "des-ctr",
+        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_CTR,
+        .alg = QCRYPTO_CIPHER_ALGO_DES,
+        .mode = QCRYPTO_CIPHER_MODE_CTR,
+        .key = des_ctr_key,
+        .keylen = sizeof(des_ctr_key),
+        .iv = des_ctr_iv,
+        .ivlen = sizeof(des_ctr_iv),
+        .ptext = des_ctr_ptext,
+        .ctext = des_ctr_ctext,
+        .iv_out = des_ctr_ivout,
+        .len = sizeof(des_ctr_ptext),
+    },
+    {
+        .name = "des3_ede-ctr",
+        .cmd = HACE_CMD_DES_SELECT | HACE_CMD_TRIPLE_DES | HACE_CMD_CTR,
+        .alg = QCRYPTO_CIPHER_ALGO_3DES,
+        .mode = QCRYPTO_CIPHER_MODE_CTR,
+        .key = tdes_ctr_key,
+        .keylen = sizeof(tdes_ctr_key),
+        .iv = tdes_ctr_iv,
+        .ivlen = sizeof(tdes_ctr_iv),
+        .ptext = tdes_ctr_ptext,
+        .ctext = tdes_ctr_ctext,
+        .iv_out = tdes_ctr_ivout,
+        .len = sizeof(tdes_ctr_ptext),
+    },
 };
 
 /* DRAM offsets for the crypto test source, destination and context buffers. */
 #define CRYPT_OFF_SRC   0x10000
 #define CRYPT_OFF_DST   0x20000
 #define CRYPT_OFF_CTX   0x30000
+/* Scatter-gather list offsets (each list has CRYPT_SG_FRAGS entries). */
+#define CRYPT_OFF_SRC_SG  0x40000
+#define CRYPT_OFF_DST_SG  0x50000
+/*
+ * The scatter-gather tests split each buffer into CRYPT_SG_FRAGS fragments,
+ * each placed CRYPT_SG_FRAG_STRIDE apart so the fragments never abut. The gaps
+ * make the test fail if the engine ignores the list and reads one contiguous
+ * block.
+ */
+#define CRYPT_SG_FRAGS         3
+#define CRYPT_SG_FRAG_STRIDE   0x1000
 
 /* Describes one registered crypto test (qtest_add_data_func() data pointer). */
 typedef struct AspeedCryptoTest {
@@ -854,6 +951,7 @@ typedef struct AspeedCryptoTest {
     uint64_t dram;
     uint32_t base;
     int index;
+    bool sg;
 } AspeedCryptoTest;
 
 /* Map a command's operation mode (HACE10[6:4]) to a CRYPT_MODE_* flag. */
@@ -864,6 +962,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)
         return CRYPT_MODE_ECB;
     case HACE_CMD_CBC:
         return CRYPT_MODE_CBC;
+    case HACE_CMD_CTR:
+        return CRYPT_MODE_CTR;
     default:
         return 0;
     }
@@ -912,7 +1012,104 @@ static void crypt_run_direct(QTestState *s, uint32_t base, uint64_t dram,
     qtest_memread(s, dst, out, t->len);
 }
 
-static void aspeed_test_crypto_direct(const void *data)
+/*
+ * Byte range [*frag_off, *frag_off + *frag_len) of fragment @index when an
+ * @len-byte buffer is split into CRYPT_SG_FRAGS pieces; the last piece takes
+ * the remainder of an uneven split.
+ */
+static void crypt_frag_range(uint32_t len, int index,
+                             uint32_t *frag_off, uint32_t *frag_len)
+{
+    uint32_t base = len / CRYPT_SG_FRAGS;
+
+    *frag_off = base * index;
+    *frag_len = (index == CRYPT_SG_FRAGS - 1) ? len - *frag_off : base;
+}
+
+/*
+ * Scatter [in, len) across CRYPT_SG_FRAGS buffers based at @base_off and spaced
+ * CRYPT_SG_FRAG_STRIDE apart, then build the SG list describing them at @list.
+ * When @in is NULL only the list is built (used for the destination, which the
+ * engine fills in).
+ */
+static void crypt_make_sg(QTestState *s, uint64_t dram, uint32_t base_off,
+                          uint64_t list, const uint8_t *in, uint32_t len)
+{
+    struct AspeedSgList sg[CRYPT_SG_FRAGS];
+    uint32_t frag_off;
+    uint32_t frag_len;
+    uint64_t buf;
+    int i;
+
+    for (i = 0; i < CRYPT_SG_FRAGS; i++) {
+        crypt_frag_range(len, i, &frag_off, &frag_len);
+        buf = dram + base_off + i * CRYPT_SG_FRAG_STRIDE;
+
+        if (in) {
+            qtest_memwrite(s, buf, in + frag_off, frag_len);
+        }
+        sg[i].len = cpu_to_le32(frag_len | (i == CRYPT_SG_FRAGS - 1 ?
+                                            SG_LIST_LEN_LAST : 0));
+        sg[i].addr = cpu_to_le32((uint32_t)buf);
+    }
+
+    qtest_memwrite(s, list, sg, sizeof(sg));
+}
+
+/* Gather a scatter-gathered result back from the CRYPT_SG_FRAGS buffers. */
+static void crypt_gather_sg(QTestState *s, uint64_t dram, uint32_t base_off,
+                            uint8_t *out, uint32_t len)
+{
+    uint32_t frag_off;
+    uint32_t frag_len;
+    int i;
+
+    for (i = 0; i < CRYPT_SG_FRAGS; i++) {
+        crypt_frag_range(len, i, &frag_off, &frag_len);
+        qtest_memread(s, dram + base_off + i * CRYPT_SG_FRAG_STRIDE,
+                      out + frag_off, frag_len);
+    }
+}
+
+/*
+ * Run one block-cipher (ECB/CBC/CTR) operation in scatter-gather mode and read
+ * back the result. The source and destination are each split across
+ * CRYPT_SG_FRAGS non-adjacent DRAM buffers described by an SG list; the gaps
+ * ensure the test fails if the engine ignores the list and reads one
+ * contiguous block.
+ */
+static void crypt_run_sg(QTestState *s, uint32_t base, uint64_t dram,
+                         const CryptTest *t, bool encrypt, uint8_t *out)
+{
+    const uint8_t *in = encrypt ? t->ptext : t->ctext;
+    uint64_t src_sg = dram + CRYPT_OFF_SRC_SG;
+    uint64_t dst_sg = dram + CRYPT_OFF_DST_SG;
+    uint64_t ctx = dram + CRYPT_OFF_CTX;
+    uint32_t cmd = t->cmd | HACE_CMD_ISR_EN | HACE_CMD_SRC_SG_CTRL |
+                   HACE_CMD_DST_SG_CTRL;
+
+    if (encrypt) {
+        cmd |= HACE_CMD_ENCRYPT;
+    }
+
+    crypt_write_ctx(s, ctx, t);
+    crypt_make_sg(s, dram, CRYPT_OFF_SRC, src_sg, in, t->len);
+    crypt_make_sg(s, dram, CRYPT_OFF_DST, dst_sg, NULL, t->len);
+
+    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src_sg);
+    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst_sg);
+    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);
+    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
+
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, ==,
+                    HACE_CRYPTO_ISR);
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
+
+    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);
+}
+
+static void aspeed_test_crypto(const void *data)
 {
     const AspeedCryptoTest *c = data;
     const CryptTest *t = &crypt_tests[c->index];
@@ -924,7 +1121,11 @@ static void aspeed_test_crypto_direct(const void *data)
     g_assert_cmpuint(t->len, <=, sizeof(out));
 
     /* Encrypt: ptext -> ctext */
-    crypt_run_direct(s, c->base, c->dram, t, true, out);
+    if (c->sg) {
+        crypt_run_sg(s, c->base, c->dram, t, true, out);
+    } else {
+        crypt_run_direct(s, c->base, c->dram, t, true, out);
+    }
     g_assert_cmpmem(out, t->len, t->ctext, t->len);
 
     if (t->iv_out) {
@@ -934,14 +1135,19 @@ static void aspeed_test_crypto_direct(const void *data)
     }
 
     /* Decrypt: ctext -> ptext */
-    crypt_run_direct(s, c->base, c->dram, t, false, out);
+    if (c->sg) {
+        crypt_run_sg(s, c->base, c->dram, t, false, out);
+    } else {
+        crypt_run_direct(s, c->base, c->dram, t, false, out);
+    }
     g_assert_cmpmem(out, t->len, t->ptext, t->len);
 
     qtest_quit(s);
 }
 
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,
-                             uint32_t base, uint64_t dram, uint32_t modes)
+                             uint32_t base, uint64_t dram, uint32_t modes,
+                             bool sg)
 {
     int i;
 
@@ -966,7 +1172,8 @@ void aspeed_add_crypto_tests(const char *prefix, const char *machine,
         t->base = base;
         t->dram = dram;
         t->index = i;
-        qtest_add_data_func_full(path, t, aspeed_test_crypto_direct, g_free);
+        t->sg = sg;
+        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);
     }
 }
 
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.c
index 4cb4c475e9d8..61a3e3feb514 100644
--- a/tests/qtest/aspeed_hace-test.c
+++ b/tests/qtest/aspeed_hace-test.c
@@ -224,6 +224,12 @@ int main(int argc, char **argv)
     qtest_add_func("ast2600/hace/sha384_accum", test_sha384_accum_ast2600);
     qtest_add_func("ast2600/hace/sha256_accum", test_sha256_accum_ast2600);
 
+    /* The AST2600 crypto engine uses scatter-gather mode and adds CTR. */
+    aspeed_add_crypto_tests("ast2600", "-machine ast2600-evb", 0x1e6d0000,
+                            0x80000000,
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_CTR,
+                            true);
+
     qtest_add_func("ast2500/hace/addresses", test_addresses_ast2500);
     qtest_add_func("ast2500/hace/sha512", test_sha512_ast2500);
     qtest_add_func("ast2500/hace/sha256", test_sha256_ast2500);
@@ -233,7 +239,7 @@ int main(int argc, char **argv)
      * The AST2500 crypto engine uses direct access mode and supports ECB/CBC.
      */
     aspeed_add_crypto_tests("ast2500", "-machine ast2500-evb", 0x1e6e3000,
-                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC);
+                            0x80000000, CRYPT_MODE_ECB | CRYPT_MODE_CBC, false);
 
     qtest_add_func("ast2400/hace/addresses", test_addresses_ast2400);
     qtest_add_func("ast2400/hace/sha512", test_sha512_ast2400);
-- 
2.55.0


