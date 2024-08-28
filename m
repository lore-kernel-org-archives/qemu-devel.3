Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42F0C54FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIM5-0005uz-Gj; Wed, 28 Aug 2024 09:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjIM4-0005u1-PO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:04:56 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sjIM1-0006ZC-3B
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:04:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1C8C21B6C;
 Wed, 28 Aug 2024 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724850291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVzEXbwSELz5xdfduq1kH97SG0HM2AGjrcE5MOHazKM=;
 b=amK5cTPx82ChQ47YwmkJXNV8h2aJHS2tpJhLp6IPH6vWkA2+irxDJitWaSVzbtxo4auySC
 Gq6lIPGWSfS+KzlsuuxPHcF5AIFQ00bssuz7y0/3otUFK5YN2piRBUaQGuz+2y3uVjkeiu
 ACXpLEExD2e9AL6UQEmhUmOlNuHynxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724850291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVzEXbwSELz5xdfduq1kH97SG0HM2AGjrcE5MOHazKM=;
 b=XQHIdmcNm00Dt6kbJQfjZS7BnV9uQ5i/OacpnGx7CR6N/WiKD08a8/KwYQHunr/f0w3yEE
 AkHwZcRU5PgOE0Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724850290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVzEXbwSELz5xdfduq1kH97SG0HM2AGjrcE5MOHazKM=;
 b=K++agt+MfFLhmhZbFcaRgMs78IM1uK/WAy7hHlR69VXiSL3K4tFvjb3YxH/iQqJw2kbC+T
 f9hvq1rdUdO1m5DRDckY7hSSfjsNR0WPaH/RG3h32yR0RlKzYVdMXc8KSgrBMWRkFbaD8h
 CEwuZf3982uDVu5hAfXqjF4yLZxQWBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724850290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVzEXbwSELz5xdfduq1kH97SG0HM2AGjrcE5MOHazKM=;
 b=fUJMX3xCW6kZ0VsnWcJaK1xy1y4n2DzGMEZMmEPVEDhAmG5LaWa5spapm29d3daNElmqJU
 U+0ukNNcSs75gKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B0C8138D2;
 Wed, 28 Aug 2024 13:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ym2DEHIgz2ZwHwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Aug 2024 13:04:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero"
 <mail@maciej.szmigiero.name>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v6 19/19] migration/multifd: Add documentation for
 multifd methods
In-Reply-To: <Zs5H3TtkFfLFDrTw@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-20-farosas@suse.de> <Zs4bL_lRURD7cV_N@x1n>
 <87mskxx0ck.fsf@suse.de> <Zs4ka2-q6JJbL1KA@x1n> <87jzg1wza0.fsf@suse.de>
 <Zs4spTkGlJJuB7LT@x1n> <87zfoxogvr.fsf@suse.de> <Zs5H3TtkFfLFDrTw@x1n>
Date: Wed, 28 Aug 2024 10:04:47 -0300
Message-ID: <87wmk0ol1s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Tue, Aug 27, 2024 at 05:22:32PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Tue, Aug 27, 2024 at 04:17:59PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Tue, Aug 27, 2024 at 03:54:51PM -0300, Fabiano Rosas wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> > On Tue, Aug 27, 2024 at 02:46:06PM -0300, Fabiano Rosas wrote:
>> >> >> >> Add documentation clarifying the usage of the multifd methods. The
>> >> >> >> general idea is that the client code calls into multifd to trigger
>> >> >> >> send/recv of data and multifd then calls these hooks back from the
>> >> >> >> worker threads at opportune moments so the client can process a
>> >> >> >> portion of the data.
>> >> >> >> 
>> >> >> >> Suggested-by: Peter Xu <peterx@redhat.com>
>> >> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> >> >> ---
>> >> >> >> Note that the doc is not symmetrical among send/recv because the recv
>> >> >> >> side is still wonky. It doesn't give the packet to the hooks, which
>> >> >> >> forces the p->normal, p->zero, etc. to be processed at the top level
>> >> >> >> of the threads, where no client-specific information should be.
>> >> >> >> ---
>> >> >> >>  migration/multifd.h | 76 +++++++++++++++++++++++++++++++++++++++++----
>> >> >> >>  1 file changed, 70 insertions(+), 6 deletions(-)
>> >> >> >> 
>> >> >> >> diff --git a/migration/multifd.h b/migration/multifd.h
>> >> >> >> index 13e7a88c01..ebb17bdbcf 100644
>> >> >> >> --- a/migration/multifd.h
>> >> >> >> +++ b/migration/multifd.h
>> >> >> >> @@ -229,17 +229,81 @@ typedef struct {
>> >> >> >>  } MultiFDRecvParams;
>> >> >> >>  
>> >> >> >>  typedef struct {
>> >> >> >> -    /* Setup for sending side */
>> >> >> >> +    /*
>> >> >> >> +     * The send_setup, send_cleanup, send_prepare are only called on
>> >> >> >> +     * the QEMU instance at the migration source.
>> >> >> >> +     */
>> >> >> >> +
>> >> >> >> +    /*
>> >> >> >> +     * Setup for sending side. Called once per channel during channel
>> >> >> >> +     * setup phase.
>> >> >> >> +     *
>> >> >> >> +     * Must allocate p->iov. If packets are in use (default), one
>> >> >> >
>> >> >> > Pure thoughts: wonder whether we can assert(p->iov) that after the hook
>> >> >> > returns in code to match this line.
>> >> >> 
>> >> >> Not worth the extra instructions in my opinion. It would crash
>> >> >> immediately once the thread touches p->iov anyway.
>> >> >
>> >> > It might still be good IMHO to have that assert(), not only to abort
>> >> > earlier, but also as a code-styled comment.  Your call when resend.
>> >> >
>> >> > PS: feel free to queue existing patches into your own tree without
>> >> > resending the whole series!
>> >> >
>> >> >> 
>> >> >> >
>> >> >> >> +     * extra iovec must be allocated for the packet header. Any memory
>> >> >> >> +     * allocated in this hook must be released at send_cleanup.
>> >> >> >> +     *
>> >> >> >> +     * p->write_flags may be used for passing flags to the QIOChannel.
>> >> >> >> +     *
>> >> >> >> +     * p->compression_data may be used by compression methods to store
>> >> >> >> +     * compression data.
>> >> >> >> +     */
>> >> >> >>      int (*send_setup)(MultiFDSendParams *p, Error **errp);
>> >> >> >> -    /* Cleanup for sending side */
>> >> >> >> +
>> >> >> >> +    /*
>> >> >> >> +     * Cleanup for sending side. Called once per channel during
>> >> >> >> +     * channel cleanup phase. May be empty.
>> >> >> >
>> >> >> > Hmm, if we require p->iov allocation per-ops, then they must free it here?
>> >> >> > I wonder whether we leaked it in most compressors.
>> >> >> 
>> >> >> Sorry, this one shouldn't have that text.
>> >> >
>> >> > I still want to double check with you: we leaked iov[] in most compressors
>> >> > here, or did I overlook something?
>> >> 
>> >> They have their own send_cleanup function where p->iov is freed.
>> >
>> > Oh, so I guess I just accidentally stumbled upon
>> > multifd_uadk_send_cleanup() when looking..
>> 
>> Yeah, this is a bit worrying. The reason this has not shown on valgrind
>> or the asan that Peter ran recently is that uadk, qpl and soon qat are
>> never enabled in a regular build. I have myself introduced compilation
>> errors in those files that I only caught by accident at a later point
>> (before sending to the ml).
>
> I tried to manually install qpl and uadk just now but neither of them is
> trivial to compile and install..  I hit random errors here and there in my
> first shot.
>
> OTOH, qatzip packages are around at least in Fedora repositories, so that
> might be the easiest to reach.  Not sure how's that when with OpenSUSE.
>
> Shall we perhaps draft an email and check with them? E.g., would that be
> better if there's plan they would at some point provide RPMs for libraries
> at some point so that we could somehow integrate that into CI routines?

We merged most of these things already. Now even if rpms show up at some
point we still have to deal with not being able to build that code until
then. Perhaps we could have a container that has all of these
pre-installed just to exercize the code a bit. But it still wouldn't
catch some issues becase we cannot run the code due to the lack of
hardware.

>
>> 
>> >
>> > I thought I looked a few more but now when I check most of them are indeed
>> > there but looks like uadk is missing that.
>> >
>> > I think it might still be a good idea to assert(iov==NULL) after the
>> > cleanup..
>> 
>> Should we maybe just free p->iov at the top level then?
>
> We could, but if so it might be good to also allocate at the top level so
> the hooks are paired up on these allocations/frees.
>
> IMHO we could already always allocate iov[] to page_count+2 which is the
> maximum of all compressors - currently we've got 128 pages per packet by
> default, which is 128*16=2KB iov[] per channel.  Not so bad when only used
> during migrations.
>
> Or we can perhaps do send_setup(..., &iovs_needed), returns how many iovs
> are needed, then multifd allocates them.

Let me play around with these a bit. I might just fix uadk and leave
everything else as it is for now.

