Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D112DC88E75
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 02:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6f9e-0006aq-Oc; Tue, 15 Sep 2026 22:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6f9d-0006ah-2z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:13:45 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6f9b-0001ns-0r
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 22:13:44 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9adea43b6so637879a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 19:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789524821; cv=none;
 d=google.com; s=arc-20260327;
 b=IT4mstNY4Bt2LgR2LzC01uyj+/b4ck5us0Rq70Q+yrpjz1KWXx8ycFpYyZJ5JLpv9a
 z16vcfdsBN85QE1wlmcxfFVCV6W+wSdtFmYYvTiqR8LZ7VxnZDsIY8Bs56VB0aGe6H6W
 tFHqx0yFJYomaE2kvCg2hGq/t8NehroRcjVv6fAPK7U0INGJjH2JNf6Gzi5E67JbXNcz
 NOVD5QphDEzacQwOuJ+URSLtEmYKiSlt1vx6E2uLD8aXfjOSLUKsqODAgUM5A/afJhth
 xlL2OvnrpOip/iAk30utePa2A/zrrQBsS61VekrvveNXgJuKHo8GfPFGEVet/uIBI4HN
 eEGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bk8o5qAvNzbPLzSsZQcqTUPcneGmGZ0HCtQKFUPOkSI=;
 fh=wGZeUYt39FdrjiyDvngBMA/6KW8toEkLMWKs7FzaIuY=;
 b=e1oZ1Oyd9W2CExLbYnehYHgiHplmclo8YKwMJqCFqgAaUt690dgpplyoRY7vQk3L0e
 qNM1QKfvIz1jiADl0ucvHWxPL8I262wuKqpGMjooPebP5dgJc+I5X/tuhVG0Pq++kd+l
 QhD2ijWdfVHfnUQ8zXY45DhW3ztMtuFYnHHXsFdLJf8vEg2Vo+5EwcJ6HIhS0QcHlP2J
 +3ohS+hBtmXTdILa5fHojIN23uWihSIvLtYmHM15DcTog7NsC2vM3eGPsqAx2rofNv0S
 Q5i2UCNA4bzuOdNmdUx+hhh77zU+wgAPme+CdddljQTd/aiAYdJ4yAhFo6Cg9lzYGag7
 RQ6A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789524821; x=1790129621; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bk8o5qAvNzbPLzSsZQcqTUPcneGmGZ0HCtQKFUPOkSI=;
 b=Ug5otv0hSgtInRfD9FMMuVHrRFlJ1TfdWd/csBg/4eUebUrSvpSDaH9GCFfyk8Pyby
 wTI5gVOolPXXxb7eRHMoww4U4j3+XtCtmoa6v4cz2XisWDmDNiyNjd3GeL0rspQlCruj
 M/DHIsEQiUn9RQY2qT8xPHBRrnhpT9jL7uNTVaGMhiLlPkzM3Ww7N5t3yXYT9FL0Sdsu
 pwNcwDKC7JhdLXfSxrdNYkSB1w+3oB8YAvDihEZUKDaa0keA1Fpaofti71jLTy5IE53U
 8odjcCzG7CszPZifNF/6JfitwO17F8uACI+5Mr0+aUlH3eysYg09TWBaf/mn2bQl/H2K
 U80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789524821; x=1790129621;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bk8o5qAvNzbPLzSsZQcqTUPcneGmGZ0HCtQKFUPOkSI=;
 b=nw3Ro5IytnXH3xDibKzFl1WOkKQVU34NjSFKAwF6Z5Oo59+Lu0h8BLKFVpQP4zK55P
 4u+91GvlmRNJYNEZpWYGt01QHM1t9JrgOjZluTuYZlj+LmhN5jL+t/i55uAJ0h2p342p
 3W2NdQZptJrhdCcY74/5x5oYILoK63sPyuYBTA8KvrCF6BD8QdbkL3VfdbuvjHqtsS0Z
 jTlvhMF4PX4KApSzyGec5RSILhZmElZXeEWbVWtKMrm7uTEjpp7vBHRV4eVgB8OrTnM1
 bduMiwoTgTvlmqj2o/h7MY28hRQqBKBhXQxOlr4D7cwsZqtpGFSBFqXFKZCLdyqF7S4U
 t+6w==
X-Gm-Message-State: AFuF++kedq08MXu5nuuQjNrUtXth1Co3jTxdVzhMUh0HJLZIvkv5Gf5g
 ogJuK0wdxlWfLbXajjiHQ+RjC/e/hRR1JVa47nrC0isuwTlBUpup5ldqdwcdweLk5KAdyCS4Ob9
 ZR8DvIuqIEOc3tsdt72CG5XPW6B1fadA=
X-Gm-Gg: AYBFou3V+l3Htt9EofMDJahZQUIzODhcwLmMBOQTzvWxECwqU6YIfPKNjs5UZEejOjG
 jhycE3f5QWkIih5G8wE9VIgRx+yXDT2LTwqooV1NQUDdLveW4npa0QW24AITNNwC1FeUsavDtSw
 xcUNPF6xycSLR8vO5fNlwiSU2asjsei7bDt0sKY1qgETLlZDnfklglwLFKY7d+rAggIb+Zu+QKF
 WTOGtol7//2a7X1BK+VyoTZu9Q84Yq5tDCuRlLprXppWThWW75P8mpChGbqLym3igWZH+fj9UQZ
 sQdxkN11uo8TstDo5XbszXz1FMqVvP5H5o+QsGeg1XaYZg2YPxTP+y9wGA==
X-Received: by 2002:a05:6402:548d:b0:6a9:a33b:bb8f with SMTP id
 4fb4d7f45d1cf-6aa2245f519mr471511a12.41.1789524820946; Tue, 15 Sep 2026
 19:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-5-zhangckid@gmail.com>
 <87h5jqrdq0.fsf@pond.sub.org>
In-Reply-To: <87h5jqrdq0.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 16 Sep 2026 10:13:04 +0800
X-Gm-Features: AcwNN1UfMRkzIUQysWP596DSXDYPrVM5xNdWmtGxXYO24rUcRKCm_cC4B0Ii90U
Message-ID: <CAK3tnvL1fd+b0RxB1gJ5ONjK7gLVgwpD0VELvJDNho89tQ4E_w@mail.gmail.com>
Subject: Re: [PATCH V17 04/13] monitor: track IOThread users with QOM paths
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::10;
 envelope-from=zhangckid@gmail.com; helo=mail-ed2-x10.google.com
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

On Tue, Sep 15, 2026 at 6:49=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Monitors that require an IOThread share the internal mon_iothread.
> > Account for each monitor explicitly in IOThread holder tracking, using
> > the monitor's canonical QOM path to distinguish holders.
> >
> > Acquire the shared monitor IOThread AioContext once and store the
> > IOThread and canonical QOM path so the holder can be released after the
> > monitor has been removed from the QOM tree. Use the stored IOThread for
> > per-monitor checks and accesses after initialization, and reuse the
> > stored context for later operations.
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
> >  monitor/monitor-internal.h |  7 +++++--
> >  monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
> >  monitor/qmp.c              | 14 +++++++-------
> >  3 files changed, 38 insertions(+), 19 deletions(-)
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > index 822a66d06d..020afdaebf 100644
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
> > @@ -109,14 +114,12 @@ struct MonitorQMP {
> >  };
> >
> >  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
> > -extern IOThread *mon_iothread;
> >  extern Coroutine *qmp_dispatcher_co;
> >  extern bool qmp_dispatcher_co_shutdown;
> >  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> >  extern QemuMutex monitor_lock;
> >  extern MonitorList mon_list;
> >
> > -bool monitor_requires_iothread(const Monitor *mon);
> >  int monitor_can_read(void *opaque);
> >  void monitor_cancel_out_watch(Monitor *mon);
> >  void monitor_list_append(Monitor *mon);
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index 2654b81890..a80d8dbf45 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -55,7 +55,7 @@ typedef struct {
> >  } MonitorQAPIEventConf;
> >
> >  /* Shared monitor I/O thread */
> > -IOThread *mon_iothread;
> > +static IOThread *mon_iothread;
> >
> >  /* Coroutine to dispatch the requests received from I/O thread */
> >  Coroutine *qmp_dispatcher_co;
> > @@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
> >      qemu_chr_fe_deinit(&mon->chr, false);
> >      g_string_free(mon->outbuf, true);
> >      qemu_mutex_destroy(&mon->mon_lock);
> > +
> > +    if (mon->iothread) {
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
> > @@ -164,7 +174,7 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mo=
n)
> >      return old_monitor;
> >  }
> >
> > -bool monitor_requires_iothread(const Monitor *mon)
> > +static bool monitor_requires_iothread(const Monitor *mon)
> >  {
> >      MonitorClass *cls =3D MONITOR_GET_CLASS(mon);
> >      return cls->requires_iothread && cls->requires_iothread(mon);
> > @@ -188,8 +198,8 @@ void monitor_cancel_out_watch(Monitor *mon)
> >          GMainContext *ctx =3D NULL;
> >          GSource *src;
> >
> > -        if (monitor_requires_iothread(mon)) {
> > -            ctx =3D iothread_get_g_main_context(mon_iothread);
> > +        if (mon->iothread) {
> > +            ctx =3D iothread_get_g_main_context(mon->iothread);
> >          }
> >          src =3D g_main_context_find_source_by_id(ctx, mon->out_watch);
> >          if (!src && ctx) {
> > @@ -516,12 +526,12 @@ void monitor_suspend(Monitor *mon)
> >  {
> >      qatomic_inc(&mon->suspend_cnt);
> >
> > -    if (monitor_requires_iothread(mon)) {
> > +    if (mon->iothread) {
> >          /*
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
> >              mon_iothread =3D iothread_create("mon_iothread", &error_ab=
ort);
> >          }
> >
> > -        ctx =3D iothread_get_aio_context(mon_iothread);
> > +        mon->iothread =3D mon_iothread;
> > +        mon->iothread_qom_path =3D object_get_canonical_path(OBJECT(mo=
n));
>
> Hmm, this is the monitor's QOM path, not the I/O threads.  Let's rename
> Monitor member iothread_qom_path to monitor_qom_path or just qom_path.

OK.

>
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
> >      }
> > -    mon->accept_input_bh =3D aio_bh_new(ctx, monitor_accept_input, mon=
);
> > +    mon->accept_input_bh =3D aio_bh_new(mon->ctx, monitor_accept_input=
, mon);
> >  }
> >
> >  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index aec0315775..e235302fb3 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -187,7 +187,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
> >      memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
> >      memset(mon->capab, 0, sizeof(mon->capab));
> >      mon->capab_offered[QMP_CAPABILITY_OOB] =3D
> > -        monitor_requires_iothread(MONITOR(mon));
> > +        MONITOR(mon)->iothread !=3D NULL;
> >  }
> >
> >  static void qmp_request_free(QMPRequest *req)
> > @@ -678,8 +678,8 @@ static void monitor_qmp_setup_handlers_bh(void *opa=
que)
> >      MonitorQMP *mon =3D opaque;
> >      GMainContext *context;
> >
> > -    assert(monitor_requires_iothread(MONITOR(mon)));
> > -    context =3D iothread_get_g_main_context(mon_iothread);
> > +    assert(MONITOR(mon)->iothread);
> > +    context =3D iothread_get_g_main_context(MONITOR(mon)->iothread);
> >      assert(context);
> >      qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
> >                               monitor_qmp_read, monitor_qmp_event,
> > @@ -717,7 +717,7 @@ static void monitor_qmp_complete(UserCreatable *uc,=
 Error **errp)
> >
> >      qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
> >
> > -    if (monitor_requires_iothread(MONITOR(mon))) {
> > +    if (MONITOR(mon)->iothread) {
> >          /*
> >           * Make sure the old iowatch is gone.  It's possible when
> >           * e.g. the chardev is in client mode, with wait=3Don.
> > @@ -734,7 +734,7 @@ static void monitor_qmp_complete(UserCreatable *uc,=
 Error **errp)
> >           * thread.  Schedule a bottom half.
> >           */
> >          mon->setup_pending =3D true;
> > -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread)=
,
> > +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
> >                                  monitor_qmp_setup_handlers_bh, mon);
> >          /* The bottom half will add @mon to @mon_list */
> >      } else {
> > @@ -788,8 +788,8 @@ static bool monitor_qmp_prepare_delete(UserCreatabl=
e *uc, Error **errp)
> >      }
> >
> >      /* Synchronize with in-flight iothread callbacks. */
> > -    if (monitor_requires_iothread(mon)) {
> > -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> > +    if (mon->iothread) {
> > +        aio_wait_bh_oneshot(mon->ctx,
> >                              monitor_qmp_iothread_quiesce, NULL);
> >      }
>
> With the rename
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks
Chen

>

