Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D78BCA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk681-00047Y-KZ; Fri, 30 Aug 2024 14:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk67z-00046z-DW
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:13:43 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sk67x-0007Ao-Jc
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:13:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F24821A23;
 Fri, 30 Aug 2024 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725041619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibKzEZd0/cFQCTbMC+ca4LcUB2x3Odc5CYBZNx3T6w8=;
 b=BjKLMsw6q/oiVroPSz6ntE2c+a+H723s6/NV6QlbJR558NAOqjRjk1K/c3C6dPvTXmouza
 UMVXznBvEtNvW8ApyENPchs1FbWu/YCDPgVwd0SwiazqugKavuRT99uYhUH7uD9opl7gLo
 hyCwKPtcVd6PRFTzr3szgT+C4uiyjfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725041619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibKzEZd0/cFQCTbMC+ca4LcUB2x3Odc5CYBZNx3T6w8=;
 b=OeBp3aBaiRCAsusJtyKtNKjdUkcxFoWiU8dc59vcW5yFOnTVes/+vpol/ERPqwh74G30Sx
 ke25D/wGCB5jUWBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725041619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibKzEZd0/cFQCTbMC+ca4LcUB2x3Odc5CYBZNx3T6w8=;
 b=BjKLMsw6q/oiVroPSz6ntE2c+a+H723s6/NV6QlbJR558NAOqjRjk1K/c3C6dPvTXmouza
 UMVXznBvEtNvW8ApyENPchs1FbWu/YCDPgVwd0SwiazqugKavuRT99uYhUH7uD9opl7gLo
 hyCwKPtcVd6PRFTzr3szgT+C4uiyjfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725041619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ibKzEZd0/cFQCTbMC+ca4LcUB2x3Odc5CYBZNx3T6w8=;
 b=OeBp3aBaiRCAsusJtyKtNKjdUkcxFoWiU8dc59vcW5yFOnTVes/+vpol/ERPqwh74G30Sx
 ke25D/wGCB5jUWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89EBB13A3D;
 Fri, 30 Aug 2024 18:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5PAWFNIL0mZQKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 30 Aug 2024 18:13:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/17] migration/multifd: Convert
 multifd_send()::next_channel to atomic
In-Reply-To: <76dc3ad69fa457fd1e358ad3de874474f9f64716.1724701542.git.maciej.szmigiero@oracle.com>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <76dc3ad69fa457fd1e358ad3de874474f9f64716.1724701542.git.maciej.szmigiero@oracle.com>
Date: Fri, 30 Aug 2024 15:13:36 -0300
Message-ID: <875xrhop4f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This is necessary for multifd_send() to be able to be called
> from multiple threads.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  migration/multifd.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index d5a8e5a9c9b5..b25789dde0b3 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -343,26 +343,38 @@ bool multifd_send(MultiFDSendData **send_data)
>          return false;
>      }
>  
> -    /* We wait here, until at least one channel is ready */
> -    qemu_sem_wait(&multifd_send_state->channels_ready);
> -
>      /*
>       * next_channel can remain from a previous migration that was
>       * using more channels, so ensure it doesn't overflow if the
>       * limit is lower now.
>       */
> -    next_channel %= migrate_multifd_channels();
> -    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> +    i = qatomic_load_acquire(&next_channel);
> +    if (unlikely(i >= migrate_multifd_channels())) {
> +        qatomic_cmpxchg(&next_channel, i, 0);
> +    }

Do we still need this? It seems not, because the mod down below would
already truncate to a value less than the number of channels. We don't
need it to start at 0 always, the channels are equivalent.

> +
> +    /* We wait here, until at least one channel is ready */
> +    qemu_sem_wait(&multifd_send_state->channels_ready);
> +
> +    while (true) {
> +        int i_next;
> +
>          if (multifd_send_should_exit()) {
>              return false;
>          }
> +
> +        i = qatomic_load_acquire(&next_channel);
> +        i_next = (i + 1) % migrate_multifd_channels();
> +        if (qatomic_cmpxchg(&next_channel, i, i_next) != i) {
> +            continue;
> +        }

Say channel 'i' is the only one that's idle. What's stopping the other
thread(s) to race at this point and loop around to the same index?

> +
>          p = &multifd_send_state->params[i];
>          /*
>           * Lockless read to p->pending_job is safe, because only multifd
>           * sender thread can clear it.
>           */
>          if (qatomic_read(&p->pending_job) == false) {

With the cmpxchg your other patch adds here, then the race I mentioned
above should be harmless. But we'd need to bring that code into this
patch.

> -            next_channel = (i + 1) % migrate_multifd_channels();
>              break;
>          }
>      }

