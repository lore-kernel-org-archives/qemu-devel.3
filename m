Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C349FE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5N-0005yR-Ch; Mon, 29 Dec 2025 14:39:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4k-0004xS-Ef
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:48 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4h-0000Nv-UO
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:42 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso4444981cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037119; cv=none;
 d=google.com; s=arc-20240605;
 b=YIEhK90GoGYyxXIBBCcwC85pLIvX4dhmrojMbF8u8STGqPJpw77HZgQzDF4ffLdY1l
 7f0jUUC7NNqFGmdBz6dcXmFfRIQrfi8d2MrcyJk35dFVnJ2ecLuBRDlFuHcRFQKpqWdz
 FVP+YBvssT/qilp1fiGZhkGVjLHAUwdpevqC9EOhu0x/F7nKUOIBXv1AmhvI3cIDUa51
 /gfXfUsDiusw9dIH0lslTbyLNDhTxnECsjX6R2RqMLyrODG8YhfSkJMCS/632EIDqc9S
 soMhfhHVVszxhJzdSUakJmw1Ir0a/8YEikRhqiZ4ErnzWq/8PNhALEG6CYafGL6GJpFp
 xc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WNnyQnBuY6fWRl+2LpGm2R49b/18h6Uu6dhhPmk26cE=;
 fh=tzbQ859PukjYHWxKwvqhtlCir60xfK5f10xM2keq0t8=;
 b=BX3DCD4e0dKtElUIOt8RFu4iWK+dqDbIAeYNQMJ9OtxnMYsHX1Tl/ul6q5WuWoSGSd
 DjuIVvbULI3CQKiw6EWY3WTsk8UFUat/t35PjDjSsUk5GrFt8g01Otku2CnObf1OhAB6
 QY9bSRCwx5a/wmeal/QXkVOTd6jRnIzj0HoqjBieuwdMjELSGwOQN2ZgY4GDG91cpLSH
 IQMYgTbKg9jz41j1+WcCbUCJS4auJuhluREhO3iu/ptqUiOSKOsTzoThsyUfEWpP6VPO
 bXIWYRzZpdTrIOaB88N6NcpP+Z7RxJgx+fFLn8BFK8DiKh8WkmqJfCmpl2lLA3LbWkuQ
 xhXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037119; x=1767641919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNnyQnBuY6fWRl+2LpGm2R49b/18h6Uu6dhhPmk26cE=;
 b=Av29aedsi8WqBdGMrJL0dXnVq41kuLINsyVY54XV7pM6bDsbTGUuKD12qrZCIp8arm
 ShasOaDUbM22j00lwl7OznJNK8RJUa/K93ZZC9RxSUynBn2NPX2ck5x0nnDDONaWUvfs
 Nw35f95vVIgeMHB8rXPVP3itSeNkc/d4Xnh8JJhh38+ZiqcZijNP0QEsq+XA7os7K4r9
 b12UbiN8hQQo+1GZwm712jEvZIpB3y/6xdqDd9WZqupXvfbjxpG0urFITTU3esv6+hbN
 6UwGI+xk07+HkufNZfXLIyDV9paCE7Av56JyE3zZSsp0jnBQtYpUHS9cg/+1UVrKZgpi
 lwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037119; x=1767641919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WNnyQnBuY6fWRl+2LpGm2R49b/18h6Uu6dhhPmk26cE=;
 b=U0Q1qDdDKeNF4VrPeG6FtrzchdyZCwUoxEg7kI4dVJaf2bOOcR3lvgZccRwwQNXWMA
 id96pzMaSIyCRySuKvQm6T0DRltBsxft9QBrixGZt61zH82p54uSeOXLT2MhAakplTaD
 DRDcafr/iogUHkGLcuTvLmGdpV8zMvZ4lV484QOyADrBCYcNBfP9g+PzFVc/+3rf0QMA
 CxYepeFYS5YIrG66MjNckOXRk4AHu+ZG0m+iFuGOS5Hh5jHRhElE/6VLr7iGILKf32bc
 CpsRSWqt2yFKumty2NMJXHjGTHHTTSUwBMeboJ0o2qi7g/jQkhDZIYZjpG832IHw31vg
 3EMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1xgP9otltbjaE3mIMJWRIFuQ0YjtTuWnFhDSR+1ktMaEolu6WWwFiCwyef56IHpHtM6OaUy+yqtbN@nongnu.org
X-Gm-Message-State: AOJu0YzhGGzkPnmYvMD2vQefm0Gg/NZgtsQErBUfcqQel6zjoPLJ8YnL
 3q2GJWVtgpEIhwbh0mpz+DsE2EOyXwmF+J5I+1rXOBzUtsZix935pPPD0PsY6GPOq1fxP7agq1E
 0FdxzWDiyHb6sdge07pB60oRW3XFN7y7afa2E53XI
X-Gm-Gg: AY/fxX7GjJdf7VcYfy53oVjjeVb2Sj2QiPJ7aNT0liRqc4XhPr+yNGTM7YkcvGbHZhd
 x0Ka1SAeNwtznS/Y4XiZAermJ3ZtnV1HJykmcMmwVzjZjBSYpk43zvVHKZJ5kZWKVqaU9EOZYNc
 Sh3dT5Bp8idrH6Rv5tMdo/j9PL+yMa74hi6kfMwt/06mppRHvD5nPWUPyk2BMMManQEmvoxtLqp
 Z07sBbMLrROX5jevHI9IRdgmIW+ZOs7PUeowmeqJKJ0nkPBE0YN8JyI3lI97WTiV0zsEbP/65PE
 28tBietGaBT9r/3Q2KBARC88Yg==
X-Google-Smtp-Source: AGHT+IEqalZkovtKOtaa9yF1y0wRpVoGu0gqhSQxaXs/kjWcC2Vub4D/shrKx0M33JQr68hywsu8xNQ5wgSZEs9b0tM=
X-Received: by 2002:a05:622a:58f:b0:4f3:7b37:81b with SMTP id
 d75a77b69052e-4f4e4e600fcmr39230621cf.18.1767037118744; Mon, 29 Dec 2025
 11:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-18-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-18-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:27 -0800
X-Gm-Features: AQt7F2om4NLZ8oqScX-nVsfGRHafBbfW7TN1dncgdtEfPIIDicEJM9J7b3DwRyc
Message-ID: <CA+QoejV26Jeo=YeM5N2GS6B2WARMyzxbNegVEkcfTkabvz34UQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/19] hw/arm/aspeed: Attach SGPIOM device to AST1700
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
> Connect the SGPIOM device to AST1700 model.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>

> ---
>  include/hw/arm/aspeed_ast1700.h |  3 +++
>  hw/arm/aspeed_ast1700.c         | 21 +++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index 7292719dc2..490f2a3b05 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -12,6 +12,7 @@
>  #include "hw/misc/aspeed_scu.h"
>  #include "hw/adc/aspeed_adc.h"
>  #include "hw/gpio/aspeed_gpio.h"
> +#include "hw/gpio/aspeed_sgpio.h"
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "hw/misc/aspeed_ltpi.h"
>  #include "hw/misc/aspeed_pwm.h"
> @@ -19,6 +20,7 @@
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/char/serial-mm.h"
>
> +#define AST1700_SGPIO_NUM            2
>  #define AST1700_WDT_NUM              9
>
>  #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
> @@ -39,6 +41,7 @@ struct AspeedAST1700SoCState {
>      AspeedADCState adc;
>      AspeedSCUState scu;
>      AspeedGPIOState gpio;
> +    AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];
>      AspeedI2CState i2c;
>      AspeedPWMState pwm;
>      AspeedWDTState wdt[AST1700_WDT_NUM];
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index 5a2552aa25..ca0ce4e2c2 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -23,6 +23,8 @@ enum {
>      ASPEED_AST1700_DEV_ADC,
>      ASPEED_AST1700_DEV_SCU,
>      ASPEED_AST1700_DEV_GPIO,
> +    ASPEED_AST1700_DEV_SGPIOM0,
> +    ASPEED_AST1700_DEV_SGPIOM1,
>      ASPEED_AST1700_DEV_I2C,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
> @@ -37,6 +39,8 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {
>      [ASPEED_AST1700_DEV_ADC]       =3D  0x00C00000,
>      [ASPEED_AST1700_DEV_SCU]       =3D  0x00C02000,
>      [ASPEED_AST1700_DEV_GPIO]      =3D  0x00C0B000,
> +    [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,
> +    [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,
>      [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
> @@ -141,6 +145,17 @@ static void aspeed_ast1700_realize(DeviceState *dev,=
 Error **errp)
>      memory_region_add_subregion(&s->iomem,
>                          aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI=
_CTRL],
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi),=
 0));
> +
> +    /* SGPIOM */
> +    for (int i =3D 0; i < AST1700_SGPIO_NUM; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sgpiom[i]), errp)) {
> +            return;
> +        }
> +        memory_region_add_subregion(&s->iomem,
> +                    aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SGPIOM0 =
+ i],
> +                    sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sgpiom[i])=
, 0));
> +    }
> +
>      /* WDT */
>      for (int i =3D 0; i < AST1700_WDT_NUM; i++) {
>          AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> @@ -194,6 +209,12 @@ static void aspeed_ast1700_instance_init(Object *obj=
)
>      object_initialize_child(obj, "ltpi-ctrl",
>                              &s->ltpi, TYPE_ASPEED_LTPI);
>
> +    /* SGPIOM */
> +    for (int i =3D 0; i < AST1700_SGPIO_NUM; i++) {
> +        object_initialize_child(obj, "ioexp-sgpiom[*]", &s->sgpiom[i],
> +                                "aspeed.sgpio-ast2700");
> +    }
> +
>      /* WDT */
>      for (int i =3D 0; i < AST1700_WDT_NUM; i++) {
>          object_initialize_child(obj, "ioexp-wdt[*]",
> --
> 2.43.0
>

