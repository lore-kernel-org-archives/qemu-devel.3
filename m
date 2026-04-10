Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952EFF45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 21:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBJ2l-0007x2-88; Fri, 10 Apr 2026 17:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wBJ2j-0007w7-R8; Fri, 10 Apr 2026 17:05:33 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wBJ2h-00034T-7l; Fri, 10 Apr 2026 17:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=t1Gf3E0eM1kvaubS45tIjqLZ3+nomW/VrDrQ8pcjq6Y=; b=ezz/GGlojV8cFijg
 sk/JDXC5URd2YbURQY5EQ8igS3uWCCxXY6ldAZmtLUsJCPjVAmLmL/4mYcLkpy+9v/3FNruX7QqqQ
 c7vs2vbFVWjHQNUR83LgLR5FKTJthG+Aoky1KH94+HFjllyqGgh8fLfLe7nY/UyQQP+mcz5FJjIrk
 G/XmFhi4F3lKbtg2804zr/J1Mus+ky66mKTJdvW2ZBRUhmSqYMm3/GsxRT76N1FVROJHrSYN05MpF
 lyluhFiJ8Vi9BBW70aoaywHlFkSx3SLoi94LLp/vuNz7tqL66bREKmZ6dGfudkjoHOkHW8Nev+B8b
 jcRWAW+Ge0rxgr6/TQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wBJ2e-00000007YRF-27cF;
 Fri, 10 Apr 2026 21:05:28 +0000
Date: Fri, 10 Apr 2026 21:05:28 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 01/17] monitor: replace 'common' with 'parent' in
 MonitorHMP
Message-ID: <adlmGLnpW9PF17ZS@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-2-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 21:05:05 up 28 days, 22:18,  2 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> The field name 'parent' is standard practice for QOM structs
> so align the HMP monitor.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Just a rename, fine;

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/hmp-cmds.c         |  2 +-
>  monitor/hmp.c              | 40 +++++++++++++++++++-------------------
>  monitor/monitor-internal.h |  2 +-
>  monitor/monitor.c          |  6 +++---
>  monitor/qmp-cmds.c         | 10 +++++-----
>  ui/ui-hmp-cmds.c           |  2 +-
>  6 files changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index bc26b39d70..911d984cbe 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -236,7 +236,7 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
>  
>  void hmp_info_history(Monitor *mon, const QDict *qdict)
>  {
> -    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
>      int i;
>      const char *str;
>  
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 0e5913fabb..af346d190b 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -47,9 +47,9 @@ static void monitor_command_cb(void *opaque, const char *cmdline,
>  {
>      MonitorHMP *mon = opaque;
>  
> -    monitor_suspend(&mon->common);
> +    monitor_suspend(&mon->parent);
>      handle_hmp_command(mon, cmdline);
> -    monitor_resume(&mon->common);
> +    monitor_resume(&mon->parent);
>  }
>  
>  void monitor_read_command(MonitorHMP *mon, int show_prompt)
> @@ -72,7 +72,7 @@ int monitor_read_password(MonitorHMP *mon, ReadLineFunc *readline_func,
>          /* prompt is printed on return from the command handler */
>          return 0;
>      } else {
> -        monitor_printf(&mon->common,
> +        monitor_printf(&mon->parent,
>                         "terminal does not support password prompting\n");
>          return -ENOTTY;
>      }
> @@ -689,7 +689,7 @@ static const HMPCommand *monitor_parse_command(MonitorHMP *hmp_mon,
>                                                 const char **cmdp,
>                                                 HMPCommand *table)
>  {
> -    Monitor *mon = &hmp_mon->common;
> +    Monitor *mon = &hmp_mon->parent;
>      const char *p;
>      const HMPCommand *cmd;
>      char cmdname[256];
> @@ -1182,35 +1182,35 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>  
>      if (!cmd->cmd && !cmd->cmd_info_hrt) {
>          /* FIXME: is it useful to try autoload modules here ??? */
> -        monitor_printf(&mon->common, "Command \"%.*s\" is not available.\n",
> +        monitor_printf(&mon->parent, "Command \"%.*s\" is not available.\n",
>                         (int)(cmdline - cmd_start), cmd_start);
>          return;
>      }
>  
> -    qdict = monitor_parse_arguments(&mon->common, &cmdline, cmd);
> +    qdict = monitor_parse_arguments(&mon->parent, &cmdline, cmd);
>      if (!qdict) {
>          while (cmdline > cmd_start && qemu_isspace(cmdline[-1])) {
>              cmdline--;
>          }
> -        monitor_printf(&mon->common, "Try \"help %.*s\" for more information\n",
> +        monitor_printf(&mon->parent, "Try \"help %.*s\" for more information\n",
>                         (int)(cmdline - cmd_start), cmd_start);
>          return;
>      }
>  
>      if (!cmd->coroutine) {
>          /* old_mon is non-NULL when called from qmp_human_monitor_command() */
> -        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
> -        handle_hmp_command_exec(&mon->common, cmd, qdict);
> +        Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->parent);
> +        handle_hmp_command_exec(&mon->parent, cmd, qdict);
>          monitor_set_cur(qemu_coroutine_self(), old_mon);
>      } else {
>          HandleHmpCommandCo data = {
> -            .mon = &mon->common,
> +            .mon = &mon->parent,
>              .cmd = cmd,
>              .qdict = qdict,
>              .done = false,
>          };
>          Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
> -        monitor_set_cur(co, &mon->common);
> +        monitor_set_cur(co, &mon->parent);
>          aio_co_enter(qemu_get_aio_context(), co);
>          AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
>      }
> @@ -1428,7 +1428,7 @@ cleanup:
>  
>  static void monitor_read(void *opaque, const uint8_t *buf, int size)
>  {
> -    MonitorHMP *mon = container_of(opaque, MonitorHMP, common);
> +    MonitorHMP *mon = container_of(opaque, MonitorHMP, parent);
>      int i;
>  
>      if (mon->rs) {
> @@ -1437,7 +1437,7 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
>          }
>      } else {
>          if (size == 0 || buf[size - 1] != 0) {
> -            monitor_printf(&mon->common, "corrupted command\n");
> +            monitor_printf(&mon->parent, "corrupted command\n");
>          } else {
>              handle_hmp_command(mon, (char *)buf);
>          }
> @@ -1506,26 +1506,26 @@ static void G_GNUC_PRINTF(2, 3) monitor_readline_printf(void *opaque,
>      MonitorHMP *mon = opaque;
>      va_list ap;
>      va_start(ap, fmt);
> -    monitor_vprintf(&mon->common, fmt, ap);
> +    monitor_vprintf(&mon->parent, fmt, ap);
>      va_end(ap);
>  }
>  
>  static void monitor_readline_flush(void *opaque)
>  {
>      MonitorHMP *mon = opaque;
> -    monitor_flush(&mon->common);
> +    monitor_flush(&mon->parent);
>  }
>  
>  void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
>  {
>      MonitorHMP *mon = g_new0(MonitorHMP, 1);
>  
> -    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
> +    if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
>          g_free(mon);
>          return;
>      }
>  
> -    monitor_data_init(&mon->common, false, false, false);
> +    monitor_data_init(&mon->parent, false, false, false);
>  
>      mon->use_readline = use_readline;
>      if (mon->use_readline) {
> @@ -1536,9 +1536,9 @@ void monitor_init_hmp(Chardev *chr, bool use_readline, Error **errp)
>          monitor_read_command(mon, 0);
>      }
>  
> -    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read, monitor_read,
> -                             monitor_event, NULL, &mon->common, NULL, true);
> -    monitor_list_append(&mon->common);
> +    qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read, monitor_read,
> +                             monitor_event, NULL, &mon->parent, NULL, true);
> +    monitor_list_append(&mon->parent);
>  }
>  
>  /**
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index feca111ae3..ae0cf8c1da 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -119,7 +119,7 @@ struct Monitor {
>  };
>  
>  struct MonitorHMP {
> -    Monitor common;
> +    Monitor parent;
>      bool use_readline;
>      /*
>       * State used only in the thread "owning" the monitor.
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 00b93ed612..6532796edb 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -132,7 +132,7 @@ static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
>          return false;
>      }
>  
> -    return !monitor_uses_readline(container_of(mon, MonitorHMP, common));
> +    return !monitor_uses_readline(container_of(mon, MonitorHMP, parent));
>  }
>  
>  static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
> @@ -542,7 +542,7 @@ static void monitor_accept_input(void *opaque)
>  
>      qemu_mutex_lock(&mon->mon_lock);
>      if (!monitor_is_qmp(mon) && mon->reset_seen) {
> -        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
>          assert(hmp_mon->rs);
>          readline_restart(hmp_mon->rs);
>          qemu_mutex_unlock(&mon->mon_lock);
> @@ -627,7 +627,7 @@ void monitor_data_destroy(Monitor *mon)
>      if (monitor_is_qmp(mon)) {
>          monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
>      } else {
> -        readline_free(container_of(mon, MonitorHMP, common)->rs);
> +        readline_free(container_of(mon, MonitorHMP, parent)->rs);
>      }
>      g_string_free(mon->outbuf, true);
>      qemu_mutex_destroy(&mon->mon_lock);
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index 0c409c27dc..191eba1b3a 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -168,10 +168,10 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      char *output = NULL;
>      MonitorHMP hmp = {};
>  
> -    monitor_data_init(&hmp.common, false, true, false);
> +    monitor_data_init(&hmp.parent, false, true, false);
>  
>      if (has_cpu_index) {
> -        int ret = monitor_set_cpu(&hmp.common, cpu_index);
> +        int ret = monitor_set_cpu(&hmp.parent, cpu_index);
>          if (ret < 0) {
>              error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
>                         "a CPU number");
> @@ -181,12 +181,12 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>  
>      handle_hmp_command(&hmp, command_line);
>  
> -    WITH_QEMU_LOCK_GUARD(&hmp.common.mon_lock) {
> -        output = g_strdup(hmp.common.outbuf->str);
> +    WITH_QEMU_LOCK_GUARD(&hmp.parent.mon_lock) {
> +        output = g_strdup(hmp.parent.outbuf->str);
>      }
>  
>  out:
> -    monitor_data_destroy(&hmp.common);
> +    monitor_data_destroy(&hmp.parent);
>      return output;
>  }
>  
> diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
> index 6c93d452c9..fe89632474 100644
> --- a/ui/ui-hmp-cmds.c
> +++ b/ui/ui-hmp-cmds.c
> @@ -341,7 +341,7 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
>          return;
>      }
>      if (!arg) {
> -        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> +        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
>          monitor_read_password(hmp_mon, hmp_change_read_arg, NULL);
>      } else {
>          qmp_change_vnc_password(arg, errp);
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

