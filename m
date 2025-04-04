Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490DFC3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0WE1-0004LM-5h; Thu, 03 Apr 2025 21:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WDy-0004Ky-6E; Thu, 03 Apr 2025 21:52:03 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0WDw-0006rS-BN; Thu, 03 Apr 2025 21:52:01 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-523de5611a3so755654e0c.1; 
 Thu, 03 Apr 2025 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743731518; x=1744336318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0amKgEFIbAZo/gRjBuDwH6oKX9CBH9iMSQlhRjkshWY=;
 b=Q4PQGKR3vech0xljnjE/PE9C4fWCke9NZFE4kuYyaP8Qf8RjS/xMpbMb1s3yzT1lWu
 4TXA1FUkGlArJY+zcyWpxNO7iXACjrfsp64WNmPUwoc/YdrHlGtLDrhhMtgQ4atGI+Kk
 yWfCe0qx5qiMCQxMHbmh5SJ4wCnzZQZbVf3EXJOFKkUqANOYsohSrRjlX074ScQ1iVk+
 RGkVRtsJBXGToa92bsURU8X5iRXUb9CiFKpHC26bKrbd3jGWk7YnGm9EwaW1QkvmvtVA
 g913Qgna+x2BsFtq8q9cb5aNerCWxhN+trAwSl0nbfmVaQVzDRWItzOdE845AXVvHHHc
 j9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743731518; x=1744336318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0amKgEFIbAZo/gRjBuDwH6oKX9CBH9iMSQlhRjkshWY=;
 b=jNEVYPq8We+9bMz/XEwP5Bfhwbq8LeqBQeKbhbmlXVkD/hIYIFqUPGvJyKuXNiLPeg
 GLMxg+0L8fRwVXRTUAGbCcLOJoidWwCgFQ7HUdKUT/ONIK81E7l8+jr0SmpjXtyF37l2
 rbhXGXFDJULaeoffJV/XK7/CU5oroAbxUUJaGEUhTW/V/SmSX+yQleavy10FCIy/6FQZ
 FGBG3MJpTxga75yN8APyjEWwMDO+zIOdQD50qbJYTPUGD9ah2Xpon7+ekoVgWUHy65aK
 MVt5Py3v6+wFuyKLKAkD57OhjiqMNj1UMyyZfhwyjPqtFFOjK8FfTXihg1AHZcdQ46fW
 0zMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvrYTLDPlz50uU6A6ra7kVIpVGrmnkv+EcVNq37l6mCEppC8rR0zuC6LH5t6pfCIIT+CkNSwUTIBTf@nongnu.org
X-Gm-Message-State: AOJu0YwooeuBIgMTatvH5MCZM3Bt/YSED4pXrKTx9puTV2ACk+9JNsdi
 HckuzVR105wWuWQ59FN37PjbzkVO4Z60RI4Kaloue0oU4H9qEf7HNcjogsMff89HrtXfKujEX2J
 UmHtWRQTqhApmFdKjiU5yykp+iIw=
X-Gm-Gg: ASbGncsKulpN6ArzZbECxLWXSJXUWZZ7jPLqfZHVnpdDRKPSfm2eHp8x1O9nbPgrayP
 Q2KPD7hp4NLe1gMfWefFoA1uC8kBNx67jsU4p4gkzD6TgPOth9VJY0mGOKnpmJtv3WkU99JEf8i
 q/kguH3Ms+XCgZGG7lskVs1iG8okg/LJl/YhC4Mf8NR+OIhX7WXeWijFN1
X-Google-Smtp-Source: AGHT+IHSx6t/kUDadjhBSZPHD4xCiFNARnVGcjjEwYIbSEGoTBgU1hI/A54uAuoFmeZnpIyTNfmwlGMPbkIxEuTMnt8=
X-Received: by 2002:a05:6102:b0a:b0:4bb:e511:15a3 with SMTP id
 ada2fe7eead31-4c85539f8e6mr1139837137.8.1743731518298; Thu, 03 Apr 2025
 18:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:51:32 +1000
X-Gm-Features: ATxdqUEAkf5M3ezFqQm4CoiNwmXS9b6YKdK6IJqbgmRAdVSGeOQjMGXhnrdTYpw
Message-ID: <CAKmqyKNTdE76SH3PfDB_n1qyhotpeyuLc7FHVQY9CY8D-Cykxg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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
> Real-time kernels such as RTEMS or Zephyr may use a static device tree
> built into the kernel image.  Do not require to use the -dtb option if
> -kernel is used for the microchip-icicle-kit machine.  Issue a warning
> if no device tree is provided by the user since the machine does not
> generate one.
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/microchip_pfsoc.c | 56 +++++++++++++++++++-------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index f477d2791e..844dc0545c 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -516,7 +516,6 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>      uint64_t mem_low_size, mem_high_size;
>      hwaddr firmware_load_addr;
>      const char *firmware_name;
> -    bool kernel_as_payload =3D false;
>      target_ulong firmware_end_addr, kernel_start_addr;
>      uint64_t kernel_entry;
>      uint64_t fdt_load_addr;
> @@ -589,25 +588,12 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>       *
>       * This ensures backwards compatibility with how we used to expose -=
bios
>       * to users but allows them to run through direct kernel booting as =
well.
> -     *
> -     * When -kernel is used for direct boot, -dtb must be present to pro=
vide
> -     * a valid device tree for the board, as we don't generate device tr=
ee.
>       */
>
> -    if (machine->kernel_filename && machine->dtb) {
> -        int fdt_size;
> -        machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
> -        if (!machine->fdt) {
> -            error_report("load_device_tree() failed");
> -            exit(1);
> -        }
> -
> +    if (machine->kernel_filename) {
>          firmware_name =3D RISCV64_BIOS_BIN;
>          firmware_load_addr =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> -        kernel_as_payload =3D true;
> -    }
> -
> -    if (!kernel_as_payload) {
> +    } else {
>          firmware_name =3D BIOS_FILENAME;
>          firmware_load_addr =3D RESET_VECTOR;
>      }
> @@ -617,7 +603,7 @@ static void microchip_icicle_kit_machine_init(Machine=
State *machine)
>                                                       &firmware_load_addr=
, NULL);
>
>      riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
> -    if (kernel_as_payload) {
> +    if (machine->kernel_filename) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
>                                                           firmware_end_ad=
dr);
>
> @@ -625,19 +611,33 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>                            true, NULL);
>          kernel_entry =3D boot_info.image_low_addr;
>
> -        /* Compute the fdt load address in dram */
> -        hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].base;
> -        hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].size;
> -
> -        if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
> -            kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base;
> -            kernel_ram_size =3D mem_high_size;
> +        if (machine->dtb) {
> +            int fdt_size;
> +            machine->fdt =3D load_device_tree(machine->dtb, &fdt_size);
> +            if (!machine->fdt) {
> +                error_report("load_device_tree() failed");
> +                exit(1);
> +            }
> +
> +            /* Compute the FDT load address in DRAM */
> +            hwaddr kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_LO].b=
ase;
> +            hwaddr kernel_ram_size =3D memmap[MICROCHIP_PFSOC_DRAM_LO].s=
ize;
> +
> +            if (kernel_entry - kernel_ram_base >=3D kernel_ram_size) {
> +                kernel_ram_base =3D memmap[MICROCHIP_PFSOC_DRAM_HI].base=
;
> +                kernel_ram_size =3D mem_high_size;
> +            }
> +
> +            fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, ke=
rnel_ram_size,
> +                                                   machine, &boot_info);
> +            riscv_load_fdt(fdt_load_addr, machine->fdt);
> +        } else {
> +            warn_report_once("The QEMU microchip-icicle-kit machine does=
 not "
> +                             "generate a device tree, so no device tree =
is "
> +                             "being provided to the guest.");
> +            fdt_load_addr =3D 0;
>          }
>
> -        fdt_load_addr =3D riscv_compute_fdt_addr(kernel_ram_base, kernel=
_ram_size,
> -                                               machine, &boot_info);
> -        riscv_load_fdt(fdt_load_addr, machine->fdt);
> -
>          /* Load the reset vector */
>          riscv_setup_rom_reset_vec(machine, &s->soc.u_cpus, firmware_load=
_addr,
>                                    memmap[MICROCHIP_PFSOC_ENVM_DATA].base=
,
> --
> 2.43.0
>

