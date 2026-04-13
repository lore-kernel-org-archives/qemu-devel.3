Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D806F34C6B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCLK9-0006qE-Iu; Mon, 13 Apr 2026 13:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wCLK7-0006pw-4b; Mon, 13 Apr 2026 13:43:47 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wCLK5-0005aM-3H; Mon, 13 Apr 2026 13:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=hJHQ+zco3nKsygBWmQoH8CPh3xvf+sntcrZZ9yMW7Ms=; b=XGDS0NnKTiCo9rOE
 CnZypXQ14ZLwocQdjn0TmAqnltFqXP5eaw35dt2uudqbWlW+/bWmjzlXHSSldzE6TqYKA7DrM3+do
 9kcYR5poTmi78nh39i2337cI2yRkPOg7FVZvQwjQPQBxv6N8ZQRwkM8SmkLks9tjHu3hDjqsfsRv0
 zpkzK4LsGWA2/c0BvwSowhwcg0lew6hC/2vWXL1Y4y5zB7ADNsgmISay+riO2qZmRiWNtZpP/BgYn
 w/ILUkdtciK5kP9TCo1JEcFgAPxoetW5qmtbszuv706QRLTl5K+McqhXnF/PeiWcbFwUBiqueLeXV
 Z2pzb+b3aAjVnpCKIQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wCLK2-000000083LT-2E96;
 Mon, 13 Apr 2026 17:43:42 +0000
Date: Mon, 13 Apr 2026 17:43:42 +0000
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
Subject: Re: [PATCH 09/17] monitor: use class methods for monitor_accept_input
Message-ID: <ad0rTh493HFAxS0d@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-10-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-10-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 17:43:38 up 31 days, 18:57,  2 users,  load average: 0.00, 0.01, 0.00
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
> This removes the need for using monitor_is_qmp() to check the
> subclass type, which is an anti-pattern.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/hmp.c              | 16 ++++++++++++++++
>  monitor/monitor-internal.h |  1 +
>  monitor/monitor.c          | 12 +++---------
>  3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 3fe6f5715a..5f9373a87b 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -52,12 +52,14 @@ static void monitor_hmp_finalize(Object *obj)
>  
>  int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
>      G_GNUC_PRINTF(2, 0);
> +static void monitor_hmp_accept_input(Monitor *mon);
>  
>  static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
>  {
>      MonitorClass *moncls = MONITOR_CLASS(cls);
>  
>      moncls->vprintf = monitor_hmp_vprintf;
> +    moncls->accept_input = monitor_hmp_accept_input;
>  }
>  
>  static void monitor_hmp_init(Object *obj)
> @@ -70,6 +72,20 @@ int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
>      return monitor_puts(mon, buf);
>  }
>  
> +static void monitor_hmp_accept_input(Monitor *mon)
> +{
> +    qemu_mutex_lock(&mon->mon_lock);
> +    if (mon->reset_seen) {
> +        MonitorHMP *hmp = MONITOR_HMP(mon);
> +        assert(hmp->rs);
> +        readline_restart(hmp->rs);
> +        qemu_mutex_unlock(&mon->mon_lock);
> +        readline_show_prompt(hmp->rs);
> +    } else {
> +        qemu_mutex_unlock(&mon->mon_lock);
> +    }
> +}
> +
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque)
>  {
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 4b5e708f14..7004f5d002 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -99,6 +99,7 @@ struct MonitorClass {
>      int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
>          G_GNUC_PRINTF(2, 0);
>      void (*emit_event)(Monitor *mon, QAPIEvent event, QDict *qdict);
> +    void (*accept_input)(Monitor *mon);
>  };
>  
>  struct Monitor {
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 5f55d33476..1326069b79 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -557,16 +557,10 @@ int monitor_suspend(Monitor *mon)
>  static void monitor_accept_input(void *opaque)
>  {
>      Monitor *mon = opaque;
> +    MonitorClass *cls = MONITOR_GET_CLASS(mon);
>  
> -    qemu_mutex_lock(&mon->mon_lock);
> -    if (!monitor_is_qmp(mon) && mon->reset_seen) {
> -        MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, parent);
> -        assert(hmp_mon->rs);
> -        readline_restart(hmp_mon->rs);
> -        qemu_mutex_unlock(&mon->mon_lock);
> -        readline_show_prompt(hmp_mon->rs);
> -    } else {
> -        qemu_mutex_unlock(&mon->mon_lock);
> +    if (cls->accept_input) {
> +        cls->accept_input(mon);
>      }
>  
>      qemu_chr_fe_accept_input(&mon->chr);
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

