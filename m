Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13394CFA474
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 21:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3iWD-0005Wt-9c; Wed, 23 Oct 2024 17:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t3iW7-0005WR-VK
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:03:44 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t3iW5-0004nF-Q4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 17:03:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B84C121C4E;
 Wed, 23 Oct 2024 21:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729717419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yph0hL0hkeNJgSx1WHV107pYUnTBPDrt+AYaoz3smOY=;
 b=lBA9KgYML5CjR96qUrzQ8edmX8xZX5cPlkAMuK6lQd+lyEsmKo+fynOXMrEyD6TC217GSl
 gtQHp8lANRAx4v2uNkRAP5AqCJD9IhZK94HrQWCZbi+nBMgH7EbnoQqqrvpYBL1NHa/mSh
 f9EbBefJXoBfrlWKbxOWLHS66L9uMXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729717419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yph0hL0hkeNJgSx1WHV107pYUnTBPDrt+AYaoz3smOY=;
 b=448j2+9MBKGLsccGzbM8juu1Du5HtPt1lTs5q4rw/2HTYq4ihetJVcJKHVpqEUC1lSKA4c
 Jj7OcoS13wj5cXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729717419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yph0hL0hkeNJgSx1WHV107pYUnTBPDrt+AYaoz3smOY=;
 b=lBA9KgYML5CjR96qUrzQ8edmX8xZX5cPlkAMuK6lQd+lyEsmKo+fynOXMrEyD6TC217GSl
 gtQHp8lANRAx4v2uNkRAP5AqCJD9IhZK94HrQWCZbi+nBMgH7EbnoQqqrvpYBL1NHa/mSh
 f9EbBefJXoBfrlWKbxOWLHS66L9uMXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729717419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yph0hL0hkeNJgSx1WHV107pYUnTBPDrt+AYaoz3smOY=;
 b=448j2+9MBKGLsccGzbM8juu1Du5HtPt1lTs5q4rw/2HTYq4ihetJVcJKHVpqEUC1lSKA4c
 Jj7OcoS13wj5cXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F0C513A63;
 Wed, 23 Oct 2024 21:03:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v1GNAatkGWchBwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 23 Oct 2024 21:03:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH v2 0/4] Migration: Make misc.h helpers available for
 whole VM lifecycle
In-Reply-To: <ZxlWjpVfRzCg1PJA@x1n>
References: <20241023180216.1072575-1-peterx@redhat.com>
 <87ed46fwem.fsf@suse.de> <ZxlWjpVfRzCg1PJA@x1n>
Date: Wed, 23 Oct 2024 18:03:36 -0300
Message-ID: <87bjzafs5z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Oct 23, 2024 at 04:32:01PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > This is a follow up of below patch from Avihai as a replacement:
>> >
>> > https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/
>> >
>> > This is v2 of the series, and it became a more generic rework on how we do
>> > migration object refcounts, so I skipped a changelog because most of this
>> > is new things.
>> >
>> > To put it simple, now I introduced another pointer to migration object, and
>> > here's a simple explanation for both after all change applied (copy-paste
>> > from one of the patch):
>> >
>> > /*
>> >  * We have two pointers for the global migration objects.  Both of them are
>> >  * initialized early during QEMU starts, but they have different lifecycles.
>> 
>> The very next person that needs to access one of those in migration code
>> will get this wrong.
>
> Migration code should never access global_migration except during init /
> shutdown (or a renamed version of it), that's the plan.. so no one should
> use it within migration/.

Right, but consider that it's easy enough for someone to look for a
global object to write in the code, find the wrong one and just use
it. It would then be up to reviewers to catch the mistake.

Look at this:

  bool migration_is_idle(void)
  {
      MigrationState *s = current_migration;
      ...
  }
  
  bool migration_is_active(void)
  {
      MigrationState *s = global_migration;
      ...
  }

Of course we'll get this wrong at some point.

Also, if in the future someone decides to call migration_is_idle() from
outside migration/, we'd be not only adding the burden to change the
variable, but also the functional change at shutdown time.

If we're to carry on with this idea, we'll need to play with some
headers to properly isolate these two usages. Something like:

migration.h:
  bool migration_is_active_internal(MigrationState *s);
  void set_global_obj(MigrationState *obj);

migration.c:
  bool migration_is_active_internal(MigrationState *s)
  {
  }

  void migration_object_init(void)
  {
      set_global_object(MIGRATION_OBJ(object_new(TYPE_MIGRATION)));
  }

exports.h:
  #include migration.h
  bool migration_is_active(void);

exports.c:
  static MigrationState *global_migration;
  
  void set_global_obj(MigrationState *obj)
  {
      global_migration = obj;
  }
  
  bool migration_is_active(void)
  {
      return migration_is_active_internal(global_migration);
  }

That way, the internal code never calls the exported functions with
global, always with current.

>> 
>> >  *
>> >  * - current_migration
>> >  *
>> >  *   This variable reflects the whole lifecycle of the migration object
>> >  *   (which each QEMU can only have one).  It is valid until the migration
>> >  *   object is destroyed.
>> >  *
>> >  *   This is the object that internal migration so far use.  For example,
>> >  *   internal helper migrate_get_current() references it.
>> >  *
>> >  *   When all migration code can always pass over a MigrationState* around,
>> >  *   this variable can logically be dropped.  But we're not yet there.
>> 
>> Won't dropping it just bring us back to the situation before this patch?
>> I'd say we need the opposite, to stop using migrate_get_current()
>> everywhere in the migration code and instead expose the
>> current_migration via an internal header.
>
> I meant dropping all the global access to current_migration within
> migration/ dir.
>
> Consider all functions has the 1st parameter as MigrationState*, for
> example.  Then we don't need that for internal use, while global_migration
> is still needed for external use, but only for external use.
>
>> 
>> >  *
>> >  * - global_migration
>> 
>> Both are global, we can't prefix one of them with global_.
>
> I can rename it to migration_export, but the question is whether the name
> is the issue, or you'd think having two global variables pointing to
> migration object is the issue / concern.
>
> So I think fundaementally we indeed only need one global var there, if we
> can cleanup the migration/ everywhere to always take the pointer from the
> caller, then migration thread will take 1 refcount and that guarantees it's
> available for migration/.

We can discuss when we get to that point, but that might make the code
too cumbersome. Having to change signatures all the time to
include/remove MigrationState.

>
>> 
>> >  *
>> >  *   This is valid only until the migration object is still valid to the
>> >  *   outside-migration world (until migration_shutdown()).
>> >  *
>> >  *   This should normally be always set, cleared or accessed by the main
>> >  *   thread only, rather than the migration thread.
>> >  *
>> >  *   All the exported functions (in include/migration) should reference the
>> >  *   exported migration object only to avoid race conditions, as
>> >  *   current_migration can be freed concurrently by migration thread when
>> >  *   the migration thread holds the last refcount.
>> >  */
>> 
>> Have you thought of locking the migration object instead?
>
> Yes, logically we could use RCU if we want, then take BQL for example only
> if update.  but I worry that's an overkill: we'll need too many rcu read
> lock all over the places..
>
>> 
>> Having two global pointers to the same object with one having slightly
>> different lifecycle than the other will certainly lead to misuse.
>
> That's indeed tricky, it's just that this is so far the easiest change I
> can think of.
>
>> 
>> I worry about mixing the usage of both globals due to some migration
>> code that needs to call these exported functions or external code
>> reaching into migration/ through some indirect path. Check global and
>> try to use current sort of scenarios (and vice-versa).
>
> Yeh I get your concern.  I actually tried to observe such usages (for now,
> especially when migration/ uses the misc.h exported functions) and they're
> all safe.  I should have mentioned that.

I'm afraid that's not enough, code changes after all. It's not possible
to carry these requirements to the future, we must account for the gaps
now.

>
> For the other way round, I don't yet expect that to happen: the plan is
> anything outside must call a function in include/migration/* and that must
> only use global_migration.
>
>> 
>> Similarly, what about when a lingering reference still exists, but
>> global_migration is already clear? Any migration code looking at
>> global_migration would do the wrong thing.
>
> That's how it works: migration thread will take one refcount and that'll
> happen when migration is running but when VM shutdowns itself.  I checked
> that all the migration code should be fine when using the exported
> functions even if they should reference current_migration.
>
> So logically if with such design, indeed internal migration/ code shouldn't
> reference global_migration at all just to be always safe.
>
> Any idea in your mind that can make this easier?  I'm definitely open to
> suggestions.
>
>> 
>> >
>> > It allows all misc.h exported helpers to be used for the whole VM
>> > lifecycle, so as to never crash QEMU with freed migration objects.
>> 
>> Isn't there a race with the last reference being dropped at
>> migration_shutdown() and global_migration still being set?
>
> It needs to be protected by BQL in this case, so anyone using exported
> functions need to take BQL first.

Even code under migration/ ? All the various threads? The BQL is a
heavyweight lock. We shouldn't be adding more instances of it unless it
protects against something from the main loop/other subsystems.

>
>> 
>> >
>> > Thanks,
>> >
>> > Peter Xu (4):
>> >   migration: Unexport dirty_bitmap_mig_init() in misc.h
>> >   migration: Reset current_migration properly
>> >   migration: Add global_migration
>> >   migration: Make all helpers in misc.h safe to use without migration
>> >
>> >  include/migration/misc.h | 29 ++++++++----
>> >  migration/migration.h    |  4 ++
>> >  migration/migration.c    | 99 +++++++++++++++++++++++++++++++++++-----
>> >  3 files changed, 113 insertions(+), 19 deletions(-)
>> 

