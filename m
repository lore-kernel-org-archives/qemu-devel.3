Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE164CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:09:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKAW-0006uA-Tc; Mon, 15 Jun 2026 23:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKAS-0006tT-G1
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:08:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKAP-0008Bo-DY
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:08:48 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so7446628a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781579323; cv=none;
 d=google.com; s=arc-20240605;
 b=YRJPNi3HG5a5ZC8NmdttJwkA/idQ0Nc2/qRsP+NMsb19KB+eUMzLGkNfSkFTXtWzzJ
 OJiylDJO0wCrBFaa8Bi2YR8O2emJBj6mY4jGNrFwEyMwyZVPPsuxIbky1Zf1+3SpyoMD
 RuNhAXQwys7phA0gBxrozMQZGHLGC5r8nUpXGoaOXUmNopeiZBuYv5oqTohPZK/uED5i
 Z6bxxKXwSf41JaF1JWTmaQ8qgQbDHwiOz9bGbVbXWKL7YmNRIbmD423HlD+O7UwK9dFq
 8aqP1Z5Hu9ucmvcAIzf4DJYYFJ1A1N1S0cUF0YoivkGgNSgywiY3UJr5CGnw5qQqO0et
 ll7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gF+1+ugwYxUqSuygQLOoDf6gnCwtaiiiPyJc5ma5Uf8=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=gRy5D8cUkQWQERhN8fQdr01ri8SEtCkI2/KtO21pDm/X4C5D3NzaNz7D6FkEK9tSPn
 IWhqEpDm4+OJ2sVsazeWnByOZX/PTHWj8Y6UX/78l9/M3ii3gy18DCZT1jBEW98DePNz
 RgfFa6eSJNZtUIOKN7hVhdtlQzvxWYiS77tSdCvHUvwaRE6x49uWOnORhh2JuLbuob/F
 6dBMSPvEzf3inPDrYMEje2mpx+HKDRAHMT66U/zEKYF77a++0nzH+goHt5QksMsDCm+8
 d9gGGvcRdWD+qB2pZ1sP3O/E6dzPo4aj8CNEib0CEs2XJIioUDZdSas7Zqpd0YfAcqJU
 YpWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781579323; x=1782184123; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gF+1+ugwYxUqSuygQLOoDf6gnCwtaiiiPyJc5ma5Uf8=;
 b=Z7lB2D8apQEoaAPgz5hdRTcVatzUoWyubQDau1F0lyBj3gP9FWEWouijIDMG6gKPnx
 6B9SIjnTq94SyokBfN6R22fyotf1Ozbfws6/VFOCefvuecFSRi7esHBD9GgMjmToSL/L
 frFRYs90nkyV8LY01Viq/zR8HC5Bt+4wLcFB72IM3qz8ne65pWsVrD7MwSkTa5Sq9jmI
 IYfpp6M8fzHr9iedb7qCn5sXfYvtqNs//61dpJosxogGD2ikcwt+Y5mzA7PAwDHYDsRv
 sJym0Sr0dWxWXJfrbYPRDkFjp9vwj5Xl8szmbQBlj3mJgRbZT9sXvBdgjBMNaguDUWvZ
 6+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579323; x=1782184123;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gF+1+ugwYxUqSuygQLOoDf6gnCwtaiiiPyJc5ma5Uf8=;
 b=TUQix+3lLJiBfJorxM4WyF7xe8Ag9oS/nk9b7EDabGlSJpMsQvSLacjYGK5ojbDcGu
 pxAIk4X2l/NaixDqqRsL1b663VPuaybjD8tnnBr7UuGJCa5KfqEb+3DAiucGPOcy8LmE
 DNrke9LHrdNr+reut1sc0gBIhcUWZ+pUPYHDNknkIpWTV0GeTqvTktkIUQQpBKk1HPp7
 3uxu47lNySxe6w4+4oFg+1SfA+Qdr35iDVMZComVeHGzjbUd1b29LsIBLgYCCNa96XiL
 jpLydLpfi91MZY3ySIB+07W/XZDE4vevRQ/PthAubUD0e+IXXaEatd47aq6wPcVFMJya
 YUqQ==
X-Gm-Message-State: AOJu0Yxmy9uK8+HzPHsVyevp5e+DUUNsKFVTp1OXIkag6iq9FL3dTwCl
 4AmYc8ulp6zhtyYmKthxAA+mboG3/DtQ6peJOmie4CgmPFZM3VoDOX24zjEO/FgmIIWkOpAZPNh
 rp5N6D0bBpZe910mowgW8Zi6stIkCkdY=
X-Gm-Gg: Acq92OH6PmfUNUhrn9HNS1O94mY1xOdBgZkQ0e53UvNuwiQCPK/T6PEBqtoKH9ctSx+
 LpofWmTHv1gF5qFZATJt8LzDR/w3OfHGsmZzKMWQ+3rPgtxHIJnQAdFUJi77Pe7ROBku4ZCcKy7
 wufDzQ4vyNLFQfxttJNHe8IamwmOpUhD4EUL9jK5PYDj8v0fzR5u/b3Dmb331s589FTVGpIGUtd
 bhr0jq5l4ypWWXQcJMbZ0y1V7t442mb0LhMKm8MHJhnnueEDzwszAdl6mLjBlwKdiL+Ws8A9Ypk
 xyMRGRAkSeQUX+tutLtv9GMyxzDjXytlnBQFxA==
X-Received: by 2002:a05:6402:27cf:b0:67b:89f5:26c7 with SMTP id
 4fb4d7f45d1cf-693c6a93510mr5810363a12.26.1781579323434; Mon, 15 Jun 2026
 20:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
 <20260615203734.954428-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-5-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:08:17 +1000
X-Gm-Features: AVVi8CcxQY9T5iH1LxgOsorzHrtflh_vpvnbiViJBpMXEtACID7g1SCRvSSUiDM
Message-ID: <CAKmqyKNcOURk1zU9F+R0YB02YnkdQjafiRjzYCa9FKg8Mo7=hw@mail.gmail.com>
Subject: Re: [PATCH 04/13] hw/riscv: add create_fdt_socket_memory() helper
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x532.google.com
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

On Tue, Jun 16, 2026 at 6:39=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> This helper encapsulates the creation of /memory@addr FDT subnodes.
>
> Boards are responsible for calculating the adequate addr, size and
> inform if we have numa enabled.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/fdt-common.c         | 15 +++++++++++++++
>  hw/riscv/sifive_u.c           | 11 ++---------
>  hw/riscv/spike.c              | 18 +++++++-----------
>  hw/riscv/virt.c               | 23 ++++++-----------------
>  include/hw/riscv/fdt-common.h |  2 ++
>  5 files changed, 32 insertions(+), 37 deletions(-)
>
> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
> index b155246998..719c36e001 100644
> --- a/hw/riscv/fdt-common.c
> +++ b/hw/riscv/fdt-common.c
> @@ -10,6 +10,7 @@
>
>  #include "qemu/error-report.h"
>  #include "system/device_tree.h"
> +#include "hw/core/boards.h"
>  #include "hw/riscv/fdt-common.h"
>
>  void *create_board_device_tree(const char *model, const char *compatible=
,
> @@ -35,3 +36,17 @@ void *create_board_device_tree(const char *model, cons=
t char *compatible,
>
>      return fdt;
>  }
> +
> +void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> +                              int socket_id, bool numa_enabled)
> +{
> +    g_autofree char *mem_name =3D g_strdup_printf("/memory@%"HWADDR_PRIx=
, addr);
> +
> +    qemu_fdt_add_subnode(fdt, mem_name);
> +    qemu_fdt_setprop_sized_cells(fdt, mem_name, "reg", 2, addr, 2, size)=
;
> +    qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
> +
> +    if (numa_enabled) {
> +        qemu_fdt_setprop_cell(fdt, mem_name, "numa-node-id", socket_id);
> +    }
> +}
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index 5d3b2751ad..a00cfd08a7 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -98,7 +98,6 @@ static void create_fdt(SiFiveUState *s, const MemMapEnt=
ry *memmap,
>                         bool is_32_bit)
>  {
>      MachineState *ms =3D MACHINE(s);
> -    uint64_t mem_size =3D ms->ram_size;
>      void *fdt;
>      int cpu;
>      uint32_t *cells;
> @@ -138,14 +137,8 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>      qemu_fdt_setprop_cell(fdt, nodename, "#clock-cells", 0x0);
>      g_free(nodename);
>
> -    nodename =3D g_strdup_printf("/memory@%lx",
> -        (long)memmap[SIFIVE_U_DEV_DRAM].base);
> -    qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cells(fdt, nodename, "reg",
> -        memmap[SIFIVE_U_DEV_DRAM].base >> 32, memmap[SIFIVE_U_DEV_DRAM].=
base,
> -        mem_size >> 32, mem_size);
> -    qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
> -    g_free(nodename);
> +    create_fdt_socket_memory(fdt, memmap[SIFIVE_U_DEV_DRAM].base,
> +                             ms->ram_size, 0, false);
>
>      qemu_fdt_add_subnode(fdt, "/cpus");
>      qemu_fdt_setprop_cell(fdt, "/cpus", "timebase-frequency",
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 79c9bb041f..92facba29d 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -55,13 +55,12 @@ static void create_fdt(SpikeState *s, const MemMapEnt=
ry *memmap,
>  {
>      void *fdt;
>      int fdt_size;
> -    uint64_t addr, size;
>      unsigned long clint_addr;
>      int cpu, socket;
>      MachineState *ms =3D MACHINE(s);
>      uint32_t *clint_cells;
>      uint32_t cpu_phandle, intc_phandle, phandle =3D 1;
> -    char *mem_name, *clint_name, *clust_name;
> +    char *clint_name, *clust_name;
>      char *core_name, *cpu_name, *intc_name;
>      static const char * const clint_compat[2] =3D {
>          "sifive,clint0", "riscv,clint0"
> @@ -85,6 +84,10 @@ static void create_fdt(SpikeState *s, const MemMapEntr=
y *memmap,
>      qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
>
>      for (socket =3D (riscv_socket_count(ms) - 1); socket >=3D 0; socket-=
-) {
> +        hwaddr memaddr =3D memmap[SPIKE_DRAM].base +
> +                         riscv_socket_mem_offset(ms, socket);
> +        uint64_t memsize =3D  riscv_socket_mem_size(ms, socket);
> +
>          clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
>          qemu_fdt_add_subnode(fdt, clust_name);
>
> @@ -133,15 +136,8 @@ static void create_fdt(SpikeState *s, const MemMapEn=
try *memmap,
>              g_free(cpu_name);
>          }
>
> -        addr =3D memmap[SPIKE_DRAM].base + riscv_socket_mem_offset(ms, s=
ocket);
> -        size =3D riscv_socket_mem_size(ms, socket);
> -        mem_name =3D g_strdup_printf("/memory@%lx", (long)addr);
> -        qemu_fdt_add_subnode(fdt, mem_name);
> -        qemu_fdt_setprop_cells(fdt, mem_name, "reg",
> -            addr >> 32, addr, size >> 32, size);
> -        qemu_fdt_setprop_string(fdt, mem_name, "device_type", "memory");
> -        riscv_socket_fdt_write_id(ms, mem_name, socket);
> -        g_free(mem_name);
> +        create_fdt_socket_memory(fdt, memaddr, memsize, socket,
> +                                 riscv_numa_enabled(ms));
>
>          clint_addr =3D memmap[SPIKE_CLINT].base +
>              (memmap[SPIKE_CLINT].size * socket);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index cb1d83fd48..df3eadef78 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -302,22 +302,6 @@ static void create_fdt_socket_cpus(RISCVVirtState *s=
, int socket,
>      }
>  }
>
> -static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
> -{
> -    g_autofree char *mem_name =3D NULL;
> -    hwaddr addr;
> -    uint64_t size;
> -    MachineState *ms =3D MACHINE(s);
> -
> -    addr =3D s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, soc=
ket);
> -    size =3D riscv_socket_mem_size(ms, socket);
> -    mem_name =3D g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
> -    qemu_fdt_add_subnode(ms->fdt, mem_name);
> -    qemu_fdt_setprop_sized_cells(ms->fdt, mem_name, "reg", 2, addr, 2, s=
ize);
> -    qemu_fdt_setprop_string(ms->fdt, mem_name, "device_type", "memory");
> -    riscv_socket_fdt_write_id(ms, mem_name, socket);
> -}
> -
>  static void create_fdt_socket_clint(RISCVVirtState *s,
>                                      int socket,
>                                      uint32_t *intc_phandles)
> @@ -759,6 +743,10 @@ static void create_fdt_sockets(RISCVVirtState *s,
>      phandle_pos =3D ms->smp.cpus;
>      for (socket =3D (socket_count - 1); socket >=3D 0; socket--) {
>          g_autofree char *clust_name =3D NULL;
> +        hwaddr memaddr =3D s->memmap[VIRT_DRAM].base +
> +                         riscv_socket_mem_offset(ms, socket);
> +        uint64_t memsize =3D riscv_socket_mem_size(ms, socket);
> +
>          phandle_pos -=3D s->soc[socket].num_harts;
>
>          clust_name =3D g_strdup_printf("/cpus/cpu-map/cluster%d", socket=
);
> @@ -767,7 +755,8 @@ static void create_fdt_sockets(RISCVVirtState *s,
>          create_fdt_socket_cpus(s, socket, clust_name, phandle,
>                                 &intc_phandles[phandle_pos]);
>
> -        create_fdt_socket_memory(s, socket);
> +        create_fdt_socket_memory(ms->fdt, memaddr, memsize,
> +                                 socket, riscv_numa_enabled(ms));
>
>          if (virt_aclint_allowed() && s->have_aclint) {
>              create_fdt_socket_aclint(s, socket,
> diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.=
h
> index adf9b33dfd..81689f418b 100644
> --- a/include/hw/riscv/fdt-common.h
> +++ b/include/hw/riscv/fdt-common.h
> @@ -11,4 +11,6 @@
>
>  void *create_board_device_tree(const char *model, const char *compatible=
,
>                                 int *fdt_size);
> +void create_fdt_socket_memory(void *fdt, hwaddr addr, uint64_t size,
> +                              int socket_id, bool numa_enabled);
>  #endif
> --
> 2.43.0
>
>

