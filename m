Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F099DCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 22:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyeHf-0007xt-4Z; Tue, 16 Sep 2025 18:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyeHd-0007xP-HS
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 18:36:21 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uyeHA-0003kC-6m
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 18:36:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 174E61F387;
 Tue, 16 Sep 2025 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758062149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+jpeYJY9rzph24f0SkFQROltuYqD3ltuYX9aCBRffE=;
 b=zoF2PAkUm3W045CLq/0gJ4FItXHY3woUH+ph5JFa7bWWSb8UiFrAroncMSC+kitgt5GHgA
 x7sKpoDR7LmmrB2kxc/S9as2LQF20GXuPKoETLXFRLhbCRI6CJSRPtyr1hysgQGzN0EqTy
 Pbcen9MTWVgKgJw3jNH5FKAWMGxwPYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758062149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+jpeYJY9rzph24f0SkFQROltuYqD3ltuYX9aCBRffE=;
 b=a937muGBzwae4E4TQXYZ1o+PHMt3WRz7Z4KdMc1kPkTbvjktjYRNKVhGlDi0QRcMCvUG5f
 SbdMnsra2L5/sdCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zoF2PAkU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a937muGB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758062149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+jpeYJY9rzph24f0SkFQROltuYqD3ltuYX9aCBRffE=;
 b=zoF2PAkUm3W045CLq/0gJ4FItXHY3woUH+ph5JFa7bWWSb8UiFrAroncMSC+kitgt5GHgA
 x7sKpoDR7LmmrB2kxc/S9as2LQF20GXuPKoETLXFRLhbCRI6CJSRPtyr1hysgQGzN0EqTy
 Pbcen9MTWVgKgJw3jNH5FKAWMGxwPYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758062149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y+jpeYJY9rzph24f0SkFQROltuYqD3ltuYX9aCBRffE=;
 b=a937muGBzwae4E4TQXYZ1o+PHMt3WRz7Z4KdMc1kPkTbvjktjYRNKVhGlDi0QRcMCvUG5f
 SbdMnsra2L5/sdCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D95713A63;
 Tue, 16 Sep 2025 22:35:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJBiDkTmyWg3YAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 16 Sep 2025 22:35:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 4/9] migration/rdma: Change io_create_watch() to
 return immediately
In-Reply-To: <20250827205949.364606-5-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-5-peterx@redhat.com>
Date: Tue, 16 Sep 2025 19:35:45 -0300
Message-ID: <87ms6uvxdq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 174E61F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> The old RDMA's io_create_watch() isn't really doing much work anyway.  For
> G_IO_OUT, it already does return immediately.  For G_IO_IN, it will try to
> detect some RDMA context length however normally nobody will be able to set
> it at all.
>
> Simplify the code so that RDMA iochannels simply always rely on synchronous
> reads and writes.  It is highly likely what 6ddd2d76ca6f86f was talking
> about, that the async model isn't really working well.
>
> This helps because this is almost the only dependency that the migration
> core would need a coroutine for rdma channels.
>

I don't understand this. How does this code require a coroutine? Isn't
the io_watch exactly the strategy used when there is no coroutine?

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/rdma.c | 69 +++---------------------------------------------
>  1 file changed, 3 insertions(+), 66 deletions(-)
>
> diff --git a/migration/rdma.c b/migration/rdma.c
> index ed4e20b988..bcd7aae2f2 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2789,56 +2789,14 @@ static gboolean
>  qio_channel_rdma_source_prepare(GSource *source,
>                                  gint *timeout)
>  {
> -    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> -    RDMAContext *rdma;
> -    GIOCondition cond = 0;
>      *timeout = -1;
> -
> -    RCU_READ_LOCK_GUARD();
> -    if (rsource->condition == G_IO_IN) {
> -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> -    } else {
> -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> -    }
> -
> -    if (!rdma) {
> -        error_report("RDMAContext is NULL when prepare Gsource");
> -        return FALSE;
> -    }
> -
> -    if (rdma->wr_data[0].control_len) {
> -        cond |= G_IO_IN;
> -    }
> -    cond |= G_IO_OUT;
> -
> -    return cond & rsource->condition;
> +    return TRUE;
>  }
>  
>  static gboolean
>  qio_channel_rdma_source_check(GSource *source)
>  {
> -    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> -    RDMAContext *rdma;
> -    GIOCondition cond = 0;
> -
> -    RCU_READ_LOCK_GUARD();
> -    if (rsource->condition == G_IO_IN) {
> -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> -    } else {
> -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> -    }
> -
> -    if (!rdma) {
> -        error_report("RDMAContext is NULL when check Gsource");
> -        return FALSE;
> -    }
> -
> -    if (rdma->wr_data[0].control_len) {
> -        cond |= G_IO_IN;
> -    }
> -    cond |= G_IO_OUT;
> -
> -    return cond & rsource->condition;
> +    return TRUE;

These are fine if we want the source to run as soon as possible, I
think. But then...

>  }
>  
>  static gboolean
> @@ -2848,29 +2806,8 @@ qio_channel_rdma_source_dispatch(GSource *source,
>  {
>      QIOChannelFunc func = (QIOChannelFunc)callback;
>      QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
> -    RDMAContext *rdma;
> -    GIOCondition cond = 0;
> -
> -    RCU_READ_LOCK_GUARD();
> -    if (rsource->condition == G_IO_IN) {
> -        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
> -    } else {
> -        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
> -    }
> -
> -    if (!rdma) {
> -        error_report("RDMAContext is NULL when dispatch Gsource");
> -        return FALSE;
> -    }
> -
> -    if (rdma->wr_data[0].control_len) {
> -        cond |= G_IO_IN;
> -    }
> -    cond |= G_IO_OUT;
>  
> -    return (*func)(QIO_CHANNEL(rsource->rioc),
> -                   (cond & rsource->condition),
> -                   user_data);
> +    return (*func)(QIO_CHANNEL(rsource->rioc), rsource->condition, user_data);

No idea who even calls g_source_set_callback() in this case. What is func?

>  }
>  
>  static void

