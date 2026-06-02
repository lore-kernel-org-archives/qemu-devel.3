Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE340CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:21:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSnC-000442-Ob; Tue, 02 Jun 2026 13:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUSn5-00041U-Ug
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUSn3-0001i2-Rk
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780420832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AGhIokLdRYVFShtHrr2Fv/XnMC0ZwKaQJwK47KxQXZY=;
 b=g74LXX9LDvPrbWghLaZ28F2ydw/lNC9hR95V3KK2Wfb6zd1KYe61EQ/uLpmCfAAFNqp4La
 To2CLQzQA/WWE/AIh+QBfmKjGHP1b5OJvLYFkRLY7+7HR3eZBFEbtVX3iCAoXaIuwMr/No
 oKkqiVFNQ1kPFgkZBogbquj0VuIuA4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-lsdeNT4dO8qVHr2JyjQC2A-1; Tue,
 02 Jun 2026 13:20:28 -0400
X-MC-Unique: lsdeNT4dO8qVHr2JyjQC2A-1
X-Mimecast-MFC-AGG-ID: lsdeNT4dO8qVHr2JyjQC2A_1780420827
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A4E18005BA; Tue,  2 Jun 2026 17:20:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F198318004A3; Tue,  2 Jun 2026 17:20:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A33F21E6A01; Tue, 02 Jun 2026 19:20:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V8 07/15] monitor: Update tracking iothread users with
 holder
In-Reply-To: <20260529213321.96271-8-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 30 May 2026 05:33:13 +0800")
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-8-zhangckid@gmail.com>
Date: Tue, 02 Jun 2026 19:20:24 +0200
Message-ID: <87qzmorh9j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

> Based on monitor ID tracking iothread users with holder.
> Introduce the AioContext in the Monitor struct to avoid repeated calls to
> iothread_get_aio_context()

iothread_get_aio_context(iothread) returns iothread->ctx.  I doubt
avoiding the call is worth the complexity yet another variable adds.

>                            and ensure symmetrical ref/unref during
> monitor lifecycle.

What do you mean by that?

> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  monitor/monitor-internal.h |  3 +++
>  monitor/monitor.c          | 20 ++++++++++++++++++--
>  monitor/qmp.c              |  3 ++-
>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 2060311b03..92d7630921 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -127,6 +127,9 @@ struct Monitor {
>      guint out_watch;
>      int mux_out;
>      int reset_seen;
> +
> +    /* iothread context */
> +    AioContext *ctx;
>  };
>  
>  struct MonitorHMP {
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index dafb4ad8b0..7eec6f967d 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -529,7 +529,7 @@ int monitor_suspend(Monitor *mon)
>           * Kick I/O thread to make sure this takes effect.  It'll be
>           * evaluated again in prepare() of the watch object.
>           */
> -        aio_notify(iothread_get_aio_context(mon_iothread));
> +        aio_notify(mon->ctx);
>      }
>  
>      trace_monitor_suspend(mon, 1);
> @@ -564,7 +564,7 @@ void monitor_resume(Monitor *mon)
>          AioContext *ctx;
>  
>          if (mon->use_io_thread) {
> -            ctx = iothread_get_aio_context(mon_iothread);
> +            ctx = mon->ctx;
>          } else {
>              ctx = qemu_get_aio_context();
>          }
> @@ -612,6 +612,12 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>  {
>      if (use_io_thread && !mon_iothread) {
>          monitor_iothread_init();
> +
> +        IOThreadHolder holder = {
> +            .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
> +            .u.monitor_name.monitor_name = (char *)mon->id,
> +        };
> +        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &holder);
>      }
>      qemu_mutex_init(&mon->mon_lock);
>      mon->is_qmp = is_qmp;
> @@ -631,6 +637,16 @@ void monitor_data_destroy(Monitor *mon)
>      }
>      g_string_free(mon->outbuf, true);
>      qemu_mutex_destroy(&mon->mon_lock);
> +
> +    if (mon->ctx && mon_iothread) {
> +        IOThreadHolder holder = {
> +            .type = IO_THREAD_HOLDER_KIND_MONITOR_NAME,
> +            .u.monitor_name.monitor_name = (char *)mon->id,
> +        };
> +
> +        iothread_put_aio_context(mon_iothread, &holder);
> +        mon->ctx = NULL;
> +    }
>  }
>  
>  void monitor_cleanup(void)
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index b210850a15..b67674aef3 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -565,7 +565,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
>           * since chardev might be running in the monitor I/O
>           * thread.  Schedule a bottom half.
>           */
> -        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
> +        Monitor *mon_p = &mon->common;
> +        aio_bh_schedule_oneshot(mon_p->ctx,
>                                  monitor_qmp_setup_handlers_bh, mon);
>          /* The bottom half will add @mon to @mon_list */
>      } else {

The patch does two things:

(1) Replace iothread_get_aio_context(mon_iothread) by mon->ctx.

(2) Call iothread_ref_and_get_aio_context() / iothread_put_aio_context().

I challenged (1).  If we decide we want it, I'll ask you to split the
patch.


