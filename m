Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080E9C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPS-0006F6-7D; Tue, 11 Aug 2026 12:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP7-0005aD-RU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP5-00014b-AV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V86vy0lkjWuWAmUpjwhu7w5xNlRA7tuExSlckQmhD94=;
 b=e+zBOid7YTZp7YM/3YIa0kWWUv5fBb6a8GAY8OXYQkuzZjX+u+bK7raHbK+L0XqEJMylAV
 EW5jTR8nN6OWRA1uYbAJzkLy+NKCWtrVnULNGThw7i6uNawk2BvwM+Gj9zcC8whfYXZF8a
 v32qiFWW4s1NxUl4VQ4e8t/DxGbpw1E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-Rt6HJnG8PVm2V6LdQafbOQ-1; Tue,
 11 Aug 2026 12:32:29 -0400
X-MC-Unique: Rt6HJnG8PVm2V6LdQafbOQ-1
X-Mimecast-MFC-AGG-ID: Rt6HJnG8PVm2V6LdQafbOQ_1786465948
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43910180034C; Tue, 11 Aug 2026 16:32:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F128195DF91; Tue, 11 Aug 2026 16:32:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 77/83] crypto/cipher-nettle: Implement AES-GCM
Date: Tue, 11 Aug 2026 18:29:32 +0200
Message-ID: <20260811162938.1403216-78-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the AES-GCM AEAD mode to the nettle backend so it is available when
QEMU is built with nettle instead of gcrypt. GCM is driven through
nettle's generic gcm_* interface, using the AES encrypt function for both
directions: gcm_set_iv() sets the (typically 96-bit) nonce, gcm_update()
feeds the associated data, gcm_encrypt()/gcm_decrypt() need not be block
aligned, and gcm_digest() produces the authentication tag.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/cipher-nettle.c.inc | 128 +++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index 1afdc391b49b..d4847f0efeee 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -27,6 +27,7 @@
 #include <nettle/twofish.h>
 #include <nettle/ctr.h>
 #include <nettle/xts.h>
+#include <nettle/gcm.h>
 #ifdef CONFIG_CRYPTO_SM4
 #include <nettle/sm4.h>
 #endif
@@ -410,6 +411,125 @@ DEFINE_ECB(qcrypto_nettle_sm4,
            sm4_encrypt_native, sm4_decrypt_native)
 #endif
 
+/*
+ * GCM is an AEAD mode built on AES (128-bit block only). Drive it through the
+ * generic gcm_* interface, using the block cipher's encrypt function for both
+ * directions; associated data is fed with gcm_update() and the authentication
+ * tag is produced by gcm_digest().
+ */
+typedef struct QCryptoNettleAESGCM {
+    QCryptoCipher base;
+    struct gcm_key gcm_key;
+    struct gcm_ctx gcm_ctx;
+    union {
+        struct aes128_ctx aes128;
+        struct aes192_ctx aes192;
+        struct aes256_ctx aes256;
+    } cipher;
+    nettle_cipher_func *encrypt;
+} QCryptoNettleAESGCM;
+
+static int qcrypto_nettle_aes_gcm_setiv(QCryptoCipher *cipher,
+                                        const uint8_t *iv, size_t niv,
+                                        Error **errp)
+{
+    QCryptoNettleAESGCM *ctx = container_of(cipher, QCryptoNettleAESGCM, base);
+
+    gcm_set_iv(&ctx->gcm_ctx, &ctx->gcm_key, niv, iv);
+    return 0;
+}
+
+static int qcrypto_nettle_aes_gcm_setaad(QCryptoCipher *cipher,
+                                         const uint8_t *aad, size_t len,
+                                         Error **errp)
+{
+    QCryptoNettleAESGCM *ctx = container_of(cipher, QCryptoNettleAESGCM, base);
+
+    gcm_update(&ctx->gcm_ctx, &ctx->gcm_key, len, aad);
+    return 0;
+}
+
+static int qcrypto_nettle_aes_gcm_encrypt(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
+{
+    QCryptoNettleAESGCM *ctx = container_of(cipher, QCryptoNettleAESGCM, base);
+
+    gcm_encrypt(&ctx->gcm_ctx, &ctx->gcm_key, &ctx->cipher, ctx->encrypt,
+                len, out, in);
+    return 0;
+}
+
+static int qcrypto_nettle_aes_gcm_decrypt(QCryptoCipher *cipher,
+                                          const void *in, void *out,
+                                          size_t len, Error **errp)
+{
+    QCryptoNettleAESGCM *ctx = container_of(cipher, QCryptoNettleAESGCM, base);
+
+    gcm_decrypt(&ctx->gcm_ctx, &ctx->gcm_key, &ctx->cipher, ctx->encrypt,
+                len, out, in);
+    return 0;
+}
+
+static int qcrypto_nettle_aes_gcm_gettag(QCryptoCipher *cipher,
+                                         uint8_t *tag, size_t len,
+                                         Error **errp)
+{
+    QCryptoNettleAESGCM *ctx = container_of(cipher, QCryptoNettleAESGCM, base);
+
+    gcm_digest(&ctx->gcm_ctx, &ctx->gcm_key, &ctx->cipher, ctx->encrypt,
+               len, tag);
+    return 0;
+}
+
+static const struct QCryptoCipherDriver qcrypto_nettle_aes_gcm_driver = {
+    .cipher_encrypt = qcrypto_nettle_aes_gcm_encrypt,
+    .cipher_decrypt = qcrypto_nettle_aes_gcm_decrypt,
+    .cipher_setiv = qcrypto_nettle_aes_gcm_setiv,
+    .cipher_setaad = qcrypto_nettle_aes_gcm_setaad,
+    .cipher_gettag = qcrypto_nettle_aes_gcm_gettag,
+    .cipher_free = qcrypto_cipher_ctx_free,
+};
+
+static QCryptoCipher *qcrypto_nettle_aes_gcm_ctx_new(QCryptoCipherAlgo alg,
+                                                     const uint8_t *key,
+                                                     size_t nkey,
+                                                     Error **errp)
+{
+    QCryptoNettleAESGCM *ctx;
+
+    if (!qcrypto_cipher_validate_key_length(alg, QCRYPTO_CIPHER_MODE_GCM,
+                                            nkey, errp)) {
+        return NULL;
+    }
+
+    ctx = g_new0(QCryptoNettleAESGCM, 1);
+    ctx->base.driver = &qcrypto_nettle_aes_gcm_driver;
+
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALGO_AES_128:
+        aes128_set_encrypt_key(&ctx->cipher.aes128, key);
+        ctx->encrypt = aes128_encrypt_native;
+        break;
+    case QCRYPTO_CIPHER_ALGO_AES_192:
+        aes192_set_encrypt_key(&ctx->cipher.aes192, key);
+        ctx->encrypt = aes192_encrypt_native;
+        break;
+    case QCRYPTO_CIPHER_ALGO_AES_256:
+        aes256_set_encrypt_key(&ctx->cipher.aes256, key);
+        ctx->encrypt = aes256_encrypt_native;
+        break;
+    default:
+        error_setg(errp, "Unsupported cipher algorithm %s with GCM mode",
+                   QCryptoCipherAlgo_str(alg));
+        g_free(ctx);
+        return NULL;
+    }
+
+    gcm_set_key(&ctx->gcm_key, &ctx->cipher, ctx->encrypt);
+    return &ctx->base;
+}
+
 bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
                              QCryptoCipherMode mode)
 {
@@ -440,6 +560,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
     case QCRYPTO_CIPHER_MODE_XTS:
     case QCRYPTO_CIPHER_MODE_CTR:
         return true;
+    case QCRYPTO_CIPHER_MODE_GCM:
+        return alg == QCRYPTO_CIPHER_ALGO_AES_128 ||
+               alg == QCRYPTO_CIPHER_ALGO_AES_192 ||
+               alg == QCRYPTO_CIPHER_ALGO_AES_256;
     default:
         return false;
     }
@@ -451,6 +575,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
                                              size_t nkey,
                                              Error **errp)
 {
+    if (mode == QCRYPTO_CIPHER_MODE_GCM) {
+        return qcrypto_nettle_aes_gcm_ctx_new(alg, key, nkey, errp);
+    }
+
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_ECB:
     case QCRYPTO_CIPHER_MODE_CBC:
-- 
2.55.0


