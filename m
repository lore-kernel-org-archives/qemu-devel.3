Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE2FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 17:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0kXS-00063X-DW; Mon, 22 Sep 2025 13:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v0kX6-0005sM-7E
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:41:01 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v0kWt-0002jr-V5
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 13:40:55 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E73251F7E1;
 Mon, 22 Sep 2025 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758562841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUmh2R516CUzr6JrEmOT2avlKygRQsFqt/EPaeqlRm0=;
 b=SbGCZpzs6/GAlYDIVh62qUvZ3Q1Dr0uGsEejNF97lRIZujLz5d5MnyAfl0MaNZVRWYwMcb
 NPM2Q/rIEe/3C0B8XN2T9XAU6bD7MwmKodl9eCS9I3zqEstbP7oMbZFGtIK26cBJrFwlc7
 nBMfAtsWbkX3QkmQ92LrW0muS+y3POY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758562841;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUmh2R516CUzr6JrEmOT2avlKygRQsFqt/EPaeqlRm0=;
 b=gngu1FZSsdx/feCz3FA1mfXv5vpYBsGNN46j1O83efF8COhHNriyyvdISoSOmwlZKwIRhy
 D+Adia4T9CrEHfBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jf2j4pjI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xo6XNItv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758562840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUmh2R516CUzr6JrEmOT2avlKygRQsFqt/EPaeqlRm0=;
 b=Jf2j4pjIuvZ1ke6O/c5n1ZctcfMCCcbo4/6IKWOYasH1ef60Cg80JAHnqmDzkibW7tHqgc
 qQkqxNYuttpk+gK9+XclZkqGh4k7dhT9Q4ZZLP2ePUt0LEOeJbp9Pe8q77opPkOvM3rpa5
 IE210ZweZLXhD+bPcJ1DGHbgn5yXH+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758562840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UUmh2R516CUzr6JrEmOT2avlKygRQsFqt/EPaeqlRm0=;
 b=xo6XNItvVF9foaxzZxDFffNNsBAhubjIfMwYnTLiyTU18BGRqysOSwPIreRNrVSQwKyHtv
 sRaKsy8Du0g16XAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C79713A63;
 Mon, 22 Sep 2025 17:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rDP5BhiK0WifTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Sep 2025 17:40:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, "Dr. David
 Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
In-Reply-To: <aNFwdic2-d_Crctc@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com> <87plbmtmox.fsf@suse.de>
 <luoiumyvzjxtro6bd4vqn5mq6icf2zfic3n6shivb2e3ngkmcl@bz7vzg7xwdiq>
 <aNFwdic2-d_Crctc@x1.local>
Date: Mon, 22 Sep 2025 14:40:37 -0300
Message-ID: <877bxqtmga.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: E73251F7E1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Sep 22, 2025 at 02:58:38PM +0200, Juraj Marcin wrote:
>> Hi Fabiano,
>> 
>> On 2025-09-19 13:46, Fabiano Rosas wrote:
>> > Juraj Marcin <jmarcin@redhat.com> writes:
>> > 
>> > Hi Juraj,
>> > 
>> > Good patch, nice use of migrate_has_failed()
>> 
>> Thanks!
>> 
>> > 
>> > > From: Juraj Marcin <jmarcin@redhat.com>
>> > >
>> > > Currently, there are two functions that are responsible for cleanup of
>> > > the incoming migration state. With successful precopy, it's the main
>> > > thread and with successful postcopy it's the listen thread. However, if
>> > > postcopy fails during in the device load, both functions will try to do
>> > > the cleanup. Moreover, when exit-on-error parameter was added, it was
>> > > applied only to precopy.
>> > >
>> > 
>> > Someone could be relying in postcopy always exiting on error while
>> > explicitly setting exit-on-error=false for precopy and this patch would
>> > change the behavior incompatibly. Is this an issue? I'm willing to
>> > ignore it, but you guys know more about postcopy.
>> 
>> Good question. When going through older patches where postcopy listen
>> thread and then where exit-on-error were implemented, it seemed more
>> like an overlook than intentional omission. However, it might be better
>> to not break any potential users of this, we could add another option,
>> "exit-on-postcopy-error" that would allow such handling if postscopy
>> failed unrecoverably. I've already talked about such option with
>> @jdenemar and he agreed with it.
>
> The idea for postcopy ram is, it should never fail.. as failing should
> never be better than a pause.  Block dirty bitmap might be different,
> though, when enabled separately.
>
> For postcopy-ram, qemu_loadvm_state_main() will in reality only receive RAM
> updates. It'll almost always trigger the postcopy_pause_incoming() path
> when anything fails.
>
> For pure block-dirty-bitmap-only styled postcopy: for this exit-on-error, I
> also don't think we should really "exit on errors", even if the flag is
> set.  IIUC, it's not fatal to the VM if that failed, as described in:
>
> commit ee64722514fabcad2430982ade86180208f5be4f
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Mon Jul 27 22:42:32 2020 +0300
>
>     migration/savevm: don't worry if bitmap migration postcopy failed
>
>     ...
>
>     And anyway, bitmaps postcopy is not prepared to be somehow recovered.
>     The original idea instead is that if bitmaps postcopy failed, we just
>     lose some bitmaps, which is not critical. So, on failure we just need
>     to remove unfinished bitmaps and guest should continue execution on
>     destination.
>
> Hence, exit here might be an overkill.. need block developers to double
> check, though..
>
>> 
>> > 
>> > > This patch refactors common cleanup and exiting on error into a helper
>> > > function that can be started either from precopy or postcopy, reducing
>> > > the duplication. If the listen thread has been started (the postcopy
>> > > state is at least LISTENING), the listen thread is responsible for all
>> > > cleanup and exiting, otherwise it's the main thread's responsibility.
>> > 
>> > Don't the BHs also run in the main thread? I'm not sure this sentence is
>> > accurate.
>> 
>> Yeah, it is a bit inaccurate now that you mention it, BHs are indeed run
>> in the main thread. More accurate would to replace the main thread with
>> process incoming migration coroutine, that would precisely describe who
>> has the responsibility to call the cleanup.
>> 
>> > 
>> > >
>> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
>> > > ---
>> > >  migration/migration.c | 64 ++++++++++++++++++++++++-------------------
>> > >  migration/migration.h |  1 +
>> > >  migration/savevm.c    | 48 +++++++++++---------------------
>> > 
>> > Could someone act on the TODOs and move postcopy code into postcopy-ram?
>> > It's never too late to make things consistent.
>> 
>> I can take a look.
>> 
>> > 
>> > >  3 files changed, 53 insertions(+), 60 deletions(-)
>> > >
>> > > diff --git a/migration/migration.c b/migration/migration.c
>> > > index 2c0b3a7229..7222e3de13 100644
>> > > --- a/migration/migration.c
>> > > +++ b/migration/migration.c
>> > > @@ -442,9 +442,19 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
>> > >  void migration_incoming_state_destroy(void)
>> > >  {
>> > >      struct MigrationIncomingState *mis = migration_incoming_get_current();
>> > > +    PostcopyState ps = postcopy_state_get();
>> > >  
>> > >      multifd_recv_cleanup();
>> > >  
>> > > +    if (mis->have_listen_thread) {
>> > > +        qemu_thread_join(&mis->listen_thread);
>> > > +        mis->have_listen_thread = false;
>> > > +    }
>> > > +
>> > > +    if (ps != POSTCOPY_INCOMING_NONE) {
>> > > +        postcopy_ram_incoming_cleanup(mis);
>> > > +    }
>> > > +
>> > >      /*
>> > >       * RAM state cleanup needs to happen after multifd cleanup, because
>> > >       * multifd threads can use some of its states (receivedmap).
>> > > @@ -809,6 +819,23 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>> > >      cpr_state_close();
>> > >  }
>> > >  
>> > > +void migration_incoming_finish(void)
>> > > +{
>> > > +    MigrationState *s = migrate_get_current();
>> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
>> > > +
>> > > +    migration_incoming_state_destroy();
>> > > +
>> > > +    if (migration_has_failed(mis->state) && mis->exit_on_error) {
>> > > +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> > > +            error_report_err(s->error);
>> > > +            s->error = NULL;
>> > > +        }
>> > > +
>> > > +        exit(EXIT_FAILURE);
>> > > +    }
>> > > +}
>> > > +
>> > >  static void process_incoming_migration_bh(void *opaque)
>> > >  {
>> > >      MigrationIncomingState *mis = opaque;
>> > > @@ -861,7 +888,7 @@ static void process_incoming_migration_bh(void *opaque)
>> > >       */
>> > >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>> > >                        MIGRATION_STATUS_COMPLETED);
>> > > -    migration_incoming_state_destroy();
>> > > +    migration_incoming_finish();
>> > >  }
>> > >  
>> > >  static void coroutine_fn
>> > > @@ -888,23 +915,13 @@ process_incoming_migration_co(void *opaque)
>> > >  
>> > >      ps = postcopy_state_get();
>> > >      trace_process_incoming_migration_co_end(ret, ps);
>> > > -    if (ps != POSTCOPY_INCOMING_NONE) {
>> > > -        if (ps == POSTCOPY_INCOMING_ADVISE) {
>> > > -            /*
>> > > -             * Where a migration had postcopy enabled (and thus went to advise)
>> > > -             * but managed to complete within the precopy period, we can use
>> > > -             * the normal exit.
>> > > -             */
>> > > -            postcopy_ram_incoming_cleanup(mis);
>> > > -        } else if (ret >= 0) {
>> > > -            /*
>> > > -             * Postcopy was started, cleanup should happen at the end of the
>> > > -             * postcopy thread.
>> > > -             */
>> > > -            trace_process_incoming_migration_co_postcopy_end_main();
>> > > -            goto out;
>> > > -        }
>> > > -        /* Else if something went wrong then just fall out of the normal exit */
>> > > +    if (ps >= POSTCOPY_INCOMING_LISTENING) {
>> > > +        /*
>> > > +         * Postcopy was started, cleanup should happen at the end of the
>> > > +         * postcopy thread.
>> > > +         */
>> > > +        trace_process_incoming_migration_co_postcopy_end_main();
>> > > +        goto out;
>> > >      }
>> > >  
>> > >      if (ret < 0) {
>> > > @@ -926,16 +943,7 @@ fail:
>> > >      migrate_set_error(s, local_err);
>> > >      error_free(local_err);
>> > >  
>> > > -    migration_incoming_state_destroy();
>> > > -
>> > > -    if (mis->exit_on_error) {
>> > > -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
>> > > -            error_report_err(s->error);
>> > > -            s->error = NULL;
>> > > -        }
>> > > -
>> > > -        exit(EXIT_FAILURE);
>> > > -    }
>> > > +    migration_incoming_finish();
>> > >  out:
>> > >      /* Pairs with the refcount taken in qmp_migrate_incoming() */
>> > >      migrate_incoming_unref_outgoing_state();
>> > > diff --git a/migration/migration.h b/migration/migration.h
>> > > index 2c2331f40d..67e3318467 100644
>> > > --- a/migration/migration.h
>> > > +++ b/migration/migration.h
>> > > @@ -518,6 +518,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>> > >  void migration_fd_process_incoming(QEMUFile *f);
>> > >  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>> > >  void migration_incoming_process(void);
>> > > +void migration_incoming_finish(void);
>> > 
>> > What about merging migration_incoming_state_destroy and
>> > migration_incoming_finish and pair all of this with migration_cleanup?
>> > 
>> > static void migration_cleanup_bh(void *opaque)
>> > {
>> >     migration_cleanup(opaque);
>> > }
>> > 
>> > static void migration_incoming_cleanup_bh(void *opaque)
>> > {
>> >     migration_incoming_cleanup(opaque);
>> > }
>> 
>> Yes, it would pair well. I guess it would also solve Peter's nitpick
>> about the change in process_incoming_migration_bh() above.
>> 
>> > >  
>> > >  bool  migration_has_all_channels(void);
>> > >  
>> > > diff --git a/migration/savevm.c b/migration/savevm.c
>> > > index fabbeb296a..d7eb416d48 100644
>> > > --- a/migration/savevm.c
>> > > +++ b/migration/savevm.c
>> > > @@ -2069,6 +2069,11 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>> > >      return 0;
>> > >  }
>> > >  
>> > > +static void postcopy_ram_listen_thread_bh(void *opaque)
>> > > +{
>> > > +    migration_incoming_finish();
>> > > +}
>> > > +
>> > >  /*
>> > >   * Triggered by a postcopy_listen command; this thread takes over reading
>> > >   * the input stream, leaving the main thread free to carry on loading the rest
>> > > @@ -2122,52 +2127,31 @@ static void *postcopy_ram_listen_thread(void *opaque)
>> > >                           "bitmaps may be lost, and present migrated dirty "
>> > >                           "bitmaps are correctly migrated and valid.",
>> > >                           __func__, load_res);
>> > > -            load_res = 0; /* prevent further exit() */
>> > >          } else {
>> > >              error_report("%s: loadvm failed: %d", __func__, load_res);
>> > >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>> > >                                             MIGRATION_STATUS_FAILED);
>> > > +            goto out;
>> > >          }
>> > >      }
>> > > -    if (load_res >= 0) {
>> > > -        /*
>> > > -         * This looks good, but it's possible that the device loading in the
>> > > -         * main thread hasn't finished yet, and so we might not be in 'RUN'
>> > > -         * state yet; wait for the end of the main thread.
>> > > -         */
>> > > -        qemu_event_wait(&mis->main_thread_load_event);
>> > > -    }
>> > > -    postcopy_ram_incoming_cleanup(mis);
>> > > -
>> > > -    if (load_res < 0) {
>> > > -        /*
>> > > -         * If something went wrong then we have a bad state so exit;
>> > > -         * depending how far we got it might be possible at this point
>> > > -         * to leave the guest running and fire MCEs for pages that never
>> > > -         * arrived as a desperate recovery step.
>> > > -         */
>> > > -        rcu_unregister_thread();
>> > > -        exit(EXIT_FAILURE);
>> > > -    }
>> > > +    /*
>> > > +     * This looks good, but it's possible that the device loading in the
>> > > +     * main thread hasn't finished yet, and so we might not be in 'RUN'
>> > > +     * state yet; wait for the end of the main thread.
>> > > +     */
>> > > +    qemu_event_wait(&mis->main_thread_load_event);
>
> PS: I didn't notice this change, looks like this may be better to be a
> separate patch when moving out of the if.  Meanwhile, I don't think we set
> it right either, in qemu_loadvm_state():
>
>     qemu_event_set(&mis->main_thread_load_event);
>
> The problem is e.g. load_snapshot / qmp_xen_load_devices_state also set
> that event, even if there'll be no one to consume it.. not a huge deal, but
> maybe while moving it out of the if, we can also cleanup the set() side
> too, by moving the set() upper into process_incoming_migration_co().
>
>> > >  
>> > >      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
>> > >                                     MIGRATION_STATUS_COMPLETED);
>> > > -    /*
>> > > -     * If everything has worked fine, then the main thread has waited
>> > > -     * for us to start, and we're the last use of the mis.
>> > > -     * (If something broke then qemu will have to exit anyway since it's
>> > > -     * got a bad migration state).
>> > > -     */
>> > > -    bql_lock();
>> > > -    migration_incoming_state_destroy();
>> > > -    bql_unlock();
>> > >  
>> > > +out:
>> > >      rcu_unregister_thread();
>> > > -    mis->have_listen_thread = false;
>> > >      postcopy_state_set(POSTCOPY_INCOMING_END);
>> > >  
>> > >      object_unref(OBJECT(migr));
>> > >  
>> > > +    migration_bh_schedule(postcopy_ram_listen_thread_bh, NULL);
>> > 
>> > Better to schedule before the object_unref to ensure there's always
>> > someone holding a reference?
>> 
>> True, I'll move it.
>
> Good point.  Though I'm not sure moving it upper would help, because it'll
> be the BH that references the MigrationState*..

A while ago we wrapped QEMU BHs with migration_bh_dispatch_bh. The BHs
don't need to hold or drop MigrationState reference anymore because the
dispatch callback does it:

void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
{
    ...
    object_ref(OBJECT(s));
    qemu_bh_schedule(bh);
}

static void migration_bh_dispatch_bh(void *opaque)
{
    ...        
    migbh->cb(migbh->opaque);
    object_unref(OBJECT(s));
    ...
}

>  So maybe we could unref at
> the end of postcopy_ram_listen_thread_bh().  If so, we should add a comment
> on ref() / unref() saying how they're paired.
>

>> 
>> > 
>> > > +
>> > >      return NULL;
>> > >  }
>> > >  
>> > > @@ -2217,7 +2201,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>> > >      mis->have_listen_thread = true;
>> > >      postcopy_thread_create(mis, &mis->listen_thread,
>> > >                             MIGRATION_THREAD_DST_LISTEN,
>> > > -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
>> > > +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
>> > >      trace_loadvm_postcopy_handle_listen("return");
>> > >  
>> > >      return 0;
>> > 
>> 

