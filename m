Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DF7C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOY-0003b9-EP; Sun, 06 Sep 2026 13:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOX-0003a6-90
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOS-00007I-7p
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2xDjaM6J9uNyS4YUNdsZwx0xDl4hHxy+7Vz0WhHi9vA=;
 b=ekiQGwWXTGKdt8/hwpQ98amzaHwT6RcQNxojMF+E4a6pMkBf9IVlvU8hL5QDIcZzCFcinY
 QgsfRNOkY9y9JWdXKsvcB7yAPDML1mVcZacMIKEr7NNSiKkmfD6LpBSaefaFJm2ca0m1M3
 p8RZ/25f3wZxuoDKzp40uLhoI9JYlMU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-YSkluRGONZ2Y8KOCROMGYQ-1; Sun,
 06 Sep 2026 13:10:58 -0400
X-MC-Unique: YSkluRGONZ2Y8KOCROMGYQ-1
X-Mimecast-MFC-AGG-ID: YSkluRGONZ2Y8KOCROMGYQ_1788714657
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29BFB18011EC; Sun,  6 Sep 2026 17:10:57 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83FF51955F06; Sun,  6 Sep 2026 17:10:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/40] crypto/akcipher: Support ECDSA sign/verify with gcrypt
Date: Sun,  6 Sep 2026 19:09:54 +0200
Message-ID: <20260906171021.26568-14-clg@redhat.com>
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

Implement ECDSA signing and verification for the gcrypt backend, for the
prime256v1 (NIST P-256) and secp384r1 (NIST P-384) curves. The
encrypt/decrypt driver ops return an error, as ECDSA is a signature
algorithm. The public key is provided as the raw affine coordinates
Qx || Qy, the private key as the raw scalar d, and the signature as the
raw pair r || s (each half the curve size, big-endian); the input to
sign/verify is a pre-computed message digest.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/akcipher-gcrypt.c.inc | 340 ++++++++++++++++++++++++++++++++++-
 1 file changed, 339 insertions(+), 1 deletion(-)

diff --git a/crypto/akcipher-gcrypt.c.inc b/crypto/akcipher-gcrypt.c.inc
index bcf030fdec45..3e49cc150849 100644
--- a/crypto/akcipher-gcrypt.c.inc
+++ b/crypto/akcipher-gcrypt.c.inc
@@ -36,6 +36,13 @@ typedef struct QCryptoGcryptRSA {
     QCryptoHashAlgo hash_alg;
 } QCryptoGcryptRSA;
 
+typedef struct QCryptoGcryptECDSA {
+    QCryptoAkCipher akcipher;
+    QCryptoAkCipherKeyType type;
+    gcry_sexp_t key;
+    QCryptoCurveID curve_id;
+} QCryptoGcryptECDSA;
+
 static void qcrypto_gcrypt_rsa_free(QCryptoAkCipher *akcipher)
 {
     QCryptoGcryptRSA *rsa = (QCryptoGcryptRSA *)akcipher;
@@ -53,6 +60,12 @@ static QCryptoGcryptRSA *qcrypto_gcrypt_rsa_new(
     const uint8_t *key,  size_t keylen,
     Error **errp);
 
+static QCryptoGcryptECDSA *qcrypto_gcrypt_ecdsa_new(
+    const QCryptoAkCipherOptionsECDSA *opt,
+    QCryptoAkCipherKeyType type,
+    const uint8_t *key,  size_t keylen,
+    Error **errp);
+
 QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
                                       QCryptoAkCipherKeyType type,
                                       const uint8_t *key, size_t keylen,
@@ -63,6 +76,10 @@ QCryptoAkCipher *qcrypto_akcipher_new(const QCryptoAkCipherOptions *opts,
         return (QCryptoAkCipher *)qcrypto_gcrypt_rsa_new(
             &opts->u.rsa, type, key, keylen, errp);
 
+    case QCRYPTO_AK_CIPHER_ALGO_ECDSA:
+        return (QCryptoAkCipher *)qcrypto_gcrypt_ecdsa_new(
+            &opts->u.ecdsa, type, key, keylen, errp);
+
     default:
         error_setg(errp, "Unsupported algorithm: %u", opts->alg);
         return NULL;
@@ -565,6 +582,317 @@ error:
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
+static const char *qcrypto_gcrypt_ecdsa_curve_name(QCryptoCurveID curve_id)
+{
+    switch (curve_id) {
+    case QCRYPTO_CURVE_ID_PRIME256V1:
+        return "NIST P-256";
+
+    case QCRYPTO_CURVE_ID_SECP384R1:
+        return "NIST P-384";
+
+    default:
+        return NULL;
+    }
+}
+
+static size_t qcrypto_gcrypt_ecdsa_coord_len(QCryptoCurveID curve_id)
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
+static void qcrypto_gcrypt_ecdsa_free(QCryptoAkCipher *akcipher)
+{
+    QCryptoGcryptECDSA *ecdsa = (QCryptoGcryptECDSA *)akcipher;
+    if (!ecdsa) {
+        return;
+    }
+
+    gcry_sexp_release(ecdsa->key);
+    g_free(ecdsa);
+}
+
+static int qcrypto_gcrypt_ecdsa_encrypt(QCryptoAkCipher *akcipher,
+                                        const void *in, size_t in_len,
+                                        void *out, size_t out_len,
+                                        Error **errp)
+{
+    error_setg(errp, "ECDSA does not support encryption");
+    return -1;
+}
+
+static int qcrypto_gcrypt_ecdsa_decrypt(QCryptoAkCipher *akcipher,
+                                        const void *in, size_t in_len,
+                                        void *out, size_t out_len,
+                                        Error **errp)
+{
+    error_setg(errp, "ECDSA does not support decryption");
+    return -1;
+}
+
+/*
+ * Write an MPI into a fixed-length, big-endian, left-zero-padded buffer.
+ *
+ * gcry_mpi_print(GCRYMPI_FMT_USG) emits only the minimal number of bytes (it
+ * drops leading zeros), but an ECDSA r/s component must occupy exactly the
+ * curve size. Zero-fill the leading bytes and right-align the value, so a
+ * component whose most significant byte is zero still lands at the correct
+ * offset in the r || s output.
+ *
+ * Returns -1 if the value does not fit in 'len' bytes.
+ */
+static int qcrypto_gcrypt_mpi_to_buf(gcry_mpi_t mpi, uint8_t *buf, size_t len)
+{
+    size_t nbytes = (gcry_mpi_get_nbits(mpi) + 7) / 8;
+
+    if (nbytes > len) {
+        return -1;
+    }
+    memset(buf, 0, len - nbytes);
+    gcry_mpi_print(GCRYMPI_FMT_USG, buf + (len - nbytes), nbytes, NULL, mpi);
+    return 0;
+}
+
+static int qcrypto_gcrypt_ecdsa_sign(QCryptoAkCipher *akcipher,
+                                     const void *in, size_t in_len,
+                                     void *out, size_t out_len,
+                                     Error **errp)
+{
+    QCryptoGcryptECDSA *ecdsa = (QCryptoGcryptECDSA *)akcipher;
+    size_t coord_len = qcrypto_gcrypt_ecdsa_coord_len(ecdsa->curve_id);
+    gcry_sexp_t dgst_sexp = NULL;
+    gcry_sexp_t sig_sexp = NULL;
+    gcry_sexp_t r_sexp = NULL;
+    gcry_sexp_t s_sexp = NULL;
+    gcry_mpi_t r_mpi = NULL;
+    gcry_mpi_t s_mpi = NULL;
+    gcry_error_t err;
+    int ret = -1;
+
+    if (ecdsa->type != QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE) {
+        error_setg(errp, "ECDSA sign requires a private key");
+        return ret;
+    }
+
+    if (in_len == 0 || in_len > akcipher->max_dgst_len) {
+        error_setg(errp, "Invalid digest length %zu", in_len);
+        return ret;
+    }
+
+    if (out_len < coord_len * 2) {
+        error_setg(errp, "Signature buffer length %zu is less than %zu",
+                   out_len, coord_len * 2);
+        return ret;
+    }
+
+    err = gcry_sexp_build(&dgst_sexp, NULL,
+                          "(data (flags raw) (value %b))",
+                          (int)in_len, in);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build digest: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_pk_sign(&sig_sexp, dgst_sexp, ecdsa->key);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to make signature: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    /* S-expression of signature: (sig-val (ecdsa (r r-mpi) (s s-mpi))) */
+    r_sexp = gcry_sexp_find_token(sig_sexp, "r", 0);
+    s_sexp = gcry_sexp_find_token(sig_sexp, "s", 0);
+    if (!r_sexp || !s_sexp) {
+        error_setg(errp, "Invalid signature result");
+        goto cleanup;
+    }
+    r_mpi = gcry_sexp_nth_mpi(r_sexp, 1, GCRYMPI_FMT_USG);
+    s_mpi = gcry_sexp_nth_mpi(s_sexp, 1, GCRYMPI_FMT_USG);
+    if (!r_mpi || !s_mpi) {
+        error_setg(errp, "Invalid signature result");
+        goto cleanup;
+    }
+
+    /* output is r || s, each zero-padded to the curve size */
+    if (qcrypto_gcrypt_mpi_to_buf(r_mpi, out, coord_len) < 0 ||
+        qcrypto_gcrypt_mpi_to_buf(s_mpi, (uint8_t *)out + coord_len,
+                                  coord_len) < 0) {
+        error_setg(errp, "Signature component is too large");
+        goto cleanup;
+    }
+    ret = coord_len * 2;
+
+cleanup:
+    gcry_sexp_release(dgst_sexp);
+    gcry_sexp_release(sig_sexp);
+    gcry_sexp_release(r_sexp);
+    gcry_sexp_release(s_sexp);
+    gcry_mpi_release(r_mpi);
+    gcry_mpi_release(s_mpi);
+    return ret;
+}
+
+static int qcrypto_gcrypt_ecdsa_verify(QCryptoAkCipher *akcipher,
+                                       const void *in, size_t in_len,
+                                       const void *in2, size_t in2_len,
+                                       Error **errp)
+{
+    QCryptoGcryptECDSA *ecdsa = (QCryptoGcryptECDSA *)akcipher;
+    size_t coord_len = qcrypto_gcrypt_ecdsa_coord_len(ecdsa->curve_id);
+    gcry_sexp_t sig_sexp = NULL;
+    gcry_sexp_t dgst_sexp = NULL;
+    gcry_error_t err;
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
+    err = gcry_sexp_build(&sig_sexp, NULL,
+                          "(sig-val (ecdsa (r %b) (s %b)))",
+                          (int)coord_len, in,
+                          (int)coord_len, (const uint8_t *)in + coord_len);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build signature: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_sexp_build(&dgst_sexp, NULL,
+                          "(data (flags raw) (value %b))",
+                          (int)in2_len, in2);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build digest: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+
+    err = gcry_pk_verify(sig_sexp, dgst_sexp, ecdsa->key);
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to verify signature: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto cleanup;
+    }
+    ret = 0;
+
+cleanup:
+    gcry_sexp_release(sig_sexp);
+    gcry_sexp_release(dgst_sexp);
+    return ret;
+}
+
+QCryptoAkCipherDriver gcrypt_ecdsa = {
+    .encrypt = qcrypto_gcrypt_ecdsa_encrypt,
+    .decrypt = qcrypto_gcrypt_ecdsa_decrypt,
+    .sign = qcrypto_gcrypt_ecdsa_sign,
+    .verify = qcrypto_gcrypt_ecdsa_verify,
+    .free = qcrypto_gcrypt_ecdsa_free,
+};
+
+static QCryptoGcryptECDSA *qcrypto_gcrypt_ecdsa_new(
+    const QCryptoAkCipherOptionsECDSA *opt,
+    QCryptoAkCipherKeyType type,
+    const uint8_t *key, size_t keylen,
+    Error **errp)
+{
+    QCryptoGcryptECDSA *ecdsa;
+    const char *curve_name = qcrypto_gcrypt_ecdsa_curve_name(opt->curve_id);
+    size_t coord_len = qcrypto_gcrypt_ecdsa_coord_len(opt->curve_id);
+    g_autofree uint8_t *point = NULL;
+    gcry_error_t err;
+
+    if (!curve_name || coord_len == 0) {
+        error_setg(errp, "Unsupported curve id: %u", opt->curve_id);
+        return NULL;
+    }
+
+    ecdsa = g_new0(QCryptoGcryptECDSA, 1);
+    ecdsa->akcipher.driver = &gcrypt_ecdsa;
+    ecdsa->type = type;
+    ecdsa->curve_id = opt->curve_id;
+    ecdsa->akcipher.max_dgst_len = coord_len;
+    ecdsa->akcipher.max_signature_len = coord_len * 2;
+
+    switch (type) {
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PUBLIC:
+        /* public key: Qx || Qy */
+        if (keylen != coord_len * 2) {
+            error_setg(errp, "Public key length %zu is not %zu",
+                       keylen, coord_len * 2);
+            goto error;
+        }
+        /* build uncompressed EC point: 0x04 || Qx || Qy */
+        point = g_malloc(1 + keylen);
+        point[0] = 0x04;
+        memcpy(point + 1, key, keylen);
+        err = gcry_sexp_build(&ecdsa->key, NULL,
+                              "(public-key (ecc (curve %s) (q %b)))",
+                              curve_name, (int)(1 + keylen), point);
+        break;
+
+    case QCRYPTO_AK_CIPHER_KEY_TYPE_PRIVATE:
+        /* private key: the scalar d */
+        if (keylen != coord_len) {
+            error_setg(errp, "Private key length %zu is not %zu",
+                       keylen, coord_len);
+            goto error;
+        }
+        err = gcry_sexp_build(&ecdsa->key, NULL,
+                              "(private-key (ecc (curve %s) (d %b)))",
+                              curve_name, (int)keylen, key);
+        break;
+
+    default:
+        error_setg(errp, "Unknown akcipher key type %d", type);
+        goto error;
+    }
+
+    if (gcry_err_code(err) != 0) {
+        error_setg(errp, "Failed to build ECDSA key: %s/%s",
+                   gcry_strsource(err), gcry_strerror(err));
+        goto error;
+    }
+
+    return ecdsa;
+
+error:
+    qcrypto_gcrypt_ecdsa_free((QCryptoAkCipher *)ecdsa);
+    return NULL;
+}
+
 bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
 {
     switch (opts->alg) {
@@ -589,7 +917,17 @@ bool qcrypto_akcipher_supports(QCryptoAkCipherOptions *opts)
             return false;
         }
 
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
-        return true;
+        return false;
     }
 }
-- 
2.55.0


