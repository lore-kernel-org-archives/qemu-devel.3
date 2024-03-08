Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E09CC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 20:32:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rigru-0006rM-Ke; Fri, 08 Mar 2024 15:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rigrt-0006pv-IR
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rigrr-0004ao-Cr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709929858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P8/6c3q9KnpPkvD+oTmHsvOnZfuiqW4ZzVDG77Xbqm8=;
 b=OT6ZNkkk2caHm13ERhS3m8RCF6Vm//2ICYr9VtLoYzgZ0urCsrSCPRcWaHCX6lVXlGEwH1
 9nCkW+E1vcSnicME45iFBH/nRsGNs+pqz59pTM2Pggazy06xb3fE7L5lqtQXDoLEh1gKdV
 gGCBIaE1e1YGzvde8PvGjXOkZYcbdwI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-RQhM27MFNlm-lkTCHGYY7g-1; Fri, 08 Mar 2024 15:30:56 -0500
X-MC-Unique: RQhM27MFNlm-lkTCHGYY7g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33e6fd52037so931755f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 12:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709929856; x=1710534656;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8/6c3q9KnpPkvD+oTmHsvOnZfuiqW4ZzVDG77Xbqm8=;
 b=qhim/DezL2I0tD9lnPEkuc1mC30iC87HjJzSqNYOGoQcn5c5ScmPSDC/g2O9qmriVl
 xAWK7SFEDz1saDfoZLC6KFtOgc+DWSFNT+uTYVNzdXvLwuMzPdRF/cjw/3yTq06SRw5K
 Ef4PFm6jDh+hs0LstNNqHrT6GYbat88MAveeLyUlVMSHDjmeuNE56AgksPwpc6H+r7q0
 NrB5Gr98iI/eM9XfTqJmfN2v9/HRKVYs8Ddqqx1B1Hf5gr3F9skHOymarGK2rMpa7+Bn
 hSgQ8sJjSaE1hKRGHsNewt3HJGy9rll5L8XIqc2RZJwrZSZ4sj1G72WMvnQNw1ZM2d+b
 qeNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFAV0+ljz6C9A7CKMWm8Qxcr6LExnQ1yFoHvkd2O9r+5RDnSNZjG6D/ECVmICFrt9p9rkWi4TozYuXgoLmEDMPPGt9MMU=
X-Gm-Message-State: AOJu0YzOKKJm/1SvT68ad1IkcjMloYjhA+5Eq8z17zORg5KuEjxP0BMK
 rFUS386kVE+VMG+7KcFIQUJedfTGx5MmoF7uOYgGwGfqyLvC3A0eXhvKAAKWV7TG1R8E3or84Mf
 CSeOT/VslSmlqeKXkfbx+BHukdnXTQrD/mRpC/uf5QXgKT3GkqjEuTX/hWGeU
X-Received: by 2002:a5d:604f:0:b0:33e:798f:6d1e with SMTP id
 j15-20020a5d604f000000b0033e798f6d1emr151491wrt.37.1709929855800; 
 Fri, 08 Mar 2024 12:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHc0paz+atb/QWPazYZuWzZ3njZRy51UGlpMRG60/LYYqYT7foTnGvmUvcPRFQ3QNy2C0tvAQ==
X-Received: by 2002:a5d:604f:0:b0:33e:798f:6d1e with SMTP id
 j15-20020a5d604f000000b0033e798f6d1emr151482wrt.37.1709929855372; 
 Fri, 08 Mar 2024 12:30:55 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 f15-20020adff58f000000b0033dd2c3131fsm251994wro.65.2024.03.08.12.30.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 12:30:54 -0800 (PST)
Message-ID: <ac13ac70-9894-48b2-97a9-ddb7a8077ac7@redhat.com>
Date: Fri, 8 Mar 2024 21:30:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] crypto: Introduce SM4 symmetric cipher algorithm
Content-Language: en-US
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <95b77afe68b898c95d381c9aa039c16b54d2e525.1701963950.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07/12/2023 16.47, Hyman Huang wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
> 
> Detect the SM4 cipher algorithms and enable the feature silently
> if it is available.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

FYI, starting with this commit, tests/unit/test-crypto-cipher is now failing 
on s390x hosts (i.e. big endian machines)... could be that there is maybe an 
endianess issue somewhere in here...

  Thomas



> diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> index fb01ec38bb..f0813d69b4 100644
> --- a/crypto/block-luks.c
> +++ b/crypto/block-luks.c
> @@ -95,12 +95,23 @@ qcrypto_block_luks_cipher_size_map_twofish[] = {
>       { 0, 0 },
>   };
>   
> +#ifdef CONFIG_CRYPTO_SM4
> +static const QCryptoBlockLUKSCipherSizeMap
> +qcrypto_block_luks_cipher_size_map_sm4[] = {
> +    { 16, QCRYPTO_CIPHER_ALG_SM4},
> +    { 0, 0 },
> +};
> +#endif
> +
>   static const QCryptoBlockLUKSCipherNameMap
>   qcrypto_block_luks_cipher_name_map[] = {
>       { "aes", qcrypto_block_luks_cipher_size_map_aes },
>       { "cast5", qcrypto_block_luks_cipher_size_map_cast5 },
>       { "serpent", qcrypto_block_luks_cipher_size_map_serpent },
>       { "twofish", qcrypto_block_luks_cipher_size_map_twofish },
> +#ifdef CONFIG_CRYPTO_SM4
> +    { "sm4", qcrypto_block_luks_cipher_size_map_sm4},
> +#endif
>   };
>   
>   QEMU_BUILD_BUG_ON(sizeof(struct QCryptoBlockLUKSKeySlot) != 48);
> diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
> index a6a0117717..1377cbaf14 100644
> --- a/crypto/cipher-gcrypt.c.inc
> +++ b/crypto/cipher-gcrypt.c.inc
> @@ -35,6 +35,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>       case QCRYPTO_CIPHER_ALG_SERPENT_256:
>       case QCRYPTO_CIPHER_ALG_TWOFISH_128:
>       case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> +#ifdef CONFIG_CRYPTO_SM4
> +    case QCRYPTO_CIPHER_ALG_SM4:
> +#endif
>           break;
>       default:
>           return false;
> @@ -219,6 +222,11 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>       case QCRYPTO_CIPHER_ALG_TWOFISH_256:
>           gcryalg = GCRY_CIPHER_TWOFISH;
>           break;
> +#ifdef CONFIG_CRYPTO_SM4
> +    case QCRYPTO_CIPHER_ALG_SM4:
> +        gcryalg = GCRY_CIPHER_SM4;
> +        break;
> +#endif
>       default:
>           error_setg(errp, "Unsupported cipher algorithm %s",
>                      QCryptoCipherAlgorithm_str(alg));
> diff --git a/crypto/cipher-nettle.c.inc b/crypto/cipher-nettle.c.inc
> index 24cc61f87b..42b39e18a2 100644
> --- a/crypto/cipher-nettle.c.inc
> +++ b/crypto/cipher-nettle.c.inc
> @@ -33,6 +33,9 @@
>   #ifndef CONFIG_QEMU_PRIVATE_XTS
>   #include <nettle/xts.h>
>   #endif
> +#ifdef CONFIG_CRYPTO_SM4
> +#include <nettle/sm4.h>
> +#endif
>   
>   static inline bool qcrypto_length_check(size_t len, size_t blocksize,
>                                           Error **errp)
> @@ -426,6 +429,30 @@ DEFINE_ECB_CBC_CTR_XTS(qcrypto_nettle_twofish,
>                          QCryptoNettleTwofish, TWOFISH_BLOCK_SIZE,
>                          twofish_encrypt_native, twofish_decrypt_native)
>   
> +#ifdef CONFIG_CRYPTO_SM4
> +typedef struct QCryptoNettleSm4 {
> +    QCryptoCipher base;
> +    struct sm4_ctx key[2];
> +} QCryptoNettleSm4;
> +
> +static void sm4_encrypt_native(void *ctx, size_t length,
> +                               uint8_t *dst, const uint8_t *src)
> +{
> +    struct sm4_ctx *keys = ctx;
> +    sm4_crypt(&keys[0], length, dst, src);
> +}
> +
> +static void sm4_decrypt_native(void *ctx, size_t length,
> +                               uint8_t *dst, const uint8_t *src)
> +{
> +    struct sm4_ctx *keys = ctx;
> +    sm4_crypt(&keys[1], length, dst, src);
> +}
> +
> +DEFINE_ECB(qcrypto_nettle_sm4,
> +           QCryptoNettleSm4, SM4_BLOCK_SIZE,
> +           sm4_encrypt_native, sm4_decrypt_native)
> +#endif
>   
>   bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>                                QCryptoCipherMode mode)
> @@ -443,6 +470,9 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgorithm alg,
>       case QCRYPTO_CIPHER_ALG_TWOFISH_128:
>       case QCRYPTO_CIPHER_ALG_TWOFISH_192:
>       case QCRYPTO_CIPHER_ALG_TWOFISH_256:
> +#ifdef CONFIG_CRYPTO_SM4
> +    case QCRYPTO_CIPHER_ALG_SM4:
> +#endif
>           break;
>       default:
>           return false;
> @@ -701,6 +731,25 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgorithm alg,
>   
>               return &ctx->base;
>           }
> +#ifdef CONFIG_CRYPTO_SM4
> +    case QCRYPTO_CIPHER_ALG_SM4:
> +        {
> +            QCryptoNettleSm4 *ctx = g_new0(QCryptoNettleSm4, 1);
> +
> +            switch (mode) {
> +            case QCRYPTO_CIPHER_MODE_ECB:
> +                ctx->base.driver = &qcrypto_nettle_sm4_driver_ecb;
> +                break;
> +            default:
> +                goto bad_cipher_mode;
> +            }
> +
> +            sm4_set_encrypt_key(&ctx->key[0], key);
> +            sm4_set_decrypt_key(&ctx->key[1], key);
> +
> +            return &ctx->base;
> +        }
> +#endif
>   
>       default:
>           error_setg(errp, "Unsupported cipher algorithm %s",
> diff --git a/crypto/cipher.c b/crypto/cipher.c
> index 74b09a5b26..5f512768ea 100644
> --- a/crypto/cipher.c
> +++ b/crypto/cipher.c
> @@ -38,6 +38,9 @@ static const size_t alg_key_len[QCRYPTO_CIPHER_ALG__MAX] = {
>       [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
>       [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 24,
>       [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 32,
> +#ifdef CONFIG_CRYPTO_SM4
> +    [QCRYPTO_CIPHER_ALG_SM4] = 16,
> +#endif
>   };
>   
>   static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
> @@ -53,6 +56,9 @@ static const size_t alg_block_len[QCRYPTO_CIPHER_ALG__MAX] = {
>       [QCRYPTO_CIPHER_ALG_TWOFISH_128] = 16,
>       [QCRYPTO_CIPHER_ALG_TWOFISH_192] = 16,
>       [QCRYPTO_CIPHER_ALG_TWOFISH_256] = 16,
> +#ifdef CONFIG_CRYPTO_SM4
> +    [QCRYPTO_CIPHER_ALG_SM4] = 16,
> +#endif
>   };
>   
>   static const bool mode_need_iv[QCRYPTO_CIPHER_MODE__MAX] = {
> diff --git a/meson.build b/meson.build
> index d2c4c2adb3..52f2f85b5a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1480,6 +1480,7 @@ endif
>   gcrypt = not_found
>   nettle = not_found
>   hogweed = not_found
> +crypto_sm4 = not_found
>   xts = 'none'
>   
>   if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> @@ -1505,6 +1506,17 @@ if not gnutls_crypto.found()
>            cc.find_library('gpg-error', required: true)],
>           version: gcrypt.version())
>       endif
> +    crypto_sm4 = gcrypt
> +    # SM4 ALG is available in libgcrypt >= 1.9
> +    if gcrypt.found() and not cc.links('''
> +      #include <gcrypt.h>
> +      int main(void) {
> +        gcry_cipher_hd_t handler;
> +        gcry_cipher_open(&handler, GCRY_CIPHER_SM4, GCRY_CIPHER_MODE_ECB, 0);
> +        return 0;
> +      }''', dependencies: gcrypt)
> +      crypto_sm4 = not_found
> +    endif
>     endif
>     if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
>       nettle = dependency('nettle', version: '>=3.4',
> @@ -1513,6 +1525,18 @@ if not gnutls_crypto.found()
>       if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
>         xts = 'private'
>       endif
> +    crypto_sm4 = nettle
> +    # SM4 ALG is available in nettle >= 3.9
> +    if nettle.found() and not cc.links('''
> +      #include <nettle/sm4.h>
> +      int main(void) {
> +        struct sm4_ctx ctx;
> +        unsigned char key[16] = {0};
> +        sm4_set_encrypt_key(&ctx, key);
> +        return 0;
> +      }''', dependencies: nettle)
> +      crypto_sm4 = not_found
> +    endif
>     endif
>   endif
>   
> @@ -2199,6 +2223,7 @@ config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
>   config_host_data.set('CONFIG_TASN1', tasn1.found())
>   config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
>   config_host_data.set('CONFIG_NETTLE', nettle.found())
> +config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
>   config_host_data.set('CONFIG_HOGWEED', hogweed.found())
>   config_host_data.set('CONFIG_QEMU_PRIVATE_XTS', xts == 'private')
>   config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
> @@ -4274,6 +4299,7 @@ summary_info += {'nettle':            nettle}
>   if nettle.found()
>      summary_info += {'  XTS':             xts != 'private'}
>   endif
> +summary_info += {'SM4 ALG support':   crypto_sm4}
>   summary_info += {'AF_ALG support':    have_afalg}
>   summary_info += {'rng-none':          get_option('rng_none')}
>   summary_info += {'Linux keyring':     have_keyring}
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index fd3d46ebd1..2f2aeff5fd 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -94,6 +94,8 @@
>   #
>   # @twofish-256: Twofish with 256 bit / 32 byte keys
>   #
> +# @sm4: SM4 with 128 bit / 16 byte keys (since 9.0)
> +#
>   # Since: 2.6
>   ##
>   { 'enum': 'QCryptoCipherAlgorithm',
> @@ -102,7 +104,8 @@
>              'des', '3des',
>              'cast5-128',
>              'serpent-128', 'serpent-192', 'serpent-256',
> -           'twofish-128', 'twofish-192', 'twofish-256']}
> +           'twofish-128', 'twofish-192', 'twofish-256',
> +           'sm4']}
>   
>   ##
>   # @QCryptoCipherMode:
> diff --git a/tests/unit/test-crypto-cipher.c b/tests/unit/test-crypto-cipher.c
> index d9d9d078ff..11ab1a54fc 100644
> --- a/tests/unit/test-crypto-cipher.c
> +++ b/tests/unit/test-crypto-cipher.c
> @@ -382,6 +382,19 @@ static QCryptoCipherTestData test_data[] = {
>           .plaintext = "90afe91bb288544f2c32dc239b2635e6",
>           .ciphertext = "6cb4561c40bf0a9705931cb6d408e7fa",
>       },
> +#ifdef CONFIG_CRYPTO_SM4
> +    {
> +        /* SM4, GB/T 32907-2016, Appendix A.1 */
> +        .path = "/crypto/cipher/sm4",
> +        .alg = QCRYPTO_CIPHER_ALG_SM4,
> +        .mode = QCRYPTO_CIPHER_MODE_ECB,
> +        .key = "0123456789abcdeffedcba9876543210",
> +        .plaintext  =
> +            "0123456789abcdeffedcba9876543210",
> +        .ciphertext =
> +            "681edf34d206965e86b3e94f536e4246",
> +    },
> +#endif
>       {
>           /* #1 32 byte key, 32 byte PTX */
>           .path = "/crypto/cipher/aes-xts-128-1",


