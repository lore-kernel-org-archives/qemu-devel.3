Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D0CD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKGm-0000pf-8F; Mon, 15 Jun 2026 23:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKGk-0000p8-2E
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:15:18 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKGh-0001yb-Jq
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:15:17 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so6184917a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781579713; cv=none;
 d=google.com; s=arc-20240605;
 b=O539fpQ5tQVwN/NiywFfwpvWhyT4nmiS8UvXvoNws4wNaWQXrOMmm7JQT6kbjmvjff
 T/+m93sTpqhYLL2oE6xFc6sWgkDzsfcJp1mWoMgzA8ZMFGQgbFpKAewuKRLv7eakhH3m
 9nLDYGupaQFtLAqDBEKUIZ8x2PeFOvYlfZh7xfcVwkpduQmUfzscFl81QKS7/Z0oFUFc
 /ercPIAXIk5Aw4S4Hby063T/ROQa1G3mTo3t1hbpWtinwhhXOMPpTzNI3O+1deLsbyfB
 C5Gs08W00UxkGhajhTSMhXDvMzY7eeX9BmE3s49HJ16ZbnozGZdLumEO2Oke8e+Q5EMP
 Q/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2//7fekKtdDPkgBvtLRGOmWSThEKpL0MI6l5G2YadNg=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=XgklTELhaXD5rK2UJu/hB01TshZq8wDWo3yGb+OjRgjTODiqqNyEolLUFhcGpKzDa6
 Nc/15Gcqhnkm1fhI7MMi8EgpU29jrSuMu0PkZkALt/9mGQXvHS1lnj+YNaM/tv6CFyZT
 H1bjMx30YLE94HhUdRn1NRVFcfTz/khDEc0sIGyRCs8JGM7Hbpez/cY6PXtwV7YtYNfa
 prHjUjyrbJ6peGcUa9O9Vq6fKgjAZYiNqeJ/mSjamUv1fnD30JYaKympMEsQJ011Q0nW
 P2nFjHMVsLtX5NNs7AVL9YPjJAcyY6FAoTa/fcfBU3Tqm/56WeCbGCASwskP6YH6SWit
 pY4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781579713; x=1782184513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2//7fekKtdDPkgBvtLRGOmWSThEKpL0MI6l5G2YadNg=;
 b=Edj1zrqWvf8SkGs8Xd2pkzXziB6wGUjmnQG0SdkDwO5djEg2YBCnMcIDJnqSnga74c
 JVxpd6fSo1GxNOfy2bVkwYFW8AYYtj/hNqvvmaJbRC9mlV8LEo9q4MBVeZCsSTaa1eG1
 9aJwySgxyhhLj1GNKupJIXvX55xriO8vb9qrRBqVo6sn/e+bDbOSlGnjXMhJdaCWoAyi
 jHAYzm9nxOUExfllo6HbfLD9NTDoC2jwpwHwomWhjUQC8JoeO1LLGQ3oeR1vI8FMvRbt
 /8NnIubJU+83xGHU1BGAFoA0Er3U0fZXjtkCGNIEYeSl8K3V2YbLAh42kye44qmbimt+
 pcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579713; x=1782184513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2//7fekKtdDPkgBvtLRGOmWSThEKpL0MI6l5G2YadNg=;
 b=RHTuMP35uzQWXkw8J5B5f/Sui/44QjGY8rnXcDEYzRDnilsnADmuh3aXFw36KB6hoW
 0Ai8LOIqavzkYR7uRFtFS+bdYVJhcQkZbm/Ep8VjTpPBUbt535G9py7Fxw3hPtsPjxGS
 1VpyyA7sfhFsxBBwrgbIjDSSCD0FZX3U0AfOgBAxNYNlJql7Q+pz0eawjrZmMIjnDhqC
 svXTZBT8sTTTBLkD2rQ1hw27j5o69I4SACTFJvHEcUG0Nu1wMqaNGe6QoIyUpNCrRp1Z
 +4Xi3QnbwQ+q2d7rMo/OSfXTrSgaHEqhmjxvA9o3vUc7dgDZD2cEOALPVpPRxhi0Ita+
 Hz2Q==
X-Gm-Message-State: AOJu0YzaR4/gU3IWpEkvaFoZwQkw3klO/ZMiaZmjGUBagUnMZ8vq0iGq
 lAyS+lhUaqfCDTsGKmmQx8D8b1KQvKT3C1tR6gExJwBeREdE6lJmEV+FaU1fmUAGRWFfxta+Qjp
 XonKIVSLzNjW5slZiF3r7smb99w0WzCI=
X-Gm-Gg: Acq92OGlFoql2srCVSQwgGgAcKvZZHuWmIJ9482t6Itqux9wM6b1flho05xolNeEOYT
 i5azBWwCYPUKy+KopF1bz5/mHp8smgne6rvsaEeV5tsvF/sNtQxF4CRsUN+b/Lj4x3Ggb9HWDVk
 UL6oYUUh+Kya7ZV5z11K8HTObjtC0pzFuMt4/NY20PZJxuP3LRn1ZXkINbrmyt9D3UpI4ntoEC3
 ufNiWbZPCuxa+3cmyLYinGY8eR9KNYveOAguchOiu51MUzPaFx+W7XyUz73M3yUKvORcObTTZrw
 CGHu4qTVrQkkySHCdNZcOT9VeE+YqqrDn19J//mnJZ8jMOMk
X-Received: by 2002:a05:6402:1ec7:b0:691:7054:8c6a with SMTP id
 4fb4d7f45d1cf-695087df672mr793580a12.20.1781579712706; Mon, 15 Jun 2026
 20:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-8-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-8-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:14:44 +1000
X-Gm-Features: AVVi8Cf-txzAHHbpjJBy1yrNFquJBwPseazDhfxWYZrzZWPVQnyzaC8acLSTyz4
Message-ID: <CAKmqyKOVtBTwY1Wpv5KGvEM12H6hMa1=ySfQwjK1gDrXQhC-ng@mail.gmail.com>
Subject: Re: [PATCH 07/13] hw/riscv: add create_fdt_clint() helper
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Tue, Jun 16, 2026 at 6:42=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Move all clint FDT generation to fdt-common.c reducing code repetition.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c         | 33 +++++++++++++++++++++++++
>  hw/riscv/sifive_u.c           | 25 +++----------------
>  hw/riscv/spike.c              | 31 ++++-------------------
>  hw/riscv/virt.c               | 46 ++++++-----------------------------
>  include/hw/riscv/fdt-common.h |  5 ++++
>  5 files changed, 54 insertions(+), 86 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index 719c36e001..d2661ec389 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -12,6 +12,7 @@
>  #include "system/device_tree.h"
>  #include "hw/core/boards.h"
>  #include "hw/riscv/fdt-common.h"
> +#include "target/riscv/cpu_bits.h"
>
>  void *create_board_device_tree(const char *model, const char *compatible=
,
>                                 int *fdt_size)
> @@ -50,3 +51,35 @@ void create_fdt_socket_memory(void *fdt, hwaddr addr, =
uint64_t size,
>          qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket_id);
>      }
>  }
> +
> +void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
> +                             int socket_id, uint32_t *intc_phandles,
> +                             int num_harts, bool numa_enabled)
> +{
> +    g_autofree uint32_t *clint_cells =3D g_new0(uint32_t, num_harts * 4)=
;
> +    g_autofree char *clint_name =3D NULL;
> +    static const char * const clint_compat[2] =3D {
> +        "sifive,clint0", "riscv,clint0"
> +    };
> +
> +    for (int cpu =3D 0; cpu < num_harts; cpu++) {
> +        clint_cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> +        clint_cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> +        clint_cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandles[cpu]);
> +        clint_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
> +    }
> +
> +    clint_name =3D g_strdup_printf("/soc/clint@%"HWADDR_PRIx, addr);
> +    qemu_fdt_add_subnode(fdt, clint_name);
> +    qemu_fdt_setprop_string_array(fdt, clint_name, "compatible",
> +                                  (char **)&clint_compat,
> +                                  ARRAY_SIZE(clint_compat));
> +    qemu_fdt_setprop_sized_cells(fdt, clint_name, "reg",
> +                                 2, addr, 2, size);
> +    qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
> +                     clint_cells, num_harts * sizeof(uint32_t) * 4);
> +
> +    if (numa_enabled) {
> +        qemu_fdt_setprop_cell(fdt, clint_name, "numa-node-id", socket_id=
);
> +    }
> +}
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ce86989bc8..9a791b36d6 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -105,9 +105,6 @@ static void create_fdt(SiFiveUState *s, const MemMapE=
ntry *memmap,
>      uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle =3D 1;
>      uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
>      static const char * const ethclk_names[2] =3D { "pclk", "hclk" };
> -    static const char * const clint_compat[2] =3D {
> -        "sifive,clint0", "riscv,clint0"
> -    };
>      static const char * const plic_compat[2] =3D {
>          "sifive,plic-1.0.0", "riscv,plic0"
>      };
> @@ -180,25 +177,9 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>          g_free(nodename);
>      }
>
> -    cells =3D  g_new0(uint32_t, ms->smp.cpus * 4);
> -    for (cpu =3D 0; cpu < ms->smp.cpus; cpu++) {
> -        cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> -        cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> -        cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandles[cpu]);
> -        cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
> -    }
> -    nodename =3D g_strdup_printf("/soc/clint@%lx",
> -        (long)memmap[SIFIVE_U_DEV_CLINT].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
> -        (char **)&clint_compat, ARRAY_SIZE(clint_compat));
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        0x0, memmap[SIFIVE_U_DEV_CLINT].base,
> -        0x0, memmap[SIFIVE_U_DEV_CLINT].size);
> -    qemu_fdt_setprop(fdt, nodename, "interrupts-extended",
> -        cells, ms->smp.cpus * sizeof(uint32_t) * 4);
> -    g_free(cells);
> -    g_free(nodename);
> +    create_fdt_socket_clint(fdt, memmap[SIFIVE_U_DEV_CLINT].base,
> +                            memmap[SIFIVE_U_DEV_CLINT].size, 0,
> +                            intc_phandles, ms->smp.cpus, false);
>
>      nodename =3D g_strdup_printf("/soc/otp@%lx",
>          (long)memmap[SIFIVE_U_DEV_OTP].base);
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 82005ec163..b15188fb07 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -58,13 +58,10 @@ static void create_fdt(SpikeState *s, const MemMapEnt=
ry *memmap,
>      unsigned long clint_addr;
>      int cpu, socket;
>      MachineState *ms =3D MACHINE(s);
> -    uint32_t *clint_cells;
>      uint32_t cpu_phandle, phandle =3D 1;
> -    char *clint_name, *clust_name;
> +    char *clust_name;
>      char *core_name, *cpu_name, *intc_name;
> -    static const char * const clint_compat[2] =3D {
> -        "sifive,clint0", "riscv,clint0"
> -    };
> +    bool numa_enabled =3D riscv_numa_enabled(ms);
>
>      fdt =3D ms->fdt =3D create_board_device_tree("ucbbar,spike-bare,qemu=
",
>          "ucbbar,spike-bare-dev", &fdt_size);
> @@ -136,29 +133,11 @@ static void create_fdt(SpikeState *s, const MemMapE=
ntry *memmap,
>          create_fdt_socket_memory(fdt, memaddr, memsize, socket,
>                                   riscv_numa_enabled(ms));
>
> -        clint_cells =3D  g_new0(uint32_t, s->soc[socket].num_harts * 4);
> -
> -        for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
> -            clint_cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandles[cpu])=
;
> -            clint_cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> -            clint_cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandles[cpu])=
;
> -            clint_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
> -        }
> -
>          clint_addr =3D memmap[SPIKE_CLINT].base +
>              (memmap[SPIKE_CLINT].size * socket);
> -        clint_name =3D g_strdup_printf("/soc/clint@%lx", clint_addr);
> -        qemu_fdt_add_subnode(fdt, clint_name);
> -        qemu_fdt_setprop_string_array(fdt, clint_name, "compatible",
> -            (char **)&clint_compat, ARRAY_SIZE(clint_compat));
> -        qemu_fdt_setprop_cells(fdt, clint_name, "reg",
> -            0x0, clint_addr, 0x0, memmap[SPIKE_CLINT].size);
> -        qemu_fdt_setprop(fdt, clint_name, "interrupts-extended",
> -            clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4=
);
> -        riscv_socket_fdt_write_id(ms, clint_name, socket);
> -
> -        g_free(clint_name);
> -        g_free(clint_cells);
> +        create_fdt_socket_clint(fdt, clint_addr, memmap[SPIKE_CLINT].siz=
e,
> +                                socket, intc_phandles,
> +                                s->soc[socket].num_harts, numa_enabled);
>          g_free(clust_name);
>      }
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index df3eadef78..b134f11266 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -302,42 +302,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s=
, int socket,
>      }
>  }
>
> -static void create_fdt_socket_clint(RISCVVirtState *s,
> -                                    int socket,
> -                                    uint32_t *intc_phandles)
> -{
> -    int cpu;
> -    g_autofree char *clint_name =3D NULL;
> -    g_autofree uint32_t *clint_cells =3D NULL;
> -    hwaddr clint_addr;
> -    MachineState *ms =3D MACHINE(s);
> -    static const char * const clint_compat[2] =3D {
> -        "sifive,clint0", "riscv,clint0"
> -    };
> -
> -    clint_cells =3D g_new0(uint32_t, s->soc[socket].num_harts * 4);
> -
> -    for (cpu =3D 0; cpu < s->soc[socket].num_harts; cpu++) {
> -        clint_cells[cpu * 4 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
> -        clint_cells[cpu * 4 + 1] =3D cpu_to_be32(IRQ_M_SOFT);
> -        clint_cells[cpu * 4 + 2] =3D cpu_to_be32(intc_phandles[cpu]);
> -        clint_cells[cpu * 4 + 3] =3D cpu_to_be32(IRQ_M_TIMER);
> -    }
> -
> -    clint_addr =3D s->memmap[VIRT_CLINT].base +
> -                 s->memmap[VIRT_CLINT].size * socket;
> -    clint_name =3D g_strdup_printf("/soc/clint@%"HWADDR_PRIx, clint_addr=
);
> -    qemu_fdt_add_subnode(ms->fdt, clint_name);
> -    qemu_fdt_setprop_string_array(ms->fdt, clint_name, "compatible",
> -                                  (char **)&clint_compat,
> -                                  ARRAY_SIZE(clint_compat));
> -    qemu_fdt_setprop_sized_cells(ms->fdt, clint_name, "reg",
> -        2, clint_addr, 2, s->memmap[VIRT_CLINT].size);
> -    qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
> -        clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> -    riscv_socket_fdt_write_id(ms, clint_name, socket);
> -}
> -
>  static void create_fdt_socket_aclint(RISCVVirtState *s,
>                                       int socket,
>                                       uint32_t *intc_phandles)
> @@ -728,6 +692,7 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      uint32_t xplic_phandles[MAX_NODES];
>      g_autofree uint32_t *intc_phandles =3D NULL;
>      int socket_count =3D riscv_socket_count(ms);
> +    bool numa_enabled =3D riscv_numa_enabled(ms);
>
>      qemu_fdt_add_subnode(ms->fdt, "/cpus");
>      qemu_fdt_setprop_cell(ms->fdt, "/cpus", "timebase-frequency",
> @@ -762,8 +727,13 @@ static void create_fdt_sockets(RISCVVirtState *s,
>              create_fdt_socket_aclint(s, socket,
>                                       &intc_phandles[phandle_pos]);
>          } else if (tcg_enabled()) {
> -            create_fdt_socket_clint(s, socket,
> -                                    &intc_phandles[phandle_pos]);
> +            hwaddr clintaddr =3D s->memmap[VIRT_CLINT].base +
> +                               s->memmap[VIRT_CLINT].size * socket;
> +
> +            create_fdt_socket_clint(ms->fdt, clintaddr,
> +                                    s->memmap[VIRT_CLINT].size,
> +                                    socket, &intc_phandles[phandle_pos],
> +                                    s->soc[socket].num_harts, numa_enabl=
ed);
>          }
>      }
>
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.=
h
> index 81689f418b..6e81d6cd6c 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -13,4 +13,9 @@ void *create_board_device_tree(const char *model, const=
 char *compatible,
>                                 int *fdt_size);
>  void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
>                                int socket_id, bool numa_enabled);
> +void create_fdt_clint(void *fdt, hwaddr addr, uint64_t size,
> +                      uint32_t *intc_phandles, int num_harts);
> +void create_fdt_socket_clint(void *fdt, hwaddr addr, uint64_t size,
> +                             int socket_id, uint32_t *intc_phandles,
> +                             int num_harts, bool numa_enabled);
>  #endif
> --
> 2.43.0
>
>

