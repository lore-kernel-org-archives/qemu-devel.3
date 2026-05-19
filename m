Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DEECD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPEh6-0000j9-TE; Tue, 19 May 2026 03:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPEh1-0000ho-9L
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:16:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wPEgy-0003HO-8Q
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:16:42 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EFA905DB86;
 Tue, 19 May 2026 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779174996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaKsV5Wxlr3w/1/fTCisSKQYtZrEjP+pb8Vf6Tc02yQ=;
 b=LGwiL38p4wzbFd8W9MLk6OvYz8QhizlMuHg+Fy78X9F6yZB9vJx4yM5w5Yt8T1JRJV4GLU
 Si2ANsn0Yni7eKt7WDv3RAb62Y4STfvEvhPiMvRd0q9OU4V4ogPPoVlLTkGwBzpdt3Y8jr
 i3UcxmyNmW8bl7affuNuKR28v7QjHSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779174996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaKsV5Wxlr3w/1/fTCisSKQYtZrEjP+pb8Vf6Tc02yQ=;
 b=LtDTroktiUf5OaIwbwZdKyc06pLd38QUoWD+UcaYDFwZKKJUloSuEZHA5nwmpDJ+Rkvecb
 d1RAmefq9EvAsECw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XaKO39b2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x3ZoRQ3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779174995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaKsV5Wxlr3w/1/fTCisSKQYtZrEjP+pb8Vf6Tc02yQ=;
 b=XaKO39b2CGwkna1GeUqDsAK4S/gNqS6hI8+NsQMX8jTmjhwjSrKT7VTOvYwiFSqcxSout5
 +jFSeS3bFogl3ci/TSINcnobPI2EAqbYbbt2YOJdrW+oRnrvmHS0NqEGXwTk+10P3zH/ZH
 51o3JQQUfR8zbQvA9IC9K2qXcgHIsRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779174995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zaKsV5Wxlr3w/1/fTCisSKQYtZrEjP+pb8Vf6Tc02yQ=;
 b=x3ZoRQ3AKwUHnyXnw6W9TuApvRE7XDXraSWSSbFLc9dMvWWSmEfcvQJWsN8M+42WG0nFHO
 YReDy6PyBEiNaFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 919C4593A8;
 Tue, 19 May 2026 07:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ViXlGFMODGp9RAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 19 May 2026 07:16:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 7/8] migration/multifd: cache migrate_multifd_channels()
 in send/recv hot paths
In-Reply-To: <20260518110112.21395-8-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
 <20260518110112.21395-8-guobin@linux.alibaba.com>
Date: Tue, 19 May 2026 04:16:33 -0300
Message-ID: <87y0hf3m3y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EFA905DB86
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

Bin Guo <guobin@linux.alibaba.com> writes:

> multifd_send() and multifd_recv() are on the per-page-batch hot path
> of live migration.  Both functions call migrate_multifd_channels()
> multiple times (3-4 calls each) for modulo arithmetic in the
> round-robin channel selection loop.
>
> Each call goes through migrate_get_current() -> dereference
> MigrationState -> read parameters.multifd_channels.  While each
> individual call is cheap, these functions execute for every page
> batch during the entire migration, easily millions of times.
>
> Cache the return value in a local variable at function entry.  The
> channel count is fixed for the duration of a migration and cannot
> change mid-flight.
>
> For multifd_send(): 3 calls reduced to 1.
> For multifd_recv(): 4 calls reduced to 1.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/multifd.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 67ee9bdf5e..cc2fa90204 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -362,13 +362,15 @@ bool multifd_send(MultiFDSendData **send_data)
>      /* We wait here, until at least one channel is ready */
>      qemu_sem_wait(&multifd_send_state->channels_ready);
>  
> +    int thread_count = migrate_multifd_channels();
> +
>      /*
>       * next_channel can remain from a previous migration that was
>       * using more channels, so ensure it doesn't overflow if the
>       * limit is lower now.
>       */
> -    next_channel %= migrate_multifd_channels();
> -    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> +    next_channel %= thread_count;
> +    for (i = next_channel;; i = (i + 1) % thread_count) {
>          if (multifd_send_should_exit()) {
>              return false;
>          }
> @@ -378,7 +380,7 @@ bool multifd_send(MultiFDSendData **send_data)
>           * sender thread can clear it.
>           */
>          if (qatomic_read(&p->pending_job) == false) {
> -            next_channel = (i + 1) % migrate_multifd_channels();
> +            next_channel = (i + 1) % thread_count;
>              break;
>          }
>      }
> @@ -998,6 +1000,7 @@ bool multifd_recv(void)
>      int i;
>      static int next_recv_channel;
>      MultiFDRecvParams *p = NULL;
> +    int thread_count = migrate_multifd_channels();
>      MultiFDRecvData *data = multifd_recv_state->data;
>  
>      /*
> @@ -1005,8 +1008,8 @@ bool multifd_recv(void)
>       * using more channels, so ensure it doesn't overflow if the
>       * limit is lower now.
>       */
> -    next_recv_channel %= migrate_multifd_channels();
> -    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
> +    next_recv_channel %= thread_count;
> +    for (i = next_recv_channel;; i = (i + 1) % thread_count) {
>          if (multifd_recv_should_exit()) {
>              return false;
>          }
> @@ -1014,7 +1017,7 @@ bool multifd_recv(void)
>          p = &multifd_recv_state->params[i];
>  
>          if (qatomic_read(&p->pending_job) == false) {
> -            next_recv_channel = (i + 1) % migrate_multifd_channels();
> +            next_recv_channel = (i + 1) % thread_count;
>              break;
>          }
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

