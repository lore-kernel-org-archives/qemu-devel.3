Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6fM-00033e-Kp; Fri, 26 Jun 2026 09:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd6fI-000331-F8
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wd6fG-000660-C4
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782480732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7Ue6Q647Vu0aXCWDac8HaGCcTy523BmN3BYepxS7X9E=;
 b=GT0QVdYZ0DvAVOjNNUJ4/hKTsCzQLkZZMVRnt1+w1Q4EBF9wjakYBVvSG/skJ6MlL7chh+
 5EJMDwaCkYi7bMVkmomLSDIzL/A+RR4E07h/2zXZK8PNLnYLrD9hvCjoPy+19eUcqqZXlO
 DENBWo8n1wLJvWL5bUUX9Pn1F+J6ptU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-2NOrHsuLPG-bUi7rIfcfRg-1; Fri,
 26 Jun 2026 09:32:09 -0400
X-MC-Unique: 2NOrHsuLPG-bUi7rIfcfRg-1
X-Mimecast-MFC-AGG-ID: 2NOrHsuLPG-bUi7rIfcfRg_1782480727
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10F7B195421D; Fri, 26 Jun 2026 13:32:07 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A639630001A7; Fri, 26 Jun 2026 13:32:02 +0000 (UTC)
Date: Fri, 26 Jun 2026 14:31:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 06/17] monitor: refactor monitor_data_init() to pass ID
Message-ID: <aj5_T__4oqt41IWv@redhat.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-7-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624070851.13342-7-zhangckid@gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jun 24, 2026 at 03:08:40PM +0800, Zhang Chen wrote:
> Anonymous monitors (e.g., '-monitor stdio' or GDB stub) leave their 'id'
> field as NULL. To allow downstream subsystems (like iothread tracking) to
> identify these instances later, the initialization paths must propagate
> the context.
> 
> Refactor monitor_data_init() to accept the 'id' parameters, and
> update all internal QMP/HMP paths to pass these identifiers.
> 
> For anonymous monitors, 'mon->id' remains NULL at this stage to avoid
> namespace pollution, setting up infrastructure for subsequent patches.
> 
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

This patch will significantly conflict with my series that
creates QOM objects for the monitors. They will all be
guaranteed to have an "id" at that point though, which
addresses the problem you're trying to solve IIUC.

https://lists.gnu.org/archive/html/qemu-devel/2026-06/msg06427.html

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
> +void monitor_init_hmp(Chardev *chr, bool use_readline, const char *id,
> +                      Error **errp);
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
>          break;
>      case MONITOR_MODE_READLINE:
>          if (!allow_hmp) {
> @@ -743,7 +746,7 @@ int monitor_init(MonitorOptions *opts, bool allow_hmp, Error **errp)
>              error_setg(errp, "'pretty' is not compatible with HMP monitors");
>              return -1;
>          }
> -        monitor_init_hmp(chr, true, errp);
> +        monitor_init_hmp(chr, true, opts->id, errp);
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
> -- 
> 2.49.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


