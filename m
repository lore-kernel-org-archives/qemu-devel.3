Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D5FDEE46
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzvm-0006X3-9g; Thu, 23 Apr 2026 15:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzvl-0006Wu-9P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:41:45 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzvj-0000fl-OR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:41:45 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7A655BD68;
 Thu, 23 Apr 2026 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776973302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUqfFhyIf5ggQI+LbE9DHstg/QqBm6/RUwAyyBhLmlI=;
 b=ajcSVeOQv2X92ywpSWEYgSgrQOkL337ZBVvd/hyzYIlJ0mJrigPz6dYR5fAHNQZzfsJWs0
 3gzVNZnREE2wx3iFn8tVyCtvraum32VMQSQfaBRcarXhw6gjlanfgNgjj6xDRGmJa9t1OI
 Vb/8NEzfnPbIgJZTtntGKkmaiWuFm4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776973302;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUqfFhyIf5ggQI+LbE9DHstg/QqBm6/RUwAyyBhLmlI=;
 b=aHsrPx0vrLoSmNOnYA59Piq4uo4jKYZaZ5lJKXLA7p00YdNxJGnU3IRaOROUKdCnCpI0u5
 2ZlaAK8UDk28SOBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776973301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUqfFhyIf5ggQI+LbE9DHstg/QqBm6/RUwAyyBhLmlI=;
 b=p6Y5eEh8B4utCGEKWxAbRvI6bcke5L7r5soVN1Llx5V+x48cB3tApHs4W7jeF0Aodvi/Vb
 j6TniDPIdDs2HDhe57ohl626BMry6578YKJ3HFgy4o1L/3rgyH7hQxhY8ctJtIxNWQ4a/3
 tK59PEfpUzZHy1nQQHmHU6SGexB5fj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776973301;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mUqfFhyIf5ggQI+LbE9DHstg/QqBm6/RUwAyyBhLmlI=;
 b=/Gn2JwPPscxGdbKvLlQYA0Sp5enxWyzhWO9yoZEldDOC7pz/IEPspIkUxB8mYo+4I9/bmz
 dktN5fzhSZXl5CCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87F08593A3;
 Thu, 23 Apr 2026 19:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gbZGFvV16mmNHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:41:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] migration/multifd: fix channel count TOCTOU race on
 cancel and retry
In-Reply-To: <aepokJ2N1w7fA2Ye@x1.local>
References: <20260422161202.34150-1-viking4@gmail.com>
 <20260422161202.34150-2-viking4@gmail.com> <87o6jaeig8.fsf@suse.de>
 <aepFf11lBgdXK6CB@x1.local> <87ik9hee95.fsf@suse.de>
 <aepokJ2N1w7fA2Ye@x1.local>
Date: Thu, 23 Apr 2026 16:41:39 -0300
Message-ID: <87fr4lea6k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[gmail.com,nongnu.org];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> On Thu, Apr 23, 2026 at 03:13:42PM -0300, Fabiano Rosas wrote:
>> Looking again at this argument I put (too many variables), I notice we
>> also have multifd_send_state->channels_ready and
>
> channels_ready seems to be special?  In busy systems I think it should
> normally always be less than the number of threads on sender side, because
> some of them will be busy.
>

Argh, sorry, I meant channels_created!

>> multifd_recv_state->count, both of which should contain the right number
>
> This one is used so far to just count how many channels are established on
> dest side.  Logically after setup phase it can be gone.  It's just not hurt
> to be available until cleanups.
>
>> of channels after multifd_send_setup() and migration_start_incoming(),
>> respectively. Maybe we could unify all of this into a single semaphore
>> used in both sides and take the semaphore count as number of
>> channels. @Peter, do you think it's worth it?
>
> My memory is reading counter from a sem isn't always reliable.  I always
> only use sem as thread-safety purpose primitives.
>
> So if I was correct on channels_ready above, then it may not apply on the
> idea to merge.  We're essentially trying to save one 8B for ->count.. and
> it can only be gone after it's finished its use (IOW, we still need it to
> work before recv side setup).
>
> Just leave them as-is?

