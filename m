Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA1DC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0w6C-0002wf-Lp; Mon, 31 Aug 2026 03:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0w68-0002wD-H9
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:06:28 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0w65-0002f3-Tc
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:06:28 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-66f79f58123so533831d50.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788159985; cv=none;
 d=google.com; s=arc-20260327;
 b=LTcaK+pnQfrwY95/vVclExgW/1jSgC7+iZ3LfUtUXyO2pPZPagWHf0892BgB5uo6a4
 xnT1LBYhMbPZopcMpPNLpAtl0yDmrucNBIK/zt+FtlR7tGwHPHDeRGqEbgFrTlKRKHF1
 GklgPM0mEjWNHonVfwhMw5wpMKBX1Pif1jzF4LqSJlhpfLXBLxlhj7bms+HoJLYjgZgr
 9FMDcgoPPTdTs1FYzsw3U8xQIL8LN4ioYyoU214HUbsLeHoX0TopKnmYlkaSMB17S7xu
 xdvrEsy3CReNler9pNuFb0NzmFHZLBJAVrd5OErUlwegY9eJ6s2sdvuoMPoiXTpHq9cm
 v0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vh1sNaFQo/dCNzKzQAqORQc/BQd2gCS7fALdj1uI5Tc=;
 fh=8ik9FFMGHL0a2axiY+q6nxkXql+LJ2KzvU2UfxPrZlE=;
 b=lOexKtHsjT9NZOwgU0qg1fe/1GG0RxlH9Hfg/VhhJlojP1NLUe4QCeSNHhB0oVorQa
 +FJ1dX0PHM6uVDSEbO3MAVKoIFFniCneOnJc9qigMQnOyY2981Yctj3ZQhe24PSxE+uY
 x2QSdN0ekcegBQv26lMH+DY0gjOaqEr1Qp0cAro56APQHZNGMnuF7e0wyBFYJNdyd+6i
 IlLH8tXk2ptLRoMtqo1IR0ivoDZLJJD6a0bMVP8VeIiYkwT020Tk61PSSsm9TtGkaW6r
 VwkweSJ3hlACf6wQum071jAHHUpbrAtakeqUF9XZa/cjql5QAkX8kRuZZAuawqrnYYuK
 Gpwg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788159985; x=1788764785; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vh1sNaFQo/dCNzKzQAqORQc/BQd2gCS7fALdj1uI5Tc=;
 b=TI4ympfGdGs3HYjYB7XjAwnxTmfAwjRi3+vmkrNv1OGInvaWLedZIk7IYm9MN3pT0U
 6kGC/Miaed9jMLe6zm8LvEBBNCMaj2mcKj5eY7dz25xQFVdu+MSMkpL67u9qHy1k7T8e
 sGq+LJVB2ng/yGlingg33KoB2QyoHep5skOcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788159985; x=1788764785;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vh1sNaFQo/dCNzKzQAqORQc/BQd2gCS7fALdj1uI5Tc=;
 b=R7eV2fTRt1BA+zxd09PQWW0IDS8x6ejYlgCBr0/+SbP2gmXmhO/d1Q0OHlT/TmsWRP
 uapzslPndTsx5BAYjnMWYBQ43tjRhpx7ePmtaE6OMfZ8uy33AdzMf7jk3uWDWaaIqy2L
 dtTFAF4QZRxrBznOQ+4I+qpd+chId5Tz2Z61OcW1qeYmEkwZvG3mOKn3m2cVS56V0QPY
 0np9ftCowPeh2JTJHCwMYb2duFEmd/8s1MpCzPIy/i3WonU+o9kbkg1mLHyAg3G6zlnC
 9BBcjHMqQVITlc+ntDvEm6U/zyKXYFAp63k3MIec1UssZqiHjVbxY3qfspJnccGly/5d
 nuhw==
X-Gm-Message-State: AFuF++mJqB+McNw/4DTK1T/qBW3fupAjYvNwyIopYjArfCYSqaJ4O8++
 L02v5iTc2/Xm3pJhNYCWYhGGsoyHudMF+7VrymD0u4An7i7tzytIkj9ph3NuwUPhzxs0TkNUejm
 +YhuNVNDPTnbW2MAMAHmKrxJtMzybwL4=
X-Gm-Gg: AYBFou2zgwb+CD6y68ocHQyvQN7n/4ICotdA5JO7hXbKW16F9lmCl1rswsz2wJpIGL1
 YaoEzkQ1Wp760cF2Pjh5YIEXIIHUdDt15DHSl1mroEjM+PABW7YFum5cz4j1/G1ay8sMgX/S3k1
 IW0safCeng/MzzzdLbv0CYnuPz82MKGhDw+h9obE/p/8eHf47Dno/WjCMmWSVXsboZItV1MN8nJ
 LCGghX++bqEse8oHcb3Bboq9crsiVkZVa3E978QRrpIVXidJBOyQ0h086W6JUWGpTf+MsXuZ+Eq
 J/r+/NzyqU0ton54ep1FS0V9wc4gAIOZTRYjmn7vmsDgmRvx2r1oYqodejC79lBhW2Ong8uJPBy
 YTwEH+CQ99Y3adp6GegZOeU1snPwAkhwvldU3lpl5GSWhgF1GFz8tYBgLEaX6Gh/DZfUPI79Fi7
 TZ+9hOhe9+HJalpJyL
X-Received: by 2002:a05:690e:484a:b0:66c:e38c:599b with SMTP id
 956f58d0204a3-66f8149fb4bmr420201d50.27.1788159984517; Mon, 31 Aug 2026
 00:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
 <20260817-atlantis_prcm-v2-2-ffba0b944419@oss.tenstorrent.com>
In-Reply-To: <20260817-atlantis_prcm-v2-2-ffba0b944419@oss.tenstorrent.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 31 Aug 2026 16:36:13 +0930
X-Gm-Features: AcwNN1UQHQDeZR1BqnATpRxHPdEAXelsS9uswlsu8cEphw3yloymyXlajif9quA
Message-ID: <CACPK8XcEk4xXDYnY_FSZ7Wud0RQqyLzX_VVA3vXT2q27Z2dn8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 18 Aug 2026 at 00:13, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
> (RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to the
> tt-atlantis model, along with necessary device tree nodes for them.
>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
>  docs/system/riscv/tt_atlantis.rst |  1 +
>  hw/riscv/tt_atlantis.c            | 94 +++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/tt_atlantis.h    | 19 ++++++++
>  3 files changed, 114 insertions(+)
>
> diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_atlantis.rst
> index 1f2880d617..539c22354f 100644
> --- a/docs/system/riscv/tt_atlantis.rst
> +++ b/docs/system/riscv/tt_atlantis.rst
> @@ -14,6 +14,7 @@ tt-atlantis QEMU model features
>  * 8-core Ascalon-X CPU Cluster
>  * RISC-V compliant Advanced Interrupt Architecture
>  * 16550A compatible UART
> +* 4 PRCMs (Clock and Reset Controllers)
>
>  Known limitations
>  -----------------
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index d808bcc11c..9ebba07703 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -26,6 +26,7 @@
>  #include "hw/char/serial-mm.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/misc/unimp.h"
> +#include "hw/misc/tt_atlantis_prcm.h"
>
>  #include "system/system.h"
>  #include "system/device_tree.h"
> @@ -59,6 +60,10 @@ static const MemMapEntry tt_atlantis_memmap[] = {
>      [TT_ATL_I2C3] =             { 0xd4070000,       0x10000 },
>      [TT_ATL_I2C4] =             { 0xd4080000,       0x10000 },
>      [TT_ATL_UART1] =            { 0xd4110000,       0x10000 },
> +    [TT_ATL_PRCM_RCPU] =        { 0xd0000000,       0x10000 },
> +    [TT_ATL_PRCM_PCIE] =        { 0xd8000000,         0x100 },
> +    [TT_ATL_PRCM_MM] =          { 0xdc000000,        0x1000 },
> +    [TT_ATL_PRCM_HSIO] =        { 0xe00c0000,         0x510 },
>      [TT_ATL_SAPLIC] =           { 0xe8000000,     0x4000000 },
>      [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
>  };
> @@ -328,11 +333,35 @@ static void create_fdt_i2c_device(TTAtlantisState *s, int bus,
>      qemu_fdt_setprop_cell(fdt, name, "reg", addr);
>  }
>
> +static char *create_fdt_prcm(void *fdt, const MemMapEntry *mem,
> +                             const char *prcm_name)
> +{
> +    hwaddr base = mem->base;
> +    hwaddr size = mem->size;
> +    char *name = g_strdup_printf("/soc/prcm_%s@%" PRIx64,
> +                                 prcm_name, mem->base);

Use the locals, or drop them and use mem->base both times.

> +    g_autofree char *compatible =
> +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());

If a phandle falls in the woods and nobody...

If you're not saving this value anywhere, is there any need to set one?

> +
> +    return name;
> +}
> +
>  static void finalize_fdt(TTAtlantisState *s)
>  {
>      uint32_t aplic_s_phandle = next_phandle();
>      uint32_t imsic_s_phandle = next_phandle();
>      uint32_t periph_clk_phandle = next_phandle();
> +    uint32_t osc_24m_phandle = next_phandle();
> +    uint32_t prcm_rcpu_phandle;
>      void *fdt = MACHINE(s)->fdt;
>
>      create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> @@ -348,6 +377,34 @@ static void finalize_fdt(TTAtlantisState *s)
>                      aplic_s_phandle);
>
>      create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
> +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);

With the PRCM enabled the UART and I2C can get a real clock? So we can
drop the periph-clk node and modify create_fdt_i2c as well as
create_fdt_uart to use the real PRCM phandles. This will shake out any
issues with how you're wiring up the device tree too.

> +
> +    g_autofree char *rcpu_name = create_fdt_prcm(fdt,
> +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
> +    prcm_rcpu_phandle = qemu_fdt_get_phandle(fdt, rcpu_name);

This is a great function that I didn't know of when I wrote
next_phandle(). I'm all for using it, but lets swap the entire file
over at once.

> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
> +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
> +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
> +                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);

> @@ -545,6 +602,43 @@ static void tt_atlantis_machine_init(MachineState *machine)
>      serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
>                     qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
>                     115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> +
> +    /* Add rcpu prcm block */
> +    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
> +                            TYPE_TT_ATLANTIS_PRCM_RCPU);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
> +    memory_region_add_subregion(system_memory,

Since you're already sending a v3, can you rebase it on this series please:

 https://lore.kernel.org/qemu-riscv/20260831021500.82565-1-joel@jms.id.au/

Aside from code shuffling, you will pass s->memory to
memory_region_add_subregion, the _realize calls go in
tt_atlantis_soc_realize, and the initalise calls go in
tt_atlantis_soc_init.

> +                                s->memmap[TT_ATL_PRCM_RCPU].base,
> +                                sysbus_mmio_get_region(
> +                                    SYS_BUS_DEVICE(&s->prcm[0]), 0));
> +

> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 7f7d4a5a59..20bcdfeb52 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h

> @@ -59,6 +62,22 @@ enum {
>      TT_ATL_SAPLIC,
>      TT_ATL_SIMSIC,
>      TT_ATL_UART1,
> +    TT_ATL_PRCM_RCPU,
> +    TT_ATL_PRCM_HSIO,
> +    TT_ATL_PRCM_PCIE,
> +    TT_ATL_PRCM_MM,
> +};
> +
> +/* RCPU PRCM Clock IDs */

Do these come from
include/dt-bindings/clock/tenstorrent,atlantis-prcm-rcpu.h in linux?
Add a comment.

> +enum {
> +    TT_ATL_CLK_RCPU_PLL = 0,
> +    TT_ATL_CLK_RCPU_ROOT = 1,
> +    TT_ATL_CLK_NOC_PLL = 25,
> +    TT_ATL_CLK_NOCC_CLK = 26,
> +    TT_ATL_CLK_HSIO_PLL = 54,
> +    TT_ATL_CLK_PCIE_PLL = 55,
> +    TT_ATL_CLK_MM_PLL0 = 56,
> +    TT_ATL_CLK_MM_PLL1 = 57,
>  };
>
>  #endif
>
> --
> 2.43.0
>

