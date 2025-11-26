Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03FDD10384
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAPa-0003MZ-4N; Wed, 26 Nov 2025 02:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOAPT-0003Jx-R9
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:57:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOAPQ-0005Cb-Ua
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764143870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LrBEnroPxZhQCkkCgPCCspSVlAGSj+0cKqQ2e2b/+J4=;
 b=E3j0It77ai9OaYMf30jZV2urfbyT1VbxEhJhUmPC3zyoP7oMrMYjN9MuqTRwB8O3ioB6s+
 VXRMHagH288XaM4G1i811L0K5Af1BEgfpXOGczpkMA37QjSmAMwckHbuH1XyNoYbgyae9B
 /mrObKKab7+zuEMFoLxk1mkznhRYitI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-QU0KgaklOF69ONKJRBcwVw-1; Wed,
 26 Nov 2025 02:57:47 -0500
X-MC-Unique: QU0KgaklOF69ONKJRBcwVw-1
X-Mimecast-MFC-AGG-ID: QU0KgaklOF69ONKJRBcwVw_1764143866
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E5DA180047F; Wed, 26 Nov 2025 07:57:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 904D6195608E; Wed, 26 Nov 2025 07:57:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 24A0C21E6A27; Wed, 26 Nov 2025 08:57:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH for-11.0 6/6] migration: Replace migrate_set_error()
 with migrate_error_propagate()
In-Reply-To: <20251125204648.857018-7-peterx@redhat.com> (Peter Xu's message
 of "Tue, 25 Nov 2025 15:46:48 -0500")
References: <20251125204648.857018-1-peterx@redhat.com>
 <20251125204648.857018-7-peterx@redhat.com>
Date: Wed, 26 Nov 2025 08:57:43 +0100
Message-ID: <87pl95dy4o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> migrate_set_error() currently doesn't take ownership of the error being
> passed in.  It's not aligned with the error API and meanwhile it also
> makes most of the caller free the error explicitly.
>
> Change the API to take the ownership of the Error object instead.  When at
> it, remove the first parameter so it's friendly to g_clear_pointer().  It
> can be used whenever the caller wants to provide extra safety measure (or
> reuse the pointer) to reset the Error* pointer after stolen.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Worth mentioning that this avoids Error object copies?

> ---
>  migration/migration.h            |  2 +-
>  migration/cpr-exec.c             |  4 +--
>  migration/migration.c            | 46 +++++++++++++++-----------------
>  migration/multifd-device-state.c |  5 +---
>  migration/multifd.c              | 19 +++++++------
>  migration/postcopy-ram.c         |  5 ++--
>  migration/ram.c                  |  4 +--
>  migration/savevm.c               | 15 ++++-------
>  8 files changed, 42 insertions(+), 58 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 213b33fe6e..df74f9b14f 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -525,7 +525,7 @@ void migration_incoming_process(void);
>  
>  bool  migration_has_all_channels(void);
>  
> -void migrate_set_error(MigrationState *s, const Error *error);
> +void migrate_error_propagate(Error *error);
>  bool migrate_has_error(MigrationState *s);
>  
>  void migration_connect(MigrationState *s, Error *error_in);
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> index 0b8344a86f..13e6138f56 100644
> --- a/migration/cpr-exec.c
> +++ b/migration/cpr-exec.c
> @@ -158,9 +158,7 @@ static void cpr_exec_cb(void *opaque)
>  
>      error_report_err(error_copy(err));
>      migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> -    migrate_set_error(s, err);
> -    error_free(err);
> -    err = NULL;
> +    g_clear_pointer(&err, migrate_error_propagate);
>  
>      /* Note, we can go from state COMPLETED to FAILED */
>      migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);

I dislike g_clear_pointer(), and I dislike the change from taking the
migration state as argument to getting the global migration state with
migrate_get_current().  The loss of similarity to error_propagate() is
unfortunate, but tolerable.  This is not a demand.

For each hunk, we need to prove that the migrate_set_error()'s first
argument before the patch equals migrate_get_current() afterwards.

For this hunk, it's locally obvious: @s is initialized to
migrate_get_current() at the beginning of the funtion.

Where it's not locally obvious, I guess we could argue that just one
MigrationState object exists, so a MigrationState * can only point to
that one.

If locally non-obvious hunks exist, such an argument needs to be made in
the commit message.

I did *not* check this aspect of the patch.

> diff --git a/migration/migration.c b/migration/migration.c
> index 4fe69cc2ef..219d3129cb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -914,9 +914,7 @@ process_incoming_migration_co(void *opaque)
>  fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
> -    migrate_set_error(s, local_err);
> -    error_free(local_err);
> -
> +    migrate_error_propagate(local_err);
>      migration_incoming_state_destroy();
>  
>      if (mis->exit_on_error) {
> @@ -1548,14 +1546,22 @@ static void migration_cleanup_bh(void *opaque)
>      migration_cleanup(opaque);
>  }
>  
> -void migrate_set_error(MigrationState *s, const Error *error)
> +/*
> + * Propagate the Error* object to migration core.  The caller mustn't
> + * reference the error pointer after the function returned, because the
> + * Error* object might be freed.
> + */
> +void migrate_error_propagate(Error *error)
>  {
> -    QEMU_LOCK_GUARD(&s->error_mutex);
> +    MigrationState *s = migrate_get_current();
>  
> +    QEMU_LOCK_GUARD(&s->error_mutex);
>      trace_migrate_error(error_get_pretty(error));
>  
>      if (!s->error) {
> -        s->error = error_copy(error);
> +        s->error = error;
> +    } else {
> +        error_free(error);
>      }
>  }
>  
> @@ -1601,8 +1607,7 @@ static void migration_connect_set_error(MigrationState *s, Error *error)
>      }
>  
>      migrate_set_state(&s->state, current, next);
> -    migrate_set_error(s, error);
> -    error_free(error);
> +    migrate_error_propagate(error);
>  }
>  
>  void migration_cancel(void)
> @@ -2014,8 +2019,7 @@ void qmp_migrate_pause(Error **errp)
>  
>          /* Tell the core migration that we're pausing */
>          error_setg(&error, "Postcopy migration is paused by the user");
> -        migrate_set_error(ms, error);
> -        error_free(error);
> +        migrate_error_propagate(error);
>  
>          qemu_mutex_lock(&ms->qemu_file_lock);
>          if (ms->to_dst_file) {
> @@ -2647,8 +2651,7 @@ static void *source_return_path_thread(void *opaque)
>  
>  out:
>      if (err) {
> -        migrate_set_error(ms, err);
> -        error_free(err);
> +        migrate_error_propagate(err);
>          trace_source_return_path_thread_bad_end();
>      }
>  
> @@ -3094,12 +3097,10 @@ static void migration_completion(MigrationState *s)
>  
>  fail:
>      if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> -        migrate_set_error(s, local_err);
> -        error_free(local_err);
> +        migrate_error_propagate(local_err);
>      } else if (ret) {
>          error_setg_errno(&local_err, -ret, "Error in migration completion");
> -        migrate_set_error(s, local_err);
> -        error_free(local_err);
> +        migrate_error_propagate(local_err);
>      }
>  
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> @@ -3326,8 +3327,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>      }
>  
>      if (local_error) {
> -        migrate_set_error(s, local_error);
> -        error_free(local_error);
> +        migrate_error_propagate(local_error);
>      }
>  
>      if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
> @@ -3522,7 +3522,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>          if (must_precopy <= s->threshold_size &&
>              can_switchover && qatomic_read(&s->start_postcopy)) {
>              if (postcopy_start(s, &local_err)) {
> -                migrate_set_error(s, local_err);
> +                migrate_error_propagate(error_copy(local_err));

First hunk where we don't save a copy.  Reason: we report in addition to
propagate.  There are a several more below.

"Forking" the error like this gives me an uneasy feeling, as explained
in
    Subject: Re: [PATCH 0/3] migration: Error fixes and improvements
    Date: Tue, 18 Nov 2025 08:44:32 +0100
    Message-ID: <87a50jlr8f.fsf@pond.sub.org>

Clearly out of scope for this series.

>                  error_report_err(local_err);
>              }
>              return MIG_ITERATE_SKIP;
> @@ -3819,8 +3819,7 @@ static void *migration_thread(void *opaque)
>       * devices to unplug. This to preserve migration state transitions.
>       */
>      if (ret) {
> -        migrate_set_error(s, local_err);
> -        error_free(local_err);
> +        migrate_error_propagate(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>                            MIGRATION_STATUS_FAILED);
>          goto out;
> @@ -3944,8 +3943,7 @@ static void *bg_migration_thread(void *opaque)
>       * devices to unplug. This to preserve migration state transitions.
>       */
>      if (ret) {
> -        migrate_set_error(s, local_err);
> -        error_free(local_err);
> +        migrate_error_propagate(local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>                            MIGRATION_STATUS_FAILED);
>          goto fail_setup;
> @@ -4127,7 +4125,7 @@ void migration_connect(MigrationState *s, Error *error_in)
>      return;
>  
>  fail:
> -    migrate_set_error(s, local_err);
> +    migrate_error_propagate(error_copy(local_err));
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
>      }
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> index db3239fef5..3040d70872 100644
> --- a/migration/multifd-device-state.c
> +++ b/migration/multifd-device-state.c
> @@ -143,8 +143,6 @@ static int multifd_device_state_save_thread(void *opaque)
>      Error *local_err = NULL;
>  
>      if (!data->hdlr(data, &local_err)) {
> -        MigrationState *s = migrate_get_current();
> -
>          /*
>           * Can't call abort_device_state_save_threads() here since new
>           * save threads could still be in process of being launched
> @@ -158,8 +156,7 @@ static int multifd_device_state_save_thread(void *opaque)
>           * In case of multiple save threads failing which thread error
>           * return we end setting is purely arbitrary.
>           */
> -        migrate_set_error(s, local_err);
> -        error_free(local_err);
> +        migrate_error_propagate(local_err);
>      }
>  
>      return 0;
> diff --git a/migration/multifd.c b/migration/multifd.c
> index c861b4b557..99717b64e9 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -428,8 +428,9 @@ static void multifd_send_set_error(Error *err)
>  
>      if (err) {
>          MigrationState *s = migrate_get_current();
> -        migrate_set_error(s, err);
> -        error_free(err);
> +
> +        migrate_error_propagate(err);
> +
>          if (s->state == MIGRATION_STATUS_SETUP ||
>              s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
>              s->state == MIGRATION_STATUS_DEVICE ||
> @@ -588,8 +589,7 @@ void multifd_send_shutdown(void)
>          Error *local_err = NULL;
>  
>          if (!multifd_send_cleanup_channel(p, &local_err)) {
> -            migrate_set_error(migrate_get_current(), local_err);
> -            error_free(local_err);
> +            migrate_error_propagate(local_err);
>          }
>      }
>  
> @@ -962,8 +962,7 @@ bool multifd_send_setup(void)
>          p->write_flags = 0;
>  
>          if (!multifd_new_send_channel_create(p, &local_err)) {
> -            migrate_set_error(s, local_err);
> -            error_free(local_err);
> +            migrate_error_propagate(local_err);
>              ret = -1;
>          }
>      }
> @@ -987,8 +986,7 @@ bool multifd_send_setup(void)
>  
>          ret = multifd_send_state->ops->send_setup(p, &local_err);
>          if (ret) {
> -            migrate_set_error(s, local_err);
> -            error_free(local_err);
> +            migrate_error_propagate(local_err);
>              goto err;
>          }
>          assert(p->iov);
> @@ -1067,8 +1065,9 @@ static void multifd_recv_terminate_threads(Error *err)
>  
>      if (err) {
>          MigrationState *s = migrate_get_current();
> -        migrate_set_error(s, err);
> -        error_free(err);
> +
> +        migrate_error_propagate(err);
> +
>          if (s->state == MIGRATION_STATUS_SETUP ||
>              s->state == MIGRATION_STATUS_ACTIVE) {
>              migrate_set_state(&s->state, s->state,
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 7c9fe61041..856366072a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1927,8 +1927,7 @@ postcopy_preempt_send_channel_done(MigrationState *s,
>                                     QIOChannel *ioc, Error *local_err)
>  {
>      if (local_err) {
> -        migrate_set_error(s, local_err);
> -        error_free(local_err);
> +        migrate_error_propagate(local_err);
>      } else {
>          migration_ioc_register_yank(ioc);
>          s->postcopy_qemufile_src = qemu_file_new_output(ioc);
> @@ -2162,7 +2161,7 @@ static void *postcopy_listen_thread(void *opaque)
>               * exit depending on if postcopy-exit-on-error is true, but the
>               * migration cannot be recovered.
>               */
> -            migrate_set_error(migr, local_err);
> +            migrate_error_propagate(error_copy(local_err));
>              error_report_err(local_err);
>              migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
>              goto out;
> diff --git a/migration/ram.c b/migration/ram.c
> index 29f016cb25..1d2a47526e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4730,9 +4730,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>           * Abort and indicate a proper reason.
>           */
>          error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
> -        migrate_set_error(migrate_get_current(), err);
> -        error_free(err);
> -
> +        migrate_error_propagate(err);
>          migration_cancel();
>      }
>  
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 638e9b364f..ab9d1e579e 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1125,13 +1125,12 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
>  int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
>  {
>      uint32_t tmp;
> -    MigrationState *ms = migrate_get_current();
>      Error *local_err = NULL;
>  
>      if (len > MAX_VM_CMD_PACKAGED_SIZE) {
>          error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
>                       __func__, len);
> -        migrate_set_error(ms, local_err);
> +        migrate_error_propagate(error_copy(local_err));
>          error_report_err(local_err);
>          return -1;
>      }
> @@ -1373,7 +1372,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>          if (se->vmsd && se->vmsd->early_setup) {
>              ret = vmstate_save(f, se, vmdesc, errp);
>              if (ret) {
> -                migrate_set_error(ms, *errp);
> +                migrate_error_propagate(error_copy(*errp));

Here, we need to keep the copy because we additionally propagate to the
caller.

>                  qemu_file_set_error(f, ret);
>                  break;
>              }

[...]


