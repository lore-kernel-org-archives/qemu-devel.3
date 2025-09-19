Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955DACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 16:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzeFt-00082L-Rz; Fri, 19 Sep 2025 12:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzeFr-00081i-13
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:46:40 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzeFj-0007gS-CR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 12:46:38 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3AF5B1F7E3;
 Fri, 19 Sep 2025 16:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758300385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QKKpiwmPqWSlU3SYjghBBTfip9bKu7h62FAtac00Qw=;
 b=sBWkJibgUX+Licve8CxkcGyGPaWlSd0zTp+OiLq2LXhvoy49++vYaGr6hR0au44iEpqe9z
 1CiRYgfRRczvCJ1uIOWV8DDxd4GUph0ZO6stMEOUakiG9XfWU8fZNB0Uda7nSdiGyMJE0Y
 CGonDnhENM1E/qcMScMnlA8kjGGIVO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758300385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QKKpiwmPqWSlU3SYjghBBTfip9bKu7h62FAtac00Qw=;
 b=0yL5wzEPFiwHqBiUeE0C5teQKi8N9R/wVHnLmjcHGn9gJu006RwpM8nKQij+y/FYp6Mu4E
 IMIcIT82Z1K3+hDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sBWkJibg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0yL5wzEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758300385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QKKpiwmPqWSlU3SYjghBBTfip9bKu7h62FAtac00Qw=;
 b=sBWkJibgUX+Licve8CxkcGyGPaWlSd0zTp+OiLq2LXhvoy49++vYaGr6hR0au44iEpqe9z
 1CiRYgfRRczvCJ1uIOWV8DDxd4GUph0ZO6stMEOUakiG9XfWU8fZNB0Uda7nSdiGyMJE0Y
 CGonDnhENM1E/qcMScMnlA8kjGGIVO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758300385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0QKKpiwmPqWSlU3SYjghBBTfip9bKu7h62FAtac00Qw=;
 b=0yL5wzEPFiwHqBiUeE0C5teQKi8N9R/wVHnLmjcHGn9gJu006RwpM8nKQij+y/FYp6Mu4E
 IMIcIT82Z1K3+hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF21D13A78;
 Fri, 19 Sep 2025 16:46:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0oX8G+CIzWhaVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 16:46:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
In-Reply-To: <20250915115918.3520735-4-jmarcin@redhat.com>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com>
Date: Fri, 19 Sep 2025 13:46:22 -0300
Message-ID: <87plbmtmox.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 3AF5B1F7E3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Juraj Marcin <jmarcin@redhat.com> writes:

Hi Juraj,

Good patch, nice use of migrate_has_failed()

> From: Juraj Marcin <jmarcin@redhat.com>
>
> Currently, there are two functions that are responsible for cleanup of
> the incoming migration state. With successful precopy, it's the main
> thread and with successful postcopy it's the listen thread. However, if
> postcopy fails during in the device load, both functions will try to do
> the cleanup. Moreover, when exit-on-error parameter was added, it was
> applied only to precopy.
>

Someone could be relying in postcopy always exiting on error while
explicitly setting exit-on-error=false for precopy and this patch would
change the behavior incompatibly. Is this an issue? I'm willing to
ignore it, but you guys know more about postcopy.

> This patch refactors common cleanup and exiting on error into a helper
> function that can be started either from precopy or postcopy, reducing
> the duplication. If the listen thread has been started (the postcopy
> state is at least LISTENING), the listen thread is responsible for all
> cleanup and exiting, otherwise it's the main thread's responsibility.

Don't the BHs also run in the main thread? I'm not sure this sentence is
accurate.

>
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/migration.c | 64 ++++++++++++++++++++++++-------------------
>  migration/migration.h |  1 +
>  migration/savevm.c    | 48 +++++++++++---------------------

Could someone act on the TODOs and move postcopy code into postcopy-ram?
It's never too late to make things consistent.

>  3 files changed, 53 insertions(+), 60 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 2c0b3a7229..7222e3de13 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -442,9 +442,19 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
>  void migration_incoming_state_destroy(void)
>  {
>      struct MigrationIncomingState *mis = migration_incoming_get_current();
> +    PostcopyState ps = postcopy_state_get();
>  
>      multifd_recv_cleanup();
>  
> +    if (mis->have_listen_thread) {
> +        qemu_thread_join(&mis->listen_thread);
> +        mis->have_listen_thread = false;
> +    }
> +
> +    if (ps != POSTCOPY_INCOMING_NONE) {
> +        postcopy_ram_incoming_cleanup(mis);
> +    }
> +
>      /*
>       * RAM state cleanup needs to happen after multifd cleanup, because
>       * multifd threads can use some of its states (receivedmap).
> @@ -809,6 +819,23 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>      cpr_state_close();
>  }
>  
> +void migration_incoming_finish(void)
> +{
> +    MigrationState *s = migrate_get_current();
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    migration_incoming_state_destroy();
> +
> +    if (migration_has_failed(mis->state) && mis->exit_on_error) {
> +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +            error_report_err(s->error);
> +            s->error = NULL;
> +        }
> +
> +        exit(EXIT_FAILURE);
> +    }
> +}
> +
>  static void process_incoming_migration_bh(void *opaque)
>  {
>      MigrationIncomingState *mis = opaque;
> @@ -861,7 +888,7 @@ static void process_incoming_migration_bh(void *opaque)
>       */
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COMPLETED);
> -    migration_incoming_state_destroy();
> +    migration_incoming_finish();
>  }
>  
>  static void coroutine_fn
> @@ -888,23 +915,13 @@ process_incoming_migration_co(void *opaque)
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
> -            postcopy_ram_incoming_cleanup(mis);
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
> +         * postcopy thread.
> +         */
> +        trace_process_incoming_migration_co_postcopy_end_main();
> +        goto out;
>      }
>  
>      if (ret < 0) {
> @@ -926,16 +943,7 @@ fail:
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
> -    }
> +    migration_incoming_finish();
>  out:
>      /* Pairs with the refcount taken in qmp_migrate_incoming() */
>      migrate_incoming_unref_outgoing_state();
> diff --git a/migration/migration.h b/migration/migration.h
> index 2c2331f40d..67e3318467 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -518,6 +518,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>  void migration_fd_process_incoming(QEMUFile *f);
>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
> +void migration_incoming_finish(void);

What about merging migration_incoming_state_destroy and
migration_incoming_finish and pair all of this with migration_cleanup?

static void migration_cleanup_bh(void *opaque)
{
    migration_cleanup(opaque);
}

static void migration_incoming_cleanup_bh(void *opaque)
{
    migration_incoming_cleanup(opaque);
}

>  
>  bool  migration_has_all_channels(void);
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296a..d7eb416d48 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2069,6 +2069,11 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>      return 0;
>  }
>  
> +static void postcopy_ram_listen_thread_bh(void *opaque)
> +{
> +    migration_incoming_finish();
> +}
> +
>  /*
>   * Triggered by a postcopy_listen command; this thread takes over reading
>   * the input stream, leaving the main thread free to carry on loading the rest
> @@ -2122,52 +2127,31 @@ static void *postcopy_ram_listen_thread(void *opaque)
>                           "bitmaps may be lost, and present migrated dirty "
>                           "bitmaps are correctly migrated and valid.",
>                           __func__, load_res);
> -            load_res = 0; /* prevent further exit() */
>          } else {
>              error_report("%s: loadvm failed: %d", __func__, load_res);
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
> -    postcopy_ram_incoming_cleanup(mis);
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
>      object_unref(OBJECT(migr));
>  
> +    migration_bh_schedule(postcopy_ram_listen_thread_bh, NULL);

Better to schedule before the object_unref to ensure there's always
someone holding a reference?

> +
>      return NULL;
>  }
>  
> @@ -2217,7 +2201,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>      mis->have_listen_thread = true;
>      postcopy_thread_create(mis, &mis->listen_thread,
>                             MIGRATION_THREAD_DST_LISTEN,
> -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
>      trace_loadvm_postcopy_handle_listen("return");
>  
>      return 0;

