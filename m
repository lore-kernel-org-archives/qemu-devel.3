Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F193D69108
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeR5-0006QO-DN; Thu, 28 Nov 2024 08:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGeR2-0006Q0-HC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:19:57 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGeR0-0006TC-DT
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:19:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDB4121166;
 Thu, 28 Nov 2024 13:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732799990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2GEK6K9A6tmQ9T3Vk3m8LifcftLnhQ5KTm4lXgqlT8=;
 b=uymXOYvqJRHSX3MUOz6Zv/zVmfnR//ZUvBFJEE4UvTHneK9Q5chW4ug8Xr9cP4XivfIx2b
 E1ZmlYnmVcSyfhJMG8rSrWoR3//v39n/OfjyTMUZyvOBETqEoEIvfxiIG86Ijd9lFh92b2
 F1hinLcTFG0HhXRz56KHxBS8ZVoGmeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732799990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2GEK6K9A6tmQ9T3Vk3m8LifcftLnhQ5KTm4lXgqlT8=;
 b=rBSqYc5cBHooVg5b22k3+W+uEYNOoPh0GvQnf5G/X6N9Onu1IRMYk5/FXvlHAzLFOgkH1s
 33dwG4cjoC98+PDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732799990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2GEK6K9A6tmQ9T3Vk3m8LifcftLnhQ5KTm4lXgqlT8=;
 b=uymXOYvqJRHSX3MUOz6Zv/zVmfnR//ZUvBFJEE4UvTHneK9Q5chW4ug8Xr9cP4XivfIx2b
 E1ZmlYnmVcSyfhJMG8rSrWoR3//v39n/OfjyTMUZyvOBETqEoEIvfxiIG86Ijd9lFh92b2
 F1hinLcTFG0HhXRz56KHxBS8ZVoGmeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732799990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2GEK6K9A6tmQ9T3Vk3m8LifcftLnhQ5KTm4lXgqlT8=;
 b=rBSqYc5cBHooVg5b22k3+W+uEYNOoPh0GvQnf5G/X6N9Onu1IRMYk5/FXvlHAzLFOgkH1s
 33dwG4cjoC98+PDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4194413690;
 Thu, 28 Nov 2024 13:19:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s+VwAvZtSGfsegAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 28 Nov 2024 13:19:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
In-Reply-To: <CAE8KmOzfaxzxTCMoF6miOG5fYFaikmz7sm9UeuAe6u1Optz8fg@mail.gmail.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com> <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <875xo8n4ue.fsf@suse.de>
 <CAE8KmOzfaxzxTCMoF6miOG5fYFaikmz7sm9UeuAe6u1Optz8fg@mail.gmail.com>
Date: Thu, 28 Nov 2024 10:19:47 -0300
Message-ID: <87y113jy18.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Wed, 27 Nov 2024 at 19:42, Fabiano Rosas <farosas@suse.de> wrote:
>> From e9110360eb0efddf6945f37c518e3cc38d12b600 Mon Sep 17 00:00:00 2001
>> From: Fabiano Rosas <farosas@suse.de>
>> Date: Wed, 27 Nov 2024 11:03:04 -0300
>> Subject: [PATCH] migration: Rationalize multifd flushes from ram code
>>
>> We currently have a mess of conditionals to achieve the correct
>> combination of multifd local flushes, where we sync the local
>> (send/recv) multifd threads between themselves, and multifd remote
>> flushes, where we put a flag on the stream to inform the recv side to
>> perform a local flush.
>>
>> On top of that we also have the multifd_flush_after_each_section
>> property, which is there to provide backward compatibility from when
>> we used to flush after every vmstate section.
>>
>> And lastly, there's the mapped-ram feature which always wants the
>> non-backward compatible behavior and also does not support extraneous
>> flags on the stream (such as the MULTIFD_FLUSH flag).
>>
>> Move the conditionals into a separate function that encapsulates and
>> explains the whole situation.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/ram.c | 198 ++++++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 157 insertions(+), 41 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 05ff9eb328..caaaae6fdc 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1277,6 +1277,149 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
>>      return pages;
>>  }
>>
>> +enum RamMultifdFlushSpots {
>> +    FLUSH_SAVE_SETUP,
>> +    FLUSH_SAVE_ITER,
>> +    FLUSH_DIRTY_BLOCK,
>> +    FLUSH_SAVE_COMPLETE,
>> +
>> +    FLUSH_LOAD_POSTCOPY_EOS,
>> +    FLUSH_LOAD_POSTCOPY_FLUSH,
>> +    FLUSH_LOAD_PRECOPY_EOS,
>> +    FLUSH_LOAD_PRECOPY_FLUSH,
>> +};
>> +
>> +static int ram_multifd_flush(QEMUFile *f, enum RamMultifdFlushSpots spot)
>> +{
>> +    int ret;
>> +    bool always_flush, do_local_flush, do_remote_flush;
>> +    bool mapped_ram = migrate_mapped_ram();
>> +
>> +    if (!migrate_multifd()) {
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * For backward compatibility, whether to flush multifd after each
>> +     * section is sent. This is mutually exclusive with a
>> +     * RAM_SAVE_FLAG_MULTIFD_FLUSH on the stream
>> +     */
>> +    always_flush = migrate_multifd_flush_after_each_section();
>> +
>> +    /*
>> +     * Save side flushes
>> +     */
>> +
>> +    do_local_flush = false;
>> +
>> +    switch (spot) {
>> +    case FLUSH_SAVE_SETUP:
>> +        assert(!bql_locked());
>> +        do_local_flush = true;
>> +        break;
>> +
>> +    case FLUSH_SAVE_ITER:
>> +        /*
>> +         * This flush is not necessary, only do for backward
>> +         * compatibility. Mapped-ram assumes the new scheme.
>> +         */
>> +        do_local_flush = always_flush && !mapped_ram;
>> +        break;
>> +
>> +    case FLUSH_DIRTY_BLOCK:
>> +        /*
>> +         * This is the flush that's actually required, always do it
>> +         * unless we're emulating the old behavior.
>> +         */
>> +        do_local_flush = !always_flush || mapped_ram;
>> +        break;
>> +
>> +    case FLUSH_SAVE_COMPLETE:
>> +        do_local_flush = true;
>> +        break;
>> +
>> +    default:
>> +        break;
>> +    }
>> +
>> +    if (do_local_flush) {
>> +        ret = multifd_ram_flush_and_sync();
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    /*
>> +     * There's never a remote flush with mapped-ram because any flags
>> +     * put on the stream (aside from RAM_SAVE_FLAG_MEM_SIZE and
>> +     * RAM_SAVE_FLAG_EOS) break mapped-ram's assumption that ram pages
>> +     * can be read contiguously from the stream.
>> +     *
>> +     * On the recv side, there's no local flush, even at EOS because
>> +     * mapped-ram does its own flush after loading the ramblock.
>> +     */
>> +    if (mapped_ram) {
>> +        return 0;
>> +    }
>> +
>> +    do_remote_flush = false;
>> +
>> +    /* Save side remote flush */
>> +    switch (spot) {
>> +    case FLUSH_SAVE_SETUP:
>> +        do_remote_flush = !always_flush;
>> +        break;
>> +
>> +    case FLUSH_SAVE_ITER:
>> +        do_remote_flush = false;
>> +        break;
>> +
>> +    case FLUSH_DIRTY_BLOCK:
>> +        do_remote_flush = do_local_flush;
>> +        break;
>> +
>> +    case FLUSH_SAVE_COMPLETE:
>> +        do_remote_flush = false;
>> +        break;
>> +
>> +    default:
>> +        break;
>> +    }
>> +
>> +    /* Put a flag on the stream to trigger a remote flush */
>> +    if (do_remote_flush) {
>> +        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> +        qemu_fflush(f);
>> +    }
>> +
>> +    /*
>> +     * Load side flushes.
>> +     */
>> +
>> +    do_local_flush = false;
>> +
>> +    switch (spot) {
>> +    case FLUSH_LOAD_PRECOPY_EOS:
>> +    case FLUSH_LOAD_POSTCOPY_EOS:
>> +        do_local_flush = always_flush;
>> +        break;
>> +
>> +    case FLUSH_LOAD_PRECOPY_FLUSH:
>> +    case FLUSH_LOAD_POSTCOPY_FLUSH:
>> +        do_local_flush = true;
>> +        break;
>> +
>> +    default:
>> +        break;
>> +    }
>> +
>> +    if (do_local_flush) {
>> +        multifd_recv_sync_main();
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>>  {
>>      if (!multifd_queue_page(block, offset)) {
>> @@ -1323,19 +1466,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>>          pss->page = 0;
>>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>>          if (!pss->block) {
>> -            if (migrate_multifd() &&
>> -                (!migrate_multifd_flush_after_each_section() ||
>> -                 migrate_mapped_ram())) {
>> -                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>> -                int ret = multifd_ram_flush_and_sync();
>> -                if (ret < 0) {
>> -                    return ret;
>> -                }
>> -
>> -                if (!migrate_mapped_ram()) {
>> -                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> -                    qemu_fflush(f);
>> -                }
>> +            int ret = ram_multifd_flush(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel,
>> +                                        FLUSH_DIRTY_BLOCK);
>> +            if (ret < 0) {
>> +                return ret;
>>              }
>>
>>              /* Hit the end of the list */
>> @@ -3065,18 +3199,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>      }
>>
>>      bql_unlock();
>> -    ret = multifd_ram_flush_and_sync();
>> +    ret = ram_multifd_flush(f, FLUSH_SAVE_SETUP);
>>      bql_lock();
>>      if (ret < 0) {
>>          error_setg(errp, "%s: multifd synchronization failed", __func__);
>>          return ret;
>>      }
>>
>> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
>> -        && !migrate_mapped_ram()) {
>> -        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> -    }
>> -
>>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>>      ret = qemu_fflush(f);
>>      if (ret < 0) {
>> @@ -3209,12 +3338,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>>
>>  out:
>>      if (ret >= 0 && migration_is_running()) {
>> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
>> -            !migrate_mapped_ram()) {
>> -            ret = multifd_ram_flush_and_sync();
>> -            if (ret < 0) {
>> -                return ret;
>> -            }
>> +
>> +        ret = ram_multifd_flush(f, FLUSH_SAVE_ITER);
>> +        if (ret < 0) {
>> +            return ret;
>>          }
>>
>>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>> @@ -3283,7 +3410,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>          }
>>      }
>>
>> -    ret = multifd_ram_flush_and_sync();
>> +    ret = ram_multifd_flush(f, FLUSH_SAVE_COMPLETE);
>>      if (ret < 0) {
>>          return ret;
>>      }
>> @@ -3797,14 +3924,11 @@ int ram_load_postcopy(QEMUFile *f, int channel)
>>              }
>>              break;
>>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
>> -            multifd_recv_sync_main();
>> +            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_FLUSH);
>>              break;
>>          case RAM_SAVE_FLAG_EOS:
>>              /* normal exit */
>> -            if (migrate_multifd() &&
>> -                migrate_multifd_flush_after_each_section()) {
>> -                multifd_recv_sync_main();
>> -            }
>> +            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_EOS);
>>              break;
>>          default:
>>              error_report("Unknown combination of migration flags: 0x%x"
>> @@ -4237,19 +4361,11 @@ static int ram_load_precopy(QEMUFile *f)
>>              }
>>              break;
>>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
>> -            multifd_recv_sync_main();
>> +            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_FLUSH);
>>              break;
>>          case RAM_SAVE_FLAG_EOS:
>>              /* normal exit */
>> -            if (migrate_multifd() &&
>> -                migrate_multifd_flush_after_each_section() &&
>> -                /*
>> -                 * Mapped-ram migration flushes once and for all after
>> -                 * parsing ramblocks. Always ignore EOS for it.
>> -                 */
>> -                !migrate_mapped_ram()) {
>> -                multifd_recv_sync_main();
>> -            }
>> +            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_EOS);
>>              break;
>>          case RAM_SAVE_FLAG_HOOK:
>>              ret = rdma_registration_handle(f);
>> --
>> 2.35.3
>>
>
> * This does not seem to solve for complexity. When reading/following
> code, it is easier to see 3-4 conditions and work them to check if the
> full expression is 'true' or 'false', that is not doable here.

You miss the point that people also need to understand the code, not
only tell whether it results in true or false. These syncs are all
related and we'd like to be able to reason about them in a single place,
not in several little pieces all over the place. When a new feature
comes up, like it did when mapped-ram was introduced, we don't want to
go around having to squint at conditionals to know whether it applies to
the new case or not.

Also, ram.c is not the place for open-coded multifd code. The same
mapped-ram example applies: having to add if (migrate_mapped_ram())
throughout the ram code was a pain and we had some iterations of
flipping the logic until we got it right.

>
> * fflush(1) is just flushing buffered content into (or out of) the
> stream IIUC, why do we have to tie it to a specific spot? At any time
> it is going to do the same thing: flush available data to (or out of)
> the stream.
>

There is no fflush() going on here. This code is about the multifd
flush, which sends the remaining data from MultiFDPages_t and the
multifd sync, which synchronizes the multifd threads. That qemu_fflush
is just to make sure the destination sees flag on the stream.

> * Could we separate out send side fflush(1) from the receive side
> fflush(1) operations? Writing a flag in the stream on the send side to
> trigger fflush(1) on the receive side is weird; Data stream need not
> say when to fflush(1). Let the sender and receiver decide when they
> want to fflush(1) and fsync(1) data, no? Maybe that'll help to
> reduce/solve the complexity of long conditionals? ie. if we are able
> to fflush(1) and fsync(1) without any condition?

There is no flush on the receive side. The RAM_SAVE_FLAG_MULTIFD_FLUSH
flag is there to indicate to the destination that at that point in the
stream the source has done a flush + sync operation and the destination
should sync it's threads as well.

