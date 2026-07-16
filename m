Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC72C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNkF-0005Dx-5q; Thu, 16 Jul 2026 11:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkNkD-0005DW-Sg
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:11:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wkNkA-0004xv-LT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 11:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784214680;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YFsxFnklmO+X5ASco9yOrMosB76tHtUzWdpaJDXp+Ng=;
 b=RNaoDdgvFU01O2BLow1eZdQh3P4yE0/hJ3pPmuvy+KziY349kf6L9xzPARwa0iD12Ich9L
 jPCUTfW+ga1KvAEgflJanbQhDOxk9SWXR5cZtzIsKR1Cfseg5UnVIuhVGstNtYq/u8T4cn
 tPhNPbahqbMg0jZl+OySg6nYp9ocmIA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-DaFYEHUSPdGxIXK9m4JXfg-1; Thu,
 16 Jul 2026 11:11:19 -0400
X-MC-Unique: DaFYEHUSPdGxIXK9m4JXfg-1
X-Mimecast-MFC-AGG-ID: DaFYEHUSPdGxIXK9m4JXfg_1784214677
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C29D1955DC7; Thu, 16 Jul 2026 15:11:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.221])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B85242E; Thu, 16 Jul 2026 15:11:12 +0000 (UTC)
Date: Thu, 16 Jul 2026 16:11:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V10 06/15] monitor: Update tracking iothread users with
 holder
Message-ID: <alj0jQ_Is4VA_J2A@redhat.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
 <20260716144043.76414-7-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716144043.76414-7-zhangckid@gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 16, 2026 at 10:40:31PM +0800, Zhang Chen wrote:
> Based on monitor QOM path tracking iothread users with holder.
> Introduce the AioContext in the Monitor struct to avoid repeated calls to
> iothread_get_aio_context() and ensure symmetrical ref/unref during
> monitor lifecycle.
> 
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/monitor-internal.h |  3 +++
>  monitor/monitor.c          | 22 ++++++++++++++++++++--
>  monitor/qmp.c              |  5 +++--
>  3 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 23829f32f9..caecceec93 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -153,6 +153,9 @@ struct Monitor {
>      guint out_watch;
>      int mux_out;
>      int reset_seen;
> +
> +    /* iothread context */
> +    AioContext *ctx;
>  };
>  
>  struct MonitorHMPClass {
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index ed195fd97b..688bb85c81 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -573,7 +573,7 @@ void monitor_suspend(Monitor *mon)
>           * Kick I/O thread to make sure this takes effect.  It'll be
>           * evaluated again in prepare() of the watch object.
>           */
> -        aio_notify(iothread_get_aio_context(mon_iothread));
> +        aio_notify(mon->ctx);
>      }
>  
>      trace_monitor_suspend(mon, 1);
> @@ -668,6 +668,17 @@ void monitor_cleanup(void)
>          qemu_mutex_unlock(&monitor_lock);
>          monitor_flush(mon);
>          qemu_mutex_lock(&monitor_lock);
> +
> +        if (mon_iothread) {
> +            g_autofree char *path = object_get_canonical_path(OBJECT(mon));
> +            const IOThreadHolder io_holder = {
> +                .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +                .u.qom_object.qom_path = path,
> +            };
> +
> +            iothread_put_aio_context(mon_iothread, &io_holder);
> +            mon->ctx = NULL;
> +        }
>          object_unparent(OBJECT(mon));
>      }
>      qemu_mutex_unlock(&monitor_lock);
> @@ -732,7 +743,14 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
>              mon_iothread = iothread_create("mon_iothread", &error_abort);
>          }
>  
> -        ctx = iothread_get_aio_context(mon_iothread);
> +        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
> +        const IOThreadHolder io_holder = {
> +            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +            .u.qom_object.qom_path = path,
> +        };
> +
> +        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
> +        ctx = mon->ctx;
>      } else {
>          ctx = qemu_get_aio_context();
>      }

Even though QMP only takes the first branch, I'd be more
comfortable if we set mon->ctx in both branches of this
condition, so we can always assume that mon->ctx is
non-NULL.

> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 223e0643c2..b16bd77688 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -732,7 +732,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
>           * thread.  Schedule a bottom half.
>           */
>          mon->setup_pending = true;
> -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +
> +        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {
> @@ -787,7 +788,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
>  
>      /* Synchronize with in-flight iothread callbacks. */
>      if (monitor_requires_iothread(mon)) {
> -        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
> +        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
>                              monitor_qmp_iothread_quiesce, NULL);
>      }

...this unconditionally accesses mon->ctx, and so will surely hit
a NULL

>  
> -- 
> 2.49.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


