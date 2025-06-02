Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35355C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 05:46:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLxzb-00067d-Ca; Mon, 02 Jun 2025 01:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLxxJ-0005e3-Ks; Mon, 02 Jun 2025 01:43:33 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLxws-0004RN-Sd; Mon, 02 Jun 2025 01:43:25 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4a58ebece05so4233191cf.1; 
 Sun, 01 Jun 2025 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748842978; x=1749447778; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g955E9KHL1sQ4Uiohn3fKLn7O8em84aDVI3aCG8tIEY=;
 b=k0VTZuzwDtrVI/su7yd7c6+rUUk17ewPHDU8ZzLhXzPcC4qlYQ+VUrwWJV+QQ3F58f
 uGZU6PO0dtXxlnW/bIN0rj4vgNU/VxuxDo50dUcPdIJ5ZExZL2vyBjndpMFjy3uFwBtb
 txfYiCIL8HG9eyWXE8KqpRgR7NcXkSYL3sqFJr6JIjAUvxDyy4nVIKjrutHwEjQ0oy+I
 fZWimTf10NP3QCHBJMBPMWaNvfam8YN6A6ItJc7pYDeucRb+9xkdrr49hBexn7NchXH4
 0e8IJsfleishVEOnOgNaXfASlq5qiJ9lJbpwjJAcorMgZFVQZWlrgg4imvtXxJ0UKtxw
 G2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748842978; x=1749447778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g955E9KHL1sQ4Uiohn3fKLn7O8em84aDVI3aCG8tIEY=;
 b=mF2k7/HD5/Iz/744mtLp+tlNqOiiwCLQMqT07eK9nbjTuj8XUuxXzmaf7/X5oI6k5y
 x4DJ/1upM3UxNdNyan6vcKjHDT97mfbeQFctuzbt6xk0o5WhvvM8iyNvDyZLVO5NgfJ5
 kYrPIYFQG0TDmfTwrk7HY7JKSNqV/a61WVREE1ZyB32+NdV9wNtmzRbojupwdMOeNnB/
 4AQZRTi3XKiINxph1VnrbGVrhno5tw/YT3RaNVhk7c2816jG2XkoBYNisqbhmp4C1ph2
 67XL1tTmR9hEbA89K6hnJWCmPrEoWXO6AycenlST38CA8v9u6KJ5lQGBmtVJtkE2Pc1d
 A4XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8sZ6Z+geoI1lwKwHi6bQqefkenlASd99veBi1hNk795Cl9AwA3rfVvKFvznuvd+OGzbUymMq3h/sqOQ==@nongnu.org,
 AJvYcCWztftL4tmpqF5WL6Q6292EJ9SSjcO7qoWl9iC2imH1zUibnFgcEIsNoAgQEQUdHuAUIrSgbJDPyCjw@nongnu.org
X-Gm-Message-State: AOJu0YyyUNwC6+fsyDwPrCHheTOkoSwYatOPUXYdLnMU9tjAyEJEaReG
 oXQ1FAtGoC7eAW09mzRTGvhLLKQybTqLJAlzSjdvFiLR7ptuirCJz13U+DGHw1h4W5XTA1zK5cM
 QKV3i31JsUBIY8v4aY0xg0Nw9TwpIn1RZMQ==
X-Gm-Gg: ASbGnctv/L/P9B1qXHMP797OiqlzyiP7ahbUpb1pUsyxoFMSIYpZZMkUGo0n8qNvlZt
 BO+yQviP8uCXGxgdvRT9zT4LmUFiV7VT9ZkvpRnuf9WwZfyEpTG8QMaKOy+o59foAGP76fWg/ou
 KTEWSHrzsiN4yW7GMleTlh7tUF5VbT5kCaLfCT7cYXmLDqAEGeSxb9Y8H//T6c6jI=
X-Google-Smtp-Source: AGHT+IHg/pJOwo6D5qOASIxiAx9EZINNmWEI/5ZqI3s2htX1tapw/0HkDGF9q61qVRgnnYAhw5TyW6R5qnPkJwE9YeE=
X-Received: by 2002:a05:6102:512b:b0:4e5:8eb6:e8f5 with SMTP id
 ada2fe7eead31-4e6ecd2e78cmr8428119137.3.1748838250327; Sun, 01 Jun 2025
 21:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1747878772.git.lc00631@tecorigin.com>
 <3c7b570e2bb697dda770b4b82cd4adfeac2f189c.1747878772.git.lc00631@tecorigin.com>
In-Reply-To: <3c7b570e2bb697dda770b4b82cd4adfeac2f189c.1747878772.git.lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 14:23:44 +1000
X-Gm-Features: AX0GCFuYxbO0nUWi4dmh5PUITeyGVEGTFX27pSkuOQ4R-Ob_mu_vxhP5PPsotXI
Message-ID: <CAKmqyKOAnqty4X4YwX2E3iKATO5oKg1Cb8fZi+ze+ntievcr=Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <lc00631@tecorigin.com>
Cc: palmer@dabbelt.com, zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zhangtj@tecorigin.com, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x830.google.com
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

On Thu, May 22, 2025 at 12:29=E2=80=AFPM Chao Liu <lc00631@tecorigin.com> w=
rote:
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
> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
> Reviewed-by: Alistair Francis <alistair23@gmail.com>

Should be:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Otherwise applied

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
> index 3160b216fd..8e7ebc0655 100644
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
> index 828a867be3..aa775e846c 100644
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
> index 2e74783fce..6c0e3b22af 100644
> --- a/hw/riscv/microchip_pfsoc.c
> +++ b/hw/riscv/microchip_pfsoc.c
> @@ -274,7 +274,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *=
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
> index d69f942cfb..5f94b8d703 100644
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
> index cf280a92e5..d094bd186b 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1289,7 +1289,7 @@ static DeviceState *virt_create_plic(const MemMapEn=
try *memmap, int socket,
>      g_autofree char *plic_hart_config =3D NULL;
>
>      /* Per-socket PLIC hart topology configuration string */
> -    plic_hart_config =3D riscv_plic_hart_config_string(hart_count);
> +    plic_hart_config =3D riscv_plic_hart_config_string(base_hartid, hart=
_count);
>
>      /* Per-socket PLIC */
>      return sifive_plic_create(
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

