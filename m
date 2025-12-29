Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A56CE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ4T-00045y-I9; Mon, 29 Dec 2025 14:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4F-0003vz-5b
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:12 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4D-0000H9-30
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:10 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso4444651cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037087; cv=none;
 d=google.com; s=arc-20240605;
 b=VmFGWIL/GQcwkibNcjg3G/RAk2Wq8dpEDyIdNDuaaqlQrBfuvdVNae1my6Js6lcl7z
 WV3lCRrGFNllwK9qpR54ixVa7wnidzAx9M7aogM8u5f4+JynENjePuU+MHZ/eEOuGJdB
 50ow7DECNdKbeGu8oNhyN7CafDcisdYTCOfqeVtcmhGexaJy9g8MYUiv50engnz3XRYk
 GHutc++9vBG/IE11w2Fj+Ujrk/7zZRUTx2M1K35rWAiL5l7kkiX6Nf5Ov2SQt9ejOS3g
 vRbPTuYF59P1G042jpnRaxyPZM2cmvMrkL6tk47YRDS/iHBDc5JMToF1at+/TZTASAKG
 bJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zuTJiWk0L++OdECP3jktqysCn72HNQBRFVZi8vZmRxY=;
 fh=iACiGUL9GB09fwN+W+A9UcMj9VWGd7ECr/9Dzn9DWzc=;
 b=T/Om/HijbuodpjCanhYNF5v0uYepqj2g+i8xatlWResLgn4fhd/0ZpY4n5z19/GiUa
 oEy1oC+KCYXu4tNq3XEQMIpZNc3J8Ozs6Za3nJurIWlYsNFLFk8AtYhhMOhbf5ncBXvL
 xTzzpiFBx9hG80zmfhK1+Jp+8foL1KbHXAVsK6k10MCKKtqBmyNvB2gbQMJPEELz+LYv
 6CmVb04PIULY3+06Df1RGe2cWEGHm2dRXWWEzHrq+jFUIjHq7zwyF3G6/tlnh7XCf0IU
 gyMC/37fu64+v/Sn5Pfv+S8OlLv4vrwaRcAdoDMhiOdvMS68HakDIjaVdIUV39CnzYAt
 pb2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037087; x=1767641887; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zuTJiWk0L++OdECP3jktqysCn72HNQBRFVZi8vZmRxY=;
 b=KVLi+a3am9aCt2Tzgg1z9vQVjDeZPm8srhHAyxuX0lpdZaDAPMTRXQ7bbBYigLtQqw
 aCfRKMSB4doY3osdtE0X9KrD1i/kx7W0NDDEf8d71Q/wBcbCgSS1harIwX7l6S28QSgH
 WYgb2/4Bco9MT1o701UR0kj6UP59Gi6T/7tTbtCJ+HBYOtLEs/ynwCCy4Hn8lLF52fbM
 rQledspRK019DuE8/mkEWgNtdiGpxMZoOdJQ3iwjCltmsWdQ9gVtxqMSxb0T+NWhRlP2
 7CJ1xRvkKMuT7L4eb3GzdRltQ9R/nIzczaTRVg6mb4Lt5A0cKNOROuUHKGt/GfBsJTSu
 5tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037087; x=1767641887;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zuTJiWk0L++OdECP3jktqysCn72HNQBRFVZi8vZmRxY=;
 b=Uc50DZI5grtqzXIbcIoNXF3NhjcHavmDUDl+zskkpkPuSFrIumpgmLCp+WBRuF44pG
 xfGf584yElPwXeQSqUy4dp4xH4wSNpOugfbz9GrVNcWGDZS5PUlqcHdQsw5DtFwOTNOv
 rSaEU/xxOg/FrulLjoSnr05HPsi8V16wm1QZaWnA8mxoQOtIRqY9Rqv+x6XScsfL1Bhw
 2NhM65GVO4fncYfdkXy3yDSq6/CCDflVL56As6AVDG+hCWxxZK9hPqaworEXZRx1aEjC
 L/5SUTStpqghvJG42azF8ByFQSIY8bhH4qgAYPLbOg3DvmIhKUm9k3bjndvfbqiWLO4O
 zChw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUO/K1ekDmi1lKYUxD2prcOn1K/09BhzGoWGh+aKnPcUfEWF11bGvML4RwVygabL1pzvTuMTB3cmuZB@nongnu.org
X-Gm-Message-State: AOJu0Yydb2tfrw/HMvUgzVe+9xN1pWetUj99JAFyaqHLGrXte0raP4+r
 kWqOkth5LNjcNdEe1876SYlGlTfab98YIeEJBYye6NRyGjx/uu2SgsXQ0JtbvUN0R15QtFdOmGW
 fak/YfpzolDsyx45AtGIPO4cK4otfw/D3ZXhPj450
X-Gm-Gg: AY/fxX6Vlq7rcRrHdgmX/zMi3ElOa1Z6qRhoOPhxkNDjXfDcv2z7/TTFr+t7csnHAGl
 bDlyGCjdiqOJwccceA4VqBdrc/jIS48w9HPmKJSmZVmuaFu38Ra+IQkOD4mEulyjPfURIXA4VFP
 tDhgp/JVVnx2kjN/8w3qn2m5E+aD+SZ65b7taYE8pHefJTk86oyquCY4XgbRowT94b6zpT19CJV
 7oAkfoV4AgHqngAvbZuq6ejRoAx4zxEPeD4UD/Tw2sMit3ZGc9fyPvpulbF+hBTqDm8EAFJ5WWK
 LOZSucVy4NP7ZM9OoB0CU812Yw==
X-Google-Smtp-Source: AGHT+IGg7vDbpaWDgP0I7HPKJtytO55GbbdrcdtyCzWIr319iyw21CpRPQGJaxT9XUHY8qndw8khYi5ezYf9Wq7ynME=
X-Received: by 2002:ac8:5ad4:0:b0:4ed:b4e3:cfa9 with SMTP id
 d75a77b69052e-4f4e5f73bb3mr34920711cf.5.1767037086885; Mon, 29 Dec 2025
 11:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-7-kane_chen@aspeedtech.com>
 <8d290ffe-351f-4dee-90f0-05dc1d299872@kaod.org>
In-Reply-To: <8d290ffe-351f-4dee-90f0-05dc1d299872@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:55 -0800
X-Gm-Features: AQt7F2pndCu4Eh-PKYuMv8R4soaUtN2IgxEWrjNd4FMSgKvFEIgD5eqRCmg4Gv8
Message-ID: <CA+QoejVUzN0vqyC05R52_jX5vgFcBo0Dxp-91ZDPoff6SBrWsA@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x834.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Wed, Dec 24, 2025 at 2:39=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 12/24/25 02:41, Kane Chen via wrote:
> > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >
> > Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling
> > the propagation of AST1700-originated interrupts to the host SoC.
> >
> > This patch does not implement interrupt sources in AST1700 itself,
> > only the wiring into AST27X0.
> >
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

I agree with the readability notes from Cedric, as for the bus naming,
I feel like that applied to patch 14 more than it does to this one.

>
> Thanks,
>
> C.
>
>
> > ---
> >   include/hw/arm/aspeed_soc.h   |  6 +++-
> >   include/hw/intc/aspeed_intc.h |  2 ++
> >   hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++
> >   hw/intc/aspeed_intc.c         | 60 ++++++++++++++++++++++++++++++++++=
+
> >   4 files changed, 104 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> > index f19bab3457..b051d0eb3a 100644
> > --- a/include/hw/arm/aspeed_soc.h
> > +++ b/include/hw/arm/aspeed_soc.h
> > @@ -58,6 +58,7 @@
> >   #define ASPEED_UARTS_NUM 13
> >   #define ASPEED_JTAG_NUM  2
> >   #define ASPEED_PCIE_NUM  3
> > +#define ASPEED_INTC_NUM  2
> >   #define ASPEED_IOEXP_NUM 2
> >
> >   struct AspeedSoCState {
> > @@ -146,7 +147,8 @@ struct Aspeed27x0SoCState {
> >       AspeedSoCState parent;
> >
> >       ARMCPU cpu[ASPEED_CPUS_NUM];
> > -    AspeedINTCState intc[2];
> > +    AspeedINTCState intc[ASPEED_INTC_NUM];
> > +    AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
> >       GICv3State gic;
> >       MemoryRegion dram_empty;
> >   };
> > @@ -288,6 +290,8 @@ enum {
> >       ASPEED_DEV_LTPI_CTRL2,
> >       ASPEED_DEV_LTPI_IO0,
> >       ASPEED_DEV_LTPI_IO1,
> > +    ASPEED_DEV_IOEXP0_INTCIO,
> > +    ASPEED_DEV_IOEXP1_INTCIO,
> >   };
> >
> >   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> > diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_int=
c.h
> > index 51288384a5..4565bbab84 100644
> > --- a/include/hw/intc/aspeed_intc.h
> > +++ b/include/hw/intc/aspeed_intc.h
> > @@ -15,6 +15,8 @@
> >   #define TYPE_ASPEED_INTC "aspeed.intc"
> >   #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
> >   #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
> > +#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "ast2700-ioexp1"
> > +#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "ast2700-ioexp2"
> >   #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
> >   #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
> >   #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"
> > diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> > index de39a3e7eb..678d4eb6d9 100644
> > --- a/hw/arm/aspeed_ast27x0.c
> > +++ b/hw/arm/aspeed_ast27x0.c
> > @@ -91,7 +91,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
> >       [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,
> >       [ASPEED_DEV_WDT]       =3D  0x14C37000,
> >       [ASPEED_DEV_LTPI_IO0]  =3D  0x30000000,
> > +    [ASPEED_DEV_IOEXP0_INTCIO] =3D 0x30C18000,
> >       [ASPEED_DEV_LTPI_IO1]  =3D  0x50000000,
> > +    [ASPEED_DEV_IOEXP1_INTCIO] =3D 0x50C18000,
> >       [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,
> >       [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,
> >       [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,
> > @@ -511,6 +513,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
> >       object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_270=
0_INTC);
> >       object_initialize_child(obj, "intcio", &a->intc[1],
> >                               TYPE_ASPEED_2700_INTCIO);
> > +    object_initialize_child(obj, "intcioexp0", &a->intcioexp[0],
> > +                            TYPE_ASPEED_2700_INTCIOEXP1);
> > +    object_initialize_child(obj, "intcioexp1", &a->intcioexp[1],
> > +                            TYPE_ASPEED_2700_INTCIOEXP2);
> >
> >       snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
> >       object_initialize_child(obj, "adc", &s->adc, typename);
> > @@ -755,6 +761,22 @@ static void aspeed_soc_ast2700_realize(DeviceState=
 *dev, Error **errp)
> >       aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
> >                       sc->memmap[ASPEED_DEV_INTCIO]);
> >
> > +    /* INTCIOEXP0 */
> > +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[0]), errp)) {
> > +        return;
> > +    }
> > +
> > +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[0]), 0,
> > +                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);
> > +
> > +    /* INTCIOEXP1 */
> > +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[1]), errp)) {
> > +        return;
> > +    }
> > +
> > +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[1]), 0,
> > +                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);
> > +
> >       /* irq sources -> orgates -> INTC */
> >       for (i =3D 0; i < ic->num_inpins; i++) {
> >           qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
> > @@ -1079,6 +1101,21 @@ static void aspeed_soc_ast2700_realize(DeviceSta=
te *dev, Error **errp)
> >           }
> >           sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
> >                           sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
> > +
> > +        icio =3D ASPEED_INTC_GET_CLASS(&a->intcioexp[i]);
> > +        /* INTC_IOEXP internal: orgate[i] -> input[i] */
> > +        for (int j =3D 0; j < icio->num_inpins; j++) {
> > +            irq =3D qdev_get_gpio_in(DEVICE(&a->intcioexp[i]), j);
> > +            qdev_connect_gpio_out(DEVICE(&a->intcioexp[i].orgates[j]),=
 0,
> > +                                  irq);
> > +        }
> > +
> > +        /* INTC_IOEXP output[i] -> INTC0.orgate[0].input[i] */
> > +        for (int j =3D 0; j < icio->num_outpins; j++) {
> > +            irq =3D qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j=
);
> > +            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,
> > +                               irq);
> > +        }
> >       }
> >
> >       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu=
),
> > diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> > index 5cd786dee6..a04005ee7c 100644
> > --- a/hw/intc/aspeed_intc.c
> > +++ b/hw/intc/aspeed_intc.c
> > @@ -924,6 +924,64 @@ static const TypeInfo aspeed_2700_intc_info =3D {
> >       .class_init =3D aspeed_2700_intc_class_init,
> >   };
> >
> > +static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPIN=
S] =3D {
> > +    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> > +    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> > +};
> > +
> > +static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,
> > +                                              const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);
> > +
> > +    dc->desc =3D "ASPEED 2700 IOEXP2 INTC Controller";
> > +    aic->num_lines =3D 32;
> > +    aic->num_inpins =3D 2;
> > +    aic->num_outpins =3D 10;
> > +    aic->mem_size =3D 0x400;
> > +    aic->nr_regs =3D 0x58 >> 2;
> > +    aic->reg_offset =3D 0x100;
> > +    aic->reg_ops =3D &aspeed_intcio_ops;
> > +    aic->irq_table =3D aspeed_2700_intcioexp2_irqs;
> > +    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);
> > +}
> > +
> > +static const TypeInfo aspeed_2700_intcioexp2_info =3D {
> > +    .name =3D TYPE_ASPEED_2700_INTCIOEXP2,
> > +    .parent =3D TYPE_ASPEED_INTC,
> > +    .class_init =3D aspeed_2700_intcioexp2_class_init,
> > +};
> > +
> > +static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPIN=
S] =3D {
> > +    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> > +    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> > +};
> > +
> > +static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,
> > +                                              const void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);
> > +
> > +    dc->desc =3D "ASPEED 2700 IOEXP1 INTC Controller";
> > +    aic->num_lines =3D 32;
> > +    aic->num_inpins =3D 2;
> > +    aic->num_outpins =3D 10;
> > +    aic->mem_size =3D 0x400;
> > +    aic->nr_regs =3D 0x58 >> 2;
> > +    aic->reg_offset =3D 0x100;
> > +    aic->reg_ops =3D &aspeed_intcio_ops;
> > +    aic->irq_table =3D aspeed_2700_intcioexp1_irqs;
> > +    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);
> > +}
> > +
> > +static const TypeInfo aspeed_2700_intcioexp1_info =3D {
> > +    .name =3D TYPE_ASPEED_2700_INTCIOEXP1,
> > +    .parent =3D TYPE_ASPEED_INTC,
> > +    .class_init =3D aspeed_2700_intcioexp1_class_init,
> > +};
> > +
> >   static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] =
=3D {
> >       {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> >       {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> > @@ -1099,6 +1157,8 @@ static void aspeed_intc_register_types(void)
> >       type_register_static(&aspeed_intc_info);
> >       type_register_static(&aspeed_2700_intc_info);
> >       type_register_static(&aspeed_2700_intcio_info);
> > +    type_register_static(&aspeed_2700_intcioexp1_info);
> > +    type_register_static(&aspeed_2700_intcioexp2_info);
> >       type_register_static(&aspeed_2700ssp_intc_info);
> >       type_register_static(&aspeed_2700ssp_intcio_info);
> >       type_register_static(&aspeed_2700tsp_intc_info);
>

