Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF06E92FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ3y-0003cL-Jd; Mon, 29 Dec 2025 14:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3x-0003ZC-K5
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:53 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vaJ3v-0000E3-Km
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:37:53 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4f34f257a1bso3264201cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:37:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767037071; cv=none;
 d=google.com; s=arc-20240605;
 b=PPO3XwGuMHnrMrjMOSYdNXUGu9m6vt2fq0h0quIL+HOHntMLMBTBQbPIDin3vbsXHy
 HYkrDAwiS50TO/TO3rO2c9oO6Btzp7uCpdQI+av8PmyJHoW/1uSSc1dD9J71MiJ55CKT
 IKsaUtFWAzqEKEzq772hebIabzW/SxzyL3IfDy+fCNn2MrHvfB9xirX9vyhmBh58GHPe
 oazC/c+bQN70Oge+0ZCVDiPljNs72+2a543Sq08GNp6q1yLY7tcE+TxljRJ3dMH7NrxX
 4hbvvPjUEO/Q9+puj9U3qmgB7hzmeBXEW36mW5R/wUK3L8Ia0LREmWRIPu4RJr+EaWRU
 7TMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Oc0Eicmqsegr21jAAuYrfaRxCYikt927C1D4WMgzzqs=;
 fh=jVxH/1kNtL0li+/XxnQIlrGjaEUuwX87g3uuLArS/qA=;
 b=F8EgZp3f20fKDjjILC2mFzYjV4NmElhjosx+S+EGF9k0UFva163v0Z4d2zwrOg3Y4G
 m7k8SXdu6L7WNszSDBAX5fxftWQYl392ON7QHZ4hqdrO9g4jIo/K4v6vv/GFB9SkwWzs
 dVNUAEQYqICPgrlGgi9pQ/o1kDylxcEcamI8GFwdonxsWrBO8hyieWYEBPEoKbgfr8HX
 chqZPmt1dT5iKN8WPP/LRJlSRz+Di1vNdf79wka3KQj6CeKRbRx9W2S78k7dCNpjNzPd
 GbX7TkQvxa7UbtaFnhzY0TiFZMttjwcCHKINSghAD4Ce5ElPth/oIZ3Zw66kMgi8FBfj
 /Fhg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767037071; x=1767641871; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oc0Eicmqsegr21jAAuYrfaRxCYikt927C1D4WMgzzqs=;
 b=TinwYl2zLFcmDphcbE4q/rrLl646jOybUn5IhVLmlPa6ndcRFb6YnCAN8Frj3oo+ag
 1vzF9Q1rZb/vWBvwqZCAuwU2fz8QxtnSjvG2ZGVerlEfufyzIvlC6JdsWg01H+aMAvGz
 eHKFbxLAoswFZ1ubZC7hCzgje3DUjIYbfW3R+CxQsChZGz91WESHYjCTUTZVi81m8tJs
 /oDRgMMKv5fa/FWn2wilDgYL1dID0+Ozbr3J8pRvyuNG836uXjKFbEcCtJKcRrVDPkVr
 ag2pYdjoCodTjqDGceqKD+NmIYC8VsNCQ1PGGS0zb1gaIwyoBA34HPgLRvc0WsZGsJ4v
 HRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037071; x=1767641871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oc0Eicmqsegr21jAAuYrfaRxCYikt927C1D4WMgzzqs=;
 b=Df8SKmfPH8AwOIhYaLuuOzTZsz0be4hSp+jNzyoIcICoouCKcAL+oINsEOzitxwv/J
 aHK8/qp4U3znOTxdG+YIXuz2u3aRHIKJSR/xIewZxLSNDlL4vowSaSqv/pLmw7sb/ZIC
 0DHTaSFY2nwICg0xEfYj/eIricie8AIX+pCQILLaNqnsCWt/PMM2XRrNcRprGude3iXn
 lc2Hfb7qcY240IhdPdFV8/0FrEcdu+PY4aWeaQWRXmgCEemU+r5dalAC7ehK2x7+f4Ae
 CleaAevCGzjNH9cg5w2DnMkU6IrF9135Kt5IDSAmWLOgejKEZlHvN7TCyCVPAO80Vg8i
 7n7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwBg0l56B434wPMrdh6ZCAbvXN6PbIELRgXgw+OMAs0Zg1tVGL57G+XV03DES6v+a0W86AAv3rv2VJ@nongnu.org
X-Gm-Message-State: AOJu0YyLXjeexPEPdH2F8I1ObFGAYtw5Hi7D938YPoyUkliIrLL4wbpZ
 jzTJEBeDjWtpdnEjdvpL6Nc9mMwnzkfKpxJtXcHPZAOr1e2kV8+jWxXluZC9eV8EoeLCknyfTnO
 +94kT8JqUK+h8KZav6LnwyKjf7zRhIU3qSdIVcnb1
X-Gm-Gg: AY/fxX5H6lO6lIiEamiXxxmFuwsUG1tWAoWyUa6YuIsZjuRByrINSeyXQeuxle1CLjZ
 2PIHWQ2B1GYxOSF2NKpiQB3mnoiQoD0a9Abiru64kKkt3fCVZEHdQ+sbDryFYDphbhxtVv3Jwv2
 iKXVRtrSnv7BMTVC3OT1M4uLsUugFuDGuoWkzsQ9HYB10h+HAKVoUMJX/P3S4pB3u6XtCD4CeQa
 0qE88XrvzO/195dQJPnuR2BbKVm7Q1hNr12QwC4t8PM7+/F9TR7YTicDsEES+b9TpsoyIwLgZOG
 kDVHlpkiBA2YcGwvUQpEhahlEQ==
X-Google-Smtp-Source: AGHT+IGI3DQccZWs8wOV17/EJ95hoNum8iNBrD1xrOsLczR3U0JhXxaRTGM272h90Cdl0P5zxm3ZnH6xlmCsH7CNj9g=
X-Received: by 2002:a05:622a:307:b0:4eb:7681:d90 with SMTP id
 d75a77b69052e-4f4e4e5b475mr31215111cf.16.1767037070433; Mon, 29 Dec 2025
 11:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20251224014203.756264-1-kane_chen@aspeedtech.com>
 <20251224014203.756264-4-kane_chen@aspeedtech.com>
 <3369eba7-b1f9-4356-8f77-d2da2c6b7b07@kaod.org>
In-Reply-To: <3369eba7-b1f9-4356-8f77-d2da2c6b7b07@kaod.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Mon, 29 Dec 2025 11:37:39 -0800
X-Gm-Features: AQt7F2pUyy2IxM18pk7vkf5j05FvHx8BXjNR5ZDVYNGugM94Ww72XQzVGcmbMOs
Message-ID: <CA+QoejWGK5s2EOSp3OXUXFHExNxvmUr6PDnOo5W=g4rATBJ=_A@mail.gmail.com>
Subject: Re: [PATCH v4 03/19] hw/misc: Add basic Aspeed PWM model
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=nabihestefan@google.com; helo=mail-qt1-x830.google.com
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

On Wed, Dec 24, 2025 at 2:37=E2=80=AFAM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> On 12/24/25 02:41, Kane Chen via wrote:
> > From: Kane-Chen-AS <kane_chen@aspeedtech.com>
>
> It should be From: clg ...
>
> I will fix it. Don't resend for that.
>
>
> Thanks,
>
> C.
>
> >
> > Add an initial PWM model for Aspeed SoCs, including device state,
> > register definitions, and basic initialization as a sysbus device.
> >
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>

Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


> > ---
> >   include/hw/arm/aspeed_soc.h  |   3 +-
> >   include/hw/misc/aspeed_pwm.h |  31 +++++++++
> >   hw/misc/aspeed_pwm.c         | 121 ++++++++++++++++++++++++++++++++++=
+
> >   hw/misc/meson.build          |   1 +
> >   hw/misc/trace-events         |   4 ++
> >   5 files changed, 159 insertions(+), 1 deletion(-)
> >   create mode 100644 include/hw/misc/aspeed_pwm.h
> >   create mode 100644 hw/misc/aspeed_pwm.c
> >
> > diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> > index bca10c387b..7b08cca908 100644
> > --- a/include/hw/arm/aspeed_soc.h
> > +++ b/include/hw/arm/aspeed_soc.h
> > @@ -28,6 +28,7 @@
> >   #include "hw/misc/aspeed_hace.h"
> >   #include "hw/misc/aspeed_sbc.h"
> >   #include "hw/misc/aspeed_sli.h"
> > +#include "hw/misc/aspeed_pwm.h"
> >   #include "hw/watchdog/wdt_aspeed.h"
> >   #include "hw/net/ftgmac100.h"
> >   #include "target/arm/cpu.h"
> > @@ -88,6 +89,7 @@ struct AspeedSoCState {
> >       MemoryRegion secsram;
> >       UnimplementedDeviceState sbc_unimplemented;
> >       AspeedSDMCState sdmc;
> > +    AspeedPWMState pwm;
> >       AspeedWDTState wdt[ASPEED_WDTS_NUM];
> >       FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
> >       AspeedMiiState mii[ASPEED_MACS_NUM];
> > @@ -108,7 +110,6 @@ struct AspeedSoCState {
> >       UnimplementedDeviceState video;
> >       UnimplementedDeviceState emmc_boot_controller;
> >       UnimplementedDeviceState dpmcu;
> > -    UnimplementedDeviceState pwm;
> >       UnimplementedDeviceState espi;
> >       UnimplementedDeviceState udc;
> >       UnimplementedDeviceState ltpi;
> > diff --git a/include/hw/misc/aspeed_pwm.h b/include/hw/misc/aspeed_pwm.=
h
> > new file mode 100644
> > index 0000000000..13dc3ea45b
> > --- /dev/null
> > +++ b/include/hw/misc/aspeed_pwm.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * ASPEED PWM Controller
> > + *
> > + * Copyright (C) 2017-2021 IBM Corp.
> > + *
> > + * This code is licensed under the GPL version 2 or later.  See
> > + * the COPYING file in the top-level directory.
> > + */
> > +
> > +#ifndef ASPEED_PWM_H
> > +#define ASPEED_PWM_H
> > +
> > +#include "hw/sysbus.h"
> > +
> > +#define TYPE_ASPEED_PWM "aspeed.pwm"
> > +#define ASPEED_PWM(obj) OBJECT_CHECK(AspeedPWMState, (obj), TYPE_ASPEE=
D_PWM)
> > +
> > +#define ASPEED_PWM_NR_REGS (0x10C >> 2)
> > +
> > +typedef struct AspeedPWMState {
> > +    /* <private> */
> > +    SysBusDevice parent;
> > +
> > +    /*< public >*/
> > +    MemoryRegion iomem;
> > +    qemu_irq irq;
> > +
> > +    uint32_t regs[ASPEED_PWM_NR_REGS];
> > +} AspeedPWMState;
> > +
> > +#endif /* _ASPEED_PWM_H_ */
> > diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c
> > new file mode 100644
> > index 0000000000..de209274af
> > --- /dev/null
> > +++ b/hw/misc/aspeed_pwm.c
> > @@ -0,0 +1,121 @@
> > +/*
> > + * ASPEED PWM Controller
> > + *
> > + * Copyright (C) 2017-2021 IBM Corp.
> > + *
> > + * This code is licensed under the GPL version 2 or later.  See
> > + * the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/log.h"
> > +#include "qemu/error-report.h"
> > +#include "hw/misc/aspeed_pwm.h"
> > +#include "qapi/error.h"
> > +#include "migration/vmstate.h"
> > +
> > +#include "trace.h"
> > +
> > +static uint64_t aspeed_pwm_read(void *opaque, hwaddr addr,
> > +                                     unsigned int size)
> > +{
> > +    AspeedPWMState *s =3D ASPEED_PWM(opaque);
> > +    uint64_t val =3D 0;
> > +
> > +    addr >>=3D 2;
> > +
> > +    if (addr >=3D ASPEED_PWM_NR_REGS) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PR=
Ix "\n",
> > +                      __func__, addr << 2);
> > +    } else {
> > +        val =3D s->regs[addr];
> > +    }
> > +
> > +    trace_aspeed_pwm_read(addr << 2, val);
> > +
> > +    return val;
> > +}
> > +
> > +static void aspeed_pwm_write(void *opaque, hwaddr addr, uint64_t data,
> > +                              unsigned int size)
> > +{
> > +    AspeedPWMState *s =3D ASPEED_PWM(opaque);
> > +
> > +    trace_aspeed_pwm_write(addr, data);
> > +
> > +    addr >>=3D 2;
> > +
> > +    if (addr >=3D ASPEED_PWM_NR_REGS) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_P=
RIx "\n",
> > +                      __func__, addr << 2);
> > +        return;
> > +    }
> > +
> > +    s->regs[addr] =3D data;
> > +}
> > +
> > +static const MemoryRegionOps aspeed_pwm_ops =3D {
> > +    .read =3D aspeed_pwm_read,
> > +    .write =3D aspeed_pwm_write,
> > +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> > +    },
> > +};
> > +
> > +static void aspeed_pwm_reset(DeviceState *dev)
> > +{
> > +    struct AspeedPWMState *s =3D ASPEED_PWM(dev);
> > +
> > +    memset(s->regs, 0, sizeof(s->regs));
> > +}
> > +
> > +static void aspeed_pwm_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AspeedPWMState *s =3D ASPEED_PWM(dev);
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> > +
> > +    sysbus_init_irq(sbd, &s->irq);
> > +
> > +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_pwm_ops, s,
> > +            TYPE_ASPEED_PWM, 0x1000);
> > +
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +}
> > +
> > +static const VMStateDescription vmstate_aspeed_pwm =3D {
> > +    .name =3D TYPE_ASPEED_PWM,
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, AspeedPWMState, ASPEED_PWM_NR_REGS)=
,
> > +        VMSTATE_END_OF_LIST(),
> > +    }
> > +};
> > +
> > +static void aspeed_pwm_class_init(ObjectClass *klass, const void *data=
)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->realize =3D aspeed_pwm_realize;
> > +    device_class_set_legacy_reset(dc, aspeed_pwm_reset);
> > +    dc->desc =3D "Aspeed PWM Controller";
> > +    dc->vmsd =3D &vmstate_aspeed_pwm;
> > +}
> > +
> > +static const TypeInfo aspeed_pwm_info =3D {
> > +    .name =3D TYPE_ASPEED_PWM,
> > +    .parent =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(AspeedPWMState),
> > +    .class_init =3D aspeed_pwm_class_init,
> > +};
> > +
> > +static void aspeed_pwm_register_types(void)
> > +{
> > +    type_register_static(&aspeed_pwm_info);
> > +}
> > +
> > +type_init(aspeed_pwm_register_types);
> > diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> > index 45b16e7797..7afe1d0009 100644
> > --- a/hw/misc/meson.build
> > +++ b/hw/misc/meson.build
> > @@ -137,6 +137,7 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: f=
iles(
> >     'aspeed_i3c.c',
> >     'aspeed_lpc.c',
> >     'aspeed_ltpi.c',
> > +  'aspeed_pwm.c',
> >     'aspeed_scu.c',
> >     'aspeed_sbc.c',
> >     'aspeed_sdmc.c',
> > diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> > index eeb9243898..f7870babba 100644
> > --- a/hw/misc/trace-events
> > +++ b/hw/misc/trace-events
> > @@ -299,6 +299,10 @@ aspeed_i3c_write(uint64_t offset, uint64_t data) "=
I3C write: offset 0x%" PRIx64
> >   aspeed_i3c_device_read(uint32_t deviceid, uint64_t offset, uint64_t d=
ata) "I3C Dev[%u] read: offset 0x%" PRIx64 " data 0x%" PRIx64
> >   aspeed_i3c_device_write(uint32_t deviceid, uint64_t offset, uint64_t =
data) "I3C Dev[%u] write: offset 0x%" PRIx64 " data 0x%" PRIx64
> >
> > +# aspeed_pwm.c
> > +aspeed_pwm_read(uint64_t offset, uint64_t data) "read: offset 0x%" PRI=
x64 " data 0x%" PRIx64
> > +aspeed_pwm_write(uint64_t offset, uint64_t data) "write: offset 0x%" P=
RIx64 " data 0x%" PRIx64
> > +
> >   # aspeed_sdmc.c
> >   aspeed_sdmc_write(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " da=
ta: 0x%" PRIx64
> >   aspeed_sdmc_read(uint64_t reg, uint64_t data) "reg @0x%" PRIx64 " dat=
a: 0x%" PRIx64
>

