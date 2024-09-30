Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE357CEB2C0
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 20:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svND1-0004Vw-U9; Mon, 30 Sep 2024 16:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svND0-0004V5-Nh
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1svNCy-0001I4-7V
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 16:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727728885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tl+nKTckNXRvP1mX5cXz+TY5YHRrdoRIrTppI5XBiA=;
 b=KNRZZHEeHiRw0zK0YZDYhnZgdWL4xm9Mj6hgKxuJkCz5r7hRswYnmWbavNWgga3+7xWSpZ
 FvknHoqxFwqPnzT7euIZqohHJK0yDlaMNcibne+CKJ5ZWUmAs+pcGg7W0WGzbrOy3htswM
 rzHMeCufVuCKvpZ+YnwS+BMRwGcccAU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-QqbuXO1fM4SKqR_6G1I3TA-1; Mon, 30 Sep 2024 16:41:24 -0400
X-MC-Unique: QqbuXO1fM4SKqR_6G1I3TA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cb4c013b89so47534796d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 13:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727728884; x=1728333684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tl+nKTckNXRvP1mX5cXz+TY5YHRrdoRIrTppI5XBiA=;
 b=r7YqHhrN4MUN+0satfsVoU4+j3RZ1vM8n5rpAks9znnrLs77Iw0a4W64oZnDF/POpq
 IVYJ8nUVy9G1qqpDhFx5vWVxEK0BeJ6K7uYaV2w7qVrbxei83bYcdonV/59MCaHJr5XB
 Gv3czwPppgeNvatkJ221a3xLtZyeF1wG3uNi5qeh85ip+5BMxDocY2TpnKskF/OOq3ar
 b2vxzyY6hmrCCzD6QtDQyniQj8N+26VmmdCHADZrz2As1A/uU6DrZCcHB/Jf0+38jJJI
 8crPnYx5kPSdrXPHiz1uN3AUwA3EQVDJb0HeAYDefKsDd0wngW3DcJldcjMitdsCzwIZ
 ODAA==
X-Gm-Message-State: AOJu0YxQWx/zFqj4xS5Yc6iOJjCXi9oughprgUvragtrYIyePEtU53NC
 vY8KVi/aZDUljCf/+TGY0irS95cWi4kw14tDsz0b9ZE7U9rjYqvwJO730FGls1fXc7mujOaG6wt
 LW6X2ZVtQrCLcIpBZtdAgUHd5DV9X0ZBexQABSfT4b7ia3BCdfbQY
X-Received: by 2002:a05:6214:1d2a:b0:6bf:a3a6:e7ce with SMTP id
 6a1803df08f44-6cb72a27cdcmr13962746d6.26.1727728883997; 
 Mon, 30 Sep 2024 13:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd1MIg5T9JwfBaXLQdK2YUHq+ozCHaYwNFVtlo6D2ZzVQQhnzqaLNfQxJXH+kNWSK6k74KsA==
X-Received: by 2002:a05:6214:1d2a:b0:6bf:a3a6:e7ce with SMTP id
 6a1803df08f44-6cb72a27cdcmr13962476d6.26.1727728883568; 
 Mon, 30 Sep 2024 13:41:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b680228sm42501326d6.111.2024.09.30.13.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 13:41:22 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:41:20 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/3] migration: Support background ramblock dirty sync
Message-ID: <ZvsM8LObQlYy6H_O@x1n>
References: <cover.1727630000.git.yong.huang@smartx.com>
 <f36590f60307ce9647d3506e55dcbc2405c98ee2.1727630000.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f36590f60307ce9647d3506e55dcbc2405c98ee2.1727630000.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 30, 2024 at 01:14:26AM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> When VM is configured with huge memory, the current throttle logic
> doesn't look like to scale, because migration_trigger_throttle()
> is only called for each iteration, so it won't be invoked for a long
> time if one iteration can take a long time.
> 
> The background dirty sync aim to fix the above issue by synchronizing
> the ramblock from remote dirty bitmap and, when necessary, triggering
> the CPU throttle multiple times during a long iteration.
> 
> This is a trade-off between synchronization overhead and CPU throttle
> impact.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  include/migration/misc.h     |  3 ++
>  migration/migration.c        | 11 +++++++
>  migration/ram.c              | 64 ++++++++++++++++++++++++++++++++++++
>  migration/ram.h              |  3 ++
>  migration/trace-events       |  1 +
>  system/cpu-timers.c          |  2 ++
>  tests/qtest/migration-test.c | 29 ++++++++++++++++
>  7 files changed, 113 insertions(+)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index bfadc5613b..67c00d98f5 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -111,4 +111,7 @@ bool migration_in_bg_snapshot(void);
>  /* migration/block-dirty-bitmap.c */
>  void dirty_bitmap_mig_init(void);
>  
> +/* migration/ram.c */
> +void bg_ram_dirty_sync_init(void);

IMO it's better we don't add this logic to ram.c as I mentioned.  It's
closely relevant to auto converge so I think cpu-throttle.c is more
suitable.

> +
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 3dea06d577..224b5dfb4f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3285,6 +3285,9 @@ static void migration_iteration_finish(MigrationState *s)
>  {
>      /* If we enabled cpu throttling for auto-converge, turn it off. */
>      cpu_throttle_stop();
> +    if (migrate_auto_converge()) {
> +        bg_ram_dirty_sync_timer_enable(false);
> +    }

Please avoid adding this code.  When it's part of auto-converge,
cpu_throttle_stop() should already guarantee that timer disabled
altogether.

>  
>      bql_lock();
>      switch (s->state) {
> @@ -3526,6 +3529,14 @@ static void *migration_thread(void *opaque)
>  
>      trace_migration_thread_setup_complete();
>  
> +    /*
> +     * Tick the background ramblock dirty sync timer after setup
> +     * phase.
> +     */
> +    if (migrate_auto_converge()) {
> +        bg_ram_dirty_sync_timer_enable(true);
> +    }

Might be good to still stick the enablement with auto-converge; the latter
was done in migration_trigger_throttle().  Maybe also enable the timer only
there?

> +
>      while (migration_is_active()) {
>          if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
>              MigIterateState iter_state = migration_iteration_run(s);
> diff --git a/migration/ram.c b/migration/ram.c
> index 67ca3d5d51..995bae1ac9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -110,6 +110,12 @@
>   */
>  #define MAPPED_RAM_LOAD_BUF_SIZE 0x100000
>  
> +/* Background ramblock dirty sync trigger every five seconds */
> +#define BG_RAM_SYNC_TIMESLICE_MS 5000
> +#define BG_RAM_SYNC_TIMER_INTERVAL_MS 1000

Why this timer needs to be invoked every 1sec, if it's a 5sec timer?

> +
> +static QEMUTimer *bg_ram_dirty_sync_timer;
> +
>  XBZRLECacheStats xbzrle_counters;
>  
>  /* used by the search for pages to send */
> @@ -4543,6 +4549,64 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>      }
>  }
>  
> +static void bg_ram_dirty_sync_timer_tick(void *opaque)

Please consider moving this function to cpu-throttle.c.

Also please prefix the functions with cpu_throttle_*(), rather than bg_*().
It should be part of auto converge function.

> +{
> +    static int prev_pct;
> +    static uint64_t prev_sync_cnt = 2;
> +    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +    int cur_pct = cpu_throttle_get_percentage();
> +
> +    if (prev_pct && !cur_pct) {
> +        /* CPU throttle timer stopped, so do we */
> +        return;
> +    }

Didn't follow why this is not needed if cpu throttle is 0.

It means dirty rate is probably very low, but then shouldn't this
background sync still working (just to notice it grows again)?

> +
> +    /*
> +     * The first iteration copies all memory anyhow and has no
> +     * effect on guest performance, therefore omit it to avoid
> +     * paying extra for the sync penalty.
> +     */
> +    if (sync_cnt <= 1) {
> +        goto end;
> +    }
> +
> +    if (sync_cnt == prev_sync_cnt) {
> +        int64_t curr_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +        assert(ram_state);
> +        if ((curr_time - ram_state->time_last_bitmap_sync) >
> +            BG_RAM_SYNC_TIMESLICE_MS) {
> +            trace_bg_ram_dirty_sync();
> +            WITH_RCU_READ_LOCK_GUARD() {
> +                migration_bitmap_sync_precopy(ram_state, false);
> +            }
> +        }
> +    }
> +
> +end:
> +    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +    prev_pct = cpu_throttle_get_percentage();
> +
> +    timer_mod(bg_ram_dirty_sync_timer,
> +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> +            BG_RAM_SYNC_TIMER_INTERVAL_MS);

IIUC we only need to fire per 5sec, not 1s?

> +}
> +
> +void bg_ram_dirty_sync_timer_enable(bool enable)
> +{
> +    if (enable) {
> +        bg_ram_dirty_sync_timer_tick(NULL);
> +    } else {
> +        timer_del(bg_ram_dirty_sync_timer);
> +    }
> +}
> +
> +void bg_ram_dirty_sync_init(void)
> +{
> +    bg_ram_dirty_sync_timer =
> +        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> +                     bg_ram_dirty_sync_timer_tick, NULL);
> +}

IMHO all these functions should move to cpu-throttle.c.

> +
>  static RAMBlockNotifier ram_mig_ram_notifier = {
>      .ram_block_resized = ram_mig_ram_block_resized,
>  };
> diff --git a/migration/ram.h b/migration/ram.h
> index bc0318b834..9c1a2f30f1 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -93,4 +93,7 @@ void ram_write_tracking_prepare(void);
>  int ram_write_tracking_start(void);
>  void ram_write_tracking_stop(void);
>  
> +/* Background ramblock dirty sync */
> +void bg_ram_dirty_sync_timer_enable(bool enable);
> +
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index c65902f042..3f09e7f383 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -90,6 +90,7 @@ put_qlist_end(const char *field_name, const char *vmsd_name) "%s(%s)"
>  qemu_file_fclose(void) ""
>  
>  # ram.c
> +bg_ram_dirty_sync(void) ""
>  get_queued_page(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
>  get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned long page_abs) "%s/0x%" PRIx64 " page_abs=0x%lx"
>  migration_bitmap_sync_start(void) ""
> diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> index 0b31c9a1b6..64f0834be4 100644
> --- a/system/cpu-timers.c
> +++ b/system/cpu-timers.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
>  #include "migration/vmstate.h"
> +#include "migration/misc.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/cpus.h"
> @@ -274,4 +275,5 @@ void cpu_timers_init(void)
>      vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
>  
>      cpu_throttle_init();
> +    bg_ram_dirty_sync_init();
>  }
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index d6768d5d71..3296f5244d 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -468,6 +468,12 @@ static void migrate_ensure_converge(QTestState *who)
>      migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
>  }
>  
> +static void migrate_ensure_iteration_last_long(QTestState *who)
> +{
> +    /* Set 10Byte/s bandwidth limit to make the iteration last long enough */
> +    migrate_set_parameter_int(who, "max-bandwidth", 10);
> +}
> +
>  /*
>   * Our goal is to ensure that we run a single full migration
>   * iteration, and also dirty memory, ensuring that at least
> @@ -2791,6 +2797,7 @@ static void test_migrate_auto_converge(void)
>       * so we need to decrease a bandwidth.
>       */
>      const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
> +    uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
>  
>      if (test_migrate_start(&from, &to, uri, &args)) {
>          return;
> @@ -2827,6 +2834,28 @@ static void test_migrate_auto_converge(void)
>      } while (true);
>      /* The first percentage of throttling should be at least init_pct */
>      g_assert_cmpint(percentage, >=, init_pct);
> +
> +    /* Make sure the iteration last a long time enough */
> +    migrate_ensure_iteration_last_long(from);

There's already migrate_ensure_non_converge(), why this is needed?

> +
> +    /*
> +     * End the loop when the dirty sync count greater than 1.
> +     */
> +    while ((dirty_sync_cnt = get_migration_pass(from)) < 2) {
> +        usleep(1000 * 1000);
> +    }
> +
> +    prev_dirty_sync_cnt = dirty_sync_cnt;
> +
> +    /*
> +     * The dirty sync count must changes in 5 seconds, here we
> +     * plus 1 second as error value.
> +     */
> +    sleep(5 + 1);
> +
> +    dirty_sync_cnt = get_migration_pass(from);
> +    g_assert_cmpint(dirty_sync_cnt, != , prev_dirty_sync_cnt);
> +
>      /* Now, when we tested that throttling works, let it converge */
>      migrate_ensure_converge(from);

Please move the test change into a separate patch.  I had a feeling 5+1 sec
might still easily fail on CIs (even though this test is not yet run).
Maybe it needs to still provide a loop so it waits for a few rounds just in
case.

Thanks,

-- 
Peter Xu


