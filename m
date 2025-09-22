Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1C5CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0g84-0004bb-W6; Mon, 22 Sep 2025 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v0g83-0004bC-Nk
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v0g7y-0001VS-52
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758545923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhyudY3PQ5mL25J+3laORLDR8LP42TXYeEZfTKfNvZ0=;
 b=HL0d1P/+MmUDNF7fUtWJ58rurvnTr36gxGDyQAc8HtU8HE+UkIeGO++N8nFHduDbH2W9t/
 S5mza1exV+v+nB17UfNGeHNIhiJNALZzCKQZ63lnHvdMcLDeFE6g0hc93hRDqYE+J+vCC+
 h33xmnV9vdmJu0dmdHYfxQOohRC7I+g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-GCkHDyq7N_aM35-26AaYEg-1; Mon, 22 Sep 2025 08:58:42 -0400
X-MC-Unique: GCkHDyq7N_aM35-26AaYEg-1
X-Mimecast-MFC-AGG-ID: GCkHDyq7N_aM35-26AaYEg_1758545921
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46c90948deaso10936105e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758545921; x=1759150721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QhyudY3PQ5mL25J+3laORLDR8LP42TXYeEZfTKfNvZ0=;
 b=DDXY9GgauhS5APoSG8VpMqbe64bQbI5LUjCFsh8LaM9psYR6niVaTqWtDOwwQY8xlv
 +cei+EGFQ6X77ylivVhfDVfVm7UUql8G9qR390t4g7eaVT/nTnXYVoE4+HxPxyzJPwbu
 hUClhZqkshEk6LQwm9ISBaiLjpaKUOJO8qeVRmlMHbKHPC8b2yoRuIeSoQsYsHORZ1F7
 D7By0PIX6V1ZMQL9qiDAdUQgkFqPCifCBSBa6icHRx5n8rTdGErZAsqn+W6BG/2BqOnR
 KLsUJBNxRHQhSztZgmGAa5wnbstyF0JRMM7M8HQTkKIrPSYXAVH2b0GxM0BxUXIC9hs+
 NEGA==
X-Gm-Message-State: AOJu0YzypRI/HZcO+1jTOYg01nHAxURl4I3B/22T1nXFtQhqgzTJlxDc
 LTfzM9wmWP2ATqP+1/s6YLVNr0aCHTYxgA7tfBydnzzZ2Fzd6bsEFclXRFxBbdZ90veAZClxcuC
 95lZS4f1Nd1C57ZDX5/8Fdy1WBVRyMlZC1upa0IYnJyw25WKFJeItXe2K3klD51D4gKI=
X-Gm-Gg: ASbGnctfRzD9/rW/hc9nSxMfei6N5Bnfz93DyBdlCRQZLaVnj6aCV2TMr3rhSEkm7Je
 D3ibszFtMCti2FSpe9UbIb5l+PKWo6bm8jOfGSNUpW1GI+WOGACaFoGkZwUuYEuStuVLUYHNEXz
 fh/x6OKZECMN8cbuAMBm5gVfMG12rtCCwixI+YqM9gGtVv7cM6+LZy2UUaVnSy0GgUYXTQDpM35
 AKPfAxfyEGaXePD+et0s7HhG8/iaWLN7bP/zPO2zKo5WNGodLOMoLYhxaaMdLNy7Sj43HM8Ce9X
 EyYIpwKP+WHdaLrXLrkZ/hSONabMWg==
X-Received: by 2002:a05:600c:a01:b0:45d:f7f9:9ac7 with SMTP id
 5b1f17b1804b1-467e6b64fcbmr121373255e9.6.1758545920856; 
 Mon, 22 Sep 2025 05:58:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWshe/9EP9V87G7kNFvHGtKteiL8MQVMiHa8ENkpOZe1GADoTRywlJ3BBKRWw/JlFDWmSbPQ==
X-Received: by 2002:a05:600c:a01:b0:45d:f7f9:9ac7 with SMTP id
 5b1f17b1804b1-467e6b64fcbmr121373065e9.6.1758545920326; 
 Mon, 22 Sep 2025 05:58:40 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ef166e62e5sm14973114f8f.40.2025.09.22.05.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:58:39 -0700 (PDT)
Date: Mon, 22 Sep 2025 14:58:38 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 3/4] migration: Refactor incoming cleanup into
 migration_incoming_finish()
Message-ID: <luoiumyvzjxtro6bd4vqn5mq6icf2zfic3n6shivb2e3ngkmcl@bz7vzg7xwdiq>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-4-jmarcin@redhat.com>
 <87plbmtmox.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plbmtmox.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Fabiano,

On 2025-09-19 13:46, Fabiano Rosas wrote:
> Juraj Marcin <jmarcin@redhat.com> writes:
> 
> Hi Juraj,
> 
> Good patch, nice use of migrate_has_failed()

Thanks!

> 
> > From: Juraj Marcin <jmarcin@redhat.com>
> >
> > Currently, there are two functions that are responsible for cleanup of
> > the incoming migration state. With successful precopy, it's the main
> > thread and with successful postcopy it's the listen thread. However, if
> > postcopy fails during in the device load, both functions will try to do
> > the cleanup. Moreover, when exit-on-error parameter was added, it was
> > applied only to precopy.
> >
> 
> Someone could be relying in postcopy always exiting on error while
> explicitly setting exit-on-error=false for precopy and this patch would
> change the behavior incompatibly. Is this an issue? I'm willing to
> ignore it, but you guys know more about postcopy.

Good question. When going through older patches where postcopy listen
thread and then where exit-on-error were implemented, it seemed more
like an overlook than intentional omission. However, it might be better
to not break any potential users of this, we could add another option,
"exit-on-postcopy-error" that would allow such handling if postscopy
failed unrecoverably. I've already talked about such option with
@jdenemar and he agreed with it.

> 
> > This patch refactors common cleanup and exiting on error into a helper
> > function that can be started either from precopy or postcopy, reducing
> > the duplication. If the listen thread has been started (the postcopy
> > state is at least LISTENING), the listen thread is responsible for all
> > cleanup and exiting, otherwise it's the main thread's responsibility.
> 
> Don't the BHs also run in the main thread? I'm not sure this sentence is
> accurate.

Yeah, it is a bit inaccurate now that you mention it, BHs are indeed run
in the main thread. More accurate would to replace the main thread with
process incoming migration coroutine, that would precisely describe who
has the responsibility to call the cleanup.

> 
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  migration/migration.c | 64 ++++++++++++++++++++++++-------------------
> >  migration/migration.h |  1 +
> >  migration/savevm.c    | 48 +++++++++++---------------------
> 
> Could someone act on the TODOs and move postcopy code into postcopy-ram?
> It's never too late to make things consistent.

I can take a look.

> 
> >  3 files changed, 53 insertions(+), 60 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 2c0b3a7229..7222e3de13 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -442,9 +442,19 @@ void migration_incoming_transport_cleanup(MigrationIncomingState *mis)
> >  void migration_incoming_state_destroy(void)
> >  {
> >      struct MigrationIncomingState *mis = migration_incoming_get_current();
> > +    PostcopyState ps = postcopy_state_get();
> >  
> >      multifd_recv_cleanup();
> >  
> > +    if (mis->have_listen_thread) {
> > +        qemu_thread_join(&mis->listen_thread);
> > +        mis->have_listen_thread = false;
> > +    }
> > +
> > +    if (ps != POSTCOPY_INCOMING_NONE) {
> > +        postcopy_ram_incoming_cleanup(mis);
> > +    }
> > +
> >      /*
> >       * RAM state cleanup needs to happen after multifd cleanup, because
> >       * multifd threads can use some of its states (receivedmap).
> > @@ -809,6 +819,23 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
> >      cpr_state_close();
> >  }
> >  
> > +void migration_incoming_finish(void)
> > +{
> > +    MigrationState *s = migrate_get_current();
> > +    MigrationIncomingState *mis = migration_incoming_get_current();
> > +
> > +    migration_incoming_state_destroy();
> > +
> > +    if (migration_has_failed(mis->state) && mis->exit_on_error) {
> > +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> > +            error_report_err(s->error);
> > +            s->error = NULL;
> > +        }
> > +
> > +        exit(EXIT_FAILURE);
> > +    }
> > +}
> > +
> >  static void process_incoming_migration_bh(void *opaque)
> >  {
> >      MigrationIncomingState *mis = opaque;
> > @@ -861,7 +888,7 @@ static void process_incoming_migration_bh(void *opaque)
> >       */
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> >                        MIGRATION_STATUS_COMPLETED);
> > -    migration_incoming_state_destroy();
> > +    migration_incoming_finish();
> >  }
> >  
> >  static void coroutine_fn
> > @@ -888,23 +915,13 @@ process_incoming_migration_co(void *opaque)
> >  
> >      ps = postcopy_state_get();
> >      trace_process_incoming_migration_co_end(ret, ps);
> > -    if (ps != POSTCOPY_INCOMING_NONE) {
> > -        if (ps == POSTCOPY_INCOMING_ADVISE) {
> > -            /*
> > -             * Where a migration had postcopy enabled (and thus went to advise)
> > -             * but managed to complete within the precopy period, we can use
> > -             * the normal exit.
> > -             */
> > -            postcopy_ram_incoming_cleanup(mis);
> > -        } else if (ret >= 0) {
> > -            /*
> > -             * Postcopy was started, cleanup should happen at the end of the
> > -             * postcopy thread.
> > -             */
> > -            trace_process_incoming_migration_co_postcopy_end_main();
> > -            goto out;
> > -        }
> > -        /* Else if something went wrong then just fall out of the normal exit */
> > +    if (ps >= POSTCOPY_INCOMING_LISTENING) {
> > +        /*
> > +         * Postcopy was started, cleanup should happen at the end of the
> > +         * postcopy thread.
> > +         */
> > +        trace_process_incoming_migration_co_postcopy_end_main();
> > +        goto out;
> >      }
> >  
> >      if (ret < 0) {
> > @@ -926,16 +943,7 @@ fail:
> >      migrate_set_error(s, local_err);
> >      error_free(local_err);
> >  
> > -    migration_incoming_state_destroy();
> > -
> > -    if (mis->exit_on_error) {
> > -        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> > -            error_report_err(s->error);
> > -            s->error = NULL;
> > -        }
> > -
> > -        exit(EXIT_FAILURE);
> > -    }
> > +    migration_incoming_finish();
> >  out:
> >      /* Pairs with the refcount taken in qmp_migrate_incoming() */
> >      migrate_incoming_unref_outgoing_state();
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 2c2331f40d..67e3318467 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -518,6 +518,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> >  void migration_fd_process_incoming(QEMUFile *f);
> >  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> >  void migration_incoming_process(void);
> > +void migration_incoming_finish(void);
> 
> What about merging migration_incoming_state_destroy and
> migration_incoming_finish and pair all of this with migration_cleanup?
> 
> static void migration_cleanup_bh(void *opaque)
> {
>     migration_cleanup(opaque);
> }
> 
> static void migration_incoming_cleanup_bh(void *opaque)
> {
>     migration_incoming_cleanup(opaque);
> }

Yes, it would pair well. I guess it would also solve Peter's nitpick
about the change in process_incoming_migration_bh() above.

> >  
> >  bool  migration_has_all_channels(void);
> >  
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index fabbeb296a..d7eb416d48 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2069,6 +2069,11 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
> >      return 0;
> >  }
> >  
> > +static void postcopy_ram_listen_thread_bh(void *opaque)
> > +{
> > +    migration_incoming_finish();
> > +}
> > +
> >  /*
> >   * Triggered by a postcopy_listen command; this thread takes over reading
> >   * the input stream, leaving the main thread free to carry on loading the rest
> > @@ -2122,52 +2127,31 @@ static void *postcopy_ram_listen_thread(void *opaque)
> >                           "bitmaps may be lost, and present migrated dirty "
> >                           "bitmaps are correctly migrated and valid.",
> >                           __func__, load_res);
> > -            load_res = 0; /* prevent further exit() */
> >          } else {
> >              error_report("%s: loadvm failed: %d", __func__, load_res);
> >              migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> >                                             MIGRATION_STATUS_FAILED);
> > +            goto out;
> >          }
> >      }
> > -    if (load_res >= 0) {
> > -        /*
> > -         * This looks good, but it's possible that the device loading in the
> > -         * main thread hasn't finished yet, and so we might not be in 'RUN'
> > -         * state yet; wait for the end of the main thread.
> > -         */
> > -        qemu_event_wait(&mis->main_thread_load_event);
> > -    }
> > -    postcopy_ram_incoming_cleanup(mis);
> > -
> > -    if (load_res < 0) {
> > -        /*
> > -         * If something went wrong then we have a bad state so exit;
> > -         * depending how far we got it might be possible at this point
> > -         * to leave the guest running and fire MCEs for pages that never
> > -         * arrived as a desperate recovery step.
> > -         */
> > -        rcu_unregister_thread();
> > -        exit(EXIT_FAILURE);
> > -    }
> > +    /*
> > +     * This looks good, but it's possible that the device loading in the
> > +     * main thread hasn't finished yet, and so we might not be in 'RUN'
> > +     * state yet; wait for the end of the main thread.
> > +     */
> > +    qemu_event_wait(&mis->main_thread_load_event);
> >  
> >      migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> >                                     MIGRATION_STATUS_COMPLETED);
> > -    /*
> > -     * If everything has worked fine, then the main thread has waited
> > -     * for us to start, and we're the last use of the mis.
> > -     * (If something broke then qemu will have to exit anyway since it's
> > -     * got a bad migration state).
> > -     */
> > -    bql_lock();
> > -    migration_incoming_state_destroy();
> > -    bql_unlock();
> >  
> > +out:
> >      rcu_unregister_thread();
> > -    mis->have_listen_thread = false;
> >      postcopy_state_set(POSTCOPY_INCOMING_END);
> >  
> >      object_unref(OBJECT(migr));
> >  
> > +    migration_bh_schedule(postcopy_ram_listen_thread_bh, NULL);
> 
> Better to schedule before the object_unref to ensure there's always
> someone holding a reference?

True, I'll move it.

> 
> > +
> >      return NULL;
> >  }
> >  
> > @@ -2217,7 +2201,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
> >      mis->have_listen_thread = true;
> >      postcopy_thread_create(mis, &mis->listen_thread,
> >                             MIGRATION_THREAD_DST_LISTEN,
> > -                           postcopy_ram_listen_thread, QEMU_THREAD_DETACHED);
> > +                           postcopy_ram_listen_thread, QEMU_THREAD_JOINABLE);
> >      trace_loadvm_postcopy_handle_listen("return");
> >  
> >      return 0;
> 


