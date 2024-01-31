Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BA3C47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVC9S-0008Me-2e; Wed, 31 Jan 2024 10:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVC9O-0008MI-FJ
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:05:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVC9M-0003JG-1p
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:05:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC4C71FB86;
 Wed, 31 Jan 2024 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706713512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMPSlgXg4vjmsqw4LzdAtuMASBREPzo+wjGb6jJ2xVg=;
 b=kgVpMHL3xGLihe4482R5B8aK6wwFzKWPuxCMy2rrffSU5DG2Fa5uZ7MKG/U1rv4iQlAO98
 O96rRALBppM262sCjmyn3yPDLGlsIufWTP/mIrH1k7Z/pUcPc28RaeK61YXacC1LbxXx08
 o9Kp3iJbqzpntthknhZN0jijqm22HpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706713512;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMPSlgXg4vjmsqw4LzdAtuMASBREPzo+wjGb6jJ2xVg=;
 b=XSImlj9W5ZWXGIYUjwapPaGXiHmDg4kqdd1kldPcJrIwqn0Q4a6OO+fcE5qDN2hYdJgEg9
 O4UsLT0K/DRskEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706713511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMPSlgXg4vjmsqw4LzdAtuMASBREPzo+wjGb6jJ2xVg=;
 b=Jmu/oIewLBKUQaWGl9KKEgCCAAUjhqo2NsOJrbkokh9UB7IydgFTEjo8Vw8D5GIe8Zo4qG
 1w0hW2uLiHPELkerB15DsixvbOJ1dwXAWQm6q41X+//wDaWXkk66Ipe/4HYt9rwFLxiS9n
 EyQB6lfuE2vRgiqMebnB9qEHMYT+QpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706713511;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMPSlgXg4vjmsqw4LzdAtuMASBREPzo+wjGb6jJ2xVg=;
 b=hWIBZedVYZ+7q8YwO0CSRQT4CRZcd9QOwSOgLqBXDEspHH0CNTfZJLx+docdd+Gh2Tfwqp
 7bUk2qK66yImH2Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 592061347F;
 Wed, 31 Jan 2024 15:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4t1ZCKdhumVzHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 15:05:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 03/14] migration/multifd: Drop MultiFDSendParams.quit,
 cleanup error paths
In-Reply-To: <20240131103111.306523-4-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-4-peterx@redhat.com>
Date: Wed, 31 Jan 2024 12:05:08 -0300
Message-ID: <87zfwlk0gr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Jmu/oIew";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hWIBZedV
X-Spamd-Result: default: False [-5.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DC4C71FB86
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Multifd send side has two fields to indicate error quits:
>
>   - MultiFDSendParams.quit
>   - &multifd_send_state->exiting
>
> Merge them into the global one.  The replacement is done by changing all
> p->quit checks into the global var check.  The global check doesn't need
> any lock.
>
> A few more things done on top of this altogether:
>
>   - multifd_send_terminate_threads()
>
>     Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
>     the tracepoint, migrate_set_error() and migrate_set_state().

Good.

>
>   - multifd_send_sync_main()
>
>     In the 2nd loop, add one more check over the global var to make sure we
>     don't keep the looping if QEMU already decided to quit.

Yes, also because we don't necessarily enter at multifd_send_page()
every time.

>
>   - multifd_tls_outgoing_handshake()
>
>     Use multifd_send_terminate_threads() to set the error state.  That has
>     a benefit of updating MigrationState.error to that error too, so we can
>     persist that 1st error we hit in that specific channel.

Makes sense.

>
>   - multifd_new_send_channel_async()
>
>     Take similar approach like above, drop the migrate_set_error() because
>     multifd_send_terminate_threads() already covers that.  Unwrap the helper
>     multifd_new_send_channel_cleanup() along the way; not really needed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.h |  2 --
>  migration/multifd.c | 85 ++++++++++++++++++---------------------------
>  2 files changed, 33 insertions(+), 54 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 35d11f103c..7c040cb85a 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -95,8 +95,6 @@ typedef struct {
>      QemuMutex mutex;
>      /* is this channel thread running */
>      bool running;
> -    /* should this thread finish */
> -    bool quit;
>      /* multifd flags for each packet */
>      uint32_t flags;
>      /* global number of generated multifd packets */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b8d2c96533..2c98023d67 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -372,6 +372,11 @@ struct {
>      MultiFDMethods *ops;
>  } *multifd_send_state;
>  
> +static bool multifd_send_should_exit(void)
> +{
> +    return qatomic_read(&multifd_send_state->exiting);
> +}
> +
>  /*
>   * The migration thread can wait on either of the two semaphores.  This
>   * function can be used to kick the main thread out of waiting on either of
> @@ -409,7 +414,7 @@ static int multifd_send_pages(void)
>      MultiFDSendParams *p = NULL; /* make happy gcc */
>      MultiFDPages_t *pages = multifd_send_state->pages;
>  
> -    if (qatomic_read(&multifd_send_state->exiting)) {
> +    if (multifd_send_should_exit()) {
>          return -1;
>      }
>  
> @@ -421,14 +426,11 @@ static int multifd_send_pages(void)
>       */
>      next_channel %= migrate_multifd_channels();
>      for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> -        p = &multifd_send_state->params[i];
> -
> -        qemu_mutex_lock(&p->mutex);
> -        if (p->quit) {
> -            error_report("%s: channel %d has already quit!", __func__, i);
> -            qemu_mutex_unlock(&p->mutex);
> +        if (multifd_send_should_exit()) {
>              return -1;
>          }
> +        p = &multifd_send_state->params[i];
> +        qemu_mutex_lock(&p->mutex);
>          if (!p->pending_job) {
>              p->pending_job++;
>              next_channel = (i + 1) % migrate_multifd_channels();

Hm, I'm not sure it's correct to check 'exiting' outside of the
lock. While it is an atomic operation, it is not atomic in relation to
pending_job...

... looking closer, it seems that we can do what you suggest because
p->pending_job is not touched by the multifd_send_thread in case of
error, which means this function will indeed miss the 'exiting' flag,
but pending_job > 0 means it will loop to the next channel and _then_ it
will see the 'exiting' flag.

> @@ -483,6 +485,16 @@ static void multifd_send_terminate_threads(Error *err)
>  {
>      int i;
>  
> +    /*
> +     * We don't want to exit each threads twice.  Depending on where
> +     * we get the error, or if there are two independent errors in two
> +     * threads at the same time, we can end calling this function
> +     * twice.
> +     */
> +    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
> +        return;
> +    }
> +
>      trace_multifd_send_terminate_threads(err != NULL);
>  
>      if (err) {
> @@ -497,26 +509,13 @@ static void multifd_send_terminate_threads(Error *err)
>          }
>      }
>  
> -    /*
> -     * We don't want to exit each threads twice.  Depending on where
> -     * we get the error, or if there are two independent errors in two
> -     * threads at the same time, we can end calling this function
> -     * twice.
> -     */
> -    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
> -        return;
> -    }
> -
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        qemu_mutex_lock(&p->mutex);
> -        p->quit = true;

Now that you removed this, we decoupled kicking the threads from setting
the exit/error, so this function could be split in two.

We could set the exiting flag at the places the error occurred (multifd
threads, thread creation, etc) and "terminate the threads" at
multifd_save_cleanup(). That second part we already do actually:

void multifd_save_cleanup(void) {
...
    multifd_send_terminate_threads(NULL);
                                   ^see?
    for (i = 0; i < migrate_multifd_channels(); i++) {
        MultiFDSendParams *p = &multifd_send_state->params[i];

        if (p->running) {
            qemu_thread_join(&p->thread);
        }
    }
...
}

I think there's no reason anymore for the channels to kick each
other. They would all be waiting at p->sem and multifd_send_cleanup()
would kick + join them.

>          qemu_sem_post(&p->sem);
>          if (p->c) {
>              qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>          }
> -        qemu_mutex_unlock(&p->mutex);
>      }
>  }
>  
> @@ -615,16 +614,13 @@ int multifd_send_sync_main(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        trace_multifd_send_sync_main_signal(p->id);
> -
> -        qemu_mutex_lock(&p->mutex);
> -
> -        if (p->quit) {
> -            error_report("%s: channel %d has already quit", __func__, i);
> -            qemu_mutex_unlock(&p->mutex);
> +        if (multifd_send_should_exit()) {
>              return -1;
>          }
>  
> +        trace_multifd_send_sync_main_signal(p->id);
> +
> +        qemu_mutex_lock(&p->mutex);
>          p->packet_num = multifd_send_state->packet_num++;
>          p->flags |= MULTIFD_FLAG_SYNC;
>          p->pending_job++;
> @@ -634,6 +630,10 @@ int multifd_send_sync_main(void)
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> +        if (multifd_send_should_exit()) {
> +            return -1;
> +        }
> +
>          qemu_sem_wait(&multifd_send_state->channels_ready);
>          trace_multifd_send_sync_main_wait(p->id);
>          qemu_sem_wait(&p->sem_sync);
> @@ -671,7 +671,7 @@ static void *multifd_send_thread(void *opaque)
>          qemu_sem_post(&multifd_send_state->channels_ready);
>          qemu_sem_wait(&p->sem);
>  
> -        if (qatomic_read(&multifd_send_state->exiting)) {
> +        if (multifd_send_should_exit()) {
>              break;
>          }
>          qemu_mutex_lock(&p->mutex);
> @@ -786,12 +786,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>  
>      trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>  
> -    migrate_set_error(migrate_get_current(), err);
> -    /*
> -     * Error happen, mark multifd_send_thread status as 'quit' although it
> -     * is not created, and then tell who pay attention to me.
> -     */
> -    p->quit = true;
> +    multifd_send_terminate_threads(err);
>      multifd_send_kick_main(p);
>      error_free(err);
>  }
> @@ -857,22 +852,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>      return true;
>  }
>  
> -static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
> -                                             QIOChannel *ioc, Error *err)
> -{
> -     migrate_set_error(migrate_get_current(), err);
> -     /* Error happen, we need to tell who pay attention to me */
> -     multifd_send_kick_main(p);
> -     /*
> -      * Although multifd_send_thread is not created, but main migration
> -      * thread need to judge whether it is running, so we need to mark
> -      * its status.
> -      */
> -     p->quit = true;
> -     object_unref(OBJECT(ioc));
> -     error_free(err);
> -}
> -
>  static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>  {
>      MultiFDSendParams *p = opaque;
> @@ -889,7 +868,10 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>      }
>  
>      trace_multifd_new_send_channel_async_error(p->id, local_err);
> -    multifd_new_send_channel_cleanup(p, ioc, local_err);
> +    multifd_send_terminate_threads(local_err);
> +    multifd_send_kick_main(p);
> +    object_unref(OBJECT(ioc));
> +    error_free(local_err);
>  }
>  
>  static void multifd_new_send_channel_create(gpointer opaque)
> @@ -921,7 +903,6 @@ int multifd_save_setup(Error **errp)
>          qemu_mutex_init(&p->mutex);
>          qemu_sem_init(&p->sem, 0);
>          qemu_sem_init(&p->sem_sync, 0);
> -        p->quit = false;
>          p->pending_job = 0;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);

