Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562A1E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ4K-0003xh-RH; Mon, 29 Dec 2025 14:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ48-0003pp-7O
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:07 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ44-0000Fr-10
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:03 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso4444511cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037079; cv=none;
 d=google.com; s=arc-20240605;
 b=WtzEyxEd+hSHa8g6fiddySH3UpjFgtYkaQ003AW2Cy3P2KQChDd/0bkQPxp/fsjRCq
 TnK/t+N8UgXjqrKqCzBp0ItOfFCaM1qCP+D9wyIgYhI4SpyXZOS9EBg68U0li3ck353C
 odpsqKSgotqW7DQJZGgqbsTKkXQgDrB8Cq/phn/BYQXbeBNqxcw/fzp75BXSETbTRO+h
 FTQF3DnQnOLqy1+UKAfzpH3x9DTTRQCPt3mdpj1ia83rVKv/n5FYxi8cUftISCkFMvZR
 erG4f4KAZ0SWKUF7m2VJTj6JdZ2yDkQlD8sKuS9g7aKCBPvQM6DeAQ0S4X5UIPm+7O7q
 jPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hh+y2I4x1NXXfxMLFLJUYgBIldCrY0BkRVyLCywP4vU=;
 fh=0UZYLQuO3K4oSHt+bxOF4KerxQJ4M7kInQGI6Akg87I=;
 b=ifuJ72SFdB6uw5vCRNl39ISa6cesXMsl7nAlJ+1N3KkmVY1yPTbIPUwxKw1dF65whM
 wmV5RoI4ZqPMG4pS2kS1tUbKY8FtUQzBMCO9K+WFZsZOdvn7jltbWSSQv3mTg4L41RSn
 DQok0vLaqlnno2ZVvija4cyMyZjtinF9cN6HlJ1ad9b9qW0M1onjrsFQFFqIL/s0DHHW
 I8e+HFeQrsqzho1dnDyDCyiTlWnjN34qmZgj+I8OLHymp4AHMu+ax708egVyCWNaxqOt
 7YQT95Rstuyl5PydGmC86dKPiP+Pv15BMdIn+NpWae6KTqj/glMvObrENkO1bzMhT+Gy
 IAGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037079; x=1767641879; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hh+y2I4x1NXXfxMLFLJUYgBIldCrY0BkRVyLCywP4vU=;
 b=r3skAinoqmNIvOHpLjN7myvF7lQwKOR7HMPtqbLHY0Qri+tb1YgFc2LXp/PPJ+1vcr
 HcOPMtjNMCNEArxApf9R39ct9NIbw6h/Dyjt7SZ2s3CWa36yTamkWXwbFPF3W4t0L6Uu
 MfexacoVnh11NHby+GWvoDOKeeLXhZcHk8SnyTyobgHk+MoGE8FgVUo3L2k9hsdTHLoW
 9E0TaGgMMrA/rE7xdUCH+w67GZ5aYX1Lqj0QBZkma00Ccm3JtBH5AQgPeZIcQKFAaweH
 gbFLUSax0ghqsDKrypn6SPbpab6AHmBC/HdqSc5TiszAZBGrw6KHHTPumDJFCZ1mIoWY
 oyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037079; x=1767641879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hh+y2I4x1NXXfxMLFLJUYgBIldCrY0BkRVyLCywP4vU=;
 b=m6x5Vz+Mruc1X3fROTjRPxyk+0ZrYOc2Qez2MwHbMJsfJP3/xlOlZuja0LX7vHCYFd
 OHowfF2I3um5ADajGlXIBjxASYLeUIMEERNb9c+A3F8Ro+EyQjRo2vaJIsGr4VLcxfw6
 TW2Mdxo9U9bmHwBvf5z9ozNSh5ZneEb1p6fM+P2HalQXbXQCQ30X3Lwa7hI35o91PO5w
 lZ9bP7piSzvT5KA3o7VrLreqx7m/8BdPxEmVi7U99RlrXkKpMeh38aJP7hV7kftUnXiz
 IxlKGEC4v/y8SeY7VcBpqlm+9srQfhT0//9x6jjXfMx2xml263r2YnFZHhMCsXV/V8ci
 aegQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPG/m09CMLP1vdBru+9y0aMccILKTGqSdqs4v6CHn7VL1Ec39mxe+MgIoNh16OP18/CbhpHong/98B@nongnu.org
X-Gm-Message-State: AOJu0YwRGMEYMixSCxW3i3Jg0ruHOKNAdIV3D9JZB0gKJMdUr2Yoo3da
 ksjEVV5CTtB3PRAkRdvTopGUm1AJp+GTQSuMNb+/Fu21KZFxq57zEGAk5c/0A0FRFj9xoj89CpX
 kAPndQ5riWZhtiUhlKgNULiZoNJuoI/cMc3EbwYRX
X-Gm-Gg: AY/fxX6x7e0EGVVNSGxp6Bx7xpZR75nhCfhaOlggAQj6PE+oYAeuWL1kH9JPzEPUU1C
 7fa1W2oiqDyVEvSGV7cIpYwnVj2bOkQuBo/qlomI1QNIzG35Bu2dUXi36p/wf8LMpWgordZE7yy
 EcuWv6Hg/FQRMkuJwEN7A8tMOuIeQcZB2fahDg5KOKqUttASVJvSzDmvdZs+u2ENPMWglZu4znM
 aQwi0d8eB03qmmg9a6M836B0Ov7nt1cHJwioOzN6yBS5nKqYt9WgIL4uVkoIhBhqbOaC0en0R0n
 W22G+Dxdj9VuORFG+6C6m/8QsA==
X-Google-Smtp-Source: AGHT+IF6PeYQUrJDoR57gwgl67N/WK0qPSJUZGpCQNZTAq/EpYrMat/9OVgO/ryjrMyfQS9S0TvZTUbdkwMErS9LYVU=
X-Received: by 2002:ac8:5983:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-4f4e4e2b2aamr41070791cf.10.1767037078836; Mon, 29 Dec 2025
 11:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-6-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-6-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:47 -0800
X-Gm-Features: AQt7F2oqqY2oM69j1tsipzNH4KjH7n_aP70jUH1KJunyhyuYGKsgkDr_u7N7jNU
Message-ID: <CA+QoejVaqC9EPEPaTcTkz6-srE-At8xrCtrWTbZr9xiDD+iecA@mail.gmail.com>
Subject: Re: [PATCH v4 05/19] hw/arm/aspeed: Integrate AST1700 device into
 AST27X0
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82b.google.com
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
> Connect the AST1700 device as a child of the AST27X0 model to reflect
> its role in DC-SCM 2.0 LTPI-based architectures. This patch wires
> the AST1700 device into the platform without introducing functional
> peripherals.
>
> This forms the base for LTPI expander emulation in QEMU using
> AST27X0 as the host controller.
>
> Note: ioexp_num is set to 0 at this stage. Once all related devices
> and interrupts are fully implemented, ioexp_num will be updated to
> its expected value. This ensures the machine remains functional at
> every commit and avoids potential compiler or build issues.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> ---
>  include/hw/arm/aspeed_soc.h |  7 +++++--
>  hw/arm/aspeed_ast27x0.c     | 26 ++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 7b08cca908..f19bab3457 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -45,6 +45,7 @@
>  #include "hw/char/serial-mm.h"
>  #include "hw/intc/arm_gicv3.h"
>  #include "hw/misc/aspeed_ltpi.h"
> +#include "hw/arm/aspeed_ast1700.h"
>
>  #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>
> @@ -112,10 +113,10 @@ struct AspeedSoCState {
>      UnimplementedDeviceState dpmcu;
>      UnimplementedDeviceState espi;
>      UnimplementedDeviceState udc;
> -    UnimplementedDeviceState ltpi;
>      UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>      AspeedAPB2OPBState fsi[2];
>      AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
> +    AspeedAST1700SoCState ioexp[ASPEED_IOEXP_NUM];
>  };
>
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -178,6 +179,7 @@ struct AspeedSoCClass {
>      int macs_num;
>      int uarts_num;
>      int uarts_base;
> +    int ioexp_num;
>      const int *irqmap;
>      const hwaddr *memmap;
>      uint32_t num_cpus;
> @@ -190,7 +192,6 @@ enum {
>      ASPEED_DEV_IOMEM,
>      ASPEED_DEV_IOMEM0,
>      ASPEED_DEV_IOMEM1,
> -    ASPEED_DEV_LTPI,
>      ASPEED_DEV_UART0,
>      ASPEED_DEV_UART1,
>      ASPEED_DEV_UART2,
> @@ -285,6 +286,8 @@ enum {
>      ASPEED_DEV_IPC1,
>      ASPEED_DEV_LTPI_CTRL1,
>      ASPEED_DEV_LTPI_CTRL2,
> +    ASPEED_DEV_LTPI_IO0,
> +    ASPEED_DEV_LTPI_IO1,
>  };
>
>  const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 341b53189b..de39a3e7eb 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -26,7 +26,6 @@
>  #define AST2700_SOC_IO_SIZE          0x00FE0000
>  #define AST2700_SOC_IOMEM_SIZE       0x01000000
>  #define AST2700_SOC_DPMCU_SIZE       0x00040000
> -#define AST2700_SOC_LTPI_SIZE        0x01000000
>
>  static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
>      [ASPEED_DEV_VBOOTROM]  =3D  0x00000000,
> @@ -91,7 +90,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
>      [ASPEED_DEV_LTPI_CTRL1] =3D  0x14C34000,
>      [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,
>      [ASPEED_DEV_WDT]       =3D  0x14C37000,
> -    [ASPEED_DEV_LTPI]      =3D  0x30000000,
> +    [ASPEED_DEV_LTPI_IO0]  =3D  0x30000000,
> +    [ASPEED_DEV_LTPI_IO1]  =3D  0x50000000,
>      [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,
>      [ASPEED_DEV_PCIE_MMIO1] =3D 0x80000000,
>      [ASPEED_DEV_PCIE_MMIO2] =3D 0xA0000000,
> @@ -563,10 +563,14 @@ static void aspeed_soc_ast2700_init(Object *obj)
>                                  &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
>      }
>
> +    for (i =3D 0; i < sc->ioexp_num; i++) {
> +        /* AST1700 IOEXP */
> +        object_initialize_child(obj, "ioexp[*]", &s->ioexp[i],
> +                                TYPE_ASPEED_AST1700);
> +    }
> +
>      object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                              TYPE_UNIMPLEMENTED_DEVICE);
> -    object_initialize_child(obj, "ltpi", &s->ltpi,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "iomem", &s->iomem,
>                              TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "iomem0", &s->iomem0,
> @@ -1068,14 +1072,19 @@ static void aspeed_soc_ast2700_realize(DeviceStat=
e *dev, Error **errp)
>          aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_ba=
se);
>      }
>
> +    /* IO Expander */
> +    for (i =3D 0; i < sc->ioexp_num; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->ioexp[i]), errp)) {
> +            return;
> +        }
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ioexp[i]), 0,
> +                        sc->memmap[ASPEED_DEV_LTPI_IO0 + i]);
> +    }
> +
>      aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                    "aspeed.dpmcu",
>                                    sc->memmap[ASPEED_DEV_DPMCU],
>                                    AST2700_SOC_DPMCU_SIZE);
> -    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->ltpi),
> -                                  "aspeed.ltpi",
> -                                  sc->memmap[ASPEED_DEV_LTPI],
> -                                  AST2700_SOC_LTPI_SIZE);
>      aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
>                                    "aspeed.io",
>                                    sc->memmap[ASPEED_DEV_IOMEM],
> @@ -1143,6 +1152,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectC=
lass *oc, const void *data)
>      sc->macs_num     =3D 3;
>      sc->uarts_num    =3D 13;
>      sc->num_cpus     =3D 4;
> +    sc->ioexp_num    =3D 0;
>      sc->uarts_base   =3D ASPEED_DEV_UART0;
>      sc->irqmap       =3D aspeed_soc_ast2700a1_irqmap;
>      sc->memmap       =3D aspeed_soc_ast2700_memmap;
> --
> 2.43.0
>

