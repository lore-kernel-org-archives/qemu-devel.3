Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A17AC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 15:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX16W-0002a8-Ua; Mon, 05 Feb 2024 10:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX16V-0002YY-9i
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:41:51 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rX16Q-0008QO-UO
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:41:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DBBA1F8D4;
 Mon,  5 Feb 2024 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707147702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qnzn09Z8o9e6IYrTKCQeqQ20flgMsjNwKrlR2kygoQ=;
 b=ZA6aThF2QjQ0chdNqXmR/1YMl9O97jeXoSbDS+4wRVYhLqEZzC6YdPN1ok/PGgw58bGr4K
 laiMey3Z0SHDDQ/Yot73IJPoCi7z3qzirPBbDoiJ1xUWDgD0e/XrLc0mbgG+pbbN4ouikE
 egU7MFaIxJWIUp5A1UTmvgKe57dKHU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707147702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qnzn09Z8o9e6IYrTKCQeqQ20flgMsjNwKrlR2kygoQ=;
 b=aZWW7krzov5geqQOtdZLpW7LvKYCrVDVU1DrVC5vObQp5R66srF9ukYfvObkiE0PxWOdf/
 rR+wdctA2gK6+WCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707147702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qnzn09Z8o9e6IYrTKCQeqQ20flgMsjNwKrlR2kygoQ=;
 b=ZA6aThF2QjQ0chdNqXmR/1YMl9O97jeXoSbDS+4wRVYhLqEZzC6YdPN1ok/PGgw58bGr4K
 laiMey3Z0SHDDQ/Yot73IJPoCi7z3qzirPBbDoiJ1xUWDgD0e/XrLc0mbgG+pbbN4ouikE
 egU7MFaIxJWIUp5A1UTmvgKe57dKHU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707147702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qnzn09Z8o9e6IYrTKCQeqQ20flgMsjNwKrlR2kygoQ=;
 b=aZWW7krzov5geqQOtdZLpW7LvKYCrVDVU1DrVC5vObQp5R66srF9ukYfvObkiE0PxWOdf/
 rR+wdctA2gK6+WCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09F70136F5;
 Mon,  5 Feb 2024 15:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HB7TMLUBwWWTBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 05 Feb 2024 15:41:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] migration/multifd: Add a synchronization point for
 channel creation
In-Reply-To: <ZcDaRCZdAurisoyj@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-6-farosas@suse.de> <ZcB-O5WiZtvGiyNR@x1n>
 <6bd7f665-23d9-48d5-9f79-0b012e3a6205@nvidia.com> <ZcDaRCZdAurisoyj@x1n>
Date: Mon, 05 Feb 2024 12:41:39 -0300
Message-ID: <874jem6hqk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZA6aThF2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aZWW7krz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-3.00)[100.00%]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 7DBBA1F8D4
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Mon, Feb 05, 2024 at 01:10:14PM +0200, Avihai Horon wrote:
>> 
>> On 05/02/2024 8:20, Peter Xu wrote:
>> > External email: Use caution opening links or attachments
>> > 
>> > 
>> > On Fri, Feb 02, 2024 at 04:11:28PM -0300, Fabiano Rosas wrote:
>> > > It is possible that one of the multifd channels fails to be created at
>> > > multifd_new_send_channel_async() while the rest of the channel
>> > > creation tasks are still in flight.
>> > > 
>> > > This could lead to multifd_save_cleanup() executing the
>> > > qemu_thread_join() loop too early and not waiting for the threads
>> > > which haven't been created yet, leading to the freeing of resources
>> > > that the newly created threads will try to access and crash.
>> > > 
>> > > Add a synchronization point after which there will be no attempts at
>> > > thread creation and therefore calling multifd_save_cleanup() past that
>> > > point will ensure it properly waits for the threads.
>> > > 
>> > > A note about performance: Prior to this patch, if a channel took too
>> > > long to be established, other channels could finish connecting first
>> > > and already start taking load. Now we're bounded by the
>> > > slowest-connecting channel.
>> > Yes, I think this should (hopefully!) be fine.
>> > 
>> > > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > > ---
>> > >   migration/multifd.c | 67 +++++++++++++++++++++++++--------------------
>> > >   1 file changed, 37 insertions(+), 30 deletions(-)
>> > > 
>> > > diff --git a/migration/multifd.c b/migration/multifd.c
>> > > index 1851206352..888ac8b05d 100644
>> > > --- a/migration/multifd.c
>> > > +++ b/migration/multifd.c
>> > > @@ -360,6 +360,11 @@ struct {
>> > >       MultiFDPages_t *pages;
>> > >       /* global number of generated multifd packets */
>> > >       uint64_t packet_num;
>> > > +    /*
>> > > +     * Synchronization point past which no more channels will be
>> > > +     * created.
>> > > +     */
>> > > +    QemuSemaphore channels_created;
>> > >       /* send channels ready */
>> > >       QemuSemaphore channels_ready;
>> > >       /*
>> > > @@ -561,6 +566,7 @@ void multifd_save_cleanup(void)
>> > >               error_free(local_err);
>> > >           }
>> > >       }
>> > > +    qemu_sem_destroy(&multifd_send_state->channels_created);
>> > >       qemu_sem_destroy(&multifd_send_state->channels_ready);
>> > >       g_free(multifd_send_state->params);
>> > >       multifd_send_state->params = NULL;
>> > > @@ -787,13 +793,6 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
>> > >       trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
>> > > 
>> > >       migrate_set_error(migrate_get_current(), err);
>> > > -    /*
>> > > -     * Error happen, mark multifd_send_thread status as 'quit' although it
>> > > -     * is not created, and then tell who pay attention to me.
>> > > -     */
>> > > -    p->quit = true;
>> > > -    qemu_sem_post(&multifd_send_state->channels_ready);
>> > > -    qemu_sem_post(&p->sem_sync);
>> > >       error_free(err);
>> > >   }
>> > > 
>> > > @@ -862,39 +861,37 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
>> > >       return true;
>> > >   }
>> > > 
>> > > -static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
>> > > -                                             QIOChannel *ioc, Error *err)
>> > > -{
>> > > -     migrate_set_error(migrate_get_current(), err);
>> > > -     /* Error happen, we need to tell who pay attention to me */
>> > > -     qemu_sem_post(&multifd_send_state->channels_ready);
>> > > -     qemu_sem_post(&p->sem_sync);
>> > > -     /*
>> > > -      * Although multifd_send_thread is not created, but main migration
>> > > -      * thread need to judge whether it is running, so we need to mark
>> > > -      * its status.
>> > > -      */
>> > > -     p->quit = true;
>> > > -     object_unref(OBJECT(ioc));
>> > > -     error_free(err);
>> > > -}
>> > > -
>> > >   static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
>> > >   {
>> > >       MultiFDSendParams *p = opaque;
>> > >       QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
>> > >       Error *local_err = NULL;
>> > > +    bool ret;
>> > > 
>> > >       trace_multifd_new_send_channel_async(p->id);
>> > > -    if (!qio_task_propagate_error(task, &local_err)) {
>> > > -        qio_channel_set_delay(ioc, false);
>> > > -        if (multifd_channel_connect(p, ioc, &local_err)) {
>> > > -            return;
>> > > -        }
>> > > +
>> > > +    if (qio_task_propagate_error(task, &local_err)) {
>> > > +        ret = false;
>> > > +        goto out;
>> > > +    }
>> > > +
>> > > +    qio_channel_set_delay(ioc, false);
>> > > +    ret = multifd_channel_connect(p, ioc, &local_err);
>> > > +
>> > > +out:
>> > > +    /*
>> > > +     * Here we're not interested whether creation succeeded, only that
>> > > +     * it happened at all.
>> > > +     */
>> > > +    qemu_sem_post(&multifd_send_state->channels_created);
>> > > +    if (ret) {
>> > > +        return;
>> > >       }
>> > > 
>> > >       trace_multifd_new_send_channel_async_error(p->id, local_err);
>> > > -    multifd_new_send_channel_cleanup(p, ioc, local_err);
>> > > +    migrate_set_error(migrate_get_current(), local_err);
>> > > +    object_unref(OBJECT(ioc));
>> > > +    error_free(local_err);
>> > >   }
>> > > 
>> > >   static void multifd_new_send_channel_create(gpointer opaque)
>> > > @@ -918,6 +915,7 @@ bool multifd_save_setup(void)
>> > >       multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>> > >       multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>> > >       multifd_send_state->pages = multifd_pages_init(page_count);
>> > > +    qemu_sem_init(&multifd_send_state->channels_created, 0);
>> > >       qemu_sem_init(&multifd_send_state->channels_ready, 0);
>> > >       qatomic_set(&multifd_send_state->exiting, 0);
>> > >       multifd_send_state->ops = multifd_ops[migrate_multifd_compression()];
>> > > @@ -953,6 +951,15 @@ bool multifd_save_setup(void)
>> > >           multifd_new_send_channel_create(p);
>> > >       }
>> > > 
>> > > +    /*
>> > > +     * Wait until channel creation has started for all channels. The
>> > > +     * creation can still fail, but no more channels will be created
>> > > +     * past this point.
>> > > +     */
>> > Let me double check with you here on the TLS use case.
>> > 
>> > IIUC we still can have more channels to be created if TLS is enabled: we
>> > notify the sem as long as the handshake thread is created, then the
>> > handshake thread can further create the tls-armed iochannel?

Oh, that's just a mistake on my part. We cannot allow "no more channels
will be created" above to be a lie.

I'll fix it for v2. I just found a way to stop calling
multifd_channel_connect() twice so now I can have the TLS thread posting
the semaphore at the appropriate place.

>> > However I
>> > think I get your point, and that is fine, because if that is the case, even
>> > though this loop can complete before tls further creates the final channel,
>> > we'll still see tls_thread_created==true and join() that tls thread first,
>> > then further we'll join() the next multifd thread even if a new one will
>> > pop up, or if it failed then nothing to join besides the tls thread.
>> > 
>> > I'm not sure whether Avihai has any input, I think this can be a good idea
>> > indeed.
>> 
>> Nothing special, my understanding of this is the same as yours.
>> This fix looks solid.
>> 
>> >    there's a dependency chain on the ordering if my above
>> > undertanding is correct; we may want to document this somewhere, perhaps
>> > right here on the chaining of threads and how we handle that?
>> 
>> I agree, this is subtle and may deserve a small note or hint.
>
> IMHO it'll be always better to be verbose on these than "not enough info".
>
> One thing I'd also like a comment is now the order is a must to firstly
> join tls threads then multifd threads, not vice versa, not anymore. We may
> want a comment above the two join()s there to state this hard requirement.
>
>> 
>> > 
>> > This may not allow a concurrent migrate_cancel to respond, but I assume
>> > this is good enough; the migrate_cancel request is indeed at least so far
>> > something I made up, but not a request from anyone.  We can leave that for
>> > later and fix the race / crash first.  This seems to be a complete fix from
>> > that regard.
>> > 
>> > > +    for (i = 0; i < thread_count; i++) {
>> > > +        qemu_sem_wait(&multifd_send_state->channels_created);
>> > > +    }
>> > > +
>> > >       for (i = 0; i < thread_count; i++) {
>> > >           MultiFDSendParams *p = &multifd_send_state->params[i];
>> > > 
>> > > --
>> > > 2.35.3
>> > > 
>> > One other note is I think this will also deserve a cc: stable? But then
>> > it'll mean all patch 3/4 will also need to copy stable to make Michael's
>> > life easier.
>> > 
>> > Let's also copy Dan when repost; after all he more or less owns the TLS
>> > part.
>> > 
>> > Thanks!
>> > 
>> > --
>> > Peter Xu
>> > 
>> 

