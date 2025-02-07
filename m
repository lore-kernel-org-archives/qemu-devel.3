Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17BCC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 14:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgPAP-0006XJ-Cx; Fri, 07 Feb 2025 09:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPA4-0006Vr-5v
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:16:55 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tgPA1-0003Eg-1I
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 09:16:51 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 624E421160;
 Fri,  7 Feb 2025 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738937805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JgaRctii7xd80iGcWxLrv0Kahdr/XJqeoW8QI4X9RzQ=;
 b=cKOpfrq3+b6PNhBpWcK1Kczz16IHdhTmMi2tcz3xbP8wLzW35ax29IgwXq9EokNj2Cl7e0
 0FGb36837tyyr6/AT8V7rjiRcHuJC/g3lh1EReMbJANoByREvxIywrS94yZhPN3E4Fv5yu
 C222mR1Yyh+NhMjyQSAoeKDDOLppa4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738937805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JgaRctii7xd80iGcWxLrv0Kahdr/XJqeoW8QI4X9RzQ=;
 b=AuFjy86jOYuut5Q6NAMMskh3kNiCrtJ+nRtZSJc+AYBKX5Wcb0oQAmqTtJUW8vuTDPpTQE
 mAWdEyUmk8JpwzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738937805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JgaRctii7xd80iGcWxLrv0Kahdr/XJqeoW8QI4X9RzQ=;
 b=cKOpfrq3+b6PNhBpWcK1Kczz16IHdhTmMi2tcz3xbP8wLzW35ax29IgwXq9EokNj2Cl7e0
 0FGb36837tyyr6/AT8V7rjiRcHuJC/g3lh1EReMbJANoByREvxIywrS94yZhPN3E4Fv5yu
 C222mR1Yyh+NhMjyQSAoeKDDOLppa4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738937805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JgaRctii7xd80iGcWxLrv0Kahdr/XJqeoW8QI4X9RzQ=;
 b=AuFjy86jOYuut5Q6NAMMskh3kNiCrtJ+nRtZSJc+AYBKX5Wcb0oQAmqTtJUW8vuTDPpTQE
 mAWdEyUmk8JpwzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C021F139CB;
 Fri,  7 Feb 2025 14:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1p0FH8wVpmfGNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 07 Feb 2025 14:16:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Eric Blake
 <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Joao
 Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
In-Reply-To: <Z6YS95V5RA9-UmGl@x1.local>
References: <87zfj0mcmy.fsf@suse.de> <87wme4m8ci.fsf@suse.de>
 <192db6a6-f3ff-4cf9-8537-b849fb3a97b3@maciej.szmigiero.name>
 <87tt97ma9l.fsf@suse.de>
 <ac6f56c0-58d9-45a4-bbf4-6b28649a8952@maciej.szmigiero.name>
 <87msezm75y.fsf@suse.de>
 <eba9c2d2-5a20-489c-aa89-8adde2781c7a@maciej.szmigiero.name>
 <87jza3m12b.fsf@suse.de> <Z6Uu50gzSIgKsiLA@x1.local>
 <87cyftnbc0.fsf@suse.de> <Z6YS95V5RA9-UmGl@x1.local>
Date: Fri, 07 Feb 2025 11:16:41 -0300
Message-ID: <87a5axn8l2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Feb 07, 2025 at 10:17:19AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Feb 06, 2025 at 02:32:12PM -0300, Fabiano Rosas wrote:
>> >> > In any case we'd still need some kind of a compatibility behavior for
>> >> > the TLS bit stream emitted by older QEMU versions (which is always
>> >> > improperly terminated).
>> >> >
>> >> 
>> >> There is no compat issue. For <= 9.2, QEMU is still doing an extra
>> >> multifd_send_sync_main(), which results in an extra MULTIFD_FLAG_SYNC on
>> >> the destination and it gets stuck waiting for the
>> >> RAM_SAVE_FLAG_MULTIFD_FLUSH that never comes. Therefore the src always
>> >> closes the connection before dst reaches the extra recv().
>> >> 
>> >> I test migration both ways with 2 previous QEMU versions and the
>> >> gnutls_bye() series passes all tests. I also put an assert at
>> >> tlssession.c and never triggers for GNUTLS_E_PREMATURE_TERMINATION. The
>> >> MULTIFD_FLAG_EOS should behave the same.
>> >
>> > Which are the versions you tried?  As only 9.1 and 9.2 has 637280aeb2, so I
>> > wonder if the same issue would hit too with 9.0 or older.
>> 
>> Good point. 9.0 indeed breaks.
>> 
>> >
>> > I'd confess I feel unreliable relying on the side effect of 637280aeb2,
>> > because fundamentally it works based on the fact that multifd threads need
>> > to be kicked out by the main load thread SYNC event on dest QEMU to avoid
>> > the readv() from going wrong.
>> >
>> 
>> We're relying on the opposite: mutlifd_recv NOT getting kicked. Which is
>> a bug that 1d457daf86 fixed.
>> 
>> > What I'm not sure here is, is it sheer luck that the main channel SYNC will
>> > always arrive _before_ pre-mature terminations of the multifd channels?  It
>> > sounds like it could also happen when the multifd channels got its
>> > pre-mature termination early, before the main thread got the SYNC.
>> 
>> You lost me here, what main channel sync? Its the MULTIFD_FLAG_SYNC that
>> puts the recv thread in the "won't see the termination" state and that
>> is serialized:
>> 
>>    SEND                        RECV
>>    -------------------------+----------------------------
>> 1  multifd_send_sync_main()
>> 2  pending_sync==true,
>> 3  send thread sends SYNC      recv thread gets SYNC
>> 4  <some work>                 recv gets stuck.
>> 5  multifd_send_shutdown()     <time passes>
>> 6  shutdown()                  multifd_recv_shutdown()
>>                                recv_terminate_threads()
>>                                recv exits without recv()
>> 
>> In other words, RECV would need to see the shutdown (6) before the SYNC
>> (3), which I don't think it possible.
>
> Ah yeah, I somehow remembered we sent a SYNC in the main channel but forgot
> to push the per-channel SYNC.  I got it the other way round.  Yeah if data
> is always ordered with shutdown() effect on recv then it seems in order.
>
>> 
>> >
>> > Maybe we still need a compat property at the end..
>> 
>> This is actually similar to preempt_pre_7_2, what about:
>> 
>>     /*
>>      * This variable only makes sense when set on the machine that is
>>      * the destination of a multifd migration with TLS enabled. It
>>      * affects the behavior of the last send->recv iteration with
>>      * regards to termination of the TLS session. Defaults to true.
>>      *
>>      * When set:
>>      *
>>      * - the destination QEMU instance can expect to never get a
>>      *   GNUTLS_E_PREMATURE_TERMINATION error. Manifested as the error
>>      *   message: "The TLS connection was non-properly terminated".
>>      *
>>      * When clear:
>>      *
>>      * - the destination QEMU instance can expect to see a
>>      *   GNUTLS_E_PREMATURE_TERMINATION error in any multifd channel
>>      *   whenever the last recv() call of that channel happens after
>>      *   the source QEMU instance has already issued shutdown() on the
>>      *   channel. This is affected by (at least) commits 637280aeb2
>>      *   and 1d457daf86.
>
> If we want to reference them after all, we could use another sentence to
> describe the effects:
>
>        *   Commit 637280aeb2 (since 9.1) introduced a side effect to cause
>        *   pre-mature termination not happen, while commit 1d457daf86
>        *   (since 10.0) can unexpectedly re-expose the pre-mature
>        *   termination issue.
>

I'll add this.

>>      *
>>      * NOTE: Regardless of the state of this option, a premature
>>      * termination of the TLS connection might happen due to error at
>>      * any moment prior to the last send->recv iteration.
>>      */
>>     bool multifd_clean_tls_termination;
>> 
>> And I think the more straight-forward implementation is to incorporate
>> Maciej's premature_ok patches (in some form), otherwise that option will
>> have to take effect on the QIOChannel which is a layering violation.
>
> If we take Dan's comment into account:
>
> https://lore.kernel.org/r/Z6I86e-hzJAlxk0r@redhat.com
>
> It means whenever multifd recv thread invokes the iochannel API it will use
> multifd_clean_tls_termination to decide QIO_CHANNEL_READ_RELAXED_EOF flag
> to pass in.  I hope this is not layer violation, or I could miss something..

Yes, we need that.

>
> So if we're on the same page we need that knob, to make this series easier
> we could make it two steps:
>
>   - Step 1: introduce the parameter and QIO_CHANNEL_READ_RELAXED_EOF, set
>     it default to false.
>
>   - Step 2: Your other RFC series to implement gnutls_bye(), at last make
>     it a compat property and switch default true.
>
> Then Maciej only needs step 1, it looks to me.

I'm sending everything as a v2 in a moment. We can cherry-pick from
there.

