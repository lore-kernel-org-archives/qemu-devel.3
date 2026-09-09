Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B87C79FAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4DBh-00022e-EY; Wed, 09 Sep 2026 03:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4DBf-00022G-1b
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:57:43 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4DBd-0006lR-4L
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 03:57:42 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a68279dd86so6935862a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 00:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788940659; cv=none;
 d=google.com; s=arc-20260327;
 b=W8RVig51bStVbdRHvD4PVh0ZDoNVIRsA/JP5ITHRLzNwDYnmNIxKVk9Yd80jJi5OrG
 +yRGMLvjtSzFzjSDO2wq6yU0Gi/uqAW7hpqZ7oBJfl+eRx/kLXqoVgQ4aOpBqOxD5PXC
 l6Q634aS/EhdpHomshVDJ/RiWsZyuz5BFPjCL0PYfeAf68gk5X/debhdTx2nuh0ApEeX
 SdEgDVwdzaw3Pjz2AM9b97htdb1vtqLkbgEQtqMgiw+lwbkkhLPicjt1pSAfPEfAK+BI
 zbRWv9lI5B4+3OiiB6WVJwebQhNNZ38d9d/K9iRhPvokZFISBEXmw6FS/43fiNuu927D
 rWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mghUWIUVlF0b/VA50/2jiXeAvIKpW4vtJh2ANQDhBVw=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=jMLIZQmWhwDeCqslvrjWHqVcezVuOf5h4cjylvweUFJMu9sPUVB/oD+3wKMqln4biH
 KTb17S0sdm/sT53Nd+cTg2+HvuXj91A2epR2SFlm0ezX7Ih3mP4ZFhXhNqFl2yQdycBM
 jdUjijY+B/L2w90M4UDotIsMhkDcoAa7JCTZpgYYz2jT8R00AWuW/9i+laEHgcGeVUj1
 9dqYEwaUjTDO45WT87cB+A1AyTLatCMNdgdVkiMR/6XhMIyuE2J+fUcPPDMIH22otWmZ
 2v5BzgThWPd6paoXdvQDaF08o0AQos5qZPWSqjMMhi8nq01BA/i5vEGwLRV4KkkC4Kyd
 AwrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788940659; x=1789545459; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mghUWIUVlF0b/VA50/2jiXeAvIKpW4vtJh2ANQDhBVw=;
 b=tCisX03WUNCVgTjBE4RYoJYyFFdkm/cpvGGY1zqvtJ/+p59drfPyF4DSVEyIYpHfo9
 xk9vBCBizOG6SQv7Mb87jOBup+gMR+VEWbfWioFgRB0jiY/sN3+JB+wuE1I17YdGu5Wz
 ouyJs2BvhQn7FVj4mH8h+wuTnEDHF9C46vjEQHuDqWXqR2dysYz+5A+Ger5w8yxR40Db
 MOz1JSma+7y9MGSdunHGzttVwGmmnTENtuqkgmXXIFgV7jEZNjq0JBVSUWTTfEU8ACeu
 0CJdMWvrga0E3RnFgGfp4vm3AMex4s04VIrNbsboOLK/p0Rb+2ZOebcshl4YdaUtXtiJ
 cwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940659; x=1789545459;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mghUWIUVlF0b/VA50/2jiXeAvIKpW4vtJh2ANQDhBVw=;
 b=CYB5Xp38hoKzBD1i1HcxT2Y9/3U2HylnRHKEmVPpDZGXGfIry5HclJ2Zi1Q6GIT4uy
 bMR5TD3k2p/NEmxjdvDjDpwc9XRR7e5yImcXRPkUWqdUxXU2tMhio5Uh3DvX+dXcQp5L
 vatZIi7SbFIjVd1iX25ZvKDweeJ7PI37kTFIEhb+RKIxFjjBw0f51Ca1a05Fdmk9XFhH
 CTtF1Rhz4zUG2z+dF32OC/cFamDQB1D44sXd8z3ydfaRfnPQbAsLSH/awYSj5W+bPK7O
 mkQpi0eGR9Cy75wabILesVIh6srUaHrxDhtGDQGf8BXc93xQhUKTimDwNJI4xPbqgOKD
 Ab2A==
X-Gm-Message-State: AFuF++nojMGstzFMA9vksaoVbndTLB/tiBSJQKAvF326d3jU/ovFCIeI
 q9jtUzyvwgehNeb64JKZ1qD7tLJpcE6cFWaCDQB5dyhPmEXPwVlFiGMc1rtN8VbAmMr8n/ZngDP
 ZQQ/oBgyPiN1Dthu/Qbie0x4Qu6nIOvY=
X-Gm-Gg: AYBFou1u57qgx5nNm9KByAzpsN4F3Il8DWTTEvQb3oBYtQnE5CBnN/4yyg0JZ9K6mno
 Epv6nhN6Dr1JbgnEwd+GkUCYGtIooG/43RC+qKnM6YzA33azBcliDRoNlIXKjcqUlUVN7TY2+aU
 pPyK3DMW7NKs01yH7/aJKcdwHXf4+wtrMTiAT61gUU5YN84vVNrkU/QE4qitavAI3n0ZDq6G8Bb
 /UqIA5/SFneIMu2YpzUhIIjidPq86lvFiL0RkTC1az0c9JbCBZ5SElKG0BhSV/KwqgvkEY6vN+y
 rELpB+NiDeHcwuKq6yqtdM2vkZa9ytGNce9oxqNlZd8i2Jemp1Sgm4AeoQ==
X-Received: by 2002:a05:6402:4608:b0:6a8:37b6:3a6e with SMTP id
 4fb4d7f45d1cf-6a837b63cdemr3083439a12.43.1788940659116; Wed, 09 Sep 2026
 00:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-6-zhangckid@gmail.com>
 <874ig1xmbi.fsf@pond.sub.org>
In-Reply-To: <874ig1xmbi.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 9 Sep 2026 15:57:02 +0800
X-Gm-Features: AcwNN1XfsYchoX5J_gbu-tRPyk4eM_sv83ElIWvC-8A0XZltpYvANhmY71tZbME
Message-ID: <CAK3tnvKfeJK-p8POfzDoG2NLt=NWgKnF_WcmAWAHWXnuQdCWTw@mail.gmail.com>
Subject: Re: [PATCH V15 05/14] monitor: track IOThread users with QOM paths
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52d.google.com
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

On Mon, Sep 7, 2026 at 8:44=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Monitors that require an IOThread share the internal mon_iothread.
> > Account for each monitor explicitly in IOThread holder tracking, using
> > the monitor's canonical QOM path to distinguish holders.
> >
> > Acquire the shared monitor IOThread AioContext once and store the
> > IOThread and canonical QOM path so the holder can be released after the
> > monitor has been removed from the QOM tree. Reuse the stored context fo=
r
> > later operations.
> >
> > Release the holder from monitor_finalize(), after resources associated
> > with the AioContext have been destroyed. This pairs the reference taken
> > in complete() with instance finalization and keeps the IOThread alive
> > throughout monitor teardown.
> >
> > The internal mon_iothread remains hidden from query-iothreads, as befor=
e.
> > Management applications therefore cannot use it to determine which
> > monitors are using the IOThread. Nevertheless, track the monitor
> > holders so that they follow the same explicit holder and
> > IOThread reference lifecycle as other AioContext users.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  monitor/monitor-internal.h |  5 +++++
> >  monitor/monitor.c          | 26 +++++++++++++++++++++-----
> >  monitor/qmp.c              |  5 +++--
> >  3 files changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 822a66d06d..1d5aeae5e6 100644
> > --- a/monitor/monitor-internal.h
> > +++ b/monitor/monitor-internal.h
> > @@ -77,6 +77,11 @@ struct Monitor {
> >      GString *outbuf;
> >      guint out_watch;
> >      int mux_out;
> > +
> > +    /* iothread context and holder identity */
> > +    IOThread *iothread;
> > +    char *iothread_qom_path;
> > +    AioContext *ctx;
> >  };
> >
> >  struct MonitorQMPClass {
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 2654b81890..cc7f6785b5 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
> >      qemu_chr_fe_deinit(&mon->chr, false);
> >      g_string_free(mon->outbuf, true);
> >      qemu_mutex_destroy(&mon->mon_lock);
> > +
> > +    if (mon->iothread) {
>
> As we'll see in monitor_complete() below, mon->iothread is mon_iothread
> if monitor_requires_iothread(mon), else null.  Which means
> mon->mon_iothread is non-null if and only if
> monitor_requires_iothread(mon).
>
> Here, you check whether mon->mon_iothread is non-null to find out
> whether @mon uses the monitor I/O thread, and you read the monitor I/O
> thread from mon->mon_iothread.
>
> Elsewhere in this file, we check monitor_requires_iothread(mon) and you
> read mon_iothread, e.g. in monitor_cancel_out_watch()
>
>            if (monitor_requires_iothread(mon)) {
>                ctx =3D iothread_get_g_main_context(mon_iothread);
>            }
>
> I don't like this inconsistency.  Two ways to avoid it:
>
> 1. Always use monitor_requires_iothread(mon) to check and mon_iothread
> to read.  Drop struct Monitor member iothread.
>
> 2. Always use mon_iothread, except where we initialize it in
> monitor_complete().

Just to clarify: by option 2, do you mean using mon->iothread
consistently for per-monitor checks and accesses, except in
monitor_complete(), where monitor_requires_iothread() determines
whether to initialize it?

Thanks
Chen

>
> > +        const IOThreadHolder io_holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +            .u.qom_object.qom_path =3D mon->iothread_qom_path,
> > +        };
> > +
> > +        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
> > +    }
> > +    g_free(mon->iothread_qom_path);
> >  }
> >
> >  static char *monitor_get_chardev_id(Object *obj, Error **errp)
> > @@ -521,7 +531,7 @@ void monitor_suspend(Monitor *mon)
> >           * Kick I/O thread to make sure this takes effect.  It'll be
> >           * evaluated again in prepare() of the watch object.
> >           */
> > -        aio_notify(iothread_get_aio_context(mon_iothread));
> > +        aio_notify(mon->ctx);
> >      }
> >
> >      trace_monitor_suspend(mon, 1);
> > @@ -661,7 +671,6 @@ char *monitor_compat_id(void)
> >  static void monitor_complete(UserCreatable *uc, Error **errp)
> >  {
> >      Monitor *mon =3D MONITOR(uc);
> > -    AioContext *ctx;
> >
> >      if (mon->chardev_id) {
> >          Chardev *chr =3D qemu_chr_find(mon->chardev_id);
> > @@ -680,11 +689,18 @@ static void monitor_complete(UserCreatable *uc, E=
rror **errp)
>        if (monitor_requires_iothread(mon)) {
>            if (!mon_iothread) {
> >              mon_iothread =3D iothread_create("mon_iothread", &error_ab=
ort);
>
> Create the single, shared monitor I/O thread on demand, and store it in
> mon_iothread.
>
> >          }
> >
> > -        ctx =3D iothread_get_aio_context(mon_iothread);
> > +        mon->iothread =3D mon_iothread;
>
> Set mon->iothread to the monitor I/O thread.
>
> > +        mon->iothread_qom_path =3D object_get_canonical_path(OBJECT(mo=
n));
> > +        const IOThreadHolder io_holder =3D {
> > +            .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +            .u.qom_object.qom_path =3D mon->iothread_qom_path,
> > +        };
> > +
> > +        mon->ctx =3D iothread_ref_and_get_aio_context(mon->iothread, &=
io_holder);
> >      } else {
> > -        ctx =3D qemu_get_aio_context();
> > +        mon->ctx =3D qemu_get_aio_context();
>
> Leave mon->iothread null.
>
> >      }
>
> mon->iothread is mon_iothread if monitor_requires_iothread(mon), else
> null.
>
> > -    mon->accept_input_bh =3D aio_bh_new(ctx, monitor_accept_input, mon=
);
> > +    mon->accept_input_bh =3D aio_bh_new(mon->ctx, monitor_accept_input=
, mon);
> >  }
> >
> >  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index aec0315775..de56345456 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -734,7 +734,8 @@ static void monitor_qmp_complete(UserCreatable *uc,=
 Error **errp)
> >           * thread.  Schedule a bottom half.
> >           */
> >          mon->setup_pending =3D true;
> > -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread)=
,
> > +
> > +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
> >                                  monitor_qmp_setup_handlers_bh, mon);
> >          /* The bottom half will add @mon to @mon_list */
> >      } else {
> > @@ -789,7 +790,7 @@ static bool monitor_qmp_prepare_delete(UserCreatabl=
e *uc, Error **errp)
> >
> >      /* Synchronize with in-flight iothread callbacks. */
> >      if (monitor_requires_iothread(mon)) {
> > -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> > +        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
> >                              monitor_qmp_iothread_quiesce, NULL);
> >      }
>

