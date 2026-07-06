Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282A1C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqXy-0006XF-MQ; Mon, 06 Jul 2026 17:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgqXw-0006Wl-Gd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:08:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wgqXu-0003cd-4g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783372084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4DM1blKDix8Grjl8GC+BbzV5Xn/FPTP9JpFkp3SFjOQ=;
 b=Cp7AU0UxKdynX7OdkOVKCddeBqIb4QPbS5nVn+AcoJqG3koFoqCXU6qBYs4VvVYdkV6u4o
 wW+qc6CSnn6wBkEMR+xicKrI8D8asqN8j4dTrl8APyjD3Md7K+xFV992UBZIE5tifwrt8w
 9nKDh1jcUF735pcNPxOqEO6jF5T8Bmw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-WF_Ida1JOBORHwrtbKe1CQ-1; Mon, 06 Jul 2026 17:08:03 -0400
X-MC-Unique: WF_Ida1JOBORHwrtbKe1CQ-1
X-Mimecast-MFC-AGG-ID: WF_Ida1JOBORHwrtbKe1CQ_1783372083
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ec45d9628aso81088016d6.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783372083; x=1783976883; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4DM1blKDix8Grjl8GC+BbzV5Xn/FPTP9JpFkp3SFjOQ=;
 b=am6xTLxBYq0AUoDaLOAVEZXwyQ4mddmu6Ktoa23SnWBQ4K6ADhFq5NconqWYrG6rXQ
 +o+VgO0BaOaIt9zlcoYA5xw8N/ggAbyqDHeEz920Ay1GWCKahxCbs6oYhiKaOnaRp2N0
 hJTPnEET9imGTJ3kxlLZPBeeCObQgI6scMzYlSO9yL4at/7VLhoXIevywRP9ZVV+3dOY
 9lSLj4sPTqxez7pBcIUrHSsteyBS89GNPIgp7yM79hKjSbX4TR3L12zD+M/8ANYoyrAU
 7eyDVN7dyOJpyrnHlFvirvGBAwJ7jdMjs0GSEOgvePAr2XivWkdmbnS0pCCVGy00oRl8
 +Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372083; x=1783976883;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4DM1blKDix8Grjl8GC+BbzV5Xn/FPTP9JpFkp3SFjOQ=;
 b=I19JzCzmJCVdLnjD5OjyX2SymymJ4ddnJPVkeDDs5irSdBjBubffqwgxyJ0QZQOHHx
 rIS0Lw7BicMeJ4d/QsWQmt7qJdrqm6ctUclKz94SAlJr5hm/qk2NN7Jkjy9pJkaayy+f
 mGHm6vtV1PuDoQjQizBA+EbB7Hq2ISneOQVynFtaLwTtND6ojehzY1TW5ag0bESkrODR
 MMF5c+eftRSjg5s4snJThE4ZLCHSGM4/yrzEkaiOz83roLN3V7j8iizyQGw4OCZgkdkk
 rzIt64P8asmTw2tAcmS7ecGAisSbY5AwfSMrJZSciLm0wdhlKB8xSjYgLJv0PYE4Ti6H
 s+EQ==
X-Gm-Message-State: AOJu0Yzl/obvvK+biFEJ3oBeZLi42uINovAIeQUJx3iY7rES7xrUyrZU
 RvJ5hskiL6pgg1ROK54CX8evtQjv4F8gSb7PH0J67usm+EkvAjdDrMQ2zZ5dDGhQ7BLu7pSbvhe
 n10sRgc/qGIR7a7XLrThaaACUwgwtXLX0lYVmfJ1R0FNO2k5WCBbuFZ+h
X-Gm-Gg: AfdE7cmBNxZTzxOWyeEnMNGWmUiUXVBkcA+BsjosA0+AmerdjFeDomSMaPxIe9YYbHo
 nCFduON63xRwXpDlgUZ4fCUksBAD7A5DlOZVsSlIYBueYTV5omFwhWKRYZ1bZy/BFSoxpSRIQcU
 qIHyIMsh8aVmzB087JHw1jlKi5yRgJcc+XGdFGDiUmXjKWQ5TF5apxsem2mDDohyunt8mWSC0iD
 IDKUUedIz9MxNBK8UeGIczXZ1qZuNPjVX3qTNIRjwmzHnbyEecVd5lxVzhABkWO3wqXVOgMIAL4
 KnlNBThYlmrSSFALeE2Ox771VRBUF1RruU0/EwrgRVWATtB4SI4CPCOGqo8oE2jBT/cAfMSiTmG
 nJaV2at1OQrbEkWsiTVaq5AVKQPBfOy+PRPdQ5G4SLf+7YkuxUsNVGSUKRgIr6Cwu6iEbLQ==
X-Received: by 2002:a05:6214:2589:b0:8f1:ae38:1beb with SMTP id
 6a1803df08f44-8fcb47119afmr31249676d6.32.1783372082714; 
 Mon, 06 Jul 2026 14:08:02 -0700 (PDT)
X-Received: by 2002:a05:6214:2589:b0:8f1:ae38:1beb with SMTP id
 6a1803df08f44-8fcb47119afmr31248996d6.32.1783372081992; 
 Mon, 06 Jul 2026 14:08:01 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f46e84dfb0sm143760936d6.12.2026.07.06.14.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:08:01 -0700 (PDT)
Date: Mon, 6 Jul 2026 17:07:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH v2 7/7] migration: add eager load thread and setup
 for fast snapshot load
Message-ID: <akwZLy6EfzJNlTtY@x1.local>
References: <20260630081940.611092-1-aadeshveer07@gmail.com>
 <20260630081940.611092-8-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630081940.611092-8-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jun 30, 2026 at 01:49:40PM +0530, Aadeshveer Singh wrote:
> In fast snapshot load a thread is needed for actively loading in pages
> along with the fault path so that the guest is not dependent on fault
> thread indefinitely. Considering the difference from usual network
> postcopy where major chunk of RAM is already loaded here entire RAM
> needs to be loaded later. Existance of background pages which are not
> really accessed by the guest might never be loaded and system will be
> locked in migration for indefinite time. As there should be no
> assumption about how guest accesses memory, the load times can be
> indefinite.
> 
> Add postcopy_ram_eager_load_thread(), for the eager thread which
> iterates over all non ignored blocks calling ram_block_load_eager()
> on each. ram_block_load_eager then iterates to load in all pages using
> postcopy_mapped_ram_load_page(), with a different channel, which takes
> care of not loading in pages already loaded by fault thread. On
> completion the thread schedules postcopy_incoming_complete_bh() to
> destroy the incoming migration state.
> 
> Add postcopy_ram_eager_load_setup() to create the thread. Added joining
> logic in postcopy_incoming_cleanup().
> 
> Add tracepoints for entry and exit to eager load thread.
> 
> When both mapped-ram and postcopy-ram are set, divert from
> qemu_loadvm_state to run fast snapshot load
> 
> Initialize postcopy RAM state and register RAM Blocks with userfaultfd
> via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup() in
> process_incoming_migration_co(). Fault thread needs to be launched
> before VM to serve faults for some hardwares emulation that need to read
> RAM (like vapic devices). Populate bitmaps and offset tables while
> reading file in qemu_loadvm_state_main.
> 
> Add function qemu_loadvm_run_fast_snapshot_load() which starts the VM
> using loadvm_postcopy_handle_run_bh() and launches eager load thread.
> 
> Skip scheduling process_incoming_migration_bh() in
> process_incoming_migration_co(), for fast snapshot load as the state
> cleanup is managed by eager load thread on completion.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/migration.c    | 33 ++++++++++++++++--
>  migration/migration.h    |  5 +++
>  migration/postcopy-ram.c | 74 ++++++++++++++++++++++++++++++++++++++--
>  migration/postcopy-ram.h |  2 ++
>  migration/savevm.c       | 26 ++++++++++++++
>  migration/savevm.h       |  2 ++
>  migration/trace-events   |  2 ++
>  7 files changed, 140 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 074d3f2c69..9295794713 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -730,6 +730,11 @@ static void process_incoming_migration_bh(void *opaque)
>      migration_incoming_state_destroy();
>  }
>  
> +static bool migration_incoming_has_postcopy_thread(MigrationIncomingState *mis)
> +{
> +    return mis->have_listen_thread || mis->have_eager_load_thread;
> +}
> +
>  static void coroutine_fn
>  process_incoming_migration_co(void *opaque)
>  {
> @@ -759,17 +764,41 @@ process_incoming_migration_co(void *opaque)
>      migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
>                        MIGRATION_STATUS_ACTIVE);
>  

Below is correct, said that, it would be nice to add a comment explaining
why setup postcopy needs to be done here, especially, why it needs to be
before qemu_loadvm_state(); it's very not obvious but critical..

Something like this?

       /*
        * When loading snapshot with postcopy enabled, setup the postcopy
        * infrastructure before loading the major part of device states.
        * It's required because qemu_loadvm_state() may access guest memory
        * while loading device states, which can cause page faults already.
        */

> +    if (migrate_postcopy_ram() && migrate_mapped_ram()) {
> +        migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> +                          MIGRATION_STATUS_POSTCOPY_DEVICE);
> +
> +        if (ram_postcopy_incoming_init(mis, &local_err)) {
> +            goto fail;
> +        }
> +
> +        postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
> +        if (postcopy_ram_incoming_setup(mis, &local_err)) {
> +            goto fail;
> +        }
> +    }
> +
>      mis->loadvm_co = qemu_coroutine_self();
>      ret = qemu_loadvm_state(mis->from_src_file, &local_err);
>      mis->loadvm_co = NULL;
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    if (migrate_postcopy_ram() && migrate_mapped_ram()) {
> +        if (qemu_loadvm_run_fast_snapshot_load(mis->from_src_file, mis,
> +                                               &local_err)) {
> +            goto fail;
> +        }
> +    }
>  
>      trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
>  
>      trace_process_incoming_migration_co_end(ret);
> -    if (mis->have_listen_thread) {
> +    if (migration_incoming_has_postcopy_thread(mis)) {
>          /*
>           * Postcopy was started, cleanup should happen at the end of the
> -         * postcopy listen thread.
> +         * postcopy listen thread or eager load thread.
>           */
>          trace_process_incoming_migration_co_postcopy_end_main();
>          goto out;
> diff --git a/migration/migration.h b/migration/migration.h
> index 841f49b215..540124bc27 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -42,6 +42,7 @@
>  #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
>  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
>  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
> +#define  MIGRATION_THREAD_DST_SNAPSHOT_LOAD "mig/dst/snapshot_load"
>  
>  struct PostcopyBlocktimeContext;
>  typedef struct ThreadPool ThreadPool;
> @@ -120,6 +121,10 @@ struct MigrationIncomingState {
>      bool           have_listen_thread;
>      QemuThread     listen_thread;
>  
> +    /* Thread to load pages eagerly in fast snapshot load case */
> +    bool have_eager_load_thread;
> +    QemuThread eager_load_thread;
> +
>      /* For the kernel to send us notifications */
>      int       userfault_fd;
>      /* To notify the fault_thread to wake, e.g., when need to quit */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index be9edac572..c31abd4339 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2159,7 +2159,7 @@ bool postcopy_is_paused(MigrationStatus status)
>          status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
>  }
>  
> -static void postcopy_listen_thread_bh(void *opaque)
> +static void postcopy_incoming_complete_bh(void *opaque)
>  {
>      MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
> @@ -2267,7 +2267,7 @@ out:
>      rcu_unregister_thread();
>      postcopy_state_set(POSTCOPY_INCOMING_END);
>  
> -    migration_bh_schedule(postcopy_listen_thread_bh, NULL);
> +    migration_bh_schedule(postcopy_incoming_complete_bh, NULL);

Nitpick: this rename change can be a tiny separate patch.

>  
>      object_unref(OBJECT(migr));
>  
> @@ -2311,9 +2311,79 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
>          mis->have_listen_thread = false;
>      }
>  
> +    if (mis->have_eager_load_thread) {
> +        qemu_thread_join(&mis->eager_load_thread);
> +        mis->have_eager_load_thread = false;
> +    }
> +
>      if (migrate_postcopy_ram()) {
>          rc = postcopy_ram_incoming_cleanup(mis);
>      }
>  
>      return rc;
>  }
> +
> +/*
> + * Called by postcopy_ram_eager_load_thread over all blocks to load in all the
> + * pending pages of given ram block
> + */
> +static int ram_block_load_eager(RAMBlock *rb, void *opaque)
> +{
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    MigrationState *s = migrate_get_current();
> +    Error *errp = NULL;
> +    void *host = qemu_ram_get_host_addr(rb);
> +    void *target;
> +
> +    for (ram_addr_t page_loc = 0; page_loc < rb->used_length;
> +         page_loc += qemu_ram_pagesize(rb)) {
> +        target = (uint8_t *)host + page_loc;
> +        if (!postcopy_mapped_ram_load_page(mis, rb, page_loc, (uint64_t)target,
> +                                           RAM_CHANNEL_PRECOPY, &errp)) {
> +            migrate_error_propagate(s, errp);
> +            return 1;

Nit: return a negative (e.g. -1) might be clearer for an error.

> +        }
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Used by fast snapshot load to eagerly load in all pages of RAM and schedule
> + * cleanup after entire RAM is loaded
> + */
> +static void *postcopy_ram_eager_load_thread(void *opaque)
> +{
> +    MigrationIncomingState *mis = opaque;
> +
> +    trace_postcopy_ram_eager_load_thread_entry();
> +    rcu_register_thread();
> +    qemu_event_set(&mis->thread_sync_event);
> +
> +    if (foreach_not_ignored_block(ram_block_load_eager, NULL)) {
> +        migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                          MIGRATION_STATUS_FAILED);
> +        goto out;
> +    }
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                      MIGRATION_STATUS_COMPLETED);
> +
> +out:
> +    postcopy_state_set(POSTCOPY_INCOMING_END);
> +    migration_bh_schedule(postcopy_incoming_complete_bh, mis);
> +
> +    rcu_unregister_thread();
> +    trace_postcopy_ram_eager_load_thread_exit();
> +    return NULL;
> +}
> +
> +/*
> + * Create thread for eager loading in fast snapshot load case
> + */
> +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis)
> +{
> +    postcopy_thread_create(
> +        mis, &mis->eager_load_thread, MIGRATION_THREAD_DST_SNAPSHOT_LOAD,
> +        postcopy_ram_eager_load_thread, QEMU_THREAD_JOINABLE);
> +    mis->have_eager_load_thread = true;
> +    return 0;
> +}
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 98d918713f..6d1a296795 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -202,4 +202,6 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
>  int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp);
>  int postcopy_incoming_cleanup(MigrationIncomingState *mis);
>  
> +int postcopy_ram_eager_load_setup(MigrationIncomingState *mis);
> +
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 23adaf9dd9..5857fb8ac2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2959,6 +2959,32 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>      return true;
>  }
>  
> +/*
> + * Starts the VM and launches the eager thread for fast snapshot load
> + */
> +int qemu_loadvm_run_fast_snapshot_load(QEMUFile *f, MigrationIncomingState *mis,
> +                                       Error **errp)
> +{
> +    ERRP_GUARD();
> +    int ret = 0;
> +
> +    postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
> +
> +    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
> +
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +
> +    ret = postcopy_ram_eager_load_setup(mis);

This function never fails, can make it return void and remove the err
handling.

> +    if (ret) {
> +        error_prepend(errp,
> +                      "Failed to setup eager load for fast snapshot load: ");
> +        return ret;
> +    }
> +
> +    return ret;
> +}
> +
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp)
>  {
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 96fdf96d4e..f17d7057e1 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -67,6 +67,8 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
>  int qemu_save_device_state(QEMUFile *f, Error **errp);
>  int qemu_loadvm_state(QEMUFile *f, Error **errp);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> +int qemu_loadvm_run_fast_snapshot_load(QEMUFile *f, MigrationIncomingState *mis,
> +                                       Error **errp);
>  int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
>                             Error **errp);
>  int qemu_load_device_state(QEMUFile *f, Error **errp);
> diff --git a/migration/trace-events b/migration/trace-events
> index de99d976ab..38f11e1e9f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -314,6 +314,8 @@ postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
>  postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
>  postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
>  postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
> +postcopy_ram_eager_load_thread_entry(void) ""
> +postcopy_ram_eager_load_thread_exit(void) ""
>  
>  # exec.c
>  migration_exec_outgoing(const char *cmd) "cmd=%s"
> -- 
> 2.54.0
> 

-- 
Peter Xu


