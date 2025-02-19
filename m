Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5282DC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 17:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tknmB-0005MR-R7; Wed, 19 Feb 2025 12:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tknm3-0005Le-Ez
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:22:15 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tknm0-0001Eo-4q
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 12:22:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAEF5210F0;
 Wed, 19 Feb 2025 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739985729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9Y2AfxkVYdfKI6NrgDEA0bAUEv5HyWfTr/DBLUMUM4=;
 b=s2I9OrVjFLR1OhK41kdWm0rwKBx9W9FLUWfybZoFZ8aCWsYjIsEW/5uuEPT0XBiD8N2oej
 y8aJWUMrvc6wQKTaLozkOnaJoTTgGSxCzu/ToD9ooCwgpzteVlYP5/zbvHdSZhSTAHyw+U
 BjQo5szCGoFy960dLOytssZHXoyvPv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739985729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9Y2AfxkVYdfKI6NrgDEA0bAUEv5HyWfTr/DBLUMUM4=;
 b=5xRPcdXWEh/NbwjPgZmJLKrNxW4ALu5FR7AZ+EKOWo5tiRf85AFoM6bIH7x3wTK0UKPQIT
 mCQya06fj+H0YHAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s2I9OrVj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5xRPcdXW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739985729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9Y2AfxkVYdfKI6NrgDEA0bAUEv5HyWfTr/DBLUMUM4=;
 b=s2I9OrVjFLR1OhK41kdWm0rwKBx9W9FLUWfybZoFZ8aCWsYjIsEW/5uuEPT0XBiD8N2oej
 y8aJWUMrvc6wQKTaLozkOnaJoTTgGSxCzu/ToD9ooCwgpzteVlYP5/zbvHdSZhSTAHyw+U
 BjQo5szCGoFy960dLOytssZHXoyvPv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739985729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9Y2AfxkVYdfKI6NrgDEA0bAUEv5HyWfTr/DBLUMUM4=;
 b=5xRPcdXWEh/NbwjPgZmJLKrNxW4ALu5FR7AZ+EKOWo5tiRf85AFoM6bIH7x3wTK0UKPQIT
 mCQya06fj+H0YHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4300E13715;
 Wed, 19 Feb 2025 17:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FOrTAEETtmdbWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 19 Feb 2025 17:22:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v6 2/4] migration: enable multifd and postcopy together
In-Reply-To: <CAE8KmOyy=ybDaRFpFr0DTJWScyjCX+99PKHzLibv6zhtUpw8Ng@mail.gmail.com>
References: <20250215123119.814345-1-ppandit@redhat.com>
 <20250215123119.814345-3-ppandit@redhat.com> <87y0y4tf5q.fsf@suse.de>
 <CAE8KmOxYE=10+xjMjH5ZhbMmRJHgxJKHj2wH-nB-qiBSHEVh1w@mail.gmail.com>
 <878qq39vu3.fsf@suse.de>
 <CAE8KmOyy=ybDaRFpFr0DTJWScyjCX+99PKHzLibv6zhtUpw8Ng@mail.gmail.com>
Date: Wed, 19 Feb 2025 14:22:06 -0300
Message-ID: <87r03t97ep.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CAEF5210F0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> Hello Fabiano,
>
> On Tue, 18 Feb 2025 at 19:52, Fabiano Rosas <farosas@suse.de> wrote:
>> Do you concede that this code has a hidden assumption? Either that
>> migrate_multifd() != migrate_postcopy_preempt() or that multifd channels
>> must be set up before postcopy preempt channel? Because that is enough
>> for us to have to do something about it. Either restructuring or a
>> comment explaining.
>
> * Not a hidden assumption, but it is an observation that 'main' and
> 'multifd' channels are established before 'postcopy' ones. And for new
> migration to start, it is necessary that 'main' and 'multifd' channels
> (when enabled) are established before migration starts.
>
>> > * When does postcopy preempt channel creation race with the multifd
>> > channel creation?
>>
>> For instance, postcopy_do_resume() has this comment:
>>     /*
>>      * If preempt is enabled, re-establish the preempt channel.  Note that
>>      * we do it after resume prepare to make sure the main channel will be
>>      * created before the preempt channel.  E.g. with weak network, the
>>      * dest QEMU may get messed up with the preempt and main channels on
>>      * the order of connection setup.  This guarantees the correct order.
>>      */
>> It looks like if the main channel can race, so do the multifd channels,
>> no? In any case, I'm fine with just documenting any assumption for now.
>
> * The first requirement for this race to occur is that two types of
> channels are created together at the same time. Let's see:
>
>    * Postcopy migration:  without multifd enabled
>       - 'main' channel is created before the migration starts. And
> 'postcopy' channels are created towards the end of precopy migration,
> when the Postcopy phase starts. So in this scenario the race does not
> happen.
>
>    * Postcopy resume: without multifd enabled
>       - As described in the comment above, preempt channel is created
> _after_ the 'main' channel to avoid the race condition.
>
>    * Postcopy migration: with multifd enabled
>       - 'main' and 'multifd' channels are created before migration
> starts. And 'postcopy' channels are created towards the end of precopy
> migration, when the Postcopy phase starts. No race occurs.
>
>    * Postcopy resume: with multifd enabled
>       - 'multifd' channels are shutdown before Postcopy starts, ie. no
> 'multifd' channels exist during Postcopy resume. So no race between
> 'postcopy' and 'multifd' channels.
>       - And 'postcopy' channels are created after the 'main' channel
> to avoid the race between them.
>       - postcopy_do_resume() does not seem to create 'multifd' channels.
>
>    * Multifd migration: without Postcopy enabled
>       - 'main' and 'multifd' channels are created before the migration
> starts. They both send 'magic value' bytes, so are easier to
> differentiate. No race occurs.
>

I don't see anything stopping postcopy_start() from being called in the
source in relation to multifd recv threads being setup in the
destination. So far it seems possible that the source is opening the
preempt channel while multifd still hasn't seen all threads. There's
also pre-7.2 machines which create the postcopy channel early.

>
>> > * migration_needs_multiple_sockets() => return migrate_multifd() ||
>> > migrate_postcopy_preempt();
>> >
>> Nope, this is just saying whether a single channel is expected, or more
>> than one.
>
> * If we read it as a question:
>     - migration_needs_multiple_sockets() ? True => Yes, migration
> needs multiple sockets.
>     - migration_needs_multiple_sockets() ? False => No, migration does
> not need multiple sockets.
>
> Then it should return 'True' when both migrate_multifd() and
> postcopy_preempt() are enabled.
>

Why?

>>That's why I think it would be a good gate for this peeking
>> code. Since postcopy preempt could be a peekable channel, it's
>> misleading to put it all behind QIO_CHANNEL_FEATURE_READ_MSG_PEEK
>> only. This is a time-bomb for the next person to refactor this code.
>
> * Postcopy preempt could be a peekable channel ? Currently it does not
> send magic value, does it?
>

Peekable means it can read ahead and rollback without consuming that
part of the stream. We need it because there's code later on that will
validate the MAGIC.

>> Right, but that's not what we have today. Changing this requires
>> figuring out how to keep the stream compatible when channels now start
>> sending extra stuff at the start. It's not trivial. There's also
>> mapped-ram which is asynchronous and there might be something special to
>> be done about the TLS handshake, I'm not sure.
>
> * True, it's not trivial.
>
>> Well, aside from preempt, they're *not* dependent on the order. That's
>> the point of having to do all of this dance. In fact we might be better
>> off if we could serialize the connections somehow.
>>
>> I havent't followed this series closely, could you point me to the
>> discussion that led to the channels concept being introduced?
>
> * Channels concept was not introduced in this series. It has been
> there since the beginning, no?
>

I thought you meant the CH_MAIN stuff. So now I don't know what you
mean. You want to do away with multifd?

>> Yes. They *can* be used without multifd. The comment would explain that
>> at that point in the code, these are the only types possible. So as to
>> not mislead future readers that whenever tls/file, then multifd must be
>> used.
> ....
>> See? Multifd mutually exclusive with postcopy preempt. You carried that
>> assumption (well done), but made it more subtle (not good), since
>> if/else is by definition showing the relationship between the two while
>> migration_has_main_and_multifd_channels() makes it hidden under the
>> multifd check allowing the last return true to happen.
>>
>> If we're enabling multifd along with postcopy, we need to be aware that
>> the relationship with preempt might not hold true anymore.
>
> * Sorry, I did not get that. Enabling them together means that they
> are _not_ exclusive, no? It is not Either 'multifd'  OR 'postcopy'
> case, anymore.
>

Yes, as we're seeing, there's this assumption that multifd is never
enabled along with postcopy_preempt. Now with multifd+postcopy we need
to be careful to stop the places where that assumption was made.

>>>Not sure if/how that works really. It is possible that currently
>>> these (tls/file) channels are used only with migrate_multifd() enabled
>>> and so are processed with multifd_recv_new_channel() function. The
>>> current patch handles them the same way.
>>
>> That's the entire point I'm making when I ask to not omit the else
>> clauses.
>
> * ie. we set 'channel = CH_MAIN' in the final else clause as well? - Okay.
>
>> Do you think this series can work without touching the channel discovery
>> code? As I said earlier, I'm missing a bit of context, but to me it
>> seems it cannot.
>
> * The reason we need to touch the channel discovery part is: with
> 'multifd' and 'postcopy' both enabled, towards the end of migration,
> when 'postcopy' connection comes in
>      migration_ioc_process_incoming(...)
>     {
>         if (migrate_multifd() && !migrate_mapped_ram() &&
> !migrate_postcopy_ram() &&
>              qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
>              ...
>          } else {
>              default_channel = !mis->from_src_file;
>          }
>         ...
>         if (migrate_multifd()) {
>             multifd_recv_new_channel(ioc, &local_err);
>         } else {
>            postcopy_preempt_new_channel(mis, f);
>         }
>     }
>
> * The first 'if (migrate_multifd() ... !migrate_postcopy_ram()')
> evaluates to false, in the else part 'default_channel' also evaluates
> to false, because the 'main' channel is established. Now the new
> incoming connection falls in the second migrate_multifd() block and
> gets processed via - multifd_recv_new_channel(ioc, &local_err); call
> and migration would not complete/finish.
>
> * To identify the incoming postcopy connection, in the very first
> version of this series, a magic value for the postcopy channel was
> introduced and everything else remained the same.
>
> * Would that be an acceptable solution for now?
>

Continue with this patch and fix the stuff I mentioned. You can ignore
the first two paragraphs of that reply.

https://lore.kernel.org/r/87y0y4tf5q.fsf@suse.de

I still think we need to test that preempt + multifd scenario, but it
should be easy to write a test for that once the series is in more of a
final shape.

>> If instead of this refactoring you want to start working on a model for
>> consistent channel advertisement, then that's fine. But we'll have to
>> put this series on hold (which is also fine). It also looks like it
>> could be considerably more work, although I haven't looked at it in
>> detail. Granted, it's work that makes sense, instead of the heuristics
>> we have today.
>
> * IMHO, we need not put this series on hold, for now we could go ahead
> with the postcopy magic value patch if that works. And the larger
> overhaul of the channel discovery part could be done as a separate
> series of its own.
>

We can't add magic values, as we've discussed.

> Thank you.
> ---
>   - Prasad

