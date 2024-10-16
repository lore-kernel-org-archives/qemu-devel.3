Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A343D2A53D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 18:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t195I-0004KO-9S; Wed, 16 Oct 2024 14:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t195E-0004Ju-FT
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t195C-0006u3-IF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 14:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729104556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ue1fcDmnO3gKmduh7Csvlg1tNOfQKtV8e+BK6eUdleE=;
 b=fNDzATim9djvlzlhamD6hK6mEE3xFSg7phHj7vOANHWbQfhZUWH44YxJUNOD937Vu20t8S
 HGyf5cVtgapmWO8JVwzu46KojVty8VDz0jvY644pJXHp+Dad7SI9HTn0eK1CvDZxvzc4bQ
 JSWjO5bD0kdu+vvE83hg90sv3qpIOO4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-ln7QabvVOgup2J0Qqzie2g-1; Wed, 16 Oct 2024 14:49:15 -0400
X-MC-Unique: ln7QabvVOgup2J0Qqzie2g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbed928402so1471016d6.2
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 11:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729104555; x=1729709355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ue1fcDmnO3gKmduh7Csvlg1tNOfQKtV8e+BK6eUdleE=;
 b=moIHI3O+bZDd9qbPcPQ/hEJN/7HdZ6g7l8vI2LmhQOFUWFghA5RP8f7201FqHfpyoE
 HuSNZSvo4qE0NzqFAgb1lAslUT/9orif261B6ekbbwr+48izjm1ydDijsrQXiYiAmCM3
 GUGSodFHsL/6nlE48RI/Cueq5O9ol4Ry554HvdKwmJqZGII0LAgmlRtAawPGsdaK7yyX
 lBLWWREAH76miyuWvTZW782y6TMchqwF7dXHv0Qo8KJeiTwB0I9BuUBmuvL6QTEGd+RZ
 oT47BJFUTr8MVRVOF8jiXl7yINipFDLV9R3ZisPi1QmsbIf4Qnx++pgwehyzDIUPrSZN
 fIzQ==
X-Gm-Message-State: AOJu0YyCHtWgpyRzSj25vcuPOVh5K02Go+jOpygzeS2+pQdtgkuPCbDj
 dRRRs6LE1puEPOjb+i6kSAEFAEXPReCUS1oXWhYfRYfCMQK4alqmtj07YrWydw8UZFrbC3zDEBS
 VWUMCBNGxnQbORpSRdWodL6bz7XDzqHOOvsdd1O2bEvnoBlHIhLYP
X-Received: by 2002:a0c:f408:0:b0:6cb:ecb3:4d3b with SMTP id
 6a1803df08f44-6cc2b91849amr62646796d6.42.1729104554569; 
 Wed, 16 Oct 2024 11:49:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOC86vjiXBz/yAPRsc4+RRhU9MLKUg1OTfTA4ivQvZpDoKgl+YA9gahYovKwnqfKTbsfa5Q==
X-Received: by 2002:a0c:f408:0:b0:6cb:ecb3:4d3b with SMTP id
 6a1803df08f44-6cc2b91849amr62646446d6.42.1729104554087; 
 Wed, 16 Oct 2024 11:49:14 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22990427sm20606536d6.134.2024.10.16.11.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 11:49:13 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:49:11 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 3/4] migration: Support periodic ramblock dirty sync
Message-ID: <ZxAKp_qUU4ClLzs6@x1n>
References: <cover.1729064919.git.yong.huang@smartx.com>
 <f1067c9ddca005629e64d7e77c98686612bb1f82.1729064919.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f1067c9ddca005629e64d7e77c98686612bb1f82.1729064919.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

On Wed, Oct 16, 2024 at 03:56:44PM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> When VM is configured with huge memory, the current throttle logic
> doesn't look like to scale, because migration_trigger_throttle()
> is only called for each iteration, so it won't be invoked for a long
> time if one iteration can take a long time.
> 
> The periodic dirty sync aims to fix the above issue by synchronizing
> the ramblock from remote dirty bitmap and, when necessary, triggering
> the CPU throttle multiple times during a long iteration.
> 
> This is a trade-off between synchronization overhead and CPU throttle
> impact.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/cpu-throttle.c | 70 +++++++++++++++++++++++++++++++++++++++-
>  migration/cpu-throttle.h | 14 ++++++++
>  migration/migration.h    |  1 +
>  migration/ram.c          |  9 ++++--
>  migration/trace-events   |  1 +
>  5 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> index fa47ee2e21..784b51ab35 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -28,16 +28,23 @@
>  #include "qemu/main-loop.h"
>  #include "sysemu/cpus.h"
>  #include "cpu-throttle.h"
> +#include "migration.h"
> +#include "migration-stats.h"
> +#include "options.h"
>  #include "trace.h"
>  
>  /* vcpu throttling controls */
> -static QEMUTimer *throttle_timer;
> +static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
>  static unsigned int throttle_percentage;
> +static bool throttle_dirty_sync_timer_active;
>  
>  #define CPU_THROTTLE_PCT_MIN 1
>  #define CPU_THROTTLE_PCT_MAX 99
>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>  
> +/* RAMBlock dirty sync trigger every five seconds */

Maybe enrich it to say "making sure it is synchronized every five seconds"?
Because it can synchronize faster if each iteration runs faster than 5sec,
so just to emphasize it's a fallback sync, and only with auto converge.

> +#define CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS 5000
> +
>  static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
>  {
>      double pct;
> @@ -112,6 +119,7 @@ void cpu_throttle_set(int new_throttle_pct)
>  void cpu_throttle_stop(void)
>  {
>      qatomic_set(&throttle_percentage, 0);
> +    cpu_throttle_dirty_sync_timer(false);
>  }
>  
>  bool cpu_throttle_active(void)
> @@ -124,8 +132,68 @@ int cpu_throttle_get_percentage(void)
>      return qatomic_read(&throttle_percentage);
>  }
>  
> +void cpu_throttle_dirty_sync_timer_tick(void *opaque)
> +{
> +    static uint64_t prev_sync_cnt = 2;

IIUC the hard coded "2" isn't needed, as long as it's guaranteed to be
updated for each timer call, and you special cased "1" anyway below.

> +    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +
> +    if (!migrate_auto_converge()) {
> +        /* Stop the timer when auto converge is disabled */
> +        return;

I think we can try to make sure this never starts if !auto-converge, so
assuming this path will never trigger in real life.

> +    }
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
> +        trace_cpu_throttle_dirty_sync();
> +        WITH_RCU_READ_LOCK_GUARD() {
> +            migration_bitmap_sync_precopy(false);
> +        }
> +    }
> +
> +end:
> +    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +
> +    timer_mod(throttle_dirty_sync_timer,
> +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> +            CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> +}
> +
> +static bool cpu_throttle_dirty_sync_active(void)
> +{
> +    return qatomic_read(&throttle_dirty_sync_timer_active);
> +}
> +
> +void cpu_throttle_dirty_sync_timer(bool enable)
> +{
> +    if (enable) {
> +        assert(throttle_dirty_sync_timer);
> +        if (!cpu_throttle_dirty_sync_active()) {

I suppose this can be logically racy? As I think after this patch this path
can be invoked both in main thread and migration thread.

The simplest way to do is to move cpu_throttle_stop() call to be under
bql_lock(), so that this will be serialized by BQL.  Then we can add an
assertion at the entry of the function for bql_locked().

> +            timer_mod(throttle_dirty_sync_timer,
> +                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> +                    CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> +            qatomic_set(&throttle_dirty_sync_timer_active, 1);
> +        }
> +    } else {
> +        if (throttle_dirty_sync_timer != NULL) {

IIUC throttle_dirty_sync_timer is never destroyed, aka, timer_del() only
disables it.  So you should probably use throttle_dirty_sync_timer_active?

> +            timer_del(throttle_dirty_sync_timer);
> +            qatomic_set(&throttle_dirty_sync_timer_active, 0);
> +        }
> +    }
> +}
> +
>  void cpu_throttle_init(void)
>  {
>      throttle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
>                                    cpu_throttle_timer_tick, NULL);
> +    throttle_dirty_sync_timer =
> +        timer_new_ms(QEMU_CLOCK_VIRTUAL_RT,
> +                     cpu_throttle_dirty_sync_timer_tick, NULL);
>  }
> diff --git a/migration/cpu-throttle.h b/migration/cpu-throttle.h
> index d65bdef6d0..420702b8d3 100644
> --- a/migration/cpu-throttle.h
> +++ b/migration/cpu-throttle.h
> @@ -65,4 +65,18 @@ bool cpu_throttle_active(void);
>   */
>  int cpu_throttle_get_percentage(void);
>  
> +/**
> + * cpu_throttle_dirty_sync_timer_tick:
> + *
> + * Dirty sync timer hook.
> + */
> +void cpu_throttle_dirty_sync_timer_tick(void *opaque);
> +
> +/**
> + * cpu_throttle_dirty_sync_timer:
> + *
> + * Start or stop the dirty sync timer.
> + */
> +void cpu_throttle_dirty_sync_timer(bool enable);
> +
>  #endif /* SYSEMU_CPU_THROTTLE_H */
> diff --git a/migration/migration.h b/migration/migration.h
> index 38aa1402d5..fbd0d19092 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -537,4 +537,5 @@ int migration_rp_wait(MigrationState *s);
>   */
>  void migration_rp_kick(MigrationState *s);
>  
> +void migration_bitmap_sync_precopy(bool last_stage);
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 9b5b350405..ac34e731e2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1020,6 +1020,11 @@ static void migration_trigger_throttle(RAMState *rs)
>          migration_transferred_bytes() - rs->bytes_xfer_prev;
>      uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
>      uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
> +    bool auto_converge = migrate_auto_converge();
> +
> +    if (auto_converge) {
> +        cpu_throttle_dirty_sync_timer(true);
> +    }

If you have the guard to skip the 1st sync in the timer fn(), IIUC you can
move this earlier to e.g. migration_thread() before iteration starts.
Otherwise it'll be not as clear on when this timer will start if it hides
in the sync path itself.

>  
>      /*
>       * The following detection logic can be refined later. For now:
> @@ -1031,7 +1036,7 @@ static void migration_trigger_throttle(RAMState *rs)
>      if ((bytes_dirty_period > bytes_dirty_threshold) &&
>          (++rs->dirty_rate_high_cnt >= 2)) {
>          rs->dirty_rate_high_cnt = 0;
> -        if (migrate_auto_converge()) {
> +        if (auto_converge) {
>              trace_migration_throttle();
>              mig_throttle_guest_down(bytes_dirty_period,
>                                      bytes_dirty_threshold);
> @@ -1088,7 +1093,7 @@ static void migration_bitmap_sync(RAMState *rs, bool last_stage)
>      }
>  }
>  
> -static void migration_bitmap_sync_precopy(bool last_stage)
> +void migration_bitmap_sync_precopy(bool last_stage)
>  {
>      Error *local_err = NULL;
>      assert(ram_state);
> diff --git a/migration/trace-events b/migration/trace-events
> index 9a19599804..0638183056 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -381,3 +381,4 @@ migration_pagecache_insert(void) "Error allocating page"
>  
>  # cpu-throttle.c
>  cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
> +cpu_throttle_dirty_sync(void) ""
> -- 
> 2.27.0
> 

-- 
Peter Xu


