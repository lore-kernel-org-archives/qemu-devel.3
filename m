Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2974EE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5D-0004zo-QG; Mon, 29 Dec 2025 14:39:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4U-0004Aa-1q
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:26 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4R-0000Jq-GQ
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:25 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3867841cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037102; cv=none;
 d=google.com; s=arc-20240605;
 b=foLK770EzYSaKwssxFxSxuaoXRh8MVReyIRkdYSSlW5x8czFeLQZqQ78YvpOVUhCws
 qoonrG22mAI94Ku483wD/NuZKZE08ISeu6Y/8YZwxV0JWFua3zqtGxmHTiYzOava5PTy
 uDmBE9+zt5Ft6iYlNBLypoy7H1imrmvHRV4RyaZBZCQmfWk4FktA8rOo5okCn9msIcRq
 dZevKJ71aaqDN0JimLPA5369tCYg24AwAK3en5cCQVzE15rr5zCrsJhn+BaQxDm7HjUg
 cFZGno42fg7YYvBsFXdLQLaTDKCR88BqrO63UxR9NaKq07Eo6Id/QdtlBNLwKsyvLfcB
 MrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=25NTTjqn4yrf8s6rxU/M0fEcAs5aC9D8bZUJNOnkS90=;
 fh=bXZlQw8Kkz1N7lSwABam7QdfHbT7tTSjIEDgtTEw6Xc=;
 b=NqSvSmcItDLxYRZR1XWc7eiazBGf0nOh+DN7UBLNc2ACmLSa7xWs9an+Xo/t6bBaKI
 pbM1cMVpkvIagwuA+eECeEIcqOR8eQJ4tf7y4vfs6ReLBXgk3shAvvPDqlZDhad/ITRF
 V7ndggdWDDqIKf9wJnbZHOKhO5aNf/1uL6L3eg0n+cdm9nJ9h7AZrZYyknNr2i7tfUNn
 XE3sWAzskuxwkWcdI1sR6AuKWr3/p+Zy5tdmIkbkF4t8RGJd8HGaPOJlyTUu+bnRVrRh
 EvRO2rOah6VThUrUomyKEmA5yUrnU1Wa6mHcHCKi+ZJsS9/SA0ORBT75XK/z4Lz5aivs
 JNeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037102; x=1767641902; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25NTTjqn4yrf8s6rxU/M0fEcAs5aC9D8bZUJNOnkS90=;
 b=i6ww8VJfGj472WULYcSt5zfVmPu7Mee9QIWv1zD5KNSE8SrAWxMQ9rNtNsCyN8JHqI
 jyTecObD4tCosRTbON7JMPaGSqcjFlgPZV7BFDUae434qT1jtx1GzNvMIR+8OPFGDCU/
 CFL8WmkpYZFb063pyTDxlCS9h6D3CqoLlGjUOx75OduUhcFA7RDI/E8DIIPsANYfE9l/
 6/rXlpxT75stA6FvbVRDV9FF1fQTDIWTxl0YjMy0ESbixF8EdL5QRYUzkgsgkE2846P7
 obCuffZWsnduKLvBpH1yh3r63mwqYUm/wsyz7sOw6kzPcPxZt+Hll6z2Cmo3jqlOwvoT
 dkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037102; x=1767641902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=25NTTjqn4yrf8s6rxU/M0fEcAs5aC9D8bZUJNOnkS90=;
 b=MIwt0uEbuixLajWy9v5p7Ic7thtlbG8RxvNSPQkwVYgtrY/oBKPLw+3XiKsWoAxAlb
 ClEeFO7NS5dbdgqrNTNijAalB5lQJcxlUv+CwvUdZUUGmOHLsW9U7yCpxBJVBU3/bSwc
 f9wNNBZVPMw0rGXljKETSU1iIGXDOGbc8OYdrVUnl96Hh3UGj7XZohMf39GIOFGtR6sf
 cgwltR/aOMitMfjSQr2ZAp4tc5SecxUflXcMEjmuLcCv0Vpt64jzd/zOUme4YzfkFknn
 Fg8rdmT949sFi5JsoZ8aRWgF0oUMvU1L6P2piCrsjS7fuDEA8ZrxFcuCON3j/fy/w1hJ
 JBug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX20gTDxHDQiwZwC7Ftd1lwGRIoQfEdVIRIjr2nrSG1lwvkHSinHK616XogyqUo+GobWOhevrUgpRcX@nongnu.org
X-Gm-Message-State: AOJu0YwaVE9vz30DelaYLxSRQ/rzW8o9V7D0876IIIG+VxDMZuyMcM9w
 taomWDgEkRaYka9Chr3IbETRqWwiGzqC27021eg3pcOrEL+0qEGZnZ1NPdZTNK2G4M+ZU+iOgNV
 kQ0drNda/GO1yWPXMPHTSUpwFbzr9AQskqitiTfS7
X-Gm-Gg: AY/fxX7xnm+KL6lyhk0y3Y5naASnMQsLJBvgcwF0XPOeZr1AmhuUMqedgC/YuJsMFCy
 V5f0W2adYdImtSU6cqNjMPVlXHO6HVPud5V2Ir3CR7q8fndbGYnTfyMDs/JgdPQKIVgXs0dUFDP
 ieu/1RyWK/avEfQSrJvL5zdpfMFx/qeJgetEbYjpyXZQL4vkLpMogai0piJmyELLzjeeg7gbI5S
 dWV2UF4Y2Go+F1MfqoDUPCWOATA2n6YOhNCWYIEPT1+Lw/GlAnqfSg5BW6vwFNRnEZyjGor7yka
 z+MbDvsKqZ+GnApe97oUHkqzrQ==
X-Google-Smtp-Source: AGHT+IGDg0FHJgfl/FCpc96fnWMcvswbLcCEn3ouLGa0okOe/r+WmPOkjF8BG810U9HZytR6oI1OnL3cFAyUXgElMME=
X-Received: by 2002:a05:622a:1308:b0:4f3:b0f3:62bb with SMTP id
 d75a77b69052e-4f4e5f746cdmr33506691cf.13.1767037102282; Mon, 29 Dec 2025
 11:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-11-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-11-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:11 -0800
X-Gm-Features: AQt7F2pRLbNHa9PaI8krc0R21FnU2Sur4cn_JHxqSW3SwchHE_r1PK1dagxP-X4
Message-ID: <CA+QoejXxzVNrvFk1rG4bX8uMpksEhqG+xxMQ3gWsHckn0s2u=g@mail.gmail.com>
Subject: Re: [PATCH v4 10/19] hw/arm/aspeed: Attach SPI device to AST1700 model
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x82c.google.com
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
> Connect the SPI device to AST1700 model.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> ---
>  include/hw/arm/aspeed_ast1700.h |  2 ++
>  hw/arm/aspeed_ast1700.c         | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index 23588f7a81..5b120dd11a 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -10,6 +10,7 @@
>
>  #include "hw/sysbus.h"
>  #include "hw/misc/aspeed_ltpi.h"
> +#include "hw/ssi/aspeed_smc.h"
>  #include "hw/char/serial-mm.h"
>
>  #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
> @@ -25,6 +26,7 @@ struct AspeedAST1700SoCState {
>      AspeedLTPIState ltpi;
>      SerialMM uart;
>      MemoryRegion sram;
> +    AspeedSMCState spi;
>  };
>
>  #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index cb07d94054..fc09bb1aed 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -17,15 +17,19 @@
>  #define AST1700_SOC_SRAM_SIZE        0x00040000
>
>  enum {
> +    ASPEED_AST1700_DEV_SPI0,
>      ASPEED_AST1700_DEV_SRAM,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
> +    ASPEED_AST1700_DEV_SPI0_MEM,
>  };
>
>  static const hwaddr aspeed_ast1700_io_memmap[] =3D {
> +    [ASPEED_AST1700_DEV_SPI0]      =3D  0x00030000,
>      [ASPEED_AST1700_DEV_SRAM]      =3D  0x00BC0000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
> +    [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,
>  };
>
>  static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
> @@ -58,6 +62,20 @@ static void aspeed_ast1700_realize(DeviceState *dev, E=
rror **errp)
>                          aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_UART=
12],
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart),=
 0));
>
> +    /* SPI */
> +    object_property_set_link(OBJECT(&s->spi), "dram",
> +                             OBJECT(&s->iomem), errp);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi), errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0=
],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), =
0));
> +
> +    memory_region_add_subregion(&s->iomem,
> +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_SPI0=
_MEM],
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->spi), =
1));
> +
>      /* LTPI controller */
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
>          return;
> @@ -75,6 +93,10 @@ static void aspeed_ast1700_instance_init(Object *obj)
>      object_initialize_child(obj, "uart[*]", &s->uart,
>                              TYPE_SERIAL_MM);
>
> +    /* SPI */
> +    object_initialize_child(obj, "ioexp-spi[*]", &s->spi,
> +                            "aspeed.spi0-ast2700");
> +
>      /* LTPI controller */
>      object_initialize_child(obj, "ltpi-ctrl",
>                              &s->ltpi, TYPE_ASPEED_LTPI);
> --
> 2.43.0
>

