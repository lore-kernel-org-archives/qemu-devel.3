Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAFEC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 14:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvcyt-00032L-C2; Fri, 21 Mar 2025 10:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvcyq-00031l-Nj
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:04:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tvcyn-000415-NV
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:04:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C663721B18;
 Fri, 21 Mar 2025 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742565843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfqzkILiBLtYfjm4PDwv3tTODFgysqJ0w9ku14fspYk=;
 b=2VV5cL8UznIzY4eAVolie+Y/HXJt1l7KOOFAoNw+jDWAi+Il656gMYIJ+OtzmVz7ACNxf+
 4AoW8e5l8yS7RwUlXWKmnSzD5jhR+7V7zpFMbV5+lXpmDzD8rLBCAVV6aD3uJQaYpvR914
 ZuPSv6g6nUU9hVEKx/IwQFlHMD6YV1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742565843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfqzkILiBLtYfjm4PDwv3tTODFgysqJ0w9ku14fspYk=;
 b=mwpdFREbb+YH4O+0Gq0oqV29eP4hAPytYeFV020euguLhe79jhLFPYRA6fCOUedc8II8m9
 +INQJpMIdtk/emAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1742565843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfqzkILiBLtYfjm4PDwv3tTODFgysqJ0w9ku14fspYk=;
 b=2VV5cL8UznIzY4eAVolie+Y/HXJt1l7KOOFAoNw+jDWAi+Il656gMYIJ+OtzmVz7ACNxf+
 4AoW8e5l8yS7RwUlXWKmnSzD5jhR+7V7zpFMbV5+lXpmDzD8rLBCAVV6aD3uJQaYpvR914
 ZuPSv6g6nUU9hVEKx/IwQFlHMD6YV1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1742565843;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lfqzkILiBLtYfjm4PDwv3tTODFgysqJ0w9ku14fspYk=;
 b=mwpdFREbb+YH4O+0Gq0oqV29eP4hAPytYeFV020euguLhe79jhLFPYRA6fCOUedc8II8m9
 +INQJpMIdtk/emAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 490A1139AA;
 Fri, 21 Mar 2025 14:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c1NtA9Nx3WeOdwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Mar 2025 14:04:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
In-Reply-To: <CAE8KmOwHVAnTwUUXVMuGRiLbhELUunVoWQjimcSxS2s8+1VfVg@mail.gmail.com>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <CAE8KmOx0KQ7OfbyivQ_256JVRugtJ8ekykxtQw-uz91Uiuv-tg@mail.gmail.com>
 <875xk3bw1i.fsf@suse.de>
 <CAE8KmOwHVAnTwUUXVMuGRiLbhELUunVoWQjimcSxS2s8+1VfVg@mail.gmail.com>
Date: Fri, 21 Mar 2025 11:04:00 -0300
Message-ID: <87wmcia3an.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Thu, 20 Mar 2025 at 20:15, Fabiano Rosas <farosas@suse.de> wrote:
>> Technically both can happen. But that would just be the case of
>> file:fdset migration which requires an extra fd for O_DIRECT. So
>> "multiple" in the usual sense of "more is better" is only
>> fd-per-thread. IOW, using multiple fds is an implementation detail IMO,
>> what people really care about is medium saturation, which we can only
>> get (with multifd) via parallelization.
>
> * I see. Multifd is essentially multiple threads = thread pool then.
>

Yes, that's what I'm trying to convey with the first
sentence. Specifically to dispel any misconceptions that this is
something esoteric. It's not. We're just using multiple threads with
some custom locking and some callbacks.

`migrate-set-capability
multiple-threads-with-some-custom-locking-and-some-callbacks true`

...doesn't work that well =)

>> > Because doing migration via QMP commands is not as
>> > straightforward, I wonder who might do that and why.
>> >
>>
>> All of QEMU developers, libvirt developers, cloud software developers,
>> kernel developers etc.
>
> * Really? That must be using QMP apis via libvirt/virsh kind of tools
> I guess. Otherwise how does one follow above instructions to enable
> 'multifd' and set number of channels on both source and destination
> machines? User has to open QMP shell on two machines and invoke QMP
> commands?
>

Well, I can't speak for everyone, of course, but generally the less
layers on top of the object of your work the better. I don't even have
libvirt installed on my development machine for instance.

It's convenient to deal directly with QEMU command line and QMP because
that usually gives you a faster turnaround when experimenting with
various command lines/commands.

There are also setups that don't want to bring in too many dependencies,
so having a full libvirt installation is not wanted. There's a bunch of
little tools out there that invoke QEMU and give it QMP commands
directly.

There are several ways of accessing QMP, some examples I have lying
around:

==
  $QEMU ... -qmp unix:${SRC_SOCK},server,wait=off

  echo "
       { 'execute': 'qmp_capabilities' }
       { 'execute': 'migrate-set-capabilities','arguments':{ 'capabilities':[ \
       { 'capability': 'mapped-ram', 'state': true }, \
       { 'capability': 'multifd', 'state': true } \
       ] } }
       { 'execute': 'migrate-set-parameters','arguments':{ 'multifd-channels': 8 } }
       { 'execute': 'migrate-set-parameters','arguments':{ 'max-bandwidth': 0 } }
       { 'execute': 'migrate-set-parameters','arguments':{ 'direct-io': true } }
       { 'execute': 'migrate${incoming}','arguments':{ 'uri': 'file:$MIGFILE' } }
       " | nc -NU $SRC_SOCK
==
(echo "migrate_set_capability x-ignore-shared on"; echo
"migrate_set_capability validate-uuid on"; echo "migrate
exec:cat>migfile-s390x"; echo "quit") | ./qemu-system-s390x -bios
/tmp/migration-test-16K1Z2/bootsect -monitor stdio
==
$QEMU ... -qmp unix:${DST_SOCK},server,wait=off
./qemu/scripts/qmp/qmp-shell $DST_SOCK
==
$QEMU ...
C-a c
(qemu) info migrate

>> > * So multifd mechanism can be used to transfer non-ram data as well? I
>> > thought it's only used for RAM migration. Are device/gpu states etc
>> > bits also transferred via multifd threads?
>> >
>> device state migration with multifd has been merged for 10.0
>>
>> <rant>
>> If it were up to me, we'd have a pool of multifd threads that transmit
>> everything migration-related.
>
> * Same my thought: If multifd is to be used for all data, why not use
> the existing QEMU thread pool  OR  make it a migration thread pool.
> IIRC, there is also some discussion about having a thread pool for
> VFIO or GPU state transfer. Having so many different thread pools does
> not seem right.
>

To be clear, multifd is not meant to transfer all data. It was designed
to transfer RAM pages and later got extended to deal with VFIO device
state. It _could_ be further extended for all device states (vmstate)
and it _could_ be further extended to handle control messages from the
main migration thread (QEMU_VM_*, postcopy commands, etc). My opinion is
that it would be interesting to have this kind of flexibility (at some
point). But it might turn out that it doesn't make sense technically,
it's costly in terms of development time, etc.

I think we all agree that having different sets of threads managed in
different ways is not ideal. The thing with multifd is that it's very
important to keep the performance and constraints of ram migration. If
we manage to achieve that with some generic thread pool, that's
great. But it's an exploration work that will have to be done.

>> Unfortunately, that's not so
>> straight-forward to implement without rewriting a lot of code, multifd
>> requires too much entanglement from the data producer. We're constantly
>> dealing with details of data transmission getting in the way of data
>> production/consumption (e.g. try to change ram.c to produce multiple
>> pages at once and watch everyting explode).
>
> * Ideally there should be separation between what the client is doing
> and how migration is working.
>
> * IMO, migration is a mechanism to transfer byte streams from one
> machine to another. And while doing so, facilitate writing (data) at
> specific addresses/offsets on the destination, not just append bytes
> at the tail end. This entails that each individual migration packet
> specifies where to write data on the destination. Let's say a
> migration stream is a train of packets. Each packet has a header and
> data.
>
>      ( [header][...data...] )><><( [header][...data...] )><><(
> [header][data] )><>< ... ><><( [header][data] )
>

But then there's stuff like mapped-ram which wants its data free of any
metadata because it mirrors the RAM layout in the migration file.

> Header specifies:
>     - Serial number
>     - Header length
>     - Data length/size (2MB/4MB/8MB etc.)

I generally like the idea of having the size of the header/data
specified in the header itself. It does seem like it would allow for
better extensibility over time. I spent a lot of time looking at those
"unused" bytes in MultiFDPacket_t trying to figure out a way of
embedding the size information in a backward-compatible way. We ended up
going with Maciej's idea of isolating the common parts of the header in
the MultiFDPacketHdr_t and having each data type define it's own
specific sub-header.

I don't know how this looks like in terms of type-safety and how we'd
keep compatibility (two separate issues) because a variable-size header
needs to end up in a well-defined structure at some point. It's
generally more difficult to maintain code that simply takes a buffer and
pokes at random offsets in there.

Even with the length, an old QEMU would still not know about extra
fields.

>     - Destination address <- offset where to write migration data, if
> it is zero(0) append that data
>     - Data type (optional): Whether it is RAM/Device/GPU/CPU state etc.
>     - Data iteration number <- version/iteration of the same RAM page
>     ...   more variables
>     ...   more variables

This is all in the end client-centric, which means it is "data" from the
migration perspective. So the question I put earlier still remains, what
determines the kind of data that goes in the header and the kind of data
that goes in the data part of the packet? It seems we cannot escape from
having the client bring it's own header format.

>     - Some reserved bytes
> Migration data is:
>     - Just a data byte stream <= Data length/size above.
>
> * Such a train of packets is then transferred via 1 thread or 10
> threads is an operational change.
> * Such a packet is pushed (Precopy) from source to destination  OR
> pulled (Postcopy) by destination from the source side is an
> operational difference. In Postcopy phase, it could send a message
> saying I need the next RAM packet for this offset and RAM module on
> the source side provides only relevant data. Again packaging and
> transmission is done by the migration module. Similarly the Postcopy
> phase could send a message saying I need the next GPU packet, and the
> GPU module on the source side would provide relevant data.
> * How long such a train of packets is, is also immaterial.
> * With such a separation, things like synchronisation of threads is
> not connected to the data (RAM/GPU/CPU/etc.) type.
> * It may also allow us to apply compression/encryption uniformly
> across all channels/threads, irrespective of the data type.
> * Since migration is a packet transport mechanism,
> creation/modification/destruction of packets could be done by one
> entity. Clients (like RAM/GPU/CPU/VFIO etc.) shall only supply 'data'
> to be packaged and sent. It shouldn't be like RAM.c writes its own
> pakcets as they like, GPU.c writes their own packets as they like,
> that does not seem right.
>

Right, so we'd need an extra abstraction layer with a well defined
interface to convert a raw packet into something that's useful for the
clients. The vmstate macros actually do that work kind of well. A device
emulation code does not need to care (too much) about how migration
works as long as the vmstate is written properly.

>  >> +- A packet which is the final result of all the data aggregation
>> >> +  and/or transformation. The packet contains: a *header* with magic and
>> >> +  version numbers and flags that inform of special processing needed
>> >> +  on the destination; a *payload-specific header* with metadata referent
>> >> +  to the packet's data portion, e.g. page counts; and a variable-size
>> >> +  *data portion* which contains the actual opaque payload data.
>
> * Thread synchronisation and other such control messages could/should
> be a separate packets of its own, to be sent on the main channel.

Remember that currently the control data is put raw on the stream, it is
not encapsulated by a packet. This would increase the amount of data put
on the stream, which might affect throughput.

> Thread synchronisation flags could/should not be combined with the
> migration data packets above. Control message packets may have _no
> data_ to be processed. (just sharing thoughts)
>

Yeah, the MULTIFD_FLAG_SYNC used to be part of a data packet and it was
utterly confusing to debug sync issues like that. Peter did the work to
make it a standalone (no data) packet.

> Thank you.
> ---
>   - Prasad

