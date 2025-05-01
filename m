Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7888C369D9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHZK-0007Ap-5w; Wed, 30 Apr 2025 20:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHZI-0007A7-9a; Wed, 30 Apr 2025 20:14:24 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHZG-0003ZC-7y; Wed, 30 Apr 2025 20:14:23 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-52446b21cfdso147566e0c.1; 
 Wed, 30 Apr 2025 17:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746058460; x=1746663260; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m1loIG0TI/OP8b/AU3niKOufe8JvsPaF0NNh8NAnec=;
 b=TVDqdYe9sNytrQ39bsMmidp5FSBI77li0HBKxebtl8bUqG4QOYG5XlNhlmUBYZgabL
 2u9FmSUsaydx5jbheVebALE9zRTFKv7LazEnXUGI4RRS8mVFM9a+iCsWVa+eahfLtTpP
 NgX9W7QFYLAlI6zzRkxQ56vhNis4ijHl83vljUKTD1blHfQJHtR/ALVPMmPW+V8hu6h5
 aZJfVQ19TnjBlXDrvrESf0GPIZqvYUeK3GMPoinmQPU0siwxoENMlEc3l2vi/1d6PHEE
 09CNZqcNQj04OFAzNpSHJHgF+tUuVCeJTkjSwGRcPI/1RffKUMiDsVsvaFFF8d8dsThT
 oZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746058460; x=1746663260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/m1loIG0TI/OP8b/AU3niKOufe8JvsPaF0NNh8NAnec=;
 b=n7Cw1ELQhU9th9d4I3niU0keN03HBTwmfqikWY4QkNEPPJI+I/U1HSQd9tyKlGvH8c
 pkiDkweJn0GloKvNrDkQecsQJKkQr1XzTQAWMz3y7HJrCC0BU2nUbWaF+AIzlBk+Kxoa
 BiKWIw+U9p7bP/Otdkhi3Ce/eP8MBQ+mNHgJFKBGHil7uxKg7/096P7ZYWmI9OWQkmEG
 0I/a3PncvMkRKM906jV9x39M17iwyXOP2bEcTBTisfnev6X3hZgs5YylhvykJWnqXIoI
 4gVXg5O7pQiNF4szn/27NBPnftt8mHmYWKxAUoCaKN+Rc/M836Aep8tsrwBOrjkui6ZA
 G1MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEnFgim464FknDkPKgyWOCjOWhkcaQOrzowOp1v2BCshDT1lCxjnRKI1eHOswY1l8AUwuZfQTHWUne@nongnu.org
X-Gm-Message-State: AOJu0Ywvp6NbeRroWVnBmo+UcgMWdJ2pOGgcq4+aqdsv0aThkjFj/+9e
 /lDyv8eZ0aWEJVYpwDLzhG1ReZMjZwKVespwiLEolVfC78qrCTwAJ5DsqI9mp2MAr9aY2Uy5aQO
 hsCrNF2injIaFAc3kr6Jlms5yOFw=
X-Gm-Gg: ASbGncshk2rDFepXIKYIt0Q7KxIyFqgZ0Z7caOwbwfyfnp8rGlRxnVsEC+afRHi0E5f
 gWOpbUr+ZKZpafohMGXbyVxrXwXBiq+la1YgZo83/ZTVJdDwqkNRI/7mLzYrkujfU3L0UaMEFT9
 26s9juD9I10aIUozmGfLJQ4/Uy0LPmnU+0hBuFJGZLuXP6Gf2aj0dO
X-Google-Smtp-Source: AGHT+IH/73g7LaU/VFjlXFa4TVsjPtU7Vh1kMvhyRAN/PMlt8YgoXI5J+J4bXPbmWE5Ps+0sGZui20taksZLN7avsFs=
X-Received: by 2002:a05:6122:2024:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-52ade3bf4ebmr436051e0c.8.1746058460292; Wed, 30 Apr 2025
 17:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
 <20250429125811.224803-10-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-10-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:13:54 +1000
X-Gm-Features: ATxdqUF1jSIDxfWQdm45K9cjezM0BUcARYxn3sVBZqyCN3t2lEITiRYDp42CbvE
Message-ID: <CAKmqyKNPJfvfjhDf2xqf_1UO7K35cwQ5OwEPw94sKxr-q8G5CQ@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] hw/riscv/virt.c: remove 'long' casts in fmt strings
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Tue, Apr 29, 2025 at 11:01=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> We can avoid the 'long' casts by using PRIx64 and HWADDR_PRIx on the fmt
> strings for uint64_t and hwaddr types.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f38b64d836..0020d8f404 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -303,12 +303,13 @@ static void create_fdt_socket_cpus(RISCVVirtState *=
s, int socket,
>  static void create_fdt_socket_memory(RISCVVirtState *s, int socket)
>  {
>      g_autofree char *mem_name =3D NULL;
> -    uint64_t addr, size;
> +    hwaddr addr;
> +    uint64_t size;
>      MachineState *ms =3D MACHINE(s);
>
>      addr =3D s->memmap[VIRT_DRAM].base + riscv_socket_mem_offset(ms, soc=
ket);
>      size =3D riscv_socket_mem_size(ms, socket);
> -    mem_name =3D g_strdup_printf("/memory@%lx", (long)addr);
> +    mem_name =3D g_strdup_printf("/memory@%"HWADDR_PRIx, addr);
>      qemu_fdt_add_subnode(ms->fdt, mem_name);
>      qemu_fdt_setprop_cells(ms->fdt, mem_name, "reg",
>          addr >> 32, addr, size >> 32, size);
> @@ -879,8 +880,8 @@ static void create_fdt_pcie(RISCVVirtState *s,
>      g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
> -    name =3D g_strdup_printf("/soc/pci@%lx",
> -        (long) s->memmap[VIRT_PCIE_ECAM].base);
> +    name =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> +                           s->memmap[VIRT_PCIE_ECAM].base);
>      qemu_fdt_setprop_cell(ms->fdt, name, "#address-cells",
>          FDT_PCI_ADDR_CELLS);
>      qemu_fdt_setprop_cell(ms->fdt, name, "#interrupt-cells",
> @@ -924,8 +925,8 @@ static void create_fdt_reset(RISCVVirtState *s, uint3=
2_t *phandle)
>      MachineState *ms =3D MACHINE(s);
>
>      test_phandle =3D (*phandle)++;
> -    name =3D g_strdup_printf("/soc/test@%lx",
> -        (long)s->memmap[VIRT_TEST].base);
> +    name =3D g_strdup_printf("/soc/test@%"HWADDR_PRIx,
> +                           s->memmap[VIRT_TEST].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      {
>          static const char * const compat[3] =3D {
> @@ -963,8 +964,8 @@ static void create_fdt_uart(RISCVVirtState *s,
>      g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
> -    name =3D g_strdup_printf("/soc/serial@%lx",
> -                           (long)s->memmap[VIRT_UART0].base);
> +    name =3D g_strdup_printf("/soc/serial@%"HWADDR_PRIx,
> +                           s->memmap[VIRT_UART0].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_string(ms->fdt, name, "compatible", "ns16550a");
>      qemu_fdt_setprop_cells(ms->fdt, name, "reg",
> @@ -988,7 +989,8 @@ static void create_fdt_rtc(RISCVVirtState *s,
>      g_autofree char *name =3D NULL;
>      MachineState *ms =3D MACHINE(s);
>
> -    name =3D g_strdup_printf("/soc/rtc@%lx", (long)s->memmap[VIRT_RTC].b=
ase);
> +    name =3D g_strdup_printf("/soc/rtc@%"HWADDR_PRIx,
> +                           s->memmap[VIRT_RTC].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>      qemu_fdt_setprop_string(ms->fdt, name, "compatible",
>          "google,goldfish-rtc");
> @@ -1041,8 +1043,8 @@ static void create_fdt_virtio_iommu(RISCVVirtState =
*s, uint16_t bdf)
>      g_autofree char *iommu_node =3D NULL;
>      g_autofree char *pci_node =3D NULL;
>
> -    pci_node =3D g_strdup_printf("/soc/pci@%lx",
> -                               (long) s->memmap[VIRT_PCIE_ECAM].base);
> +    pci_node =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> +                               s->memmap[VIRT_PCIE_ECAM].base);
>      iommu_node =3D g_strdup_printf("%s/virtio_iommu@%x,%x", pci_node,
>                                   PCI_SLOT(bdf), PCI_FUNC(bdf));
>      iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
> @@ -1110,8 +1112,8 @@ static void create_fdt_iommu(RISCVVirtState *s, uin=
t16_t bdf)
>      g_autofree char *iommu_node =3D NULL;
>      g_autofree char *pci_node =3D NULL;
>
> -    pci_node =3D g_strdup_printf("/soc/pci@%lx",
> -                               (long) s->memmap[VIRT_PCIE_ECAM].base);
> +    pci_node =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> +                               s->memmap[VIRT_PCIE_ECAM].base);
>      iommu_node =3D g_strdup_printf("%s/iommu@%x", pci_node, bdf);
>      iommu_phandle =3D qemu_fdt_alloc_phandle(fdt);
>      qemu_fdt_add_subnode(fdt, iommu_node);
> @@ -1180,8 +1182,8 @@ static void create_fdt(RISCVVirtState *s)
>       * The "/soc/pci@..." node is needed for PCIE hotplugs
>       * that might happen before finalize_fdt().
>       */
> -    name =3D g_strdup_printf("/soc/pci@%lx",
> -                           (long) s->memmap[VIRT_PCIE_ECAM].base);
> +    name =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
> +                           s->memmap[VIRT_PCIE_ECAM].base);
>      qemu_fdt_add_subnode(ms->fdt, name);
>
>      qemu_fdt_add_subnode(ms->fdt, "/chosen");
> --
> 2.49.0
>
>

