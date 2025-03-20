Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8364DC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvH9m-0002Lb-6K; Thu, 20 Mar 2025 10:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvH9X-0002Jy-Ex
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:45:49 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvH9R-00070z-F2
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:45:45 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 152DC21EFC;
 Thu, 20 Mar 2025 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742481934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=150bKVbBZus5B9lHcJwLJJ2F03PSZYHl1AMvDIdWnS4=;
 b=ZTIrgnQ9q3BAETT6mpnUfuMtXf4yMGbcycV1PJ1mQ5KVXVH6BwXp/EiINRmBbiJ9opzQWN
 JMH7ntW1Ci7wUVMsMXET7XflmsQGnw5UzwjwrpCQUBWYCTj74XFv0pdaKDKYWhk4PqoGvz
 onhocy07jAZ8xTyUPuYRE/yQ4fXiLd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742481934;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=150bKVbBZus5B9lHcJwLJJ2F03PSZYHl1AMvDIdWnS4=;
 b=a/zJ2fHddbIonjD9U0HQy9uIzst0cP/U38iXvA+MXTN6hzlrJq8icL8bOemyphnYrpWR7l
 vzMQ1SeQtPeislAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rp8EuJpV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cMPKBx2K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742481933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=150bKVbBZus5B9lHcJwLJJ2F03PSZYHl1AMvDIdWnS4=;
 b=rp8EuJpVCeirsHkEaSZ3cq+zuIFx3ecyuoTnWOVx0H0RG0mPEVmy0R6l/BEbnnsXmKaYBG
 RbEj1+Zf/WO0v7GDR0R19HHsutsMOEEldGCY44r5rWdcGS8ajv9Hyutr+yj1SxCBYbjdc+
 LWZb8NMADTzORD9lAsXO6S+/bHaPU+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742481933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=150bKVbBZus5B9lHcJwLJJ2F03PSZYHl1AMvDIdWnS4=;
 b=cMPKBx2K5md0Jls7b1G0DCNeF2+K+xaShaornyrFXa7QXLYD30ChRzQAs6CtXi0h+tpHnH
 lPt335Soa0uUrxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F0113757;
 Thu, 20 Mar 2025 14:45:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cp4lEAwq3Gd/ZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Mar 2025 14:45:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
In-Reply-To: <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
Date: Thu, 20 Mar 2025 11:45:29 -0300
Message-ID: <875xk3bw1i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 152DC21EFC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, libvirt.org:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hello Fabiano,
>
> * First big thank you for starting/writing this document. It is a
> great resource.
>
> On Fri, 7 Mar 2025 at 19:13, Fabiano Rosas <farosas@suse.de> wrote:
>> +++ b/docs/devel/migration/multifd.rst
>> @@ -0,0 +1,254 @@
>> +Multifd
>> +Multifd is the name given for the migration capability that enables
>> +data transfer using multiple threads. Multifd supports all the
>> +transport types currently in use with migration (inet, unix, vsock,
>> +fd, file).
>
> * Multifd is Multiple File Descriptors, right? Ie. Does it work with
> one thread but multiple file descriptors? OR one thread per file
> descriptor is always the case? I have not used/tried 'multifd +
> file://' migration, but I imagined there one thread might be able to
> read/write to multiple file descriptors at a time.
>

Technically both can happen. But that would just be the case of
file:fdset migration which requires an extra fd for O_DIRECT. So
"multiple" in the usual sense of "more is better" is only
fd-per-thread. IOW, using multiple fds is an implementation detail IMO,
what people really care about is medium saturation, which we can only
get (with multifd) via parallelization.

>> +Usage
>> +-----
>> +
>> +On both source and destination, enable the ``multifd`` capability:
>> +
>> +    ``migrate_set_capability multifd on``
>> +
>> +Define a number of channels to use (default is 2, but 8 usually
>> +provides best performance).
>> +
>> +    ``migrate_set_parameter multifd-channels 8``
>> +
>
> * I get that this is a QEMU documentation, but for users/reader's
> convenience it'll help to point to libvirt:virsh migrate usage here ->
> https://www.libvirt.org/manpages/virsh.html#migrate , just as an
> alternative.

AFAIK, we tend to not do that in QEMU docs.

> Because doing migration via QMP commands is not as
> straightforward, I wonder who might do that and why.
>

All of QEMU developers, libvirt developers, cloud software developers,
kernel developers etc.

>
>> +Restrictions
>> +------------
>> +
>> +For migration to a file, support is conditional on the presence of the
>> +mapped-ram capability, see `mapped-ram`.
>> +
>> +Snapshots are currently not supported.
>
> * Maybe: Sanpshot using multiple threads (multifd) is not supported.
>
>> +`postcopy` migration is currently not supported.
>
> * Maybe - 'postcopy' migration using multiple threads (multifd) is not
> supported. ie. 'postcopy' uses a single thread to transfer migration
> data.
>
> * Reason for these suggestions: as a writer it is easy to think
> everything written in this page is to be taken with multifd context,
> but readers may not do that, they may take sentences in isolation.
> (just sharing thoughts)
>

Sure, I can expand on those.

>> +Multifd consists of:
>> +
>> +- A client that produces the data on the migration source side and
>> +  consumes it on the destination. Currently the main client code is
>> +  ram.c, which selects the RAM pages for migration;
>
> * So multifd mechanism can be used to transfer non-ram data as well? I
> thought it's only used for RAM migration. Are device/gpu states etc
> bits also transferred via multifd threads?
>

device state migration with multifd has been merged for 10.0

<rant>
If it were up to me, we'd have a pool of multifd threads that transmit
everything migration-related. Unfortunately, that's not so
straight-forward to implement without rewriting a lot of code, multifd
requires too much entanglement from the data producer. We're constantly
dealing with details of data transmission getting in the way of data
production/consumption (e.g. try to change ram.c to produce multiple
pages at once and watch everyting explode).

I've been experimenting with a MultiFDIov payload type to allow
separation between the data type handling details and multifd inner
workings. However in order for that to be useful we'd need to have a
sync that doesn't depend on control data on the main migration
thread. That's why I've been asking about a multifd-only sync with Peter
in the other thread.

There's a bunch of other issues as well:

- no clear distinction between what should go in the header and what
  should go in the packet.

- the header taking up one slot in the iov, which should in theory be
  responsibility of the client

- the whole multifd_ops situation which doesn't allow a clear interface
  between multifd and client

- the lack of uniformity between send/recv in regards to doing I/O from
  multifd code or from client code

- the recv having two different modes of operation, socket and file

the list goes on...
</rant>

>> +- A packet which is the final result of all the data aggregation
>> +  and/or transformation. The packet contains: a *header* with magic and
>> +  version numbers and flags that inform of special processing needed
>> +  on the destination; a *payload-specific header* with metadata referent
>> +  to the packet's data portion, e.g. page counts; and a variable-size
>> +  *data portion* which contains the actual opaque payload data.
>
> * It'll help to define the exact packet format here. Like they do in RFCs.

I'll try to produce some ascii art.

>
> Thank you for writing this.
> ---
>   - Prasad

