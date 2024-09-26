Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E3CCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 09:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stkbL-0004bB-1A; Thu, 26 Sep 2024 05:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stkbI-0004ZB-FR; Thu, 26 Sep 2024 05:15:52 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1stkbG-0000CX-5z; Thu, 26 Sep 2024 05:15:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so6976085e9.1; 
 Thu, 26 Sep 2024 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727342145; x=1727946945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ubWgk39mHd7Ygqo8rHLIoZLeC76fSwHyQx9i07N4GhU=;
 b=KskY2KpaPm6fxKCjLZLfWoJb/omOflwQyVSuuxB5APUria4bfuHsC6cUiQzRu9kdV1
 strPi8KgF+dUmrpHG6YdF9GDHAVa1A5VbYIg07wC4XD/Nv6QEof0/EaG+/BvQ7Vwsba5
 AJ6DFdC2ZkmWxQuqx/X/Wtxj0FDEVW9fMlO9YAA7VcMtbaecHDr6YWAgHwn1dGeBZSQ7
 2gN7bFbjRhi1+bWUjmtlsDkdEVfredChNwHyDiuSG25HLxMR/9r0V2tp6A7AcXJ4mUeL
 tlKBzrOwvLxjrq4tHL6UwvM1/z7g5Y/i4szPB4G8BGUQvdwzotJDS88U63Mg7uQY6vBc
 OpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727342145; x=1727946945;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubWgk39mHd7Ygqo8rHLIoZLeC76fSwHyQx9i07N4GhU=;
 b=F/7eyHLJggo+unyT6BR/ldjCAcdR2opGSLaTexwZzYJFbb4pvWL77KqlpSL7eBA51l
 ZOr6zqKwWvL5wnfhrstGIKrRSzIrsBd0YwYJxISGpaS3y/lEeq8F2i3tVjbkpe5zkzE/
 FrHkk918tcH8Uifi6UNgUC0daIBdYUFhRQIQqld5bEAjD3OyfpIqCiUkMCr3dmZBX3FJ
 QR2/nrYIMSTIrPhcrkkqgwnRY+rfO4aKUANTsDMj3BTxddngxb1tnUfKzzeSBB/3P1GQ
 G/X4cd/BzzZ2jC+EbE3iQkNqQx9uYM8aSqNIsNaHQVWP+VwvqQQUPK5R3I72DuVIgKYy
 qCgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8UF9gKrlpsETALHi9WBvEWujIj4rZyO0XMn295uE0sXzMJC8AixkcbUo4SkpRmAidyi/lgWrKUC5Z@nongnu.org,
 AJvYcCU9wbW+4kqGkLY5+h2d9iUyEL+yD745NuOtGKGzVK0+hqwnpGqV56BYst/hVQgsZMZU/wwIQkQ+34MU0w==@nongnu.org,
 AJvYcCVtF9hTLPRXn4AvuvNa+IIjSMNN/xRxqQvqhnHQ/LSQJE/dhiTk3NX/T5lJ6BYqitTbLsbpC8gOuYA=@nongnu.org
X-Gm-Message-State: AOJu0YwVi8U0pQNtpoWev1TjDGiZP5o5iaQMFGYpfOgCQl+kie4IRqx5
 3OMPX/BvjH1WOrJ+TtKBisOkf8tkLU4GUNyJojm1/0EFMwsu2I7q
X-Google-Smtp-Source: AGHT+IG6QUASBMBnsF3gkGEUx5kNSjOc2beY6k+BYDTsm6RqvjWt24Y+K6V+U4ft63x5KzUJh015aA==
X-Received: by 2002:a05:600c:1547:b0:42c:b377:3f5f with SMTP id
 5b1f17b1804b1-42e9610e16fmr45383475e9.14.1727342144400; 
 Thu, 26 Sep 2024 02:15:44 -0700 (PDT)
Received: from [127.0.0.1] ([185.238.219.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a0a179sm41497455e9.29.2024.09.26.02.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2024 02:15:43 -0700 (PDT)
Date: Thu, 26 Sep 2024 09:15:42 +0000
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
In-Reply-To: <2a7c68aa-e493-44e9-8e9b-7c91088ad0f2@redhat.com>
References: <20240923093016.66437-1-shentey@gmail.com>
 <cbc6d0f4-ab9d-46c5-862f-aac83c91af3a@redhat.com>
 <E8877813-B07A-41A7-AF76-2564ECC02336@gmail.com>
 <2a7c68aa-e493-44e9-8e9b-7c91088ad0f2@redhat.com>
Message-ID: <9414FA57-9727-42E4-A967-372E676D50F5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 24=2E September 2024 08:33:26 UTC schrieb "C=C3=A9dric Le Goater" <clg@=
redhat=2Ecom>:
>On 9/23/24 23:25, Bernhard Beschow wrote:
>>=20
>>=20
>>=20
>> Am 23=2E September 2024 20:23:54 UTC schrieb "C=C3=A9dric Le Goater" <c=
lg@redhat=2Ecom>:
>>> Hello Bernhard,
>>=20
>> Hi C=C3=A9dric,
>>=20
>>>=20
>>> On 9/23/24 11:29, Bernhard Beschow wrote:
>>>> This series is part of a bigger series exploring data-driven machine =
creation
>>>> using device tree blobs on top of the e500 machines [1]=2E It contain=
s patches to
>>>> make this exploration easier which are also expected to provide value=
 in
>>>> themselves=2E
>>>>=20
>>>> The cleanup starts with the e500 machine class itself, then proceeds =
with
>>>> machine-specific device models and concludes with more or less loosel=
y related
>>>> devices=2E Device cleanup mostly consists of using the DEFINE_TYPES()=
 macro=2E
>>>=20
>>> Since you recently took a look at the machine models, would you
>>> be willing to take over maintenance of the e500 ? It shouldn't
>>> be an enormous amount of work=2E
>>=20
>> Are you referring to the machine and related devices or the CPU? I'm so=
mewhat familiar with the P102x and could take over but the CPU would be a d=
ifferent beast=2E
>
>Please take a look at the MAINTAINERS file=2E You will see it is not
>that large and the CPU target models are not part of it=2E

Patch sent: https://lore=2Ekernel=2Eorg/qemu-devel/20240926075948=2E2343-1=
-shentey@gmail=2Ecom/

Best regards,
Bernhard

>
>
>Thanks,
>
>C=2E
>
>=20
>
>>=20
>> Best regards,
>> Bernhard
>>=20
>>>=20
>>> Thanks,
>>>=20
>>> C=2E
>>>=20
>>>=20
>>>=20
>>>> [1] https://github=2Ecom/shentok/qemu/tree/e500-fdt
>>>>=20
>>>> Bernhard Beschow (23):
>>>>     hw/ppc/e500: Do not leak struct boot_info
>>>>     hw/ppc/e500: Reduce scope of env pointer
>>>>     hw/ppc/e500: Prefer QOM cast
>>>>     hw/ppc/e500: Remove unused "irqs" parameter
>>>>     hw/ppc/e500: Add missing device tree properties to i2c controller=
 node
>>>>     hw/ppc/e500: Use SysBusDevice API to access TYPE_CCSR's internal
>>>>       resources
>>>>     hw/ppc/e500: Extract ppce500_ccsr=2Ec
>>>>     hw/ppc/ppce500_ccsr: Log access to unimplemented registers
>>>>     hw/ppc/mpc8544_guts: Populate POR PLL ratio status register
>>>>     hw/i2c/mpc_i2c: Convert DPRINTF to trace events for register acce=
ss
>>>>     hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
>>>>     hw/pci-host/ppce500: Reuse TYPE_PPC_E500_PCI_BRIDGE define
>>>>     hw/pci-host/ppce500: Prefer DEFINE_TYPES() macro
>>>>     hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
>>>>     hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
>>>>     hw/net/fsl_etsec/etsec: Prefer DEFINE_TYPES() macro
>>>>     hw/intc: Guard openpic_kvm=2Ec by dedicated OPENPIC_KVM Kconfig s=
witch
>>>>     hw/sd/sdhci: Prefer DEFINE_TYPES() macro
>>>>     hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
>>>>     hw/i2c/smbus_eeprom: Prefer DEFINE_TYPES() macro
>>>>     hw/rtc/ds1338: Prefer DEFINE_TYPES() macro
>>>>     hw/usb/hcd-ehci-sysbus: Prefer DEFINE_TYPES() macro
>>>>     hw/vfio/platform: Let vfio_start_eventfd_injection() take
>>>>       VFIOPlatformDevice pointer
>>>>=20
>>>>    MAINTAINERS              |   2 +-
>>>>    hw/ppc/e500-ccsr=2Eh       |   2 +
>>>>    hw/ppc/e500=2Eh            |   8 +++
>>>>    hw/block/pflash_cfi01=2Ec  |  21 +++----
>>>>    hw/gpio/mpc8xxx=2Ec        |  22 +++-----
>>>>    hw/i2c/mpc_i2c=2Ec         |  29 +++++-----
>>>>    hw/i2c/smbus_eeprom=2Ec    |  19 +++----
>>>>    hw/net/fsl_etsec/etsec=2Ec |  22 +++-----
>>>>    hw/pci-host/ppce500=2Ec    |  54 ++++++++----------
>>>>    hw/ppc/e500=2Ec            |  61 +++++---------------
>>>>    hw/ppc/mpc8544_guts=2Ec    |  32 +++++++----
>>>>    hw/ppc/ppce500_ccsr=2Ec    |  67 ++++++++++++++++++++++
>>>>    hw/rtc/ds1338=2Ec          |  20 +++----
>>>>    hw/sd/sdhci=2Ec            |  62 +++++++++-----------
>>>>    hw/usb/hcd-ehci-sysbus=2Ec | 118 +++++++++++++++++----------------=
------
>>>>    hw/vfio/platform=2Ec       |   7 +--
>>>>    hw/i2c/trace-events      |   5 ++
>>>>    hw/intc/Kconfig          |   4 ++
>>>>    hw/intc/meson=2Ebuild      |   3 +-
>>>>    hw/ppc/meson=2Ebuild       |   1 +
>>>>    hw/ppc/trace-events      |   3 +
>>>>    21 files changed, 285 insertions(+), 277 deletions(-)
>>>>    create mode 100644 hw/ppc/ppce500_ccsr=2Ec
>>>>=20
>>>=20
>>=20
>

