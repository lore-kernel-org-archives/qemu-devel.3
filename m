Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FA7CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEs0j-0003QK-LN; Fri, 31 Oct 2025 12:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEs0h-0003Q4-6x
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEs0Y-00033j-Ah
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761928174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/D/7N3jMb23v7NBpt0fw2eeWqEQcfjUhVNDKp4pZKas=;
 b=PDmwmQ2qcH6I4/ISAydq0fJKYKRzi3dybDT+zZKDIblGAP9d6fsqgm80DJy00IdRi8qe+l
 /Oz4LBxG5y6af2QgHe3YvDk6yEXrjwQemtIwUbGI68gPMZrTswC2M+teejWliLyxUONQEu
 pzDuTclH975iU3OZbgtL+Vrb0kTfbBo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-8jIXZFecOH28gzIXgKRXlg-1; Fri, 31 Oct 2025 12:29:32 -0400
X-MC-Unique: 8jIXZFecOH28gzIXgKRXlg-1
X-Mimecast-MFC-AGG-ID: 8jIXZFecOH28gzIXgKRXlg_1761928172
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-87dfd03fb72so111675146d6.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 09:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761928172; x=1762532972;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/D/7N3jMb23v7NBpt0fw2eeWqEQcfjUhVNDKp4pZKas=;
 b=b2VBud27ohI08tTgY7jX6jWSW3RpxMTy9rdnlkIlr+b+hIa9/N7L/rzQEnyMKwYX2J
 XLVqR4cSjtjnoZMLQ6NENXhrfTpM/HNHA6a43EclB6W9sLCKBK+jwEpf0kY8XH9NyqAW
 00doIo7REhaBvmGZFqF2VLfR60FluMVmhrWZLq9K0ayBhFf/IxxNOvU5wwnz6DfcmNH0
 hvHwixSppJgFC18uRXyuzaf/Q2bp6I50gr0/MhaPzlBYavg+ATJqECsBHfmpb/rgRV7R
 W5Bbe8mEldpnQOiZ7zJQrU3T81HRgM7aaAjjPkBlkyCxy6Y0GiYauubKwA2NwxgqdL23
 e2WA==
X-Gm-Message-State: AOJu0Yw8r95/R8hCNTpx5AAKFZG8bP87Ay8Ptj48SyeObPxMkpAMGiFM
 QjfEV+tl3d1Y+tdKh78UesdD6vcDf0EBLb/07Tcx8Fw5BvxEFG/S4VCwbqSKltEHihVx/khTncq
 uSgBtl2pvm+9KDH1W51IutD8HusN0iBd7TzxBBODh80N2XihY8rfGKY1h
X-Gm-Gg: ASbGnctEnXLLFCv/Z5uqs/vJPjKl86qVLYFLhO9RsA0phRoMVxWUCziwPluaegA4XR1
 xYIDRpHKRwmSfTFLlmczNf+E2MsuD6zNKhJWAgX0jKD9iugCV5pKv98WT5ltzS6d52+YJ5hTXGX
 wAK3Saf8TrSjUlzSx4s3SB1sjFnmSfReRx/HeJGfWPZUoodylhVKM2J5rDU3S7IpwEqVt0rcwdw
 YNYL70uQ7c4g/0gdl8ABuVrfmgFGGYfbHb53RAGdbU9nWLH3ZcLCN40vLYhXeqx+9EfJhvCMfJC
 MSF3IBSrJDrlumlyBO+NH0jGxaAZWSljsnHHT8y7sknjAeMP8NTR0AjfbFDh3hBq4iU=
X-Received: by 2002:a05:6214:1bcd:b0:87d:f969:6a7d with SMTP id
 6a1803df08f44-8802f2d2d04mr57531016d6.18.1761928171565; 
 Fri, 31 Oct 2025 09:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7CxhvDLXg9xqSAI+AsOUJhQO1JCL3XNHn2r32cx36EEpCLpzrarnw4E4Sc/TSsQ9369unsQ==
X-Received: by 2002:a05:6214:1bcd:b0:87d:f969:6a7d with SMTP id
 6a1803df08f44-8802f2d2d04mr57530386d6.18.1761928170914; 
 Fri, 31 Oct 2025 09:29:30 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8803605e629sm13950856d6.22.2025.10.31.09.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:29:30 -0700 (PDT)
Date: Fri, 31 Oct 2025 12:29:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>
Subject: Re: [PATCH v3 4/7] migration: Refactor all incoming cleanup info
 migration_incoming_destroy()
Message-ID: <aQTj6DnXA3XzT9JA@x1.local>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
 <20251030214915.1411860-5-jmarcin@redhat.com>
 <aQPrYgJMyXIN5yZ2@x1.local>
 <bbggqirwmxugoq3ijnx6ymewfvozwnqnhlmawn7kckln2i6rwq@aztu47ekvpea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbggqirwmxugoq3ijnx6ymewfvozwnqnhlmawn7kckln2i6rwq@aztu47ekvpea>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Oct 31, 2025 at 12:03:57PM +0100, Juraj Marcin wrote:
> On 2025-10-30 18:49, Peter Xu wrote:
> > On Thu, Oct 30, 2025 at 10:49:08PM +0100, Juraj Marcin wrote:
> > > From: Juraj Marcin <jmarcin@redhat.com>
> > > 
> > > Currently, there are two functions that are responsible for calling the
> > > cleanup of the incoming migration state. With successful precopy, it's
> > > the incoming migration coroutine, and with successful postcopy it's the
> > > postcopy listen thread. However, if postcopy fails during in the device
> > > load, both functions will try to do the cleanup.
> > > 
> > > This patch refactors all cleanup that needs to be done on the incoming
> > > side into a common function and defines a clear boundary, who is
> > > responsible for the cleanup. The incoming migration coroutine is
> > > responsible for calling the cleanup function, unless the listen thread
> > > has been started, in which case the postcopy listen thread runs the
> > > incoming migration cleanup in its BH.
> > > 
> > > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > > ---
> > >  migration/migration.c    | 44 +++++++++-------------------
> > >  migration/migration.h    |  1 +
> > >  migration/postcopy-ram.c | 63 +++++++++++++++++++++-------------------
> > >  migration/trace-events   |  2 +-
> > >  4 files changed, 49 insertions(+), 61 deletions(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 9a367f717e..637be71bfe 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -438,10 +438,15 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
> > >  
> > >  void migration_incoming_state_destroy(void)
> > >  {
> > > -    struct MigrationIncomingState *mis = migration_incoming_get_current();
> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > +    PostcopyState ps = postcopy_state_get();
> > >  
> > >      multifd_recv_cleanup();
> > >  
> > > +    if (ps != POSTCOPY_INCOMING_NONE) {
> > > +        postcopy_incoming_cleanup(mis);
> > > +    }
> > > +
> > >      /*
> > >       * RAM state cleanup needs to happen after multifd cleanup, because
> > >       * multifd threads can use some of its states (receivedmap).
> > > @@ -866,7 +871,6 @@ process_incoming_migration_co(void *opaque)
> > >  {
> > >      MigrationState *s = migrate_get_current();
> > >      MigrationIncomingState *mis = migration_incoming_get_current();
> > > -    PostcopyState ps;
> > >      int ret;
> > >      Error *local_err = NULL;
> > >  
> > > @@ -883,25 +887,14 @@ process_incoming_migration_co(void *opaque)
> > >  
> > >      trace_vmstate_downtime_checkpoint("dst-precopy-loadvm-completed");
> > >  
> > > -    ps = postcopy_state_get();
> > > -    trace_process_incoming_migration_co_end(ret, ps);
> > > -    if (ps != POSTCOPY_INCOMING_NONE) {
> > > -        if (ps == POSTCOPY_INCOMING_ADVISE) {
> > > -            /*
> > > -             * Where a migration had postcopy enabled (and thus went to advise)
> > > -             * but managed to complete within the precopy period, we can use
> > > -             * the normal exit.
> > > -             */
> > > -            postcopy_incoming_cleanup(mis);
> > > -        } else if (ret >= 0) {
> > > -            /*
> > > -             * Postcopy was started, cleanup should happen at the end of the
> > > -             * postcopy thread.
> > > -             */
> > > -            trace_process_incoming_migration_co_postcopy_end_main();
> > > -            goto out;
> > > -        }
> > > -        /* Else if something went wrong then just fall out of the normal exit */
> > > +    trace_process_incoming_migration_co_end(ret);
> > > +    if (mis->have_listen_thread) {
> > > +        /*
> > > +         * Postcopy was started, cleanup should happen at the end of the
> > > +         * postcopy listen thread.
> > > +         */
> > > +        trace_process_incoming_migration_co_postcopy_end_main();
> > > +        goto out;
> > >      }
> > >  
> > >      if (ret < 0) {
> > > @@ -933,15 +926,6 @@ fail:
> > >          }
> > >  
> > >          exit(EXIT_FAILURE);
> > > -    } else {
> > > -        /*
> > > -         * Report the error here in case that QEMU abruptly exits
> > > -         * when postcopy is enabled.
> > > -         */
> > > -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> > > -            error_report_err(s->error);
> > > -            s->error = NULL;
> > > -        }
> > 
> > The patch looks all good itself.  Here a pure question: is the old code
> > wrong?  If user sets exit_on_error=false, then this path seems to be
> > releasing the error object, then query-migrate will see nothing?
> 
> I have tested this, and it is indeed what happens with the old code.
> There is no "error-desc" in the response of "query-migrate" command,
> just "status": "failed".

Looks like it was a regression.

At the meantime, I feel like it's indeed fine if we do not dump error when
exit-on-error=false, like what you did here.

So I'll attach this:

Fixes: 9535435795 ("migration: push Error **errp into qemu_loadvm_state()")

And as the current patch looks all correct to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

I've queued the series, thanks!

I'll post a small patch shortly to test the error-desc for
exit-on-error=false.

+Arun

> 
> > 
> > >      }
> > >  out:
> > >      /* Pairs with the refcount taken in qmp_migrate_incoming() */
> > > diff --git a/migration/migration.h b/migration/migration.h
> > > index 01329bf824..4a37f7202c 100644
> > > --- a/migration/migration.h
> > > +++ b/migration/migration.h
> > > @@ -254,6 +254,7 @@ struct MigrationIncomingState {
> > >  MigrationIncomingState *migration_incoming_get_current(void);
> > >  void migration_incoming_state_destroy(void);
> > >  void migration_incoming_transport_cleanup(MigrationIncomingState *mis);
> > > +void migration_incoming_qemu_exit(void);
> > >  /*
> > >   * Functions to work with blocktime context
> > >   */
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index b47c955763..48cbb46c27 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -2078,6 +2078,24 @@ bool postcopy_is_paused(MigrationStatus status)
> > >          status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
> > >  }
> > >  
> > > +static void postcopy_listen_thread_bh(void *opaque)
> > > +{
> > > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > > +
> > > +    migration_incoming_state_destroy();
> > > +
> > > +    if (mis->state == MIGRATION_STATUS_FAILED) {
> > > +        /*
> > > +         * If something went wrong then we have a bad state so exit;
> > > +         * we only could have gotten here if something failed before
> > > +         * POSTCOPY_INCOMING_RUNNING (for example device load), otherwise
> > > +         * postcopy migration would pause inside qemu_loadvm_state_main().
> > > +         * Failing dirty-bitmaps won't fail the whole migration.
> > > +         */
> > > +        exit(1);
> > > +    }
> > > +}
> > > +
> > >  /*
> > >   * Triggered by a postcopy_listen command; this thread takes over reading
> > >   * the input stream, leaving the main thread free to carry on loading the rest
> > > @@ -2131,53 +2149,38 @@ static void *postcopy_listen_thread(void *opaque)
> > >                           "bitmaps are correctly migrated and valid.",
> > >                           __func__, load_res, error_get_pretty(local_err));
> > >              g_clear_pointer(&local_err, error_free);
> > > -            load_res = 0; /* prevent further exit() */
> > >          } else {
> > > +            /*
> > > +             * Something went fatally wrong and we have a bad state, QEMU will
> > > +             * exit depending on if postcopy-exit-on-error is true, but the
> > > +             * migration cannot be recovered.
> > > +             */
> > >              error_prepend(&local_err,
> > >                            "loadvm failed during postcopy: %d: ", load_res);
> > >              migrate_set_error(migr, local_err);
> > >              g_clear_pointer(&local_err, error_report_err);
> > >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > >                                             MIGRATION_STATUS_FAILED);
> > > +            goto out;
> > >          }
> > >      }
> > > -    if (load_res >= 0) {
> > > -        /*
> > > -         * This looks good, but it's possible that the device loading in the
> > > -         * main thread hasn't finished yet, and so we might not be in 'RUN'
> > > -         * state yet; wait for the end of the main thread.
> > > -         */
> > > -        qemu_event_wait(&mis->main_thread_load_event);
> > > -    }
> > > -    postcopy_incoming_cleanup(mis);
> > > -
> > > -    if (load_res < 0) {
> > > -        /*
> > > -         * If something went wrong then we have a bad state so exit;
> > > -         * depending how far we got it might be possible at this point
> > > -         * to leave the guest running and fire MCEs for pages that never
> > > -         * arrived as a desperate recovery step.
> > > -         */
> > > -        rcu_unregister_thread();
> > > -        exit(EXIT_FAILURE);
> > > -    }
> > > +    /*
> > > +     * This looks good, but it's possible that the device loading in the
> > > +     * main thread hasn't finished yet, and so we might not be in 'RUN'
> > > +     * state yet; wait for the end of the main thread.
> > > +     */
> > > +    qemu_event_wait(&mis->main_thread_load_event);
> > >  
> > >      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > >                                     MIGRATION_STATUS_COMPLETED);
> > > -    /*
> > > -     * If everything has worked fine, then the main thread has waited
> > > -     * for us to start, and we're the last use of the mis.
> > > -     * (If something broke then qemu will have to exit anyway since it's
> > > -     * got a bad migration state).
> > > -     */
> > > -    bql_lock();
> > > -    migration_incoming_state_destroy();
> > > -    bql_unlock();
> > >  
> > > +out:
> > >      rcu_unregister_thread();
> > >      mis->have_listen_thread = false;
> > >      postcopy_state_set(POSTCOPY_INCOMING_END);
> > >  
> > > +    migration_bh_schedule(postcopy_listen_thread_bh, NULL);
> > > +
> > >      object_unref(OBJECT(migr));
> > >  
> > >      return NULL;
> > > diff --git a/migration/trace-events b/migration/trace-events
> > > index e8edd1fbba..772636f3ac 100644
> > > --- a/migration/trace-events
> > > +++ b/migration/trace-events
> > > @@ -193,7 +193,7 @@ source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
> > >  source_return_path_thread_switchover_acked(void) ""
> > >  migration_thread_low_pending(uint64_t pending) "%" PRIu64
> > >  migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidth, uint64_t avail_bw, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " switchover_bw %" PRIu64 " max_size %" PRId64
> > > -process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
> > > +process_incoming_migration_co_end(int ret) "ret=%d"
> > >  process_incoming_migration_co_postcopy_end_main(void) ""
> > >  postcopy_preempt_enabled(bool value) "%d"
> > >  migration_precopy_complete(void) ""
> > > -- 
> > > 2.51.0
> > > 
> > 
> > -- 
> > Peter Xu
> > 
> 

-- 
Peter Xu


