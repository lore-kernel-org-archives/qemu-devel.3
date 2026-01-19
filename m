Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7126EC9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdcl-0006au-35; Sun, 18 Jan 2026 20:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vhdcf-0006ZU-QC; Sun, 18 Jan 2026 20:00:01 -0500
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1vhdcd-0000Ou-M2; Sun, 18 Jan 2026 20:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=0WVsrv89xQbOrPpEsi89/WKphD/nzR7rKd+cQ6vy+kY=; b=bPM56RNZjhm7w/LK
 55+glE9a8Y0NK9R1K4jv0qJtDso3xxLDF1PIakM3EMcbOjOJIp+p9oHz1lNzJRhLE17Q76rrH/F7K
 xmmJbvQl7Los/ztXdLhnIyzT2JeO/J5g1F1xCY/0uT0jYUsCjMHLtVQr12tJlvsnjICGbO0/Bkd+R
 4Q91ocHsP9nCHNIxBE01NZm0TM48V/RRHyelb+w/s2EV0ralGkfsPZahoRoxtiRRplFWAQraY4Dgy
 u/jMNFaVBI5O8tB7E8oR52EYI4MkCdT3/NDW7zVRaf9DHVyaaHaXz/9TErQdo87QGQpPhG0bbga5N
 yDMURI8Rl10K8YhgSg==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1vhdcX-0000000FeqS-1FzG;
 Mon, 19 Jan 2026 00:59:53 +0000
Date: Mon, 19 Jan 2026 00:59:53 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2 4/8] monitor: Have MonitorDef::get_value() return an
 unsigned type
Message-ID: <aW2CCaZlpdPo31io@gallifrey>
References: <20260117162926.74225-1-philmd@linaro.org>
 <20260117162926.74225-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260117162926.74225-5-philmd@linaro.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.48+deb13-amd64 (x86_64)
X-Uptime: 00:58:49 up 84 days, 35 min,  2 users,  load average: 0.00, 0.00,
 0.00
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
> All implementations of the get_value() handler return an
> unsigned type:
> 
> - target/i386/monitor.c
> 
>   monitor_get_pc() -> target_ulong eip;
> 
> - target/ppc/ppc-qmp-cmds.c
> 
>   monitor_get_ccr() -> uint64_t ppc_get_cr(const CPUPPCState *env);
> 
>   monitor_get_xer() -> target_ulong cpu_read_xer(const CPUPPCState *env);
> 
>   monitor_get_decr() -> target_ulong cpu_ppc_load_decr(CPUPPCState *env);
> 
>   monitor_get_tbu() -> uint32_t cpu_ppc_load_tbu(CPUPPCState *env);
> 
>   monitor_get_tbl() -> uint64_t cpu_ppc_load_tbl(CPUPPCState *env);
> 
> - target/sparc/monitor.c
> 
>   monitor_get_psr() -> target_ulong cpu_get_psr(CPUSPARCState *env1);
> 
>   monitor_get_reg() -> target_ulong *regwptr;
> 
> Convert the MonitorDef::get_value() handler to return unsigned.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/monitor/hmp-target.h |  3 +--
>  monitor/hmp-target.c         |  8 ++++----
>  target/i386/monitor.c        |  4 ++--
>  target/ppc/ppc-qmp-cmds.c    | 25 +++++++++++--------------
>  target/sparc/monitor.c       |  8 ++++----
>  5 files changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> index b679aaebbff..bd9baeaa3ad 100644
> --- a/include/monitor/hmp-target.h
> +++ b/include/monitor/hmp-target.h
> @@ -32,8 +32,7 @@ typedef struct MonitorDef MonitorDef;
>  struct MonitorDef {
>      const char *name;
>      int offset;
> -    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
> -                             int val);
> +    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
>      int type;
>  };
>  #endif
> diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
> index 420969bd6eb..3fb4fb12508 100644
> --- a/monitor/hmp-target.c
> +++ b/monitor/hmp-target.c
> @@ -67,7 +67,6 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>  {
>      const MonitorDef *md = target_monitor_defs();
>      CPUState *cs = mon_get_cpu(mon);
> -    void *ptr;
>      uint64_t tmp = 0;
>      int ret;
>  
> @@ -81,13 +80,14 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
>                  *pval = md->get_value(mon, md, md->offset);
>              } else {
>                  CPUArchState *env = mon_get_cpu_env(mon);
> -                ptr = (uint8_t *)env + md->offset;
> +                void *ptr = (uint8_t *)env + md->offset;
> +
>                  switch(md->type) {
>                  case MD_I32:
> -                    *pval = *(int32_t *)ptr;
> +                    *pval = *(uint32_t *)ptr;
>                      break;
>                  case MD_TLONG:
> -                    *pval = *(target_long *)ptr;
> +                    *pval = *(target_ulong *)ptr;
>                      break;

So I think this patch does make sense, but it does feel a bit hideous
to have 'MD_I32' and 'MD_TLONG' as names for unsigneds.

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

>                  default:
>                      *pval = 0;
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index 99b32cb7b0f..cce23f987ef 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -593,8 +593,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
>      }
>  }
>  
> -static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> -                                  int val)
> +static uint64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
> +                               int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>      return env->eip + env->segs[R_CS].base;
> diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
> index 7022564604f..07938abb15f 100644
> --- a/target/ppc/ppc-qmp-cmds.c
> +++ b/target/ppc/ppc-qmp-cmds.c
> @@ -33,26 +33,23 @@
>  #include "cpu-models.h"
>  #include "cpu-qom.h"
>  
> -static target_long monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_ccr(Monitor *mon, const struct MonitorDef *md,
> +                               int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
> -    unsigned int u;
>  
> -    u = ppc_get_cr(env);
> -
> -    return u;
> +    return ppc_get_cr(env);
>  }
>  
> -static target_long monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_xer(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>      return cpu_read_xer(env);
>  }
>  
> -static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
> -                                    int val)
> +static uint64_t monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
> +                                 int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>      if (!env->tb_env) {
> @@ -61,8 +58,8 @@ static target_long monitor_get_decr(Monitor *mon, const struct MonitorDef *md,
>      return cpu_ppc_load_decr(env);
>  }
>  
> -static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>      if (!env->tb_env) {
> @@ -71,8 +68,8 @@ static target_long monitor_get_tbu(Monitor *mon, const struct MonitorDef *md,
>      return cpu_ppc_load_tbu(env);
>  }
>  
> -static target_long monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_tbl(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>      if (!env->tb_env) {
> diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
> index 73f15aa272d..3e1f4dd5c9c 100644
> --- a/target/sparc/monitor.c
> +++ b/target/sparc/monitor.c
> @@ -40,8 +40,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>  }
>  
>  #ifndef TARGET_SPARC64
> -static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>  
> @@ -49,8 +49,8 @@ static target_long monitor_get_psr(Monitor *mon, const struct MonitorDef *md,
>  }
>  #endif
>  
> -static target_long monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
> -                                   int val)
> +static uint64_t monitor_get_reg(Monitor *mon, const struct MonitorDef *md,
> +                                int val)
>  {
>      CPUArchState *env = mon_get_cpu_env(mon);
>      return env->regwptr[val];
> -- 
> 2.52.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

