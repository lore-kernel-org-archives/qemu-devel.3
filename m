Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2F7CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKFQ-00007w-Q9; Mon, 15 Jun 2026 23:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKFP-00006m-GK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:13:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKFN-0001jr-RU
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:13:55 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68bfcf11050so6893644a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781579632; cv=none;
 d=google.com; s=arc-20240605;
 b=EyrRZ2sMFZuKZe77fELnRYD3njpMSbFt85yY+1/b+Yyf2yMmznz/i4gaDkGCgaFBQX
 OhwUluWsjbBBJBxXMqA1sTcBgmgWnzBbIO90sYKOVShglpYBQPulT7xRbaNvxjNPch0a
 mRIfPn/6IR8WP6JSVCR0itzAGWoExbMVwBR8FEi5OgeduRWYswwkhNt73FOndIBzuYV8
 0LPJ/6BTmzvYUnTDXdd2DB4nBy3uv1Ni0Gi1allmDMS9TIvGGeo7DDHBU2XC71OYsjeS
 MG9iMbUjsVFl2LmIdyvhPaJuPpTocf5Jad1nuji2KY0pZKvkkJjRXaAuGjFiK5KAAdsz
 3XEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YkwaVw3MVlo9U754wm7BPYx6CRLOgvXkcJyPmfBFsxA=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=c05tsDVwsqGr0BdGjvUmDJEo2meBKj62QlkgPmt/NLPn0RVVfFlu2F9fSDBmjMpRkK
 zpm11v/nWGGDpC8e5KtvrlRsBxBklnzPfxa11bKTOds3VCpQWcOkkUVSEsOKH/AUcYRf
 KEqK3hsBQ1sP86fwl5LRTlzA17aswvVK4CJm7wAch8Y0PO6Bv0FQBBX4SnPq0ohPMqXe
 1A8H4GcCy7GIOc4sKTai1dw3R6OqHMBHhgk+8p/sHVQdwEtStAwJJUDzI/S/aua5dGuT
 LDRg4y0G92exY6+IR+Vcfk32qDWeu+venZEfG440D/XlwCMTzgECQClB/Dt2uq8Ef3kL
 tueg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781579632; x=1782184432; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkwaVw3MVlo9U754wm7BPYx6CRLOgvXkcJyPmfBFsxA=;
 b=pPeYJ5kE4sZ59KuT1355fMhIiFvMKnth2kNoOSHI8ayQ3gzm0Ca5GnfUbh8x/pudOI
 IJPKmbvYAdJxegQ/rE5f2MC9WByMLrzp9mRFPeH+USPjKB7IS2fDa+2T8qrwbgSilej/
 ZRCMNwyas4O4571aTyM1J1Ki0Im7X8AVE22kEIL4oknA/jwWZ5xiGGueFMKyd1eElb2b
 3boyCQ34/hphiAC1yZ79x49MyYSoGKaeRu1K8pCB4IAv++wLR8TnYJp7zVW9lygd/8UX
 wfsX//2JPeFpGy81obD6oW8ZRg8efXow13yX8F9THOEf89JpZZBdJAK1Wv0dYPpxOpyv
 JOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579632; x=1782184432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YkwaVw3MVlo9U754wm7BPYx6CRLOgvXkcJyPmfBFsxA=;
 b=cc0En01c5LMnYgGHlkW88VkljMySI2oz3GC5Sq7wGdFYigY/iwVc3NdWtHSrH6w4U1
 kbJfzYlAeYTEPIrR+jWj9qJ1LVq+ovHFdb4QAxW9ZumxleIJO3FUXKM3jrsvoKIB1AkI
 fp9voZ/OZ5rOQ8pYt/wLcEX1jVZhqx2V0A/3GwoQ0f37Xqnf5byPmInEgOaGlMKYGhfF
 98MPnQ4+MZiCRJLzzEa48QxG0BN8jsHCyZCY+oGck/xLoOBE2gLypJ0vWlBmnrV9a4WM
 +cCdGjAlE4FeiFCka6wAHEcAof6oJOoSnfqDYs6QwJGRVf+mfHJnZvR9v9f7azq8779k
 VD0w==
X-Gm-Message-State: AOJu0YyDt8MK3rNf+f5S7ykveZd9ZZJdMnrMIgcWF3BRQF0L2u0Uj83M
 s1ulG5OG71J3VSSn8pGBvXBQQzKAOht36kxIHZG+4hLSp3O1ahbZwFntc/ypUHM5zVWlrpdiz2T
 NuN8qVEOPoXtl7zDqcE3iNryp2jCol7s=
X-Gm-Gg: Acq92OG5n9Q3XlQLuNCug6RZcUyYgBEDTDrQW9JXsRSQtvfd6cSsJtbIBGEnfD9Lt90
 UTo2fSdVKHV2lY3KAIsYtFedYY+rWsby7n6J7yTpNss8huvr0DBw3krJot/YAHNZjvCNQAgh8SB
 Z4AjaXmSc+IvGMGRN9EnNfmf52YA113lWm1SwjsIvaA8cqzEgdbt5J+jO9daB3LpnoRMiQykyCT
 4NqeDsrAR6sLVCQTNN6R7WjSooJ865pj9u9RLn69BJa1M2OWISVcdqTl2h/MqTK8ISEDKK8orwM
 hK5Dzfg8rRU6mW23qDexTO7QzUXcfegL3/YNtw==
X-Received: by 2002:a05:6402:5208:b0:689:6c2e:6cdf with SMTP id
 4fb4d7f45d1cf-6950874bfdemr783191a12.22.1781579631925; Mon, 15 Jun 2026
 20:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-7-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-7-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:13:25 +1000
X-Gm-Features: AVVi8Cc5EIcGOjrqGMSaHgobiAJitL9LMRwuVwl5ItwGXiTuP31CiZB6H9Oyue4
Message-ID: <CAKmqyKOQuy74DmSMa+e03ZL-ifctu_qSmh6_kTCX8cnYnVSpkw@mail.gmail.com>
Subject: Re: [PATCH 06/13] hw/riscv/spike.c: add intc_phandles array
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Tue, Jun 16, 2026 at 6:38=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The clint FDT generation uses a cells array (clint_cells) that are
> populated in the middle of the loop that creates the CPU socket FDT.
> This is completely fine but it differs from the other boards that
> creates the clint cells array right before creating the clint FDT.
> 'virt' and 'sifive_u' store the intc phandles in a intc_phandles array
> during FDT CPU socket creation, and this array is used to create the
> clint FDT cells.
>
> Standardize the clint FDT creation for spike doing the same here,
> allowing us to move everything to a common helper later.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/spike.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 92facba29d..82005ec163 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -59,7 +59,7 @@ static void create_fdt(SpikeState *s, const MemMapEntry=
 *memmap,
>      int cpu, socket;
>      MachineState *ms =3D MACHINE(s);
>      uint32_t *clint_cells;
> -    uint32_t cpu_phandle, intc_phandle, phandle =3D 1;
> +    uint32_t cpu_phandle, phandle =3D 1;
>      char *clint_name, *clust_name;
>      char *core_name, *cpu_name, *intc_name;
>      static const char * const clint_compat[2] =3D {
> @@ -84,6 +84,8 @@ static void create_fdt(SpikeState *s, const MemMapEntry=
 *memmap,
>      qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
>
>      for (socket =3D (riscv_socket_count(ms) - 1); socket >=3D 0; socket-=
-) {
> +        g_autofree uint32_t *intc_phandles =3D g_new0(uint32_t,
> +                                                    s->soc[socket].num_h=
arts);
>          hwaddr memaddr =3D memmap[SPIKE_DRAM].base +
>                           riscv_socket_mem_offset(ms, socket);
>          uint64_t memsize =3D  riscv_socket_mem_size(ms, socket);
> @@ -91,8 +93,6 @@ static void create_fdt(SpikeState *s, const MemMapEntry=
 *memmap,
>          clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
>          qemu_fdt_add_subnode(fdt, clust_name);
>
> -        clint_cells =3D  g_new0(uint32_t, s->soc[socket].num_harts * 4);
> -
>          for (cpu =3D s->soc[socket].num_harts - 1; cpu >=3D 0; cpu--) {
>              cpu_phandle =3D phandle++;
>
> @@ -113,20 +113,17 @@ static void create_fdt(SpikeState *s, const MemMapE=
ntry *memmap,
>              riscv_socket_fdt_write_id(ms, cpu_name, socket);
>              qemu_fdt_setprop_cell(fdt, cpu_name, "phandle", cpu_phandle)=
;
>
> +            intc_phandles[cpu] =3D phandle++;
> +
>              intc_name =3D g_strdup_printf("%s/interrupt-controller", cpu=
_name);
>              qemu_fdt_add_subnode(fdt, intc_name);
> -            intc_phandle =3D phandle++;
> -            qemu_fdt_setprop_cell(fdt, intc_name, "phandle", intc_phandl=
e);
> +            qemu_fdt_setprop_cell(fdt, intc_name, "phandle",
> +                                  intc_phandles[cpu]);
>              qemu_fdt_setprop_string(fdt, intc_name, "compatible",
>                  "riscv,cpu-intc");
>              qemu_fdt_setprop(fdt, intc_name, "interrupt-controller", NUL=
L, 0);
>              qemu_fdt_setprop_cell(fdt, intc_name, "#interrupt-cells", 1)=
;
>
> -            clint_cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandle);
> -            clint_cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> -            clint_cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandle);
> -            clint_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
> -
>              core_name =3D g_strdup_printf("%s/core%d", clust_name, cpu);
>              qemu_fdt_add_subnode(fdt, core_name);
>              qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
> @@ -139,6 +136,15 @@ static void create_fdt(SpikeState *s, const MemMapEn=
try *memmap,
>          create_fdt_socket_memory(fdt, memaddr, memsize, socket,
>                                   riscv_numa_enabled(ms));
>
> +        clint_cells =3D  g_new0(uint32_t, s->soc[socket].num_harts * 4);
> +
> +        for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
> +            clint_cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandles[cpu])=
;
> +            clint_cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> +            clint_cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandles[cpu])=
;
> +            clint_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
> +        }
> +
>          clint_addr =3D memmap[SPIKE_CLINT].base +
>              (memmap[SPIKE_CLINT].size * socket);
>          clint_name =3D g_strdup_printf("/soc/clint@%lx", clint_addr);
> --
> 2.43.0
>
>

