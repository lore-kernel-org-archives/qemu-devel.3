Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2C5CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEGL-0006bi-0A; Wed, 29 Oct 2025 18:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEEGG-0006b8-Ju
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEEFy-0000YT-2p
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761775372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7NxlBbvqBwlw1fohbdtps4ENnmGxVqJaGbmUUslBj2k=;
 b=DmfnukyNYoG5YEYOWgqYreRcLWOe13uwP5+dy1VmuQzI55EB5/r49pGy7FwjF5mTnp8MhM
 yWgXAYwYdl8N30AjviqBaXZmqpDxrp/4wTNn1cdzLs92eeN4U92nhgfW+/RdxVU+J7IDC3
 ciUB3Cpa01Cw96KUqCu7/EcSn8YZB9g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-2yyR-g5iOAOJ174KzK0boA-1; Wed, 29 Oct 2025 18:02:51 -0400
X-MC-Unique: 2yyR-g5iOAOJ174KzK0boA-1
X-Mimecast-MFC-AGG-ID: 2yyR-g5iOAOJ174KzK0boA_1761775370
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8a65ae81245so98128585a.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 15:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775370; x=1762380170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NxlBbvqBwlw1fohbdtps4ENnmGxVqJaGbmUUslBj2k=;
 b=d3u4uAxap2Tic9mZ6Uck5WBNfM/ue3NTAXiTi353nZbhxdRYlWlXwKQjvLIwJGqbeE
 uHammcFPe4Z3AE/9UR70i9bH+kOywHhUOfWL6fgIZnN5qMNOg0FJjjsR4s/H6IzMfUVp
 WYe/X+nA5qDYOUTGXgYGgktwl+/xuwF8pwNtDFdZ0OGezOU3GL5w4O7PM8OASCnwdtw8
 GKO6DbXb/QGbm9Fv8AW6Y46Q4unD7KnRDhigOBP5wPKzWD8cg4YZLtHTci57NPQJ+3hb
 Gpl5Qv9ER5Pt1NtaNiDMx7rm4sJLEkFWl4XQxBBHBB54cd0iic7OvHn8GJqKuMhay1vB
 TKGA==
X-Gm-Message-State: AOJu0YxG9/7ZEAOmpC6BkE23hY5XWno58xpIqweufz72Q6BLhsxK0dc5
 ImVv3/Lzf5RGkT3H8CItCmpgx2C3FX9iWCjf2cl/IpX3cD7JvwkvGtl/wk9CcJqucuDDTnlTXxl
 9E96Wl9bJthHjOD4zIGzTHG3tCvUumC5Yo9CH4e+t4h0u+YfJnitHBwjZ
X-Gm-Gg: ASbGnctWNSS2DHw3hjvtb13tUlImvTnEOHsfN5jbAMFuxtX3l6k2A/IZmplWWkk4Nmq
 wZLHe4/5JgF6tJXiD4VXP7p32Vw360g1qC5HQ2fzEhdNFH+epnnHbDDTrgsHeEK0d6hZZ+CYWbo
 Ta7zM60US5r2iB2SkZXMBNqheRGeAFP4TBqIb5aQMyWoZOjoKNeQ9BY/zFxMbmh/WTc1sarBjWN
 oCp5uaEbbBFxB5UeX1IdvYjLmS1u7SjZh00geyYJFjGpcQHXN9c2SQ1Mj8aoCfp3DaB59zlL+X2
 UD9i33Jb7qpD+aXQaaH/YfnK1iDeBiMOs+5pR6yHLx15I8sWWSywKguMEqITxXGDwaI=
X-Received: by 2002:a05:620a:1927:b0:880:d691:2af7 with SMTP id
 af79cd13be357-8a8e5f929a0mr601025485a.79.1761775370087; 
 Wed, 29 Oct 2025 15:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh8jtrbqSILyRMRy6GyOQTN74R1hxBhJUF9HI8OLrMTE76/41sUOibh/yN0d8d3DgIBLuGfQ==
X-Received: by 2002:a05:620a:1927:b0:880:d691:2af7 with SMTP id
 af79cd13be357-8a8e5f929a0mr601018085a.79.1761775369413; 
 Wed, 29 Oct 2025 15:02:49 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421f8b8sm1151072885a.7.2025.10.29.15.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 15:02:48 -0700 (PDT)
Date: Wed, 29 Oct 2025 18:02:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 3/4] migration: Refactor all incoming cleanup into
 migration_incoming_cleanup()
Message-ID: <aQKPB3zQjn2GOdF3@x1.local>
References: <20251027154115.4138677-1-jmarcin@redhat.com>
 <20251027154115.4138677-4-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251027154115.4138677-4-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Mon, Oct 27, 2025 at 04:41:10PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, there are two functions that are responsible for cleanup of
> the incoming migration state. With successful precopy, it's the process
> incoming migration coroutine and with successful postcopy it's the
> postcopy listen thread. However, if postcopy fails during in the device
> load, both functions will try to do the cleanup. Moreover, when
> exit-on-error parameter was added, it was applied only to precopy.
> 
> This patch introduces exit-on-error to postcopy and refactors incoming
> migration cleanup into a common function while defining a clear boundary
> of who is responsible for the cleanup. The process incoming migration
> coroutine is responsible for running the cleanup function, unless the
> listen thread has been started (the postcopy state is at least in
> LISTENING phase), in which case the postcopy listen thread runs the
> incoming migration cleanup in a BH, which also joins the listen thread.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration-hmp-cmds.c |  2 +-
>  migration/migration.c          | 77 +++++++++++++++++-----------------
>  migration/migration.h          |  4 +-
>  migration/postcopy-ram.c       | 53 ++++++++++-------------
>  migration/savevm.c             |  4 +-
>  qapi/migration.json            |  9 +++-
>  system/vl.c                    |  3 +-
>  7 files changed, 75 insertions(+), 77 deletions(-)
> 
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
> index 847d18faaa..c572c1fb28 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -521,7 +521,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>      }
>      QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
>  
> -    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
> +    qmp_migrate_incoming(NULL, true, caps, true, false, true, false, &err);
>      qapi_free_MigrationChannelList(caps);
>  
>  end:
> diff --git a/migration/migration.c b/migration/migration.c
> index 8827884a15..2cc6327c39 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -328,6 +328,7 @@ void migration_object_init(void)
>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +    current_incoming->postcopy_exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;

Postcopy by default should almost be ignoring such concept of exit-on-error
because postcopy cannot fail as long as reaching ACTIVE..

Then this new flag is only about the device state transfer, which is a
trivially small window.  The thing is, we were broken anyway for this small
window before this series if it can fail... So personally I still prefer
reusing exit-on-error for this very small window, and I keep thinking
having a new knob is an overkill..

We used to get some complains on having too much knobs for migration.  I
used to scan them, most of them were still useful.  However IMHO we should
still avoid introducing new configurables unless it is required.

>  
>      migration_object_check(current_migration, &error_fatal);
>  
> @@ -436,12 +437,18 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
>      }
>  }
>  
> -void migration_incoming_state_destroy(void)
> +void migration_incoming_cleanup(void)
>  {
> -    struct MigrationIncomingState *mis = migration_incoming_get_current();
> +    MigrationState *ms = migrate_get_current();
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +    PostcopyState ps = postcopy_state_get();
>  
>      multifd_recv_cleanup();
>  
> +    if (ps != POSTCOPY_INCOMING_NONE) {
> +        postcopy_incoming_cleanup(mis);
> +    }
> +
>      /*
>       * RAM state cleanup needs to happen after multifd cleanup, because
>       * multifd threads can use some of its states (receivedmap).
> @@ -493,6 +500,22 @@ void migration_incoming_state_destroy(void)
>  
>      cpr_set_incoming_mode(MIG_MODE_NONE);
>      yank_unregister_instance(MIGRATION_YANK_INSTANCE);
> +
> +    if (mis->state == MIGRATION_STATUS_FAILED &&
> +        ((ps < POSTCOPY_INCOMING_LISTENING && mis->exit_on_error) ||
> +         (ps >= POSTCOPY_INCOMING_LISTENING && mis->postcopy_exit_on_error))) {
> +        WITH_QEMU_LOCK_GUARD(&ms->error_mutex) {
> +            error_report_err(ms->error);
> +            ms->error = NULL;
> +        }
> +
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
> +void migration_incoming_cleanup_bh(void *opaque)
> +{
> +    migration_incoming_cleanup();
>  }
>  
>  static void migrate_generate_event(MigrationStatus new_state)
> @@ -858,7 +881,7 @@ static void process_incoming_migration_bh(void *opaque)
>       */
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COMPLETED);
> -    migration_incoming_state_destroy();
> +    migration_incoming_cleanup();
>  }
>  
>  static void coroutine_fn
> @@ -885,23 +908,13 @@ process_incoming_migration_co(void *opaque)
>  
>      ps = postcopy_state_get();
>      trace_process_incoming_migration_co_end(ret, ps);
> -    if (ps != POSTCOPY_INCOMING_NONE) {
> -        if (ps == POSTCOPY_INCOMING_ADVISE) {
> -            /*
> -             * Where a migration had postcopy enabled (and thus went to advise)
> -             * but managed to complete within the precopy period, we can use
> -             * the normal exit.
> -             */
> -            postcopy_incoming_cleanup(mis);
> -        } else if (ret >= 0) {
> -            /*
> -             * Postcopy was started, cleanup should happen at the end of the
> -             * postcopy thread.
> -             */
> -            trace_process_incoming_migration_co_postcopy_end_main();
> -            goto out;
> -        }
> -        /* Else if something went wrong then just fall out of the normal exit */
> +    if (ps >= POSTCOPY_INCOMING_LISTENING) {
> +        /*
> +         * Postcopy was started, cleanup should happen at the end of the
> +         * postcopy listen thread.
> +         */

I think this is correct.  However since we've removed most of the ps checks
(which is definitely good.. this path was very hard to read before this
series) then here IMHO we could also directly detect the existance of the
thread:

  if (mis->have_listen_thread)
      ...

That'll make it crystal clear to skip cleanup when the thread is created,
irrelevant of how POSTCOPY status is relevant to the "thread creation"
operation itself, e.g. if we have a fail path after set LISTEN but before
creating the thread then we may have issues.

Side benefit is we can drop postcopy_state_get() call too above.

> +        trace_process_incoming_migration_co_postcopy_end_main();
> +        goto out;
>      }
>  
>      if (ret < 0) {
> @@ -924,25 +937,7 @@ fail:
>      migrate_set_error(s, local_err);
>      error_free(local_err);
>  
> -    migration_incoming_state_destroy();
> -
> -    if (mis->exit_on_error) {
> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -            error_report_err(s->error);
> -            s->error = NULL;
> -        }
> -
> -        exit(EXIT_FAILURE);
> -    } else {
> -        /*
> -         * Report the error here in case that QEMU abruptly exits
> -         * when postcopy is enabled.
> -         */
> -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -            error_report_err(s->error);
> -            s->error = NULL;
> -        }
> -    }
> +    migration_incoming_cleanup();
>  out:
>      /* Pairs with the refcount taken in qmp_migrate_incoming() */
>      migrate_incoming_unref_outgoing_state();
> @@ -1968,6 +1963,8 @@ void migrate_del_blocker(Error **reasonp)
>  void qmp_migrate_incoming(const char *uri, bool has_channels,
>                            MigrationChannelList *channels,
>                            bool has_exit_on_error, bool exit_on_error,
> +                          bool has_postcopy_exit_on_error,
> +                          bool postcopy_exit_on_error,
>                            Error **errp)
>  {
>      Error *local_err = NULL;
> @@ -1989,6 +1986,8 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
>  
>      mis->exit_on_error =
>          has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +    mis->postcopy_exit_on_error = has_postcopy_exit_on_error ?
> +        postcopy_exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
>  
>      qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index 01329bf824..9d9e95ae90 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -249,10 +249,12 @@ struct MigrationIncomingState {
>  
>      /* Do exit on incoming migration failure */
>      bool exit_on_error;
> +    bool postcopy_exit_on_error;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> -void migration_incoming_state_destroy(void);
> +void migration_incoming_cleanup(void);
> +void migration_incoming_cleanup_bh(void *opaque);
>  void migration_incoming_transport_cleanup(MigrationIncomingState *mis);
>  /*
>   * Functions to work with blocktime context
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index dbbb2dfb78..0375366ed0 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -2130,53 +2130,37 @@ static void *postcopy_listen_thread(void *opaque)
>                           "bitmaps may be lost, and present migrated dirty "
>                           "bitmaps are correctly migrated and valid.",
>                           __func__, load_res);
> -            load_res = 0; /* prevent further exit() */
>          } else {
> +            /*
> +             * Something went fatally wrong and we have a bad state, QEMU will
> +             * exit depending on if postcopy-exit-on-error is true, but the
> +             * migration cannot be recovered.
> +             */
>              error_prepend(&local_err,
>                            "loadvm failed during postcopy: %d: ", load_res);
>              migrate_set_error(migr, local_err);
>              error_report_err(local_err);
>              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                             MIGRATION_STATUS_FAILED);
> +            goto out;
>          }
>      }
> -    if (load_res >= 0) {
> -        /*
> -         * This looks good, but it's possible that the device loading in the
> -         * main thread hasn't finished yet, and so we might not be in 'RUN'
> -         * state yet; wait for the end of the main thread.
> -         */
> -        qemu_event_wait(&mis->main_thread_load_event);
> -    }
> -    postcopy_incoming_cleanup(mis);
> -
> -    if (load_res < 0) {
> -        /*
> -         * If something went wrong then we have a bad state so exit;
> -         * depending how far we got it might be possible at this point
> -         * to leave the guest running and fire MCEs for pages that never
> -         * arrived as a desperate recovery step.
> -         */
> -        rcu_unregister_thread();
> -        exit(EXIT_FAILURE);
> -    }
> +    /*
> +     * This looks good, but it's possible that the device loading in the
> +     * main thread hasn't finished yet, and so we might not be in 'RUN'
> +     * state yet; wait for the end of the main thread.
> +     */
> +    qemu_event_wait(&mis->main_thread_load_event);
>  
>      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>                                     MIGRATION_STATUS_COMPLETED);
> -    /*
> -     * If everything has worked fine, then the main thread has waited
> -     * for us to start, and we're the last use of the mis.
> -     * (If something broke then qemu will have to exit anyway since it's
> -     * got a bad migration state).
> -     */
> -    bql_lock();
> -    migration_incoming_state_destroy();
> -    bql_unlock();
>  
> +out:
>      rcu_unregister_thread();
> -    mis->have_listen_thread = false;
>      postcopy_state_set(POSTCOPY_INCOMING_END);
>  
> +    migration_bh_schedule(migration_incoming_cleanup_bh, NULL);
> +
>      object_unref(OBJECT(migr));
>  
>      return NULL;
> @@ -2206,7 +2190,7 @@ int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
>      mis->have_listen_thread = true;
>      postcopy_thread_create(mis, &mis->listen_thread,
>                             MIGRATION_THREAD_DST_LISTEN,
> -                           postcopy_listen_thread, QEMU_THREAD_DETACHED);
> +                           postcopy_listen_thread, QEMU_THREAD_JOINABLE);

I feel like some of the changes in this patch can be split into a few more
patches.

>  
>      return 0;
>  }
> @@ -2215,6 +2199,11 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
>  {
>      int rc = 0;
>  
> +    if (mis->have_listen_thread) {
> +        qemu_thread_join(&mis->listen_thread);
> +        mis->have_listen_thread = false;
> +    }
> +
>      if (migrate_postcopy_ram()) {
>          rc = postcopy_ram_incoming_cleanup(mis);
>      }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 96a2699ca7..27fe815731 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3368,7 +3368,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
>      if (ret < 0) {
>          error_prepend(errp, "loading Xen device state failed: ");
>      }
> -    migration_incoming_state_destroy();
> +    migration_incoming_cleanup();
>  }
>  
>  bool load_snapshot(const char *name, const char *vmstate,
> @@ -3438,7 +3438,7 @@ bool load_snapshot(const char *name, const char *vmstate,
>          goto err_drain;
>      }
>      ret = qemu_loadvm_state(f, errp);
> -    migration_incoming_state_destroy();
> +    migration_incoming_cleanup();

Do we need to touch these two places?  I wonder if there'll be side effects
like "exit-on-error" start to affect tither xen load device or load
snapshot, where it used to only apply to live migrations.

>  
>      bdrv_drain_all_end();
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..da5b3a4d8c 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1817,6 +1817,12 @@
>  #     event, and error details could be retrieved with `query-migrate`.
>  #     (since 9.1)
>  #
> +# @postcopy-exit-on-error: same es exit-on-error, but used during postcopy
> +#     migration.  Default true.  When set to true, QEMU only exits if a fatal
> +#     unrecoverable error happens during postcopy, in which case QEMU would
> +#     exit even before the introduction of this option.
> +#     (since 10.2)
> +#
>  # Since: 2.3
>  #
>  # .. admonition:: Notes
> @@ -1870,7 +1876,8 @@
>  { 'command': 'migrate-incoming',
>               'data': {'*uri': 'str',
>                        '*channels': [ 'MigrationChannel' ],
> -                      '*exit-on-error': 'bool' } }
> +                      '*exit-on-error': 'bool',
> +                      '*postcopy-exit-on-error': 'bool' } }
>  
>  ##
>  # @xen-save-devices-state:
> diff --git a/system/vl.c b/system/vl.c
> index 17bbc092c8..1308d92901 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2824,7 +2824,8 @@ void qmp_x_exit_preconfig(Error **errp)
>                  g_new0(MigrationChannelList, 1);
>  
>              channels->value = incoming_channels[MIGRATION_CHANNEL_TYPE_MAIN];
> -            qmp_migrate_incoming(NULL, true, channels, true, true, &local_err);
> +            qmp_migrate_incoming(NULL, true, channels, true, true, true, true,
> +                                 &local_err);
>              if (local_err) {
>                  error_reportf_err(local_err, "-incoming %s: ", incoming);
>                  exit(1);
> -- 
> 2.51.0
> 

-- 
Peter Xu


