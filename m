Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C64C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnSQV-0003zs-7x; Wed, 26 Feb 2025 20:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSQS-0003zO-K5; Wed, 26 Feb 2025 20:10:56 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSQP-0006Zz-4j; Wed, 26 Feb 2025 20:10:56 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2234e5347e2so5250945ad.1; 
 Wed, 26 Feb 2025 17:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740618650; x=1741223450; darn=nongnu.org;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CuSRKJcV2HYsb6R5VD+qFkOuD1bPm+sY5kcMBvfzha0=;
 b=VVIwBWANrB+LzGNodU9QElHepVbCZt/24h9Z9tMXDhfbEl5VFQOV/XbJ8E3sTIlwmb
 PevSMJiLhtWmbv4bmcfgOSVR3jL9OGnpo+FCSURRMp/k0PcxGgtpbCAJYkv+zYxldHLo
 2L28TNiCG9KRYlDC0+XBRly1TlfGYqE9eGK1jaPqqnroTeCQhOPGs7yh2K8CDD1+nBQt
 RMOtuWSGcgwnudVRSnsRaOZuak1Amh+jeIcZF3Myl2dIav6SYb26Q59ME3bZsdUR60/y
 ypfWyvUhVyucgVHC/xv0s3gcxTQ2YzblbHzp97QqWNYqjnCocIPkqgtGI+Hw+fQJOo3H
 d5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740618650; x=1741223450;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CuSRKJcV2HYsb6R5VD+qFkOuD1bPm+sY5kcMBvfzha0=;
 b=TLbbu6ZgLr4K1Uvgdj7igkTrRv2ahU3QB4ftDyt7IhYiwnu3FyPkyTffk/ed7CnoDW
 gSNaeAG31pE3KY4ARjAZmpVOTLahxpKf8CEa+m2bBsiKPmQ6l+IBxgs8HaCsEG5y5/Vc
 rU6fcOKfTnl8vmKclKjZv9nGsWRBaDhhuoy8WO8oWMRovUTfxSwAD4nynuXxhnzqO0Mu
 cTOrltTqZ9lIRX34k3E4gHZMVqSLoq+QcpBwoMk21AxxzfJInIXykkk4Ql3oivYuVU9u
 +zhAeUQ4/Qh3pfGwnPB3jKdu+NSJ0mJ/mkO4SiIO1GCVWvGnnUYX5d6csRB8vaY1xKEI
 zkdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJseNegaYpdmKNfAl5fNdhkGOlTK9N8dWVyWOxrVc4VWD70VUd6NxKE6Woo3cay70zExCX/Jf6Ru0=@nongnu.org,
 AJvYcCVKVByr2pwbQkuYXO64MZjGSy/WsJbf2YHJfNB167NWLc0AlGRc2hLKaIGaXqDJfh3KXMm6tfc+YOYy@nongnu.org
X-Gm-Message-State: AOJu0YwhGhvVMwyfgx7q2tt7SS3rxojfjY5RUhILSN1SUMryB1DOx29M
 vn541PIEnbwLGZobTkrz/kJIaAd66kG2ED2/jKjC0tb3TG4JDExICrD2fw==
X-Gm-Gg: ASbGnctogZKY5IeKO1cbVniYN+fveAvMEG4Ueh03kjp3jgfUDoW53aMg/DNMJlLwOpG
 uZbFpdlTdtFL+N/6GYmkOGpgApdga9LZrorrWq8YqUYkdC7CvbHC/SXVTi+NdgvZJaVrXVDpGNl
 78ADIQUC2GEnv0bUv+gm57q+2d6VOGKF2PmI5JmoZrRfMPUODlCycyuEkikZcO3PEEQzhTKkdae
 rTX901btGBDFx0Lz1m2rNnnQp+sZBJio5jjcrqilmmeOvz6cJ67GTrJvpDhKswzbVBkOe9wxzDj
 1o+ooTD5J9CYsktd8w==
X-Google-Smtp-Source: AGHT+IHtvdIvtD+yZgjpdH5mfSkU0yBR8KGqdnjw92PV2llQDqJcHj2wCQV6vAZUFYBCOtURVcajHw==
X-Received: by 2002:a05:6a00:cd3:b0:728:9d19:d2ea with SMTP id
 d2e1a72fcca58-7348bdf1f46mr7203779b3a.13.1740618650432; 
 Wed, 26 Feb 2025 17:10:50 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2b0f9sm252716b3a.22.2025.02.26.17.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:10:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:10:45 +1000
Message-Id: <D82TTAPY9JXE.3P3A8B5Y1GAB1@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 2/4] ppc/amigaone: Implement NVRAM emulation
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.19.0
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <7fac3d50347adbb00bfcd1d1d0bfdf9e73515ebb.1740243918.git.balaton@eik.bme.hu>
In-Reply-To: <7fac3d50347adbb00bfcd1d1d0bfdf9e73515ebb.1740243918.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
> The board has a battery backed NVRAM where U-Boot environment is
> stored which is also accessed by AmigaOS and e.g. C:NVGetVar command
> crashes without it having at least a valid checksum.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/amigaone.c | 116 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 4290d58613..5273543460 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -21,10 +21,13 @@
>  #include "hw/ide/pci.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/ppc/ppc.h"
> +#include "system/block-backend.h"
>  #include "system/qtest.h"
>  #include "system/reset.h"
>  #include "kvm_ppc.h"
> =20
> +#include <zlib.h> /* for crc32 */
> +
>  #define BUS_FREQ_HZ 100000000
> =20
>  /*
> @@ -46,6 +49,103 @@ static const char dummy_fw[] =3D {
>      0x4e, 0x80, 0x00, 0x20, /* blr */
>  };
> =20
> +#define NVRAM_ADDR 0xfd0e0000
> +#define NVRAM_SIZE (4 * KiB)
> +
> +#define TYPE_A1_NVRAM "a1-nvram"
> +OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
> +
> +struct A1NVRAMState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion mr;
> +    BlockBackend *blk;
> +};
> +
> +/* read callback not used because of romd mode, only here just in case *=
/

Better make it g_assert_not_reached() then.

> +static uint64_t nvram_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    A1NVRAMState *s =3D opaque;
> +    uint8_t *p =3D memory_region_get_ram_ptr(&s->mr);
> +
> +    return p[addr];
> +}
> +
> +static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
> +                        unsigned int size)
> +{
> +    A1NVRAMState *s =3D opaque;
> +    uint8_t *p =3D memory_region_get_ram_ptr(&s->mr);
> +
> +    p[addr] =3D val;
> +    if (s->blk) {
> +        blk_pwrite(s->blk, addr, 1, &val, 0);
> +    }
> +}
> +
> +static const MemoryRegionOps nvram_ops =3D {
> +    .read =3D nvram_read,
> +    .write =3D nvram_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +};
> +
> +static void nvram_realize(DeviceState *dev, Error **errp)
> +{
> +    A1NVRAMState *s =3D A1_NVRAM(dev);
> +    void *p;
> +    uint32_t *c;
> +
> +    memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
> +                                  NVRAM_SIZE, &error_fatal);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
> +    c =3D p =3D memory_region_get_ram_ptr(&s->mr);
> +    if (s->blk) {
> +        if (blk_getlength(s->blk) !=3D NVRAM_SIZE) {
> +            error_setg(errp, "NVRAM backing file size must be %ld bytes"=
,
> +                       NVRAM_SIZE);
> +            return;
> +        }
> +        blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
> +                     BLK_PERM_ALL, &error_fatal);
> +        if (blk_pread(s->blk, 0, NVRAM_SIZE, p, 0) < 0) {
> +            error_setg(errp, "Cannot read NVRAM contents from backing fi=
le");
> +            return;
> +        }
> +    }
> +    if (*c =3D=3D 0) {
> +        *c =3D cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
> +        if (s->blk) {
> +            blk_pwrite(s->blk, 0, 4, p, 0);
> +        }
> +    }
> +}

So, no need for a reset because it's persistent?

> +
> +static const Property nvram_properties[] =3D {
> +    DEFINE_PROP_DRIVE("drive", A1NVRAMState, blk),
> +};
> +
> +static void nvram_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
> +
> +    dc->realize =3D nvram_realize;
> +    device_class_set_props(dc, nvram_properties);
> +}
> +
> +static const TypeInfo nvram_types[] =3D {
> +    {
> +        .name =3D TYPE_A1_NVRAM,
> +        .parent =3D TYPE_SYS_BUS_DEVICE,
> +        .instance_size =3D sizeof(A1NVRAMState),
> +        .class_init =3D nvram_class_init,
> +    },
> +};
> +DEFINE_TYPES(nvram_types)
> +
>  static void amigaone_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -72,7 +172,7 @@ static void amigaone_init(MachineState *machine)
>      DeviceState *dev;
>      I2CBus *i2c_bus;
>      uint8_t *spd_data;
> -    int i;
> +    DriveInfo *di;
> =20
>      /* init CPU */
>      cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -97,6 +197,16 @@ static void amigaone_init(MachineState *machine)
>          memory_region_add_subregion(get_system_memory(), 0x40000000, mr)=
;
>      }
> =20
> +    /* nvram */
> +    dev =3D qdev_new(TYPE_A1_NVRAM);
> +    di =3D drive_get(IF_MTD, 0, 0);
> +    if (di) {
> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
> +    }
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), NVRAM_ADDR,
> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(de=
v), 0));
> +
>      /* allocate and load firmware */
>      rom =3D g_new(MemoryRegion, 1);
>      memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
> @@ -136,7 +246,7 @@ static void amigaone_init(MachineState *machine)
>      pci_mem =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>      mr =3D g_new(MemoryRegion, 1);
>      memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
> -                             0, 0x1000000);
> +                             0, 0xe0000);
>      memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);

Better make these addresses #defines at the top of the file with
the NVRAM_ADDR?

Thanks,
Nick

>      mr =3D g_new(MemoryRegion, 1);
>      memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
> @@ -153,7 +263,7 @@ static void amigaone_init(MachineState *machine)
>      qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
>                                  qdev_get_gpio_in(DEVICE(cpu),
>                                  PPC6xx_INPUT_INT));
> -    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> +    for (int i =3D 0; i < PCI_NUM_PINS; i++) {
>          qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via)=
,
>                                                               "pirq", i))=
;
>      }


