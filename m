Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5736DC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 07:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uljj2-0001Kb-Mu; Tue, 12 Aug 2025 03:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uljj1-0001KT-QJ
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 03:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uljix-0004R7-3s
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 03:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754984825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z34ecAj3l3I8IZj7j0RpdYP/xVlmTdrSBON8jV1PIbg=;
 b=bQTAQmGtOZlHNPFuKNHhDznbcgKjPtvxXbCFmfZEbDS5CES7bbO7Cz2BchcjAg0eMRdJkw
 Tqwf6s+SUR0vrykZWMP7Y+toM7DULiKPsyPP0zPxmNOKVngypOxt7f8Bi3uXQ/3SIXWoRI
 EDudoRinrao4b+XFeOWX5DckDdunppE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-eKHJD7pfOUe9HGRW8RriaQ-1; Tue, 12 Aug 2025 03:47:04 -0400
X-MC-Unique: eKHJD7pfOUe9HGRW8RriaQ-1
X-Mimecast-MFC-AGG-ID: eKHJD7pfOUe9HGRW8RriaQ_1754984823
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b7882c0992so2856397f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 00:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754984822; x=1755589622;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z34ecAj3l3I8IZj7j0RpdYP/xVlmTdrSBON8jV1PIbg=;
 b=hpwX6dfznIlzzMNnDviN5/riaK1D1+SYp85bvKitH/wv1FHUr0Y1PQFIsfP36li7xz
 +2J9I3Z0AJ5Jhk7foFdaEW9a4/1dLU/mD4RNXo/d7ZaFHhDOkfpGJGCsmxtXym686gTi
 vZwDqBDXxB4uMreN3mz5JIoz6PSlm3DfPPNKIpvaq3mCYHfwSjpDY+bC5VcWrvZozlIu
 dqGwsufPpIRmG64MbdMBCWOVwYfgg5E9O3kzyjV3rwn81Y5en5vnbGW+lqv68Zod4tNn
 btDdFBZAotbL/CeBJhVjfGIhMX22keyj9xBdYi76a8GDow35kcIRVvdExUUDtcrPycxy
 8HrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU99UiSEUzRllJHp2DCDogfYutvBGN9YoLf8RMDE9HPy8qKA4J0srsL6J5kIR/WJeSLiiWnoRC+lwUi@nongnu.org
X-Gm-Message-State: AOJu0Yx5gz/EJHVa/8jH0dJ1Mt/POWEBCNJogHjoeBu7X7OdCT2Am4kA
 Gf1FEgnQMVQP9Vkn0ruldWieWONwiapxlzxRPg1dOkHgRol5RkhK6Dxl2+8Zil9OAg7NzP4giv2
 RShG3j3NaYQ+8pzEfm5DjLjycU5UUUVyRJ6iLbWqHo9RvWw6KklW7Lxnx9WiIGZaa
X-Gm-Gg: ASbGncuhQzIew7zf+B7bj4aI2Li3naQzsFt0R5uNUlzj18LjNSY5saD71wspo88Vhfr
 pvSGbMczSWj19e3L2JgXizgnzqkV1Sph+At0DWz7hXYxdJ+IAUN6jzz11t9WcQbYmA09tAL3u2M
 rav0717PrXjclMOV6tRZd7jB7zJcEB/Iu9EJOOxuEz6ioZKIxO21kDRwK8pXFpitS9/jy0ndB6r
 VRIBlB53cM1lX0nXzbnd4Ue2401x6oyus/WMYH3VYgGGLqoZANIOx16Fb2K+DedTciunt5TZ4hk
 W/6Dpkfx4hC3R9qbFOhQz4cmO4LtEBj/7xHnBbv//lJ+khbmAz9ivnXiuXAskYwW9+bbLLGIW1B
 pan05L0AUd/AKjp0GlF5JlnMHPoIwA2WQFxWw7IjBiZrt0iqFcC58JIOrUEVfgGhgj7Nc
X-Received: by 2002:a05:6000:24c6:b0:3b8:d900:fa79 with SMTP id
 ffacd0b85a97d-3b90092cacbmr14011092f8f.5.1754984821129; 
 Tue, 12 Aug 2025 00:47:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN/KDgXirnddmzRQ8zdvPdiULOEWw5e0ANGMYWKMpOtaEhhq3U1Qh7Q18yltHhzgX70axKyQ==
X-Received: by 2002:a05:6000:24c6:b0:3b8:d900:fa79 with SMTP id
 ffacd0b85a97d-3b90092cacbmr14011052f8f.5.1754984820601; 
 Tue, 12 Aug 2025 00:47:00 -0700 (PDT)
Received: from ?IPV6:2003:cf:d715:6837:b828:a358:d573:e3a8?
 (p200300cfd7156837b828a358d573e3a8.dip0.t-ipconnect.de.
 [2003:cf:d715:6837:b828:a358:d573:e3a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9eddsm43353249f8f.22.2025.08.12.00.46.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 00:46:59 -0700 (PDT)
Message-ID: <4f382d55-553e-45b3-8a66-9729f43daef1@redhat.com>
Date: Tue, 12 Aug 2025 09:46:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: Fix .bdrv_get_specific_info implementation
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: idryomov@gmail.com, pl@dlhnet.de, eblake@redhat.com, armbru@redhat.com,
 oro@il.ibm.com, qemu-devel@nongnu.org
References: <20250811134010.81787-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250811134010.81787-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11.08.25 15:40, Kevin Wolf wrote:
> qemu_rbd_get_specific_info() has at least two problems:
>
> The first is that it issues a blocking rbd_read() call in order to probe
> the encryption format for the image while querying the node. This means
> that if the connection to the server goes down, not only I/O is stuck
> (which is unavoidable), but query-names-block-nodes will actually make
> the whole QEMU instance unresponsive. .bdrv_get_specific_info
> implementations shouldn't perform blocking operations, but only return
> what is already known.

Maybe we should put a “must not block” warning on 
BlockDriver.bdrv_get_specific_info()?

> The second is that the information returned isn't even correct. If the
> image is already opened with encryption enabled at the RBD level, we'll
> probe for "double encryption", i.e. if the encrypted data contains
> another encryption header. If it doesn't (which is the normal case), we
> won't return the encryption format. If it does, we return misleading
> information because it looks like we're talking about the outer level
> (the encryption format of the image itself) while the information is
> about an encryption header in the guest data.
>
> Fix this by storing the encryption format in BDRVRBDState when the image
> is opened (and we do blocking operations anyway) and returning only the
> stored information in qemu_rbd_get_specific_info().
>
> The information we'll store is either the actual encryption format that
> we enabled on the RBD level, or if the image is unencrypted, the result
> of the same probing as we previously did when querying the node. Probing
> image formats based on content that can be modified by the guest has
> long been known as problematic, but as long as we only output it to the
> user instead of making decisions based on it, it should be okay. It is
> undoubtedly useful in the context of 'qemu-img info' when you're trying
> to figure out which encryption options you have to use to open the
> image successfully.
>
> Fixes: 42e4ac9ef5a6 ("block/rbd: Add support for rbd image encryption")
> Buglink: https://issues.redhat.com/browse/RHEL-105440
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   qapi/block-core.json |   9 +++-
>   block/rbd.c          | 103 ++++++++++++++++++++++++++++---------------
>   2 files changed, 75 insertions(+), 37 deletions(-)

Looks good to me, just found two spelling/wording nits below.  With 
those fixed:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

(I think the .bdrv_get_specific_info() warning would be nice, but optional.)

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ebbe95b3d8..cbd2bc84fe 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -159,7 +159,14 @@
>   ##
>   # @ImageInfoSpecificRbd:
>   #
> -# @encryption-format: Image encryption format
> +# @encryption-format: Image encryption format. If encryption is enabled for the
> +#     image (see encrpyted in BlockNodeInfo), this is the actual format in which the

*encrypted

> +#     image is accessed. If encryption is not enabled, this is the result of
> +#     probing when the image was opened, to give a suggestion which encryption
> +#     format could be enabled. Note that probing results can be changed by the
> +#     guest by writing a (possibly partial) encryption format header to the
> +#     image, so don't treat this information as trusted if the guest is not
> +#     trusted.
>   #
>   # Since: 6.1
>   ##
> diff --git a/block/rbd.c b/block/rbd.c
> index 951cd63f9a..8582bc8360 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -99,6 +99,14 @@ typedef struct BDRVRBDState {
>       char *namespace;
>       uint64_t image_size;
>       uint64_t object_size;
> +
> +    /*
> +     * If @bs->encrypted is true, this is the encryption format actually loaded
> +     * at the librbd level. If it is false, it is the result of probing.
> +     * RBD_IMAGE_ENCRYPTION_FORMAT__MAX means that encryption is not enabled and
> +     * probing didn't find any known encryption header either.
> +     */
> +    RbdImageEncryptionFormat encryption_format;
>   } BDRVRBDState;
>   
>   typedef struct RBDTask {
> @@ -470,10 +478,12 @@ static int qemu_rbd_encryption_format(rbd_image_t image,
>       return 0;
>   }
>   
> -static int qemu_rbd_encryption_load(rbd_image_t image,
> +static int qemu_rbd_encryption_load(BlockDriverState *bs,
> +                                    rbd_image_t image,
>                                       RbdEncryptionOptions *encrypt,
>                                       Error **errp)
>   {
> +    BDRVRBDState *s = bs->opaque;
>       int r = 0;
>       g_autofree char *passphrase = NULL;
>       rbd_encryption_luks1_format_options_t luks_opts;
> @@ -544,15 +554,19 @@ static int qemu_rbd_encryption_load(rbd_image_t image,
>           error_setg_errno(errp, -r, "encryption load fail");
>           return r;
>       }
> +    bs->encrypted = true;
> +    s->encryption_format = encrypt->format;
>   
>       return 0;
>   }
>   
>   #ifdef LIBRBD_SUPPORTS_ENCRYPTION_LOAD2
> -static int qemu_rbd_encryption_load2(rbd_image_t image,
> +static int qemu_rbd_encryption_load2(BlockDriverState *bs,
> +                                     rbd_image_t image,
>                                        RbdEncryptionOptions *encrypt,
>                                        Error **errp)
>   {
> +    BDRVRBDState *s = bs->opaque;
>       int r = 0;
>       int encrypt_count = 1;
>       int i;
> @@ -638,6 +652,8 @@ static int qemu_rbd_encryption_load2(rbd_image_t image,
>           error_setg_errno(errp, -r, "layered encryption load fail");
>           goto exit;
>       }
> +    bs->encrypted = true;
> +    s->encryption_format = encrypt->format;
>   
>   exit:
>       for (i = 0; i < encrypt_count; ++i) {
> @@ -671,6 +687,44 @@ exit:
>   #endif
>   #endif
>   
> +/*
> + * For an image without encryption enabled on the rbd layer, probe the start of
> + * the image if it could be opened as an encrypted image so that we can display
> + * it when the user queries the node (most importantly in qemu-img).
> + *
> + * If the guest writes an encryption header to its disk after this probing, but

Either there’s something missing after the comma (e.g. “it wouldn’t be 
reflected when queried”), or the “but” is too much.

> + * that's okay. There is no reason why the user should want to apply encryption
> + * at the rbd level while the image is still in use. This is just guest data.
> + */
> +static void qemu_rbd_encryption_probe(BlockDriverState *bs)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    char buf[RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN] = {0};
> +    int r;
> +
> +    assert(s->encryption_format == RBD_IMAGE_ENCRYPTION_FORMAT__MAX);
> +
> +    r = rbd_read(s->image, 0,
> +                 RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN, buf);
> +    if (r < RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) {
> +        return;
> +    }
> +
> +    if (memcmp(buf, rbd_luks_header_verification,
> +               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> +        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
> +    } else if (memcmp(buf, rbd_luks2_header_verification,
> +               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> +        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
> +    } else if (memcmp(buf, rbd_layered_luks_header_verification,
> +               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> +        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
> +    } else if (memcmp(buf, rbd_layered_luks2_header_verification,
> +               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> +        s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
> +    }
> +}
> +
>   /* FIXME Deprecate and remove keypairs or make it available in QMP. */
>   static int qemu_rbd_do_create(BlockdevCreateOptions *options,
>                                 const char *keypairs, const char *password_secret,
> @@ -1133,17 +1187,18 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>           goto failed_open;
>       }
>   
> +    s->encryption_format = RBD_IMAGE_ENCRYPTION_FORMAT__MAX;
>       if (opts->encrypt) {
>   #ifdef LIBRBD_SUPPORTS_ENCRYPTION
>           if (opts->encrypt->parent) {
>   #ifdef LIBRBD_SUPPORTS_ENCRYPTION_LOAD2
> -            r = qemu_rbd_encryption_load2(s->image, opts->encrypt, errp);
> +            r = qemu_rbd_encryption_load2(bs, s->image, opts->encrypt, errp);
>   #else
>               r = -ENOTSUP;
>               error_setg(errp, "RBD library does not support layered encryption");
>   #endif
>           } else {
> -            r = qemu_rbd_encryption_load(s->image, opts->encrypt, errp);
> +            r = qemu_rbd_encryption_load(bs, s->image, opts->encrypt, errp);
>           }
>           if (r < 0) {
>               goto failed_post_open;
> @@ -1153,6 +1208,8 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>           error_setg(errp, "RBD library does not support image encryption");
>           goto failed_post_open;
>   #endif
> +    } else {
> +        qemu_rbd_encryption_probe(bs);
>       }
>   
>       r = rbd_stat(s->image, &info, sizeof(info));
> @@ -1412,17 +1469,6 @@ static ImageInfoSpecific *qemu_rbd_get_specific_info(BlockDriverState *bs,
>   {
>       BDRVRBDState *s = bs->opaque;
>       ImageInfoSpecific *spec_info;
> -    char buf[RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN] = {0};
> -    int r;
> -
> -    if (s->image_size >= RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) {
> -        r = rbd_read(s->image, 0,
> -                     RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN, buf);
> -        if (r < 0) {
> -            error_setg_errno(errp, -r, "cannot read image start for probe");
> -            return NULL;
> -        }
> -    }
>   
>       spec_info = g_new(ImageInfoSpecific, 1);
>       *spec_info = (ImageInfoSpecific){
> @@ -1430,28 +1476,13 @@ static ImageInfoSpecific *qemu_rbd_get_specific_info(BlockDriverState *bs,
>           .u.rbd.data = g_new0(ImageInfoSpecificRbd, 1),
>       };
>   
> -    if (memcmp(buf, rbd_luks_header_verification,
> -               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> -        spec_info->u.rbd.data->encryption_format =
> -                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
> -        spec_info->u.rbd.data->has_encryption_format = true;
> -    } else if (memcmp(buf, rbd_luks2_header_verification,
> -               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> -        spec_info->u.rbd.data->encryption_format =
> -                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
> -        spec_info->u.rbd.data->has_encryption_format = true;
> -    } else if (memcmp(buf, rbd_layered_luks_header_verification,
> -               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> -        spec_info->u.rbd.data->encryption_format =
> -                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS;
> -        spec_info->u.rbd.data->has_encryption_format = true;
> -    } else if (memcmp(buf, rbd_layered_luks2_header_verification,
> -               RBD_ENCRYPTION_LUKS_HEADER_VERIFICATION_LEN) == 0) {
> -        spec_info->u.rbd.data->encryption_format =
> -                RBD_IMAGE_ENCRYPTION_FORMAT_LUKS2;
> -        spec_info->u.rbd.data->has_encryption_format = true;
> +    if (s->encryption_format == RBD_IMAGE_ENCRYPTION_FORMAT__MAX) {
> +        assert(!bs->encrypted);
>       } else {
> -        spec_info->u.rbd.data->has_encryption_format = false;
> +        ImageInfoSpecificRbd *rbd_info = spec_info->u.rbd.data;
> +
> +        rbd_info->has_encryption_format = true;
> +        rbd_info->encryption_format = s->encryption_format;
>       }
>   
>       return spec_info;


