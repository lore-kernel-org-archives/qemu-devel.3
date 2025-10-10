Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC49CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 11:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Bgr-0008N8-Ts; Fri, 10 Oct 2025 07:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v7Bgp-0008Mu-S7
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 07:53:39 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v7Bgi-0006E7-Vd
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 07:53:39 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso411857266b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760097204; x=1760702004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HX2bit+Q+N9hc9RuZAdnMfGq8JDdUCV45g1a41Zdsg=;
 b=G5VmDzCW0qza+dBX93yF95Oug1y+k2gPAXEsyJfEjOn2yb6ZYUIc3HPoJWTyp8XqbD
 +8J0zMMeFs853Tz7IKZQ3cUMGP44VQgLzx8F1Cf9lpHjRAoCd92VT/kneO2gNZs5o96C
 1X66+pCMSEBuf38QJYjYdR1AViVNBVJHHtuMMONWddmgw1Vu46lqjDSvG3RCeeeu4zhO
 HcsiwIPvy9JDwBJCURBVIEThCOWxjzqXUQFy6XmTiMpcIxoUknH7Q22syZ8xUzYZ70KH
 n7PqBgZ1hDmXHhNlo4ji4yXdP+op5E+KdCWrQ+wkkQM0dhlHrHXIqNmQYYSITV1jfbE/
 UsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760097204; x=1760702004;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5HX2bit+Q+N9hc9RuZAdnMfGq8JDdUCV45g1a41Zdsg=;
 b=R59OHx8vOWnTgBZmr2JkUEbNWkKgvZ2oTunhP9KrbD7E9B7aY8JbZj2aqmrGWyX9yQ
 ML2Rh4IqJCF45APTmsFeoijH6d2pg0CRGKfeb0GtGYbAilb8sHg4V9qonCGenfARD/2H
 obs2444ktJbVq5xhR3L2/pe+HZpgDT92kKA8FNGxHju1CRqGnbh9kn+Dr6IzNmdvqbuX
 DF/tdhz9e7Jkxb+j114jVc4LqTdXy3NGDRwd9s3lHL04VrsZ67DvYA9kvJ0LKZg42k95
 VgYMrw6xyHkW73v9k3AMxGK0JDuQ5OLP2BI6eUt1sul+8gy1k/b3YfC0M2F1sj9lJSWX
 Pvqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXurOfwmA5fgMDfncKVH11XPrin95fgH3H4tEMSeteSWMdfjLwWcdZj4rVIa3Jqj+fzUj6WJ9MMj0Py@nongnu.org
X-Gm-Message-State: AOJu0Ywi2PcFcIIH+9t+LST4EHS1zz19w+tJznLKASfiBD+x5ECUSY9X
 mmYNBcvYfvGELsxlFUpgerdGP4PTD1E4VYanYjOSbTYQFEspwYYoyY8pPNTQ/3ykY+U=
X-Gm-Gg: ASbGncsXr1VfKwaDatD2IYrqIp7h3f9577nCA5iuIZzg0SHt/MLJdXijbtXcVGIkl4i
 1l6/7pHbb2HFk3wMMMe3hEDN3ouQak0QZD94DX7w+t4TZ4FamJzvXZzyHuXrRqvLiKowYbOlU8x
 hdETskiT0tzQVhUKVNtzHhL0tzUorTNzBoJMh0sK1xMrH1xelRS/UgxVYejozm8EUA5iWpE84Md
 H06cTDNC4pJz6t+T/Z9NwyS7MaGhSh7GwOLB3oULfduBL0qq73MMuHOu/9371XslzAl/nSH2NB5
 lFEQBibrtLdbx7BTQmzAUQgphLDZAa7N1g5G2wFMGv1qznTsuPxCeiijY2GDILTU/xEVoZRVai1
 RzuTK3YL5GMfVylr+4CvelwJ3jG23zhjKVoShcTa7cZ9uhQ==
X-Google-Smtp-Source: AGHT+IE8zIQzkifg4Ebek3jDvHwN8mDWe3akQYP14n6E6xMsnt8wpS93jQH0QRD0Epl7+w/RkKk9pQ==
X-Received: by 2002:a17:906:7313:b0:b41:297c:f7bb with SMTP id
 a640c23a62f3a-b50aaa9b6f8mr1244720466b.26.1760097203747; 
 Fri, 10 Oct 2025 04:53:23 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d61d04dfsm216300466b.22.2025.10.10.04.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 04:53:22 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2641A5F7F6;
 Fri, 10 Oct 2025 12:53:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,  qemu-devel@nongnu.org,  Gerd
 Hoffmann <kraxel@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH] Add support for zboot images compressed with zstd
In-Reply-To: <CAFEAcA-iQkqxR5jPtGC1EAtcH4FYD5y71x6RFSWC3vP05krScw@mail.gmail.com>
 (Peter Maydell's message of "Fri, 10 Oct 2025 11:05:43 +0100")
References: <20251008191716.3005164-1-daan.j.demeyer@gmail.com>
 <CAFEAcA-iQkqxR5jPtGC1EAtcH4FYD5y71x6RFSWC3vP05krScw@mail.gmail.com>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Fri, 10 Oct 2025 12:53:22 +0100
Message-ID: <87sefrvuq5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 8 Oct 2025 at 20:17, Daan De Meyer <daan.j.demeyer@gmail.com> wro=
te:
>>
>> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> ---
>>  hw/arm/boot.c       |  2 +-
>>  hw/core/loader.c    | 36 ++++++++++++++++++++++++------------
>>  hw/nvram/fw_cfg.c   |  2 +-
>>  include/hw/loader.h |  2 +-
>>  4 files changed, 27 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index e77d8679d8..c0dec0343a 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -826,7 +826,7 @@ static uint64_t load_aarch64_image(const char *filen=
ame, hwaddr mem_base,
>>      ssize_t size;
>>
>>      /* On aarch64, it's the bootloader's job to uncompress the kernel. =
*/
>> -    size =3D load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_GUNZIP_=
BYTES,
>> +    size =3D load_image_gzipped_buffer(filename, LOAD_IMAGE_MAX_DECOMPR=
ESSED_BYTES,
>>                                       &buffer);
>
> I would either not bother renaming this constant, or else do
> it in a preliminary patch of its own in the series. (That
> makes the part of the patch which is making the functional
> change easier to read and review.)
>
>> @@ -882,14 +887,6 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ss=
ize_t *size)
>>          return 0;
>>      }
>>
>> -    if (strcmp(header->compression_type, "gzip") !=3D 0) {
>> -        fprintf(stderr,
>> -                "unable to handle EFI zboot image with \"%.*s\" compres=
sion\n",
>> -                (int)sizeof(header->compression_type) - 1,
>> -                header->compression_type);
>> -        return -1;
>> -    }
>> -
>>      ploff =3D ldl_le_p(&header->payload_offset);
>>      plsize =3D ldl_le_p(&header->payload_size);
>>
>> @@ -898,8 +895,23 @@ ssize_t unpack_efi_zboot_image(uint8_t **buffer, ss=
ize_t *size)
>>          return -1;
>>      }
>>
>> -    data =3D g_malloc(LOAD_IMAGE_MAX_GUNZIP_BYTES);
>> -    bytes =3D gunzip(data, LOAD_IMAGE_MAX_GUNZIP_BYTES, *buffer + ploff=
, plsize);
>> +    data =3D g_malloc(LOAD_IMAGE_MAX_DECOMPRESSED_BYTES);
>> +
>> +    if (strcmp(header->compression_type, "gzip") =3D=3D 0) {
>> +        bytes =3D gunzip(data, LOAD_IMAGE_MAX_DECOMPRESSED_BYTES, *buff=
er + ploff, plsize);
>> +#ifdef CONFIG_ZSTD
>> +    } else if (strcmp(header->compression_type, "zstd") =3D=3D 0) {
>> +        size_t ret =3D ZSTD_decompress(data, LOAD_IMAGE_MAX_DECOMPRESSE=
D_BYTES, *buffer + ploff, plsize);
>> +        bytes =3D ZSTD_isError(ret) ? -1 : (ssize_t) ret;
>> +#endif
>> +    } else {
>> +        fprintf(stderr,
>> +                "unable to handle EFI zboot image with \"%.*s\" compres=
sion\n",
>> +                (int)sizeof(header->compression_type) - 1,
>> +                header->compression_type);
>> +        return -1;
>
> Moving the "unrecognized compression type" error path down to
> here means that we have moved it below the g_malloc() of the
> data buffer, so we now need to g_free() to avoid a leak.

Could we not declare:

      g_autofree uint8_t *data =3D NULL;

and drop the cleanup?

>
>> +    }
>> +
>>      if (bytes < 0) {
>>          fprintf(stderr, "failed to decompress EFI zboot image\n");
>>          g_free(data);
>
> Otherwise I think this looks OK.
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

