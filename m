Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2BBCD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slV28-0001Rx-AH; Tue, 03 Sep 2024 11:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slV20-00010L-Pv
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:01:21 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slV1y-0008BX-MV
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:01:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A56961F397;
 Tue,  3 Sep 2024 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725375676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXg3KmjO6g8uo/J7ZcYD+a2MRAS1YpU3Iunyc/3i0vs=;
 b=HVmYHIRC6D2lqQv0/CRymcilg42zZ+uQh69SUbbMzTsiWrxgw76xG50na64XXazMQojJ/J
 Jsf7Js9mKJW7vw+OzqbjeAhGsxk9ClDATt2scvKvI5A7cTB8lwYMuyg6lUozdI8r69a5+b
 YWq+zA7Lk20VGpC6eWaNANru/xBYYaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725375676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXg3KmjO6g8uo/J7ZcYD+a2MRAS1YpU3Iunyc/3i0vs=;
 b=s0kOrhwt5d4rjWqQ2Z1T1s7VE+Pnx0HillxZf7GM08HZBy/yu9I+dmy3Di/JuPAQViEFiq
 p0FecCzqFz8bsLBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HVmYHIRC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s0kOrhwt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725375676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXg3KmjO6g8uo/J7ZcYD+a2MRAS1YpU3Iunyc/3i0vs=;
 b=HVmYHIRC6D2lqQv0/CRymcilg42zZ+uQh69SUbbMzTsiWrxgw76xG50na64XXazMQojJ/J
 Jsf7Js9mKJW7vw+OzqbjeAhGsxk9ClDATt2scvKvI5A7cTB8lwYMuyg6lUozdI8r69a5+b
 YWq+zA7Lk20VGpC6eWaNANru/xBYYaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725375676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXg3KmjO6g8uo/J7ZcYD+a2MRAS1YpU3Iunyc/3i0vs=;
 b=s0kOrhwt5d4rjWqQ2Z1T1s7VE+Pnx0HillxZf7GM08HZBy/yu9I+dmy3Di/JuPAQViEFiq
 p0FecCzqFz8bsLBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3034413A80;
 Tue,  3 Sep 2024 15:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xCjpObsk12YeZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Sep 2024 15:01:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/17] migration/multifd: Convert
 multifd_send()::next_channel to atomic
In-Reply-To: <93336ae5-e0e4-4066-9a1b-9577046f4d07@maciej.szmigiero.name>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <76dc3ad69fa457fd1e358ad3de874474f9f64716.1724701542.git.maciej.szmigiero@oracle.com>
 <875xrhop4f.fsf@suse.de>
 <93336ae5-e0e4-4066-9a1b-9577046f4d07@maciej.szmigiero.name>
Date: Tue, 03 Sep 2024 12:01:13 -0300
Message-ID: <87cylkn5mu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A56961F397
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 30.08.2024 20:13, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This is necessary for multifd_send() to be able to be called
>>> from multiple threads.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   migration/multifd.c | 24 ++++++++++++++++++------
>>>   1 file changed, 18 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>> index d5a8e5a9c9b5..b25789dde0b3 100644
>>> --- a/migration/multifd.c
>>> +++ b/migration/multifd.c
>>> @@ -343,26 +343,38 @@ bool multifd_send(MultiFDSendData **send_data)
>>>           return false;
>>>       }
>>>   
>>> -    /* We wait here, until at least one channel is ready */
>>> -    qemu_sem_wait(&multifd_send_state->channels_ready);
>>> -
>>>       /*
>>>        * next_channel can remain from a previous migration that was
>>>        * using more channels, so ensure it doesn't overflow if the
>>>        * limit is lower now.
>>>        */
>>> -    next_channel %= migrate_multifd_channels();
>>> -    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
>>> +    i = qatomic_load_acquire(&next_channel);
>>> +    if (unlikely(i >= migrate_multifd_channels())) {
>>> +        qatomic_cmpxchg(&next_channel, i, 0);
>>> +    }
>> 
>> Do we still need this? It seems not, because the mod down below would
>> already truncate to a value less than the number of channels. We don't
>> need it to start at 0 always, the channels are equivalent.
>
> The "modulo" operation below forces i_next to be in the proper range,
> not i.
>
> If the qatomic_cmpxchg() ends up succeeding then we use the (now out of
> bounds) i value to index multifd_send_state->params[].

Indeed.

>
>>> +
>>> +    /* We wait here, until at least one channel is ready */
>>> +    qemu_sem_wait(&multifd_send_state->channels_ready);
>>> +
>>> +    while (true) {
>>> +        int i_next;
>>> +
>>>           if (multifd_send_should_exit()) {
>>>               return false;
>>>           }
>>> +
>>> +        i = qatomic_load_acquire(&next_channel);
>>> +        i_next = (i + 1) % migrate_multifd_channels();
>>> +        if (qatomic_cmpxchg(&next_channel, i, i_next) != i) {
>>> +            continue;
>>> +        }
>> 
>> Say channel 'i' is the only one that's idle. What's stopping the other
>> thread(s) to race at this point and loop around to the same index?
>
> See the reply below.
>
>>> +
>>>           p = &multifd_send_state->params[i];
>>>           /*
>>>            * Lockless read to p->pending_job is safe, because only multifd
>>>            * sender thread can clear it.
>>>            */
>>>           if (qatomic_read(&p->pending_job) == false) {
>> 
>> With the cmpxchg your other patch adds here, then the race I mentioned
>> above should be harmless. But we'd need to bring that code into this
>> patch.
>> 
>
> You're right - the sender code with this patch alone isn't thread safe
> yet but this commit is only literally about "converting
> multifd_send()::next_channel to atomic".
>
> At the time of this patch there aren't any multifd_send() calls from
> multiple threads, and the commit that introduces such possible call
> site (multifd_queue_device_state()) also modifies multifd_send()
> to be fully thread safe by introducing p->pending_job_preparing.

In general this would be a bad practice because this commit can end up
being moved around due to backporting or bisecting. It would be better
if it were complete from the start. It also affects backporting due to
ambiguity on where the Fixes tag should point to if someone eventually
finds a bug.

I already asked you to extract the other code into a separate patch, so
it's not that bad. If you prefer to keep both changes separate for
clarity, please note on the commit message that the next patch is
necessary for correctness.

>
> Thanks,
> Maciej

