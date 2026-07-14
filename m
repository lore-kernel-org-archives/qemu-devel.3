Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77728C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZVy-0003up-U1; Tue, 14 Jul 2026 05:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjZVx-0003th-KT
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjZVv-00011g-OX
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784021599;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imQvlJ6xk7HfeVfEIkFIq2CJ82cuwFXXyGav6xvanHk=;
 b=gK4xL4P5vfTPyhC0FJNvzt4169BSlWt9puyNJaz6r6X3LntHBMm1EhDMz7mBsGxpH0GqLt
 8H9b1aYEJH/Tn2a1MISDp4XsoBaDdsJ5siMQypfonhLr24B7pdXJgmAh5y9b3N4UQ9KZVb
 tUyjwsxJT8Yf7Qg7KB5OHgejMVsOhuc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-D8Cn037fPUeD4gFRXYaZTQ-1; Tue,
 14 Jul 2026 05:32:07 -0400
X-MC-Unique: D8Cn037fPUeD4gFRXYaZTQ-1
X-Mimecast-MFC-AGG-ID: D8Cn037fPUeD4gFRXYaZTQ_1784021525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82AE81956094; Tue, 14 Jul 2026 09:32:05 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.163])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A896180049F; Tue, 14 Jul 2026 09:32:00 +0000 (UTC)
Date: Tue, 14 Jul 2026 10:31:56 +0100
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
Message-ID: <alYCDIhk82rHlZM1@redhat.com>
References: <20260714072900.3023742-1-jamin_lin@aspeedtech.com>
 <20260714072900.3023742-10-jamin_lin@aspeedtech.com>
 <alX10vA2TB_cmzxC@redhat.com>
 <TYZPR06MB498092C808D35FCCB792545BFCF92@TYZPR06MB4980.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB498092C808D35FCCB792545BFCF92@TYZPR06MB4980.apcprd06.prod.outlook.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Tue, Jul 14, 2026 at 08:57:24AM +0000, Jamin Lin wrote:
> Hi Daniel
> 
> > Subject: Re: [PATCH v1 09/15] crypto/cipher-gcrypt: Implement AES-GCM
> > 
> > On Tue, Jul 14, 2026 at 07:29:14AM +0000, Jamin Lin wrote:
> > > Map QCRYPTO_CIPHER_MODE_GCM to GCRY_CIPHER_MODE_GCM and
> > advertise it
> > > in
> > > qcrypto_cipher_supports() for 128-bit block ciphers. Add a GCM driver
> > > whose setiv accepts the (typically 96-bit) nonce, whose
> > > encrypt/decrypt do not require block-aligned lengths, and which
> > > implements setaad via
> > > gcry_cipher_authenticate() and gettag via gcry_cipher_gettag().
> > >
> > > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > > ---
> > >  crypto/cipher-gcrypt.c.inc | 101
> > > +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >
> > > diff --git a/crypto/cipher-gcrypt.c.inc b/crypto/cipher-gcrypt.c.inc
> > > index 12eb9ddb5a..fce09a3c77 100644
> > > --- a/crypto/cipher-gcrypt.c.inc
> > > +++ b/crypto/cipher-gcrypt.c.inc
> > > @@ -65,6 +65,8 @@ static int
> > qcrypto_cipher_mode_to_gcry_mode(QCryptoCipherMode mode)
> > >          return GCRY_CIPHER_MODE_CBC;
> > >      case QCRYPTO_CIPHER_MODE_CTR:
> > >          return GCRY_CIPHER_MODE_CTR;
> > > +    case QCRYPTO_CIPHER_MODE_GCM:
> > > +        return GCRY_CIPHER_MODE_GCM;
> > >      default:
> > >          return GCRY_CIPHER_MODE_NONE;
> > >      }
> > > @@ -104,6 +106,10 @@ bool qcrypto_cipher_supports(QCryptoCipherAlgo
> > alg,
> > >      case QCRYPTO_CIPHER_MODE_XTS:
> > >      case QCRYPTO_CIPHER_MODE_CTR:
> > >          return true;
> > > +    case QCRYPTO_CIPHER_MODE_GCM:
> > > +        /* GCM requires a 128-bit block cipher. */
> > > +        return gcry_cipher_get_algo_blklen(
> > > +                   qcrypto_cipher_alg_to_gcry_alg(alg)) == 16;
> > >      default:
> > >          return false;
> > >      }
> > > @@ -228,6 +234,99 @@ static const struct QCryptoCipherDriver
> > qcrypto_gcrypt_ctr_driver = {
> > >      .cipher_free = qcrypto_gcrypt_ctx_free,  };
> > >
> > > +/*
> > > + * GCM is an AEAD stream mode: the IV/nonce need not match the block
> > > +size,
> > > + * the message length need not be a multiple of the block size,
> > > +associated
> > > + * data is fed with gcry_cipher_authenticate() and the authentication
> > > +tag is
> > > + * read back with gcry_cipher_gettag().
> > > + */
> > > +static int qcrypto_gcrypt_gcm_setiv(QCryptoCipher *cipher,
> > > +                                    const uint8_t *iv, size_t niv,
> > > +                                    Error **errp) {
> > > +    QCryptoCipherGcrypt *ctx = container_of(cipher,
> > QCryptoCipherGcrypt, base);
> > > +    gcry_error_t err;
> > > +
> > > +    gcry_cipher_reset(ctx->handle);
> > > +    err = gcry_cipher_setiv(ctx->handle, iv, niv);
> > > +    if (err != 0) {
> > > +        error_setg(errp, "Cannot set IV: %s", gcry_strerror(err));
> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > >
> > > +static int qcrypto_gcrypt_gcm_encrypt(QCryptoCipher *cipher, const void
> > *in,
> > > +                                      void *out, size_t len, Error
> > > +**errp) {
> > > +    QCryptoCipherGcrypt *ctx = container_of(cipher,
> > QCryptoCipherGcrypt, base);
> > > +    gcry_error_t err;
> > > +
> > > +    err = gcry_cipher_encrypt(ctx->handle, out, len, in, len);
> > > +    if (err != 0) {
> > > +        error_setg(errp, "Cannot encrypt data: %s", gcry_strerror(err));
> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > > +static int qcrypto_gcrypt_gcm_decrypt(QCryptoCipher *cipher, const void
> > *in,
> > > +                                      void *out, size_t len, Error
> > > +**errp) {
> > > +    QCryptoCipherGcrypt *ctx = container_of(cipher,
> > QCryptoCipherGcrypt, base);
> > > +    gcry_error_t err;
> > > +
> > > +    err = gcry_cipher_decrypt(ctx->handle, out, len, in, len);
> > > +    if (err != 0) {
> > > +        error_setg(errp, "Cannot decrypt data: %s", gcry_strerror(err));
> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > 
> > Is there a reason you can't use the common qcrypto_gcrypt_setiv,
> > qcrypto_gcrypt_decrypt and qcrypto_gcrypt_encrypt methods ?
> > 
> 
> Thanks for the review and suggestion.
> 
> The GCM path differs from the common methods in two input checks that GCM legitimately violates:
> 
>   - qcrypto_gcrypt_setiv() rejects niv != blocksize, but GCM uses a
>     96-bit (12-byte) nonce.
>   - qcrypto_gcrypt_encrypt()/decrypt() reject a length that is not a
>     multiple of the block size, but GCM must accept arbitrary lengths
>     (e.g. the 60-byte NIST test vectors).
> 
> So reusing the common methods means relaxing those two checks for GCM,
> e.g.:
>   /* qcrypto_gcrypt_setiv() */
>   if (cipher->mode != QCRYPTO_CIPHER_MODE_GCM && niv != ctx->blocksize) {
>       error_setg(errp, "Expected IV size %zu not %zu", ctx->blocksize, niv);
>       return -1;
>   }
>   /* qcrypto_gcrypt_encrypt() / _decrypt() */
>   if (cipher->mode != QCRYPTO_CIPHER_MODE_GCM &&
>       (len & (ctx->blocksize - 1))) {
>       error_setg(errp, "Length %zu must be a multiple of block size %zu",
>                  len, ctx->blocksize);
>       return -1;
>   }
> 
> I kept them separate to avoid adding GCM special-cases to the shared
> block-cipher path, but I'm happy to switch the GCM driver to the common
> qcrypto_gcrypt_{setiv,encrypt,decrypt} (dropping the GCM-specific ones and
> keeping only the AEAD setaad/gettag hooks)
> 
> If you prefer. I'll make that change in v2 if that's the direction you'd like.

No, leave it as it is.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>




With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


