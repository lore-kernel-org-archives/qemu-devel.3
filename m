Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA195E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 15:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsjPH-0003hc-AI; Wed, 18 Feb 2026 10:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1vsjPF-0003hM-LZ
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:24:01 -0500
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1vsjOu-000539-VW
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:24:01 -0500
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-126ea4e9694so749578c88.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 07:23:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771428206; cv=none;
 d=google.com; s=arc-20240605;
 b=RzffSDc6xL0wz/8uK1F7qlLW8imnBPYFmr8lXAdE4is3QGRQM5U2DjlEtLaKE2ujWr
 mvnGU/DdiGDzYeL0Cf9siQRqCsdXNcvOUX8MMQWJOqldvgxJVN/xSj91xXya8nNxvKBT
 RjbZrmd8Sh4wI1qpbHCNQraRposs8ZwEt8EzLMjV9YGMMXUdotgFLxUBEN/p+6d3kc+d
 UL6M4yxsskVovEYT4h3cdZ0kJuPzgSnqIcmbEX1OMdodfCs0J2p76NHntDI6pLhwDgqx
 ALGZ5m2taWSf3YCmRwc/Qa4hAMywhq8nGDvXZ/RPXhkU1wMIgFUvsiY4HBPfbhD3k2GU
 rm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2UsbvPdUzkpU92dkxDHalvZCOXMpxYS7kgECiTNSA90=;
 fh=sdRjwF8oUqEiD33m04wmpwcDN3OVLMFzW3bOd/8YB8s=;
 b=dw4wjfsZUdHhRQ4JopEEuH953BkzKHj/HGbpiD9WQJxByG7curIZR80oxnXXT6scQe
 2SJutebNb6684+iS58rS32JzqoUqB4DG/9r5IoX9Ry2jslkVCp0WW2CMLssUNtWDv6XR
 dzlJWQua7fezw23dqoKItSybyxDIga7STrwD18+54ZxbGRWpAN3TCqC/Licg3dGiA/EQ
 3ps9MEZebRf3eC5QGGzJEV03inG479Px5WtNUMbvZ6PEYYeVLBUr8TonXLCFyd8uhQpo
 uvdOCOE+sbgROhbjLGia4NdWSTtEWZf4iOx6+acWlrlQkheP8zExaQ6njVhG17nIykWC
 OM7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771428206; x=1772033006; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UsbvPdUzkpU92dkxDHalvZCOXMpxYS7kgECiTNSA90=;
 b=OdZLnXTcZartAQoJQjlR/xvGiSKm7trk9km3PyVIWyRLcgT1statnYoXgG7oNipkDl
 bKhcZ++DEmqockaKVA118OfPr3A7qOJ/Xx74PWe0hoD972xG0B47mL+vHMvnozcPIn4X
 12QXn7QTUDgFO1h+2sblCeeSFbBXrPhf3TjwwfP/oP4R3ua+MMXeooJa5sL841bC82je
 EIFFJWk6RrKjk04u1zQQgLPJhl8HhlqwD0CKNYhS9shRmxyxsdGwPJ74/mG+QurVP6Ll
 oSn6Iwi4CUDgi4D5Di+ZZxfbX7lCKMEJhRUg2MI5P5T2Ex7FSdddx334GCX0kWt+P9Vn
 IbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771428206; x=1772033006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2UsbvPdUzkpU92dkxDHalvZCOXMpxYS7kgECiTNSA90=;
 b=rEmX6qAYWk5usyxWILshARs9lQ45nIVYBp5Pw6KpS6c/e88TXGXGMA+x/+fWGoLvWJ
 VW0nXWX9v6T6aNXYwEEP5hLUgg3GtrsB/0A4aLc4HA43Vcgl12pIPj5vGxJyifLKZUXx
 Ou9aGTfWyvPwkMMwAu16Z8tySbgPP4Z/+YS5Sd62c0vBfE+GxwyvlSum62R8R6dDt/kg
 HyquX8dKhlMAfMwUVKAjt6ph5YIRsf3RkgiqJIK8x4JjCtX6CLwQ8Vuy1FZh0P5xERpo
 51BqSPkWtxYUgXMgsNCDb0vVJzqtm6uECcLn6T7xxTQPwHITcxPgSpinWsTvZKupqfUK
 5UEw==
X-Gm-Message-State: AOJu0YwYu8RH54Wx9jqshm9Fg5tSOKSUCrVu3lrAREhhXX8+C58laTE0
 uMR+1OFUned+797GMafH94gDwwfVP3sa+fvlcd/pW4Yr9BCwG31yDoR/Ia6k6S90pUbAIGy9YPQ
 1Yqpg5vTVX98OQbqO7SOZZDmFmZIdZahYqw==
X-Gm-Gg: AZuq6aKGsW6EueWEmlvcmlTkHdt1JBRJjIUUt3Wwf2n6r0r+FDqo99xfcfnxAg7N9bl
 7iEajJEwon1SySQinpWJ5RKflkLK67JUM2zl5JJQ0yTX7NqPNZ8pan6HH6x+dCKboxCPq1dqFZl
 EeWwPC5ltQBhBldClomczQ+KUDhcrgMbC7CFdFfDtAVe2u94Izyf6ZPTOSyqNHl/sZNWOLl+dpw
 3RFpaKRT5SUM7TyKOTzkqZge4kq455JUB5VlJ30Hk64jLipJIpqy2UOKh+Ki7xvIzL8ZPVRU+HG
 66GnMbsLWo313RG0ItmxWYx20C+vKIpliMwvUCP134g=
X-Received: by 2002:a05:6102:1621:b0:5fd:f2ad:c653 with SMTP id
 ada2fe7eead31-5fe1acde7ebmr7592163137.16.1771427580739; Wed, 18 Feb 2026
 07:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20260218015151.4052-1-graf@amazon.com>
 <20260218015151.4052-9-graf@amazon.com>
In-Reply-To: <20260218015151.4052-9-graf@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 18 Feb 2026 21:12:49 +0600
X-Gm-Features: AaiRm513RFggHu2TxwroliXKL5PLEVkM4Y1EBl3AzSXfa4BnC2Pr5o3HpsuJTqU
Message-ID: <CAFfO_h4xRp9RpP1_viAUbkuHG86q-S_tWunt_T2eC3Th3V=5NA@mail.gmail.com>
Subject: Re: [PATCH 08/10] hw/core/eif: Move definitions to header
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 alex.bennee@linaro.org, 
 philmd@linaro.org, berrange@redhat.com, marcandre.lureau@redhat.com, 
 Cornelia Huck <cohuck@redhat.com>, mst@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Tyler Fanelli <tfanelli@redhat.com>, mknaust@amazon.com,
 nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=dorjoychy111@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Feb 18, 2026 at 7:53=E2=80=AFAM Alexander Graf <graf@amazon.com> wr=
ote:
>
> In follow-up patches we need some EIF file definitions that are
> currently in the eif.c file, but want to access them from a separate
> device. Move them into the header instead.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  hw/core/eif.c | 38 --------------------------------------
>  hw/core/eif.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 38 deletions(-)

Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

Regards,
Dorjoy

>
> diff --git a/hw/core/eif.c b/hw/core/eif.c
> index 513caec6b4..96f1d76578 100644
> --- a/hw/core/eif.c
> +++ b/hw/core/eif.c
> @@ -18,44 +18,6 @@
>
>  #include "hw/core/eif.h"
>
> -#define MAX_SECTIONS 32
> -
> -/* members are ordered according to field order in .eif file */
> -typedef struct EifHeader {
> -    uint8_t  magic[4]; /* must be .eif in ascii i.e., [46, 101, 105, 102=
] */
> -    uint16_t version;
> -    uint16_t flags;
> -    uint64_t default_memory;
> -    uint64_t default_cpus;
> -    uint16_t reserved;
> -    uint16_t section_cnt;
> -    uint64_t section_offsets[MAX_SECTIONS];
> -    uint64_t section_sizes[MAX_SECTIONS];
> -    uint32_t unused;
> -    uint32_t eif_crc32;
> -} QEMU_PACKED EifHeader;
> -
> -/* members are ordered according to field order in .eif file */
> -typedef struct EifSectionHeader {
> -    /*
> -     * 0 =3D invalid, 1 =3D kernel, 2 =3D cmdline, 3 =3D ramdisk, 4 =3D =
signature,
> -     * 5 =3D metadata
> -     */
> -    uint16_t section_type;
> -    uint16_t flags;
> -    uint64_t section_size;
> -} QEMU_PACKED EifSectionHeader;
> -
> -enum EifSectionTypes {
> -    EIF_SECTION_INVALID =3D 0,
> -    EIF_SECTION_KERNEL =3D 1,
> -    EIF_SECTION_CMDLINE =3D 2,
> -    EIF_SECTION_RAMDISK =3D 3,
> -    EIF_SECTION_SIGNATURE =3D 4,
> -    EIF_SECTION_METADATA =3D 5,
> -    EIF_SECTION_MAX =3D 6,
> -};
> -
>  static const char *section_type_to_string(uint16_t type)
>  {
>      const char *str;
> diff --git a/hw/core/eif.h b/hw/core/eif.h
> index fed3cb5514..a3412377a9 100644
> --- a/hw/core/eif.h
> +++ b/hw/core/eif.h
> @@ -11,6 +11,44 @@
>  #ifndef HW_CORE_EIF_H
>  #define HW_CORE_EIF_H
>
> +#define MAX_SECTIONS 32
> +
> +/* members are ordered according to field order in .eif file */
> +typedef struct EifHeader {
> +    uint8_t  magic[4]; /* must be .eif in ascii i.e., [46, 101, 105, 102=
] */
> +    uint16_t version;
> +    uint16_t flags;
> +    uint64_t default_memory;
> +    uint64_t default_cpus;
> +    uint16_t reserved;
> +    uint16_t section_cnt;
> +    uint64_t section_offsets[MAX_SECTIONS];
> +    uint64_t section_sizes[MAX_SECTIONS];
> +    uint32_t unused;
> +    uint32_t eif_crc32;
> +} QEMU_PACKED EifHeader;
> +
> +/* members are ordered according to field order in .eif file */
> +typedef struct EifSectionHeader {
> +    /*
> +     * 0 =3D invalid, 1 =3D kernel, 2 =3D cmdline, 3 =3D ramdisk, 4 =3D =
signature,
> +     * 5 =3D metadata
> +     */
> +    uint16_t section_type;
> +    uint16_t flags;
> +    uint64_t section_size;
> +} QEMU_PACKED EifSectionHeader;
> +
> +enum EifSectionTypes {
> +    EIF_SECTION_INVALID =3D 0,
> +    EIF_SECTION_KERNEL =3D 1,
> +    EIF_SECTION_CMDLINE =3D 2,
> +    EIF_SECTION_RAMDISK =3D 3,
> +    EIF_SECTION_SIGNATURE =3D 4,
> +    EIF_SECTION_METADATA =3D 5,
> +    EIF_SECTION_MAX =3D 6,
> +};
> +
>  bool read_eif_file(const char *eif_path, const char *machine_initrd,
>                     char **kernel_path, char **initrd_path,
>                     char **kernel_cmdline, uint8_t *image_sha384,
> --
> 2.47.1
>
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>

