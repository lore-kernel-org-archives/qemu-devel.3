Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5ED0C61CE8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 00:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOmps-0005lW-MU; Mon, 09 Jun 2025 20:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uOmpo-0005kt-Tg
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 20:27:24 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uOmpm-000222-0U
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 20:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=ULhezJTf6QH25BHP1GRbB5ocijPk3QKYSvi/Ou1FTtc=; b=oRSQmmH8egcWFkoX
 JNpmNqwpJnWEsxDF+8PZa/Duj+iy5xMRRLwXYFsQhffj+bschax71vkvm8VS7dcUDOWZ5RZtuJ56u
 mJMvZVAUMJ00hleFqmT6Dmg3uIQniOHZ8jB9yvtu9VrrCXEDmJGHd4rBsl15R4u6uH093wiSVeGWJ
 a6ZawA/cr3MZ0jDg9dMH9zIxDQaJtYanfyc/WY8Khi9F27OM1jnEIZocrG53rRJgRZKGw7kg4D/mR
 gXgG9LwYcm/9LsV+P/ZVWNjyZshwxEFkdp2jMhZNfcRIzf/lui7Kb+5OvK8FcWglH+vNBTC6vG5L7
 /82qCPJofjCKyM6ygA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uOmpj-008W6Q-28;
 Tue, 10 Jun 2025 00:27:19 +0000
Date: Tue, 10 Jun 2025 00:27:19 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration/postcopy: Add latency distribution report for
 blocktime
Message-ID: <aEd7526urkX56eq0@gallifrey>
References: <20250609223607.34387-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250609223607.34387-1-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 00:20:48 up 43 days, 8:34, 1 user, load average: 0.00, 0.01, 0.00
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
> Add the latency distribution too for blocktime, using order-of-two buckets.
> It accounts for all the faults, from either vCPU or non-vCPU threads.  With
> prior rework, it's very easy to achieve by adding an array to account for
> faults in each buckets.
> 
> Sample output for HMP (while for QMP it's simply an array):
> 
> Postcopy Latency Distribution:
>   [     1 us -     2 us ]:          0
>   [     2 us -     4 us ]:          0
>   [     4 us -     8 us ]:          1
>   [     8 us -    16 us ]:          2
>   [    16 us -    32 us ]:          2
>   [    32 us -    64 us ]:          3
>   [    64 us -   128 us ]:      10169
>   [   128 us -   256 us ]:      50151
>   [   256 us -   512 us ]:      12876
>   [   512 us -     1 ms ]:         97
>   [     1 ms -     2 ms ]:         42
>   [     2 ms -     4 ms ]:         44
>   [     4 ms -     8 ms ]:         93
>   [     8 ms -    16 ms ]:        138

Nice.

>   [    16 ms -    32 ms ]:          0
>   [    32 ms -    65 ms ]:          0
>   [    65 ms -   131 ms ]:          0
>   [   131 ms -   262 ms ]:          0
>   [   262 ms -   524 ms ]:          0
>   [   524 ms -    1 sec ]:          0
>   [    1 sec -    2 sec ]:          0
>   [    2 sec -    4 sec ]:          0
>   [    4 sec -    8 sec ]:          0
>   [    8 sec -   16 sec ]:          0
> 
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> This patch is based on:
> 
> [PATCH v2 00/13] migration/postcopy: Blocktime tracking overhaul
> Based-on: <20250609191259.9053-1-peterx@redhat.com>
> 
> It is the TODO mentioned in the other series, this patch implemented the
> buckets distribution for fault latency traps.
> ---
>  qapi/migration.json                   |  9 ++++++
>  migration/migration-hmp-cmds.c        | 32 +++++++++++++++++++
>  migration/postcopy-ram.c              | 45 +++++++++++++++++++++++++++
>  tests/qtest/migration/migration-qmp.c |  1 +
>  4 files changed, 87 insertions(+)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index cc680dda46..7d9524a8ea 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -242,6 +242,14 @@
>  #     average page fault latency. This is only present when the
>  #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
>  #
> +# @postcopy-latency-dist: remote page fault latency distributions.  Each
> +#     element of the array is the number of faults that fall into the
> +#     bucket period.  For the N-th bucket (N>=0), the latency window is
> +#     [2^N, 2^(N+1)).  For example, the 8th element stores how many remote
> +#     faults got resolved within [256us, 512us) window. This is only
> +#     present when the postcopy-blocktime migration capability is enabled.
> +#     (Since 10.1)
> +#
>  # @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
>  #     us).  It has the same definition of @postcopy-latency, but instead
>  #     this is the per-vCPU statistics.  This is only present when the
> @@ -293,6 +301,7 @@
>             '*postcopy-blocktime': 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
>             '*postcopy-latency': 'uint64',
> +           '*postcopy-latency-dist': ['uint64'],
>             '*postcopy-vcpu-latency': ['uint64'],
>             '*postcopy-non-vcpu-latency': 'uint64',
>             '*socket-address': ['SocketAddress'],
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index b234eb6478..b83befd26c 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -52,6 +52,21 @@ static void migration_global_dump(Monitor *mon)
>                     ms->clear_bitmap_shift);
>  }
>  
> +static const gchar *format_time_str(uint64_t us)
> +{
> +    const char *units[] = {"us", "ms", "sec"};
> +    int index = 0;
> +
> +    while (us > 1000) {
> +        us /= 1000;
> +        if (++index >= (sizeof(units) - 1)) {
> +            break;
> +        }
> +    }
> +
> +    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
> +}

(It surprises me we don't have a function like that somewhere)

> +
>  static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>  {
>      if (info->has_postcopy_blocktime) {
> @@ -100,6 +115,23 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
>          }
>          monitor_printf(mon, "]\n");
>      }
> +
> +    if (info->has_postcopy_latency_dist) {
> +        uint64List *item = info->postcopy_latency_dist;
> +        int count = 0;
> +
> +        monitor_printf(mon, "Postcopy Latency Distribution:\n");
> +
> +        while (item) {
> +            g_autofree const gchar *from = format_time_str(1UL << count);
> +            g_autofree const gchar *to = format_time_str(1UL << (count + 1));
> +
> +            monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
> +                           from, to, item->value);
> +            item = item->next;
> +            count++;
> +        }
> +    }
>  }

For HMP,

Acked-by: Dr. David Alan Gilbert <dave@treblig.org>

>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 23332ef3dd..0b40b79f64 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -110,6 +110,15 @@ void postcopy_thread_create(MigrationIncomingState *mis,
>  #include <sys/eventfd.h>
>  #include <linux/userfaultfd.h>
>  
> +/*
> + * Here we use 24 buckets, which means the last bucket will cover [2^24 us,
> + * 2^25 us) ~= [16, 32) seconds.  It should be far enough to record even
> + * extreme (perf-wise broken) 1G pages moving over, which can sometimes
> + * take a few seconds due to various reasons.  Anything more than that
> + * might be unsensible to account anymore.
> + */
> +#define  BLOCKTIME_LATENCY_BUCKET_N  (24)
> +
>  /* All the time records are in unit of microseconds (us) */
>  typedef struct PostcopyBlocktimeContext {
>      /* blocktime per vCPU */
> @@ -175,6 +184,11 @@ typedef struct PostcopyBlocktimeContext {
>       * that a fault was requested.
>       */
>      GHashTable *vcpu_addr_hash;
> +    /*
> +     * Each bucket stores the count of faults that were resolved within the
> +     * bucket window [2^N us, 2^(N+1) us).
> +     */
> +    uint64_t latency_buckets[BLOCKTIME_LATENCY_BUCKET_N];
>      /* total blocktime when all vCPUs are stopped */
>      uint64_t total_blocktime;
>      /* point in time when last page fault was initiated */
> @@ -283,6 +297,9 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
>      unsigned int smp_cpus = ms->smp.cpus;
>      PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
>  
> +    /* Initialize all counters to be zeros */
> +    memset(ctx->latency_buckets, 0, sizeof(ctx->latency_buckets));
> +
>      ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
>      ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
>      ctx->vcpu_faults_current = g_new0(uint8_t, smp_cpus);
> @@ -320,6 +337,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
>      uint64_t latency_total = 0, faults = 0;
>      uint32List *list_blocktime = NULL;
>      uint64List *list_latency = NULL;
> +    uint64List *latency_buckets = NULL;
>      int i;
>  
>      if (!bc) {
> @@ -349,6 +367,10 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
>          QAPI_LIST_PREPEND(list_latency, latency);
>      }
>  
> +    for (i = BLOCKTIME_LATENCY_BUCKET_N - 1; i >= 0; i--) {
> +        QAPI_LIST_PREPEND(latency_buckets, bc->latency_buckets[i]);
> +    }
> +
>      latency_total += bc->non_vcpu_blocktime_total;
>      faults += bc->non_vcpu_faults;
>  
> @@ -363,6 +385,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
>      info->postcopy_latency = faults ? (latency_total / faults) : 0;
>      info->has_postcopy_vcpu_latency = true;
>      info->postcopy_vcpu_latency = list_latency;
> +    info->has_postcopy_latency_dist = true;
> +    info->postcopy_latency_dist = latency_buckets;
>  }
>  
>  static uint64_t get_postcopy_total_blocktime(void)
> @@ -1095,6 +1119,25 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>      blocktime_fault_inject(dc, addr, cpu, current_us);
>  }
>  
> +static void blocktime_latency_account(PostcopyBlocktimeContext *ctx,
> +                                      uint64_t time_us)
> +{
> +    /*
> +     * Convert time (in us) to bucket index it belongs.  Take extra caution
> +     * of time_us==0 even if normally rare - when happens put into bucket 0.
> +     */
> +    int index = time_us ? (63 - clz64(time_us)) : 0;
> +
> +    assert(index >= 0);
> +
> +    /* If it's too large, put into top bucket */
> +    if (index >= BLOCKTIME_LATENCY_BUCKET_N) {
> +        index = BLOCKTIME_LATENCY_BUCKET_N - 1;
> +    }
> +
> +    ctx->latency_buckets[index]++;
> +}
> +
>  typedef struct {
>      PostcopyBlocktimeContext *ctx;
>      uint64_t current_us;
> @@ -1117,6 +1160,8 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
>      assert(iter->current_us >= entry->fault_time);
>      time_passed = iter->current_us - entry->fault_time;
>  
> +    blocktime_latency_account(ctx, time_passed);
> +
>      if (cpu >= 0) {
>          /*
>           * If we resolved all pending faults on one vCPU due to this page
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index 67a67d4bd6..66dd369ba7 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -360,6 +360,7 @@ void read_blocktime(QTestState *who)
>      g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
>      g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
>      g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
> +    g_assert(qdict_haskey(rsp_return, "postcopy-latency-dist"));
>      g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
>      g_assert(qdict_haskey(rsp_return, "postcopy-non-vcpu-latency"));
>      qobject_unref(rsp_return);
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

