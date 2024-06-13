Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F5DC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHo8P-0000Y1-3u; Thu, 13 Jun 2024 13:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHo8N-0000XZ-Qg
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:11 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHo8K-0005hh-LB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:21:11 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 171191FCFB;
 Thu, 13 Jun 2024 17:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718299267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahM9ZulMfAXOHQSBkXrBnMIOtmtqddIDrrwWJl2l0i8=;
 b=DddtJQuzWByQ6EraUrE08tf2KVY/sVURedYK7CiQlfPa1jjPofwxn12cZtT8HieQcviw3z
 fztZsygNmbkGl0eVdB0x7+OKgTY4S1NaFOKm6sxRXdWjucHDEPMLhD+z6y3yjOvoja5yW7
 gy4pvcV9m0fXQGuhPz1K70HlQS2MTnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718299267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahM9ZulMfAXOHQSBkXrBnMIOtmtqddIDrrwWJl2l0i8=;
 b=C1YpaWVcIvW0Pimfb38Rr7YTIWhVs2HHD75qFqqyo7dG+WXw9e5RLxkOOCU67NxJFZi5IW
 ZZsHs35eyuyKAPCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DddtJQuz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C1YpaWVc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718299267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahM9ZulMfAXOHQSBkXrBnMIOtmtqddIDrrwWJl2l0i8=;
 b=DddtJQuzWByQ6EraUrE08tf2KVY/sVURedYK7CiQlfPa1jjPofwxn12cZtT8HieQcviw3z
 fztZsygNmbkGl0eVdB0x7+OKgTY4S1NaFOKm6sxRXdWjucHDEPMLhD+z6y3yjOvoja5yW7
 gy4pvcV9m0fXQGuhPz1K70HlQS2MTnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718299267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahM9ZulMfAXOHQSBkXrBnMIOtmtqddIDrrwWJl2l0i8=;
 b=C1YpaWVcIvW0Pimfb38Rr7YTIWhVs2HHD75qFqqyo7dG+WXw9e5RLxkOOCU67NxJFZi5IW
 ZZsHs35eyuyKAPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CB7913A87;
 Thu, 13 Jun 2024 17:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rpbsFIIqa2ZtBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Jun 2024 17:21:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Prasad
 Pandit <ppandit@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH 4/4] migration/postcopy: Add postcopy-recover-setup phase
In-Reply-To: <Zmsc5pXGs4dLfiLB@x1n>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-5-peterx@redhat.com> <8734pgdhf5.fsf@suse.de>
 <Zmsc5pXGs4dLfiLB@x1n>
Date: Thu, 13 Jun 2024 14:21:04 -0300
Message-ID: <87tthwbvy7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 171191FCFB
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Jun 13, 2024 at 11:51:58AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > This patch adds a migration state on src called "postcopy-recover-setup".
>> > The new state will describe the intermediate step starting from when the
>> > src QEMU started an postcopy recovery request, until the migration channels
>> > are properly established, but before the recovery process take place.
>> >
>> > The request came from Libvirt where Libvirt currently rely on the migration
>> > state events to detect migration state changes.  That works for most of the
>> > migration process but except postcopy recovery failures at the beginning.
>> >
>> > Currently postcopy recovery only has two major states:
>> >
>> >   - postcopy-paused: this is the state that both sides of QEMU will be in
>> >     for a long time as long as the migration channel was interrupted.
>> >
>> >   - postcopy-recover: this is the state where both sides of QEMU handshake
>> >     with each other, preparing for a continuation of postcopy which used to
>> >     be interrupted.
>> >
>> > The issue here is when the recovery port is invalid, the src QEMU will take
>> > the URI/channels, noticing the ports are not valid, and it'll silently keep
>> > in the postcopy-paused state, with no event sent to Libvirt.  In this case,
>> > the only thing Libvirt can do is to poll the migration status with a proper
>> > interval, however that's less optimal.
>> >
>> > Considering that this is the only case where Libvirt won't get a
>> > notification from QEMU on such events, let's add postcopy-recover-setup
>> > state to mimic what we used to have with the "setup" state of a newly
>> 
>> s/used to //
>
> Fixed.
>
>> 
>> > initialized migration, describing the phase of connection establishment.
>> >
>> > With that, postcopy recovery will have two paths to go now, and either path
>> > will guarantee an event generated.  Now the events will look like this
>> > during a recovery process on src QEMU:
>> >
>> >   - Initially when the recovery is initiated on src, QEMU will go from
>> >     "postcopy-paused" -> "postcopy-recover-setup".  Old QEMUs don't have
>> >     this event.
>> >
>> >   - Depending on whether the channel re-establishment is succeeded:
>> >
>> >     - In succeeded case, src QEMU will move from "postcopy-recover-setup"
>> >       to "postcopy-recover".  Old QEMUs also have this event.
>> >
>> >     - In failure case, src QEMU will move from "postcopy-recover-setup" to
>> >       "postcopy-paused" again.  Old QEMUs don't have this event.
>> >
>> > This guarantees that Libvirt will always receive a notification for
>> > recovery process properly.
>> >
>> > One thing to mention is, such new status is only needed on src QEMU not
>> > both.  On dest QEMU, the state machine doesn't change.  Hence the events
>> > don't change either.  It's done like so because dest QEMU may not have an
>> > explicit point of setup start.  E.g., it can happen that when dest QEMUs
>> > doesn't use migrate-recover command to use a new URI/channel, but the old
>> > URI/channels can be reused in recovery, in which case the old ports simply
>> > can work again after the network routes are fixed up.
>> >
>> > The patch has some touch-ups in the dest path too, but it's because there's
>> > some unclearness on using migrate_set_state(), so the change should make it
>> > crystal clear now by checking current status always.  The next step from
>> 
>> Can we get a separate patch for these cleanups?
>
> We can, and I'll do.
>
>> 
>> > that POV would be making migrate_set_state() not using cmpxchg() but always
>> > update the status, but that's for later.
>> >
>> > Cc: Jiri Denemark <jdenemar@redhat.com>
>> > Cc: Fabiano Rosas <farosas@suse.de>
>> > Cc: Prasad Pandit <ppandit@redhat.com>
>> > Buglink: https://issues.redhat.com/browse/RHEL-38485
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  qapi/migration.json      |  4 +++
>> >  migration/postcopy-ram.h |  3 ++
>> >  migration/migration.c    | 66 +++++++++++++++++++++++++++++++++++-----
>> >  migration/postcopy-ram.c |  6 ++++
>> >  migration/savevm.c       |  4 +--
>> >  5 files changed, 73 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index a351fd3714..a135bbcd96 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -142,6 +142,9 @@
>> >  #
>> >  # @postcopy-paused: during postcopy but paused.  (since 3.0)
>> >  #
>> > +# @postcopy-recover-setup: setup phase for a postcopy recover process,
>> > +#     preparing for a recover phase to start.  (since 9.1)
>> 
>> recover*y* process
>> recover*y* phase
>
> OK.
>
>> 
>> > +#
>> >  # @postcopy-recover: trying to recover from a paused postcopy.  (since
>> >  #     3.0)
>> >  #
>> > @@ -166,6 +169,7 @@
>> >  { 'enum': 'MigrationStatus',
>> >    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
>> >              'active', 'postcopy-active', 'postcopy-paused',
>> > +            'postcopy-recover-setup',
>> >              'postcopy-recover', 'completed', 'failed', 'colo',
>> >              'pre-switchover', 'device', 'wait-unplug' ] }
>> >  ##
>> > diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
>> > index ecae941211..a6df1b2811 100644
>> > --- a/migration/postcopy-ram.h
>> > +++ b/migration/postcopy-ram.h
>> > @@ -13,6 +13,8 @@
>> >  #ifndef QEMU_POSTCOPY_RAM_H
>> >  #define QEMU_POSTCOPY_RAM_H
>> >  
>> > +#include "qapi/qapi-types-migration.h"
>> > +
>> >  /* Return true if the host supports everything we need to do postcopy-ram */
>> >  bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
>> >                                      Error **errp);
>> > @@ -193,5 +195,6 @@ enum PostcopyChannels {
>> >  void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
>> >  void postcopy_preempt_setup(MigrationState *s);
>> >  int postcopy_preempt_establish_channel(MigrationState *s);
>> > +bool postcopy_is_paused(MigrationStatus status);
>> >  
>> >  #endif
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index bfbd657035..9475dce7dc 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -595,6 +595,26 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>> >      return true;
>> >  }
>> >  
>> > +static bool
>> > +migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
>> > +{
>> > +    MigrationStatus current = mis->state;
>> > +
>> > +    if (current == MIGRATION_STATUS_POSTCOPY_PAUSED) {
>> > +        /* Postcopy paused state doesn't change when setup new ports */
>> 
>> The "setup new ports" part is a bit vague. Maybe:
>> 
>> /*
>>  * The SETUP state only happens at the start of migration. A postcopy
>>  * migration recovery migration stays in POSTCOPY_PAUSED.
>>  */
>
> Mentioning SETUP in this if clause might be slightly confusing?  How about
> I only keep the latter sentence (and change it a bit; there's one extra
> "migration")?
>
>   /*
>    * Postcopy migration stays in POSTCOPY_PAUSED even if reconnection
>    * happens.
>    */

Yep.

>
>> 
>> > +        return true;
>> > +    }
>> > +
>> > +    if (current != MIGRATION_STATUS_NONE) {
>> > +        error_setg(errp, "Illegal migration incoming state: %s",
>> > +                   MigrationStatus_str(current));
>> > +        return false;
>> > +    }
>> 
>> This is a good candidate for a separate patch due to the extra change in
>> behavior not necessarily related to postcopy.
>
> I'll split that, but just to mention, I think there should have no
> functional change, or we're doomed.

Right, but it's technically not impossible, so better to have it
separate anyway.

>
> The old code worked the same by ignoring migrate_set_state() when PAUSED in
> the cmpxchg(), which is implicit and unclear.
>

Agreed.

>> 
>> > +
>> > +    migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
>> > +    return true;
>> > +}
>> > +
>> >  static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>> >                                            MigrationChannelList *channels,
>> >                                            Error **errp)
>> > @@ -633,8 +653,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>> >          return;
>> >      }
>> >  
>> > -    migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
>> > -                      MIGRATION_STATUS_SETUP);
>> > +    if (!migration_incoming_state_setup(mis, errp)) {
>> > +        return;
>> > +    }
>> >  
>> >      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> >          SocketAddress *saddr = &addr->u.socket;
>> > @@ -1070,6 +1091,7 @@ bool migration_is_setup_or_active(void)
>> >      case MIGRATION_STATUS_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>> > +    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>> >      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>> >      case MIGRATION_STATUS_SETUP:
>> >      case MIGRATION_STATUS_PRE_SWITCHOVER:
>> > @@ -1092,6 +1114,7 @@ bool migration_is_running(void)
>> >      case MIGRATION_STATUS_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>> > +    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>> >      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>> >      case MIGRATION_STATUS_SETUP:
>> >      case MIGRATION_STATUS_PRE_SWITCHOVER:
>> > @@ -1229,6 +1252,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>> >      case MIGRATION_STATUS_PRE_SWITCHOVER:
>> >      case MIGRATION_STATUS_DEVICE:
>> >      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>> > +    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>> >      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>> >          /* TODO add some postcopy stats */
>> >          populate_time_info(info, s);
>> > @@ -1279,6 +1303,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>> >      case MIGRATION_STATUS_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>> > +    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>> 
>> Does this need to be here? We don't reach this state on destination, right?
>
> Right, it won't hurt having that here, but let me drop it.
>
>> 
>> >      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>> >      case MIGRATION_STATUS_FAILED:
>> >      case MIGRATION_STATUS_COLO:
>> > @@ -1435,9 +1460,30 @@ static void migrate_error_free(MigrationState *s)
>> >  
>> >  static void migrate_fd_error(MigrationState *s, const Error *error)
>> >  {
>> 
>> The default case of the swtich below is a bit surprising to me. Why
>> wouldn't we allow this function to be called from other places to set
>> STATUS_FAILED?
>> 
>> ...unless this is only mean for the connection phase, so:
>> 
>> just to check your understanding here because it seems we've drifted a
>> bit from the original definition on those, specially with
>> migrate_fd_cleanup(), but does this _fd_ in the function name implies
>> something like a "connection phase"? As in, "connect to the fd", "the fd
>> connection errored out" and "cleanup the fd connection". Maybe it's time
>> to switch this "fd" to something clearer...
>
> IIUC it's just that many functions around this area used to be called
> migrate_fd_*().  Let me know if you have some suggestions, though.
>

At some other point I think we need to rename those. Very little going
on in these functions that relates directly to an fd. It needs a closer
inspection, however.

>> 
>> > +    MigrationStatus current = s->state;
>> > +    MigrationStatus next;
>> > +
>> >      assert(s->to_dst_file == NULL);
>> > -    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> > -                      MIGRATION_STATUS_FAILED);
>> > +
>> > +    switch (current) {
>> > +    case MIGRATION_STATUS_SETUP:
>> > +        next = MIGRATION_STATUS_FAILED;
>> > +        break;
>> > +    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>> > +        /* Never fail a postcopy migration; switch back to PAUSED instead */
>> > +        next = MIGRATION_STATUS_POSTCOPY_PAUSED;
>> 
>> So presumably we can keep recovering the migration indefinitely?
>
> Yes, that's by design.
>

ok

>> 
>> > +        break;
>> > +    default:
>> > +        /*
>> > +         * This really shouldn't happen. Just be careful to not crash a VM
>> > +         * just for this.  Instead, dump something.
>> > +         */
>> > +        error_report("%s: Illegal migration status (%s) detected",
>> > +                     __func__, MigrationStatus_str(current));
>> > +        return;
>> > +    }
>> > +
>> > +    migrate_set_state(&s->state, current, next);
>> >      migrate_set_error(s, error);
>> >  }
>> >  
>> > @@ -1538,6 +1584,7 @@ bool migration_in_postcopy(void)
>> >      switch (s->state) {
>> >      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>> >      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>> > +    case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>> >      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>> >          return true;
>> >      default:
>> > @@ -1936,6 +1983,9 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>> >              return false;
>> >          }
>> >  
>> > +        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
>> > +                          MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>> > +
>> >          /* This is a resume, skip init status */
>> >          return true;
>> >      }
>> > @@ -2968,9 +3018,9 @@ static MigThrError postcopy_pause(MigrationState *s)
>> >           * We wait until things fixed up. Then someone will setup the
>> >           * status back for us.
>> >           */
>> > -        while (s->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
>> > +        do {
>> >              qemu_sem_wait(&s->postcopy_pause_sem);
>> > -        }
>> > +        } while (postcopy_is_paused(s->state));
>> 
>> Is there a particular reason to go from while() to do{}while()?
>
> It'll be the same AFAICT, the 1st check should mostly be meaningless as the
> sem must be posted at least once.  Yes I should have had a comment
> somewhere but I didn't.. if you want me to keep the old way it's also fine,
> isn't a big deal here to check first either, just save some cycles when I
> worked on these lines.
>

That's fine. Just making sure there wasn't some hidden purpose here.

>> 
>> >  
>> >          if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
>> >              /* Woken up by a recover procedure. Give it a shot */
>> > @@ -3666,7 +3716,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>> >  {
>> >      Error *local_err = NULL;
>> >      uint64_t rate_limit;
>> > -    bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>> > +    bool resume = migration_in_postcopy();
>> 
>> Here you're expecting just PAUSED or RECOVER_SETUP, right? We'll not
>> reach here in any of the other postcopy states.
>
> I think here it must be RECOVER_SETUP after this patch.  I changed it to
> use the helper as I think that's cleaner (precopy doesn't allow resume),
> and we don't need such change if the state machine trivially changes again.
>

Intent matters for anyone reading the code in the future. I would use
the state explicitly, but I don't have a strong opinion, feel free to
ignore.

>> 
>> >      int ret;
>> >  
>> >      /*
>> > @@ -3733,7 +3783,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>> >  
>> >      if (resume) {
>> >          /* Wakeup the main migration thread to do the recovery */
>> > -        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
>> > +        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
>> >                            MIGRATION_STATUS_POSTCOPY_RECOVER);
>> >          qemu_sem_post(&s->postcopy_pause_sem);
>> >          return;
>> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> > index 97701e6bb2..1c374b7ea1 100644
>> > --- a/migration/postcopy-ram.c
>> > +++ b/migration/postcopy-ram.c
>> > @@ -1770,3 +1770,9 @@ void *postcopy_preempt_thread(void *opaque)
>> >  
>> >      return NULL;
>> >  }
>> > +
>> > +bool postcopy_is_paused(MigrationStatus status)
>> > +{
>> > +    return status == MIGRATION_STATUS_POSTCOPY_PAUSED ||
>> > +        status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
>> > +}
>> > diff --git a/migration/savevm.c b/migration/savevm.c
>> > index e71410d8c1..deb57833f8 100644
>> > --- a/migration/savevm.c
>> > +++ b/migration/savevm.c
>> > @@ -2864,9 +2864,9 @@ static bool postcopy_pause_incoming(MigrationIncomingState *mis)
>> >      error_report("Detected IO failure for postcopy. "
>> >                   "Migration paused.");
>> >  
>> > -    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
>> > +    do {
>> >          qemu_sem_wait(&mis->postcopy_pause_sem_dst);
>> > -    }
>> > +    } while (postcopy_is_paused(mis->state));
>> >  
>> >      trace_postcopy_pause_incoming_continued();
>> 

