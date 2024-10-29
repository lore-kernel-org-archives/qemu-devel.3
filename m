Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA7AD2AB2D
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5kzy-0003QA-QP; Tue, 29 Oct 2024 08:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liequanche@gmail.com>)
 id 1t5kzv-0003PS-Sd
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:06:56 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liequanche@gmail.com>)
 id 1t5kzr-0006yE-Qb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:06:55 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b14554468fso401071685a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730203610; x=1730808410; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iR0mTX/w2rJbYDVSWTBtm6McGirBQAaWmuuU54oDtPs=;
 b=H8lvQ6Q53hQpY+zSNzAU9XUrHWP/GtDhvYeSSrnW+s6pRcCrJJx4zHso0+/ym5ygP/
 n35GzkvdBGH0xEZW/DkZKy++8OdQ/opEtdV9+onE6cQ/ySvwANoRKlfXzSIqf3AwxNo7
 WbKD1yYL6BBzpDNRcJHngV5Adly0ciUGa/YbL3qQ62jQeLI2wFSzAsJRhBFWTCF+BdZT
 u8I4dFMvAmGuOTPHBmAepKzNXFHsAZ3y0KSMDPlbjhAZ0l03k8GR3t5lrOGPRGJO8ean
 /vZqQ/e9PnMuWgUTcv4ryQ4cV/bZbDGRJCD4N9sw2nxQRq7LBqiq5n2Bgb2L76AIlBse
 yDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203610; x=1730808410;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iR0mTX/w2rJbYDVSWTBtm6McGirBQAaWmuuU54oDtPs=;
 b=sg5d28YiGBL5CoEG1o2erAYk2ZjQCA6HmbLO3YJ9nAZ/Z3Q9DHG/Bhs5R0Wsghf2HJ
 BrI7kDZky9lFMG6IUHcu1uNILs6p/6mQXXuDFqGuWp19Xt9ugkYUKObymqJniO8Y2Hsv
 fpoosp20qg/GpPzuEoW5JsR/fiIc0asNlXemRZ1YZBGVTd7XHAK7l6olY9Gg0LJcU0Ix
 qf2o2Oo4PSpV1rGyeNDoRhXRsecxXyiS8VncsZP9TS+xZbUm6wkVg7nZZUpZ0tQZu9WB
 TWvDermvUBPQTPPN4KjkIXWPb4zXLBqkyFrNKXPUXgkE4mV2p5EKH/BjkCEgjYWQVEVe
 C7CQ==
X-Gm-Message-State: AOJu0YzIzJZLY9+VNI8G3kbwiNcN4F5QJGGyOablkbSGoED2XN6AoHzk
 c7cIBgTbmTBFvxeI7KT5QfMjFn2caD6VOkqeujjBUpRuUNsMZXDIdBUJ5oFeEh6rW8MDIQRNcBK
 BkU44RqfWW5EqTKH3lMfnUTLLkHI0b6Zj
X-Google-Smtp-Source: AGHT+IGEzEI5ezEzMEPiuyzWC2+OKGThHFiPvFEz2EsuHkf8FlLr25UmCRj/gSC9Kd5q5g75bQh+EQpKQnQppy7Bu4c=
X-Received: by 2002:a05:6214:5543:b0:6cc:37bb:40b with SMTP id
 6a1803df08f44-6d185841246mr208161366d6.37.1730203610015; Tue, 29 Oct 2024
 05:06:50 -0700 (PDT)
MIME-Version: 1.0
From: liequan che <liequanche@gmail.com>
Date: Tue, 29 Oct 2024 20:06:39 +0800
Message-ID: <CAAsfc_qfHe8hgr06AjhhfhWkOvKxU-Wz-02EjFCpo6HNkRhzgg@mail.gmail.com>
Subject: [PATCH V2] crypto: Introduce SM3 hash hmac pbkdf algorithm
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000090719406259c6b17"
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=liequanche@gmail.com; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000090719406259c6b17
Content-Type: text/plain; charset="UTF-8"

Introduce the SM3 cryptographic hash algorithm (GB/T 32905-2016).

SM3 (GB/T 32905-2016) is a cryptographic standard issued by the
Organization of State Commercial Cryptography Administration (OSCCA)
as an authorized cryptographic algorithm for use within China.

Detect the SM3 cryptographic hash algorithm and enable the feature silently
if it is available.

Signed-off-by: cheliequan <cheliequan@inspur.com>
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
@@ -34,6 +34,9 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH_ALGO__MAX] =
{
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
@@ -33,6 +33,9 @@ static size_t
qcrypto_hash_alg_size[QCRYPTO_HASH_ALGO__MAX] = {
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
@@ -26,6 +26,9 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALGO__MAX] =
{
     [QCRYPTO_HASH_ALGO_SHA384] = GCRY_MAC_HMAC_SHA384,
     [QCRYPTO_HASH_ALGO_SHA512] = GCRY_MAC_HMAC_SHA512,
     [QCRYPTO_HASH_ALGO_RIPEMD160] = GCRY_MAC_HMAC_RMD160,
+#ifdef CONFIG_CRYPTO_SM3
+    [QCRYPTO_HASH_ALGO_SM3] = GCRY_MAC_HMAC_SM3,
+#endif
 };

 typedef struct QCryptoHmacGcrypt QCryptoHmacGcrypt;
diff --git a/crypto/hmac-nettle.c b/crypto/hmac-nettle.c
index 54dd75d5ff..4755f2caca 100644
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
         PBKDF2(&ctx.ripemd160, hmac_ripemd160_update,
hmac_ripemd160_digest,
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
index 85594fd3f1..611c13d182 100644
--- a/meson.build
+++ b/meson.build
@@ -1754,6 +1754,7 @@ gcrypt = not_found
 nettle = not_found
 hogweed = not_found
 crypto_sm4 = not_found
+crypto_sm3 = not_found
 xts = 'none'

 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
@@ -1789,6 +1790,17 @@ if not gnutls_crypto.found()
       }''', dependencies: gcrypt)
       crypto_sm4 = not_found
     endif
+    crypto_sm3 = gcrypt
+    # SM3 ALG is available in libgcrypt >= 1.8
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
   if (not get_option('nettle').auto() or have_system) and not
gcrypt.found()
     nettle = dependency('nettle', version: '>=3.4',
@@ -1809,6 +1821,31 @@ if not gnutls_crypto.found()
       }''', dependencies: nettle)
       crypto_sm4 = not_found
     endif
+    crypto_sm3 = nettle
+    # SM3 ALG is available in nettle >= 3.4
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

@@ -2453,6 +2490,7 @@ config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
 config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
+config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
 config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
@@ -4578,6 +4616,7 @@ if nettle.found()
    summary_info += {'  XTS':             xts != 'private'}
 endif
 summary_info += {'SM4 ALG support':   crypto_sm4}
+summary_info += {'SM3 ALG support':   crypto_sm3}
 summary_info += {'AF_ALG support':    have_afalg}
 summary_info += {'rng-none':          get_option('rng_none')}
 summary_info += {'Linux keyring':     have_keyring}
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 9431522768..3645a4649b 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -55,11 +55,12 @@
 # @sha512: SHA-512.  (since 2.7)
 #
 # @ripemd160: RIPEMD-160.  (since 2.7)
+# @sm3: SM3. (since 8.2.0)
 #
 # Since: 2.6
 ##
 { 'enum': 'QCryptoHashAlgo',
-  'data': ['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512',
'ripemd160']}
+  'data': ['md5', 'sha1', 'sha224', 'sha256', 'sha384', 'sha512',
'ripemd160', 'sm3']}

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
+#define OUTPUT_SM3
"d4a97db105b477b84c4f20ec9c31a6c814e2705a0b83a5a89748d75f0ef456a1"
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
index cdb8774443..d8774bed01 100644
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
index 12ee808fbc..061a8da139 100644
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
2.33.0

--00000000000090719406259c6b17
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Introduce the SM3 cryptographic hash algorithm (GB/T 32905=
-2016).<br><br>SM3 (GB/T 32905-2016) is a cryptographic standard issued by =
the<br>Organization of State Commercial Cryptography Administration (OSCCA)=
<br>as an authorized cryptographic algorithm for use within China.<br><br>D=
etect the SM3 cryptographic hash algorithm and enable the feature silently<=
br>if it is available.<br><br>Signed-off-by: cheliequan &lt;<a href=3D"mail=
to:cheliequan@inspur.com">cheliequan@inspur.com</a>&gt;<br>---<br>=C2=A0cry=
pto/hash-gcrypt.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A03 +++<br>=C2=
=A0crypto/hash-nettle.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 14 +++++++++++=
+<br>=C2=A0crypto/hash.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A03 +++<br>=C2=A0crypto/hmac-gcrypt.c =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | =C2=A03 +++<br>=C2=A0crypto/hmac-nettle.c =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 11 ++++++++++<br>=C2=A0crypto/pbkdf-gcrypt.c =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A06 ++++++<br>=C2=A0crypto/pbkdf-nettle.c=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++++++++++++<br>=C2=A0include/crypt=
o/hash.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 +<br>=C2=A0meson.build=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 39 =
++++++++++++++++++++++++++++++++++<br>=C2=A0qapi/crypto.json =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A03 ++-<br>=C2=A0tests/unit/test-c=
rypto-hash.c =C2=A0| 16 ++++++++++++++<br>=C2=A0tests/unit/test-crypto-hmac=
.c =C2=A0| =C2=A08 +++++++<br>=C2=A0tests/unit/test-crypto-pbkdf.c | 16 +++=
+++++++++++<br>=C2=A013 files changed, 135 insertions(+), 1 deletion(-)<br>=
<br>diff --git a/crypto/hash-gcrypt.c b/crypto/hash-gcrypt.c<br>index 73533=
a4949..f04a9f553c 100644<br>--- a/crypto/hash-gcrypt.c<br>+++ b/crypto/hash=
-gcrypt.c<br>@@ -34,6 +34,9 @@ static int qcrypto_hash_alg_map[QCRYPTO_HASH=
_ALGO__MAX] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA384] =3D GCR=
Y_MD_SHA384,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA512] =3D GCRY_MD_=
SHA512,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_RIPEMD160] =3D GCRY_MD_RM=
D160,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SM3=
] =3D GCRY_MD_SM3,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0gboolean qcryp=
to_hash_supports(QCryptoHashAlgo alg)<br>diff --git a/crypto/hash-nettle.c =
b/crypto/hash-nettle.c<br>index c78624b347..53f68301ef 100644<br>--- a/cryp=
to/hash-nettle.c<br>+++ b/crypto/hash-nettle.c<br>@@ -26,6 +26,9 @@<br>=C2=
=A0#include &lt;nettle/md5.h&gt;<br>=C2=A0#include &lt;nettle/sha.h&gt;<br>=
=C2=A0#include &lt;nettle/ripemd160.h&gt;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+=
#include &lt;nettle/sm3.h&gt;<br>+#endif<br>=C2=A0<br>=C2=A0typedef void (*=
qcrypto_nettle_init)(void *ctx);<br>=C2=A0typedef void (*qcrypto_nettle_wri=
te)(void *ctx,<br>@@ -43,6 +46,9 @@ union qcrypto_hash_ctx {<br>=C2=A0 =C2=
=A0 =C2=A0struct sha384_ctx sha384;<br>=C2=A0 =C2=A0 =C2=A0struct sha512_ct=
x sha512;<br>=C2=A0 =C2=A0 =C2=A0struct ripemd160_ctx ripemd160;<br>+#ifdef=
 CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0struct sm3_ctx sm3;<br>+#endif<br>=C2=
=A0};<br>=C2=A0<br>=C2=A0struct qcrypto_hash_alg {<br>@@ -93,6 +99,14 @@ st=
ruct qcrypto_hash_alg {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.result =3D (q=
crypto_nettle_result)ripemd160_digest,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.len =3D RIPEMD160_DIGEST_SIZE,<br>=C2=A0 =C2=A0 =C2=A0},<br>+#ifdef CON=
FIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SM3] =3D {<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0.init =3D (qcrypto_nettle_init)sm3_init,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0.write =3D (qcrypto_nettle_write)sm3_update,<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.result =3D (qcrypto_nettle_result)sm3_digest,<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0.len =3D SM3_DIGEST_SIZE,<br>+ =C2=A0 =C2=A0},<=
br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0gboolean qcrypto_hash_supports(QC=
ryptoHashAlgo alg)<br>diff --git a/crypto/hash.c b/crypto/hash.c<br>index 0=
c8548c568..7513769e42 100644<br>--- a/crypto/hash.c<br>+++ b/crypto/hash.c<=
br>@@ -33,6 +33,9 @@ static size_t qcrypto_hash_alg_size[QCRYPTO_HASH_ALGO_=
_MAX] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA384] =C2=A0 =C2=A0=
=3D QCRYPTO_HASH_DIGEST_LEN_SHA384,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_AL=
GO_SHA512] =C2=A0 =C2=A0=3D QCRYPTO_HASH_DIGEST_LEN_SHA512,<br>=C2=A0 =C2=
=A0 =C2=A0[QCRYPTO_HASH_ALGO_RIPEMD160] =3D QCRYPTO_HASH_DIGEST_LEN_RIPEMD1=
60,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SM3] =
=3D QCRYPTO_HASH_DIGEST_LEN_SM3,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0=
size_t qcrypto_hash_digest_len(QCryptoHashAlgo alg)<br>diff --git a/crypto/=
hmac-gcrypt.c b/crypto/hmac-gcrypt.c<br>index 19990cb6ed..090fe01c1e 100644=
<br>--- a/crypto/hmac-gcrypt.c<br>+++ b/crypto/hmac-gcrypt.c<br>@@ -26,6 +2=
6,9 @@ static int qcrypto_hmac_alg_map[QCRYPTO_HASH_ALGO__MAX] =3D {<br>=C2=
=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA384] =3D GCRY_MAC_HMAC_SHA384,<br>=
=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA512] =3D GCRY_MAC_HMAC_SHA512,<br=
>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_RIPEMD160] =3D GCRY_MAC_HMAC_RMD160=
,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SM3] =
=3D GCRY_MAC_HMAC_SM3,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0typedef st=
ruct QCryptoHmacGcrypt QCryptoHmacGcrypt;<br>diff --git a/crypto/hmac-nettl=
e.c b/crypto/hmac-nettle.c<br>index 54dd75d5ff..4755f2caca 100644<br>--- a/=
crypto/hmac-nettle.c<br>+++ b/crypto/hmac-nettle.c<br>@@ -38,6 +38,9 @@ str=
uct QCryptoHmacNettle {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sh=
a256_ctx sha256_ctx; /* equals hmac_sha224_ctx */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0struct hmac_sha512_ctx sha512_ctx; /* equals hmac_sha384_ctx *=
/<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_ripemd160_ctx ripemd160_=
ctx;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+	struct hmac_sm3_ctx ctx;<br>+#endif<=
br>=C2=A0 =C2=A0 =C2=A0} u;<br>=C2=A0};<br>=C2=A0<br>@@ -89,6 +92,14 @@ str=
uct qcrypto_nettle_hmac_alg {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.digest =
=3D (qcrypto_nettle_hmac_digest)hmac_ripemd160_digest,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0.len =3D RIPEMD160_DIGEST_SIZE,<br>=C2=A0 =C2=A0 =C2=A0},<=
br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SM3] =3D =
{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.setkey =3D (qcrypto_nettle_hmac_setkey)h=
mac_sm3_set_key,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.update =3D (qcrypto_nettl=
e_hmac_update)hmac_sm3_update,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.digest =3D =
(qcrypto_nettle_hmac_digest)hmac_sm3_digest,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0.len =3D SM3_DIGEST_SIZE,<br>+ =C2=A0 =C2=A0},<br>+#endif<br>=C2=A0};<br=
>=C2=A0<br>=C2=A0bool qcrypto_hmac_supports(QCryptoHashAlgo alg)<br>diff --=
git a/crypto/pbkdf-gcrypt.c b/crypto/pbkdf-gcrypt.c<br>index 76bbb55f7a..e8=
9b8b1c76 100644<br>--- a/crypto/pbkdf-gcrypt.c<br>+++ b/crypto/pbkdf-gcrypt=
.c<br>@@ -33,6 +33,9 @@ bool qcrypto_pbkdf2_supports(QCryptoHashAlgo hash)<=
br>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALGO_SHA384:<br>=C2=A0 =C2=A0 =C2=
=A0case QCRYPTO_HASH_ALGO_SHA512:<br>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_=
ALGO_RIPEMD160:<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0case QCRYPTO=
_HASH_ALGO_SM3:<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return qcry=
pto_hash_supports(hash);<br>=C2=A0 =C2=A0 =C2=A0default:<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0return false;<br>@@ -54,6 +57,9 @@ int qcrypto_pbkdf2(Q=
CryptoHashAlgo hash,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG=
O_SHA384] =3D GCRY_MD_SHA384,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO=
_HASH_ALGO_SHA512] =3D GCRY_MD_SHA512,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0[QCRYPTO_HASH_ALGO_RIPEMD160] =3D GCRY_MD_RMD160,<br>+#ifdef CONFIG_CRYP=
TO_SM3<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SM3] =3D GCRY_MD_=
SM3,<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0};<br>=C2=A0 =C2=A0 =C2=A0int ret;<b=
r>=C2=A0<br>diff --git a/crypto/pbkdf-nettle.c b/crypto/pbkdf-nettle.c<br>i=
ndex 93e686c2c6..3ef9c1b52c 100644<br>--- a/crypto/pbkdf-nettle.c<br>+++ b/=
crypto/pbkdf-nettle.c<br>@@ -34,6 +34,9 @@ bool qcrypto_pbkdf2_supports(QCr=
yptoHashAlgo hash)<br>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALGO_SHA384:<br=
>=C2=A0 =C2=A0 =C2=A0case QCRYPTO_HASH_ALGO_SHA512:<br>=C2=A0 =C2=A0 =C2=A0=
case QCRYPTO_HASH_ALGO_RIPEMD160:<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =
=C2=A0case QCRYPTO_HASH_ALGO_SM3:<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return true;<br>=C2=A0 =C2=A0 =C2=A0default:<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return false;<br>@@ -55,6 +58,9 @@ int qcrypto_pbkdf2(QCrypto=
HashAlgo hash,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sha384_ctx =
sha384;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sha512_ctx sha512;=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_ripemd160_ctx ripemd160;<=
br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hmac_sm=
3_ctx sm3;<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0} ctx;<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0if (iterations &gt; UINT_MAX) {<br>@@ -106,6 +112,13 @@ int qcryp=
to_pbkdf2(QCryptoHashAlgo hash,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0PBKDF2=
(&amp;ctx.ripemd160, hmac_ripemd160_update, hmac_ripemd160_digest,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RIPEMD160_DIGEST_SIZE,=
 iterations, nsalt, salt, nout, out);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
break;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0case QCRYPTO_HASH_ALG=
O_SM3:<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0hmac_sm3_set_key(&amp;ctx.sm3, nkey,=
 key);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0PBKDF2(&amp;ctx.sm3, hmac_sm3_update=
, hmac_sm3_digest,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SM=
3_DIGEST_SIZE, iterations, nsalt, salt, nout, out);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>+#endif<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0default:<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, ENOSYS,<br>diff --=
git a/include/crypto/hash.h b/include/crypto/hash.h<br>index 712cac79ee..18=
68d4a0f7 100644<br>--- a/include/crypto/hash.h<br>+++ b/include/crypto/hash=
.h<br>@@ -31,6 +31,7 @@<br>=C2=A0#define QCRYPTO_HASH_DIGEST_LEN_SHA384 =C2=
=A0 =C2=A048<br>=C2=A0#define QCRYPTO_HASH_DIGEST_LEN_SHA512 =C2=A0 =C2=A06=
4<br>=C2=A0#define QCRYPTO_HASH_DIGEST_LEN_RIPEMD160 20<br>+#define QCRYPTO=
_HASH_DIGEST_LEN_SM3 =C2=A0 =C2=A0 =C2=A0 32<br>=C2=A0<br>=C2=A0/* See also=
 &quot;QCryptoHashAlgo&quot; defined in qapi/crypto.json */<br>=C2=A0<br>di=
ff --git a/meson.build b/meson.build<br>index 85594fd3f1..611c13d182 100644=
<br>--- a/meson.build<br>+++ b/meson.build<br>@@ -1754,6 +1754,7 @@ gcrypt =
=3D not_found<br>=C2=A0nettle =3D not_found<br>=C2=A0hogweed =3D not_found<=
br>=C2=A0crypto_sm4 =3D not_found<br>+crypto_sm3 =3D not_found<br>=C2=A0xts=
 =3D &#39;none&#39;<br>=C2=A0<br>=C2=A0if get_option(&#39;nettle&#39;).enab=
led() and get_option(&#39;gcrypt&#39;).enabled()<br>@@ -1789,6 +1790,17 @@ =
if not gnutls_crypto.found()<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;=
, dependencies: gcrypt)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0crypto_sm4 =3D not_fo=
und<br>=C2=A0 =C2=A0 =C2=A0endif<br>+ =C2=A0 =C2=A0crypto_sm3 =3D gcrypt<br=
>+ =C2=A0 =C2=A0# SM3 ALG is available in libgcrypt &gt;=3D 1.8<br>+ =C2=A0=
 =C2=A0if gcrypt.found() and not cc.links(&#39;&#39;&#39;<br>+ =C2=A0 =C2=
=A0 =C2=A0#include &lt;gcrypt.h&gt;<br>+ =C2=A0 =C2=A0 =C2=A0int main(void)=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0gcry_md_hd_t handler;<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0gcry_md_open(&amp;handler, GCRY_MD_SM3, 0);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return 0;<br>+ =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;, depen=
dencies: gcrypt)<br>+ =C2=A0 =C2=A0 =C2=A0crypto_sm3 =3D not_found<br>+ =C2=
=A0 =C2=A0endif<br>=C2=A0 =C2=A0endif<br>=C2=A0 =C2=A0if (not get_option(&#=
39;nettle&#39;).auto() or have_system) and not gcrypt.found()<br>=C2=A0 =C2=
=A0 =C2=A0nettle =3D dependency(&#39;nettle&#39;, version: &#39;&gt;=3D3.4&=
#39;,<br>@@ -1809,6 +1821,31 @@ if not gnutls_crypto.found()<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;, dependencies: nettle)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0crypto_sm4 =3D not_found<br>=C2=A0 =C2=A0 =C2=A0endif<br>+ =C2=
=A0 =C2=A0crypto_sm3 =3D nettle<br>+ =C2=A0 =C2=A0# SM3 ALG is available in=
 nettle &gt;=3D 3.4<br>+ =C2=A0 =C2=A0if nettle.found() and not cc.links(&#=
39;&#39;&#39;<br>+ =C2=A0 =C2=A0 =C2=A0#include &lt;nettle/sm3.h&gt;<br>+ =
=C2=A0 =C2=A0 =C2=A0#include &lt;nettle/hmac.h&gt;<br>+ =C2=A0 =C2=A0 =C2=
=A0int main(void) {<br>+ =C2=A0 =C2=A0 =C2=A0struct sm3_ctx ctx;<br>+ =C2=
=A0 =C2=A0 =C2=A0struct hmac_sm3_ctx hmac_ctx;<br>+ =C2=A0 =C2=A0 =C2=A0uns=
igned char data[64] =3D {0};<br>+ =C2=A0 =C2=A0 =C2=A0unsigned char output[=
32];<br>+ =C2=A0 =C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0// SM3 hash function test<=
br>+ =C2=A0 =C2=A0 =C2=A0sm3_init(&amp;ctx);<br>+ =C2=A0 =C2=A0 =C2=A0sm3_u=
pdate(&amp;ctx, 64, data);<br>+ =C2=A0 =C2=A0 =C2=A0sm3_digest(&amp;ctx, 32=
, data);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0// HMAC-SM3 test<br>+ =C2=A0 =C2=A0 =
=C2=A0hmac_sm3_set_key(&amp;hmac_ctx, 32, data);<br>+ =C2=A0 =C2=A0 =C2=A0h=
mac_sm3_update(&amp;hmac_ctx, 64, data);<br>+ =C2=A0 =C2=A0 =C2=A0hmac_sm3_=
digest(&amp;hmac_ctx, 32, output);<br>+ =C2=A0 =C2=A0<br>+ =C2=A0 =C2=A0 =
=C2=A0return 0;<br>+ =C2=A0 =C2=A0 =C2=A0}&#39;&#39;&#39;, dependencies: ne=
ttle)<br>+ =C2=A0 =C2=A0 =C2=A0crypto_sm3 =3D not_found<br>+ =C2=A0 =C2=A0e=
ndif<br>=C2=A0 =C2=A0endif<br>=C2=A0endif<br>=C2=A0<br>@@ -2453,6 +2490,7 @=
@ config_host_data.set(&#39;CONFIG_TASN1&#39;, tasn1.found())<br>=C2=A0conf=
ig_host_data.set(&#39;CONFIG_GCRYPT&#39;, gcrypt.found())<br>=C2=A0config_h=
ost_data.set(&#39;CONFIG_NETTLE&#39;, nettle.found())<br>=C2=A0config_host_=
data.set(&#39;CONFIG_CRYPTO_SM4&#39;, crypto_sm4.found())<br>+config_host_d=
ata.set(&#39;CONFIG_CRYPTO_SM3&#39;, crypto_sm3.found())<br>=C2=A0config_ho=
st_data.set(&#39;CONFIG_HOGWEED&#39;, hogweed.found())<br>=C2=A0config_host=
_data.set(&#39;CONFIG_QEMU_PRIVATE_XTS&#39;, xts =3D=3D &#39;private&#39;)<=
br>=C2=A0config_host_data.set(&#39;CONFIG_MALLOC_TRIM&#39;, has_malloc_trim=
)<br>@@ -4578,6 +4616,7 @@ if nettle.found()<br>=C2=A0 =C2=A0 summary_info =
+=3D {&#39; =C2=A0XTS&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xts !=
=3D &#39;private&#39;}<br>=C2=A0endif<br>=C2=A0summary_info +=3D {&#39;SM4 =
ALG support&#39;: =C2=A0 crypto_sm4}<br>+summary_info +=3D {&#39;SM3 ALG su=
pport&#39;: =C2=A0 crypto_sm3}<br>=C2=A0summary_info +=3D {&#39;AF_ALG supp=
ort&#39;: =C2=A0 =C2=A0have_afalg}<br>=C2=A0summary_info +=3D {&#39;rng-non=
e&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_option(&#39;rng_none&#39;)}<b=
r>=C2=A0summary_info +=3D {&#39;Linux keyring&#39;: =C2=A0 =C2=A0 have_keyr=
ing}<br>diff --git a/qapi/crypto.json b/qapi/crypto.json<br>index 943152276=
8..3645a4649b 100644<br>--- a/qapi/crypto.json<br>+++ b/qapi/crypto.json<br=
>@@ -55,11 +55,12 @@<br>=C2=A0# @sha512: SHA-512. =C2=A0(since 2.7)<br>=C2=
=A0#<br>=C2=A0# @ripemd160: RIPEMD-160. =C2=A0(since 2.7)<br>+# @sm3: SM3. =
(since 8.2.0)<br>=C2=A0#<br>=C2=A0# Since: 2.6<br>=C2=A0##<br>=C2=A0{ &#39;=
enum&#39;: &#39;QCryptoHashAlgo&#39;,<br>- =C2=A0&#39;data&#39;: [&#39;md5&=
#39;, &#39;sha1&#39;, &#39;sha224&#39;, &#39;sha256&#39;, &#39;sha384&#39;,=
 &#39;sha512&#39;, &#39;ripemd160&#39;]}<br>+ =C2=A0&#39;data&#39;: [&#39;m=
d5&#39;, &#39;sha1&#39;, &#39;sha224&#39;, &#39;sha256&#39;, &#39;sha384&#3=
9;, &#39;sha512&#39;, &#39;ripemd160&#39;, &#39;sm3&#39;]}<br>=C2=A0<br>=C2=
=A0##<br>=C2=A0# @QCryptoCipherAlgo:<br>diff --git a/tests/unit/test-crypto=
-hash.c b/tests/unit/test-crypto-hash.c<br>index 76c4699c15..8fee1593f9 100=
644<br>--- a/tests/unit/test-crypto-hash.c<br>+++ b/tests/unit/test-crypto-=
hash.c<br>@@ -43,6 +43,9 @@<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;63b54e4cb2d2032b393994aa263c=
0dbb&quot; \<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;e00a9f2fe9ef6037352232a1eec55ee7&quot;<br>=C2=
=A0#define OUTPUT_RIPEMD160 &quot;f3d658fad3fdfb2b52c9369cf0d441249ddfa8a0&=
quot;<br>+#ifdef CONFIG_CRYPTO_SM3<br>+#define OUTPUT_SM3 &quot;d4a97db105b=
477b84c4f20ec9c31a6c814e2705a0b83a5a89748d75f0ef456a1&quot;<br>+#endif<br>=
=C2=A0<br>=C2=A0#define OUTPUT_MD5_B64 &quot;Yo0gY3FWMDWrjvYvSSveyQ=3D=3D&q=
uot;<br>=C2=A0#define OUTPUT_SHA1_B64 &quot;sudPJnWKOkIeUJzuBFJEt4dTzAI=3D&=
quot;<br>@@ -55,6 +58,10 @@<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;7sVe5w=3D=3D&q=
uot;<br>=C2=A0#define OUTPUT_RIPEMD160_B64 &quot;89ZY+tP9+ytSyTac8NRBJJ3fqK=
A=3D&quot;<br>=C2=A0<br>+#ifdef CONFIG_CRYPTO_SM3<br>+#define OUTPUT_SM3_B6=
4 &quot;1Kl9sQW0d7hMTyDsnDGmyBTicFoLg6Wol0jXXw70VqE=3D&quot;<br>+#endif<br>=
+<br>=C2=A0static const char *expected_outputs[] =3D {<br>=C2=A0 =C2=A0 =C2=
=A0[QCRYPTO_HASH_ALGO_MD5] =3D OUTPUT_MD5,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_=
HASH_ALGO_SHA1] =3D OUTPUT_SHA1,<br>@@ -63,6 +70,9 @@ static const char *ex=
pected_outputs[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA384] =
=3D OUTPUT_SHA384,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA512] =3D OU=
TPUT_SHA512,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_RIPEMD160] =3D OUTPU=
T_RIPEMD160,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HASH_A=
LGO_SM3] =3D OUTPUT_SM3,<br>+#endif<br>=C2=A0};<br>=C2=A0static const char =
*expected_outputs_b64[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_MD5=
] =3D OUTPUT_MD5_B64,<br>@@ -72,6 +82,9 @@ static const char *expected_outp=
uts_b64[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA384] =3D OUTPU=
T_SHA384_B64,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA512] =3D OUTPUT_=
SHA512_B64,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_RIPEMD160] =3D OUTPUT=
_RIPEMD160_B64,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPTO_HAS=
H_ALGO_SM3] =3D OUTPUT_SM3_B64,<br>+#endif<br>=C2=A0};<br>=C2=A0static cons=
t int expected_lens[] =3D {<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_MD5] =
=3D 16,<br>@@ -81,6 +94,9 @@ static const int expected_lens[] =3D {<br>=C2=
=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALGO_SHA384] =3D 48,<br>=C2=A0 =C2=A0 =C2=A0=
[QCRYPTO_HASH_ALGO_SHA512] =3D 64,<br>=C2=A0 =C2=A0 =C2=A0[QCRYPTO_HASH_ALG=
O_RIPEMD160] =3D 20,<br>+#ifdef CONFIG_CRYPTO_SM3<br>+ =C2=A0 =C2=A0[QCRYPT=
O_HASH_ALGO_SM3] =3D 32,<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0static c=
onst char hex[] =3D &quot;0123456789abcdef&quot;;<br>diff --git a/tests/uni=
t/test-crypto-hmac.c b/tests/unit/test-crypto-hmac.c<br>index cdb8774443..d=
8774bed01 100644<br>--- a/tests/unit/test-crypto-hmac.c<br>+++ b/tests/unit=
/test-crypto-hmac.c<br>@@ -76,6 +76,14 @@ static QCryptoHmacTestData test_d=
ata[] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;94964e=
d4c1155b62b668c241d67279e5&quot;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;8a711676&quot;,<br>=C2=A0 =C2=A0 =C2=A0},<br>+#ifdef CONFIG=
_CRYPTO_SM3<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.alg =3D QC=
RYPTO_HASH_ALGO_SM3,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.hex_digest =3D<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;760e3799332bc913819b93008536=
0ddb&quot;<br>+	 =C2=A0 =C2=A0&quot;c05529261313d5b15b75bab4fd7ae91e&quot;,=
<br>+ =C2=A0 =C2=A0},<br>+#endif<br>=C2=A0};<br>=C2=A0<br>=C2=A0static cons=
t char hex[] =3D &quot;0123456789abcdef&quot;;<br>diff --git a/tests/unit/t=
est-crypto-pbkdf.c b/tests/unit/test-crypto-pbkdf.c<br>index 12ee808fbc..06=
1a8da139 100644<br>--- a/tests/unit/test-crypto-pbkdf.c<br>+++ b/tests/unit=
/test-crypto-pbkdf.c<br>@@ -325,6 +325,22 @@ static QCryptoPbkdfTestData te=
st_data[] =3D {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
&quot;\xce\xbf\x91\x14\x8b\x5c\x48\x41&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0.nout =3D 32<br>=C2=A0 =C2=A0 =C2=A0},<br>+#ifdef CONFIG_CRYPTO_S=
M3<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.path =3D &quot;/cry=
pto/pbkdf/nonrfc/sm3/iter2&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.hash =3D=
 QCRYPTO_HASH_ALGO_SM3,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.iterations =3D 2,<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.key =3D &quot;password&quot;,<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0.nkey =3D 8,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.salt =3D =
&quot;ATHENA.MIT.EDUraeburn&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.nsalt =
=3D 21,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.out =3D &quot;\x48\x71\x1b\x58\xa3=
\xcb\xce\x06&quot;<br>+		&quot;\xba\xad\x77\xa8\xb5\xb9\xd8\x07&quot;<br>+	=
	&quot;\x6a\xe2\xb3\x5b\x95\xce\xc8\xce&quot;<br>+		&quot;\xe7\xb1\xcb\xee\=
x61\xdf\x04\xea&quot;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0.nout =3D 32<br>+ =
=C2=A0 =C2=A0},<br>+#endif<br>=C2=A0#if 0<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.path =3D &quot;/crypto/pbkdf/nonrfc/whirlpo=
ol/iter1200&quot;,<br>-- <br>2.33.0<br><br></div>

--00000000000090719406259c6b17--

