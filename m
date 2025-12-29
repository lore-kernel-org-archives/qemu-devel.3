Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3107E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5f-0006ds-UD; Mon, 29 Dec 2025 14:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4m-0004zI-DY
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:54 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4k-0000OU-Kf
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:44 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3868221cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037122; cv=none;
 d=google.com; s=arc-20240605;
 b=TGQdoE1n41rp67Wor0AZ8b1GRCPFJxYvnLhuPKX/bp/f2PNgloii+gFMWQlOabWQjM
 2JJxaRaVGoH53MdX/3g/sKkc+vTowK/xS8X1mIFFaG4pBowb+JgHKqCpbVizaVsBYrxc
 YR2T09AfoRfnZSSCdeRlTHDR4KnlI9OilkpXKupls9GGeDSaLZmUeUNb7rtXvEwYjkVq
 eDvtFYOjlJWr+PAbhje54BDoUrdvk2YIig1bGOpPWz9x0QhFtx8jlfltm1zTlqd4IGPS
 CRnZFDMd69USUXt5Ss77MgJznpaVt0fo58uCLwjYnH8/ZTOX6rIuiYpkPxrpLvZi6JPO
 CkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u73m9N8obcpsjMR5nj1DHn9VzepxtitMUFYhJ02aFA8=;
 fh=3E//W1zZheXfh++0cDzLLo1tpmg9IGi3joxXmRyFf78=;
 b=CBcVAGsCF2CXRa3QAFhHa9HRVLWLYCgzSiiAPi384KvRTxDaj9kvW7Q0bBwAy32MIs
 VJeO8RsfCsmNyazEtL6xW1Rj0n4DVz0ALLGZfZULueeIBceBTyAlZyPTkUNX/dBvOKyh
 gbSj1ZvlmkQy4P8hs4++MbLF8LDqNcnkqND5v91TIOcVIZZ4bSqmX9FhpYT7F0lL7fF5
 Po94pmM4BcpVxRtEoZzHyVfv6Zg96R7ObCGw/p6Xbn9KYyucERHyyQEYo0JUvNUeCo8L
 laAN2UL9L/boZLgFgxlLBbLGgM4NkycTdrxpXi/RUSaqYSLJ0rKhPsLNZfReyeCrw98o
 twyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037122; x=1767641922; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u73m9N8obcpsjMR5nj1DHn9VzepxtitMUFYhJ02aFA8=;
 b=psIQZzfa0WBRbS/VHM7ra97h50uuPURdAoYFSk/wLhK6dGfk6PWifzBx+XQXR+4ZRS
 wI71TlXSw52kIv/dHHWfmqifOqe8MFBpXKw2lpRNxGd1v/+nl/UxlUTA32wAKb5rlBEs
 ZknFQRGGNAFmA1IhEEfawmgcgaKzF740a6kqAHWHSfb1WUtsUH+XcSk3GDB8B2fNPFCs
 IL+3s5P2aouwZnnrlNcFiF05mSo/8onYNDTgMwjpeTLd/kIT2byDlmTQ/hD/hcsd4U3n
 MpObNop7ZLW6RzSR+trDf8lTtXP6m0O9SuYLfGPgSXrjj7yOSyPHd/dorkufmTLvvTmk
 0lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037122; x=1767641922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u73m9N8obcpsjMR5nj1DHn9VzepxtitMUFYhJ02aFA8=;
 b=JzxykzHY0Pn04JyFXfvqoxznoVPyiB7G5WSrtNlfLhzrgbGSonEM/42YhNA+IBkJNc
 jnloWFr5ThtaHrvqGtQf/9Mq8SoWuPT3jkx1tamUV7xjpFBhGQo7R2+/ZB9djuwEhI0f
 IQC46kK+wICo/oQxsrGFJ6Q0yw5WNafPAMVjB7eBqew4oN+q+EGTb/+lEmj1/jnERgu7
 T/r9SVJe1CcAFnhJkqq+rZqFvHqJVRgZ80lty0fS49yLrnASXPU536epLR04Kfxg+d3q
 vQcZChFutyJfPTKD3JlrWBxnN6jmzyABFlNj/3sOXM4EO+OZv4VupVYfIMBRIAUodf98
 QVuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEvqLAkPM2hXZ0Lws23TajnOZbt3tBTL3D8a0JcJHYLGfeiHLLqhIP0RWvFcAa3ubZ6t7Z3p6gGTjZ@nongnu.org
X-Gm-Message-State: AOJu0YzhlmwLSW28ZM8lgptSq4fpJLEO/Ggj1S32jdhgZ+BltVfj7u3Q
 gOOd+znk8ignkB5PV36FMC1AqipIq1dYd2MXwnO926JgFZWvupbjuLEL9kMYkt7hh9GBDjbApEP
 EhYTU9BacMSXXDTVVBJ3Yp6T1HAehQHv5mD8sC4Yg
X-Gm-Gg: AY/fxX4QD6AYZT86Aw72LgiWcp2LXaYzZIMmDT/DB34jq03swilEUd0HuyljJ3txatw
 uFBkE+4JpQwz06dcTtACzwlYZ3G4GMBuvaqkQ0JN9P+hnHeu6AsN1bBmgbw7oYXje6HMc9T9EOa
 4BGOoC+POxaTGdTDPJx3vzmCTqKj1SWimOJqfKrFSLM6NEwEmTFZKe7vFTg4b442VMGWvSD0n5x
 u7EFpbqMbcpOVcpfEJtjHgPTakL4TGwx3tQS3OAH9PZEp4jOkw3lJ1XYjNFuOfcLVqH4yItk4v1
 5EaUQ0nE5jh1Bx4X9KAjcXCImw==
X-Google-Smtp-Source: AGHT+IHP+6XviAUcyk8HN805MZK+8O0+3TYVEqx3yNoUoWyRwPny9Fc0nFfu/DncIIlIDuTVe0j4nOQqs2CwBP0NarY=
X-Received: by 2002:ac8:57c2:0:b0:4f0:2e33:81aa with SMTP id
 d75a77b69052e-4f4e5f62fc8mr29427641cf.11.1767037121381; Mon, 29 Dec 2025
 11:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-19-kane_chen@aspeedtech.com>
 <473d4888-83fb-4eb8-8487-14c2521fc331@kaod.org>
In-Reply-To: <473d4888-83fb-4eb8-8487-14c2521fc331@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:30 -0800
X-Gm-Features: AQt7F2oYdFrBeM3Y3fB-nE4ykrEwYRPUHZW4bRmqDoqs6_Hgy8FQ-o0o7usnQhM
Message-ID: <CA+QoejWBKrBfbZfdLa-mT1zgrQWjZzSLCQr6Srj58Rw_yRhRCA@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x833.google.com
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

On Wed, Dec 24, 2025 at 2:43=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 12/24/25 02:41, Kane Chen via wrote:
> > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >
> > AST1700 exposes more I3C buses than the current dummy I3C model
> > provides. When Linux probes the I3C devices on AST1700 this mismatch
> > can trigger a kernel panic. Model the I3C block as an unimplemented
> > device to make the missing functionality explicit and avoid unexpected
> > side effects.
> >
> > This wires up the I3C interrupt lines for the IO expanders and adds the
> > corresponding device entries for the AST1700 model.
> >
> > No functional I3C emulation is provided yet; this only prevents crashes=
 and
> > documents the missing piece.
> >
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


>
> Thanks,
>
> C.
>
> > ---
> >   include/hw/arm/aspeed_ast1700.h |  3 +++
> >   include/hw/arm/aspeed_soc.h     |  2 ++
> >   hw/arm/aspeed_ast1700.c         | 15 +++++++++++++++
> >   hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--
> >   4 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_as=
t1700.h
> > index 490f2a3b05..874b4d63fe 100644
> > --- a/include/hw/arm/aspeed_ast1700.h
> > +++ b/include/hw/arm/aspeed_ast1700.h
> > @@ -19,6 +19,7 @@
> >   #include "hw/ssi/aspeed_smc.h"
> >   #include "hw/watchdog/wdt_aspeed.h"
> >   #include "hw/char/serial-mm.h"
> > +#include "hw/misc/unimp.h"
> >
> >   #define AST1700_SGPIO_NUM            2
> >   #define AST1700_WDT_NUM              9
> > @@ -45,6 +46,8 @@ struct AspeedAST1700SoCState {
> >       AspeedI2CState i2c;
> >       AspeedPWMState pwm;
> >       AspeedWDTState wdt[AST1700_WDT_NUM];
> > +
> > +    UnimplementedDeviceState i3c;
> >   };
> >
> >   #endif /* ASPEED_AST1700_H */
> > diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> > index 4ea2521041..b185b04186 100644
> > --- a/include/hw/arm/aspeed_soc.h
> > +++ b/include/hw/arm/aspeed_soc.h
> > @@ -294,6 +294,8 @@ enum {
> >       ASPEED_DEV_IOEXP1_I2C,
> >       ASPEED_DEV_IOEXP0_INTCIO,
> >       ASPEED_DEV_IOEXP1_INTCIO,
> > +    ASPEED_DEV_IOEXP0_I3C,
> > +    ASPEED_DEV_IOEXP1_I3C,
> >   };
> >
> >   const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> > diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> > index ca0ce4e2c2..5f3c56e6cc 100644
> > --- a/hw/arm/aspeed_ast1700.c
> > +++ b/hw/arm/aspeed_ast1700.c
> > @@ -15,6 +15,7 @@
> >
> >   #define AST2700_SOC_LTPI_SIZE        0x01000000
> >   #define AST1700_SOC_SRAM_SIZE        0x00040000
> > +#define AST1700_SOC_I3C_SIZE         0x00010000
> >
> >   enum {
> >       ASPEED_AST1700_DEV_SPI0,
> > @@ -26,6 +27,7 @@ enum {
> >       ASPEED_AST1700_DEV_SGPIOM0,
> >       ASPEED_AST1700_DEV_SGPIOM1,
> >       ASPEED_AST1700_DEV_I2C,
> > +    ASPEED_AST1700_DEV_I3C,
> >       ASPEED_AST1700_DEV_UART12,
> >       ASPEED_AST1700_DEV_LTPI_CTRL,
> >       ASPEED_AST1700_DEV_WDT,
> > @@ -42,6 +44,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {
> >       [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,
> >       [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,
> >       [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,
> > +    [ASPEED_AST1700_DEV_I3C]       =3D  0x00C20000,
> >       [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
> >       [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
> >       [ASPEED_AST1700_DEV_WDT]       =3D  0x00C37000,
> > @@ -172,6 +175,14 @@ static void aspeed_ast1700_realize(DeviceState *de=
v, Error **errp)
> >                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt=
[i]), 0));
> >       }
> >
> > +    /* I3C */
> > +    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");
> > +    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE=
);
> > +    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);
> > +    memory_region_add_subregion_overlap(&s->iomem,
> > +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3=
C],
> > +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c)=
, 0),
> > +                        -1000);
> >   }
> >
> >   static void aspeed_ast1700_instance_init(Object *obj)
> > @@ -221,6 +232,10 @@ static void aspeed_ast1700_instance_init(Object *o=
bj)
> >                                   &s->wdt[i], "aspeed.wdt-ast2700");
> >       }
> >
> > +    /* I3C */
> > +    object_initialize_child(obj, "ioexp-i3c[*]", &s->i3c,
> > +                            TYPE_UNIMPLEMENTED_DEVICE);
> > +
> >       return;
> >   }
> >
> > diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> > index ca3adf9a50..0807481162 100644
> > --- a/hw/arm/aspeed_ast27x0.c
> > +++ b/hw/arm/aspeed_ast27x0.c
> > @@ -206,7 +206,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D =
{
> >       [ASPEED_DEV_PECI]      =3D 197,
> >       [ASPEED_DEV_SDHCI]     =3D 197,
> >       [ASPEED_DEV_IOEXP0_I2C] =3D 198,
> > +    [ASPEED_DEV_IOEXP0_I3C] =3D 199,
> >       [ASPEED_DEV_IOEXP1_I2C] =3D 200,
> > +    [ASPEED_DEV_IOEXP1_I3C] =3D 201,
> >   };
> >
> >   /* GICINT 128 */
> > @@ -275,12 +277,24 @@ static const int ast2700_gic198_intcmap[] =3D {
> >       [ASPEED_DEV_IOEXP0_I2C]       =3D 0, /* 0 - 15 */
> >   };
> >
> > +/* Primary AST1700 Interrupts */
> > +/* A1: GINTC 199 */
> > +static const int ast2700_gic199_intcmap[] =3D {
> > +    [ASPEED_DEV_IOEXP0_I3C]       =3D 0, /* 0 - 15 */
> > +};
> > +
> >   /* Secondary AST1700 Interrupts */
> >   /* A1: GINTC 200 */
> >   static const int ast2700_gic200_intcmap[] =3D {
> >       [ASPEED_DEV_IOEXP1_I2C]       =3D 0, /* 0 - 15 */
> >   };
> >
> > +/* Secondary AST1700 Interrupts */
> > +/* A1: GINTC 201 */
> > +static const int ast2700_gic201_intcmap[] =3D {
> > +    [ASPEED_DEV_IOEXP1_I3C]       =3D 0, /* 0 - 15 */
> > +};
> > +
> >   /* GICINT 128 ~ 136 */
> >   /* GICINT 192 ~ 201 */
> >   struct gic_intc_irq_info {
> > @@ -298,9 +312,9 @@ static const struct gic_intc_irq_info ast2700_gic_i=
ntcmap[] =3D {
> >       {196, 1, 4, ast2700_gic132_gic196_intcmap},
> >       {197, 1, 5, ast2700_gic133_gic197_intcmap},
> >       {198, 2, 0, ast2700_gic198_intcmap},
> > -    {199, 1, 7, NULL},
> > +    {199, 2, 1, ast2700_gic199_intcmap},
> >       {200, 3, 0, ast2700_gic200_intcmap},
> > -    {201, 1, 9, NULL},
> > +    {201, 3, 1, ast2700_gic201_intcmap},
> >       {128, 0, 1, ast2700_gic128_gic192_intcmap},
> >       {129, 0, 2, NULL},
> >       {130, 0, 3, ast2700_gic130_gic194_intcmap},
>

