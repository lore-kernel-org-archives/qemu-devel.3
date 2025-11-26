Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D10D10F34
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEuf-0004ZC-Ns; Wed, 26 Nov 2025 07:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vOEu1-0003pM-Qt
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:45:51 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vOEty-0004Gx-Pw
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:45:45 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB3465BE31;
 Wed, 26 Nov 2025 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764161138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCughnpcAJRZqqspfZy7ji09PmMK25B8lrAcumHnTTU=;
 b=O7e1WsNGWGZJiWujdrSCG4D02gyShoBrgSqlaiQ/OvYmXaPgiIEfIaR+WxLJgx73gkpCUU
 tlcngrSYHJIu8qH7rejUwK/DoLKojT9G6rDOdj3cANEcm5+21AgNyhrrekRIDJH1/ncmz9
 DSTyoCqfLkDP++F97466n+lOTzQGwZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764161138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCughnpcAJRZqqspfZy7ji09PmMK25B8lrAcumHnTTU=;
 b=/XPNDuFA6L+HBRqiVa4EcneDu2cg84hbUo/+NW88E6orEcKmAUCarBgXshEBezAlLq2z6f
 PqLv5qBryVSbCrCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1764161138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCughnpcAJRZqqspfZy7ji09PmMK25B8lrAcumHnTTU=;
 b=O7e1WsNGWGZJiWujdrSCG4D02gyShoBrgSqlaiQ/OvYmXaPgiIEfIaR+WxLJgx73gkpCUU
 tlcngrSYHJIu8qH7rejUwK/DoLKojT9G6rDOdj3cANEcm5+21AgNyhrrekRIDJH1/ncmz9
 DSTyoCqfLkDP++F97466n+lOTzQGwZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1764161138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WCughnpcAJRZqqspfZy7ji09PmMK25B8lrAcumHnTTU=;
 b=/XPNDuFA6L+HBRqiVa4EcneDu2cg84hbUo/+NW88E6orEcKmAUCarBgXshEBezAlLq2z6f
 PqLv5qBryVSbCrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 266D13EA63;
 Wed, 26 Nov 2025 12:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rE/9NXH2Jml0WAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Nov 2025 12:45:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Pawel Zmarzly <pzmarzly0@gmail.com>, qemu-devel@nongnu.org,
 michel@michel-slm.name
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
In-Reply-To: <aSYt4MUUESAcThrr@x1.local>
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
 <aSYE_rdMhH36KBxf@x1.local> <87tsyheqpv.fsf@suse.de>
 <aSYt4MUUESAcThrr@x1.local>
Date: Wed, 26 Nov 2025 09:45:35 -0300
Message-ID: <87o6opdksw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,michel-slm.name];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Tue, Nov 25, 2025 at 06:40:12PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Nov 25, 2025 at 05:46:49PM +0000, Pawel Zmarzly wrote:
>> >> Snapshots made with mapped-ram and x-ignore-shared flags are
>> >> not parsed properly.
>> >> 
>> >> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
>> >> ---
>> >>  migration/ram.c | 5 +++++
>> >>  1 file changed, 5 insertions(+)
>> >> 
>> >> diff --git a/migration/ram.c b/migration/ram.c
>> >> index 29f016cb25..85fdc810ab 100644
>> >> --- a/migration/ram.c
>> >> +++ b/migration/ram.c
>> >> @@ -4277,6 +4277,11 @@ static int parse_ramblocks(QEMUFile *f, ram_addr_t total_ram_bytes)
>> >>          id[len] = 0;
>> >>          length = qemu_get_be64(f);
>> >>  
>> >> +        if (migrate_ignore_shared()) {
>> >> +            /* Read and discard the x-ignore-shared memory region address */
>> >> +            qemu_get_be64(f);
>> >> +        }
>> >> +
>> >>          block = qemu_ram_block_by_name(id);
>> >>          if (block) {
>> >>              ret = parse_ramblock(f, block, length);
>> >> -- 
>> >> 2.52.0
>> >> 
>> >
>> > Thanks for the patch, though the u64 was parsed in parse_ramblock()
>> > instead.  Would you consider refactoring that function instead?
>> 
>> There's actually not much going on in terms of "parsing" in
>> parse_ramblock(). I think we could move the migrate_ignore_shared() from
>> the end of the function to before the mapped-ram check().
>
> Yes, that's also what I meant if it wasn't clear.. it was parsed into a
> hwaddr, and it was used to verify the addresses match.
>
> If that check is needed for ignore-shared blocks, then these checks should
> also apply when mapped-ram is enabled on top of whatever ramblock got
> ignored during migration.
>

Right, because ignore_shared implies putting the MR address in the
stream, but there is still the matter of whether the pages will actually
be read on the destination.

Should ram_save_setup() use RAMBLOCK_FOREACH_NOT_IGNORED instead of
RAMBLOCK_FOREACH_MIGRATABLE? I don't immediately see why not...

> Since the discussion started, I am actually not sure if we do this all
> right for two things..
>
> (1) When mapped-ram is enabled, do we actually need to setup those
>     ramblocks in mapped_ram_setup_ramblock()?
>
>     That is, when a ramblock returns migrate_ram_is_ignored()==true, IIUC
>     we don't need to allocate bitmap or page chunks for it?
>
>     We likely don't need to change this easily, because this will change
>     file format.. I'm also not sure if this is a major issue, logically
>     when ignore-shared is used we normally shouldn't need mapped-ram.. vice
>     versa.  So I may need to better understand the use case first on
>     enabling the two..
>

Thanks, Peter. A keen eye, as usual. I was searching for this reasoning
when looking at the code, but it missed me.

I looked back at the very first version of fixed-ram, which wasn't
authored by me and there is indeed no mention or expectation of handling
shared ram. So I think this is at this point unspecified.

What is the current impact of having those pages in? We're "just"
wasting cycles writing to the file, AFAICS. We'd better, at least,
sanitise that part to avoid the extra work.

> (2) Is the check proper on validating mr->addr didn't change?
>
>     This is a question on the check itself when ignore-shared enabled,
>     with/without mapped-ram enabled.  That is, I question whether this
>     check is useful or valid at all:
>     
>     if (migrate_ignore_shared()) {
>         hwaddr addr = qemu_get_be64(f);
>         if (migrate_ram_is_ignored(block) &&
>             block->mr->addr != addr) {
>             error_report("Mismatched GPAs for block %s "
>                          "%" PRId64 "!= %" PRId64, block->idstr,
>                          (uint64_t)addr, (uint64_t)block->mr->addr);
>             return -EINVAL;
>         }
>     }
>

I agree with all you say below, but I think an earlier question would
be: why put the address on the stream in the first place? Is this just
hardening of some sort?

The commit the introduces the feature has me wondering:

fbd162e629 ("migration: Add an ability to ignore shared RAM blocks")

  during save:
  
  +        if (migrate_ignore_shared()) {
  +            qemu_put_be64(f, block->mr->addr);
  +            qemu_put_byte(f, ramblock_is_ignored(block) ? 1 : 0);
  +        }

  during load:
  +    if (ramblock_is_ignored(block)) {
           error_report("block %s should not be migrated !", id);
           return NULL;
       }

If we know it's ignored, why send anything at all? (also, "to ignore"
has a meaning, we should stick to it)

>     In the error, it said "GPA", but mr->addr isn't GPA.. it's the offset
>     of the MR within the MR's parent container MR..  So if the parent is
>     the root MR / system_memory, then it is the GPA, however I don't see it
>     guaranteed..
>

Looking at the initial commit, I think this is all sanity check, maybe
to ensure some sort of stream compatibility. Or to make sure the stream
is stateful and we're not confusing an ignored block with an
(incorrectly) ignored one.

>     My gut feeling is we almost always rely on proper QEMU cmdlines anyway
>     to make migration work.  I wonder if we should just remove this check
>     (in case it might break when mr's parent isn't the root MR).
>

I believe it's ok to remove the check. I wish we had a compatible way to
remove handling of ignored blocks altogether, but I guess this u64 is
now on the stream forever?

> This is irrelevant of this specific fix, so it doesn't need to block a
> repost..

