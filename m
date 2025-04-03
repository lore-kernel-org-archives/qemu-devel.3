Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B37C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KAe-0007VM-QC; Thu, 03 Apr 2025 08:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KAc-0007V7-94
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:59:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0KAa-0003KR-2A
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:59:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2695C211AD;
 Thu,  3 Apr 2025 12:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUTJRJE0WGzkpNa4S7MCQYpdpK1riCenJC02j4PL1fE=;
 b=rnlrao3BeE15E4G//YrLefOIt9ajwYbmhvWl+8mqi5OFSLEjWcz9AtRuELYRhhwJIhSsZ3
 gsvQ0yt03yL1KNcn/OzFG7UyGqP5TmslJxOKcjqP5ilahQ5OQz9xI36F8sxaHACv8BAtw/
 H9OED6MiVF9YKV/nayx/wdxvlV7jz8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUTJRJE0WGzkpNa4S7MCQYpdpK1riCenJC02j4PL1fE=;
 b=DgE5cmIeGcJ5xweZ41CvRG/8f/+vm1ATk8cPVfmbfhgbQo/S5nXsO97i/54PAg2yOGp+ZB
 cA7JqQi84avcR6DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rnlrao3B;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DgE5cmIe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743685178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUTJRJE0WGzkpNa4S7MCQYpdpK1riCenJC02j4PL1fE=;
 b=rnlrao3BeE15E4G//YrLefOIt9ajwYbmhvWl+8mqi5OFSLEjWcz9AtRuELYRhhwJIhSsZ3
 gsvQ0yt03yL1KNcn/OzFG7UyGqP5TmslJxOKcjqP5ilahQ5OQz9xI36F8sxaHACv8BAtw/
 H9OED6MiVF9YKV/nayx/wdxvlV7jz8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743685178;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kUTJRJE0WGzkpNa4S7MCQYpdpK1riCenJC02j4PL1fE=;
 b=DgE5cmIeGcJ5xweZ41CvRG/8f/+vm1ATk8cPVfmbfhgbQo/S5nXsO97i/54PAg2yOGp+ZB
 cA7JqQi84avcR6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 912761392A;
 Thu,  3 Apr 2025 12:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a0fnEzmG7md3OAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Apr 2025 12:59:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v8 2/7] migration: Refactor channel discovery mechanism
In-Reply-To: <CAE8KmOzASSXE9FRmiFQ6Q4fxaGFh_8VWKXgnugjEs+egFuQPpA@mail.gmail.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <20250318123846.1370312-3-ppandit@redhat.com> <87y0wlkzvs.fsf@suse.de>
 <CAE8KmOzASSXE9FRmiFQ6Q4fxaGFh_8VWKXgnugjEs+egFuQPpA@mail.gmail.com>
Date: Thu, 03 Apr 2025 09:59:34 -0300
Message-ID: <878qohl7t5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2695C211AD
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
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hello Fabiano,
>
> On Mon, 31 Mar 2025 at 20:31, Fabiano Rosas <farosas@suse.de> wrote:
>> > +    } else if (mis->from_src_file) {
>> This is redundant.
>
> * This was to ensure (double check) that when the Postcopy connection
> comes in, the main channel is established. Also a couple of versions
> back migration qtest was failing without this check. Nonetheless,
> qtests do work now without this check. I'll remove it if we must.
>

Yes, there's no point. if we already have main and multifd channels,
what's left must be postcopy.

>> > +        channel = CH_POSTCOPY;
>> >      } else {
>> > -        default_channel = !mis->from_src_file;
>> > +        channel = CH_MAIN;
>>
>> And this is impossible.
>
>     -> https://lore.kernel.org/qemu-devel/20250215123119.814345-1-ppandit@redhat.com/T/#m18b6bf30e877f9eafaa67bba6a209b47782f6eac
>
> * Yes, but a couple of revisions back you suggested adding it saying
> CH_MAIN assignment at the top was doing some heavy lifting and it's
> more clear this way.
>

Well, but don't add it blindly if it doesn't make sense. The point was
to not end the conditional at 'else if' because that makes the reader
have to go look around the code to see what was already assigned. Here
we want just a plain:

else {
    channel = CH_POSTCOPY; 
}

>> We should probably expand migration_incoming_setup() to make it clear
>> that mis->from_src_file is set at this point. And
>> assert(!mis->from_src_file). I can send a patch on top later.
>
> * migration_incoming_setup uses the QEMUFile object only when
> mis->from_src_file is not set. I'm wondering if we really need an
> assert(!mis->from_src_file) check? Because it'll reach here only when
> channel == CH_MAIN and channel is set to CH_MAIN only when
> mis->from_src_file is NULL.
>
>

Given the:

if (!mis->from_src_file) {

I think someone (back in 2017) thought it was possible to reach there
with from_src_file already set. I don't know whether that applied to
this path. In any case, for this function I believe the correct is
assert because we shouldn't have two channels arriving as main.

>> > -    } else {
>> > +    } else if (channel == CH_MULTIFD) {
>> >          /* Multiple connections */
>> > -        assert(migration_needs_multiple_sockets());
>> >          if (migrate_multifd()) {
>>
>> This should be an assert.
>
> Same, 'channel' is set to CH_MULTIFD,  only when migrate_multifd() is
> enabled. Do we need another assert(migrate_multifd()) check?
>

Maybe not, but we definitely cannot just ignore if it happens and we
also should not have an empty check that is always known to be true. So
either assert or remove the if entirely.

>> > +    } else if (channel == CH_POSTCOPY) {
>> > +        assert(migrate_postcopy_preempt());
>> > +        assert(!mis->postcopy_qemufile_dst);
>> > +        f = qemu_file_new_input(ioc);
>> > +        postcopy_preempt_new_channel(mis, f);
>> > +        return;
>> >      }
>> >
>> > -    if (migration_should_start_incoming(default_channel)) {
>> > +    if (migration_has_main_and_multifd_channels()) {
>>
>> I think there's a bug here. Excluding multifd from the picture, if only
>> the main channel needs to be setup, then it's possible to start postcopy
>> recovery twice, once when the main channel appears and another time when
>> the preempt channel appears.
>
> * When the preempt channel appears 'channel' is set to CH_POSTCOPY, so
> it shall 'return' before reaching here, right?
>

You're right, I missed the return statement.

> ===
>         } else if (!mis->from_src_file &&
>                         mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
>                 /* reconnect main channel for postcopy recovery */
>                 channel = CH_MAIN;
>         } else {
> ===
> * When 'main' channel connection arrives for postcopy recovery,
> 'channel' shall be set to CH_MAIN.
>
>> The previous code worked differently because it did:
>>
>> if (migrate_postcopy_preempt()) {
>>     return main_channel;
>>
>> which would return false when preempt arrived after main.
>
> * Yes.
>
>> We could use migration_has_all_channels() instead, that would look more
>> logically correct, but it would also change the current behavior that
>> postcopy recovery can start before the preempt channel is in place. I'm
>> not even sure if that's actually part of the design of the feature.
>
> * Not sure if we need this.
>
> Thank you.
> ---
>   - Prasad

