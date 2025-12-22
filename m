Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE79CE674B9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 14:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgvU-0006Nv-7O; Mon, 22 Dec 2025 09:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vXgvI-0006Mr-29
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:30:12 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vXgvF-0004NQ-7C
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:30:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DAEC65BCD3;
 Mon, 22 Dec 2025 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766413801; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVdhzE1iKIyLQESL2QvJFmkTPkZmd7EDmIgKEMSxtRo=;
 b=ae2jIY3/3tepFi1ZWUd+IowcfpssUyy5lrgUUgVlrFl7dI7SbDxnpcXc7aLi9k49+CRZ1Z
 KvU2DhrBPT9YST6ceYFQWtom7LAIR/59EOh9f94iSZEbReGklHC/bL+3emsbKwHRlKwuVj
 yKd3mk68PCtmgHYRjsIy/0OQi8GqXU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766413801;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVdhzE1iKIyLQESL2QvJFmkTPkZmd7EDmIgKEMSxtRo=;
 b=8twvhKMCW7Xwl2Ik68rIv0lwXtFqFx3UHV7qsnENNWHPZD7+Bc+8+UvJkEyCxnxChN5oC2
 gGArN7jlET6LbcBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AnnjnNTH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LyrYrkHT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766413800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVdhzE1iKIyLQESL2QvJFmkTPkZmd7EDmIgKEMSxtRo=;
 b=AnnjnNTHkKMh5iBd1eufo1/ZQU+2rhPya8JhTPbSttTndwzvJJHdtj5Ly0wQeIreaLs6ea
 LkAuGkHPw0pWqjJ18WToY7gdEg7b7O/OCu3AMBsz75qi12NZG3V2NsSxjtiMOsyYm6IObb
 aWFET3m3HzL9iIwcLRwrkLlGWya1VoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766413800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TVdhzE1iKIyLQESL2QvJFmkTPkZmd7EDmIgKEMSxtRo=;
 b=LyrYrkHTDvn9Rw6Ag9/DQqrensdBox/sEPpGspoLCnkP2C0uzBDkxJ4sdMaYvTqCmy5SMg
 DtSpAPz1tYGXayAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BC1A3EA63;
 Mon, 22 Dec 2025 14:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q8AgCOhVSWkzAQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 22 Dec 2025 14:30:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
In-Reply-To: <20251222114822.327623-1-ppandit@redhat.com>
References: <20251222114822.327623-1-ppandit@redhat.com>
Date: Mon, 22 Dec 2025 11:29:57 -0300
Message-ID: <87h5tilhcq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: DAEC65BCD3
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,fedoraproject.org:email,suse.de:dkim,suse.de:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> When migration connection is broken, the QEMU and libvirtd(8)
> process on the source side receive TCP connection reset
> notification. QEMU sets the migration status to FAILED and
> proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
> a QMP command to migrate_set_capabilities().
>
> The migration_cleanup() and qmp_migrate_set_capabilities()
> calls race with each other. When the latter is invoked first,
> since the migration is not running (FAILED), migration
> capabilities are reset to false, so during migration_cleanup()
> the QEMU process crashes with assertion failure.
>
>   Stack trace of thread 255014:
>    #0  __pthread_kill_implementation (libc.so.6 + 0x822e8)
>    #1  raise (libc.so.6 + 0x3a73c)
>    #2  abort (libc.so.6 + 0x27034)
>    #3  __assert_fail_base (libc.so.6 + 0x34090)
>    #4  __assert_fail (libc.so.6 + 0x34100)
>    #5  yank_unregister_instance (qemu-kvm + 0x8b8280)
>    #6  migrate_fd_cleanup (qemu-kvm + 0x3c6308)
>    #7  migration_bh_dispatch_bh (qemu-kvm + 0x3c2144)
>    #8  aio_bh_poll (qemu-kvm + 0x8ba358)
>    #9  aio_dispatch (qemu-kvm + 0x8a0ab4)
>    #10 aio_ctx_dispatch (qemu-kvm + 0x8bb180)
>

This doesn't look like it's caused by set-capabilities. Seems like:

qmp_migrate()               
-> migrate_init()           
   s->to_dst_file = NULL;
bql_unlock() somewhere
                            bql_lock()
                            migration_cleanup()
                            tmp = s->to_dst_file;
                            if (tmp) {
                                migration_ioc_unregister_yank_from_file(tmp);
                            ...
                            yank_unregister_instance()
                            *sees the function was not unregistered*

Please clarify, there might be some other bug lurking around, such as a
locking issue with qemu_file_lock or even the BQL.

Also, if possible provide an upstream backtrace, or at least mention the
code path based on upstream code. It's ok to keep the downstream
backtrace, but point that out in the commit message.

> Introduce a new migration status FAILING and use it as an
> interim status when an error occurs. Once migration_cleanup()
> is done, it sets the migration status to FAILED. This helps
> to avoid the above race condition and ensuing failure.

I'm fine with the general idea:

i) FAILED and CANCELLED are terminal states. It makes sense to not have
work happen after they're set.

ii) Using an intermediate state, assuming locking/atomic are correct is
a suitable fix for the issue.

iii) Using a FAILING status seems appropriate.

However,

It would be great if we could stop exposing implementation details via
QAPI. Does the user really need to see events for CANCELLING and
FAILING?

It would probably be easier if we kept MigrationStatus as QAPI only and
used a separate mechanism to track the internal states.

That said, we could merge this as is to fix the bug and think about that
later.

>
> Interim status FAILING is set wherever the execution moves
> towards migration_cleanup() directly OR via:
>
>   migration_iteration_finish  bg_migration_iteration_finish
>   -> migration_bh_schedule    -> migration_bh_schedule
>    -> migration_cleanup_bh     -> migration_cleanup_bh
>     -> migration_cleanup        -> migration_cleanup
>      -> FAILED                   -> FAILED
>
> The migration status finally moves to FAILED and reports an
> appropriate error to the user.
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c                 | 33 +++++++++++++++------------
>  migration/multifd.c                   |  4 ++--
>  qapi/migration.json                   |  8 ++++---
>  tests/qtest/migration/migration-qmp.c |  3 ++-
>  tests/qtest/migration/precopy-tests.c |  5 ++--
>  5 files changed, 31 insertions(+), 22 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b316ee01ab..5c32bc8fe5 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1216,6 +1216,7 @@ bool migration_is_running(void)
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_WAIT_UNPLUG:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_COLO:
>          return true;
>      default:
> @@ -1351,6 +1352,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          break;
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_POSTCOPY_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_PRE_SWITCHOVER:
> @@ -1409,6 +1411,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
> @@ -1531,6 +1534,9 @@ static void migration_cleanup(MigrationState *s)
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                            MIGRATION_STATUS_CANCELLED);
> +    } else if (s->state == MIGRATION_STATUS_FAILING) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
> +                          MIGRATION_STATUS_FAILED);
>      }
>  
>      if (s->error) {
> @@ -1584,7 +1590,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
>  
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
> -        next = MIGRATION_STATUS_FAILED;
> +        next = MIGRATION_STATUS_FAILING;
>          break;
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
> @@ -1728,6 +1734,7 @@ bool migration_has_failed(MigrationState *s)
>  {
>      return (s->state == MIGRATION_STATUS_CANCELLING ||
>              s->state == MIGRATION_STATUS_CANCELLED ||
> +            s->state == MIGRATION_STATUS_FAILING ||
>              s->state == MIGRATION_STATUS_FAILED);
>  }
>  
> @@ -2744,7 +2751,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>          if (postcopy_preempt_establish_channel(ms)) {
>              if (ms->state != MIGRATION_STATUS_CANCELLING) {
>                  migrate_set_state(&ms->state, ms->state,
> -                                  MIGRATION_STATUS_FAILED);
> +                                  MIGRATION_STATUS_FAILING);
>              }
>              error_setg(errp, "%s: Failed to establish preempt channel",
>                         __func__);
> @@ -2907,7 +2914,7 @@ fail_closefb:
>      qemu_fclose(fb);
>  fail:
>      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
>      }

This is a good example where having MigrationStatus makes the code more
complicated. This could be exiting=true, running=false, etc. It
shouldn't matter why this routine failed. If we reach
migration_cleanup() and, at the very end, state is CANCELLING, then we
know the cancel command has caused this and set the state to
CANCELLED. If the state was something else, then it's unintended and we
set FAILED.

>      migration_block_activate(NULL);
>      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
> @@ -3102,7 +3109,7 @@ fail:
>      }
>  
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
>      }
>  }
>  
> @@ -3139,7 +3146,7 @@ static void bg_migration_completion(MigrationState *s)
>  
>  fail:
>      migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>  }
>  
>  typedef enum MigThrError {
> @@ -3341,7 +3348,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>           * For precopy (or postcopy with error outside IO, or before dest
>           * starts), we fail with no time.
>           */
> -        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILING);
>          trace_migration_thread_file_err();
>  
>          /* Time to stop the migration, now. */
> @@ -3572,7 +3579,7 @@ static void migration_iteration_finish(MigrationState *s)
>          migrate_start_colo_process(s);
>          s->vm_old_state = RUN_STATE_RUNNING;
>          /* Fallthrough */
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          if (!migration_block_activate(&local_err)) {
> @@ -3631,7 +3638,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
>      switch (s->state) {
>      case MIGRATION_STATUS_COMPLETED:
>      case MIGRATION_STATUS_ACTIVE:
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          break;
> @@ -3821,7 +3828,7 @@ static void *migration_thread(void *opaque)
>          migrate_set_error(s, local_err);
>          error_free(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +                          MIGRATION_STATUS_FAILING);
>          goto out;
>      }
>  
> @@ -3945,8 +3952,6 @@ static void *bg_migration_thread(void *opaque)
>      if (ret) {
>          migrate_set_error(s, local_err);
>          error_free(local_err);
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
>          goto fail_setup;
>      }
>  
> @@ -4008,12 +4013,12 @@ static void *bg_migration_thread(void *opaque)
>  
>  fail:
>      if (early_fail) {
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                MIGRATION_STATUS_FAILED);
>          bql_unlock();
>      }
>  
>  fail_setup:
> +    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                        MIGRATION_STATUS_FAILING);
>      bg_migration_iteration_finish(s);
>  
>      qemu_fclose(fb);
> @@ -4128,7 +4133,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>  fail:
>      migrate_set_error(s, local_err);
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
>      }
>      error_report_err(local_err);
>      migration_cleanup(s);
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3203dc98e1..970633474e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -434,7 +434,7 @@ static void multifd_send_set_error(Error *err)
>              s->state == MIGRATION_STATUS_DEVICE ||
>              s->state == MIGRATION_STATUS_ACTIVE) {
>              migrate_set_state(&s->state, s->state,
> -                              MIGRATION_STATUS_FAILED);
> +                              MIGRATION_STATUS_FAILING);
>          }
>      }
>  }
> @@ -1001,7 +1001,7 @@ bool multifd_send_setup(void)
>  
>  err:
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>      return false;
>  }
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index cf023bd29d..85f4961781 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -158,7 +158,9 @@
>  #
>  # @completed: migration is finished.
>  #
> -# @failed: some error occurred during migration process.
> +# @failing: error occurred during migration, clean-up underway.

"wait a moment, we're picking up the pieces" =D

> +#
> +# @failed: error occurred during migration, clean-up done.
>  #
>  # @colo: VM is in the process of fault tolerance, VM can not get into
>  #     this state unless colo capability is enabled for migration.
> @@ -181,8 +183,8 @@
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
>              'active', 'postcopy-device', 'postcopy-active',
>              'postcopy-paused', 'postcopy-recover-setup',
> -            'postcopy-recover', 'completed', 'failed', 'colo',
> -            'pre-switchover', 'device', 'wait-unplug' ] }
> +            'postcopy-recover', 'completed', 'failing', 'failed',
> +            'colo', 'pre-switchover', 'device', 'wait-unplug' ] }
>  
>  ##
>  # @VfioStats:
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index c803fcee9d..ceb40efd56 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -241,7 +241,8 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
>      do {
>          status = migrate_query_status(from);
>          bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
> -            (allow_active && !strcmp(status, "active"));
> +            (allow_active && !strcmp(status, "active")) ||
> +            !strcmp(status, "failing");
>          if (!result) {
>              fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
>                      __func__, status, allow_active);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 57ca623de5..a04442df96 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -807,7 +807,8 @@ static void test_cancel_src_after_status(void *opaque)
>      } else if (g_str_equal(phase, "completed")) {
>          test_cancel_src_after_complete(from, to, uri, phase);
>  
> -    } else if (g_str_equal(phase, "failed")) {
> +    } else if (g_str_equal(phase, "failing") ||
> +               g_str_equal(phase, "failed")) {
>          test_cancel_src_after_failed(from, to, uri, phase);
>  
>      } else if (g_str_equal(phase, "none")) {
> @@ -1316,7 +1317,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>      }
>  
>      /* ensure new status don't go unnoticed */
> -    assert(MIGRATION_STATUS__MAX == 16);
> +    assert(MIGRATION_STATUS__MAX == 17);
>  
>      for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
>          switch (i) {

