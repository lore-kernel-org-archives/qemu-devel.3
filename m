Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE99EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6Ey-0004cs-RV; Fri, 26 Jun 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wd6EI-0004Of-Tc
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wd6EG-0002ok-UM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:04:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782479059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gWMmHIQ+PfLNRSnqyiWrL40qLebGHII79BNduoR9hIU=;
 b=TOGfnkUFqIZFjp9eH6R8qzl6xVTXtRt1FOBnfJipuCJZhvlGF7foUILX3FYKrio1T+98I8
 qRu8Km6mwo9tEbFT6UtIaQeKZFeBT0PkrgSUgDkjLG4MIA+IsDkfm55ZwGmG1tGAeT1NWl
 8NKY3XA2tQ71wQRMeV2mq4D/TTxmXh0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-D3VMrCa2Po-EMdQN_DFk2w-1; Fri,
 26 Jun 2026 09:04:15 -0400
X-MC-Unique: D3VMrCa2Po-EMdQN_DFk2w-1
X-Mimecast-MFC-AGG-ID: D3VMrCa2Po-EMdQN_DFk2w_1782479054
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E508C1955DCF; Fri, 26 Jun 2026 13:04:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 390A918005B2; Fri, 26 Jun 2026 13:04:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B154021E6920; Fri, 26 Jun 2026 15:04:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 06/17] monitor: refactor monitor_data_init() to pass ID
In-Reply-To: <20260624070851.13342-7-zhangckid@gmail.com> (Zhang Chen's
 message of "Wed, 24 Jun 2026 15:08:40 +0800")
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-7-zhangckid@gmail.com>
Date: Fri, 26 Jun 2026 15:04:10 +0200
Message-ID: <87fr29zc51.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Anonymous monitors (e.g., '-monitor stdio' or GDB stub) leave their 'id'
> field as NULL.

What "'id' field" do you mean here?

>                To allow downstream subsystems (like iothread tracking) to
> identify these instances later, the initialization paths must propagate
> the context.
>
> Refactor monitor_data_init() to accept the 'id' parameters, and
> update all internal QMP/HMP paths to pass these identifiers.
>
> For anonymous monitors, 'mon->id' remains NULL at this stage to avoid
> namespace pollution, setting up infrastructure for subsequent patches.

What's an "anonymous monitor"?

If it's a monitor without an ID, the sentence is a tautology.  What
information are you trying to convey?  That the new @id member may be
null?

> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  chardev/char.c             | 2 +-
>  gdbstub/system.c           | 3 ++-
>  include/monitor/monitor.h  | 5 +++--
>  monitor/hmp.c              | 5 +++--
>  monitor/monitor-internal.h | 4 +++-
>  monitor/monitor.c          | 9 ++++++---
>  monitor/qmp-cmds.c         | 2 +-
>  monitor/qmp.c              | 5 +++--
>  stubs/monitor-internal.c   | 3 ++-
>  9 files changed, 24 insertions(+), 14 deletions(-)
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

This creates an HMP monitor connected to a "multiplexed" character
device ("mux=on").  This is an old, poorly documented feature.

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

This creates a monitor connected to gdbstub's "chardev-gdb" character
device.  I'm not sure this is actually an HMP monitor.

>      } else {
>          qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
>          mon_chr = gdbserver_system_state.mon_chr;
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 55649a8664..4a5eb20bea 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -19,8 +19,9 @@ bool monitor_cur_is_qmp(void);
>  
>  void monitor_init_globals(void);
>  void monitor_init_globals_core(void);
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp);
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp);
> +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp);

Break the line before Error, please.

> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp);

I'd add the @id parameter before the flags.  Same for
monitor_data_init().

>  int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_init_opts(QemuOpts *opts, Error **errp);
>  void monitor_cleanup(void);
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index cc4390486e..4ee8cb58d1 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1522,7 +1522,8 @@ static void monitor_readline_flush(void *opaque)
>      monitor_flush(&mon->common);
>  }
>  
> -void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp)
>  {
>      MonitorHMP *mon = g_new0(MonitorHMP, 1);
>  
> @@ -1531,7 +1532,7 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
>          return;
>      }
>  
> -    monitor_data_init(&mon->common, false, false, false);
> +    monitor_data_init(&mon->common, false, false, false, id);
>  
>      mon->use_readline = use_readline;
>      if (mon->use_readline) {
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index a5c4aba306..f651ba6a90 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -108,6 +108,8 @@ struct Monitor {
>      bool skip_flush;
>      bool use_io_thread;
>  
> +    char *id;
> +
>      char *mon_cpu_path;
>      QTAILQ_ENTRY(Monitor) entry;
>  
> @@ -179,7 +181,7 @@ extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
>  
>  void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> -                       bool use_io_thread);
> +                       bool use_io_thread, const char *id);
>  void monitor_data_destroy(Monitor *mon);
>  int monitor_can_read(void *opaque);
>  void monitor_list_append(Monitor *mon);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 00b93ed612..65749f931e 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -608,8 +608,10 @@ static void monitor_iothread_init(void)
>  }
>  
>  void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> -                       bool use_io_thread)
> +                       bool use_io_thread, const char *id)
>  {
> +    mon->id = id ? g_strdup(id) : NULL;

g_strdup(NULL) returns NULL.  Simplify:

       mon->id = g_strdup(id);

> +
>      if (use_io_thread && !mon_iothread) {
>          monitor_iothread_init();
>      }
> @@ -629,6 +631,7 @@ void monitor_data_destroy(Monitor *mon)
>      } else {
>          readline_free(container_of(mon, MonitorHMP, common)->rs);
>      }
> +    g_free(mon->id);
>      g_string_free(mon->outbuf, true);
>      qemu_mutex_destroy(&mon->mon_lock);
>  }
> @@ -732,7 +735,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>  
>      switch (opts->mode) {
>      case MONITOR_MODE_CONTROL:
> -        monitor_init_qmp(chr, opts->pretty, errp);
> +        monitor_init_qmp(chr, opts->pretty, opts->id, errp);

This creates a QMP monitor on behalf of -mon or one of the convenience
options.

For -mon, opts->id comes from the command line, and may be null.

For the convenience options, opts->id is made up by the system.

>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> @@ -743,7 +746,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>              error_setg(errp, "'pretty' is not compatible with HMP monitors");
>              return -1;
>          }
> -        monitor_init_hmp(chr, true, errp);
> +        monitor_init_hmp(chr, true, opts->id, errp);

Likewise, HMP.

>          break;
>      default:
>          g_assert_not_reached();
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 0c409c27dc..e49b9cbf8b 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      char *output = NULL;
>      MonitorHMP hmp = {};
>  
> -    monitor_data_init(&hmp.common, false, true, false);
> +    monitor_data_init(&hmp.common, false, true, false, NULL);

This sets up a dummy HMP monitor not connected to anything.

>  
>      if (has_cpu_index) {
>          int ret = monitor_set_cpu(&hmp.common, cpu_index);
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 687019811f..8fd71386e8 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -513,7 +513,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
>      monitor_list_append(&mon->common);
>  }
>  
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> +void monitor_init_qmp(Chardev *chr, bool pretty, const char *id, Error **errp)
>  {
>      MonitorQMP *mon = g_new0(MonitorQMP, 1);
>  
> @@ -525,7 +525,8 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
>  
>      /* Note: we run QMP monitor in I/O thread when @chr supports that */
>      monitor_data_init(&mon->common, true, false,
> -                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
> +                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT),
> +                      id);
>  
>      mon->pretty = pretty;
>  
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

Things the commit message should make clear, but doesn't:

* This patch adds member @id to struct Monitor.  It is initialized, but
  not yet used.

* If the monitor is created on behalf of CLI option -mon, then @id is
  the value of -mon's parameter "id" if present, null if absent.

* If the monitor is created on behalf of CLI convenience options, then
  @id is some made-up string.

* If the monitor is created in any other way, then @id is null.

Please rework your commit message accordingly.


