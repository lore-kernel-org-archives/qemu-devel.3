Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D62CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSeI-0001QN-SY; Tue, 02 Jun 2026 13:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUSdb-0001Ga-KD
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUSdZ-0007RB-DX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780420243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzJ6JoI09xhemgFDBo1nYKnJQG4Ah3cCDdCJWRotTuE=;
 b=EFkNb/gLdFIoUXEESwqeppSDXje/l1SPbpingooeDjEV0zMIq0ml54I98YoXfwQnfLnTCq
 iuUtPRCuigRoKWvzqmn0t+tF+SAuJv1jXlBrS0g0GXORgUnIQjawjju9exAba3W5XN1INk
 RHWd0gYlZJXWR5o16/m8x1qV6JaoS4A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-GDZSFL6pPxqCevGu4s4udg-1; Tue,
 02 Jun 2026 13:02:33 -0400
X-MC-Unique: GDZSFL6pPxqCevGu4s4udg-1
X-Mimecast-MFC-AGG-ID: GDZSFL6pPxqCevGu4s4udg_1780419752
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B1BDB1956052; Tue,  2 Jun 2026 17:02:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E500230002E4; Tue,  2 Jun 2026 17:02:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 873EB21E6A01; Tue, 02 Jun 2026 19:02:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V8 06/15] monitor: assign unique default ID to anonymous
 monitors
In-Reply-To: <20260529213321.96271-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 30 May 2026 05:33:12 +0800")
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-7-zhangckid@gmail.com>
Date: Tue, 02 Jun 2026 19:02:28 +0200
Message-ID: <87ecioswnv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Currently, dynamically or implicitly created monitors (such as those
> generated via '-monitor stdio', GDB stub terminals, or mux chardevs)
> leave the 'id' field in the Monitor struct as NULL.

There is no @id member in struct Monitor.

>                                                     But the original
> @MonitorOptions have the @id field.

QAPI type MonitorOptions has an optional member @id.

Instances are only created by monitor_init_opts() from a QemuOpts, and
member @id is set to the QemuOpts's @id, which is also optional.

monitor_init_opts() is only called during startup on behalf of CLI
option -mon, its shorthands -monitor, -qmp, -qmp-pretty, and for default
monitors.

-mon accepts an "id" parameter, but it's optional.

The others make up an "id".  For instance, the default monitor usually
gets "compat_monitor0".

Aside: there's code that checks whether a non-null QemuOpts "id" starts
with "compat_monitor".  That's horrifying.

As far as I can tell, the only way to create a monitor with null @id in
MonitorOptions is -mon without "id".

This is a swamp.  Instead of messing with MonitorOptions member @id, ...

>                                     This makes it difficult to track,
> debug, or associate monitors with specific iothreads or
> infrastructure components.
>
> Fix this by introducing monitor_get_id(), which uses an atomic counter
> to generate a unique fallback name ("mon_default_X") when 'id' is
> not explicitly supplied in MonitorOptions. Update all internal HMP
> and QMP initialization paths to propagate and store this string.

... you create yet another ID that is used for nothing but referring to
monitors from IOThreadHolder.  Hmm.

Is it really necessary that every monitor has an ID?  If a user want
one, they can simply avoid -mon without id.

If it's not necessary, ignore the remainder of my review.

> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  chardev/char.c             |  2 +-
>  gdbstub/system.c           |  3 ++-
>  include/monitor/monitor.h  |  6 ++++--
>  monitor/hmp.c              | 20 +++++++++++++++++++-
>  monitor/monitor-internal.h |  2 ++
>  monitor/monitor.c          |  4 ++--
>  monitor/qmp.c              | 18 +++++++++++++++++-
>  stubs/monitor-internal.c   |  3 ++-
>  8 files changed, 49 insertions(+), 9 deletions(-)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index ca8b37ed8d..f057247001 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -805,7 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
>  
>      if (qemu_opt_get_bool(opts, "mux", 0)) {
>          assert(permit_mux_mon);
> -        monitor_init_hmp(chr, true, &err);
> +        monitor_init_hmp(chr, true, NULL, &err);
>          if (err) {
>              error_report_err(err);
>              object_unparent(OBJECT(chr));
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index e86c5870ab..50f934fde3 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -388,7 +388,8 @@ bool gdbserver_start(const char *device, Error **errp)
>          /* Initialize a monitor terminal for gdb */
>          mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
>                                     NULL, NULL, &error_abort);
> -        monitor_init_hmp(mon_chr, false, &error_abort);
> +
> +        monitor_init_hmp(mon_chr, false, NULL, &error_abort);
>      } else {
>          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>          mon_chr = gdbserver_system_state.mon_chr;
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 55649a8664..c6ccd34cda 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -19,11 +19,13 @@ bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
> +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp);
> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp);
>  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_init_opts(QemuOpts *opts, Error **errp);
>  void monitor_cleanup(void);
> +char *monitor_get_id(void);
>  
>  int monitor_suspend(Monitor *mon);
>  void monitor_resume(Monitor *mon);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index cc4390486e..47f57f69e5 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -43,6 +43,8 @@
>  #include "system/block-backend.h"
>  #include "trace.h"
>  
> +static int mon_hmp_id_counter;
> +
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque)
>  {
> @@ -65,6 +67,14 @@ void monitor_read_command(MonitorHMP *mon, int show_prompt)
>      }
>  }
>  
> +static char *monitor_hmp_get_id(void)
> +{
> +    int id = qatomic_fetch_inc(&mon_hmp_id_counter);

Why atomic?  As far as I can see, this is only called during startup in
the main thread.  Even if we merge dynamic monitor creation, the monitor
command to create a monitor will also run in the main thread.

> +    char *name = g_strdup_printf("mon_default_hmp_%d", id);

Can clash with the user's monitor IDs.

> +
> +    return name;
> +}
> +
>  int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>                            void *opaque)
>  {
> @@ -1522,10 +1532,18 @@ static void monitor_readline_flush(void *opaque)
>      monitor_flush(&mon->common);
>  }
>  
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp)
>  {
>      MonitorHMP *mon = g_new0(MonitorHMP, 1);
>  
> +    if (!id) {
> +        g_autofree char *mon_id =  monitor_hmp_get_id();
> +        mon->common.id = g_strdup(mon_id);
> +    } else {
> +        mon->common.id = g_strdup(id);
> +    }
> +
>      if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
>          g_free(mon);
>          return;
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index a5c4aba306..2060311b03 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -108,6 +108,8 @@ struct Monitor {
>      bool skip_flush;
>      bool use_io_thread;
>  
> +    char *id;

Needs a comment.  In case you doubt it: explaining monitor IDs in my
review of the commit message took me ~120 words.

> +
>      char *mon_cpu_path;
>      QTAILQ_ENTRY(Monitor) entry;
>  
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 00b93ed612..dafb4ad8b0 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -732,7 +732,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
> -        monitor_init_qmp(chr, opts->pretty, errp);
> +        monitor_init_qmp(chr, opts->pretty, opts->id, errp);
>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> @@ -743,7 +743,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>              error_setg(errp, "'pretty' is not compatible with HMP monitors");
>              return -1;
>          }
> -        monitor_init_hmp(chr, true, errp);
> +        monitor_init_hmp(chr, true, opts->id, errp);
>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 687019811f..b210850a15 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -56,6 +56,7 @@
>   * Access must be atomic for thread safety.
>   */
>  static bool qmp_dispatcher_co_busy = true;
> +static int mon_qmp_id_counter;
>  
>  struct QMPRequest {
>      /* Owner of the request */
> @@ -76,6 +77,14 @@ static bool qmp_oob_enabled(MonitorQMP *mon)
>      return mon->capab[QMP_CAPABILITY_OOB];
>  }
>  
> +static char *monitor_qmp_get_id(void)
> +{
> +    int id = qatomic_fetch_inc(&mon_qmp_id_counter);

Again, why atomic?

> +    char *name = g_strdup_printf("mon_default_qmp_%d", id);

Again, can clash with the user's IDs.

> +
> +    return name;
> +}
> +
>  static void monitor_qmp_caps_reset(MonitorQMP *mon)
>  {
>      memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
> @@ -513,10 +522,17 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      monitor_list_append(&mon->common);
>  }
>  
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
>  {
>      MonitorQMP *mon = g_new0(MonitorQMP, 1);
>  
> +    if (!id) {
> +        g_autofree char *mon_id =  monitor_qmp_get_id();
> +        mon->common.id = g_strdup(mon_id);
> +    } else {
> +        mon->common.id = g_strdup(id);
> +    }
> +
>      if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
>          g_free(mon);
>          return;
> diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
> index 4fece49d53..325a559e62 100644
> --- a/stubs/monitor-internal.c
> +++ b/stubs/monitor-internal.c
> @@ -8,6 +8,7 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>      return -1;
>  }
>  
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp)
>  {
>  }


