Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B2FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEtf-0005lG-G3; Wed, 29 Apr 2026 20:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIEtc-0005l4-1I
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:04:48 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIEtY-0001I8-KL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:04:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ba8472c1613so54383966b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777507483; cv=none;
 d=google.com; s=arc-20240605;
 b=W7po8j/VPk68LHW8J2WTODzrPQaSz1/k9PneU5gpj1SikzPA4+/1TanPAH+hyBSGSK
 a8p5ermUMMQ48xJqmlh6j/hcvq72O/EP2zON4baFRtdhnonKapJKHH9OxYO9wh3euaB4
 ID/1KKpIJ1C0SbXlVf4HbzfzexZOE8WAxCgE+g7wVQSs/RMHJB56dh9M9rEZkofYCsrw
 kvVrodXbCLwTuIq0nnlOtSU1by4MMIi81NO9pbfaUY5dxvvaOcdyxhjyKk8Aj75eIAwB
 zvx964UYWMqkUg7GT/+FnlS8FAJ3dBfnuYNo72FZzKfyUwyo9aIMDxC65b/S5lA/XZJP
 /zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b9mYIwc4zkAYZGVdtlkHpU8vIEICU1FMlykQFHCZUeY=;
 fh=jE/arX6hOQRTa71zs2Zzf1osFWpo40/vgWXTwSR/fMU=;
 b=CpqTBUp5ZMLcD+5aMjRuySRJXCg01SOhr8N8J+TV8bhFGJ0fPBOUEIiWk8amdNyJdl
 BGxy3sRKPxcbaJTc+jz7F6Axp0A33Arx1meON7By+ffJ8WdQHj/muBj3AqXEbm/U/7/P
 eJZ3ENMnRhrhafZWT6mA4RSerfPZMT57Rytj2vYq6C2EKRGeYopDOqZOdD/47RiiUpvm
 AAkQYprU1Y+O4polU20sxVku0MPm9MfBZnfTjlYPXj6jT4FIJA8BcHiIoPbXom6ko1p4
 LpV/I06EU8YjlqvR7IQb3ncWMeuXHn3Fs6Dxmea/xCPhZvl3eIcICcfdpYHhocNrECll
 fAag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777507483; x=1778112283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9mYIwc4zkAYZGVdtlkHpU8vIEICU1FMlykQFHCZUeY=;
 b=MK2TueNbmf5s4oWMBQnkAp2/No76kULBz/ISG8uKMPYOCsZe0K2JNv0UooqruL0BEK
 fN3rprHiy+cfZ9RzolRN+18i/iqPwzzV7aiYrt7q7+DxMChR/Gx5MK5PF5Plqho0OPmF
 NFV2Uy7ehTCT6OJHUuG0NYpnzsbga/vw8S5RuaSrdHjkR/v6QSEadrp/i6+/oQ+Nhv2e
 jOusL6piVw9ur8UknyDq0XHpfL/BvS1u6qbqQKmefNEUBUa6GUeOTWPnTNGULoZlzwcr
 DT5FgSRgvkKdZb6zpNWK/Ga4XGI91G0G+APFBWre/QOg5amWAlnTBGJ02mgWBzVDm+TR
 zKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507483; x=1778112283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b9mYIwc4zkAYZGVdtlkHpU8vIEICU1FMlykQFHCZUeY=;
 b=HGebi1YVI66NFGsjK5iTEfH9e47S5IWGOprUHv0U/VQAo4eii8a1xpcBLkxuZX2Axh
 74pvc3/oxL4fLmF8MxvnNB1uteprUoXtowxHoofkil+XjNkrrll2sAxSu5urmB+Be2M9
 eTSYgp61aLOZiS7lEA00mXNS1jZT11CvcQQS5edxFfou5Dw07KyaryDGRIVmn8F9SN4C
 QRJRvD/P5cbxxMWyGipSYr+5KRcvNZWJLdQQNrq7xQ0CbVUfRQgxTDBBgZmtB7kQM2DO
 1AyoLyriXXwYBl9QFLAAy1xSy/uJjuAAh4Hign5En0cyL+svnhcG5LID5RJ6ISZ9elTO
 DJIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v1BlOXBCqxKYK19gOQBd6fOut89Tm7h/NY5PRGZL+lv6Y8PU19Dcv1p/OSINciBmcCJhhgRijd26M@nongnu.org
X-Gm-Message-State: AOJu0YwCDUKUdOXFWDFSRcAtK0pzsFUlyLLaKTuwPCaA7QoyzCz/idzO
 LBRYmBqVSVVhXk1yKzSPteqY3vUVSWlxkcPIT4UrMRIMIFNZZz/qy99m57N3KG3AQe78IB21FaP
 Lq6HIOpgAhgOy4C3JRTOc7I8/Nep4c8E=
X-Gm-Gg: AeBDievVc663Kms+kQWGuDTnb4k7u9K6684Np/C7c0FFurltKQF1Sfy+Tyb2braGV/7
 tYnPutakuADm3iWBbTABqxyj9iIG9Do3ntmhwibrRcC+SmHq9lYdXNL+pMXdsxbIZU0pbZZESZm
 KrQquaylXHSGUN7q2px1ismMPr0+gKr318ydMMzB7PvkQkBevAQJoVyb4nn2R47omusD870a+Un
 m5fq8CrSs+0gCdVAlWxCunLaTutfWutyg9a+4xd5BTWREkp97V2bGdGiHS2OllpqTuXFQ/lLPci
 5pAlkvo56oMlML77I7UZ1x6ANBZ5UINc9RiAZYrsSEdnzKUTHjoECBrov6Q=
X-Received: by 2002:a17:907:e106:b0:bba:3e2c:f3a3 with SMTP id
 a640c23a62f3a-bbac7a97122mr25670866b.45.1777507482521; Wed, 29 Apr 2026
 17:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-11-joel@jms.id.au>
In-Reply-To: <20260425131721.932250-11-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 30 Apr 2026 10:04:16 +1000
X-Gm-Features: AVHnY4Jj9iLu7tSSdW563oGsSOnD2BE5_j16l0hDnhMwEUM9xMioNJHCe1yCYbU
Message-ID: <CAKmqyKOV07ANs0i1yj6bMJWkWgn7DcME7B0_ZO0LPb0qVnfsew@mail.gmail.com>
Subject: Re: [PATCH v4 10/13] hw/riscv/atlantis: Add PCIe controller
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Sat, Apr 25, 2026 at 11:21=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> Atlantis has 3 DesignWare PCIe host controllers, however the boot firmwar=
e
> has not been tested with the QEMU DesignWare model so a generic ECAM
> controller is used for the interim. The system bus aperture and PCIe IO

I don't follow.

The actual hardware has a different PCIe controller? This is user
visible so you can't easily change it once it's merged. Generally user
visible changes go through a deprecation process, we have some
exceptions for soft cores which change all the time. But ideally this
should model the hardware from the start.

Also if it isn't that should be noted in the board documentation.

A quick grep shows support for a DesignWare PCIe Host, why not use that?

Alistair

> mappings match the hardware configuration. Only a single PCIe controller =
is
> implemented, because the gpex model does not support multiple controllers=
.
>
> Booting Linux v6.19:
>
>  pci-host-generic 1110000000.pci: host bridge /soc/pci@1110000000 ranges:
>  pci-host-generic 1110000000.pci:       IO 0x30011000000..0x300110fffff -=
> 0x0000000000
>  pci-host-generic 1110000000.pci:      MEM 0x30080000000..0x300ffffffff -=
> 0x0080000000
>  pci-host-generic 1110000000.pci:      MEM 0x30100000000..0x3ff7fffffff -=
> 0x30100000000
>  pci-host-generic 1110000000.pci: ECAM at [mem 0x1110000000-0x111fffffff]=
 for [bus 00-ff]
>  pci-host-generic 1110000000.pci: PCI host bridge to bus 0000:00
>  pci_bus 0000:00: root bus resource [bus 00-ff]
>  pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
>  pci_bus 0000:00: root bus resource [mem 0x30080000000-0x300ffffffff] (bu=
s address [0x80000000-0xffffffff])
>  pci_bus 0000:00: root bus resource [mem 0x30100000000-0x3ff7fffffff pref=
]
>  pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000 conventional PCI en=
dpoint
>  pci 0000:00:01.0: [1af4:1001] type 00 class 0x010000 conventional PCI en=
dpoint
>  pci 0000:00:01.0: BAR 0 [io  0x0000-0x007f]
>  pci 0000:00:01.0: BAR 1 [mem 0x00000000-0x00000fff]
>  pci 0000:00:01.0: BAR 4 [mem 0x00000000-0x00003fff 64bit pref]
>  pci 0000:00:01.0: BAR 4 [mem 0x30100000000-0x30100003fff 64bit pref]: as=
signed
>  pci 0000:00:01.0: BAR 1 [mem 0x30080000000-0x30080000fff]: assigned
>  pci 0000:00:01.0: BAR 0 [io  0x0080-0x00ff]: assigned
>  pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
>  pci_bus 0000:00: resource 5 [mem 0x30080000000-0x300ffffffff]
>  pci_bus 0000:00: resource 6 [mem 0x30100000000-0x3ff7fffffff pref]
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> v4:
>  - Remove select PCI
>  - Rework addressing, use a table for describing the map
>  - Remove traces of controller 2 and 3; they will be implemented in
>    future patches
> v3: Avoid leaks in the dt string allocation
> ---
>  include/hw/riscv/tt_atlantis.h |  12 ++
>  hw/riscv/tt_atlantis.c         | 234 ++++++++++++++++++++++++++++++++-
>  hw/riscv/Kconfig               |   1 +
>  3 files changed, 246 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlanti=
s.h
> index 9fe50d9c9040..070f53eeb450 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -17,6 +17,13 @@
>  #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>  OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
>
> +typedef struct {
> +    hwaddr pcie_addr; /* Device side address */
> +    hwaddr window_offset; /* Host side offset */
> +    hwaddr size;
> +    uint32_t flags;
> +} PciMapEntry;
> +
>  struct TTAtlantisState {
>      /*< private >*/
>      MachineState parent;
> @@ -25,9 +32,11 @@ struct TTAtlantisState {
>      Notifier machine_done;
>      FWCfgState *fw_cfg;
>      const MemMapEntry *memmap;
> +    const PciMapEntry *pcimap;
>
>      RISCVHartArrayState soc;
>      DeviceState *irqchip;
> +    GPEXHost gpex_host;
>
>      int fdt_size;
>  };
> @@ -39,6 +48,7 @@ enum {
>      TT_ATL_UART2_IRQ =3D 40,
>      TT_ATL_UART3_IRQ =3D 41,
>      TT_ATL_UART4_IRQ =3D 42,
> +    TT_ATL_PCIE0_INTA_IRQ =3D 96,
>  };
>
>  enum {
> @@ -50,6 +60,8 @@ enum {
>      TT_ATL_I2C0,
>      TT_ATL_MAPLIC,
>      TT_ATL_MIMSIC,
> +    TT_ATL_PCIE_ECAM0,
> +    TT_ATL_PCIE_MMIO0,
>      TT_ATL_SAPLIC,
>      TT_ATL_SIMSIC,
>      TT_ATL_SYSCON,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 5b66d7e95bb9..1eb473907ad7 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -27,6 +27,7 @@
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/intc/riscv_aplic.h"
>  #include "hw/misc/pvpanic.h"
> +#include "hw/pci-host/gpex.h"
>
>  #include "system/system.h"
>  #include "system/device_tree.h"
> @@ -51,6 +52,13 @@
>  #define TT_ACLINT_MTIMECMP      0x8000
>  #define TT_ACLINT_TIMEBASE_FREQ 1000000000
>
> +
> +enum {
> +    PCIE0_PIO,
> +    PCIE0_MMIO_32,
> +    PCIE0_MMIO_64,
> +};
> +
>  static const MemMapEntry tt_atlantis_memmap[] =3D {
>      /* Keep sorted with :'<,'>!sort -g -k 4 */
>      [TT_ATL_DDR_LO] =3D           { 0x00000000,    0x80000000 },
> @@ -66,6 +74,19 @@ static const MemMapEntry tt_atlantis_memmap[] =3D {
>      [TT_ATL_MAPLIC] =3D           { 0xcc000000,     0x4000000 },
>      [TT_ATL_SAPLIC] =3D           { 0xe8000000,     0x4000000 },
>      [TT_ATL_DDR_HI] =3D          { 0x100000000,  0x1000000000 },
> +    [TT_ATL_PCIE_ECAM0] =3D    { 0x01110000000,    0x10000000 },
> +    [TT_ATL_PCIE_MMIO0] =3D    { 0x30000000000, 0x10000000000 },
> +};
> +
> +static const PciMapEntry tt_atlantis_pci_map[]  =3D {
> +    /* pcie_addr    window_offset         size   flags */
> +    {           0x0,  0x11000000,       1 * MiB, FDT_PCI_RANGE_IOPORT |
> +                                                  FDT_PCI_RANGE_RELOCATA=
BLE },
> +    {    0x80000000,  0x80000000,       2 * GiB, FDT_PCI_RANGE_MMIO |
> +                                                  FDT_PCI_RANGE_RELOCATA=
BLE },
> +    { 0x30100000000, 0x100000000,    1018 * GiB, FDT_PCI_RANGE_MMIO_64BI=
T |
> +                                                  FDT_PCI_RANGE_RELOCATA=
BLE |
> +                                                  FDT_PCI_RANGE_PREFETCH=
ABLE },
>  };
>
>  static uint32_t next_phandle(void)
> @@ -74,6 +95,59 @@ static uint32_t next_phandle(void)
>      return phandle++;
>  }
>
> +static void create_pcie_irq_map(void *fdt, char *nodename, int legacy_ir=
q,
> +                                uint32_t irqchip_phandle)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride =3D 0;
> +    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
> +                          FDT_MAX_INT_MAP_WIDTH] =3D {};
> +    uint32_t *irq_map =3D full_irq_map;
> +
> +    /*
> +     * This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +    for (dev =3D 0; dev < PCI_NUM_PINS; dev++) {
> +        int devfn =3D dev * 0x8;
> +
> +        for (pin =3D 0; pin < PCI_NUM_PINS; pin++) {
> +            int irq_nr =3D legacy_irq + ((pin + PCI_SLOT(devfn)) % PCI_N=
UM_PINS);
> +            int i =3D 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] =3D cpu_to_be32(devfn << 8);
> +            i +=3D FDT_PCI_ADDR_CELLS;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] =3D cpu_to_be32(pin + 1);
> +            i +=3D FDT_PCI_INT_CELLS;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] =3D cpu_to_be32(irqchip_phandle);
> +            irq_map[i++] =3D cpu_to_be32(irq_nr);
> +            irq_map[i++] =3D cpu_to_be32(0x4);
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride =3D i;
> +            }
> +            irq_map +=3D irq_map_stride;
> +        }
> +    }
> +
> +    qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
> +                     PCI_NUM_PINS * PCI_NUM_PINS *
> +                     irq_map_stride * sizeof(uint32_t));
> +
> +    qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
> +                           0x1800, 0, 0, 0x7);
> +}
> +
>  static void create_fdt_cpus(TTAtlantisState *s, uint32_t *intc_phandles)
>  {
>      uint32_t cpu_phandle;
> @@ -314,6 +388,52 @@ static void create_fdt_cpu(TTAtlantisState *s, const=
 MemMapEntry *memmap,
>                           IRQ_S_EXT, s->soc.num_harts);
>  }
>
> +static void create_fdt_pcie(void *fdt,
> +                            const MemMapEntry *ecam_mem,
> +                            const MemMapEntry *pcie_mem,
> +                            const PciMapEntry *pio,
> +                            const PciMapEntry *mmio32,
> +                            const PciMapEntry *mmio64,
> +                            int legacy_irq,
> +                            uint32_t aplic_s_phandle,
> +                            uint32_t imsic_s_phandle)
> +{
> +    g_autofree char *name =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
> +                                            ecam_mem->base);
> +
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", FDT_PCI_ADDR_CELL=
S);
> +    qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", FDT_PCI_INT_CEL=
LS);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0x2);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "pci-host-ecam-gene=
ric");
> +    qemu_fdt_setprop_string(fdt, name, "device_type", "pci");
> +    qemu_fdt_setprop_cells(fdt, name, "bus-range", 0,
> +                           ecam_mem->size / PCIE_MMCFG_SIZE_MIN - 1);
> +    qemu_fdt_setprop(fdt, name, "dma-coherent", NULL, 0);
> +    qemu_fdt_setprop_cell(fdt, name, "msi-parent", imsic_s_phandle);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> +                                 2, ecam_mem->base,
> +                                 2, ecam_mem->size);
> +
> +    qemu_fdt_setprop_sized_cells(fdt, name, "ranges",
> +                                 1, pio->flags,
> +                                 2, pio->pcie_addr,
> +                                 2, pio->window_offset + pcie_mem->base,
> +                                 2, pio->size,
> +
> +                                 1, mmio32->flags,
> +                                 2, mmio32->pcie_addr,
> +                                 2, mmio32->window_offset + pcie_mem->ba=
se,
> +                                 2, mmio32->size,
> +
> +                                 1, mmio64->flags,
> +                                 2, mmio64->pcie_addr,
> +                                 2, mmio64->window_offset + pcie_mem->ba=
se,
> +                                 2, mmio64->size);
> +
> +    create_pcie_irq_map(fdt, name, legacy_irq, aplic_s_phandle);
> +}
> +
>  static void create_fdt_reset(void *fdt, const MemMapEntry *mem)
>  {
>      uint32_t syscon_phandle =3D next_phandle();
> @@ -379,6 +499,15 @@ static void finalize_fdt(TTAtlantisState *s)
>       *                       aplic_s_phandle);
>       */
>
> +    create_fdt_pcie(fdt,
> +                    &s->memmap[TT_ATL_PCIE_ECAM0],
> +                    &s->memmap[TT_ATL_PCIE_MMIO0],
> +                    &s->pcimap[PCIE0_PIO],
> +                    &s->pcimap[PCIE0_MMIO_32],
> +                    &s->pcimap[PCIE0_MMIO_64],
> +                    TT_ATL_PCIE0_INTA_IRQ,
> +                    aplic_s_phandle, imsic_s_phandle);
> +
>      create_fdt_reset(fdt, &s->memmap[TT_ATL_SYSCON]);
>
>      create_fdt_uart(fdt, &s->memmap[TT_ATL_UART0], TT_ATL_UART0_IRQ,
> @@ -389,7 +518,7 @@ static void create_fdt(TTAtlantisState *s)
>  {
>      MachineState *ms =3D MACHINE(s);
>      uint8_t rng_seed[32];
> -    g_autofree char *name =3D NULL;
> +    char *name;
>      void *fdt;
>
>      fdt =3D create_device_tree(&s->fdt_size);
> @@ -411,6 +540,15 @@ static void create_fdt(TTAtlantisState *s)
>      qemu_fdt_setprop_cell(fdt, "/soc", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(fdt, "/soc", "#address-cells", 0x2);
>
> +    /*
> +     * The "/soc/pci@..." node is needed for PCIE hotplugs
> +     * that might happen before finalize_fdt().
> +     */
> +    name =3D g_strdup_printf("/soc/pci@%"HWADDR_PRIX,
> +                           s->memmap[TT_ATL_PCIE_ECAM0].base);
> +    qemu_fdt_add_subnode(fdt, name);
> +    g_free(name);
> +
>      qemu_fdt_add_subnode(fdt, "/chosen");
>
>      /* Pass seed to RNG */
> @@ -423,6 +561,95 @@ static void create_fdt(TTAtlantisState *s)
>      create_fdt_pmu(s);
>  }
>
> +static void gpex_pcie_init_one(TTAtlantisState *s, GPEXHost *gpex_host,
> +                               MemoryRegion *mr,
> +                               const MemMapEntry *ecam_mem,
> +                               const MemMapEntry *pcie_mem,
> +                               const PciMapEntry *mem_pio,
> +                               const PciMapEntry *mem_mmio32,
> +                               const PciMapEntry *mem_mmio64,
> +                               int legacy_irq)
> +{
> +    DeviceState *dev;
> +    Object *obj;
> +    MemoryRegion *ecam_alias, *ecam_reg;
> +    MemoryRegion *mmio32_alias, *mmio64_alias, *mmio_reg;
> +    hwaddr ecam_base =3D ecam_mem->base;
> +    hwaddr ecam_size =3D ecam_mem->size;
> +    hwaddr pio_base =3D mem_pio->window_offset + pcie_mem->base;
> +    hwaddr pio_size =3D mem_pio->size;
> +    hwaddr mmio32_base =3D mem_mmio32->window_offset + pcie_mem->base;
> +    hwaddr mmio32_size =3D mem_mmio32->size;
> +    hwaddr mmio64_base =3D mem_mmio64->window_offset + pcie_mem->base;
> +    hwaddr mmio64_size =3D mem_mmio64->size;
> +    qemu_irq irq;
> +    char name[16];
> +    int i;
> +
> +    snprintf(name, sizeof(name), "pcie");
> +    object_initialize_child(OBJECT(s), name, gpex_host, TYPE_GPEX_HOST);
> +    dev =3D DEVICE(gpex_host);
> +    obj =3D OBJECT(dev);
> +
> +    object_property_set_uint(obj, PCI_HOST_ECAM_BASE, ecam_base, &error_=
abort);
> +    object_property_set_int(obj, PCI_HOST_ECAM_SIZE, ecam_size, &error_a=
bort);
> +    object_property_set_uint(obj, PCI_HOST_BELOW_4G_MMIO_BASE, mmio32_ba=
se,
> +                             &error_abort);
> +    object_property_set_int(obj, PCI_HOST_BELOW_4G_MMIO_SIZE, mmio32_siz=
e,
> +                            &error_abort);
> +    object_property_set_uint(obj, PCI_HOST_ABOVE_4G_MMIO_BASE, mmio64_ba=
se,
> +                             &error_abort);
> +    object_property_set_int(obj, PCI_HOST_ABOVE_4G_MMIO_SIZE, mmio64_siz=
e,
> +                            &error_abort);
> +    object_property_set_uint(obj, PCI_HOST_PIO_BASE, pio_base, &error_ab=
ort);
> +    object_property_set_int(obj, PCI_HOST_PIO_SIZE, pio_size, &error_abo=
rt);
> +
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> +
> +    ecam_alias =3D g_new0(MemoryRegion, 1);
> +    ecam_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    snprintf(name, sizeof(name), "pcie.ecam");
> +    memory_region_init_alias(ecam_alias, obj, name,
> +                             ecam_reg, 0, ecam_size);
> +    memory_region_add_subregion(mr, ecam_base, ecam_alias);
> +
> +    mmio_reg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +
> +    mmio32_alias =3D g_new0(MemoryRegion, 1);
> +    snprintf(name, sizeof(name), "pcie.mmio32");
> +    memory_region_init_alias(mmio32_alias, obj, name,
> +                             mmio_reg, mmio32_base & 0xffffffffUL, mmio3=
2_size);
> +    memory_region_add_subregion(mr, mmio32_base, mmio32_alias);
> +
> +    mmio64_alias =3D g_new0(MemoryRegion, 1);
> +    snprintf(name, sizeof(name), "pcie.mmio64");
> +    memory_region_init_alias(mmio64_alias, obj, name,
> +                             mmio_reg, mmio64_base, mmio64_size);
> +    memory_region_add_subregion(mr, mmio64_base, mmio64_alias);
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
> +
> +    for (i =3D 0; i < PCI_NUM_PINS; i++) {
> +        irq =3D qdev_get_gpio_in(s->irqchip, legacy_irq + i);
> +
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
> +        gpex_set_irq_num(GPEX_HOST(dev), i, legacy_irq + i);
> +    }
> +
> +    gpex_host->gpex_cfg.bus =3D PCI_HOST_BRIDGE(dev)->bus;
> +}
> +
> +static void gpex_pcie_init(TTAtlantisState *s, MemoryRegion *mr)
> +{
> +    gpex_pcie_init_one(s, &s->gpex_host, mr,
> +                       &s->memmap[TT_ATL_PCIE_ECAM0],
> +                       &s->memmap[TT_ATL_PCIE_MMIO0],
> +                       &s->pcimap[PCIE0_PIO],
> +                       &s->pcimap[PCIE0_MMIO_32],
> +                       &s->pcimap[PCIE0_MMIO_64],
> +                       TT_ATL_PCIE0_INTA_IRQ);
> +}
> +
>  static DeviceState *create_reboot_device(const MemMapEntry *mem)
>  {
>      DeviceState *dev =3D qdev_new(TYPE_PVPANIC_MMIO_DEVICE);
> @@ -517,6 +744,7 @@ static void tt_atlantis_machine_init(MachineState *ma=
chine)
>      int base_hartid =3D 0;
>
>      s->memmap =3D tt_atlantis_memmap;
> +    s->pcimap =3D tt_atlantis_pci_map;
>
>      object_initialize_child(OBJECT(machine), "soc", &s->soc,
>                              TYPE_RISCV_HART_ARRAY);
> @@ -582,6 +810,9 @@ static void tt_atlantis_machine_init(MachineState *ma=
chine)
>      s->fw_cfg =3D create_fw_cfg(&s->memmap[TT_ATL_FW_CFG], machine->smp.=
cpus);
>      rom_set_fw(s->fw_cfg);
>
> +    /* PCIe */
> +    gpex_pcie_init(s, system_memory);
> +
>      /* Reboot and exit */
>      create_reboot_device(&s->memmap[TT_ATL_SYSCON]);
>
> @@ -617,6 +848,7 @@ static void tt_atlantis_machine_class_init(ObjectClas=
s *oc, const void *data)
>      mc->default_cpu_type =3D TYPE_RISCV_CPU_TT_ASCALON;
>      mc->block_default_type =3D IF_VIRTIO;
>      mc->no_cdrom =3D 1;
> +    mc->pci_allow_0_address =3D true;
>      mc->default_ram_id =3D "tt_atlantis.ram";
>  }
>
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0601ae1a7494..f13a05c7b1d1 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -129,6 +129,7 @@ config TENSTORRENT
>      select DEVICE_TREE
>      select RISCV_NUMA
>      select PVPANIC_MMIO
> +    select PCI_EXPRESS_GENERIC_BRIDGE
>      select SERIAL_MM
>      select RISCV_ACLINT
>      select RISCV_APLIC
> --
> 2.47.3
>
>

