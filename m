Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2750AC47DB3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 20:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVH58-00055i-1U; Wed, 31 Jan 2024 15:21:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVH56-00055X-PP
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:21:13 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVH54-0007PM-UW
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 15:21:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B8271F80A;
 Wed, 31 Jan 2024 20:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706732469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mufilxLEwI/4rmASPpS5UMpzQ7rjJVZQag79p8JkgXA=;
 b=CkzMdds/F5ILdTe/EXgeBCLrQFFL4iyW4MQOUPuqd6PmMev5J3nofFT+RAPmMlsXiHHCJx
 vcUeuBxaq8gLLU0f6Um/0x/aPbrcsO0+qdtVw0eMrDbfxiNCbW2gwx96F+srB+MG0t1ZdJ
 qhR3X38KG7umpONdFAE6fqmGsUOeqtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706732469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mufilxLEwI/4rmASPpS5UMpzQ7rjJVZQag79p8JkgXA=;
 b=rvEuTq8tBumuPM66/mDBLykbl2GshJRP/IuS6za9X7bdQqJYBeRZ8Tmryp7fqueMUR0nBf
 Lualj28B22AtULDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706732469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mufilxLEwI/4rmASPpS5UMpzQ7rjJVZQag79p8JkgXA=;
 b=CkzMdds/F5ILdTe/EXgeBCLrQFFL4iyW4MQOUPuqd6PmMev5J3nofFT+RAPmMlsXiHHCJx
 vcUeuBxaq8gLLU0f6Um/0x/aPbrcsO0+qdtVw0eMrDbfxiNCbW2gwx96F+srB+MG0t1ZdJ
 qhR3X38KG7umpONdFAE6fqmGsUOeqtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706732469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mufilxLEwI/4rmASPpS5UMpzQ7rjJVZQag79p8JkgXA=;
 b=rvEuTq8tBumuPM66/mDBLykbl2GshJRP/IuS6za9X7bdQqJYBeRZ8Tmryp7fqueMUR0nBf
 Lualj28B22AtULDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D901B139B1;
 Wed, 31 Jan 2024 20:21:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id knCHJ7SrumX0YAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 20:21:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>, Prasad Pandit
 <ppandit@redhat.com>, peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 07/14] migration/multifd: Simplify locking in sender thread
In-Reply-To: <20240131103111.306523-8-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-8-peterx@redhat.com>
Date: Wed, 31 Jan 2024 17:21:06 -0300
Message-ID: <87o7d1jlu5.fsf@suse.de>
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
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> The sender thread will yield the p->mutex before IO starts, trying to not
> block the requester thread.  This may be unnecessary lock optimizations,
> because the requester can already read pending_job safely even without the
> lock, because the requester is currently the only one who can assign a
> task.

What about the coroutine yield at qio_channel_writev_full_all()? Is it
safe from yield while holding a lock? Could the main loop dispatch the
cleanup function, it calls join on the multifd thread and it deadlocks?

>
> Drop that lock complication on both sides:
>
>   (1) in the sender thread, always take the mutex until job done
>   (2) in the requester thread, check pending_job clear lockless
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/multifd.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 6a4863edd2..4dc5af0a15 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -429,7 +429,9 @@ static int multifd_send_pages(void)
>          return -1;
>      }
>  
> +    /* We wait here, until at least one channel is ready */
>      qemu_sem_wait(&multifd_send_state->channels_ready);
> +
>      /*
>       * next_channel can remain from a previous migration that was
>       * using more channels, so ensure it doesn't overflow if the
> @@ -441,17 +443,26 @@ static int multifd_send_pages(void)
>              return -1;
>          }
>          p = &multifd_send_state->params[i];
> -        qemu_mutex_lock(&p->mutex);
> +        /*
> +         * Lockless read to p->pending_job is safe, because only multifd
> +         * sender thread can clear it.
> +         */
>          if (!p->pending_job) {

The worst it could happen is we read at the same time the thread is
clearing it and we loop to the next channel. So it doesn't need to be
atomic either.

> -            p->pending_job = true;
>              next_channel = (i + 1) % migrate_multifd_channels();
>              break;
>          }
> -        qemu_mutex_unlock(&p->mutex);
>      }
> +
> +    qemu_mutex_lock(&p->mutex);

What data this lock protects now? Everything below here only happens
after this thread sees pending_job==false. It seems we would only need a
barrier on the multifd thread to make sure p->pending_job=false is
ordered after everything.

Even for the "sync" case, it appears the lock is not needed as well?

We might need to remove p->running first and move the kick from
multifd_send_terminate_threads() into multifd_save_cleanup() like I
suggested, but it seems like we could remove this lock.

Which would make sense, because there's nothing another thread would
want to do with a channel's MultiFDSendParams unless the channel is idle
waiting for work.

> +    /*
> +     * Double check on pending_job==false with the lock.  In the future if
> +     * we can have >1 requester thread, we can replace this with a "goto
> +     * retry", but that is for later.
> +     */
> +    assert(p->pending_job == false);
> +    p->pending_job = true;
>      assert(!p->pages->num);
>      assert(!p->pages->block);
> -
>      p->packet_num = multifd_send_state->packet_num++;

I noticed this line cannot be here. If the channel thread takes long to
wakeup, the "sync" code will increment once more and overwrite this
field. This and the identical line at multifd_send_sync_main() should go
into multifd_send_fill_packet() I think.

>      multifd_send_state->pages = p->pages;
>      p->pages = pages;
> @@ -704,8 +715,6 @@ static void *multifd_send_thread(void *opaque)
>              multifd_send_fill_packet(p);
>              p->num_packets++;
>              p->total_normal_pages += pages->num;
> -            qemu_mutex_unlock(&p->mutex);
> -
>              trace_multifd_send(p->id, packet_num, pages->num, p->flags,
>                                 p->next_packet_size);
>  
> @@ -725,6 +734,7 @@ static void *multifd_send_thread(void *opaque)
>              ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
>                                                0, p->write_flags, &local_err);
>              if (ret != 0) {
> +                qemu_mutex_unlock(&p->mutex);
>                  break;
>              }
>  
> @@ -733,7 +743,6 @@ static void *multifd_send_thread(void *opaque)
>  
>              multifd_pages_reset(p->pages);
>              p->next_packet_size = 0;
> -            qemu_mutex_lock(&p->mutex);
>              p->pending_job = false;
>              qemu_mutex_unlock(&p->mutex);
>          } else if (p->pending_sync) {

