Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C220AC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:45:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Yic-0001b1-MB; Mon, 07 Sep 2026 08:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3Yib-0001at-S0
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x3YiZ-0002qR-4O
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788785097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j9KXRRLSzkyAGofetJGWcuI2nc4kXnA/XwMuC2eA0zU=;
 b=cpofeMnPEEx+E37woupLUyaGAHY+aC86UQA0pFUbJl8NLM7vVpGnifPMgmjztvbhkSyDcQ
 dzm0WrRTKat8JfafeX2mUVGIwR64rzWe2cz5/p5iDRicxLFAeyXKw5Nj5Ns6wIPrSQoN3n
 PJFk0liQ9JLxVuQ+E+rc8aKAQdtB5Pc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-wbPYlum-OCyE4Ya-4FAukg-1; Mon,
 07 Sep 2026 08:44:54 -0400
X-MC-Unique: wbPYlum-OCyE4Ya-4FAukg-1
X-Mimecast-MFC-AGG-ID: wbPYlum-OCyE4Ya-4FAukg_1788785093
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B1721829E3F; Mon,  7 Sep 2026 12:44:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 531CA427; Mon,  7 Sep 2026 12:44:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 05B9121E6A04; Mon, 07 Sep 2026 14:44:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  "'Michael S . Tsirkin'"
 <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  'Daniel P . =?utf-8?Q?Berrang=C3=A9'?=
 <berrange@redhat.com>, Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V15 05/14] monitor: track IOThread users with QOM paths
In-Reply-To: <20260907063725.626685-6-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 7 Sep 2026 14:37:16 +0800")
References: <20260907063725.626685-1-zhangckid@gmail.com>
 <20260907063725.626685-6-zhangckid@gmail.com>
Date: Mon, 07 Sep 2026 14:44:49 +0200
Message-ID: <874ig1xmbi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Monitors that require an IOThread share the internal mon_iothread.
> Account for each monitor explicitly in IOThread holder tracking, using
> the monitor's canonical QOM path to distinguish holders.
>
> Acquire the shared monitor IOThread AioContext once and store the
> IOThread and canonical QOM path so the holder can be released after the
> monitor has been removed from the QOM tree. Reuse the stored context for
> later operations.
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
>  monitor/monitor-internal.h |  5 +++++
>  monitor/monitor.c          | 26 +++++++++++++++++++++-----
>  monitor/qmp.c              |  5 +++--
>  3 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 822a66d06d..1d5aeae5e6 100644
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
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 2654b81890..cc7f6785b5 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
>      qemu_chr_fe_deinit(&mon->chr, false);
>      g_string_free(mon->outbuf, true);
>      qemu_mutex_destroy(&mon->mon_lock);
> +
> +    if (mon->iothread) {

As we'll see in monitor_complete() below, mon->iothread is mon_iothread
if monitor_requires_iothread(mon), else null.  Which means
mon->mon_iothread is non-null if and only if
monitor_requires_iothread(mon).

Here, you check whether mon->mon_iothread is non-null to find out
whether @mon uses the monitor I/O thread, and you read the monitor I/O
thread from mon->mon_iothread.

Elsewhere in this file, we check monitor_requires_iothread(mon) and you
read mon_iothread, e.g. in monitor_cancel_out_watch()

           if (monitor_requires_iothread(mon)) {
               ctx = iothread_get_g_main_context(mon_iothread);
           }

I don't like this inconsistency.  Two ways to avoid it:

1. Always use monitor_requires_iothread(mon) to check and mon_iothread
to read.  Drop struct Monitor member iothread.

2. Always use mon_iothread, except where we initialize it in
monitor_complete().

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
> @@ -521,7 +531,7 @@ void monitor_suspend(Monitor *mon)
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
       if (monitor_requires_iothread(mon)) {
           if (!mon_iothread) {
>              mon_iothread = iothread_create("mon_iothread", &error_abort);

Create the single, shared monitor I/O thread on demand, and store it in
mon_iothread.

>          }
>  
> -        ctx = iothread_get_aio_context(mon_iothread);
> +        mon->iothread = mon_iothread;

Set mon->iothread to the monitor I/O thread.

> +        mon->iothread_qom_path = object_get_canonical_path(OBJECT(mon));
> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = mon->iothread_qom_path,
> +        };
> +
> +        mon->ctx = iothread_ref_and_get_aio_context(mon->iothread, &io_holder);
>      } else {
> -        ctx = qemu_get_aio_context();
> +        mon->ctx = qemu_get_aio_context();

Leave mon->iothread null.

>      }

mon->iothread is mon_iothread if monitor_requires_iothread(mon), else
null.

> -    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
> +    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
>  }
>  
>  int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index aec0315775..de56345456 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -734,7 +734,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
>           * thread.  Schedule a bottom half.
>           */
>          mon->setup_pending = true;
> -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +
> +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {
> @@ -789,7 +790,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
>  
>      /* Synchronize with in-flight iothread callbacks. */
>      if (monitor_requires_iothread(mon)) {
> -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> +        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
>                              monitor_qmp_iothread_quiesce, NULL);
>      }


