Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8025AC61CE8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 00:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOmXd-0003Ja-HA; Mon, 09 Jun 2025 20:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uOmXZ-0003JI-4y
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 20:08:33 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uOmXW-0008D0-NA
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 20:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Jf+69yxUohjXYnqAH/uiLPl08LjdjJG/uvMYzuYPlbQ=; b=rA7C9OSqtvwqJL8w
 dQHVHgF830e4/53atx0YAjXGet9GUF/WYrjm1h2y3n6uVmygOXJWJXMmGDL/ABH4Z8YIC7szV8pMo
 03vEQCOB9g2E5ZOM5TREIZGpB2JZCL+UpCZErBiyYU14fYnl4u7C6nguBaKQz+UzF5n8X4T5THpPN
 sXJsajNmdSHqPZIblRq5AasfyixGe53VdGY1jyksa+yyNDIkLxZ+v4VAgNium0SmTLxSBvcfffSLc
 qDkaWuvZb/T5W0qqv8Qhk5BCMjNXHL3/tteZS0+cmih9Ptpnq4A+1rzqq11YifuNqnAI9QGZkbjRL
 J3xm+ooO3jyZbQnYvA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uOmXP-008W1g-1O;
 Tue, 10 Jun 2025 00:08:23 +0000
Date: Tue, 10 Jun 2025 00:08:23 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aEd3d07hQYXWc4eq@gallifrey>
References: <20250609191259.9053-1-peterx@redhat.com>
 <20250609191259.9053-9-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250609191259.9053-9-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:05:28 up 43 days, 8:19, 1 user, load average: 0.00, 0.00, 0.00
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

* Peter Xu (peterx@redhat.com) wrote:
> Blocktime so far only cares about the time one vcpu (or the whole system)
> got blocked.  It would be also be helpful if it can also report the latency
> of page requests, which could be very sensitive during postcopy.
> 
> Blocktime itself is sometimes not very important, especially when one
> thinks about KVM async PF support, which means vCPUs are literally almost
> not blocked at all because the guest OS is smart enough to switch to
> another task when a remote fault is needed.
> 
> However, latency is still sensitive and important because even if the guest
> vCPU is running on threads that do not need a remote fault, the workload
> that accesses some missing page is still affected.
> 
> Add two entries to the report, showing how long it takes to resolve a
> remote fault.  Mention in the QAPI doc that this is not the real average
> fault latency, but only the ones that was requested for a remote fault.
> 
> Unwrap get_vcpu_blocktime_list() so we don't need to walk the list twice,
> meanwhile add the entry checks in qtests for all postcopy tests.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json                   | 13 +++++
>  migration/migration-hmp-cmds.c        | 68 ++++++++++++++++++---------
>  migration/postcopy-ram.c              | 48 +++++++++++++------
>  tests/qtest/migration/migration-qmp.c |  3 ++
>  4 files changed, 96 insertions(+), 36 deletions(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 4963f6ca12..e95b7402cb 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -236,6 +236,17 @@
>  #     This is only present when the postcopy-blocktime migration
>  #     capability is enabled.  (Since 3.0)
>  #
> +# @postcopy-latency: average remote page fault latency (in us).  Note that
> +#     this doesn't include all faults, but only the ones that require a
> +#     remote page request.  So it should be always bigger than the real
> +#     average page fault latency. This is only present when the
> +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> +#
> +# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
> +#     us).  It has the same definition of @postcopy-latency, but instead
> +#     this is the per-vCPU statistics.  This is only present when the
> +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)

I wonder if even 'us' is too big; given you have 64bits to play with, and your
examples show some samples landing in under 10us, perhaps it's best
to at least define the qapi  fields as ns, even if you keep with the same
buckets for now?

Dave

>  # @socket-address: Only used for tcp, to know what the real port is
>  #     (Since 4.0)
>  #
> @@ -275,6 +286,8 @@
>             '*blocked-reasons': ['str'],
>             '*postcopy-blocktime': 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> +           '*postcopy-latency': 'uint64',
> +           '*postcopy-vcpu-latency': ['uint64'],
>             '*socket-address': ['SocketAddress'],
>             '*dirty-limit-throttle-time-per-round': 'uint64',
>             '*dirty-limit-ring-full-time': 'uint64'} }
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 6c36e202a0..600b0f8071 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -52,6 +52,52 @@ static void migration_global_dump(Monitor *mon)
>                     ms->clear_bitmap_shift);
>  }
>  
> +static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
> +{
> +    if (info->has_postcopy_blocktime) {
> +        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
> +                       info->postcopy_blocktime);
> +    }
> +
> +    if (info->has_postcopy_vcpu_blocktime) {
> +        uint32List *item = info->postcopy_vcpu_blocktime;
> +        const char *sep = "";
> +        int count = 0;
> +
> +        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> +
> +        while (item) {
> +            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
> +            item = item->next;
> +            /* Each line 10 vcpu results, newline if there's more */
> +            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
> +        }
> +        monitor_printf(mon, "]\n");
> +    }
> +
> +    if (info->has_postcopy_latency) {
> +        monitor_printf(mon, "Postcopy Latency (us): %" PRIu64 "\n",
> +                       info->postcopy_latency);
> +    }
> +
> +    if (info->has_postcopy_vcpu_latency) {
> +        uint64List *item = info->postcopy_vcpu_latency;
> +        int count = 0;
> +
> +        monitor_printf(mon, "Postcopy vCPU Latencies (us): \n [");
> +
> +        while (item) {
> +            monitor_printf(mon, "%"PRIu64", ", item->value);
> +            item = item->next;
> +            /* Each line 10 vcpu results, newline if there's more */
> +            if ((++count % 10 == 0) && item) {
> +                monitor_printf(mon, "\n  ");
> +            }
> +        }
> +        monitor_printf(mon, "\b\b]\n");
> +    }
> +}
> +
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  {
>      bool show_all = qdict_get_try_bool(qdict, "all", false);
> @@ -202,27 +248,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->dirty_limit_ring_full_time);
>      }
>  
> -    if (info->has_postcopy_blocktime) {
> -        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
> -                       info->postcopy_blocktime);
> -    }
> -
> -    if (info->has_postcopy_vcpu_blocktime) {
> -        uint32List *item = info->postcopy_vcpu_blocktime;
> -        const char *sep = "";
> -        int count = 0;
> -
> -        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> -
> -        while (item) {
> -            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
> -            item = item->next;
> -            /* Each line 10 vcpu results, newline if there's more */
> -            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
> -        }
> -        monitor_printf(mon, "]\n");
> -    }
> -
> +    migration_dump_blocktime(mon, info);
>  out:
>      qapi_free_MigrationInfo(info);
>  }
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index f5c58a6ca7..98d4c29532 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -166,20 +166,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>      return ctx;
>  }
>  
> -static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
> -{
> -    MachineState *ms = MACHINE(qdev_get_machine());
> -    uint32List *list = NULL;
> -    int i;
> -
> -    for (i = ms->smp.cpus - 1; i >= 0; i--) {
> -        QAPI_LIST_PREPEND(
> -            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / 1000));
> -    }
> -
> -    return list;
> -}
> -
>  /*
>   * This function just populates MigrationInfo from postcopy's
>   * blocktime context. It will not populate MigrationInfo,
> @@ -191,15 +177,47 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    uint64_t latency_total = 0, faults = 0;
> +    uint32List *list_blocktime = NULL;
> +    uint64List *list_latency = NULL;
> +    int i;
>  
>      if (!bc) {
>          return;
>      }
>  
> +    for (i = ms->smp.cpus - 1; i >= 0; i--) {
> +        uint64_t latency, total, count;
> +
> +        /* This is in milliseconds */
> +        QAPI_LIST_PREPEND(list_blocktime,
> +                          (uint32_t)(bc->vcpu_blocktime_total[i] / 1000));
> +
> +        /* The rest in microseconds */
> +        total = bc->vcpu_blocktime_total[i];
> +        latency_total += total;
> +        count = bc->vcpu_faults_count[i];
> +        faults += count;
> +
> +        if (count) {
> +            latency = total / count;
> +        } else {
> +            /* No fault detected */
> +            latency = 0;
> +        }
> +
> +        QAPI_LIST_PREPEND(list_latency, latency);
> +    }
> +
>      info->has_postcopy_blocktime = true;
>      info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / 1000);
>      info->has_postcopy_vcpu_blocktime = true;
> -    info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
> +    info->postcopy_vcpu_blocktime = list_blocktime;
> +    info->has_postcopy_latency = true;
> +    info->postcopy_latency = faults ? (latency_total / faults) : 0;
> +    info->has_postcopy_vcpu_latency = true;
> +    info->postcopy_vcpu_latency = list_latency;
>  }
>  
>  static uint64_t get_postcopy_total_blocktime(void)
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index fb59741b2c..1a5ab2d229 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -358,6 +358,9 @@ void read_blocktime(QTestState *who)
>  
>      rsp_return = migrate_query_not_failed(who);
>      g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
> +    g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
> +    g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
> +    g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
>      qobject_unref(rsp_return);
>  }
>  
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

