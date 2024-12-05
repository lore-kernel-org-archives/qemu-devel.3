Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BE3E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJCt-0004Vv-8M; Thu, 05 Dec 2024 16:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJJCr-0004VQ-57
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:16:17 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJJCp-0002sn-79
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:16:16 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CE8D1F37C;
 Thu,  5 Dec 2024 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733433370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCzzmwH+qWmJr3FqIA0xXzUGmmRBmF9JtkbfML9wI8I=;
 b=vWFQvMEJnyFuiZokUghrG8p83e9g2aC20xwBNMh2LuXf3lqANjeGDXYdr1S4FOJg4J50/s
 WbXiQoopRVsDiDt3PE7jrYOxRYJQnz9gUwV87Bn9Pjp0z7XYLNh/mDzuDZnDK0mVgHqQ70
 LLaPVRpb36DDdZWxznEhY9vBZEO15uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733433370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCzzmwH+qWmJr3FqIA0xXzUGmmRBmF9JtkbfML9wI8I=;
 b=5aEVmHUUOjwGUiXvEisL3gyemO11u3NDZtbSiJ6zZ8aMhpEXTmaDc0/5VrWxTnOhzshGhE
 d32a8Vj5qHcLD/DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733433369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCzzmwH+qWmJr3FqIA0xXzUGmmRBmF9JtkbfML9wI8I=;
 b=v8iqc8eM4EskpWwLk3/FhnN4wcmUyMFCsVF2mIwHBjKqihtcCI/HXca4MCH5zE9KrEC9pT
 4F0HXCaY+XUSObw/Lpu79Ule81KE5Yn+r1jT3IRn2J7J18nobNUQVx9mJbU6Ou/GcBH4Bi
 G332F7XIabDl63m9PAqFP8Vq4PFdyMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733433369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCzzmwH+qWmJr3FqIA0xXzUGmmRBmF9JtkbfML9wI8I=;
 b=Stfi4hUTVb6oTsUgR8CN7QsxpGEzUv39VOU2L5ZCFLo4tKtir7TT0vhitWamqAsyjGmC2o
 BDwGQfcrw90hM8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3DB6132EB;
 Thu,  5 Dec 2024 21:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +4YIGhgYUmcNWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Dec 2024 21:16:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration/multifd: Further remove the SYNC on complete
In-Reply-To: <Z1ILpzQk6Q8d1cpg@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-2-peterx@redhat.com> <878qstj46b.fsf@suse.de>
 <Z1ILpzQk6Q8d1cpg@x1n>
Date: Thu, 05 Dec 2024 18:16:05 -0300
Message-ID: <87jzcdde5m.fsf@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On Thu, Dec 05, 2024 at 04:55:08PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Commit 637280aeb2 ("migration/multifd: Avoid the final FLUSH in
>> > complete()") removed the FLUSH operation on complete() which should avoid
>> > one global sync on destination side, because it's not needed.
>> >
>> > However that commit overlooked multifd_ram_flush_and_sync() part of things,
>> > as that's always used together with the FLUSH message on the main channel.
>> 
>> Let's please write the full name of the flags, functions, etc. As we've
>> seen in the discussion with Prasad, we're stumbling over ambiguous
>> terminology. This is RAM_SAVE_FLAG_MULTIFD_FLUSH.
>
> Sure.
>
>> 
>> >
>> > For very old binaries (multifd_flush_after_each_section==true), that's
>> > still needed because each EOS received on destination will enforce
>> > all-channel sync once.
>> 
>> Ok, but why does this patch not reinstate the flag?
>
> RAM_SAVE_FLAG_MULTIFD_FLUSH?  Because it's not needed?
>

Ah, you're saying we need the source side to send the MULTIFD_FLAG_SYNC
packet so that the old QEMU on the recv side gets out of waiting. I
see.

>> 
>> >
>> > For new binaries (multifd_flush_after_each_section==false), the flush and
>> > sync shouldn't be needed just like the FLUSH, with the same reasoning.
>> >
>> > Currently, on new binaries we'll still send SYNC messages on multifd
>> > channels, even if FLUSH is omitted at the end.  It'll make all recv threads
>> > hang at SYNC message.
>> 
>> I don't get this part, is this a bug you're describing? There's not SYNC
>> message on the recv side, I think you mean the MULTIFD_FLAG_SYNC and
>> this code?
>> 
>>     if (flags & MULTIFD_FLAG_SYNC) {
>>         qemu_sem_post(&multifd_recv_state->sem_sync);
>>         qemu_sem_wait(&p->sem_sync);
>>     }
>
> Yes.
>
>> 
>> That's not a hang, that's the sync.
>
> When recv side never collect that SYNC (by invoke multifd_recv_sync_main),
> then it is a hang.
>

Right, I forget the sync on the recv is the other way around. It's the
multifd_recv_state that does the sync between the threads. The sem_sync
is there so that the channels don't exit.

>> 
>> >
>> > Multifd is still all working fine because luckily recv side cleanup
>> > code (mostly multifd_recv_sync_main()) is smart enough to make sure even if
>> > recv threads are stuck at SYNC it'll get kicked out.  And since this is the
>> > completion phase of migration, nothing else will be sent after the SYNCs.
>> 
>> Hmm, a last sync on the recv side might indeed not be needed.
>> 
>> >
>> > This may be needed for VFIO in the future because VFIO can have data to
>> > push after ram_save_complete(), hence we don't want the recv thread to be
>> > stuck in SYNC message. Remove this limitation will make src even slightly
>> > faster too to avoid some more code.
>> >
>> > Stable branches do not need this patch, as no real bug I can think of that
>> > will go wrong there.. so not attaching Fixes to be clear on the backport
>> > not needed.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/ram.c | 13 ++++++++++---
>> >  1 file changed, 10 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index 05ff9eb328..7284c34bd8 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -3283,9 +3283,16 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>> >          }
>> >      }
>> >  
>> > -    ret = multifd_ram_flush_and_sync();
>> > -    if (ret < 0) {
>> > -        return ret;
>> > +    if (migrate_multifd() &&
>> > +        migrate_multifd_flush_after_each_section()) {
>> > +        /*
>> > +         * Only the old dest QEMU will need this sync, because each EOS
>> > +         * will require one SYNC message on each channel.
>> > +         */
>> > +        ret = multifd_ram_flush_and_sync();
>> > +        if (ret < 0) {
>> > +            return ret;
>> > +        }
>> 
>> I don't think this works. We need one last flush to not lose the last
>> few pages of ram. And we need the src side sync of multifd threads to
>> make sure this function doesn't return before all IO has been put on the
>> wire.
>
> This should be the question for commit 637280aeb2, I thought it got
> answered there.. It's almost what the commit message there in 637280aeb2
> wanted to justify too.

Yeah, it missed the mark.

>
> We don't need to flush the last pages here, because we flushed it already,
> in the last find_dirty_block() call where src QEMU finished scanning the
> last round.  Then we set complete_round=true, scan one more round, and the
> iteration won't complete until the new round sees zero dirty page.

Ok, let's put this in the commit message. As it stands it looks like
this patch is fixing a bug with 637280aeb2 when instead it's doing
further optimization, but so it happens that we still require the
backward compatibility part.

>
> So when reaching this line, multifd send buffer must be empty.  We need to
> flush for each round of RAM scan, we can't avoid the flush there, but we
> can save this one in complete().
>
> To explain that with code, I hacked a QEMU and assert that.  It ran all
> fine here (this is definitely not for merge.. but to show what I meant):
>
> ===8<===
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index f64c4c9abd..0bd42c7627 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -21,7 +21,7 @@
>  #include "qemu/error-report.h"
>  #include "trace.h"
>
> -static MultiFDSendData *multifd_ram_send;
> +MultiFDSendData *multifd_ram_send;
>
>  size_t multifd_ram_payload_size(void)
>  {
> diff --git a/migration/ram.c b/migration/ram.c
> index 7284c34bd8..edeb9e28ff 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3228,6 +3228,8 @@ out:
>      return done;
>  }
>
> +extern MultiFDSendData *multifd_ram_send;
> +
>  /**
>   * ram_save_complete: function called to send the remaining amount of ram
>   *
> @@ -3283,6 +3285,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>
> +    if (migrate_multifd()) {
> +        assert(multifd_payload_empty(multifd_ram_send));
> +    }
> +
>      if (migrate_multifd() &&
>          migrate_multifd_flush_after_each_section()) {
>          /*
> ===8<===
>
>> 
>> This also doesn't address what the commit message says about the recv
>> side never getting the RAM_SAVE_FLAG_MULTIFD_FLUSH message.
>
> The new binaries now always not send RAM_SAVE_FLAG_MULTIFD_FLUSH when
> complete(), however it always sends the multifd SYNC messages on the wire.
> It means those SYNC messages will always arrive on dest multifd channels,
> and then all these channels will wait for the main thread to collect that.
> However since RAM_SAVE_FLAG_MULTIFD_FLUSH is not there, they'll hang until
> multifd recv cleanups.

