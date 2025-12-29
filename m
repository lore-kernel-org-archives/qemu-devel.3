Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC312E9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIou-0004KK-6M; Mon, 29 Dec 2025 14:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaIog-0004IL-Km
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:22:06 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaIof-0004oG-0T
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:22:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E61945BCDB;
 Mon, 29 Dec 2025 19:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6djY2jfljzQRf2HoHkrlxfJJF7md7+vJQfG4ZLiJF5Y=;
 b=QJWK98CjNzhqG/dJF5Al3g5o4funCgFYwHhAwT4bAy/3dC3cbtzfsLQGf7wzay/9Sy/+Jg
 Pm02XiuMkbhoUSgaVe6ulHZjOtAKtK0aAItvhK+n9mn9830Mwnjzs+Qh7MwZRr12z17l/T
 YN+cRrVLZWdGwnVOC3/08NrcgmbfkRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6djY2jfljzQRf2HoHkrlxfJJF7md7+vJQfG4ZLiJF5Y=;
 b=nopEY0cr7rUYkk5xOHPeZ4QyQLbcSd4JH9jiGRlRqwHCT4pmR1rjvKsqfdEdikp1AnRk8F
 GYf8ihNikWzmQSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767036118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6djY2jfljzQRf2HoHkrlxfJJF7md7+vJQfG4ZLiJF5Y=;
 b=0zlflq9/aOxWcZRrTrLdrjYc9+4aixi87z11AxBGt/a+KaKuyMnnjXfikV/wDqL6cUh8/m
 gLjWmT4qqf9XyEq0nlI4pMsTwpilv18+udGmfP2Ln06mBRbQ79+dyhI4lffjOLJkIK/xqE
 sFx7+5AxLDGb4mTppKTqtqF8Dxpabk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767036118;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6djY2jfljzQRf2HoHkrlxfJJF7md7+vJQfG4ZLiJF5Y=;
 b=Oy9gYS2iBux3pb9e7RXUDlcmr07Y4csSiwlEPnugvIoG998oCf3t0YflGYEamH2IcbzASu
 Xr7eLYFRUgCi9aDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60775137C3;
 Mon, 29 Dec 2025 19:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lHSnCNbUUmlqVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 19:21:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 04/25] migration: Move multifd_recv_setup call
In-Reply-To: <aVKjZyDWVH5ouvdV@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-5-farosas@suse.de> <aVKjZyDWVH5ouvdV@x1.local>
Date: Mon, 29 Dec 2025 16:21:55 -0300
Message-ID: <87o6nh8564.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

> On Fri, Dec 26, 2025 at 06:19:06PM -0300, Fabiano Rosas wrote:
>> The multifd_recv_setup() call is currently in a place where it will be
>> called for every channel that appears. That doesn't make much
>> sense.
>> 
>> It seems it was moved when the channel discovery mechanism was added
>> back at commit 6720c2b327 (migration: check magic value for deciding
>> the mapping of channels, 2022-12-20). The original place was
>> migration_incoming_setup() which would run for just the main channel,
>> but it was discovered that the main channel might arrive after a
>> multifd channel.
>> 
>> Move the call back to a place where it will be called only once.
>> 
>> With respect to cleanup, this new location at
>> qemu_start_incoming_migration() has the same issue as the previous
>> callsite at migration_ioc_process_incoming(): no cleanup ever happens.
>> 
>> The error message goes from being emitted via error_report_err(), to
>> being returned to the qmp_migrate_incoming() incoming command, which
>> is arguably better, since this is setup code.
>
> This is not the only and real reason that you moved it, right?
>

It was odd where it was and I just moved it. It could probably remain
there even after the rest of the series, I didn't check.

I think it would then need to move to channel.c which would make that
file access multifd code, so maybe it's a layering argument.

> Neither should it be the reason that you want it to be called only exactly
> once; after all the function will be no-op in the 2nd+ calls.
>

It's not a no-op. But yes, it returns early on subsequent calls.

> I'll keep reading.. I'm guessing I'll find it later, but IMHO it'll always
> be good to mention the real motivation in the commit log.
>
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 71efe945f6..974313944c 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -786,6 +786,10 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>          return;
>>      }
>>  
>> +    if (multifd_recv_setup(errp) != 0) {
>> +        return;
>> +    }
>> +
>>      if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>>          SocketAddress *saddr = &addr->u.socket;
>>          if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>> @@ -1065,10 +1069,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>          channel = CH_POSTCOPY;
>>      }
>>  
>> -    if (multifd_recv_setup(errp) != 0) {
>> -        return;
>> -    }
>> -
>>      if (channel == CH_MAIN) {
>>          f = qemu_file_new_input(ioc);
>>          migration_incoming_setup(f);
>> -- 
>> 2.51.0
>> 

