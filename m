Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3612FC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 08:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnYwT-00008T-05; Thu, 27 Feb 2025 03:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnYwM-00007v-Nh; Thu, 27 Feb 2025 03:08:18 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnYwK-0001hB-Oi; Thu, 27 Feb 2025 03:08:18 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2230c74c8b6so18202915ad.0; 
 Thu, 27 Feb 2025 00:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740643695; x=1741248495; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/ivrbhWG8WwJ8UXxTBdPWQ069q4Q+mqwhwxLYGh/xg=;
 b=gMz87Cq3QvqIi7K3Cl+518YfPtNfEdQ3ET3mWyxclZNKeIpxJL5f1ngGbbMbm9uWFp
 rrI0QLkbFcd/xtm7CMXc5QyWlclSZBf50KFMTUb1xxFbwDBXC1rXhaQH067tRK/S0NCN
 powlY9+OoTAipFQ+wlJfw6yLOHnTL26h6g9H7iCMEeNelhTUhIQmKB7fcMo4jOTEmwMY
 FU3w0VWLgiEgVY5UVoA4umoVP//JXPkAvpfBzcKMAKpMi74LOsNHRy/3NaKQ0A+Xep8O
 zU4avHVzfvDngHCO0HlicSxXrOpwZYyUAxenXImctrgzZpcNSVGxhJfXxK0oBvR9f1P5
 umow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740643695; x=1741248495;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L/ivrbhWG8WwJ8UXxTBdPWQ069q4Q+mqwhwxLYGh/xg=;
 b=ZxWXBKNqb7HgkMDMTgdLf024pEb1DpncaATgkVPHe9cGvQW9DJpvKgdNB/gPisfy77
 Vgbs3hh4+8GFfSmE0QUvQ24iQ8cMkiuFGLJumYBKrzexEZu3Sm41NpEHqPl4v0W1PZLt
 ZrQi9bk7MtlgjIs9CJyIECoNo7dd7IzW9b4zPJOyFbV5vTNwJEe5j3ypb0DE9tELiael
 taUPBZh53I50myy1LOULxOgYCiO6ELYSolLBQbzXpq1nfKQCcNDFft863lC8s4jdUozd
 WG74ltd07jRywkJtY/1stM5DdB4WPojTQyak/w9hehFRKgLYt4hlQ3a7/KmnRRcgXhCB
 sA5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/I4ltQ73RI2qFQBQAYx7fS+WZ5aiq/3LlhPPuCSQiKhfRNfio3voBQ+FDwzdhNRXtfN215r8g4A==@nongnu.org
X-Gm-Message-State: AOJu0YzyIrWIcBHPlA985vUePaMmnzb8gBkML239/phBQvMmw9p7wPq8
 8c08MxvOXRF5DSHYTLyMclf8c1lQnVQauy7LX59kGxgELcP5bTzS
X-Gm-Gg: ASbGncvIOLRe+8nt67j+tEjs96IfKRRgA4oZtrcaQ21hSi0P3XK8xY0wvyUUs3zEVU0
 4VqHBUcjB+l9Ws/UwkqYo9hn4mCVIIL+94ZUQxx2V3/81uqFCNdfB3cOlidXL1RD/CGKt6dz2qU
 HnPf8+88H77UH2MPOu51NGHdAt5vVsBeb2vNqc5whgJUps/3UCGr4gmWj6qLaNCw76WuYKL70kV
 S8uZKrKDNw7U6fO8B3v1mc8kl9M9BQ9ZwXcdSttbuRLQ7EqASb4+qQ38nNfDNYdeRZtvtm2Eov7
 N3urrpa4JOH5l6Dr9w==
X-Google-Smtp-Source: AGHT+IHbTSYUN5+SDLYdak4cX5BeDpFP//mddFbVspyAh4K8aMUdjzUdYmrU29bTs3/0BgbTjSy0sw==
X-Received: by 2002:a05:6a20:1590:b0:1f2:e31c:527e with SMTP id
 adf61e73a8af0-1f2e31c5401mr4721437637.34.1740643694506; 
 Thu, 27 Feb 2025 00:08:14 -0800 (PST)
Received: from localhost ([1.146.124.39]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe2b886sm923814b3a.24.2025.02.27.00.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 00:08:14 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 18:08:08 +1000
Message-Id: <D832OVALUQAP.19HG8HTKN2EGJ@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 2/4] ppc/amigaone: Implement NVRAM emulation
X-Mailer: aerc 0.19.0
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <7fac3d50347adbb00bfcd1d1d0bfdf9e73515ebb.1740243918.git.balaton@eik.bme.hu>
 <D82TTAPY9JXE.3P3A8B5Y1GAB1@gmail.com>
 <5bd464bc-bcbf-d5ad-abef-3506d255d7e5@eik.bme.hu>
In-Reply-To: <5bd464bc-bcbf-d5ad-abef-3506d255d7e5@eik.bme.hu>
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

On Thu Feb 27, 2025 at 11:48 AM AEST, BALATON Zoltan wrote:
> On Thu, 27 Feb 2025, Nicholas Piggin wrote:
>> On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
>>> The board has a battery backed NVRAM where U-Boot environment is
>>> stored which is also accessed by AmigaOS and e.g. C:NVGetVar command
>>> crashes without it having at least a valid checksum.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  hw/ppc/amigaone.c | 116 ++++++++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 113 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>> index 4290d58613..5273543460 100644
>>> --- a/hw/ppc/amigaone.c
>>> +++ b/hw/ppc/amigaone.c
>>> @@ -21,10 +21,13 @@
>>>  #include "hw/ide/pci.h"
>>>  #include "hw/i2c/smbus_eeprom.h"
>>>  #include "hw/ppc/ppc.h"
>>> +#include "system/block-backend.h"
>>>  #include "system/qtest.h"
>>>  #include "system/reset.h"
>>>  #include "kvm_ppc.h"
>>>
>>> +#include <zlib.h> /* for crc32 */
>>> +
>>>  #define BUS_FREQ_HZ 100000000
>>>
>>>  /*
>>> @@ -46,6 +49,103 @@ static const char dummy_fw[] =3D {
>>>      0x4e, 0x80, 0x00, 0x20, /* blr */
>>>  };
>>>
>>> +#define NVRAM_ADDR 0xfd0e0000
>>> +#define NVRAM_SIZE (4 * KiB)
>>> +
>>> +#define TYPE_A1_NVRAM "a1-nvram"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
>>> +
>>> +struct A1NVRAMState {
>>> +    SysBusDevice parent_obj;
>>> +
>>> +    MemoryRegion mr;
>>> +    BlockBackend *blk;
>>> +};
>>> +
>>> +/* read callback not used because of romd mode, only here just in case=
 */
>>
>> Better make it g_assert_not_reached() then.
>
> There is a memory_region_rom_device_set_romd() function. It's not called=
=20
> here so a read function should not be needed but it's also trivial and=20
> would work if romd mode is turned off for some reason in the future so=20
> adding it seems safer to me. The comment is just to note it's a romd=20
> region so reads normally don't go through this function unless romd mode=
=20
> is turned off.

It's trivial to add back if you do turn it off. Adding dead code is no
good. The memory API default won't get changed underneath you without
proper code audit or deprecating the API so that's no problem.

>>> +static uint64_t nvram_read(void *opaque, hwaddr addr, unsigned int siz=
e)
>>> +{
>>> +    A1NVRAMState *s =3D opaque;
>>> +    uint8_t *p =3D memory_region_get_ram_ptr(&s->mr);
>>> +
>>> +    return p[addr];
>>> +}
>>> +
>>> +static void nvram_write(void *opaque, hwaddr addr, uint64_t val,
>>> +                        unsigned int size)
>>> +{
>>> +    A1NVRAMState *s =3D opaque;
>>> +    uint8_t *p =3D memory_region_get_ram_ptr(&s->mr);
>>> +
>>> +    p[addr] =3D val;
>>> +    if (s->blk) {
>>> +        blk_pwrite(s->blk, addr, 1, &val, 0);
>>> +    }
>>> +}
>>> +
>>> +static const MemoryRegionOps nvram_ops =3D {
>>> +    .read =3D nvram_read,
>>> +    .write =3D nvram_write,
>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>> +    .impl =3D {
>>> +        .min_access_size =3D 1,
>>> +        .max_access_size =3D 1,
>>> +    },
>>> +};
>>> +
>>> +static void nvram_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    A1NVRAMState *s =3D A1_NVRAM(dev);
>>> +    void *p;
>>> +    uint32_t *c;
>>> +
>>> +    memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram"=
,
>>> +                                  NVRAM_SIZE, &error_fatal);
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mr);
>>> +    c =3D p =3D memory_region_get_ram_ptr(&s->mr);
>>> +    if (s->blk) {
>>> +        if (blk_getlength(s->blk) !=3D NVRAM_SIZE) {
>>> +            error_setg(errp, "NVRAM backing file size must be %ld byte=
s",
>>> +                       NVRAM_SIZE);
>>> +            return;
>>> +        }
>>> +        blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE=
,
>>> +                     BLK_PERM_ALL, &error_fatal);
>>> +        if (blk_pread(s->blk, 0, NVRAM_SIZE, p, 0) < 0) {
>>> +            error_setg(errp, "Cannot read NVRAM contents from backing =
file");
>>> +            return;
>>> +        }
>>> +    }
>>> +    if (*c =3D=3D 0) {
>>> +        *c =3D cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>> +        if (s->blk) {
>>> +            blk_pwrite(s->blk, 0, 4, p, 0);
>>> +        }
>>> +    }
>>> +}
>>
>> So, no need for a reset because it's persistent?
>
> It's either written to the backing file when changed or stays unchanged o=
n=20
> reboot so no need to reset. The idea is to provide a default if there's n=
o=20
> backing file but allow the user to change it for the session but not keep=
=20
> changes between sessions. With backing file it's like real machine keepin=
g=20
> settings between reboots. I don't think it needs anything in reset.

Yep, makes sense I think.

>
>>> +
>>> +static const Property nvram_properties[] =3D {
>>> +    DEFINE_PROP_DRIVE("drive", A1NVRAMState, blk),
>>> +};
>>> +
>>> +static void nvram_class_init(ObjectClass *oc, void *data)
>>> +{
>>> +    DeviceClass *dc =3D DEVICE_CLASS(oc);
>>> +
>>> +    dc->realize =3D nvram_realize;
>>> +    device_class_set_props(dc, nvram_properties);
>>> +}
>>> +
>>> +static const TypeInfo nvram_types[] =3D {
>>> +    {
>>> +        .name =3D TYPE_A1_NVRAM,
>>> +        .parent =3D TYPE_SYS_BUS_DEVICE,
>>> +        .instance_size =3D sizeof(A1NVRAMState),
>>> +        .class_init =3D nvram_class_init,
>>> +    },
>>> +};
>>> +DEFINE_TYPES(nvram_types)
>>> +
>>>  static void amigaone_cpu_reset(void *opaque)
>>>  {
>>>      PowerPCCPU *cpu =3D opaque;
>>> @@ -72,7 +172,7 @@ static void amigaone_init(MachineState *machine)
>>>      DeviceState *dev;
>>>      I2CBus *i2c_bus;
>>>      uint8_t *spd_data;
>>> -    int i;
>>> +    DriveInfo *di;
>>>
>>>      /* init CPU */
>>>      cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>>> @@ -97,6 +197,16 @@ static void amigaone_init(MachineState *machine)
>>>          memory_region_add_subregion(get_system_memory(), 0x40000000, m=
r);
>>>      }
>>>
>>> +    /* nvram */
>>> +    dev =3D qdev_new(TYPE_A1_NVRAM);
>>> +    di =3D drive_get(IF_MTD, 0, 0);
>>> +    if (di) {
>>> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(di));
>>> +    }
>>> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>>> +    memory_region_add_subregion(get_system_memory(), NVRAM_ADDR,
>>> +                                sysbus_mmio_get_region(SYS_BUS_DEVICE(=
dev), 0));
>>> +
>>>      /* allocate and load firmware */
>>>      rom =3D g_new(MemoryRegion, 1);
>>>      memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
>>> @@ -136,7 +246,7 @@ static void amigaone_init(MachineState *machine)
>>>      pci_mem =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
>>>      mr =3D g_new(MemoryRegion, 1);
>>>      memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
>>> -                             0, 0x1000000);
>>> +                             0, 0xe0000);
>>>      memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
>>
>> Better make these addresses #defines at the top of the file with
>> the NVRAM_ADDR?
>
> I don't have defines for these as these are single use constants to set u=
p=20
> memory map and with defines it's less obvious and has to be looked up=20
> where these are while this way I can see it directly without having to=20
> scroll up so I prefer this. I've added defines where the constant is used=
=20
> more than once where it makes sense to keep consistency.

But now you have to lok in two different places anyway because you have
the NVRAM_ADDR etc defines at the top of the file. Seems like a good
time to move all defines there so you can easily see the memory map in
one place.

Thanks,
Nick

