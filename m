Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1320EFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 23:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEQj-0004rl-70; Wed, 29 Apr 2026 19:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIEQh-0004rF-8L
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:34:55 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIEQf-0001k2-Fp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 19:34:55 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ba699316b42so38395066b.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 16:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777505692; cv=none;
 d=google.com; s=arc-20240605;
 b=VqWsO4OmpXVQe77cz8ZX0FGQJrxKkMxGvi9KDVUquiTO8FzFo1p1jZA0Lo3dBdwKTX
 PS3Z/2bj6DC/NIOm23LozrJ+wtHQVxAVZv4LDomHPnX1WWUCvIKO7cAkg5qLvgMiAEmb
 b9lvaWlnGSfDE33dAYg6c3Z2xJLzk3Se1Nr+iohocx0XmrOnBsjmLuf9xmcUBMmT37Zc
 pkzSH+YjKtbjbS2VnMrjM53/ag4OvqpIyE1ATpnyGWit+kkUNLJ5vEhyZvyk8yfNHvCk
 HnNrw8UImMFT4sOwflbFWIEc3X6d9gEknN1FXpoOtXHlTmVDLB2oK0EsPRuSy9/FWhAT
 PX1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRpFTIshTUtRJIsim236X/XKK1X11xrkJJlh9CqlaqI=;
 fh=HvQTaN+ehH9UI39K7HVtUl3dsFAtybFn5AiT+5+G0WU=;
 b=g8B20BghUSAlpb1WZS2wiRVTDHmj96hNZqg8Qhwl57VLqLO1yAow4TF8ux7b37JhTV
 DkmwRTrpt2C7UzdkEqPoPqRChKPZgCLZp0QopLPTW2LZdqsTkKxsho44dxT40zyEpjC3
 AqApICIBGBTy4bpScZ5ea3E4dY+4lQdgpl4BJvf9gm7HknFHf7RBl0t2RHbynRjjt51t
 lY1WChzlynhAL2ShZTDEycpf1EX9btp751T2xFKCB2SgJfBGDUtwkbRxhu1uOIP4KxJv
 kGUyyhRFwCBmlJG+qT8jkJTF6h6bNG6xXixKWztJanFtoA8uKR5AVtiKDi56MxfzPvHX
 S2SQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777505692; x=1778110492; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRpFTIshTUtRJIsim236X/XKK1X11xrkJJlh9CqlaqI=;
 b=mZsX2W7npe70Rq9RD0xm1D9zZAOYlhixjZ2HBiQgSsn/d6F2sVV7lpoaK/u6rbvmNl
 USaY/oPA4ebr83oOdoYotL9H7i+lDdePO517jeg/YzGa7qcEYezzIyAuna3GplM2JgyM
 UNyQZSyXexrjYuqhn6WEpNQHsuucWyy+JJSrRGLgpqvI4kExCcvhaNenHTqJgj91o6QX
 +hT2K1D35fD9zNSmbYFXx0+nqW7lYn4/50IdqOSH6OQvfICpY0y4FLLsURRKJgpnaHUQ
 9wBnNqWPhcBaPK0/zlu6ergPr1Qat5hngKHu79jcCfriXsM2rMxdX/9Ftb8fxJRDAbP+
 dzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777505692; x=1778110492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRpFTIshTUtRJIsim236X/XKK1X11xrkJJlh9CqlaqI=;
 b=pCFPOLmHvgA87MxIOQo4cqHYMQWVV931Ag3nytFMPJ41uZakWFEFoAiBlfqHGBXQNt
 D4CJxpYr5S4RQCrx3vmxAFptfMihoQ++33x4jlPnusORrtlJWcwQJB3HLIcbas1/YG50
 RnCFsDRKKKq0Hx3v0q6So8Exiolig3OQi+RMyq6/w6Y8Qu9R2HnDqgkZvX4dYtHxJFkt
 tDlVBJJ/9NlU9gexV0A0EQveHGib8kPZQfe0pEpIgahBI8+TzOQMXN8XdCxBpJL2Vroi
 aDH0RjXDgvU4Q4ql+nWaoKdKP9wXFQp9+EnscbsGtcV0zV4O/j6dgLKLcbQpumTEDq+8
 vdrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HTLrtlO/M6xcow/d9ed9AqyyQJhxNUvxXHgJohdUsI3/GCM8zFnX2khPgrwPdlaVz5FP9LamBAXXr@nongnu.org
X-Gm-Message-State: AOJu0YwMbb8Zeftc+5RRc/Br2e5a3ISjVQKhASwr2YFjz/LFL+WdmF9s
 e9QIEVZMMXkfN/ISpX8jE42zVbTLv6l36l0bfe1154j0vMRB+ulLz8PoKKw+dMbLdie0HjyS1ym
 aNxSvY9IFyPmsAJvhYEigTxTPNNeL8NNwcYF6
X-Gm-Gg: AeBDieuOcElV66awmVPomaBFwLwsxwEH0j1YVrrhw4CjgDIZoyCbJVJng7tRiOOhPmz
 /i9P/gon0EGUCxhQC8YniP5VayUfka3rL0JjO2LEn1AlqKlG7/Ay6WVwLCXOIwcQR+8EWcW0Jn9
 smkCjJSIgkaokuvJA0Ee6UE6T2g1elFURBotpnJiJDs4NbHMCtS0+40rviS0z4D3WYkJoL+JgB9
 H9clLfyU0gbBi30twCOM+6K+DrBF7koJ7sTWFWdj5Jm49p9WCAcJ2R4QB7b1GsfMMqm0KlULudc
 tY53UzArTDVpLlT3Chb0XJu3htRqnYIfIwK+XB2qdx2WK+eI
X-Received: by 2002:a17:907:1b29:b0:b97:c719:14d4 with SMTP id
 a640c23a62f3a-bbac7e84df9mr33465366b.29.1777505691676; Wed, 29 Apr 2026
 16:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-4-joel@jms.id.au>
In-Reply-To: <20260425131721.932250-4-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 09:34:24 +1000
X-Gm-Features: AVHnY4IHuf0fZ9wHXY1ZHgYEMsZTS4PxWHP1VWaowVgbHwrkeS3U38ME90fsv-o
Message-ID: <CAKmqyKPY0oxFzOXxZG5Mgj9qUdFiNg8wMxnCa5V0f0-Oc_sJBQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] hw/riscv/boot: Account for discontiguous memory
 when loading firmware
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Sat, Apr 25, 2026 at 11:20=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> This loads firmware into the first (low) memory range,
> accounting for machines having discontiguous memory regions.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v4: Make RISCVBootInfo *info const in riscv_load_firmware
> v3: Call riscv_boot_info_init before riscv_find_and_load_firmware in
>     sifive_u
> ---
>  include/hw/riscv/boot.h    |  5 ++++-
>  hw/riscv/boot.c            | 18 ++++++++++++------
>  hw/riscv/microchip_pfsoc.c |  6 ++++--
>  hw/riscv/opentitan.c       |  6 ++++--
>  hw/riscv/shakti_c.c        |  6 +++++-
>  hw/riscv/sifive_u.c        |  6 ++++--
>  hw/riscv/spike.c           |  6 ++++--
>  hw/riscv/virt.c            |  7 ++++---
>  hw/riscv/xiangshan_kmh.c   |  6 +++++-
>  9 files changed, 46 insertions(+), 20 deletions(-)
>
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 115e3222174f..b2ef64fb1d14 100644
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
> index 5c9547429a36..4fbc778263cf 100644
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
> +                           const RISCVBootInfo *info,
> +                           const char *firmware_filename,
>                             hwaddr *firmware_load_addr,
>                             symbol_fn_t sym_cb)
>  {
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      uint64_t firmware_entry, firmware_end;
>      ssize_t firmware_size;
>
> @@ -197,7 +202,7 @@ hwaddr riscv_load_firmware(const char *firmware_filen=
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
> @@ -212,7 +217,7 @@ hwaddr riscv_load_firmware(const char *firmware_filen=
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
> @@ -258,6 +263,7 @@ void riscv_load_kernel(MachineState *machine,
>                         bool load_initrd,
>                         symbol_fn_t sym_cb)
>  {
> +    uint64_t mem_size =3D info->ram_low_size ?: machine->ram_size;
>      const char *kernel_filename =3D machine->kernel_filename;
>      ssize_t kernel_size;
>      void *fdt =3D machine->fdt;
> @@ -289,7 +295,7 @@ void riscv_load_kernel(MachineState *machine,
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
> @@ -385,7 +391,7 @@ uint64_t riscv_compute_fdt_addr(hwaddr dram_base, hwa=
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

We should be able to use the new riscv_boot_info_init_discontig_mem() here

Alistair

