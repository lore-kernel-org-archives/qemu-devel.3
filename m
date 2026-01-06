Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA68C47BC4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 08:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd28y-0004Di-Ug; Tue, 06 Jan 2026 03:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vd28w-0004Cx-FX
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:10:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vd28s-0006Wr-8Y
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 03:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767687012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1d0S01Bw+TCFtUi0x+6kvxjtE+PNICoZPb8pBUd8zb0=;
 b=UtJ8FUfMuiBJyOO2JwKp0M1IRlkGPcopdOJW+welkAxO7JFmlHKy0GcAQVlq3ioNwALHbb
 3Qigo8PwZvolDxS0wlyPFPmon0FclqI2tY+9AevW2A68ZQJX5NXJW+9KJ8thysCCgYRhz+
 0EsDMOmq5dq9rmtdGsLx63nyffDXXeo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-XxTjtuyjM9SAKSF-Pkh_Dg-1; Tue, 06 Jan 2026 03:10:10 -0500
X-MC-Unique: XxTjtuyjM9SAKSF-Pkh_Dg-1
X-Mimecast-MFC-AGG-ID: XxTjtuyjM9SAKSF-Pkh_Dg_1767687009
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-34c38781efcso1562338a91.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 00:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767687009; x=1768291809; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1d0S01Bw+TCFtUi0x+6kvxjtE+PNICoZPb8pBUd8zb0=;
 b=WCqk9lwmrwmtXkXwRHfvq1T5vO9oOPnKIkxA5OcSfzgQTuyvy2g0OFsWf1T8GROuil
 YpwgsALmiCeeSlpY0HAr0erfotRvb9IwT9cq8xSHRjtFQZaVNaeBzyuW49iujH7epxPI
 LxXS6mogl81a5KKjRhwjZF13+pNJIWg2893xITfjnBGWJOCbKlWkYxIXCdoh++iYpCtV
 6bnpzSBctHE6Cwi28Y2NPf+yJM8B5PdgNVmmVdNCDzGWCENC1yefq7FCboCHbSydODzm
 tRC2EgIfqoRTXSHmhw0bcR1lWEaIRAI8RA8pigZhMoIQ/LlqOyz5/rbBxOpOuL/xvjwO
 QqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767687009; x=1768291809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1d0S01Bw+TCFtUi0x+6kvxjtE+PNICoZPb8pBUd8zb0=;
 b=fOJA2hAfxn8YLa8WFLOF67ejda1iWTU2UJ8u4m9YyKpfRQ+Q3xg9JU5qVEJM4JPljK
 SzxAMUugWT6OsoGykAmMmD46Vzk2JRCupTliLwJzMBDdONujmT9MwKPVJaRJZ7PKv/MJ
 8uE03TvvSF4iRlZLpFFGC0AsMZXoSSwmkCgke3Yml3suoV8mACWq9H8Z/WZHUvZ9MjAQ
 6NNCPerNCj1wCy32sspOV6pu3K+vIA8+JHrD156zAYas2SnElfvZtCpWpCy6Rb3gCEVP
 jBuWuMiuQLMERFOvFqzyARmsgWAJUGza/7rCIWAy427vmfqW7rNdWlOoiMcQTmjZHNKM
 y9LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLqgbBWFHQCDCxDxVqBlKFkYGo+blA/gZVmzYtfbwLCSWztgOQZuxrbw+ZMCa17BORKfUD9nQw5/5o@nongnu.org
X-Gm-Message-State: AOJu0Yz+xJGmjH/6HIVljTAH7WNMO7gIDeqXKsMAzD6A6YqOoFf4ujHy
 cItNAkbzRYlXYWbpVwLnxa3vx06vjyJ99ffm5YJDbp40X9Ym54p9qmX0i0Z6RbqNR6quwFhmmHG
 4ABY4zFyeq2Zd2fn7KV0r2Z8FK6nyLYyA7sAS44I+qgm9RxY60BlYFxHhTxgxeYdmU0VLbm7r/4
 6TY1iajpNtOunS++uID3jx/L8whO0JEf5cM652SUE=
X-Gm-Gg: AY/fxX73idpIjeJxzc5zR8bLsAsjBbnssVTQrDZHzaQ4zBber//ZrjLB81c9pzx6Kj6
 gAw0pQ8tiNZsKvKLmZLxF/Cc2Qa0V/ah0KFJbp6q8LiVAPg4UmzNUSgtNryuNDRcFwX4Kz7Q+U/
 ULd1rmtSNK0dLCqvbAedVPpnEpYGly0wNceLP3W+D8wL5bcALJINX2ZLCFFh0RqUo=
X-Received: by 2002:a17:90a:b313:b0:349:3fe8:170d with SMTP id
 98e67ed59e1d1-34f5f27b7e7mr1191035a91.3.1767687008962; 
 Tue, 06 Jan 2026 00:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJLq0V92urfgAF35cccPzucH61/7MNJKaWpmkb0Baa7SkMkRS/7NXgkGqQhlEKrmZjHkno8VllTEwJA4nhg+0=
X-Received: by 2002:a17:90a:b313:b0:349:3fe8:170d with SMTP id
 98e67ed59e1d1-34f5f27b7e7mr1191024a91.3.1767687008519; Tue, 06 Jan 2026
 00:10:08 -0800 (PST)
MIME-Version: 1.0
References: <20260104075412.1262-1-jasowang@redhat.com>
 <20260104075412.1262-2-jasowang@redhat.com>
 <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
In-Reply-To: <CAK3tnv+97kgSAt-do3BwhzFewy+A3rcMrJj8K5r7hvSJag_tgA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 6 Jan 2026 16:09:56 +0800
X-Gm-Features: AQt7F2rkJWL_ffdTWNcpPCbfOJYyMx-FDVi_AeEqx-JUUiISwnbjMd6qN-6C3B4
Message-ID: <CACGkMEsA4hoTWqetffmfJEZ7Jq5=6gQ1ik+UznXgSGiyhE_Hqw@mail.gmail.com>
Subject: Re: [PATCH 1/3] net/filter-redirector: add support for dynamic status
 on/off switching
To: Zhang Chen <zhangckid@gmail.com>
Cc: lizhijian@fujitsu.com, qemu-devel@nongnu.org, lulu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 5, 2026 at 9:19=E2=80=AFPM Zhang Chen <zhangckid@gmail.com> wro=
te:
>
> On Sun, Jan 4, 2026 at 3:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > Currently, filter-redirector does not implement the status_changed
> > callback, which means the 'status' property cannot be used to
> > dynamically enable/disable the filter at runtime. When status is
> > set to 'off' via QMP/HMP, the filter still receives data from the
> > indev chardev because the chardev handlers remain registered.
> >
> > This patch adds proper support for the 'status' property:
> >
> > 1. Implement filter_redirector_status_changed() callback:
> >    - When status changes to 'off': remove chardev read handlers
> >    - When status changes to 'on': re-register chardev handlers
> >      (only if chardev is already open)
> >
> > 2. Update filter_redirector_setup() to respect initial status:
> >    - If filter is created with status=3Doff, do not register handlers
> >    - This allows creating disabled filters via command line or QMP
> >
> > 3. Handle chardev OPENED/CLOSED events to re-arm handlers on reconnect:
> >    - Keep the chr_event callback installed on CLOSE so a later OPENED
> >      can re-register the read handlers when nf->on
> >    - Use qemu_chr_fe_set_handlers_full(..., set_open=3Dfalse, sync_stat=
e=3Dfalse)
> >      instead of qemu_chr_fe_set_handlers() because the latter forces
> >      sync_state=3Dtrue and may emit CHR_EVENT_OPENED for an already-ope=
n
> >      backend. Doing that from inside the chr_event callback would cause
> >      recursive/re-entrant OPENED handling.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  net/filter-mirror.c | 38 +++++++++++++++++++++++++++++++++-----
> >  1 file changed, 33 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/filter-mirror.c b/net/filter-mirror.c
> > index 8e01e98f40..aa2ab452fd 100644
> > --- a/net/filter-mirror.c
> > +++ b/net/filter-mirror.c
> > @@ -179,9 +179,16 @@ static void redirector_chr_event(void *opaque, QEM=
UChrEvent event)
> >      MirrorState *s =3D FILTER_REDIRECTOR(nf);
> >
> >      switch (event) {
> > +    case CHR_EVENT_OPENED:
> > +        if (nf->on) {
> > +            qemu_chr_fe_set_handlers_full(&s->chr_in, redirector_chr_c=
an_read,
> > +                                          redirector_chr_read, redirec=
tor_chr_event,
> > +                                          NULL, nf, NULL, false, false=
);
> > +        }
> > +        break;
> >      case CHR_EVENT_CLOSED:
> > -        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > -                                 NULL, NULL, NULL, true);
> > +        qemu_chr_fe_set_handlers_full(&s->chr_in, NULL, NULL, redirect=
or_chr_event,
> > +                                      NULL, nf, NULL, false, false);
> >          break;
> >      default:
> >          break;
> > @@ -306,9 +313,11 @@ static void filter_redirector_setup(NetFilterState=
 *nf, Error **errp)
> >              return;
> >          }
> >
> > -        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
> > -                                 redirector_chr_read, redirector_chr_e=
vent,
> > -                                 NULL, nf, NULL, true);
> > +        if (nf->on) {
> > +            qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_re=
ad,
> > +                                     redirector_chr_read, redirector_c=
hr_event,
> > +                                     NULL, nf, NULL, true);
> > +        }
> >      }
> >
> >      if (s->outdev) {
> > @@ -324,6 +333,24 @@ static void filter_redirector_setup(NetFilterState=
 *nf, Error **errp)
> >      }
> >  }
> >
> > +static void filter_redirector_status_changed(NetFilterState *nf, Error=
 **errp)
> > +{
> > +    MirrorState *s =3D FILTER_REDIRECTOR(nf);
> > +
> > +    if (!s->indev) {
>
> It's better to add a error here, for example:
>
>         error_setg(errp,  "filter_redirector_status_changed failed for
> the s->indev cleared" );

Will do.

>
>
> > +        return;
> > +    }
> > +
> > +    if (nf->on) {
> > +        qemu_chr_fe_set_handlers(&s->chr_in, redirector_chr_can_read,
> > +                                 redirector_chr_read, redirector_chr_e=
vent,
> > +                                 NULL, nf, NULL, true);
> > +    } else {
> > +        qemu_chr_fe_set_handlers(&s->chr_in, NULL, NULL, NULL,
> > +                                 NULL, NULL, NULL, true);
>
> It seems like we need to keep the "redirector_chr_event" here?

Since the filter is disabled I think we probably don't care about the
event in that case.

>
> And another thing, this series focus on indev, should we need to do
> the same thing for outdev?

We don't poll outdev, if we get something to send to outdev it's the
bug of other filters or networking core.

Thanks

>
> Thanks
> Chen
>
> > +    }
> > +}
> > +
> >  static char *filter_redirector_get_indev(Object *obj, Error **errp)
> >  {
> >      MirrorState *s =3D FILTER_REDIRECTOR(obj);
> > @@ -440,6 +467,7 @@ static void filter_redirector_class_init(ObjectClas=
s *oc, const void *data)
> >      nfc->setup =3D filter_redirector_setup;
> >      nfc->cleanup =3D filter_redirector_cleanup;
> >      nfc->receive_iov =3D filter_redirector_receive_iov;
> > +    nfc->status_changed =3D filter_redirector_status_changed;
> >  }
> >
> >  static void filter_mirror_init(Object *obj)
> > --
> > 2.34.1
> >
>


