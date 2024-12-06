Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8B4E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZp4-0000WG-Bw; Fri, 06 Dec 2024 10:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZp3-0000W1-Dq
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:00:49 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZp1-0001gV-Ok
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:00:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A882521111;
 Fri,  6 Dec 2024 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733497246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnLrcvMibtz9KTecAhrPlIsW4NgwLExJdP5gAC3O0i8=;
 b=bWCgHRWYMBruUdwtlLdrVpkV8ew2XG4EFi0XFMECjefy2VqiA45cR95FpKUCUGddjM36HR
 dopriKOKbU8BBeMy794+OnZ2U5OAAu7DVJDL0W2mzyBDS1XJKQC9vUPpK4N5/RCpXqB781
 LfkMWq3ZZNYi4ul3+57XzK9E4kxUzbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733497246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnLrcvMibtz9KTecAhrPlIsW4NgwLExJdP5gAC3O0i8=;
 b=t6ONV/ssxlQEo5Ju+zidVosjeq8CyLIg7S/Zmg4/9eNxz5pusqoqhUTpBv5uYGwBxG157Y
 bYOCA5vORoA7NWBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=G5OBs1RM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=esKcUgr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733497245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnLrcvMibtz9KTecAhrPlIsW4NgwLExJdP5gAC3O0i8=;
 b=G5OBs1RMMXDf24XvBv18j0ejvQDR3amPyNPdx8AjKoDcHplTiTcqolwciELcRGWJjJbafX
 sWNWm41CtgSnilo9Soa/Jj0Fb04lAW5BwZlZt4ufgkmhksOcEltBcFyQ2wURAhhklPIrt+
 o2QppjOGoT7v7Ds6TXKaZZ2E1dyhiTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733497245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PnLrcvMibtz9KTecAhrPlIsW4NgwLExJdP5gAC3O0i8=;
 b=esKcUgr62oBpFiP/gxox22AgIOVfLQz0+CqUdS+Gpf1mHj5I9S5dBdxOYxnyZvbyLapyyp
 xPovEaR91txNIxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F96E13647;
 Fri,  6 Dec 2024 15:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XJtdOZwRU2c4cwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 15:00:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 2/7] migration/multifd: Allow to sync with sender
 threads only
In-Reply-To: <Z1MPOQ6Tg_FVSiF9@x1n>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-3-peterx@redhat.com> <877c8dc58x.fsf@suse.de>
 <Z1MPOQ6Tg_FVSiF9@x1n>
Date: Fri, 06 Dec 2024 12:00:42 -0300
Message-ID: <87o71oc0v9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A882521111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

> On Fri, Dec 06, 2024 at 10:26:06AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Teach multifd_send_sync_main() to sync with threads only.
>> >
>> > We already have such requests, which is when mapped-ram is enabled with
>> > multifd.  In that case, no SYNC messages will be pushed to the stream when
>> > multifd syncs the sender threads because there's no destination threads
>> > waiting for that.  The whole point of the sync is to make sure all threads
>> > flushed their jobs.
>> 
>> s/flushed/finished/ otherwise we risk confusing people.
>
> done.
>
>> 
>> >
>> > So fundamentally we have a request to do the sync in different ways:
>> >
>> >   - Either to sync the threads only,
>> >   - Or to sync the threads but also with the destination side.
>> >
>> > Mapped-ram did it already because of the use_packet check in the sync
>> > handler of the sender thread.  It works.
>> >
>> > However it may stop working when e.g. VFIO may start to reuse multifd
>> > channels to push device states.  In that case VFIO has similar request on
>> > "thread-only sync" however we can't check a flag because such sync request
>> > can still come from RAM which needs the on-wire notifications.
>> >
>> > Paving way for that by allowing the multifd_send_sync_main() to specify
>> > what kind of sync the caller needs.  We can use it for mapped-ram already.
>> >
>> > No functional change intended.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/multifd.h        | 19 ++++++++++++++++---
>> >  migration/multifd-nocomp.c |  7 ++++++-
>> >  migration/multifd.c        | 15 +++++++++------
>> >  3 files changed, 31 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/migration/multifd.h b/migration/multifd.h
>> > index 50d58c0c9c..bd337631ec 100644
>> > --- a/migration/multifd.h
>> > +++ b/migration/multifd.h
>> > @@ -19,6 +19,18 @@
>> >  typedef struct MultiFDRecvData MultiFDRecvData;
>> >  typedef struct MultiFDSendData MultiFDSendData;
>> >  
>> > +typedef enum {
>> > +    /* No sync request */
>> > +    MULTIFD_SYNC_NONE = 0,
>> > +    /* Sync locally on the sender threads without pushing messages */
>> > +    MULTIFD_SYNC_LOCAL,
>> > +    /*
>> > +     * Sync not only on the sender threads, but also push "SYNC" message to
>> > +     * the wire (which is for a remote sync).
>> 
>> s/SYNC/MULTIFD_FLAG_SYNC/
>> 
>> Do we need to also mention that this needs to be paired with a
>> multifd_recv_sync_main() via the emission of the
>> RAM_SAVE_FLAG_MULTIFD_FLUSH flag on the stream?
>
> If we want to mention something, IMO it would be better about what happens
> on the src, not dest.  It can be too hard to follow if we connect that
> directly to the dest behavior.
>
> Does this look good to you?
>
>     /*
>      * Sync not only on the sender threads, but also push MULTIFD_FLAG_SYNC
>      * message to the wire for each iochannel (which is for a remote sync).
>      *
>      * When remote sync is used, need to be paired with a follow up
>      * RAM_SAVE_FLAG_EOS / RAM_SAVE_FLAG_MULTIFD_FLUSH message on the main
>      * channel.
>      */

Yes, thanks.


