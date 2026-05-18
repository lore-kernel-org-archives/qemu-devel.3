Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4F8CD4F4A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 19:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP3sh-0007SM-0u; Mon, 18 May 2026 15:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP3sa-0007Rp-K1
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:43:57 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wP3sX-0004a1-4h
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:43:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C47F55D3F6;
 Mon, 18 May 2026 19:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779133429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xH3wvOeyoSc+XFE2NFsVZqIoCEwfc+nFmxBljxxZdI=;
 b=FIBNiwHx5uM57zpMPfRwggHm8Qg7p4k1CmUqyYxc5eTORZQtWm9ycCIBZFMRhz+asdRSoI
 Pgl+zSM/4wRPgZhgPC0ZvIN6cRZXjN6lTOUboPgXDkD/HndcR7lUWGU+7C3mBLM43KSNPu
 sbRZOcFNRvjU5nU5sjhq4ND2+s/KvXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779133429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xH3wvOeyoSc+XFE2NFsVZqIoCEwfc+nFmxBljxxZdI=;
 b=AjZtMbFd0JEkiCpASZ29CbjYjpOGX8oZYs8PD3G6kPKKxhneo7lhApBWYBCggr4BL0N7XO
 xymcaVF645czmLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779133429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xH3wvOeyoSc+XFE2NFsVZqIoCEwfc+nFmxBljxxZdI=;
 b=FIBNiwHx5uM57zpMPfRwggHm8Qg7p4k1CmUqyYxc5eTORZQtWm9ycCIBZFMRhz+asdRSoI
 Pgl+zSM/4wRPgZhgPC0ZvIN6cRZXjN6lTOUboPgXDkD/HndcR7lUWGU+7C3mBLM43KSNPu
 sbRZOcFNRvjU5nU5sjhq4ND2+s/KvXU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779133429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xH3wvOeyoSc+XFE2NFsVZqIoCEwfc+nFmxBljxxZdI=;
 b=AjZtMbFd0JEkiCpASZ29CbjYjpOGX8oZYs8PD3G6kPKKxhneo7lhApBWYBCggr4BL0N7XO
 xymcaVF645czmLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64262593A8;
 Mon, 18 May 2026 19:43:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L+aIDfVrC2qzNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 18 May 2026 19:43:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH 5/8] migration/multifd: fix off-by-one in recv channel
 ID validation
In-Reply-To: <20260518110112.21395-6-guobin@linux.alibaba.com>
References: <20260518110112.21395-1-guobin@linux.alibaba.com>
 <20260518110112.21395-6-guobin@linux.alibaba.com>
Date: Mon, 18 May 2026 16:43:33 -0300
Message-ID: <87ecj84i6y.fsf@suse.de>
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
 suse.de:email]
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

> multifd_recv_initial_packet() validates the channel ID received from
> the source against the configured number of channels. The current
> check uses '>' which allows msg.id == N to pass through. This ID is
> then used to index multifd_recv_state->params[msg.id], which was
> allocated with g_new0(MultiFDRecvParams, N) -- an out-of-bounds
> access.
>
> A malicious or buggy source could send id == N and cause heap
> corruption on the destination.
>
> Fix by changing '>' to '>='. Also fix the error message to say
> "exceeds channel count" for accuracy.
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>  migration/multifd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 035cb70f7b..b3eef875cc 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -210,9 +210,9 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>          return -1;
>      }
>  
> -    if (msg.id > migrate_multifd_channels()) {
> -        error_setg(errp, "multifd: received channel id %u is greater than "
> -                   "number of channels %u", msg.id, migrate_multifd_channels());
> +    if (msg.id >= migrate_multifd_channels()) {
> +        error_setg(errp, "multifd: received channel id %u exceeds "
> +                   "channel count %u", msg.id, migrate_multifd_channels());
>          return -1;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

