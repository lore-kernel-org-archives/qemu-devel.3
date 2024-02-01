Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D3CC4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 13:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVX9k-000843-9x; Thu, 01 Feb 2024 08:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVX9B-0007u0-Cv
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:30:29 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVX98-0006vP-0o
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 08:30:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C65A41FBBF;
 Thu,  1 Feb 2024 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706794222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpcNXmMyNLwKukTYEEGKd4y/mGysO/eA254UvWJLmJk=;
 b=AnM2aJsxnluR3+VciI7s59WHrY5XUEdKFLkROo3J28Cg5RrcrwLclg6ruhwQMyBtigev3l
 eeMYlX1Z9GMa/pYpE9Rz9301Ou4lTHOovQ23MARw1Ef1Ghn9oiaAQt4FC7YSGsLExJ2O1K
 hfY7WgfP7ZZW6x5c/q7iRXiQJ/TN5BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706794222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpcNXmMyNLwKukTYEEGKd4y/mGysO/eA254UvWJLmJk=;
 b=xGrCLi/no6MqbhQ9/3Y3MxWMd1QWjiSK2Z0ZXs8rGURk2hVkBKsRhJw8CVy9opCrXZG8kk
 Vfw0ElmNuaCmN4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706794222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpcNXmMyNLwKukTYEEGKd4y/mGysO/eA254UvWJLmJk=;
 b=AnM2aJsxnluR3+VciI7s59WHrY5XUEdKFLkROo3J28Cg5RrcrwLclg6ruhwQMyBtigev3l
 eeMYlX1Z9GMa/pYpE9Rz9301Ou4lTHOovQ23MARw1Ef1Ghn9oiaAQt4FC7YSGsLExJ2O1K
 hfY7WgfP7ZZW6x5c/q7iRXiQJ/TN5BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706794222;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jpcNXmMyNLwKukTYEEGKd4y/mGysO/eA254UvWJLmJk=;
 b=xGrCLi/no6MqbhQ9/3Y3MxWMd1QWjiSK2Z0ZXs8rGURk2hVkBKsRhJw8CVy9opCrXZG8kk
 Vfw0ElmNuaCmN4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FC76139AB;
 Thu,  1 Feb 2024 13:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X8MbBu6cu2UaRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Feb 2024 13:30:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>, Prasad
 Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>, Avihai Horon
 <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 03/14] migration/multifd: Drop MultiFDSendParams.quit,
 cleanup error paths
In-Reply-To: <ZbtkQLnPJDmXK912@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-4-peterx@redhat.com> <87zfwlk0gr.fsf@suse.de>
 <ZbtkQLnPJDmXK912@x1n>
Date: Thu, 01 Feb 2024 10:30:19 -0300
Message-ID: <87sf2cia6s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

> On Wed, Jan 31, 2024 at 12:05:08PM -0300, Fabiano Rosas wrote:
>> peterx@redhat.com writes:
>> 
>> > From: Peter Xu <peterx@redhat.com>
>> >
>> > Multifd send side has two fields to indicate error quits:
>> >
>> >   - MultiFDSendParams.quit
>> >   - &multifd_send_state->exiting
>> >
>> > Merge them into the global one.  The replacement is done by changing all
>> > p->quit checks into the global var check.  The global check doesn't need
>> > any lock.
>> >
>> > A few more things done on top of this altogether:
>> >
>> >   - multifd_send_terminate_threads()
>> >
>> >     Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
>> >     the tracepoint, migrate_set_error() and migrate_set_state().
>> 
>> Good.
>> 
>> >
>> >   - multifd_send_sync_main()
>> >
>> >     In the 2nd loop, add one more check over the global var to make sure we
>> >     don't keep the looping if QEMU already decided to quit.
>> 
>> Yes, also because we don't necessarily enter at multifd_send_page()
>> every time.
>> 
>> >
>> >   - multifd_tls_outgoing_handshake()
>> >
>> >     Use multifd_send_terminate_threads() to set the error state.  That has
>> >     a benefit of updating MigrationState.error to that error too, so we can
>> >     persist that 1st error we hit in that specific channel.
>> 
>> Makes sense.
>> 
>> >
>> >   - multifd_new_send_channel_async()
>> >
>> >     Take similar approach like above, drop the migrate_set_error() because
>> >     multifd_send_terminate_threads() already covers that.  Unwrap the helper
>> >     multifd_new_send_channel_cleanup() along the way; not really needed.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/multifd.h |  2 --
>> >  migration/multifd.c | 85 ++++++++++++++++++---------------------------
>> >  2 files changed, 33 insertions(+), 54 deletions(-)
>> >
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 35d11f103c..7c040cb85a 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -95,8 +95,6 @@ typedef struct {
>> >      QemuMutex mutex;
>> >      /* is this channel thread running */
>> >      bool running;
>> > -    /* should this thread finish */
>> > -    bool quit;
>> >      /* multifd flags for each packet */
>> >      uint32_t flags;
>> >      /* global number of generated multifd packets */
>> > diff --git a/migration/multifd.c b/migration/multifd.c
>> > index b8d2c96533..2c98023d67 100644
>> > --- a/migration/multifd.c
>> > +++ b/migration/multifd.c
>> > @@ -372,6 +372,11 @@ struct {
>> >      MultiFDMethods *ops;
>> >  } *multifd_send_state;
>> >  
>> > +static bool multifd_send_should_exit(void)
>> > +{
>> > +    return qatomic_read(&multifd_send_state->exiting);
>> > +}
>> > +
>> >  /*
>> >   * The migration thread can wait on either of the two semaphores.  This
>> >   * function can be used to kick the main thread out of waiting on either of
>> > @@ -409,7 +414,7 @@ static int multifd_send_pages(void)
>> >      MultiFDSendParams *p = NULL; /* make happy gcc */
>> >      MultiFDPages_t *pages = multifd_send_state->pages;
>> >  
>> > -    if (qatomic_read(&multifd_send_state->exiting)) {
>> > +    if (multifd_send_should_exit()) {
>> >          return -1;
>> >      }
v>> >  
>> > @@ -421,14 +426,11 @@ static int multifd_send_pages(void)
>> >       */
>> >      next_channel %= migrate_multifd_channels();
>> >      for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
>> > -        p = &multifd_send_state->params[i];
>> > -
>> > -        qemu_mutex_lock(&p->mutex);
>> > -        if (p->quit) {
>> > -            error_report("%s: channel %d has already quit!", __func__, i);
>> > -            qemu_mutex_unlock(&p->mutex);
>> > +        if (multifd_send_should_exit()) {
>> >              return -1;
>> >          }
>> > +        p = &multifd_send_state->params[i];
>> > +        qemu_mutex_lock(&p->mutex);
>> >          if (!p->pending_job) {
>> >              p->pending_job++;
>> >              next_channel = (i + 1) % migrate_multifd_channels();
>> 
>> Hm, I'm not sure it's correct to check 'exiting' outside of the
>> lock. While it is an atomic operation, it is not atomic in relation to
>> pending_job...
>> 
>> ... looking closer, it seems that we can do what you suggest because
>> p->pending_job is not touched by the multifd_send_thread in case of
>> error, which means this function will indeed miss the 'exiting' flag,
>> but pending_job > 0 means it will loop to the next channel and _then_ it
>> will see the 'exiting' flag.
>
> It could still be the last channel we iterate, then IIUC we can still try
> to assign a job to a thread even if a concurrent error is set there.
>
> However IMHO it's okay; the error in the sender thread should ultimately
> set migrate_set_error() and the main thread should detect that in the
> migration loop, then we'll still quit.  The extra queued job shouldn't
> matter, IMHO.
>
>> 
>> > @@ -483,6 +485,16 @@ static void multifd_send_terminate_threads(Error *err)
>> >  {
>> >      int i;
>> >  
>> > +    /*
>> > +     * We don't want to exit each threads twice.  Depending on where
>> > +     * we get the error, or if there are two independent errors in two
>> > +     * threads at the same time, we can end calling this function
>> > +     * twice.
>> > +     */
>> > +    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
>> > +        return;
>> > +    }
>> > +
>> >      trace_multifd_send_terminate_threads(err != NULL);
>> >  
>> >      if (err) {
>> > @@ -497,26 +509,13 @@ static void multifd_send_terminate_threads(Error *err)
>> >          }
>> >      }
>> >  
>> > -    /*
>> > -     * We don't want to exit each threads twice.  Depending on where
>> > -     * we get the error, or if there are two independent errors in two
>> > -     * threads at the same time, we can end calling this function
>> > -     * twice.
>> > -     */
>> > -    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
>> > -        return;
>> > -    }
>> > -
>> >      for (i = 0; i < migrate_multifd_channels(); i++) {
>> >          MultiFDSendParams *p = &multifd_send_state->params[i];
>> >  
>> > -        qemu_mutex_lock(&p->mutex);
>> > -        p->quit = true;
>> 
>> Now that you removed this, we decoupled kicking the threads from setting
>> the exit/error, so this function could be split in two.
>> 
>> We could set the exiting flag at the places the error occurred (multifd
>> threads, thread creation, etc) and "terminate the threads" at
>> multifd_save_cleanup(). That second part we already do actually:
>> 
>> void multifd_save_cleanup(void) {
>> ...
>>     multifd_send_terminate_threads(NULL);
>>                                    ^see?
>>     for (i = 0; i < migrate_multifd_channels(); i++) {
>>         MultiFDSendParams *p = &multifd_send_state->params[i];
>> 
>>         if (p->running) {
>>             qemu_thread_join(&p->thread);
>>         }
>>     }
>> ...
>> }
>> 
>> I think there's no reason anymore for the channels to kick each
>> other. They would all be waiting at p->sem and multifd_send_cleanup()
>> would kick + join them.
>
> Sounds good here.
>
> I'll attach one patch like this, feel free to have an early look:
>
> =====
>
> From f9a3d63d5cca0068daaea4c72392803f4b29dcb5 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 1 Feb 2024 17:01:54 +0800
> Subject: [PATCH] migration/multifd: Split multifd_send_terminate_threads()
>
> Split multifd_send_terminate_threads() into two functions:
>
>   - multifd_send_set_error(): used when an error happened on the sender
>     side, set error and quit state only
>
>   - multifd_send_terminate_threads(): used only by the main thread to kick
>     all multifd send threads out of sleep, for the last recycling.
>
> Use multifd_send_set_error() in the three old call sites where only the
> error will be set.
>
> Use multifd_send_terminate_threads() in the last one where the main thread
> will kick the multifd threads at last in multifd_save_cleanup().
>
> Both helpers will need to set quitting=1.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

New patch looks good.

> ---
>  migration/multifd.c    | 27 ++++++++++++++++++---------
>  migration/trace-events |  2 +-
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index c71e74b101..95dc29c8c7 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -536,10 +536,9 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
>      return 1;
>  }
>  
> -static void multifd_send_terminate_threads(Error *err)
> +/* Multifd send side hit an error; remember it and prepare to quit */
> +static void multifd_send_set_error(Error *err)
>  {
> -    int i;
> -
>      /*
>       * We don't want to exit each threads twice.  Depending on where
>       * we get the error, or if there are two independent errors in two
> @@ -550,8 +549,6 @@ static void multifd_send_terminate_threads(Error *err)
>          return;
>      }
>  
> -    trace_multifd_send_terminate_threads(err != NULL);
> -
>      if (err) {
>          MigrationState *s = migrate_get_current();
>          migrate_set_error(s, err);
> @@ -563,7 +560,19 @@ static void multifd_send_terminate_threads(Error *err)
>                                MIGRATION_STATUS_FAILED);
>          }
>      }
> +}
> +
> +static void multifd_send_terminate_threads(void)
> +{
> +    int i;
> +
> +    trace_multifd_send_terminate_threads();
>  
> +    /*
> +     * Tell everyone we're quitting.  No xchg() needed here; we simply
> +     * always set it.
> +     */
> +    qatomic_set(&multifd_send_state->exiting, 1);
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> @@ -586,7 +595,7 @@ void multifd_save_cleanup(void)
>      if (!migrate_multifd()) {
>          return;
>      }
> -    multifd_send_terminate_threads(NULL);
> +    multifd_send_terminate_threads();
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];

We could then move the qemu_thread_join loop into
multifd_send_terminate_threads().

(and fix all the bugs we have so that we only progress past
multifd_send_terminate_threads() once all threads have exited and no
more thread is going to spawn)

>  
> @@ -778,7 +787,7 @@ out:
>      if (ret) {
>          assert(local_err);
>          trace_multifd_send_error(p->id);
> -        multifd_send_terminate_threads(local_err);
> +        multifd_send_set_error(local_err);
>          multifd_send_kick_main(p);
>          error_free(local_err);
>      }
> @@ -814,7 +823,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>  
>      trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>  
> -    multifd_send_terminate_threads(err);
> +    multifd_send_set_error(err);
>      multifd_send_kick_main(p);
>      error_free(err);
>  }
> @@ -896,7 +905,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>      }
>  
>      trace_multifd_new_send_channel_async_error(p->id, local_err);
> -    multifd_send_terminate_threads(local_err);
> +    multifd_send_set_error(local_err);
>      multifd_send_kick_main(p);
>      object_unref(OBJECT(ioc));
>      error_free(local_err);
> diff --git a/migration/trace-events b/migration/trace-events
> index de4a743c8a..298ad2b0dd 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -141,7 +141,7 @@ multifd_send_error(uint8_t id) "channel %u"
>  multifd_send_sync_main(long packet_num) "packet num %ld"
>  multifd_send_sync_main_signal(uint8_t id) "channel %u"
>  multifd_send_sync_main_wait(uint8_t id) "channel %u"
> -multifd_send_terminate_threads(bool error) "error %d"
> +multifd_send_terminate_threads(void) ""
>  multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
>  multifd_send_thread_start(uint8_t id) "%u"
>  multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
> -- 
> 2.43.0

