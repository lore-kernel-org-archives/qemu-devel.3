Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC93C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 20:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW0YR-0003hH-Tu; Fri, 02 Feb 2024 15:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW0YQ-0003h3-3G
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:54:30 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rW0YO-00025x-9Y
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 15:54:29 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 612821FD3B;
 Fri,  2 Feb 2024 20:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706907266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUeJCIZSYZLrskiAd/XD2m8GfXX3RRtL1oohl1gNqjg=;
 b=WO1u2h/p+iAERPmPhEcaAGQjo5d2aLHkd04qUDRWEwb27gayyNV6y71xLIoYHJJepawOsg
 SlvsQHxqzLLogVvmIslKx7fJqXA/tpU9UdIYme8iTYles9Hw9RTq9WukRoJXyk5Ea7mLXk
 1AKDvt262tJKB7+ifbo+eE5Xk/mT+5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706907266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUeJCIZSYZLrskiAd/XD2m8GfXX3RRtL1oohl1gNqjg=;
 b=JK0Zrizlid+pNz9feF5ACIuPU06S+xajMP4kMk93TOeZc9GfpMucieAcaCoFW2hzqpG5id
 qdDKDOjO9hG8czDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706907266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUeJCIZSYZLrskiAd/XD2m8GfXX3RRtL1oohl1gNqjg=;
 b=WO1u2h/p+iAERPmPhEcaAGQjo5d2aLHkd04qUDRWEwb27gayyNV6y71xLIoYHJJepawOsg
 SlvsQHxqzLLogVvmIslKx7fJqXA/tpU9UdIYme8iTYles9Hw9RTq9WukRoJXyk5Ea7mLXk
 1AKDvt262tJKB7+ifbo+eE5Xk/mT+5E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706907266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VUeJCIZSYZLrskiAd/XD2m8GfXX3RRtL1oohl1gNqjg=;
 b=JK0Zrizlid+pNz9feF5ACIuPU06S+xajMP4kMk93TOeZc9GfpMucieAcaCoFW2hzqpG5id
 qdDKDOjO9hG8czDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFEBB13A58;
 Fri,  2 Feb 2024 20:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iyVjKYFWvWUYeQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 20:54:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 19/23] migration/multifd: Cleanup multifd_save_cleanup()
In-Reply-To: <20240202102857.110210-20-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-20-peterx@redhat.com>
Date: Fri, 02 Feb 2024 17:54:23 -0300
Message-ID: <87a5oih9j4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="WO1u2h/p";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JK0Zrizl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.59 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; BAYES_SPAM(5.10)[99.99%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 612821FD3B
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
> Shrink the function by moving relevant works into helpers: move the thread
> join()s into multifd_send_terminate_threads(), then create two more helpers
> to cover channel/state cleanups.
>
> Add a TODO entry for the thread terminate process because p->running is
> still buggy.  We need to fix it at some point but not yet covered.
>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

minor comment below

> ---
>  migration/multifd.c | 91 +++++++++++++++++++++++++++++----------------
>  1 file changed, 59 insertions(+), 32 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 4ab8e6eff2..4cb0d2cc17 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -593,6 +593,11 @@ static void multifd_send_terminate_threads(void)
>       * always set it.
>       */
>      qatomic_set(&multifd_send_state->exiting, 1);
> +
> +    /*
> +     * Firstly, kick all threads out; no matter whether they are just idle,
> +     * or blocked in an IO system call.
> +     */
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> @@ -601,6 +606,21 @@ static void multifd_send_terminate_threads(void)
>              qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
>          }
>      }
> +
> +    /*
> +     * Finally recycle all the threads.
> +     *
> +     * TODO: p->running is still buggy, e.g. we can reach here without the
> +     * corresponding multifd_new_send_channel_async() get invoked yet,
> +     * then a new thread can even be created after this function returns.
> +     */

Series on the list:

https://lore.kernel.org/r/20240202191128.1901-1-farosas@suse.de

> +    for (i = 0; i < migrate_multifd_channels(); i++) {
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        if (p->running) {
> +            qemu_thread_join(&p->thread);
> +        }
> +    }
>  }
>  
>  static int multifd_send_channel_destroy(QIOChannel *send)
> @@ -608,6 +628,41 @@ static int multifd_send_channel_destroy(QIOChannel *send)
>      return socket_send_channel_destroy(send);
>  }
>  
> +static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
> +{
> +    if (p->registered_yank) {
> +        migration_ioc_unregister_yank(p->c);
> +    }
> +    multifd_send_channel_destroy(p->c);
> +    p->c = NULL;
> +    qemu_mutex_destroy(&p->mutex);
> +    qemu_sem_destroy(&p->sem);
> +    qemu_sem_destroy(&p->sem_sync);
> +    g_free(p->name);
> +    p->name = NULL;
> +    multifd_pages_clear(p->pages);
> +    p->pages = NULL;
> +    p->packet_len = 0;
> +    g_free(p->packet);
> +    p->packet = NULL;
> +    g_free(p->iov);
> +    p->iov = NULL;
> +    multifd_send_state->ops->send_cleanup(p, errp);
> +
> +    return *errp == NULL;

I think technically this would require the ERRP_GUARD() macro?

> +}
> +
> +static void multifd_send_cleanup_state(void)
> +{
> +    qemu_sem_destroy(&multifd_send_state->channels_ready);
> +    g_free(multifd_send_state->params);
> +    multifd_send_state->params = NULL;
> +    multifd_pages_clear(multifd_send_state->pages);
> +    multifd_send_state->pages = NULL;
> +    g_free(multifd_send_state);
> +    multifd_send_state = NULL;
> +}
> +
>  void multifd_save_cleanup(void)
>  {
>      int i;
> @@ -615,48 +670,20 @@ void multifd_save_cleanup(void)
>      if (!migrate_multifd()) {
>          return;
>      }
> +
>      multifd_send_terminate_threads();
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> -        MultiFDSendParams *p = &multifd_send_state->params[i];
>  
> -        if (p->running) {
> -            qemu_thread_join(&p->thread);
> -        }
> -    }
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
>  
> -        if (p->registered_yank) {
> -            migration_ioc_unregister_yank(p->c);
> -        }
> -        multifd_send_channel_destroy(p->c);
> -        p->c = NULL;
> -        qemu_mutex_destroy(&p->mutex);
> -        qemu_sem_destroy(&p->sem);
> -        qemu_sem_destroy(&p->sem_sync);
> -        g_free(p->name);
> -        p->name = NULL;
> -        multifd_pages_clear(p->pages);
> -        p->pages = NULL;
> -        p->packet_len = 0;
> -        g_free(p->packet);
> -        p->packet = NULL;
> -        g_free(p->iov);
> -        p->iov = NULL;
> -        multifd_send_state->ops->send_cleanup(p, &local_err);
> -        if (local_err) {
> +        if (!multifd_send_cleanup_channel(p, &local_err)) {
>              migrate_set_error(migrate_get_current(), local_err);
>              error_free(local_err);
>          }
>      }
> -    qemu_sem_destroy(&multifd_send_state->channels_ready);
> -    g_free(multifd_send_state->params);
> -    multifd_send_state->params = NULL;
> -    multifd_pages_clear(multifd_send_state->pages);
> -    multifd_send_state->pages = NULL;
> -    g_free(multifd_send_state);
> -    multifd_send_state = NULL;
> +
> +    multifd_send_cleanup_state();
>  }
>  
>  static int multifd_zero_copy_flush(QIOChannel *c)

