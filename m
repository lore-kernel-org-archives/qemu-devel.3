Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA360C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2hw-0000Ic-3p; Wed, 05 Mar 2025 23:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2hu-0000IJ-HC; Wed, 05 Mar 2025 23:19:38 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2hs-00080Q-G2; Wed, 05 Mar 2025 23:19:38 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86b2cc5b3c4so66376241.3; 
 Wed, 05 Mar 2025 20:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741234775; x=1741839575; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3wCTbxMwQ3XuuHLcnkdHuK66BhMoeYK5a2s+XgTMkJw=;
 b=H5MPKF9AqWuH7nY9p4s8lh9mkDcH9VIdaC6KxgO1cFAxfb79oToa4m/8ziVG7GVq3b
 IYBubCZGX1dvEFiNaDcsIlOMJCJMZIsO1VJ5tzTDNxkjSrbZ3wGn5TX/5jpJWaeHkKrb
 ay02y86YxaVYzFaE3Z33Ho29ODbdgYgA5lsLWgFpcYp7TKTKk3y3gEb59/8Rf9srrIKN
 FoMWQGDF/ClSb5b+Ijb9aXcbDsfycgSxphmLeBNkzadHrL2/lZ9CNxL7K7QRZIgHu+V0
 i6xuP2GCbJJsi+ETUUxwqdc6yz3NuWNHKAyrNmkgPI2Z0wTeUqI84KAiGzUXT3ReZ+vE
 4t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741234775; x=1741839575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3wCTbxMwQ3XuuHLcnkdHuK66BhMoeYK5a2s+XgTMkJw=;
 b=SvUA5fdS9gksRw8rI5hQEklXcGUIBPJENZ8rylIgkCLXbZAJ01LlkWa46NZcAQL7ra
 0pX4blzH0Dhx23TVWgv0mkO5elh55f11ztBy2k9Vu7I1wR4v8468V1hfS/gpXdFfh7re
 3Irun8P4WgBLxRGsx4txI1nPeU7w1NrtnWOIcujMB0RzP2epIqP3zIqSVT5i2IpcxlYz
 +BD08rMAYirQi4bDykvWAcKLixcyw60XB/IASm29QVCWDK9P6aCTsNQx4zsgz3DsxtJf
 XVqcAY9TK5FXG8vfMTZP8BATwLOjOW9qjKnvbPLNPAS5jSlGKv1LS9qqV1UdL4EEOjEr
 CY9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXtLtd+cQ1/FdJpgLXSKo8AzL/W7QuwdZvFDfhW+i7vbfPU1fB3Lq7GA8tUVyf7Vh2QxVqTLTZ815J@nongnu.org
X-Gm-Message-State: AOJu0YwJAwfgigG9lC+18hPIosbG5e7xCFqsIz8b7ioijlAsYetr/b36
 jH8opRy+wbcCjg+u0h9iU8feqr9F3F9ZJ+dIAIMWJddZkQWu3l9BWBNg73uAx6oscy9DSZJcG9f
 C4ncGjFL6iQJd9trrYnM+y7kINDs=
X-Gm-Gg: ASbGncsxSAIqcjArbYDcNjorgVVujXE6ANxmGYDuudu7ahUEAM53CaReQLeigwPO1bW
 Fi9BKtY43tMDLZi2uGU56zUmAMBrzQKE6bN7ACTyKTnDfSqDwPKO2iwmx9Hpk1IGccO/HF0qGr5
 w0LyJ224kKdYP4gdW8UU1NMZ+3/N0Xt/eixp6ph5DyWtl4zcfvKnT1qMol
X-Google-Smtp-Source: AGHT+IGkVvrBlObm/L1nPbZF24D/SA9Pk2LEjtnUevfVKqcpJ3ZEzF5RJAqsIt1Eh8NmYXRSWvWHQOqnOQxV22iW6m4=
X-Received: by 2002:a05:6102:3a0f:b0:4c2:2beb:b726 with SMTP id
 ada2fe7eead31-4c2e27af9e3mr3998581137.10.1741234774933; Wed, 05 Mar 2025
 20:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
 <20250225005446.13894-5-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250225005446.13894-5-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 14:19:08 +1000
X-Gm-Features: AQ5f1Jqvm3oCxIBvvbXP6J25FH-ZXeRqLiy9jR1nYtWfd3Jt_xIFECZA4YRfUYM
Message-ID: <CAKmqyKMHXcV_JhBrdMVz+DS=iPgYsFyOoP_OPjzM1FVnV6erBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] hw/riscv: Allow direct start of kernel for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Tue, Feb 25, 2025 at 10:55=E2=80=AFAM Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> Further customize the -bios and -kernel options behaviour for the
> microchip-icicle-kit machine.  If "-bios none -kernel filename" is
> specified, then do not load a firmware and instead only load and start
> the kernel image.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c | 57 ++++++++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 17 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 844dc0545c..df902c8667 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -578,29 +578,45 @@ static void microchip_icicle_kit_machine_init(Machi=
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
> +    if (firmware_name) {
> +        const char *filename =3D riscv_find_firmware(firmware_name, NULL=
);
> +        firmware_end_addr =3D riscv_load_firmware(filename, &firmware_lo=
ad_addr,
> +                                                NULL);
> +    } else {
> +        firmware_end_addr =3D firmware_load_addr;
> +    }
>
>      riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
>      if (machine->kernel_filename) {
> @@ -638,8 +654,15 @@ static void microchip_icicle_kit_machine_init(Machin=
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

