Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B62D78326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7AP-0007Pa-9M; Mon, 02 Dec 2024 09:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tI7AN-0007PO-Bo
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:12:47 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tI7AL-00060w-Ik
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:12:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1A141F444;
 Mon,  2 Dec 2024 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733148760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/auXAY66ljEYwBu9srNoIXZUKKwsPcCt7X9gYppGVGc=;
 b=dvsYfozg32lGKV/6Y82T1gX8SYv/JIWOuaxnW+nLfLXgPh4/JALtgdNCTDLDc+pJRET8N7
 tryv2Yr+3oQ4neTVZ0tTeRj6rcDmY6DiSiOp18lfbNck693YsP5Q7PuRgwoQdE8IbHMT8x
 lr43BPi3keyFstAAKvQjSnyu7xl1vAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733148760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/auXAY66ljEYwBu9srNoIXZUKKwsPcCt7X9gYppGVGc=;
 b=Jg3jPbV9jn79y/GepDZ6vdyiAwWw6rw0RL0VXHsA91xAkY/2ex/YOi/HhHdYbGuRCZafwI
 bW7E1WvJB+PsboBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dvsYfozg;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Jg3jPbV9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733148760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/auXAY66ljEYwBu9srNoIXZUKKwsPcCt7X9gYppGVGc=;
 b=dvsYfozg32lGKV/6Y82T1gX8SYv/JIWOuaxnW+nLfLXgPh4/JALtgdNCTDLDc+pJRET8N7
 tryv2Yr+3oQ4neTVZ0tTeRj6rcDmY6DiSiOp18lfbNck693YsP5Q7PuRgwoQdE8IbHMT8x
 lr43BPi3keyFstAAKvQjSnyu7xl1vAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733148760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/auXAY66ljEYwBu9srNoIXZUKKwsPcCt7X9gYppGVGc=;
 b=Jg3jPbV9jn79y/GepDZ6vdyiAwWw6rw0RL0VXHsA91xAkY/2ex/YOi/HhHdYbGuRCZafwI
 bW7E1WvJB+PsboBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A13A13A31;
 Mon,  2 Dec 2024 14:12:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p5E5OFfATWeoGQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 14:12:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, Prasad
 Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
In-Reply-To: <CAE8KmOygGSr=DuWdeVppgxq9UN2XG0fmMEV+nO=Q=QXQb4m8oA@mail.gmail.com>
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com> <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <875xo8n4ue.fsf@suse.de>
 <CAE8KmOzfaxzxTCMoF6miOG5fYFaikmz7sm9UeuAe6u1Optz8fg@mail.gmail.com>
 <87y113jy18.fsf@suse.de>
 <CAE8KmOygGSr=DuWdeVppgxq9UN2XG0fmMEV+nO=Q=QXQb4m8oA@mail.gmail.com>
Date: Mon, 02 Dec 2024 11:12:37 -0300
Message-ID: <87a5dejhre.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: A1A141F444
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
> On Thu, 28 Nov 2024 at 18:50, Fabiano Rosas <farosas@suse.de> wrote:
>>>> We currently have a mess of conditionals to achieve the correct
>>>> combination of multifd local flushes, where we sync the local
>>>> (send/recv) multifd threads between themselves, and multifd remote
>>>> flushes, where we put a flag on the stream to inform the recv side to
>>>> perform a local flush.
> ...
>> >> +    if (do_local_flush) {
>> >> +        ret = multifd_ram_flush_and_sync();
>> >> +        if (ret < 0) {
>> >> +            return ret;
>> >> +        }
>> >> +    }
>> >> +
> ...
>> >> +    /* Put a flag on the stream to trigger a remote flush */
>> >> +    if (do_remote_flush) {
>> >> +        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> >> +        qemu_fflush(f);
>> >> +    }
>> >> +
>> >> +    if (do_local_flush) {
>> >> +        multifd_recv_sync_main();
>> >> +    }
> ...
>>These syncs are all related and we'd like to be able to reason about
>> them in a single place, not in several little pieces all over the place.
>> When a new feature comes up, like it did when mapped-ram was introduced,
>> we don't want to go around having to squint at conditionals to know whether
>> it applies to the new case or not.
>>
>> Also, ram.c is not the place for open-coded multifd code. The same
>> mapped-ram example applies: having to add if (migrate_mapped_ram())
>> throughout the ram code was a pain and we had some iterations of
>> flipping the logic until we got it right.
>
> * I see. If it is the larger complexity of how multifd threads do
> flush/sync, not just about long conditionals with 3-4 sub-expressions,
> I think this can be done separately, instead of as part of this patch
> series.
>
>> There is no fflush() going on here. This code is about the multifd
>> flush, which sends the remaining data from MultiFDPages_t and the
>> multifd sync, which synchronizes the multifd threads. That qemu_fflush
>> is just to make sure the destination sees flag on the stream.
>
> * Yes, there is no fflush(3) call. I mentioned fflush(3) as indicative
> of the operation performed. ie. the description above reads the same
> as what fflush(3) does to streams.
>
>       "...fflush() forces a write of all user-space buffered data for
> the given output or update stream via the  stream's  underlying write
> function."
>
> In the multifd case we are sending remaining data from MultiFDPages_t
> buffers onto the respective channels IIUC. The
> multifd_send_sync_main() function sets the 'p->pending_sync' field and
> when it is set miltifd_send_thread() function calls
>
>       ret = qio_channel_write_all(p->c, (void *)p->packet,
>                                             p->packet_len, &local_err);
>
> multifd_send_sync_main() also has 'flush_zero_copy', but that only
> happens when using --zerocopy option is used -> $ virsh migrate
> --zerocopy  ...
>
>> There is no flush on the receive side. The RAM_SAVE_FLAG_MULTIFD_FLUSH
>> flag is there to indicate to the destination that at that point in the
>> stream the source has done a flush + sync operation and the destination
>> should sync it's threads as well.
>
> * The comment around where 'RAM_SAVE_FLAG_MULTIFD_FLUSH' gets written
> above, says -> "...trigger remote flush."
>
> * We seem to use terms 'flush' and 'sync' quite freely and
> interchangeably. ie. variables (ex: do_local_flush) and constants are
> named with _FLUSH and functions and fields are named as _sync_main()
> and &p->pending_sync.
>
>         if (do_local_flush) {
>             multifd_send/_recv_sync_main();    <= do the 'flush' and
> 'sync' mean the same thing here?
>         }

No, that patch is indeed inconsistent in the terminology, good point.

>
> Even in multifd_ram_flush_and_sync() routine, it is named with _flush_
> and eventually multifd_send() sets the '&p->pending_job' variable to
> true. There is no field in MultiFDSendParams structure named with
> 'flush'. It defines 'pending_sync' and 'sem_sync'.

Yes, the flush in flush_and_sync is tied with multifd_send(), that's
what does the flush. This is more a consequence of the implementation,
take a look at multifd_queue_page().

>
> * Such free usage of these terms is bound to create confusion. Because
> while reading code the reader may relate flush with fflush(3) and sync
> with fsync(2) calls/operations. It will help if we use these terms
> more judiciously.

Well, flush and sync are not reserved terms, we can use them however we
see fit. As long as it's consistent, of course.

Note however, that there is some intended overlap with system library
terminology in the implementation of QEMUFile. In qemu-file.c
qemu_fflush() is indeed reminiscent of fflush(). I think it's been
agreed in the past that this is not a good way of designing an interface
and we should eventually move away from that.

>
> * Coming back to the issue of simplifying multifd threads 'flush or
> sync' operation:
>    1. I think it can be done separately, outside the scope of this patch series.

Yes, that's fine.

>    2. Must we tie the flush/sync operations with specific spots? Isn't
> there any other way, where we call multifd_*_sync() unconditionally,
> without any side-effects? As I see it, we have those conditions,
> because of the side-effects.

Perhaps we could move the sync up to the vmstate level and do it
unconditionally.

>
> Thank you.
> ---
>   - Prasad

