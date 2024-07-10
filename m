Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAF9C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 20:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRdkI-0003ZA-FJ; Wed, 10 Jul 2024 16:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sRdkA-0003Vm-BQ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:16:51 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sRdk3-00021G-Ka
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 16:16:49 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7DAD21252;
 Wed, 10 Jul 2024 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720642600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKLNjjkf2S2Phui6tX/XEV6ls+tIJFaIZWdVSv6g3tE=;
 b=gzugzNFtR/r5mgPkejW3FdJgmSTdbLLZSRHw4utdgoPDpQtFMLEjIue11FS7geUBTKBgbz
 GMCm3DKO2sFVIYF6XFaaicZvB7tyYaaHcKlaFwSyXsMnQ0NyDK7WkKAXxnO8k41W2EwRBz
 T89UlIPL7HME54In77f2WW8aK2XjXMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720642600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKLNjjkf2S2Phui6tX/XEV6ls+tIJFaIZWdVSv6g3tE=;
 b=RJKnGLqJWjJcEQGiVicAfNFzj4VoCLHPFx0fvmu+CBdLj8ky/A64/ngHuXNQ2OsLTU6DyO
 dRY4vQas7sWKdjAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rnwQ+6vX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jwYVjAb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720642599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKLNjjkf2S2Phui6tX/XEV6ls+tIJFaIZWdVSv6g3tE=;
 b=rnwQ+6vXs6PvyndDXnvYYR31v+gRecpvQoAw0dbNrQWytdTJmp6LwnBbIMaYQOlamoQ445
 fbIRteZFS8nNQf+hgxEWzCI2IukUOEhoINx8LAoMnshbGRGavEcRmMDS63+ucdZXqpVkgr
 KeOWZama1Xur3pzpeMVRHaePUvLG2vE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720642599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eKLNjjkf2S2Phui6tX/XEV6ls+tIJFaIZWdVSv6g3tE=;
 b=jwYVjAb1yFKQugUgTKTFZ8siELf2AMFXtxc4/ZHzqiD3HT1pI/JeMHu/ScN7xyA0XeCWg1
 uY/mx6NfQLOITeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EF43137D2;
 Wed, 10 Jul 2024 20:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ksiTDSfsjmbKIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jul 2024 20:16:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <Zo7cncqkxB89AUBe@x1n>
References: <20240620212111.29319-1-farosas@suse.de>
 <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com> <Zn15y693g0AkDbYD@x1n>
 <877cdtfcsi.fsf@suse.de> <Zo7cncqkxB89AUBe@x1n>
Date: Wed, 10 Jul 2024 17:16:36 -0300
Message-ID: <87y169dmu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E7DAD21252
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Wed, Jul 10, 2024 at 01:10:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Jun 27, 2024 at 11:27:08AM +0800, Wang, Lei wrote:
>> >> > Or graphically:
>> >> > 
>> >> > 1) client fills the active slot with data. Channels point to nothing
>> >> >    at this point:
>> >> >   [a]      <-- active slot
>> >> >   [][][][] <-- free slots, one per-channel
>> >> > 
>> >> >   [][][][] <-- channels' p->data pointers
>> >> > 
>> >> > 2) multifd_send() swaps the pointers inside the client slot. Channels
>> >> >    still point to nothing:
>> >> >   []
>> >> >   [a][][][]
>> >> > 
>> >> >   [][][][]
>> >> > 
>> >> > 3) multifd_send() finds an idle channel and updates its pointer:
>> >> 
>> >> It seems the action "finds an idle channel" is in step 2 rather than step 3,
>> >> which means the free slot is selected based on the id of the channel found, am I
>> >> understanding correctly?
>> >
>> > I think you're right.
>> >
>> > Actually I also feel like the desription here is ambiguous, even though I
>> > think I get what Fabiano wanted to say.
>> >
>> > The free slot should be the first step of step 2+3, here what Fabiano
>> > really wanted to suggest is we move the free buffer array from multifd
>> > channels into the callers, then the caller can pass in whatever data to
>> > send.
>> >
>> > So I think maybe it's cleaner to write it as this in code (note: I didn't
>> > really change the code, just some ordering and comments):
>> >
>> > ===8<===
>> > @@ -710,15 +710,11 @@ static bool multifd_send(MultiFDSlots *slots)
>> >       */
>> >      active_slot = slots->active;
>> >      slots->active = slots->free[p->id];
>> > -    p->data = active_slot;
>> > -
>> > -    /*
>> > -     * By the next time we arrive here, the channel will certainly
>> > -     * have consumed the active slot. Put it back on the free list
>> > -     * now.
>> > -     */
>> >      slots->free[p->id] = active_slot;
>> >  
>> > +    /* Assign the current active slot to the chosen thread */
>> > +    p->data = active_slot;
>> > ===8<===
>> >
>> > The comment I removed is slightly misleading to me too, because right now 
>> > active_slot contains the data hasn't yet been delivered to multifd, so
>> > we're "putting it back to free list" not because of it's free, but because
>> > we know it won't get used until the multifd send thread consumes it
>> > (because before that the thread will be busy, and we won't use the buffer
>> > if so in upcoming send()s).
>> >
>> > And then when I'm looking at this again, I think maybe it's a slight
>> > overkill, and maybe we can still keep the "opaque data" managed by multifd.
>> > One reason might be that I don't expect the "opaque data" payload keep
>> > growing at all: it should really be either RAM or device state as I
>> > commented elsewhere in a relevant thread, after all it's a thread model
>> > only for migration purpose to move vmstates..
>> 
>> Some amount of flexibility needs to be baked in. For instance, what
>> about the handshake procedure? Don't we want to use multifd threads to
>> put some information on the wire for that as well?
>
> Is this an orthogonal question?

I don't think so. You say the payload data should be either RAM or
device state. I'm asking what other types of data do we want the multifd
channel to transmit and suggesting we need to allow room for the
addition of that, whatever it is. One thing that comes to mind that is
neither RAM or device state is some form of handshake or capabilities
negotiation.

>
> What I meant above is it looks fine to me to keep "device state" in
> multifd.c, as long as it is not only about VFIO.
>
> What you were saying seems to be about how to identify this is a device
> state, then I just hope VFIO shares the same flag with any future device
> that would also like to send its state via multifd, like:
>
> #define MULTIFD_FLAG_DEVICE_STATE (32 << 1)
>
> Then set it in MultiFDPacket_t.flags.  The dest qemu should route that
> packet to the device vmsd / save_entry for parsing.

Sure, that part I agree with, no issue here.

>
>> 
>> > Putting it managed by multifd thread should involve less change than this
>> > series, but it could look like this:
>> >
>> > typedef enum {
>> >     MULTIFD_PAYLOAD_RAM = 0,
>> >     MULTIFD_PAYLOAD_DEVICE_STATE = 1,
>> > } MultifdPayloadType;
>> >
>> > typedef enum {
>> >     MultiFDPages_t ram_payload;
>> >     MultifdDeviceState_t device_payload;
>> > } MultifdPayload;
>> >
>> > struct MultiFDSendData {
>> >     MultifdPayloadType type;
>> >     MultifdPayload data;
>> > };
>> 
>> Is that an union up there? So you want to simply allocate in multifd the
>
> Yes.
>
>> max amount of memory between the two types of payload? But then we'll
>
> Yes.
>
>> need a memset(p->data, 0, ...) at every round of sending to avoid giving
>> stale data from one client to another. That doesn't work with the
>
> I think as long as the one to enqueue will always setup the fields, we
> don't need to do memset.  I am not sure if it's a major concern to always
> set all the relevant fields in the multifd enqueue threads.  It sounds like
> the thing we should always better do.

Well, writing to a region of memory that was "owned" by another multifd
client and already has a bunch of data there is somewhat prone to
bugs. Just forget to set something and now things start to behave
weirdly. I guess that's just the price of having an union. I'm not
against that, but I would maybe prefer to have each client hold its own
data and not have to think about anything else. Much of this feeling
comes from how the RAM code currently works (more on that below).

>
>> current ram migration because it wants p->pages to remain active across
>> several calls of multifd_queue_page().
>
> I don't think I followed here.
>
> What I meant: QEMU maintains SendData[8], now a bunch of pages arrives, it
> enqueues "pages" into a free slot index 2 (set type=pages), then before
> thread 2 finished sending the bunch of pages, SendData[2] will always
> represent those pages without being used by anything else. What did I miss?
>

You're missing multifd_send_state->pages and the fact that it holds
unsent data on behalf of the client. At every call to
multifd_queue_pages(), the RAM code expects the previously filled pages
structure to be there. Since we intend to have more than one multifd
client, now the other client (say device state) might run, it will take
that slot and fill it with it's own stuff (or rather fill p->send_data
and multifd_send_pages() switches the pointer). Next call to
multifd_queue_pages(), it will take multifd_send_state->pages and
there'll be garbage there.

The code is not: take a free slot from the next idle channel and fill it
with data.

It is: take from multifd_send_state the active slot which *might* have
previously been consumed by the last channel and (continue to) fill it
with data.

"might", because successive calls to multifd_queue_page() don't need to
call multifd_send_page() to flush to the channel.

>> 
>> >
>> > Then the "enum" makes sure the payload only consumes only the max of both
>> > types; a side benefit to save some memory.
>> >
>> > I think we need to make sure MultifdDeviceState_t is generic enough so that
>> > it will work for mostly everything (especially normal VMSDs).  In this case
>> > the VFIO series should be good as that was currently defined as:
>> >
>> > typedef struct {
>> >     MultiFDPacketHdr_t hdr;
>> >
>> >     char idstr[256] QEMU_NONSTRING;
>> >     uint32_t instance_id;
>> >
>> >     /* size of the next packet that contains the actual data */
>> >     uint32_t next_packet_size;
>> > } __attribute__((packed)) MultiFDPacketDeviceState_t;
>> 
>> This is the packet, a different thing. Not sure if your paragraph above
>> means to talk about that or really MultifdDeviceState, which is what is
>> exchanged between the multifd threads and the client code.
>
> I meant the wire protocol looks great from that POV.  We may need similar
> thing for the type==device_state slots just to be generic.
>
>> 
>> >
>> > IIUC that was what we need exactly with idstr+instance_id, so as to nail
>> > exactly at where should the "opaque device state" go to, then load it with
>> > a buffer-based loader when it's ready (starting from VFIO, to get rid of
>> > qemufile).  For VMSDs in the future if ever possible, that should be a
>> > modified version of vmstate_load() where it may take buffers not qemufiles.
>> >
>> > To Maciej: please see whether above makes sense to you, and if you also
>> > agree please consider that with your VFIO work.
>> >
>> > Thanks,
>> >
>> >> 
>> >> >   []
>> >> >   [a][][][]
>> >> > 
>> >> >   [a][][][]
>> >> >   ^idle
>> 

