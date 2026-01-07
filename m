Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6E1CF6C00
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdOvk-0003vO-T7; Wed, 07 Jan 2026 03:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vdOvj-0003up-3N
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:30:11 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vdOvh-0005AT-4q
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:30:10 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64b9b0b4d5dso3690923a12.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767774606; x=1768379406; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RqWPNul5hnbcIZ6LSpMbQYu7eMRnWXA+MM+Sjnx6BtE=;
 b=d5JJfPQoYjHouKRIK1VnsN6onxy8309OxUMSdTA1G3y8Cg7pydj7rNU0vhQzHk+TSx
 Rfk8/fV8AWos0BU+/j0eiJDhS9HMKnelIuZ9wK41XYmYLH0oYzO8y64uR/SUbCcu+KQ3
 iQLuVSgtVBzr45IuZyx65F/LUE3HUT2f8BCx6yOn+iSoAdrgAUcUi3S0V+VXcgzktunZ
 UVD2GAfCN1ok7ULJAivpJPLJVQKoanRIMnSaKbu0NvS65UXyJlK7+vXvUT7ZcntHAhXi
 hyFQ5KeEX0nsfJwmAn/7EIMTrvdm+LU9H2iPTUdux3NHDED1rFGrcE7AixgomhY17qEa
 Sf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767774606; x=1768379406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RqWPNul5hnbcIZ6LSpMbQYu7eMRnWXA+MM+Sjnx6BtE=;
 b=dCRGCjPKgkJkKjStz/hIGsTI4YmK7qwij+dT8yjeNteFeJYYUJr8lWNpO/gUSc4hc3
 Ir4fpYeqnjWdZ0zjzau7FI2395I4VUmMn4qHB192W4U0hmcX2rI0ab8IAUAYHw6jpiY4
 1CQ2VMiqpjUPkN3lO9fXN6rB4D+iLT2uBHND2GNfAy6+ORdyJDzUANPdbCAr+08ryuev
 cXpBMoIDbb16GWfJwNToSeGSSykP0i1zbt3dB/OJ0YRdtlZuJ6EYC4YQgxIOcflUXUZ9
 m2E39RVNYciGOJj7kLID5mUh0yT8+dAIENJSWUjJg1Hh3BcroMNliwrTORPZTIqfVqFd
 ptBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw6Zq0z9obwoFGuHOBl4rilbPSGpldbK8OibhxhzRYzopUYOUAT/3rWTp8pKfZeNvmYAyGdzCjx4YI@nongnu.org
X-Gm-Message-State: AOJu0YzsSyYYP+wYcj8MHBxjGDHen3SHxbdZ6VdEmP5Y9b2islOLzymp
 VdOiA5j3bqKaLlSk/9jq84APEIJ3g4BpaIqvWf8J23HZgyslQQVgQrBPafLM+A9NfzddX/xE5t+
 a8aVB2lveLkX3hjHzLkto6O71s5uaYNY=
X-Gm-Gg: AY/fxX4DOTz0Ia1Pe7NLxzXotCDcM7qorYiq7bw0tikWR9k9sbGYyshkgVfATQdX5t1
 nWSPJY13h8eGeQCTEfem/mY9UkdrxLl2tP9Uw9tk4FtwBRDFWiL5G6ZEuJe7l5aJMYUG94eOiOc
 nMq6ofPSGr1krit6B7jQ6sKhArisbOfv2JjMEqCfEK4aDEB1jHzIjqYXBmV3x32tCmfE7vgzJy5
 MZV/Nub7zWhtPeEUHW001blzValRDiaCzK7H287bbvvNcZp7dyJakv2R+dW36xxOxd//ZHi5ORl
 mAevq5I=
X-Google-Smtp-Source: AGHT+IGo4GID7wrju5wCF+dKTXS0ffNCmCFh68Riq+9HUPYZH36MGE8J/QEIinUDwLW2MG3xmRG5Co5l5uoUl513dss=
X-Received: by 2002:a17:907:d09:b0:b72:ddfd:bca7 with SMTP id
 a640c23a62f3a-b84453385d8mr171140566b.35.1767774605982; Wed, 07 Jan 2026
 00:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
 <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
 <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
In-Reply-To: <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 7 Jan 2026 16:29:28 +0800
X-Gm-Features: AQt7F2rIKG_0egWBEiizv-TZqoCyZnMx8XQol1KMOo94fjsrYnSGRTuUqCe1Lf8
Message-ID: <CAK3tnvLhpG2KkAbP0vKse=p35NjwDecfcBPqW2qJ-cuSje=QPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
To: Jason Wang <jasowang@redhat.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52b.google.com
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

On Tue, Jan 6, 2026 at 4:10=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Jan 5, 2026 at 9:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> w=
rote:
> >
> > On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > Currently, filter-redirector does not implement the status_changed
> > > callback, which means the 'status' property cannot be used to
> > > dynamically enable/disable the filter at runtime. When status is
> > > set to 'off' via QMP/HMP, the filter still receives data from the
> > > indev chardev because the chardev handlers remain registered.
> > >
> > > This patch adds proper support for the 'status' property:
> > >
> > > 1. Implement filter_redirector_status_changed() callback:
> > >    - When status changes to 'off': remove chardev read handlers
> > >    - When status changes to 'on': re-register chardev handlers
> > >      (only if chardev is already open)
> > >
> > > 2. Update filter_redirector_setup() to respect initial status:
> > >    - If filter is created with status=3Doff, do not register handlers
> > >    - This allows creating disabled filters via command line or QMP
> > >
> > > 3. Handle chardev OPENED/CLOSED events to re-arm handlers on reconnec=
t:
> > >    - Keep the chr_event callback installed on CLOSE so a later OPENED
> > >      can re-register the read handlers when nf->on
> > >    - Use qemu_chr_fe_set_handlers_full(..., set_open=3Dfalse, sync_st=
ate=3Dfalse)
> > >      instead of qemu_chr_fe_set_handlers() because the latter forces
> > >      sync_state=3Dtrue and may emit CHR_EVENT_OPENED for an already-o=
pen
> > >      backend. Doing that from inside the chr_event callback would cau=
se
> > >      recursive/re-entrant OPENED handling.
> > >
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > >  net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 33 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > > index 8e01e98f40..aa2ab452fd 100644
> > > --- a/net/filter-mirror.c
> > > +++ b/net/filter-mirror.c
> > > @@ -179,9 +179,16 @@ static void redirector_chr_event(void *opaque, Q=
EMUChrEvent event)
> > >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > >
> > >      switch (event) {
> > > +    case CHR_EVENT_OPENED:
> > > +        if (nf->on) {
> > > +            qemu_chr_fe_set_handlers_full(&s->chr_in, redirector_chr=
_can_read,
> > > +                                          redirector_chr_read, redir=
ector_chr_event,
> > > +                                          NULL, nf, NULL, false, fal=
se);
> > > +        }
> > > +        break;
> > >      case CHR_EVENT_CLOSED:
> > > -        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > > -                                 NULL, NULL, NULL, true);
> > > +        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, redire=
ctor_chr_event,
> > > +                                      NULL, nf, NULL, false, false);
> > >          break;
> > >      default:
> > >          break;
> > > @@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFilterSta=
te *nf, Error **errp)
> > >              return;
> > >          }
> > >
> > > -        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read=
,
> > > -                                 redirector_chr_read, redirector_chr=
_event,
> > > -                                 NULL, nf, NULL, true);
> > > +        if (nf->on) {
> > > +            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_=
read,
> > > +                                     redirector_chr_read, redirector=
_chr_event,
> > > +                                     NULL, nf, NULL, true);
> > > +        }
> > >      }
> > >
> > >      if (s->outdev) {
> > > @@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFilterSta=
te *nf, Error **errp)
> > >      }
> > >  }
> > >
> > > +static void filter_redirector_status_changed(NetFilterState *nf, Err=
or **errp)
> > > +{
> > > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > +
> > > +    if (!s->indev) {
> >
> > It's better to add a error here, for example:
> >
> >         error_setg(errp,  "filter_redirector_status_changed failed for
> > the s->indev cleared" );
>
> Will do.
>
> >
> >
> > > +        return;
> > > +    }
> > > +
> > > +    if (nf->on) {
> > > +        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read=
,
> > > +                                 redirector_chr_read, redirector_chr=
_event,
> > > +                                 NULL, nf, NULL, true);
> > > +    } else {
> > > +        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > > +                                 NULL, NULL, NULL, true);
> >
> > It seems like we need to keep the "redirector_chr_event" here?
>
> Since the filter is disabled I think we probably don't care about the
> event in that case.

OK.

>
> >
> > And another thing, this series focus on indev, should we need to do
> > the same thing for outdev?
>
> We don't poll outdev, if we get something to send to outdev it's the
> bug of other filters or networking core.

OK.

Thanks
Chen

>
> Thanks
>
> >
> > Thanks
> > Chen
> >
> > > +    }
> > > +}
> > > +
> > >  static char *filter_redirector_get_indev(Object *obj, Error **errp)
> > >  {
> > >      MirrorState *s =3D FILTER_REDIRECTOR(obj);
> > > @@ -440,6 +467,7 @@ static void filter_redirector_class_init(ObjectCl=
ass *oc, const void *data)
> > >      nfc->setup =3D filter_redirector_setup;
> > >      nfc->cleanup =3D filter_redirector_cleanup;
> > >      nfc->receive_iov =3D filter_redirector_receive_iov;
> > > +    nfc->status_changed =3D filter_redirector_status_changed;
> > >  }
> > >
> > >  static void filter_mirror_init(Object *obj)
> > > --
> > > 2.34.1
> > >
> >
>

