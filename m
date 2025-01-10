Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0531AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEln-0000LD-QX; Fri, 10 Jan 2025 08:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWElm-0000Kx-9e
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:09:46 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWElk-0003Lh-1T
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:09:46 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D5C221102;
 Fri, 10 Jan 2025 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736514582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJx/BYPBTMx+1d8b5s2Jp2d5Ba1KKSWFi0GmnAWV2wo=;
 b=GyU18xGb/ZV21uougKPz+EEsjMfdkLM+Ztg+RNXEScoe9FlGnUfgQNzxQMM6V7KvZ0Z0TI
 TqGswRibTN8eoiwd1lCvWUywUkQwY8R6kDaD2WcII5r+VcNcz456ABTk41Hdwqyarg1Vc+
 A8Ya7t4ehU794+WvtiRzKh/sZpdDjkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736514582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJx/BYPBTMx+1d8b5s2Jp2d5Ba1KKSWFi0GmnAWV2wo=;
 b=YUEiL1antSdcq2v7IcIOfIGwD97KH9HtoHPmA75LHFFKIHKBUPMZd23rv1hRQJKP5YmlCh
 QaxRXQfN+Y1yPqDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GyU18xGb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YUEiL1an
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736514582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJx/BYPBTMx+1d8b5s2Jp2d5Ba1KKSWFi0GmnAWV2wo=;
 b=GyU18xGb/ZV21uougKPz+EEsjMfdkLM+Ztg+RNXEScoe9FlGnUfgQNzxQMM6V7KvZ0Z0TI
 TqGswRibTN8eoiwd1lCvWUywUkQwY8R6kDaD2WcII5r+VcNcz456ABTk41Hdwqyarg1Vc+
 A8Ya7t4ehU794+WvtiRzKh/sZpdDjkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736514582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJx/BYPBTMx+1d8b5s2Jp2d5Ba1KKSWFi0GmnAWV2wo=;
 b=YUEiL1antSdcq2v7IcIOfIGwD97KH9HtoHPmA75LHFFKIHKBUPMZd23rv1hRQJKP5YmlCh
 QaxRXQfN+Y1yPqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7D4813763;
 Fri, 10 Jan 2025 13:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 39vNIhUcgWdUWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 13:09:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Shivam Kumar <shivam.kumar1@nutanix.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Shivam Kumar <shivam.kumar1@nutanix.com>
Subject: Re: [RFC PATCH] Fix race in live migration failure path
In-Reply-To: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
Date: Fri, 10 Jan 2025 10:09:38 -0300
Message-ID: <87frlqerxp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4D5C221102
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Shivam Kumar <shivam.kumar1@nutanix.com> writes:

> Even if a live migration fails due to some reason, migration status
> should not be set to MIGRATION_STATUS_FAILED until migrate fd cleanup
> is done, else the client can trigger another instance of migration
> before the cleanup is complete (as it would assume no migration is
> active) or reset migration capabilities affecting old migration's
> cleanup. Hence, set the status to 'failing' when a migration failure
> happens and once the cleanup is complete, set the migration status to
> MIGRATION_STATUS_FAILED.
>
> Signed-off-by: Shivam Kumar <shivam.kumar1@nutanix.com>
> ---
>  migration/migration.c | 49 +++++++++++++++++++++----------------------
>  migration/migration.h |  9 ++++++++
>  migration/multifd.c   |  6 ++----
>  migration/savevm.c    |  7 +++----
>  4 files changed, 38 insertions(+), 33 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index df61ca4e93..f084f54f6b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1143,8 +1143,9 @@ static bool migration_is_active(void)

migration_is_running() is the one that gates qmp_migrate() and
qmp_migrate_set_capabilities().

>  {
>      MigrationState *s = current_migration;
>  
> -    return (s->state == MIGRATION_STATUS_ACTIVE ||
> -            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +    return ((s->state == MIGRATION_STATUS_ACTIVE ||
> +            s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) &&
> +            !qatomic_read(&s->failing));
>  }
>  
>  static bool migrate_show_downtime(MigrationState *s)
> @@ -1439,6 +1440,11 @@ static void migrate_fd_cleanup(MigrationState *s)
>                            MIGRATION_STATUS_CANCELLED);
>      }
>  
> +    if (qatomic_xchg(&s->failing, 0)) {
> +        migrate_set_state(&s->state, s->state,
> +                          MIGRATION_STATUS_FAILED);
> +    }

I hope you've verified that sure every place that used to set FAILED
will also reach migrate_fd_cleanup() eventually.

Also, we probably still need the FAILING state. Otherwise, this will
trip code that expects a state change on failure. Anything that does:

if (state != MIGRATION_STATUS_FOO) {
   ...
}

So I think the change overall should be

-migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);

 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
                        MigrationStatus new_state)
 {
     assert(new_state < MIGRATION_STATUS__MAX);
     if (qatomic_cmpxchg(state, old_state, new_state) == old_state) {
         trace_migrate_set_state(MigrationStatus_str(new_state));

+        if (new_state == MIGRATION_STATUS_FAILING) {
+            qatomic_set(&s->failing, 1);
+        }
         migrate_generate_event(new_state);
     }
 }

And we should proably do the same for CANCELLING actually, but there the
(preexisting) issue is actual concurrency, while here it's just
inconsistency in the state.

> +
>      if (s->error) {
>          /* It is used on info migrate.  We can't free it */
>          error_report_err(error_copy(s->error));
> @@ -1484,17 +1490,16 @@ static void migrate_error_free(MigrationState *s)
>  static void migrate_fd_error(MigrationState *s, const Error *error)
>  {
>      MigrationStatus current = s->state;
> -    MigrationStatus next;
>  
>      assert(s->to_dst_file == NULL);
>  
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
> -        next = MIGRATION_STATUS_FAILED;
> +        qatomic_set(&s->failing, 1);
>          break;
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          /* Never fail a postcopy migration; switch back to PAUSED instead */
> -        next = MIGRATION_STATUS_POSTCOPY_PAUSED;
> +        migrate_set_state(&s->state, current, MIGRATION_STATUS_POSTCOPY_PAUSED);
>          break;
>      default:
>          /*
> @@ -1506,7 +1511,6 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
>          return;
>      }
>  
> -    migrate_set_state(&s->state, current, next);
>      migrate_set_error(s, error);
>  }
>  
> @@ -2101,8 +2105,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>      } else {
>          error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                     "a valid migration protocol");
> -        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                          MIGRATION_STATUS_FAILED);
> +        qatomic_set(&s->failing, 1);
>      }
>  
>      if (local_err) {
> @@ -2498,7 +2501,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>      if (migrate_postcopy_preempt()) {
>          migration_wait_main_channel(ms);
>          if (postcopy_preempt_establish_channel(ms)) {
> -            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +            qatomic_set(&ms->failing, 1);
>              error_setg(errp, "%s: Failed to establish preempt channel",
>                         __func__);
>              return -1;
> @@ -2648,8 +2651,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>  fail_closefb:
>      qemu_fclose(fb);
>  fail:
> -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +    qatomic_set(&ms->failing, 1);
>      if (restart_block) {
>          /* A failure happened early enough that we know the destination hasn't
>           * accessed block devices, so we're safe to recover.
> @@ -2782,8 +2784,7 @@ static void migration_completion_failed(MigrationState *s,
>          bql_unlock();
>      }
>  
> -    migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +    qatomic_set(&s->failing, 1);
>  }
>  
>  /**
> @@ -2850,8 +2851,6 @@ fail:
>   */
>  static void bg_migration_completion(MigrationState *s)
>  {
> -    int current_active_state = s->state;
> -
>      if (s->state == MIGRATION_STATUS_ACTIVE) {
>          /*
>           * By this moment we have RAM content saved into the migration stream.
> @@ -2874,8 +2873,7 @@ static void bg_migration_completion(MigrationState *s)
>      return;
>  
>  fail:
> -    migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +    qatomic_set(&s->failing, 1);
>  }
>  
>  typedef enum MigThrError {
> @@ -3047,6 +3045,10 @@ static MigThrError migration_detect_error(MigrationState *s)
>          return MIG_THR_ERR_FATAL;
>      }
>  
> +    if (qatomic_read(&s->failing)) {
> +        return MIG_THR_ERR_FATAL;
> +    }
> +
>      /*
>       * Try to detect any file errors.  Note that postcopy_qemufile_src will
>       * be NULL when postcopy preempt is not enabled.
> @@ -3077,7 +3079,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>           * For precopy (or postcopy with error outside IO), we fail
>           * with no time.
>           */
> -        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
> +        qatomic_set(&s->failing, 1);
>          trace_migration_thread_file_err();
>  
>          /* Time to stop the migration, now. */
> @@ -3492,8 +3494,7 @@ static void *migration_thread(void *opaque)
>      if (ret) {
>          migrate_set_error(s, local_err);
>          error_free(local_err);
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +        qatomic_set(&s->failing, 1);
>          goto out;
>      }
>  
> @@ -3617,8 +3618,7 @@ static void *bg_migration_thread(void *opaque)
>      if (ret) {
>          migrate_set_error(s, local_err);
>          error_free(local_err);
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +        qatomic_set(&s->failing, 1);
>          goto fail_setup;
>      }
>  
> @@ -3685,8 +3685,7 @@ static void *bg_migration_thread(void *opaque)
>  
>  fail:
>      if (early_fail) {
> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                MIGRATION_STATUS_FAILED);
> +        qatomic_set(&s->failing, 1);
>          bql_unlock();
>      }
>  
> @@ -3805,7 +3804,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>  
>  fail:
>      migrate_set_error(s, local_err);
> -    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +    qatomic_set(&s->failing, 1);
>      error_report_err(local_err);
>      migrate_fd_cleanup(s);
>  }
> diff --git a/migration/migration.h b/migration/migration.h
> index 7b6e718690..3b808d971f 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -471,6 +471,15 @@ struct MigrationState {
>      bool switchover_acked;
>      /* Is this a rdma migration */
>      bool rdma_migration;
> +    /*
> +     * Is migration failing? Migration status should not be set to
> +     * MIGRATION_STATUS_FAILED until migrate fd cleanup is done, else
> +     * the client can trigger another instance of migration before
> +     * the cleanup is complete. Hence, set the status to 'failing'
> +     * when a migration failure happens and once the cleanup is done,
> +     * set it to MIGRATION_STATUS_FAILED.
> +     */
> +    int failing;
>  };
>  
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4f973d70e0..48ece2162c 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -878,8 +878,7 @@ bool multifd_send_setup(void)
>      return true;
>  
>  err:
> -    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_FAILED);
> +    qatomic_set(&s->failing, 1);
>      return false;
>  }
>  
> @@ -949,8 +948,7 @@ static void multifd_recv_terminate_threads(Error *err)
>          migrate_set_error(s, err);
>          if (s->state == MIGRATION_STATUS_SETUP ||
>              s->state == MIGRATION_STATUS_ACTIVE) {
> -            migrate_set_state(&s->state, s->state,
> -                              MIGRATION_STATUS_FAILED);
> +            qatomic_set(&s->failing, 1);
>          }
>      }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 927b1146c0..4f0ef34f23 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1686,7 +1686,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>  {
>      int ret;
>      MigrationState *ms = migrate_get_current();
> -    MigrationStatus status;
>  
>      if (migration_is_running()) {
>          error_setg(errp, "There's a migration process in progress");
> @@ -1723,11 +1722,11 @@ cleanup:
>      qemu_savevm_state_cleanup();
>  
>      if (ret != 0) {
> -        status = MIGRATION_STATUS_FAILED;
> +        qatomic_set(&ms->failing, 1);
>      } else {
> -        status = MIGRATION_STATUS_COMPLETED;
> +        migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP,
> +                          MIGRATION_STATUS_COMPLETED);
>      }
> -    migrate_set_state(&ms->state, MIGRATION_STATUS_SETUP, status);
>  
>      /* f is outer parameter, it should not stay in global migration state after
>       * this function finished */

