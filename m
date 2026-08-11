Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CF0C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPR-0006B0-FB; Tue, 11 Aug 2026 12:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP7-0005aB-5y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP4-00014H-3K
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Urm/uDj0mXYGo2zMUDdzTQCkCidK6nG5ccSCnhChbyA=;
 b=NIjIpecvTUsZQo/ZhHGh2lhZM2Rhjn7rZpFY2nsSDyW9bUmA94EFz5cYgKpbpZoslJeoxA
 AkmcRs9NjCjVH6KtvxnzJClItAyRo4QttPeHCsmRUix66WDf+Pyib8wGeTnzzUEERwkNsO
 BFNeiu/aWnU1fXCXI742T2NepMmjY0Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-dCWSL8FyMkGbwmnobb561Q-1; Tue,
 11 Aug 2026 12:32:34 -0400
X-MC-Unique: dCWSL8FyMkGbwmnobb561Q-1
X-Mimecast-MFC-AGG-ID: dCWSL8FyMkGbwmnobb561Q_1786465953
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32490195609F; Tue, 11 Aug 2026 16:32:33 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4EAF195DF96; Tue, 11 Aug 2026 16:32:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 79/83] tests/unit/test-crypto-cipher: Test AES-GCM mode
Date: Tue, 11 Aug 2026 18:29:34 +0200
Message-ID: <20260811162938.1403216-80-clg@redhat.com>
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

Exercise the new GCM mode and the setaad/gettag helpers with the
canonical AES-GCM test vectors from the GCM specification (McGrew &
Viega, also NIST SP 800-38D): AES-128 and AES-256, with and without
associated data. Each vector is run through encrypt (checking the
ciphertext and the generated tag) and decrypt (checking the recovered
plaintext and the recomputed tag).

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/unit/test-crypto-cipher.c | 240 ++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
index 1331d558cf25..420c826df95b 100644
--- a/tests/unit/test-crypto-cipher.c
+++ b/tests/unit/test-crypto-cipher.c
@@ -810,6 +810,230 @@ static void test_cipher_short_plaintext(void)
     qcrypto_cipher_free(cipher);
 }
 
+typedef struct QCryptoCipherGcmTestData QCryptoCipherGcmTestData;
+struct QCryptoCipherGcmTestData {
+    const char *path;
+    QCryptoCipherAlgo alg;
+    const char *key;
+    const char *iv;
+    /* associated data, or NULL for none */
+    const char *aad;
+    const char *plaintext;
+    const char *ciphertext;
+    const char *tag;
+};
+
+/*
+ * AES-GCM test vectors from "The Galois/Counter Mode of Operation (GCM)"
+ * (McGrew & Viega, also NIST SP 800-38D), with a 96-bit IV and a 128-bit
+ * tag. Each entry's "Test case N" label is the numbered test case from that
+ * document (Appendix B / the GCM specification's test vectors).
+ */
+static QCryptoCipherGcmTestData gcm_test_data[] = {
+    {
+        /* Test case 2 */
+        .path = "/crypto/cipher/aes-gcm-128-2",
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .key = "00000000000000000000000000000000",
+        .iv = "000000000000000000000000",
+        .plaintext = "00000000000000000000000000000000",
+        .ciphertext = "0388dace60b6a392f328c2b971b2fe78",
+        .tag = "ab6e47d42cec13bdf53a67b21257bddf",
+    },
+    {
+        /* Test case 3 (no AAD) */
+        .path = "/crypto/cipher/aes-gcm-128-3",
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .key = "feffe9928665731c6d6a8f9467308308",
+        .iv = "cafebabefacedbaddecaf888",
+        .plaintext =
+            "d9313225f88406e5a55909c5aff5269a"
+            "86a7a9531534f7da2e4c303d8a318a72"
+            "1c3c0c95956809532fcf0e2449a6b525"
+            "b16aedf5aa0de657ba637b391aafd255",
+        .ciphertext =
+            "42831ec2217774244b7221b784d0d49c"
+            "e3aa212f2c02a4e035c17e2329aca12e"
+            "21d514b25466931c7d8f6a5aac84aa05"
+            "1ba30b396a0aac973d58e091473f5985",
+        .tag = "4d5c2af327cd64a62cf35abd2ba6fab4",
+    },
+    {
+        /* Test case 4 (with AAD) */
+        .path = "/crypto/cipher/aes-gcm-128-4",
+        .alg = QCRYPTO_CIPHER_ALGO_AES_128,
+        .key = "feffe9928665731c6d6a8f9467308308",
+        .iv = "cafebabefacedbaddecaf888",
+        .aad = "feedfacedeadbeeffeedfacedeadbeefabaddad2",
+        .plaintext =
+            "d9313225f88406e5a55909c5aff5269a"
+            "86a7a9531534f7da2e4c303d8a318a72"
+            "1c3c0c95956809532fcf0e2449a6b525"
+            "b16aedf5aa0de657ba637b39",
+        .ciphertext =
+            "42831ec2217774244b7221b784d0d49c"
+            "e3aa212f2c02a4e035c17e2329aca12e"
+            "21d514b25466931c7d8f6a5aac84aa05"
+            "1ba30b396a0aac973d58e091",
+        .tag = "5bc94fbc3221a5db94fae95ae7121a47",
+    },
+    {
+        /* Test case 15 (AES-256, no AAD) */
+        .path = "/crypto/cipher/aes-gcm-256-15",
+        .alg = QCRYPTO_CIPHER_ALGO_AES_256,
+        .key =
+            "feffe9928665731c6d6a8f9467308308"
+            "feffe9928665731c6d6a8f9467308308",
+        .iv = "cafebabefacedbaddecaf888",
+        .plaintext =
+            "d9313225f88406e5a55909c5aff5269a"
+            "86a7a9531534f7da2e4c303d8a318a72"
+            "1c3c0c95956809532fcf0e2449a6b525"
+            "b16aedf5aa0de657ba637b391aafd255",
+        .ciphertext =
+            "522dc1f099567d07f47f37a32a84427d"
+            "643a8cdcbfe5c0c97598a2bd2555d1aa"
+            "8cb08e48590dbb3da7b08b1056828838"
+            "c5f61e6393ba7a0abcc9f662898015ad",
+        .tag = "b094dac5d93471bdec1a502270e3cc6c",
+    },
+    {
+        /* Test case 16 (AES-256, with AAD) */
+        .path = "/crypto/cipher/aes-gcm-256-16",
+        .alg = QCRYPTO_CIPHER_ALGO_AES_256,
+        .key =
+            "feffe9928665731c6d6a8f9467308308"
+            "feffe9928665731c6d6a8f9467308308",
+        .iv = "cafebabefacedbaddecaf888",
+        .aad = "feedfacedeadbeeffeedfacedeadbeefabaddad2",
+        .plaintext =
+            "d9313225f88406e5a55909c5aff5269a"
+            "86a7a9531534f7da2e4c303d8a318a72"
+            "1c3c0c95956809532fcf0e2449a6b525"
+            "b16aedf5aa0de657ba637b39",
+        .ciphertext =
+            "522dc1f099567d07f47f37a32a84427d"
+            "643a8cdcbfe5c0c97598a2bd2555d1aa"
+            "8cb08e48590dbb3da7b08b1056828838"
+            "c5f61e6393ba7a0abcc9f662",
+        .tag = "76fc6ece0f4e1768cddf8853bb2d551b",
+    },
+};
+
+static void test_cipher_gcm(const void *opaque)
+{
+    const QCryptoCipherGcmTestData *data = opaque;
+    g_autofree uint8_t *key = NULL;
+    g_autofree uint8_t *iv = NULL;
+    g_autofree uint8_t *aad = NULL;
+    g_autofree uint8_t *ptext = NULL;
+    g_autofree uint8_t *ctext = NULL;
+    g_autofree uint8_t *tagexp = NULL;
+    g_autofree uint8_t *out = NULL;
+    uint8_t tag[16];
+    size_t nkey;
+    size_t niv;
+    size_t naad = 0;
+    size_t nptext;
+    size_t nctext;
+    size_t ntag;
+    QCryptoCipher *cipher;
+
+    nkey = unhex_string(data->key, &key);
+    niv = unhex_string(data->iv, &iv);
+    nptext = unhex_string(data->plaintext, &ptext);
+    nctext = unhex_string(data->ciphertext, &ctext);
+    ntag = unhex_string(data->tag, &tagexp);
+    if (data->aad) {
+        naad = unhex_string(data->aad, &aad);
+    }
+
+    g_assert_cmpint(nptext, ==, nctext);
+    g_assert_cmpint(ntag, ==, sizeof(tag));
+    out = g_new0(uint8_t, nptext);
+
+    /* Encrypt: plaintext -> ciphertext, then read back the tag. */
+    cipher = qcrypto_cipher_new(data->alg, QCRYPTO_CIPHER_MODE_GCM,
+                                key, nkey, &error_abort);
+    g_assert(cipher != NULL);
+    g_assert(qcrypto_cipher_setiv(cipher, iv, niv, &error_abort) == 0);
+    if (naad) {
+        g_assert(qcrypto_cipher_setaad(cipher, aad, naad, &error_abort) == 0);
+    }
+    g_assert(qcrypto_cipher_encrypt(cipher, ptext, out, nptext,
+                                    &error_abort) == 0);
+    g_assert_cmpmem(out, nptext, ctext, nctext);
+    g_assert(qcrypto_cipher_gettag(cipher, tag, sizeof(tag),
+                                   &error_abort) == 0);
+    g_assert_cmpmem(tag, sizeof(tag), tagexp, ntag);
+    qcrypto_cipher_free(cipher);
+
+    /* Decrypt: ciphertext -> plaintext, recomputed tag must match. */
+    memset(out, 0, nptext);
+    cipher = qcrypto_cipher_new(data->alg, QCRYPTO_CIPHER_MODE_GCM,
+                                key, nkey, &error_abort);
+    g_assert(cipher != NULL);
+    g_assert(qcrypto_cipher_setiv(cipher, iv, niv, &error_abort) == 0);
+    if (naad) {
+        g_assert(qcrypto_cipher_setaad(cipher, aad, naad, &error_abort) == 0);
+    }
+    g_assert(qcrypto_cipher_decrypt(cipher, ctext, out, nctext,
+                                    &error_abort) == 0);
+    g_assert_cmpmem(out, nctext, ptext, nptext);
+    g_assert(qcrypto_cipher_gettag(cipher, tag, sizeof(tag),
+                                   &error_abort) == 0);
+    g_assert_cmpmem(tag, sizeof(tag), tagexp, ntag);
+    qcrypto_cipher_free(cipher);
+}
+
+/*
+ * Corrupt one ciphertext byte and confirm the recomputed GCM tag no longer
+ * matches: the authentication tag must detect tampering.
+ */
+static void test_cipher_gcm_tamper(const void *opaque)
+{
+    const QCryptoCipherGcmTestData *data = opaque;
+    g_autofree uint8_t *key = NULL;
+    g_autofree uint8_t *iv = NULL;
+    g_autofree uint8_t *aad = NULL;
+    g_autofree uint8_t *ctext = NULL;
+    g_autofree uint8_t *tagexp = NULL;
+    g_autofree uint8_t *out = NULL;
+    uint8_t tag[16];
+    size_t nkey;
+    size_t niv;
+    size_t naad = 0;
+    size_t nctext;
+    size_t ntag;
+    QCryptoCipher *cipher;
+
+    nkey = unhex_string(data->key, &key);
+    niv = unhex_string(data->iv, &iv);
+    nctext = unhex_string(data->ciphertext, &ctext);
+    ntag = unhex_string(data->tag, &tagexp);
+    if (data->aad) {
+        naad = unhex_string(data->aad, &aad);
+    }
+    out = g_new0(uint8_t, nctext);
+
+    /* Flip one ciphertext bit before decrypting. */
+    ctext[0] ^= 0x01;
+
+    cipher = qcrypto_cipher_new(data->alg, QCRYPTO_CIPHER_MODE_GCM,
+                                key, nkey, &error_abort);
+    g_assert(cipher != NULL);
+    g_assert(qcrypto_cipher_setiv(cipher, iv, niv, &error_abort) == 0);
+    if (naad) {
+        g_assert(qcrypto_cipher_setaad(cipher, aad, naad, &error_abort) == 0);
+    }
+    g_assert(qcrypto_cipher_decrypt(cipher, ctext, out, nctext,
+                                    &error_abort) == 0);
+    g_assert(qcrypto_cipher_gettag(cipher, tag, sizeof(tag),
+                                   &error_abort) == 0);
+    g_assert(memcmp(tag, tagexp, ntag) != 0);
+    qcrypto_cipher_free(cipher);
+}
+
 int main(int argc, char **argv)
 {
     size_t i;
@@ -828,6 +1052,22 @@ int main(int argc, char **argv)
         }
     }
 
+    for (i = 0; i < G_N_ELEMENTS(gcm_test_data); i++) {
+        if (qcrypto_cipher_supports(gcm_test_data[i].alg,
+                                    QCRYPTO_CIPHER_MODE_GCM)) {
+            g_autofree char *tamper = g_strdup_printf("%s/tamper",
+                                                      gcm_test_data[i].path);
+
+            g_test_add_data_func(gcm_test_data[i].path, &gcm_test_data[i],
+                                 test_cipher_gcm);
+            g_test_add_data_func(tamper, &gcm_test_data[i],
+                                 test_cipher_gcm_tamper);
+        } else {
+            g_printerr("# skip unsupported %s:gcm\n",
+                       QCryptoCipherAlgo_str(gcm_test_data[i].alg));
+        }
+    }
+
     if (qcrypto_cipher_supports(QCRYPTO_CIPHER_ALGO_AES_256,
                                 QCRYPTO_CIPHER_MODE_CBC)) {
         g_test_add_func("/crypto/cipher/null-iv",
-- 
2.55.0


