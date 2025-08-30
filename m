Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F530CA0FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 23:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usUYe-0003yS-48; Sat, 30 Aug 2025 19:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUYY-0003ww-UQ; Sat, 30 Aug 2025 19:00:24 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUYX-0006Cw-53; Sat, 30 Aug 2025 19:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=s2peyQe3P//sWNdGamIK7XkvxSqNIB5HGKwXFbfRwo0=; b=H61+a7TNdcrf4FLj
 uB1gWZuHK/JXhJEbWCURwdGxrT5mMGmAZ8fsxzfyrCIdc8JaOz8CJPXhOnKwWqwmRllrmlCCJ9oqW
 sRUIgVDu5mWtd0I0WVvnOnsW0pWA6r4+pTpSweFoj6U7w18F9zI7AM4jEp5jrpUk/U/5b1LuQjdA3
 CmqHep3L/8YioaLYoHYMD6S5odpVxbanxbk84hIwEnwZ0O2WNgEHC6EJMti9hDPQgyVd6qNTrw/Q9
 u+JGath4v0Diz9REwx2NZYIHJNzfCOXbkzTAiVO4C+Qceei4EkyxMyW+m7J8H9P2ftIDKnzglWNCo
 VkkFdJUVa9ryZUvVZA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1usUYV-007aUU-1W;
 Sat, 30 Aug 2025 23:00:19 +0000
Date: Sat, 30 Aug 2025 23:00:19 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 02/14] monitor: initialize global data from a
 constructor
Message-ID: <aLOCg9QUaJelsNf_@gallifrey>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829180354.2922145-3-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 22:59:51 up 125 days,  7:13,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
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
List-Id: <qemu-devel.nongnu.org>
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
> Some monitor functions, most notably, monitor_cur() rely on global
> data being initialized by 'monitor_init_globals()'. The latter is
> called relatively late in startup. If code triggers error_report()
> before monitor_init_globals() is called, QEMU will abort when
> accessing the uninitialized monitor mutex.
> 
> The critical monitor global data must be initialized from a
> constructor function, to improve the guarantee that it is done
> before any possible calls to monitor_cur(). Not only that, but
> the constructor must be marked to run before the default
> constructor in case any of them trigger error reporting.
> 
> Note in particular that the RCU constructor will spawn a background
> thread so we might even have non-constructor QEMU code running
> concurrently with other constructors.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Checked that qemu_mutex_init doesn't look like it can call
error code; so

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/monitor.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index c5a5d30877..da54e1b1ce 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -704,18 +704,22 @@ void monitor_cleanup(void)
>      }
>  }
>  
> -static void monitor_qapi_event_init(void)
> +/*
> + * Initialize static vars that have no deps on external
> + * module initialization, and are required for external
> + * functions to call things like monitor_cur()
> + */
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +monitor_init_static(void)
>  {
> +    qemu_mutex_init(&monitor_lock);
> +    coroutine_mon = g_hash_table_new(NULL, NULL);
>      monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
>                                                  qapi_event_throttle_equal);
>  }
>  
>  void monitor_init_globals(void)
>  {
> -    monitor_qapi_event_init();
> -    qemu_mutex_init(&monitor_lock);
> -    coroutine_mon = g_hash_table_new(NULL, NULL);
> -
>      /*
>       * The dispatcher BH must run in the main loop thread, since we
>       * have commands assuming that context.  It would be nice to get
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

