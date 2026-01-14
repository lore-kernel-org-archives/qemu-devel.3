Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867A4D31A1E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 07:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfvPT-0001Dq-H7; Wed, 14 Jan 2026 02:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vfvPK-00019u-A8
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 02:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vfvPI-0005Bz-Hv
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 02:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768376106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHPos+b1KE99O/PXOYCleDCciLn6UXVGtUxOg7Zc4Z0=;
 b=SL5O0YjC4ATYF7jPWh5aZ057rXnzQ+erOX9VFESSZnqUefX+SNKUwy6b1zbXXjEfDmARWK
 PQxiQaxG0hlKqP3rxH51iIY/O+AxEwa0dTFg/45CbBz+ueefJcbKlbpN3/lmscjg3bK46N
 paSFX4uq1sei4hSemWufGiznh5ke6Ks=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-yzJ4H3aHPtCIWqFFhwmJ3A-1; Wed, 14 Jan 2026 02:35:04 -0500
X-MC-Unique: yzJ4H3aHPtCIWqFFhwmJ3A-1
X-Mimecast-MFC-AGG-ID: yzJ4H3aHPtCIWqFFhwmJ3A_1768376103
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c387d3eb6so6055367a91.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 23:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768376103; x=1768980903; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHPos+b1KE99O/PXOYCleDCciLn6UXVGtUxOg7Zc4Z0=;
 b=s5JXeIPsLMyqCOv1tTrbgI4akTyAOZWKtK9/65rGi/3Jw861b6YzmHJI7fOOsN6vHs
 RXR6EMgdtK9hCRKvU9L+ueJ06N/s4izIiKAJjL+OCnpdIj3N4bP6rVbXx5uWULVr4uKY
 EpicXF08IT8xHYP9Ef//j9eJsqpkQ4PGmqE3vYp0UmqghQBUNv5m2b7jGDE20KZ6tJgu
 njTon8/2vYxbzZkRAN0fqvYrajjN27UtSVBONqa1FaRsqSKrTjh4SqvXswRwufQM1eof
 3EZ6LgaKQvd6gicR4iAVVWleLsnKJ44N5+YoJUFaSqSpLfDCIunJPzwV+te4NqX2n2pm
 6mfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768376103; x=1768980903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHPos+b1KE99O/PXOYCleDCciLn6UXVGtUxOg7Zc4Z0=;
 b=Kj32pMFV3aXXJ3soymdkEealrySv7J/nweQUl+c8JOYOZrw6jvzxavG/GRzQFWBert
 3AUYrCm4AFiauj1t0v2XzF6VITybcUXY8AzTw/THlQ5fqCI4r6hwabS2lpcEAY8C8UpC
 b49nov8RCGDFrkZK32ZeXr/JEfhFURjCMTcrqnP+4+mj69uv0/K8up5it2tM0KYkrJd2
 0rhH1mntq++B7LiOA6Yz6Oj1DU4p/ebkZKoTAehJRcX7rN+hjzV6sp6rpifQIvZXA9h8
 hgGSNWyATOJKH2ND/d0RNphOjHbrCe1p+alwINF+WsQAr7NfxPgTdDtubSxH0UH2yLwE
 giKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh4Yp2Hvh8IGlG2C2nvP+4YbRJodKYo89j9SGa7t6tSI4V8qIGYnS6MW5t7KcrAZqPzbB+y2IdTJ87@nongnu.org
X-Gm-Message-State: AOJu0Yy6jGTPMH12TlUpFdCjcgyfzYMJXdCRn45qOkiEE7h71s9LPqjz
 dxOWLGRnIsoGZam40s+SGBDtRnQnwv1fa/azsDxzaOSe98xBDYe2UDtuvL+ljvDIQE8Sr/UtgJH
 xHoUVOmjmRtSDu03Rl/aP+2FicYA9hR+AzWRsD5WVGCBuZIef5E75cKxnaZYF5SWoofgKXEPKyr
 8KC3gYqHcd7uDWk4pnplGoWv6KbfayyLc=
X-Gm-Gg: AY/fxX4FBB+WHQ903v7IBmYXf682S0XpgqZnijD5Oj9hPUaSI2+jMsKw2wjfEF7DiOx
 mKavkXyQpGSQMu+9JCrXGytcH/ns6fw7OZSq26lyUGw/4Ad0x62Uv9UP6Hn7ctJZmDIBbKOhxa2
 EgSO70jNKHeCsFYnkRldexCNByah552iUWNqY7KYcVGmiv8ZDo/zmLU3rdaGtW0RQ=
X-Received: by 2002:a17:90b:4c49:b0:33e:30e8:81cb with SMTP id
 98e67ed59e1d1-351090b102bmr1483066a91.13.1768376103038; 
 Tue, 13 Jan 2026 23:35:03 -0800 (PST)
X-Received: by 2002:a17:90b:4c49:b0:33e:30e8:81cb with SMTP id
 98e67ed59e1d1-351090b102bmr1483053a91.13.1768376102575; Tue, 13 Jan 2026
 23:35:02 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
 <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
 <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
 <CACGkMEs08wX5yBWcs05wiUmReb7boxTNy4+Br0dDUi=npfo1Cg@mail.gmail.com>
 <CAK3tnv+j_7s5JhPb32C9FK565B6M2V9gRsGkg6x_J0YesEmgFQ@mail.gmail.com>
In-Reply-To: <CAK3tnv+j_7s5JhPb32C9FK565B6M2V9gRsGkg6x_J0YesEmgFQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Jan 2026 15:34:51 +0800
X-Gm-Features: AZwV_Qhyiui93x7Qs3sGzZIZdWarTnlBGyuJdRiTzJvYcz5-3CK-y5gTbR32I2Y
Message-ID: <CACGkMEvuMW-KSOrFi-28pSQP8WNzmgk4Dnnd4KLhd7_DYih35Q@mail.gmail.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 13, 2026 at 5:22=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wr=
ote:
>
> On Tue, Jan 13, 2026 at 2:43=E2=80=AFPM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Tue, Jan 6, 2026 at 4:09=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Mon, Jan 5, 2026 at 9:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.co=
m> wrote:
> > > >
> > > > On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > Currently, filter-redirector does not implement the status_change=
d
> > > > > callback, which means the 'status' property cannot be used to
> > > > > dynamically enable/disable the filter at runtime. When status is
> > > > > set to 'off' via QMP/HMP, the filter still receives data from the
> > > > > indev chardev because the chardev handlers remain registered.
> > > > >
> > > > > This patch adds proper support for the 'status' property:
> > > > >
> > > > > 1. Implement filter_redirector_status_changed() callback:
> > > > >    - When status changes to 'off': remove chardev read handlers
> > > > >    - When status changes to 'on': re-register chardev handlers
> > > > >      (only if chardev is already open)
> > > > >
> > > > > 2. Update filter_redirector_setup() to respect initial status:
> > > > >    - If filter is created with status=3Doff, do not register hand=
lers
> > > > >    - This allows creating disabled filters via command line or QM=
P
> > > > >
> > > > > 3. Handle chardev OPENED/CLOSED events to re-arm handlers on reco=
nnect:
> > > > >    - Keep the chr_event callback installed on CLOSE so a later OP=
ENED
> > > > >      can re-register the read handlers when nf->on
> > > > >    - Use qemu_chr_fe_set_handlers_full(..., set_open=3Dfalse, syn=
c_state=3Dfalse)
> > > > >      instead of qemu_chr_fe_set_handlers() because the latter for=
ces
> > > > >      sync_state=3Dtrue and may emit CHR_EVENT_OPENED for an alrea=
dy-open
> > > > >      backend. Doing that from inside the chr_event callback would=
 cause
> > > > >      recursive/re-entrant OPENED handling.
> > > > >
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > ---
> > > > >  net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++-----
> > > > >  1 file changed, 33 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > > > > index 8e01e98f40..aa2ab452fd 100644
> > > > > --- a/net/filter-mirror.c
> > > > > +++ b/net/filter-mirror.c
> > > > > @@ -179,9 +179,16 @@ static void redirector_chr_event(void *opaqu=
e, QEMUChrEvent event)
> > > > >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > > >
> > > > >      switch (event) {
> > > > > +    case CHR_EVENT_OPENED:
> > > > > +        if (nf->on) {
> > > > > +            qemu_chr_fe_set_handlers_full(&s->chr_in, redirector=
_chr_can_read,
> > > > > +                                          redirector_chr_read, r=
edirector_chr_event,
> > > > > +                                          NULL, nf, NULL, false,=
 false);
> > > > > +        }
> > > > > +        break;
> > > > >      case CHR_EVENT_CLOSED:
> > > > > -        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > > > > -                                 NULL, NULL, NULL, true);
> > > > > +        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, re=
director_chr_event,
> > > > > +                                      NULL, nf, NULL, false, fal=
se);
> > > > >          break;
> > > > >      default:
> > > > >          break;
> > > > > @@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFilte=
rState *nf, Error **errp)
> > > > >              return;
> > > > >          }
> > > > >
> > > > > -        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_=
read,
> > > > > -                                 redirector_chr_read, redirector=
_chr_event,
> > > > > -                                 NULL, nf, NULL, true);
> > > > > +        if (nf->on) {
> > > > > +            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_=
can_read,
> > > > > +                                     redirector_chr_read, redire=
ctor_chr_event,
> > > > > +                                     NULL, nf, NULL, true);
> > > > > +        }
> > > > >      }
> > > > >
> > > > >      if (s->outdev) {
> > > > > @@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFilte=
rState *nf, Error **errp)
> > > > >      }
> > > > >  }
> > > > >
> > > > > +static void filter_redirector_status_changed(NetFilterState *nf,=
 Error **errp)
> > > > > +{
> > > > > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > > > > +
> > > > > +    if (!s->indev) {
> > > >
> > > > It's better to add a error here, for example:
> > > >
> > > >         error_setg(errp,  "filter_redirector_status_changed failed =
for
> > > > the s->indev cleared" );
> > >
> > > Will do.
> > >
> >
> > I think it's probably wrong to return an error here as we may only use
> > outdev but not indev, in this case status_changed doesn't need to do
> > anything.
>
> This confuses me. The filter_redirector_status_changed code focus on
> how to read the the indev, it looks not affect the outdev.
> If we just return without any error, the user is unsure whether the attem=
pt
> was successful.
>

Consider the case where there's only outdev, in this case we don't
need to do anything when status is changed:

1) we don't poll outdev
2) net core will bypass the redirector if the status is off.

I meant basically we don't need to do anything in this case and it's
not an error.

Thanks


