Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4352CCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFumK-0005wi-BK; Mon, 03 Nov 2025 08:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFumG-0005pT-Km
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:39:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFum4-0004Qz-TZ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=abBJDIunTJvrYpyxMj9h3VkaYZbvrHDOp7KTl753n9Q=;
 b=MxN2TQ/EDJBwRek+fR65EUVb4PmBFNEmvOSKxff/tMbTn4t/fRfxytZnIJNSfvCJZ+oGMg
 WGwLJ4zDk7zlR615rKIZsGf85ho+z2SKHayi8DmExnCX5i3JltbtDJtUCAwY2wRLcVHKhR
 nRVzzamhHXbSjmMr5oM20xbUgNudjFU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-xLuoNVC6PuSkq42TFxpS5Q-1; Mon,
 03 Nov 2025 08:39:03 -0500
X-MC-Unique: xLuoNVC6PuSkq42TFxpS5Q-1
X-Mimecast-MFC-AGG-ID: xLuoNVC6PuSkq42TFxpS5Q_1762177142
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 144BD180065F; Mon,  3 Nov 2025 13:39:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB37F1800578; Mon,  3 Nov 2025 13:38:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 11/32] crypto: drop in-tree XTS cipher mode impl
Date: Mon,  3 Nov 2025 13:37:05 +0000
Message-ID: <20251103133727.423041-12-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

nettle included XTS in 3.4.1, so with the new min version we
no longer require the in-tree XTS cipher mode impl.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher-nettle.c.inc   |  44 ---
 crypto/meson.build           |   3 -
 crypto/xts.c                 | 250 -----------------
 include/crypto/xts.h         |  82 ------
 meson.build                  |   8 -
 tests/unit/meson.build       |   3 -
 tests/unit/test-crypto-xts.c | 529 -----------------------------------
 7 files changed, 919 deletions(-)
 delete mode 100644 crypto/xts.c
 delete mode 100644 include/crypto/xts.h
 delete mode 100644 tests/unit/test-crypto-xts.c

diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
index ae91363772..1afdc391b4 100644
--- a/crypto/cipher-nettle.c.inc
+++ b/crypto/cipher-nettle.c.inc
@@ -18,10 +18,6 @@
  *
  */
 
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-#include "crypto/xts.h"
-#endif
-
 #include <nettle/nettle-types.h>
 #include <nettle/aes.h>
 #include <nettle/des.h>
@@ -30,9 +26,7 @@
 #include <nettle/serpent.h>
 #include <nettle/twofish.h>
 #include <nettle/ctr.h>
-#ifndef CONFIG_QEMU_PRIVATE_XTS
 #include <nettle/xts.h>
-#endif
 #ifdef CONFIG_CRYPTO_SM4
 #include <nettle/sm4.h>
 #endif
@@ -154,43 +148,6 @@ static const struct QCryptoCipherDriver NAME##_driver_ctr = {           \
 };
 
 
-#ifdef CONFIG_QEMU_PRIVATE_XTS
-#define DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                 \
-static void NAME##_xts_wrape(const void *ctx, size_t length,            \
-                             uint8_t *dst, const uint8_t *src)          \
-{                                                                       \
-    ENCRYPT((const void *)ctx, length, dst, src);                       \
-}                                                                       \
-static void NAME##_xts_wrapd(const void *ctx, size_t length,            \
-                             uint8_t *dst, const uint8_t *src)          \
-{                                                                       \
-    DECRYPT((const void *)ctx, length, dst, src);                       \
-}                                                                       \
-static int NAME##_encrypt_xts(QCryptoCipher *cipher, const void *in,    \
-                              void *out, size_t len, Error **errp)      \
-{                                                                       \
-    TYPE *ctx = container_of(cipher, TYPE, base);                       \
-    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
-        return -1;                                                      \
-    }                                                                   \
-    xts_encrypt(&ctx->key, &ctx->key_xts,                               \
-                NAME##_xts_wrape, NAME##_xts_wrapd,                     \
-                ctx->iv, len, out, in);                                 \
-    return 0;                                                           \
-}                                                                       \
-static int NAME##_decrypt_xts(QCryptoCipher *cipher, const void *in,    \
-                              void *out, size_t len, Error **errp)      \
-{                                                                       \
-    TYPE *ctx = container_of(cipher, TYPE, base);                       \
-    if (!qcrypto_length_check(len, BLEN, errp)) {                       \
-        return -1;                                                      \
-    }                                                                   \
-    xts_decrypt(&ctx->key, &ctx->key_xts,                               \
-                NAME##_xts_wrape, NAME##_xts_wrapd,                     \
-                ctx->iv, len, out, in);                                 \
-    return 0;                                                           \
-}
-#else
 #define DEFINE__XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)                 \
 static int NAME##_encrypt_xts(QCryptoCipher *cipher, const void *in,    \
                               void *out, size_t len, Error **errp)      \
@@ -214,7 +171,6 @@ static int NAME##_decrypt_xts(QCryptoCipher *cipher, const void *in,    \
                         ctx->iv, len, out, in);                         \
     return 0;                                                           \
 }
-#endif
 
 #define DEFINE_XTS(NAME, TYPE, BLEN, ENCRYPT, DECRYPT)          \
     QEMU_BUILD_BUG_ON(BLEN != XTS_BLOCK_SIZE);                  \
diff --git a/crypto/meson.build b/crypto/meson.build
index dd61ed9174..110c347033 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -33,9 +33,6 @@ if nettle.found()
   if hogweed.found()
     crypto_ss.add(gmp, hogweed)
   endif
-  if xts == 'private'
-    crypto_ss.add(files('xts.c'))
-  endif
 elif gcrypt.found()
   crypto_ss.add(gcrypt, files('hash-gcrypt.c', 'hmac-gcrypt.c', 'pbkdf-gcrypt.c'))
 elif gnutls.found()
diff --git a/crypto/xts.c b/crypto/xts.c
deleted file mode 100644
index d4a49fdb70..0000000000
--- a/crypto/xts.c
+++ /dev/null
@@ -1,250 +0,0 @@
-/*
- * QEMU Crypto XTS cipher mode
- *
- * Copyright (c) 2015-2016 Red Hat, Inc.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- *
- * This code is originally derived from public domain / WTFPL code in
- * LibTomCrypt crytographic library http://libtom.org. The XTS code
- * was donated by Elliptic Semiconductor Inc (www.ellipticsemi.com)
- * to the LibTom Projects
- *
- */
-
-#include "qemu/osdep.h"
-#include "qemu/bswap.h"
-#include "crypto/xts.h"
-
-typedef union {
-    uint8_t b[XTS_BLOCK_SIZE];
-    uint64_t u[2];
-} xts_uint128;
-
-static inline void xts_uint128_xor(xts_uint128 *D,
-                                   const xts_uint128 *S1,
-                                   const xts_uint128 *S2)
-{
-    D->u[0] = S1->u[0] ^ S2->u[0];
-    D->u[1] = S1->u[1] ^ S2->u[1];
-}
-
-static inline void xts_uint128_cpu_to_les(xts_uint128 *v)
-{
-    cpu_to_le64s(&v->u[0]);
-    cpu_to_le64s(&v->u[1]);
-}
-
-static inline void xts_uint128_le_to_cpus(xts_uint128 *v)
-{
-    le64_to_cpus(&v->u[0]);
-    le64_to_cpus(&v->u[1]);
-}
-
-static void xts_mult_x(xts_uint128 *I)
-{
-    uint64_t tt;
-
-    xts_uint128_le_to_cpus(I);
-
-    tt = I->u[0] >> 63;
-    I->u[0] <<= 1;
-
-    if (I->u[1] >> 63) {
-        I->u[0] ^= 0x87;
-    }
-    I->u[1] <<= 1;
-    I->u[1] |= tt;
-
-    xts_uint128_cpu_to_les(I);
-}
-
-
-/**
- * xts_tweak_encdec:
- * @param ctxt: the cipher context
- * @param func: the cipher function
- * @src: buffer providing the input text of XTS_BLOCK_SIZE bytes
- * @dst: buffer to output the output text of XTS_BLOCK_SIZE bytes
- * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
- *
- * Encrypt/decrypt data with a tweak
- */
-static inline void xts_tweak_encdec(const void *ctx,
-                                    xts_cipher_func *func,
-                                    const xts_uint128 *src,
-                                    xts_uint128 *dst,
-                                    xts_uint128 *iv)
-{
-    /* tweak encrypt block i */
-    xts_uint128_xor(dst, src, iv);
-
-    func(ctx, XTS_BLOCK_SIZE, dst->b, dst->b);
-
-    xts_uint128_xor(dst, dst, iv);
-
-    /* LFSR the tweak */
-    xts_mult_x(iv);
-}
-
-
-void xts_decrypt(const void *datactx,
-                 const void *tweakctx,
-                 xts_cipher_func *encfunc,
-                 xts_cipher_func *decfunc,
-                 uint8_t *iv,
-                 size_t length,
-                 uint8_t *dst,
-                 const uint8_t *src)
-{
-    xts_uint128 PP, CC, T;
-    unsigned long i, m, mo, lim;
-
-    /* get number of blocks */
-    m = length >> 4;
-    mo = length & 15;
-
-    /* must have at least one full block */
-    g_assert(m != 0);
-
-    if (mo == 0) {
-        lim = m;
-    } else {
-        lim = m - 1;
-    }
-
-    /* encrypt the iv */
-    encfunc(tweakctx, XTS_BLOCK_SIZE, T.b, iv);
-
-    if (QEMU_PTR_IS_ALIGNED(src, sizeof(uint64_t)) &&
-        QEMU_PTR_IS_ALIGNED(dst, sizeof(uint64_t))) {
-        xts_uint128 *S = (xts_uint128 *)src;
-        xts_uint128 *D = (xts_uint128 *)dst;
-        for (i = 0; i < lim; i++, S++, D++) {
-            xts_tweak_encdec(datactx, decfunc, S, D, &T);
-        }
-    } else {
-        xts_uint128 D;
-
-        for (i = 0; i < lim; i++) {
-            memcpy(&D, src, XTS_BLOCK_SIZE);
-            xts_tweak_encdec(datactx, decfunc, &D, &D, &T);
-            memcpy(dst, &D, XTS_BLOCK_SIZE);
-            src += XTS_BLOCK_SIZE;
-            dst += XTS_BLOCK_SIZE;
-        }
-    }
-
-    /* if length is not a multiple of XTS_BLOCK_SIZE then */
-    if (mo > 0) {
-        xts_uint128 S, D;
-        memcpy(&CC, &T, XTS_BLOCK_SIZE);
-        xts_mult_x(&CC);
-
-        /* PP = tweak decrypt block m-1 */
-        memcpy(&S, src, XTS_BLOCK_SIZE);
-        xts_tweak_encdec(datactx, decfunc, &S, &PP, &CC);
-
-        /* Pm = first length % XTS_BLOCK_SIZE bytes of PP */
-        for (i = 0; i < mo; i++) {
-            CC.b[i] = src[XTS_BLOCK_SIZE + i];
-            dst[XTS_BLOCK_SIZE + i] = PP.b[i];
-        }
-        for (; i < XTS_BLOCK_SIZE; i++) {
-            CC.b[i] = PP.b[i];
-        }
-
-        /* Pm-1 = Tweak uncrypt CC */
-        xts_tweak_encdec(datactx, decfunc, &CC, &D, &T);
-        memcpy(dst, &D, XTS_BLOCK_SIZE);
-    }
-
-    /* Decrypt the iv back */
-    decfunc(tweakctx, XTS_BLOCK_SIZE, iv, T.b);
-}
-
-
-void xts_encrypt(const void *datactx,
-                 const void *tweakctx,
-                 xts_cipher_func *encfunc,
-                 xts_cipher_func *decfunc,
-                 uint8_t *iv,
-                 size_t length,
-                 uint8_t *dst,
-                 const uint8_t *src)
-{
-    xts_uint128 PP, CC, T;
-    unsigned long i, m, mo, lim;
-
-    /* get number of blocks */
-    m = length >> 4;
-    mo = length & 15;
-
-    /* must have at least one full block */
-    g_assert(m != 0);
-
-    if (mo == 0) {
-        lim = m;
-    } else {
-        lim = m - 1;
-    }
-
-    /* encrypt the iv */
-    encfunc(tweakctx, XTS_BLOCK_SIZE, T.b, iv);
-
-    if (QEMU_PTR_IS_ALIGNED(src, sizeof(uint64_t)) &&
-        QEMU_PTR_IS_ALIGNED(dst, sizeof(uint64_t))) {
-        xts_uint128 *S = (xts_uint128 *)src;
-        xts_uint128 *D = (xts_uint128 *)dst;
-        for (i = 0; i < lim; i++, S++, D++) {
-            xts_tweak_encdec(datactx, encfunc, S, D, &T);
-        }
-    } else {
-        xts_uint128 D;
-
-        for (i = 0; i < lim; i++) {
-            memcpy(&D, src, XTS_BLOCK_SIZE);
-            xts_tweak_encdec(datactx, encfunc, &D, &D, &T);
-            memcpy(dst, &D, XTS_BLOCK_SIZE);
-
-            dst += XTS_BLOCK_SIZE;
-            src += XTS_BLOCK_SIZE;
-        }
-    }
-
-    /* if length is not a multiple of XTS_BLOCK_SIZE then */
-    if (mo > 0) {
-        xts_uint128 S, D;
-        /* CC = tweak encrypt block m-1 */
-        memcpy(&S, src, XTS_BLOCK_SIZE);
-        xts_tweak_encdec(datactx, encfunc, &S, &CC, &T);
-
-        /* Cm = first length % XTS_BLOCK_SIZE bytes of CC */
-        for (i = 0; i < mo; i++) {
-            PP.b[i] = src[XTS_BLOCK_SIZE + i];
-            dst[XTS_BLOCK_SIZE + i] = CC.b[i];
-        }
-
-        for (; i < XTS_BLOCK_SIZE; i++) {
-            PP.b[i] = CC.b[i];
-        }
-
-        /* Cm-1 = Tweak encrypt PP */
-        xts_tweak_encdec(datactx, encfunc, &PP, &D, &T);
-        memcpy(dst, &D, XTS_BLOCK_SIZE);
-    }
-
-    /* Decrypt the iv back */
-    decfunc(tweakctx, XTS_BLOCK_SIZE, iv, T.b);
-}
diff --git a/include/crypto/xts.h b/include/crypto/xts.h
deleted file mode 100644
index f267b7824a..0000000000
--- a/include/crypto/xts.h
+++ /dev/null
@@ -1,82 +0,0 @@
-/*
- * QEMU Crypto XTS cipher mode
- *
- * Copyright (c) 2015-2016 Red Hat, Inc.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- *
- * This code is originally derived from public domain / WTFPL code in
- * LibTomCrypt crytographic library http://libtom.org. The XTS code
- * was donated by Elliptic Semiconductor Inc (www.ellipticsemi.com)
- * to the LibTom Projects
- *
- */
-
-#ifndef QCRYPTO_XTS_H
-#define QCRYPTO_XTS_H
-
-
-#define XTS_BLOCK_SIZE 16
-
-typedef void xts_cipher_func(const void *ctx,
-                             size_t length,
-                             uint8_t *dst,
-                             const uint8_t *src);
-
-/**
- * xts_decrypt:
- * @datactx: the cipher context for data decryption
- * @tweakctx: the cipher context for tweak decryption
- * @encfunc: the cipher function for encryption
- * @decfunc: the cipher function for decryption
- * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
- * @length: the length of @dst and @src
- * @dst: buffer to hold the decrypted plaintext
- * @src: buffer providing the ciphertext
- *
- * Decrypts @src into @dst
- */
-void xts_decrypt(const void *datactx,
-                 const void *tweakctx,
-                 xts_cipher_func *encfunc,
-                 xts_cipher_func *decfunc,
-                 uint8_t *iv,
-                 size_t length,
-                 uint8_t *dst,
-                 const uint8_t *src);
-
-/**
- * xts_decrypt:
- * @datactx: the cipher context for data encryption
- * @tweakctx: the cipher context for tweak encryption
- * @encfunc: the cipher function for encryption
- * @decfunc: the cipher function for decryption
- * @iv: the initialization vector tweak of XTS_BLOCK_SIZE bytes
- * @length: the length of @dst and @src
- * @dst: buffer to hold the encrypted ciphertext
- * @src: buffer providing the plaintext
- *
- * Decrypts @src into @dst
- */
-void xts_encrypt(const void *datactx,
-                 const void *tweakctx,
-                 xts_cipher_func *encfunc,
-                 xts_cipher_func *decfunc,
-                 uint8_t *iv,
-                 size_t length,
-                 uint8_t *dst,
-                 const uint8_t *src);
-
-
-#endif /* QCRYPTO_XTS_H */
diff --git a/meson.build b/meson.build
index ad0aa6ccc0..b8c1296d3b 100644
--- a/meson.build
+++ b/meson.build
@@ -1846,7 +1846,6 @@ nettle = not_found
 hogweed = not_found
 crypto_sm4 = not_found
 crypto_sm3 = not_found
-xts = 'none'
 
 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
   error('Only one of gcrypt & nettle can be enabled')
@@ -1872,9 +1871,6 @@ if not gnutls.found()
     nettle = dependency('nettle', version: '>=3.7.3',
                         method: 'pkg-config',
                         required: get_option('nettle'))
-    if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
-      xts = 'private'
-    endif
     crypto_sm4 = nettle
     # SM4 ALG is available in nettle >= 3.9
     if nettle.found() and not cc.links('''
@@ -2566,7 +2562,6 @@ config_host_data.set('CONFIG_NETTLE', nettle.found())
 config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
 config_host_data.set('CONFIG_CRYPTO_SM3', crypto_sm3.found())
 config_host_data.set('CONFIG_HOGWEED', hogweed.found())
-config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
 config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
 config_host_data.set('CONFIG_ZSTD', zstd.found())
 config_host_data.set('CONFIG_QPL', qpl.found())
@@ -4862,9 +4857,6 @@ if gnutls.found()
 endif
 summary_info += {'libgcrypt':         gcrypt}
 summary_info += {'nettle':            nettle}
-if nettle.found()
-   summary_info += {'  XTS':             xts != 'private'}
-endif
 summary_info += {'SM4 ALG support':   crypto_sm4}
 summary_info += {'SM3 ALG support':   crypto_sm3}
 summary_info += {'AF_ALG support':    have_afalg}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d5248ae51d..bd58029060 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -110,9 +110,6 @@ if have_block
   if pam.found()
     tests += {'test-authz-pam': [authz]}
   endif
-  if xts == 'private'
-    tests += {'test-crypto-xts': [crypto, io]}
-  endif
   if host_os != 'windows'
     tests += {
       'test-image-locking': [testblock],
diff --git a/tests/unit/test-crypto-xts.c b/tests/unit/test-crypto-xts.c
deleted file mode 100644
index 7acbc956fd..0000000000
--- a/tests/unit/test-crypto-xts.c
+++ /dev/null
@@ -1,529 +0,0 @@
-/*
- * QEMU Crypto XTS cipher mode
- *
- * Copyright (c) 2015-2018 Red Hat, Inc.
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- *
- * This code is originally derived from public domain / WTFPL code in
- * LibTomCrypt crytographic library http://libtom.org. The XTS code
- * was donated by Elliptic Semiconductor Inc (www.ellipticsemi.com)
- * to the LibTom Projects
- *
- */
-
-#include "qemu/osdep.h"
-#include "crypto/init.h"
-#include "crypto/xts.h"
-#include "crypto/aes.h"
-
-typedef struct {
-    const char *path;
-    int keylen;
-    unsigned char key1[32];
-    unsigned char key2[32];
-    uint64_t seqnum;
-    unsigned long PTLEN;
-    unsigned char PTX[512], CTX[512];
-} QCryptoXTSTestData;
-
-static const QCryptoXTSTestData test_data[] = {
-    /* #1 32 byte key, 32 byte PTX */
-    {
-        "/crypto/xts/t-1-key-32-ptx-32",
-        32,
-        { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-        { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-        0,
-        32,
-        { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
-        { 0x91, 0x7c, 0xf6, 0x9e, 0xbd, 0x68, 0xb2, 0xec,
-          0x9b, 0x9f, 0xe9, 0xa3, 0xea, 0xdd, 0xa6, 0x92,
-          0xcd, 0x43, 0xd2, 0xf5, 0x95, 0x98, 0xed, 0x85,
-          0x8c, 0x02, 0xc2, 0x65, 0x2f, 0xbf, 0x92, 0x2e },
-    },
-
-    /* #2, 32 byte key, 32 byte PTX */
-    {
-        "/crypto/xts/t-2-key-32-ptx-32",
-        32,
-        { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11,
-          0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x11 },
-        { 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22,
-          0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22 },
-        0x3333333333LL,
-        32,
-        { 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
-          0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
-          0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
-          0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44 },
-        { 0xc4, 0x54, 0x18, 0x5e, 0x6a, 0x16, 0x93, 0x6e,
-          0x39, 0x33, 0x40, 0x38, 0xac, 0xef, 0x83, 0x8b,
-          0xfb, 0x18, 0x6f, 0xff, 0x74, 0x80, 0xad, 0xc4,
-          0x28, 0x93, 0x82, 0xec, 0xd6, 0xd3, 0x94, 0xf0 },
-    },
-
-    /* #5 from xts.7, 32 byte key, 32 byte PTX */
-    {
-        "/crypto/xts/t-5-key-32-ptx-32",
-        32,
-        { 0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
-          0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0 },
-        { 0xbf, 0xbe, 0xbd, 0xbc, 0xbb, 0xba, 0xb9, 0xb8,
-          0xb7, 0xb6, 0xb5, 0xb4, 0xb3, 0xb2, 0xb1, 0xb0 },
-        0x123456789aLL,
-        32,
-        { 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
-          0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
-          0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44,
-          0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44, 0x44 },
-        { 0xb0, 0x1f, 0x86, 0xf8, 0xed, 0xc1, 0x86, 0x37,
-          0x06, 0xfa, 0x8a, 0x42, 0x53, 0xe3, 0x4f, 0x28,
-          0xaf, 0x31, 0x9d, 0xe3, 0x83, 0x34, 0x87, 0x0f,
-          0x4d, 0xd1, 0xf9, 0x4c, 0xbe, 0x98, 0x32, 0xf1 },
-    },
-
-    /* #4, 32 byte key, 512 byte PTX  */
-    {
-        "/crypto/xts/t-4-key-32-ptx-512",
-        32,
-        { 0x27, 0x18, 0x28, 0x18, 0x28, 0x45, 0x90, 0x45,
-          0x23, 0x53, 0x60, 0x28, 0x74, 0x71, 0x35, 0x26 },
-        { 0x31, 0x41, 0x59, 0x26, 0x53, 0x58, 0x97, 0x93,
-          0x23, 0x84, 0x62, 0x64, 0x33, 0x83, 0x27, 0x95 },
-        0,
-        512,
-        {
-            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-            0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-            0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
-            0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
-            0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
-            0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
-            0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
-            0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
-            0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
-            0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
-            0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
-            0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
-            0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
-            0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
-            0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
-            0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
-            0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
-            0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
-            0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
-            0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
-            0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
-            0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
-            0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
-            0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
-            0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
-            0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
-            0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
-            0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
-            0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
-            0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
-            0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
-            0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
-            0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-            0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-            0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
-            0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
-            0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
-            0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d, 0x2e, 0x2f,
-            0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37,
-            0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
-            0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
-            0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f,
-            0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57,
-            0x58, 0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f,
-            0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
-            0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f,
-            0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77,
-            0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f,
-            0x80, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87,
-            0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f,
-            0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97,
-            0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f,
-            0xa0, 0xa1, 0xa2, 0xa3, 0xa4, 0xa5, 0xa6, 0xa7,
-            0xa8, 0xa9, 0xaa, 0xab, 0xac, 0xad, 0xae, 0xaf,
-            0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,
-            0xb8, 0xb9, 0xba, 0xbb, 0xbc, 0xbd, 0xbe, 0xbf,
-            0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc7,
-            0xc8, 0xc9, 0xca, 0xcb, 0xcc, 0xcd, 0xce, 0xcf,
-            0xd0, 0xd1, 0xd2, 0xd3, 0xd4, 0xd5, 0xd6, 0xd7,
-            0xd8, 0xd9, 0xda, 0xdb, 0xdc, 0xdd, 0xde, 0xdf,
-            0xe0, 0xe1, 0xe2, 0xe3, 0xe4, 0xe5, 0xe6, 0xe7,
-            0xe8, 0xe9, 0xea, 0xeb, 0xec, 0xed, 0xee, 0xef,
-            0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,
-            0xf8, 0xf9, 0xfa, 0xfb, 0xfc, 0xfd, 0xfe, 0xff,
-        },
-        {
-            0x27, 0xa7, 0x47, 0x9b, 0xef, 0xa1, 0xd4, 0x76,
-            0x48, 0x9f, 0x30, 0x8c, 0xd4, 0xcf, 0xa6, 0xe2,
-            0xa9, 0x6e, 0x4b, 0xbe, 0x32, 0x08, 0xff, 0x25,
-            0x28, 0x7d, 0xd3, 0x81, 0x96, 0x16, 0xe8, 0x9c,
-            0xc7, 0x8c, 0xf7, 0xf5, 0xe5, 0x43, 0x44, 0x5f,
-            0x83, 0x33, 0xd8, 0xfa, 0x7f, 0x56, 0x00, 0x00,
-            0x05, 0x27, 0x9f, 0xa5, 0xd8, 0xb5, 0xe4, 0xad,
-            0x40, 0xe7, 0x36, 0xdd, 0xb4, 0xd3, 0x54, 0x12,
-            0x32, 0x80, 0x63, 0xfd, 0x2a, 0xab, 0x53, 0xe5,
-            0xea, 0x1e, 0x0a, 0x9f, 0x33, 0x25, 0x00, 0xa5,
-            0xdf, 0x94, 0x87, 0xd0, 0x7a, 0x5c, 0x92, 0xcc,
-            0x51, 0x2c, 0x88, 0x66, 0xc7, 0xe8, 0x60, 0xce,
-            0x93, 0xfd, 0xf1, 0x66, 0xa2, 0x49, 0x12, 0xb4,
-            0x22, 0x97, 0x61, 0x46, 0xae, 0x20, 0xce, 0x84,
-            0x6b, 0xb7, 0xdc, 0x9b, 0xa9, 0x4a, 0x76, 0x7a,
-            0xae, 0xf2, 0x0c, 0x0d, 0x61, 0xad, 0x02, 0x65,
-            0x5e, 0xa9, 0x2d, 0xc4, 0xc4, 0xe4, 0x1a, 0x89,
-            0x52, 0xc6, 0x51, 0xd3, 0x31, 0x74, 0xbe, 0x51,
-            0xa1, 0x0c, 0x42, 0x11, 0x10, 0xe6, 0xd8, 0x15,
-            0x88, 0xed, 0xe8, 0x21, 0x03, 0xa2, 0x52, 0xd8,
-            0xa7, 0x50, 0xe8, 0x76, 0x8d, 0xef, 0xff, 0xed,
-            0x91, 0x22, 0x81, 0x0a, 0xae, 0xb9, 0x9f, 0x91,
-            0x72, 0xaf, 0x82, 0xb6, 0x04, 0xdc, 0x4b, 0x8e,
-            0x51, 0xbc, 0xb0, 0x82, 0x35, 0xa6, 0xf4, 0x34,
-            0x13, 0x32, 0xe4, 0xca, 0x60, 0x48, 0x2a, 0x4b,
-            0xa1, 0xa0, 0x3b, 0x3e, 0x65, 0x00, 0x8f, 0xc5,
-            0xda, 0x76, 0xb7, 0x0b, 0xf1, 0x69, 0x0d, 0xb4,
-            0xea, 0xe2, 0x9c, 0x5f, 0x1b, 0xad, 0xd0, 0x3c,
-            0x5c, 0xcf, 0x2a, 0x55, 0xd7, 0x05, 0xdd, 0xcd,
-            0x86, 0xd4, 0x49, 0x51, 0x1c, 0xeb, 0x7e, 0xc3,
-            0x0b, 0xf1, 0x2b, 0x1f, 0xa3, 0x5b, 0x91, 0x3f,
-            0x9f, 0x74, 0x7a, 0x8a, 0xfd, 0x1b, 0x13, 0x0e,
-            0x94, 0xbf, 0xf9, 0x4e, 0xff, 0xd0, 0x1a, 0x91,
-            0x73, 0x5c, 0xa1, 0x72, 0x6a, 0xcd, 0x0b, 0x19,
-            0x7c, 0x4e, 0x5b, 0x03, 0x39, 0x36, 0x97, 0xe1,
-            0x26, 0x82, 0x6f, 0xb6, 0xbb, 0xde, 0x8e, 0xcc,
-            0x1e, 0x08, 0x29, 0x85, 0x16, 0xe2, 0xc9, 0xed,
-            0x03, 0xff, 0x3c, 0x1b, 0x78, 0x60, 0xf6, 0xde,
-            0x76, 0xd4, 0xce, 0xcd, 0x94, 0xc8, 0x11, 0x98,
-            0x55, 0xef, 0x52, 0x97, 0xca, 0x67, 0xe9, 0xf3,
-            0xe7, 0xff, 0x72, 0xb1, 0xe9, 0x97, 0x85, 0xca,
-            0x0a, 0x7e, 0x77, 0x20, 0xc5, 0xb3, 0x6d, 0xc6,
-            0xd7, 0x2c, 0xac, 0x95, 0x74, 0xc8, 0xcb, 0xbc,
-            0x2f, 0x80, 0x1e, 0x23, 0xe5, 0x6f, 0xd3, 0x44,
-            0xb0, 0x7f, 0x22, 0x15, 0x4b, 0xeb, 0xa0, 0xf0,
-            0x8c, 0xe8, 0x89, 0x1e, 0x64, 0x3e, 0xd9, 0x95,
-            0xc9, 0x4d, 0x9a, 0x69, 0xc9, 0xf1, 0xb5, 0xf4,
-            0x99, 0x02, 0x7a, 0x78, 0x57, 0x2a, 0xee, 0xbd,
-            0x74, 0xd2, 0x0c, 0xc3, 0x98, 0x81, 0xc2, 0x13,
-            0xee, 0x77, 0x0b, 0x10, 0x10, 0xe4, 0xbe, 0xa7,
-            0x18, 0x84, 0x69, 0x77, 0xae, 0x11, 0x9f, 0x7a,
-            0x02, 0x3a, 0xb5, 0x8c, 0xca, 0x0a, 0xd7, 0x52,
-            0xaf, 0xe6, 0x56, 0xbb, 0x3c, 0x17, 0x25, 0x6a,
-            0x9f, 0x6e, 0x9b, 0xf1, 0x9f, 0xdd, 0x5a, 0x38,
-            0xfc, 0x82, 0xbb, 0xe8, 0x72, 0xc5, 0x53, 0x9e,
-            0xdb, 0x60, 0x9e, 0xf4, 0xf7, 0x9c, 0x20, 0x3e,
-            0xbb, 0x14, 0x0f, 0x2e, 0x58, 0x3c, 0xb2, 0xad,
-            0x15, 0xb4, 0xaa, 0x5b, 0x65, 0x50, 0x16, 0xa8,
-            0x44, 0x92, 0x77, 0xdb, 0xd4, 0x77, 0xef, 0x2c,
-            0x8d, 0x6c, 0x01, 0x7d, 0xb7, 0x38, 0xb1, 0x8d,
-            0xeb, 0x4a, 0x42, 0x7d, 0x19, 0x23, 0xce, 0x3f,
-            0xf2, 0x62, 0x73, 0x57, 0x79, 0xa4, 0x18, 0xf2,
-            0x0a, 0x28, 0x2d, 0xf9, 0x20, 0x14, 0x7b, 0xea,
-            0xbe, 0x42, 0x1e, 0xe5, 0x31, 0x9d, 0x05, 0x68,
-        }
-    },
-
-    /* #7, 32 byte key, 17 byte PTX */
-    {
-        "/crypto/xts/t-7-key-32-ptx-17",
-        32,
-        { 0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
-          0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0 },
-        { 0xbf, 0xbe, 0xbd, 0xbc, 0xbb, 0xba, 0xb9, 0xb8,
-          0xb7, 0xb6, 0xb5, 0xb4, 0xb3, 0xb2, 0xb1, 0xb0 },
-        0x123456789aLL,
-        17,
-        { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-          0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10 },
-        { 0x6c, 0x16, 0x25, 0xdb, 0x46, 0x71, 0x52, 0x2d,
-          0x3d, 0x75, 0x99, 0x60, 0x1d, 0xe7, 0xca, 0x09, 0xed },
-    },
-
-    /* #15, 32 byte key, 25 byte PTX */
-    {
-        "/crypto/xts/t-15-key-32-ptx-25",
-        32,
-        { 0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
-          0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0 },
-        { 0xbf, 0xbe, 0xbd, 0xbc, 0xbb, 0xba, 0xb9, 0xb8,
-          0xb7, 0xb6, 0xb5, 0xb4, 0xb3, 0xb2, 0xb1, 0xb0 },
-        0x123456789aLL,
-        25,
-        { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-          0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-          0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18 },
-        { 0x8f, 0x4d, 0xcb, 0xad, 0x55, 0x55, 0x8d, 0x7b,
-          0x4e, 0x01, 0xd9, 0x37, 0x9c, 0xd4, 0xea, 0x22,
-          0xed, 0xbf, 0x9d, 0xac, 0xe4, 0x5d, 0x6f, 0x6a, 0x73 },
-    },
-
-    /* #21, 32 byte key, 31 byte PTX */
-    {
-        "/crypto/xts/t-21-key-32-ptx-31",
-        32,
-        { 0xff, 0xfe, 0xfd, 0xfc, 0xfb, 0xfa, 0xf9, 0xf8,
-          0xf7, 0xf6, 0xf5, 0xf4, 0xf3, 0xf2, 0xf1, 0xf0 },
-        { 0xbf, 0xbe, 0xbd, 0xbc, 0xbb, 0xba, 0xb9, 0xb8,
-          0xb7, 0xb6, 0xb5, 0xb4, 0xb3, 0xb2, 0xb1, 0xb0 },
-        0x123456789aLL,
-        31,
-        { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-          0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
-          0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
-          0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e },
-        { 0xd0, 0x5b, 0xc0, 0x90, 0xa8, 0xe0, 0x4f, 0x1b,
-          0x3d, 0x3e, 0xcd, 0xd5, 0xba, 0xec, 0x0f, 0xd4,
-          0xed, 0xbf, 0x9d, 0xac, 0xe4, 0x5d, 0x6f, 0x6a,
-          0x73, 0x06, 0xe6, 0x4b, 0xe5, 0xdd, 0x82 },
-    },
-};
-
-#define STORE64L(x, y)                                                  \
-    do {                                                                \
-        (y)[7] = (unsigned char)(((x) >> 56) & 255);                    \
-        (y)[6] = (unsigned char)(((x) >> 48) & 255);                    \
-        (y)[5] = (unsigned char)(((x) >> 40) & 255);                    \
-        (y)[4] = (unsigned char)(((x) >> 32) & 255);                    \
-        (y)[3] = (unsigned char)(((x) >> 24) & 255);                    \
-        (y)[2] = (unsigned char)(((x) >> 16) & 255);                    \
-        (y)[1] = (unsigned char)(((x) >> 8) & 255);                     \
-        (y)[0] = (unsigned char)((x) & 255);                            \
-    } while (0)
-
-struct TestAES {
-    AES_KEY enc;
-    AES_KEY dec;
-};
-
-static void test_xts_aes_encrypt(const void *ctx,
-                                 size_t length,
-                                 uint8_t *dst,
-                                 const uint8_t *src)
-{
-    const struct TestAES *aesctx = ctx;
-
-    AES_encrypt(src, dst, &aesctx->enc);
-}
-
-
-static void test_xts_aes_decrypt(const void *ctx,
-                                 size_t length,
-                                 uint8_t *dst,
-                                 const uint8_t *src)
-{
-    const struct TestAES *aesctx = ctx;
-
-    AES_decrypt(src, dst, &aesctx->dec);
-}
-
-
-static void test_xts(const void *opaque)
-{
-    const QCryptoXTSTestData *data = opaque;
-    uint8_t out[512], Torg[16], T[16];
-    uint64_t seq;
-    struct TestAES aesdata;
-    struct TestAES aestweak;
-
-    AES_set_encrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.enc);
-    AES_set_decrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.dec);
-    AES_set_encrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.enc);
-    AES_set_decrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.dec);
-
-    seq = data->seqnum;
-    STORE64L(seq, Torg);
-    memset(Torg + 8, 0, 8);
-
-    memcpy(T, Torg, sizeof(T));
-    xts_encrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, data->PTLEN, out, data->PTX);
-
-    g_assert(memcmp(out, data->CTX, data->PTLEN) == 0);
-
-    memcpy(T, Torg, sizeof(T));
-    xts_decrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, data->PTLEN, out, data->CTX);
-
-    g_assert(memcmp(out, data->PTX, data->PTLEN) == 0);
-}
-
-
-static void test_xts_split(const void *opaque)
-{
-    const QCryptoXTSTestData *data = opaque;
-    uint8_t out[512], Torg[16], T[16];
-    uint64_t seq;
-    unsigned long len = data->PTLEN / 2;
-    struct TestAES aesdata;
-    struct TestAES aestweak;
-
-    AES_set_encrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.enc);
-    AES_set_decrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.dec);
-    AES_set_encrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.enc);
-    AES_set_decrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.dec);
-
-    seq = data->seqnum;
-    STORE64L(seq, Torg);
-    memset(Torg + 8, 0, 8);
-
-    memcpy(T, Torg, sizeof(T));
-    xts_encrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, len, out, data->PTX);
-    xts_encrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, len, &out[len], &data->PTX[len]);
-
-    g_assert(memcmp(out, data->CTX, data->PTLEN) == 0);
-
-    memcpy(T, Torg, sizeof(T));
-    xts_decrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, len, out, data->CTX);
-    xts_decrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, len, &out[len], &data->CTX[len]);
-
-    g_assert(memcmp(out, data->PTX, data->PTLEN) == 0);
-}
-
-
-static void test_xts_unaligned(const void *opaque)
-{
-#define BAD_ALIGN 3
-    const QCryptoXTSTestData *data = opaque;
-    uint8_t in[512 + BAD_ALIGN], out[512 + BAD_ALIGN];
-    uint8_t Torg[16], T[16 + BAD_ALIGN];
-    uint64_t seq;
-    struct TestAES aesdata;
-    struct TestAES aestweak;
-
-    AES_set_encrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.enc);
-    AES_set_decrypt_key(data->key1, data->keylen / 2 * 8, &aesdata.dec);
-    AES_set_encrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.enc);
-    AES_set_decrypt_key(data->key2, data->keylen / 2 * 8, &aestweak.dec);
-
-    seq = data->seqnum;
-    STORE64L(seq, Torg);
-    memset(Torg + 8, 0, 8);
-
-    /* IV not aligned */
-    memcpy(T + BAD_ALIGN, Torg, 16);
-    memcpy(in, data->PTX, data->PTLEN);
-    xts_encrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T + BAD_ALIGN, data->PTLEN, out, in);
-
-    g_assert(memcmp(out, data->CTX, data->PTLEN) == 0);
-
-    /* plain text not aligned */
-    memcpy(T, Torg, 16);
-    memcpy(in + BAD_ALIGN, data->PTX, data->PTLEN);
-    xts_encrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, data->PTLEN, out, in + BAD_ALIGN);
-
-    g_assert(memcmp(out, data->CTX, data->PTLEN) == 0);
-
-    /* cipher text not aligned */
-    memcpy(T, Torg, 16);
-    memcpy(in, data->PTX, data->PTLEN);
-    xts_encrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, data->PTLEN, out + BAD_ALIGN, in);
-
-    g_assert(memcmp(out + BAD_ALIGN, data->CTX, data->PTLEN) == 0);
-
-
-    /* IV not aligned */
-    memcpy(T + BAD_ALIGN, Torg, 16);
-    memcpy(in, data->CTX, data->PTLEN);
-    xts_decrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T + BAD_ALIGN, data->PTLEN, out, in);
-
-    g_assert(memcmp(out, data->PTX, data->PTLEN) == 0);
-
-    /* cipher text not aligned */
-    memcpy(T, Torg, 16);
-    memcpy(in + BAD_ALIGN, data->CTX, data->PTLEN);
-    xts_decrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, data->PTLEN, out, in + BAD_ALIGN);
-
-    g_assert(memcmp(out, data->PTX, data->PTLEN) == 0);
-
-    /* plain text not aligned */
-    memcpy(T, Torg, 16);
-    memcpy(in, data->CTX, data->PTLEN);
-    xts_decrypt(&aesdata, &aestweak,
-                test_xts_aes_encrypt,
-                test_xts_aes_decrypt,
-                T, data->PTLEN, out + BAD_ALIGN, in);
-
-    g_assert(memcmp(out + BAD_ALIGN, data->PTX, data->PTLEN) == 0);
-}
-
-
-int main(int argc, char **argv)
-{
-    size_t i;
-
-    g_test_init(&argc, &argv, NULL);
-
-    g_assert(qcrypto_init(NULL) == 0);
-
-    for (i = 0; i < G_N_ELEMENTS(test_data); i++) {
-        gchar *path = g_strdup_printf("%s/basic", test_data[i].path);
-        g_test_add_data_func(path, &test_data[i], test_xts);
-        g_free(path);
-
-        /* skip the cases where the length is smaller than 2*blocklen
-         * or the length is not a multiple of 32
-         */
-        if ((test_data[i].PTLEN >= 32) && !(test_data[i].PTLEN % 32)) {
-            path = g_strdup_printf("%s/split", test_data[i].path);
-            g_test_add_data_func(path, &test_data[i], test_xts_split);
-            g_free(path);
-        }
-
-        path = g_strdup_printf("%s/unaligned", test_data[i].path);
-        g_test_add_data_func(path, &test_data[i], test_xts_unaligned);
-        g_free(path);
-    }
-
-    return g_test_run();
-}
-- 
2.51.1


