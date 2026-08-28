Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351AFC61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 02:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzmSe-0006hu-SA; Thu, 27 Aug 2026 22:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzmSc-0006ef-PU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 22:36:55 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1wzmSa-0005Gx-EX
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 22:36:54 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66d2b3092c1so968034d50.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 19:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787884611; cv=none;
 d=google.com; s=arc-20260327;
 b=KcWKK42Ml3sV2hYyrBw/xYcKXcgPOclIwY5t2ls5jqGYzuclWEM/1g4H871RZn1lNN
 Xew7qSrHz0esMqTy0kZdJGeBu+lcDp567m5mAx1Qdj0h8h5y3fchxS773v6DRFDaaDO3
 n+zmX1CSNRA8VAoanGB0lTJqxrtHjR5jYKXDIGkl4RuRyZ6EBEbipgQOtAYf2Cwlagq8
 Pmr5tVM+L95rn0NXMJrYdB4nDL2Ujzsz/oVp78A1gIEBdTTZt+DizECoQ6zWxiyJvPF+
 8GAnga7w5qryLWKKxokksIxzY3r3ITxmP0hOTA7Hdmy9lBSlYQD5vBp3XdiQZYD1X/IZ
 9nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eMUhk1NtKjJDnuEFhNoFILhv81UQawK+DEqO/UXFrpU=;
 fh=fi6EkmAcHre70J/1/Kpblsy6Abs9eQdzmlytBWwZ2V8=;
 b=RJ/VqLqhXuywY4MyeIBbdRSY3PRI+mO0qH2OolnS5GsfztvLty1CDFu8dAasD6lbOD
 4XyZlOveNR3e3DwMrjNeipJcWhbDKW20ljkNNL7Olcy3pPOvYR/Fqv10k+IE4V0B/y4/
 e72ErtQbr+xIVz66TrxA1A+hEVyQ+eM7oPmIA3AvNZ2Mdm5qsCTmTMzyehqT8jih9shx
 ZFv/OP32x+smxxSHudPPgkoCfQCAOOo5/xakLGxHzhus/PKtJPsOg0he0Bjn37w8YHkb
 yO05sv1noXt61EUl3OG4M9hcox6LQnf+UFADvbD6XQ9VAQDXIdSAoGVmdq5c4NEltewA
 7lBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787884611; x=1788489411; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eMUhk1NtKjJDnuEFhNoFILhv81UQawK+DEqO/UXFrpU=;
 b=R+tPhIa++ad74S8L3a8dRRSlBnAJvatVz+rOLA9KC8dpUeE5MQiJuqA6ND39cTNowi
 powefsNaG2pXuyKp3/6IXhDAN0W0RNNIgZwipU/v1WBPOyK+UfjIPsY/ZU42K1VlyRKZ
 UVx532OnRm3Ffcn7DMR0E2voh9L6JeS/dCF9zN9GjV/dSCpTY148NUTNqJbK/ZzIe7Up
 mF3o7cw1qwxlEK0HrpnAqldpWctx/YwMgSquSIgB9yhAQ8g6QY8eHhRfZ/nvLY5joOzM
 hRtyC/JTo0lbu28cwkJO3sl8pgi91JwHEr9dPXV27aPygEQ1zBaiVA6zjKSfX+InnG3Z
 /W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787884611; x=1788489411;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eMUhk1NtKjJDnuEFhNoFILhv81UQawK+DEqO/UXFrpU=;
 b=ZTkVeJb33wk4AdZ1znvliPf1Agfof/mzqNDlKQp3JGMoMGKKMVyDpllHUoNjDxhBjn
 xq2hyWN3LuZr0P8ueX4VuHqyHVM8/7MxAMu02pIqIgOp0K9xwiBYJFWaIVGxRufD1y2W
 XmU8vs/KJml6BokD034oQkJ4ASU64mjwSufxQh67K/xd/yzekjrL5T78FPIzJZIy5eZe
 gtKCzkX5RkS6IHl0uDbixnfjvY/DxK4g2wt3DFWvvg01fCh3O7DlCzTygHaA4OW0Zefj
 edU5ATt9vMpomVxubKiV+UWqyxjmwBoNakTuZma9Hnerj2aZiTtJpgFZsvwGVKfWLgYd
 ALzw==
X-Gm-Message-State: AFuF++mO1cCKm+0GnOxJJSQ8GkPlayDSVHz1iqmolIM7DhvLSWeeEYJ9
 kZp2fPjUQSiUsI4GiaTGbZaSJTH5rlOyP6zQq7CqIdsRbHnKttr9LmN8GTEehc5NyGK+8gRBZg2
 Qmb86p+FLGhQpNMChI1rUqR13tmKI1U/E7XE0zU4mJw==
X-Gm-Gg: AR+sD11tqhC5UyQu/cgY9ftOLoLgnBPguwLnOA4dbJxkSNgZF28lfhjZYyPz/adYlwN
 GBZ+lrRN0zjRGaI44uSKZEOeDAFYlRqhx27xaHI1Lo1DibEU9bKcsxQ3wyT9ZAYwHUPHeiUTGuZ
 wHFS/FHJ4nfYTQDUEyCbxxAhhzTnTyUFVJan7hnlmR4+F5KjTQDteGdEJhWpOWBLK9H17LgVkoV
 4PH2Bb1Od1u755Xs5W/iBsa+FGIeCBp6cjXjIo7faMfugR8LRzK8N8+TiksPrZGPlElvrvr+BT2
 kROOHtPhZg2uMJetr/heZc0PDFdA8J9oLMi5E5OKT345eU3QYiX+2OanSZWDLbNk7bAEz6vSn0K
 +5yUSb/vl1BI=
X-Received: by 2002:a53:b6c3:0:b0:66c:f8d6:35d5 with SMTP id
 956f58d0204a3-66e4c688234mr782688d50.7.1787884610996; Thu, 27 Aug 2026
 19:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
 <20260817-atlantis_prcm-v2-2-ffba0b944419@oss.tenstorrent.com>
 <82aaa80829eab22a9bd5ee308aa366a93928934c.camel@wdc.com>
In-Reply-To: <82aaa80829eab22a9bd5ee308aa366a93928934c.camel@wdc.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 27 Aug 2026 21:36:40 -0500
X-Gm-Features: AcwNN1XWQJGnUD77Rb3cGugx-VpbnQID9opD1zqZ9K_sFxse7iaKk9Va4T0mtuA
Message-ID: <CAEev2e-zYGvdMD3SrQAwi59gEb_dJFr4fhLpP0Jq36_Zsx_Mbw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "joel@jms.id.au" <joel@jms.id.au>, 
 "npiggin@gmail.com" <npiggin@gmail.com>, 
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "mpe@kernel.org" <mpe@kernel.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>, 
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alistair,

On Thu, Aug 27, 2026 at 9:01=E2=80=AFPM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Mon, 2026-08-17 at 09:42 -0500, Anirudh Srinivasan wrote:
> > Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
> > (RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to
> > the
> > tt-atlantis model, along with necessary device tree nodes for them.
> >
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >  docs/system/riscv/tt_atlantis.rst |  1 +
> >  hw/riscv/tt_atlantis.c            | 94
> > +++++++++++++++++++++++++++++++++++++++
> >  include/hw/riscv/tt_atlantis.h    | 19 ++++++++
> >  3 files changed, 114 insertions(+)
> >
> > diff --git a/docs/system/riscv/tt_atlantis.rst
> > b/docs/system/riscv/tt_atlantis.rst
> > index 1f2880d617..539c22354f 100644
> > --- a/docs/system/riscv/tt_atlantis.rst
> > +++ b/docs/system/riscv/tt_atlantis.rst
> > @@ -14,6 +14,7 @@ tt-atlantis QEMU model features
> >  * 8-core Ascalon-X CPU Cluster
> >  * RISC-V compliant Advanced Interrupt Architecture
> >  * 16550A compatible UART
> > +* 4 PRCMs (Clock and Reset Controllers)
> >
> >  Known limitations
> >  -----------------
> > diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> > index d808bcc11c..9ebba07703 100644
> > --- a/hw/riscv/tt_atlantis.c
> > +++ b/hw/riscv/tt_atlantis.c
> > @@ -26,6 +26,7 @@
> >  #include "hw/char/serial-mm.h"
> >  #include "hw/intc/riscv_aclint.h"
> >  #include "hw/misc/unimp.h"
> > +#include "hw/misc/tt_atlantis_prcm.h"
> >
> >  #include "system/system.h"
> >  #include "system/device_tree.h"
> > @@ -59,6 +60,10 @@ static const MemMapEntry tt_atlantis_memmap[] =3D {
> >      [TT_ATL_I2C3] =3D             { 0xd4070000,       0x10000 },
> >      [TT_ATL_I2C4] =3D             { 0xd4080000,       0x10000 },
> >      [TT_ATL_UART1] =3D            { 0xd4110000,       0x10000 },
> > +    [TT_ATL_PRCM_RCPU] =3D        { 0xd0000000,       0x10000 },
> > +    [TT_ATL_PRCM_PCIE] =3D        { 0xd8000000,         0x100 },
> > +    [TT_ATL_PRCM_MM] =3D          { 0xdc000000,        0x1000 },
> > +    [TT_ATL_PRCM_HSIO] =3D        { 0xe00c0000,         0x510 },
> >      [TT_ATL_SAPLIC] =3D           { 0xe8000000,     0x4000000 },
> >      [TT_ATL_DDR_HI] =3D          { 0x100000000,  0x1000000000 },
> >  };
> > @@ -328,11 +333,35 @@ static void
> > create_fdt_i2c_device(TTAtlantisState *s, int bus,
> >      qemu_fdt_setprop_cell(fdt, name, "reg", addr);
> >  }
> >
> > +static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
> > +                             const char *prcm_name)
> > +{
> > +    hwaddr base =3D mem->base;
> > +    hwaddr size =3D mem->size;
> > +    char *name =3D g_strdup_printf("/soc/prcm_%s@%" PRIx64,
> > +                                 prcm_name, mem->base);
> > +    g_autofree char *compatible =3D
> > +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
> > +
> > +    qemu_fdt_add_subnode(fdt, name);
> > +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> > +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2,
> > size);
> > +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> > +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());
> > +
> > +    return name;
> > +}
> > +
> >  static void finalize_fdt(TTAtlantisState *s)
> >  {
> >      uint32_t aplic_s_phandle =3D next_phandle();
> >      uint32_t imsic_s_phandle =3D next_phandle();
> >      uint32_t periph_clk_phandle =3D next_phandle();
> > +    uint32_t osc_24m_phandle =3D next_phandle();
> > +    uint32_t prcm_rcpu_phandle;
> >      void *fdt =3D MACHINE(s)->fdt;
> >
> >      create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> > @@ -348,6 +377,34 @@ static void finalize_fdt(TTAtlantisState *s)
> >                      aplic_s_phandle);
> >
> >      create_fdt_clk(fdt, "periph-clk", 100000000,
> > periph_clk_phandle);
> > +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
> > +
> > +    g_autofree char *rcpu_name =3D create_fdt_prcm(fdt,
> > +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
>
> Please don't mix code and declarations

Yes, will fix. Checkpatch didn't seem to complain about these.

>
> > +    prcm_rcpu_phandle =3D qemu_fdt_get_phandle(fdt, rcpu_name);
> > +    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks",
> > osc_24m_phandle);
> > +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
> > +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
> > +
> > +    g_autofree char *hsio_name =3D create_fdt_prcm(fdt,
> > +        &s->memmap[TT_ATL_PRCM_HSIO], "hsio");
> > +    qemu_fdt_setprop_cells(fdt, hsio_name, "clocks",
> > osc_24m_phandle,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_HSIO_PLL);
> > +
> > +    g_autofree char *pcie_name =3D create_fdt_prcm(fdt,
> > +        &s->memmap[TT_ATL_PRCM_PCIE], "pcie");
> > +    qemu_fdt_setprop_cells(fdt, pcie_name, "clocks",
> > osc_24m_phandle,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_PCIE_PLL);
> > +
> > +    g_autofree char *mm_name =3D create_fdt_prcm(fdt,
> > +        &s->memmap[TT_ATL_PRCM_MM], "mm");
> > +    qemu_fdt_setprop_cells(fdt, mm_name, "clocks", osc_24m_phandle,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL0,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_MM_PLL1);
> >
> >      for (int i =3D 0; i < TT_ATL_NUM_I2C; i++) {
> >          create_fdt_i2c(fdt,
> > @@ -545,6 +602,43 @@ static void
> > tt_atlantis_machine_init(MachineState *machine)
> >      serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
> >                     qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
> >                     115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> > +
> > +    /* Add rcpu prcm block */
> > +    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
> > +                            TYPE_TT_ATLANTIS_PRCM_RCPU);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
> > +    memory_region_add_subregion(system_memory,
> > +                                s->memmap[TT_ATL_PRCM_RCPU].base,
> > +                                sysbus_mmio_get_region(
> > +                                    SYS_BUS_DEVICE(&s->prcm[0]),
> > 0));
> > +
> > +    /* Add hsio prcm block */
> > +    object_initialize_child(OBJECT(s), "prcm-hsio", &s->prcm[1],
> > +                            TYPE_TT_ATLANTIS_PRCM_HSIO);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[1]), &error_fatal);
> > +    memory_region_add_subregion(system_memory,
> > +                                s->memmap[TT_ATL_PRCM_HSIO].base,
> > +                                sysbus_mmio_get_region(
> > +                                    SYS_BUS_DEVICE(&s->prcm[1]),
> > 0));
> > +
> > +    /* Add pcie prcm block */
> > +    object_initialize_child(OBJECT(s), "prcm-pcie", &s->prcm[2],
> > +                            TYPE_TT_ATLANTIS_PRCM_PCIE);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[2]), &error_fatal);
> > +    memory_region_add_subregion(system_memory,
> > +                                s->memmap[TT_ATL_PRCM_PCIE].base,
> > +                                sysbus_mmio_get_region(
> > +                                    SYS_BUS_DEVICE(&s->prcm[2]),
> > 0));
> > +
> > +    /* Add mm prcm block */
> > +    object_initialize_child(OBJECT(s), "prcm-mm", &s->prcm[3],
> > +                            TYPE_TT_ATLANTIS_PRCM_MM);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[3]), &error_fatal);
> > +    memory_region_add_subregion(system_memory,
> > +                                s->memmap[TT_ATL_PRCM_MM].base,
> > +                                sysbus_mmio_get_region(
> > +                                    SYS_BUS_DEVICE(&s->prcm[3]),
>
> You should be able to use your `PRCM_DOMAIN_*` enums here

Ack.

>
> > 0));
> > +
> >      /*
> >       * Atlantis contains a DesignWare uart while the QEMU machine
> >       * uses the serial_mm model with the base ns16550 register set.
> > diff --git a/include/hw/riscv/tt_atlantis.h
> > b/include/hw/riscv/tt_atlantis.h
> > index 7f7d4a5a59..20bcdfeb52 100644
> > --- a/include/hw/riscv/tt_atlantis.h
> > +++ b/include/hw/riscv/tt_atlantis.h
> > @@ -13,12 +13,14 @@
> >  #include "hw/core/sysbus.h"
> >  #include "hw/i2c/designware_i2c.h"
> >  #include "hw/intc/riscv_imsic.h"
> > +#include "hw/misc/tt_atlantis_prcm.h"
> >  #include "hw/riscv/riscv_hart.h"
> >
> >  #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
> >  OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
> >
> >  #define TT_ATL_NUM_I2C 5
> > +#define TT_ATL_NUM_PRCM 4
>
> What about the other 2?

The other 2 aren't accessible from the Ascalon cores in Atlantis
(which is what we have modelled currently in the qemu machine), so I
haven't mapped them in. They're accessible from another rv32 core in
the soc which is part of the boot flow, and will be mapped in when
that is added to the qemu machine.

>
> Alistair
>
> >
> >  struct TTAtlantisState {
> >      /*< private >*/
> > @@ -31,6 +33,7 @@ struct TTAtlantisState {
> >      RISCVHartArrayState soc;
> >      DeviceState *irqchip;
> >      DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> > +    TTAtlantisPRCMState prcm[TT_ATL_NUM_PRCM];
> >
> >      int fdt_size;
> >  };
> > @@ -59,6 +62,22 @@ enum {
> >      TT_ATL_SAPLIC,
> >      TT_ATL_SIMSIC,
> >      TT_ATL_UART1,
> > +    TT_ATL_PRCM_RCPU,
> > +    TT_ATL_PRCM_HSIO,
> > +    TT_ATL_PRCM_PCIE,
> > +    TT_ATL_PRCM_MM,
> > +};
> > +
> > +/* RCPU PRCM Clock IDs */
> > +enum {
> > +    TT_ATL_CLK_RCPU_PLL =3D 0,
> > +    TT_ATL_CLK_RCPU_ROOT =3D 1,
> > +    TT_ATL_CLK_NOC_PLL =3D 25,
> > +    TT_ATL_CLK_NOCC_CLK =3D 26,
> > +    TT_ATL_CLK_HSIO_PLL =3D 54,
> > +    TT_ATL_CLK_PCIE_PLL =3D 55,
> > +    TT_ATL_CLK_MM_PLL0 =3D 56,
> > +    TT_ATL_CLK_MM_PLL1 =3D 57,
> >  };
> >
> >  #endif

