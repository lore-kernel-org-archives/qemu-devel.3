Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AF5C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 14:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkOUX-0006Iz-0H; Tue, 18 Feb 2025 09:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkOUP-0006Ig-JC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:22:22 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tkOUM-0004c0-Cr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:22:20 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB6221F745;
 Tue, 18 Feb 2025 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739888535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwTdsibJ41J0vPdT1zQ4Ja8MCfPdVwKml1MpWfbPggY=;
 b=OfW9C1Q9ig9EIduYkzvy1I8dGPtOXRLcbY5EyqAM4dnQug29Z43l0ZxV1NpP5+aY8A7VKQ
 ayKUcj5OvgltF65c9kkg03PPvTCm+lrgmqOOeVIlyfN+NIIL1dU5iZGWhOVwkGf5Zq8nNV
 mjRTkVl+SjyGKTg1ceU6Bu6fKPijHlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739888535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwTdsibJ41J0vPdT1zQ4Ja8MCfPdVwKml1MpWfbPggY=;
 b=xYQ6GqBRKulqujk5lGFfg+NdslJJW0sTAJ/IXYzrUskzEHAvcngQ316Z2io6fKx5iABQ1Y
 fEimjUEx9ztcFbAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OfW9C1Q9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xYQ6GqBR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739888535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwTdsibJ41J0vPdT1zQ4Ja8MCfPdVwKml1MpWfbPggY=;
 b=OfW9C1Q9ig9EIduYkzvy1I8dGPtOXRLcbY5EyqAM4dnQug29Z43l0ZxV1NpP5+aY8A7VKQ
 ayKUcj5OvgltF65c9kkg03PPvTCm+lrgmqOOeVIlyfN+NIIL1dU5iZGWhOVwkGf5Zq8nNV
 mjRTkVl+SjyGKTg1ceU6Bu6fKPijHlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739888535;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwTdsibJ41J0vPdT1zQ4Ja8MCfPdVwKml1MpWfbPggY=;
 b=xYQ6GqBRKulqujk5lGFfg+NdslJJW0sTAJ/IXYzrUskzEHAvcngQ316Z2io6fKx5iABQ1Y
 fEimjUEx9ztcFbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4273B132C7;
 Tue, 18 Feb 2025 14:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ya50AJeXtGcWYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 18 Feb 2025 14:22:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
In-Reply-To: <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com> <87y0y4tf5q.fsf@suse.de>
 <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
Date: Tue, 18 Feb 2025 11:22:12 -0300
Message-ID: <878qq39vu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CB6221F745
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: permerror client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
> On Tue, 18 Feb 2025 at 03:20, Fabiano Rosas <farosas@suse.de> wrote:
>> > -static bool migration_should_start_incoming(bool main_channel)
>> > +static bool migration_has_main_and_multifd_channels(void)
>> >  {
> ...
>> > +    /* main channel and all multifd channels are established */
>> >      return true;
>> >  }
>>
>> How will this avoid peeking the preempt channel? You're assuming preempt
>> is mutually exclusive with multifd it seems. Otherwise you could get the
>> preempt channel creation racing with multifd channels creation.
>
> * IIUC postcopy preempt channel is created towards the end of the
> migration when the Postcopy phase starts. At that time, the 'main' and
> 'multifd' channels are already established and working. Having the
> 'main' and when multifd is enabled 'multifd' channels in place is a
> requirement for starting new migration. So when both the 'main' and
> 'multifd' channels are established, the new incoming connection is
> seen as the 'postcopy' one; And it falls to the 'else' block of the
> 'if' conditional ->  if (!migration_has_main_and_multifd_channels()) {
>

Do you concede that this code has a hidden assumption? Either that
migrate_multifd() != migrate_postcopy_preempt() or that multifd channels
must be set up before postcopy preempt channel? Because that is enough
for us to have to do something about it. Either restructuring or a
comment explaining.

> * When does postcopy preempt channel creation race with the multifd
> channel creation?
>

Well, taking that this is the destination side, I don't think we can
predict when the other end of the migration will open a channel, can we?
For instance, postcopy_do_resume() has this comment:

    /*
     * If preempt is enabled, re-establish the preempt channel.  Note that
     * we do it after resume prepare to make sure the main channel will be
     * created before the preempt channel.  E.g. with weak network, the
     * dest QEMU may get messed up with the preempt and main channels on
     * the order of connection setup.  This guarantees the correct order.
     */

It looks like if the main channel can race, so do the multifd channels,
no?

In any case, I'm fine with just documenting any assumption for now.

>> > @@ -989,13 +983,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>> > +    if (!migration_has_main_and_multifd_channels()) {
>> I'm not entirely sure we need these checks here. They will happen anyway
>> later. Could this be replaced by migration_needs_multiple_sockets()
>> instead?
>
> * migration_needs_multiple_sockets() => return migrate_multifd() ||
> migrate_postcopy_preempt();
>
> * That logical OR should have been AND, no? It returns true even when
> one of them is true. That's not multiple types (multifd/postcopy) of
> sockets. I don't think it helps much.
>

Nope, this is just saying whether a single channel is expected, or more
than one. That's why I think it would be a good gate for this peeking
code. Since postcopy preempt could be a peekable channel, it's
misleading to put it all behind QIO_CHANNEL_FEATURE_READ_MSG_PEEK
only. This is a time-bomb for the next person to refactor this code.

> * Let's try this:
>     - First differentiation: peekable Vs non-peekable channels

As I said above, this is not entirely what we're doing.

>     - Peekable channels
>          - Main
>          - Multifd
>     - Non-peekable channels
>          - Postcopy preempt
>          - TLS
>          - File/mapped_ram
>
>     if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK))
>     {
>             if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
>                 channel = CH_MAIN;
>             } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
>                 channel = CH_MULTIFD;
>     } else {
>             if (!strcmp(ioc->name, "migration-tls-incoming")
>                 || !strcmp(ioc->name, "migration-file-incoming"))) {
>                channel = CH_MULTIFD;
>             } else {
>                channel = CH_POSTCOPY;
>             }
>     }
>
> * With above, the 'main' channel shall have to send 'magic value' even
> for reconnection during the postcopy recovery phase. If all channels
> were consistent and sent a magic value, this code would be much
> simpler and we may not have to care/worry about the _order_ in which
> these connections are made.
>

Right, but that's not what we have today. Changing this requires
figuring out how to keep the stream compatible when channels now start
sending extra stuff at the start. It's not trivial. There's also
mapped-ram which is asynchronous and there might be something special to
be done about the TLS handshake, I'm not sure.

>    if (channel == 'main')
>        process_main_channel()
>    else if (channel == 'multifd')
>        process_multifd_channel()
>    else if (channel == 'tls')
>        process_tls_channel()
>     else if (channel == 'file')
>        process_file_channel()
>     else if (channel == 'postcopy')
>        process_postcopy_channel()
>
>> And I'd put this whole channel discovery business in channel.c since
>> it's encoding several assumptions about channels. Some helpers used here
>> might need to be exported, but that's ok.
>>
>> Also, please make a separate patch, we need to be really confident that
>> changing the discovery code around won't introduce any regression, and
>> if it does, we'll want it separate from the postcopy+multifd
>> enablement. It's ok if you have the patch assume that multifd+postcopy
>> will happen later in the series.
>
> * TBH, I think we have complicated this whole thing with multiple
> channel types, their inconsistent behaviour and dependence on the
> _order_ in which connections are made. Do we really need channel
> types? Could we consider rationalising them?
>

Well, aside from preempt, they're *not* dependent on the order. That's
the point of having to do all of this dance. In fact we might be better
off if we could serialize the connections somehow.

I havent't followed this series closely, could you point me to the
discussion that led to the channels concept being introduced?

>> > +        if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>> >          /*
>> >           * With multiple channels, it is possible that we receive channels
>> >           * out of order on destination side, causing incorrect mapping of
>> > @@ -1006,42 +999,58 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>> >           * tls handshake while initializing main channel so with tls this
>> >           * issue is not possible.
>> >           */
>>
>> This comment block needs to be indented properly.
>>
>> > -        ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
>> > -                                          sizeof(channel_magic), errp);
>> > +            ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
>> > +                                              sizeof(channel_magic), errp);
>> > +            if (ret != 0) {
>> > +                return;
>> > +            }
>> >
>> > -        if (ret != 0) {
>> > -            return;
>> > +            if (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC)) {
>> > +                channel = CH_MAIN;
>> > +            } else if (channel_magic == cpu_to_be32(MULTIFD_MAGIC)) {
>> > +                channel = CH_MULTIFD;
>> > +            } else if (!mis->from_src_file
>> > +                        && mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
>>
>> The usual style is to keep the && on the previous line.
>>
>> > +                /* reconnect default channel for postcopy recovery */
>>
>> s/default/main/
>
> * Okay, will fix these.
>
>
>> > +                channel = CH_MAIN;
>> > +            } else {
>> > +                error_report("%s: unknown channel magic: %u",
>> > +                                __func__, channel_magic);
>> > +                return;
>>
>> This needs to set errp instead of reporting.
>
> * Okay.
>
>> > +            }
>> > +        } else if (mis->from_src_file
>> > +                && (!strcmp(ioc->name, "migration-tls-incoming")
>> > +                || !strcmp(ioc->name, "migration-file-incoming"))) {
>> > +            channel = CH_MULTIFD;
>>
>> This is quite misleading. These channels are used without multifd as
>> well. For instance, file-backed fd migration goes past this because
>> !mis->from_src_file but it still uses the file channel.
>>
>> I agree with Peter that checking for channel names is not ideal. I don't
>> see an alternative at the moment (hiding the assumption is of course not
>> a fix). Maybe check migrate_multifd() here and explain in a comment that
>> at the moment, the non-peekable channels happen to be used with multifd
>> only.
>
> * The first paragraph says these channels are used without
> migrate_multifd(); And the second paragraph says they are used with
> migrate_multifd() only....??

Yes. They *can* be used without multifd. The comment would explain that
at that point in the code, these are the only types possible. So as to
not mislead future readers that whenever tls/file, then multifd must be
used.

> ===
> } else {
>         /* Multiple connections */
>         assert(migration_needs_multiple_sockets());
>         if (migrate_multifd()) {
>             multifd_recv_new_channel(ioc, &local_err);
>         } else {
>             assert(migrate_postcopy_preempt());
>             f = qemu_file_new_input(ioc);
>             postcopy_preempt_new_channel(mis, f);
>         }

See? Multifd mutually exclusive with postcopy preempt. You carried that
assumption (well done), but made it more subtle (not good), since
if/else is by definition showing the relationship between the two while
migration_has_main_and_multifd_channels() makes it hidden under the
multifd check allowing the last return true to happen.

If we're enabling multifd along with postcopy, we need to be aware that
the relationship with preempt might not hold true anymore.

> ===
> * IIUC in the current code, when migrate_multifd() is true, these
> channels get processed via - multifd_recv_new_channel(). And when
> migrate_multifd() is false, it falls to postcopy_preempt_new_channel()
> part.

This relies on the fact that the management layer will certainly have
set multifd on both sides of the migration and that multifd will not be
used with postcopy.

>Not sure if/how that works really. It is possible that currently
> these (tls/file) channels are used only with migrate_multifd() enabled
> and so are processed with multifd_recv_new_channel() function. The
> current patch handles them the same way.
>

That's the entire point I'm making when I ask to not omit the else
clauses. The tls and file channels can be the main channel as well, but
that is never explicit in the code. That uint8 channel = CH_MAIN up
there is doing some heavy-lifting.

> * About checking channel names, in the non-peekable category above,
> how do we differentiate between 'TLS', 'File' and 'Postcopy' channels?
> Without magic values, we don't have much choice really.

Indeed.

> And seeing
> those names in the code also tells the reader that 'TLS' and 'File'
> channels are processed as CH_MULTIFD via - multifd_recv_new_channel().

We shouldn't rely on the underlying iochannel type. That's why they
expose the QIO_CHANNEL_FEATUREs. It's fine if we double check at that
point that the channels are either file/tls, but that cannot be the
algorithm. The current code can work without relying on it after all and
I don't think your postcopy enablement affects that particular part.

>
>> No else clause here and in the rest of the patch makes this is as opaque
>> as the previous version, IMO. We need to define what's supposed to
>> happen whenever the conditionals don't match. Is it an error,
>> g_assert_not_reached(), a fallthrough? Better to set CH_MAIN explicitly
>> wherenever that's the case.
>
> * I'd say let's treat unmatched conditions as an error and return.
>
>> > -        default_channel = (channel_magic == cpu_to_be32(QEMU_VM_FILE_MAGIC));
>> > -    } else {
>> > -        default_channel = !mis->from_src_file;
>> > +    } else if (mis->from_src_file) {
>> > +        channel = CH_POSTCOPY;
>> >      }
>>
>> Same here.
>
> * Here final else means the main channel (mis->from_src_file) is not
> established, so it defaults to CH_MAIN.
>

Yes, but let's make it explicit. We have this thing in our minds now. In
6 months time no one remembers anything anymore.

>>
>> You could check CH_POSTCOPY first in the block above this one and return
>> early.
>>
>
> * Okay.
>
> * My request is the same - let's think about having consistent channel
> behaviour. The restructuring and overhauling of the channel processing
> part could be done separately, outside the current scope of enabling
> multifd+postcopy together with this series. Let's not try to fix
> everything in one go, in one series.
>

Ok, no one is asking for this to be done in one go. You're free to split
any side efforts into a new series and proceed with that. Having to do
prerequisite work is pretty common.

Do you think this series can work without touching the channel discovery
code? As I said earlier, I'm missing a bit of context, but to me it
seems it cannot.

If instead of this refactoring you want to start working on a model for
consistent channel advertisement, then that's fine. But we'll have to
put this series on hold (which is also fine). It also looks like it
could be considerably more work, although I haven't looked at it in
detail. Granted, it's work that makes sense, instead of the heuristics
we have today.

>
> Thank you.
> ---
>   - Prasad

