Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E622BC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 12:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3DRM-0005Zz-Iv; Fri, 11 Apr 2025 08:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3DRA-0005ZT-Ty
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:24:50 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u3DR4-0007oY-LF
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 08:24:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DC081F453;
 Fri, 11 Apr 2025 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744374276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpcblA4xYDq1shSdSI9ABcP4eCQhn7jAzhIfkjnWvQ=;
 b=GA/1gVq1NRE1+t9puxEUEsvaGD69+eRfvSz7aKvkWQTbtCpxQoZdB+8oNsO5noRlqnMfbc
 OVlKAFmHkzn8lRFOFlvfO4l9zSmIkDhkXzsXowl7Jz3l6gKvaG9hKUO9ubr2hsS/oxrpOT
 +EeBDDKACemjBmuZaA/S9AF2EE0gwnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744374276;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpcblA4xYDq1shSdSI9ABcP4eCQhn7jAzhIfkjnWvQ=;
 b=+dKpe+eNc8AkLsl0lmBIqIN72rfGvCyHk9hj2pKyt6X25KJLJry4rlC3Nnarfr2TsW/3ck
 2BSS/Uw0hO58yCCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T6x7DDq6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SX3WnjRV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744374275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpcblA4xYDq1shSdSI9ABcP4eCQhn7jAzhIfkjnWvQ=;
 b=T6x7DDq6VUnat4Ebh9mv4eq91lC07oAC/vnS+zILbeUEGaoK2mHR3C7dXSexJiACEhjMOa
 E17VjCph5k73WE1sV3FseB55UwmW8te6NphxLpRgSRSvaTRF3izklSVbZ9BsDs7AY0GhX4
 AsgUVxTQxxxDNw1gfGSycqCAFQqPEFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744374275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EOpcblA4xYDq1shSdSI9ABcP4eCQhn7jAzhIfkjnWvQ=;
 b=SX3WnjRVDbxpP8Jy5B1PTp46Pb4nTEGpLC+nG5kxYVmBIjZbq/gepDSKHgKwgoZVcvMpLf
 Bx9MHLJQz1dryrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8C3136A4;
 Fri, 11 Apr 2025 12:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W3UOJgIK+Wc7YgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Apr 2025 12:24:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH] migration: add  FEATURE_SEEKABLE to QIOChannelBlock
In-Reply-To: <4caa0-67f8d780-a89-60718600@156698708>
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
Date: Fri, 11 Apr 2025 09:24:32 -0300
Message-ID: <87ecxyhon3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 7DC081F453
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"Marco Cavenati" <Marco.Cavenati@eurecom.fr> writes:

> On Thursday, April 10, 2025 21:52 CEST, Fabiano Rosas <farosas@suse.de> wrote:
>
>> We'll need to add the infrastructure to reject multifd and direct-io
>> before this. The rest of the capabilities should not affect mapped-ram,
>> so it's fine (for now) if we don't honor them.
>
> Ok, thanks for the update.
>  
>> What about zero page handling? Mapped-ram doesn't send zero pages
>> because the file will always have zeroes in it and the migration
>> destination is guaranteed to not have been running previously. I believe
>> loading a snapshot in a VM that's already been running would leave stale
>> data in the guest's memory.
>
> Yes, you are correct.
>
> About the `RAMBlock->file_bmap`, according to the code it is a:
> `/* bitmap of pages present in the migration file */`
> And, if a pages is a zero page, it won't be in the migration file:
> `/* zero pages are not transferred with mapped-ram */`
> So, zero page implies bitmap 0.
> Does the opposite hold?
>

It does. Mapped-ram takes up (sparse) disk space equal to the guest's
ram size.

> If bitmap 0 implies zero page, we could call `ram_handle_zero`
> in `read_ramblock_mapped_ram` for the clear bits.
> Or do you fear this might be unnecessary expensive for migration?
>

Yes, unfortunately the peformance difference is noticeable. But we could
have a slightly different algorithm for savevm. At this point it might
be easier to just duplicate read_ramblock_mapped_ram(), check for savevm
in there and see what that the resulting code looks like.

By the way, what's your overall goal with enabling the feature? Do you
intent to enable further capabilities for snapshot? Specifically
multifd. I belive the zero page skip is responsible for most of the
performance gains for mapped-ram without direct-io and multifd. The
benefit of bounded stream size doesn't apply to snapshots because
they're not live.

It would be interesting to gather some numbers for the perf difference
between mapped-ram=on vs off.

> If bitmap 0 does not imply zero page, I feel like the
> "is present in the migration file" and "is zero page" info should
> be better separated.
>
> Best,
> Marco

