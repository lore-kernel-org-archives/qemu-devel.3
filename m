Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278A6C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 04:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOTqq-000323-Pi; Mon, 09 Jun 2025 00:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTqm-00031l-Bq; Mon, 09 Jun 2025 00:11:08 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTqk-000088-LB; Mon, 09 Jun 2025 00:11:08 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-87ed4300327so73605241.2; 
 Sun, 08 Jun 2025 21:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749442265; x=1750047065; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWghqZmTEEdtbZHCe8oisQ0794XSXS7tj1zZcQw0FqQ=;
 b=lOZhlF5Zb6p2u9KjnwD080dlXus0d8nDq+uK8QEsi4LrqCDlIGuuQknm1PPRfI/+CP
 47YShMrDM9mSTRXLQfYV5wXR92FN9RlWQiA76P168DNbNzSu6cvztn3bpvtlNA4gYdqE
 u4a5eJcfz+YXB7OM3ADKkCdZM2KB/r3DrzHvKAub+FsVN4YcVPGi8lUlrKtiEy+fHf5d
 M6292lO7ew9InyzdJteB4Uns/em4stCIHGGpfjOSAK5lqc63nbxX1ohACyaLK2EqEjAE
 V9rEfE4ECJ3uVOhr32pouZ5qsbZR5BdaVIJyIwdwCqhqRee4rbhv+7tUl1/ZSSYzHMSr
 DDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749442265; x=1750047065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWghqZmTEEdtbZHCe8oisQ0794XSXS7tj1zZcQw0FqQ=;
 b=UMcGSFSAnH8+st9pRcyo+aiw9DVkNu0EXoG95XUXaQYhswDCXoJNGa6EDAdUYkXbQC
 zS3kjOlLhjtCRp2821K6MwTI4TqI4sm+aRLfIhPvf7SJXsgMKK/getA8a2A0mSVX/un2
 He85UIIlJHXOjvLe3mswTxWuM2RUmkcy4teZekRKFNl4iekFFycE8jhn7OyCu2UXR8N3
 DFp601S+FrntyqyEx8eQTgMFVL5V5Nm5uG7RvM3kQe0ga3eC5JCPSrjum7wiPNTh8A6k
 88SWcNLKDmB3eduQTpA1/V8x4XR2pygBx5Se11z58tCAtaZnLf3W1Haey7WNCWw3BWsF
 /KbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnAbjZ5zh0RqDgRuO7hduE51zTYqGxibL+FZnn5CgYjw1eSY2hS88K/rfiAHxbLQWi/5PvPFar41z8@nongnu.org,
 AJvYcCWLTHA5djyu4vqKj5LKfT7IqewRF1MzW8Eyxe73RARM0T4tqMjPCiQ1QG0YSfjKOIU5ipFIReaPslGVdw==@nongnu.org
X-Gm-Message-State: AOJu0YyNosp81McjsCYRrtySYmtdED+DZ8Uw77e64EL0Zf40VWYFFLLL
 UA5i5b4aM2NFrw/0Xsy4XxSb23Oy8OWjWgpLe8BSm4C5YVBsF0oKtOX25+COl7c0lq/XHhMrLFm
 3urQg9xRpEIrAtORn05ScLyI/W4pu1PJHzw==
X-Gm-Gg: ASbGncv4OA3y6xV61zi13buYaqcW4UvyaY5/USbBdhcrNQQYfFh+EKQVHI5d5hlKEB3
 QPzgjwfjCkxRaIe2ORO6G220udakn1QQNbM/qRZ/jsW4OCDQUmfEvOSZUlUywqVEIoKp17E0Jkp
 f9/FArpA8GLmxXov0CzgXgy/unVlgakJMiRbSnDieoy2OkoT6PZlt8FQNDDA3g7FSNrOvzQVgLr
 A==
X-Google-Smtp-Source: AGHT+IFX4jllI2Ae3+LefjkUJ9epbbDPNI7grP9hrAtrU7pjUj6Z7i7AbhD9RyO++FFULjys29rCFLZJTH9xl2921ZE=
X-Received: by 2002:a05:6102:41ab:b0:4e6:f86b:141f with SMTP id
 ada2fe7eead31-4e772978e16mr9442812137.12.1749442265077; Sun, 08 Jun 2025
 21:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1749224867.git.chao.liu@yeah.net>
 <e4750730e723642922021767946bf277765201a1.1749224867.git.chao.liu@yeah.net>
In-Reply-To: <e4750730e723642922021767946bf277765201a1.1749224867.git.chao.liu@yeah.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 14:10:39 +1000
X-Gm-Features: AX0GCFttifY-AqEwqGdI7z8tthazKAWWyCfXv5BIltU-2I7YnPIkmr52YmP37Ec
Message-ID: <CAKmqyKN6dL6-qXGzHqxrHfBBC34YrD-HwhLyb8RdTqdw6KsrmA@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
To: Chao Liu <chao.liu@yeah.net>
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com, 
 zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhangtj@tecorigin.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <lc00631@tecorigin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Sat, Jun 7, 2025 at 12:13=E2=80=AFPM Chao Liu <chao.liu@yeah.net> wrote:
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/sifive_plic.c      | 4 ++--
>  hw/riscv/boot.c            | 4 ++--
>  hw/riscv/microchip_pfsoc.c | 2 +-
>  hw/riscv/sifive_u.c        | 2 +-
>  hw/riscv/virt.c            | 2 +-
>  include/hw/riscv/boot.h    | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
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
> index d69f942cfb..c89dac0f21 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -829,7 +829,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Er=
ror **errp)
>                                  l2lim_mem);
>
>      /* create PLIC hart topology configuration string */
> -    plic_hart_config =3D riscv_plic_hart_config_string(ms->smp.cpus);
> +    plic_hart_config =3D riscv_plic_hart_config_string(0, ms->smp.cpus);
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
> 2.49.0
>
>

