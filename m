Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C81C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Qja-0004xw-E8; Tue, 15 Sep 2026 06:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6QjZ-0004xW-4o
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6QjW-0003NU-9W
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789469389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aBPWYkSPpHB10jFENengvcxbGHIMIxaoHOfqaGKV9CM=;
 b=iHZ+EtUAPX0CaWLNVJB9bzGTQCgBzHcaVY9rnBgt79pLO2qWEXNkMntx3q839ZlKOImDS4
 DvM3NIqP0Aj0TYRB2yKNET65VQNmJeKRacCc0xtB2ECnPjS6EZUV3pD8CJXfQ4eoRDAZdd
 pNBckud+nceMhAfyOH7hqxrgOFC6Odw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-KMLirWNOPtq6zKwe_J2H7g-1; Tue,
 15 Sep 2026 06:49:47 -0400
X-MC-Unique: KMLirWNOPtq6zKwe_J2H7g-1
X-Mimecast-MFC-AGG-ID: KMLirWNOPtq6zKwe_J2H7g_1789469386
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78D321829E27; Tue, 15 Sep 2026 10:49:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C01C61956045; Tue, 15 Sep 2026 10:49:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5C6A021E6A04; Tue, 15 Sep 2026 12:49:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  "'Michael S . Tsirkin'"
 <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  'Daniel P . =?utf-8?Q?Berrang=C3=A9'?=
 <berrange@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V17 04/13] monitor: track IOThread users with QOM paths
In-Reply-To: <20260915101655.3216101-5-zhangckid@gmail.com> (Zhang Chen's
 message of "Tue, 15 Sep 2026 18:16:46 +0800")
References: <20260915101655.3216101-1-zhangckid@gmail.com>
 <20260915101655.3216101-5-zhangckid@gmail.com>
Date: Tue, 15 Sep 2026 12:49:43 +0200
Message-ID: <87h5jqrdq0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Monitors that require an IOThread share the internal mon_iothread.
> Account for each monitor explicitly in IOThread holder tracking, using
> the monitor's canonical QOM path to distinguish holders.
>
> Acquire the shared monitor IOThread AioContext once and store the
> IOThread and canonical QOM path so the holder can be released after the
> monitor has been removed from the QOM tree. Use the stored IOThread for
> per-monitor checks and accesses after initialization, and reuse the
> stored context for later operations.
>
> Release the holder from monitor_finalize(), after resources associated
> with the AioContext have been destroyed. This pairs the reference taken
> in complete() with instance finalization and keeps the IOThread alive
> throughout monitor teardown.
>
> The internal mon_iothread remains hidden from query-iothreads, as before.
> Management applications therefore cannot use it to determine which
> monitors are using the IOThread. Nevertheless, track the monitor
> holders so that they follow the same explicit holder and
> IOThread reference lifecycle as other AioContext users.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/monitor-internal.h |  7 +++++--
>  monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
>  monitor/qmp.c              | 14 +++++++-------
>  3 files changed, 38 insertions(+), 19 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 822a66d06d..020afdaebf 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -77,6 +77,11 @@ struct Monitor {
>      GString *outbuf;
>      guint out_watch;
>      int mux_out;
> +
> +    /* iothread context and holder identity */
> +    IOThread *iothread;
> +    char *iothread_qom_path;
> +    AioContext *ctx;
>  };
>  
>  struct MonitorQMPClass {
> @@ -109,14 +114,12 @@ struct MonitorQMP {
>  };
>  
>  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
> -extern IOThread *mon_iothread;
>  extern Coroutine *qmp_dispatcher_co;
>  extern bool qmp_dispatcher_co_shutdown;
>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
>  
> -bool monitor_requires_iothread(const Monitor *mon);
>  int monitor_can_read(void *opaque);
>  void monitor_cancel_out_watch(Monitor *mon);
>  void monitor_list_append(Monitor *mon);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 2654b81890..a80d8dbf45 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -55,7 +55,7 @@ typedef struct {
>  } MonitorQAPIEventConf;
>  
>  /* Shared monitor I/O thread */
> -IOThread *mon_iothread;
> +static IOThread *mon_iothread;
>  
>  /* Coroutine to dispatch the requests received from I/O thread */
>  Coroutine *qmp_dispatcher_co;
> @@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
>      qemu_chr_fe_deinit(&mon->chr, false);
>      g_string_free(mon->outbuf, true);
>      qemu_mutex_destroy(&mon->mon_lock);
> +
> +    if (mon->iothread) {
> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = mon->iothread_qom_path,
> +        };
> +
> +        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
> +    }
> +    g_free(mon->iothread_qom_path);
>  }
>  
>  static char *monitor_get_chardev_id(Object *obj, Error **errp)
> @@ -164,7 +174,7 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>      return old_monitor;
>  }
>  
> -bool monitor_requires_iothread(const Monitor *mon)
> +static bool monitor_requires_iothread(const Monitor *mon)
>  {
>      MonitorClass *cls = MONITOR_GET_CLASS(mon);
>      return cls->requires_iothread && cls->requires_iothread(mon);
> @@ -188,8 +198,8 @@ void monitor_cancel_out_watch(Monitor *mon)
>          GMainContext *ctx = NULL;
>          GSource *src;
>  
> -        if (monitor_requires_iothread(mon)) {
> -            ctx = iothread_get_g_main_context(mon_iothread);
> +        if (mon->iothread) {
> +            ctx = iothread_get_g_main_context(mon->iothread);
>          }
>          src = g_main_context_find_source_by_id(ctx, mon->out_watch);
>          if (!src && ctx) {
> @@ -516,12 +526,12 @@ void monitor_suspend(Monitor *mon)
>  {
>      qatomic_inc(&mon->suspend_cnt);
>  
> -    if (monitor_requires_iothread(mon)) {
> +    if (mon->iothread) {
>          /*
>           * Kick I/O thread to make sure this takes effect.  It'll be
>           * evaluated again in prepare() of the watch object.
>           */
> -        aio_notify(iothread_get_aio_context(mon_iothread));
> +        aio_notify(mon->ctx);
>      }
>  
>      trace_monitor_suspend(mon, 1);
> @@ -661,7 +671,6 @@ char *monitor_compat_id(void)
>  static void monitor_complete(UserCreatable *uc, Error **errp)
>  {
>      Monitor *mon = MONITOR(uc);
> -    AioContext *ctx;
>  
>      if (mon->chardev_id) {
>          Chardev *chr = qemu_chr_find(mon->chardev_id);
> @@ -680,11 +689,18 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
>              mon_iothread = iothread_create("mon_iothread", &error_abort);
>          }
>  
> -        ctx = iothread_get_aio_context(mon_iothread);
> +        mon->iothread = mon_iothread;
> +        mon->iothread_qom_path = object_get_canonical_path(OBJECT(mon));

Hmm, this is the monitor's QOM path, not the I/O threads.  Let's rename
Monitor member iothread_qom_path to monitor_qom_path or just qom_path.

> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = mon->iothread_qom_path,
> +        };
> +
> +        mon->ctx = iothread_ref_and_get_aio_context(mon->iothread, &io_holder);
>      } else {
> -        ctx = qemu_get_aio_context();
> +        mon->ctx = qemu_get_aio_context();
>      }
> -    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
> +    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
>  }
>  
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index aec0315775..e235302fb3 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -187,7 +187,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
>      memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
>      memset(mon->capab, 0, sizeof(mon->capab));
>      mon->capab_offered[QMP_CAPABILITY_OOB] =
> -        monitor_requires_iothread(MONITOR(mon));
> +        MONITOR(mon)->iothread != NULL;
>  }
>  
>  static void qmp_request_free(QMPRequest *req)
> @@ -678,8 +678,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      MonitorQMP *mon = opaque;
>      GMainContext *context;
>  
> -    assert(monitor_requires_iothread(MONITOR(mon)));
> -    context = iothread_get_g_main_context(mon_iothread);
> +    assert(MONITOR(mon)->iothread);
> +    context = iothread_get_g_main_context(MONITOR(mon)->iothread);
>      assert(context);
>      qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
>                               monitor_qmp_read, monitor_qmp_event,
> @@ -717,7 +717,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
>  
>      qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
>  
> -    if (monitor_requires_iothread(MONITOR(mon))) {
> +    if (MONITOR(mon)->iothread) {
>          /*
>           * Make sure the old iowatch is gone.  It's possible when
>           * e.g. the chardev is in client mode, with wait=on.
> @@ -734,7 +734,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
>           * thread.  Schedule a bottom half.
>           */
>          mon->setup_pending = true;
> -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {
> @@ -788,8 +788,8 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
>      }
>  
>      /* Synchronize with in-flight iothread callbacks. */
> -    if (monitor_requires_iothread(mon)) {
> -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> +    if (mon->iothread) {
> +        aio_wait_bh_oneshot(mon->ctx,
>                              monitor_qmp_iothread_quiesce, NULL);
>      }

With the rename
Reviewed-by: Markus Armbruster <armbru@redhat.com>


