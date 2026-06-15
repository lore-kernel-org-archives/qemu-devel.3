Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AEACD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYyxK-0004y4-M3; Mon, 15 Jun 2026 00:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYyxI-0004xS-Hf
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:29:48 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYyxG-0006KU-6h
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:29:48 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so2417810a12.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 21:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781497784; cv=none;
 d=google.com; s=arc-20240605;
 b=JrUtom51im3pyQiaUkoJWdx8w/IaFoM/s75+Q5Hslk1J6qNb5ySVYpjMKL3IIDFRPS
 HuwHXi9Eg1W1eIhh+QbjSbiN5YTo1/RLnr1ZtOw84h3y3jA1/NeKBvVq9mO3fOOCJEl+
 MS3/zSxBM+ZPXFOSML2Sf3Tqr8HfIx3X3gtwTHsgdcLiCNeDMwoq/mpmtZeT4SUS2Ni8
 CxM9hhjgi/O+Z92/Mm3Yh5xKWtERzafLYz3j4rpoamJvLwRZP8a9BIC8LgWo+k4Ap/CR
 VxEOjO+eGE1r2og6CE8VLOeMPlSQcoRp6Pbj/TZABnUWIuXDm8znBpJusNvMmK5kdye4
 LlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gFqejJaxH/UvyuwwpK6EEHKyQW1NIj+WmBmMhOfmv4Y=;
 fh=bVjlwCpxs/IStbH73oi+SAjGbb5KLxYE1lW4m/d5Smc=;
 b=RBKdGGz0jMM9zHwImtU0YtXnDZnQw5AvJ0OZvWlZFqYpc1JK32kPGdxNKJlDwy2VMU
 NEo17Ym/hx7Rt7XrAuK10YNKHc8V/rJu6YKSjzqPiBII7rbErFke48/4dzyoryg+yw9S
 3tvH62/sgKogzoeBDgrNvp0TDFr+vnA4R/cCy42PaQNreJoZFTxPr8f5z3LjAxvIvQSP
 5xsFGsE46G68CGzzrJwP9FfuZ+kG6c7k1ro6QBAk70F0pGCKEYwkjTUbp1dEhDnLAi3e
 q4ZNe1Taj91XFTqwA4GQfmfjRxZ1g22qAyl439M1b9qlimqQvadGf08t3ZOSPoGx2xlz
 rvsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781497784; x=1782102584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFqejJaxH/UvyuwwpK6EEHKyQW1NIj+WmBmMhOfmv4Y=;
 b=B54kZUm2uATdohoNEzOdwTHOO0E1+hi9XbmIi+FgkI7ARagPr5WMV4qSxSONqjVJpA
 tc7WzjJNksw9rN/Dw2qKG9zh1DzGfQya1IE9gx6mq5Nj7PVnAvQ8DVR/0xmU//Zw2nac
 QHg6U405+prJxbmnZwGXg209Ie6VU0J1MukXTu0GX8LuzWu/wx+os/s1AVDv6we5zjU9
 KaU1qOVdfCKT/CreWrtv3HrkMfRIrvr0VulN+upxS3MnxwbsUV1/aXS/xLLWaP+yuM75
 VfZIBN1YEJnr1M3pyik25qlEb0oHgimq+ENfToyExlEpwvAZ1+K9+MVc0O0IIiDJ920q
 z8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781497784; x=1782102584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gFqejJaxH/UvyuwwpK6EEHKyQW1NIj+WmBmMhOfmv4Y=;
 b=Fmq5DTp7M/+wofgg6Ivn7PRAFUs8SVUFWnkmLHRU1fv99kzEkhKdyr+t03gyGigCgY
 cz4zHNt2fq68a0r+ntxSgQdrjW9hqStlnDc8qFNSt0gfaUDVLzpwHyerkZzLBeeBDK0+
 Ex638e53BZWy6NqO2yAs1Bcrj33CabXJbvSoVoSAELa0Q+0luG++PW00oaaxies4CErf
 9B3YUwDGbNU5Gterf0gGwzwRndgl7JhURAaB2xPdVYR5OgZxg0NyiODD83ywtlha6YpS
 CQTZh1PPVMg6vfFdIHiq4/KA31pI0Ba2Cam0BS4inTcv1pI9lJ6ZQWF1N90Yb/UEcN0N
 bfug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6rnyY2B7XBFwuhchmKlEnuriW0x8BsWjqUBiF8SNXb3TN/+bnjhteEcqaS6LMH2Xs8ogF4vtS7Xns@nongnu.org
X-Gm-Message-State: AOJu0YzmSwwHY5+pXlSO5esHkg6Twb4aZxP6SXG5LF0GWh2sctbFrOQN
 wnE5+riPV/sjarKgDcTT+Sok6i5+kLc+HfA+488ks1zq8LHnWrN9MoFLTqUmr6CtBQxiNAXpTCA
 5uiJaQdLHOrrYOiCKoWUXp0O1Z9w96bA=
X-Gm-Gg: Acq92OEV+Sxh7jmgnLzGr4ejRQetChB2PMGb8h+luT5RfVZpc1yxse8TLvr29QMfYB7
 QyaTnsTv527JJYokePfful8E8b4N9fw78ln44esBXKMejiruNYtSz3CKWdliczRKwPCAND2KWkP
 SuDcLcMjtsiDkK4hbfYQe26+pjV9wI+N3mdxK+gD0ybTITabh7UaZwovTYwrmo5JcKWedSArKT+
 fwd9755+O7hj/btaYhgA3EsbTPZoHsewwjmn3G0WhTiTyjH+BlulgvGMBW0lw5pbGX7Uy2tanMT
 jmD0QgiF4w+pmP9fOUDMbSAzCfLeOcunyJZgUg==
X-Received: by 2002:a05:6402:5405:b0:68b:f026:f381 with SMTP id
 4fb4d7f45d1cf-693787ed75bmr5181365a12.8.1781497784462; Sun, 14 Jun 2026
 21:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-3-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-3-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 14:29:17 +1000
X-Gm-Features: AVVi8CfBXypda9cxvDV2C8oHqDSWWWIkV50v4MHy0SjnZlpOstNWHsksRKE1W6A
Message-ID: <CAKmqyKNN1PtHT7DY5n_r4acBcCp3heSm2w_G8GgqPnvqWP5CtA@mail.gmail.com>
Subject: Re: [PATCH v8 02/12] hw/riscv/boot: Account for discontiguous memory
 when loading firmware
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Jun 3, 2026 at 4:59=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> This loads firmware into the first (low) memory range,
> accounting for machines having discontiguous memory regions.
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/boot.h    |  5 ++++-
>  hw/riscv/boot.c            | 18 ++++++++++++------
>  hw/riscv/microchip_pfsoc.c |  8 ++++++--
>  hw/riscv/opentitan.c       |  6 ++++--
>  hw/riscv/shakti_c.c        |  6 +++++-
>  hw/riscv/sifive_u.c        |  6 ++++--
>  hw/riscv/spike.c           |  6 ++++--
>  hw/riscv/virt.c            |  7 ++++---
>  hw/riscv/xiangshan_kmh.c   |  6 +++++-
>  9 files changed, 48 insertions(+), 20 deletions(-)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 69c99a149613..4e7bd9a225ef 100644
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
> +                           const RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                             hwaddr *firmware_load_addr,
>                             symbol_fn_t sym_cb);
>  void riscv_load_kernel(MachineState *machine,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index b1a020b58aed..b0a2e384b1ae 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -150,6 +150,7 @@ char *riscv_find_firmware(const char *firmware_filena=
me,
>  }
>
>  hwaddr riscv_find_and_load_firmware(MachineState *machine,
> +                                    RISCVBootInfo *info,
>                                      const char *default_machine_firmware=
,
>                                      hwaddr *firmware_load_addr,
>                                      symbol_fn_t sym_cb)
> @@ -162,7 +163,8 @@ hwaddr riscv_find_and_load_firmware(MachineState *mac=
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
> @@ -170,10 +172,13 @@ hwaddr riscv_find_and_load_firmware(MachineState *m=
achine,
>      return firmware_end_addr;
>  }
>
> -hwaddr riscv_load_firmware(const char *firmware_filename,
> +hwaddr riscv_load_firmware(MachineState *machine,
> +                           const RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                             hwaddr *firmware_load_addr,
>                             symbol_fn_t sym_cb)
>  {
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      uint64_t firmware_entry, firmware_end;
>      ssize_t firmware_size;
>
> @@ -202,7 +207,7 @@ hwaddr riscv_load_firmware(const char *firmware_filen=
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
> @@ -217,7 +222,7 @@ hwaddr riscv_load_firmware(const char *firmware_filen=
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
> @@ -263,6 +268,7 @@ void riscv_load_kernel(MachineState *machine,
>                         bool load_initrd,
>                         symbol_fn_t sym_cb)
>  {
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      ssize_t kernel_size;
>      void *fdt =3D machine->fdt;
> @@ -294,7 +300,7 @@ void riscv_load_kernel(MachineState *machine,
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
> @@ -390,7 +396,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwa=
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
> index 5e48a2970838..4017129c8304 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -619,18 +619,22 @@ static void microchip_icicle_kit_machine_init(Machi=
neState *machine)
>          firmware_load_addr =3D RESET_VECTOR;
>      }
>
> +    riscv_boot_info_init_discontig_mem(&boot_info, &s->soc.u_cpus,
> +                                       memmap[MICROCHIP_PFSOC_DRAM_LO].b=
ase,
> +                                       mem_low_size);
> +
>      /* Load the firmware if necessary */
>      firmware_end_addr =3D firmware_load_addr;
>      if (firmware_name) {
>          char *filename =3D riscv_find_firmware(firmware_name, NULL);
>          if (filename) {
> -            firmware_end_addr =3D riscv_load_firmware(filename,
> +            firmware_end_addr =3D riscv_load_firmware(machine, &boot_inf=
o,
> +                                                    filename,
>                                                      &firmware_load_addr,=
 NULL);
>              g_free(filename);
>          }
>      }
>
> -    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
>      if (machine->kernel_filename) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
>                                                           firmware_end_ad=
dr);
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index c8b2f028f237..5b2f33d5acac 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -100,12 +100,14 @@ static void opentitan_machine_init(MachineState *ma=
chine)
>      memory_region_add_subregion(sys_mem,
>          memmap[IBEX_DEV_RAM].base, machine->ram);
>
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
>      if (machine->firmware) {
>          hwaddr firmware_load_addr =3D memmap[IBEX_DEV_RAM].base;
> -        riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL=
);
> +        riscv_load_firmware(machine, &boot_info, machine->firmware,
> +                            &firmware_load_addr, NULL);
>      }
>
> -    riscv_boot_info_init(&boot_info, &s->soc.cpus);
>      if (machine->kernel_filename) {
>          riscv_load_kernel(machine, &boot_info,
>                            memmap[IBEX_DEV_RAM].base,
> diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
> index b1823a312508..835b1f879b7f 100644
> --- a/hw/riscv/shakti_c.c
> +++ b/hw/riscv/shakti_c.c
> @@ -46,6 +46,7 @@ static void shakti_c_machine_state_init(MachineState *m=
state)
>  {
>      ShaktiCMachineState *sms =3D RISCV_SHAKTI_MACHINE(mstate);
>      MemoryRegion *system_memory =3D get_system_memory();
> +    RISCVBootInfo boot_info;
>      hwaddr firmware_load_addr =3D shakti_c_memmap[SHAKTI_C_RAM].base;
>
>      /* Initialize SoC */
> @@ -58,8 +59,11 @@ static void shakti_c_machine_state_init(MachineState *=
mstate)
>                                  shakti_c_memmap[SHAKTI_C_RAM].base,
>                                  mstate->ram);
>
> +    riscv_boot_info_init(&boot_info, &sms->soc.cpus);
> +
>      if (mstate->firmware) {
> -        riscv_load_firmware(mstate->firmware, &firmware_load_addr, NULL)=
;
> +        riscv_load_firmware(mstate, &boot_info, mstate->firmware,
> +                            &firmware_load_addr, NULL);
>      }
>
>      /* ROM reset vector */
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 6a637e3b86c4..3b2763de1684 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -590,11 +590,13 @@ static void sifive_u_machine_init(MachineState *mac=
hine)
>          break;
>      }
>
> +    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
> +
>      firmware_name =3D riscv_default_firmware_name(&s->soc.u_cpus);
> -    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, &boot_in=
fo,
> +                                                     firmware_name,
>                                                       &start_addr, NULL);
>
> -    riscv_boot_info_init(&boot_info, &s->soc.u_cpus);
>      if (machine->kernel_filename) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
>                                                           firmware_end_ad=
dr);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index f9d00e0d5c48..8d68b4e235dd 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -282,9 +282,12 @@ static void spike_board_init(MachineState *machine)
>          }
>      }
>
> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
> +
>      /* Load firmware */
>      if (firmware_name) {
> -        firmware_end_addr =3D riscv_load_firmware(firmware_name,
> +        firmware_end_addr =3D riscv_load_firmware(machine, &boot_info,
> +                                                firmware_name,
>                                                  &firmware_load_addr,
>                                                  htif_symbol_callback);
>          g_free(firmware_name);
> @@ -294,7 +297,6 @@ static void spike_board_init(MachineState *machine)
>      create_fdt(s, memmap, riscv_is_32bit(&s->soc[0]), htif_custom_base);
>
>      /* Load kernel */
> -    riscv_boot_info_init(&boot_info, &s->soc[0]);
>      if (machine->kernel_filename) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
>                                                           firmware_end_ad=
dr);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ce64eaaef7d9..febf49d5f149 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1458,7 +1458,10 @@ static void virt_machine_done(Notifier *notifier, =
void *data)
>          }
>      }
>
> -    firmware_end_addr =3D riscv_find_and_load_firmware(machine, firmware=
_name,
> +    riscv_boot_info_init(&boot_info, &s->soc[0]);
> +
> +    firmware_end_addr =3D riscv_find_and_load_firmware(machine, &boot_in=
fo,
> +                                                     firmware_name,
>                                                       &start_addr, NULL);
>
>      pflash_blk0 =3D pflash_cfi01_get_blk(s->flash[0]);
> @@ -1481,8 +1484,6 @@ static void virt_machine_done(Notifier *notifier, v=
oid *data)
>          }
>      }
>
> -    riscv_boot_info_init(&boot_info, &s->soc[0]);
> -
>      if (machine->kernel_filename && !kernel_entry) {
>          kernel_start_addr =3D riscv_calc_kernel_start_addr(&boot_info,
>                                                           firmware_end_ad=
dr);
> diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
> index 76417ba7aba1..384624d69ad5 100644
> --- a/hw/riscv/xiangshan_kmh.c
> +++ b/hw/riscv/xiangshan_kmh.c
> @@ -167,6 +167,7 @@ static void xiangshan_kmh_machine_init(MachineState *=
machine)
>      const MemMapEntry *memmap =3D xiangshan_kmh_memmap;
>      MemoryRegion *system_memory =3D get_system_memory();
>      hwaddr start_addr =3D memmap[XIANGSHAN_KMH_DRAM].base;
> +    RISCVBootInfo boot_info;
>
>      /* Initialize SoC */
>      object_initialize_child(OBJECT(machine), "soc", &s->soc,
> @@ -178,13 +179,16 @@ static void xiangshan_kmh_machine_init(MachineState=
 *machine)
>                                  memmap[XIANGSHAN_KMH_DRAM].base,
>                                  machine->ram);
>
> +    riscv_boot_info_init(&boot_info, &s->soc.cpus);
> +
>      /* ROM reset vector */
>      riscv_setup_rom_reset_vec(machine, &s->soc.cpus,
>                                start_addr,
>                                memmap[XIANGSHAN_KMH_ROM].base,
>                                memmap[XIANGSHAN_KMH_ROM].size, 0, 0);
>      if (machine->firmware) {
> -        riscv_load_firmware(machine->firmware, &start_addr, NULL);
> +        riscv_load_firmware(machine, &boot_info, machine->firmware,
> +                            &start_addr, NULL);
>      }
>
>      /* Note: dtb has been integrated into firmware(OpenSBI) when compili=
ng */
> --
> 2.47.3
>
>

