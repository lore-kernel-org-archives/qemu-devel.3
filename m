Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FF5C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 13:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXi1y-0005TZ-Sf; Wed, 07 Feb 2024 08:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXi1x-0005RT-2y
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:32:01 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXi1t-0007hi-HQ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 08:32:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 956FE1FBEF;
 Wed,  7 Feb 2024 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707312714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RyFbARdFQntg/tgoKKwub531yQnfaVrM/MWg1r5fg0=;
 b=QNOHJNcBkvE+eEdcQBt0mN8tku3PZDWJ9Iorftyp10nKBLMPf2+S47IX/IoLX4HaC446i8
 tDrYrD7r7GH+g/4AR2+L3qi4Vh9Gv78x/e9RYm5k9Plpbje95s4JdDMBAMgOSTqZX3wrbT
 DidXR4/K7Y/MzN9IuFW+T3rePnoFUUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707312714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RyFbARdFQntg/tgoKKwub531yQnfaVrM/MWg1r5fg0=;
 b=u6bI4hGGZEd9qg8Mf+0k9N8JjfoXgPFTferv+vjUUkiz5UeNFievnz8o0iggEAEtUAzLFZ
 QuDt5sc3nVhODlBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707312714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RyFbARdFQntg/tgoKKwub531yQnfaVrM/MWg1r5fg0=;
 b=QNOHJNcBkvE+eEdcQBt0mN8tku3PZDWJ9Iorftyp10nKBLMPf2+S47IX/IoLX4HaC446i8
 tDrYrD7r7GH+g/4AR2+L3qi4Vh9Gv78x/e9RYm5k9Plpbje95s4JdDMBAMgOSTqZX3wrbT
 DidXR4/K7Y/MzN9IuFW+T3rePnoFUUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707312714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2RyFbARdFQntg/tgoKKwub531yQnfaVrM/MWg1r5fg0=;
 b=u6bI4hGGZEd9qg8Mf+0k9N8JjfoXgPFTferv+vjUUkiz5UeNFievnz8o0iggEAEtUAzLFZ
 QuDt5sc3nVhODlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EF8C139B9;
 Wed,  7 Feb 2024 13:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6YqwNUmGw2XkHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 Feb 2024 13:31:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>, =?utf-8?Q?Da?=
 =?utf-8?Q?niel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/6] migration/multifd: Fix channel creation vs.
 cleanup races
In-Reply-To: <ZcLrF5HN920rUTSw@x1n>
References: <20240206215118.6171-1-farosas@suse.de> <ZcLrF5HN920rUTSw@x1n>
Date: Wed, 07 Feb 2024 10:31:51 -0300
Message-ID: <878r3w7648.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

> On Tue, Feb 06, 2024 at 06:51:12PM -0300, Fabiano Rosas wrote:
>> Based-on: 20240202102857.110210-1-peterx@redhat.com
>> [PATCH v2 00/23] migration/multifd: Refactor ->send_prepare() and cleanups
>> https://lore.kernel.org/r/20240202102857.110210-1-peterx@redhat.com
>> 
>> Hi,
>> 
>> For v3 I fixed the refcounting issue spotted by Avihai. The situation
>> there is a bit clunky due to historical reasons. The gist is that we
>> have an assumption that channel creation never fails after p->c has
>> been set, so when 'p->c == NULL' we have to unref and when 'p->c !=
>> NULL' the cleanup code will do the unref.
>
> Yes, this looks good to me.  That's a good catch.
>
> I'll leave at least one more day for Avihai and/or Dan to have another
> look.  My r-b persist as of now on patch 5.
>
> Actually I think the conditional unref is slightly tricky, but it's not its
> own fault, IMHO, OTOH it's more about a1af605bd5ad where p->c is slightly
> abused.  My understanding is we can avoid that conditional unref with below
> patch 1 as a cleanup (on top of this series).  Then patch 2 comes all
> alongside.

Yes, I even wrote some code to always set p->c and leave the unref to
the cleanup routine. Doing reference counting in the middle of the code
like that leaves us exposed to new code relying on p->c being valid
during cleanup. There's already yank and the cleanup itself which expect
p->c to be valid.

However, I couldn't get past the uglyness of overwriting p->c, so I kept
the changes minimal for this version.

I'm also wondering whether we can remove the TLS handshake thread
altogether now that we moved the multifd_send_setup call into the
migration thread. My (poor) understanding is that a1af605bd5ad hit the
issue that the QIOTask completion would just execute after
multifd_save_setup returned. Otherwise I don't see how adding a thread
to an already async task would have helped. But I need to think about
that a bit more.

>
> We don't need to rush on these, though, we should fix the thread race
>first because multiple of us hit it, and all cleanups can be done
>later.

I said we should not merge these two changes right now, but I take that
back. I'll leave it up to you, there doesn't seem to be that much impact
in adding them.

>
> =====
> From 0830819d86e08c5175d6669505aa712a0a09717f Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 7 Feb 2024 10:08:35 +0800
> Subject: [PATCH 1/2] migration/multifd: Cleanup TLS iochannel referencing
>
> Commit a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to
> blocking handshake") introduced a thread for TLS channels, which will
> resolve the issue on blocking the main thread.  However in the same commit
> p->c is slightly abused just to be able to pass over the pointer "p" into
> the thread.
>
> That's the major reason we'll need to conditionally free the io channel in
> the fault paths.
>
> To clean it up, using a separate structure to pass over both "p" and "tioc"
> in the tls handshake thread.  Then we can make it a rule that p->c will
> never be set until the channel is completely setup.  With that, we can drop
> the tricky conditional unref of the io channel in the error path.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index adfe8c9a0a..4a85a6b7b3 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -873,16 +873,22 @@ out:
>  
>  static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
>  
> +typedef struct {
> +    MultiFDSendParams *p;
> +    QIOChannelTLS *tioc;
> +} MultiFDTLSThreadArgs;
> +
>  static void *multifd_tls_handshake_thread(void *opaque)
>  {
> -    MultiFDSendParams *p = opaque;
> -    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
> +    MultiFDTLSThreadArgs *args = opaque;
>  
> -    qio_channel_tls_handshake(tioc,
> +    qio_channel_tls_handshake(args->tioc,
>                                multifd_new_send_channel_async,
> -                              p,
> +                              args->p,
>                                NULL,
>                                NULL);
> +    g_free(args);
> +
>      return NULL;
>  }
>  
> @@ -892,6 +898,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>  {
>      MigrationState *s = migrate_get_current();
>      const char *hostname = s->hostname;
> +    MultiFDTLSThreadArgs *args;
>      QIOChannelTLS *tioc;
>  
>      tioc = migration_tls_client_create(ioc, hostname, errp);
> @@ -906,11 +913,14 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
>      object_unref(OBJECT(ioc));
>      trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
>      qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
> -    p->c = QIO_CHANNEL(tioc);

This assignment also meant multifd_send_channel_destroy() would call
object_unref on the tioc object. Removing it means
qio_channel_tls_finalize() will never be called.

It also means the socket channel (ioc) refcount will be decremented one
too many times, due to the object_unref above^.

So I think we should find a point where tioc is not needed anymore and
unref it and remove the object_unref(ioc) above.

Right?

> +
> +    args = g_new0(MultiFDTLSThreadArgs, 1);
> +    args->tioc = tioc;
> +    args->p = p;
>  
>      p->tls_thread_created = true;
>      qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
> -                       multifd_tls_handshake_thread, p,
> +                       multifd_tls_handshake_thread, args,
>                         QEMU_THREAD_JOINABLE);
>      return true;
>  }
> @@ -923,6 +933,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>  
>      migration_ioc_register_yank(ioc);
>      p->registered_yank = true;
> +    /* Setup p->c only if the channel is completely setup */
>      p->c = ioc;
>  
>      p->thread_created = true;
> @@ -976,14 +987,12 @@ out:
>  
>      trace_multifd_new_send_channel_async_error(p->id, local_err);
>      multifd_send_set_error(local_err);
> -    if (!p->c) {
> -        /*
> -         * If no channel has been created, drop the initial
> -         * reference. Otherwise cleanup happens at
> -         * multifd_send_channel_destroy()
> -         */
> -        object_unref(OBJECT(ioc));
> -    }
> +    /*
> +     * For error cases (TLS or non-TLS), IO channel is always freed here
> +     * rather than when cleanup multifd: since p->c is not set, multifd
> +     * cleanup code doesn't even know its existance.
> +     */
> +    object_unref(OBJECT(ioc));
>      error_free(local_err);
>  }
>  
> -- 
> 2.43.0
> =====
> From 9e574c3216f6459e3a808096d905e2554d962cad Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 7 Feb 2024 10:24:39 +0800
> Subject: [PATCH 2/2] migration/multifd: Drop registered_yank
>
> With a clear definition of p->c protocol, where we only set it up if the
> channel is fully established (TLS or non-TLS), registered_yank boolean will
> have equal meaning of "p->c != NULL".
>
> Drop registered_yank by checking p->c instead.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

This one looks good. I know it depends on the previous patch, but if you
plan to add it:

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  migration/multifd.h | 2 --
>  migration/multifd.c | 7 +++----
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 8a1cad0996..b3fe27ae93 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -78,8 +78,6 @@ typedef struct {
>      bool tls_thread_created;
>      /* communication channel */
>      QIOChannel *c;
> -    /* is the yank function registered */
> -    bool registered_yank;
>      /* packet allocated len */
>      uint32_t packet_len;
>      /* guest page size */
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4a85a6b7b3..278453cf84 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -648,11 +648,11 @@ static int multifd_send_channel_destroy(QIOChannel *send)
>  
>  static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>  {
> -    if (p->registered_yank) {
> +    if (p->c) {
>          migration_ioc_unregister_yank(p->c);
> +        multifd_send_channel_destroy(p->c);
> +        p->c = NULL;
>      }
> -    multifd_send_channel_destroy(p->c);
> -    p->c = NULL;
>      qemu_sem_destroy(&p->sem);
>      qemu_sem_destroy(&p->sem_sync);
>      g_free(p->name);
> @@ -932,7 +932,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>      qio_channel_set_delay(ioc, false);
>  
>      migration_ioc_register_yank(ioc);
> -    p->registered_yank = true;
>      /* Setup p->c only if the channel is completely setup */
>      p->c = ioc;
>  
> -- 
> 2.43.0
> ====
>
> Thanks,

