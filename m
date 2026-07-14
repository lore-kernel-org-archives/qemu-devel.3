Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606CBC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjYgQ-0005cq-4p; Tue, 14 Jul 2026 04:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjYgN-0005cC-QK
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:40:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjYgL-0001bH-I8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 04:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784018401;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AGRVlBPWdTM4lVVdc8P+UUzMosm6FTOSGPWjh22SG8I=;
 b=XRoLbIkKHnXqFLYzd/X4Mklzo9OqGsaHmuOlzyhbpJo0CYaJm29qQBCymQrYEdTGqyHwxX
 RerzoKURSH6ha9MT/wdLQJDSWylzh3I1lVoUQARs7u7zRM1xMVAo4G+GIV6Vy5rh2s7Z1e
 ejIfgdgk1v/uLSGyV6deftMlnhN1MoE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-y6Iybd_QO22N7IK_Kr5p_g-1; Tue,
 14 Jul 2026 04:39:57 -0400
X-MC-Unique: y6Iybd_QO22N7IK_Kr5p_g-1
X-Mimecast-MFC-AGG-ID: y6Iybd_QO22N7IK_Kr5p_g_1784018395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A8EF1956094; Tue, 14 Jul 2026 08:39:55 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F16F11956040; Tue, 14 Jul 2026 08:39:49 +0000 (UTC)
Date: Tue, 14 Jul 2026 09:39:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v1 09/15] crypto/cipher-gcrypt: Implement AES-GCM
Message-ID: <alX10vA2TB_cmzxC@redhat.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
 <20260714072900.3023742-10-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714072900.3023742-10-jamin_lin@aspeedtech.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 07:29:14AM +0000, Jamin Lin wrote:
> Map QCRYPTO_CIPHER_MODE_GCM to GCRY_CIPHER_MODE_GCM and advertise it in
> qcrypto_cipher_supports() for 128-bit block ciphers. Add a GCM driver
> whose setiv accepts the (typically 96-bit) nonce, whose encrypt/decrypt
> do not require block-aligned lengths, and which implements setaad via
> gcry_cipher_authenticate() and gettag via gcry_cipher_gettag().
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  crypto/cipher-gcrypt.c.inc | 101 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
> index 12eb9ddb5a..fce09a3c77 100644
> --- a/crypto/cipher-gcrypt.c.inc
> +++ b/crypto/cipher-gcrypt.c.inc
> @@ -65,6 +65,8 @@ static int qcrypto_cipher_mode_to_gcry_mode(QCryptoCipherMode mode)
>          return GCRY_CIPHER_MODE_CBC;
>      case QCRYPTO_CIPHER_MODE_CTR:
>          return GCRY_CIPHER_MODE_CTR;
> +    case QCRYPTO_CIPHER_MODE_GCM:
> +        return GCRY_CIPHER_MODE_GCM;
>      default:
>          return GCRY_CIPHER_MODE_NONE;
>      }
> @@ -104,6 +106,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo alg,
>      case QCRYPTO_CIPHER_MODE_XTS:
>      case QCRYPTO_CIPHER_MODE_CTR:
>          return true;
> +    case QCRYPTO_CIPHER_MODE_GCM:
> +        /* GCM requires a 128-bit block cipher. */
> +        return gcry_cipher_get_algo_blklen(
> +                   qcrypto_cipher_alg_to_gcry_alg(alg)) == 16;
>      default:
>          return false;
>      }
> @@ -228,6 +234,99 @@ static const struct QCryptoCipherDriver qcrypto_gcrypt_ctr_driver = {
>      .cipher_free = qcrypto_gcrypt_ctx_free,
>  };
>  
> +/*
> + * GCM is an AEAD stream mode: the IV/nonce need not match the block size,
> + * the message length need not be a multiple of the block size, associated
> + * data is fed with gcry_cipher_authenticate() and the authentication tag is
> + * read back with gcry_cipher_gettag().
> + */
> +static int qcrypto_gcrypt_gcm_setiv(QCryptoCipher *cipher,
> +                                    const uint8_t *iv, size_t niv,
> +                                    Error **errp)
> +{
> +    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
> +    gcry_error_t err;
> +
> +    gcry_cipher_reset(ctx->handle);
> +    err = gcry_cipher_setiv(ctx->handle, iv, niv);
> +    if (err != 0) {
> +        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
>
> +static int qcrypto_gcrypt_gcm_encrypt(QCryptoCipher *cipher, const void *in,
> +                                      void *out, size_t len, Error **errp)
> +{
> +    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
> +    gcry_error_t err;
> +
> +    err = gcry_cipher_encrypt(ctx->handle, out, len, in, len);
> +    if (err != 0) {
> +        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int qcrypto_gcrypt_gcm_decrypt(QCryptoCipher *cipher, const void *in,
> +                                      void *out, size_t len, Error **errp)
> +{
> +    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
> +    gcry_error_t err;
> +
> +    err = gcry_cipher_decrypt(ctx->handle, out, len, in, len);
> +    if (err != 0) {
> +        error_setg(errp, "Cannot decrypt data: %s", gcry_strerror(err));
> +        return -1;
> +    }
> +
> +    return 0;
> +}

Is there a reason you can't use the common qcrypto_gcrypt_setiv,
qcrypto_gcrypt_decrypt and qcrypto_gcrypt_encrypt methods ?

> +
> +static int qcrypto_gcrypt_gcm_gettag(QCryptoCipher *cipher,
> +                                     uint8_t *tag, size_t len, Error **errp)
> +{
> +    QCryptoCipherGcrypt *ctx = container_of(cipher, QCryptoCipherGcrypt, base);
> +    gcry_error_t err;
> +
> +    err = gcry_cipher_gettag(ctx->handle, tag, len);
> +    if (err != 0) {
> +        error_setg(errp, "Cannot get tag: %s", gcry_strerror(err));
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static const struct QCryptoCipherDriver qcrypto_gcrypt_gcm_driver = {
> +    .cipher_encrypt = qcrypto_gcrypt_gcm_encrypt,
> +    .cipher_decrypt = qcrypto_gcrypt_gcm_decrypt,
> +    .cipher_setiv = qcrypto_gcrypt_gcm_setiv,
> +    .cipher_setaad = qcrypto_gcrypt_gcm_setaad,
> +    .cipher_gettag = qcrypto_gcrypt_gcm_gettag,
> +    .cipher_free = qcrypto_gcrypt_ctx_free,
> +};
> +
>  static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
>                                               QCryptoCipherMode mode,
>                                               const uint8_t *key,
> @@ -259,6 +358,8 @@ static QCryptoCipher *qcrypto_cipher_ctx_new(QCryptoCipherAlgo alg,
>  
>      if (mode == QCRYPTO_CIPHER_MODE_CTR) {
>          drv = &qcrypto_gcrypt_ctr_driver;
> +    } else if (mode == QCRYPTO_CIPHER_MODE_GCM) {
> +        drv = &qcrypto_gcrypt_gcm_driver;
>      } else {
>          drv = &qcrypto_gcrypt_driver;
>      }
> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


