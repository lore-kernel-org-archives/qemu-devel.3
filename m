Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E10DF433D0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 00:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDA9c-0007a4-Km; Wed, 15 Apr 2026 20:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDA9a-0007Zl-LA
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:00:18 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDA9Y-0004cF-KU
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 20:00:18 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-652f220595fso823341d50.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 17:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776297615; cv=none;
 d=google.com; s=arc-20240605;
 b=HdY6TgQelvPSmOJElUoY/LI0bmMxcA/vkdGc+C0a/2jr3QVSErzBvC8G3vkXVVgISk
 h6oWF2zGzlXhF6pXRe+hE7lUIF4hWFxoJZADlLvF10Vf24coCa8a8TUX3+Zd/jf7N0fl
 Bn02qeWtq/2Ga2xpWzp+7rtyeVCkgosfBMJ+EPDWd4A5luz4ljKGs36YcBw6Zhm4uEhM
 9l7i/nMZHwu2/SE6KJZbV3GMEGYIcQXABUJVfKDn0fzIJr6TgOOka4tzhiFDWjZy+YtE
 1RZsxFyNr5azjaUijDp6A5hrk0ffZeGgNTGxL8PUltQWRDADxacFn3Z10IZ8+bVfFUWn
 qdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hafj6m/O4ih1Yo7dTCBbATpZXa0Z5uMNOvsKs78TsDk=;
 fh=3IwB7GlzQWqGZlNRsAsXu9Hkolrug9Aot1+MAtnck6Q=;
 b=YJhh5z9JBt81Y5s/tNnOLCsxnjvXZ9YlOezlifCvqXg8ZSgHQKPWOKnzQ2nsWF9+Ro
 DVbmt38dY984zTntt84xHnIw2Wh5pCk3WzAaj4j98GCSQNlrIl4JPkgmEhtyX7DZsORO
 gGAdSzycJxtemyQ6RqTFizpHOnHWzy5tawi+opZvDdfANHMV9d7K6ujOAZoA3Rzh+2r4
 t9g4KdYh20FafdY6u+pBprtyY2G0PGqNYp3GEIAOZzmUG0pSzta3St9u/F3h2JAI6ZVF
 LOn2k+01SG1Rlx28CUWaHAZQ1pn8kSzHwQ8l4ilMGdQ3kImP3vcynCqvSGNQEdnsznqM
 q7KQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776297615; x=1776902415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hafj6m/O4ih1Yo7dTCBbATpZXa0Z5uMNOvsKs78TsDk=;
 b=QYYX3X1UM0uiLGypxSZTHAu8mcookGQlYj3U0xehU7Xrc9DpyIw4SH24hXrmTWItpo
 j3dXZtrTm3RiA8Tf9jsdC6KnwroZgNIerzMast9fbZ/S58hgGN36JG91SYi7dPIo7iXo
 FPrUFP1M883i6JuzeQStvRyrjZNQXQSisCK1ZY1Alt4b3e5DlVrvlnx1NKHoLz+sKKaV
 dDojizGJfBVzfZoFT6aiOJqzaZK2q6ol/Gaogh7t9gwH99Iklz/acghundA0QV1rSbPj
 zaYIu2eaUTeroumu29VJ7hMtRguwmSbY1jwN1kKvkW1An+62lnXtiQi73JEPN6OGZXF0
 uIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776297615; x=1776902415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hafj6m/O4ih1Yo7dTCBbATpZXa0Z5uMNOvsKs78TsDk=;
 b=R8NJXaHK7qVWId9DYRjnDBPSr+lNkamG1rRmCVhiUbujBdN4Ff7/9WxId+g7OuGpXV
 APB0ec3oUo9dgaT9llBGAimxOsijq1dkMZlzu9uYXWI5VBTHf6oUI7I9EpbB7Javjy5q
 vnsdswFBL99fZYbUKtaF4h7CafH1fs3B87M9dJCDVcZZeOrC5ga4gC6S2o67cDc1lRqO
 OxxpD4ccABD6jtPt+2IZcNvXDYiqkJBovjYSjNAzvpSMQReSV3iZ6whXL52OMrC//Pnf
 YWxpzTXM4K4vTlSPbioYhytR2dP/MgYekONP+q0gYDW0LW/Kyx5jGnNBWxRPNz1zgy2X
 PfjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/hGNV5w54mUWwFOCaylg4MEEhR8KdArMiE/+FWKKHVJWwLpFgKkcgN18ihWgbCzvMNoYuoAUvK4olE@nongnu.org
X-Gm-Message-State: AOJu0Yzj+sj8O2QeSySRHBU1l8bHdBokb8gJR3QQ3I/jPb4hV+BEhnie
 zzvdX/XotSCvZaPYxVb8afiQNoIOy2f0uCn1witd2vWj53R5vHqmgLOszeqwxXR4QhHfj0NXKt2
 4IFpUk/jGH141ex3CKVYimvRCqBmecas=
X-Gm-Gg: AeBDieuXUtNKQSgG9ZAxqRiUfl8gT7v2Sgx6Pz0Ixsg68hHwgN7bCVJiYm8YRTdPE6z
 t4MGfnfme/wC+++NC1Ek5EWcq8m3s+RBj3/gkex+N4RyJ3Ct1P1El6zH8auW7kA7ua+h6RVOMIr
 toDw9SZSrQB4ev6tCnNOZaKKjcwABHiRVFqqf9xdpjul1+t/fPEy2WSZv6GQNwRMHm+2w1kczef
 u8vmLsS/dt7hxLtiBJSzcPu4ZyRfSg/bak+cl7T91jM+NIdl31ifrkywjYG3x+bM66OFsMh3tMa
 R0ySf3r21+zaxzgBTmFQK9Kcj/ZW6UKZ0X2XJA==
X-Received: by 2002:a05:690e:1488:b0:651:be70:9261 with SMTP id
 956f58d0204a3-651be70a3d5mr14723774d50.43.1776297614974; Wed, 15 Apr 2026
 17:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260415064838.652297-1-joel@jms.id.au>
 <20260415064838.652297-3-joel@jms.id.au>
In-Reply-To: <20260415064838.652297-3-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 09:59:47 +1000
X-Gm-Features: AQROBzAh10H2J666lb0GCx5yvb9y7q2Ax0ySsdJjd9DLduxyL27U_5ZoG9bmIUA
Message-ID: <CAKmqyKNBJVecdsq0pqEYS4nuO4B7RJDeOwunZFP6EM9u=UmnNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] hw/riscv/boot: Account for discontiguous memory
 when loading firmware
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 15, 2026 at 4:50=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> This loads firmware into the first (low) memory range,
> accounting for machines having discontiguous memory regions.

Your new riscv_boot_info_init_discontig_mem() function is unused though...

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  include/hw/riscv/boot.h    |  5 ++++-
>  hw/riscv/boot.c            | 18 ++++++++++++------
>  hw/riscv/microchip_pfsoc.c |  6 ++++--
>  hw/riscv/opentitan.c       |  6 ++++--
>  hw/riscv/shakti_c.c        |  6 +++++-
>  hw/riscv/sifive_u.c        |  3 ++-
>  hw/riscv/spike.c           |  6 ++++--
>  hw/riscv/virt.c            |  7 ++++---
>  hw/riscv/xiangshan_kmh.c   |  6 +++++-
>  9 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 115e3222174f..fb90bf12399e 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -53,13 +53,16 @@ void riscv_boot_info_init_discontig_mem(RISCVBootInfo=
 *info,
>  vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
>                                     hwaddr firmware_end_addr);
>  hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    RISCVBootInfo *info,
>                                      const char *default_machine_firmware=
,
>                                      hwaddr *firmware_load_addr,
>                                      symbol_fn_t sym_cb);
>  const char *riscv_default_firmware_name(RISCVHartArrayState *harts);
>  char *riscv_find_firmware(const char *firmware_filename,
>                            const char *default_machine_firmware);
> -hwaddr riscv_load_firmware(const char *firmware_filename,
> +hwaddr riscv_load_firmware(MachineState *machine,
> +                           RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                             hwaddr *firmware_load_addr,
>                             symbol_fn_t sym_cb);
>  void riscv_load_kernel(MachineState *machine,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 9babb85b0458..f3857e984240 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -145,6 +145,7 @@ char *riscv_find_firmware(const char *firmware_filena=
me,
>  }
>
>  hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    RISCVBootInfo *info,
>                                      const char *default_machine_firmware=
,
>                                      hwaddr *firmware_load_addr,
>                                      symbol_fn_t sym_cb)
> @@ -157,7 +158,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *mac=
hine,
>
>      if (firmware_filename) {
>          /* If not "none" load the firmware */
> -        firmware_end_addr =3D riscv_load_firmware(firmware_filename,
> +        firmware_end_addr =3D riscv_load_firmware(machine, info,
> +                                                firmware_filename,
>                                                  firmware_load_addr, sym_=
cb);
>          g_free(firmware_filename);
>      }
> @@ -165,10 +167,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *m=
achine,
>      return firmware_end_addr;
>  }
>
> -hwaddr riscv_load_firmware(const char *firmware_filename,
> +hwaddr riscv_load_firmware(MachineState *machine,
> +                           RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                             hwaddr *firmware_load_addr,
>                             symbol_fn_t sym_cb)
>  {
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      uint64_t firmware_entry, firmware_end;
>      ssize_t firmware_size;
>
> @@ -183,7 +188,7 @@ hwaddr riscv_load_firmware(const char *firmware_filen=
ame,
>
>      firmware_size =3D load_image_targphys_as(firmware_filename,
>                                             *firmware_load_addr,
> -                                           current_machine->ram_size, NU=
LL,
> +                                           mem_size, NULL,
>                                             NULL);
>
>      if (firmware_size > 0) {
> @@ -197,7 +202,7 @@ hwaddr riscv_load_firmware(const char *firmware_filen=
ame,
>  static void riscv_load_initrd(MachineState *machine, RISCVBootInfo *info=
)
>  {
>      const char *filename =3D machine->initrd_filename;
> -    uint64_t mem_size =3D machine->ram_size;
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      void *fdt =3D machine->fdt;
>      hwaddr start, end;
>      ssize_t size;
> @@ -243,6 +248,7 @@ void riscv_load_kernel(MachineState *machine,
>                         bool load_initrd,
>                         symbol_fn_t sym_cb)
>  {
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      ssize_t kernel_size;
>      void *fdt =3D machine->fdt;
> @@ -274,7 +280,7 @@ void riscv_load_kernel(MachineState *machine,
>      }
>
>      kernel_size =3D load_image_targphys_as(kernel_filename, kernel_start=
_addr,
> -                                         current_machine->ram_size, NULL=
, NULL);
> +                                         mem_size, NULL, NULL);
>      if (kernel_size > 0) {
>          info->kernel_size =3D kernel_size;
>          info->image_low_addr =3D kernel_start_addr;
> @@ -370,7 +376,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwa=
ddr dram_size,
>      dtb_start =3D QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
>
>      if (dtb_start_limit && (dtb_start < dtb_start_limit)) {
> -        error_report("No enough memory to place DTB after kernel/initrd"=
);
> +        error_report("Not enough memory to place DTB after kernel/initrd=
");
>          exit(1);
>      }
>
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 743f31f00578..1d1ddb05a882 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -618,18 +618,20 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>          firmware_load_addr =3D RESET_VECTOR;
>      }
>
> +    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);

The Microchip board has high and low memory, so you should use your
new riscv_boot_info_init_discontig_mem() function here.

Alistair

