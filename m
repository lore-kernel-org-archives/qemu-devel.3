Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7666D3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 21:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSiOy-000218-EW; Mon, 08 Dec 2025 16:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vSiOx-00020f-Md
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 16:04:11 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vSiOv-0002Iy-Mo
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 16:04:11 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4ed67a143c5so135471cf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765227849; x=1765832649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eN8fmjfEXDNyavBz0q8Zx/G62KkjihFyQi8jxd7WKsY=;
 b=3La8whsfeFR2l2JLzA6UUBG0DSltimFg5RdNH1vy3WqWuk0vzyykxE+A+k9zMct28n
 Kz59/PngD0niFBHS5PCNRMxYCXjmH/Te6CCmGgYzRr/VdArPS6+OuoXgpBs924awgN3k
 GVWX418pjG0dGHhDJzoMUtqrkGH07jquJD++8ErJ2WrZ7Mph93y8EuhxaGOTWB7ulTj/
 wxl0GnADNgEUzHbpqLsGhNfjEq/M6/aRf3M70qBC/TMed2awuT/0aMYxMkPh0TW9s83K
 r3RGw5bEsjqgBJarStIjPkRSZU0gCF3MFLvru3GTxPLQPzpP6IOjobVVrSgNI+dbIWlh
 3zGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765227849; x=1765832649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eN8fmjfEXDNyavBz0q8Zx/G62KkjihFyQi8jxd7WKsY=;
 b=Agm4yI928el5NyiTH2Pap6e1c25v91lbvQb3fonUdmeL0Dwg/aj0KTVF7YjQCGxfc2
 fofJPubaSs7b8DVH3flLvhsKEF3BS9cGUO+mHN+j7EqElUdFmd6/Xcac3uBoeOAMGmqj
 tSJSgpV4cg3BjfGQAduWKo5c62tILp4IMpqAwNgCw2X6suXMO3Gk1A6OwqW4FYcIlHA8
 DI6clLFzF54TrHJN9jS2ZH46JcpEJ0SBcOWbdIs8qHesvRoMWuegO+Dz+iz18C96F1yL
 0StHKjeEWNobdeC+M4UJ+21MHf56cutT3MMSUWyKva6Yjkwgcb6H1xO5sVwwuqUS7zDq
 jDTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDo3YQJm03eAqYxx6h0esd0BJRUOERBEHOVAsWqgRZYd4vnnpCkBSHgJ4jaRkSr5Hx+zCgONwdtAym@nongnu.org
X-Gm-Message-State: AOJu0YxLymsuIfVqz0hYZoILOJxR6ZyXkOTzxFpMbn0M1JjXf3r43ZPg
 Qkc7f/PNNfdF/v/a89eNTTjhSDrldZmx2ilHJefwFa6GzOnezARvzhpHX5+fkSvZmsaKnh+VPuw
 Rur8CNNnsf5l7IKars7hGYk6st1GrAooYoraLLOK4
X-Gm-Gg: ASbGncuHwOARxokBJMoXndfDwMWz2Ecv5mpE3SvJAUwun7xEOYQuAVTCsuf3KGyRcVe
 RX7SEYlALPH+xWhOCnbvKnZ8CcyyhbPjOq9oKU2jUy27yP16fb1VI0gAlFfbmaIqIh9iGD8Mquu
 FcvOu3RHRci7VwPwxdFEVcM02Wrl6wDx+aF+p9INwq4ie1PRYzz2s7MWganXz4D8VsWVHal77tY
 tJJ7Uoq6k3zQPxVWQCKGQxJZK/Fv4NpjQum2mop95cJRaU9OsgtpWZMNgawt4MPVPVUBWe26tYK
 e+97MKD7lrO7s8WKC6EH5GgU6w==
X-Google-Smtp-Source: AGHT+IE//gxmDs2Mi3xru8j7aOPW5wZjsUYi4KmDQsKXFT0y79CUYPJ5J1YUwLHdOWuNMSMbgcLFpwlqxajfIzNEIv8=
X-Received: by 2002:ac8:57d3:0:b0:4ed:ff79:e679 with SMTP id
 d75a77b69052e-4f1a5f3875fmr331281cf.19.1765227847872; Mon, 08 Dec 2025
 13:04:07 -0800 (PST)
MIME-Version: 1.0
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-7-kane_chen@aspeedtech.com>
In-Reply-To: <20251208074436.1871180-7-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 8 Dec 2025 13:03:56 -0800
X-Gm-Features: AQt7F2rZmXj2DHfQrYUVTZ9FTdUTf7MvIE66ostGFd9ZO_SK4KEuEP1pCUVULJs
Message-ID: <CA+QoejWMRckxE=GQZ3T0HsjBmv8Ejjax23RATM5bE6UgQZKmog@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] hw/arm/aspeed: Integrate interrupt controller
 for AST1700
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Sun, Dec 7, 2025 at 11:45=E2=80=AFPM Kane Chen via <qemu-devel@nongnu.or=
g> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Connect the AST1700 interrupt lines to the GIC in AST27X0, enabling
> the propagation of AST1700-originated interrupts to the host SoC.
>
> This patch does not implement interrupt sources in AST1700 itself,
> only the wiring into AST27X0.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/arm/aspeed_soc.h   |  6 +++-
>  include/hw/intc/aspeed_intc.h |  2 ++
>  hw/arm/aspeed_ast27x0.c       | 37 +++++++++++++++++++++
>  hw/intc/aspeed_intc.c         | 60 +++++++++++++++++++++++++++++++++++
>  4 files changed, 104 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 63dea86f24..cebd8c21c8 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -58,6 +58,7 @@
>  #define ASPEED_UARTS_NUM 13
>  #define ASPEED_JTAG_NUM  2
>  #define ASPEED_PCIE_NUM  3
> +#define ASPEED_INTC_NUM  2
>  #define ASPEED_IOEXP_NUM 2
>
>  struct AspeedSoCState {
> @@ -146,7 +147,8 @@ struct Aspeed27x0SoCState {
>      AspeedSoCState parent;
>
>      ARMCPU cpu[ASPEED_CPUS_NUM];
> -    AspeedINTCState intc[2];
> +    AspeedINTCState intc[ASPEED_INTC_NUM];
> +    AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
>      GICv3State gic;
>      MemoryRegion dram_empty;
>  };
> @@ -288,6 +290,8 @@ enum {
>      ASPEED_DEV_LTPI_CTRL2,
>      ASPEED_DEV_LTPI_IO0,
>      ASPEED_DEV_LTPI_IO1,
> +    ASPEED_DEV_IOEXP0_INTCIO,
> +    ASPEED_DEV_IOEXP1_INTCIO,
>  };
>
>  const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.=
h
> index 51288384a5..4565bbab84 100644
> --- a/include/hw/intc/aspeed_intc.h
> +++ b/include/hw/intc/aspeed_intc.h
> @@ -15,6 +15,8 @@
>  #define TYPE_ASPEED_INTC "aspeed.intc"
>  #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
>  #define TYPE_ASPEED_2700_INTCIO TYPE_ASPEED_INTC "io-ast2700"
> +#define TYPE_ASPEED_2700_INTCIOEXP1 TYPE_ASPEED_INTC "ast2700-ioexp1"
> +#define TYPE_ASPEED_2700_INTCIOEXP2 TYPE_ASPEED_INTC "ast2700-ioexp2"
>  #define TYPE_ASPEED_2700SSP_INTC TYPE_ASPEED_INTC "-ast2700ssp"
>  #define TYPE_ASPEED_2700SSP_INTCIO TYPE_ASPEED_INTC "io-ast2700ssp"
>  #define TYPE_ASPEED_2700TSP_INTC TYPE_ASPEED_INTC "-ast2700tsp"
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 7d3bede39d..33800dffc5 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -91,7 +91,9 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
>      [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,
>      [ASPEED_DEV_WDT]       =3D  0x14C37000,
>      [ASPEED_DEV_LTPI_IO0]  =3D  0x30000000,
> +    [ASPEED_DEV_IOEXP0_INTCIO] =3D 0x30C18000,
>      [ASPEED_DEV_LTPI_IO1]  =3D  0x50000000,
> +    [ASPEED_DEV_IOEXP1_INTCIO] =3D 0x50C18000,
>      [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,
>      [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,
>      [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,
> @@ -511,6 +513,10 @@ static void aspeed_soc_ast2700_init(Object *obj)
>      object_initialize_child(obj, "intc", &a->intc[0], TYPE_ASPEED_2700_I=
NTC);
>      object_initialize_child(obj, "intcio", &a->intc[1],
>                              TYPE_ASPEED_2700_INTCIO);
> +    object_initialize_child(obj, "intcioexp0", &a->intcioexp[0],
> +                            TYPE_ASPEED_2700_INTCIOEXP1);
> +    object_initialize_child(obj, "intcioexp1", &a->intcioexp[1],
> +                            TYPE_ASPEED_2700_INTCIOEXP2);
>
>      snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
>      object_initialize_child(obj, "adc", &s->adc, typename);
> @@ -755,6 +761,22 @@ static void aspeed_soc_ast2700_realize(DeviceState *=
dev, Error **errp)
>      aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intc[1]), 0,
>                      sc->memmap[ASPEED_DEV_INTCIO]);
>
> +    /* INTCIOEXP0 */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[0]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[0]), 0,
> +                    sc->memmap[ASPEED_DEV_IOEXP0_INTCIO]);
> +
> +    /* INTCIOEXP1 */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intcioexp[1]), errp)) {
> +        return;
> +    }
> +
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->intcioexp[1]), 0,
> +                    sc->memmap[ASPEED_DEV_IOEXP1_INTCIO]);
> +
>      /* irq sources -> orgates -> INTC */
>      for (i =3D 0; i < ic->num_inpins; i++) {
>          qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
> @@ -1079,6 +1101,21 @@ static void aspeed_soc_ast2700_realize(DeviceState=
 *dev, Error **errp)
>          }
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
>                          sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
> +
> +        icio =3D ASPEED_INTC_GET_CLASS(&a->intc[2 + i]);

I'm seeing this fail qtest locally:
runtime error: index 3 out of bounds for type 'AspeedINTCState[2]'
(aka 'struct AspeedINTCState[2]')
Presumably, it's because even though we use `ASPEED_INTC_NUM` to
declare soc->intc, it's only
declaring 2 of them. Should we declare more controllers in intc?

Thanks,
Nabih


> +        /* INTC_IOEXP internal: orgate[i] -> input[i] */
> +        for (int j =3D 0; j < icio->num_inpins; j++) {
> +            irq =3D qdev_get_gpio_in(DEVICE(&a->intcioexp[i]), j);
> +            qdev_connect_gpio_out(DEVICE(&a->intcioexp[i].orgates[j]), 0=
,
> +                                  irq);
> +        }
> +
> +        /* INTC_IOEXP output[i] -> INTC0.orgate[0].input[i] */
> +        for (int j =3D 0; j < icio->num_outpins; j++) {
> +            irq =3D qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), j);
> +            sysbus_connect_irq(SYS_BUS_DEVICE(&a->intcioexp[i]), j,
> +                               irq);
> +        }
>      }
>
>      aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
> diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
> index 5cd786dee6..a04005ee7c 100644
> --- a/hw/intc/aspeed_intc.c
> +++ b/hw/intc/aspeed_intc.c
> @@ -924,6 +924,64 @@ static const TypeInfo aspeed_2700_intc_info =3D {
>      .class_init =3D aspeed_2700_intc_class_init,
>  };
>
> +static AspeedINTCIRQ aspeed_2700_intcioexp2_irqs[ASPEED_INTC_MAX_INPINS]=
 =3D {
> +    {0, 8, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> +    {1, 9, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> +};
> +
> +static void aspeed_2700_intcioexp2_class_init(ObjectClass *klass,
> +                                              const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc =3D "ASPEED 2700 IOEXP2 INTC Controller";
> +    aic->num_lines =3D 32;
> +    aic->num_inpins =3D 2;
> +    aic->num_outpins =3D 10;
> +    aic->mem_size =3D 0x400;
> +    aic->nr_regs =3D 0x58 >> 2;
> +    aic->reg_offset =3D 0x100;
> +    aic->reg_ops =3D &aspeed_intcio_ops;
> +    aic->irq_table =3D aspeed_2700_intcioexp2_irqs;
> +    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp2_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700_intcioexp2_info =3D {
> +    .name =3D TYPE_ASPEED_2700_INTCIOEXP2,
> +    .parent =3D TYPE_ASPEED_INTC,
> +    .class_init =3D aspeed_2700_intcioexp2_class_init,
> +};
> +
> +static AspeedINTCIRQ aspeed_2700_intcioexp1_irqs[ASPEED_INTC_MAX_INPINS]=
 =3D {
> +    {0, 6, 1, R_GICINT192_EN, R_GICINT192_STATUS},
> +    {1, 7, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> +};
> +
> +static void aspeed_2700_intcioexp1_class_init(ObjectClass *klass,
> +                                              const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    AspeedINTCClass *aic =3D ASPEED_INTC_CLASS(klass);
> +
> +    dc->desc =3D "ASPEED 2700 IOEXP1 INTC Controller";
> +    aic->num_lines =3D 32;
> +    aic->num_inpins =3D 2;
> +    aic->num_outpins =3D 10;
> +    aic->mem_size =3D 0x400;
> +    aic->nr_regs =3D 0x58 >> 2;
> +    aic->reg_offset =3D 0x100;
> +    aic->reg_ops =3D &aspeed_intcio_ops;
> +    aic->irq_table =3D aspeed_2700_intcioexp1_irqs;
> +    aic->irq_table_count =3D ARRAY_SIZE(aspeed_2700_intcioexp1_irqs);
> +}
> +
> +static const TypeInfo aspeed_2700_intcioexp1_info =3D {
> +    .name =3D TYPE_ASPEED_2700_INTCIOEXP1,
> +    .parent =3D TYPE_ASPEED_INTC,
> +    .class_init =3D aspeed_2700_intcioexp1_class_init,
> +};
> +
>  static AspeedINTCIRQ aspeed_2700_intcio_irqs[ASPEED_INTC_MAX_INPINS] =3D=
 {
>      {0, 0, 1, R_GICINT192_EN, R_GICINT192_STATUS},
>      {1, 1, 1, R_GICINT193_EN, R_GICINT193_STATUS},
> @@ -1099,6 +1157,8 @@ static void aspeed_intc_register_types(void)
>      type_register_static(&aspeed_intc_info);
>      type_register_static(&aspeed_2700_intc_info);
>      type_register_static(&aspeed_2700_intcio_info);
> +    type_register_static(&aspeed_2700_intcioexp1_info);
> +    type_register_static(&aspeed_2700_intcioexp2_info);
>      type_register_static(&aspeed_2700ssp_intc_info);
>      type_register_static(&aspeed_2700ssp_intcio_info);
>      type_register_static(&aspeed_2700tsp_intc_info);
> --
> 2.43.0
>
>

