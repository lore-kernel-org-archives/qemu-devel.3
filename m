Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF12E93808
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 01:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC69w-0004Nb-0V; Sun, 12 Apr 2026 21:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wC69t-0004N2-Kc; Sun, 12 Apr 2026 21:32:13 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1wC69s-0006sw-3V; Sun, 12 Apr 2026 21:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=PtKBHD8ST23EDcZlBrffJ9XaQVErETUQDeqR/FP5qjo=; b=b//IppyA1xOPLvXw
 jh744kydSgbY6VYm9rEw9X1R/f5iJ40lAug/5AeZPkiU0OVC7ivE/DPfFhYCmT3cKHLWlipwKLPCg
 XYGYbmgoZjux2JrAQNNrlHk+7k2emOUhpajfc1APHPT5bNMTqn24Fch9Ablm20u/xRYPc6oX1zf+Y
 p0pM2wJivNb28YtgAyGCBWes6nANKZ71X0zC5Aek8K+Eisti5vZkKJq0UYzDLM7zETsJoSzmJLqi+
 Vc29kfZ/A0RZNtR0lb/zPcEdwS8ZeJfREgw/JbTSb0TjydVM5fUMAFy6uzOsnaVhpTxUxmFdizTV3
 HWNX3Jcr2FnlBkGJmQ==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1wC69q-00000007rtV-30Pr;
 Mon, 13 Apr 2026 01:32:10 +0000
Date: Mon, 13 Apr 2026 01:32:10 +0000
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
Subject: Re: [PATCH 07/17] monitor: use class methods for monitor_vprintf
Message-ID: <adxHmgyw1FJYkvQw@gallifrey>
References: <20260410160458.3778874-1-berrange@redhat.com>
 <20260410160458.3778874-8-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260410160458.3778874-8-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.74+deb13+1-amd64 (x86_64)
X-Uptime: 01:32:06 up 31 days,  2:45,  2 users,  load average: 0.01, 0.07, 0.05
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
>  monitor/hmp.c              | 12 ++++++++++++
>  monitor/monitor-internal.h |  3 +++
>  monitor/monitor.c          | 11 ++++-------
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 833de0eee8..3fe6f5715a 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -50,14 +50,26 @@ static void monitor_hmp_finalize(Object *obj)
>      readline_free(mon->rs);
>  }
>  
> +int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +    G_GNUC_PRINTF(2, 0);
> +
>  static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
>  {
> +    MonitorClass *moncls = MONITOR_CLASS(cls);
> +
> +    moncls->vprintf = monitor_hmp_vprintf;
>  }
>  
>  static void monitor_hmp_init(Object *obj)
>  {
>  }
>  
> +int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
> +{
> +    g_autofree char *buf = g_strdup_vprintf(fmt, ap);
> +    return monitor_puts(mon, buf);
> +}
> +
>  static void monitor_command_cb(void *opaque, const char *cmdline,
>                                 void *readline_opaque)
>  {
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 5bfe3b7325..3f05c46e88 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -95,6 +95,9 @@ typedef struct HMPCommand {
>  
>  struct MonitorClass {
>      ObjectClass parent_class;
> +
> +    int (*vprintf)(Monitor *mon, const char *fmt, va_list ap)
> +        G_GNUC_PRINTF(2, 0);
>  };
>  
>  struct Monitor {
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index f6c90145f6..b51046c0c9 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -243,21 +243,18 @@ int monitor_puts(Monitor *mon, const char *str)
>  
>  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
>  {
> -    char *buf;
> -    int n;
> +    MonitorClass *moncls;
>  
>      if (!mon) {
>          return -1;
>      }
>  
> -    if (monitor_is_qmp(mon)) {
> +    moncls = MONITOR_GET_CLASS(mon);
> +    if (!moncls->vprintf) {
>          return -1;
>      }
>  
> -    buf = g_strdup_vprintf(fmt, ap);
> -    n = monitor_puts(mon, buf);
> -    g_free(buf);
> -    return n;
> +    return moncls->vprintf(mon, fmt, ap);
>  }
>  
>  int monitor_printf(Monitor *mon, const char *fmt, ...)
> -- 
> 2.53.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

