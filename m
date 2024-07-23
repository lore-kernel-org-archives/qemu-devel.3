Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF288C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJdK-0001Ge-On; Tue, 23 Jul 2024 13:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sWJdA-0001DP-V2
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:48:58 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sWJd8-000682-Q9
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:48:56 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1CEBD1FD58;
 Tue, 23 Jul 2024 17:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721756931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxgDQbDUTT8qW7JyCYWnxGwu1PUGWITv9uAZIcFl/bY=;
 b=mHAZmK5P8MNKPy2acp75OqQMX8/8672Zs5i90lL+cEHdtO/4cgsPRXxDk/IEzoaqk49j3c
 svIobWMq/2Xnl14jXmG6YLoM72pZcwvppo/WQzU+08k3FjusS2diOUtlp1vh8vn1m6i6kw
 Qzz0aahEko0CEO+AyzAX3do7n7+09jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721756931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxgDQbDUTT8qW7JyCYWnxGwu1PUGWITv9uAZIcFl/bY=;
 b=c77YCNk9PVZYzPncjICzhpwU6D40W17bMahNppyanFFMOfJvtETNQvIBTVpXrC2o/xgUUk
 bIKiSbQbE1mTHrCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721756931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxgDQbDUTT8qW7JyCYWnxGwu1PUGWITv9uAZIcFl/bY=;
 b=mHAZmK5P8MNKPy2acp75OqQMX8/8672Zs5i90lL+cEHdtO/4cgsPRXxDk/IEzoaqk49j3c
 svIobWMq/2Xnl14jXmG6YLoM72pZcwvppo/WQzU+08k3FjusS2diOUtlp1vh8vn1m6i6kw
 Qzz0aahEko0CEO+AyzAX3do7n7+09jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721756931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cxgDQbDUTT8qW7JyCYWnxGwu1PUGWITv9uAZIcFl/bY=;
 b=c77YCNk9PVZYzPncjICzhpwU6D40W17bMahNppyanFFMOfJvtETNQvIBTVpXrC2o/xgUUk
 bIKiSbQbE1mTHrCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 030DB1377F;
 Tue, 23 Jul 2024 17:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZfnoLbbsn2YZEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Jul 2024 17:47:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH v2 0/9] migration/multifd: Remove
 multifd_send_state->pages
In-Reply-To: <Zp7k4wF1W6Fzp7YW@x1n>
References: <20240722175914.24022-1-farosas@suse.de> <Zp65zvb9oy9my-qY@x1n>
 <87msm9yy77.fsf@suse.de> <Zp7HH6-WeYKXQ-fy@x1n> <87a5i9yvhf.fsf@suse.de>
 <Zp7k4wF1W6Fzp7YW@x1n>
Date: Tue, 23 Jul 2024 14:48:48 -0300
Message-ID: <8734o0yp6n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Mon, Jul 22, 2024 at 06:20:28PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Jul 22, 2024 at 05:21:48PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Mon, Jul 22, 2024 at 02:59:05PM -0300, Fabiano Rosas wrote:
>> >> >> Hi,
>> >> >> 
>> >> >> In this v2 I took Peter's suggestion of keeping the channels' pointers
>> >> >> and moving only the extra slot. The major changes are in patches 5 and
>> >> >> 9. Patch 3 introduces the structure:
>> >> >> 
>> >> >> typedef enum {
>> >> >>     MULTIFD_PAYLOAD_NONE,
>> >> >>     MULTIFD_PAYLOAD_RAM,
>> >> >> } MultiFDPayloadType;
>> >> >> 
>> >> >> struct MultiFDSendData {
>> >> >>     MultiFDPayloadType type;
>> >> >>     union {
>> >> >>         MultiFDPages_t ram;
>> >> >>     } u;
>> >> >> };
>> >> >> 
>> >> >> I added a NONE type so we can use it to tell when the channel has
>> >> >> finished sending a packet, since we'll need to switch types between
>> >> >> clients anyway. This avoids having to introduce a 'size', or 'free'
>> >> >> variable.
>> >> >
>> >> > This at least looks better to me, thanks.
>> >> >
>> >> >> 
>> >> >> WHAT'S MISSING:
>> >> >> 
>> >> >> - The support for calling multifd_send() concurrently. Maciej has this
>> >> >>   in his series so I didn't touch it.
>> >> >> 
>> >> >> - A way of adding methods for the new payload type. Currently, the
>> >> >>   compression methods are somewhat coupled with ram migration, so I'm
>> >> >>   not sure how to proceed.
>> >> >
>> >> > What is this one?  Why compression methods need new payload?  Aren't they
>> >> > ram-typed?
>> >> 
>> >> The data we transport is MultiFDPages_t, yes, but the MultiFDMethods are
>> >> either nocomp, or the compression-specific methods
>> >> (e.g. zlib_send_prepare).
>> >> 
>> >> How do we add methods for the upcoming new payload types? I don't expect
>> >> us to continue using nocomp and then do "if (ram)... else if
>> >> (device_state) ..." inside of them. I would expect us to rename
>> >> s/nocomp/ram/ and add a new set of MultiFDMethods for the new data type
>> >> (e.g. vfio_send_prepare, vmstate_send_prepare, etc).
>> >> 
>> >> multifd_nocomp_ops -> multifd_ram_ops // rename
>> >> multifd_zlib_ops   // existing
>> >> multifd_device_ops // new
>> >> 
>> >> The challenge here is that the current framework is nocomp
>> >> vs. compression. It needs to become ram + compression vs. other types.
>> >
>> > IMHO we can keep multifd_ops[] only for RAM.  There's only send_prepare()
>> > that device state will need, and so far it's only (referring Maciej's
>> > code):
>> >
>> > static int nocomp_send_prepare_device_state(MultiFDSendParams *p,
>> >                                             Error **errp)
>> > {
>> >     multifd_send_prepare_header_device_state(p);
>> >
>> >     assert(!(p->flags & MULTIFD_FLAG_SYNC));
>> >
>> >     p->next_packet_size = p->device_state->buf_len;
>> >     if (p->next_packet_size > 0) {
>> >         p->iov[p->iovs_num].iov_base = p->device_state->buf;
>> >         p->iov[p->iovs_num].iov_len = p->next_packet_size;
>> >         p->iovs_num++;
>> >     }
>> >
>> >     p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
>> >
>> >     multifd_send_fill_packet_device_state(p);
>> >
>> >     return 0;
>> > }
>> >
>> > None of other multifd_ops are used.
>> 
>> There's also a conditional around device_state when calling
>> ->recv(). That could seems like it could go to a hook.
>> 
>> https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com
>
> Actually that's exactly what I think is right.. it looks to me now that we
> could bypass anything in MultifdOps (including recv()) but let device state
> be a parallel layer of MultifdOps itself, leaving MultifdOps only for
> compressors.
>
> And yeah, I still remember you just renamed it from recv_pages() to
> recv()..  it's just that now when think it again it looks like cleaner to
> make it only about pages..
>
>> 
>> >
>> > I think we can directly invoke this part of device state code in
>> > multifd_send_thread() for now.  So far I think it should be ok.
>> 
>> It's not just that. There's also a check for "if (ram)" at every call to
>> multifd_ops to avoid calling the ram code when doing the device
>> migration. It would be way easier to just set noop functions for those.
>> 
>> static MultiFDMethods multifd_devstate_ops = {
>>     .send_setup = noop_send_setup,
>>     .send_cleanup = noop_send_cleanup,
>>     .send_prepare = devstate_send_prepare,
>>     .recv_setup = noop_recv_setup,
>>     .recv_cleanup = noop_recv_cleanup,
>>     .recv = devstate_recv
>> };
>> 
>> I'm not saying this needs to be done in this series though. But I do
>> think that's the correct design choice for the long term.
>
> Yes it should be separate.
>
> And what I meant is we don't need all these noops, but recv() keeps being
> ignored just like above, then for sender side, right now it's:
>
>             ret = multifd_send_state->ops->send_prepare(p, &local_err);
>             if (migrate_mapped_ram()) {
>                 file_write_ramblock_iov();
>             } else {
>                 ret = qio_channel_writev_full_all();
>             }
>
> VFIO can process device state in parallel, so:
>
>     if (ram) {
>         ret = multifd_send_state->ops->send_prepare(p, &local_err);
>         if (migrate_mapped_ram()) {
>                 file_write_ramblock_iov();
>         } else {
>                 qio_channel_writev_full_all();
>         }
>     } else {
>         // device state handling
>         multifd_send_device_prepare(...);
>         ...
>         qio_channel_writev_full_all();
>     }
>
> Then MultifdOps doesn't apply to device states.

To avoid getting into bikeshed territory, I think we should postpone
this discussion until after Maciej's series is merged, so we can speak
more concretely about the implications. It's easy enough to go from your
suggestion to mine than the other way around, so let's leave at that.

I had it already written, so more of my reasoning below, if you're
interested.
======

We already have the send/recv threads structured in relation to what we
do inside the hooks. You're just defining a function that's not a hook,
but it has the same signature and responsibilities and needs to be
called at the same moment.

I think the dissonance here is that you don't see the multifd thread
code and the payloads (ram, device) as separate layers. Payload-specific
code should not be at top level. Otherwise, it breaks any semblance of
proper layering:

- payload code will have access to MultiFD*Params, which has a bunch of
  control variables for the loop, the semaphores, etc. that should not
  be touched;

- payload code ends up influencing the flow of the thread
  function. E.g. when zero_copy_send used to dictate whether we'd have
  separate IO for the packet or not.

- temporary variables needed by the payload code will have to be
  declared inside the thread funcion, which makes tempting to use them
  across payload types and also in the thread code itself;

- it creates doubt as to whether new changes go inside the hooks, in the
  if/else or outside of it;

Think about how easy it has has been to review and merge the various
compression features we had. It doesn't matter how much they mess up
inside the hooks, it will never cause the dreaded "Memory content
inconsistency at ..." error from check_guest_ram(). At least not in a
way that affects other people. Now compare that with for instance the
zero-page work, or even mapped-ram, that required a bunch of changes to
the multifd control flow itself (e.g. all of the sync changes w/
mapped-ram).

