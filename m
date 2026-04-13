Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC764E937E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 01:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC66D-0003fC-Ar; Sun, 12 Apr 2026 21:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wC669-0003er-Nf; Sun, 12 Apr 2026 21:28:21 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wC667-0005jG-3O; Sun, 12 Apr 2026 21:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=mf2gmiwYTaAAfCw01jy17/m2CBty+lUI4Fl6BoD39Gw=; b=DHGrwZyz++kxcfqq
 Mmwf1DI8LVajZh0QJtFX/aXUpD1NpOfuJd/0GujVifnSrnQEOZ0xmYfPopVPBNu2vFNOoJ/ZWB6AL
 zDNXTWeM1tJEQYzfq6lS4juW3ATBkbW3G5JFLLVQQ/19hG4VFhb4u8G3CAh7KGeeycQ0ByjEea334
 cH6qRa7SHb5njmwFYOhweeH/X46QBab6cS+Xv58PUFKLtqaV1MVi2Q3okFwlNQkALW5qnKRBfYE2A
 EOgOSUIuEtn9MlbevrEk6Div1y6iElXyXz8zt1XLDbdoEu6BYuCrrrwD9/PXyVY9sAduooYgOUWr9
 Xae2q9YU+X/rpICEnw==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wC661-00000007rno-2xil;
 Mon, 13 Apr 2026 01:28:13 +0000
Date: Mon, 13 Apr 2026 01:28:13 +0000
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
Subject: Re: [PATCH 05/17] monitor: remove 'skip_flush' field
Message-ID: <adxGrbCi4LfS0lsT@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-6-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 01:27:03 up 31 days,  2:40,  2 users,  load average: 0.08, 0.11, 0.05
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
> The 'skip_flush' field is set on the dummy throwaway HMP monitor
> object created by QMP's  'human-monitor-command', as an indication
> not to try to write data to the chardev. Instead the QMP command
> impl will grab the data straight out of the in-memory buffer.
> 
> The flag is redundant, however, as the monitor code could instead
> simply check the 'fe_is_open' field on the CharFrontend, which
> will be false in the same scenarios that 'skip_flush' is true.

For monitors on sockets where the other end isn't connected, does that
change the behaviour?   Does that also have !fe_is_open and can that hit this
case?

Dave

> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  monitor/hmp.c              |  2 +-
>  monitor/monitor-internal.h |  4 +---
>  monitor/monitor.c          | 11 +++++++----
>  monitor/qmp-cmds.c         |  2 +-
>  monitor/qmp.c              |  2 +-
>  5 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 614d9a3707..72f8303662 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1539,7 +1539,7 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>          return;
>      }
>  
> -    monitor_data_init(&mon->parent, false, false, false);
> +    monitor_data_init(&mon->parent, false, false);
>  
>      mon->use_readline = use_readline;
>      if (mon->use_readline) {
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 25320928a7..84117805b7 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -102,7 +102,6 @@ struct Monitor {
>      CharFrontend chr;
>      int suspend_cnt;            /* Needs to be accessed atomically */
>      bool is_qmp;
> -    bool skip_flush;
>      bool use_io_thread;
>  
>      char *mon_cpu_path;
> @@ -183,8 +182,7 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
>  
> -void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> -                       bool use_io_thread);
> +void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread);
>  void monitor_data_destroy(Monitor *mon);
>  int monitor_can_read(void *opaque);
>  void monitor_list_append(Monitor *mon);
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 7936e2ab22..f7e3708d2f 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -167,7 +167,12 @@ void monitor_flush_locked(Monitor *mon)
>      size_t len;
>      const char *buf;
>  
> -    if (mon->skip_flush) {
> +    /*
> +     * When used by QMP human-monitor-command, no chardev
> +     * will be connected, as we want to just collect the
> +     * output in the buffer
> +     */
> +    if (!mon->chr.fe_is_open) {
>          return;
>      }
>  
> @@ -621,8 +626,7 @@ static void monitor_iothread_init(void)
>      mon_iothread = iothread_create("mon_iothread", &error_abort);
>  }
>  
> -void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
> -                       bool use_io_thread)
> +void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread)
>  {
>      if (use_io_thread && !mon_iothread) {
>          monitor_iothread_init();
> @@ -630,7 +634,6 @@ void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>      qemu_mutex_init(&mon->mon_lock);
>      mon->is_qmp = is_qmp;
>      mon->outbuf = g_string_new(NULL);
> -    mon->skip_flush = skip_flush;
>      mon->use_io_thread = use_io_thread;
>  }
>  
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index d0ed241d6a..be2bd985b7 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -168,7 +168,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
>      char *output = NULL;
>      MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
>  
> -    monitor_data_init(&hmp->parent, false, true, false);
> +    monitor_data_init(&hmp->parent, false, false);
>  
>      if (has_cpu_index) {
>          int ret = monitor_set_cpu(&hmp->parent, cpu_index);
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index 36cb078f30..fe2aec9ce9 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -538,7 +538,7 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
>      qemu_chr_fe_set_echo(&mon->parent.chr, true);
>  
>      /* Note: we run QMP monitor in I/O thread when @chr supports that */
> -    monitor_data_init(&mon->parent, true, false,
> +    monitor_data_init(&mon->parent, true,
>                        qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
>  
>      mon->pretty = pretty;
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

