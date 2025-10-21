Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD91CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAYA-0001sW-2U; Tue, 21 Oct 2025 07:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBAY1-0001s0-HV
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:29:04 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vBAXz-0007S1-FB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:29:01 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-88f79ae58d9so722730285a.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761046137; x=1761650937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kN8UOJ6sYYeY4W6Z7vaiuSTM7zji1MAjr1+NfxFqSs=;
 b=f+tkfNO0MEdZagOdCwLQPKPWl/2Z96wdRIQ0cgC2ZrM0OBGXyTlboacdqxerPg94xf
 kpYTAcka2dLH3cWoKAGCQd8sw0A2fFO9e70qqNFtCoPEqmiDJQviuLoEJWi7BiCjPcpP
 Kcvv0YmHVWDt0FmfwM9rAQhM6+mPRo/PWpi0SrIAifYEMDKOnW7YgoTHCjeVWq1xuI2W
 ISQmfaNIYikR6ebF+VRadzcCrUG0qdWdIN+Nzti5TFbZbxXvDXNLbo/9bq/7H2rKSfsz
 J7dKp6CxVHWuI8yCWAaZW9R2zHUztkjIvWqloj1sIwFobq4INGaDfBvrr0hE0PhiCbof
 xcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761046137; x=1761650937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kN8UOJ6sYYeY4W6Z7vaiuSTM7zji1MAjr1+NfxFqSs=;
 b=IpS3INGcltpmKA202FxBFnwDoHrdfZW4kfAsfR7JnDylQ94WavUrOevOEV9YtiR3bL
 HlsndLtrhu3h8SIjI4iU5fwie+T9h40X78WmXf8vNZAhr5d/yRc2Jc1DyWD6VtUKRdvN
 kiBWRuBcmImAUBJpw67q4GvYgJEpgzan/y2gbqmlLqoR2w0cFxDA85R4gl+nQ3vxoUjQ
 OyjZsv5RW2AHYYJ9RMVM2qSD1HPP8+BEQ02plQLSX0ouA6ddxMjRNES07bpx1X12VbRg
 bG1v8hiUXUFEKRICryuc20d9O2ZbCK/1VqHoH3rocv/lYrKc89KrBTG6nIS9mXl3b8FO
 wDfA==
X-Gm-Message-State: AOJu0YyK6jCJ4OmzxR7eEAluJUSOuFH3tn8grgXui5up3gA1ZbHiPnZg
 OrFvz+FtlfJeBa7BTiyQG8JUpreOBhf11ws8LVaaXvpOklSuLNzLVZsNb2KhxytM8E7lV+XmBEn
 auzvmLniE6Fx1v94MIN2sDZ8dUnS117ms11Vmx5Ca4w==
X-Gm-Gg: ASbGnctCdyfryKQpfgu3xISnEtj2bLG9lzxJSwlMAvoVpha9/oJ3qWZcAHwB4/4dXYX
 NWBTFC46DT7IqGyMMr3XvZ9BX/dTjCqVXijrWoy6xI4aM5r5X9GLF/5Dl6T2kIeij6kxDXzKzlR
 lNx4hL127kQS/bo+v/BC73efqqtxR+pk4ylrZzJ9fKAVZNX3mD5gfrjQdmOJj+kHt6QrjW55LY1
 xXHOemZlJW3jj16wEdxGddxS9uvt+8qNiQiAT086hFsRkf78lfNhXYyjp9aCKwyNQzA65fCkeHV
 d0Mf2mm54Qt3g1o8
X-Google-Smtp-Source: AGHT+IFlDcj+HZuAHJmEV66L+2SqDz35hTJRv1s3pMllOwOGRhTgz7vTJEn2cHRFD+R8eAE0ok+oLq5REtyMnbWMUow=
X-Received: by 2002:ac8:598b:0:b0:4bd:a790:e485 with SMTP id
 d75a77b69052e-4e89d283727mr197169171cf.25.1761046137246; Tue, 21 Oct 2025
 04:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-9-marcandre.lureau@redhat.com>
 <292dc18a-9386-3887-bc9c-186a8fb70f59@eik.bme.hu>
In-Reply-To: <292dc18a-9386-3887-bc9c-186a8fb70f59@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Oct 2025 15:28:45 +0400
X-Gm-Features: AS18NWCXGNye9sAfnnq2J1ff-PP45YBa-0LWSuy7quvIHdXSC_maBTKQueyFAkU
Message-ID: <CAJ+F1CJ9eEV2TKXHHwCYfB4PsyAutjM5CkC2GCtTQDXYe5TqJw@mail.gmail.com>
Subject: Re: [PATCH 08/43] qdev: add qdev_find_default_bus()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72d.google.com
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

On Tue, Oct 21, 2025 at 3:24=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 21 Oct 2025, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This helper is used next by -audio code.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > include/monitor/qdev.h |  3 +++
> > system/qdev-monitor.c  | 21 +++++++++++++++++----
> > 2 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> > index 1d57bf6577..de33637869 100644
> > --- a/include/monitor/qdev.h
> > +++ b/include/monitor/qdev.h
> > @@ -1,6 +1,8 @@
> > #ifndef MONITOR_QDEV_H
> > #define MONITOR_QDEV_H
> >
> > +#include "hw/qdev-core.h"
> > +
> > /*** monitor commands ***/
> >
> > void hmp_info_qtree(Monitor *mon, const QDict *qdict);
> > @@ -11,6 +13,7 @@ int qdev_device_help(QemuOpts *opts);
> > DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
> > DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >                                         bool from_json, Error **errp);
> > +BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp);
> >
> > /**
> >  * qdev_set_id: parent the device and set its id if provided.
> > diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> > index 2ac92d0a07..4b732f579a 100644
> > --- a/system/qdev-monitor.c
> > +++ b/system/qdev-monitor.c
> > @@ -621,6 +621,21 @@ const char *qdev_set_id(DeviceState *dev, char *id=
, Error **errp)
> >     return prop->name;
> > }
> >
> > +BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp)
> > +{
> > +    BusState *bus =3D NULL;
> > +
> > +    assert(dc->bus_type !=3D NULL);
> > +    bus =3D qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_ty=
pe);
> > +    if (!bus || qbus_is_full(bus)) {
> > +        error_setg(errp, "No '%s' bus found for device '%s'",
> > +                   dc->bus_type, object_class_get_name(OBJECT_CLASS(dc=
)));
> > +        return NULL;
>
> Should it differrentiate between no bus and a bus that exists but full an=
d
> return different error to help debugging?
>

qdev_device_add_from_qdict() doesn't distinguish it either, but it
could be useful indeed. I will report a different error.

> Regards,
> BALATON Zoltan
>
> > +    }
> > +
> > +    return bus;
> > +}
> > +
> > DeviceState *qdev_device_add_from_qdict(const QDict *opts,
> >                                         bool from_json, Error **errp)
> > {
> > @@ -657,10 +672,8 @@ DeviceState *qdev_device_add_from_qdict(const QDic=
t *opts,
> >             return NULL;
> >         }
> >     } else if (dc->bus_type !=3D NULL) {
> > -        bus =3D qbus_find_recursive(sysbus_get_default(), NULL, dc->bu=
s_type);
> > -        if (!bus || qbus_is_full(bus)) {
> > -            error_setg(errp, "No '%s' bus found for device '%s'",
> > -                       dc->bus_type, driver);
> > +        bus =3D qdev_find_default_bus(dc, errp);
> > +        if (!bus) {
> >             return NULL;
> >         }
> >     }
> >



--=20
Marc-Andr=C3=A9 Lureau

