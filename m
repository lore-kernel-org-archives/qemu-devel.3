Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C40CC79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOo-0003fp-PR; Sun, 06 Sep 2026 13:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOb-0003cN-2v
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOX-00008D-0z
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/S0gg6ay167kYCj0XMl5BuMQ33oL89MBoeWbHslaVQI=;
 b=dgqGPFU4bjYDkw3zJ+Bg+/t7eI5c8rQxvK2rbpBpUYXmHCZQyAMDXUpZWTkPyG8fb3phdZ
 kDCR+NXBd1V0o4/ZtMyEZyfDrR9vUSI8bN3rST23sfp2Y1Gnb0ZZySBMcotQSD8YVM/RxN
 BKsJZ4oXwz6qZ+k8V91AbynvHPzi57k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-OLURm2_FN52K12eiW46uag-1; Sun,
 06 Sep 2026 13:11:02 -0400
X-MC-Unique: OLURm2_FN52K12eiW46uag-1
X-Mimecast-MFC-AGG-ID: OLURm2_FN52K12eiW46uag_1788714661
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 963531954238; Sun,  6 Sep 2026 17:11:01 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA7ED1955F06; Sun,  6 Sep 2026 17:10:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/40] tests/crypto: Add ECDSA sign/verify tests
Date: Sun,  6 Sep 2026 19:09:56 +0200
Message-ID: <20260906171021.26568-16-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add unit tests for ECDSA prime256v1 and secp384r1, using the
RFC 6979 (Deterministic ECDSA) "sample" known-answer vectors. The same
key pair drives the verify test (against the RFC's known signature) and
the sign test, which signs the digest with the private key and checks
that the result verifies with the public key. Each test skips
(g_test_skip) when the crypto backend does not support ECDSA, via
qcrypto_akcipher_supports().

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/unit/test-crypto-akcipher.c | 236 ++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/tests/unit/test-crypto-akcipher.c b/tests/unit/test-crypto-akcipher.c
index 53c2211ba8ea..fb1a6163e926 100644
--- a/tests/unit/test-crypto-akcipher.c
+++ b/tests/unit/test-crypto-akcipher.c
@@ -658,6 +658,117 @@ static const uint8_t rsa_public_key_extra_elem[] = {
     0x02, 0x06, 0xe1, 0x22, 0xdb, 0xe1, 0x22, 0xdb,
 };
 
+/*
+ * ECDSA known-answer vectors from RFC 6979 (Deterministic ECDSA), message
+ * "sample", decoded into raw big-endian form. The same key pair drives both
+ * the verify test (against the RFC's known signature) and the sign round-trip
+ * test:
+ *   - private key: the scalar d (curve size)
+ *   - public key: Qx || Qy (2 * curve size)
+ *   - dgst: the message digest (curve size)
+ *   - signature: r || s (2 * curve size)
+ *
+ * prime256v1 / SHA-256 (RFC 6979 A.2.5):
+ */
+static const uint8_t ecdsa_p256_privkey[32] = {
+    0xc9, 0xaf, 0xa9, 0xd8, 0x45, 0xba, 0x75, 0x16,
+    0x6b, 0x5c, 0x21, 0x57, 0x67, 0xb1, 0xd6, 0x93,
+    0x4e, 0x50, 0xc3, 0xdb, 0x36, 0xe8, 0x9b, 0x12,
+    0x7b, 0x8a, 0x62, 0x2b, 0x12, 0x0f, 0x67, 0x21,
+};
+
+static const uint8_t ecdsa_p256_pubkey[64] = {
+    0x60, 0xfe, 0xd4, 0xba, 0x25, 0x5a, 0x9d, 0x31,
+    0xc9, 0x61, 0xeb, 0x74, 0xc6, 0x35, 0x6d, 0x68,
+    0xc0, 0x49, 0xb8, 0x92, 0x3b, 0x61, 0xfa, 0x6c,
+    0xe6, 0x69, 0x62, 0x2e, 0x60, 0xf2, 0x9f, 0xb6,
+    0x79, 0x03, 0xfe, 0x10, 0x08, 0xb8, 0xbc, 0x99,
+    0xa4, 0x1a, 0xe9, 0xe9, 0x56, 0x28, 0xbc, 0x64,
+    0xf2, 0xf1, 0xb2, 0x0c, 0x2d, 0x7e, 0x9f, 0x51,
+    0x77, 0xa3, 0xc2, 0x94, 0xd4, 0x46, 0x22, 0x99,
+};
+
+static const uint8_t ecdsa_p256_dgst[32] = {
+    0xaf, 0x2b, 0xdb, 0xe1, 0xaa, 0x9b, 0x6e, 0xc1,
+    0xe2, 0xad, 0xe1, 0xd6, 0x94, 0xf4, 0x1f, 0xc7,
+    0x1a, 0x83, 0x1d, 0x02, 0x68, 0xe9, 0x89, 0x15,
+    0x62, 0x11, 0x3d, 0x8a, 0x62, 0xad, 0xd1, 0xbf,
+};
+
+static const uint8_t ecdsa_p256_signature[64] = {
+    0xef, 0xd4, 0x8b, 0x2a, 0xac, 0xb6, 0xa8, 0xfd,
+    0x11, 0x40, 0xdd, 0x9c, 0xd4, 0x5e, 0x81, 0xd6,
+    0x9d, 0x2c, 0x87, 0x7b, 0x56, 0xaa, 0xf9, 0x91,
+    0xc3, 0x4d, 0x0e, 0xa8, 0x4e, 0xaf, 0x37, 0x16,
+    0xf7, 0xcb, 0x1c, 0x94, 0x2d, 0x65, 0x7c, 0x41,
+    0xd4, 0x36, 0xc7, 0xa1, 0xb6, 0xe2, 0x9f, 0x65,
+    0xf3, 0xe9, 0x00, 0xdb, 0xb9, 0xaf, 0xf4, 0x06,
+    0x4d, 0xc4, 0xab, 0x2f, 0x84, 0x3a, 0xcd, 0xa8,
+};
+
+/* secp384r1 / SHA-384 (RFC 6979 A.2.6): */
+static const uint8_t ecdsa_p384_privkey[48] = {
+    0x6b, 0x9d, 0x3d, 0xad, 0x2e, 0x1b, 0x8c, 0x1c,
+    0x05, 0xb1, 0x98, 0x75, 0xb6, 0x65, 0x9f, 0x4d,
+    0xe2, 0x3c, 0x3b, 0x66, 0x7b, 0xf2, 0x97, 0xba,
+    0x9a, 0xa4, 0x77, 0x40, 0x78, 0x71, 0x37, 0xd8,
+    0x96, 0xd5, 0x72, 0x4e, 0x4c, 0x70, 0xa8, 0x25,
+    0xf8, 0x72, 0xc9, 0xea, 0x60, 0xd2, 0xed, 0xf5,
+};
+
+static const uint8_t ecdsa_p384_pubkey[96] = {
+    0xec, 0x3a, 0x4e, 0x41, 0x5b, 0x4e, 0x19, 0xa4,
+    0x56, 0x86, 0x18, 0x02, 0x9f, 0x42, 0x7f, 0xa5,
+    0xda, 0x9a, 0x8b, 0xc4, 0xae, 0x92, 0xe0, 0x2e,
+    0x06, 0xaa, 0xe5, 0x28, 0x6b, 0x30, 0x0c, 0x64,
+    0xde, 0xf8, 0xf0, 0xea, 0x90, 0x55, 0x86, 0x60,
+    0x64, 0xa2, 0x54, 0x51, 0x54, 0x80, 0xbc, 0x13,
+    0x80, 0x15, 0xd9, 0xb7, 0x2d, 0x7d, 0x57, 0x24,
+    0x4e, 0xa8, 0xef, 0x9a, 0xc0, 0xc6, 0x21, 0x89,
+    0x67, 0x08, 0xa5, 0x93, 0x67, 0xf9, 0xdf, 0xb9,
+    0xf5, 0x4c, 0xa8, 0x4b, 0x3f, 0x1c, 0x9d, 0xb1,
+    0x28, 0x8b, 0x23, 0x1c, 0x3a, 0xe0, 0xd4, 0xfe,
+    0x73, 0x44, 0xfd, 0x25, 0x33, 0x26, 0x47, 0x20,
+};
+
+static const uint8_t ecdsa_p384_dgst[48] = {
+    0x9a, 0x90, 0x83, 0x50, 0x5b, 0xc9, 0x22, 0x76,
+    0xae, 0xc4, 0xbe, 0x31, 0x26, 0x96, 0xef, 0x7b,
+    0xf3, 0xbf, 0x60, 0x3f, 0x4b, 0xbd, 0x38, 0x11,
+    0x96, 0xa0, 0x29, 0xf3, 0x40, 0x58, 0x53, 0x12,
+    0x31, 0x3b, 0xca, 0x4a, 0x9b, 0x5b, 0x89, 0x0e,
+    0xfe, 0xe4, 0x2c, 0x77, 0xb1, 0xee, 0x25, 0xfe,
+};
+
+static const uint8_t ecdsa_p384_signature[96] = {
+    0x94, 0xed, 0xbb, 0x92, 0xa5, 0xec, 0xb8, 0xaa,
+    0xd4, 0x73, 0x6e, 0x56, 0xc6, 0x91, 0x91, 0x6b,
+    0x3f, 0x88, 0x14, 0x06, 0x66, 0xce, 0x9f, 0xa7,
+    0x3d, 0x64, 0xc4, 0xea, 0x95, 0xad, 0x13, 0x3c,
+    0x81, 0xa6, 0x48, 0x15, 0x2e, 0x44, 0xac, 0xf9,
+    0x6e, 0x36, 0xdd, 0x1e, 0x80, 0xfa, 0xbe, 0x46,
+    0x99, 0xef, 0x4a, 0xeb, 0x15, 0xf1, 0x78, 0xce,
+    0xa1, 0xfe, 0x40, 0xdb, 0x26, 0x03, 0x13, 0x8f,
+    0x13, 0x0e, 0x74, 0x0a, 0x19, 0x62, 0x45, 0x26,
+    0x20, 0x3b, 0x63, 0x51, 0xd0, 0xa3, 0xa9, 0x4f,
+    0xa3, 0x29, 0xc1, 0x45, 0x78, 0x6e, 0x67, 0x9e,
+    0x7b, 0x82, 0xc7, 0x1a, 0x38, 0x62, 0x8a, 0xc8,
+};
+
+typedef struct QCryptoECDSATestData QCryptoECDSATestData;
+struct QCryptoECDSATestData {
+    const char *path;
+    QCryptoCurveID curve_id;
+    const uint8_t *priv_key;
+    size_t priv_key_len;
+    const uint8_t *pub_key;
+    size_t pub_key_len;
+    const uint8_t *dgst;
+    size_t dlen;
+    const uint8_t *signature;
+    size_t slen;
+};
+
 typedef struct QCryptoRSAKeyTestData QCryptoRSAKeyTestData;
 struct QCryptoRSAKeyTestData {
     const char *path;
@@ -969,6 +1080,120 @@ static void test_rsakey(const void *opaque)
     g_assert(qcrypto_akcipher_max_dgst_len(key) == data->exp_key_len);
 }
 
+static QCryptoECDSATestData ecdsa_test_data[] = {
+    {
+        .path = "/crypto/akcipher/ecdsa-prime256v1",
+        .curve_id = QCRYPTO_CURVE_ID_PRIME256V1,
+        .priv_key = ecdsa_p256_privkey,
+        .priv_key_len = sizeof(ecdsa_p256_privkey),
+        .pub_key = ecdsa_p256_pubkey,
+        .pub_key_len = sizeof(ecdsa_p256_pubkey),
+        .dgst = ecdsa_p256_dgst,
+        .dlen = sizeof(ecdsa_p256_dgst),
+        .signature = ecdsa_p256_signature,
+        .slen = sizeof(ecdsa_p256_signature),
+    },
+    {
+        .path = "/crypto/akcipher/ecdsa-secp384r1",
+        .curve_id = QCRYPTO_CURVE_ID_SECP384R1,
+        .priv_key = ecdsa_p384_privkey,
+        .priv_key_len = sizeof(ecdsa_p384_privkey),
+        .pub_key = ecdsa_p384_pubkey,
+        .pub_key_len = sizeof(ecdsa_p384_pubkey),
+        .dgst = ecdsa_p384_dgst,
+        .dlen = sizeof(ecdsa_p384_dgst),
+        .signature = ecdsa_p384_signature,
+        .slen = sizeof(ecdsa_p384_signature),
+    },
+    /* Add more curves here as they gain backend support. */
+};
+
+static void test_ecdsa_verify(const void *opaque)
+{
+    const QCryptoECDSATestData *data = opaque;
+    QCryptoAkCipherOptions opt = {
+        .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
+        .u.ecdsa = {
+            .curve_id = data->curve_id,
+        },
+    };
+    g_autoptr(QCryptoAkCipher) pub_key = NULL;
+    g_autofree uint8_t *signature = NULL;
+    g_autofree uint8_t *dgst = NULL;
+
+    if (!qcrypto_akcipher_supports(&opt)) {
+        g_test_skip("ECDSA is not supported by the crypto backend");
+        return;
+    }
+
+    pub_key = qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
+                                   data->pub_key, data->pub_key_len,
+                                   &error_abort);
+    g_assert(pub_key != NULL);
+    g_assert(qcrypto_akcipher_max_signature_len(pub_key) == data->slen);
+    g_assert(qcrypto_akcipher_max_dgst_len(pub_key) == data->dlen);
+
+    /* A valid signature must verify. */
+    g_assert(qcrypto_akcipher_verify(pub_key, data->signature, data->slen,
+                                     data->dgst, data->dlen,
+                                     &error_abort) == 0);
+
+    /* A tampered signature must fail (error is expected, so ignore it). */
+    signature = g_memdup2(data->signature, data->slen);
+    signature[0]++;
+    g_assert(qcrypto_akcipher_verify(pub_key, signature, data->slen,
+                                     data->dgst, data->dlen, NULL) != 0);
+
+    /* A tampered digest must also fail. */
+    dgst = g_memdup2(data->dgst, data->dlen);
+    dgst[0]++;
+    g_assert(qcrypto_akcipher_verify(pub_key, data->signature, data->slen,
+                                     dgst, data->dlen, NULL) != 0);
+}
+
+static void test_ecdsa_sign(const void *opaque)
+{
+    const QCryptoECDSATestData *data = opaque;
+    QCryptoAkCipherOptions opt = {
+        .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
+        .u.ecdsa = {
+            .curve_id = data->curve_id,
+        },
+    };
+    g_autoptr(QCryptoAkCipher) priv_key = NULL;
+    g_autoptr(QCryptoAkCipher) pub_key = NULL;
+    g_autofree uint8_t *signature = NULL;
+    int slen;
+
+    if (!qcrypto_akcipher_supports(&opt)) {
+        g_test_skip("ECDSA is not supported by the crypto backend");
+        return;
+    }
+
+    priv_key = qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE,
+                                    data->priv_key, data->priv_key_len,
+                                    &error_abort);
+    g_assert(priv_key != NULL);
+
+    /*
+     * Sign the digest.
+     * ECDSA signatures are randomized so only length is fixed.
+     */
+    slen = qcrypto_akcipher_max_signature_len(priv_key);
+    signature = g_new0(uint8_t, slen);
+    g_assert(qcrypto_akcipher_sign(priv_key, data->dgst, data->dlen,
+                                   signature, slen, &error_abort) == slen);
+
+    /* The freshly produced signature must verify with the public key. */
+    pub_key = qcrypto_akcipher_new(&opt, QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC,
+                                   data->pub_key, data->pub_key_len,
+                                   &error_abort);
+    g_assert(pub_key != NULL);
+    g_assert(qcrypto_akcipher_verify(pub_key, signature, slen,
+                                     data->dgst, data->dlen,
+                                     &error_abort) == 0);
+}
+
 int main(int argc, char **argv)
 {
     size_t i;
@@ -985,6 +1210,17 @@ int main(int argc, char **argv)
                              &rsakey_test_data[i],
                              test_rsakey);
     }
+    for (i = 0; i < G_N_ELEMENTS(ecdsa_test_data); i++) {
+        g_autofree char *verify_path =
+            g_strdup_printf("%s-verify", ecdsa_test_data[i].path);
+        g_autofree char *sign_path =
+            g_strdup_printf("%s-sign", ecdsa_test_data[i].path);
+
+        g_test_add_data_func(verify_path, &ecdsa_test_data[i],
+                             test_ecdsa_verify);
+        g_test_add_data_func(sign_path, &ecdsa_test_data[i],
+                             test_ecdsa_sign);
+    }
 
     return g_test_run();
 }
-- 
2.55.0


