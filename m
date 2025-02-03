Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B258AC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 23:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf5RI-00037N-K8; Mon, 03 Feb 2025 18:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tf5RG-00036k-SK; Mon, 03 Feb 2025 18:01:11 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tf5RE-00088j-C9; Mon, 03 Feb 2025 18:01:10 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso37144135e9.0; 
 Mon, 03 Feb 2025 15:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738623666; x=1739228466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1X9lkwxCyiyn6VPTkPmA0Do69DyfvnR1bI4eu9PquFQ=;
 b=TZA5MCsKQYnHLu6eUgMGVNtaLTo3dLcYHfdyR4DAZ0ARXm1DfMqwt2/D56rSrf/1/Z
 XBR+UhF0j8crypXY0LkDsjr5QCmgcJUPgQ9BGThYPUGubPRpFNpUlogmsCr4koyMxx41
 tdzAkpaxxMyz/zit9qeDculioRmj9pse/O2Zv9vH+L3lxN4bPoFrfiTpclqgysPjNjaS
 21/g/JcAgRvC5zPu1IRJvM05YnG72ZNsK4mBuygQUMsGcz+aJIIz66PyI5gOYwJTBJqY
 RSgDiGE2EmBDPKOdScwP6GKMKWFmFSVGmeXOMDUnNkFxj6K3Ojp01LBsDCxD2WeH+Qjf
 DIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738623666; x=1739228466;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1X9lkwxCyiyn6VPTkPmA0Do69DyfvnR1bI4eu9PquFQ=;
 b=YYKbSnXNpsUpvICGAYLdXLz9F5FmKW6m4po2ndBYF8iAjuyYH3vtiH3ZF5/BV1DFFA
 vjmUDzxxFF/MHfU0S+HtLsK8dnbBTvMviOwXrA72g6+vbTVWeXdarcFv/kgd4tgWIofM
 MVT5fNjFnVd+eWSF+U7i5g4n+4xfJh8IKFNJ60odI6wJU1lrGat0HgL+xPnPraR7pmaB
 uN10Yw67T0BiOYB9wCT2DvU6VM8EE2QskoIxolSj+VaHYowLZiIelLD7R4mv+xJErmdH
 diWxhF4lrIM8tOmroeJpH9qefctkoyiG3eskcyHICJHc5DNDxV5/MSFfYvr5Qxv7EpPb
 zlQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9UAV+ONBCmDh9zAhFavcgHFD3cbY877IyK1g1WzWPYvmoktC+NmerqWdQQjq1GKTdQH8wr19Xxg==@nongnu.org
X-Gm-Message-State: AOJu0YwmxyC5V9diJY0OAyeSxoZpEoXq/3QJ4GdUaSdN474CIK6RY9wF
 y5k29eh3cWGBB93/6L6POzcDdkKYunVaWCPH6eftmzxf3L7OhyKN
X-Gm-Gg: ASbGncvh+bVch00axxbI89UYZamTyvZ6FyGT7gldqmvwJPvSKTZJlxTUinnKrWVr0es
 RusHhJw+NRfBnTov27Rm+qA/GmxfwMoYzOhbJAgXH/apC/ji83zYtt2H2+STmPtnPSgw1CC5Tu/
 OvFNlYfiGZXGAIOhFn2bMavU2W0fn9ZzLxvMfuE0BFrsx+ec958N+T2Zt3EsMMJo0R4F++RZe0q
 4fU9C0BTslbdYJaNQhLu0qNGIO4RPRIEoOoFN72v5yh07pavvoIpIIPr/HbXYXn7AgifGfrd+2M
 PRUCFRMsarvzlvD82xwcmfHgYEok4U/sJh1Pv11vDQlX0Hj5kQpxkw8VmQMNwj14A0nFA8mc2g=
 =
X-Google-Smtp-Source: AGHT+IGRLhk/4YLNHplkGqR6j2XAar72D+304cZxubyeafYwaAqrrsHetOTggP9knnjcfnCDuFwt6g==
X-Received: by 2002:a05:600c:1e09:b0:434:f1bd:1e40 with SMTP id
 5b1f17b1804b1-43905f71556mr6443065e9.6.1738623665874; 
 Mon, 03 Feb 2025 15:01:05 -0800 (PST)
Received: from ?IPv6:::1?
 (p200300faaf00430048cf2359cf0b0456.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:48cf:2359:cf0b:456])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d4f9esm176110465e9.2.2025.02.03.15.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 15:01:05 -0800 (PST)
Date: Mon, 03 Feb 2025 23:01:03 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 08/21] hw/arm/fsl-imx8mp: Add USDHC storage controllers
In-Reply-To: <3e6208b1-7d70-5205-a92f-549d7d2fff13@eik.bme.hu>
References: <20250120203748.4687-1-shentey@gmail.com>
 <20250120203748.4687-9-shentey@gmail.com>
 <3e6208b1-7d70-5205-a92f-549d7d2fff13@eik.bme.hu>
Message-ID: <FA8D7DA4-2CD8-4310-A210-A147EE385103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
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



Am 21=2E Januar 2025 02:52:58 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Mon, 20 Jan 2025, Bernhard Beschow wrote:
>> The USDHC emulation allows for running real-world images such as those =
generated
>> by Buildroot=2E Convert the board documentation accordingly instead of =
running a
>> Linux kernel with ephemeral storage=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>> docs/system/arm/imx8mp-evk=2Erst | 39 +++++++++++++++++++++++----------=
-
>> include/hw/arm/fsl-imx8mp=2Eh    |  7 ++++++
>> hw/arm/fsl-imx8mp=2Ec            | 28 ++++++++++++++++++++++++
>> hw/arm/imx8mp-evk=2Ec            | 18 ++++++++++++++++
>> hw/arm/Kconfig                 |  1 +
>> 5 files changed, 81 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/docs/system/arm/imx8mp-evk=2Erst b/docs/system/arm/imx8mp-=
evk=2Erst
>> index d7d08cc198=2E=2E1514bc5864 100644
>> --- a/docs/system/arm/imx8mp-evk=2Erst
>> +++ b/docs/system/arm/imx8mp-evk=2Erst
>> @@ -13,6 +13,7 @@ The ``imx8mp-evk`` machine implements the following d=
evices:
>>  * Up to 4 Cortex-A53 Cores
>>  * Generic Interrupt Controller (GICv3)
>>  * 4 UARTs
>> + * 3 USDHC Storage Controllers
>>  * Secure Non-Volatile Storage (SNVS) including an RTC
>>  * Clock Tree
>>=20
>> @@ -25,25 +26,39 @@ for loading a Linux kernel=2E
>> Direct Linux Kernel Boot
>> ''''''''''''''''''''''''
>>=20
>> -Linux mainline v6=2E12 release is tested at the time of writing=2E To =
build a Linux
>> -mainline kernel that can be booted by the ``imx8mp-evk`` machine, simp=
ly
>> -configure the kernel using the defconfig configuration:
>> +Probably the easiest way to get started with a whole Linux system on t=
he machine
>> +is to generate an image with Buildroot=2E Version 2024=2E11=2E1 is tes=
ted at the time
>> +of writing and involves three steps=2E First run the following command=
 in the
>> +toplevel directory of the Buildroot source tree:
>>=20
>> =2E=2E code-block:: bash
>>=20
>> -  $ export ARCH=3Darm64
>> -  $ export CROSS_COMPILE=3Daarch64-linux-gnu-
>> -  $ make defconfig
>> +  $ make freescale_imx8mpevk_defconfig
>>   $ make
>
>Adding documentation that is removed a few patches later seems unnecessar=
y=2E Maybe you could keep the bare kernel docs as that could also be useful=
 or not add it in the first place? But if this is already written keeping i=
t may make more sense than dropping it=2E

I'd like the documentation to be complete and easy to follow at the same t=
ime=2E Buildroot achieves both, and allows for generating a cpio initrd ins=
tead=2E So I'd start with that which just requires minor adjustments here=
=2E

Best regards,
Bernhard

>
>Regards,
>BALATON Zoltan
>
>>=20
>> -To boot the newly built Linux kernel in QEMU with the ``imx8mp-evk`` m=
achine,
>> -run:
>> +Once finished successfully there is an ``output/image`` subfolder=2E N=
avigate into
>> +it and resize the SD card image to a power of two:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ qemu-img resize sdcard=2Eimg 256M
>> +
>> +Finally, the device tree needs to be patched with the following comman=
ds which
>> +will remove the ``cpu-idle-states`` properties from CPU nodes:
>> +
>> +=2E=2E code-block:: bash
>> +
>> +  $ dtc imx8mp-evk=2Edtb | sed '/cpu-idle-states/d' > imx8mp-evk-patch=
ed=2Edts
>> +  $ dtc imx8mp-evk-patched=2Edts -o imx8mp-evk-patched=2Edtb
>> +
>> +Now that everything is prepared the newly built image can be run in th=
e QEMU
>> +``imx8mp-evk`` machine:
>>=20
>> =2E=2E code-block:: bash
>>=20
>>   $ qemu-system-aarch64 -M imx8mp-evk -smp 4 -m 3G \
>>       -display none -serial null -serial stdio \
>> -      -kernel arch/arm64/boot/Image \
>> -      -dtb arch/arm64/boot/dts/freescale/imx8mp-evk=2Edtb \
>> -      -initrd /path/to/rootfs=2Eext4 \
>> -      -append "root=3D/dev/ram"
>> +      -kernel Image \
>> +      -dtb imx8mp-evk-patched=2Edtb \
>> +      -append "root=3D/dev/mmcblk2p2" \
>> +      -drive file=3Dsdcard=2Eimg,if=3Dsd,bus=3D2,format=3Draw,id=3Dmmc=
blk2
>> diff --git a/include/hw/arm/fsl-imx8mp=2Eh b/include/hw/arm/fsl-imx8mp=
=2Eh
>> index 9d2a757c2a=2E=2E9832c05e8c 100644
>> --- a/include/hw/arm/fsl-imx8mp=2Eh
>> +++ b/include/hw/arm/fsl-imx8mp=2Eh
>> @@ -14,6 +14,7 @@
>> #include "hw/intc/arm_gicv3_common=2Eh"
>> #include "hw/misc/imx7_snvs=2Eh"
>> #include "hw/misc/imx8mp_ccm=2Eh"
>> +#include "hw/sd/sdhci=2Eh"
>> #include "qom/object=2Eh"
>> #include "qemu/units=2Eh"
>>=20
>> @@ -27,6 +28,7 @@ enum FslImx8mpConfiguration {
>>     FSL_IMX8MP_NUM_CPUS         =3D 4,
>>     FSL_IMX8MP_NUM_IRQS         =3D 160,
>>     FSL_IMX8MP_NUM_UARTS        =3D 4,
>> +    FSL_IMX8MP_NUM_USDHCS       =3D 3,
>> };
>>=20
>> struct FslImx8mpState {
>> @@ -38,6 +40,7 @@ struct FslImx8mpState {
>>     IMX8MPAnalogState  analog;
>>     IMX7SNVSState      snvs;
>>     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
>> +    SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
>> };
>>=20
>> enum FslImx8mpMemoryRegions {
>> @@ -183,6 +186,10 @@ enum FslImx8mpMemoryRegions {
>> };
>>=20
>> enum FslImx8mpIrqs {
>> +    FSL_IMX8MP_USDHC1_IRQ   =3D 22,
>> +    FSL_IMX8MP_USDHC2_IRQ   =3D 23,
>> +    FSL_IMX8MP_USDHC3_IRQ   =3D 24,
>> +
>>     FSL_IMX8MP_UART1_IRQ    =3D 26,
>>     FSL_IMX8MP_UART2_IRQ    =3D 27,
>>     FSL_IMX8MP_UART3_IRQ    =3D 28,
>> diff --git a/hw/arm/fsl-imx8mp=2Ec b/hw/arm/fsl-imx8mp=2Ec
>> index 0abde2b1fc=2E=2E612ea7bf93 100644
>> --- a/hw/arm/fsl-imx8mp=2Ec
>> +++ b/hw/arm/fsl-imx8mp=2Ec
>> @@ -210,6 +210,11 @@ static void fsl_imx8mp_init(Object *obj)
>>         snprintf(name, NAME_SIZE, "uart%d", i + 1);
>>         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL=
);
>>     }
>> +
>> +    for (i =3D 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
>> +        snprintf(name, NAME_SIZE, "usdhc%d", i + 1);
>> +        object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDH=
C);
>> +    }
>> }
>>=20
>> static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>> @@ -350,6 +355,28 @@ static void fsl_imx8mp_realize(DeviceState *dev, E=
rror **errp)
>>                            qdev_get_gpio_in(gicdev, serial_table[i]=2Ei=
rq));
>>     }
>>=20
>> +    /* USDHCs */
>> +    for (i =3D 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
>> +        static const struct {
>> +            hwaddr addr;
>> +            unsigned int irq;
>> +        } usdhc_table[FSL_IMX8MP_NUM_USDHCS] =3D {
>> +            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC1]=2Eaddr, FSL_IMX8MP_=
USDHC1_IRQ },
>> +            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC2]=2Eaddr, FSL_IMX8MP_=
USDHC2_IRQ },
>> +            { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3]=2Eaddr, FSL_IMX8MP_=
USDHC3_IRQ },
>> +        };
>> +
>> +        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
>> +                                 SDHCI_VENDOR_IMX, &error_abort);
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
>> +            return;
>> +        }
>> +
>> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0, usdhc_table[i=
]=2Eaddr);
>> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
>> +                           qdev_get_gpio_in(gicdev, usdhc_table[i]=2Ei=
rq));
>> +    }
>> +
>>     /* SNVS */
>>     if (!sysbus_realize(SYS_BUS_DEVICE(&s->snvs), errp)) {
>>         return;
>> @@ -367,6 +394,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Er=
ror **errp)
>>         case FSL_IMX8MP_RAM:
>>         case FSL_IMX8MP_SNVS_HP:
>>         case FSL_IMX8MP_UART1 =2E=2E=2E FSL_IMX8MP_UART4:
>> +        case FSL_IMX8MP_USDHC1 =2E=2E=2E FSL_IMX8MP_USDHC3:
>>             /* device implemented and treated above */
>>             break;
>>=20
>> diff --git a/hw/arm/imx8mp-evk=2Ec b/hw/arm/imx8mp-evk=2Ec
>> index 2756d4c21c=2E=2E27d9e9e8ee 100644
>> --- a/hw/arm/imx8mp-evk=2Ec
>> +++ b/hw/arm/imx8mp-evk=2Ec
>> @@ -11,6 +11,7 @@
>> #include "hw/arm/boot=2Eh"
>> #include "hw/arm/fsl-imx8mp=2Eh"
>> #include "hw/boards=2Eh"
>> +#include "hw/qdev-properties=2Eh"
>> #include "system/qtest=2Eh"
>> #include "qemu/error-report=2Eh"
>> #include "qapi/error=2Eh"
>> @@ -40,6 +41,23 @@ static void imx8mp_evk_init(MachineState *machine)
>>     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_STA=
RT,
>>                                 machine->ram);
>>=20
>> +    for (int i =3D 0; i < FSL_IMX8MP_NUM_USDHCS; i++) {
>> +        BusState *bus;
>> +        DeviceState *carddev;
>> +        BlockBackend *blk;
>> +        DriveInfo *di =3D drive_get(IF_SD, i, 0);
>> +
>> +        if (!di) {
>> +            continue;
>> +        }
>> +
>> +        blk =3D blk_by_legacy_dinfo(di);
>> +        bus =3D qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
>> +        carddev =3D qdev_new(TYPE_SD_CARD);
>> +        qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
>> +        qdev_realize_and_unref(carddev, bus, &error_fatal);
>> +    }
>> +
>>     if (!qtest_enabled()) {
>>         arm_load_kernel(&s->cpu[0], machine, &boot_info);
>>     }
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index adb4ed8076=2E=2Ef880c03d35 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -582,6 +582,7 @@ config FSL_IMX8MP
>>     imply TEST_DEVICES
>>     select ARM_GIC
>>     select IMX
>> +    select SDHCI
>>     select UNIMP
>>=20
>> config FSL_IMX8MP_EVK
>>=20

