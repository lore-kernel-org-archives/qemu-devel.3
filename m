Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C0D3E780
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTTB7-0006Df-SJ; Wed, 10 Dec 2025 18:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vTTB6-0006Cz-5F
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:01:00 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vTTB4-0006Wx-GP
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 18:00:59 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso206231cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 15:00:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765407657; cv=none;
 d=google.com; s=arc-20240605;
 b=JJfxF9IUMCp+ykfp1m3Ngycmt4eOjfWocpIQZX9++CczPg+DoUUXwVNEU/vu3umTxz
 yCTwCIEYPxzAQNWp/IDboROciLeMeyWhEwtqcHjcFUQQ7qhIAWXkG41T1UYixVsKcARP
 fP9/ohaxK4cjWw7PQ3pJ2JlYyje7TFnpv9UjcSxAPjM6dNV7oL0pD1fgfYyPkZZY6crY
 m/IMQPqGAlbqf8bgY8YRcBqJ1uEXNEEsXo3gLgtQB6xCxmJudbul3qn/xFpkB+iBQUsw
 qc8Oqk2RBhNO7v7Iam5YLqsztIggcdTQd48PNtt8EAyp5U++nKaS3FF7gU0IRm16B3B3
 IdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Hm0IOTG2G5675/h26bvJU6kW4LaWvamaY/sywK1kIGQ=;
 fh=i39rQfXxW83XsxmnZ6h4+yf1Ky8zS52VoSU+dKqlwio=;
 b=VW3NfeYOAnso7naK8ecsVCutuOV3FlytQ7Z/UTb1MSTLSF1T+pRFUWv8QY+kb1YksH
 NFA/dezyYxWz+9ftJc978HKNjub5F3q3iAlqD0i7/HUVKWa1OLisU4jBvn97ren9qSqj
 zZlFj8oZyNc1OTvnE/NjhdzXF5iMkBkdx1k+hXjRjyI4Lp06GArb4xUqBrow4FzjuMxB
 ysBnsyVV2ZRZWIplDKNp65oh/11U0JYh0e6z7mN+Hcts1qpOBJbbIk3epqNQ8f1OjO8v
 Bgy9nJ9fG0BcLUGtWCcpyGSZwTICAUrtYPG4oFm8sgVXcc0mTtr4BmSJ7TRKHcbN9MhI
 cinw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765407657; x=1766012457; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hm0IOTG2G5675/h26bvJU6kW4LaWvamaY/sywK1kIGQ=;
 b=a5mqwCw0hjI9noyUi37TEbx2yMkdlurAeXJmcY4CGbsz9N9CaM6ZuMPOFogIlDslbi
 dH51FI1kuKR1lkUH5zwP1Z/Ujbpnd4R8HnlQxyIuigCuQxCGpLdgPiyE43l4FJqDp+WW
 /KLnWEHs5Dyo8qC9taJyutk23uUm65BFtfoeuDx9umxp4p53rOjuDSsLenudAVZzx+/b
 iiKLgja5lMpPRvJhsaXhQgzEWWuhYSw1kbRHBW5hC6oIO20S8OaYyv0aQo2csr9aHrec
 HqTLzZ8NlPKEHni4gMpIChg5QoSLv/vBtabrW7mp2PQwLpRFwzfTGWgIbakKE7zM4nFz
 sh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765407657; x=1766012457;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hm0IOTG2G5675/h26bvJU6kW4LaWvamaY/sywK1kIGQ=;
 b=IoInKFZMFmuazz6yVuXjIi53jUW8OAcwOdXH6xQOJMkD9vtj3Lf2cJhRatH3/yxOYw
 yw/hdmThGio6K1Mz/ufDu1/Cd5obifLdYhoXGUfLWBHbjzGju/R7PPF+B21zKxHZloNb
 GFl9h6dF9nWe2pkC3BIcTN14SV11kmFLu20c0CqA9vlE4CXy2TLzLRfLvhG5gyI8Sgzh
 EshQFTv4IGOrDNTOHcpugax9q2AJucrC42BILRhMxx95Nztw2mU+oIeqzhab357FZn6A
 JKHM01FBxDnFsXCq8o7uFG7+fnWaPqJH5WfMpUFBdBzT0nad/niyJq6PPITfGWmKCkej
 Mb+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ6iYlcDRa5IJSa/zFofc1icMS1z/pXDqHT4nTSNx0vdhta1yzxCUG9ULu6tbytka51TayMgUNeMak@nongnu.org
X-Gm-Message-State: AOJu0Yx/61L4vlB+SCUZk/qtULvXxRATx6bWNDWr8q4ObiDyrz5t8PRM
 khUHerIKxM0kovDjhL0yzRlk5XphVEWWr+0znrez7GzNBFQKdJa2KRBdYs5KYYX4ApwpsCwurRi
 4LmFCGGXVqnjI3WcxgBqOy9rBx///F4hfvFigKFE3
X-Gm-Gg: ASbGncsznLhAG9xW1WoqjOMxvtfH+eFfqds1VpxXyHE6tB++OCJ4BaWXvf+ACjMYyDN
 JpfUnlx1I/lK79wHJBkFjXqNqSv9u8eEjmXHjpgH5cQ2lCaWhf5IKOkO1MLULy6vSYwa2h4D977
 6+/lx0rKrOuTQ8Pj8DAvpQYLPqQ8AfKIHHW4ekaG68L9AQ82IllAi/ppsd+FkLTc6oJ6KRfdwDD
 icilgBeyIUN0d4BiEy105NzxRFt9dnOHfPk3gg31ooNaBx77SZqB0C3VbghYJFkx0bp3+HAQ9Gu
 wwBF/w2ZSzMPC2i0Ux1kjcTqlkfl
X-Google-Smtp-Source: AGHT+IEA7fWY7sNmSowmp8WZRO2yQuVguk6w54vs+u5TrvXYcWxnH7rEweMGjLtCrhhOza8w4a12c7Di2q3PBgEjjOw=
X-Received: by 2002:a05:622a:341:b0:4ed:a65c:88d0 with SMTP id
 d75a77b69052e-4f1bd86ad85mr4074121cf.6.1765407657054; Wed, 10 Dec 2025
 15:00:57 -0800 (PST)
MIME-Version: 1.0
References: <20251208074436.1871180-1-kane_chen@aspeedtech.com>
 <20251208074436.1871180-3-kane_chen@aspeedtech.com>
In-Reply-To: <20251208074436.1871180-3-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Wed, 10 Dec 2025 15:00:44 -0800
X-Gm-Features: AQt7F2ooJiX1we7OOLgJttgVpvA4KZOkNsGMqhVLiqcO5DEfyVxEYnPkhm_1S9o
Message-ID: <CA+QoejW+YugMO=uCJJzPt3tSdk63+HpYPXmh=s9JKtPXHdB=dw@mail.gmail.com>
Subject: Re: [PATCH v3 02/18] hw/arm/aspeed: Attach LTPI controller to AST27X0
 platform
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82e.google.com
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

On Sun, Dec 7, 2025 at 11:48=E2=80=AFPM Kane Chen via <qemu-devel@nongnu.or=
g> wrote:
>
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Connect the LTPI controller device (representing the AST1700 I/O
> expander) to the AST27X0 SoC model. This patch sets up the memory
> mapping and device registration according to the AST2700 SoC design,
> where the LTPI controller is exposed at fixed MMIO regions.
>
> This change only handles device instantiation and integration,
> without implementing the controller's internal logic.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/arm/aspeed_soc.h |  5 +++++
>  hw/arm/aspeed_ast27x0.c     | 21 +++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 18ff961a38..bca10c387b 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -43,6 +43,7 @@
>  #include "hw/fsi/aspeed_apb2opb.h"
>  #include "hw/char/serial-mm.h"
>  #include "hw/intc/arm_gicv3.h"
> +#include "hw/misc/aspeed_ltpi.h"
>
>  #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>
> @@ -55,6 +56,7 @@
>  #define ASPEED_UARTS_NUM 13
>  #define ASPEED_JTAG_NUM  2
>  #define ASPEED_PCIE_NUM  3
> +#define ASPEED_IOEXP_NUM 2
>
>  struct AspeedSoCState {
>      DeviceState parent;
> @@ -112,6 +114,7 @@ struct AspeedSoCState {
>      UnimplementedDeviceState ltpi;
>      UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>      AspeedAPB2OPBState fsi[2];
> +    AspeedLTPIState ltpi_ctrl[ASPEED_IOEXP_NUM];
>  };
>
>  #define TYPE_ASPEED_SOC "aspeed-soc"
> @@ -279,6 +282,8 @@ enum {
>      ASPEED_GIC_REDIST,
>      ASPEED_DEV_IPC0,
>      ASPEED_DEV_IPC1,
> +    ASPEED_DEV_LTPI_CTRL1,
> +    ASPEED_DEV_LTPI_CTRL2,
>  };
>
>  const char *aspeed_soc_cpu_type(const char * const *valid_cpu_types);
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 70be3871bb..341b53189b 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -88,6 +88,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] =3D {
>      [ASPEED_DEV_UART10]    =3D  0x14C33900,
>      [ASPEED_DEV_UART11]    =3D  0x14C33A00,
>      [ASPEED_DEV_UART12]    =3D  0x14C33B00,
> +    [ASPEED_DEV_LTPI_CTRL1] =3D  0x14C34000,
> +    [ASPEED_DEV_LTPI_CTRL2] =3D  0x14C35000,
>      [ASPEED_DEV_WDT]       =3D  0x14C37000,
>      [ASPEED_DEV_LTPI]      =3D  0x30000000,
>      [ASPEED_DEV_PCIE_MMIO0] =3D 0x60000000,
> @@ -556,6 +558,11 @@ static void aspeed_soc_ast2700_init(Object *obj)
>          object_property_set_int(OBJECT(&s->pcie[i]), "id", i, &error_abo=
rt);
>      }
>
> +    for (i =3D 0; i < ASPEED_IOEXP_NUM; i++) {
> +        object_initialize_child(obj, "ltpi-ctrl[*]",
> +                                &s->ltpi_ctrl[i], TYPE_ASPEED_LTPI);
> +    }
> +
>      object_initialize_child(obj, "dpmcu", &s->dpmcu,
>                              TYPE_UNIMPLEMENTED_DEVICE);
>      object_initialize_child(obj, "ltpi", &s->ltpi,
> @@ -1047,6 +1054,20 @@ static void aspeed_soc_ast2700_realize(DeviceState=
 *dev, Error **errp)
>          return;
>      }
>
> +    /* LTPI controller */
> +    for (i =3D 0; i < ASPEED_IOEXP_NUM; i++) {
> +        AspeedLTPIState *ltpi_ctrl;
> +        hwaddr ltpi_base;
> +
> +        ltpi_ctrl =3D ASPEED_LTPI(&s->ltpi_ctrl[i]);
> +        ltpi_base =3D sc->memmap[ASPEED_DEV_LTPI_CTRL1 + i];
> +
> +        if (!sysbus_realize(SYS_BUS_DEVICE(ltpi_ctrl), errp)) {
> +            return;
> +        }
> +        aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(ltpi_ctrl), 0, ltpi_ba=
se);
> +    }
> +
>      aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
>                                    "aspeed.dpmcu",
>                                    sc->memmap[ASPEED_DEV_DPMCU],
> --
> 2.43.0
>
>

