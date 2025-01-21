Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF7CC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 21:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taLPE-0006BF-08; Tue, 21 Jan 2025 16:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1taLPB-00067u-1c; Tue, 21 Jan 2025 16:03:25 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1taLP8-0008O4-Na; Tue, 21 Jan 2025 16:03:24 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so1124427366b.3; 
 Tue, 21 Jan 2025 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737493400; x=1738098200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7LQMBxJ1iBdb7PgB2zJunhftYpi3JMsr8ixp4Yc1ZI=;
 b=ZoTbzwGjpy6EmeuZoMx1rq9rSCmfqK6wHFzMXj226AXCWIU4CCHOdm4xrXM9jz33Dv
 7v+SW+ZXP/dZxkK04wP2UKgpucZltHwTYi1rmHA7+K69UL1OIZRdfBVeiWJVb+LgviPT
 iKlXYTUtVx5AExkPdH9aLIsgdCMt0wYdq8mRVEq18X3DRR+OTgSMRwx3ml29ecQ39uVF
 gtnflG8lEKvvXxsxZFsh/KyCPcKesnV4v6QWYnG9/xbKI8C/t8pdmK+8VL2/ZT45QBrZ
 JnxZacRlPI7xGy7mJtdN/gli7tR1f0h+5qBSPtdEDUm3XI+h5jFwboGAenGuaY1Mq1Vn
 7xOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737493400; x=1738098200;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7LQMBxJ1iBdb7PgB2zJunhftYpi3JMsr8ixp4Yc1ZI=;
 b=ZrXeHJ4ZomiIbKH+7a4pdzvmXW7SkFlQ541ge6eGR7vGoMzTn7ilHy9+DBAnZKEiF4
 Aeap9uAVMjt3B8HFbTIfS7aZJJWY/aW0haREFrwFdYpMHLWyJwZu52SPBgb701OUpjia
 d+12mBooC0l/YNei9Rdn6zwNHgir0C6KwdjG9xBlnra/ICrsZLLwLVFcLSBF3ByBNzlz
 2CSl0QxTeohDHrstsqsiO0ACn4n+EkCfQed3UEUNs52zq7DM3rogSr6kVnaPX92WCfKJ
 GDO8Hn6nnpla77tzWuH/NJWKKKgBQI+kDv4yLD00b/T/EtobX4ehGyhuiO/9u0eD9QYy
 tJrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9dNBXiT9siSNBQZm4M+zxabkBk1V1gqKD/CklLw65fZXBCZ8bUPqUttakJM+bzzzTuSdUdil7Nw==@nongnu.org
X-Gm-Message-State: AOJu0Yy7rZh42FOz5CNHRkHoZ+otkXJIWi0Y0boRP9lH9s7NCs2M8Qoh
 v6uy4E4BYHPvVHKdMuVS9VB7WHLPKRQwQIMhFdFVMq/DE8Y4GJOY
X-Gm-Gg: ASbGncslL+R6J+wYEY3pGMb+2NbBqbpcD9QFYmlxL+jQqVhHU1qJBLoXxNA/5q+/NxC
 A97s8JbBLf6hgr5MVUOk8WCLMqxcbXGx5zoscGjyZfttDVXBYp7rOK5y6KkIbCyZhIuAdp/U4dB
 V2yOvhwEUc1c50e7nJJIdsQWiC5F8OQCy2o9Yb8LHJNbZdWCXnqHMxYWfxLnH+axjTOlE4pDzQe
 7JtfeK35gawSu3wkZgXpxAGFJiOdWc5J3svJPUpIke/+oEWfVy/Gpndu/dVBTyJ3IIk1oSBsKxF
 cn7PO9zHEFnJ2X7zF2WcvEVEWJm+A7c9lySD2Ulc2Q==
X-Google-Smtp-Source: AGHT+IFKcqBWPaOjE7YIGfPpkTc9s0uF572+APav0lgeK7HVfitZtFppk2TxwG/mDbvxXpTXRIQX4Q==
X-Received: by 2002:a17:907:7eaa:b0:aac:439:10ce with SMTP id
 a640c23a62f3a-ab38b2cef0bmr1924745766b.27.1737493399921; 
 Tue, 21 Jan 2025 13:03:19 -0800 (PST)
Received: from [127.0.0.1] (dynamic-078-055-084-069.78.55.pool.telefonica.de.
 [78.55.84.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f2911fsm795340666b.120.2025.01.21.13.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 13:03:19 -0800 (PST)
Date: Tue, 21 Jan 2025 21:03:19 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 17/21] hw/arm/fsl-imx8mp: Add boot ROM
In-Reply-To: <e3004582-40cc-e35c-91fe-88947cbb4978@eik.bme.hu>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-18-shentey@gmail.com>
 <e3004582-40cc-e35c-91fe-88947cbb4978@eik.bme.hu>
Message-ID: <A48CB744-0C99-4979-B941-BC80E013FCE8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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



Am 21=2E Januar 2025 03:00:17 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Mon, 20 Jan 2025, Bernhard Beschow wrote:
>> On a real device, the boot ROM contains the very first instructions the=
 CPU
>> executes=2E Also, U-Boot calls into the ROM to determine the boot devic=
e=2E While
>> we're not actually implementing this here, let's create the infrastruct=
ure and
>> add a dummy ROM with all zeros=2E This allows for implementing a ROM la=
ter without
>> touching the source code and even allows for users to provide their own=
 ROMs=2E
>>=20
>> The imx8mp-boot=2Erom was created with
>> `dd if=3D/dev/zero of=3Dimx8mp-boot=2Erom bs=3D1 count=3D258048`=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> MAINTAINERS                 |   1 +
>> include/hw/arm/fsl-imx8mp=2Eh |   1 +
>> hw/arm/fsl-imx8mp=2Ec         |  18 ++++++++++++++++++
>> pc-bios/imx8mp-boot=2Erom     | Bin 0 -> 258048 bytes
>> pc-bios/meson=2Ebuild         |   1 +
>> 5 files changed, 21 insertions(+)
>> create mode 100644 pc-bios/imx8mp-boot=2Erom
>>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 76b416831d=2E=2Ed2cdc790ff 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -830,6 +830,7 @@ F: hw/pci-host/fsl_imx8m_phy=2Ec
>> F: include/hw/arm/fsl-imx8mp=2Eh
>> F: include/hw/misc/imx8mp_*=2Eh
>> F: include/hw/pci-host/fsl_imx8m_phy=2Eh
>> +F: pc-bios/imx8mp*
>> F: docs/system/arm/imx8mp-evk=2Erst
>>=20
>> MPS2 / MPS3
>> diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=
=2Eh
>> index 1b8a5cbbba=2E=2E326c4ddf69 100644
>> --- a/include/hw/arm/fsl-imx8mp=2Eh
>> +++ b/include/hw/arm/fsl-imx8mp=2Eh
>> @@ -67,6 +67,7 @@ struct FslImx8mpState {
>>     DesignwarePCIEHost pcie;
>>     FslImx8mPciePhyState   pcie_phy;
>>     OrIRQState         gpt5_gpt6_irq;
>> +    MemoryRegion       boot_rom;
>>=20
>>     uint32_t           phy_num;
>>     bool               phy_connected;
>> diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>> index 5b9781a424=2E=2E9688e2e962 100644
>> --- a/hw/arm/fsl-imx8mp=2Ec
>> +++ b/hw/arm/fsl-imx8mp=2Ec
>> @@ -9,12 +9,14 @@
>>  */
>>=20
>> #include "qemu/osdep=2Eh"
>> +#include "qemu/datadir=2Eh"
>> #include "exec/address-spaces=2Eh"
>> #include "hw/arm/bsa=2Eh"
>> #include "hw/arm/fsl-imx8mp=2Eh"
>> #include "hw/intc/arm_gicv3=2Eh"
>> #include "hw/misc/unimp=2Eh"
>> #include "hw/boards=2Eh"
>> +#include "hw/loader=2Eh"
>> #include "system/system=2Eh"
>> #include "target/arm/cpu-qom=2Eh"
>> #include "qapi/qmp/qlist=2Eh"
>> @@ -266,6 +268,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
ror **errp)
>>     MachineState *ms =3D MACHINE(qdev_get_machine());
>>     FslImx8mpState *s =3D FSL_IMX8MP(dev);
>>     DeviceState *gicdev =3D DEVICE(&s->gic);
>> +    g_autofree char *filename =3D NULL;
>>     int i;
>>=20
>>     if (ms->smp=2Ecpus > FSL_IMX8MP_NUM_CPUS) {
>> @@ -648,10 +651,25 @@ static void fsl_imx8mp_realize(DeviceState *dev, =
Error **errp)
>>     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
>>                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1]=2Eaddr);
>>=20
>> +    /* ROM memory */
>> +    if (!memory_region_init_ram(&s->boot_rom, OBJECT(dev),
>> +                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM]=
=2Ename,
>> +                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM]=
=2Esize,
>> +                                errp)) {
>> +        return;
>> +    }
>
>If it's ROM why not memory_region_init_rom?

Indeed, this should be memory_region_init_rom()=2E Will be fixed in next i=
teration=2E

Thanks,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>> +    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, "imx8mp-boot=2Ero=
m");
>> +    load_image_size(filename, memory_region_get_ram_ptr(&s->boot_rom),
>> +                    memory_region_size(&s->boot_rom));
>> +    memory_region_add_subregion(get_system_memory(),
>> +                                fsl_imx8mp_memmap[FSL_IMX8MP_BOOT_ROM]=
=2Eaddr,
>> +                                &s->boot_rom);
>> +
>>     /* Unimplemented devices */
>>     for (i =3D 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
>>         switch (i) {
>>         case FSL_IMX8MP_ANA_PLL:
>> +        case FSL_IMX8MP_BOOT_ROM:
>>         case FSL_IMX8MP_CCM:
>>         case FSL_IMX8MP_GIC_DIST:
>>         case FSL_IMX8MP_GIC_REDIST:
>> diff --git a/pc-bios/imx8mp-boot=2Erom b/pc-bios/imx8mp-boot=2Erom
>> new file mode 100644
>> index 0000000000000000000000000000000000000000=2E=2E5324b5eed200e723d04=
8f8476e4d96d45622fd4d
>> GIT binary patch
>> literal 258048
>> zcmeIuF#!Mo0K%a4Pi+Q&h(KY$fB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
>> z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
>> z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
>> z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwA
>> zz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEj
>> zFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r
>> z3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@
>> z0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VK
>> zfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5
>> zV8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
>> z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
>> z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
>> z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwA
>> zz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEj
>> zFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r
>> z3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@
>> z0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VK
>> zfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5
>> zV8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM
>> z7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*
>> z1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd
>> z0RsjM7%*VKfB^#r3>YwAz<>b*1`HT5V8DO@0|pEjFkrxd0RsjM7%*VKfB^#r3>f$Z
>> E2JkHa0RR91
>>=20
>> literal 0
>> HcmV?d00001
>>=20
>> diff --git a/pc-bios/meson=2Ebuild b/pc-bios/meson=2Ebuild
>> index b68b29cc7d=2E=2E64d3286fdd 100644
>> --- a/pc-bios/meson=2Ebuild
>> +++ b/pc-bios/meson=2Ebuild
>> @@ -60,6 +60,7 @@ blobs =3D [
>>   'efi-virtio=2Erom',
>>   'efi-e1000e=2Erom',
>>   'efi-vmxnet3=2Erom',
>> +  'imx8mp-boot=2Erom',
>>   'qemu-nsis=2Ebmp',
>>   'multiboot=2Ebin',
>>   'multiboot_dma=2Ebin',
>>=20

