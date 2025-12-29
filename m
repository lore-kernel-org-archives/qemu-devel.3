Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83539E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ5K-0005Xd-Ug; Mon, 29 Dec 2025 14:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4f-0004vl-2k
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:40 -0500
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4d-0000N4-Fq
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:36 -0500
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4f34f257a1bso3264701cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037114; cv=none;
 d=google.com; s=arc-20240605;
 b=j8BQGYhpGDvMQgCPtMUNc+Gl0PG1SAAJdrvEAUbv+JGz+8MtEfC3dRwdrvdUZ2nESC
 BsLa7ov6mNoxGmtYqNVHn0XCQYlKbz3Ne3exsCKHpAXzI1fHXe2txWvd1AAY4Olfwd4P
 MrD2XGsBMk8voHElTLWGTgVmORVJjqZt2pRE5b28bnYMdxM2WkfXIUrr2A76HWXxgbX+
 t1ytZOoRVRDkqtOrVLHGtKxdHghYR4gBqZFz+IoCJO4ZmqTPfHUc+rHKoHvp0JO+3x63
 G3bsmqApySMmhkKzI09PBNU/CpNcW8uspZqjylO7fL8hP7Zvfi0tglh1xR/zaRwOL/oS
 HdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=doKnHhUkFb/0NWLVCyNF9qJ6hCQOom1B9Iyu62HNW/U=;
 fh=I5Cg8mBSw0+tRiuUjqyg0N0jNZkaQmvH6AAN8IZUtyw=;
 b=RYChNiag0AzqpA07BzboEtrumenxmY0yolA3dkBWLgBMnPdd0QzXpJpTwBcYreHKJK
 gI9fM+SDI7T4NdqIQmqCAtC0zTaLgvnzMf0h2rfuDipVu+U8CK4EfnY9XGKgCBBeceaX
 TsVd9qM2lNGBB33R7nGXLW2c8fIHTzfBor5lDKxQxwdfW9NePxodYRJJ7qM3r0ydugzu
 af84eeXrf7Ki+BA+9/QGIDPlIG8GiggPEQR8QWiQuJ7faP/k24VapJehYltWEcx4v6NN
 aln+TKqetYHUWSyl8MVqCfI9+YKFhltH1aZ8QQ8+2Ir6uKduGBxoKBWEVN7duAu6bAaM
 u8CQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037114; x=1767641914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doKnHhUkFb/0NWLVCyNF9qJ6hCQOom1B9Iyu62HNW/U=;
 b=DQdHGFktFTrUYMjtRHorguxtdbhUd7Fy7WpS5YE2SpvntGmBbb1ZC4MOhb/bgFb3XA
 ql7XZDRRB/9SfgNGeRAUvEmV+wsj8K1ToD0vXkM6yy48ZApC6ASpz5WOm6G9lrTykPrK
 OKFPI+jnHjDaRyLgLClfKaNXWIHon3QpV5ACSv0Bw+OQ3Mj+6OwtlthXr9US4vudMYbH
 Z/nmGt1LMhPYdrwrvs2ab67cg8LYk/jBoae0h8jEsNVicN38umB6vNgeVLe6UReUnD/X
 CJsKHvLH9kGNz56z4Cg0yRPUkW9QbcpwyEgWNoEwO0IJbow1fIPJzM0pa+uwYY/DpLIE
 7rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037114; x=1767641914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=doKnHhUkFb/0NWLVCyNF9qJ6hCQOom1B9Iyu62HNW/U=;
 b=hHUq73t7u0T8N2DrnoU061Y5hTQIc+/CA3oHxv1uqIkLadpHi+AFjtMLsQMR/+AzS0
 vCN6I8djRL1szcHpl8i+GtgAcSHduO1e8YkBPKHzTGxyytcgxhIsJEeTc6Q1WK0XM5iB
 Jxut2Mj4w8q+UZ4ywWsfEPVL4/lCXDL/U9jKVp40c/72BLs4i3SmauQELIu+ZVv7PXUZ
 sVdYxJoBK2r2awN1QVFqaV79ymRVHCS5ts6YhP0XGQd8mBa2HqEuePzWsyO4tbNXqrYq
 TQFPa19YVMY/sP+ww3idNifPtlgnKPZWfjPJJT87ZQqiJyn5PAzozWaT6Y14UZ90ZKEc
 A5pA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGY8XMHVY5pi0o7JkEr9JO4Ns58tpLvLf7Kp9MPB8e4GdrXT/nDKrIINBz2GRPssFVdcYzCzxjPfR7@nongnu.org
X-Gm-Message-State: AOJu0YxWTtc3v577Eg0j56vyWpdT3WpDUKWdDeyUZDcPjaBYIYp712Sj
 C8eDxccPTfdTG5U/fe0+AFv9TD5+xp1THh6lDfXrVUZ8KBvbH+3szkFeIWDGQACjMy1CSSwSFZS
 nTQobBXX13z+uc8rECYG2iKQ7UBoKMIYVRSZK6UPx
X-Gm-Gg: AY/fxX57aAmfkhcGtyaBWXuJsWst8FXEXfpks9hwRvpfFc5AMgvU9XtU+HSS8DgL1I0
 aXsi3SWZ5O1iXYRkECEMJEt809WV0ZcMnbPbUUDj+twO1pR+uceuPOI8agIP5n185+tJFkQnehK
 E6PH66z2MlSa6InbCr9jU7i8ZYJpZ0/S6bTQD8h+hNs/as5ZPHp2iNSvZRbMvqVTsSS1jIQvPDv
 DUikJJawJnqUIzUSGKycncvD1UfWu3/ropEX/uCTZGDDtvUKP2044k0JUk4I0oHqtkRAm0UWQeN
 u0s3x+dRwgEe0w5LT7ivI2JVlA==
X-Google-Smtp-Source: AGHT+IEyQOupiZr2zpS8yq9ARPqaemPv9uB0Uydep4wqnLCVzrMioJxYouzQJGTv2b+3RZ9L3JmCEUYCAa+28Z9gwIc=
X-Received: by 2002:a05:622a:15cb:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-4f4e4e3df06mr29408191cf.8.1767037114066; Mon, 29 Dec 2025
 11:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-16-kane_chen@aspeedtech.com>
In-Reply-To: <20251224014203.756264-16-kane_chen@aspeedtech.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:22 -0800
X-Gm-Features: AQt7F2r8-mK_VxsCyp_o_MeLLc9rqwqoFwNmN-zKlpw3EFjXPPzjx7oRyON4QXU
Message-ID: <CA+QoejWSscrjQPpTsd14Y43ULWG=HJy4=4fYG_kJiW2VQ6xS+g@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] hw/arm/aspeed: Attach WDT device to AST1700 model
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x829.google.com
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
> Connect the WDT device to AST1700 model.
>
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> ---
>  include/hw/arm/aspeed_ast1700.h |  4 ++++
>  hw/arm/aspeed_ast1700.c         | 24 ++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1=
700.h
> index d4b7abee7d..f43c0c5475 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -15,8 +15,11 @@
>  #include "hw/i2c/aspeed_i2c.h"
>  #include "hw/misc/aspeed_ltpi.h"
>  #include "hw/ssi/aspeed_smc.h"
> +#include "hw/watchdog/wdt_aspeed.h"
>  #include "hw/char/serial-mm.h"
>
> +#define AST1700_WDT_NUM              9
> +
>  #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
>
>  OBJECT_DECLARE_SIMPLE_TYPE(AspeedAST1700SoCState, ASPEED_AST1700)
> @@ -36,6 +39,7 @@ struct AspeedAST1700SoCState {
>      AspeedSCUState scu;
>      AspeedGPIOState gpio;
>      AspeedI2CState i2c;
> +    AspeedWDTState wdt[AST1700_WDT_NUM];
>  };
>
>  #endif /* ASPEED_AST1700_H */
> diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> index fad3b86e8d..9fb84dd159 100644
> --- a/hw/arm/aspeed_ast1700.c
> +++ b/hw/arm/aspeed_ast1700.c
> @@ -25,6 +25,7 @@ enum {
>      ASPEED_AST1700_DEV_I2C,
>      ASPEED_AST1700_DEV_UART12,
>      ASPEED_AST1700_DEV_LTPI_CTRL,
> +    ASPEED_AST1700_DEV_WDT,
>      ASPEED_AST1700_DEV_SPI0_MEM,
>  };
>
> @@ -37,6 +38,7 @@ static const hwaddr aspeed_ast1700_io_memmap[] =3D {
>      [ASPEED_AST1700_DEV_I2C]       =3D  0x00C0F000,
>      [ASPEED_AST1700_DEV_UART12]    =3D  0x00C33B00,
>      [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
> +    [ASPEED_AST1700_DEV_WDT]       =3D  0x00C37000,
>      [ASPEED_AST1700_DEV_SPI0_MEM]  =3D  0x04000000,
>  };
>
> @@ -129,6 +131,22 @@ static void aspeed_ast1700_realize(DeviceState *dev,=
 Error **errp)
>      memory_region_add_subregion(&s->iomem,
>                          aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LTPI=
_CTRL],
>                          sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi),=
 0));
> +    /* WDT */
> +    for (int i =3D 0; i < AST1700_WDT_NUM; i++) {
> +        AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);
> +        hwaddr wdt_offset =3D aspeed_ast1700_io_memmap[ASPEED_AST1700_DE=
V_WDT] +
> +                            i * awc->iosize;
> +
> +        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->s=
cu),
> +                                 errp);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
> +            return;
> +        }
> +        memory_region_add_subregion(&s->iomem,
> +                        wdt_offset,
> +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->wdt[i]=
), 0));
> +    }
> +
>  }
>
>  static void aspeed_ast1700_instance_init(Object *obj)
> @@ -163,6 +181,12 @@ static void aspeed_ast1700_instance_init(Object *obj=
)
>      object_initialize_child(obj, "ltpi-ctrl",
>                              &s->ltpi, TYPE_ASPEED_LTPI);
>
> +    /* WDT */
> +    for (int i =3D 0; i < AST1700_WDT_NUM; i++) {
> +        object_initialize_child(obj, "ioexp-wdt[*]",
> +                                &s->wdt[i], "aspeed.wdt-ast2700");
> +    }
> +
>      return;
>  }
>
> --
> 2.43.0
>

