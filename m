Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BDDC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 14:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCfbh-000706-Fl; Wed, 07 May 2025 10:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCfbf-0006zg-F8
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:18:43 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCfbc-0002j5-RG
 for qemu-devel@nongnu.org; Wed, 07 May 2025 10:18:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f62d3ed994so6857268a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746627519; x=1747232319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tR8BKMFGSxCBZqpOTRIjDuS9974kg3np7n8OmCIHbXI=;
 b=mges3nxMNqu8/wfhjuGscVHmFRKlj/ywgjjjWDbjif/cO96Hp9Pdb2UE88yNf5iI+q
 jqew1hf/2KYS7qhNYqjt8QGzprSbacKItbLhR/Qy9Dml2eanclYg2ezYVpToHYlSCV/B
 8w3dTLHT1fmn4VZe+qORvA4Xo5OBx4DEaO6E5XPEuvrmyNTz7XwbF5Bb/whb9bSd9PB4
 3t9c3YmI3xOqKr3GwVpvtUVFfSYLgaPPXC7mlK0JIYcOG+f04oZ+cgPbVXjra6x74Iv9
 Ye4o6CRpVVcboX3S1QU6XXsaxUOjpk9yyxU0bJNlhYtGJN88pCo7boZHjY/oAh9OSWWb
 Gekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746627519; x=1747232319;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tR8BKMFGSxCBZqpOTRIjDuS9974kg3np7n8OmCIHbXI=;
 b=ZgNWQaZ32XwY05306jbKw7B/rnL6lNSX4suhDgjXEj4pfm638a3I0icgXLtzUglX88
 Jt9+MEffP6VXj8SAoD0/7OEFVjRZkODh9I/k+605OdZP0inL5Rp6vUcKG6opqEqloVaY
 ArF3PFAUkvJKwz5F4cTzsRpGcmhcirtlsQzsyKnqke0Gz5WG1IY6osjE+qNhZxTRARlL
 MtVF5wyAEI8mun4OdwD6gYeOZvU99Ty8FnESTYRNz38C+RVchkf+hc91nrlCdYTecL+d
 uIzkXoiyFUUbq5VYpPF/naTTwEFdJvxdXMYjIbSkSmGY24HtL2qbWLG9FzPb7Cm9QyKw
 9UwQ==
X-Gm-Message-State: AOJu0Yw5VXWvu7CpxEk+PbxYixYmz6sjSQbJc0McP0FrwRvdaCG+8SQI
 WgrflF1XmPkwctLskmi9gNNUaCxu6ifgUrXS9kCpWIoEynDbHUHRSfjSB4HCZ6x/a7VUVxoFH1C
 1oJg=
X-Gm-Gg: ASbGncv2yBTBgAYspZlraQf0dYm3pK79siIzoszqvsKE7KOwtHCg6VQqXDvV6UiWiwi
 /MjkrYSzUUboVh6HfPf0MpGsVbo9bsJTV4cQ6sJ6fIJLLRwgBIOdHI9Qw/mI0XoBGyJDq8/SJ+z
 5cnKWPiiP+lTmGq2SLpMRoD2XY9eGxoPnS30wiKJKc8u29DF4o3npZW0lXMeoWUH0qLbqGPIppv
 +8C170swi2gg86PxDYjGe+KERaTA0uiwEUEvvmGkXQOzUAuBV/whuVNiP+Hwh3wOO1LPZ70Y+8W
 4w12rrmuuVtqiU87ev/yB1Dge6d51j/bJcpaY9noNJA=
X-Google-Smtp-Source: AGHT+IFTutzWKKa6A7nPzPgJGMc+jP+FpYL/dpoJApOiJwKfALxUTYDsKVpruq47NKKY+oElWlipmQ==
X-Received: by 2002:a17:907:9814:b0:ac3:8988:deda with SMTP id
 a640c23a62f3a-ad1e8d0559cmr358659566b.40.1746627518531; 
 Wed, 07 May 2025 07:18:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189146a30sm910131666b.30.2025.05.07.07.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 07:18:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 199795F858;
 Wed,  7 May 2025 15:18:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] crypto: fully drop built-in cipher provider
In-Reply-To: <20250507100430.150360-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 7 May 2025 11:04:30 +0100")
References: <20250507100430.150360-1-berrange@redhat.com>
User-Agent: mu4e 1.12.10; emacs 30.1
Date: Wed, 07 May 2025 15:18:37 +0100
Message-ID: <87h61wo66a.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When originally creating the internal crypto cipher APIs, they were
> wired up to use the built-in D3DES and AES implementations, as a way
> to gracefully transition to the new APIs without introducing an
> immediate hard dep on any external crypto libraries for the VNC
> password auth (D3DES) or the qcow2 encryption (AES).
>
> In the 6.1.0 release we dropped the built-in D3DES impl, and also
> the XTS mode for the AES impl, leaving only AES with ECB/CBC modes.
> The rational was that with the system emulators, it is expected that
> 3rd party crypto libraries will be available.
>
> The qcow2 LUKS impl is preferred to the legacy raw AES impl, and by
> default that requires AES in XTS mode, limiting the usefulness of
> the built-in cipher provider.
>
> The built-in AES impl has known timing attacks and is only suitable
> for use cases where a security boundary is already not expected to
> be provided (TCG).
>
> Providing a built-in cipher impl thus potentially misleads users,
> should they configure a QEMU without any crypto library, and try
> to use it with the LUKS backend, even if that requires a non-default
> configuration choice.
>
> Complete what we started in 6.1.0 and purge the remaining AES
> support.
>
> Use of either gnutls, nettle, or libcrypt is now mandatory for any
> cipher support, except for TCG impls.

Building with:

  # Configured with: '../../configure' '--disable-docs' '--extra-ldflags=3D=
-gsplit-dwarf' '--target-list=3Dx86_64-softmmu,aarch64-softmmu' '--enable-d=
ebug-info' '--disable-gcrypt' '--disable-nettle' '--disable-gnutls'

This now triggers:

Summary of Failures:

  1/102 qemu:unit / test-crypto-block           ERROR            0.00s   ki=
lled by signal 6 SIGABRT
 65/102 qemu:unit / test-crypto-cipher          ERROR            0.00s   ki=
lled by signal 6 SIGABRT
 67/102 qemu:unit / test-crypto-secret          ERROR            0.01s   ki=
lled by signal 6 SIGABRT

I can see test-crypto-block tries to skip TEST_LUKS is we haven't
enabled any cipher libraries but it looks like some tests still get run
and fail.

But at least I can tell it does what is advertised:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  crypto/cipher-builtin.c.inc | 303 ------------------------------------
>  crypto/cipher-stub.c.inc    |  41 +++++
>  crypto/cipher.c             |   2 +-
>  3 files changed, 42 insertions(+), 304 deletions(-)
>  delete mode 100644 crypto/cipher-builtin.c.inc
>  create mode 100644 crypto/cipher-stub.c.inc
>
> diff --git a/crypto/cipher-builtin.c.inc b/crypto/cipher-builtin.c.inc
> deleted file mode 100644
> index da5fcbd9a3..0000000000
> --- a/crypto/cipher-builtin.c.inc
> +++ /dev/null
> @@ -1,303 +0,0 @@
> -/*
> - * QEMU Crypto cipher built-in algorithms
> - *
> - * Copyright (c) 2015 Red Hat, Inc.
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> - *
> - */
> -
> -#include "crypto/aes.h"
> -
> -typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESCon=
text;
> -struct QCryptoCipherBuiltinAESContext {
> -    AES_KEY enc;
> -    AES_KEY dec;
> -};
> -
> -typedef struct QCryptoCipherBuiltinAES QCryptoCipherBuiltinAES;
> -struct QCryptoCipherBuiltinAES {
> -    QCryptoCipher base;
> -    QCryptoCipherBuiltinAESContext key;
> -    uint8_t iv[AES_BLOCK_SIZE];
> -};
> -
> -
> -static inline bool qcrypto_length_check(size_t len, size_t blocksize,
> -                                        Error **errp)
> -{
> -    if (unlikely(len & (blocksize - 1))) {
> -        error_setg(errp, "Length %zu must be a multiple of block size %z=
u",
> -                   len, blocksize);
> -        return false;
> -    }
> -    return true;
> -}
> -
> -static void qcrypto_cipher_ctx_free(QCryptoCipher *cipher)
> -{
> -    g_free(cipher);
> -}
> -
> -static int qcrypto_cipher_no_setiv(QCryptoCipher *cipher,
> -                                   const uint8_t *iv, size_t niv,
> -                                   Error **errp)
> -{
> -    error_setg(errp, "Setting IV is not supported");
> -    return -1;
> -}
> -
> -static void do_aes_encrypt_ecb(const void *vctx,
> -                               size_t len,
> -                               uint8_t *out,
> -                               const uint8_t *in)
> -{
> -    const QCryptoCipherBuiltinAESContext *ctx =3D vctx;
> -
> -    /* We have already verified that len % AES_BLOCK_SIZE =3D=3D 0. */
> -    while (len) {
> -        AES_encrypt(in, out, &ctx->enc);
> -        in +=3D AES_BLOCK_SIZE;
> -        out +=3D AES_BLOCK_SIZE;
> -        len -=3D AES_BLOCK_SIZE;
> -    }
> -}
> -
> -static void do_aes_decrypt_ecb(const void *vctx,
> -                               size_t len,
> -                               uint8_t *out,
> -                               const uint8_t *in)
> -{
> -    const QCryptoCipherBuiltinAESContext *ctx =3D vctx;
> -
> -    /* We have already verified that len % AES_BLOCK_SIZE =3D=3D 0. */
> -    while (len) {
> -        AES_decrypt(in, out, &ctx->dec);
> -        in +=3D AES_BLOCK_SIZE;
> -        out +=3D AES_BLOCK_SIZE;
> -        len -=3D AES_BLOCK_SIZE;
> -    }
> -}
> -
> -static void do_aes_encrypt_cbc(const AES_KEY *key,
> -                               size_t len,
> -                               uint8_t *out,
> -                               const uint8_t *in,
> -                               uint8_t *ivec)
> -{
> -    uint8_t tmp[AES_BLOCK_SIZE];
> -    size_t n;
> -
> -    /* We have already verified that len % AES_BLOCK_SIZE =3D=3D 0. */
> -    while (len) {
> -        for (n =3D 0; n < AES_BLOCK_SIZE; ++n) {
> -            tmp[n] =3D in[n] ^ ivec[n];
> -        }
> -        AES_encrypt(tmp, out, key);
> -        memcpy(ivec, out, AES_BLOCK_SIZE);
> -        len -=3D AES_BLOCK_SIZE;
> -        in +=3D AES_BLOCK_SIZE;
> -        out +=3D AES_BLOCK_SIZE;
> -    }
> -}
> -
> -static void do_aes_decrypt_cbc(const AES_KEY *key,
> -                               size_t len,
> -                               uint8_t *out,
> -                               const uint8_t *in,
> -                               uint8_t *ivec)
> -{
> -    uint8_t tmp[AES_BLOCK_SIZE];
> -    size_t n;
> -
> -    /* We have already verified that len % AES_BLOCK_SIZE =3D=3D 0. */
> -    while (len) {
> -        memcpy(tmp, in, AES_BLOCK_SIZE);
> -        AES_decrypt(in, out, key);
> -        for (n =3D 0; n < AES_BLOCK_SIZE; ++n) {
> -            out[n] ^=3D ivec[n];
> -        }
> -        memcpy(ivec, tmp, AES_BLOCK_SIZE);
> -        len -=3D AES_BLOCK_SIZE;
> -        in +=3D AES_BLOCK_SIZE;
> -        out +=3D AES_BLOCK_SIZE;
> -    }
> -}
> -
> -static int qcrypto_cipher_aes_encrypt_ecb(QCryptoCipher *cipher,
> -                                          const void *in, void *out,
> -                                          size_t len, Error **errp)
> -{
> -    QCryptoCipherBuiltinAES *ctx
> -        =3D container_of(cipher, QCryptoCipherBuiltinAES, base);
> -
> -    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
> -        return -1;
> -    }
> -    do_aes_encrypt_ecb(&ctx->key, len, out, in);
> -    return 0;
> -}
> -
> -static int qcrypto_cipher_aes_decrypt_ecb(QCryptoCipher *cipher,
> -                                          const void *in, void *out,
> -                                          size_t len, Error **errp)
> -{
> -    QCryptoCipherBuiltinAES *ctx
> -        =3D container_of(cipher, QCryptoCipherBuiltinAES, base);
> -
> -    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
> -        return -1;
> -    }
> -    do_aes_decrypt_ecb(&ctx->key, len, out, in);
> -    return 0;
> -}
> -
> -static int qcrypto_cipher_aes_encrypt_cbc(QCryptoCipher *cipher,
> -                                          const void *in, void *out,
> -                                          size_t len, Error **errp)
> -{
> -    QCryptoCipherBuiltinAES *ctx
> -        =3D container_of(cipher, QCryptoCipherBuiltinAES, base);
> -
> -    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
> -        return -1;
> -    }
> -    do_aes_encrypt_cbc(&ctx->key.enc, len, out, in, ctx->iv);
> -    return 0;
> -}
> -
> -static int qcrypto_cipher_aes_decrypt_cbc(QCryptoCipher *cipher,
> -                                          const void *in, void *out,
> -                                          size_t len, Error **errp)
> -{
> -    QCryptoCipherBuiltinAES *ctx
> -        =3D container_of(cipher, QCryptoCipherBuiltinAES, base);
> -
> -    if (!qcrypto_length_check(len, AES_BLOCK_SIZE, errp)) {
> -        return -1;
> -    }
> -    do_aes_decrypt_cbc(&ctx->key.dec, len, out, in, ctx->iv);
> -    return 0;
> -}
> -
> -static int qcrypto_cipher_aes_setiv(QCryptoCipher *cipher, const uint8_t=
 *iv,
> -                             size_t niv, Error **errp)
> -{
> -    QCryptoCipherBuiltinAES *ctx
> -        =3D container_of(cipher, QCryptoCipherBuiltinAES, base);
> -
> -    if (niv !=3D AES_BLOCK_SIZE) {
> -        error_setg(errp, "IV must be %d bytes not %zu",
> -                   AES_BLOCK_SIZE, niv);
> -        return -1;
> -    }
> -
> -    memcpy(ctx->iv, iv, AES_BLOCK_SIZE);
> -    return 0;
> -}
> -
> -static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_ecb =
=3D {
> -    .cipher_encrypt =3D qcrypto_cipher_aes_encrypt_ecb,
> -    .cipher_decrypt =3D qcrypto_cipher_aes_decrypt_ecb,
> -    .cipher_setiv =3D qcrypto_cipher_no_setiv,
> -    .cipher_free =3D qcrypto_cipher_ctx_free,
> -};
> -
> -static const struct QCryptoCipherDriver qcrypto_cipher_aes_driver_cbc =
=3D {
> -    .cipher_encrypt =3D qcrypto_cipher_aes_encrypt_cbc,
> -    .cipher_decrypt =3D qcrypto_cipher_aes_decrypt_cbc,
> -    .cipher_setiv =3D qcrypto_cipher_aes_setiv,
> -    .cipher_free =3D qcrypto_cipher_ctx_free,
> -};
> -
> -bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
> -                             QCryptoCipherMode mode)
> -{
> -    switch (alg) {
> -    case QCRYPTO_CIPHER_ALGO_AES_128:
> -    case QCRYPTO_CIPHER_ALGO_AES_192:
> -    case QCRYPTO_CIPHER_ALGO_AES_256:
> -        switch (mode) {
> -        case QCRYPTO_CIPHER_MODE_ECB:
> -        case QCRYPTO_CIPHER_MODE_CBC:
> -            return true;
> -        default:
> -            return false;
> -        }
> -        break;
> -    default:
> -        return false;
> -    }
> -}
> -
> -static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
> -                                             QCryptoCipherMode mode,
> -                                             const uint8_t *key,
> -                                             size_t nkey,
> -                                             Error **errp)
> -{
> -    if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
> -        return NULL;
> -    }
> -
> -    switch (alg) {
> -    case QCRYPTO_CIPHER_ALGO_AES_128:
> -    case QCRYPTO_CIPHER_ALGO_AES_192:
> -    case QCRYPTO_CIPHER_ALGO_AES_256:
> -        {
> -            QCryptoCipherBuiltinAES *ctx;
> -            const QCryptoCipherDriver *drv;
> -
> -            switch (mode) {
> -            case QCRYPTO_CIPHER_MODE_ECB:
> -                drv =3D &qcrypto_cipher_aes_driver_ecb;
> -                break;
> -            case QCRYPTO_CIPHER_MODE_CBC:
> -                drv =3D &qcrypto_cipher_aes_driver_cbc;
> -                break;
> -            default:
> -                goto bad_mode;
> -            }
> -
> -            ctx =3D g_new0(QCryptoCipherBuiltinAES, 1);
> -            ctx->base.driver =3D drv;
> -
> -            if (AES_set_encrypt_key(key, nkey * 8, &ctx->key.enc)) {
> -                error_setg(errp, "Failed to set encryption key");
> -                goto error;
> -            }
> -            if (AES_set_decrypt_key(key, nkey * 8, &ctx->key.dec)) {
> -                error_setg(errp, "Failed to set decryption key");
> -                goto error;
> -            }
> -
> -            return &ctx->base;
> -
> -        error:
> -            g_free(ctx);
> -            return NULL;
> -        }
> -
> -    default:
> -        error_setg(errp,
> -                   "Unsupported cipher algorithm %s",
> -                   QCryptoCipherAlgo_str(alg));
> -        return NULL;
> -    }
> -
> - bad_mode:
> -    error_setg(errp, "Unsupported cipher mode %s",
> -               QCryptoCipherMode_str(mode));
> -    return NULL;
> -}
> diff --git a/crypto/cipher-stub.c.inc b/crypto/cipher-stub.c.inc
> new file mode 100644
> index 0000000000..2574882d89
> --- /dev/null
> +++ b/crypto/cipher-stub.c.inc
> @@ -0,0 +1,41 @@
> +/*
> + * QEMU Crypto cipher built-in algorithms
> + *
> + * Copyright (c) 2015 Red Hat, Inc.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + *
> + */
> +
> +bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
> +                             QCryptoCipherMode mode)
> +{
> +    return false;
> +}
> +
> +static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
> +                                             QCryptoCipherMode mode,
> +                                             const uint8_t *key,
> +                                             size_t nkey,
> +                                             Error **errp)
> +{
> +    if (!qcrypto_cipher_validate_key_length(alg, mode, nkey, errp)) {
> +        return NULL;
> +    }
> +
> +    error_setg(errp,
> +               "Unsupported cipher algorithm %s, no crypto library enabl=
ed in build",
> +               QCryptoCipherAlgo_str(alg));
> +    return NULL;
> +}
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index c14a8b8a11..229710f76b 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -145,7 +145,7 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo =
alg,
>  #elif defined CONFIG_GNUTLS_CRYPTO
>  #include "cipher-gnutls.c.inc"
>  #else
> -#include "cipher-builtin.c.inc"
> +#include "cipher-stub.c.inc"
>  #endif
>=20=20
>  QCryptoCipher *qcrypto_cipher_new(QCryptoCipherAlgo alg,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

