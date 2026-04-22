Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F02FA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfVS-0007h5-PZ; Wed, 22 Apr 2026 17:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFfVK-0007fQ-Sj
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:53:09 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFfVI-0002sE-Av
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:53:06 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74F736A836;
 Wed, 22 Apr 2026 21:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776894781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eubxRGA54r6/y+tI+BmxFOkbbk1e7POfXyp4I/+c0+c=;
 b=a2p3dEJMieRo+3KSM+jXs/+ET7leGVjHPy+jCCyyTtMr4uyGOEQgCI7MbitUVs6vxGqD6v
 Uzq/Ey9LLn9p+coKJhAtZ8r2vqgRtLLyOqfidy6lUg10UdlGBXNHhy4HUVQrRVGNJLbssq
 W9u57//TBzuG3XggUd2DOdbf13KrQKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776894781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eubxRGA54r6/y+tI+BmxFOkbbk1e7POfXyp4I/+c0+c=;
 b=MpqGZZf/g3ir8QiRG+eS2VZndfCF2eYJSHOPDmToC2jR6b1Js9LYJfzsKIyMQQYkaCgqZG
 WWb3MxkhSH1XvmAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a2p3dEJM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="MpqGZZf/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776894781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eubxRGA54r6/y+tI+BmxFOkbbk1e7POfXyp4I/+c0+c=;
 b=a2p3dEJMieRo+3KSM+jXs/+ET7leGVjHPy+jCCyyTtMr4uyGOEQgCI7MbitUVs6vxGqD6v
 Uzq/Ey9LLn9p+coKJhAtZ8r2vqgRtLLyOqfidy6lUg10UdlGBXNHhy4HUVQrRVGNJLbssq
 W9u57//TBzuG3XggUd2DOdbf13KrQKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776894781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eubxRGA54r6/y+tI+BmxFOkbbk1e7POfXyp4I/+c0+c=;
 b=MpqGZZf/g3ir8QiRG+eS2VZndfCF2eYJSHOPDmToC2jR6b1Js9LYJfzsKIyMQQYkaCgqZG
 WWb3MxkhSH1XvmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CCE4593AF;
 Wed, 22 Apr 2026 21:53:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id civWMzxD6WlkEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Apr 2026 21:53:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, Ben Chaney
 <bchaney@akamai.com>, Juraj Marcin <jmarcin@redhat.com>, Mark Kanda
 <mark.kanda@oracle.com>, Pranav Tyagi <prtyagi@redhat.com>, =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] migration: Fix crash on second migration when cancel early
In-Reply-To: <aejqGMhhrfQENE1X@x1.local>
References: <20260421175820.302795-1-peterx@redhat.com>
 <87wlxzdsv9.fsf@suse.de> <aejqGMhhrfQENE1X@x1.local>
Date: Wed, 22 Apr 2026 18:52:54 -0300
Message-ID: <87qzo6ek7d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 74F736A836
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Apr 22, 2026 at 10:31:06AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > Marc-Andr=C3=A9 reported an issue on QEMU crash when retrying a cancel=
led
>> > migration during early setup phase, see "Link:" for more information, =
and
>> > also easy way to reproduce.
>> >
>> > This patch is a replacement of the prior fix proposed by not only swit=
ching
>> > to migration_cleanup(), but also fixing it from CPR side, so that we t=
rack
>> > hup_source properly to know if src QEMU is waiting or the HUP signal.
>> >
>> > To put it simple: this chunk of special casing in migration_cancel() s=
hould
>> > not affect normal migration, but only cpr-transfer migration to cover =
the
>> > small window when the src QEMU is waiting for a HUP signal on cpr
>> > channel (so that src QEMU can continue the migration on the main chann=
el).
>> >
>> > To achieve that, we'll also need to remember to detach the hup_source
>> > whenenver invoked: after that point, we should always be able to clean=
up
>> > the migration.
>> >
>> > It's not a generic operation to explicitly detach a gsource from its
>> > context while in its dispatch() function.  But it should be safe, beca=
use
>> > gsource disptch() will only happen with a boosted refcount for the
>> > dispatcher so that the gsource will not be freed until the callback
>> > completes. It's also safe to return G_SOURCE_REMOVE after the gsource =
is
>> > detached, as glib will simply ignore the G_SOURCE_REMOVE.
>> >
>> > One can refer to latest 2.86.5 glib code in g_main_dispatch() for that:
>> >
>> > https://github.com/GNOME/glib/blob/2.86.5/glib/gmain.c#L3592
>> >
>> > When at this, add a bunch of assertions to make sure nothing surprises=
 us.
>> >
>> > After this patch applied, the 2nd migration will not crash QEMU, inste=
ad
>> > it'll be in CANCELLING until the socket connection times out (it will =
take
>> > ~2min on my Fedora default kernel).  During this process no 2nd migrat=
ion
>> > will be allowed, and after it timed out migration can be restarted.
>> >
>> > It's because so far we don't have control over socket_connect_outgoing=
(),
>> > or anything yet managed by a task executed in qio_task_run_in_thread().
>> > Speeding up the cancellation to be left for future.
>
> [1]
>
>> >
>> > I also tested cpr-transfer by only providing cpr channel not the main
>> > channel (with -incoming defer), kickoff migration on source, then canc=
el it
>> > on source directly without providing the main channel.  It keeps worki=
ng.
>> >
>> > I wanted to add an unit test for that but it'll need to refactor curre=
nt
>> > cpr-transfer tests first; let's leave it for later.
>> >
>> > Link: https://lore.kernel.org/r/20260417184742.293061-1-marcandre.lure=
au@redhat.com
>> > Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  include/migration/cpr.h  |  1 +
>> >  migration/migration.h    |  5 +++++
>> >  migration/cpr-transfer.c | 10 ++++++++++
>> >  migration/migration.c    | 31 +++++++++++++++++++++++--------
>> >  4 files changed, 39 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> > index 5850fd1788..ebf09a2f0a 100644
>> > --- a/include/migration/cpr.h
>> > +++ b/include/migration/cpr.h
>> > @@ -57,6 +57,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *chann=
el, Error **errp);
>> >  void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc fun=
c,
>> >                                  void *opaque);
>> >  void cpr_transfer_source_destroy(MigrationState *s);
>> > +bool cpr_transfer_source_active(MigrationState *s);
>> >=20=20
>> >  void cpr_exec_init(void);
>> >  QEMUFile *cpr_exec_output(Error **errp);
>> > diff --git a/migration/migration.h b/migration/migration.h
>> > index b6888daced..2bc2787480 100644
>> > --- a/migration/migration.h
>> > +++ b/migration/migration.h
>> > @@ -514,6 +514,11 @@ struct MigrationState {
>> >      bool postcopy_package_loaded;
>> >      QemuEvent postcopy_package_loaded_event;
>> >=20=20
>> > +    /*
>> > +     * When set, it means cpr-transfer is waiting for the HUP signal =
from
>> > +     * destination to continue the 2nd step of migration via the main
>> > +     * channel.
>> > +     */
>> >      GSource *hup_source;
>> >=20=20
>> >      /*
>> > diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> > index 61d5c9dce2..9defe7bad7 100644
>> > --- a/migration/cpr-transfer.c
>> > +++ b/migration/cpr-transfer.c
>> > @@ -6,6 +6,7 @@
>> >   */
>> >=20=20
>> >  #include "qemu/osdep.h"
>> > +#include "qemu/main-loop.h"
>> >  #include "qapi/clone-visitor.h"
>> >  #include "qapi/error.h"
>> >  #include "qapi/qapi-visit-migration.h"
>> > @@ -79,6 +80,7 @@ QEMUFile *cpr_transfer_input(MigrationChannel *chann=
el, Error **errp)
>> >  void cpr_transfer_add_hup_watch(MigrationState *s, QIOChannelFunc fun=
c,
>> >                                  void *opaque)
>> >  {
>> > +    assert(bql_locked());
>> >      s->hup_source =3D qio_channel_create_watch(cpr_state_ioc(), G_IO_=
HUP);
>>=20
>> Before I review the patch in detail, let me just make a high level
>> comment here:
>>=20
>> I wonder if we should have a "register" in the iochannel layer for the
>> several watches we create. So we could at migration_cancel time call
>
> Yes, we need to do this part of mgmt better either now or at some point..
>
> Said that, just to mention: what you're discussing below seems to be about
> dest QEMU, not src QEMU.
>

Indeed, I haven't looked closely into this patch yet.

> Here the "unmanaged async tasks" I mentioned above [1] is only about src
> QEMU.  It only applies to socket channels and socket_connect_outgoing().
> It is slightly even trickier, IIUC, because instead of creating a watch
> directly, it creates a pthread and run the task there, then when the task
> fn() completes that thread will inject one event back to the main event
> loop.  See qio_task_thread_worker() and the @completion gsource.
>
> One thing I can try to do is to work out fast cancellation for sockets he=
re
> on src side, so we don't need to wait for that 2min timeout..  But it wou=
ld
> still be nice to have this fix land first because it fixes a crash.. so it
> may still be something on top but I can start look into.  I actually don't
> know how frequent users will suffer from the 2min timeout: normally when
> the host:port isn't available we should just get disconnected fast.
>
> Starting from now, I'll only discuss about dest QEMU side (IOW, may not be
> directly relevant to this patch).
>
>> g_clear_handle/g_source_destroy on all at the same time. The management
>> of these source ids is getting too particular.
>>=20
>> I'm seeing that exec, fd and file migration all ignore the id returned
>> by channel-watch.c. In the case of exec this is causing
>> qio_channel_command_finalize() to be skipped, leaving the exec'ed
>> command process behind! So what I did as an experiment was to register
>
> Are we?
>

Yes.

> We're on the same page at least on that the gsources are not yet managed.
> But I am not sure they're leaked.
>
> exec_connect_incoming() does qio_channel_add_watch_full(), within itself =
it
> will release the refcount of the IO watch gsource.  It means it'll be a
> dangling gsource on the main context.  So after the spawn of the new
> process, it will still be finalized properly?
>

When the migration_with_exec functional test fails [0], the test issues
qmp-quit to both src and dst. The dst will exit before ever having
dispatched the gsource and exec_accept_incoming_migration() is not
executed at all. In that case the gsource and the ioc are never freed
and the spawned process is left behind.

This oneliner triggers it for me:

for i in $(seq 1 1000); do \
echo "$i =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D"; \
make -j$(nproc) check-func-quick || break; done; ps aux | grep socat

[0] - due to the startup race as the AI overlords told us. Patch coming
soon!

>> watches like this:
>>=20
>>   static inline void migration_watch_data(void) {};
>>=20=20=20
>>   qio_channel_add_watch_full(ioc, G_IO_IN, exec_accept_incoming_migratio=
n,
>>                              migration_watch_data, NULL,
>>                              g_main_context_get_thread_default());
>>=20
>> and at migrate_cancel():
>>=20
>>   while(g_source_remove_by_user_data(migration_watch_data));
>>=20
>> It feels to me that a wrapper around this, or even a hashtable of "func
>> ptr->GSource" or "str->GSource id" would allow us to call a (say)
>> qio_channel_clear_watches() and avoid having to do the management in
>> each of the clients.
>
> In general, this whole idea sounds reasonable.  I just want to check with
> you on which side of QEMU we're talking about.
>
> To me, dest QEMU is less of a concern when it can easily be killed.  But
> still it's good to be able to manage those.  Src QEMU is more important
> from that perspective.
>

It applies to both src and dst. Whenever we have to add a watch. The
non-uniformity of having the source removed maybe after it dispatches if
we return G_SOURCE_REMOVE or maybe it doesn't dispatch and then it needs
to be explicitly removed is error prone I think.

Looking at callers of qio_channel_add_watch[_full], all of them just
store the gsource "tag" and later remove it. Having the callers each
implement their own way of keeping track of the GSource pointer/id just
to be able to free them later on seems unnecessary to me.

The caller could still decide when to destroy the source, but it could
have semantics more like: "I'm done with all the sources".

Or just make it part of the iochannel finalize routine. A small list of
source ids per channel seems reasonable.

>>=20
>> We already have stuff like IOWatchPoll which kind of already wraps the
>> watch creation in a sense.
>>=20
>> >      g_source_set_callback(s->hup_source,
>> >                            (GSourceFunc)func,
>> > @@ -89,9 +91,17 @@ void cpr_transfer_add_hup_watch(MigrationState *s, =
QIOChannelFunc func,
>> >=20=20
>> >  void cpr_transfer_source_destroy(MigrationState *s)
>> >  {
>> > +    assert(bql_locked());
>> >      if (s->hup_source) {
>> >          g_source_destroy(s->hup_source);
>> >          g_source_unref(s->hup_source);
>> >          s->hup_source =3D NULL;
>> >      }
>> >  }
>> > +
>> > +bool cpr_transfer_source_active(MigrationState *s)
>> > +{
>> > +    /* Whenever the HUP gsource is available, it's active. */
>> > +    assert(bql_locked());
>> > +    return s->hup_source;
>> > +}
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 5c9aaa6e58..58c1e56766 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -1469,14 +1469,19 @@ void migration_cancel(void)
>> >      }
>> >=20=20
>> >      /*
>> > -     * If migration_connect_outgoing has not been called, then there
>> > -     * is no path that will complete the cancellation. Do it now.
>> > -     */
>> > -    if (setup && !s->to_dst_file) {
>> > -        migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>> > -                          MIGRATION_STATUS_CANCELLED);
>> > -        cpr_state_close();
>> > -        cpr_transfer_source_destroy(s);
>> > +     * This is cpr-transfer specific processing.
>> > +     *
>> > +     * If this is true, it means cpr-transfer migration is waiting fo=
r the
>> > +     * destination to send HUP event on CPR channel to continue the n=
ext
>> > +     * phase.  If so, do the cleanup proactively to avoid get stuck in
>> > +     * CANCELLING state.
>> > +     */
>> > +    if (cpr_transfer_source_active(s)) {
>> > +        assert(migrate_mode() =3D=3D MIG_MODE_CPR_TRANSFER);
>> > +        assert(setup && !s->to_dst_file);
>> > +        migration_cleanup(s);
>> > +        /* Now all things should have been released */
>> > +        assert(!cpr_transfer_source_active(s));
>> >      }
>> >  }
>> >=20=20
>> > @@ -2009,12 +2014,22 @@ static gboolean migration_connect_outgoing_cb(=
QIOChannel *channel,
>> >      MigrationState *s =3D migrate_get_current();
>> >      Error *local_err =3D NULL;
>> >=20=20
>> > +    /*
>> > +     * Detach and release the GSource right after use.  We rely on th=
is to
>> > +     * detect this small cpr-transfer window of "waiting for HUP even=
t".
>> > +     */
>> > +    cpr_transfer_source_destroy(s);
>> > +
>> >      migration_connect_outgoing(s, opaque, &local_err);
>> >=20=20
>> >      if (local_err) {
>> >          migration_connect_error_propagate(s, local_err);
>> >      }
>> >=20=20
>> > +    /*
>> > +     * This is redundant as we do cpr_transfer_source_destroy() at the
>> > +     * entry, but it's benign; glib will just skip the detach.
>> > +     */
>> >      return G_SOURCE_REMOVE;
>> >  }
>>=20

