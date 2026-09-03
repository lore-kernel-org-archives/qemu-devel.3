Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF6DC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AxY-0005WJ-Ap; Thu, 03 Sep 2026 13:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1x2AxW-0005W6-8W
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:10:42 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1x2AxQ-00025Z-Qv
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:10:41 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66e63afda8fso39702d50.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:10:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788455431; cv=none;
 d=google.com; s=arc-20260327;
 b=BnAEkRQmS8PmrHGC6EtI7I27zTdpybNO4ze7ll5/6eeNUOPVlA9q0sHm8z9LPlIZJA
 KlVKLDE3okvEKEh2hg1ZRARMJVVAenmuvHlS9hyDCfmq3GIWdIPuzLoRy/1euUFgPat8
 CZ90YgdJnhuCqtoxo1iOJ1+N9IUYR8vo8+T5fB9na75PV7sxMOOi9U50pCLkCPzz6Cgu
 LJOVoaJFBqQ6RxTFIQtC6gzzDqKg6+CZXXj0Xr/33iuY8V5HB2nO2O4nENfQcHA+NFUR
 10muRc/DLUw+tOZy9SF8G3bkxlTuYZP1uR0gZrND/0XvSjXA9VJuxskgFkSJH6PS07IO
 BkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rMQ5PEE9csDsLkzMcktQnzQ0G1E36vkXdJ16Clec62c=;
 fh=T7GZKU3pqGfZDaVHTkyCxWlgssTqcxXKF3+qSko7WPo=;
 b=YGoM42dXxrKCNu50cTUnqZAspZ3TWjir4G5ifh5shp4m0gAP34s33mtsHOJcoes6IJ
 hfnOEqzII4s1XBWRMf7/MXf6P9Z+4NQFiS4jOTMXI+t1kjKynGTsssvNgB15GtuIThu2
 UQrR9AQrg7VqDUzPNDtYhmBA38/CYYvefX9dD2Ge1bPlPOhYfP/PzAwoOcdv4h7Y1HBr
 s8gvtqzJ5ee8bMYZK4nA57fJCFT4hpdC4VSjNyzW4wuW3wfI9iSbvXSmdo+Hj7rzQVGG
 d6ZyVQmAS3gC9KXG1P5QmUDm1r0GvNW6yD7cAyFzw1e8VEO3j2xnJZFbujlEyNIDiuB/
 BhkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1788455431; x=1789060231; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rMQ5PEE9csDsLkzMcktQnzQ0G1E36vkXdJ16Clec62c=;
 b=XEnLI+4b16NKzEOT0MdRm5o2QWyVio9wWiQ5ewVgA+04/Il0oe5eqx6ZKHjvM5V2TZ
 LysLNASF2xn7HsGrtlcfL0I9oMPpvYo7gyZ4RvOfMNBHQMwiITwD8up+CDK19YWZzmCj
 qRd/s1ANwhZLayIvvChUvt0ZrdqBOlfoaZbG4qL17VGKDLstXaRIGOYRn7sUAT8e7U5W
 IlcWK/Szko7Le73ofJ2u7Ukb2h9SG593Q7oR7nduzpNtXTtrl9SWjOKf09FOFUzThgF7
 Pqw9gkT3hC2g5NwveGwMpuPsDTBKl63BytoeIKTbNHUVbKYyoOEHFgSmny8inQrvlMln
 m9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788455431; x=1789060231;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rMQ5PEE9csDsLkzMcktQnzQ0G1E36vkXdJ16Clec62c=;
 b=S5AAAzFqG8ohTU9AbGWKZBd9V+FUioAk7Kws2KNiEKsFJOEzVxZBnG9OoZd0HtWdPa
 0kYCW1l6q4CMWBdbZKmEUOrz3lmugpnkzsxVIMOSueOmqx+y6U0mK6zUVxvYMdV0ZLIK
 gmqKQ1bz/Oi5SJGqZAoqsEWCOQ9wMN7D7sl+R/EN25jmlH/dNNf61AWLSS575XJtJsLU
 zcb5drfaFnWuhA6TXpyXwqSdcWnfMuU5w6mwvv21TBeC+1zdlbGOKJjy70g1HIJ49V0V
 tuPNMthxPeBYG0Zss79ufqaQI+EEa3sR36guT3RLstjHWFpggwWb3A5qjUE3AfGUfmDO
 wz0Q==
X-Gm-Message-State: AFuF++m/ReuOzX+0Myhjd56f4uw5SLrOXv5r9vNQpANuR3LNyXZub9um
 KAajaGRH1ohfD5+m4tVDw5kRy/6BQv95ffXvSBnc7fGNdMXvjYgPCpmLj97N95J+DnY2QTvGCY5
 DtrjJSDpzy6TgiFw0H/03WNA35CUCs5HsMDXdgCoJ2g==
X-Gm-Gg: AYBFou0qPynVCzAmqgJ79IGWKckf6T5A6tpIT94QKea66Uw1XNxd/I+oK3ANlvmjCRS
 g3WDIgASUgEegAEnS9Wd2q3/JgWMzCylu6IHXt5iX9XPgiARQQ4ugpndZGE/GMEUufLdE6lw4QI
 QTgtsxs/349H0QnErsHmyficXVTPedO7mMpe7MmwcXu8l42AgxLlXgHG28Px5+VijP8WoM7b+8I
 rXljmtwaOjBMPTQK3kbBioGR+hTHEbNrF0P5ft0iXrdptMA8GCO/jrHByaytyCZoeS0R29zlPo8
 +GkKwfWRdcPpFLluGI9yH/udqLJcNUkRqAKfbycsua44vg+0u5c2MNg5JuopqUf9gbpu9t+RqB4
 =
X-Received: by 2002:a05:690e:4419:b0:66f:a87e:4f2 with SMTP id
 956f58d0204a3-66fb59d6d77mr39317d50.17.1788455430714; Thu, 03 Sep 2026
 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-atlantis_prcm-v2-0-ffba0b944419@oss.tenstorrent.com>
 <20260817-atlantis_prcm-v2-2-ffba0b944419@oss.tenstorrent.com>
 <CACPK8XcEk4xXDYnY_FSZ7Wud0RQqyLzX_VVA3vXT2q27Z2dn8g@mail.gmail.com>
In-Reply-To: <CACPK8XcEk4xXDYnY_FSZ7Wud0RQqyLzX_VVA3vXT2q27Z2dn8g@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Thu, 3 Sep 2026 12:10:19 -0500
X-Gm-Features: AcwNN1VWLJrd-s74tSaQuZa15t3crwU3mtJDEzqfe41cP9u42YzFgbeB4KENq_U
Message-ID: <CAEev2e9i0evP3MLr_+QjJD9849DRs4M911VeCPxywkrL-z73qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv/tt-atlantis: Add PRCMs to tt-atlantis
 model
To: Joel Stanley <joel@jms.id.au>
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
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-yx1-xb12f.google.com
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

Hi,

On Mon, Aug 31, 2026 at 2:06=E2=80=AFAM Joel Stanley <joel@jms.id.au> wrote=
:
>
> On Tue, 18 Aug 2026 at 00:13, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > Atlantis has 4 PRCMs that are visible from S mode by the Ascalon Core
> > (RCPU, HSIO, PCIe and MM). This commit adds these 4 PRCM blocks to the
> > tt-atlantis model, along with necessary device tree nodes for them.
> >
> > Reviewed-by: Chao Liu <chao.liu@processmission.com>
> > Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> > ---
> >  docs/system/riscv/tt_atlantis.rst |  1 +
> >  hw/riscv/tt_atlantis.c            | 94 +++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/riscv/tt_atlantis.h    | 19 ++++++++
> >  3 files changed, 114 insertions(+)
> >
> > diff --git a/docs/system/riscv/tt_atlantis.rst b/docs/system/riscv/tt_a=
tlantis.rst
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
> > @@ -328,11 +333,35 @@ static void create_fdt_i2c_device(TTAtlantisState=
 *s, int bus,
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
>
> Use the locals, or drop them and use mem->base both times.
>
> > +    g_autofree char *compatible =3D
> > +        g_strdup_printf("tenstorrent,atlantis-prcm-%s", prcm_name);
> > +
> > +    qemu_fdt_add_subnode(fdt, name);
> > +    qemu_fdt_setprop_string(fdt, name, "compatible", compatible);
> > +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, base, 2, size);
> > +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> > +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "#reset-cells", 1);
> > +    qemu_fdt_setprop_cell(fdt, name, "phandle", next_phandle());
>
> If a phandle falls in the woods and nobody...
>
> If you're not saving this value anywhere, is there any need to set one?

Doesn't seem to work if I remove next_phandle(). I get an error at the
qemu_fdt_get_phandle call below like this

qemu-system-riscv64: qemu_fdt_get_phandle: Couldn't get phandle for
/soc/prcm_rcpu@d0000000: <no error>

I think the correct solution would be to use qemu_fdt_alloc_phandle
instead here. That seems to work.

>
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
> >      create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
> > +    create_fdt_clk(fdt, "osc_24m", 24000000, osc_24m_phandle);
>
> With the PRCM enabled the UART and I2C can get a real clock? So we can
> drop the periph-clk node and modify create_fdt_i2c as well as
> create_fdt_uart to use the real PRCM phandles. This will shake out any
> issues with how you're wiring up the device tree too.

Updated.

>
> > +
> > +    g_autofree char *rcpu_name =3D create_fdt_prcm(fdt,
> > +        &s->memmap[TT_ATL_PRCM_RCPU], "rcpu");
> > +    prcm_rcpu_phandle =3D qemu_fdt_get_phandle(fdt, rcpu_name);
>
> This is a great function that I didn't know of when I wrote
> next_phandle(). I'm all for using it, but lets swap the entire file
> over at once.

I would like to keep this series limited to adding the PRCM, this
cleanup can be done in a subsequent series.

>
> > +    qemu_fdt_setprop_cells(fdt, rcpu_name, "clocks", osc_24m_phandle);
> > +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clocks",
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_ROOT,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_NOCC_CLK);
> > +    qemu_fdt_setprop_cells(fdt, rcpu_name, "assigned-clock-parents",
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_RCPU_PLL,
> > +                           prcm_rcpu_phandle, TT_ATL_CLK_NOC_PLL);
>
> > @@ -545,6 +602,43 @@ static void tt_atlantis_machine_init(MachineState =
*machine)
> >      serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
> >                     qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
> >                     115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> > +
> > +    /* Add rcpu prcm block */
> > +    object_initialize_child(OBJECT(s), "prcm-rcpu", &s->prcm[0],
> > +                            TYPE_TT_ATLANTIS_PRCM_RCPU);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->prcm[0]), &error_fatal);
> > +    memory_region_add_subregion(system_memory,
>
> Since you're already sending a v3, can you rebase it on this series pleas=
e:
>
>  https://lore.kernel.org/qemu-riscv/20260831021500.82565-1-joel@jms.id.au=
/
>
> Aside from code shuffling, you will pass s->memory to
> memory_region_add_subregion, the _realize calls go in
> tt_atlantis_soc_realize, and the initalise calls go in
> tt_atlantis_soc_init.

Will do.

>
> > +                                s->memmap[TT_ATL_PRCM_RCPU].base,
> > +                                sysbus_mmio_get_region(
> > +                                    SYS_BUS_DEVICE(&s->prcm[0]), 0));
> > +
>
> > diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlan=
tis.h
> > index 7f7d4a5a59..20bcdfeb52 100644
> > --- a/include/hw/riscv/tt_atlantis.h
> > +++ b/include/hw/riscv/tt_atlantis.h
>
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
>
> Do these come from
> include/dt-bindings/clock/tenstorrent,atlantis-prcm-rcpu.h in linux?
> Add a comment.

Yes.



>
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
> >
> > --
> > 2.43.0
> >

