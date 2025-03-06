Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13114C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 04:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq2am-0006el-J7; Wed, 05 Mar 2025 23:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2aV-0006aA-M9; Wed, 05 Mar 2025 23:12:00 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq2aT-0007KO-Pe; Wed, 05 Mar 2025 23:11:59 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5239067df8eso83864e0c.3; 
 Wed, 05 Mar 2025 20:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741234315; x=1741839115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfAFU0n8E2x+65ma+4/seir36h9JujQcLnUNYu+mCl0=;
 b=OM4y3tv6D2R/dr3sbU+OXyyjH4rCG9jDUphPhYWsRAtnB44SS8SL+4X01VVcOkKxwr
 F0pf1ACudKDRDKpEmNxwFb35B/y19BJ/avNKpqvOCVGYJN/di7/26/a57cuOLeFGbbNv
 1yzSkMIQCT9stukpO/FXaUKl9Ne0rt9lEypzPaE5eRgE5GAgpV6xYzMGek66UZAR4k93
 kaB3YactoSeYhwkw5YfffU4CMnONp+1aE97Gw4HHv/Ppvg9kzsdpGSzt+2vZfY4revyW
 OYEDqUMvg9LcGLxlZrx+j/oEDtZg8j8D5lu8R83lndRGRaP8MAuazye+/uFBJpJ3nU9K
 9j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741234315; x=1741839115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xfAFU0n8E2x+65ma+4/seir36h9JujQcLnUNYu+mCl0=;
 b=eZ7gl7xQpFwRMh39QeofDJwJIc3wPcCUK1DBZLv7+as+D9DUWfDH0RF+xbmz7fTV3v
 MisUjxNJhld1ENu/eFJy8xjC2JZghtoS/UWD1F76gcxGAkD2wL2oXRU5PZAE9WTjuKmL
 iCUrS/bfVkMooubdUIHUL2IcI5ub+TbrHpWbTk+u5a521ZGciqDaSQZz96rDj4JQUPLx
 8IihZmUs8AwC65Kqb8GyCeGPHPRci0BoMjjRj4SgRPjRJ62JEectcbUL5Sw23teL+WAY
 AAadyVd4bGNNpAW9r0IJmX+/btOZF6O07sqtelfPrnmCtDre32wWPfBZh5NwQoEeOAtb
 StLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTjKrVcByB6Syds3HmCeYyyC5rpKn7s28tZvmnMJpz0YBYEiAe3pqIF1gW/qxiZgYB9r5S3M5dJXD8@nongnu.org
X-Gm-Message-State: AOJu0Yx4AS91/SAKZXZzjok+u3hbd1t7aID7OEGTvf4NxTiihYBgRVUL
 Gvx/3QybYrSSAdi3PIPsI7/2citAfthilxTGccUzYC6oLNkaLuuGpX5B0okHsOhonLphxmFsVIE
 4KIxtmbM8DhxnAPyCKUfK6PDsd9M=
X-Gm-Gg: ASbGncu+s1FvTtaRwwEuXohUxAjpP6YAg3ajwPvA9vlrHR5pdFSbYr4sPdfQ9e63ApI
 h5qGnOJp1oi9FpgcW+iPr0T3Z2ky6qieZZOy52YbfTsQGuD/5NRMCddAZ1x9hy21e+QZaYQAQCD
 D6QFCKERE63DqhjkGvVO0+npS6bdYQ8nV2lY9o5OYCUd/QtruPFjlx/KuV
X-Google-Smtp-Source: AGHT+IEX1j93wMxt5wJIjyKSQkz87WYgNOGlzpH1jWIBYN1U2UyDeDi1UQjHhd/aXV0I82j/0mfwHnpGRfEyrOWRrR8=
X-Received: by 2002:a05:6102:38cf:b0:4c1:8bea:d421 with SMTP id
 ada2fe7eead31-4c2e27fe02fmr3517758137.14.1741234315248; Wed, 05 Mar 2025
 20:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20250225005446.13894-1-sebastian.huber@embedded-brains.de>
 <20250225005446.13894-4-sebastian.huber@embedded-brains.de>
In-Reply-To: <20250225005446.13894-4-sebastian.huber@embedded-brains.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 14:11:29 +1000
X-Gm-Features: AQ5f1JpZY8ZwfpGDoKj-7N95lPZyHFsXxZE9MG9zIpk9wv_e4GuwK6tadmnYCuk
Message-ID: <CAKmqyKOgbKh29K06gi-QTUzNfrjvaTp1PwF1g0WuJ3_Ck5CWSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] hw/riscv: Make FDT optional for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

