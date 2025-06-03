Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A45C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 06:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMLKX-000537-08; Tue, 03 Jun 2025 02:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uMLJ7-0003ka-06
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:39:35 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uMLJ4-0003ZR-5d
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 02:39:32 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad572ba1347so763889666b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 23:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748932766; x=1749537566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ea6hTdxF4uF0H2AFslhuAGNmreKAbr7zkjNo4QRPqEo=;
 b=ebd6r9fe1wyNX071kwWdks0TU3MgjJCIUTkUuKW+r2TFbE+FJ3skrxxIkEmXLL6DaZ
 c3TLYUvEBUlkr4vYHwD4WkBhHqjp5D7Wk2Ksdf5eJZIEWqilT1U8T5pAE0nyeNzKC29u
 fuXJdkNGZzNgaNTQQhG6DZAJoOvU+7sPfWn+4PjQHTK80M4YIdUhaZRhm4S4FrE7i2Lf
 E6cOetDr4cLpWAhljla/iYkH6w0y+Yqk4eYYZoSWjttb8HBbJ1phE+zzcstd22KVaAOP
 /reCiBOht/Mi9gvZNq1eZhRufxpYMH/n9LpJ5tTYuaHfyNGNoag4ZHkJUakv+l5qnyTL
 /TwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748932766; x=1749537566;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ea6hTdxF4uF0H2AFslhuAGNmreKAbr7zkjNo4QRPqEo=;
 b=B/mstg9tIO3ZPT8dc50qTcI4eikeqfFNIANrr6IAYWOSgzjMdO/uApP907zM6/pntI
 qUffKmd86UeV1dgk9xaZCfjzqXto/H6I5b3TU6cDYegO1xUFpH8JuN0aYTesWGehJ7eY
 2f8KHPogSYYqvvJIuQUCbstivHXAzKBJvLJrb0j+S3EwHZL37GeRDIULLzRsM9tJf3QF
 tHhoRVDqv69gIraViJJoBoppyJThLTTn/LPmvrmz4ytPOLWMHNZOyGH1dpdSRkc5nN2c
 kLYGw9d9K8sHGF5Am2NNqT0u6CqeJ0hWW4pbdfUUEu6jDtheWNBy8yLnanKP/rlQQ/jl
 wgEQ==
X-Gm-Message-State: AOJu0YxIPORlvEz/2S4ffRo2qUE7FjynXlw6BTcNJPsmtwSObgHht0Gd
 VgBwMLqyRm6d0AnuYGJj0wEUytHsYMAl5mfxFjtu2IrDCkX9c2SBSsxuRfYkuA==
X-Gm-Gg: ASbGnctRHDHZfsqD1dZ6Trm/sHoMZgSk3baVoZhrAvs7fWZqAQA7KjpQwj5kqOKYQa0
 2+SXjVqFR8RIbFS1dtJr393MsJQLv6TKVtf/014/7w+jDInma1RTMuxs0eNkuMQ7VlMn8IQeGm+
 MXu4e9i6900y2r2m3MSPVtwEmyhF3C99fHGy6NyGeEfg3k5E2R9u1BWxqa5bKYm0h9wPhEGQHXL
 jxSG6yHDPKkQm8U7aiqZQ9iMmCoBqB1WN3IyfXHwomvkEjX7qY2ye9BQ7EpWbs98Xfw8xFEr8dH
 Kj2Z4Oj9dnOGz0HfsiO0d24NGOWXrKTqmk5ztCSJ1euVMdc9TVUj8KGxcc3+0WlbPi4g/J0YKKE
 vN35pcEyi59r7/0nsAfWPyrSIT43AXG8hFfJYeYOUpNK3U+lQURmdUgKNMEU1DksHaa4SwdrO/E
 3CTMw=
X-Google-Smtp-Source: AGHT+IHwcQ/EUH6ICb2QqSi7JQretsCbvZeE0bWVTu+ij0eDqaLnObu7XnjNpK1aVqfK2EpW2ythBg==
X-Received: by 2002:a17:907:9721:b0:ad8:a935:b8e8 with SMTP id
 a640c23a62f3a-adb49370432mr1032424566b.5.1748932766107; 
 Mon, 02 Jun 2025 23:39:26 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2c1d-9800-e96f-0ee8-1bd2-ecbf.310.pool.telefonica.de.
 [2a02:3100:2c1d:9800:e96f:ee8:1bd2:ecbf])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fef7dsm906194766b.6.2025.06.02.23.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 23:39:25 -0700 (PDT)
Date: Tue, 03 Jun 2025 06:39:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
In-Reply-To: <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
 <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
Message-ID: <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 2=2E Juni 2025 08:12:39 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@linaro=2Eorg>:
>On 30/5/25 02:54, BALATON Zoltan wrote:
>> On Thu, 29 May 2025, Bernhard Beschow wrote:
>>> Am 25=2E April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=
 <philmd@linaro=2Eorg>:
>>>> From: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>=20
>>>> We have several device tree files already and may have more in the
>>>> future so add a new dtb subdirectory and move device tree files there
>>>> so they are not mixed with ROM binaries=2E
>>>>=20
>>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>> Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa=2E1745402140=2E=
git=2Ebalaton@eik=2Ebme=2Ehu>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>> ---
>>>> MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>> system/datadir=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +++-
>>>> pc-bios/{ =3D> dtb}/bamboo=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin
>>>> pc-bios/{ =3D> dtb}/bamboo=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>> pc-bios/{ =3D> dtb}/canyonlands=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | Bin
>>>> pc-bios/{ =3D> dtb}/canyonlands=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>> pc-bios/dtb/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 23 +++++++++++++++++++++
>>>> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | Bin
>>>> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 0
>>>> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb | Bin
>>>> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts |=C2=A0=C2=A0 0
>>>> pc-bios/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 23 +--------------------
>>>> qemu=2Ensi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +-
>>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>>> rename pc-bios/{ =3D> dtb}/bamboo=2Edtb (100%)
>>>> rename pc-bios/{ =3D> dtb}/bamboo=2Edts (100%)
>>>> rename pc-bios/{ =3D> dtb}/canyonlands=2Edtb (100%)
>>>> rename pc-bios/{ =3D> dtb}/canyonlands=2Edts (100%)
>>>> create mode 100644 pc-bios/dtb/meson=2Ebuild
>>>> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb (100%)
>>>> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts (100%)
>>>> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb (100%)
>>>> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts (100%)
>>>>=20
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 661a47db5ac=2E=2Ed82d962f1a4 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix=2Ec
>>>> F: hw/display/sm501*
>>>> F: hw/ide/sii3112=2Ec
>>>> F: hw/rtc/m41t80=2Ec
>>>> -F: pc-bios/canyonlands=2Edt[sb]
>>>> +F: pc-bios/dtb/canyonlands=2Edt[sb]
>>>> F: pc-bios/u-boot-sam460ex-20100605=2Ebin
>>>> F: roms/u-boot-sam460ex
>>>> F: docs/system/ppc/amigang=2Erst
>>>> diff --git a/system/datadir=2Ec b/system/datadir=2Ec
>>>> index e450b84ce91=2E=2Ef96f8fc2646 100644
>>>> --- a/system/datadir=2Ec
>>>> +++ b/system/datadir=2Ec
>>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char=
 *name)
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0 switch (type) {
>>>> =C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_BIOS:
>>>> -=C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_DTB:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_DTB:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "dtb/";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> =C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_KEYMAP:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "keymaps/";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> diff --git a/pc-bios/bamboo=2Edtb b/pc-bios/dtb/bamboo=2Edtb
>>>> similarity index 100%
>>>> rename from pc-bios/bamboo=2Edtb
>>>> rename to pc-bios/dtb/bamboo=2Edtb
>>>> diff --git a/pc-bios/bamboo=2Edts b/pc-bios/dtb/bamboo=2Edts
>>>> similarity index 100%
>>>> rename from pc-bios/bamboo=2Edts
>>>> rename to pc-bios/dtb/bamboo=2Edts
>>>> diff --git a/pc-bios/canyonlands=2Edtb b/pc-bios/dtb/canyonlands=2Edt=
b
>>>> similarity index 100%
>>>> rename from pc-bios/canyonlands=2Edtb
>>>> rename to pc-bios/dtb/canyonlands=2Edtb
>>>> diff --git a/pc-bios/canyonlands=2Edts b/pc-bios/dtb/canyonlands=2Edt=
s
>>>> similarity index 100%
>>>> rename from pc-bios/canyonlands=2Edts
>>>> rename to pc-bios/dtb/canyonlands=2Edts
>>>> diff --git a/pc-bios/dtb/meson=2Ebuild b/pc-bios/dtb/meson=2Ebuild
>>>> new file mode 100644
>>>> index 00000000000=2E=2E7a71835bca7
>>>> --- /dev/null
>>>> +++ b/pc-bios/dtb/meson=2Ebuild
>>>> @@ -0,0 +1,23 @@
>>>> +dtbs =3D [
>>>> +=C2=A0 'bamboo=2Edtb',
>>>> +=C2=A0 'canyonlands=2Edtb',
>>>> +=C2=A0 'petalogix-ml605=2Edtb',
>>>> +=C2=A0 'petalogix-s3adsp1800=2Edtb',
>>>=20
>>> Was it intended that the suffix changed from =2Edts to =2Edtb? This ch=
ange isn't motivated in the commit message and usually source files rather =
than generated artifacts are listed in build files=2E
>>=20
>> I think I either found similar python code somewhere and followed that =
because meson and python is not something I understand well=2E Or changed i=
t because we always need the list of dtbs to install but only need the dts =
when compiling so this way we don't need another list or replacing suffix t=
wice=2E
>
>Should we revert?

What's the idea behind having dtbs in the repository instead of making dtc=
 mandatory? If there is any perspective that we could remove the dtbs in th=
e future I vote for restoring the original logic=2E I could send a patch si=
nce I have further dtb fixes for the e500 and arm=2E

Best regards,
Bernhard

