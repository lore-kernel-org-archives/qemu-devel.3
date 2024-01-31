Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4176CC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAQo-0007fX-3Z; Wed, 31 Jan 2024 08:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVAQj-0007Ut-Iq
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:15:06 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVAQh-0005GR-5u
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:15:05 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 195DF1F37C;
 Wed, 31 Jan 2024 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706706901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQcO9boHGoZAFHGUL9DbUolTgPVr5F590wOXAKQFkFw=;
 b=Gn6nTljUAUIoH+qQNPss1Ik6bn+PU44b3wVQcR7X7Xw3+terA1AJaP87DMiq7diCZYCAbF
 ucWLY1YJG5r5xLEdNPpsKRDHQy9TBktpSYI8jnzXEiNFi+NdA8QGTHnKBFliLquPRJ/uUA
 KK8IqskS40Zef/Ra/S8ewYG6hztpO+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706706901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQcO9boHGoZAFHGUL9DbUolTgPVr5F590wOXAKQFkFw=;
 b=Ow9ToySbPiQALVi6+IPqCwDOcMQyY1TE9eGQ71ST0JzLUVqo6QVD/t2VMijZQR5vnymlag
 rDBTlULyZ2BDjTCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706706901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQcO9boHGoZAFHGUL9DbUolTgPVr5F590wOXAKQFkFw=;
 b=Gn6nTljUAUIoH+qQNPss1Ik6bn+PU44b3wVQcR7X7Xw3+terA1AJaP87DMiq7diCZYCAbF
 ucWLY1YJG5r5xLEdNPpsKRDHQy9TBktpSYI8jnzXEiNFi+NdA8QGTHnKBFliLquPRJ/uUA
 KK8IqskS40Zef/Ra/S8ewYG6hztpO+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706706901;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DQcO9boHGoZAFHGUL9DbUolTgPVr5F590wOXAKQFkFw=;
 b=Ow9ToySbPiQALVi6+IPqCwDOcMQyY1TE9eGQ71ST0JzLUVqo6QVD/t2VMijZQR5vnymlag
 rDBTlULyZ2BDjTCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98C971347F;
 Wed, 31 Jan 2024 13:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Jrz+F9RHumXrAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 31 Jan 2024 13:15:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>, Yuan Liu
 <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 1/5] migration/multifd: Separate compression ops from
 non-compression
In-Reply-To: <Zbn1mcXXGKdTTz6O@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <20240126221943.26628-2-farosas@suse.de> <ZbdFzFxysMg274Rw@x1n>
 <87mssoe2fj.fsf@suse.de> <Zbi2XDfeJHcUpUp9@x1n> <8734uedff0.fsf@suse.de>
 <Zbn1mcXXGKdTTz6O@x1n>
Date: Wed, 31 Jan 2024 10:14:58 -0300
Message-ID: <875xz9lk4t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.954];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> On Tue, Jan 30, 2024 at 12:11:47PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Jan 29, 2024 at 09:42:24AM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Fri, Jan 26, 2024 at 07:19:39PM -0300, Fabiano Rosas wrote:
>> >> >> +static MultiFDMethods multifd_socket_ops = {
>> >> >> +    .send_setup = multifd_socket_send_setup,
>> >> >> +    .send_cleanup = multifd_socket_send_cleanup,
>> >> >> +    .send_prepare = multifd_socket_send_prepare,
>> >> >
>> >> > Here it's named with "socket", however not all socket-based multifd
>> >> > migrations will go into this route, e.g., when zstd compression enabled it
>> >> > will not go via this route, even if zstd also uses sockets as transport.
>> >> > From that pov, this may be slightly confusing.  Maybe it suites more to be
>> >> > called "socket_plain" / "socket_no_comp"?
>> >> >
>> >> > One step back, I had a feeling that the current proposal tried to provide a
>> >> > single ->ops to cover a model where we may need more than one layer of
>> >> > abstraction.
>> >> >
>> >> > Since it might be helpful to allow multifd send arbitrary data (e.g. for
>> >> > VFIO?  Avihai might have an answer there..), I'll try to even consider that
>> >> > into the picture.
>> >> >
>> >> > Let's consider the ultimate goal of multifd, where the simplest model could
>> >> > look like this in my mind (I'm only discussing sender side, but it'll be
>> >> > similar on recv side):
>> >> >
>> >> >                prepare()           send()
>> >> >   Input   ----------------> IOVs ------------> iochannels
>> >> >
>> >> > [I used prepare/send, but please think them as generic terms, not 100%
>> >> >  aligned with what we have with existing multifd_ops, or what you proposed
>> >> >  later]
>> >> >
>> >> > Here what are sure, IMHO, is:
>> >> >
>> >> >   - We always can have some input data to dump; I didn't use "guest pages"
>> >> >     just to say we may allow arbitrary data.  For any multifd user that
>> >> >     would like to dump arbitrary data, they can already provide IOVs, so
>> >> >     here input can be either "MultiFDPages_t" or "IOVs".
>> >> 
>> >> Or anything else, since the client code also has control over send(),
>> >> no? So it could give multifd a pointer to some memory and then use
>> >> send() to do whatever it wants with it. Multifd is just providing worker
>> >> threads and "scheduling".
>> >
>> > IOVs contain the case of one single buffer, where n_iovs==1.  Here I
>> > mentioned IOVs explicitly because I want to make it part of the protocol so
>> > that the interface might be clearer, on what is not changing, and what can
>> > change for a multifd client.
>> 
>> Got it. I agree.
>> 
>> >> 
>> >> Also note that multifd clients currently _do not_ provide IOVs. They
>> >> merely provide data to multifd (p->pages) and then convert that data
>> >> into IOVs at prepare(). This is different, because multifd currently
>> >> holds that p->pages (and turns that into p->normal), which means the
>> >> client code does not need to store the data across iterations (in the
>> >> case of RAM which is iterative).
>> >
>> > They provide?  AFAIU that's exactly MultiFDSendParams.iov as of now, while
>> > iov_nums is the length.
>> 
>> Before that, the ram code needs to pass in the p->pages->offset array
>> first. Then, that gets put into p->normal. Then, that gets put into
>> p->iov at prepare(). So it's not a simple "fill p->iov and pass it to
>> multifd".
>> 
>> Hmm, could we just replace multifd_send_state->pages with a
>> multifd_send_state->iov? I don't really understand why do we need to
>> carry that pages->offset around.
>
> I am thinking the p->normal is mostly redundant.. at least on the sender
> side that I just read.  Since I'll be preparing a new spin of the multifd
> cleanup series I posted, maybe I can append one more to try dropping
> p->normal[] completely.

Just for reference, you don't have to use it, but I have this patch:

https://gitlab.com/farosas/qemu/-/commit/4316e145ae7e7bf378ef7fde64c2b02260362847

>> 
>> >> 
>> >> >
>> >> >   - We may always want to have IOVs to represent the buffers at some point,
>> >> >     no matter what the input it
>> >> >
>> >> >   - We always flush the IOVs to iochannels; basically I want to say we can
>> >> >     always assume the last layer is connecting to QIOChannel APIs, while I
>> >> >     don't think there's outliers here so far, even if the send() may differ.
>> >> >
>> >> > Then _maybe_ it's clearer that we can have two layers of OPs?
>> >> >
>> >> >   - prepare(): it tells how the "input" will be converted into a scatter
>> >> >     gatter list of buffers.  All compression methods fall into this afaiu.
>> >> >     This has _nothing_ to do on how the buffers will be sent.  For
>> >> >     arbitrary-typed input, this can already be a no-op since the IOVs
>> >> >     provided can already be passed over to send().
>> >> >
>> >> >   - send(): how to dump the IOVs to the iochannels.  AFAIU this is motly
>> >> >     only useful for fixed-ram migrations.
>> >> >
>> >> > Would this be clearer, rather than keep using a single multifd_ops?
>> >> 
>> >> Sorry, I don't see how what you describe is any different than what we
>> >> have. And I don't see how any of this would mean more than one
>> >> multifd_ops. We already have multifd_ops->prepare() and
>> >> multifd_ops->send(). What am I missing?
>> >
>> > I meant instead of having a single MultiFDMethods, we can have
>> > MultifdPrepareOps and MultifdSendOps separately.
>> >
>> > Now with single MultiFDMethods, it must always provide e.g. both prepare()
>> > and send() in one set of OPs for one use case.  What I wanted to say is
>> > maybe it is cleaner we split it into two OPs, then all the socket-based
>> > scenarios can already stick with the same send() method, even though they
>> > can prepare() differently.
>> 
>> Hmm, so zlib/zstd implement all ops except for the send one. And
>> socket_plain and file implement all prepare hooks plus the send. So we'd
>> have sort of a data handling layer and a transport layer. I'll see how
>> it looks.
>
> Yeah something like that if you agree; I'd think socket_plain can also use
> the same socket send() with all the rest?  Again, I don't see its specialty
> except the zero copy possibility, while the latter should be able to be
> covered by proper setup of p->write_flags.
>

I see. Makes sense.

>> 
>> >
>> > IOW, for this base patchset to pave way for compression accelerators, IIUC
>> > we don't need a send() yet so far?  Should they still work pretty well with
>> > qio_channel_writev_full_all() with proper touchups on p->write_flags just
>> > for zero copy purposes?
>> 
>> Yes. The point here is to just give everyone a heads-up so we avoid
>> changing the code in incompatible ways.
>> 
>> >
>> > I'll have a read again to your previous multifd-packet-cleanups branch I
>> > guess.  but this series definitely doesn't apply there already.
>> 
>> multifd-packet-cleanups attempts to replace MultiFDPages_t with a
>> generic data structure. That's a separate issue.
>> 

