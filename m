Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF8FED3CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 14:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGHK8-0005in-Ms; Fri, 24 Apr 2026 10:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wGHK5-0005iX-HP
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:16:01 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wGHK3-0002Bj-BZ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 10:16:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA86D6A8AB;
 Fri, 24 Apr 2026 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777040154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eDwuoc+DPQiibUPFib60geE1BY2swYJuSCgB4hpAE=;
 b=PYrDvbynOX0ZqwC/LCdSKX37ArqL41mrS9foYuUuDO+Y4zauL05nMKzyrXDGzfYQ2D2nAz
 M+BOxHHjdiIrkOWtylzT3tWzt9A/FR0w+HTNaQPAKzyW8WWPSLtEi20+5rfnBdjaqjjwyy
 Chbxy+GIcEsHUdsTzY7OlzeYZCm7KVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777040154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eDwuoc+DPQiibUPFib60geE1BY2swYJuSCgB4hpAE=;
 b=tMLPG//qbVFd2Z6TnMnqP05sw8hzmNwZ+VGYcycvjua4NgEDNpMSAxRX25dbIHBzKwzx/i
 TA7BCucQS0F5H0Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PYrDvbyn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tMLPG//q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777040154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eDwuoc+DPQiibUPFib60geE1BY2swYJuSCgB4hpAE=;
 b=PYrDvbynOX0ZqwC/LCdSKX37ArqL41mrS9foYuUuDO+Y4zauL05nMKzyrXDGzfYQ2D2nAz
 M+BOxHHjdiIrkOWtylzT3tWzt9A/FR0w+HTNaQPAKzyW8WWPSLtEi20+5rfnBdjaqjjwyy
 Chbxy+GIcEsHUdsTzY7OlzeYZCm7KVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777040154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z+eDwuoc+DPQiibUPFib60geE1BY2swYJuSCgB4hpAE=;
 b=tMLPG//qbVFd2Z6TnMnqP05sw8hzmNwZ+VGYcycvjua4NgEDNpMSAxRX25dbIHBzKwzx/i
 TA7BCucQS0F5H0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67E5F593A6;
 Fri, 24 Apr 2026 14:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jiuMDhp762k+ZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Apr 2026 14:15:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
In-Reply-To: <aet1zMrfXzShXeuS@x1.local>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com> <87o6jaeig8.fsf@suse.de>
 <aepFf11lBgdXK6CB@x1.local> <87ik9hee95.fsf@suse.de>
 <aepokJ2N1w7fA2Ye@x1.local> <87fr4lea6k.fsf@suse.de>
 <aet1zMrfXzShXeuS@x1.local>
Date: Fri, 24 Apr 2026 11:15:52 -0300
Message-ID: <87cxzoe95z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: CA86D6A8AB
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Thu, Apr 23, 2026 at 04:41:39PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Apr 23, 2026 at 03:13:42PM -0300, Fabiano Rosas wrote:
>> >> Looking again at this argument I put (too many variables), I notice we
>> >> also have multifd_send_state->channels_ready and
>> >
>> > channels_ready seems to be special?  In busy systems I think it should
>> > normally always be less than the number of threads on sender side, because
>> > some of them will be busy.
>> >
>> 
>> Argh, sorry, I meant channels_created!
>
> Yeah, this one looks like a slight duplicate over channels_ready.  However
> it's still slightly different in that it's also used in failure path of
> channel establishments.
>

I'm not suggesting to merge channels_ready and channels_created. I'm
saying that channels_created == migrate_multifd_channels(). 

> IOW, multifd_send_channel_created() can be invoked in failure paths where
> multifd_channel_connect() won't.
>

Good, we always want to iterate over the number of created channels,
right? But maybe using the semaphore count is really not a good idea,
let's leave it.

> We could still consider reusing channels_ready, but it will introduce a few
> complexities, namely:
>
> - The name becomes slightly ambiguous: we may need to listen to
>   channels_ready even if the channel creation failed..  if to be fair,
>   channels_created also implies a success.. s I assume not a major concern.
>
> - Multifd sender side relies on channels_ready to be posted by default when
>   migration just starts (says, "all channels are free to use").  It means
>   if we consume that sem here waiting for channels, then we need to kick
>   all threads once more just to give it back, hence one more roundtrip of
>   sem notifies.  We also need a small touchup in send thread to allow that
>   to happen; patch attached at the end to show what I mean (not tested at
>   all, please treat it as pesudo code.. so it's definitely not a complete
>   patch).
>
> I think we can still leave it there to make the establishment path simple.
>
> What's your take?
>
> ===8<===
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 035cb70f7b..570ff8c017 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -736,16 +736,9 @@ static void *multifd_send_thread(void *opaque)
>               * multifd_send().
>               */
>              qatomic_store_release(&p->pending_job, false);
> -        } else {
> +        } else if (qatomic_read(&p->pending_sync)) {
>              MultiFDSyncReq req = qatomic_read(&p->pending_sync);
>  
> -            /*
> -             * If not a normal job, must be a sync request.  Note that
> -             * pending_sync is a standalone flag (unlike pending_job), so
> -             * it doesn't require explicit memory barriers.
> -             */
> -            assert(req != MULTIFD_SYNC_NONE);
> -
>              /* Only push the SYNC message if it involves a remote sync */
>              if (req == MULTIFD_SYNC_ALL) {
>                  p->flags = MULTIFD_FLAG_SYNC;
> @@ -964,7 +957,14 @@ bool multifd_send_setup(void)
>       * past this point.
>       */
>      for (i = 0; i < thread_count; i++) {
> -        qemu_sem_wait(&multifd_send_state->channels_created);
> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> +
> +        qemu_sem_wait(&multifd_send_state->channels_ready);
> +        /*
> +         * Re-kick the thread to recover the channels_ready event we
> +         * consumed for detecting channel establish event.
> +         */
> +        qemu_sem_post(&p->sem);
>      }
>  
>      if (ret) {

I think it's risky.

