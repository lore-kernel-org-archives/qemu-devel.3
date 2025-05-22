Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB0BC54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 01:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHujI-0003Rp-Tu; Wed, 21 May 2025 21:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHujF-0003RJ-6j; Wed, 21 May 2025 21:28:14 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHujB-0002UM-8P; Wed, 21 May 2025 21:28:12 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-87be74a6e59so1276151241.0; 
 Wed, 21 May 2025 18:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747877287; x=1748482087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8RBS05c0SuNK5R75sWyDujnMFIebrtfOxp91yj5Ke4=;
 b=LcEyTHmVHHs2X8c8zej5LvSRKazJOtac+NcMvWBzdHD8z35HoqehvXkSgGAJi0R2zg
 McX7Lg/VPj2O94SjTGwt+2CtlpTzYKG6nzbAkweBls5RNIzXa/mvULv93dI1ZGIwKUsf
 OVttpkDFtKD7+WQ3Yh+KuIULaRncDzHH29X4JwH0MWzGJ5y057xCCbZdL+7E70oGgq2P
 ejbJyIILMdE8xYqkbJtrEpwJHif9o0SKXq42fbc0TEqcqu1DbEzlD+cWvr4gY4ZoNzzo
 djvWYJytt/c6z6EU5nvtQ5nFB0apWR0b7cePIL9s00fpzLKrWywvu0esYvcI9z9TixUW
 lagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747877287; x=1748482087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8RBS05c0SuNK5R75sWyDujnMFIebrtfOxp91yj5Ke4=;
 b=ROall3HTLcoGhHFGcXF09kRxMxr7OLPMri+JXM/OTzX795ThkYwIjl26j58/Yizm8l
 OG5yTSvoV5ZtF1R4IT++anUA+nlnJp2NDxmg4N3Ojy2DnO10IQ3/1e55Y6+OZhIVqpZu
 xszSboPCiHC7I4V3rXEwSFRwTzs1XHtMbQIYAB8y9Q5lqoUR27i8RHEnOfnn+/RFCdVI
 Otx8vdDvMbbxCVawlmgUHI2ko1znTx4m/GNxSe89kjRMIt7nl+hxkPaEboC0Q+EciZTc
 0n4eft/Q827UzTuf588kMspN9X6bHZuj8iaenQJdxlG3AZcUHL2pJSd7+oO+I8R9xI3l
 otmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcnQgE7gb45R00Vn56X1tnX1j0or5/cE69jjdJSyid6ICfFV3ECjzOa40RFieAemFrmf87Yp2Daioj@nongnu.org,
 AJvYcCXdHq1gc5GFmuTMf/XG69yWucFMU8fdEi2zHr1B2+V86iC24ew/452AexISd/TWY34PdtyeQSKZ9Y4pnQ==@nongnu.org
X-Gm-Message-State: AOJu0YxdzjP8aX3c8QUwMoCeF4g09yvven+iiC79MEY59KQr5Sejad0k
 004ijUW9Xiyv1YK5Bw0t/hGk9tsXFQB2bMosnj/wy+Cp7BMfeeI8lOWcrIPJiOGDecD5opSRdm0
 XW5zhweMgZ1sFgS+TDDoHxITLz7VgrMg=
X-Gm-Gg: ASbGncvEfch62U1CCYxrkpZYBDG9OrSVRcUjgYBG5Dby+DIRsoRGnxb2tnEGX5OORWP
 jwZTOrQjja1vN5jCFKsGKJDIhuUNPe8wAedUYAW6Ebwo9DyrdlSHEQC8ClVosAmXY9syM5JqSuj
 ZbcLFOy1Z+qM0TcwREo+HKOWDGRCkZpMLf9aD0eIckTzW3H3AtL6VODUh1Rd2P+6VPdK/WALBzr
 w==
X-Google-Smtp-Source: AGHT+IGRypOYMpTB00pxxvll1CXlVwCHuPJ4279E2oxYb9PyIgfTkuiSr3+guqeA54aJjP0B74J/TiVTEJbODF1QEZo=
X-Received: by 2002:a05:6102:3e13:b0:4da:e6e9:1f56 with SMTP id
 ada2fe7eead31-4dfa6c66d7emr23830891137.23.1747877287236; Wed, 21 May 2025
 18:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744779826.git.lc00631@tecorigin.com>
 <b7ba615aeef5abca603413cfd17dcaecd0b99bf1.1744779826.git.lc00631@tecorigin.com>
In-Reply-To: <b7ba615aeef5abca603413cfd17dcaecd0b99bf1.1744779826.git.lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 May 2025 11:27:41 +1000
X-Gm-Features: AX0GCFtcGLh2bmCFjwIYowhjjT9gKbgx1PGq4BW7W3SdUSRLMB3DZzgNp4Roi9E
Message-ID: <CAKmqyKPTjYOhgOL-Dr=nzvr6heinL3sPXJja2spoiGE_09Wr5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <lc00631@tecorigin.com>
Cc: palmer@dabbelt.com, zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, zhangtj@tecorigin.com, 
 zqz00548@tecorigin.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

