Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54923ECE578
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 23:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sn4fM-0003eo-VV; Sat, 07 Sep 2024 19:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sn4fG-0003dM-KU; Sat, 07 Sep 2024 19:16:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sn4fE-0005z8-OB; Sat, 07 Sep 2024 19:16:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42cae4eb026so7675935e9.0; 
 Sat, 07 Sep 2024 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725750977; x=1726355777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zdUYCB5+/YQr+E0TUUm0Dw5lCY94glCNJFdQX81xI9k=;
 b=Mvuu6oXuRC7EzrlvkiILtI0CMltGgvsfWoZdMtgDdhgwKs1Vt9g2zkwwu0N4S9rpjb
 Qtz96QlK4FYgA/QdHm/L5v1sXOd2lqbMYUAGdYrv+nGKIspAHZNcfFytkL0TUJAxd0r6
 my/G+rG2wKOR2Y+1FZoOyHa6IBZcqzilup/nfISl3T+iaiCEp/Wk2LNHNpQ9mSL79ACi
 FAhohXCVB1mXgstjS7K8610NhF8pLLp2sW8tr9Ug3HDQ23m0ef6uULtH+8ktFhEO8a4G
 0xEuGbj2m+C7VBd3WRiiqfyD8eKrMfgVTs25qP4Sa3MWm4ZaKYX6Xvuipm3qVnNl98IU
 TIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725750977; x=1726355777;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zdUYCB5+/YQr+E0TUUm0Dw5lCY94glCNJFdQX81xI9k=;
 b=JoCOWjFyb0nzk8cLTppyUa6flp3ooTTL30TCjX1knfW0888eOlr4c3eDXppMlFIl2L
 MnnqfXi44fN+oi7MlPE8jxe48NIbCyaaxjGAJLtxokHtiAiM+/HjN0kSlHcyAsYEVlHL
 z3fmXym8E9clChQo8bzD1DXQcV6n3QNT2mLLcZxQpcqwCnWAomske7T/anZI3dJHFp/U
 n0/fsiLO44i22+wuDUMlgEDxmZ+b2JCCuuOF63FkGNTBK5Yx/V7BLcWCC1OD4Dh3DUR1
 N0aNz8WnhOkaEDPZwILVe+KuEy2N8sOO/a0WvcVVtfle9JH0dgIAPTjcWn0jso003FMi
 0j2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKDZyJLMZJ/kFb98En2eKkcwqKOweef1rgUYM/fjVxVqjGdLnGXvlT6DTQDARNvp9+l9t5J8yXLIsR4g==@nongnu.org,
 AJvYcCVkhZelyoLsmY0ZTA8RhQrSXhHtRl2vtO7vQ7rehgnwB87B2cnSZfUXa19+VduZcIiXdZXKNm+xIJo=@nongnu.org,
 AJvYcCWRcKDrMIWmZHaH+zjas89qkJyMc81ivHT0ipP780VOOhcK3oUoOEYQReBjbzuwkgGuPUwk/DatvQ==@nongnu.org
X-Gm-Message-State: AOJu0YzfzJNvZRwBokcJvsIwk9rx7+KThMcbRwAMRYC7UGZsq9Ri3Z65
 JO0uqbe7AVFiNgCJ1y1c2TXJwwH9cPQItlDoq2SysBfu8RR0kGIR
X-Google-Smtp-Source: AGHT+IE3oPNtsLmeGhxgrRyUZTn7JO4U9vNi6p0bkRLny2KBsyBv3JWF4YxIrSRIE4hfdXOaUBgWJQ==
X-Received: by 2002:a5d:5452:0:b0:374:c0cc:a1fb with SMTP id
 ffacd0b85a97d-378896573fbmr4733165f8f.39.1725750977217; 
 Sat, 07 Sep 2024 16:16:17 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.7]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895675bc9sm2223140f8f.56.2024.09.07.16.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Sep 2024 16:16:16 -0700 (PDT)
Date: Sat, 07 Sep 2024 17:33:47 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 Helge Deller <deller@gmx.de>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joel Stanley <joel@jms.id.au>, Troy Lee <leetroy@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-riscv@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hao Wu <wuhaotsh@google.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?ISO-8859-1?Q?Fr=E9d=E9ric_Barrat?= <fbarrat@linux.ibm.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Tyrone Ting <kfting@nuvoton.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org,
 Sergio Lopez <slp@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Paul Burton <paulburton@kernel.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 3/3] hw/char: Extract serial-mm
In-Reply-To: <b80ddcfd-bd02-8ebd-315f-285c533aaf81@eik.bme.hu>
References: <20240905073832.16222-1-shentey@gmail.com>
 <20240905073832.16222-4-shentey@gmail.com>
 <b80ddcfd-bd02-8ebd-315f-285c533aaf81@eik.bme.hu>
Message-ID: <859EB9E2-9101-4F01-AF40-B8A2E8FF1783@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 5=2E September 2024 12:26:35 UTC schrieb BALATON Zoltan <balaton@eik=2E=
bme=2Ehu>:
>On Thu, 5 Sep 2024, Bernhard Beschow wrote:
>> hw/char/serial currently contains the implementation of both TYPE_SERIA=
L and
>> TYPE_SERIAL_MM=2E According to serial_class_init(), TYPE_SERIAL is an i=
nternal
>> class while TYPE_SERIAL_MM is used by numerous machine types directly=
=2E Let's
>> move the latter into its own module which makes the dependencies more o=
bvious
>> and the code more tidy=2E
>>=20
>> The includes and the dependencies have been converted mechanically exce=
pt in the
>> hw/char directories which were updated manually=2E The result was compi=
le-tested=2E
>> Now, only hw/char makes direct use of TYPE_SERIAL:
>>=20
>>  # grep -r -e "select SERIAL" | grep -v SERIAL_
>>  hw/char/Kconfig:    select SERIAL
>>  hw/char/Kconfig:    select SERIAL
>>  hw/char/Kconfig:    select SERIAL
>>  hw/char/Kconfig:    select SERIAL
>>  hw/char/Kconfig:    select SERIAL
>>=20
>>  # grep -r -e "/serial\\=2Eh"
>>  include/hw/char/serial-mm=2Eh:#include "hw/char/serial=2Eh"
>>  hw/char/serial-pci-multi=2Ec:#include "hw/char/serial=2Eh"
>>  hw/char/serial=2Ec:#include "hw/char/serial=2Eh"
>>  hw/char/serial-isa=2Ec:#include "hw/char/serial=2Eh"
>>  hw/char/serial-pci=2Ec:#include "hw/char/serial=2Eh"
>>=20
>> Tested-by: Andrew Jeffery <andrew@codeconstruct=2Ecom=2Eau>
>> Reviewed-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> include/hw/arm/aspeed_soc=2Eh         |   2 +-
>> include/hw/char/mchp_pfsoc_mmuart=2Eh |   2 +-
>> include/hw/char/serial-mm=2Eh         |  52 +++++++++
>> include/hw/char/serial=2Eh            |  19 ----
>> hw/arm/allwinner-a10=2Ec              |   2 +-
>> hw/arm/allwinner-h3=2Ec               |   2 +-
>> hw/arm/allwinner-r40=2Ec              |   2 +-
>> hw/arm/aspeed_ast2400=2Ec             |   2 +-
>> hw/arm/aspeed_soc_common=2Ec          |   2 +-
>> hw/arm/kzm=2Ec                        |   2 +-
>> hw/arm/msf2-soc=2Ec                   |   2 +-
>> hw/arm/musicpal=2Ec                   |   2 +-
>> hw/arm/npcm7xx=2Ec                    |   2 +-
>> hw/arm/pxa2xx=2Ec                     |   2 +-
>> hw/char/omap_uart=2Ec                 |   2 +-
>> hw/char/serial-mm=2Ec                 | 157 +++++++++++++++++++++++++++=
+
>> hw/char/serial=2Ec                    | 126 ----------------------
>> hw/display/sm501=2Ec                  |   2 +-
>> hw/hppa/machine=2Ec                   |   2 +-
>> hw/loongarch/virt=2Ec                 |   2 +-
>> hw/microblaze/petalogix_ml605_mmu=2Ec |   2 +-
>> hw/mips/boston=2Ec                    |   2 +-
>> hw/mips/jazz=2Ec                      |   2 +-
>> hw/mips/loongson3_virt=2Ec            |   2 +-
>> hw/mips/malta=2Ec                     |   2 +-
>> hw/mips/mipssim=2Ec                   |   2 +-
>> hw/openrisc/openrisc_sim=2Ec          |   2 +-
>> hw/openrisc/virt=2Ec                  |   2 +-
>> hw/ppc/e500=2Ec                       |   2 +-
>> hw/ppc/ppc405_uc=2Ec                  |   2 +-
>> hw/ppc/ppc440_bamboo=2Ec              |   2 +-
>> hw/ppc/sam460ex=2Ec                   |   2 +-
>> hw/ppc/virtex_ml507=2Ec               |   2 +-
>> hw/riscv/virt=2Ec                     |   2 +-
>> hw/sparc64/niagara=2Ec                |   2 +-
>> hw/sparc64/sun4u=2Ec                  |   2 +-
>> hw/xtensa/xtfpga=2Ec                  |   2 +-
>> hw/arm/Kconfig                      |  20 ++--
>> hw/char/Kconfig                     |   4 +
>> hw/char/meson=2Ebuild                 |   1 +
>> hw/display/Kconfig                  |   2 +-
>> hw/hppa/Kconfig                     |   2 +-
>> hw/loongarch/Kconfig                |   2 +-
>> hw/microblaze/Kconfig               |   2 +-
>> hw/mips/Kconfig                     |  10 +-
>> hw/openrisc/Kconfig                 |   4 +-
>> hw/ppc/Kconfig                      |  10 +-
>> hw/riscv/Kconfig                    |   2 +-
>> hw/sparc64/Kconfig                  |   1 +
>> hw/xtensa/Kconfig                   |   2 +-
>> 50 files changed, 276 insertions(+), 206 deletions(-)
>> create mode 100644 include/hw/char/serial-mm=2Eh
>> create mode 100644 hw/char/serial-mm=2Ec
>>=20
>> diff --git a/include/hw/arm/aspeed_soc=2Eh b/include/hw/arm/aspeed_soc=
=2Eh
>> index 624d489e0d=2E=2E689f52dae8 100644
>> --- a/include/hw/arm/aspeed_soc=2Eh
>> +++ b/include/hw/arm/aspeed_soc=2Eh
>> @@ -39,7 +39,7 @@
>> #include "hw/misc/unimp=2Eh"
>> #include "hw/misc/aspeed_peci=2Eh"
>> #include "hw/fsi/aspeed_apb2opb=2Eh"
>> -#include "hw/char/serial=2Eh"
>> +#include "hw/char/serial-mm=2Eh"
>> #include "hw/intc/arm_gicv3=2Eh"
>>=20
>> #define ASPEED_SPIS_NUM  2
>> diff --git a/include/hw/char/mchp_pfsoc_mmuart=2Eh b/include/hw/char/mc=
hp_pfsoc_mmuart=2Eh
>> index b0e14ca355=2E=2Ea7b8b1b08b 100644
>> --- a/include/hw/char/mchp_pfsoc_mmuart=2Eh
>> +++ b/include/hw/char/mchp_pfsoc_mmuart=2Eh
>> @@ -29,7 +29,7 @@
>> #define HW_MCHP_PFSOC_MMUART_H
>>=20
>> #include "hw/sysbus=2Eh"
>> -#include "hw/char/serial=2Eh"
>> +#include "hw/char/serial-mm=2Eh"
>>=20
>> #define MCHP_PFSOC_MMUART_REG_COUNT 13
>>=20
>> diff --git a/include/hw/char/serial-mm=2Eh b/include/hw/char/serial-mm=
=2Eh
>> new file mode 100644
>> index 0000000000=2E=2E62a8489d69
>> --- /dev/null
>> +++ b/include/hw/char/serial-mm=2Eh
>> @@ -0,0 +1,52 @@
>> +/*
>> + * QEMU 16550A UART emulation
>
>This is now only "memory mapped 16550A compatible UART emulation" or some=
thing like that, the actual 16550A emulation is in serial=2Ec where this wa=
s moved from=2E Maybe worth making it clear in this comment and in serial-m=
m=2Ec as well=2E

I'll send a v3 then=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan

