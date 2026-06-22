Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7ACCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 05:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbWoT-0005U6-Nq; Mon, 22 Jun 2026 01:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWoR-0005TV-2X
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 01:03:11 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWoP-0000P6-0V
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 01:03:10 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c07ea058c0cso627900066b.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 22:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782104587; cv=none;
 d=google.com; s=arc-20240605;
 b=D5XK5/A0A65Ko2q72XR9a+/KzOBxFLxkohTLRFpLolzSEjoMy1SmmvaryojWuwHm5p
 RmhwGYDeUxcknj6V65mXHT644En0FdkhdhtUPGjDzdLBuPAdQLJu6cJh2cy2nEZTuSf9
 R29Kl7DpCzcmaSelK6tr2gyEDilF10cSp+gAJjdJC9ODFnJTXpp09J9hJ4XPcp4Uzuhq
 S0Qp0ulIJtBzG++UfKSZsHazrkaqviKmAlBnhLl2t515UqLd8TJDf4rR6LUF6WKkrR1v
 iOizoGgw7UPSJZm/oN0My+pUTm8viMfBMtZePbTS8Qc1VwPNq+e3nMQ0tJD9RFBpyvR4
 1X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LZ/pK/qrosauCgvZFW7TUEv2Sjon1rM1h6qrA9dYw70=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=CaVhdCH5wpupKF9a7cf6rGo7YzYHiz38Z45WEob60ubGhGu9zD3fARyGF5olrdIIPD
 ugfG6SpOLxT/v9A5cC3B+z4yOzGR9gz3f9OScmmLkP+ug63SO8X1w3BgwMi7NuDFoxfy
 tkvMac1RD53fFI8XX5IbhZQ/0Jetr2+fNm5kW70DiS5IX6+p34h6dfhRGusHa7gaX2oV
 LVthtOrBc5xpTMNUsT/cRzmaxIXyvEZog7q8d+HjYAirUy37lQ+HdAIS3Bi1MIkppWAm
 diBl2jx+KHV0nGKEapIozILM7pJt4FX6SptKK5jRuM14D3xxmZicF4vVF9jqRoYZmvY/
 Fflg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782104587; x=1782709387; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZ/pK/qrosauCgvZFW7TUEv2Sjon1rM1h6qrA9dYw70=;
 b=USQmSVPMNyNOkzHcns6w09698GRadM+OsMMZHanhnn+A6VV9FJM8CyRACJfCoxQpFW
 lmsVt/ImiJ6xHlhfVw9xjGbXNX6xXuau/EvnowfbRpR0bPIEuCh/S0ZKYCwDzd98WgBC
 WH7n3nZUSd2AbW/mEIvJ8sNz//ry5GOX8y8uOjb2jExfr5NcV3Lx9n42J6iO7lUVfCMA
 FpMYJDnybZEw2xiNOL2yUzwXezCN/cgGBsuDrqY9IGx6OLAC9HI+lHfwgGgFM9vF6sL+
 5tneltx8osOA2rlcsSMerpsMZZOiqFUVFr16UXixZsh3vJqguKg8OK3dFXRPovLv7yH/
 qW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782104587; x=1782709387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LZ/pK/qrosauCgvZFW7TUEv2Sjon1rM1h6qrA9dYw70=;
 b=Vq1HRh4yCYJWuPRC3tLBs67t8R/dP+8xqCniWCp2ETjxP7Fokk7IPwmh0kuuysl9L/
 vmMlL6wvSzUs3dd5RfUIx2sTnRPro9dV7B4LvBREQB4Xh8cBf0ck4+1GElbsFuVh2kim
 uAsPb0+Mz+YFx4slR3dzvF73a55LDXshK6zDHe/Xt7eSpZTzBvEVJM5EYZNsD4+Yr93Y
 3josOMKQPJGzUkFDB0hRGdrGlXiIocl9C5aSzE0RQsvSwzms/6Et9+mW6YIc2fDQf+Mb
 2wDmHr5ee7g20RX4a+GLIGj15o89rUdwGpnr5/BF8S6o8orzG6jTA9gHbOtauManhMAT
 4JRg==
X-Gm-Message-State: AOJu0YyxL9IZgPBfyhRdVc73GrV6DfsphnnRgNfiW1+jUSR+YCfRGJMr
 mH3UqfBF8YZO3OButOU/0SDpV3S+N5SRFvT8SUCsoOHd40hnbo5r9GlIbezK7GaW5txgRl0+Flp
 0GG2lrHwTUJmZV0KDivNsC3MW5+1XSa0H7mBWAsY=
X-Gm-Gg: AfdE7cmi3BX+KOnG8ArHqFPtrw89jvZrQ14ZoUKvylY5L8WOPXfP2H36tTFlhr+Mr8N
 8405kXB+bLQhQpwfI/5mUuLuJ/6PDAfE/5RpWKxzEvMFwlR2kbGxrwsGO2YR22iYsKh5CKmBQiu
 xW7EEanodk+DEocgXVKbQpDgFjARnYdeAImVGKmLYLMEzs0CtqhgblHOea+pMmqwmQ2/ZDQ7AnG
 F3yyhxYUa7PE1C60fvMM4j38by4V+0fCrLcMsBqXSpVk+vMOWGpaYk/rFXHXrjFTXWh4QzenNsm
 CwlmsQBDb0uvALz4jb4ALrfIeBw=
X-Received: by 2002:a17:907:8b8a:b0:bd3:cb24:ae61 with SMTP id
 a640c23a62f3a-c0b601eaa1cmr503084366b.6.1782104586573; Sun, 21 Jun 2026
 22:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260616235939.1358663-6-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 15:02:39 +1000
X-Gm-Features: AVVi8CeMYzaLvzlFdXpH3IVCZYMDzLxyndXnJtF0DWbXJ0Gj3S0Ehjg64-BKmTc
Message-ID: <CAKmqyKP_CuDeoTYyz73jM_UiQGsUW06yLTEJsnMRSnuCQYWbxw@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/riscv: add create_fdt_plic() helper
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
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

On Wed, Jun 17, 2026 at 10:01=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Consolidate the common plic FDT code between 'virt' and sifive_u boards
> into a single place.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c         | 30 +++++++++++++++++++++
>  hw/riscv/sifive_u.c           | 34 +++++++-----------------
>  hw/riscv/virt.c               | 49 ++++++++++++-----------------------
>  include/hw/riscv/fdt-common.h |  5 ++++
>  4 files changed, 61 insertions(+), 57 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index b27ff13bca..e0e31af09b 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -200,3 +200,33 @@ create_fdt_socket_cpu_sifive(void *fdt, char *clust_=
name,
>                                     socket_id, socket_hartid_base,
>                                     phandle, intc_phandles, false, false)=
;
>  }
> +
> +void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
> +                     uint32_t plic_phandle, uint32_t int_cells,
> +                     uint32_t addr_cells, uint32_t *plic_cells,
> +                     uint32_t cells_size, uint32_t ndev_sources,
> +                     bool numa_enabled, int socket_id)
> +{
> +    g_autofree char *nodename =3D NULL;
> +    static const char * const plic_compat[2] =3D {
> +        "sifive,plic-1.0.0", "riscv,plic0"
> +    };
> +
> +    nodename =3D g_strdup_printf("/soc/interrupt-controller@%"HWADDR_PRI=
x, addr);
> +
> +    qemu_fdt_add_subnode(fdt, nodename);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", int_cells);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells", addr_cells);
> +    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
> +        (char **)&plic_compat, ARRAY_SIZE(plic_compat));
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
> +    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> +                     plic_cells, cells_size);
> +    qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
> +                                 2, addr, 2, size);
> +    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev", ndev_sources);
> +    if (numa_enabled) {
> +        qemu_fdt_setprop_cell(fdt, nodename, "numa-node-id", socket_id);
> +    }
> +    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
> +}
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 7dfc18d3ec..d923f041e0 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -100,14 +100,11 @@ static void create_fdt(SiFiveUState *s, const MemMa=
pEntry *memmap,
>      MachineState *ms =3D MACHINE(s);
>      void *fdt;
>      int cpu;
> -    uint32_t *cells;
> +    uint32_t *cells, cells_length;
>      char *nodename;
>      uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle =3D 1;
>      uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
>      static const char * const ethclk_names[2] =3D { "pclk", "hclk" };
> -    static const char * const plic_compat[2] =3D {
> -        "sifive,plic-1.0.0", "riscv,plic0"
> -    };
>      g_autofree uint32_t *intc_phandles =3D g_new0(uint32_t, ms->smp.cpus=
);
>      g_autofree char *clust_name =3D NULL;
>
> @@ -197,7 +194,8 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>      g_free(nodename);
>
>      plic_phandle =3D phandle++;
> -    cells =3D  g_new0(uint32_t, ms->smp.cpus * 4 - 2);
> +    cells_length =3D ms->smp.cpus * 4 - 2;
> +    cells =3D  g_new0(uint32_t, cells_length);
>      for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
>          /* cpu 0 is the management hart that does not have S-mode */
>          if (cpu =3D=3D 0) {
> @@ -210,26 +208,14 @@ static void create_fdt(SiFiveUState *s, const MemMa=
pEntry *memmap,
>              cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_S_EXT);
>          }
>      }
> -    nodename =3D g_strdup_printf("/soc/interrupt-controller@%lx",
> -        (long)memmap[SIFIVE_U_DEV_PLIC].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
> -                          SIFIVE_U_PLIC_INT_CELLS);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
> -                          SIFIVE_U_PLIC_ADDR_CELLS);
> -    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
> -        (char **)&plic_compat, ARRAY_SIZE(plic_compat));
> -    qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
> -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, (ms->smp.cpus * 4 - 2) * sizeof(uint32_t));
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_DEV_PLIC].base,
> -        0x0, memmap[SIFIVE_U_DEV_PLIC].size);
> -    qemu_fdt_setprop_cell(fdt, nodename, "riscv,ndev",
> -                          SIFIVE_U_PLIC_NUM_SOURCES - 1);
> -    qemu_fdt_setprop_cell(fdt, nodename, "phandle", plic_phandle);
> +
> +    create_fdt_plic(fdt, memmap[SIFIVE_U_DEV_PLIC].base,
> +                    memmap[SIFIVE_U_DEV_PLIC].size,
> +                    plic_phandle, SIFIVE_U_PLIC_INT_CELLS,
> +                    SIFIVE_U_PLIC_ADDR_CELLS, cells,
> +                    cells_length * sizeof(uint32_t),
> +                    SIFIVE_U_PLIC_NUM_SOURCES - 1, false, 0);
>      g_free(cells);
> -    g_free(nodename);
>
>      gpio_phandle =3D phandle++;
>      nodename =3D g_strdup_printf("/soc/gpio@%lx",
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fa464e644f..92c30a6f4c 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -326,39 +326,25 @@ static void create_fdt_socket_plic(RISCVVirtState *=
s,
>      int cpu;
>      g_autofree char *plic_name =3D NULL;
>      g_autofree uint32_t *plic_cells;
> -    unsigned long plic_addr;
>      MachineState *ms =3D MACHINE(s);
> -    static const char * const plic_compat[2] =3D {
> -        "sifive,plic-1.0.0", "riscv,plic0"
> -    };
> +    unsigned long plic_addr =3D s->memmap[VIRT_PLIC].base +
> +                              (s->memmap[VIRT_PLIC].size * socket);
> +    bool numa_enabled =3D riscv_numa_enabled(MACHINE(s));
> +    uint32_t cells_length;
>
> -    plic_phandles[socket] =3D (*phandle)++;
> -    plic_addr =3D s->memmap[VIRT_PLIC].base +
> -                (s->memmap[VIRT_PLIC].size * socket);
>      plic_name =3D g_strdup_printf("/soc/interrupt-controller@%lx", plic_=
addr);
> -    qemu_fdt_add_subnode(ms->fdt, plic_name);
> -    qemu_fdt_setprop_cell(ms->fdt, plic_name,
> -        "#interrupt-cells", FDT_PLIC_INT_CELLS);
> -    qemu_fdt_setprop_cell(ms->fdt, plic_name,
> -        "#address-cells", FDT_PLIC_ADDR_CELLS);
> -    qemu_fdt_setprop_string_array(ms->fdt, plic_name, "compatible",
> -                                  (char **)&plic_compat,
> -                                  ARRAY_SIZE(plic_compat));
> -    qemu_fdt_setprop(ms->fdt, plic_name, "interrupt-controller", NULL, 0=
);
>
>      if (kvm_enabled()) {
> -        plic_cells =3D g_new0(uint32_t, s->soc[socket].num_harts * 2);
> +        cells_length =3D s->soc[socket].num_harts * 2;
> +        plic_cells =3D g_new0(uint32_t, cells_length);
>
>          for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
>              plic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
>              plic_cells[cpu * 2 + 1] =3D cpu_to_be32(IRQ_S_EXT);
>          }
> -
> -        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
> -                         plic_cells,
> -                         s->soc[socket].num_harts * sizeof(uint32_t) * 2=
);
>     } else {
> -        plic_cells =3D g_new0(uint32_t, s->soc[socket].num_harts * 4);
> +        cells_length =3D s->soc[socket].num_harts * 4;
> +        plic_cells =3D g_new0(uint32_t, cells_length);
>
>          for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
>              plic_cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> @@ -366,19 +352,16 @@ static void create_fdt_socket_plic(RISCVVirtState *=
s,
>              plic_cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandles[cpu]);
>              plic_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_S_EXT);
>          }
> -
> -        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
> -                         plic_cells,
> -                         s->soc[socket].num_harts * sizeof(uint32_t) * 4=
);
>      }
>
> -    qemu_fdt_setprop_sized_cells(ms->fdt, plic_name, "reg",
> -                                 2, plic_addr, 2, s->memmap[VIRT_PLIC].s=
ize);
> -    qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",
> -                          VIRT_IRQCHIP_NUM_SOURCES - 1);
> -    riscv_socket_fdt_write_id(ms, plic_name, socket);
> -    qemu_fdt_setprop_cell(ms->fdt, plic_name, "phandle",
> -        plic_phandles[socket]);
> +    plic_phandles[socket] =3D (*phandle)++;
> +
> +    create_fdt_plic(ms->fdt, plic_addr, s->memmap[VIRT_PLIC].size,
> +                    plic_phandles[socket], FDT_PLIC_INT_CELLS,
> +                    FDT_PLIC_ADDR_CELLS, plic_cells,
> +                    cells_length * sizeof(uint32_t),
> +                    VIRT_IRQCHIP_NUM_SOURCES - 1,
> +                    numa_enabled, socket);
>
>      if (!socket) {
>          platform_bus_add_all_fdt_nodes(ms->fdt, plic_name,
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.=
h
> index 2d6b9a5d03..017278b611 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -30,4 +30,9 @@ void create_fdt_socket_cpu_sifive(void *fdt, char *clus=
t_name,
>                                    int cpu_id, int socket_id,
>                                    int socket_hartid_base, uint32_t *phan=
dle,
>                                    uint32_t *intc_phandles);
> +void create_fdt_plic(void *fdt, hwaddr addr, uint64_t size,
> +                     uint32_t plic_phandle, uint32_t int_cells,
> +                     uint32_t addr_cells, uint32_t *plic_cells,
> +                     uint32_t cells_size, uint32_t ndev_sources,
> +                     bool numa_enabled, int socket);
>  #endif
> --
> 2.43.0
>
>

