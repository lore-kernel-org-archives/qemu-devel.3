Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2D8E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5F-00059A-Tv; Mon, 29 Dec 2025 14:39:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4c-0004fp-10
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:34 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4a-0000MV-Cq
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:33 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4f34f257a1bso3264681cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037111; cv=none;
 d=google.com; s=arc-20240605;
 b=asIPfDVv84vpGYm0s1GRxPh1OybCND8O9HER7sGhKJKcqxghipVAiATMS36oSxCvoc
 6wAnH/FMk5MDFNdh71qui0T/ml5W7OJeTCwcH+Rt6Ts52TzT+ZUFQ7MjwkB2Vgg3rgOJ
 PjBhpl2Gk1z5raBs4IMcj4z5x5a2CZNKd5KTmVYBmx83zb5HQrDFXxLPjJtWlKH3PSlP
 eD6cChra8xX9S2QvfCQmnC4p4KexrEKHYWJcWPYCeEBdZDaaRhJ3fFo7aMEK94PyUmNt
 VDh7qqgxj5CAf3NYs93IDwHX6nhvD08A3KEtIiOzcYBame2iK6Frj7Pt9tJ224Xa+yse
 yIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Oxi2gBJaCbN2rdJRawoPOCu6tIaYlgprDHm68pS7cJY=;
 fh=m/sC5CSFKlMbt3+oVSAGCH5NHRF7WCDKvZkYYQpjf5Q=;
 b=M3/GSOdqHMziBFeDCmlqISsqVoYziE8cPMR5lW6xzzCzzfNgz+UMeSVdMLVjrmGqTM
 sLBYWubTT9tUVnFqmTgaF376KelButt8RkbbYwER8KWdU/YhgZZE57pHqEsTfY1aM/TB
 kx+8bBGSFxoCMs+EEiwptoObVyT/844A0Qj8FYtXI8ecCApvr14dP0Q4zaupSLNvYpcp
 /iZYYIe3+4k11+QVSiIIZTyEfchdqPNwCZYKILmI7tDiZGSTZ3ZNq9+4DFIiNGpZyhoO
 IiXu6tzA/Ae5YrYCOB/iwgiV705ZqwKGvCSr5mjHZgkTg0DAm+0V42KfoFtBNhMbQK7e
 4iwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037111; x=1767641911; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oxi2gBJaCbN2rdJRawoPOCu6tIaYlgprDHm68pS7cJY=;
 b=pA7/lOZARW8UVCrMy0Tf/6Yn7lwrTk3cN42hXpQ7IisHUeSN6a/qopyV/8E9MP17bg
 OwGDflZjOzP825y/MypI/E5EvgUuw4BBSc6LsKABztiLE5QE1fqL5JQ5IOo7olLe84Yo
 tS9BTDfl6QUudoG+qt0mlQJKdk+LThuwewrsUVyIXsNMdrqKzCUTXhJxwCSWgwerxV+e
 sZrzVjfSalyN8z9KMpuUxMgsDrZdwuBfcVJwvXEoDgKoBny0yyYPlwoxXDumU+jBbWlt
 8D1yH32QJVEN6BGEbHeiP9io9ott/M7K97Nd1BqRnaGy5/uw5bul6j5n3P0jzCJBVlN/
 K3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037111; x=1767641911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oxi2gBJaCbN2rdJRawoPOCu6tIaYlgprDHm68pS7cJY=;
 b=YH0bK7kpmf8kfhu3wo31i2wT6KENpxgUbSC7/4tVkad6khIiFmV3+AgbsT8OgHq+ej
 NJvF13ycr9fSryCQ91qJ92gBkA/IIVQTqjWc5/D2n4H2rSkzymuRLuh0P2B5RV85zbQV
 pCMwU886/B+uMSVDP+HU5HWitM5rfMN9pIapFLJ5JFiA/8uDY/AZaJanj0zbODvy/87X
 2+4YJs+ESyK+xQzRyjH6zJKkUseUrOwgovzKmakjjoAMZdp6s2N7GVjoxEGsHATqnLZm
 6LYwJ3L66/FbEYImJJK2bZbY3aR31itR5+LmuIUo3yZd18/7JcMfu+3E8EU826MXYhP9
 /G8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjFEbu9yzjK44+rmtSkAqzBFfTuV60Bk23HXA3y5htzpKsqADcnJa+TW8mONONz7WmKo+2MwCJoHdH@nongnu.org
X-Gm-Message-State: AOJu0YzjSGxHDYS6pbHhBe1TBLuKqBaFMaIRFiJD39ORe1J+opGE5Mtm
 widenPoP5CbyNNgVW9SsftwZUxZ5fzq7vr1IjkdjOnfVjuiuwsZS4GoTlh51xoTPdV612ng4qGJ
 Ti7jS/AiNP8tnTy7VxHHouYbwz1emMc4WMCA6ei95
X-Gm-Gg: AY/fxX5rCbX094eWswLjn1ZvnfDqB1b6UXWytSuIQQ+GCumpoNbWA7z3vxzQ5UyH1Mw
 4HQbZWhJt9lfvsM0OVhkZJDJMfpYCUL+tb2UCd4XWHhNZW78P9QyQdmHUddYQ+U4lZAx08gyRc2
 Yu6RL6lh8NEsAsl7rsoYVnGrWK7u98DXxgYZp1l5e8vpAYIrCQktcha6tSWVMauFql4eGHLnt2H
 2pZ1G5mOElrvmcY62FQhlk5ughFOy0B9H7MMsagPkADwZ49hiDRBrG7xZaUyH3tJCoo7t7VABqy
 LgY99AL+CKuLLyckjApWV3aZrA==
X-Google-Smtp-Source: AGHT+IGAf3lHT1MDZvPNru5ZFtAyaf9Z2c3a7lsMQulfUCRBdqtOnpSSHR0gCNPWccwzeqeBKiwFzVREXA2l5d+lAJ8=
X-Received: by 2002:a05:622a:608:b0:4ed:ff79:e678 with SMTP id
 d75a77b69052e-4f4e4e613fcmr28442361cf.18.1767037111207; Mon, 29 Dec 2025
 11:38:31 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-14-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-14-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:20 -0800
X-Gm-Features: AQt7F2olQxxVhN3RObQYLvTXV4LPj0KJ167-hU600MkBpFnwNzE3hg_DSxVezBk
Message-ID: <CA+QoejVH=BqPx6R5LQP+owFEPanLQgxrhTZ4smzP-HJ3N8KF8w@mail.gmail.com>
Subject: Re: [PATCH v4 13/19] hw/arm/aspeed: Attach GPIO device to AST1700
 model
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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

On Tue, Dec 23, 2025 at 5:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Connect the GPIO controller to the AST1700 model by mapping its MMIO
> region and wiring its interrupt line.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> ---
>  include/hw/arm/aspeed_ast1700.h |  2 ++
>  hw/arm/aspeed_ast1700.c         | 14 ++++++++++++++
>  hw/arm/aspeed_ast27x0.c         |  4 ++++
>  3 files changed, 20 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index 12c57145c6..7ea6ff4c1a 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -11,6 +11,7 @@
>  #include "hw/sysbus.h"
>  #include "hw/misc/aspeed_scu.h"
>  #include "hw/adc/aspeed_adc.h"
> +#include "hw/gpio/aspeed_gpio.h"
>  #include "hw/misc/aspeed_ltpi.h"
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/char/serial-mm.h"
> @@ -32,6 +33,7 @@ struct AspeedAST1700SoCState {
>      AspeedSMCState spi;
>      AspeedADCState adc;
>      AspeedSCUState scu;
> +    AspeedGPIOState gpio;
>  };
>
>  #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 6494a5c4eb..9a6019908e 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -21,6 +21,7 @@ enum {
>      ASPEED_AST1700_DEV_SRAM,
>      ASPEED_AST1700_DEV_ADC,
>      ASPEED_AST1700_DEV_SCU,
> +    ASPEED_AST1700_DEV_GPIO,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
>      ASPEED_AST1700_DEV_SPI0_MEM,
> @@ -31,6 +32,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {
>      [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,
>      [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,
>      [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,
> +    [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
>      [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,
> @@ -98,6 +100,14 @@ static void aspeed_ast1700_realize(DeviceState *dev, =
Error **errp)
>                          aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SCU]=
,
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->scu), =
0));
>
> +    /* GPIO */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_GPIO=
],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio),=
 0));
> +
>      /* LTPI controller */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>          return;
> @@ -127,6 +137,10 @@ static void aspeed_ast1700_instance_init(Object *obj=
)
>      object_initialize_child(obj, "ioexp-scu[*]", &s->scu,
>                              TYPE_ASPEED_2700_SCU);
>
> +    /* GPIO */
> +    object_initialize_child(obj, "ioexp-gpio[*]", &s->gpio,
> +                            "aspeed.gpio-ast2700");
> +
>      /* LTPI controller */
>      object_initialize_child(obj, "ltpi-ctrl",
>                              &s->ltpi, TYPE_ASPEED_LTPI);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 6b9ad328dc..d998326536 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -1124,6 +1124,10 @@ static void aspeed_soc_ast2700_realize(DeviceState=
 *dev, Error **errp)
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].adc), 0,
>                             aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_ADC)=
);
>
> +        /* GPIO */
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ioexp[i].gpio), 0,
> +                           aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_GPIO=
));
> +
>      }
>
>      aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
> --
> 2.43.0
>

