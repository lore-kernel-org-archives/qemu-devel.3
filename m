Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B4ACD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 20:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP4T0-0006L6-La; Mon, 18 May 2026 16:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP4Sq-0006Kt-UG
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:21:24 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP4Sp-00025S-B1
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:21:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 213DD6415B;
 Mon, 18 May 2026 20:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779135681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMUppViUcKKPqkZWfZLrVNpr7IrypGtLB65nGRvigk8=;
 b=A1b72tZ4pOBhb6kYK48GHqNaC1pmPVlJ9+GD70hEdtcmJEIsxS4gcSCRaMsCZd5C+Iyoxo
 EMC0EXhES0V73Ic3DS8P7zdQtGblnto3v3PMVq+7Q809d5RaAjInXg7EiYBYWuu2nI9z7P
 0HzQ/vRRgBXbXRWnemW7TNilamo0OI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779135681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMUppViUcKKPqkZWfZLrVNpr7IrypGtLB65nGRvigk8=;
 b=zgQ2EeaStOiU8oX+0s4V4ZoAUiCzWqlCE9n6sxXaFL5trYZaCZgK6clDRB2zRkCeYjP7UT
 ew/ytQ9nL+4yGsAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779135680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMUppViUcKKPqkZWfZLrVNpr7IrypGtLB65nGRvigk8=;
 b=IeRndGp0RhgwvQWvEGbPqzm9Q0Q5ATIXmh9usKnu4f2kazdo1ejffNeO8b0bnwALi0RosM
 JtvPNMJ1ZImBUhkjqsGOLWQlBhaIylVc6suByQ2v/M1g+U/vT/R1pXEBsGDPIuVrX9H/5W
 8nm9EEunfRqgPQ30aYd44d2YFIKLmeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779135680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yMUppViUcKKPqkZWfZLrVNpr7IrypGtLB65nGRvigk8=;
 b=me0mlsvHqsc8l6AgIGTgNa1tbyDUdMXv3kVGEnE5b+J8o5WoyX8mV6NIHLNGpAiQjxKyox
 NBNrwRQikb1xo9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B74CB593A8;
 Mon, 18 May 2026 20:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3Cf6Ib90C2o2WQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 18 May 2026 20:21:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 6/8] migration/multifd: merge thread-join and cleanup
 loops in multifd_recv_cleanup
In-Reply-To: <20260518110112.21395-7-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
 <20260518110112.21395-7-guobin@linux.alibaba.com>
Date: Mon, 18 May 2026 17:21:17 -0300
Message-ID: <87bjec4gg2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 alibaba.com:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Bin Guo <guobin@linux.alibaba.com> writes:

> multifd_recv_cleanup() iterates over all receive channels twice:
> one loop to join threads and another to clean up each channel.

ok

> Unlike the send side where all threads must be signalled before any is
> joined (to avoid deadlock),

Not super relevant what the send side does. It's just a similar piece of
code, that's all.

> on the receive side the threads are already
> terminated by multifd_recv_terminate_threads().  Each join simply
> waits for an already-terminated thread, so the join and cleanup for
> channel i are independent of channel j, and the two loops can safely
> be merged into one.
>

We do really need to join all threads before proceeding. There's no
guarantee on the the order in which they'll terminate.

> This cuts the iteration count in half and improves locality: the
> thread's resources are freed immediately after its join.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/multifd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b3eef875cc..67ee9bdf5e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1153,15 +1153,14 @@ void multifd_recv_cleanup(void)
>          return;
>      }
>      multifd_recv_terminate_threads(NULL);
> +
>      for (i = 0; i < migrate_multifd_channels(); i++) {
>          MultiFDRecvParams *p = &multifd_recv_state->params[i];
>  
>          if (p->thread_created) {
>              qemu_thread_join(&p->thread);
>          }
> -    }
> -    for (i = 0; i < migrate_multifd_channels(); i++) {
> -        multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
> +        multifd_recv_cleanup_channel(p);
>      }
>      multifd_recv_cleanup_state();
>  }

