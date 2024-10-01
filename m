Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B3DCEACFC
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 19:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sviaw-0001Rc-9L; Tue, 01 Oct 2024 15:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sviap-0001RN-PL; Tue, 01 Oct 2024 15:31:31 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1svian-0000sQ-Fo; Tue, 01 Oct 2024 15:31:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37cdbcb139cso3240555f8f.1; 
 Tue, 01 Oct 2024 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727811087; x=1728415887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpXcBjNrgdlSvmssRwGHpqpdyLxDVCVuOqG07Q7VfGI=;
 b=Qtm82r3qmWUr4BJYCU9zSiuRcIhiAkO0jPsNfhL7cuBqLO8F8eQyY7I/aFLwzvqiRm
 iiNNMbx4JRE6dzmsYEwcZpU5OkRMaTGvjL9j7bY/VoilS04AkpzTlpGU8WaD+ooR3kzM
 bOfyriVxwMNHLMtHMq19GJg1I+0UocmrRVYi1/kstNiS1BSeGhq74vRYj0Bz/nMUCFQg
 5ZJodFX75PH5oQqzea2BepZlUrcDdLC0EaZ99Rj12XawTjDfZ0DJnDtMXhJrCCntfcMi
 iWhh/LO1tfAj4bn+tOcWX1QIHHAsv4pb4Kmbp1UaO1tZzpxulNURhTnLjrKGd7oNZDBl
 rYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727811087; x=1728415887;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpXcBjNrgdlSvmssRwGHpqpdyLxDVCVuOqG07Q7VfGI=;
 b=cQu916UNV2eQD71Cs+Ky5tAAZjErBL4MJW89Aa30OMOUTy0FrvDkEn0NY6le3X0bnE
 BqHX9ISCcJmeNB47rKGrF63EGU5D6GJMuXghwp/AZxqNA3/YJuh34+KdghzMtrSfsGRY
 QIKmIt8F8BEptca0JUs92eAgzsQPlxjGya4yBiNpnRxrJiR5FnKL+yWqf6B7C+Q3k2MT
 pCt+vnxpLUFyu1FQgWwb8JAvlIkY+vLIgmJPsk4bpXJD4phK4eigPU3Iv8tSESbFo+v8
 Lmnayc88soKiZ4R0NyHTxPp952cx+X7u3CZwIIKLa9dAM3ol9AjhggejAOrAn35F9ZNq
 H66g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUu8b6UTXfvNnwFt50iS6icWgL4yvkn8+7bHFfR9XTEpbzezQ+A4SJxr0WnDg9TBkwNpuByGzLrSII@nongnu.org,
 AJvYcCWDn3kx/ta1LDszUuZCh83DO4jMcBNpjI0EzavopNaRWYF3jNPGFxS/lDaG26KAjxqmYQPLomqYPCA=@nongnu.org
X-Gm-Message-State: AOJu0Yy75POtbV67cQ04ON/+8pjT2CBeaVAuh60CJqUnoV2CtiLmGTiG
 OVzLWUk5m2DEESCe7rRS/DZz8Vp3fS7fdeAIrBZPA/DgByxfQiWy
X-Google-Smtp-Source: AGHT+IGYO6g79sp1MONsSwlHl3BgEWtJc19tjCLQowst6tPAPMl9hSryarNXZ2N7E9knAnAP1N3MMw==
X-Received: by 2002:a05:6000:2cb:b0:368:445e:91cc with SMTP id
 ffacd0b85a97d-37cfb8c6c48mr486129f8f.21.1727811086578; 
 Tue, 01 Oct 2024 12:31:26 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-096-038.78.55.pool.telefonica.de.
 [78.55.96.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57debf07sm139004955e9.22.2024.10.01.12.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 12:31:26 -0700 (PDT)
Date: Tue, 01 Oct 2024 19:31:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 07/23] hw/ppc/e500: Extract ppce500_ccsr.c
In-Reply-To: <7BA1D025-2B5B-4090-B9DF-A73F43BA6BB9@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-8-shentey@gmail.com>
 <001e172d-4046-66cc-4758-a7a206fda931@eik.bme.hu>
 <7BA1D025-2B5B-4090-B9DF-A73F43BA6BB9@gmail.com>
Message-ID: <8E4DB99F-E981-4C35-AC7C-E25344B60E84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42f.google.com
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



Am 24=2E September 2024 20:02:31 UTC schrieb Bernhard Beschow <shentey@gma=
il=2Ecom>:
>
>
>Am 23=2E September 2024 10:38:46 UTC schrieb BALATON Zoltan <balaton@eik=
=2Ebme=2Ehu>:
>>On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>>> The device model already has a header file=2E Also extract its impleme=
ntation into
>>> an accompanying source file like other e500 devices=2E
>>>=20
>>> This commit is also a preparation for the next commit=2E
>>>=20
>>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>>> ---
>>> MAINTAINERS           |  2 +-
>>> hw/ppc/e500-ccsr=2Eh    |  2 ++
>>> hw/ppc/e500=2Ec         | 17 -----------------
>>> hw/ppc/ppce500_ccsr=2Ec | 38 ++++++++++++++++++++++++++++++++++++++
>>
>>Maybe you could call it e500_ccsr=2Ec and also rename the header to e500=
_ccsr=2Eh (underscore instead of dash) to match them=2E Or if you want to m=
atch ppce500_spin=2Ec then maybe move contents of e500-ccsr=2Eh to e500=2Eh=
?
>
>Yeah, naming is hard=2E I'd actually prefer something like fsl_immr=2E* (=
taking inspiration from device tree here) to not confuse the whole SoC with=
 the CPU=2E With the ppce500 prefix I was sticking to the convention of the=
 PCIE device=2E Though there is also mpc-i2c and fsl_etsec=2E=2E=2E

I'll name the header like the struct it defines, i=2Ee=2E ppce500_ccsr=2Eh=
=2E

>
>>(More below=2E=2E=2E)
>>
>>> hw/ppc/meson=2Ebuild    |  1 +
>>> 5 files changed, 42 insertions(+), 18 deletions(-)
>>> create mode 100644 hw/ppc/ppce500_ccsr=2Ec
>>>=20
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ffacd60f40=2E=2Eb7c8b7ae72 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1433,7 +1433,7 @@ e500
>>> L: qemu-ppc@nongnu=2Eorg
>>> S: Orphan
>>> F: hw/ppc/e500*
>>> -F: hw/ppc/ppce500_spin=2Ec
>>> +F: hw/ppc/ppce500_*=2Ec
>>> F: hw/gpio/mpc8xxx=2Ec
>>> F: hw/i2c/mpc_i2c=2Ec
>>> F: hw/net/fsl_etsec/
>>> diff --git a/hw/ppc/e500-ccsr=2Eh b/hw/ppc/e500-ccsr=2Eh
>>> index 249c17be3b=2E=2E3ab7e72568 100644
>>> --- a/hw/ppc/e500-ccsr=2Eh
>>> +++ b/hw/ppc/e500-ccsr=2Eh
>>> @@ -4,6 +4,8 @@
>>> #include "hw/sysbus=2Eh"
>>> #include "qom/object=2Eh"
>>>=20
>>> +#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
>>> +
>>> struct PPCE500CCSRState {
>>>     /*< private >*/
>>>     SysBusDevice parent;
>>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>>> index 2225533e33=2E=2E4ee4304a8a 100644
>>> --- a/hw/ppc/e500=2Ec
>>> +++ b/hw/ppc/e500=2Ec
>>> @@ -61,7 +61,6 @@
>>> #define RAM_SIZES_ALIGN            (64 * MiB)
>>>=20
>>> /* TODO: parameterize */
>>> -#define MPC8544_CCSRBAR_SIZE       0x00100000ULL
>>> #define MPC8544_MPIC_REGS_OFFSET   0x40000ULL
>>> #define MPC8544_MSI_REGS_OFFSET   0x41600ULL
>>> #define MPC8544_SERIAL0_REGS_OFFSET 0x4500ULL
>>> @@ -1264,21 +1263,6 @@ void ppce500_init(MachineState *machine)
>>>     pms->boot_info=2Edt_size =3D dt_size;
>>> }
>>>=20
>>> -static void e500_ccsr_initfn(Object *obj)
>>> -{
>>> -    PPCE500CCSRState *ccsr =3D CCSR(obj);
>>> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>>> -                       MPC8544_CCSRBAR_SIZE);
>>> -    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
>>> -}
>>> -
>>> -static const TypeInfo e500_ccsr_info =3D {
>>> -    =2Ename          =3D TYPE_CCSR,
>>> -    =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>>> -    =2Einstance_size =3D sizeof(PPCE500CCSRState),
>>> -    =2Einstance_init =3D e500_ccsr_initfn,
>>> -};
>>> -
>>> static const TypeInfo ppce500_info =3D {
>>>     =2Ename          =3D TYPE_PPCE500_MACHINE,
>>>     =2Eparent        =3D TYPE_MACHINE,
>>> @@ -1289,7 +1273,6 @@ static const TypeInfo ppce500_info =3D {
>>>=20
>>> static void e500_register_types(void)
>>> {
>>> -    type_register_static(&e500_ccsr_info);
>>>     type_register_static(&ppce500_info);
>>> }
>>>=20
>>> diff --git a/hw/ppc/ppce500_ccsr=2Ec b/hw/ppc/ppce500_ccsr=2Ec
>>> new file mode 100644
>>> index 0000000000=2E=2E191a9ceec3
>>> --- /dev/null
>>> +++ b/hw/ppc/ppce500_ccsr=2Ec
>>> @@ -0,0 +1,38 @@
>>> +/*
>>> + * QEMU PowerPC E500 embedded processors CCSR space emulation
>>> + *
>>> + * Copyright (C) 2009 Freescale Semiconductor, Inc=2E All rights rese=
rved=2E
>>> + *
>>> + * Author: Yu Liu,     <yu=2Eliu@freescale=2Ecom>
>>> + *
>>> + * This file is derived from hw/ppc440_bamboo=2Ec,
>>> + * the copyright for that material belongs to the original owners=2E
>>
>>I think CCSR is a Freescale thing so likely this has nothing to do with =
ppc440_bamboo so this sentence was for other parts of e500=2Ec not applicab=
le to this part=2E
>
>Good point=2E IANAL so erred on the safe side and copied the whole licens=
e text=2E I'm happy to omit this and would also prefer SPDX license identif=
iers as long as I get the confirmation that this is legal=2E

I'll remove the reference to ppc440_bamboo=2Ec which is clearly not releva=
nt here=2E Beyond that I rather leave the license text unchanged=2E

Best regards,
Bernhard

>
>Best regards,
>Bernhard
>
>>
>>> + *
>>> + * This is free software; you can redistribute it and/or modify
>>> + * it under the terms of  the GNU General  Public License as publishe=
d by
>>> + * the Free Software Foundation;  either version 2 of the  License, o=
r
>>> + * (at your option) any later version=2E
>>> + */
>>
>>SPDX-License-Identifier seems to be preferred by some nowadays, I don't =
have an opinion on that so just mentioning it for consideration but I'm OK =
with this one too although it seems a bit long=2E
>>
>>Regards,
>>BALATON Zoltan
>>
>>> +
>>> +#include "qemu/osdep=2Eh"
>>> +#include "e500-ccsr=2Eh"
>>> +
>>> +static void e500_ccsr_init(Object *obj)
>>> +{
>>> +    PPCE500CCSRState *ccsr =3D CCSR(obj);
>>> +
>>> +    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>>> +                       MPC8544_CCSRBAR_SIZE);
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(ccsr), &ccsr->ccsr_space);
>>> +}
>>> +
>>> +static const TypeInfo types[] =3D {
>>> +    {
>>> +        =2Ename          =3D TYPE_CCSR,
>>> +        =2Eparent        =3D TYPE_SYS_BUS_DEVICE,
>>> +        =2Einstance_size =3D sizeof(PPCE500CCSRState),
>>> +        =2Einstance_init =3D e500_ccsr_init,
>>> +    },
>>> +};
>>> +
>>> +DEFINE_TYPES(types)
>>> diff --git a/hw/ppc/meson=2Ebuild b/hw/ppc/meson=2Ebuild
>>> index 7cd9189869=2E=2E43c746795a 100644
>>> --- a/hw/ppc/meson=2Ebuild
>>> +++ b/hw/ppc/meson=2Ebuild
>>> @@ -81,6 +81,7 @@ ppc_ss=2Eadd(when: 'CONFIG_MPC8544DS', if_true: file=
s('mpc8544ds=2Ec'))
>>> ppc_ss=2Eadd(when: 'CONFIG_E500', if_true: files(
>>>   'e500=2Ec',
>>>   'mpc8544_guts=2Ec',
>>> +  'ppce500_ccsr=2Ec',
>>>   'ppce500_spin=2Ec'
>>> ))
>>> # PowerPC 440 Xilinx ML507 reference board=2E
>>>=20

