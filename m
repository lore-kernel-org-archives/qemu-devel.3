Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D72C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnSdv-0006Fw-PC; Wed, 26 Feb 2025 20:24:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSds-0006FQ-Dm; Wed, 26 Feb 2025 20:24:48 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSdn-0000wS-9I; Wed, 26 Feb 2025 20:24:48 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22349bb8605so7113245ad.0; 
 Wed, 26 Feb 2025 17:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740619480; x=1741224280; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8PHa3qaKlfMk0K0U/Dg4nfmW6BZf8LxInYhn+kEkIg=;
 b=nj2dzERAOCd/CzVbbdIPSUGSd2ENvBackxLMsR/mGOZyyKUaJDSw1QCKO1MNLtLDSL
 pJb2qQg10OVMMVkeSDKZRpgAxoLefz0L0/hK4UfdCE29ro1tq58BklyX5u596xLgmGgE
 Wc8aFgsWOuTLlVFYPx4YrC7H9hoBmFV9QUJpYKWvVZK80W5+/x+jkEJCvsTN4aJtNMjV
 NXg3T/aT1BD9AcZ24DtVoYPRtFCDDmJg1TEI8imfl3fjf0zKQz3hlE7Vnat0IXxlmdmr
 lDsAzfWjwZNjcf0Khfubo3vgWSGiU+LmOKhVEXmZPh09EW2OxjDHuywbUM/QDlBMP49F
 2Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740619480; x=1741224280;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i8PHa3qaKlfMk0K0U/Dg4nfmW6BZf8LxInYhn+kEkIg=;
 b=nngFMyaOAcuqNSV+HqybuVG2e+hOdsHUKrAJE7TQSM3Pqhxbj/0MgXxZ2O1KSYrnG0
 nojAe/l7UTa34/7XyD+7dP5O92aKvhDJ7O0n4nHyhioprXYg8S2vSF9KAc4MwOJLS29O
 QbbLiwcsaPU46pUdVzh7IWFrfyuDg8WtsEwJb44ZCW0z04imIKMb9Lv9gU/JToQWNqX+
 BWrVC+o/H72NSSj2mTNiuhLuDSgDF94lOEwdDyYTA0Ljtp5wfixnsJX2hFtEyrWMHsVq
 hxoBiEqxJpuWMEdNCWGDpRn+SNpPJidSWRkHL5PuLfJRhE8qckc5zXJqO7b2dEgWjq+U
 kNIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOjlptcK51xNCSB/8kBH6BMbY/bYokD964Ggv5tA4BnHazcwa/9IALELLGjEL8DWVV7BxtGCqqbPo=@nongnu.org,
 AJvYcCWTwVtehy9WheN6aZkcOiBy5ZpWKtMZmLGYvKVILhLQzC0Xr71wzj0y9Aq7zNS+xJGfoi1/vMtqxjpR@nongnu.org
X-Gm-Message-State: AOJu0YzzvLqHENahNZiYDMlq1RlAD98IPGqmye+jpKQWMXjxMGTMjXsE
 5VoSrGfctHazTLGVt560ozB/w1mh1s0bqOSwSEx0eFzN//LDWf/l
X-Gm-Gg: ASbGncvsBtciDV94DnVGN8QWM+o6Kw7XGVEnIOmnKt9JtEAKmJLfHRMg3I5KTfmIs2S
 8FKbDfZnkGgF2DvRZMJdGYl1luWvbe5VeHwFEZQqyZ5QwZIwPl4Gb9xCcqJyvsslaZRSswQNi6f
 2hos9sJxhK79QZQwz8LbQ8m/S+jmk2n39ZVaEiBzgaFzZYeWJelDgS5wdo7TKWIrwvWKoaT22di
 joDCcFeDDr9HEVxj/4At6jXhwzGl111+dGQ8kgzYYPOruSKkcGlayIScnL5U3Mt3nwvDHLHuo42
 Rs9SjLu3eF4QTP+ToQ==
X-Google-Smtp-Source: AGHT+IES62SMLFyhYVoK5o8bOgHtgbVv73v0kfbZxcuw8+WLHq3hdpqzVOZqNPGXH3ZuTwyA1tvaAg==
X-Received: by 2002:a05:6a00:3254:b0:734:9157:7456 with SMTP id
 d2e1a72fcca58-734915776d1mr5022557b3a.19.1740619480175; 
 Wed, 26 Feb 2025 17:24:40 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a0024d40sm259752b3a.93.2025.02.26.17.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:24:39 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:24:33 +1000
Message-Id: <D82U3V8D8R9D.15EDF4YA5MODR@gmail.com>
Subject: Re: [PATCH 4/4] ppc/amigaone: Add kernel and initrd support
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <8a5529e445844a34cd4efb25de12ea0d9934186c.1740243918.git.balaton@eik.bme.hu>
In-Reply-To: <8a5529e445844a34cd4efb25de12ea0d9934186c.1740243918.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
> Add support for -kernel, -initrd and -append command line options.

Looks okay. Any test case could be added to test_ppc_amiga.py?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/amigaone.c | 113 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 35e4075cc3..94682de1c7 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -25,11 +25,14 @@
>  #include "system/qtest.h"
>  #include "system/reset.h"
>  #include "kvm_ppc.h"
> +#include "elf.h"
> =20
>  #include <zlib.h> /* for crc32 */
> =20
>  #define BUS_FREQ_HZ 100000000
> =20
> +#define INITRD_MIN_ADDR 0x600000
> +
>  /*
>   * Firmware binary available at
>   * https://www.hyperion-entertainment.com/index.php/downloads?view=3Dfil=
es&parent=3D28
> @@ -181,12 +184,68 @@ static const TypeInfo nvram_types[] =3D {
>  };
>  DEFINE_TYPES(nvram_types)
> =20
> +struct boot_info {
> +    hwaddr entry;
> +    hwaddr stack;
> +    hwaddr bd_info;
> +    hwaddr initrd_start;
> +    hwaddr initrd_end;
> +    hwaddr cmdline_start;
> +    hwaddr cmdline_end;
> +};
> +
> +/* Board info struct from U-Boot */
> +struct bd_info {
> +    uint32_t bi_memstart;
> +    uint32_t bi_memsize;
> +    uint32_t bi_flashstart;
> +    uint32_t bi_flashsize;
> +    uint32_t bi_flashoffset;
> +    uint32_t bi_sramstart;
> +    uint32_t bi_sramsize;
> +    uint32_t bi_bootflags;
> +    uint32_t bi_ip_addr;
> +    uint8_t  bi_enetaddr[6];
> +    uint16_t bi_ethspeed;
> +    uint32_t bi_intfreq;
> +    uint32_t bi_busfreq;
> +    uint32_t bi_baudrate;
> +} QEMU_PACKED;
> +
> +static void create_bd_info(hwaddr addr, ram_addr_t ram_size)
> +{
> +    struct bd_info *bd =3D g_new0(struct bd_info, 1);
> +
> +    bd->bi_memsize =3D    cpu_to_be32(ram_size);
> +    bd->bi_flashstart =3D cpu_to_be32(PROM_ADDR);
> +    bd->bi_flashsize =3D  cpu_to_be32(1); /* match what U-Boot detects *=
/
> +    bd->bi_bootflags =3D  cpu_to_be32(1);
> +    bd->bi_intfreq =3D    cpu_to_be32(11.5 * BUS_FREQ_HZ);
> +    bd->bi_busfreq =3D    cpu_to_be32(BUS_FREQ_HZ);
> +    bd->bi_baudrate =3D   cpu_to_be32(115200);
> +
> +    cpu_physical_memory_write(addr, bd, sizeof(*bd));
> +}
> +
>  static void amigaone_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> +    CPUPPCState *env =3D &cpu->env;
> =20
>      cpu_reset(CPU(cpu));
> -    cpu_ppc_tb_reset(&cpu->env);
> +    if (env->load_info) {
> +        struct boot_info *bi =3D env->load_info;
> +
> +        env->gpr[1] =3D bi->stack;
> +        env->gpr[2] =3D 1024;
> +        env->gpr[3] =3D bi->bd_info;
> +        env->gpr[4] =3D bi->initrd_start;
> +        env->gpr[5] =3D bi->initrd_end;
> +        env->gpr[6] =3D bi->cmdline_start;
> +        env->gpr[7] =3D bi->cmdline_end;
> +        env->nip =3D bi->entry;
> +    }
> +    cpu_ppc_tb_reset(env);
>  }
> =20
>  static void fix_spd_data(uint8_t *spd)
> @@ -208,6 +267,8 @@ static void amigaone_init(MachineState *machine)
>      I2CBus *i2c_bus;
>      uint8_t *spd_data;
>      DriveInfo *di;
> +    hwaddr loadaddr;
> +    struct boot_info *bi =3D NULL;
> =20
>      /* init CPU */
>      cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
> @@ -304,6 +365,56 @@ static void amigaone_init(MachineState *machine)
>      }
>      pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "i=
de")));
>      pci_vga_init(pci_bus);
> +
> +    if (!machine->kernel_filename) {
> +        return;
> +    }
> +
> +    /* handle -kernel, -initrd, -append options and emulate U-Boot */
> +    bi =3D g_new0(struct boot_info, 1);
> +    cpu->env.load_info =3D bi;
> +
> +    loadaddr =3D MIN(machine->ram_size, 256 * MiB);
> +    bi->bd_info =3D loadaddr - 8 * MiB;
> +    create_bd_info(bi->bd_info, machine->ram_size);
> +    bi->stack =3D bi->bd_info - 64 * KiB - 8;
> +
> +    if (machine->kernel_cmdline && machine->kernel_cmdline[0]) {
> +        size_t len =3D strlen(machine->kernel_cmdline);
> +
> +        loadaddr =3D bi->bd_info + 1 * MiB;
> +        cpu_physical_memory_write(loadaddr, machine->kernel_cmdline, len=
 + 1);
> +        bi->cmdline_start =3D loadaddr;
> +        bi->cmdline_end =3D loadaddr + len + 1; /* including terminating=
 '\0' */
> +    }
> +
> +    sz =3D load_elf(machine->kernel_filename, NULL, NULL, NULL,
> +                  &bi->entry, &loadaddr, NULL, NULL,
> +                  ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
> +    if (sz <=3D 0) {
> +        sz =3D load_uimage(machine->kernel_filename, &bi->entry, &loadad=
dr,
> +                         NULL, NULL, NULL);
> +    }
> +    if (sz <=3D 0) {
> +        error_report("Could not load kernel '%s'",
> +                     machine->kernel_filename);
> +        exit(1);
> +    }
> +    loadaddr +=3D sz;
> +
> +    if (machine->initrd_filename) {
> +        loadaddr =3D ROUND_UP(loadaddr + 4 * MiB, 4 * KiB);
> +        loadaddr =3D MAX(loadaddr, INITRD_MIN_ADDR);
> +        sz =3D load_image_targphys(machine->initrd_filename, loadaddr,
> +                                 bi->bd_info - loadaddr);
> +        if (sz <=3D 0) {
> +            error_report("Could not load initrd '%s'",
> +                         machine->initrd_filename);
> +            exit(1);
> +        }
> +        bi->initrd_start =3D loadaddr;
> +        bi->initrd_end =3D loadaddr + sz;
> +    }
>  }
> =20
>  static void amigaone_machine_init(MachineClass *mc)


