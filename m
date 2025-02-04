Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43452C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKQG-0005dv-Bc; Tue, 04 Feb 2025 10:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfKQ9-0005ci-UG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:01:05 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tfKQ7-0003Fr-Ni
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:01:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0475E21114;
 Tue,  4 Feb 2025 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738681255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJm6xS+O4fcNMY+dSXoiL5D+0OkGhE0QisLhl3PjjH0=;
 b=ZMCKpTT4I3vbVhKOFWGIYeV1zMNTLpH7OkfXhtw0GpjH862Lg7WMb2f8YL4iov7hNAPNHD
 J76rvUS7EUyiyIVdAwSCzFBs6glp3pIay4RA4JzUCirYm7O4WNo1uQDdmn98PoWjTHKgNS
 p+4W72AazURPnmd0CjdJA+HmXfHoZWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738681255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJm6xS+O4fcNMY+dSXoiL5D+0OkGhE0QisLhl3PjjH0=;
 b=PCXAOcqnbvzdRttO+mkCVjkGKroiiNWEgxgvYGLgK2dNM6xAc6R9DNcCZH5HXdCwEfqOzj
 EbS/nnsijzNFe6Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZMCKpTT4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PCXAOcqn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738681255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJm6xS+O4fcNMY+dSXoiL5D+0OkGhE0QisLhl3PjjH0=;
 b=ZMCKpTT4I3vbVhKOFWGIYeV1zMNTLpH7OkfXhtw0GpjH862Lg7WMb2f8YL4iov7hNAPNHD
 J76rvUS7EUyiyIVdAwSCzFBs6glp3pIay4RA4JzUCirYm7O4WNo1uQDdmn98PoWjTHKgNS
 p+4W72AazURPnmd0CjdJA+HmXfHoZWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738681255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yJm6xS+O4fcNMY+dSXoiL5D+0OkGhE0QisLhl3PjjH0=;
 b=PCXAOcqnbvzdRttO+mkCVjkGKroiiNWEgxgvYGLgK2dNM6xAc6R9DNcCZH5HXdCwEfqOzj
 EbS/nnsijzNFe6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DE3513795;
 Tue,  4 Feb 2025 15:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PoCoEKYromcDdAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 04 Feb 2025 15:00:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
Date: Tue, 04 Feb 2025 12:00:47 -0300
Message-ID: <871pwdah5s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0475E21114
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, oracle.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

> On 3.02.2025 23:56, Peter Xu wrote:
>> On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
>>> On 3.02.2025 21:20, Peter Xu wrote:
>>>> On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
>>>>> On 3.02.2025 19:20, Peter Xu wrote:
>>>>>> On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
>>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>>
>>>>>>> Multifd send channels are terminated by calling
>>>>>>> qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
>>>>>>> multifd_send_terminate_threads(), which in the TLS case essentially
>>>>>>> calls shutdown(SHUT_RDWR) on the underlying raw socket.
>>>>>>>
>>>>>>> Unfortunately, this does not terminate the TLS session properly and
>>>>>>> the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
>>>>>>>
>>>>>>> The only reason why this wasn't causing migration failures is because
>>>>>>> the current migration code apparently does not check for migration
>>>>>>> error being set after the end of the multifd receive process.
>>>>>>>
>>>>>>> However, this will change soon so the multifd receive code has to be
>>>>>>> prepared to not return an error on such premature TLS session EOF.
>>>>>>> Use the newly introduced QIOChannelTLS method for that.
>>>>>>>
>>>>>>> It's worth noting that even if the sender were to be changed to terminate
>>>>>>> the TLS connection properly the receive side still needs to remain
>>>>>>> compatible with older QEMU bit stream which does not do this.
>>>>>>
>>>>>> If this is an existing bug, we could add a Fixes.
>>>>>
>>>>> It is an existing issue but only uncovered by this patch set.
>>>>>
>>>>> As far as I can see it was always there, so it would need some
>>>>> thought where to point that Fixes tag.
>>>>
>>>> If there's no way to trigger a real functional bug anyway, it's also ok we
>>>> omit the Fixes.
>>>>
>>>>>> Two pure questions..
>>>>>>
>>>>>>      - What is the correct way to terminate the TLS session without this flag?
>>>>>
>>>>> I guess one would need to call gnutls_bye() like in this GnuTLS example:
>>>>> https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
>>>>>
>>>>>>      - Why this is only needed by multifd sessions?
>>>>>
>>>>> What uncovered the issue was switching the load threads to using
>>>>> migrate_set_error() instead of their own result variable
>>>>> (load_threads_ret) which you had requested during the previous
>>>>> patch set version review:
>>>>> https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
>>>>>
>>>>> Turns out that the multifd receive code always returned
>>>>> error in the TLS case, just nothing was previously checking for
>>>>> that error presence.
>>>>
>>>> What I was curious is whether this issue also exists for the main migration
>>>> channel when with tls, especially when e.g. multifd not enabled at all.  As
>>>> I don't see anywhere that qemu uses gnutls_bye() for any tls session.
>>>>
>>>> I think it's a good to find that we overlooked this before.. and IMHO it's
>>>> always good we could fix this.
>>>>
>>>> Does it mean we need proper gnutls_bye() somewhere?
>>>>
>>>> If we need an explicit gnutls_bye(), then I wonder if that should be done
>>>> on the main channel as well.
>>>
>>> That's a good question and looking at the code qemu_loadvm_state_main() exits
>>> on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
>>> and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
>>> in qemu_loadvm_state() - so still not until channel EOF.
>> 
>> I had a closer look, I do feel like such pre-mature termination is caused
>> by explicit shutdown()s of the iochannels, looks like that can cause issue
>> even after everything is sent.  Then I noticed indeed multifd sender
>> iochannels will get explicit shutdown()s since commit 077fbb5942, while we
>> don't do that for the main channel.  Maybe that is a major difference.
>> 
>> Now I wonder whether we should shutdown() the channel at all if migration
>> succeeded, because looks like it can cause tls session to interrupt even if
>> the shutdown() is done after sent everything, and if so it'll explain why
>> you hit the issue with tls.
>> 
>>>
>>> Then I can't see anything else reading the channel until it is closed in
>>> migration_incoming_state_destroy().
>>>
>>> So most likely the main migration channel will never read far enough to
>>> reach that GNUTLS_E_PREMATURE_TERMINATION error.
>>>
>>>> If we don't need gnutls_bye(), then should we always ignore pre-mature
>>>> termination of tls no matter if it's multifd or non-multifd channel (or
>>>> even a tls session that is not migration-related)?
>>>
>>> So basically have this patch extended to calling
>>> qio_channel_tls_set_premature_eof_okay() also on the main migration channel?
>> 
>> If above theory can stand, then eof-okay could be a workaround papering
>> over the real problem that we shouldn't always shutdown()..
>> 
>> Could you have a look at below patch and see whether it can fix the problem
>> you hit too, in replace of these two patches (including the previous
>> iochannel change)?
>> 
>
> Unfortunately, the patch below does not fix the problem:
>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
>> qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
>
> I think that, even in the absence of shutdown(), if the sender does not
> call gnutls_bye() the TLS session is considered improperly terminated.
>

I havent't looked much further into this, but can we craft a reproducer
for it with current master code? It would help us take a look at this
problem independently of this series. Even an assert somewhere would
help.

>> Thanks,
>> 
> Thanks,
> Maciej

