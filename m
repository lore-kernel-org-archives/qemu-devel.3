Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3B2C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVZrz-00009m-L6; Thu, 01 Feb 2024 11:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZrj-0008VM-C8
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:24:45 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVZre-0004hy-Is
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:24:37 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d051fb89fbso15822691fa.2
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 08:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706804672; x=1707409472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46NHSLFImFJJig2UxV3k7PaJBS9adhECauo8jMROZHI=;
 b=XO5/dXmrrYLRl48fa2VAc3qzqz115Kd2dsHsM73r52RnieePXMB6p14XkyxEVf+NN2
 lJHH8CgA1j1i+afuckmaf+qWL39pYvnBu2cbj06YMCKMaBvXXhNiXUOrD/4gzekOl+mS
 iYZ1tkd9fmD8ir2Gg/8lo34c/bWYPo8LDdw5jGonyHSgps7b3P6dBVHsh9mIUK/Jzbjq
 JeA/Ju8fqDU8GyEm8u0/N/+cd63/YMAEJ/sBGe1TpiPg+8PIxgrJeiqtkUi6SGSmRJu6
 tfO/W18gxczfCaWO8LceOv8EsLKFG2oFyZR5rWwZu//Hcc5GUGGMpA673e70WeAHb/1f
 xWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706804672; x=1707409472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=46NHSLFImFJJig2UxV3k7PaJBS9adhECauo8jMROZHI=;
 b=pKsilGA5jC4Npr+dT3hiV/KlcRX4rBv3qaxRkG2ouWbLsCkuTRiiz3GzH3YCfqspXN
 v5OA6xjFTjNk2zSBdCFOt2bU+WruV+5WHqh4kQ8tbmaBL2X7E/r46DiJEQPP30t6LSaR
 sr4RVX1e3+fca0ht87sHkrHRzHF2FijAVpN8LGXjGSlO5Bk+pgabR4ABTI1Ajl1GDGuN
 Cjvi1SyTR18plPljvieiLJQvGN0jjp76BlibeAXC1D3iCQs3bPIsorBeRvJiGHFfqB9+
 v1Ng0VmaKRmee1soC/O2Gn6BOxpHsDBQQhCfclmbbtbBija75yIsicTk5L3zMsmbaiPE
 A+og==
X-Gm-Message-State: AOJu0YypzLFTEkvtSs42N1HF6scTjabcQjtzUGQKpDKo4c8JxY/okHsd
 o9F8nev23vYGDu+ck3M2X/1rn/enOjuc0261iZjl15oARWzHveUxr7J4DG1LQXebu4LN1kvJhV0
 Jk0I6p86dcXIfeZejwpzISK/2+BesODMLsT67AIov39JddHkm
X-Google-Smtp-Source: AGHT+IFL14x9oeiZfjzo5pV0Y4YN2i74qoc5RaH/iXnJx8Y+gyHy/8PO5QCVcVXSZeJ558W0dqbWPEn/gF4tVMS1ZTQ=
X-Received: by 2002:a2e:3318:0:b0:2d0:770d:5c1c with SMTP id
 d24-20020a2e3318000000b002d0770d5c1cmr1712965ljc.11.1706804672528; Thu, 01
 Feb 2024 08:24:32 -0800 (PST)
MIME-Version: 1.0
References: <20240130190317.25692-1-philmd@linaro.org>
 <20240130190317.25692-3-philmd@linaro.org>
In-Reply-To: <20240130190317.25692-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Feb 2024 16:24:21 +0000
Message-ID: <CAFEAcA_e3QOvfvJScUgtmjGacKZX1OHyY5a-BWSAhNURyO2Rgg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/arm/stellaris: Convert I2C controller to
 Resettable interface
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 30 Jan 2024 at 19:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index afbc83f1e6..284b95005f 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -607,8 +607,11 @@ static void stellaris_i2c_write(void *opaque, hwaddr=
 offset,
>      stellaris_i2c_update(s);
>  }
>
> -static void stellaris_i2c_reset(stellaris_i2c_state *s)
> +static void stellaris_i2c_reset_exit(Object *obj)
>  {
> +    stellaris_i2c_state *s =3D STELLARIS_I2C(obj);
> +
> +    /* ??? For now we only implement the master interface.  */
>      if (s->mcs & STELLARIS_I2C_MCS_BUSBSY)
>          i2c_end_transfer(s->bus);
>
> @@ -658,8 +661,6 @@ static void stellaris_i2c_init(Object *obj)
>      memory_region_init_io(&s->iomem, obj, &stellaris_i2c_ops, s,
>                            "i2c", 0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
> -    /* ??? For now we only implement the master interface.  */

I'm not 100%, but I think this comment is a general one,
not reset specific, so it should stay in the init function.

> -    stellaris_i2c_reset(s);
>  }

I think that the i2c_end_transfer() should be in the
"enter" phase, and the clearing of the state fields in
"hold", and then the stellaris_i2c_update() call in "exit".
Though usually we don't bother to do an update in reset
if it's just "device has reset and now its outbound IRQ
line is not set", so we could alternatively just delete that.

>  /* Analogue to Digital Converter.  This is only partially implemented,
> @@ -1382,7 +1383,9 @@ type_init(stellaris_machine_init)
>  static void stellaris_i2c_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>
> +    rc->phases.exit =3D stellaris_i2c_reset_exit;
>      dc->vmsd =3D &vmstate_stellaris_i2c;
>  }

Also on the subject of resetting i2c controllers and buses:
https://patchew.org/QEMU/20240126005541.1839038-1-komlodi@google.com/
That patchset proposes that the bus should basically drop
any pending transactions on the floor at reset; it would
also be possible for the bus to do the "end any transfer
in progress", so the individual controller model doesn't
have to. No idea what the overall Right Thing is, so
let's not block this tidyup on figuring out general i2c reset
cleanups.

thanks
-- PMM

