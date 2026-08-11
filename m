Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06A0C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPW-0006oI-6e; Tue, 11 Aug 2026 12:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPH-0005je-J2
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpPF-000175-HU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nYmcTpsXs9u2iJq7qfWvrOjVfS8uSKKEGzwzSAgw+SI=;
 b=D5eYS3RJFbt/2c8DVCIVIDF6O/Ue7HSL/KX29mZb3v+yqYY61rY2V+5+LmWt1FuswpJ72C
 o6BvpTB9wI2ixm1JobgN6BH7bmphhu02BiEvc784183nmZJEl4FhDjOOV0aJpT2F6u+8Zy
 MTPk1gZAFYwGclSjdR13lAIqG2+giDo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-W-nteuLOPUihjEfwUJWWBw-1; Tue,
 11 Aug 2026 12:32:43 -0400
X-MC-Unique: W-nteuLOPUihjEfwUJWWBw-1
X-Mimecast-MFC-AGG-ID: W-nteuLOPUihjEfwUJWWBw_1786465962
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5656A195609F; Tue, 11 Aug 2026 16:32:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D6F0195DF9D; Tue, 11 Aug 2026 16:32:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 83/83] tests/qtest/aspeed-hace: Test the crypto command on the
 AST2700
Date: Tue, 11 Aug 2026 18:29:38 +0200
Message-ID: <20260811162938.1403216-84-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Cover the AST2700 crypto engine, which drives 64-bit scatter-gather DMA
and adds AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.
Add AES-128 and AES-256 GCM known-answer vectors (GCM specification /
NIST SP 800-38D, no associated data) and a dedicated GCM runner that
programs the tag buffer and reads the tag back, checking it after both
encryption and decryption. Register the AST2700 with all four modes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-17-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-hace-utils.h |   1 +
 tests/qtest/aspeed-hace-utils.c | 163 +++++++++++++++++++++++++++++++-
 tests/qtest/ast2700-hace-test.c |   9 ++
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
index 82b0b3f93d77..a5601a3d65fc 100644
--- a/tests/qtest/aspeed-hace-utils.h
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -86,6 +86,7 @@ enum {
     CRYPT_MODE_ECB = 1 << 0,
     CRYPT_MODE_CBC = 1 << 1,
     CRYPT_MODE_CTR = 1 << 2,
+    CRYPT_MODE_GCM = 1 << 3,
 };
 
 /*
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
index f582c88ef515..260eec043c73 100644
--- a/tests/qtest/aspeed-hace-utils.c
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -654,6 +654,8 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
 #define HACE_CRYPTO_CONTEXT      0x08
 #define HACE_CRYPTO_DATA_LEN     0x0c
 #define HACE_CRYPTO_CMD          0x10
+#define HACE_CRYPTO_GCM_ADD_LEN  0x14
+#define HACE_CRYPTO_GCM_TAG      0x18
 
 /* Crypto command bits */
 #define HACE_CMD_ENCRYPT         BIT(7)
@@ -666,7 +668,9 @@ void aspeed_test_addresses(const char *machine, const uint32_t base,
 #define HACE_CMD_ECB             (0x0 << 4)
 #define HACE_CMD_CBC             (0x1 << 4)
 #define HACE_CMD_CTR             (0x4 << 4)
+#define HACE_CMD_GCM             (0x5 << 4)
 #define HACE_CMD_AES128          (0x0 << 2)
+#define HACE_CMD_AES256          (0x2 << 2)
 
 /* Context buffer layout: IV (DES at +8), key at +0x10 */
 #define HACE_CTX_KEY_OFFSET      0x10
@@ -794,6 +798,59 @@ static const uint8_t tdes_ctr_ctext[8] = {
 static const uint8_t tdes_ctr_ivout[8] = {
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
 
+/*
+ * aes_gcm_tv_template[2] (AES-128) and [9] (AES-256), from the McGrew & Viega
+ * GCM spec (also NIST SP 800-38D), no AAD. Both cases share this plaintext/IV.
+ */
+static const uint8_t aes_gcm_ptext[64] = {
+    0xd9, 0x31, 0x32, 0x25, 0xf8, 0x84, 0x06, 0xe5,
+    0xa5, 0x59, 0x09, 0xc5, 0xaf, 0xf5, 0x26, 0x9a,
+    0x86, 0xa7, 0xa9, 0x53, 0x15, 0x34, 0xf7, 0xda,
+    0x2e, 0x4c, 0x30, 0x3d, 0x8a, 0x31, 0x8a, 0x72,
+    0x1c, 0x3c, 0x0c, 0x95, 0x95, 0x68, 0x09, 0x53,
+    0x2f, 0xcf, 0x0e, 0x24, 0x49, 0xa6, 0xb5, 0x25,
+    0xb1, 0x6a, 0xed, 0xf5, 0xaa, 0x0d, 0xe6, 0x57,
+    0xba, 0x63, 0x7b, 0x39, 0x1a, 0xaf, 0xd2, 0x55 };
+static const uint8_t aes_gcm_iv[12] = {
+    0xca, 0xfe, 0xba, 0xbe, 0xfa, 0xce, 0xdb, 0xad,
+    0xde, 0xca, 0xf8, 0x88 };
+
+/* aes_gcm_tv_template[2] (AES-128) */
+static const uint8_t aes128_gcm_key[16] = {
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };
+static const uint8_t aes128_gcm_ctext[64] = {
+    0x42, 0x83, 0x1e, 0xc2, 0x21, 0x77, 0x74, 0x24,
+    0x4b, 0x72, 0x21, 0xb7, 0x84, 0xd0, 0xd4, 0x9c,
+    0xe3, 0xaa, 0x21, 0x2f, 0x2c, 0x02, 0xa4, 0xe0,
+    0x35, 0xc1, 0x7e, 0x23, 0x29, 0xac, 0xa1, 0x2e,
+    0x21, 0xd5, 0x14, 0xb2, 0x54, 0x66, 0x93, 0x1c,
+    0x7d, 0x8f, 0x6a, 0x5a, 0xac, 0x84, 0xaa, 0x05,
+    0x1b, 0xa3, 0x0b, 0x39, 0x6a, 0x0a, 0xac, 0x97,
+    0x3d, 0x58, 0xe0, 0x91, 0x47, 0x3f, 0x59, 0x85 };
+static const uint8_t aes128_gcm_tag[16] = {
+    0x4d, 0x5c, 0x2a, 0xf3, 0x27, 0xcd, 0x64, 0xa6,
+    0x2c, 0xf3, 0x5a, 0xbd, 0x2b, 0xa6, 0xfa, 0xb4 };
+
+/* aes_gcm_tv_template[9] (AES-256) */
+static const uint8_t aes256_gcm_key[32] = {
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08,
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };
+static const uint8_t aes256_gcm_ctext[64] = {
+    0x52, 0x2d, 0xc1, 0xf0, 0x99, 0x56, 0x7d, 0x07,
+    0xf4, 0x7f, 0x37, 0xa3, 0x2a, 0x84, 0x42, 0x7d,
+    0x64, 0x3a, 0x8c, 0xdc, 0xbf, 0xe5, 0xc0, 0xc9,
+    0x75, 0x98, 0xa2, 0xbd, 0x25, 0x55, 0xd1, 0xaa,
+    0x8c, 0xb0, 0x8e, 0x48, 0x59, 0x0d, 0xbb, 0x3d,
+    0xa7, 0xb0, 0x8b, 0x10, 0x56, 0x82, 0x88, 0x38,
+    0xc5, 0xf6, 0x1e, 0x63, 0x93, 0xba, 0x7a, 0x0a,
+    0xbc, 0xc9, 0xf6, 0x62, 0x89, 0x80, 0x15, 0xad };
+static const uint8_t aes256_gcm_tag[16] = {
+    0xb0, 0x94, 0xda, 0xc5, 0xd9, 0x34, 0x71, 0xbd,
+    0xec, 0x1a, 0x50, 0x22, 0x70, 0xe3, 0xcc, 0x6c };
+
 typedef struct CryptTest {
     QCryptoCipherMode mode;
     QCryptoCipherAlgo alg;
@@ -801,10 +858,13 @@ typedef struct CryptTest {
     const uint8_t *iv_out;
     const uint8_t *ptext;
     const uint8_t *ctext;
+    /* expected GCM authentication tag, or NULL for non-AEAD modes */
+    const uint8_t *tag;
     const uint8_t *key;
     const uint8_t *iv;
     const char *name;
     size_t keylen;
+    size_t taglen;
     /* algorithm | mode | key size selection */
     uint32_t cmd;
     size_t ivlen;
@@ -927,6 +987,36 @@ static const CryptTest crypt_tests[] = {
         .iv_out = tdes_ctr_ivout,
         .len = sizeof(tdes_ctr_ptext),
     },
+    {
+        .name = "aes128-gcm",
+        .cmd = HACE_CMD_AES128 | HACE_CMD_GCM,
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .mode = QCRYPTO_CIPHER_MODE_GCM,
+        .key = aes128_gcm_key,
+        .keylen = sizeof(aes128_gcm_key),
+        .iv = aes_gcm_iv,
+        .ivlen = sizeof(aes_gcm_iv),
+        .ptext = aes_gcm_ptext,
+        .ctext = aes128_gcm_ctext,
+        .tag = aes128_gcm_tag,
+        .taglen = sizeof(aes128_gcm_tag),
+        .len = sizeof(aes_gcm_ptext),
+    },
+    {
+        .name = "aes256-gcm",
+        .cmd = HACE_CMD_AES256 | HACE_CMD_GCM,
+        .alg = QCRYPTO_CIPHER_ALGO_AES_256,
+        .mode = QCRYPTO_CIPHER_MODE_GCM,
+        .key = aes256_gcm_key,
+        .keylen = sizeof(aes256_gcm_key),
+        .iv = aes_gcm_iv,
+        .ivlen = sizeof(aes_gcm_iv),
+        .ptext = aes_gcm_ptext,
+        .ctext = aes256_gcm_ctext,
+        .tag = aes256_gcm_tag,
+        .taglen = sizeof(aes256_gcm_tag),
+        .len = sizeof(aes_gcm_ptext),
+    },
 };
 
 /* DRAM offsets for the crypto test source, destination and context buffers. */
@@ -944,6 +1034,8 @@ static const CryptTest crypt_tests[] = {
  */
 #define CRYPT_SG_FRAGS         3
 #define CRYPT_SG_FRAG_STRIDE   0x1000
+/* DRAM offset for the AES-GCM authentication tag write buffer. */
+#define CRYPT_OFF_TAG          0x60000
 
 /* Describes one registered crypto test (qtest_add_data_func() data pointer). */
 typedef struct AspeedCryptoTest {
@@ -964,6 +1056,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)
         return CRYPT_MODE_CBC;
     case HACE_CMD_CTR:
         return CRYPT_MODE_CTR;
+    case HACE_CMD_GCM:
+        return CRYPT_MODE_GCM;
     default:
         return 0;
     }
@@ -1109,6 +1203,47 @@ static void crypt_run_sg(QTestState *s, uint32_t base, uint64_t dram,
     crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);
 }
 
+/*
+ * Run one AES-GCM operation in scatter-gather mode: like crypt_run_sg() but
+ * also program the tag write buffer (HACE18) with no associated data, and read
+ * the authentication tag back into @out_tag.
+ */
+static void crypt_run_gcm(QTestState *s, uint32_t base, uint64_t dram,
+                          const CryptTest *t, bool encrypt, uint8_t *out,
+                          uint8_t *out_tag)
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
+    qtest_writel(s, base + HACE_CRYPTO_GCM_ADD_LEN, 0);
+    qtest_writel(s, base + HACE_CRYPTO_GCM_TAG,
+                 (uint32_t)(dram + CRYPT_OFF_TAG));
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);
+
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, ==,
+                    HACE_CRYPTO_ISR);
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);
+
+    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);
+    qtest_memread(s, dram + CRYPT_OFF_TAG, out_tag, t->taglen);
+}
+
 static void aspeed_test_crypto(const void *data)
 {
     const AspeedCryptoTest *c = data;
@@ -1145,6 +1280,29 @@ static void aspeed_test_crypto(const void *data)
     qtest_quit(s);
 }
 
+static void aspeed_test_crypto_gcm(const void *data)
+{
+    const AspeedCryptoTest *c = data;
+    const CryptTest *t = &crypt_tests[c->index];
+    QTestState *s = qtest_init(c->machine);
+    uint8_t out[64];
+    uint8_t tag[16];
+
+    g_assert_cmpuint(t->len, <=, sizeof(out));
+
+    /* Encrypt: ptext -> ctext, then check the authentication tag. */
+    crypt_run_gcm(s, c->base, c->dram, t, true, out, tag);
+    g_assert_cmpmem(out, t->len, t->ctext, t->len);
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);
+
+    /* Decrypt: ctext -> ptext, the recomputed tag must match. */
+    crypt_run_gcm(s, c->base, c->dram, t, false, out, tag);
+    g_assert_cmpmem(out, t->len, t->ptext, t->len);
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);
+
+    qtest_quit(s);
+}
+
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,
                              uint32_t base, uint64_t dram, uint32_t modes,
                              bool sg)
@@ -1152,6 +1310,7 @@ void aspeed_add_crypto_tests(const char *prefix, const char *machine,
     int i;
 
     for (i = 0; i < ARRAY_SIZE(crypt_tests); i++) {
+        bool is_gcm = crypt_tests[i].mode == QCRYPTO_CIPHER_MODE_GCM;
         g_autofree char *path = NULL;
         AspeedCryptoTest *t;
 
@@ -1173,7 +1332,9 @@ void aspeed_add_crypto_tests(const char *prefix, const char *machine,
         t->dram = dram;
         t->index = i;
         t->sg = sg;
-        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);
+        qtest_add_data_func_full(path, t,
+                                 is_gcm ? aspeed_test_crypto_gcm :
+                                 aspeed_test_crypto, g_free);
     }
 }
 
diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-test.c
index 508a34dd6c65..3f0217d63510 100644
--- a/tests/qtest/ast2700-hace-test.c
+++ b/tests/qtest/ast2700-hace-test.c
@@ -94,5 +94,14 @@ int main(int argc, char **argv)
     qtest_add_func("ast2700/hace/sha384_accum", test_sha384_accum_ast2700);
     qtest_add_func("ast2700/hace/sha256_accum", test_sha256_accum_ast2700);
 
+    /*
+     * The AST2700 crypto engine uses scatter-gather with 64-bit DMA and adds
+     * AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.
+     */
+    aspeed_add_crypto_tests("ast2700", "-machine ast2700-evb", 0x12070000,
+                            0x400000000,
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_CTR |
+                            CRYPT_MODE_GCM, true);
+
     return g_test_run();
 }
-- 
2.55.0


