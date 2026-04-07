Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DC8FF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWA-0007uB-Fm; Tue, 07 Apr 2026 14:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABTm-0002eY-7W
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA3qS-0005AI-5m
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 06:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775558382;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Hbs22JhBt6EjZOe3QujDiy+G5sHIl7it0+rcHyQDPOE=;
 b=EAw2Ut+BpRI1pPD1M8+B4ySJN8Iy8UCu3OfIktEGK2XCch2LR/H9ZKvSJqTXcXKBoGBeYA
 GZNkS8oUBTFjR53WAcjEoqvMu1uTDyz6KO22ALQIeJasa7Rc+PmFuZltBRs25LJJ/MbZHt
 tz7icQvyujStQBKU3RHkAGqkGY69pBE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-Y_NaVTD1PRufTALoeK3vbQ-1; Tue,
 07 Apr 2026 06:39:39 -0400
X-MC-Unique: Y_NaVTD1PRufTALoeK3vbQ-1
X-Mimecast-MFC-AGG-ID: Y_NaVTD1PRufTALoeK3vbQ_1775558378
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A24E81956046; Tue,  7 Apr 2026 10:39:37 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBC0130001BB; Tue,  7 Apr 2026 10:39:34 +0000 (UTC)
Date: Tue, 7 Apr 2026 11:39:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 1/5] monitor: store monitor id and dynamic flag in
 Monitor struct
Message-ID: <adTe4_uiYogOULtn@redhat.com>
References: <20260407-work-qmp-monitor-hotplug-v3-0-cb259800fffb@kernel.org>
 <20260407-work-qmp-monitor-hotplug-v3-1-cb259800fffb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-work-qmp-monitor-hotplug-v3-1-cb259800fffb@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 07, 2026 at 09:32:45AM +0200, Christian Brauner wrote:
> Add 'id', 'dynamic', and 'dead' fields to struct Monitor. The id field
> stores the monitor identifier from MonitorOptions which was previously
> parsed but discarded. The dynamic flag marks monitors created at runtime
> via the upcoming monitor-add command, and the dead flag will be used for
> deferred destruction during monitor-remove.
> 
> Extend monitor_init_qmp() to accept id and dynamic parameters so these
> are set before the monitor is added to mon_list.
> 
> For iothread monitors, move monitor_list_append() from the setup BH to
> the caller so monitor_find_by_id() can detect duplicates immediately.
> Without this, two concurrent monitor-add calls could both pass the
> duplicate check before either BH runs.  This means the monitor is now
> visible in mon_list before its chardev handlers are set up, which was
> not the case before.  This is safe because the request queue is still
> empty (no chardev handlers means no monitor_qmp_read(), so the
> dispatcher finds nothing to dispatch) and event broadcast is handled
> below.
> 
> This requires initializing mon->commands = &qmp_cap_negotiation_commands
> before monitor_list_append().  Without it, commands is NULL (from
> g_new0) and monitor_qapi_event_emit() would not skip the monitor during
> event broadcast -- its check is specifically for the
> qmp_cap_negotiation_commands pointer, so a NULL falls through to
> qmp_send_response() on an uninitialized monitor.  CHR_EVENT_OPENED sets
> commands to the same value again later.
> 
> Add monitor_find_by_id() to look up monitors by identifier.  The lookup
> takes monitor_lock to serialize with the I/O thread BH that modifies
> mon_list, but releases it before returning.  The caller must hold the
> BQL to ensure the returned pointer remains valid since only BQL holders
> can destroy monitors.
> 
> Free the id string in monitor_data_destroy().
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/monitor/monitor.h  |  3 ++-
>  monitor/monitor-internal.h |  5 +++++
>  monitor/monitor.c          | 21 ++++++++++++++++++++-
>  monitor/qmp.c              | 11 ++++++++---
>  4 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 296690e1f1..7a2bb603e4 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -19,7 +19,8 @@ bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
> +                      bool dynamic, Error **errp);
>  void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
>  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_init_opts(QemuOpts *opts, Error **errp);
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index feca111ae3..4896812d4e 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -98,7 +98,10 @@ struct Monitor {
>      bool is_qmp;
>      bool skip_flush;
>      bool use_io_thread;
> +    bool dynamic;           /* true if created via monitor-add */
> +    bool dead;              /* awaiting drain after monitor-remove */

Neither of these fields appear to be used for anything in this
patch. If they're used in a later patch, then add them at time
of use.

>  
> +    char *id;               /* NULL for unnamed CLI monitors */
>      char *mon_cpu_path;
>      QTAILQ_ENTRY(Monitor) entry;
>  
> @@ -181,6 +184,8 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
>  void coroutine_fn monitor_qmp_dispatcher_co(void *data);
>  void qmp_dispatcher_co_wake(void);
>  
> +Monitor *monitor_find_by_id(const char *id);
> +
>  int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
>  void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
>  int hmp_compare_cmd(const char *name, const char *list);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 00b93ed612..7144255e12 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -622,6 +622,7 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>  
>  void monitor_data_destroy(Monitor *mon)
>  {
> +    g_free(mon->id);
>      g_free(mon->mon_cpu_path);
>      qemu_chr_fe_deinit(&mon->chr, false);
>      if (monitor_is_qmp(mon)) {
> @@ -633,6 +634,24 @@ void monitor_data_destroy(Monitor *mon)
>      qemu_mutex_destroy(&mon->mon_lock);
>  }
>  
> +/*
> + * Look up a monitor by its id.  The monitor_lock is released before
> + * returning, so the caller must hold the BQL to ensure the returned
> + * pointer remains valid (only BQL holders can destroy monitors).
> + */
> +Monitor *monitor_find_by_id(const char *id)
> +{
> +    Monitor *mon;
> +
> +    QEMU_LOCK_GUARD(&monitor_lock);
> +    QTAILQ_FOREACH(mon, &mon_list, entry) {
> +        if (mon->id && strcmp(mon->id, id) == 0) {
> +            return mon;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  void monitor_cleanup(void)
>  {
>      /*
> @@ -732,7 +751,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
> -        monitor_init_qmp(chr, opts->pretty, errp);
> +        monitor_init_qmp(chr, opts->pretty, opts->id, false, errp);
>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 687019811f..afbe2283d6 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -510,10 +510,10 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
>                               monitor_qmp_read, monitor_qmp_event,
>                               NULL, &mon->common, context, true);
> -    monitor_list_append(&mon->common);
>  }
>  
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id,
> +                      bool dynamic, Error **errp)
>  {
>      MonitorQMP *mon = g_new0(MonitorQMP, 1);
>  
> @@ -527,12 +527,16 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>      monitor_data_init(&mon->common, true, false,
>                        qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
>  
> +    mon->common.id = g_strdup(id);
> +    mon->common.dynamic = dynamic;
>      mon->pretty = pretty;
>  
>      qemu_mutex_init(&mon->qmp_queue_lock);
>      mon->qmp_requests = g_queue_new();
>  
>      json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
> +    /* Prevent event broadcast to an uninitialized monitor. */
> +    mon->commands = &qmp_cap_negotiation_commands;
>      if (mon->common.use_io_thread) {
>          /*
>           * Make sure the old iowatch is gone.  It's possible when
> @@ -551,7 +555,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>           */
>          aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
>                                  monitor_qmp_setup_handlers_bh, mon);
> -        /* The bottom half will add @mon to @mon_list */
> +        /* Synchronous insert for immediate duplicate detection. */
> +        monitor_list_append(&mon->common);
>      } else {
>          qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
>                                   monitor_qmp_read, monitor_qmp_event,
> 
> -- 
> 2.47.3
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


