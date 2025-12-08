Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E4CD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 18:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSftm-0001vP-V1; Mon, 08 Dec 2025 13:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vSfte-0001uY-Lu
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 13:23:45 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vSfta-0000wt-I7
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 13:23:39 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso23631cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 10:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765218217; x=1765823017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TngJjU+rt7LBYIuK3H9H1XJl8vNMRUXrNRon1o4ZPf0=;
 b=haw4qDPudvd+NR2PXBrj1QzObZhgphPebt0j7iB+ZDV0yyTsMWQobdhfWtFaDWwaNr
 fOtYqM7KS1i8bSGFjhl0Jwr/ejwb1cT5Mf0nM6v4kM9MzWNkSl5gS7/46BGJsSApQgcS
 jm8EPbV9VDDSae3RJscm3kIiEQ6wk3+5AkHWHWACcJk77xjdC6ge8T8C83igm+20EVpX
 EOid2NBoTMmRrXHiWHZsOqFkGs08CA0fsOd2hOpT7lXXi2V2uMCMJDNq7mWFtPLwSj1j
 opPXz5Tx7xqqV6NusBJAa/T0tnTPSAzZEApeWErjCGOH7BZu+a96YqLXkRMrFr6wft7g
 lm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765218217; x=1765823017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TngJjU+rt7LBYIuK3H9H1XJl8vNMRUXrNRon1o4ZPf0=;
 b=D1k+3/UmQMhQ/mHMoCRgFtIqdU4BptdQD8XJbWSbbmCCEn4bFNk4S+8NEpIlaNU/vW
 WD4ZQ+xu1B1PHMX/QIR8XT9nMLKszXCpFq0gf62gH0sulZH1qT+Ea7mqTzD3yhByxTdh
 eU5Q/i7Y7/LVjb+EEEm4WP9vA856aF/PwiBCPTEgf+KuJgCOJEeSkMqWGEDEpiy+dM5p
 rVvleGDc8ptxachGjjiCrR23+uYLvbyANk0ap3Dj0szWWEynFmxmutlk2DICizeu/0Zp
 nQNj/M83sK7QswLE7MGnhmyGPZfqcKkRervkQMDmohTFeJYqkJ/P8vxvGTwglOuYNXQ9
 zcmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOOsbdXFGsBKkGoTwokcXMbOeEmo0utB9b0Laez+K9kBn9C+Kv8pecU2uLT1d01o7BWgJQi5xD1Bn9@nongnu.org
X-Gm-Message-State: AOJu0YzNcw6TlJ9JD/dtDK6xU2L324Y1Lfwf23N9eGdvOjkhCAtedJVE
 YvuTtUF6xeMgYeAxv5Yh1JR5kAOcr4vKpqHJIgUAI5vpdAU6KjE61akABShFEIT/420YsqWDl1Z
 L4NAfnl46BnrhZSrU/Wn4O/CzXS2nY+NVWuxkpyXa
X-Gm-Gg: ASbGncuzqTcAeRwBSHEe/YPvVWWEFGQmddyxFjw3ms5hqHL0LuwX31BBwl+pl5q4B5G
 NDc/DPEAqbSpJ9jEKDN6E3uqOCM5UkabQrCCIG85LMQjs5xmZ5qBqduYnem59dYEHNaNlZEA0k5
 J1vFbFeBBdLu1j5TTlaO7oYfFbwPQq0hupqQgMvIP4qJTgOel3dGA1XclRFlt6TcTlJeIGaUJwB
 e7ijQqX4rig+pLkybAdjwdbNoaWUCiRTKlpR0de9c1wnJwTlRiHTn7VivEZleW2335INknMt6HH
 PTOdUuTBUm6nJjbg/7VxPD383g==
X-Google-Smtp-Source: AGHT+IH54b2qrX68YSATD+uXfy5i8QnamiIezcCRhQUNsa68hnFIDvnlPTqdUCptR5GVdmk6Umka0pRIFpGLEi7NuJg=
X-Received: by 2002:ac8:5fc3:0:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4f1a509ad75mr230411cf.1.1765218217047; Mon, 08 Dec 2025
 10:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-19-kane_chen@aspeedtech.com>
In-Reply-To: <20251208074436.1871180-19-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 8 Dec 2025 10:23:25 -0800
X-Gm-Features: AQt7F2oaqeVTvKjHoWFWc8s3G3YKtd7naTesNOkVq8wD0DukT3bpvtd7RP63ZV4
Message-ID: <CA+QoejU-hpaBce7KoOA0PXBz+DVT1-ZvoyY=mgDPnZLbdZwdHQ@mail.gmail.com>
Subject: Re: [PATCH v3 18/18] hw/arm/aspeed: Model AST1700 I3C block as
 unimplemented device
To: Kane Chen <kane_chen@aspeedtech.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com, Joe Komlodi <komlodi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82f.google.com
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

On Sun, Dec 7, 2025 at 11:47=E2=80=AFPM Kane Chen via <qemu-devel@nongnu.or=
g> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> AST1700 exposes more I3C buses than the current dummy I3C model
> provides. When Linux probes the I3C devices on AST1700 this mismatch
> can trigger a kernel panic. Model the I3C block as an unimplemented
> device to make the missing functionality explicit and avoid unexpected
> side effects.
>
> This wires up the I3C interrupt lines for the IO expanders and adds the
> corresponding device entries for the AST1700 model.
>
> No functional I3C emulation is provided yet; this only prevents crashes a=
nd
> documents the missing piece.

Would you be able to help review Joe Komlodi's I3C support patchset
(link below)?
I think it probably fills in this gap.

(We don't need to block this submission on that landing though)

https://lists.gnu.org/archive/html/qemu-arm/2025-06/msg00403.html
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/arm/aspeed_ast1700.h |  3 +++
>  include/hw/arm/aspeed_soc.h     |  2 ++
>  hw/arm/aspeed_ast1700.c         | 17 +++++++++++++++++
>  hw/arm/aspeed_ast27x0.c         | 18 ++++++++++++++++--
>  4 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index 490f2a3b05..874b4d63fe 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -19,6 +19,7 @@
>  #include "hw/ssi/aspeed_smc.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/char/serial-mm.h"
> +#include "hw/misc/unimp.h"
>
>  #define AST1700_SGPIO_NUM            2
>  #define AST1700_WDT_NUM              9
> @@ -45,6 +46,8 @@ struct AspeedAST1700SoCState {
>      AspeedI2CState i2c;
>      AspeedPWMState pwm;
>      AspeedWDTState wdt[AST1700_WDT_NUM];
> +
> +    UnimplementedDeviceState i3c;
>  };
>
>  #endif /* ASPEED_AST1700_H */
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 602ce3924d..4207887d0f 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -294,6 +294,8 @@ enum {
>      ASPEED_DEV_IOEXP1_I2C,
>      ASPEED_DEV_IOEXP0_INTCIO,
>      ASPEED_DEV_IOEXP1_INTCIO,
> +    ASPEED_DEV_IOEXP0_I3C,
> +    ASPEED_DEV_IOEXP1_I3C,
>  };
>
>  const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index e027ae02ad..67ff278241 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -15,6 +15,7 @@
>
>  #define AST2700_SOC_LTPI_SIZE        0x01000000
>  #define AST1700_SOC_SRAM_SIZE        0x00040000
> +#define AST1700_SOC_I3C_SIZE         0x00010000
>
>  enum {
>      ASPEED_AST1700_DEV_SPI0,
> @@ -26,6 +27,7 @@ enum {
>      ASPEED_AST1700_DEV_SGPIOM0,
>      ASPEED_AST1700_DEV_SGPIOM1,
>      ASPEED_AST1700_DEV_I2C,
> +    ASPEED_AST1700_DEV_I3C,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
>      ASPEED_AST1700_DEV_WDT,
> @@ -42,6 +44,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {
>      [ASPEED_AST1700_DEV_SGPIOM0]   =3D  0x00C0C000,
>      [ASPEED_AST1700_DEV_SGPIOM1]   =3D  0x00C0D000,
>      [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,
> +    [ASPEED_AST1700_DEV_I3C]       =3D  0x00C20000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
>      [ASPEED_AST1700_DEV_WDT]       =3D  0x00C37000,
> @@ -171,6 +174,15 @@ static void aspeed_ast1700_realize(DeviceState *dev,=
 Error **errp)
>                          wdt_offset,
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]=
), 0));
>      }
> +
> +    /* I3C */
> +    qdev_prop_set_string(DEVICE(&s->i3c), "name", "ioexp-i3c");
> +    qdev_prop_set_uint64(DEVICE(&s->i3c), "size", AST1700_SOC_I3C_SIZE);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp);
> +    memory_region_add_subregion_overlap(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_I3C]=
,
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->i3c), =
0),
> +                        -1000);
>  }
>
>  static void aspeed_ast1700_instance_init(Object *obj)
> @@ -219,6 +231,11 @@ static void aspeed_ast1700_instance_init(Object *obj=
)
>          object_initialize_child(obj, "ioexp-wdt[*]",
>                                  &s->wdt[i], "aspeed.wdt-ast2700");
>      }
> +
> +    /* I3C */
> +    object_initialize_child(obj, "ioexp-i3c[*]", &s->i3c,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +
>      return;
>  }
>
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 7433d365a3..5604a5b8e4 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -206,7 +206,9 @@ static const int aspeed_soc_ast2700a1_irqmap[] =3D {
>      [ASPEED_DEV_PECI]      =3D 197,
>      [ASPEED_DEV_SDHCI]     =3D 197,
>      [ASPEED_DEV_IOEXP0_I2C] =3D 198,
> +    [ASPEED_DEV_IOEXP0_I3C] =3D 199,
>      [ASPEED_DEV_IOEXP1_I2C] =3D 200,
> +    [ASPEED_DEV_IOEXP1_I3C] =3D 201,
>  };
>
>  /* GICINT 128 */
> @@ -275,12 +277,24 @@ static const int ast2700_gic198_intcmap[] =3D {
>      [ASPEED_DEV_IOEXP0_I2C]       =3D 0, /* 0 - 15 */
>  };
>
> +/* Primary AST1700 Interrupts */
> +/* A1: GINTC 199 */
> +static const int ast2700_gic199_intcmap[] =3D {
> +    [ASPEED_DEV_IOEXP0_I3C]       =3D 0, /* 0 - 15 */
> +};
> +
>  /* Secondary AST1700 Interrupts */
>  /* A1: GINTC 200 */
>  static const int ast2700_gic200_intcmap[] =3D {
>      [ASPEED_DEV_IOEXP1_I2C]       =3D 0, /* 0 - 15 */
>  };
>
> +/* Secondary AST1700 Interrupts */
> +/* A1: GINTC 201 */
> +static const int ast2700_gic201_intcmap[] =3D {
> +    [ASPEED_DEV_IOEXP1_I3C]       =3D 0, /* 0 - 15 */
> +};
> +
>  /* GICINT 128 ~ 136 */
>  /* GICINT 192 ~ 201 */
>  struct gic_intc_irq_info {
> @@ -298,9 +312,9 @@ static const struct gic_intc_irq_info ast2700_gic_int=
cmap[] =3D {
>      {196, 1, 4, ast2700_gic132_gic196_intcmap},
>      {197, 1, 5, ast2700_gic133_gic197_intcmap},
>      {198, 2, 0, ast2700_gic198_intcmap},
> -    {199, 1, 7, NULL},
> +    {199, 2, 1, ast2700_gic199_intcmap},
>      {200, 3, 0, ast2700_gic200_intcmap},
> -    {201, 1, 9, NULL},
> +    {201, 3, 1, ast2700_gic201_intcmap},
>      {128, 0, 1, ast2700_gic128_gic192_intcmap},
>      {129, 0, 2, NULL},
>      {130, 0, 3, ast2700_gic130_gic194_intcmap},
> --
> 2.43.0
>
>

