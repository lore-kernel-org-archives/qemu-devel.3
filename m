Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D88FC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 20:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP5zX-0006qf-0s; Tue, 10 Jun 2025 16:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uP5zV-0006qA-1k
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 16:54:41 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1uP5zS-0005Xw-Kp
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 16:54:40 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad574992fcaso897893066b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749588877; x=1750193677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6aMUh0s8i5ZPgANPwljmMntu9iB/q//XXVWXrT+SIfQ=;
 b=b80kJE+2yXZ+GDQrSA4YVC0J9ZmPd5jncXoL9JMEfE64yhoRF0J3RO4rlwGxpkdp7I
 f0PosjcHeRe65bRgEATpfVi7aa4uYcEZrnOAmFN4dUDiv3Re+EUbBvD7h745zNuzdH/Y
 jexXQylYzeVmWvRp1VuODYO+Z+Td4E8U8USDbFADiO1X0iLXPg7msDyylcIyZAWP59OO
 97WmFlhQYJjgEXJpUoBFD0YSyP41Gb3pvDrlcLeEOnZA5h/CsWeX5pDiWnqDxEXWhl8N
 ljgHGUoIvzVWm8tuOfz/WgG4H6LcEHl7PYoXqgBLn7jWaARVo8EzaC4ijY0m1laBbfRi
 QWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749588877; x=1750193677;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6aMUh0s8i5ZPgANPwljmMntu9iB/q//XXVWXrT+SIfQ=;
 b=pPp+OzulF2ENZVfdu5B273+CmxQHKz2pDcOlllzBDnm1l6waNYkyBD+ikFoAyl8w2E
 8R+vK7y8iirdx4NvhxjohI2cgkGm2/cgmP9Lj3HNEDIqSWh6grDOmuLNLQV9MopgLXsX
 KcbnZs64alimeLmm5+uUS9/i8cFrboXESRh6QODphVHDiPgCgg1hHA0Dt3oxOUjxjezd
 pw3KlWRd5uIrKps9yCwzQnrCKhyiCI/WvUKCRtuQn+/IWkAQSPk1zQB6CV0LYvrd1pRn
 lC3xD6F3aoXwxaT+/Zwh6yBbhRHcb5FxvKvI4WHidhtxLzLjIUlcOd2ekKHyCYGjCr6A
 DszQ==
X-Gm-Message-State: AOJu0YxSA+enGJGu+XCXHtGMPGkod8btEV0Rc5DRpmBifvk/Qq4ld9Os
 YN1iEHFkKxyvhRLPsifC22hbASl3Ve4IW6hghdWJaFEAdNwIAX3iNoDluUb4aQ==
X-Gm-Gg: ASbGnctNQLx2g9o/skc9vLaVfJoeKgFffQ9l63d3R1h0X0vXhvNwVBPl/p2ZraQJC4a
 czt3zeo/k+McHDLTHEvZFP7JFkNmSQvjRnN9otLlZbMl/1VAx2ukaf7CEe/LMPp/7/MUYrdk28E
 haINQa4rSek/3pS+OiYms7F/rB29Hwr++SVHlV4ksjtcnAdOXM5bDOorC45MDQyjOFIKbYNqfzz
 cYFu2B1vf4bNcrmwpcAb6ir9pm4rdiK/cM0TRWx8/x/V/3jR323Y7zrNKlLgsf1Cb25iAap7pEL
 +8Wg7vFgwEz223XdzPGIfCPvgbM7quQC4Nph/Z5+1mgAXmxfLFVt+a+UKLtoNlsfsCqu2BFzRdv
 p8WbM4Dj21sAUaqdsxYVsuE5ayr6U4E9CEiPf96Q=
X-Google-Smtp-Source: AGHT+IFRrlCor4YUjSjrsmH0U4XK7+6NQ1vNYWolaZDW6XilElzrwHelxDN6n7093n3Y7HEPhN/2Hg==
X-Received: by 2002:a17:907:6d18:b0:ad8:9257:573f with SMTP id
 a640c23a62f3a-ade893eac54mr83585766b.7.1749588876583; 
 Tue, 10 Jun 2025 13:54:36 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-237-205.77.183.pool.telefonica.de.
 [77.183.237.205]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c795sm784689666b.90.2025.06.10.13.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 13:54:36 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:54:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Thomas Huth <thuth@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org
Subject: Re: [PULL 36/58] pc-bios: Move device tree files in their own subdir
In-Reply-To: <D40F7961-C681-4945-9E92-E0ED4B60C1B3@gmail.com>
References: <20250425152843.69638-1-philmd@linaro.org>
 <20250425152843.69638-37-philmd@linaro.org>
 <621F23F2-05FC-4C8C-8AA8-F61DED04B306@gmail.com>
 <83dcb220-dd06-fb7f-1960-432fb2696b60@eik.bme.hu>
 <0648af18-2e50-4eaa-96fb-b0e64eb706d9@linaro.org>
 <05174912-B148-4ECB-9F8C-4C0641FFC2BB@gmail.com>
 <6b0cddfb-4ebe-4775-becc-c4301235849d@redhat.com>
 <D40F7961-C681-4945-9E92-E0ED4B60C1B3@gmail.com>
Message-ID: <2F58DDCF-40DC-4971-9C8A-31AA1450C5DA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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



Am 4=2E Juni 2025 09:59:44 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 3=2E Juni 2025 11:38:59 UTC schrieb Thomas Huth <thuth@redhat=2Ecom>:
>>On 03/06/2025 08=2E39, Bernhard Beschow wrote:
>>>=20
>>>=20
>>> Am 2=2E Juni 2025 08:12:39 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>>>> On 30/5/25 02:54, BALATON Zoltan wrote:
>>>>> On Thu, 29 May 2025, Bernhard Beschow wrote:
>>>>>> Am 25=2E April 2025 15:28:20 UTC schrieb "Philippe Mathieu-Daud=C3=
=A9" <philmd@linaro=2Eorg>:
>>>>>>> From: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>>>>=20
>>>>>>> We have several device tree files already and may have more in the
>>>>>>> future so add a new dtb subdirectory and move device tree files th=
ere
>>>>>>> so they are not mixed with ROM binaries=2E
>>>>>>>=20
>>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>>>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>>>>> Message-ID: <57f179bd3904c1f2ca062ca4d4ff9592bb4f4daa=2E1745402140=
=2Egit=2Ebalaton@eik=2Ebme=2Ehu>
>>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>>>>>> ---
>>>>>>> MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +=
-
>>>>>>> system/datadir=2Ec=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +++-
>>>>>>> pc-bios/{ =3D> dtb}/bamboo=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin
>>>>>>> pc-bios/{ =3D> dtb}/bamboo=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>>>>> pc-bios/{ =3D> dtb}/canyonlands=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Bin
>>>>>>> pc-bios/{ =3D> dtb}/canyonlands=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 0
>>>>>>> pc-bios/dtb/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 23 +++++++++++++++++++++
>>>>>>> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | Bin
>>>>>>> pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 0
>>>>>>> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb | Bin
>>>>>>> pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts |=C2=A0=C2=A0 0
>>>>>>> pc-bios/meson=2Ebuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 23 +--------------------
>>>>>>> qemu=2Ensi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 2 +-
>>>>>>> 13 files changed, 29 insertions(+), 25 deletions(-)
>>>>>>> rename pc-bios/{ =3D> dtb}/bamboo=2Edtb (100%)
>>>>>>> rename pc-bios/{ =3D> dtb}/bamboo=2Edts (100%)
>>>>>>> rename pc-bios/{ =3D> dtb}/canyonlands=2Edtb (100%)
>>>>>>> rename pc-bios/{ =3D> dtb}/canyonlands=2Edts (100%)
>>>>>>> create mode 100644 pc-bios/dtb/meson=2Ebuild
>>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edtb (100%)
>>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-ml605=2Edts (100%)
>>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edtb (100%)
>>>>>>> rename pc-bios/{ =3D> dtb}/petalogix-s3adsp1800=2Edts (100%)
>>>>>>>=20
>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>> index 661a47db5ac=2E=2Ed82d962f1a4 100644
>>>>>>> --- a/MAINTAINERS
>>>>>>> +++ b/MAINTAINERS
>>>>>>> @@ -1581,7 +1581,7 @@ F: hw/pci-host/ppc440_pcix=2Ec
>>>>>>> F: hw/display/sm501*
>>>>>>> F: hw/ide/sii3112=2Ec
>>>>>>> F: hw/rtc/m41t80=2Ec
>>>>>>> -F: pc-bios/canyonlands=2Edt[sb]
>>>>>>> +F: pc-bios/dtb/canyonlands=2Edt[sb]
>>>>>>> F: pc-bios/u-boot-sam460ex-20100605=2Ebin
>>>>>>> F: roms/u-boot-sam460ex
>>>>>>> F: docs/system/ppc/amigang=2Erst
>>>>>>> diff --git a/system/datadir=2Ec b/system/datadir=2Ec
>>>>>>> index e450b84ce91=2E=2Ef96f8fc2646 100644
>>>>>>> --- a/system/datadir=2Ec
>>>>>>> +++ b/system/datadir=2Ec
>>>>>>> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const c=
har *name)
>>>>>>>=20
>>>>>>>  =C2=A0=C2=A0=C2=A0 switch (type) {
>>>>>>>  =C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_BIOS:
>>>>>>> -=C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_DTB:
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "";
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>> +=C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_DTB:
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "dtb/";
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>>  =C2=A0=C2=A0=C2=A0 case QEMU_FILE_TYPE_KEYMAP:
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subdir =3D "keymaps/";
>>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>>> diff --git a/pc-bios/bamboo=2Edtb b/pc-bios/dtb/bamboo=2Edtb
>>>>>>> similarity index 100%
>>>>>>> rename from pc-bios/bamboo=2Edtb
>>>>>>> rename to pc-bios/dtb/bamboo=2Edtb
>>>>>>> diff --git a/pc-bios/bamboo=2Edts b/pc-bios/dtb/bamboo=2Edts
>>>>>>> similarity index 100%
>>>>>>> rename from pc-bios/bamboo=2Edts
>>>>>>> rename to pc-bios/dtb/bamboo=2Edts
>>>>>>> diff --git a/pc-bios/canyonlands=2Edtb b/pc-bios/dtb/canyonlands=
=2Edtb
>>>>>>> similarity index 100%
>>>>>>> rename from pc-bios/canyonlands=2Edtb
>>>>>>> rename to pc-bios/dtb/canyonlands=2Edtb
>>>>>>> diff --git a/pc-bios/canyonlands=2Edts b/pc-bios/dtb/canyonlands=
=2Edts
>>>>>>> similarity index 100%
>>>>>>> rename from pc-bios/canyonlands=2Edts
>>>>>>> rename to pc-bios/dtb/canyonlands=2Edts
>>>>>>> diff --git a/pc-bios/dtb/meson=2Ebuild b/pc-bios/dtb/meson=2Ebuild
>>>>>>> new file mode 100644
>>>>>>> index 00000000000=2E=2E7a71835bca7
>>>>>>> --- /dev/null
>>>>>>> +++ b/pc-bios/dtb/meson=2Ebuild
>>>>>>> @@ -0,0 +1,23 @@
>>>>>>> +dtbs =3D [
>>>>>>> +=C2=A0 'bamboo=2Edtb',
>>>>>>> +=C2=A0 'canyonlands=2Edtb',
>>>>>>> +=C2=A0 'petalogix-ml605=2Edtb',
>>>>>>> +=C2=A0 'petalogix-s3adsp1800=2Edtb',
>>>>>>=20
>>>>>> Was it intended that the suffix changed from =2Edts to =2Edtb? This=
 change isn't motivated in the commit message and usually source files rath=
er than generated artifacts are listed in build files=2E
>>>>>=20
>>>>> I think I either found similar python code somewhere and followed th=
at because meson and python is not something I understand well=2E Or change=
d it because we always need the list of dtbs to install but only need the d=
ts when compiling so this way we don't need another list or replacing suffi=
x twice=2E
>>>>=20
>>>> Should we revert?
>>>=20
>>> What's the idea behind having dtbs in the repository instead of making=
 dtc mandatory? If there is any perspective that we could remove the dtbs i=
n the future I vote for restoring the original logic=2E I could send a patc=
h since I have further dtb fixes for the e500 and arm=2E
>>
>>IMHO since we require libfdt for many boards already anyway, we could al=
so require dtc for these boards that need a dtb (and disable them if dtc is=
 not available) =2E=2E=2E we just might need some additional Kconfig symbol=
 for that case since dtc and libfdt are sometimes shipped in different pack=
ages on the various distros and thus could be installed independently from =
each other=2E
>
>I'd try that, and I have some ideas on how to make this work similar to h=
ow we deal with =2Ec files=2E I could then use this mechanism in my e500-fd=
t branch=2E Let's see=2E=2E=2E

Series is out: <https://lore=2Ekernel=2Eorg/qemu-devel/20250610204131=2E28=
62-1-shentey@gmail=2Ecom/>

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>>
>> Thomas
>>

