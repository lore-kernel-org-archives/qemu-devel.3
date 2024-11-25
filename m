Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE57D59D68
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 19:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFexq-0000RC-D6; Mon, 25 Nov 2024 14:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFexp-0000R3-Db
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:41:41 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFexn-000233-DY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:41:41 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 967ED1F399;
 Mon, 25 Nov 2024 19:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732563695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOUxdXdJjfsl7DtOfrW6KxHC4EvDPaccTGKWeTa+DYY=;
 b=bY3wNdj7QhBI9b355tOzisBQB6M53LLyBlkgV3LUxMzz7II6KqO6Iw41bGVvdt9fJywsfr
 lso42MYpB+rgdBeIqZEzhixseV8R8W3Scd+CeXMH/mk3YOTr7RiyRynAmEHvAzWXa7JhRy
 7lOWmo7JWv/x6JrHlB9g8MKpUd2wNz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732563695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOUxdXdJjfsl7DtOfrW6KxHC4EvDPaccTGKWeTa+DYY=;
 b=RtUla6I1DD7DUxLEoWD1lwQG8QklLg9yFpC4NuHCaqEr61qR2/lQRUqyxPfhdvgrv+5lp3
 YKvecfkTAGmWfKDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bY3wNdj7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RtUla6I1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732563695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOUxdXdJjfsl7DtOfrW6KxHC4EvDPaccTGKWeTa+DYY=;
 b=bY3wNdj7QhBI9b355tOzisBQB6M53LLyBlkgV3LUxMzz7II6KqO6Iw41bGVvdt9fJywsfr
 lso42MYpB+rgdBeIqZEzhixseV8R8W3Scd+CeXMH/mk3YOTr7RiyRynAmEHvAzWXa7JhRy
 7lOWmo7JWv/x6JrHlB9g8MKpUd2wNz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732563695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NOUxdXdJjfsl7DtOfrW6KxHC4EvDPaccTGKWeTa+DYY=;
 b=RtUla6I1DD7DUxLEoWD1lwQG8QklLg9yFpC4NuHCaqEr61qR2/lQRUqyxPfhdvgrv+5lp3
 YKvecfkTAGmWfKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 142A313890;
 Mon, 25 Nov 2024 19:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1LLAMu7SRGegLAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 19:41:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
In-Reply-To: <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
Date: Mon, 25 Nov 2024 16:41:32 -0300
Message-ID: <87ldx7nlsj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 967ED1F399
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Migration code wants to manage device data sending threads in one place.
>
> QEMU has an existing thread pool implementation, however it is limited
> to queuing AIO operations only and essentially has a 1:1 mapping between
> the current AioContext and the AIO ThreadPool in use.
>
> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
> GThreadPool.
>
> This brings a few new operations on a pool:
> * thread_pool_wait() operation waits until all the submitted work requests
> have finished.
>
> * thread_pool_set_max_threads() explicitly sets the maximum thread count
> in the pool.
>
> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
> in the pool to equal the number of still waiting in queue or unfinished work.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/block/thread-pool.h |   9 +++
>  util/thread-pool.c          | 109 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>
> diff --git a/include/block/thread-pool.h b/include/block/thread-pool.h
> index 6f27eb085b45..3f9f66307b65 100644
> --- a/include/block/thread-pool.h
> +++ b/include/block/thread-pool.h
> @@ -38,5 +38,14 @@ BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
>  int coroutine_fn thread_pool_submit_co(ThreadPoolFunc *func, void *arg);
>  void thread_pool_update_params(ThreadPoolAio *pool, struct AioContext *ctx);
>  
> +typedef struct ThreadPool ThreadPool;
> +
> +ThreadPool *thread_pool_new(void);
> +void thread_pool_free(ThreadPool *pool);
> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                        void *opaque, GDestroyNotify opaque_destroy);
> +void thread_pool_wait(ThreadPool *pool);
> +bool thread_pool_set_max_threads(ThreadPool *pool, int max_threads);
> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool);
>  
>  #endif
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index 908194dc070f..d80c4181c897 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -374,3 +374,112 @@ void thread_pool_free_aio(ThreadPoolAio *pool)
>      qemu_mutex_destroy(&pool->lock);
>      g_free(pool);
>  }
> +
> +struct ThreadPool { /* type safety */
> +    GThreadPool *t;
> +    size_t unfinished_el_ctr;
> +    QemuMutex unfinished_el_ctr_mutex;
> +    QemuCond unfinished_el_ctr_zero_cond;
> +};
> +
> +typedef struct {
> +    ThreadPoolFunc *func;
> +    void *opaque;
> +    GDestroyNotify opaque_destroy;
> +} ThreadPoolElement;
> +
> +static void thread_pool_func(gpointer data, gpointer user_data)
> +{
> +    ThreadPool *pool = user_data;
> +    g_autofree ThreadPoolElement *el = data;
> +
> +    el->func(el->opaque);
> +
> +    if (el->opaque_destroy) {
> +        el->opaque_destroy(el->opaque);
> +    }
> +
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    assert(pool->unfinished_el_ctr > 0);
> +    pool->unfinished_el_ctr--;
> +
> +    if (pool->unfinished_el_ctr == 0) {
> +        qemu_cond_signal(&pool->unfinished_el_ctr_zero_cond);
> +    }
> +}
> +
> +ThreadPool *thread_pool_new(void)
> +{
> +    ThreadPool *pool = g_new(ThreadPool, 1);
> +
> +    pool->unfinished_el_ctr = 0;
> +    qemu_mutex_init(&pool->unfinished_el_ctr_mutex);
> +    qemu_cond_init(&pool->unfinished_el_ctr_zero_cond);
> +
> +    pool->t = g_thread_pool_new(thread_pool_func, pool, 0, TRUE, NULL);
> +    /*
> +     * g_thread_pool_new() can only return errors if initial thread(s)
> +     * creation fails but we ask for 0 initial threads above.
> +     */
> +    assert(pool->t);
> +
> +    return pool;
> +}
> +
> +void thread_pool_free(ThreadPool *pool)
> +{
> +    g_thread_pool_free(pool->t, FALSE, TRUE);

Should we make it an error to call thread_poll_free without first
calling thread_poll_wait? I worry the current usage will lead to having
two different ways of waiting with one of them (this one) being quite
implicit.

> +
> +    qemu_cond_destroy(&pool->unfinished_el_ctr_zero_cond);
> +    qemu_mutex_destroy(&pool->unfinished_el_ctr_mutex);
> +
> +    g_free(pool);
> +}
> +
> +void thread_pool_submit(ThreadPool *pool, ThreadPoolFunc *func,
> +                        void *opaque, GDestroyNotify opaque_destroy)
> +{
> +    ThreadPoolElement *el = g_new(ThreadPoolElement, 1);
> +
> +    el->func = func;
> +    el->opaque = opaque;
> +    el->opaque_destroy = opaque_destroy;
> +
> +    WITH_QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex) {
> +        pool->unfinished_el_ctr++;
> +    }
> +
> +    /*
> +     * Ignore the return value since this function can only return errors
> +     * if creation of an additional thread fails but even in this case the
> +     * provided work is still getting queued (just for the existing threads).
> +     */
> +    g_thread_pool_push(pool->t, el, NULL);
> +}
> +
> +void thread_pool_wait(ThreadPool *pool)
> +{
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    if (pool->unfinished_el_ctr > 0) {
> +        qemu_cond_wait(&pool->unfinished_el_ctr_zero_cond,
> +                       &pool->unfinished_el_ctr_mutex);
> +        assert(pool->unfinished_el_ctr == 0);
> +    }
> +}
> +
> +bool thread_pool_set_max_threads(ThreadPool *pool,
> +                                 int max_threads)
> +{
> +    assert(max_threads > 0);
> +
> +    return g_thread_pool_set_max_threads(pool->t, max_threads, NULL);
> +}
> +
> +bool thread_pool_adjust_max_threads_to_work(ThreadPool *pool)
> +{
> +    QEMU_LOCK_GUARD(&pool->unfinished_el_ctr_mutex);
> +
> +    return thread_pool_set_max_threads(pool, pool->unfinished_el_ctr);
> +}

