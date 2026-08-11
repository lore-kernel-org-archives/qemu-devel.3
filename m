Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131FCC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpPX-0006sB-2L; Tue, 11 Aug 2026 12:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP9-0005c2-68
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpP7-000152-5Q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ux+PC7QE47ksZRyyyjY7D7UMaxE+oc6qMw6WUDcGtSg=;
 b=bUgQBGKKtc9HHf/uwr1mFPST+HzIuq16AC3NObneMLR0hLqIpWfA8iD4pRRN+ZNBpztuuA
 4HO6AlMr+3HmpkTRS5VjR8Ain16IHURN9E9BEQhi1bRj9GXCYm3Khxcv0rnd13c2BXzeYH
 XwecXA/vG+pmcdYkGY84shy5PYmTLdo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-1ickk-97PHuddix8jS0xaQ-1; Tue,
 11 Aug 2026 12:32:31 -0400
X-MC-Unique: 1ickk-97PHuddix8jS0xaQ-1
X-Mimecast-MFC-AGG-ID: 1ickk-97PHuddix8jS0xaQ_1786465950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65D4C1800651; Tue, 11 Aug 2026 16:32:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B22C8195DF91; Tue, 11 Aug 2026 16:32:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 78/83] crypto/cipher-gnutls: Implement AES-GCM
Date: Tue, 11 Aug 2026 18:29:33 +0200
Message-ID: <20260811162938.1403216-79-clg@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the AES-GCM AEAD mode to the gnutls backend so it is available when
QEMU is built with gnutls (neither gcrypt nor nettle). GCM uses the
incremental gnutls_cipher_* API with the GNUTLS_CIPHER_AES_*_GCM
algorithms: gnutls_cipher_set_iv() sets the nonce, gnutls_cipher_add_auth()
feeds the associated data, gnutls_cipher_encrypt2()/decrypt2() process the
message, and gnutls_cipher_tag() reads back the authentication tag.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260811060115.1849266-12-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 crypto/cipher-gnutls.c.inc | 154 +++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/crypto/cipher-gnutls.c.inc b/crypto/cipher-gnutls.c.inc
index a8263fff6d15..963b328fa12f 100644
--- a/crypto/cipher-gnutls.c.inc
+++ b/crypto/cipher-gnutls.c.inc
@@ -48,6 +48,15 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
         default:
             return false;
         }
+    case QCRYPTO_CIPHER_MODE_GCM:
+        switch (alg) {
+        case QCRYPTO_CIPHER_ALGO_AES_128:
+        case QCRYPTO_CIPHER_ALGO_AES_192:
+        case QCRYPTO_CIPHER_ALGO_AES_256:
+            return true;
+        default:
+            return false;
+        }
     default:
         return false;
     }
@@ -223,6 +232,147 @@ static struct QCryptoCipherDriver gnutls_driver = {
     .cipher_free = qcrypto_gnutls_cipher_free,
 };
 
+/*
+ * GCM is an AEAD stream mode: the nonce need not match the block size, the
+ * message length need not be a multiple of the block size, associated data is
+ * fed with gnutls_cipher_add_auth() and the authentication tag is read back
+ * with gnutls_cipher_tag().
+ */
+static int
+qcrypto_gnutls_cipher_encrypt_gcm(QCryptoCipher *cipher,
+                                  const void *in, void *out,
+                                  size_t len, Error **errp)
+{
+    QCryptoCipherGnutls *ctx = container_of(cipher, QCryptoCipherGnutls, base);
+    int err;
+
+    err = gnutls_cipher_encrypt2(ctx->handle, in, len, out, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot encrypt data: %s", gnutls_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int
+qcrypto_gnutls_cipher_decrypt_gcm(QCryptoCipher *cipher,
+                                  const void *in, void *out,
+                                  size_t len, Error **errp)
+{
+    QCryptoCipherGnutls *ctx = container_of(cipher, QCryptoCipherGnutls, base);
+    int err;
+
+    err = gnutls_cipher_decrypt2(ctx->handle, in, len, out, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot decrypt data: %s", gnutls_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int
+qcrypto_gnutls_cipher_setiv_gcm(QCryptoCipher *cipher,
+                                const uint8_t *iv, size_t niv,
+                                Error **errp)
+{
+    QCryptoCipherGnutls *ctx = container_of(cipher, QCryptoCipherGnutls, base);
+
+    gnutls_cipher_set_iv(ctx->handle, (void *)iv, niv);
+
+    return 0;
+}
+
+static int
+qcrypto_gnutls_cipher_setaad_gcm(QCryptoCipher *cipher,
+                                 const uint8_t *aad, size_t len,
+                                 Error **errp)
+{
+    QCryptoCipherGnutls *ctx = container_of(cipher, QCryptoCipherGnutls, base);
+    int err;
+
+    err = gnutls_cipher_add_auth(ctx->handle, aad, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot add associated data: %s",
+                   gnutls_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int
+qcrypto_gnutls_cipher_gettag_gcm(QCryptoCipher *cipher,
+                                 uint8_t *tag, size_t len,
+                                 Error **errp)
+{
+    QCryptoCipherGnutls *ctx = container_of(cipher, QCryptoCipherGnutls, base);
+    int err;
+
+    err = gnutls_cipher_tag(ctx->handle, tag, len);
+    if (err != 0) {
+        error_setg(errp, "Cannot get authentication tag: %s",
+                   gnutls_strerror(err));
+        return -1;
+    }
+
+    return 0;
+}
+
+static struct QCryptoCipherDriver gnutls_gcm_driver = {
+    .cipher_encrypt = qcrypto_gnutls_cipher_encrypt_gcm,
+    .cipher_decrypt = qcrypto_gnutls_cipher_decrypt_gcm,
+    .cipher_setiv = qcrypto_gnutls_cipher_setiv_gcm,
+    .cipher_setaad = qcrypto_gnutls_cipher_setaad_gcm,
+    .cipher_gettag = qcrypto_gnutls_cipher_gettag_gcm,
+    .cipher_free = qcrypto_gnutls_cipher_free,
+};
+
+static QCryptoCipher *
+qcrypto_gnutls_aes_gcm_ctx_new(QCryptoCipherAlgo alg, const uint8_t *key,
+                               size_t nkey, Error **errp)
+{
+    gnutls_datum_t gkey = { (unsigned char *)key, nkey };
+    gnutls_cipher_algorithm_t galg = GNUTLS_CIPHER_UNKNOWN;
+    QCryptoCipherGnutls *ctx;
+    int err;
+
+    switch (alg) {
+    case QCRYPTO_CIPHER_ALGO_AES_128:
+        galg = GNUTLS_CIPHER_AES_128_GCM;
+        break;
+    case QCRYPTO_CIPHER_ALGO_AES_192:
+        galg = GNUTLS_CIPHER_AES_192_GCM;
+        break;
+    case QCRYPTO_CIPHER_ALGO_AES_256:
+        galg = GNUTLS_CIPHER_AES_256_GCM;
+        break;
+    default:
+        error_setg(errp, "Unsupported cipher algorithm %s with GCM mode",
+                   QCryptoCipherAlgo_str(alg));
+        return NULL;
+    }
+
+    if (!qcrypto_cipher_validate_key_length(alg, QCRYPTO_CIPHER_MODE_GCM,
+                                            nkey, errp)) {
+        return NULL;
+    }
+
+    ctx = g_new0(QCryptoCipherGnutls, 1);
+    ctx->base.driver = &gnutls_gcm_driver;
+    ctx->blocksize = 16;
+
+    err = gnutls_cipher_init(&ctx->handle, galg, &gkey, NULL);
+    if (err != 0) {
+        error_setg(errp, "Cannot initialize cipher: %s", gnutls_strerror(err));
+        g_free(ctx);
+        return NULL;
+    }
+
+    return &ctx->base;
+}
+
 static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
                                              QCryptoCipherMode mode,
                                              const uint8_t *key,
@@ -234,6 +384,10 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
     gnutls_cipher_algorithm_t galg = GNUTLS_CIPHER_UNKNOWN;
     int err;
 
+    if (mode == QCRYPTO_CIPHER_MODE_GCM) {
+        return qcrypto_gnutls_aes_gcm_ctx_new(alg, key, nkey, errp);
+    }
+
     switch (mode) {
     case QCRYPTO_CIPHER_MODE_XTS:
         switch (alg) {
-- 
2.55.0


