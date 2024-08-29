Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2655EC71156
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 00:52:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjTNq-0001yy-0G; Wed, 28 Aug 2024 20:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjTNp-0001yS-BO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:51:29 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjTNn-0000ix-AZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 20:51:29 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EE7521B82;
 Thu, 29 Aug 2024 00:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724892683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukgQIZtEfg2AzAnc71IFD3ic247XTwUhjvVfJFtJ1FY=;
 b=dUNRQrt3OhS+4eKg7ify356FhDOFcNjrDAOMhTpnjxNdZQg4q/xVKv+YDI+gqGZfDp7vs6
 fDztIA+yDGBPHSjIc5PoyyKMlfGpL9L1NktcBlBsnZfddphHuMLAcaVv6YeDF4Lz12o3+P
 xKUpKdT3+IpqCvmFi380+cm6MD2EjvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724892683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukgQIZtEfg2AzAnc71IFD3ic247XTwUhjvVfJFtJ1FY=;
 b=SPPXT87JL9mGAkhzIW9y07nkK2zTFcUwTAPvRrwNEVlS2rCL+UjOlUdSObGEyBbF//nsd0
 FK/SfppLhPdJdoDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dUNRQrt3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SPPXT87J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724892683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukgQIZtEfg2AzAnc71IFD3ic247XTwUhjvVfJFtJ1FY=;
 b=dUNRQrt3OhS+4eKg7ify356FhDOFcNjrDAOMhTpnjxNdZQg4q/xVKv+YDI+gqGZfDp7vs6
 fDztIA+yDGBPHSjIc5PoyyKMlfGpL9L1NktcBlBsnZfddphHuMLAcaVv6YeDF4Lz12o3+P
 xKUpKdT3+IpqCvmFi380+cm6MD2EjvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724892683;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ukgQIZtEfg2AzAnc71IFD3ic247XTwUhjvVfJFtJ1FY=;
 b=SPPXT87JL9mGAkhzIW9y07nkK2zTFcUwTAPvRrwNEVlS2rCL+UjOlUdSObGEyBbF//nsd0
 FK/SfppLhPdJdoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBFD713408;
 Thu, 29 Aug 2024 00:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SFIELArGz2bLagAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Aug 2024 00:51:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Dan?=
 =?utf-8?Q?iel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/17] Multifd =?utf-8?Q?=F0=9F=94=80?= device state
 transfer support with VFIO consumer
In-Reply-To: <8665d854-129d-4a5e-be1d-ec448704de62@maciej.szmigiero.name>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <87jzg0nzo7.fsf@suse.de>
 <8665d854-129d-4a5e-be1d-ec448704de62@maciej.szmigiero.name>
Date: Wed, 28 Aug 2024 21:51:20 -0300
Message-ID: <87ed68noc7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6EE7521B82
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 28.08.2024 22:46, Fabiano Rosas wrote:
>> "Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:
>> 
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This is an updated v2 patch series of the v1 series located here:
>>> https://lore.kernel.org/qemu-devel/cover.1718717584.git.maciej.szmigiero@oracle.com/
>>>
>>> Changes from v1:
>>> * Extended the QEMU thread-pool with non-AIO (generic) pool support,
>>> implemented automatic memory management support for its work element
>>> function argument.
>>>
>>> * Introduced a multifd device state save thread pool, ported the VFIO
>>> multifd device state save implementation to use this thread pool instead
>>> of VFIO internally managed individual threads.
>>>
>>> * Re-implemented on top of Fabiano's v4 multifd sender refactor patch set from
>>> https://lore.kernel.org/qemu-devel/20240823173911.6712-1-farosas@suse.de/
>>>
>>> * Moved device state related multifd code to new multifd-device-state.c
>>> file where it made sense.
>>>
>>> * Implemented a max in-flight VFIO device state buffer count limit to
>>> allow capping the maximum recipient memory usage.
>>>
>>> * Removed unnecessary explicit memory barriers from multifd_send().
>>>
>>> * A few small changes like updated comments, code formatting,
>>> fixed zero-copy RAM multifd bytes transferred counter under-counting, etc.
>>>
>>>
>>> For convenience, this patch set is also available as a git tree:
>>> https://github.com/maciejsszmigiero/qemu/tree/multifd-device-state-transfer-vfio
>> 
>> With this branch I'm getting:
>> 
>> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/multifd/tcp/uri/plain/none
>> ...
>> qemu-system-x86_64: ../util/thread-pool.c:354: thread_pool_set_minmax_threads: Assertion `max_threads > 0' failed.
>> Broken pipe
>> 
>
> Oops, I should have tested this patch set in setups without any VFIO devices too.
>
> Fixed this now (together with that RAM tracepoint thing) and updated the GitHub tree -
> the above test now passes.
>
> Tomorrow I will test the whole multifd VFIO migration once again to be sure.
>
>> $ ./tests/qemu-iotests/check -p -qcow2 068
>> ...
>> +qemu-system-x86_64: ../util/qemu-thread-posix.c:92: qemu_mutex_lock_impl: Assertion `mutex->initialized' failed.
>> 
>
> I'm not sure how this can happen - it looks like qemu_loadvm_state() might be called
> somehow after migration_incoming_state_destroy() already destroyed the migration state?
> Will investigate this in detail tomorrow.

Usually something breaks and then the clean up code rushes and frees
state while other parts are still using it.

We also had issues recently with code not incrementing the migration
state refcount properly:

27eb8499ed ("migration: Fix use-after-free of migration state object")

>
> By the way, this test seems to not be run by the default "make check".
>
> Thanks,
> Maciej

