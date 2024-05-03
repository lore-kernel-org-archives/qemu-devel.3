Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70807C25B5C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sNf-0008Qu-FM; Fri, 03 May 2024 08:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2sNd-0008PM-TH
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:51:13 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2sNb-0005pF-Fn
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:51:13 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 66CC522971;
 Fri,  3 May 2024 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714740667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57f8EdNmG54LhggCVkZU/4EzRjA4Ih9/KEx9zZ5psaI=;
 b=kdMF4vsC4rurLVpj9BlCVTVSAXBU6qaRbsIKNB1CLn8DdcE5o+aB1IMjKTcsuiZaF8YmEw
 Cw1g1vcGyPReSOhN5IeqnaY5jSBijQkAtNxtkiX04zoyqHMvlh8s7zjBH+zIwUBf1CkxOx
 u1AhKkEAh2hrq5efQC+IcFdRb09rdek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714740667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57f8EdNmG54LhggCVkZU/4EzRjA4Ih9/KEx9zZ5psaI=;
 b=G/jhUVCnlwT6kzh/8NX06DIc5PUFEWcDQf2qtjx9ruCznCi1uAl2GKs4QY0DwwYipUNYdG
 PkyT6SzJ5TBG/BCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kdMF4vsC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="G/jhUVCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714740667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57f8EdNmG54LhggCVkZU/4EzRjA4Ih9/KEx9zZ5psaI=;
 b=kdMF4vsC4rurLVpj9BlCVTVSAXBU6qaRbsIKNB1CLn8DdcE5o+aB1IMjKTcsuiZaF8YmEw
 Cw1g1vcGyPReSOhN5IeqnaY5jSBijQkAtNxtkiX04zoyqHMvlh8s7zjBH+zIwUBf1CkxOx
 u1AhKkEAh2hrq5efQC+IcFdRb09rdek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714740667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=57f8EdNmG54LhggCVkZU/4EzRjA4Ih9/KEx9zZ5psaI=;
 b=G/jhUVCnlwT6kzh/8NX06DIc5PUFEWcDQf2qtjx9ruCznCi1uAl2GKs4QY0DwwYipUNYdG
 PkyT6SzJ5TBG/BCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E671F13991;
 Fri,  3 May 2024 12:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vaDzKrrdNGYidQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 12:51:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PULL 13/13] hmp/migration: Fix documents for "migrate" command
In-Reply-To: <87bk5n1ius.fsf@pond.sub.org>
References: <20240502202316.29924-1-farosas@suse.de>
 <20240502202316.29924-14-farosas@suse.de> <87bk5n1ius.fsf@pond.sub.org>
Date: Fri, 03 May 2024 09:51:04 -0300
Message-ID: <87cyq3njnr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 66CC522971
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> From: Peter Xu <peterx@redhat.com>
>>
>> Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
>> 7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
>> adding a Fixes to make life easier for the stable maintainer.
>>
>> When at it, slightly cleanup the lines, move "detach/-d" to a separate
>> section rather than appending it at the end of the command description.
>>
>> Cc: Dr. David Alan Gilbert <dave@treblig.org>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  hmp-commands.hx | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hmp-commands.hx b/hmp-commands.hx
>> index ebca2cdced..484a8a1c3a 100644
>> --- a/hmp-commands.hx
>> +++ b/hmp-commands.hx
>> @@ -918,8 +918,13 @@ ERST
>>  
>>  
>>  SRST
>> -``migrate [-d]`` *uri*
>> -  Migrate to *uri* (using -d to not wait for completion).
>> +``migrate [-d] [-r]`` *uri*
>> +  Migrate the current VM to *uri*.
>> +
>> +  ``-d``
>> +    Run this command asynchronously, so that the command doesn't wait for completion.
>> +  ``-r``
>> +    Resume a paused postcopy migration.
>>  ERST
>>  
>>      {
>
> I have questions on this one.

Yep, I should have waited longer before queuing this one, my bad.

