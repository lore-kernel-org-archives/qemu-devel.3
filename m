Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEA4C48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpG8-0002qH-5k; Sun, 04 Feb 2024 22:03:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpG6-0002q5-R3; Sun, 04 Feb 2024 22:02:58 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpG4-0007QG-M3; Sun, 04 Feb 2024 22:02:58 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7d2a67daa25so1848092241.0; 
 Sun, 04 Feb 2024 19:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707102175; x=1707706975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSQiUla5+OCiZkIiVbKtQ0e/DUgVXs+u9zC0Fpskawo=;
 b=boCHdrX2wEztJjsHDj5HSd7mi04sOlh4hlvXlwdmWZAZVdAdV7JmCogRjR3OTIXp6I
 Y4s/l1q1ewiABNwVl1T88Ae3XGwF1Q6y3gpjMGuIN3wQQcPEyXRUELbXxBk61Tl38yQX
 WRypXf+alW4Tz8KgLfN/Sf/EV20tPjw506WmmJhoAuwzz8TDjaw74M1uby8ibrRvUslo
 psJ+pQOwg2nidVS/1Z/M1VtjUzTwWkEvkNNHuWiIr0dpDWWrpeQMPDZToUHbpdksf0Ku
 aSHqdpG7KmdAmMTT/N4Z9leS+zJOtTbW/VAi+Muaapkb9+1KbnerdxnrZxJbgkgOAJhl
 5nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707102175; x=1707706975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uSQiUla5+OCiZkIiVbKtQ0e/DUgVXs+u9zC0Fpskawo=;
 b=RJe8JdpN/SAb+iWatN0dwa/ODYYvKSW7DnvEsMwaGa0JUSata0Fxgh0pqOs10eOm/w
 ZXcNVh9nmTuZ2hhoAb7d9z4xhXKc9IRgGwZhlZnxvKT7ynpYW/C/BZ+ttMcyWqNBXAu9
 SLlaZLejs6QQYH+GGzqyVOoeLrz7k9MCbUAgQ7hPK0zo5GHl2RFApuepVcGxL36wojx4
 2iKsLgY/AIYymQuYFBDomXa+wu1Nt9REtkM/4QYypxE2Vfc8cVpncPAaTqGJL7jcv9SX
 WOKVLPh4J3uhYQBb7vGpZ+nMKyrV1OJIXrL9MZ+PJRDHPNHy+rF6hkdcr7GohqVoqj90
 8W/g==
X-Gm-Message-State: AOJu0Yzah0OaJ3+xFEngpsZFT96FzFYR6WGRCuq2O/sJai/OfhXte+55
 2uASAv227PtOzkJeW3M+9l5GpTl4ShqLLPsnN+P+7pjYbwqN8abOM9Y71ZreU/2Q7AMMUowiabY
 2NvmvUpH2jC3s9jFokNn5CGRxjHg=
X-Google-Smtp-Source: AGHT+IH/cwzYTEkfmIKxxFYgFgGRXo41ABU5/vRzMEZ3i6ptTkH7m4K8xmsQbQvukQjyXSD8fnnUGEUMX41En/HyIx0=
X-Received: by 2002:a67:fe4e:0:b0:46d:258e:4e10 with SMTP id
 m14-20020a67fe4e000000b0046d258e4e10mr1711272vsr.31.1707102174668; Sun, 04
 Feb 2024 19:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20240122221529.86562-1-dbarboza@ventanamicro.com>
 <20240122221529.86562-8-dbarboza@ventanamicro.com>
In-Reply-To: <20240122221529.86562-8-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 13:02:28 +1000
Message-ID: <CAKmqyKP-jpuUNYdYMC_Fk-ia3bpAWuaQ2Zgku7+ZwWmMyucByw@mail.gmail.com>
Subject: Re: [PATCH 7/7] hw/riscv/virt.c: use g_autofree in create_fdt_*
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 23, 2024 at 8:18=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We have a lot of cases where a char or an uint32_t pointer is used once
> to alloc a string/array, read/written during the function, and then
> g_free() at the end. There's no pointer re-use - a single alloc, a
> single g_free().
>
> Use 'g_autofree' to avoid the g_free() calls.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 78 ++++++++++++++-----------------------------------
>  1 file changed, 22 insertions(+), 56 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 710fbbda2c..1c257e89d2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -285,7 +285,7 @@ static void create_fdt_socket_cpus(RISCVVirtState *s,=
 int socket,
>  static void create_fdt_socket_memory(RISCVVirtState *s,
>                                       const MemMapEntry *memmap, int sock=
et)
>  {
> -    char *mem_name;
> +    g_autofree char *mem_name =3D NULL;
>      uint64_t addr, size;
>      MachineState *ms =3D MACHINE(s);
>
> @@ -297,7 +297,6 @@ static void create_fdt_socket_memory(RISCVVirtState *=
s,
>          addr >> 32, addr, size >> 32, size);
>      qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
>      riscv_socket_fdt_write_id(ms, mem_name, socket);
> -    g_free(mem_name);
>  }
>
>  static void create_fdt_socket_clint(RISCVVirtState *s,
> @@ -305,8 +304,8 @@ static void create_fdt_socket_clint(RISCVVirtState *s=
,
>                                      uint32_t *intc_phandles)
>  {
>      int cpu;
> -    char *clint_name;
> -    uint32_t *clint_cells;
> +    g_autofree char *clint_name =3D NULL;
> +    g_autofree uint32_t *clint_cells =3D NULL;
>      unsigned long clint_addr;
>      MachineState *ms =3D MACHINE(s);
>      static const char * const clint_compat[2] =3D {
> @@ -333,9 +332,6 @@ static void create_fdt_socket_clint(RISCVVirtState *s=
,
>      qemu_fdt_setprop(ms->fdt, clint_name, "interrupts-extended",
>          clint_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
>      riscv_socket_fdt_write_id(ms, clint_name, socket);
> -    g_free(clint_name);
> -
> -    g_free(clint_cells);
>  }
>
>  static void create_fdt_socket_aclint(RISCVVirtState *s,
> @@ -346,9 +342,9 @@ static void create_fdt_socket_aclint(RISCVVirtState *=
s,
>      char *name;
>      unsigned long addr, size;
>      uint32_t aclint_cells_size;
> -    uint32_t *aclint_mswi_cells;
> -    uint32_t *aclint_sswi_cells;
> -    uint32_t *aclint_mtimer_cells;
> +    g_autofree uint32_t *aclint_mswi_cells =3D NULL;
> +    g_autofree uint32_t *aclint_sswi_cells =3D NULL;
> +    g_autofree uint32_t *aclint_mtimer_cells =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
>      aclint_mswi_cells =3D g_new0(uint32_t, s->soc[socket].num_harts * 2)=
;
> @@ -420,10 +416,6 @@ static void create_fdt_socket_aclint(RISCVVirtState =
*s,
>          riscv_socket_fdt_write_id(ms, name, socket);
>          g_free(name);
>      }
> -
> -    g_free(aclint_mswi_cells);
> -    g_free(aclint_mtimer_cells);
> -    g_free(aclint_sswi_cells);
>  }
>
>  static void create_fdt_socket_plic(RISCVVirtState *s,
> @@ -432,8 +424,8 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>                                     uint32_t *plic_phandles)
>  {
>      int cpu;
> -    char *plic_name;
> -    uint32_t *plic_cells;
> +    g_autofree char *plic_name =3D NULL;
> +    g_autofree uint32_t *plic_cells;
>      unsigned long plic_addr;
>      MachineState *ms =3D MACHINE(s);
>      static const char * const plic_compat[2] =3D {
> @@ -493,10 +485,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s=
,
>                                         memmap[VIRT_PLATFORM_BUS].size,
>                                         VIRT_PLATFORM_BUS_IRQ);
>      }
> -
> -    g_free(plic_name);
> -
> -    g_free(plic_cells);
>  }
>
>  uint32_t imsic_num_bits(uint32_t count)
> @@ -515,11 +503,12 @@ static void create_fdt_one_imsic(RISCVVirtState *s,=
 hwaddr base_addr,
>                                   bool m_mode, uint32_t imsic_guest_bits)
>  {
>      int cpu, socket;
> -    char *imsic_name;
> +    g_autofree char *imsic_name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>      int socket_count =3D riscv_socket_count(ms);
> -    uint32_t imsic_max_hart_per_socket;
> -    uint32_t *imsic_cells, *imsic_regs, imsic_addr, imsic_size;
> +    uint32_t imsic_max_hart_per_socket, imsic_addr, imsic_size;
> +    g_autofree uint32_t *imsic_cells =3D NULL;
> +    g_autofree uint32_t *imsic_regs =3D NULL;
>
>      imsic_cells =3D g_new0(uint32_t, ms->smp.cpus * 2);
>      imsic_regs =3D g_new0(uint32_t, socket_count * 4);
> @@ -571,10 +560,6 @@ static void create_fdt_one_imsic(RISCVVirtState *s, =
hwaddr base_addr,
>                                IMSIC_MMIO_GROUP_MIN_SHIFT);
>      }
>      qemu_fdt_setprop_cell(ms->fdt, imsic_name, "phandle", msi_phandle);
> -
> -    g_free(imsic_name);
> -    g_free(imsic_regs);
> -    g_free(imsic_cells);
>  }
>
>  static void create_fdt_imsic(RISCVVirtState *s, const MemMapEntry *memma=
p,
> @@ -606,12 +591,10 @@ static void create_fdt_one_aplic(RISCVVirtState *s,=
 int socket,
>                                   bool m_mode, int num_harts)
>  {
>      int cpu;
> -    char *aplic_name;
> -    uint32_t *aplic_cells;
> +    g_autofree char *aplic_name =3D NULL;
> +    g_autofree uint32_t *aplic_cells =3D g_new0(uint32_t, num_harts * 2)=
;
>      MachineState *ms =3D MACHINE(s);
>
> -    aplic_cells =3D g_new0(uint32_t, num_harts * 2);
> -
>      for (cpu =3D 0; cpu < num_harts; cpu++) {
>          aplic_cells[cpu * 2 + 0] =3D cpu_to_be32(intc_phandles[cpu]);
>          aplic_cells[cpu * 2 + 1] =3D cpu_to_be32(m_mode ? IRQ_M_EXT : IR=
Q_S_EXT);
> @@ -646,9 +629,6 @@ static void create_fdt_one_aplic(RISCVVirtState *s, i=
nt socket,
>
>      riscv_socket_fdt_write_id(ms, aplic_name, socket);
>      qemu_fdt_setprop_cell(ms->fdt, aplic_name, "phandle", aplic_phandle)=
;
> -
> -    g_free(aplic_name);
> -    g_free(aplic_cells);
>  }
>
>  static void create_fdt_socket_aplic(RISCVVirtState *s,
> @@ -660,7 +640,7 @@ static void create_fdt_socket_aplic(RISCVVirtState *s=
,
>                                      uint32_t *aplic_phandles,
>                                      int num_harts)
>  {
> -    char *aplic_name;
> +    g_autofree char *aplic_name =3D NULL;
>      unsigned long aplic_addr;
>      MachineState *ms =3D MACHINE(s);
>      uint32_t aplic_m_phandle, aplic_s_phandle;
> @@ -695,23 +675,18 @@ static void create_fdt_socket_aplic(RISCVVirtState =
*s,
>                                         VIRT_PLATFORM_BUS_IRQ);
>      }
>
> -    g_free(aplic_name);
> -
>      aplic_phandles[socket] =3D aplic_s_phandle;
>  }
>
>  static void create_fdt_pmu(RISCVVirtState *s)
>  {
> -    char *pmu_name;
> +    g_autofree char *pmu_name =3D g_strdup_printf("/pmu");
>      MachineState *ms =3D MACHINE(s);
>      RISCVCPU hart =3D s->soc[0].harts[0];
>
> -    pmu_name =3D g_strdup_printf("/pmu");
>      qemu_fdt_add_subnode(ms->fdt, pmu_name);
>      qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu"=
);
>      riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
> -
> -    g_free(pmu_name);
>  }
>
>  static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *mem=
map,
> @@ -847,7 +822,7 @@ static void create_fdt_pcie(RISCVVirtState *s, const =
MemMapEntry *memmap,
>                              uint32_t irq_pcie_phandle,
>                              uint32_t msi_pcie_phandle)
>  {
> -    char *name;
> +    g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
>      name =3D g_strdup_printf("/soc/pci@%lx",
> @@ -881,7 +856,6 @@ static void create_fdt_pcie(RISCVVirtState *s, const =
MemMapEntry *memmap,
>          2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
>
>      create_pcie_irq_map(s, ms->fdt, name, irq_pcie_phandle);
> -    g_free(name);
>  }
>
>  static void create_fdt_reset(RISCVVirtState *s, const MemMapEntry *memma=
p,
> @@ -928,7 +902,7 @@ static void create_fdt_reset(RISCVVirtState *s, const=
 MemMapEntry *memmap,
>  static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap=
,
>                              uint32_t irq_mmio_phandle)
>  {
> -    char *name;
> +    g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
>      name =3D g_strdup_printf("/soc/serial@%lx", (long)memmap[VIRT_UART0]=
.base);
> @@ -946,13 +920,12 @@ static void create_fdt_uart(RISCVVirtState *s, cons=
t MemMapEntry *memmap,
>      }
>
>      qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> -    g_free(name);
>  }
>
>  static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
>                             uint32_t irq_mmio_phandle)
>  {
> -    char *name;
> +    g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
>      name =3D g_strdup_printf("/soc/rtc@%lx", (long)memmap[VIRT_RTC].base=
);
> @@ -968,41 +941,36 @@ static void create_fdt_rtc(RISCVVirtState *s, const=
 MemMapEntry *memmap,
>      } else {
>          qemu_fdt_setprop_cells(ms->fdt, name, "interrupts", RTC_IRQ, 0x4=
);
>      }
> -    g_free(name);
>  }
>
>  static void create_fdt_flash(RISCVVirtState *s, const MemMapEntry *memma=
p)
>  {
> -    char *name;
>      MachineState *ms =3D MACHINE(s);
>      hwaddr flashsize =3D virt_memmap[VIRT_FLASH].size / 2;
>      hwaddr flashbase =3D virt_memmap[VIRT_FLASH].base;
> +    g_autofree char *name =3D g_strdup_printf("/flash@%" PRIx64, flashba=
se);
>
> -    name =3D g_strdup_printf("/flash@%" PRIx64, flashbase);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_string(ms->fdt, name, "compatible", "cfi-flash");
>      qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
>                                   2, flashbase, 2, flashsize,
>                                   2, flashbase + flashsize, 2, flashsize)=
;
>      qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
> -    g_free(name);
>  }
>
>  static void create_fdt_fw_cfg(RISCVVirtState *s, const MemMapEntry *memm=
ap)
>  {
> -    char *nodename;
>      MachineState *ms =3D MACHINE(s);
>      hwaddr base =3D memmap[VIRT_FW_CFG].base;
>      hwaddr size =3D memmap[VIRT_FW_CFG].size;
> +    g_autofree char *nodename =3D g_strdup_printf("/fw-cfg@%" PRIx64, ba=
se);
>
> -    nodename =3D g_strdup_printf("/fw-cfg@%" PRIx64, base);
>      qemu_fdt_add_subnode(ms->fdt, nodename);
>      qemu_fdt_setprop_string(ms->fdt, nodename,
>                              "compatible", "qemu,fw-cfg-mmio");
>      qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
>                                   2, base, 2, size);
>      qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
> -    g_free(nodename);
>  }
>
>  static void finalize_fdt(RISCVVirtState *s)
> @@ -1149,7 +1117,7 @@ static DeviceState *virt_create_plic(const MemMapEn=
try *memmap, int socket,
>                                       int base_hartid, int hart_count)
>  {
>      DeviceState *ret;
> -    char *plic_hart_config;
> +    g_autofree char *plic_hart_config =3D NULL;
>
>      /* Per-socket PLIC hart topology configuration string */
>      plic_hart_config =3D riscv_plic_hart_config_string(hart_count);
> @@ -1168,8 +1136,6 @@ static DeviceState *virt_create_plic(const MemMapEn=
try *memmap, int socket,
>              VIRT_PLIC_CONTEXT_STRIDE,
>              memmap[VIRT_PLIC].size);
>
> -    g_free(plic_hart_config);
> -
>      return ret;
>  }
>
> --
> 2.43.0
>
>

