Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD202F531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQ4Q-0000cP-EL; Mon, 13 Apr 2026 18:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wCQ4F-0000aR-86; Mon, 13 Apr 2026 18:47:46 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wCQ4D-0000Rc-8C; Mon, 13 Apr 2026 18:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=dPeixRmjbMbik0WnhUVF88u4/q6R7HCPcA54F6D+VTw=; b=Lz5Z4CfOBKG6P2m6
 pLV8eY0QzYJTOmA5FTtC38ZclF3pbHVuG4tioAUot/pjkjSNNSpJ4EUA3LXXJ/L4S5XeQjUG8hVhr
 1VUr1QjcOv4v6hFksjkyEb7V0R9j55nA22HFHTVPZ6iqthPWrd6JQqlI3Giq0yeRqR/rYMrRi1Mk4
 pepDeM5hS4Pnj8Uwh1xnG3ZLcFuepvyBumekEK0h/g4HyO2nCog7T82oAshdDfM1GaESW1do0usZu
 lqilJi66axMk7IGV5fCBqGYwG0dbR4fbZR4lMybAZloYnp8823K/sXQT01fupB1HVU/n8P/UAQq0F
 Il7qaqkmiogk5feO3A==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wCQ4A-000000086mE-1Ckv;
 Mon, 13 Apr 2026 22:47:38 +0000
Date: Mon, 13 Apr 2026 22:47:38 +0000
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
Subject: Re: [PATCH 16/17] monitor: eliminate monitor_is_hmp_non_interactive
 method
Message-ID: <ad1yisSWpU2TZt5_@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-17-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-17-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 22:47:34 up 32 days, 0 min,  2 users,  load average: 0.00, 0.01, 0.00
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
> The monitor_is_hmp_non_interactive method is used by
> monitor_suspend and monitor_resume, to make them a no-op
> if the HMP does not use readline.
> 
> There are only a handful of callers of suspend/resume and
> they can be made to skip the call with readline is not
> present.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  include/monitor/monitor.h      |  2 +-
>  migration/migration-hmp-cmds.c |  5 ++++-
>  monitor/hmp-cmds.c             |  5 ++++-
>  monitor/hmp.c                  | 14 +++++++++-----
>  monitor/monitor-internal.h     |  1 -
>  monitor/monitor.c              | 30 +-----------------------------
>  6 files changed, 19 insertions(+), 38 deletions(-)
> 
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index f66e465775..52df053c6d 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -34,7 +34,7 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
>  int monitor_new_opts(QemuOpts *opts, Error **errp);
>  void monitor_cleanup(void);
>  
> -int monitor_suspend(Monitor *mon);
> +void monitor_suspend(Monitor *mon);
>  void monitor_resume(Monitor *mon);
>  
>  int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp);
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 0a193b8f54..e9bb970b20 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -18,6 +18,7 @@
>  #include "migration/snapshot.h"
>  #include "monitor/hmp.h"
>  #include "monitor/monitor.h"
> +#include "monitor/monitor-internal.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-migration.h"
>  #include "qapi/qapi-visit-migration.h"
> @@ -836,12 +837,14 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>  
>      if (!detach) {
>          HMPMigrationStatus *status;
> +        MonitorHMP *hmp = MONITOR_HMP(mon);
>  
> -        if (monitor_suspend(mon) < 0) {
> +        if (!hmp->rs) {
>              monitor_printf(mon, "terminal does not allow synchronous "
>                             "migration, continuing detached\n");
>              return;
>          }
> +        monitor_suspend(mon);
>  
>          status = g_malloc0(sizeof(*status));
>          status->mon = mon;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 911d984cbe..a6314c1159 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -90,7 +90,10 @@ void hmp_info_version(Monitor *mon, const QDict *qdict)
>  
>  void hmp_quit(Monitor *mon, const QDict *qdict)
>  {
> -    monitor_suspend(mon);
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
> +    if (hmp->rs) {
> +        monitor_suspend(mon);
> +    }
>      qmp_quit(NULL);
>  }
>  
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 5f9373a87b..387dab2567 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1491,13 +1491,16 @@ static void monitor_read(void *opaque, const uint8_t *buf, int size)
>  static void monitor_event(void *opaque, QEMUChrEvent event)
>  {
>      Monitor *mon = opaque;
> +    MonitorHMP *hmp = MONITOR_HMP(mon);
>  
>      switch (event) {
>      case CHR_EVENT_MUX_IN:
>          qemu_mutex_lock(&mon->mon_lock);
>          if (mon->mux_out) {
>              mon->mux_out = 0;
> -            monitor_resume(mon);
> +            if (hmp->rs) {
> +                monitor_resume(mon);
> +            }
>          }
>          qemu_mutex_unlock(&mon->mon_lock);
>          break;
> @@ -1510,7 +1513,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
>              } else {
>                  monitor_flush_locked(mon);
>              }
> -            monitor_suspend(mon);
> +            if (hmp->rs) {
> +                monitor_suspend(mon);
> +            }
>              mon->mux_out = 1;
>          }
>          qemu_mutex_unlock(&mon->mon_lock);
> @@ -1521,7 +1526,7 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
>                         "information\n", QEMU_VERSION);
>          qemu_mutex_lock(&mon->mon_lock);
>          mon->reset_seen = 1;
> -        if (!mon->mux_out) {
> +        if (!mon->mux_out && hmp->rs) {
>              /* Suspend-resume forces the prompt to be printed.  */
>              monitor_suspend(mon);
>              monitor_resume(mon);
> @@ -1569,8 +1574,7 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
>          return;
>      }
>  
> -    mon->use_readline = use_readline;
> -    if (mon->use_readline) {
> +    if (use_readline) {
>          mon->rs = readline_init(monitor_readline_printf,
>                                  monitor_readline_flush,
>                                  mon,
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index d40fdde793..7557deb978 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -133,7 +133,6 @@ struct MonitorHMPClass {
>  
>  struct MonitorHMP {
>      Monitor parent;
> -    bool use_readline;
>      /*
>       * State used only in the thread "owning" the monitor.
>       * If @use_io_thread, this is @mon_iothread. (This does not actually happen
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index f48603a7e8..3860486a32 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -130,25 +130,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>      return old_monitor;
>  }
>  
> -/**
> - * Is @mon is using readline?
> - * Note: not all HMP monitors use readline, e.g., gdbserver has a
> - * non-interactive HMP monitor, so readline is not used there.
> - */
> -static inline bool monitor_uses_readline(const MonitorHMP *mon)
> -{
> -    return mon->use_readline;
> -}
> -
> -static inline bool monitor_is_hmp_non_interactive(const Monitor *mon)
> -{
> -    if (!object_dynamic_cast(OBJECT(mon), TYPE_MONITOR_HMP)) {
> -        return false;
> -    }
> -
> -    return !monitor_uses_readline(container_of(mon, MonitorHMP, parent));
> -}
> -
>  static gboolean monitor_unblocked(void *do_not_use, GIOCondition cond,
>                                    void *opaque)
>  {
> @@ -523,12 +504,8 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>      return TRUE;
>  }
>  
> -int monitor_suspend(Monitor *mon)
> +void monitor_suspend(Monitor *mon)
>  {
> -    if (monitor_is_hmp_non_interactive(mon)) {
> -        return -ENOTTY;
> -    }
> -
>      qatomic_inc(&mon->suspend_cnt);
>  
>      if (mon->use_io_thread) {
> @@ -540,7 +517,6 @@ int monitor_suspend(Monitor *mon)
>      }
>  
>      trace_monitor_suspend(mon, 1);
> -    return 0;
>  }
>  
>  static void monitor_accept_input(void *opaque)
> @@ -557,10 +533,6 @@ static void monitor_accept_input(void *opaque)
>  
>  void monitor_resume(Monitor *mon)
>  {
> -    if (monitor_is_hmp_non_interactive(mon)) {
> -        return;
> -    }
> -
>      if (qatomic_dec_fetch(&mon->suspend_cnt) == 0) {
>          AioContext *ctx;
>  
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

