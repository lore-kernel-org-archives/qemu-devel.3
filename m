Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72DBC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 02:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0WMo-0005mt-UJ; Thu, 03 Apr 2025 22:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WMn-0005md-4X; Thu, 03 Apr 2025 22:01:09 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WMh-0007yx-Uk; Thu, 03 Apr 2025 22:01:08 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86d30c329f2so1421186241.0; 
 Thu, 03 Apr 2025 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743732062; x=1744336862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqVnFWXcmhAg/Q7q8hVywK2dyeT7ruMEDQo+Z/U7pSs=;
 b=c+73xyVkM1IlV28CufuXzEFDaS4kzxYWJnmg4GQ1bnE7OgYTXbhkawGbhxgV3Mgv4A
 1oU2KIw540fOMtRvVKcp3cxY4Lx/Gg30J2QlIJGd7FvdJiTBDotB610aCAMwROHrceCN
 1o1Ksg9uiWqy1O7DwjPsIvexswRctkMflfBR09mx2kznuGq4Abf0uQOc0oNj3r7cIpeC
 TvRcxjXZZ5Xxj0UKiHa1dPRb2nP0pYofO7Hx1BIyOaxvykJFZXl70FHmTyaB2rzK7Zkc
 UYc6UR6NECxmUV4kBWsbuNYQZrO6kIBcxknDS6oaWAMD4jf8nAeEy62DzD+HK7gF+Qmk
 tvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743732062; x=1744336862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CqVnFWXcmhAg/Q7q8hVywK2dyeT7ruMEDQo+Z/U7pSs=;
 b=r3kLc5DnV1il8o8mbHZyXs9fluGR7sEvQzN/1X7sfgA1ZT2qHH7wS5NUcrh561z1t4
 qdT8ts2823pb7ym+y8UK6qcu01E85AxFeTy1t6vREvxP2Tz3OelxUVjAMEiNgITDF2Vk
 GCL/B8rRaPyRmmcGM/4XH96Un332TyOmZL9EkIf1JKxWohilhSeEqjCv67PtRkJoYdhZ
 Iu5u5s/BsnEXUs6bpn6mgIb1Awn81sWVrRbtIEpRM5wzreQ4NrIct/qk9Ln+n3GbwCF3
 jQpx8nbCKfmy5k7OrJBtkBdC9IEXiXdreZ74vjpFo/RnGDLL9ME4YTbdU9AzcETPfiWB
 ofpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp/2dynLaf0xHiIBO+qhcc3XVlrgtS+ioOONLfzk3DqROhhB0QHo2e1DCcsbZWVqP1Mf5ouk3uhM3Z@nongnu.org
X-Gm-Message-State: AOJu0Yw6lJWFENVcUsNQUXtjVl1K5DmKhAfc+2xF1206un5lTzFDDwEW
 QdyWF1CIGC8nR/oupF+PawCnWDFAJ0p/YmZJ5MbgI1wflbTF+2nFtxUjiDEfXUEfdiljrsR+Kuo
 3WDnb8zckGxzyvQcH4BpGi+zuMMQ=
X-Gm-Gg: ASbGnctKEqq/bLP8Z4OimFVr1SuWPtTIipVwODdccYN9HjUNnekFl5oroYC5Mcar0D1
 QGvr94bhKdDqzoRLQZa3p6QzJ9R/VrOo7O0FMhvD+OQMoH0xVyqwLR2NGzecK58HFZkETCYGxbP
 iKA51x72HXeL1XJ/3DSsJZjck7AYE4ZoUiGAB7KVG5ro3pIWE+EhexQ1a3
X-Google-Smtp-Source: AGHT+IG8LZTvpWHPlBQAjv7/3rmdYc46YD6OLyzfPqbUIlkJmIFBQoHTC51IE0fTCWcnyzo1dENoI5ilFrjxZKc4YvA=
X-Received: by 2002:a05:6102:158f:b0:4c2:fccb:a647 with SMTP id
 ada2fe7eead31-4c845a45e4fmr6154244137.5.1743732062320; Thu, 03 Apr 2025
 19:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-5-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250319061342.26435-5-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 12:00:35 +1000
X-Gm-Features: ATxdqUEKVqKu395BmnKaNWRBoWeeMCvx2mbyuXwtI5EzhGTfk51LmapGPLh3O2k
Message-ID: <CAKmqyKOfP-cjk59Oez+T2a_RE1jmcKAJD-MiqkLBogubZCtfqA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/riscv: Allow direct start of kernel for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 19, 2025 at 4:13=E2=80=AFPM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Further customize the -bios and -kernel options behaviour for the
> microchip-icicle-kit machine.  If "-bios none -kernel filename" is
> specified, then do not load a firmware and instead only load and start
> the kernel image.
>
> For test runs, use an approach similar to
> riscv_find_and_load_firmware().
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c | 59 +++++++++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 17 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 844dc0545c..5c9f7f643f 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -578,29 +578,47 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>      }
>
>      /*
> -     * We follow the following table to select which payload we execute.
> +     * We follow the following table to select which firmware we use.
>       *
> -     *  -bios |    -kernel | payload
> -     * -------+------------+--------
> -     *      N |          N | HSS
> -     *      Y | don't care | HSS
> -     *      N |          Y | kernel
> -     *
> -     * This ensures backwards compatibility with how we used to expose -=
bios
> -     * to users but allows them to run through direct kernel booting as =
well.
> +     * -bios         | -kernel    | firmware
> +     * --------------+------------+--------
> +     * none          |          N | error
> +     * none          |          Y | kernel
> +     * NULL, default |          N | BIOS_FILENAME
> +     * NULL, default |          Y | RISCV64_BIOS_BIN
> +     * other         | don't care | other
>       */
> +    if (machine->firmware && !strcmp(machine->firmware, "none")) {
> +        if (!machine->kernel_filename) {
> +            error_report("for -bios none, a kernel is required");
> +            exit(1);
> +        }
>
> -    if (machine->kernel_filename) {
> -        firmware_name =3D RISCV64_BIOS_BIN;
> -        firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> +        firmware_name =3D NULL;
> +        firmware_load_addr =3D RESET_VECTOR;
> +    } else if (!machine->firmware || !strcmp(machine->firmware, "default=
")) {
> +        if (machine->kernel_filename) {
> +            firmware_name =3D RISCV64_BIOS_BIN;
> +            firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> +        } else {
> +            firmware_name =3D BIOS_FILENAME;
> +            firmware_load_addr =3D RESET_VECTOR;
> +        }
>      } else {
> -        firmware_name =3D BIOS_FILENAME;
> +        firmware_name =3D machine->firmware;
>          firmware_load_addr =3D RESET_VECTOR;
>      }
>
> -    /* Load the firmware */
> -    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> -                                                     &firmware_load_addr=
, NULL);
> +    /* Load the firmware if necessary */
> +    firmware_end_addr =3D firmware_load_addr;
> +    if (firmware_name) {
> +        char *filename =3D riscv_find_firmware(firmware_name, NULL);
> +        if (filename) {
> +            firmware_end_addr =3D riscv_load_firmware(filename,
> +                                                    &firmware_load_addr,=
 NULL);
> +            g_free(filename);
> +        }
> +    }
>
>      riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
>      if (machine->kernel_filename) {
> @@ -638,8 +656,15 @@ static void microchip_icicle_kit_machine_init(Machin=
eState *machine)
>              fdt_load_addr =3D 0;
>          }
>
> +        hwaddr start_addr;
> +        if (firmware_name) {
> +            start_addr =3D firmware_load_addr;
> +        } else {
> +            start_addr =3D kernel_entry;
> +        }
> +
>          /* Load the reset vector */
> -        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load=
_addr,
> +        riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, start_addr,
>                                    memmap[MICROCHIP_PFSOC_ENVM_DATA].base=
,
>                                    memmap[MICROCHIP_PFSOC_ENVM_DATA].size=
,
>                                    kernel_entry, fdt_load_addr);
> --
> 2.43.0
>

