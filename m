Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60A0E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ4c-0004fe-5C; Mon, 29 Dec 2025 14:38:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4J-0003yh-7r
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:16 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ4H-0000Hp-QY
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:38:14 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4ee147baf7bso3867671cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:38:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037092; cv=none;
 d=google.com; s=arc-20240605;
 b=efZL7efBQi0VAUXLbaTsJPVzTF4rg21W+GFM0ckpQqZY/1qwWWn3+wWdWhw4+UjUAm
 hP4HZPEA2lnJ9lDIAqvK3EgxpqBQE5CJQ7YVNKwFaq6+R05po7UeH1U53V1FU7K6KB7w
 pGUT50ArV4nexS9gnG4DOwgPY6htJCFma01nA/HZsGmSoYnDksR8zrNPrc/d4GbnNuHz
 7qRFHf4Dwx8D5rJC/RvFBs3ZDW/kjOs6TtWHhUuwwlRWG8LsE50G1k/6p2Y7e0D8Rmyj
 Qik2CguVrZoxc5AIcHzWn37JcRgsKKGMQIKAUY5f7HH9xwycfKgxM+3FFDqiMKuxQ9eE
 uNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PMCl7q5Mo6Dtiuu4MLU6KbTf+Uhgc0v2z/UxK4COyTM=;
 fh=gqcFa4mqVoJVcwLi9TAkhXY+IdeqgIQOITjanWoHd2Y=;
 b=N+hU8+nxrn5f8byFz5pSP4FCsx+fuA1tyD+6f8kQucWAWJ+qAXOrbbtlnx5tGY4r0T
 OLxjHqc9+JwLXzMGZIbA32KJiFT7Df4j/uCdg9HjmDgqNmu98mqudCYNwpaC5IjXpoO2
 b+r5S/sYQIn1JlB0gXXLX7X0C8/3iAgNoT4hMA7NfYv28uuUgMNzDFqc5Ddid4WubsRO
 VLlJ/v72qsPB72rxpHoDzK8qeaakaEP5VlJkV5TQOQJUUnRwz7J5s29FsuD9SgzzG0QE
 +W2+Scto+QcwthArTfPppzE84D+azTDvCzucrkUmi54Hr0FWIP/Ws5bCcXNqWt2KJRyE
 x4fA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037092; x=1767641892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMCl7q5Mo6Dtiuu4MLU6KbTf+Uhgc0v2z/UxK4COyTM=;
 b=wrpIwqG1+4e1hLOTQi6lLkqStfyvGeKBPI8g6GSDMP2m8xkbSIoGnJRwuskOcIEKJR
 R8NTzqjidT3mo2MvWKxor2BuFbv+qdTYbYPxFsDL9mU7/VY4bG3vULMaovpibj6luF6n
 4GLTE19vlusmQb9A5vcLwZrBQXNDB8GRkPmCsLboWTKeHHlkX8442CQ8aNB32g4qKW1s
 QFYbjx+bLgjiO1iDQZcSom2wKZt9dggINYVJp6ZlAgjl90ag8ge8Toj/EFYuNNb7RyyN
 GoVTnb4NnG2BR2fPuoT/edWikYmN3y6FWQtEWlcvT47bVLRRTJ+0LMsuemjrSvyUc2pr
 tVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037092; x=1767641892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PMCl7q5Mo6Dtiuu4MLU6KbTf+Uhgc0v2z/UxK4COyTM=;
 b=dB/0RkmCR/vWU8huVMrLiL6Im+lM+WMuZdLTe9QgMyI/X4PRztGwVJHPO1KFkcXmL3
 +NCLX+Su5RxfVKCBPhcpiaJ41Xb4VLNbAmg9rdY83fA6ZakR/gGFzcU8jDhDNuZ0DVEY
 m4y+cbKLzHwvhrspNStppT7qE0X13ab01LBQwNTGFacVrL2/XMI3Ru/reDhOyQUlbhrE
 w/EBmovdngQlvN/9qXwM3R0x5C5EFV6fMwQZXYcO/tdYOWlZUk8nh6sxVLXFXa5qHdTU
 bOHwTaADadvhKw6YWpLVKkZlC0+B43EuL9sWWt/0Cp+8gYy6MM0B3Q62uauVE4GacHGp
 Nl2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNMVRhLSQ5dabom1w2VJtJLcGBuYGFceOE2yFrChLyvnOHUclK2fhGPpa0iHJhyVURhMPjRW5SmvQl@nongnu.org
X-Gm-Message-State: AOJu0YxuJf0jOyWaEv39HVutD4h9KV5Tq8yGZ3PZ1v0r0yCzNOesctPN
 Am12BwBN8JXq74G6R6yF2lTqBRT91CAAOXw71RY4EQREwx0aFi+1pnMYgJ48Fu/AStr4wtc1mVa
 LRp96DoA7zHP6W9POTWF1dp2ZHai8VnMpUw0PLNRE
X-Gm-Gg: AY/fxX5LVFh310eX8c5BMna/6tNXhq52hfm3f+/blACrj9nbPs473nJfHgMRaBKn38t
 XfebxCm5v2nFugqlrja629/vr0KAL7Q1fAhIcWVh2ck+cTzmrU61YP4zmtv7uU4qIRCFfX1CKtH
 JuNTk5Xna2TbvRQrXZohts8MdH5LxSG7mHXJO8tVrEY6WrtsvPzmJLEyUjtWdLxKmNEm3Nuposg
 yqL0QGhvhiwqRCH6v3hXKM+3jqt7SuUwBuJAlqWMZmBDLRcMda6cU0R5xIM1RFSyBQF9D7aadC7
 0wZFIoQ2uIq1JgOHwbc9avMwxIrIS2I6w5Kr
X-Google-Smtp-Source: AGHT+IGJut74XaYQNflz4GLTzSaem63scZXNB/Kw/QrbsbZ/0MZYbk6XMz4qdb3buEkMkfyQRn9EIQX/ZDSJV6EJzZY=
X-Received: by 2002:ac8:6216:0:b0:4f4:e645:2b6 with SMTP id
 d75a77b69052e-4f5fb649f7amr16610151cf.2.1767037091739; Mon, 29 Dec 2025
 11:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-8-kane_chen@aspeedtech.com>
 <98d22733-ef05-430c-8b4a-4a227f9b3f98@kaod.org>
In-Reply-To: <98d22733-ef05-430c-8b4a-4a227f9b3f98@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:38:00 -0800
X-Gm-Features: AQt7F2octzCuoTa9u-yvrxegZMIBf-hSCrwTeNjMfb7FWSS8ZDGGEnmALtQXtMc
Message-ID: <CA+QoejVDA-C3uwTGNGBejFLm5as2kNCLAGoRc5=8VQU5CAyMwQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/19] hw/arm/aspeed: Attach LTPI controller to AST1700
 model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
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

On Wed, Dec 24, 2025 at 2:41=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 12/24/25 02:41, Kane Chen via wrote:
> > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >
> > Connect the LTPI controller to the AST1700 model by mapping its MMIO
> > region.
> >
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


>
>
> > ---
> >   include/hw/arm/aspeed_ast1700.h |  3 +++
> >   hw/arm/aspeed_ast1700.c         | 27 +++++++++++++++++++++++++++
> >   2 files changed, 30 insertions(+)
> >
> > diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_as=
t1700.h
> > index 2a95ebfe89..b9ee4952d0 100644
> > --- a/include/hw/arm/aspeed_ast1700.h
> > +++ b/include/hw/arm/aspeed_ast1700.h
> > @@ -9,6 +9,7 @@
> >   #define ASPEED_AST1700_H
> >
> >   #include "hw/sysbus.h"
> > +#include "hw/misc/aspeed_ltpi.h"
> >
> >   #define TYPE_ASPEED_AST1700 "aspeed.ast1700"
> >
> > @@ -18,6 +19,8 @@ struct AspeedAST1700SoCState {
> >       SysBusDevice parent_obj;
> >
> >       MemoryRegion iomem;
> > +
> > +    AspeedLTPIState ltpi;
> >   };
> >
> >   #endif /* ASPEED_AST1700_H */
> > diff --git a/hw/arm/aspeed_ast1700.c b/hw/arm/aspeed_ast1700.c
> > index bb6ca2ce9e..eeb586102f 100644
> > --- a/hw/arm/aspeed_ast1700.c
> > +++ b/hw/arm/aspeed_ast1700.c
> > @@ -14,6 +14,14 @@
> >
> >   #define AST2700_SOC_LTPI_SIZE        0x01000000
> >
> > +enum {
> > +    ASPEED_AST1700_DEV_LTPI_CTRL,
> > +};
> > +
> > +static const hwaddr aspeed_ast1700_io_memmap[] =3D {
> > +    [ASPEED_AST1700_DEV_LTPI_CTRL] =3D  0x00C34000,
> > +};
> > +
> >   static void aspeed_ast1700_realize(DeviceState *dev, Error **errp)
> >   {
> >       AspeedAST1700SoCState *s =3D ASPEED_AST1700(dev);
> > @@ -23,8 +31,26 @@ static void aspeed_ast1700_realize(DeviceState *dev,=
 Error **errp)
> >       memory_region_init(&s->iomem, OBJECT(s), TYPE_ASPEED_AST1700,
> >                          AST2700_SOC_LTPI_SIZE);
> >       sysbus_init_mmio(sbd, &s->iomem);
> > +
> > +    /* LTPI controller */
> > +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->ltpi), errp)) {
> > +        return;
> > +    }
> > +    memory_region_add_subregion(&s->iomem,
> > +                        aspeed_ast1700_io_memmap[ASPEED_AST1700_DEV_LT=
PI_CTRL],
> > +                        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->ltpi=
), 0));
> >   }
> >
> > +static void aspeed_ast1700_instance_init(Object *obj)
> > +{
> > +    AspeedAST1700SoCState *s =3D ASPEED_AST1700(obj);
> > +
> > +    /* LTPI controller */
> > +    object_initialize_child(obj, "ltpi-ctrl",
> > +                            &s->ltpi, TYPE_ASPEED_LTPI);
> > +
> > +    return;
> > +}
> >   static void aspeed_ast1700_class_init(ObjectClass *klass, const void =
*data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -37,6 +63,7 @@ static const TypeInfo aspeed_ast1700_info =3D {
> >       .parent        =3D TYPE_SYS_BUS_DEVICE,
> >       .instance_size =3D sizeof(AspeedAST1700SoCState),
> >       .class_init    =3D aspeed_ast1700_class_init,
> > +    .instance_init =3D aspeed_ast1700_instance_init,
> >   };
> >
> >   static void aspeed_ast1700_register_types(void)
>

