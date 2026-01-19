Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F4C9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 02:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhedT-0008RU-BE; Sun, 18 Jan 2026 21:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vhedR-0008Nr-HI
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 21:04:53 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1vhedP-0001hr-TE
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 21:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=JIOZ1ohXqljoQjLBzEg3J0qXYzXOIV8CWHsrTELYhpU=; b=qK1cLySpzTQyX0Q/
 tpEClWhZRF1ekxgT+V/ixDBzuf+7KlngMBN+YMjO4Jr2fh8b0x2UMLs12YGWix5ZOAKiqrEk4WYOv
 DUdn1jzyg1uy5DtXM79ahqa39V8w+V1sj3WS5zM0gbZX8/DlPdbT37953Hvo2bF7KnnRvGrvZJLTt
 ZZLuuxISA2IxFCdROQ83SKg85cJ2Oe/2ZZ/eOJB1DbbtUziNE7ysVg6+etSBdmyrvKvg0vB7ksQnq
 tJUMdWrVM7i06NXu3AoIId5bAXH0gsnXa0cdAlkl6JI+x52TQPXpL8n7rMGrYQYrWeB/BAAzLE6DF
 Oolch2b/VOmXAqQyjg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vhedO-0000000Ff9J-3ZL2;
 Mon, 19 Jan 2026 02:04:50 +0000
Date: Mon, 19 Jan 2026 02:04:50 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/8] monitor: Add hmp_cmds_for_target() helper
Message-ID: <aW2RQiEjLggkuK7-@gallifrey>
References: <20260117162926.74225-1-philmd@linaro.org>
 <20260117162926.74225-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117162926.74225-3-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 02:04:32 up 84 days,  1:40,  3 users,  load average: 0.11, 0.05, 0.02
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

* Philippe Mathieu-Daudé (philmd@linaro.org) wrote:
> HMPCommand arrays are filled with target-specific
> commands, so defined in a target-specific unit.
> Introduce the hmp_cmds_for_target() to allow
> target-agnostic code to access the arrays.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  monitor/monitor-internal.h |  9 +++++++--
>  monitor/hmp-target.c       | 13 ++++++++-----
>  monitor/hmp.c              |  8 +++++---
>  3 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 7735c731083..feca111ae31 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -169,8 +169,6 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
>  
> -extern HMPCommand hmp_cmds[];
> -
>  void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
>                         bool use_io_thread);
>  void monitor_data_destroy(Monitor *mon);
> @@ -187,4 +185,11 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
>  void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
>  int hmp_compare_cmd(const char *name, const char *list);
>  
> +/*
> + * hmp_cmds_for_target: Return array of HMPCommand entries
> + *
> + * If @info_command is true, return the particular 'info foo' commands array.
> + */
> +HMPCommand *hmp_cmds_for_target(bool info_command);
> +
>  #endif
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 37dfd7fd4c6..59c60d13b52 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -44,8 +44,6 @@
>  /* Make devices configuration available for use in hmp-commands*.hx templates */
>  #include CONFIG_DEVICES
>  
> -static HMPCommand hmp_info_cmds[];
> -
>  /**
>   * Is @name in the '|' separated list of names @list?
>   */
> @@ -76,11 +74,16 @@ static HMPCommand hmp_info_cmds[] = {
>  };
>  
>  /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
> -HMPCommand hmp_cmds[] = {
> +static HMPCommand hmp_cmds[] = {
>  #include "hmp-commands.h"
>      { NULL, NULL, },
>  };
>  
> +HMPCommand *hmp_cmds_for_target(bool info_command)
> +{
> +    return info_command ? hmp_info_cmds : hmp_cmds;
> +}
> +
>  /*
>   * Set @pval to the value in the register identified by @name.
>   * return 0 if OK, -1 if not found
> @@ -148,7 +151,7 @@ static void __attribute__((__constructor__)) sortcmdlist(void)
>  void monitor_register_hmp(const char *name, bool info,
>                            void (*cmd)(Monitor *mon, const QDict *qdict))
>  {
> -    HMPCommand *table = info ? hmp_info_cmds : hmp_cmds;
> +    HMPCommand *table = hmp_cmds_for_target(info);
>  
>      while (table->name != NULL) {
>          if (strcmp(table->name, name) == 0) {
> @@ -164,7 +167,7 @@ void monitor_register_hmp(const char *name, bool info,
>  void monitor_register_hmp_info_hrt(const char *name,
>                                     HumanReadableText *(*handler)(Error **errp))
>  {
> -    HMPCommand *table = hmp_info_cmds;
> +    HMPCommand *table = hmp_cmds_for_target(true);
>  
>      while (table->name != NULL) {
>          if (strcmp(table->name, name) == 0) {
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 4caafbc7146..17e5756986f 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -301,7 +301,7 @@ void hmp_help_cmd(Monitor *mon, const char *name)
>      }
>  
>      /* 2. dump the contents according to parsed args */
> -    help_cmd_dump(mon, hmp_cmds, args, nb_args, 0);
> +    help_cmd_dump(mon, hmp_cmds_for_target(false), args, nb_args, 0);
>  
>      free_cmdline_args(args, nb_args);
>  }
> @@ -1131,7 +1131,8 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
>  
>      trace_handle_hmp_command(mon, cmdline);
>  
> -    cmd = monitor_parse_command(mon, cmdline, &cmdline, hmp_cmds);
> +    cmd = monitor_parse_command(mon, cmdline, &cmdline,
> +                                hmp_cmds_for_target(false));
>      if (!cmd) {
>          return;
>      }
> @@ -1375,7 +1376,8 @@ static void monitor_find_completion(void *opaque,
>      }
>  
>      /* 2. auto complete according to args */
> -    monitor_find_completion_by_table(mon, hmp_cmds, args, nb_args);
> +    monitor_find_completion_by_table(mon, hmp_cmds_for_target(false),
> +                                     args, nb_args);
>  
>  cleanup:
>      free_cmdline_args(args, nb_args);
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

