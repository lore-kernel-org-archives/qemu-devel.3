Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE2CFA1FFF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 22:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFg68-0005az-As; Wed, 22 Apr 2026 18:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFg5z-0005aI-U3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:31:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFg5v-0001SR-NG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 18:30:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD31F5BD4E;
 Wed, 22 Apr 2026 22:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776897054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67RCmrHS8uW9VUvZXoJJb23xsAy8Em325FT52CV/J+g=;
 b=VpglabpStsDzMl542LTSRptkcETWvQS0oCUaN2dYOxI9/fgqHHmAE7nzBDfl3SrQJPwt4+
 sJjMKZ7QHGzKxlZvbHwI/T4sW6a3sLU7a1abtORz/GyfUgA+Y7kgbq94YH64JaPRXa8BBK
 sHMbLQ2t9hhokQt1Ga7H6lb24YbCEUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776897054;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67RCmrHS8uW9VUvZXoJJb23xsAy8Em325FT52CV/J+g=;
 b=OG0fFvlMRWNqkc4/SIipH8lnFR1kE8rSn3tYlPy+1CcLTA71CIxGHd86ChKAGZ4DdnBqug
 KYnqeAUSfYviF2Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="LRLz/42v";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7b0Vznv3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776897053; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67RCmrHS8uW9VUvZXoJJb23xsAy8Em325FT52CV/J+g=;
 b=LRLz/42vXIa1d78zIknpF7amw3jylqvuPNdcCJyMLPJzeoYUaFP6umSr8hlNrh+OCYMIq9
 zwXn1jllRu+1ggNyiX5pSp5HJ2k8nhOva9ZIN2kp2wEe3l/t4dRFlaZbiig8H2nqPpaeDY
 Rw0pmfX2UYv5AFkJJsoERskb1Zuw6hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776897053;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67RCmrHS8uW9VUvZXoJJb23xsAy8Em325FT52CV/J+g=;
 b=7b0Vznv3ppmK8kXfvFHVZWW6bSQ9dvOzw7G27ELZc1NT+Vz/l5yjqfO9AZEZQUzkUrnc3O
 U9kcZsh6NdBjUhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 500D6593AF;
 Wed, 22 Apr 2026 22:30:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2YOwCB1M6Wm3NgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Apr 2026 22:30:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Cc: Trieu Huynh <vikingtc4@gmail.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
In-Reply-To: <20260422161202.34150-2-viking4@gmail.com>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com>
Date: Wed, 22 Apr 2026 19:30:47 -0300
Message-ID: <87o6jaeig8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DD31F5BD4E
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Trieu Huynh <vikingtc4@gmail.com> writes:

> From: Trieu Huynh <vikingtc4@gmail.com>
>
> When a multifd migration is cancelled and the user changes
> multifd-channels via QMP before cleanup completes, the shutdown and
> termination loops re-read migrate_multifd_channels() which now returns
> the new value.

Right, so this is because migrate-set-parameters is allowed to set
so-called (by me) runtime options, such as downtime-limit, which means
we cannot block it while migration_is_running() = true as we do for
migrate-set-capabilities. The "right" fix here is something I discussed
with Peter a while back, which is to write a whitelist of commands that
we're certain have no negative effect during migration runtime (or are
simply required as part of normal functioning) and block everything else
behind a migration_is_running() check.

Still, I think we can consider this patch in isolation for now... Let me
continue looking.

> This causes the loops to iterate over, for instance
> fewer channels than were created, leaving yank functions of the
> abandoned channels still registered when yank_unregister_instance()
> is called, triggering an abort:
>   qemu-system-x86_64: ../util/yank.c:107: yank_unregister_instance:
>   Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
>   Aborted (core dumped)

Ah yes, the assert machine doing it's job as usual.

>
> Fix by storing the channel count at setup time and using that frozen
> value in all subsequent loops. The live parameter
> migrate_multifd_channels() is now only read once during setup, ensuring
> teardown always operates on the exact set of channels that were created.
>

Take a look at multifd_send(), there's some shenanigans there as well
regarding changing the number of channels on the fly. Could we drop that
logic with this patch?

> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  migration/multifd.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Hmm, I see 20 instances of migrate_multifd_channels() being used in
multifd.c. It seems you missed some.

>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 035cb70f7b..69c8f6747b 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -75,6 +75,8 @@ struct {
>      int exiting;
>      /* multifd ops */
>      const MultiFDMethods *ops;
> +    /* number of channels created (fixed at setup) */
> +    int channel_num;

Reads like "channel number" to me. As in "the number of the
channel". I'd use n_channels, num_channels or channels_num.

Naming aside... we'll then have three variables representing number of
multifd channels:

s->parameters.multifd_channels
multifd_send_state->channel_num
multifd_recv_state->channel_num

(or just 2 and inconsistent representation between send/recv, which is
worse IMO)

Let's go back to the core issue I described at the start, could we
instead check at migrate_params_test_apply() whether migration is
running and return an error when trying to change multifd channels?

There might be issues with current_migration going away while QMP is
still dispatching, but I'm not sure it will be productive if we start to
solve locally the troubles caused by each parameter when changed at
migration runtime.

>  } *multifd_send_state;
>  
>  struct {
> @@ -483,7 +485,7 @@ static void multifd_send_terminate_threads(void)
>       * Firstly, kick all threads out; no matter whether they are just idle,
>       * or blocked in an IO system call.
>       */
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < multifd_send_state->channel_num; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          qemu_sem_post(&p->sem);
> @@ -495,7 +497,7 @@ static void multifd_send_terminate_threads(void)
>      /*
>       * Finally recycle all the threads.
>       */
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < multifd_send_state->channel_num; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          if (p->tls_thread_created) {
> @@ -577,7 +579,7 @@ void multifd_send_shutdown(void)
>  
>      multifd_send_terminate_threads();
>  
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < multifd_send_state->channel_num; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>          Error *local_err = NULL;
>  
> @@ -615,7 +617,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
>  
>      flush_zero_copy = migrate_zero_copy_send();
>  
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < multifd_send_state->channel_num; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          if (multifd_send_should_exit()) {
> @@ -632,7 +634,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
>          qatomic_set(&p->pending_sync, req);
>          qemu_sem_post(&p->sem);
>      }
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> +    for (i = 0; i < multifd_send_state->channel_num; i++) {
>          MultiFDSendParams *p = &multifd_send_state->params[i];
>  
>          if (multifd_send_should_exit()) {
> @@ -926,6 +928,7 @@ bool multifd_send_setup(void)
>      thread_count = migrate_multifd_channels();
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> +    multifd_send_state->channel_num = thread_count;
>      qemu_mutex_init(&multifd_send_state->multifd_send_mutex);
>      qemu_sem_init(&multifd_send_state->channels_created, 0);
>      qemu_sem_init(&multifd_send_state->channels_ready, 0);

