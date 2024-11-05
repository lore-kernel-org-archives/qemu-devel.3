Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E79D33A20
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8OUu-0001fn-Gn; Tue, 05 Nov 2024 13:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUj-0001Yk-5h
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8OUe-0008Hw-UY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730832091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3mzfATKR+Rt2ep8fA2cmUJ2XINo4A+YMhJxgwNAglg=;
 b=RIs/potNRFqdWtTH3sML4gzTT2AJGCCVfG9V9FXNyxHrwHakUVvSjwCMqvdDC9iJKcoQxc
 //xuPLVm97ELB0paY1gtImuJrXWfYGcH7xRpXa4pFKXiE7C/TcYKufEGv+JxWQd7PRcdqg
 +ulWauubFnaG5SeEjVz4/OizRT51/sY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-HTzFqGyXPQu0et4xt6u4rQ-1; Tue,
 05 Nov 2024 13:41:28 -0500
X-MC-Unique: HTzFqGyXPQu0et4xt6u4rQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86B4C1955DD4; Tue,  5 Nov 2024 18:41:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6CDE19560A2; Tue,  5 Nov 2024 18:41:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 liequan che <liequanche@gmail.com>, cheliequan <cheliequan@inspur.com>
Subject: [PULL 2/4] crypto: Introduce SM3 hash hmac pbkdf algorithm
Date: Tue,  5 Nov 2024 18:41:13 +0000
Message-ID: <20241105184115.381511-3-berrange@redhat.com>
In-Reply-To: <20241105184115.381511-1-berrange@redhat.com>
References: <20241105184115.381511-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: liequan che <liequanche@gmail.com>

Introduce the SM3 cryptographic hash algorithm (GB/T 32905-2016).

SM3 (GB/T 32905-2016) is a cryptographic standard issued by the
Organization of State Commercial Cryptography Administration (OSCCA)
as an authorized cryptographic algorithm for use within China.

Detect the SM3 cryptographic hash algorithm and enable the feature silently
if it is available.

Signed-off-by: cheliequan <cheliequan@inspur.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/hash-gcrypt.c           |  3 +++
 crypto/hash-nettle.c           | 14 ++++++++++++
 crypto/hash.c                  |  3 +++
 crypto/hmac-gcrypt.c           |  3 +++
 crypto/hmac-nettle.c           | 11 ++++++++++
 crypto/pbkdf-gcrypt.c          |  6 ++++++
 crypto/pbkdf-nettle.c          | 13 ++++++++++++
 include/crypto/hash.h          |  1 +
 meson.build                    | 39 ++++++++++++++++++++++++++++++++++
 qapi/crypto.json               |  3 ++-
 tests/unit/test-crypto-hash.c  | 16 ++++++++++++++
 tests/unit/test-crypto-hmac.c  |  8 +++++++
 tests/unit/test-crypto-pbkdf.c | 16 ++++++++++++++
 13 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c
index 73533a4949..f04a9f553c 100644
--- a/crypto/hash-gcrypt.c
+++ b/crypto/hash-gcrypt.c
@@ -34,6 +34,9 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_SHA384] = GCRY_MD_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512] = GCRY_MD_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = GCRY_MD_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = GCRY_MD_SM3,
+#endif
 };
 
 gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
diff --git a/crypto/hash-nettle.c b/crypto/hash-nettle.c
index c78624b347..53f68301ef 100644
--- a/crypto/hash-nettle.c
+++ b/crypto/hash-nettle.c
@@ -26,6 +26,9 @@
 #include <nettle/md5.h>
 #include <nettle/sha.h>
 #include <nettle/ripemd160.h>
+#ifdef CONFIG_CRYPTO_SM3
+#include <nettle/sm3.h>
+#endif
 
 typedef void (*qcrypto_nettle_init)(void *ctx);
 typedef void (*qcrypto_nettle_write)(void *ctx,
@@ -43,6 +46,9 @@ union qcrypto_hash_ctx {
     struct sha384_ctx sha384;
     struct sha512_ctx sha512;
     struct ripemd160_ctx ripemd160;
+#ifdef CONFIG_CRYPTO_SM3
+    struct sm3_ctx sm3;
+#endif
 };
 
 struct qcrypto_hash_alg {
@@ -93,6 +99,14 @@ struct qcrypto_hash_alg {
         .result = (qcrypto_nettle_result)ripemd160_digest,
         .len = RIPEMD160_DIGEST_SIZE,
     },
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = {
+        .init = (qcrypto_nettle_init)sm3_init,
+        .write = (qcrypto_nettle_write)sm3_update,
+        .result = (qcrypto_nettle_result)sm3_digest,
+        .len = SM3_DIGEST_SIZE,
+    },
+#endif
 };
 
 gboolean qcrypto_hash_supports(QCryptoHashAlgo alg)
diff --git a/crypto/hash.c b/crypto/hash.c
index 0c8548c568..7513769e42 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -33,6 +33,9 @@ static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_SHA384]    = QCRYPTO_HASH_DIGEST_LEN_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512]    = QCRYPTO_HASH_DIGEST_LEN_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = QCRYPTO_HASH_DIGEST_LEN_RIPEMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = QCRYPTO_HASH_DIGEST_LEN_SM3,
+#endif
 };
 
 size_t qcrypto_hash_digest_len(QCryptoHashAlgo alg)
diff --git a/crypto/hmac-gcrypt.c b/crypto/hmac-gcrypt.c
index 19990cb6ed..090fe01c1e 100644
--- a/crypto/hmac-gcrypt.c
+++ b/crypto/hmac-gcrypt.c
@@ -26,6 +26,9 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALGO__MAX] = {
     [QCRYPTO_HASH_ALGO_SHA384] = GCRY_MAC_HMAC_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512] = GCRY_MAC_HMAC_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = GCRY_MAC_HMAC_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = GCRY_MAC_HMAC_SM3,
+#endif
 };
 
 typedef struct QCryptoHmacGcrypt QCryptoHmacGcrypt;
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 54dd75d5ff..dd5b2ab7a1 100644
--- a/crypto/hmac-nettle.c
+++ b/crypto/hmac-nettle.c
@@ -38,6 +38,9 @@ struct QCryptoHmacNettle {
         struct hmac_sha256_ctx sha256_ctx; /* equals hmac_sha224_ctx */
         struct hmac_sha512_ctx sha512_ctx; /* equals hmac_sha384_ctx */
         struct hmac_ripemd160_ctx ripemd160_ctx;
+#ifdef CONFIG_CRYPTO_SM3
+ struct hmac_sm3_ctx ctx;
+#endif
     } u;
 };
 
@@ -89,6 +92,14 @@ struct qcrypto_nettle_hmac_alg {
         .digest = (qcrypto_nettle_hmac_digest)hmac_ripemd160_digest,
         .len = RIPEMD160_DIGEST_SIZE,
     },
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = {
+        .setkey = (qcrypto_nettle_hmac_setkey)hmac_sm3_set_key,
+        .update = (qcrypto_nettle_hmac_update)hmac_sm3_update,
+        .digest = (qcrypto_nettle_hmac_digest)hmac_sm3_digest,
+        .len = SM3_DIGEST_SIZE,
+    },
+#endif
 };
 
 bool qcrypto_hmac_supports(QCryptoHashAlgo alg)
diff --git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c
index 76bbb55f7a..e89b8b1c76 100644
--- a/crypto/pbkdf-gcrypt.c
+++ b/crypto/pbkdf-gcrypt.c
@@ -33,6 +33,9 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgo hash)
     case QCRYPTO_HASH_ALGO_SHA384:
     case QCRYPTO_HASH_ALGO_SHA512:
     case QCRYPTO_HASH_ALGO_RIPEMD160:
+#ifdef CONFIG_CRYPTO_SM3
+    case QCRYPTO_HASH_ALGO_SM3:
+#endif
         return qcrypto_hash_supports(hash);
     default:
         return false;
@@ -54,6 +57,9 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
         [QCRYPTO_HASH_ALGO_SHA384] = GCRY_MD_SHA384,
         [QCRYPTO_HASH_ALGO_SHA512] = GCRY_MD_SHA512,
         [QCRYPTO_HASH_ALGO_RIPEMD160] = GCRY_MD_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+        [QCRYPTO_HASH_ALGO_SM3] = GCRY_MD_SM3,
+#endif
     };
     int ret;
 
diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c
index 93e686c2c6..3ef9c1b52c 100644
--- a/crypto/pbkdf-nettle.c
+++ b/crypto/pbkdf-nettle.c
@@ -34,6 +34,9 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgo hash)
     case QCRYPTO_HASH_ALGO_SHA384:
     case QCRYPTO_HASH_ALGO_SHA512:
     case QCRYPTO_HASH_ALGO_RIPEMD160:
+#ifdef CONFIG_CRYPTO_SM3
+    case QCRYPTO_HASH_ALGO_SM3:
+#endif
         return true;
     default:
         return false;
@@ -55,6 +58,9 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
         struct hmac_sha384_ctx sha384;
         struct hmac_sha512_ctx sha512;
         struct hmac_ripemd160_ctx ripemd160;
+#ifdef CONFIG_CRYPTO_SM3
+        struct hmac_sm3_ctx sm3;
+#endif
     } ctx;
 
     if (iterations > UINT_MAX) {
@@ -106,6 +112,13 @@ int qcrypto_pbkdf2(QCryptoHashAlgo hash,
         PBKDF2(&ctx.ripemd160, hmac_ripemd160_update, hmac_ripemd160_digest,
                RIPEMD160_DIGEST_SIZE, iterations, nsalt, salt, nout, out);
         break;
+#ifdef CONFIG_CRYPTO_SM3
+    case QCRYPTO_HASH_ALGO_SM3:
+        hmac_sm3_set_key(&ctx.sm3, nkey, key);
+        PBKDF2(&ctx.sm3, hmac_sm3_update, hmac_sm3_digest,
+               SM3_DIGEST_SIZE, iterations, nsalt, salt, nout, out);
+        break;
+#endif
 
     default:
         error_setg_errno(errp, ENOSYS,
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 712cac79ee..1868d4a0f7 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -31,6 +31,7 @@
 #define QCRYPTO_HASH_DIGEST_LEN_SHA384    48
 #define QCRYPTO_HASH_DIGEST_LEN_SHA512    64
 #define QCRYPTO_HASH_DIGEST_LEN_RIPEMD160 20
+#define QCRYPTO_HASH_DIGEST_LEN_SM3       32
 
 /* See also "QCryptoHashAlgo" defined in qapi/crypto.json */
 
diff --git a/meson.build b/meson.build
index c386593c52..6a078f927c 100644
--- a/meson.build
+++ b/meson.build
@@ -1760,6 +1760,7 @@ gcrypt = not_found
 nettle = not_found
 hogweed = not_found
 crypto_sm4 = not_found
+crypto_sm3 = not_found
 xts = 'none'
 
 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
@@ -1795,6 +1796,17 @@ if not gnutls_crypto.found()
       }''', dependencies: gcrypt)
       crypto_sm4 = not_found
     endif
+    crypto_sm3 = gcrypt
+    # SM3 ALG is available in libgcrypt >= 1.9
+    if gcrypt.found() and not cc.links('''
+      #include <gcrypt.h>
+      int main(void) {
+        gcry_md_hd_t handler;
+        gcry_md_open(&handler, GCRY_MD_SM3, 0);
+        return 0;
+      }''', dependencies: gcrypt)
+      crypto_sm3 = not_found
+    endif
   endif
   if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
     nettle = dependency('nettle', version: '>=3.4',
@@ -1815,6 +1827,31 @@ if not gnutls_crypto.found()
       }''', dependencies: nettle)
       crypto_sm4 = not_found
     endif
+    crypto_sm3 = nettle
+    # SM3 ALG is available in nettle >= 3.8
+    if nettle.found() and not cc.links('''
+      #include <nettle/sm3.h>
+      #include <nettle/hmac.h>
+      int main(void) {
+      struct sm3_ctx ctx;
+      struct hmac_sm3_ctx hmac_ctx;
+      unsigned char data[64] = {0};
+      unsigned char output[32];
+
+      // SM3 hash function test
+      sm3_init(&ctx);
+      sm3_update(&ctx, 64, data);
+      sm3_digest(&ctx, 32, data);
+
+      // HMAC-SM3 test
+      hmac_sm3_set_key(&hmac_ctx, 32, data);
+      hmac_sm3_update(&hmac_ctx, 64, data);
+      hmac_sm3_digest(&hmac_ctx, 32, output);
+
+      return 0;
+      }''', dependencies: nettle)
+      crypto_sm3 = not_found
+    endif
   endif
 endif
 
@@ -2462,6 +2499,7 @@ config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
 config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
+config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
@@ -4590,6 +4628,7 @@ if nettle.found()
    summary_info += {'  XTS':             xts != 'private'}
 endif
 summary_info += {'SM4 ALG support':   crypto_sm4}
+summary_info += {'SM3 ALG support':   crypto_sm3}
 summary_info += {'AF_ALG support':    have_afalg}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 7c30df9e31..c9d967d782 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -55,11 +55,12 @@
 # @sha512: SHA-512.  (since 2.7)
 #
 # @ripemd160: RIPEMD-160.  (since 2.7)
+# @sm3: SM3. (since 9.2.0)
 #
 # Since: 2.6
 ##
 { 'enum': 'QCryptoHashAlgo',
-  'data': ['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512', 'ripemd160']}
+  'data': ['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512', 'ripemd160', 'sm3']}
 
 ##
 # @QCryptoCipherAlgo:
diff --git a/tests/unit/test-crypto-hash.c b/tests/unit/test-crypto-hash.c
index 76c4699c15..8fee1593f9 100644
--- a/tests/unit/test-crypto-hash.c
+++ b/tests/unit/test-crypto-hash.c
@@ -43,6 +43,9 @@
                       "63b54e4cb2d2032b393994aa263c0dbb" \
                       "e00a9f2fe9ef6037352232a1eec55ee7"
 #define OUTPUT_RIPEMD160 "f3d658fad3fdfb2b52c9369cf0d441249ddfa8a0"
+#ifdef CONFIG_CRYPTO_SM3
+#define OUTPUT_SM3 "d4a97db105b477b84c4f20ec9c31a6c814e2705a0b83a5a89748d75f0ef456a1"
+#endif
 
 #define OUTPUT_MD5_B64 "Yo0gY3FWMDWrjvYvSSveyQ=="
 #define OUTPUT_SHA1_B64 "sudPJnWKOkIeUJzuBFJEt4dTzAI="
@@ -55,6 +58,10 @@
                           "7sVe5w=="
 #define OUTPUT_RIPEMD160_B64 "89ZY+tP9+ytSyTac8NRBJJ3fqKA="
 
+#ifdef CONFIG_CRYPTO_SM3
+#define OUTPUT_SM3_B64 "1Kl9sQW0d7hMTyDsnDGmyBTicFoLg6Wol0jXXw70VqE="
+#endif
+
 static const char *expected_outputs[] = {
     [QCRYPTO_HASH_ALGO_MD5] = OUTPUT_MD5,
     [QCRYPTO_HASH_ALGO_SHA1] = OUTPUT_SHA1,
@@ -63,6 +70,9 @@ static const char *expected_outputs[] = {
     [QCRYPTO_HASH_ALGO_SHA384] = OUTPUT_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512] = OUTPUT_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = OUTPUT_RIPEMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = OUTPUT_SM3,
+#endif
 };
 static const char *expected_outputs_b64[] = {
     [QCRYPTO_HASH_ALGO_MD5] = OUTPUT_MD5_B64,
@@ -72,6 +82,9 @@ static const char *expected_outputs_b64[] = {
     [QCRYPTO_HASH_ALGO_SHA384] = OUTPUT_SHA384_B64,
     [QCRYPTO_HASH_ALGO_SHA512] = OUTPUT_SHA512_B64,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = OUTPUT_RIPEMD160_B64,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = OUTPUT_SM3_B64,
+#endif
 };
 static const int expected_lens[] = {
     [QCRYPTO_HASH_ALGO_MD5] = 16,
@@ -81,6 +94,9 @@ static const int expected_lens[] = {
     [QCRYPTO_HASH_ALGO_SHA384] = 48,
     [QCRYPTO_HASH_ALGO_SHA512] = 64,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = 20,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = 32,
+#endif
 };
 
 static const char hex[] = "0123456789abcdef";
diff --git a/tests/unit/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c
index cdb8774443..20c60eb9d8 100644
--- a/tests/unit/test-crypto-hmac.c
+++ b/tests/unit/test-crypto-hmac.c
@@ -76,6 +76,14 @@ static QCryptoHmacTestData test_data[] = {
             "94964ed4c1155b62b668c241d67279e5"
             "8a711676",
     },
+#ifdef CONFIG_CRYPTO_SM3
+    {
+        .alg = QCRYPTO_HASH_ALGO_SM3,
+        .hex_digest =
+            "760e3799332bc913819b930085360ddb"
+    "c05529261313d5b15b75bab4fd7ae91e",
+    },
+#endif
 };
 
 static const char hex[] = "0123456789abcdef";
diff --git a/tests/unit/test-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c
index 12ee808fbc..ddb7244e21 100644
--- a/tests/unit/test-crypto-pbkdf.c
+++ b/tests/unit/test-crypto-pbkdf.c
@@ -325,6 +325,22 @@ static QCryptoPbkdfTestData test_data[] = {
                "\xce\xbf\x91\x14\x8b\x5c\x48\x41",
         .nout = 32
     },
+#ifdef CONFIG_CRYPTO_SM3
+    {
+        .path = "/crypto/pbkdf/nonrfc/sm3/iter2",
+        .hash = QCRYPTO_HASH_ALGO_SM3,
+        .iterations = 2,
+        .key = "password",
+        .nkey = 8,
+        .salt = "ATHENA.MIT.EDUraeburn",
+        .nsalt = 21,
+        .out = "\x48\x71\x1b\x58\xa3\xcb\xce\x06"
+ "\xba\xad\x77\xa8\xb5\xb9\xd8\x07"
+ "\x6a\xe2\xb3\x5b\x95\xce\xc8\xce"
+ "\xe7\xb1\xcb\xee\x61\xdf\x04\xea",
+        .nout = 32
+    },
+#endif
 #if 0
     {
         .path = "/crypto/pbkdf/nonrfc/whirlpool/iter1200",
-- 
2.46.0


