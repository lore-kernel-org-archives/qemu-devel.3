Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637D5CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 02:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8rBP-0004qB-4X; Tue, 14 Oct 2025 22:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rBN-0004pJ-MU
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:24:05 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v8rBE-0003rD-6o
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 22:24:04 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-63beb2653dbso685257a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760495030; x=1761099830; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Fy2DzKv5ocTuVCF4u1TR+Cq+6ExdELyYXIxCr1MuYA=;
 b=PN9E2aHC3/yWJWeg3IrAj/yd8Mbq5XiCvtYJIsmQqDTJj4vENVVj35meAmIfc8S67A
 7ziwTti3Nyvzya0rrdHO0a6q7Lb2v460q3bzth9nf2EAZmoVBKtnE6ToPO12ZkoFPrAT
 KHdo5RvCAuNZnPxmSrnzgSX/3hFOatwR7vmsQ8jX00Lm7DGug0WNVXeZeR3808lPiOil
 6/c7LuNuHaqrP2326zyfkOI65LxWyShpw1W6r/h6iUfN6io0z/aaLDNUob5s0qvKk63R
 EJ53EoFxmUaHpj0cpDG4sF5Obsy8ivRXAkqbzBKikrGVksOQGHuegQ6TX1gO43I9oKyT
 d32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760495030; x=1761099830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Fy2DzKv5ocTuVCF4u1TR+Cq+6ExdELyYXIxCr1MuYA=;
 b=I3IedNhs1e85vWz8ec8RksFXjU/uer/6yd//17Ly+4kQ0ChkzutGHTOJFfub1LIcVm
 4jiY3sZu2YAJpduFSiEXk2Bw51VFQrZ7azxY67jejcTNHmdcyic/6nASTgAFUBiO84Qi
 T7YB22nywztNq1mUjYjwsq6rTJbRski0KNp2GRwHmC7bzvZIMgXBccqIHdPMDKnJB8BJ
 Xdz01I+2DJXW8FKRHYuL0KNPxCoDfwq71EpB12BLqx/bqwra6FSZx4pKktl2e6oork3/
 DDcpPGs4tksylIOPZGizzV5/NOTmnZzPWzAFNO+dcZc8dHhymD/ZJkqDDcp/AV5Zfcge
 GYOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/hKjzyTAAVRS5UStyJFZ2Um2MPUut1yNGIfIOCjhzW3sFT32gEy7XvOJyGf+HwML8rSYudmX34wW6@nongnu.org
X-Gm-Message-State: AOJu0YyTYXeOHsLyi9+hg02N3cSUmUuiagdDigwnURmnOTPaL8dtGtxb
 7kfKEuD6gtFKpMyDMx9Ta7JenuMyYl9QCeRMuwOqkIHOrG3sFht0cGN/5vZIHw30xSFS0YehV6H
 ZaKVvKcleJcz1jRouHpgHxOfCaYpodHI=
X-Gm-Gg: ASbGncuf+hWlC7m9kcFrHFWxZSTqNN09/1EVWnw8Cijew/Fubj2VyhhdVuSdldkfJaW
 jFHG6/BCOj1IcpJRxB5onmYe4v56MLrasPuqT/0eKCyHelzg4xMvZhI5otQno3RaNPx9l84CdNq
 NgZS5MJz7PGzsxSLsUtg3A6Tozd23QJQNKCwInb87zp8nc1BwEB7mwgLnrGkUfpRCHlSMiEt6gz
 fIzOaVKr0ZnvmjZdAfyQlUtjnn73O4iLwVOxY1N54n21wyGzqVkFs2QQil/p0gByZU=
X-Google-Smtp-Source: AGHT+IGrg9ABMKG27JCwmA000Ud2iktGvzAnc4Q+3gUta/+RHr0bUnhmFwdWCcRbea7ZdR7Oji15BlFVmF995X8cGHg=
X-Received: by 2002:a05:6402:35ce:b0:634:c377:e188 with SMTP id
 4fb4d7f45d1cf-639d5b57b06mr27140186a12.6.1760495030257; Tue, 14 Oct 2025
 19:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251004200049.871646-1-linux@roeck-us.net>
 <20251004200049.871646-4-linux@roeck-us.net>
In-Reply-To: <20251004200049.871646-4-linux@roeck-us.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 15 Oct 2025 12:23:24 +1000
X-Gm-Features: AS18NWBKVEuQQqj9cieP6rq05dD3n3W2YoTdkavY3oDi9G7Mkcr5482jzCL6-fU
Message-ID: <CAKmqyKNX6TEdj9CVmXEy+sxXU9rwbeo-wL44a66Z0v3XjoNmdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/net/cadence_gem: Add pcs-enabled property
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 5, 2025 at 6:03=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> The Linux kernel checks the PCS disabled bit in the R_DESCONF register
> to determine if SGMII is supported. If the bit is set, SGMII support is
> disabled. Since the Microchip Icicle devicetree file configures SGMII
> interface mode, enabling the Ethernet interfaces fails when booting
> the Linux kernel.
>
> Add pcs-enabled property to to let the driver know if PCS should be
> enabled. Set the flag to false by default (indicating that PCS is disable=
d)
> to match the exiting code.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/cadence_gem.c         | 7 ++++++-
>  include/hw/net/cadence_gem.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 520324adfd..44896f1801 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1477,7 +1477,10 @@ static void gem_reset(DeviceState *d)
>      s->regs[R_TXPARTIALSF] =3D 0x000003ff;
>      s->regs[R_RXPARTIALSF] =3D 0x000003ff;
>      s->regs[R_MODID] =3D s->revision;
> -    s->regs[R_DESCONF] =3D 0x02D00111;
> +    s->regs[R_DESCONF] =3D 0x02D00110;
> +    if (!s->pcs_enabled) {
> +        s->regs[R_DESCONF] |=3D 0x00000001;
> +    }
>      s->regs[R_DESCONF2] =3D 0x2ab10000 | s->jumbo_max_len;
>      s->regs[R_DESCONF5] =3D 0x002f2045;
>      s->regs[R_DESCONF6] =3D R_DESCONF6_DMA_ADDR_64B_MASK;
> @@ -1821,6 +1824,8 @@ static const Property gem_properties[] =3D {
>                        num_type2_screeners, 4),
>      DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
>                         jumbo_max_len, 10240),
> +    DEFINE_PROP_BOOL("pcs-enabled", CadenceGEMState,
> +                       pcs_enabled, false),
>      DEFINE_PROP_BOOL("phy-connected", CadenceGEMState, phy_connected, tr=
ue),
>      DEFINE_PROP_LINK("phy-consumer", CadenceGEMState, phy_consumer,
>                       TYPE_CADENCE_GEM, CadenceGEMState *),
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index 21e7319f53..e63941f18f 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -62,6 +62,7 @@ struct CadenceGEMState {
>      uint8_t num_type2_screeners;
>      uint32_t revision;
>      uint16_t jumbo_max_len;
> +    bool pcs_enabled;
>
>      /* GEM registers backing store */
>      uint32_t regs[CADENCE_GEM_MAXREG];
> --
> 2.45.2
>
>

