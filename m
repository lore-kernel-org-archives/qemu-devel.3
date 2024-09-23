Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DE9CF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 21:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssqYn-0006cN-1g; Mon, 23 Sep 2024 17:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssqYl-0006b8-Oi; Mon, 23 Sep 2024 17:25:31 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssqYj-0005Ze-VL; Mon, 23 Sep 2024 17:25:31 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so387310066b.1; 
 Mon, 23 Sep 2024 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727126727; x=1727731527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAfxUSfDM2d3QK1x6QNLXUp3OKwP/GbnmAKIpno+l0A=;
 b=fuskwWHrIgtu21VgX9/joWys9KUVamxaE16pGtYnT7tA272UwoGd4qn0afZ58t7OmY
 J+ZlVJpqyrh9ozJ2tgSxmS/GXlNULatdSGOluLgPaOPotJYgct+ToKt/r+9wdP47qaj5
 kcJpQY6y7lpg8XmfpmKg+z0/l3Q/uGH/DLwvbS2yyERTtLPIL5qUJwlwsiJR3pW3V8kC
 J1ngbn0pK3PApH9WbCVAZoRuIfaVwUJbv/NbmOSb96Sse5GmOlTTXsQnKbPRJxP4dQkA
 eA+uPM0IsqmTD5w59GoC4zsaimstdaDNqYPm8tZOfHB94+zmZU5Ciz/9H8k6qAiYTDSk
 c11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727126727; x=1727731527;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAfxUSfDM2d3QK1x6QNLXUp3OKwP/GbnmAKIpno+l0A=;
 b=ln8FbvZpapj+e33Fak+WnDmj3mXjsCC7Wnbtau88eD9ogsCjkhrzVANaHc/45e3nJc
 ovk73YLvGXXVYMLKgJ2BI7pm1e+KppkkKxfHG7l48ps0WU/2i3u8aUSBltRx2kNzUuJK
 g6Oe2HU6Rv7ltOUV3dnM2GdOtJU9TtADaEvk0kHkN/j8EN7VGuXzOnZ/k0SOag1OxKAp
 28WTij/Rkz4tB110Y/fgDc0SaS4gSVFUfjjwIByr+KxcWh5krkEH9Gvkb6dM8uXqrujd
 MopVn4EnSWlicmMXszsm1H+X7M2cIVGIAHlJYpcYec7GlpoioXHsGkOnfIK3NWJM0eIC
 RjjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6u7jQ/Scch81dwmH3r2KC6eSSfnaMnLfIg9Y5GlLR3/OJhrVHX77q3prmM5mlrU2nV+ZjuQNwQwjG@nongnu.org,
 AJvYcCVVSSBgkIU1Fula4j2YKLiLQydZcT94Hc53rjRy8z2oSCudi5b+qPpNwKiyCHhQB6A3H5+5yHTOwVT00A==@nongnu.org,
 AJvYcCWD9JGg9aJO5tSmBa3NlOtTlElSJlkIuLHzBQhK7cCmT++1JMRn0O7kJFy+V0SyyGAFgKOKLT+Vwwc=@nongnu.org
X-Gm-Message-State: AOJu0YzjYV6W6eV6ZFV0H+tpi/+z975jdYDwMse12wRrAukatQR6SGk5
 NKOvIgmivdPTqTpnNNBer+M53XbyjL2OymjkmHOHC93F2LPa2sS/
X-Google-Smtp-Source: AGHT+IEBUQKH0yszf+/ldxqc01wCJ+AHETS1w1yjhEEqOlj3HXC1UzE9JG+hICEJsIaXkrmWX5K50w==
X-Received: by 2002:a17:907:6e8b:b0:a8d:e4b:d7fe with SMTP id
 a640c23a62f3a-a90d521521dmr1522007266b.0.1727126727270; 
 Mon, 23 Sep 2024 14:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([81.19.4.232]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9392f51e25sm2838266b.77.2024.09.23.14.25.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Sep 2024 14:25:26 -0700 (PDT)
Date: Mon, 23 Sep 2024 21:25:23 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
CC: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 00/23] E500 Cleanup
In-Reply-To: <cbc6d0f4-ab9d-46c5-862f-aac83c91af3a@redhat.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <cbc6d0f4-ab9d-46c5-862f-aac83c91af3a@redhat.com>
Message-ID: <E8877813-B07A-41A7-AF76-2564ECC02336@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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




Am 23=2E September 2024 20:23:54 UTC schrieb "C=C3=A9dric Le Goater" <clg@=
redhat=2Ecom>:
>Hello Bernhard,

Hi C=C3=A9dric,

>
>On 9/23/24 11:29, Bernhard Beschow wrote:
>> This series is part of a bigger series exploring data-driven machine cr=
eation
>> using device tree blobs on top of the e500 machines [1]=2E It contains =
patches to
>> make this exploration easier which are also expected to provide value i=
n
>> themselves=2E
>>=20
>> The cleanup starts with the e500 machine class itself, then proceeds wi=
th
>> machine-specific device models and concludes with more or less loosely =
related
>> devices=2E Device cleanup mostly consists of using the DEFINE_TYPES() m=
acro=2E
>
>Since you recently took a look at the machine models, would you
>be willing to take over maintenance of the e500 ? It shouldn't
>be an enormous amount of work=2E

Are you referring to the machine and related devices or the CPU? I'm somew=
hat familiar with the P102x and could take over but the CPU would be a diff=
erent beast=2E

Best regards,
Bernhard

>
>Thanks,
>
>C=2E
>
>
>
>> [1] https://github=2Ecom/shentok/qemu/tree/e500-fdt
>>=20
>> Bernhard Beschow (23):
>>    hw/ppc/e500: Do not leak struct boot_info
>>    hw/ppc/e500: Reduce scope of env pointer
>>    hw/ppc/e500: Prefer QOM cast
>>    hw/ppc/e500: Remove unused "irqs" parameter
>>    hw/ppc/e500: Add missing device tree properties to i2c controller no=
de
>>    hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>>      resources
>>    hw/ppc/e500: Extract ppce500_ccsr=2Ec
>>    hw/ppc/ppce500_ccsr: Log access to unimplemented registers
>>    hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
>>    hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register access
>>    hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
>>    hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
>>    hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
>>    hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
>>    hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
>>    hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
>>    hw/intc: Guard openpic_kvm=2Ec by dedicated OPENPIC_KVM Kconfig swit=
ch
>>    hw/sd/sdhci: Prefer DEFINE_TYPES() macro
>>    hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
>>    hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
>>    hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
>>    hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
>>    hw/vfio/platform: Let vfio_start_eventfd_injection() take
>>      VFIOPlatformDevice pointer
>>=20
>>   MAINTAINERS              |   2 +-
>>   hw/ppc/e500-ccsr=2Eh       |   2 +
>>   hw/ppc/e500=2Eh            |   8 +++
>>   hw/block/pflash_cfi01=2Ec  |  21 +++----
>>   hw/gpio/mpc8xxx=2Ec        |  22 +++-----
>>   hw/i2c/mpc_i2c=2Ec         |  29 +++++-----
>>   hw/i2c/smbus_eeprom=2Ec    |  19 +++----
>>   hw/net/fsl_etsec/etsec=2Ec |  22 +++-----
>>   hw/pci-host/ppce500=2Ec    |  54 ++++++++----------
>>   hw/ppc/e500=2Ec            |  61 +++++---------------
>>   hw/ppc/mpc8544_guts=2Ec    |  32 +++++++----
>>   hw/ppc/ppce500_ccsr=2Ec    |  67 ++++++++++++++++++++++
>>   hw/rtc/ds1338=2Ec          |  20 +++----
>>   hw/sd/sdhci=2Ec            |  62 +++++++++-----------
>>   hw/usb/hcd-ehci-sysbus=2Ec | 118 +++++++++++++++++-------------------=
---
>>   hw/vfio/platform=2Ec       |   7 +--
>>   hw/i2c/trace-events      |   5 ++
>>   hw/intc/Kconfig          |   4 ++
>>   hw/intc/meson=2Ebuild      |   3 +-
>>   hw/ppc/meson=2Ebuild       |   1 +
>>   hw/ppc/trace-events      |   3 +
>>   21 files changed, 285 insertions(+), 277 deletions(-)
>>   create mode 100644 hw/ppc/ppce500_ccsr=2Ec
>>=20
>

