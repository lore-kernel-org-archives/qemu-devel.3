Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54A9C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8uo-00025t-O9; Thu, 20 Feb 2025 10:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tl8un-00025d-Sn
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:56:41 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tl8ul-00055D-83
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:56:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0ECD1F387;
 Thu, 20 Feb 2025 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740066995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt/QP2soUo8lehryJeNw+e8WlCIWnqojq+ZE/t/0ujI=;
 b=zz/qKzIHVbJYzFUUFv7EhmcAoMe1KN3KD/h+iTgq8oltWIx0+KaOSTSHUXFUmZLVzZEU7s
 kV7L69yF5DBKJ5BAF+SicFjglty7t/DBIHFDMHkNUxtgUWvMe08JXMUj4FQUHIJlEQZQAI
 ZCzAzzyD7KSSz2JrNC3tIGuW3BDTHw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740066995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt/QP2soUo8lehryJeNw+e8WlCIWnqojq+ZE/t/0ujI=;
 b=EaFGD8zqbsFh2hnEPuZuDlZtmI4syHi5lIVV64p66yPuQZ/BNuv2HukjI00C4Hnb9Gkp6H
 FTKPrsAMdBBVozAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zz/qKzIH";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EaFGD8zq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1740066995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt/QP2soUo8lehryJeNw+e8WlCIWnqojq+ZE/t/0ujI=;
 b=zz/qKzIHVbJYzFUUFv7EhmcAoMe1KN3KD/h+iTgq8oltWIx0+KaOSTSHUXFUmZLVzZEU7s
 kV7L69yF5DBKJ5BAF+SicFjglty7t/DBIHFDMHkNUxtgUWvMe08JXMUj4FQUHIJlEQZQAI
 ZCzAzzyD7KSSz2JrNC3tIGuW3BDTHw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1740066995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt/QP2soUo8lehryJeNw+e8WlCIWnqojq+ZE/t/0ujI=;
 b=EaFGD8zqbsFh2hnEPuZuDlZtmI4syHi5lIVV64p66yPuQZ/BNuv2HukjI00C4Hnb9Gkp6H
 FTKPrsAMdBBVozAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332FF13A42;
 Thu, 20 Feb 2025 15:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XVg9OLJQt2dSeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Feb 2025 15:56:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, Yan Fu
 <yafu@redhat.com>
Subject: Re: [PATCH] migration: Fix UAF for incoming migration on
 MigrationState
In-Reply-To: <Z7dKbGc5eA2QXbPD@x1.local>
References: <20250220132459.512610-1-peterx@redhat.com>
 <87h64o90dn.fsf@suse.de> <Z7dKbGc5eA2QXbPD@x1.local>
Date: Thu, 20 Feb 2025 12:56:32 -0300
Message-ID: <87cyfc8v9r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C0ECD1F387
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Thu, Feb 20, 2025 at 11:06:12AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On the incoming migration side, QEMU uses a coroutine to load all the VM
>> > states.  Inside, it may reference MigrationState on global states like
>> > migration capabilities, parameters, error state, shared mutexes and more.
>> >
>> > However there's nothing yet to make sure MigrationState won't get
>> > destroyed (e.g. after migration_shutdown()).  Meanwhile there's also no API
>> > available to remove the incoming coroutine in migration_shutdown(),
>> > avoiding it to access the freed elements.
>> >
>> > There's a bug report showing this can happen and crash dest QEMU when
>> > migration is cancelled on source.
>> >
>> > When it happens, the dest main thread is trying to cleanup everything:
>> >
>> >   #0  qemu_aio_coroutine_enter
>> >   #1  aio_dispatch_handler
>> >   #2  aio_poll
>> >   #3  monitor_cleanup
>> >   #4  qemu_cleanup
>> >   #5  qemu_default_main
>> >
>> > Then it found the migration incoming coroutine, schedule it (even after
>> > migration_shutdown()), causing crash:
>> >
>> >   #0  __pthread_kill_implementation
>> >   #1  __pthread_kill_internal
>> >   #2  __GI_raise
>> >   #3  __GI_abort
>> >   #4  __assert_fail_base
>> >   #5  __assert_fail
>> >   #6  qemu_mutex_lock_impl
>> >   #7  qemu_lockable_mutex_lock
>> >   #8  qemu_lockable_lock
>> >   #9  qemu_lockable_auto_lock
>> >   #10 migrate_set_error
>> >   #11 process_incoming_migration_co
>> >   #12 coroutine_trampoline
>> >
>> > To fix it, take a refcount after an incoming setup is properly done when
>> > qmp_migrate_incoming() succeeded the 1st time.  As it's during a QMP
>> > handler which needs BQL, it means the main loop is still alive (without
>> > going into cleanups, which also needs BQL).
>> 
>> We should start documenting uses of BQL and dependencies on the main
>> loop more thoroughly. Otherwise later when we decide to move stuff into
>> threads or QMP people decide to rework how QMP uses coroutines,
>> etc. there we'll be many bugs.
>
> Yeh better documentation is always good.  Maybe there're too many things
> depend on BQL so it's not easy to provide a document.  Normally, afaiu, we
> document the other way round, where things do not need BQL.
>

Well, for newly added code the developer should know about the data
structures they're using and what the dependencies are. But yeah,
there's subtleties and hidden assumptions everywhere.

>> 
>> I think the BQL is irrelevant here. The concurrent access is prevented
>> by qmp_migrate_incoming() not being a coroutine, hence keeping the main
>> loop from looping.
>> 
>> This case would be "relying on the qmp_migrate_incoming() being
>> serialized with the dispatch of the incoming coroutine by the main
>> loop".
>
> I checked just now, it's still true indeed now that both of them
> (qmp_migrate_incoming, and the cleanup code) need to be run in the main
> thread.  But I'll not be surprised if someone moves (or moved) it out into
> a separate iothread like what we do with the OOB commands.
>

Yes, that's my point on documentation. "Needs BQL because I said so"
doesn't help when doing that kind of work. AFAIK we're suck in this
QMP-needs-BQL mode precisely because we cannot determine clearly what
the dependencies are. There's been some work years ago to move QMP
commands into coroutines. Now we have a half-baked situation. Grep for
QCO_COROUTINE.

> When I was working on OOB stuff, I _think_ all things are ready to create
> yet another iothread to process cmds need bql, probably just not necessary.
> Fundamentally, the requirement, AFAIU, is qmp handlers run by default with
> BQL, and it doesn't need to always be on the main thread.
>
> Let's keep the "BQL" term?  I think I'm ok with your version as it states
> the facts at least as of now, but I still think BQL is the slightly more
> accurate term.
>

Fine.

>> 
>> >
>> > Releasing the refcount now only until the incoming migration coroutine
>> > finished or failed.  Hence the refcount is valid for both (1) setup phase
>> > of incoming ports, mostly IO watches (e.g. qio_channel_add_watch_full()),
>> > and (2) the incoming coroutine itself (process_incoming_migration_co()).
>> >
>> > Note that we can't unref in migration_incoming_state_destroy(), because
>> > both qmp_xen_load_devices_state() and load_snapshot() will use it without
>> > an incoming migration.  Those hold BQL so they're not prone to this issue.
>> >
>> > PS: I suspect nobody uses Xen's command at all, as it didn't register yank,
>> > hence AFAIU the command should crash on master when trying to unregister
>> > yank in migration_incoming_state_destroy()..  but that's another story.
>> >
>> > Also note that in some incoming failure cases we may not always unref the
>> > MigrationState refcount, which is a trade-off to keep things simple.  We
>> > could make it accurate, but it can be an overkill.  Some examples:
>> >
>> >   - Unlike most of the rest protocols, socket_start_incoming_migration()
>> >     may create net listener after incoming port setup sucessfully.
>> >     It means we can't unref in migration_channel_process_incoming() as a
>> >     generic path because socket protocol might keep using MigrationState.
>> >
>> >   - For either socket or file, multiple IO watches might be created, it
>> >     means logically each IO watch needs to take one refcount for
>> >     MigrationState so as to be 100% accurate on ownership of refcount taken.
>> >
>> > In general, we at least need per-protocol handling to make it accurate,
>> > which can be an overkill if we know incoming failed after all.  Add a short
>> > comment to explain that when taking the refcount in qmp_migrate_incoming().
>> >
>> > Bugzilla: https://issues.redhat.com/browse/RHEL-69775
>> > Tested-by: Yan Fu <yafu@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/migration.c | 40 ++++++++++++++++++++++++++++++++++++++--
>> >  1 file changed, 38 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index c597aa707e..f57d853e9f 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -116,6 +116,27 @@ static void migration_downtime_start(MigrationState *s)
>> >      s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> >  }
>> >  
>> > +/*
>> > + * This is unfortunate: incoming migration actually needs the outgoing
>> > + * migration state (MigrationState) to be there too, e.g. to query
>> > + * capabilities, parameters, using locks, setup errors, etc.
>> > + *
>> > + * NOTE: when calling this, making sure current_migration exists and not
>> > + * been freed yet!  Otherwise trying to access the refcount is already
>> > + * an use-after-free itself..
>> > + *
>> > + * TODO: Move shared part of incoming / outgoing out into separate object.
>> > + * Then this is not needed.
>> 
>> It will be needed on the new object still, no?
>
> In that case IIUC we don't need special treatment for incoming side like
> this, but only when QEMU starts it grabs that common object ref once,
> either release it at the very end of qemu, or just make it static.
>
>> 
>> > + */
>> > +static void migrate_incoming_ref_outgoing_state(void)
>> > +{
>> > +    object_ref(migrate_get_current());
>> > +}
>> > +static void migrate_incoming_unref_outgoing_state(void)
>> > +{
>> > +    object_unref(migrate_get_current());
>> > +}
>> > +
>> >  static void migration_downtime_end(MigrationState *s)
>> >  {
>> >      int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>> > @@ -850,7 +871,7 @@ process_incoming_migration_co(void *opaque)
>> >               * postcopy thread.
>> >               */
>> >              trace_process_incoming_migration_co_postcopy_end_main();
>> > -            return;
>> > +            goto out;
>> >          }
>> >          /* Else if something went wrong then just fall out of the normal exit */
>> >      }
>> > @@ -866,7 +887,8 @@ process_incoming_migration_co(void *opaque)
>> >      }
>> >  
>> >      migration_bh_schedule(process_incoming_migration_bh, mis);
>> > -    return;
>> > +    goto out;
>> > +
>> >  fail:
>> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>> >                        MIGRATION_STATUS_FAILED);
>> > @@ -883,6 +905,9 @@ fail:
>> >  
>> >          exit(EXIT_FAILURE);
>> >      }
>> > +out:
>> > +    /* Pairs with the refcount taken in qmp_migrate_incoming() */
>> > +    migrate_incoming_unref_outgoing_state();
>> 
>> Nit, the comment is redundant, the function name is already clear
>> enough.
>
> The function says the "incoming" path "unref"s an "outgoing state", not
> where it's taken?  But yeah I can drop it, let me know.
>

I mean there's a migrate_incoming_ref_outgoing_state() and a
migrate_incoming_unref_outgoing_state(), it's obvious enough that they
are paired.

>> 
>> >  }
>> >  
>> >  /**
>> > @@ -1888,6 +1913,17 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
>> >          return;
>> >      }
>> >  
>> > +    /*
>> > +     * Making sure MigrationState is available until incoming migration
>> > +     * completes.
>> > +     *
>> > +     * NOTE: QEMU _might_ leak this refcount in some failure paths, but
>> > +     * that's OK.  This is the minimum change we need to at least making
>> > +     * sure success case is clean on the refcount.  We can try harder to
>> > +     * make it accurate for any kind of failures, but it might be an
>> > +     * overkill and doesn't bring us much benefit.
>> > +     */
>> 
>> Hopefully not any real leak... Let's see what my scripts say about
>> it. If it doesn't trigger with migration-test that's fine.
>
> I remember there could be leaks but only "it fails and dest qemu will quit
> immediately" kind of leak.  So possible it could trigger with some failure
> cases, but not sure whether existing cases will trigger those specific
> paths, most failure paths should still get covered.
>

If this gets flagged by some automated process somewhere it doesn't
really matter if it's a reasonable situation because it will get in the
way of merging a pull request and I'd rather avoid that.

Also Coverity warnings after merge are extremely annoying.

This patch looks ok in my testing at least, so:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

queued.

