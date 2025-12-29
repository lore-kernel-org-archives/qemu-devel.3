Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B067AE92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ3v-0003Ot-6h; Mon, 29 Dec 2025 14:37:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3s-0003Ax-QK
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:48 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3o-0000Bi-S5
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:48 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4edb8d6e98aso4444341cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037064; cv=none;
 d=google.com; s=arc-20240605;
 b=XFcb/aWCK3BnqVD78bN45uZ/T4GexZK52I7uE/udzG7bWnUPF/IfH+urbnKXd8f864
 fBarcjCgSkMwEv5nLecq0r04uFQ5fr/qG+GRxOT9/PDjwV2grNmA5znqtBoIu6a5gDd+
 hj8TCIEvpxKOrtF2+kcn9CqFe39TiPxji6/uZaeIeWflNlO2uZf9VixgiUJKBY3Vo13/
 Yx4svG/IbCaT2lTIxoxioR2Y9eDdYAjwL6k9LHlIzipyQMUEc7Ho+yPAuez5jc5+/4o/
 GR0uJr5l69wbEMFNQnTRvQPBjyWr2eELQUkP07zCenHk6nEZeP8EHMria6GHUEreEls6
 G6DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nx3D9lvC8kud3HKOyVg5mt8h5bRG3vvp7IeWV9chrFo=;
 fh=eYdJMOYet4LNmf4zeouodQlGO2VHudawGLA9qxovDD8=;
 b=App6LCYKU1rknxUcTSmkQVg5pHXB16nA+/7SlJ3WBEkOLg5KBR+amRZxZog5jDd9nN
 0Gv6b+wd+Z8vZgnV/VJpeMz7wmpsLce/1Zdnp69smNqI/0keups3ho2NHOXvAWT8a9vX
 uer9EM1GgIDZUxD3gI/eUeMFzPHYZlGT2k+BXIepN+ZiIgyNsoqrnB9zCndXNj9kPFt9
 TMMFAqsXZL/QcWLaxxREdckkgATHMfDgQt0OI3371xua7r8gKimyS0kVNh6T/U5TNHeh
 3/S2QQK6TZXvI0I63C8MyTFHS31rB69Csi/MUPmS+h7stNqMbOrFdYt8oO1i+5D7WtX6
 AOew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037064; x=1767641864; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nx3D9lvC8kud3HKOyVg5mt8h5bRG3vvp7IeWV9chrFo=;
 b=rmMuLBX4hysaeML/f3pNowpMAGZCGBmQyFT0KRicqfkJ2TJk5aclo280rdPYmhwHTc
 n77bfXkzwZbekpC4rodRcS2V4PpaEzD1qLcvVtqsU1Rpow/tUYJ+W21lzVVNC3wpGcn3
 dnYlzRWXgi2Md1qYqiZftVi6xYRG2ce2TXR4MKRb7OP6hErmkgkMZngL9+Llf2wCUYzg
 +dQitsL4XEgOtsWUl7cPvv00ZZPa0HyQqVBZjruIj35XTqFOAxzAgRJcp/QbhXvs0qLA
 ecYCNy0XG/SOLSy03ozVRyGk8wqpJHTTdCvv74/i/v6GnXjfX3NHDTPxj2axQibsg/24
 nEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037064; x=1767641864;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nx3D9lvC8kud3HKOyVg5mt8h5bRG3vvp7IeWV9chrFo=;
 b=LwoJUzy1N4KKUO/FAMiXG6frXIu9Pxu6PN08Kcz5OIzzAykOQ7vgJNH2ufVPdSutGG
 aJX7sdE6viB3tcUsVrza+QXcL1hh645/UPpWa9zpOzdK38G5wadSpDC8aKtdwubxOKrI
 YGgtMnaa9pPoR8kpXOXnyXOU9Oi3BVVw43oBqd9LcakD2vY3MK5jnrsEj9ETdGQnlo+y
 8OtwupOX6ymQiDOiq8Cku6RjIZGThPUxeKaqyiNzY/+aT9fueBDGGomP3vYFFr3AKk5G
 +2NV2n3bErrXn2obB4JBzrB0LkOVZs984Cy42ppfN41zU6FTwLKcOf1JVDCQ321CmQwE
 NAxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbpqUL76dUnpv8No0y6SFyl7f4RFL6BodvZd2PmY216gauz21Qdi/uj6emH0XRXORBn6SfRkEnTN61@nongnu.org
X-Gm-Message-State: AOJu0YxPZ7GqUR2x02OVzdxF49gIoK/3C6SFanbk49G1se+c9uSMQuJt
 owfGFhEqiUuel1BQxez0CC5lOT1wMIXl7RjuV39rCPOaMLfWt7FehndD2o25ett7OhT/mWg+BFu
 pdDEA4XhGO3/XxrVyzrmB87uLwYjfP+BLrthdTlVh
X-Gm-Gg: AY/fxX6QyWRXBS2FCJvgC136mo/VVRJFdHLoTOP96VZBFF08qUFxvezoAblcyDDD8Ch
 ynwhekqtgIUTgLPp0JcEdCsjreI/szJqIkIw3BqtkjK6I4+s7Xcy13PMsYpjhK2z6KtzYyM1Di/
 b4DRX0yFBzRFRC0M3nhm+P+Mk+5duYJEldQ40Yhr9y+KsbAQcGHf3doEYhvwu5CF5Z13MgUR+9G
 8BjldUA2aOVyiiLG9gh8tllhQL0/TwC7c5eVghSjCkxCwfxmhjflArlDqApYPbFjeD0nba+wPus
 6fnOeKtlGkAwKvFMt6gNeX8JdA==
X-Google-Smtp-Source: AGHT+IETFx2yf6Xk/LLQzHkasdKtZZumSTqLuCp3e1IsoAnxQCb0IH/iPubB8G72r4RSQVSQT+5yf7YbCnJy/rfCaSk=
X-Received: by 2002:a05:622a:307:b0:4f3:5474:3cb9 with SMTP id
 d75a77b69052e-4f4e4e2b98bmr40532341cf.14.1767037063614; Mon, 29 Dec 2025
 11:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-2-kane_chen@aspeedtech.com>
 <49c3d3ef-b918-4b65-b4ec-3b740cb489f9@kaod.org>
In-Reply-To: <49c3d3ef-b918-4b65-b4ec-3b740cb489f9@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:32 -0800
X-Gm-Features: AQt7F2pSp5g8b3f2pimsgbMKMmDbT_aKzlhXlWaatol0ybcqHSnAuxkv_rTKWZw
Message-ID: <CA+QoejVvXrZ2aJahFDu0cv6hXvYPyRrcGkM-crdZT1-7bjV1Gw@mail.gmail.com>
Subject: Re: [PATCH v4 01/19] hw/misc: Add LTPI controller
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x831.google.com
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

On Wed, Dec 24, 2025 at 2:36=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 12/24/25 02:41, Kane Chen via wrote:
> > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> >
> > LTPI (LVDS Tunneling Protocol & Interface) is defined in the OCP DC-SCM
> > 2.0 specification:
> > https://www.opencompute.org/documents/ocp-dc-scm-2-0-ltpi-ver-1-0-pdf
> >
> > LTPI is a protocol and physical interface for tunneling various low-spe=
ed
> > signals between the HPM and SCM. As shown in Figure 2, the AST27x0 (lef=
t)
> > integrates two LTPI controllers, allowing it to connect to up to two
> > extended boards.
> >
> > This commit introduces a simple device model for the ASPEED LTPI
> > controller in QEMU.
> >
> > The model includes basic MMIO read/write operations and sets default
> > register values during reset to emulate a link-up state.
> >
> > Implements register space with read/write callbacks.
> >
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>



> > ---
> >   include/hw/misc/aspeed_ltpi.h |  33 ++++++
> >   hw/misc/aspeed_ltpi.c         | 193 +++++++++++++++++++++++++++++++++=
+
> >   hw/misc/meson.build           |   1 +
> >   3 files changed, 227 insertions(+)
> >   create mode 100644 include/hw/misc/aspeed_ltpi.h
> >   create mode 100644 hw/misc/aspeed_ltpi.c
> >
> > diff --git a/include/hw/misc/aspeed_ltpi.h b/include/hw/misc/aspeed_ltp=
i.h
> > new file mode 100644
> > index 0000000000..e991afc666
> > --- /dev/null
> > +++ b/include/hw/misc/aspeed_ltpi.h
> > @@ -0,0 +1,33 @@
> > +/*
> > + * ASPEED LTPI Controller
> > + *
> > + * Copyright (C) 2025 ASPEED Technology Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#ifndef ASPEED_LTPI_H
> > +#define ASPEED_LTPI_H
> > +
> > +#include "hw/sysbus.h"
> > +
> > +#define TYPE_ASPEED_LTPI "aspeed.ltpi-ctrl"
> > +OBJECT_DECLARE_SIMPLE_TYPE(AspeedLTPIState, ASPEED_LTPI)
> > +
> > +#define ASPEED_LTPI_TOTAL_SIZE  0x900
> > +#define ASPEED_LTPI_CTRL_SIZE   0x200
> > +#define ASPEED_LTPI_PHY_SIZE    0x100
> > +#define ASPEED_LTPI_TOP_SIZE    0x100
> > +
> > +struct AspeedLTPIState {
> > +    SysBusDevice parent;
> > +    MemoryRegion mmio;
> > +    MemoryRegion mmio_ctrl;
> > +    MemoryRegion mmio_phy;
> > +    MemoryRegion mmio_top;
> > +
> > +    uint32_t ctrl_regs[ASPEED_LTPI_CTRL_SIZE >> 2];
> > +    uint32_t phy_regs[ASPEED_LTPI_PHY_SIZE >> 2];
> > +    uint32_t top_regs[ASPEED_LTPI_TOP_SIZE >> 2];
> > +};
> > +
> > +#endif /* ASPEED_LTPI_H */
> > diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
> > new file mode 100644
> > index 0000000000..131cea9c6b
> > --- /dev/null
> > +++ b/hw/misc/aspeed_ltpi.c
> > @@ -0,0 +1,193 @@
> > +/*
> > + * ASPEED LTPI Controller
> > + *
> > + * Copyright (C) 2025 ASPEED Technology Inc.
> > + *
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "migration/vmstate.h"
> > +#include "hw/misc/aspeed_ltpi.h"
> > +
> > +#define ASPEED_LTPI_CTRL_BASE   0x000
> > +#define ASPEED_LTPI_PHY_BASE    0x200
> > +#define ASPEED_LTPI_TOP_BASE    0x800
> > +
> > +#define LTPI_CTRL_LINK_MNG 0x42
> > +#define LTPI_PHY_MODE 0x0
> > +
> > +static uint64_t aspeed_ltpi_top_read(void *opaque, hwaddr offset, unsi=
gned size)
> > +{
> > +    AspeedLTPIState *s =3D opaque;
> > +    uint32_t idx =3D offset >> 2;
> > +
> > +    return s->top_regs[idx];
> > +}
> > +
> > +static void aspeed_ltpi_top_write(void *opaque, hwaddr offset,
> > +                              uint64_t val, unsigned size)
> > +{
> > +    AspeedLTPIState *s =3D opaque;
> > +    uint32_t idx =3D offset >> 2;
> > +
> > +    switch (offset) {
> > +    default:
> > +        s->top_regs[idx] =3D (uint32_t)val;
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps aspeed_ltpi_top_ops =3D {
> > +    .read =3D aspeed_ltpi_top_read,
> > +    .write =3D aspeed_ltpi_top_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static uint64_t aspeed_ltpi_phy_read(void *opaque, hwaddr offset, unsi=
gned size)
> > +{
> > +    AspeedLTPIState *s =3D opaque;
> > +    uint32_t idx =3D offset >> 2;
> > +
> > +    return s->phy_regs[idx];
> > +}
> > +
> > +static void aspeed_ltpi_phy_write(void *opaque, hwaddr offset,
> > +                              uint64_t val, unsigned size)
> > +{
> > +    AspeedLTPIState *s =3D opaque;
> > +    uint32_t idx =3D offset >> 2;
> > +
> > +    switch (offset) {
> > +    default:
> > +        s->phy_regs[idx] =3D (uint32_t)val;
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps aspeed_ltpi_phy_ops =3D {
> > +    .read =3D aspeed_ltpi_phy_read,
> > +    .write =3D aspeed_ltpi_phy_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static uint64_t aspeed_ltpi_ctrl_read(void *opaque,
> > +                                      hwaddr offset, unsigned size)
> > +{
> > +    AspeedLTPIState *s =3D opaque;
> > +    uint32_t idx =3D offset >> 2;
> > +
> > +    return s->ctrl_regs[idx];
> > +}
> > +
> > +static void aspeed_ltpi_ctrl_write(void *opaque, hwaddr offset,
> > +                              uint64_t val, unsigned size)
> > +{
> > +    AspeedLTPIState *s =3D opaque;
> > +    uint32_t idx =3D offset >> 2;
> > +
> > +    switch (offset) {
> > +    default:
> > +        s->ctrl_regs[idx] =3D (uint32_t)val;
> > +        break;
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps aspeed_ltpi_ctrl_ops =3D {
> > +    .read =3D aspeed_ltpi_ctrl_read,
> > +    .write =3D aspeed_ltpi_ctrl_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void aspeed_ltpi_reset(DeviceState *dev)
> > +{
> > +    AspeedLTPIState *s =3D ASPEED_LTPI(dev);
> > +
> > +    memset(s->ctrl_regs, 0, sizeof(s->ctrl_regs));
> > +    memset(s->phy_regs, 0, sizeof(s->phy_regs));
> > +    memset(s->top_regs, 0, sizeof(s->top_regs));
> > +    /* set default values */
> > +    s->ctrl_regs[LTPI_CTRL_LINK_MNG] =3D 0x11900007;
> > +    s->phy_regs[LTPI_PHY_MODE] =3D 0x2;
> > +}
> > +
> > +
> > +static const VMStateDescription vmstate_aspeed_ltpi =3D {
> > +    .name =3D TYPE_ASPEED_LTPI,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(ctrl_regs, AspeedLTPIState,
> > +                             ASPEED_LTPI_CTRL_SIZE >> 2),
> > +        VMSTATE_UINT32_ARRAY(phy_regs, AspeedLTPIState,
> > +                             ASPEED_LTPI_PHY_SIZE >> 2),
> > +        VMSTATE_UINT32_ARRAY(top_regs, AspeedLTPIState,
> > +                             ASPEED_LTPI_TOP_SIZE >> 2),
> > +
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static void aspeed_ltpi_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AspeedLTPIState *s =3D ASPEED_LTPI(dev);
> > +
> > +    memory_region_init(&s->mmio, OBJECT(s), TYPE_ASPEED_LTPI,
> > +                       ASPEED_LTPI_TOTAL_SIZE);
> > +
> > +    memory_region_init_io(&s->mmio_ctrl, OBJECT(s),
> > +                          &aspeed_ltpi_ctrl_ops, s,
> > +                          "aspeed-ltpi-ctrl", ASPEED_LTPI_CTRL_SIZE);
> > +
> > +    memory_region_init_io(&s->mmio_phy, OBJECT(s),
> > +                          &aspeed_ltpi_phy_ops, s,
> > +                          "aspeed-ltpi-phy", ASPEED_LTPI_PHY_SIZE);
> > +
> > +    memory_region_init_io(&s->mmio_top, OBJECT(s),
> > +                          &aspeed_ltpi_top_ops, s,
> > +                          "aspeed-ltpi-top", ASPEED_LTPI_TOP_SIZE);
> > +
> > +    memory_region_add_subregion(&s->mmio,
> > +                                ASPEED_LTPI_CTRL_BASE, &s->mmio_ctrl);
> > +    memory_region_add_subregion(&s->mmio,
> > +                                ASPEED_LTPI_PHY_BASE, &s->mmio_phy);
> > +    memory_region_add_subregion(&s->mmio,
> > +                                ASPEED_LTPI_TOP_BASE, &s->mmio_top);
> > +
> > +    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
> > +}
> > +
> > +static void aspeed_ltpi_class_init(ObjectClass *klass, const void *dat=
a)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    dc->realize =3D aspeed_ltpi_realize;
> > +    dc->vmsd =3D &vmstate_aspeed_ltpi;
> > +    device_class_set_legacy_reset(dc, aspeed_ltpi_reset);
> > +}
> > +
> > +static const TypeInfo aspeed_ltpi_info =3D {
> > +    .name          =3D TYPE_ASPEED_LTPI,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(AspeedLTPIState),
> > +    .class_init    =3D aspeed_ltpi_class_init,
> > +};
> > +
> > +static void aspeed_ltpi_register_types(void)
> > +{
> > +    type_register_static(&aspeed_ltpi_info);
> > +}
> > +
> > +type_init(aspeed_ltpi_register_types);
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index b1d8d8e5d2..45b16e7797 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -136,6 +136,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: f=
iles(
> >     'aspeed_hace.c',
> >     'aspeed_i3c.c',
> >     'aspeed_lpc.c',
> > +  'aspeed_ltpi.c',
> >     'aspeed_scu.c',
> >     'aspeed_sbc.c',
> >     'aspeed_sdmc.c',
>

