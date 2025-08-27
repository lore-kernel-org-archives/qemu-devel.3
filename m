Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1BBCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPvC-0005zw-4r; Wed, 27 Aug 2025 19:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1urPv9-0005z5-Nc
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:51:15 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1urPv6-0001E3-AW
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=vjwVueX/oF6/O1zm4rWvykWaTiAyPsQ56YH0ZIU6iRo=; b=K1rU/g+ggTs5ei0Y
 9AQVVKnt0jnLbLnwa6/14X71cCBzqJjmifqsSUZubd5D+A+XKUcghV9f+Kbm0n4AuQdNtDdwVM+fd
 QTInZo2rJzYZIKJggwGAe6jgSg2T93JpLsw5wq2zIzh2BjD1ob5O+S0RaoGO5KngeM2EItK0pjJyu
 as63Ai9u2E+Mp70EAGCzwNeY9cgQMCUZiREITGP32/M4cm3fsqqzvkzs2A8bqWFVRkam00h7yWTtO
 BY+06Hv9XpS0yMzqhkMp1gZpu/1rCJne1hvVZVSuBMmoEH6okBdRqge7+V1PLmmT/RAyOMmQtDEnI
 5rDRtDCOciuEw1sBxw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1urPv0-006sGW-1g;
 Wed, 27 Aug 2025 23:51:06 +0000
Date: Wed, 27 Aug 2025 23:51:06 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Message-ID: <aK-Z6rARUbgNzy5Q@gallifrey>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250827205949.364606-6-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:46:37 up 122 days,  8:00,  1 user,  load average: 0.00, 0.00, 0.00
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
> Migration module was there for 10+ years.  Initially, it was in most cases
> based on coroutines.  As more features were added into the framework, like
> postcopy, multifd, etc.. it became a mixture of threads and coroutines.
> 
> I'm guessing coroutines just can't fix all issues that migration want to
> resolve.

Yeh migration can happily eat a whole core.

> After all these years, migration is now heavily based on a threaded model.
> 
> Now there's still a major part of migration framework that is still not
> thread-based, which is precopy load.  We do load in a separate thread in
> postcopy since the 1st day postcopy was introduced, however that requires a
> separate state transition from precopy loading all devices first, which
> still happens in the main thread of a coroutine.

...

> COLO
> ====

If you can I suggest splitting the COLO stuff out as a separate thread,
not many people understand it.

> TODO
> ====
> 
> Currently the BQL is taken during loading of a START|FULL section.  When
> the IO hangs (e.g. network issue) during this process, it could potentially
> block others like the monitor servers.  One solution is breaking BQL to
> smaller granule and leave IOs to be always BQL-free.  That'll need more
> justifications.
> 
> For example, there are at least four things that need some closer
> attention:
> 
>   - SaveVMHandlers's load_state(): this likely DO NOT need BQL, but we need
>   to justify all of them (not to mention, some of them look like prone to
>   be rewritten as VMSDs..)
> 
>   - VMSD's pre_load(): in most cases, this DO NOT really need BQL, but
>   sometimes maybe it will!  Double checking on this will be needed.
> 
>   - VMSD's post_load(): in many cases, this DO need BQL, for example on
>   address space operations.  Likely we should just take it for any
>   post_load().
> 
>   - VMSD field's get(): this is tricky!  It could internally be anything
>   even if it was only a field.  E.g. there can be users to use a SINGLE
>   field to load a whole VMSD, which can further introduce more
>   possibilities.

Long long ago, I did convert some get's to structure; I got stuck on some
though - some have pretty crazy hand built lists and things.

> In general, QEMUFile IOs should not need BQL, that is when receiving the
> VMSD data and waiting for e.g. the socket buffer to get refilled.  But
> that's the easy part.

It's probably generally a good thing to get rid of the BQL there, but I bet
it's going to throw some surprises; maybe something like devices doing
stuff before the migration has fully arrived or incoming socket connections
to non-migration stuff perhaps.

Dave

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/migration/colo.h |  6 ++--
>  migration/migration.h    | 52 ++++++++++++++++++++++++++------
>  migration/savevm.h       |  5 ++--
>  migration/channel.c      |  7 ++---
>  migration/colo-stubs.c   |  2 +-
>  migration/colo.c         | 23 ++++-----------
>  migration/migration.c    | 62 ++++++++++++++++++++++++++++----------
>  migration/rdma.c         |  5 ----
>  migration/savevm.c       | 64 ++++++++++++++++++++++++----------------
>  migration/trace-events   |  4 +--
>  10 files changed, 142 insertions(+), 88 deletions(-)
> 
> diff --git a/include/migration/colo.h b/include/migration/colo.h
> index 43222ef5ae..bfb30eccf0 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -44,12 +44,10 @@ void colo_do_failover(void);
>  void colo_checkpoint_delay_set(void);
>  
>  /*
> - * Starts COLO incoming process. Called from process_incoming_migration_co()
> + * Starts COLO incoming process. Called from migration_incoming_thread()
>   * after loading the state.
> - *
> - * Called with BQL locked, may temporary release BQL.
>   */
> -void coroutine_fn colo_incoming_co(void);
> +void colo_incoming_wait(void);
>  
>  void colo_shutdown(void);
>  #endif
> diff --git a/migration/migration.h b/migration/migration.h
> index 01329bf824..c4a626eed4 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -42,6 +42,44 @@
>  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
>  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"
>  
> +/**
> + * WITH_BQL_HELD(): Run a task, making sure BQL is held
> + *
> + * @bql_held: Whether BQL is already held
> + * @task:     The task to run within BQL held
> + */
> +#define  WITH_BQL_HELD(bql_held, task)          \
> +    do {                                        \
> +        if (!bql_held) {                        \
> +            bql_lock();                         \
> +        } else {                                \
> +            assert(bql_locked());               \
> +        }                                       \
> +        task;                                   \
> +        if (!bql_held) {                        \
> +            bql_unlock();                       \
> +        }                                       \
> +    } while (0)
> +
> +/**
> + * WITHOUT_BQL_HELD(): Run a task, making sure BQL is released
> + *
> + * @bql_held: Whether BQL is already held
> + * @task:     The task to run making sure BQL released
> + */
> +#define  WITHOUT_BQL_HELD(bql_held, task)       \
> +    do {                                        \
> +        if (bql_held) {                         \
> +            bql_unlock();                       \
> +        } else {                                \
> +            assert(!bql_locked());              \
> +        }                                       \
> +        task;                                   \
> +        if (bql_held) {                         \
> +            bql_lock();                         \
> +        }                                       \
> +    } while (0)
> +
>  struct PostcopyBlocktimeContext;
>  typedef struct ThreadPool ThreadPool;
>  
> @@ -119,6 +157,10 @@ struct MigrationIncomingState {
>      bool           have_listen_thread;
>      QemuThread     listen_thread;
>  
> +    /* Migration main recv thread */
> +    bool           have_recv_thread;
> +    QemuThread     recv_thread;
> +
>      /* For the kernel to send us notifications */
>      int       userfault_fd;
>      /* To notify the fault_thread to wake, e.g., when need to quit */
> @@ -177,15 +219,7 @@ struct MigrationIncomingState {
>  
>      MigrationStatus state;
>  
> -    /*
> -     * The incoming migration coroutine, non-NULL during qemu_loadvm_state().
> -     * Used to wake the migration incoming coroutine from rdma code. How much is
> -     * it safe - it's a question.
> -     */
> -    Coroutine *loadvm_co;
> -
> -    /* The coroutine we should enter (back) after failover */
> -    Coroutine *colo_incoming_co;
> +    /* Notify secondary VM to move on */
>      QemuEvent colo_incoming_event;
>  
>      /* Optional load threads pool and its thread exit request flag */
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 2d5e9c7166..c07e14f61a 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -64,9 +64,10 @@ void qemu_savevm_send_colo_enable(QEMUFile *f);
>  void qemu_savevm_live_state(QEMUFile *f);
>  int qemu_save_device_state(QEMUFile *f);
>  
> -int qemu_loadvm_state(QEMUFile *f);
> +int qemu_loadvm_state(QEMUFile *f, bool bql_held);
>  void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           bool bql_held);
>  int qemu_load_device_state(QEMUFile *f);
>  int qemu_loadvm_approve_switchover(void);
>  int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> diff --git a/migration/channel.c b/migration/channel.c
> index a547b1fbfe..621f8a4a2a 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -136,11 +136,8 @@ int migration_channel_read_peek(QIOChannel *ioc,
>          }
>  
>          /* 1ms sleep. */
> -        if (qemu_in_coroutine()) {
> -            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
> -        } else {
> -            g_usleep(1000);
> -        }
> +        assert(!qemu_in_coroutine());
> +        g_usleep(1000);
>      }
>  
>      return 0;
> diff --git a/migration/colo-stubs.c b/migration/colo-stubs.c
> index e22ce65234..ef77d1ab4b 100644
> --- a/migration/colo-stubs.c
> +++ b/migration/colo-stubs.c
> @@ -9,7 +9,7 @@ void colo_shutdown(void)
>  {
>  }
>  
> -void coroutine_fn colo_incoming_co(void)
> +void colo_incoming_wait(void)
>  {
>  }
>  
> diff --git a/migration/colo.c b/migration/colo.c
> index e0f713c837..f5722d9d9d 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -147,11 +147,6 @@ static void secondary_vm_do_failover(void)
>      }
>      /* Notify COLO incoming thread that failover work is finished */
>      qemu_event_set(&mis->colo_incoming_event);
> -
> -    /* For Secondary VM, jump to incoming co */
> -    if (mis->colo_incoming_co) {
> -        qemu_coroutine_enter(mis->colo_incoming_co);
> -    }
>  }
>  
>  static void primary_vm_do_failover(void)
> @@ -686,7 +681,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>  
>      bql_lock();
>      cpu_synchronize_all_states();
> -    ret = qemu_loadvm_state_main(mis->from_src_file, mis);
> +    ret = qemu_loadvm_state_main(mis->from_src_file, mis, true);
>      bql_unlock();
>  
>      if (ret < 0) {
> @@ -854,10 +849,8 @@ static void *colo_process_incoming_thread(void *opaque)
>          goto out;
>      }
>      /*
> -     * Note: the communication between Primary side and Secondary side
> -     * should be sequential, we set the fd to unblocked in migration incoming
> -     * coroutine, and here we are in the COLO incoming thread, so it is ok to
> -     * set the fd back to blocked.
> +     * Here we are in the COLO incoming thread, so it is ok to set the fd
> +     * to blocked.
>       */
>      qemu_file_set_blocking(mis->from_src_file, true);
>  
> @@ -930,26 +923,20 @@ out:
>      return NULL;
>  }
>  
> -void coroutine_fn colo_incoming_co(void)
> +/* Wait for failover */
> +void colo_incoming_wait(void)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      QemuThread th;
>  
> -    assert(bql_locked());
>      assert(migration_incoming_colo_enabled());
>  
>      qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
>                         colo_process_incoming_thread,
>                         mis, QEMU_THREAD_JOINABLE);
>  
> -    mis->colo_incoming_co = qemu_coroutine_self();
> -    qemu_coroutine_yield();
> -    mis->colo_incoming_co = NULL;
> -
> -    bql_unlock();
>      /* Wait checkpoint incoming thread exit before free resource */
>      qemu_thread_join(&th);
> -    bql_lock();
>  
>      /* We hold the global BQL, so it is safe here */
>      colo_release_ram_cache();
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..7e4d25b15c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -494,6 +494,11 @@ void migration_incoming_state_destroy(void)
>          mis->postcopy_qemufile_dst = NULL;
>      }
>  
> +    if (mis->have_recv_thread) {
> +        qemu_thread_join(&mis->recv_thread);
> +        mis->have_recv_thread = false;
> +    }
> +
>      cpr_set_incoming_mode(MIG_MODE_NONE);
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>  }
> @@ -864,30 +869,46 @@ static void process_incoming_migration_bh(void *opaque)
>      migration_incoming_state_destroy();
>  }
>  
> -static void coroutine_fn
> -process_incoming_migration_co(void *opaque)
> +static void migration_incoming_state_destroy_bh(void *opaque)
> +{
> +    struct MigrationIncomingState *mis = opaque;
> +
> +    if (mis->exit_on_error) {
> +        /*
> +         * NOTE: this exit() should better happen in the main thread, as
> +         * the exit notifier may require BQL which can deadlock.  See
> +         * commit e7bc0204e57836 for example.
> +         */
> +        exit(EXIT_FAILURE);
> +    }
> +
> +    migration_incoming_state_destroy();
> +}
> +
> +static void *migration_incoming_thread(void *opaque)
>  {
>      MigrationState *s = migrate_get_current();
> -    MigrationIncomingState *mis = migration_incoming_get_current();
> +    MigrationIncomingState *mis = opaque;
>      PostcopyState ps;
>      int ret;
>      Error *local_err = NULL;
>  
> +    rcu_register_thread();
> +
>      assert(mis->from_src_file);
> +    assert(!bql_locked());
>  
>      mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
>                        MIGRATION_STATUS_ACTIVE);
>  
> -    mis->loadvm_co = qemu_coroutine_self();
> -    ret = qemu_loadvm_state(mis->from_src_file);
> -    mis->loadvm_co = NULL;
> +    ret = qemu_loadvm_state(mis->from_src_file, false);
>  
>      trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
>  
>      ps = postcopy_state_get();
> -    trace_process_incoming_migration_co_end(ret, ps);
> +    trace_process_incoming_migration_end(ret, ps);
>      if (ps != POSTCOPY_INCOMING_NONE) {
>          if (ps == POSTCOPY_INCOMING_ADVISE) {
>              /*
> @@ -901,7 +922,7 @@ process_incoming_migration_co(void *opaque)
>               * Postcopy was started, cleanup should happen at the end of the
>               * postcopy thread.
>               */
> -            trace_process_incoming_migration_co_postcopy_end_main();
> +            trace_process_incoming_migration_postcopy_end_main();
>              goto out;
>          }
>          /* Else if something went wrong then just fall out of the normal exit */
> @@ -913,8 +934,8 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (migration_incoming_colo_enabled()) {
> -        /* yield until COLO exit */
> -        colo_incoming_co();
> +        /* wait until COLO exits */
> +        colo_incoming_wait();
>      }
>  
>      migration_bh_schedule(process_incoming_migration_bh, mis);
> @@ -926,19 +947,24 @@ fail:
>      migrate_set_error(s, local_err);
>      error_free(local_err);
>  
> -    migration_incoming_state_destroy();
> -
>      if (mis->exit_on_error) {
>          WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>              error_report_err(s->error);
>              s->error = NULL;
>          }
> -
> -        exit(EXIT_FAILURE);
>      }
> +
> +    /*
> +     * There's some step of the destroy process that will need to happen in
> +     * the main thread (e.g. joining this thread itself).  Leave to a BH.
> +     */
> +    migration_bh_schedule(migration_incoming_state_destroy_bh, (void *)mis);
> +
>  out:
>      /* Pairs with the refcount taken in qmp_migrate_incoming() */
>      migrate_incoming_unref_outgoing_state();
> +    rcu_unregister_thread();
> +    return NULL;
>  }
>  
>  /**
> @@ -956,8 +982,12 @@ static void migration_incoming_setup(QEMUFile *f)
>  
>  void migration_incoming_process(void)
>  {
> -    Coroutine *co = qemu_coroutine_create(process_incoming_migration_co, NULL);
> -    qemu_coroutine_enter(co);
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    mis->have_recv_thread = true;
> +    qemu_thread_create(&mis->recv_thread, "mig/dst/main",
> +                       migration_incoming_thread, mis,
> +                       QEMU_THREAD_JOINABLE);
>  }
>  
>  /* Returns true if recovered from a paused migration, otherwise false */
> diff --git a/migration/rdma.c b/migration/rdma.c
> index bcd7aae2f2..2b995513aa 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3068,7 +3068,6 @@ static void rdma_cm_poll_handler(void *opaque)
>  {
>      RDMAContext *rdma = opaque;
>      struct rdma_cm_event *cm_event;
> -    MigrationIncomingState *mis = migration_incoming_get_current();
>  
>      if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
>          error_report("get_cm_event failed %d", errno);
> @@ -3087,10 +3086,6 @@ static void rdma_cm_poll_handler(void *opaque)
>              }
>          }
>          rdma_ack_cm_event(cm_event);
> -        if (mis->loadvm_co) {
> -            qemu_coroutine_enter(mis->loadvm_co);
> -        }
> -        return;
>      }
>      rdma_ack_cm_event(cm_event);
>  }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296a..ad606c5425 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -154,11 +154,10 @@ static void qemu_loadvm_thread_pool_destroy(MigrationIncomingState *mis)
>  }
>  
>  static bool qemu_loadvm_thread_pool_wait(MigrationState *s,
> -                                         MigrationIncomingState *mis)
> +                                         MigrationIncomingState *mis,
> +                                         bool bql_held)
>  {
> -    bql_unlock(); /* Let load threads do work requiring BQL */
> -    thread_pool_wait(mis->load_threads);
> -    bql_lock();
> +    WITHOUT_BQL_HELD(bql_held, thread_pool_wait(mis->load_threads));
>  
>      return !migrate_has_error(s);
>  }
> @@ -2091,14 +2090,11 @@ static void *postcopy_ram_listen_thread(void *opaque)
>      trace_postcopy_ram_listen_thread_start();
>  
>      rcu_register_thread();
> -    /*
> -     * Because we're a thread and not a coroutine we can't yield
> -     * in qemu_file, and thus we must be blocking now.
> -     */
> +    /* Because we're a thread, making sure to use blocking mode */
>      qemu_file_set_blocking(f, true);
>  
>      /* TODO: sanity check that only postcopiable data will be loaded here */
> -    load_res = qemu_loadvm_state_main(f, mis);
> +    load_res = qemu_loadvm_state_main(f, mis, false);
>  
>      /*
>       * This is tricky, but, mis->from_src_file can change after it
> @@ -2392,13 +2388,14 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
>   * Immediately following this command is a blob of data containing an embedded
>   * chunk of migration stream; read it and load it.
>   *
> - * @mis: Incoming state
> - * @length: Length of packaged data to read
> + * @mis:      Incoming state
> + * @bql_held: Whether BQL is held already
>   *
>   * Returns: Negative values on error
>   *
>   */
> -static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
> +static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
> +                                      bool bql_held)
>  {
>      int ret;
>      size_t length;
> @@ -2449,7 +2446,7 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis)
>          qemu_coroutine_yield();
>      } while (1);
>  
> -    ret = qemu_loadvm_state_main(packf, mis);
> +    ret = qemu_loadvm_state_main(packf, mis, bql_held);
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);
>      object_unref(OBJECT(bioc));
> @@ -2539,7 +2536,7 @@ static int loadvm_postcopy_handle_switchover_start(void)
>   * LOADVM_QUIT All good, but exit the loop
>   * <0          Error
>   */
> -static int loadvm_process_command(QEMUFile *f)
> +static int loadvm_process_command(QEMUFile *f, bool bql_held)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      uint16_t cmd;
> @@ -2609,7 +2606,7 @@ static int loadvm_process_command(QEMUFile *f)
>          break;
>  
>      case MIG_CMD_PACKAGED:
> -        return loadvm_handle_cmd_packaged(mis);
> +        return loadvm_handle_cmd_packaged(mis, bql_held);
>  
>      case MIG_CMD_POSTCOPY_ADVISE:
>          return loadvm_postcopy_handle_advise(mis, len);
> @@ -3028,7 +3025,8 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>      return true;
>  }
>  
> -int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
> +int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
> +                           bool bql_held)
>  {
>      uint8_t section_type;
>      int ret = 0;
> @@ -3046,7 +3044,15 @@ retry:
>          switch (section_type) {
>          case QEMU_VM_SECTION_START:
>          case QEMU_VM_SECTION_FULL:
> -            ret = qemu_loadvm_section_start_full(f, section_type);
> +            /*
> +             * FULL should normally require BQL, e.g. during post_load()
> +             * there can be memory region updates.  START may or may not
> +             * require it, but just to keep it simple to always hold BQL
> +             * for now.
> +             */
> +            WITH_BQL_HELD(
> +                bql_held,
> +                ret = qemu_loadvm_section_start_full(f, section_type));
>              if (ret < 0) {
>                  goto out;
>              }
> @@ -3059,7 +3065,11 @@ retry:
>              }
>              break;
>          case QEMU_VM_COMMAND:
> -            ret = loadvm_process_command(f);
> +            /*
> +             * Be careful; QEMU_VM_COMMAND can embed FULL sections, so it
> +             * may internally need BQL.
> +             */
> +            ret = loadvm_process_command(f, bql_held);
>              trace_qemu_loadvm_state_section_command(ret);
>              if ((ret < 0) || (ret == LOADVM_QUIT)) {
>                  goto out;
> @@ -3103,7 +3113,7 @@ out:
>      return ret;
>  }
>  
> -int qemu_loadvm_state(QEMUFile *f)
> +int qemu_loadvm_state(QEMUFile *f, bool bql_held)
>  {
>      MigrationState *s = migrate_get_current();
>      MigrationIncomingState *mis = migration_incoming_get_current();
> @@ -3131,9 +3141,10 @@ int qemu_loadvm_state(QEMUFile *f)
>          qemu_loadvm_state_switchover_ack_needed(mis);
>      }
>  
> -    cpu_synchronize_all_pre_loadvm();
> +    /* run_on_cpu() requires BQL */
> +    WITH_BQL_HELD(bql_held, cpu_synchronize_all_pre_loadvm());
>  
> -    ret = qemu_loadvm_state_main(f, mis);
> +    ret = qemu_loadvm_state_main(f, mis, bql_held);
>      qemu_event_set(&mis->main_thread_load_event);
>  
>      trace_qemu_loadvm_state_post_main(ret);
> @@ -3149,7 +3160,7 @@ int qemu_loadvm_state(QEMUFile *f)
>      /* When reaching here, it must be precopy */
>      if (ret == 0) {
>          if (migrate_has_error(migrate_get_current()) ||
> -            !qemu_loadvm_thread_pool_wait(s, mis)) {
> +            !qemu_loadvm_thread_pool_wait(s, mis, bql_held)) {
>              ret = -EINVAL;
>          } else {
>              ret = qemu_file_get_error(f);
> @@ -3196,7 +3207,8 @@ int qemu_loadvm_state(QEMUFile *f)
>          }
>      }
>  
> -    cpu_synchronize_all_post_init();
> +    /* run_on_cpu() requires BQL */
> +    WITH_BQL_HELD(bql_held, cpu_synchronize_all_post_init());
>  
>      return ret;
>  }
> @@ -3207,7 +3219,7 @@ int qemu_load_device_state(QEMUFile *f)
>      int ret;
>  
>      /* Load QEMU_VM_SECTION_FULL section */
> -    ret = qemu_loadvm_state_main(f, mis);
> +    ret = qemu_loadvm_state_main(f, mis, true);
>      if (ret < 0) {
>          error_report("Failed to load device state: %d", ret);
>          return ret;
> @@ -3438,7 +3450,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>      f = qemu_file_new_input(QIO_CHANNEL(ioc));
>      object_unref(OBJECT(ioc));
>  
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, true);
>      qemu_fclose(f);
>      if (ret < 0) {
>          error_setg(errp, "loading Xen device state failed");
> @@ -3512,7 +3524,7 @@ bool load_snapshot(const char *name, const char *vmstate,
>          ret = -EINVAL;
>          goto err_drain;
>      }
> -    ret = qemu_loadvm_state(f);
> +    ret = qemu_loadvm_state(f, true);
>      migration_incoming_state_destroy();
>  
>      bdrv_drain_all_end();
> diff --git a/migration/trace-events b/migration/trace-events
> index 706db97def..eeb41e03f1 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -193,8 +193,8 @@ source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
>  source_return_path_thread_switchover_acked(void) ""
>  migration_thread_low_pending(uint64_t pending) "%" PRIu64
>  migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
> -process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> -process_incoming_migration_co_postcopy_end_main(void) ""
> +process_incoming_migration_end(int ret, int ps) "ret=%d postcopy-state=%d"
> +process_incoming_migration_postcopy_end_main(void) ""
>  postcopy_preempt_enabled(bool value) "%d"
>  migration_precopy_complete(void) ""
>  
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

