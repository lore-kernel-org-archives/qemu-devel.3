Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33592C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 16:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUqsX-0007I8-7q; Fri, 19 Jul 2024 12:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUqsV-0007He-Tz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:54:43 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUqsT-0001fY-SG
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 12:54:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B4F1211A9;
 Fri, 19 Jul 2024 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721408080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWCd2Z/nJLu/zTRya66D/T5dR4JiVWPOX5Dt+0hO4vQ=;
 b=TBlhhoDvGkyvHW7ePdYEfohoHyweN55+n44/9noGy7sXUg2iNI+FawGDZR0Mve7HzwXmMB
 yQUpbIxBWAcCGcKekb8946+1BKiTteQgqDyB4oBYYiLj5GR1Yp4ng/PJHWUQyOUPxlsFpz
 12xpApcKMpjCL8JbdDUwf81J9FfsTYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721408080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWCd2Z/nJLu/zTRya66D/T5dR4JiVWPOX5Dt+0hO4vQ=;
 b=+c6o6qzls1zO60f1JHoG03Dn8n1DiJbFQGVKZqHiusco+Zz41OPUsXcmRuCxaUpccvuIPf
 /0EQdcQdv3ie29Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721408080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWCd2Z/nJLu/zTRya66D/T5dR4JiVWPOX5Dt+0hO4vQ=;
 b=TBlhhoDvGkyvHW7ePdYEfohoHyweN55+n44/9noGy7sXUg2iNI+FawGDZR0Mve7HzwXmMB
 yQUpbIxBWAcCGcKekb8946+1BKiTteQgqDyB4oBYYiLj5GR1Yp4ng/PJHWUQyOUPxlsFpz
 12xpApcKMpjCL8JbdDUwf81J9FfsTYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721408080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bWCd2Z/nJLu/zTRya66D/T5dR4JiVWPOX5Dt+0hO4vQ=;
 b=+c6o6qzls1zO60f1JHoG03Dn8n1DiJbFQGVKZqHiusco+Zz41OPUsXcmRuCxaUpccvuIPf
 /0EQdcQdv3ie29Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB14F132CB;
 Fri, 19 Jul 2024 16:54:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uRadJ0+ammbbHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jul 2024 16:54:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZppyVt0LZanF4lIq@x1n>
References: <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de> <ZpAEIvbNr-ANuASV@x1n>
 <87jzhi1odn.fsf@suse.de> <ZpmFT9O-UN30i1F1@x1n> <87frs61jcr.fsf@suse.de>
 <ZpmOmXS2G3f_65xK@x1n> <87cyna1gd6.fsf@suse.de> <ZppyVt0LZanF4lIq@x1n>
Date: Fri, 19 Jul 2024 13:54:37 -0300
Message-ID: <875xt11fw2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.10 / 50.00]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[4]
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

> On Thu, Jul 18, 2024 at 07:32:05PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Jul 18, 2024 at 06:27:32PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
>> >> >> v2 is ready, but unfortunately this approach doesn't work. When client A
>> >> >> takes the payload, it fills it with it's data, which may include
>> >> >> allocating memory. MultiFDPages_t does that for the offset. This means
>> >> >> we need a round of free/malloc at every packet sent. For every client
>> >> >> and every allocation they decide to do.
>> >> >
>> >> > Shouldn't be a blocker?  E.g. one option is:
>> >> >
>> >> >     /* Allocate both the pages + offset[] */
>> >> >     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
>> >> >                                       sizeof(ram_addr_t) * n, 1);
>> >> >     pages->allocated = n;
>> >> >     pages->offset = &pages[1];
>> >> >
>> >> > Or.. we can also make offset[] dynamic size, if that looks less tricky:
>> >> >
>> >> > typedef struct {
>> >> >     /* number of used pages */
>> >> >     uint32_t num;
>> >> >     /* number of normal pages */
>> >> >     uint32_t normal_num;
>> >> >     /* number of allocated pages */
>> >> >     uint32_t allocated;
>> >> >     RAMBlock *block;
>> >> >     /* offset of each page */
>> >> >     ram_addr_t offset[0];
>> >> > } MultiFDPages_t;
>> >> 
>> >> I think you missed the point. If we hold a pointer inside the payload,
>> >> we lose the reference when the other client takes the structure and puts
>> >> its own data there. So we'll need to alloc/free everytime we send a
>> >> packet.
>> >
>> > For option 1: when the buffer switch happens, MultiFDPages_t will switch as
>> > a whole, including its offset[], because its offset[] always belong to this
>> > MultiFDPages_t.  So yes, we want to lose that *offset reference together
>> > with MultiFDPages_t here, so the offset[] always belongs to one single
>> > MultiFDPages_t object for its lifetime.
>> 
>> MultiFDPages_t is part of MultiFDSendData, it doesn't get allocated
>> individually:
>> 
>> struct MultiFDSendData {
>>     MultiFDPayloadType type;
>>     union {
>>         MultiFDPages_t ram_payload;
>>     } u;
>> };
>> 
>> (and even if it did, then we'd lose the pointer to ram_payload anyway -
>> or require multiple free/alloc)
>
> IMHO it's the same.
>
> The core idea is we allocate a buffer to put MultiFDSendData which may
> contain either Pages_t or DeviceState_t, and the size of the buffer should
> be MAX(A, B).
>

Right, but with your zero-length array proposals we need to have a
separate allocation for MultiFDPages_t because to expand the array we
need to include the number of pages.

Also, don't think only about MultiFDPages_t. With this approach we
cannot have pointers to memory allocated by the client at all anywhere
inside the union. Every pointer needs to have another reference
somewhere else to ensure we don't leak it. That's an unnecessary
restriction.

>> 
>> >
>> > For option 2: I meant MultiFDPages_t will have no offset[] pointer anymore,
>> > but make it part of the struct (MultiFDPages_t.offset[]).  Logically it's
>> > the same as option 1 but maybe slight cleaner.  We just need to make it
>> > sized 0 so as to be dynamic in size.
>> 
>> Seems like an undefined behavior magnet. If I sent this as the first
>> version, you'd NACK me right away.
>> 
>> Besides, it's an unnecessary restriction to impose in the client
>> code. And like above, we don't allocate the struct directly, it's part
>> of MultiFDSendData, that's an advantage of using the union.
>> 
>> I think we've reached the point where I'd like to hear more concrete
>> reasons for not going with the current proposal, except for the
>> simplicity argument you already put. I like the union idea, but OTOH we
>> already have a working solution right here.
>
> I think the issue with current proposal is each client will need to
> allocate (N+1)*buffer, so more user using it the more buffers we'll need (M
> users, then M*(N+1)*buffer).  Currently it seems to me we will have 3 users
> at least: RAM, VFIO, and some other VMSD devices TBD in mid-long futures;
> the latter two will share the same DeviceState_t.  Maybe vDPA as well at
> some point?  Then 4.

You used the opposite argument earlier in this thread to argue in favor
of the union: We'll only have 2 clients. I'm confused.

Although, granted, this RFC does use more memory.

> I'd agree with this approach only if multifd is flexible enough to not even
> know what's the buffers, but it's not the case, and we seem only care about
> two:
>
>   if (type==RAM)
>      ...
>   else
>      assert(type==DEVICE);
>      ...

I don't understand: "not even know what's the buffers" is exactly what
this series is about. It doesn't have any such conditional on "type".

>
> In this case I think it's easier we have multifd manage all the buffers
> (after all, it knows them well...).  Then the consumption is not
> M*(N+1)*buffer, but (M+N)*buffer.

Fine. As I said, I like the union approach. It's just that it doesn't
work if the client wants to have a pointer in there.

Again, this is client data that multifd holds, it's not multifd
data. MultiFDPages_t or DeviceState_t have nothing to do with
multifd. It should be ok to have:

DeviceState_t *devstate = &p->data->u.device;
devstate->foo = g_new0(...);
devstate->bar = g_new0(...);

just like we have:

MultiFDPages_t *pages = &p->data->u.ram;
pages->offset = g_new0(ram_addr_t, page_count);

>
> Perhaps push your tree somewhere so we can have a quick look?

https://gitlab.com/farosas/qemu/-/commits/multifd-pages-decouple

> I'm totally
> lost when you said I'll nack it.. so maybe I didn't really get what you
> meant.  Codes may clarify that.

I'm conjecturing that any contributor adding a zero-length array (a[0])
would probably be given a hard time on the mailing list. There's 10
instances of it in the code base. The proper way to grow an array is to
use a flexible array (a[]) instead.

