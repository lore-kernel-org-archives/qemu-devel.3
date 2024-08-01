Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAA4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 19:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZbFl-0003Kk-4e; Thu, 01 Aug 2024 15:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sZbFh-0003Jk-TU; Thu, 01 Aug 2024 15:14:18 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sZbFg-0002gq-4e; Thu, 01 Aug 2024 15:14:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2B661F889;
 Thu,  1 Aug 2024 19:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722539653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YepaHKW/K1SqTvoDvWg4jGwZ3ZL2sNO3kD7h9wwLUlY=;
 b=Ri2Pq8FO2u/aBapLjjxiffAJ6KZIJvSx+kvBAbCTBSXdA8+2zbw+QplLg0CksqI82onsvb
 nUZwmErJ+vc8oVjwlMX8rhmwFmvkTuaVlfOzfZk1X4X0YFpLfTmxNNd4X0ycMOY1UN6iQL
 9MU/qbGAMFjShKLw4FDJr/H+hSnLjUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722539653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YepaHKW/K1SqTvoDvWg4jGwZ3ZL2sNO3kD7h9wwLUlY=;
 b=Jg5Id+W1boh5cZt9LwCusNy1D75q7LAuwyPAxAr3eHGqO1NahjQ0iLtUavytPJAdn3m+Gn
 s0BWHvE/qZV4lICw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=adsEUCuR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BovfYDzx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722539652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YepaHKW/K1SqTvoDvWg4jGwZ3ZL2sNO3kD7h9wwLUlY=;
 b=adsEUCuRrv01hnta30II1PnCHZ/3LS8ElZVZ1xXQiTj1VGmm/mYHwzOPEU3jdMANfYloir
 hOrbMxEC0Urs9AO1qrT/ne3eYhYiDK8HWIZI5LKZzHGg3rz+FKiLWyO33Oy22wI6Ffdhbw
 ovaaIyUURsyc2EeDKxd2shPNvW5Kw/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722539652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YepaHKW/K1SqTvoDvWg4jGwZ3ZL2sNO3kD7h9wwLUlY=;
 b=BovfYDzxu11xI52AizNn6MDX3FxnqfrfZIcnJtdITQyKchf0O4mTJNdZwnmDgS9bl5dk97
 JA96TeGRefg13mDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50A89136CF;
 Thu,  1 Aug 2024 19:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lb4oBoTeq2bAUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 01 Aug 2024 19:14:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Jim Fehlig
 <jfehlig@suse.com>
Subject: Re: [PATCH 2/2] migration/multifd: Fix multifd_send_setup cleanup
 when channel creation fails
In-Reply-To: <ZqvWOEHfLCqnu4dP@x1n>
References: <20240801174101.31806-1-farosas@suse.de>
 <20240801174101.31806-3-farosas@suse.de> <ZqvWOEHfLCqnu4dP@x1n>
Date: Thu, 01 Aug 2024 16:14:09 -0300
Message-ID: <874j84xdha.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.31 / 50.00];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:email, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D2B661F889
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Thu, Aug 01, 2024 at 02:41:01PM -0300, Fabiano Rosas wrote:
>> When a channel fails to create, the code currently just returns. This
>> is wrong for two reasons:
>> 
>> 1) Channel n+1 will not get to initialize it's semaphores, leading to
>>    an assert when terminate_threads tries to post to it:
>> 
>>  qemu-system-x86_64: ../util/qemu-thread-posix.c:92:
>>  qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
>> 
>> 2) (theoretical) If channel n-1 already started creation it will
>>    defeat the purpose of the channels_created logic which is in place
>>    to avoid migrate_fd_cleanup() to run while channels are still being
>>    created.
>> 
>>    This cannot really happen today because the current failure cases
>>    for multifd_new_send_channel_create() are all synchronous,
>>    resulting from qio_channel_file_new_path() getting a bad
>>    filename. This would hit all channels equally.
>> 
>>    But I don't want to set a trap for future people, so have all
>>    channels try to create (even if failing), and only fail after the
>>    channels_created semaphore has been posted.
>> 
>> While here, remove the error_report_err call. There's one already at
>> migrate_fd_cleanup later on.
>> 
>> Cc: qemu-stable@nongnu.org
>> Reported-by: Jim Fehlig <jfehlig@suse.com>
>> Fixes: bd8b0a8f82 ("migration/multifd: Move multifd_send_setup error handling in to the function")
>
> Should it be this one instead?
>
> b7b03eb614 ("migration/multifd: Add outgoing QIOChannelFile support")

Yep, thanks. I'll fix it up.

>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> PS: what's your plan on your other multifd SendData series?  I got a bit
> overloaded on downstream stuff and I still have plenty review debts
> recently (CPR one of them.. needs follow ups), so just to say I may delay a
> bit on reading that one.  I assume it's next-release stuff anyway, but let
> me know otherwise.

That one is pretty ready. From my side I don't intend to change anything
else, save for review comments. And it's definitely 9.2 material.

I think CPR is more important at this point because it's been lagging
behind for a while.

I have a PR to send with these fixes and catch up on that virtio-net
discussion. After that I should be able to get some reviews done.

>
> Thanks,

