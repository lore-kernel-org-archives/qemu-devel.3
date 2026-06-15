Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC7CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5qd-0006L0-4b; Mon, 15 Jun 2026 07:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5qX-0006Ju-SR
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:51:19 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5qW-0006gm-2C
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:51:17 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-68d23430690so5943530a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:51:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781524274; cv=none;
 d=google.com; s=arc-20240605;
 b=ARxe1bpTid2b8iTYgD6qewE+CoDzQL6K0aqCtF2IxMmAyRQCuAczRz0xGsu83EB39x
 lPkkZ7ZQTumOt2dtdAxwjciPSd4mDaUK/HkzTSCwULHJLmi+816jF/VlcSrP3QcwuLrj
 P3Szd8MB8tkGoncbL3owdbq/+doCp4Dfsq2fAcMEgc704oo4QG/7n5jUx+hSPxwjWg/3
 z9QKddq82pgvxy2SrfXli0FZXR7fjiQtEyZElehDMrv4ZqYrW0KVLA3LffhtANgRjH/X
 PSjT/DP+gwz8C/OZaOz5C8LylwZvcns5dcOQtC1tje3ftA0IWIqcM9sPfS2bldth/S6U
 yEAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=o8ITxXPVAXJIl7DYU1ZGSTuJwscSmRvrE+T7BLiEatQ=;
 fh=XPY3t+/WD2f+CjBHO2AiDGHiB3I9FX4ygwzosSi5fQY=;
 b=AiplCtRDnIMKD6wPMvNzOo2AR9pKj7qsZMZuxPiiAmBD88Gb/zCqg4mW1LfdNAEeG5
 OYxMyEWaKv4L7YwtCmklikLTIwbIsiI9qJvaHNrqJ6O2fJsip9et6wArVURLjY6qz1/h
 K3BFG4MPvKeeszN+S70LrbXFF7HpliAsREpXh+si9CXZjo4FEbXT/gPfUdFDPpIveRSA
 afrJl4KEEc2ghQVjKT0s43LQbt8yTliZ5uaCt2mql0BVa7lIRA77YkfXk4qrmdF7RQ/1
 rxeg4GV0mHtaj5d+NaKj+O3Eg+VRAyjAe7cGklWf9UhosS2mCCwjTwJALr7yscXNJJuC
 Ot+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781524274; x=1782129074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o8ITxXPVAXJIl7DYU1ZGSTuJwscSmRvrE+T7BLiEatQ=;
 b=sy7A89SD4ppMpKXpiiFNmIXxTyeSHxr2BGkLiUbhUOpqtQF53Ho5/WeVOyaTV/3TFL
 Zp1dyx7X4nrwvL7gAjooeG0YBS8myQMdu8VO+GbbWzZaRUdT8GOoEKWwC4PPpPCHXsZz
 otIzFJFiY00G0sFhG+Sq7jq5ESJ//dmrgyvgJVqwuEB0ykRWzUxalmrZwH9WjZMhAhSf
 nuaZht3TUJlfssMRJGfTBt5+Z5O1m2SlbBjJwymxQn1xsBu2t8s9dCnDSEvoX/Z3d46G
 EiX5LsRV9rvWXviNJbyXvPCQ/mLridRulidTmv1MP6669baELGMZYHVI9rGMr27lXLUM
 SSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524274; x=1782129074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o8ITxXPVAXJIl7DYU1ZGSTuJwscSmRvrE+T7BLiEatQ=;
 b=F3HSL2X8t1C2/OqZR4c74htJHa3amGd6hTCn5uqnIkDOy5MmnHyj6miO6ssrZKTHTw
 gg3mGyWwrkIXgQ7W4wfuxAfzKTVWiL8uFCwAbqI40UzVtw/RdIru+DDSW3Cio6dxFZYD
 o8EPMnQ/r0hmyQniUKVn9hfEdItWlmJ/6qQryU9l0v+skrFwJp/eC4O+TIw91d1f/Yc7
 8J/1ko/Tb0VdjNWwHULHhyiLWDuuIha6hzEPj0xh3ute+xzLgbw9XC/jo64ZaZRmkEze
 UxmE4vg4bCXk/fb3hqF9Fqq25Xeyw/6fOWwS8Q8WltXRPbkwuULW4VLosNLtf/jd4EY1
 8wfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VI6jRcW5tgfXPEK+DvTxl+joDo8Q1Hho9H4T/VfJpyKOzfvHJE45gbZuK71FZt5u/G9QSi1GbFxU5@nongnu.org
X-Gm-Message-State: AOJu0YxPDIJyumeAhP2y26dNe9VjqHk5bqrnk0pQ2pTZcTtBdRaGN0Bn
 r6aXvFzYXtEWnvfgXBbQlRlbVOiR2S67D3FpxjyTmPF94d7BuAAWQX2JgvI/Vx6UEwN927zNtwM
 lnkDC9geer6LKSl0Eifs4jxLa7KF/pQI=
X-Gm-Gg: Acq92OHvkw/2THPeTpLIwzTaVrerIpExFKcBuTyXpmweXZdyJ4XYBHadUU99Yo3kFcD
 gE2Jzu8RmpLRHwyWi8RxrNgyMd+1rCLvGl5kDaw01/sLpl7kIYlRgIjuM1T2sGaFHQGnFTyroUc
 cRk9Jir3yl3hmSrgSv2DeZeHGq+BSaQzdHiDR9GprYFPmjm2oL3aKjxJ13qZcXINJ/evzDy/1qD
 aYwW6GZrnJyz2H1xtgXgDd3kRSX3ZNxy1UfKk6QhgM5vntliqml0D8YfJxSzmwyxLi6EEwoUbmE
 KjZe9/AY
X-Received: by 2002:a05:6402:4496:b0:691:52e1:646 with SMTP id
 4fb4d7f45d1cf-693c6a6af35mr4034562a12.18.1781524274021; Mon, 15 Jun 2026
 04:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-12-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-12-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 21:50:46 +1000
X-Gm-Features: AVVi8Cd4Z5hoiOLfbSTM3T5mJ_azApCWKfSXkUAfBEwTi8duNM8rfTXPK-cBLW4
Message-ID: <CAKmqyKMeMhkUD_uhCXTtXXNJ2fEJNJqQYvuEpYmbWn9D-ubM_w@mail.gmail.com>
Subject: Re: [PATCH v8 11/12] hw/riscv/atlantis: Integrate i2c controllers
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Wed, Jun 3, 2026 at 5:03=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> Add DesignWare I2C controllers to the tt-atlantis machine.
>
> Provide a fixed clock in the device tree so that the Linux driver probes
> without WARNing.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/hw/riscv/tt_atlantis.h | 14 ++++++++
>  hw/riscv/tt_atlantis.c         | 59 ++++++++++++++++++++++++++++++++++
>  hw/riscv/Kconfig               |  1 +
>  3 files changed, 74 insertions(+)
>
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlanti=
s.h
> index a17732ce8114..7f7d4a5a5905 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -11,12 +11,15 @@
>
>  #include "hw/core/boards.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/i2c/designware_i2c.h"
>  #include "hw/intc/riscv_imsic.h"
>  #include "hw/riscv/riscv_hart.h"
>
>  #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>  OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
>
> +#define TT_ATL_NUM_I2C 5
> +
>  struct TTAtlantisState {
>      /*< private >*/
>      MachineState parent;
> @@ -27,11 +30,17 @@ struct TTAtlantisState {
>
>      RISCVHartArrayState soc;
>      DeviceState *irqchip;
> +    DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>
>      int fdt_size;
>  };
>
>  enum {
> +    TT_ATL_I2C0_IRQ =3D 33,
> +    TT_ATL_I2C1_IRQ =3D 34,
> +    TT_ATL_I2C2_IRQ =3D 35,
> +    TT_ATL_I2C3_IRQ =3D 36,
> +    TT_ATL_I2C4_IRQ =3D 37,
>      TT_ATL_UART1_IRQ =3D 39,
>  };
>
> @@ -40,6 +49,11 @@ enum {
>      TT_ATL_BOOTROM,
>      TT_ATL_DDR_LO,
>      TT_ATL_DDR_HI,
> +    TT_ATL_I2C0,
> +    TT_ATL_I2C1,
> +    TT_ATL_I2C2,
> +    TT_ATL_I2C3,
> +    TT_ATL_I2C4,
>      TT_ATL_MAPLIC,
>      TT_ATL_MIMSIC,
>      TT_ATL_SAPLIC,
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 5de138578b48..b1ff0cbe2f61 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -53,6 +53,11 @@ static const MemMapEntry tt_atlantis_memmap[] =3D {
>      [TT_ATL_ACLINT] =3D           { 0xa2180000,       0x10000 },
>      [TT_ATL_SIMSIC] =3D           { 0xa4000000,      0x200000 },
>      [TT_ATL_MAPLIC] =3D           { 0xcc000000,     0x4000000 },
> +    [TT_ATL_I2C0] =3D             { 0xd4040000,       0x10000 },
> +    [TT_ATL_I2C1] =3D             { 0xd4050000,       0x10000 },
> +    [TT_ATL_I2C2] =3D             { 0xd4060000,       0x10000 },
> +    [TT_ATL_I2C3] =3D             { 0xd4070000,       0x10000 },
> +    [TT_ATL_I2C4] =3D             { 0xd4080000,       0x10000 },
>      [TT_ATL_UART1] =3D            { 0xd4110000,       0x10000 },
>      [TT_ATL_SAPLIC] =3D           { 0xe8000000,     0x4000000 },
>      [TT_ATL_DDR_HI] =3D          { 0x100000000,  0x1000000000 },
> @@ -333,10 +338,40 @@ static void create_fdt_rng(void *fdt)
>      qemu_fdt_setprop(fdt, "/chosen", "rng-seed", rng_seed, sizeof(rng_se=
ed));
>  }
>
> +static void create_fdt_clk(void *fdt, const char *clock_name,
> +                           uint32_t freq, uint32_t phandle)
> +{
> +    g_autofree char *name =3D g_strdup_printf("/clocks/%s", clock_name);
> +
> +    qemu_fdt_add_path(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "fixed-clock");
> +    qemu_fdt_setprop_string(fdt, name, "clock-output-names", clock_name)=
;
> +    qemu_fdt_setprop_cell(fdt, name, "#clock-cells", 0);
> +    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", freq);
> +    qemu_fdt_setprop_cell(fdt, name, "phandle", phandle);
> +}
> +
> +static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t i=
rq,
> +                           uint32_t irqchip_phandle, uint32_t clk_phandl=
e)
> +{
> +    g_autofree char *name =3D g_strdup_printf("/soc/i2c@%"HWADDR_PRIX, m=
em->base);
> +
> +    qemu_fdt_add_subnode(fdt, name);
> +    qemu_fdt_setprop_string(fdt, name, "compatible", "snps,designware-i2=
c");
> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg", 2, mem->base, 2, mem-=
>size);
> +    qemu_fdt_setprop_cell(fdt, name, "interrupt-parent", irqchip_phandle=
);
> +    qemu_fdt_setprop_cells(fdt, name, "interrupts", irq, 0x4);
> +    qemu_fdt_setprop_cell(fdt, name, "clocks", clk_phandle);
> +    qemu_fdt_setprop_cell(fdt, name, "clock-frequency", 100000);
> +    qemu_fdt_setprop_cell(fdt, name, "#address-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
> +}
> +
>  static void finalize_fdt(TTAtlantisState *s)
>  {
>      uint32_t aplic_s_phandle =3D next_phandle();
>      uint32_t imsic_s_phandle =3D next_phandle();
> +    uint32_t periph_clk_phandle =3D next_phandle();
>      void *fdt =3D MACHINE(s)->fdt;
>
>      create_fdt_cpu(s, s->memmap, aplic_s_phandle, imsic_s_phandle);
> @@ -350,6 +385,15 @@ static void finalize_fdt(TTAtlantisState *s)
>
>      create_fdt_uart(fdt, &s->memmap[TT_ATL_UART1], TT_ATL_UART1_IRQ,
>                      aplic_s_phandle);
> +
> +    create_fdt_clk(fdt, "periph-clk", 100000000, periph_clk_phandle);
> +
> +    for (int i =3D 0; i < TT_ATL_NUM_I2C; i++) {
> +        create_fdt_i2c(fdt,
> +                       &s->memmap[TT_ATL_I2C0 + i],
> +                       TT_ATL_I2C0_IRQ + i,
> +                       aplic_s_phandle, periph_clk_phandle);
> +    }
>  }
>
>  static void create_fdt(TTAtlantisState *s)
> @@ -581,6 +625,21 @@ static void tt_atlantis_machine_init(MachineState *m=
achine)
>                                  s->memmap[TT_ATL_UART1].base,
>                                  s->memmap[TT_ATL_UART1].size);
>
> +    /* I2C */
> +    for (int i =3D 0; i < TT_ATL_NUM_I2C; i++) {
> +        SysBusDevice *sbd;
> +
> +        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
> +                                TYPE_DESIGNWARE_I2C);
> +        sbd =3D SYS_BUS_DEVICE(&s->i2c[i]);
> +        sysbus_realize(sbd, &error_fatal);
> +        memory_region_add_subregion(system_memory,
> +                                    s->memmap[TT_ATL_I2C0 + i].base,
> +                                    sysbus_mmio_get_region(sbd, 0));
> +        sysbus_connect_irq(sbd, 0,
> +                           qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ =
+ i));
> +    }
> +
>      /* Load or create device tree */
>      if (machine->dtb) {
>          load_fdt(s);
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index aaf029c9ed5e..38180a903fbf 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -129,6 +129,7 @@ config TENSTORRENT
>      select RISCV_IMSIC
>      select SERIAL_MM
>      select DEVICE_TREE
> +    select DESIGNWARE_I2C
>
>  config XIANGSHAN_KUNMINGHU
>      bool
> --
> 2.47.3
>
>

