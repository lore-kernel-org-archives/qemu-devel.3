Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49371CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXLp-0006jt-O7; Wed, 22 Oct 2025 07:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBXLk-0006jX-Vm
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:49:52 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBXLj-0003Yl-EA
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:49:52 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-88f79ae58f0so939435685a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761133790; x=1761738590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AE9YhejqwmJkEXrvvR0AWExh0C/M7UF/K66oXrDBPY=;
 b=bXs3mKRK3rgW4Mf5uaMaawrxSbOQsyxdsGRPFd/I8IxbVptm/hmxf0fnCzoG5xMYT3
 xy2JBKyvzdlZJzjOBVY8yK2wFOQjaM+/CjOfTZjkQdY2RKDgRIZQaMZq/S6SosCKP5ZG
 E73iqhBypFqMms1juWPEN5AzND/XKA35A0nNf8glFjmi2gNdl1ppt+1j8yBaZoV4q80W
 DaHHp/lklt5wRtaIw86ki+Lu1mC1SZaGnongP4hboC4kM6MKT1CrjbuBPT3H/PQd9eaM
 r5e1V0CPPchkOLMxzN7GrN63VdI2KGFiYVEGTKyrob7kocwgYsRiQbZTYsO+DvkpnzbT
 +Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761133790; x=1761738590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AE9YhejqwmJkEXrvvR0AWExh0C/M7UF/K66oXrDBPY=;
 b=MZUxomfne2Lnoowyopkhu2zmRWWUZ68EFtdG/jDDQGlCjI6O7ReCDn4OmTz61+i+Wm
 O32aWcYHJh8r+XWHctdmMMx5xakz9FLMdn8zLC8BRwggcVNK6g4bWhzVmgqoXTFHCEiW
 MiNd+5DEYo/uTiY2B877K3EoFEVGVWcFqbmBufUbVtFk/tiAXGLFtU1n+cIBpv2BZB8r
 qLldk6E+LEmtnaALx9aNSY2FcgSbxQ8vNEvP8LGAfSHekcPsQyc3NzGRLghUQjScC8IR
 GxLqeYGNeeb4BozFYTSVEDFRdIDUm0XZfohPQGA4iTp77iT/ZIYT6swCRjaEQ6rZ9quq
 fpLQ==
X-Gm-Message-State: AOJu0YxesHexvZL4KqUWiB4mrJ2ryNlGIrmlGE3VM1B9YujS5A4udH8i
 PMH/l8HJ+kmGEGs6vHLOzkBFJLbc0MdpZM02f1leCDrgFgOoHsLAazk24DjKMhWuYfAXoS2o2Sk
 dL2o6xHJvdwR+zU37Wbyt4cMoiRhNiQY=
X-Gm-Gg: ASbGnctLyZLR/+g5tmCsMiFGAqLiQp3C9oMuLgpr7w10c4BYgwCHXsdpGA/gb6vS5Ia
 ngV8joFX5foZfJycmsjVEXnHTNPj2Mph7H6LMAdDnv+5zNalb+Tj8/MEcNqohSfBshXKZFgyp7q
 NsW31qd3ThT2Q5WDzHHbaQRIGpzlNFfDPy5OyZ/O6CoQaNabZ5zzEu0WpBVHj+DaG5sXZfUcaec
 b9EiDkynTfG1Ql9uIxEFRdkV+rY/fyIUdO1FAqYo11Gqhml5UDzp7DAY3Gtc4u4Cqo07RWe2+4H
 0PUsYomA1jeA9n/i
X-Google-Smtp-Source: AGHT+IEZB7Vf/HnkgOy9TOAe1cAibuhyeoTlj4PdZGwzYwVEL8Vz9cXg7LtcgTnENWjLwpvBudukk0os04utMiDz84g=
X-Received: by 2002:a05:620a:7084:b0:892:9838:b17a with SMTP id
 af79cd13be357-8929838b4e5mr1400273385a.3.1761133789808; Wed, 22 Oct 2025
 04:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-14-marcandre.lureau@redhat.com>
 <91f1eeb7-00ef-c8a7-7025-b8d9e43da42b@eik.bme.hu>
In-Reply-To: <91f1eeb7-00ef-c8a7-7025-b8d9e43da42b@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Oct 2025 15:49:37 +0400
X-Gm-Features: AS18NWDmbiA307lkHXG2zk4eYVbB2rmFI1SX_YXCrAzRyu2dkpG9kVzI8jCi0GY
Message-ID: <CAJ+F1C+nFFU+pOjQ_5gMKFxKHvzA1t_Wpu5Z5F4k0pQAMeC32w@mail.gmail.com>
Subject: Re: [PATCH v2 13/42] hw/audio: simplify 'hda' audio init code
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Wed, Oct 22, 2025 at 3:42=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Wed, 22 Oct 2025, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > For consistency, use only qdev_device_add() to instantiate the devices.
> > We can't rely on automatic bus lookup for the "hda-duplex" device thoug=
h
> > as it may end up on a different "intel-hda" bus...
>
> Maybe this needs a better commit message. My first question was how is
> this simpler when it's 6 lines more and at least to me less obvious what
> it does. The real goal may be to make it independent from PCI for the nex=
t
> patch so maybe that's what the commit message should also say.

I agree it's not as simple and generalized as I wish it would have ended.

But this allows to make init() callback bus-agnostic though. I will
add this to the commit message.

There might be other ways to do that.

> Regards,
> BALATON Zoltan
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > hw/audio/intel-hda.c | 14 ++++++++++----
> > 1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> > index 6a0db0dd9e..14bcf1257d 100644
> > --- a/hw/audio/intel-hda.c
> > +++ b/hw/audio/intel-hda.c
> > @@ -21,6 +21,7 @@
> > #include "hw/pci/pci.h"
> > #include "hw/qdev-properties.h"
> > #include "hw/pci/msi.h"
> > +#include "monitor/qdev.h"
> > #include "qemu/timer.h"
> > #include "qemu/bitops.h"
> > #include "qemu/log.h"
> > @@ -30,6 +31,7 @@
> > #include "intel-hda.h"
> > #include "migration/vmstate.h"
> > #include "intel-hda-defs.h"
> > +#include "qobject/qdict.h"
> > #include "system/dma.h"
> > #include "qapi/error.h"
> > #include "qom/object.h"
> > @@ -1305,15 +1307,19 @@ static const TypeInfo hda_codec_device_type_inf=
o =3D {
> >  */
> > static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
> > {
> > -    DeviceState *controller;
> > +    g_autoptr(QDict) props =3D qdict_new();
> > +    DeviceState *intel_hda, *codec;
> >     BusState *hdabus;
> > -    DeviceState *codec;
> >
> > -    controller =3D DEVICE(pci_create_simple(bus, -1, "intel-hda"));
> > -    hdabus =3D QLIST_FIRST(&controller->child_bus);
> > +    qdict_put_str(props, "driver", "intel-hda");
> > +    intel_hda =3D qdev_device_add_from_qdict(props, false, &error_fata=
l);
> > +    hdabus =3D QLIST_FIRST(&intel_hda->child_bus);
> > +
> >     codec =3D qdev_new("hda-duplex");
> >     qdev_prop_set_string(codec, "audiodev", audiodev);
> >     qdev_realize_and_unref(codec, hdabus, &error_fatal);
> > +    object_unref(intel_hda);
> > +
> >     return 0;
> > }
> >
> >



--=20
Marc-Andr=C3=A9 Lureau

