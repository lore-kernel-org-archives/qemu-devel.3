Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70ECAD29DD5
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 06:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfY88-0003Ab-30; Tue, 13 Jan 2026 01:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vfY85-0003AB-UL
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 01:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vfY84-0001Fv-3j
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 01:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768286625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mXIR+7ZBjQoQCp+AfFXxfZVPGEw1orfXYXpCxKwBIzw=;
 b=L2Kh0q3N0J3A4/fcO7ryQPOWG4oh0Yz06C5Q+8T/zj9M6mhJQo7PDtgwImXupGDpKgU0/p
 ZSONf1m2Q8MFBzwK69JAsm/9roMSduRYCpNlt+5F4akTbtsueWDXsgVnmUBnNWfYM0Zu4a
 kD8ijhn0qjoZzTOU7Z7fX9KPSBCxZYU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-2QcIwBzBMyOc5grLEturyQ-1; Tue, 13 Jan 2026 01:43:43 -0500
X-MC-Unique: 2QcIwBzBMyOc5grLEturyQ-1
X-Mimecast-MFC-AGG-ID: 2QcIwBzBMyOc5grLEturyQ_1768286623
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b6097ca315bso3104191a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 22:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768286622; x=1768891422; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mXIR+7ZBjQoQCp+AfFXxfZVPGEw1orfXYXpCxKwBIzw=;
 b=pJ9gpI6eWutO8RPdUqF9JRDVmKE67WgUNkz0EsqHp4eblXeEsqOqUffR2t4UEX4/9p
 ilzx4qUSGuI9syf0Ua93THDbzzWRM7EDp8iFy4ZNQPG1LKCUH4bcXawUlfyiOtMHMsZJ
 fGy4fZkbGEQahwEkmJO8EbXjsOX4Gu79SyLmC/A3mHK0mb33QLl9Z3xsJuRQMUMHLRkU
 TfvRPg8pc3MKyVE6LiqG5K8Emruol5feoUVBI6DuaEwc+KeA7wVM7CxN4ljQsDjaf5BR
 NPqz2lBfCyWNCUioyBZLCEX3wy30NCsKbkEFMNy55rCvLmqcaAZGnBdhonBbHUaIlUtk
 17ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768286622; x=1768891422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mXIR+7ZBjQoQCp+AfFXxfZVPGEw1orfXYXpCxKwBIzw=;
 b=jhEDnNprssKPaUcm0auQ+0NI2MSh1uvqoJaV1dEzWTSfPDliXg1V54au8Rg9dIsrVC
 dN94WfpipUhae9CcWAGC/+n1pLFIH4KAfmc/wetVlqStNGGCEdjrNJ2dOWrYsfbVDLPz
 UPHtZHl7rpqVneiqLwv5qCaiRCwJdDIJXnuux1Efr8+4GylPqK4+Dcu5GXfWHo2zWpUU
 JLSB6lgcwQbj4P0oYDGZun+zldvFexU6Um7IQ91t/btkissq+jToMvv23q5GIu28gnK/
 gIROngMZ9LE1b7bVEUpXmkTi0R9q93CLkWo5WXFU3yl4yzjZZhiF7sAT6heK7oIgZd7d
 H7Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdlCt31zqrWOC4YAHJaXFQKB7c3Xxs3zWR7W1KTMYnWCUAW+aY/c7jd3i7WqFpg8XQNic6HIvhY91h@nongnu.org
X-Gm-Message-State: AOJu0YxuE6xcWbipHBQ5cUO+6bWZR0M2jli30CYhMJSCf3YwrIOmPzDB
 SCRAGktki9pxmiL4VWqDhgFQg2lIMBLjuUxzfnKQjsy8mNevptZDFSSsruiHmiA0JI8BgjYjvD/
 9134vEsFWIcVK2ZNZlaBQ4vRW3xVRTDc85wwQ+UrwW4+cPFvMgZzrjwrQwHJgD79DEArPkG1YHx
 RT5VA+g5YlXzbhrv2H7I9GtOS0R+UPzU1Ttb1qcLE=
X-Gm-Gg: AY/fxX4jdqs/drEEeSjH9xjK17SBSNbycXXP8YfujTWQeqQyeio9NVWQ9ZhdsgOett5
 PEJBvZeFKAXXM05VHcc3335uitLkHqBoBma4FewkxKciCoh9bVRQUPQwNlVB0iN4bWzX3PugOwE
 FHS9p2ocV6MmudS62TWa1Xy+HT/GHwpunduWlgCSFtN2zV9e/wO2sF+C3pY+9ra+rGPAE=
X-Received: by 2002:a05:6a20:3947:b0:363:cb5a:61 with SMTP id
 adf61e73a8af0-3898f905157mr18371411637.27.1768286622177; 
 Mon, 12 Jan 2026 22:43:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGe+PPhVApBkolJ1V1s5VJKu9lkMq/weVNxzvkXvB/UPuSJqnvXAWKuCHrJqiXrFcZ6JUXNGdbZwiof8XUUgE=
X-Received: by 2002:a05:6a20:3947:b0:363:cb5a:61 with SMTP id
 adf61e73a8af0-3898f905157mr18371392637.27.1768286621751; Mon, 12 Jan 2026
 22:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
 <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
 <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
In-Reply-To: <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 13 Jan 2026 14:43:27 +0800
X-Gm-Features: AZwV_QhyhHtzBM-GPqioRnDWhgahpKd-c2U2oYZ-AIZWJx4UQe3sui9mELPo4Xs
Message-ID: <CACGkMEs08wX5yBWcs05wiUmReb7boxTNy4+Br0dDUi=npfo1Cg@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
To: Zhang Chen <zhangckid@gmail.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jan 6, 2026 at 4:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
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

I think it's probably wrong to return an error here as we may only use
outdev but not indev, in this case status_changed doesn't need to do
anything.

Thanks


