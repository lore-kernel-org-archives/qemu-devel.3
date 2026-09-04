Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FA2C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WRO-0003su-Gc; Fri, 04 Sep 2026 12:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRM-0003rq-Og
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:06:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRK-0006dL-Ke
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788538013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2J4h1MLwsa6v9AdSB/cjdqrcF7St+KHBYqO/t9Qy89c=;
 b=aTzgkc85gyoPbn/T5NI65wcVfq6DjDozTcFZaZLjwbJtcgQJfImH8D0VJY5UikK2zyrYtL
 AC1A5yO6mK253vdHniBBwXFWzxbcJ0HCvWfutz+wvuvmnh6Q/DI8PCRpEIpNUa3G0+Aqj3
 5QE/2oHchu7RSA94ve6hv6iQYga1Qq4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-0v0idWCMP26rJ-7psTzD1g-1; Fri,
 04 Sep 2026 12:06:51 -0400
X-MC-Unique: 0v0idWCMP26rJ-7psTzD1g-1
X-Mimecast-MFC-AGG-ID: 0v0idWCMP26rJ-7psTzD1g_1788538010
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2CF1195411B; Fri,  4 Sep 2026 16:06:49 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF0803001D37; Fri,  4 Sep 2026 16:06:47 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PULL v2 01/13] crypto: Use g_autofree
Date: Fri,  4 Sep 2026 17:06:31 +0100
Message-ID: <20260904160643.353833-2-berrange@redhat.com>
In-Reply-To: <20260904160643.353833-1-berrange@redhat.com>
References: <20260904160643.353833-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Evgeny Kolmakov <randomjack94dev@gmail.com>

Use g_autofree attribute to reduce the amount
of manual g_free() calls and 'goto out' code

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/block.c          | 17 ++++++-----------
 crypto/hmac-gcrypt.c    | 12 ++++--------
 crypto/hmac-glib.c      | 10 +++-------
 crypto/ivgen-essiv.c    | 15 ++++-----------
 crypto/ivgen.c          |  6 ++----
 crypto/secret_keyring.c |  5 ++---
 6 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/crypto/block.c b/crypto/block.c
index 96c83e60b9..42558f3caf 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -55,7 +55,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  unsigned int flags,
                                  Error **errp)
 {
-    QCryptoBlock *block = g_new0(QCryptoBlock, 1);
+    g_autofree QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
     qemu_mutex_init(&block->mutex);
 
@@ -65,7 +65,6 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
                    QCryptoBlockFormat_str(options->format));
-        g_free(block);
         return NULL;
     }
 
@@ -74,11 +73,10 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
     if (block->driver->open(block, options, optprefix,
                             readfunc, opaque, flags, errp) < 0)
     {
-        g_free(block);
         return NULL;
     }
 
-    return block;
+    return g_steal_pointer(&block);
 }
 
 
@@ -90,7 +88,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
                                    unsigned int flags,
                                    Error **errp)
 {
-    QCryptoBlock *block = g_new0(QCryptoBlock, 1);
+    g_autofree QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
     qemu_mutex_init(&block->mutex);
 
@@ -100,7 +98,6 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
         !qcrypto_block_drivers[options->format]) {
         error_setg(errp, "Unsupported block driver %s",
                    QCryptoBlockFormat_str(options->format));
-        g_free(block);
         return NULL;
     }
 
@@ -109,11 +106,10 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
 
     if (block->driver->create(block, options, optprefix, initfunc,
                               writefunc, opaque, errp) < 0) {
-        g_free(block);
         return NULL;
     }
 
-    return block;
+    return g_steal_pointer(&block);
 }
 
 
@@ -185,17 +181,16 @@ int qcrypto_block_amend_options(QCryptoBlock *block,
 QCryptoBlockInfo *qcrypto_block_get_info(QCryptoBlock *block,
                                          Error **errp)
 {
-    QCryptoBlockInfo *info = g_new0(QCryptoBlockInfo, 1);
+    g_autofree QCryptoBlockInfo *info = g_new0(QCryptoBlockInfo, 1);
 
     info->format = block->format;
 
     if (block->driver->get_info &&
         block->driver->get_info(block, info, errp) < 0) {
-        g_free(info);
         return NULL;
     }
 
-    return info;
+    return g_steal_pointer(&info);
 }
 
 
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index e428d17479..44631fb348 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -50,7 +50,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
                            const uint8_t *key, size_t nkey,
                            Error **errp)
 {
-    QCryptoHmacGcrypt *ctx;
+    g_autofree QCryptoHmacGcrypt *ctx = NULL;
     gcry_error_t err;
 
     if (!qcrypto_hmac_supports(alg)) {
@@ -66,7 +66,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
     if (err != 0) {
         error_setg(errp, "Cannot initialize hmac: %s",
                    gcry_strerror(err));
-        goto error;
+        return NULL;
     }
 
     err = gcry_mac_setkey(ctx->handle, (const void *)key, nkey);
@@ -74,14 +74,10 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
         error_setg(errp, "Cannot set key: %s",
                    gcry_strerror(err));
         gcry_mac_close(ctx->handle);
-        goto error;
+        return NULL;
     }
 
-    return ctx;
-
-error:
-    g_free(ctx);
-    return NULL;
+    return g_steal_pointer(&ctx);
 }
 
 static void
diff --git a/crypto/hmac-glib.c b/crypto/hmac-glib.c
index b845133a05..1f17769c1c 100644
--- a/crypto/hmac-glib.c
+++ b/crypto/hmac-glib.c
@@ -46,7 +46,7 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
                            const uint8_t *key, size_t nkey,
                            Error **errp)
 {
-    QCryptoHmacGlib *ctx;
+    g_autofree QCryptoHmacGlib *ctx = NULL;
 
     if (!qcrypto_hmac_supports(alg)) {
         error_setg(errp, "Unsupported hmac algorithm %s",
@@ -60,14 +60,10 @@ void *qcrypto_hmac_ctx_new(QCryptoHashAlgo alg,
                             (const uint8_t *)key, nkey);
     if (!ctx->ghmac) {
         error_setg(errp, "Cannot initialize hmac and set key");
-        goto error;
+        return NULL;
     }
 
-    return ctx;
-
-error:
-    g_free(ctx);
-    return NULL;
+    return g_steal_pointer(&ctx);
 }
 
 static void
diff --git a/crypto/ivgen-essiv.c b/crypto/ivgen-essiv.c
index 3d5a188795..d5fa269888 100644
--- a/crypto/ivgen-essiv.c
+++ b/crypto/ivgen-essiv.c
@@ -31,10 +31,10 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
                                     const uint8_t *key, size_t nkey,
                                     Error **errp)
 {
-    uint8_t *salt;
+    g_autofree uint8_t *salt = NULL;
     size_t nhash;
     size_t nsalt;
-    QCryptoIVGenESSIV *essiv = g_new0(QCryptoIVGenESSIV, 1);
+    g_autofree QCryptoIVGenESSIV *essiv = g_new0(QCryptoIVGenESSIV, 1);
 
     /* Not necessarily the same as nkey */
     nsalt = qcrypto_cipher_get_key_len(ivgen->cipher);
@@ -46,8 +46,6 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
     if (qcrypto_hash_bytes(ivgen->hash, (const gchar *)key, nkey,
                            &salt, &nhash,
                            errp) < 0) {
-        g_free(essiv);
-        g_free(salt);
         return -1;
     }
 
@@ -57,13 +55,10 @@ static int qcrypto_ivgen_essiv_init(QCryptoIVGen *ivgen,
                                        salt, MIN(nhash, nsalt),
                                        errp);
     if (!essiv->cipher) {
-        g_free(essiv);
-        g_free(salt);
         return -1;
     }
 
-    g_free(salt);
-    ivgen->private = essiv;
+    ivgen->private = g_steal_pointer(&essiv);
 
     return 0;
 }
@@ -75,7 +70,7 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
 {
     QCryptoIVGenESSIV *essiv = ivgen->private;
     size_t ndata = qcrypto_cipher_get_block_len(ivgen->cipher);
-    uint8_t *data = g_new(uint8_t, ndata);
+    g_autofree uint8_t *data = g_new(uint8_t, ndata);
 
     sector = cpu_to_le64(sector);
     memcpy(data, (uint8_t *)&sector, MIN(sizeof(sector), ndata));
@@ -88,7 +83,6 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
                                data,
                                ndata,
                                errp) < 0) {
-        g_free(data);
         return -1;
     }
 
@@ -99,7 +93,6 @@ static int qcrypto_ivgen_essiv_calculate(QCryptoIVGen *ivgen,
     if (ndata < niv) {
         memset(iv + ndata, 0, niv - ndata);
     }
-    g_free(data);
     return 0;
 }
 
diff --git a/crypto/ivgen.c b/crypto/ivgen.c
index 6b7d24d889..9f1f7d7dca 100644
--- a/crypto/ivgen.c
+++ b/crypto/ivgen.c
@@ -33,7 +33,7 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgo alg,
                                 const uint8_t *key, size_t nkey,
                                 Error **errp)
 {
-    QCryptoIVGen *ivgen = g_new0(QCryptoIVGen, 1);
+    g_autofree QCryptoIVGen *ivgen = g_new0(QCryptoIVGen, 1);
 
     ivgen->algorithm = alg;
     ivgen->cipher = cipheralg;
@@ -51,16 +51,14 @@ QCryptoIVGen *qcrypto_ivgen_new(QCryptoIVGenAlgo alg,
         break;
     default:
         error_setg(errp, "Unknown block IV generator algorithm %d", alg);
-        g_free(ivgen);
         return NULL;
     }
 
     if (ivgen->driver->init(ivgen, key, nkey, errp) < 0) {
-        g_free(ivgen);
         return NULL;
     }
 
-    return ivgen;
+    return g_steal_pointer(&ivgen);
 }
 
 
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 78d7f09b3b..3b332276ef 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -41,7 +41,7 @@ qcrypto_secret_keyring_load_data(QCryptoSecretCommon *sec_common,
                                  Error **errp)
 {
     QCryptoSecretKeyring *secret = QCRYPTO_SECRET_KEYRING(sec_common);
-    uint8_t *buffer = NULL;
+    g_autofree uint8_t *buffer = NULL;
     long retcode;
 
     *output = NULL;
@@ -61,12 +61,11 @@ qcrypto_secret_keyring_load_data(QCryptoSecretCommon *sec_common,
 
     retcode = keyctl_read(secret->serial, buffer, retcode);
     if (retcode < 0) {
-        g_free(buffer);
         goto keyctl_error;
     }
 
     *outputlen = retcode;
-    *output = buffer;
+    *output = g_steal_pointer(&buffer);
     return;
 
 keyctl_error:
-- 
2.55.0


