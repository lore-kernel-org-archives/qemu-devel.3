Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCB2C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOb-0003cK-7x; Sun, 06 Sep 2026 13:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOZ-0003bW-50
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOX-000084-0k
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+FeAyS0syXOmtkvR5ptxrwn+UA6/cbFTp/D9zquVVM=;
 b=XpGHIXUyOA3iYl/5qBe37D5VSzm30HKNiT+FQzekhHAXP1DAuka2fs2a92hFAB0E3Zqk8s
 muR9XGFuaRiV0VgxwI7QswUwLX12GZRGGogsE8JrryLHc6L4BD3Xju3zSE8/32W/QEnBWh
 1ECTKXwbYJNez0Zl+jDlA4TQo2yNvK0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-T9f-ulkkNESA_jC3lF4cUQ-1; Sun,
 06 Sep 2026 13:11:00 -0400
X-MC-Unique: T9f-ulkkNESA_jC3lF4cUQ-1
X-Mimecast-MFC-AGG-ID: T9f-ulkkNESA_jC3lF4cUQ_1788714659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E1AF1801236; Sun,  6 Sep 2026 17:10:59 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96E6C1955F08; Sun,  6 Sep 2026 17:10:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/40] crypto/akcipher: Support ECDSA sign/verify with nettle
Date: Sun,  6 Sep 2026 19:09:55 +0200
Message-ID: <20260906171021.26568-15-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement ECDSA signing and verification for the nettle/hogweed backend,
for the prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves.
A public key (Qx || Qy) is loaded into an ecc_point for verify;
a private key (the scalar d) into an ecc_scalar for sign,
using nettle's ecdsa_sign() / ecdsa_verify().

The encrypt/decrypt driver ops return an error.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/akcipher-nettle.c.inc | 272 +++++++++++++++++++++++++++++++++++
 1 file changed, 272 insertions(+)

diff --git a/crypto/akcipher-nettle.c.inc b/crypto/akcipher-nettle.c.inc
index 1d4bd6960e08..a34845af5d11 100644
--- a/crypto/akcipher-nettle.c.inc
+++ b/crypto/akcipher-nettle.c.inc
@@ -20,6 +20,10 @@
  */
 
 #include <nettle/rsa.h>
+#include <nettle/ecdsa.h>
+#include <nettle/ecc-curve.h>
+#include <nettle/ecc.h>
+#include <nettle/bignum.h>
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
@@ -55,6 +59,12 @@ static QCryptoAkCipher *qcrypto_nettle_rsa_new(
     const uint8_t *key,  size_t keylen,
     Error **errp);
 
+static QCryptoAkCipher *qcrypto_nettle_ecdsa_new(
+    const QCryptoAkCipherOptionsECDSA *opt,
+    QCryptoAkCipherKeyType type,
+    const uint8_t *key,  size_t keylen,
+    Error **errp);
+
 QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
                                       QCryptoAkCipherKeyType type,
                                       const uint8_t *key, size_t keylen,
@@ -64,6 +74,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
     case QCRYPTO_AK_CIPHER_ALGO_RSA:
         return qcrypto_nettle_rsa_new(&opts->u.rsa, type, key, keylen, errp);
 
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:
+        return qcrypto_nettle_ecdsa_new(&opts->u.ecdsa, type, key, keylen,
+                                        errp);
+
     default:
         error_setg(errp, "Unsupported algorithm: %u", opts->alg);
         return NULL;
@@ -422,6 +436,254 @@ error:
 }
 
 
+/*
+ * ECDSA support (sign and verify)
+ *
+ * Keys and signatures use raw big-endian formats:
+ *   - public key: Qx || Qy, each 'coord_len' bytes
+ *   - private key: the scalar d, 'coord_len' bytes
+ *   - signature: r || s, each 'coord_len' bytes
+ *   - the input to sign/verify is a raw message digest
+ */
+typedef struct QCryptoNettleECDSA {
+    QCryptoAkCipher akcipher;
+    QCryptoAkCipherKeyType type;
+    struct ecc_point pub;
+    struct ecc_scalar priv;
+    QCryptoCurveID curve_id;
+} QCryptoNettleECDSA;
+
+static const struct ecc_curve *qcrypto_nettle_ecdsa_curve(
+    QCryptoCurveID curve_id)
+{
+    switch (curve_id) {
+    case QCRYPTO_CURVE_ID_PRIME256V1:
+        return nettle_get_secp_256r1();
+
+    case QCRYPTO_CURVE_ID_SECP384R1:
+        return nettle_get_secp_384r1();
+
+    default:
+        return NULL;
+    }
+}
+
+static size_t qcrypto_nettle_ecdsa_coord_len(QCryptoCurveID curve_id)
+{
+    switch (curve_id) {
+    case QCRYPTO_CURVE_ID_PRIME256V1:
+        return 32;
+
+    case QCRYPTO_CURVE_ID_SECP384R1:
+        return 48;
+
+    default:
+        return 0;
+    }
+}
+
+static void qcrypto_nettle_ecdsa_free(QCryptoAkCipher *akcipher)
+{
+    QCryptoNettleECDSA *ecdsa = (QCryptoNettleECDSA *)akcipher;
+    if (!ecdsa) {
+        return;
+    }
+
+    if (ecdsa->type == QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
+        ecc_scalar_clear(&ecdsa->priv);
+    } else {
+        ecc_point_clear(&ecdsa->pub);
+    }
+    g_free(ecdsa);
+}
+
+static int qcrypto_nettle_ecdsa_encrypt(QCryptoAkCipher *akcipher,
+                                        const void *in, size_t in_len,
+                                        void *out, size_t out_len,
+                                        Error **errp)
+{
+    error_setg(errp, "ECDSA does not support encryption");
+    return -1;
+}
+
+static int qcrypto_nettle_ecdsa_decrypt(QCryptoAkCipher *akcipher,
+                                        const void *in, size_t in_len,
+                                        void *out, size_t out_len,
+                                        Error **errp)
+{
+    error_setg(errp, "ECDSA does not support decryption");
+    return -1;
+}
+
+static int qcrypto_nettle_ecdsa_sign(QCryptoAkCipher *akcipher,
+                                     const void *in, size_t in_len,
+                                     void *out, size_t out_len,
+                                     Error **errp)
+{
+    QCryptoNettleECDSA *ecdsa = (QCryptoNettleECDSA *)akcipher;
+    size_t coord_len = qcrypto_nettle_ecdsa_coord_len(ecdsa->curve_id);
+    struct dsa_signature sig;
+
+    if (ecdsa->type != QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
+        error_setg(errp, "ECDSA sign requires a private key");
+        return -1;
+    }
+
+    if (in_len == 0 || in_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Invalid digest length %zu", in_len);
+        return -1;
+    }
+
+    if (out_len < coord_len * 2) {
+        error_setg(errp, "Signature buffer length %zu is less than %zu",
+                   out_len, coord_len * 2);
+        return -1;
+    }
+
+    dsa_signature_init(&sig);
+    ecdsa_sign(&ecdsa->priv, NULL, wrap_nettle_random_func, in_len, in, &sig);
+
+    /* output is r || s, each zero-padded to the curve size */
+    nettle_mpz_get_str_256(coord_len, out, sig.r);
+    nettle_mpz_get_str_256(coord_len, (uint8_t *)out + coord_len, sig.s);
+
+    dsa_signature_clear(&sig);
+    return coord_len * 2;
+}
+
+static int qcrypto_nettle_ecdsa_verify(QCryptoAkCipher *akcipher,
+                                       const void *in, size_t in_len,
+                                       const void *in2, size_t in2_len,
+                                       Error **errp)
+{
+    QCryptoNettleECDSA *ecdsa = (QCryptoNettleECDSA *)akcipher;
+    size_t coord_len = qcrypto_nettle_ecdsa_coord_len(ecdsa->curve_id);
+    struct dsa_signature sig;
+    int ret = -1;
+
+    if (ecdsa->type != QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC) {
+        error_setg(errp, "ECDSA verify requires a public key");
+        return ret;
+    }
+
+    /* signature is r || s */
+    if (in_len != coord_len * 2) {
+        error_setg(errp, "Signature length %zu is not %zu",
+                   in_len, coord_len * 2);
+        return ret;
+    }
+
+    if (in2_len == 0 || in2_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Invalid digest length %zu", in2_len);
+        return ret;
+    }
+
+    dsa_signature_init(&sig);
+    nettle_mpz_set_str_256_u(sig.r, coord_len, in);
+    nettle_mpz_set_str_256_u(sig.s, coord_len, (const uint8_t *)in + coord_len);
+
+    if (ecdsa_verify(&ecdsa->pub, in2_len, in2, &sig) == 1) {
+        ret = 0;
+    } else {
+        error_setg(errp, "Failed to verify signature");
+    }
+
+    dsa_signature_clear(&sig);
+    return ret;
+}
+
+QCryptoAkCipherDriver nettle_ecdsa = {
+    .encrypt = qcrypto_nettle_ecdsa_encrypt,
+    .decrypt = qcrypto_nettle_ecdsa_decrypt,
+    .sign = qcrypto_nettle_ecdsa_sign,
+    .verify = qcrypto_nettle_ecdsa_verify,
+    .free = qcrypto_nettle_ecdsa_free,
+};
+
+static QCryptoAkCipher *qcrypto_nettle_ecdsa_new(
+    const QCryptoAkCipherOptionsECDSA *opt,
+    QCryptoAkCipherKeyType type,
+    const uint8_t *key, size_t keylen,
+    Error **errp)
+{
+    QCryptoNettleECDSA *ecdsa;
+    const struct ecc_curve *curve = qcrypto_nettle_ecdsa_curve(opt->curve_id);
+    size_t coord_len = qcrypto_nettle_ecdsa_coord_len(opt->curve_id);
+    mpz_t x;
+    mpz_t y;
+
+    if (!curve || coord_len == 0) {
+        error_setg(errp, "Unsupported curve id: %u", opt->curve_id);
+        return NULL;
+    }
+
+    switch (type) {
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
+        if (keylen != coord_len * 2) {
+            error_setg(errp, "Public key length %zu is not %zu",
+                       keylen, coord_len * 2);
+            return NULL;
+        }
+        break;
+
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
+        if (keylen != coord_len) {
+            error_setg(errp, "Private key length %zu is not %zu",
+                       keylen, coord_len);
+            return NULL;
+        }
+        break;
+
+    default:
+        error_setg(errp, "Unknown akcipher key type %d", type);
+        return NULL;
+    }
+
+    ecdsa = g_new0(QCryptoNettleECDSA, 1);
+    ecdsa->akcipher.driver = &nettle_ecdsa;
+    ecdsa->type = type;
+    ecdsa->curve_id = opt->curve_id;
+    ecdsa->akcipher.max_dgst_len = coord_len;
+    ecdsa->akcipher.max_signature_len = coord_len * 2;
+
+    if (type == QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC) {
+        /* public key: Qx || Qy */
+        ecc_point_init(&ecdsa->pub, curve);
+        mpz_init(x);
+        mpz_init(y);
+        nettle_mpz_set_str_256_u(x, coord_len, key);
+        nettle_mpz_set_str_256_u(y, coord_len,
+                                 (const uint8_t *)key + coord_len);
+
+        if (!ecc_point_set(&ecdsa->pub, x, y)) {
+            error_setg(errp, "Invalid ECDSA public key (not on curve)");
+            mpz_clear(x);
+            mpz_clear(y);
+            qcrypto_nettle_ecdsa_free((QCryptoAkCipher *)ecdsa);
+            return NULL;
+        }
+
+        mpz_clear(x);
+        mpz_clear(y);
+    } else {
+        /* private key: the scalar d */
+        ecc_scalar_init(&ecdsa->priv, curve);
+        mpz_init(x);
+        nettle_mpz_set_str_256_u(x, coord_len, key);
+
+        if (!ecc_scalar_set(&ecdsa->priv, x)) {
+            error_setg(errp, "Invalid ECDSA private key");
+            mpz_clear(x);
+            qcrypto_nettle_ecdsa_free((QCryptoAkCipher *)ecdsa);
+            return NULL;
+        }
+
+        mpz_clear(x);
+    }
+
+    return (QCryptoAkCipher *)ecdsa;
+}
+
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
 {
     switch (opts->alg) {
@@ -445,6 +707,16 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
         }
         break;
 
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:
+        switch (opts->u.ecdsa.curve_id) {
+        case QCRYPTO_CURVE_ID_PRIME256V1:
+        case QCRYPTO_CURVE_ID_SECP384R1:
+            return true;
+
+        default:
+            return false;
+        }
+
     default:
         return false;
     }
-- 
2.55.0


