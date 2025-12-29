Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA58AE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5M-0005v6-OH; Mon, 29 Dec 2025 14:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4j-0004xH-Rr
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:48 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4g-0000NX-3m
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:40 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso4444901cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037117; cv=none;
 d=google.com; s=arc-20240605;
 b=KAsIx/gIhto596LRQnca+gzJ1Bg3eNkC8ZJS8FoNy2nEY6qcEdExTUyB1AxNsvmzUD
 XN+Hs5MlHM4KhYyIJFE87w3TF2qseNFigTfx2H4S/J3wcG8m8hHNgSU7xY3P1bieUs/f
 iHPtyor37vqBC8dMU65YiJtxtZYvTc0R/325Yx749m5VcjrDPf8JvC5+W7sKjtRPlkRR
 hhxVRzeQ+68YnqroNOknSwqwwA93NTLW+Z9FzLIZLcdyNlynEHH3S81pYlLa+McRRSL5
 NBG3WI9ILTgEUBipZdrZze02AAdvZdWiFR0/iSPNz/jYAOMIzGXoyKWvBBqGOya8SeLB
 88oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FnS7ZbKw9aNcaKVTwK+oR+E5vW6qeLZ6zAVdP6qoM+I=;
 fh=Oz7ozxdF5wYqW7/I9QKYHNxtiMtZ1quw0hllQA3e6Ko=;
 b=azy5nanxo3/0LhCy3rX0ogsaQi+PhXz6caHtQtQAH3dMiXyi4QDD29obdma/85asnm
 7IErV23V4dNqrX4xxvkowNWfYNji9UgNUSFPJ9Cyf6xG1eBKZ0U9womHW7a8i1RWT/IE
 hw0yZgyBOGi9EFia60Y7omNvc5lJvTO2bNIjlF3Zela6iJcYOTidC5HFieuNbWc0oiRs
 iIv59s5dW4Mz4u5xSlfeh5zEw87PMIdne3PzHkCr0rjMh4F+12f1qVhXoUHp8PH8HyzL
 Uu93lV172osyunuilfG4D3T+3JRDzKLciuqLsIBk4P0f2sf1HNAHMnDsyIyjQ4FBEJyL
 RbAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037117; x=1767641917; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FnS7ZbKw9aNcaKVTwK+oR+E5vW6qeLZ6zAVdP6qoM+I=;
 b=TooNPuuxJoihR7+VU190E/koRQD+1nJxpdJTxbzUGYjgW8iC8slc8YiD9JY0da/c1p
 c1sBtjdeSx69k6iIBb/jbHjgGLgwYmR/9DSn7fxtvUhbuLGBNnX/14CrSjkZ6VnOUDM+
 K1F9/JXRBnTiaovIQfDIzvvc1G89Y+myaZlqQy/0aImhuu0jcetTn2+Y+YO8iCyyFmS5
 doQhyIXP2/yE6osZ9TGFqd8enLeYvH90ZnfG3a+BQQjYx+IL6Ew3qS0d8ip5bje9Ewe6
 cg22NIoAkAy+lBIy6rM9dGEpGEAL4196PoJ6mKRub5YgQGhvnY9pkpHveB3Ol+dNoJUZ
 tnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037117; x=1767641917;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FnS7ZbKw9aNcaKVTwK+oR+E5vW6qeLZ6zAVdP6qoM+I=;
 b=lIqrarLV5XZOK3iSWtVt3cyG061OhvBRUn00rw+Jyt+oPIlKOCpVYSRo+aW2XKiFiT
 aoYWXnGlKNi8drr8rndFMFH7RXLpCF5pg1/WkS5IAUFASK9yR0QffHIm5gRxkF4FlrEo
 qQekdKC0q3SRSwYd4Hr8uLcxpk9bMiAJPHAaDgQ2P34HpNNn236lgBbBbX3BWM7qYwpu
 LR6YBeDRCorytIjl3SXJpbaYUcDR1ckuzSDrh6M5U8GnMW401ecF+AIPcQMnUVbsV03P
 v++BXZSbYZPlA0ERtiTbEjwinTpS9/4UIopleJFpKEiddNvEItRstDXOf7ycqekHJFYL
 uDeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK/PhB8J6WqxgIU775eS7XuH1IBBIF7xw5upu9uYQJPQiMtHxyc8nO0ogMg5OQ5JFmYbNHfmPOhFSC@nongnu.org
X-Gm-Message-State: AOJu0YzK4F5je4DqgOEBzpB5/406z6ctf+o2ul3cWEZwBwLgriopRUGK
 n78an6yek1cH5SFY8QfJI9wedBzh6fGxYS6MFTe48jEEoFGrKA4JGXF4To4ewjUIbmEszV8OIBc
 GCX3HNTlyjgdPEvZgmpibgbxvk/836G1u2wamvhiS
X-Gm-Gg: AY/fxX76arX1dllYLXidO1AYLfmQxU2cXb72zF7qllVxk615Q+w6MhoRvIcCIOPAhL4
 j/z39jgWwkeW3W62Y8HdJM2CqJLwjitSTR/5P7d5pOFhB3fS0rMSldhXg/tgYZXbrG6sTP7QT6i
 S8/LJ1F1UJxV2dxUTITtXAlVACEVh+ec4GoIJSabsi81B+vLzSNGAVhQPmfaDOfFEd8nxjCwWKe
 mPvfQCNjOlbtYTxQDIB/NrRRewzifSS9MIHnYh63t3CSIhMotp2mWx2q1L4hbj11Q0chKFwWEsq
 JA4bZHRQdF6QdUQrF4U+FZtqgu5V46yIypxT
X-Google-Smtp-Source: AGHT+IHlBUruX02pGWaUUIRzvK0SB3P0xjXTQFmZqKxxYH74nvJbudWuwUPYPisF99WI9d6AJp0llK1ZJ748N8NPPfY=
X-Received: by 2002:a05:622a:307:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-4f4e4e2b98bmr40540621cf.14.1767037117052; Mon, 29 Dec 2025
 11:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-17-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-17-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:24 -0800
X-Gm-Features: AQt7F2qnoat-JSv9_B8H8ezIGLpQOxltaU8FQJJhbs05xwmRyDcDUtzKchFOoz4
Message-ID: <CA+QoejUnESJLFqnyfiCV=d3wiBX6n8NnEqE7jAA6S4tbjUOWbw@mail.gmail.com>
Subject: Re: [PATCH v4 16/19] hw/arm/aspeed: Attach PWM device to AST1700 model
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x830.google.com
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

On Tue, Dec 23, 2025 at 5:42=E2=80=AFPM Kane Chen <kane_chen@aspeedtech.com=
> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Connect the PWM device to AST1700 model.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  include/hw/arm/aspeed_ast1700.h |  2 ++
>  hw/arm/aspeed_ast1700.c         | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index f43c0c5475..7292719dc2 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -14,6 +14,7 @@
>  #include "hw/gpio/aspeed_gpio.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "hw/misc/aspeed_ltpi.h"
> +#include "hw/misc/aspeed_pwm.h"
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/char/serial-mm.h"
> @@ -39,6 +40,7 @@ struct AspeedAST1700SoCState {
>      AspeedSCUState scu;
>      AspeedGPIOState gpio;
>      AspeedI2CState i2c;
> +    AspeedPWMState pwm;
>      AspeedWDTState wdt[AST1700_WDT_NUM];
>  };
>
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 9fb84dd159..5a2552aa25 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -18,6 +18,7 @@
>
>  enum {
>      ASPEED_AST1700_DEV_SPI0,
> +    ASPEED_AST1700_DEV_PWM,
>      ASPEED_AST1700_DEV_SRAM,
>      ASPEED_AST1700_DEV_ADC,
>      ASPEED_AST1700_DEV_SCU,
> @@ -31,6 +32,7 @@ enum {
>
>  static const hwaddr aspeed_ast1700_io_memmap[] =3D {
>      [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,
> +    [ASPEED_AST1700_DEV_PWM]       =3D  0x000C0000,
>      [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,
>      [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,
>      [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,
> @@ -124,6 +126,14 @@ static void aspeed_ast1700_realize(DeviceState *dev,=
 Error **errp)
>                          aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I2C]=
,
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i2c), =
0));
>
> +    /* PWM */
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pwm), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_PWM]=
,
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pwm), =
0));
> +
>      /* LTPI controller */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>          return;
> @@ -177,6 +187,9 @@ static void aspeed_ast1700_instance_init(Object *obj)
>      object_initialize_child(obj, "ioexp-i2c[*]", &s->i2c,
>                              "aspeed.i2c-ast2700");
>
> +    /* PWM */
> +    object_initialize_child(obj, "pwm", &s->pwm, TYPE_ASPEED_PWM);
> +
>      /* LTPI controller */
>      object_initialize_child(obj, "ltpi-ctrl",
>                              &s->ltpi, TYPE_ASPEED_LTPI);
> --
> 2.43.0
>

