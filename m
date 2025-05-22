Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B756CC54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 01:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHul4-0004Xc-Ns; Wed, 21 May 2025 21:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHul2-0004VY-Sx; Wed, 21 May 2025 21:30:04 -0400
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHul0-0002as-5w; Wed, 21 May 2025 21:30:04 -0400
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4dfc11e2520so2413523137.0; 
 Wed, 21 May 2025 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747877400; x=1748482200; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHdtDyjNBPRIxapv3WRMHfDwSZu+Wz6wo11bBDhdb/0=;
 b=BPKlSVIEeyER73uyCkqIEGqpob0gcAYD8AJmcPEGc1ybJo6vehCPMeFBEgFK42NXq+
 lTHhesZLUfC/G4QmfGZY7CaXIIt75mm7KVBV3f+uvCjaet/nKwqEkrOtkvYE4DP0SF3F
 e68t5KYZR4QmDCQ1FVHM5No2I2l1Qam/hRChupTf1veO5axXYH0o1nON4mQM0hBhKNE+
 KLtkUH4S7Pc4yy5P3uoE+4oddKK3vE6Rs9ktIDAbkct/+umUkFh2d/ET2bQhNSCpYK33
 wzaD1KN30QStsrTrYJ42pck9J72pVBIrQ7r6Iju4+nxgC+xk0mOE4vT0GPeM0zY+hHQm
 Raig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747877400; x=1748482200;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHdtDyjNBPRIxapv3WRMHfDwSZu+Wz6wo11bBDhdb/0=;
 b=Ks5SBzG51f6u0MDH2LDxDTboSO43oC4CZg/zNZy80UvdJbsxpSbsxdZ9JvcVLYcwoP
 WxaLK2Fko0bldpmFIXCgqkLLmLpFC1OODNeiIQqfddNgIZG2OY8iA9/oOx+sOA9p42cS
 cdbu7CRfTBQON0FQ7DwfRJ+K5P4w3vRQKaoXeUXACyfUcij7ovBaH+0FYobKJ3PLPdyP
 ZTZW3qUX17HozkbdZ/6RFMDEip1PbWtZuX+7JqyZ2S4LNgveEJEWwE/H6t0/PlYaBMeX
 B3oHq1FeQDfHYVd+EmRG6cyk5o+OUeq60k+74IWD7K/UzLFeaZ79XJ1adD73LXZpZV6c
 nNcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJM7aQcBqPOREmxaUWA/2YE/X9PGcSJu02QarBis1Rrr+t1kGlIAx2NRJGm+0dyst3Z7iSQ0xzKb53gQ==@nongnu.org,
 AJvYcCX2gbB/pi3f2D4wEUJtf6N/+QvLlScQVLDbt/qwcspvoaZyT2s2GjZj7uwCA8Q+BWxI3JeI5pYAOdjV@nongnu.org
X-Gm-Message-State: AOJu0YwHYDAetqV9Z1Zd2Ln9RS7S8mfYVgxHwRQQjIMkWwDTlhiN06MC
 3R96lmschJv0wWhSdBM/D8Rfnt2mbewABqJBlEU70g52UlEodD9JY5cqoaRk/SQ2AZl9oE1zEWM
 D+Aef22svvQJcAk1FtwRDeBNrQCCeA0c=
X-Gm-Gg: ASbGnctndbRSKORzCOYc8XZ1ycDLcaPyHN9LnOWUmfp1lG4ecHz9WRWqaSMwn+/VSJ/
 NvGV0qAOvXP9OulTz4lwT4pnOxsM/kFlTPXphzAsTyL5nwIWBL2pbF4QFVcESNw6NRrQO+8AaBm
 UqYSxAtfXeT4DtY85cwdQ47jCN/f0emj5vrKFmrR0OVgGilP8eqMjHMDfzZgnRt/xYLMyQMuaQB
 g==
X-Google-Smtp-Source: AGHT+IEQn9i/M56gt3dXESSUfDyPFjyKGjK0HvB56ZvLsZOOMuDeJwZBz2imLDxFlXkKiaAxlRWq3v4svMfWpI97uTc=
X-Received: by 2002:a05:6102:2005:b0:4e2:82b9:b6fc with SMTP id
 ada2fe7eead31-4e282b9b862mr10657721137.16.1747877399681; Wed, 21 May 2025
 18:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744779826.git.lc00631@tecorigin.com>
 <b7ba615aeef5abca603413cfd17dcaecd0b99bf1.1744779826.git.lc00631@tecorigin.com>
In-Reply-To: <b7ba615aeef5abca603413cfd17dcaecd0b99bf1.1744779826.git.lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 May 2025 11:29:33 +1000
X-Gm-Features: AX0GCFtY8whmppx5bFeMfgjOyamoqrSsbqbxyMEDW3iJhCKaqkQj8BHTv-FBoxU
Message-ID: <CAKmqyKOr53P1peGKpkOoYOeusFsADW=A-guwpzb_5TrNyCkdhw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <lc00631@tecorigin.com>
Cc: palmer@dabbelt.com, zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zhangtj@tecorigin.com, 
 zqz00548@tecorigin.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Wed, Apr 16, 2025 at 3:20=E2=80=AFPM Chao Liu <lc00631@tecorigin.com> wr=
ote:
>
> riscv_plic_hart_config_string() when getting CPUState via qemu_get_cpu()
> should be consistent with keeping sifive_plic_realize()
> by hartid_base + cpu_index.
>
> A better approach is to use cpu_by_arch_id() instead of qemu_get_cpu(),
> in riscv cpu_by_arch_id() uses the mhartid.
>
> For non-numa or single-cluster machines, hartid_base should be 0.
>
> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

> ---
>  hw/intc/sifive_plic.c      | 4 ++--
>  hw/riscv/boot.c            | 4 ++--
>  hw/riscv/microchip_pfsoc.c | 2 +-
>  hw/riscv/sifive_u.c        | 5 +++--
>  hw/riscv/virt.c            | 2 +-
>  include/hw/riscv/boot.h    | 2 +-
>  6 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/hw/intc/sifive_plic.c b/hw/intc/sifive_plic.c
> index a5b0f6ef1b..d2aedfce78 100644
> --- a/hw/intc/sifive_plic.c
> +++ b/hw/intc/sifive_plic.c
> @@ -399,7 +399,7 @@ static void sifive_plic_realize(DeviceState *dev, Err=
or **errp)
>       * hardware controlled when a PLIC is attached.
>       */
>      for (i =3D 0; i < s->num_harts; i++) {
> -        RISCVCPU *cpu =3D RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
> +        RISCVCPU *cpu =3D RISCV_CPU(cpu_by_arch_id(s->hartid_base + i));
>          if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
>              error_setg(errp, "SEIP already claimed");
>              return;
> @@ -505,7 +505,7 @@ DeviceState *sifive_plic_create(hwaddr addr, char *ha=
rt_config,
>
>      for (i =3D 0; i < plic->num_addrs; i++) {
>          int cpu_num =3D plic->addr_config[i].hartid;
> -        CPUState *cpu =3D qemu_get_cpu(cpu_num);
> +        CPUState *cpu =3D cpu_by_arch_id(cpu_num);
>
>          if (plic->addr_config[i].mode =3D=3D PLICMode_M) {
>              qdev_connect_gpio_out(dev, cpu_num - hartid_base + num_harts=
,
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 765b9e2b1a..4cd29221c2 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -44,13 +44,13 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
>   * Return the per-socket PLIC hart topology configuration string
>   * (caller must free with g_free())
>   */
> -char *riscv_plic_hart_config_string(int hart_count)
> +char *riscv_plic_hart_config_string(int hart_base, int hart_count)
>  {
>      g_autofree const char **vals =3D g_new(const char *, hart_count + 1)=
;
>      int i;
>
>      for (i =3D 0; i < hart_count; i++) {
> -        CPUState *cs =3D qemu_get_cpu(i);
> +        CPUState *cs =3D cpu_by_arch_id(hart_base + i);
>          CPURISCVState *env =3D &RISCV_CPU(cs)->env;
>
>          if (kvm_enabled()) {
> diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> index 9c846f9b5b..5269336346 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -275,7 +275,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
dev, Error **errp)
>                                  l2lim_mem);
>
>      /* create PLIC hart topology configuration string */
> -    plic_hart_config =3D riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config =3D riscv_plic_hart_config_string(0, ms->smp.cpus);
>
>      /* PLIC */
>      s->plic =3D sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 679f2024bc..516912c4f4 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -790,10 +790,11 @@ static void sifive_u_soc_realize(DeviceState *dev, =
Error **errp)
>      MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
>      MemoryRegion *l2lim_mem =3D g_new(MemoryRegion, 1);
>      char *plic_hart_config;
> +    int hartid_base =3D 1;
>      int i, j;
>
>      qdev_prop_set_uint32(DEVICE(&s->u_cpus), "num-harts", ms->smp.cpus -=
 1);
> -    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", 1);
> +    qdev_prop_set_uint32(DEVICE(&s->u_cpus), "hartid-base", hartid_base)=
;
>      qdev_prop_set_string(DEVICE(&s->u_cpus), "cpu-type", s->cpu_type);
>      qdev_prop_set_uint64(DEVICE(&s->u_cpus), "resetvec", 0x1004);
>
> @@ -829,7 +830,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Er=
ror **errp)
>                                  l2lim_mem);
>
>      /* create PLIC hart topology configuration string */
> -    plic_hart_config =3D riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config =3D riscv_plic_hart_config_string(hartid_base, ms->=
smp.cpus);
>
>      /* MMIO */
>      s->plic =3D sifive_plic_create(memmap[SIFIVE_U_DEV_PLIC].base,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e517002fdf..41fdfd2bc8 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1280,7 +1280,7 @@ static DeviceState *virt_create_plic(const MemMapEn=
try *memmap, int socket,
>      g_autofree char *plic_hart_config =3D NULL;
>
>      /* Per-socket PLIC hart topology configuration string */
> -    plic_hart_config =3D riscv_plic_hart_config_string(hart_count);
> +    plic_hart_config =3D riscv_plic_hart_config_string(base_hartid, hart=
_count);
>
>      /* Per-socket PLIC */
>      ret =3D sifive_plic_create(
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index 7d59b2e6c6..5937298646 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -40,7 +40,7 @@ typedef struct RISCVBootInfo {
>
>  bool riscv_is_32bit(RISCVHartArrayState *harts);
>
> -char *riscv_plic_hart_config_string(int hart_count);
> +char *riscv_plic_hart_config_string(int hart_base, int hart_count);
>
>  void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *hart=
s);
>  target_ulong riscv_calc_kernel_start_addr(RISCVBootInfo *info,
> --
> 2.48.1
>

