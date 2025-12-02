Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AF6D1171E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 17:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQUBJ-0006Vq-Rw; Tue, 02 Dec 2025 12:28:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQUBF-0006Ux-OQ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQUBC-0002Sx-Q6
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 12:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764696523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F6AHkRzWAPoSK9XSw2yAyUFU9k796GZ2VQUQbPaFyNo=;
 b=EpC/rDVITFP78QMwj8mkn13JZl4eMQmxsoAK2PNAFktx/4SI8KA8TsAJZZRBERJrME6KFK
 KB05iIzvqfIV4tA04Rkf54z3h8Ul8nKYR5Hdh5bDZk2U72OhVUlbaY5DlcFZ2T1OeIsXWu
 lg9xFIaOLL5KD0s1puOuo5qK6bYDDjw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-BVovklPFPSKhifwyY8i6VQ-1; Tue, 02 Dec 2025 12:28:41 -0500
X-MC-Unique: BVovklPFPSKhifwyY8i6VQ-1
X-Mimecast-MFC-AGG-ID: BVovklPFPSKhifwyY8i6VQ_1764696521
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88234e4a694so195986506d6.3
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 09:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764696521; x=1765301321; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=F6AHkRzWAPoSK9XSw2yAyUFU9k796GZ2VQUQbPaFyNo=;
 b=XPwIV0yLb4BmSgP8CmY8KId+kTPPK1CA0koZcotgYXcTNDRgUuconIFO5tCBeSpGmC
 Em+HCAFc23MTQMOwj+nJoO8BNZ7W4YkmxrpESW3wgzaY03KsP+eFbY4AbaU2yr7VKua0
 TQgtFmClKVeKKSNg/Rkp6WCpysUUEDFazsgPPHY8u6DNH7QlvIwf81Mod85HECFgyPUr
 4G3tuO749CpyJkZ8DVQ2ifaR1waKFwAExyfbOOdi2xbOyvc78lgQz3KzDHYam/YW4U0u
 e6fLQ5C+h7b+t37Y/xmxyJkphbkAUNwolNgWRs+qagskuSQ7iLZJBGJb+oe8/EA+V4DO
 FTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764696521; x=1765301321;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6AHkRzWAPoSK9XSw2yAyUFU9k796GZ2VQUQbPaFyNo=;
 b=rk9MNPBc4LGi12wUOVQLWNOUCidGqTQwVe6I0GR2m0sKmmcbZJWnR0Golq0fdm5BFD
 7m6yIrWZAtSGOoj4VQPLS5viBL05yc5v8wMfOaHpkfiO1Y5JUg7H1/wj0yn8LCh6B1Cv
 mJOvjCP9VlJBjs8X6olFRpK3DS8RRbyM+hRcq7A3Nb0rPDZQWd5ySCOVMOddFSgFCZRE
 haRTK3IECO9h++tOEamWNnWllg4GXKA716DNdlIOtgHYwJL7whwrq7wew7Mqjm4Js164
 fd3z3z+Hg0DpZsJFSaHrX4E13lzvzdIkR8B1br5PBYyAWWfuUHp17HIqftEIzmNFo8h0
 HZ5Q==
X-Gm-Message-State: AOJu0YzFK5kc5C3gFU0Niy/z9T3tBkfIFUz0cAijkVMXi5yfdzrnyYEl
 xGJDvKeRgmz4ggQ50dEUKRDrMYNubFt4lNY0i5/IMFivQOoH4mKYeWqbEZoctZ0004XIQcwM3rV
 IPp/+u6Y1qFU8s828urCf7qqnW+8drjyMV3r0K5GwpLhsTFNc+FTF5XE6
X-Gm-Gg: ASbGncvZQBPOgW+sBZ/fdRAgIUI6ntpozaepaUxeca1X1eoKl4SflcmoL/khRDaeM1M
 qLT4UzqLGnDFA/m2Iwop/mwZ/RVgXLT3xi3EmBpvM8kWwf5ChUFaMElMZHIU7s+USIq67+7YnbA
 Hhcn4BT3AfR8SQ+FyACYwFyoBymsQCoHe9ta9axz+a9pDKSUwxm1itFhmxbFr4TCdYnl1jiLwNh
 fYfbrs3jonAOiq9c0J7KigCzNx96uGKusP4NHxob3UYuBzuuYkZxKbkgke+0GFV2p7B/02mkbBH
 4Y3jdFjZFRgPgNUHB40AVFSokYE19jS5TEq5dNoe2robXZCxSXIc524Br2IVYBAcSFW/2GnZNpq
 dqvI=
X-Received: by 2002:ad4:5aad:0:b0:882:3c0c:a41c with SMTP id
 6a1803df08f44-8881771f7fcmr992836d6.11.1764696520666; 
 Tue, 02 Dec 2025 09:28:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvzTwwWSU4nm2volfN/nvr7Z+9NDtzMfkKrBfER3RVy/ARL50u2KvM68402XyhgsnSkSqOeg==
X-Received: by 2002:ad4:5aad:0:b0:882:3c0c:a41c with SMTP id
 6a1803df08f44-8881771f7fcmr992226d6.11.1764696520138; 
 Tue, 02 Dec 2025 09:28:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88652b6cc1bsm106749556d6.46.2025.12.02.09.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 09:28:39 -0800 (PST)
Date: Tue, 2 Dec 2025 12:28:38 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH for-11.0 v2 7/7] migration: Replace migrate_set_error()
 with migrate_error_propagate()
Message-ID: <aS8hxqC3dWr-woJd@x1.local>
References: <20251201194510.1121221-1-peterx@redhat.com>
 <20251201194510.1121221-8-peterx@redhat.com>
 <87fr9tumab.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fr9tumab.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Dec 02, 2025 at 12:59:40PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > migrate_set_error() currently doesn't take ownership of the error being
> > passed in.  It's not aligned with the error API and meanwhile it also
> > makes most of the caller free the error explicitly.
> >
> > Change the API to take the ownership of the Error object instead.  This
> > should save a lot of error_copy() invocations.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.h            |  2 +-
> >  migration/cpr-exec.c             |  5 ++--
> >  migration/migration.c            | 44 +++++++++++++++-----------------
> >  migration/multifd-device-state.c |  5 +---
> >  migration/multifd.c              | 19 +++++++-------
> >  migration/postcopy-ram.c         |  5 ++--
> >  migration/ram.c                  |  4 +--
> >  migration/savevm.c               | 16 +++++-------
> >  8 files changed, 43 insertions(+), 57 deletions(-)
> >
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 213b33fe6e..e4b4f25deb 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -525,7 +525,7 @@ void migration_incoming_process(void);
> >  
> >  bool  migration_has_all_channels(void);
> >  
> > -void migrate_set_error(MigrationState *s, const Error *error);
> > +void migrate_error_propagate(MigrationState *s, Error *error);
> >  bool migrate_has_error(MigrationState *s);
> >  
> >  void migration_connect(MigrationState *s, Error *error_in);
> > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> > index 0b8344a86f..da287d8031 100644
> > --- a/migration/cpr-exec.c
> > +++ b/migration/cpr-exec.c
> > @@ -158,8 +158,9 @@ static void cpr_exec_cb(void *opaque)
> >  
> >      error_report_err(error_copy(err));
> >      migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> > -    migrate_set_error(s, err);
> > -    error_free(err);
> > +
> > +    migrate_error_propagate(s, err);
> > +    /* We must reset the error because it'll be reused later */
> >      err = NULL;
> >  
> >      /* Note, we can go from state COMPLETED to FAILED */
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 0ff8b31a88..70813e5006 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -914,9 +914,7 @@ process_incoming_migration_co(void *opaque)
> >  fail:
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                        MIGRATION_STATUS_FAILED);
> > -    migrate_set_error(s, local_err);
> > -    error_free(local_err);
> > -
> > +    migrate_error_propagate(s, local_err);
> >      migration_incoming_state_destroy();
> >  
> >      if (mis->exit_on_error) {
> > @@ -1548,14 +1546,20 @@ static void migration_cleanup_bh(void *opaque)
> >      migration_cleanup(opaque);
> >  }
> >  
> > -void migrate_set_error(MigrationState *s, const Error *error)
> > +/*
> > + * Propagate the Error* object to migration core.  The caller mustn't
> > + * reference the error pointer after the function returned, because the
> > + * Error* object might be freed.
> > + */
> > +void migrate_error_propagate(MigrationState *s, Error *error)
> >  {
> >      QEMU_LOCK_GUARD(&s->error_mutex);
> > -
> >      trace_migrate_error(error_get_pretty(error));
> >  
> >      if (!s->error) {
> > -        s->error = error_copy(error);
> > +        s->error = error;
> > +    } else {
> > +        error_free(error);
> >      }
> 
> This is correct.  Also correct, and possibly easier to understand at a
> glance:
> 
>        error_propagate(&s->error, error);
> 
> error_propagate() has code for a number of additional conditions, but
> these are all impossible:
> 
> * @error cannot be null here (because error_get_pretty(error) above)
> 
> * &s->error cannot be &error_abort, &error_fatal, or null
> 
> Thoughts?

Yes it looks more readable indeed, thanks for the suggestion.

Since the whole series got almost reviewed, instead of reposting everything
I'll send a small follow up patch soon as a separate cleanup.

> 
> >  }
> >  
> > @@ -1601,8 +1605,7 @@ static void migration_connect_error_propagate(MigrationState *s, Error *error)
> >      }
> >  
> >      migrate_set_state(&s->state, current, next);
> > -    migrate_set_error(s, error);
> > -    error_free(error);
> > +    migrate_error_propagate(s, error);
> >  }
> >  
> >  void migration_cancel(void)
> > @@ -2014,8 +2017,7 @@ void qmp_migrate_pause(Error **errp)
> >  
> >          /* Tell the core migration that we're pausing */
> >          error_setg(&error, "Postcopy migration is paused by the user");
> > -        migrate_set_error(ms, error);
> > -        error_free(error);
> > +        migrate_error_propagate(ms, error);
> >  
> >          qemu_mutex_lock(&ms->qemu_file_lock);
> >          if (ms->to_dst_file) {
> > @@ -2647,8 +2649,7 @@ static void *source_return_path_thread(void *opaque)
> >  
> >  out:
> >      if (err) {
> > -        migrate_set_error(ms, err);
> > -        error_free(err);
> > +        migrate_error_propagate(ms, err);
> >          trace_source_return_path_thread_bad_end();
> >      }
> >  
> > @@ -3094,12 +3095,10 @@ static void migration_completion(MigrationState *s)
> >  
> >  fail:
> >      if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(s, local_err);
> >      } else if (ret) {
> >          error_setg_errno(&local_err, -ret, "Error in migration completion");
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(s, local_err);
> >      }
> >  
> >      if (s->state != MIGRATION_STATUS_CANCELLING) {
> > @@ -3326,8 +3325,7 @@ static MigThrError migration_detect_error(MigrationState *s)
> >      }
> >  
> >      if (local_error) {
> > -        migrate_set_error(s, local_error);
> > -        error_free(local_error);
> > +        migrate_error_propagate(s, local_error);
> >      }
> >  
> >      if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
> > @@ -3522,7 +3520,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
> >          if (must_precopy <= s->threshold_size &&
> >              can_switchover && qatomic_read(&s->start_postcopy)) {
> >              if (postcopy_start(s, &local_err)) {
> > -                migrate_set_error(s, local_err);
> > +                migrate_error_propagate(s, error_copy(local_err));
> >                  error_report_err(local_err);
> >              }
> >              return MIG_ITERATE_SKIP;
> > @@ -3819,8 +3817,7 @@ static void *migration_thread(void *opaque)
> >       * devices to unplug. This to preserve migration state transitions.
> >       */
> >      if (ret) {
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(s, local_err);
> >          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> >                            MIGRATION_STATUS_FAILED);
> >          goto out;
> > @@ -3944,8 +3941,7 @@ static void *bg_migration_thread(void *opaque)
> >       * devices to unplug. This to preserve migration state transitions.
> >       */
> >      if (ret) {
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(s, local_err);
> >          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> >                            MIGRATION_STATUS_FAILED);
> >          goto fail_setup;
> > @@ -4127,7 +4123,7 @@ void migration_connect(MigrationState *s, Error *error_in)
> >      return;
> >  
> >  fail:
> > -    migrate_set_error(s, local_err);
> > +    migrate_error_propagate(s, error_copy(local_err));
> >      if (s->state != MIGRATION_STATUS_CANCELLING) {
> >          migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> >      }
> > diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> > index db3239fef5..91d5d81556 100644
> > --- a/migration/multifd-device-state.c
> > +++ b/migration/multifd-device-state.c
> > @@ -143,8 +143,6 @@ static int multifd_device_state_save_thread(void *opaque)
> >      Error *local_err = NULL;
> >  
> >      if (!data->hdlr(data, &local_err)) {
> > -        MigrationState *s = migrate_get_current();
> > -
> >          /*
> >           * Can't call abort_device_state_save_threads() here since new
> >           * save threads could still be in process of being launched
> > @@ -158,8 +156,7 @@ static int multifd_device_state_save_thread(void *opaque)
> >           * In case of multiple save threads failing which thread error
> >           * return we end setting is purely arbitrary.
> >           */
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(migrate_get_current(), local_err);
> >      }
> >  
> >      return 0;
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 52e4d25857..bf6da85af8 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -428,8 +428,9 @@ static void multifd_send_error_propagate(Error *err)
> >  
> >      if (err) {
> >          MigrationState *s = migrate_get_current();
> > -        migrate_set_error(s, err);
> > -        error_free(err);
> > +
> > +        migrate_error_propagate(s, err);
> > +
> >          if (s->state == MIGRATION_STATUS_SETUP ||
> >              s->state == MIGRATION_STATUS_PRE_SWITCHOVER ||
> >              s->state == MIGRATION_STATUS_DEVICE ||
> > @@ -588,8 +589,7 @@ void multifd_send_shutdown(void)
> >          Error *local_err = NULL;
> >  
> >          if (!multifd_send_cleanup_channel(p, &local_err)) {
> > -            migrate_set_error(migrate_get_current(), local_err);
> > -            error_free(local_err);
> > +            migrate_error_propagate(migrate_get_current(), local_err);
> >          }
> >      }
> >  
> > @@ -962,8 +962,7 @@ bool multifd_send_setup(void)
> >          p->write_flags = 0;
> >  
> >          if (!multifd_new_send_channel_create(p, &local_err)) {
> > -            migrate_set_error(s, local_err);
> > -            error_free(local_err);
> > +            migrate_error_propagate(s, local_err);
> >              ret = -1;
> >          }
> >      }
> > @@ -987,8 +986,7 @@ bool multifd_send_setup(void)
> >  
> >          ret = multifd_send_state->ops->send_setup(p, &local_err);
> >          if (ret) {
> > -            migrate_set_error(s, local_err);
> > -            error_free(local_err);
> > +            migrate_error_propagate(s, local_err);
> >              goto err;
> >          }
> >          assert(p->iov);
> > @@ -1067,8 +1065,9 @@ static void multifd_recv_terminate_threads(Error *err)
> >  
> >      if (err) {
> >          MigrationState *s = migrate_get_current();
> > -        migrate_set_error(s, err);
> > -        error_free(err);
> > +
> > +        migrate_error_propagate(s, err);
> > +
> >          if (s->state == MIGRATION_STATUS_SETUP ||
> >              s->state == MIGRATION_STATUS_ACTIVE) {
> >              migrate_set_state(&s->state, s->state,
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index 7c9fe61041..dd8e31f5ae 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1927,8 +1927,7 @@ postcopy_preempt_send_channel_done(MigrationState *s,
> >                                     QIOChannel *ioc, Error *local_err)
> >  {
> >      if (local_err) {
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(s, local_err);
> >      } else {
> >          migration_ioc_register_yank(ioc);
> >          s->postcopy_qemufile_src = qemu_file_new_output(ioc);
> > @@ -2162,7 +2161,7 @@ static void *postcopy_listen_thread(void *opaque)
> >               * exit depending on if postcopy-exit-on-error is true, but the
> >               * migration cannot be recovered.
> >               */
> > -            migrate_set_error(migr, local_err);
> > +            migrate_error_propagate(migr, error_copy(local_err));
> >              error_report_err(local_err);
> >              migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
> >              goto out;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 29f016cb25..a2f456d858 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -4730,9 +4730,7 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
> >           * Abort and indicate a proper reason.
> >           */
> >          error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
> > -        migrate_set_error(migrate_get_current(), err);
> > -        error_free(err);
> > -
> > +        migrate_error_propagate(migrate_get_current(), err);
> >          migration_cancel();
> >      }
> >  
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 638e9b364f..67f10a5dbe 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -1125,13 +1125,12 @@ void qemu_savevm_send_open_return_path(QEMUFile *f)
> >  int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
> >  {
> >      uint32_t tmp;
> > -    MigrationState *ms = migrate_get_current();
> >      Error *local_err = NULL;
> >  
> >      if (len > MAX_VM_CMD_PACKAGED_SIZE) {
> >          error_setg(&local_err, "%s: Unreasonably large packaged state: %zu",
> >                       __func__, len);
> > -        migrate_set_error(ms, local_err);
> > +        migrate_error_propagate(migrate_get_current(), error_copy(local_err));
> 
> I'd break this line between the arguments.  Matter of taste, up to you.

Would you mind if I queue this series together with patch 2+3?  If so, I
can touch it up when queuing.

> 
> >          error_report_err(local_err);
> >          return -1;
> >      }
> > @@ -1373,7 +1372,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
> >          if (se->vmsd && se->vmsd->early_setup) {
> >              ret = vmstate_save(f, se, vmdesc, errp);
> >              if (ret) {
> > -                migrate_set_error(ms, *errp);
> > +                migrate_error_propagate(ms, error_copy(*errp));
> >                  qemu_file_set_error(f, ret);
> >                  break;
> >              }
> > @@ -1681,7 +1680,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
> >  
> >          ret = vmstate_save(f, se, vmdesc, &local_err);
> >          if (ret) {
> > -            migrate_set_error(ms, local_err);
> > +            migrate_error_propagate(ms, error_copy(local_err));
> >              error_report_err(local_err);
> >              qemu_file_set_error(f, ret);
> >              return ret;
> > @@ -1858,7 +1857,6 @@ void qemu_savevm_live_state(QEMUFile *f)
> >  
> >  int qemu_save_device_state(QEMUFile *f)
> >  {
> > -    MigrationState *ms = migrate_get_current();
> >      Error *local_err = NULL;
> >      SaveStateEntry *se;
> >  
> > @@ -1876,7 +1874,8 @@ int qemu_save_device_state(QEMUFile *f)
> >          }
> >          ret = vmstate_save(f, se, NULL, &local_err);
> >          if (ret) {
> > -            migrate_set_error(ms, local_err);
> > +            migrate_error_propagate(migrate_get_current(),
> > +                                    error_copy(local_err));
> >              error_report_err(local_err);
> >              return ret;
> >          }
> > @@ -2826,8 +2825,6 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
> >      Error *local_err = NULL;
> >  
> >      if (!data->function(data->opaque, &mis->load_threads_abort, &local_err)) {
> > -        MigrationState *s = migrate_get_current();
> > -
> >          /*
> >           * Can't set load_threads_abort here since processing of main migration
> >           * channel data could still be happening, resulting in launching of new
> > @@ -2840,8 +2837,7 @@ static int qemu_loadvm_load_thread(void *thread_opaque)
> >           * In case of multiple load threads failing which thread error
> >           * return we end setting is purely arbitrary.
> >           */
> > -        migrate_set_error(s, local_err);
> > -        error_free(local_err);
> > +        migrate_error_propagate(migrate_get_current(), local_err);
> >      }
> >  
> >      return 0;
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

-- 
Peter Xu


