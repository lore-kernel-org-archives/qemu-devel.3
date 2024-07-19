Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBB7C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 21:31:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUvC7-00064l-Qs; Fri, 19 Jul 2024 17:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUvC3-00063a-VQ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 17:31:12 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sUvBy-0002VN-3k
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 17:31:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2F9E21AC6;
 Fri, 19 Jul 2024 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721424662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eig/d6eML9ExfrLkGgKZKczJYzGuJmk8L9q7Tf24FEM=;
 b=kObDE6o3PHfyJrvM+7KiLQni14RvsFuiZyG0A8aPjIoNAOGFcgycClt6pxJcPYWk5unRpJ
 t7MSAcI/9/p7kSilRwZB+0xDsLHlKJoJrqZdY9eQJbjEzyYzTKW3pJzqtZ7dj1xDLY5j/8
 sqKgH3htLX5gj33eQN0vQ2KXK+HdgKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721424662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eig/d6eML9ExfrLkGgKZKczJYzGuJmk8L9q7Tf24FEM=;
 b=4f2zy8pv73TYY5rtnHxX32NeuoiOgwRh0AXJAyL0j5/1SQQrm7f5syjdaujAc+EhJCm00N
 rZq7VOeFxvbnPRBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721424661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eig/d6eML9ExfrLkGgKZKczJYzGuJmk8L9q7Tf24FEM=;
 b=cj2rd0rfjdoMfd2nhxk472rRzsRy/oc43DbF+7EWnB+E4MmysLtkaQ2avPOsbrcYh9DIDb
 xLvx9J9oJRYIATCpD7AuV8gZqx8SDLQJdomfkXyi4DO4XcGO0p3rHufPJcD5XDcx/M1ige
 qEqHU1ED7tHH3Od02ckZexWkjTl0nV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721424661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eig/d6eML9ExfrLkGgKZKczJYzGuJmk8L9q7Tf24FEM=;
 b=qtrlNzCysahHvctPD1ZnMpW2lpaSnIjU/B1w9+WJXk7v3UhY1ZgD17+5JMzYtcrp/fP7vG
 jNr3Q/IBMJeOGIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D51132CB;
 Fri, 19 Jul 2024 21:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UiQMCxXbmmbKWgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jul 2024 21:31:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org, "Maciej S .
 Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
In-Reply-To: <ZpqpVDnVROeHg9Bn@x1n>
References: <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87jzhi1odn.fsf@suse.de> <ZpmFT9O-UN30i1F1@x1n>
 <87frs61jcr.fsf@suse.de> <ZpmOmXS2G3f_65xK@x1n> <87cyna1gd6.fsf@suse.de>
 <ZppyVt0LZanF4lIq@x1n> <875xt11fw2.fsf@suse.de> <ZpqpVDnVROeHg9Bn@x1n>
Date: Fri, 19 Jul 2024 18:30:58 -0300
Message-ID: <8734o5133h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.10 / 50.00]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,gnu.org:url]
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

> On Fri, Jul 19, 2024 at 01:54:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Jul 18, 2024 at 07:32:05PM -0300, Fabiano Rosas wrote:
>> >> Peter Xu <peterx@redhat.com> writes:
>> >> 
>> >> > On Thu, Jul 18, 2024 at 06:27:32PM -0300, Fabiano Rosas wrote:
>> >> >> Peter Xu <peterx@redhat.com> writes:
>> >> >> 
>> >> >> > On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
>> >> >> >> v2 is ready, but unfortunately this approach doesn't work. When client A
>> >> >> >> takes the payload, it fills it with it's data, which may include
>> >> >> >> allocating memory. MultiFDPages_t does that for the offset. This means
>> >> >> >> we need a round of free/malloc at every packet sent. For every client
>> >> >> >> and every allocation they decide to do.
>> >> >> >
>> >> >> > Shouldn't be a blocker?  E.g. one option is:
>> >> >> >
>> >> >> >     /* Allocate both the pages + offset[] */
>> >> >> >     MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
>> >> >> >                                       sizeof(ram_addr_t) * n, 1);
>> >> >> >     pages->allocated = n;
>> >> >> >     pages->offset = &pages[1];
>> >> >> >
>> >> >> > Or.. we can also make offset[] dynamic size, if that looks less tricky:
>> >> >> >
>> >> >> > typedef struct {
>> >> >> >     /* number of used pages */
>> >> >> >     uint32_t num;
>> >> >> >     /* number of normal pages */
>> >> >> >     uint32_t normal_num;
>> >> >> >     /* number of allocated pages */
>> >> >> >     uint32_t allocated;
>> >> >> >     RAMBlock *block;
>> >> >> >     /* offset of each page */
>> >> >> >     ram_addr_t offset[0];
>> >> >> > } MultiFDPages_t;
>> >> >> 
>> >> >> I think you missed the point. If we hold a pointer inside the payload,
>> >> >> we lose the reference when the other client takes the structure and puts
>> >> >> its own data there. So we'll need to alloc/free everytime we send a
>> >> >> packet.
>> >> >
>> >> > For option 1: when the buffer switch happens, MultiFDPages_t will switch as
>> >> > a whole, including its offset[], because its offset[] always belong to this
>> >> > MultiFDPages_t.  So yes, we want to lose that *offset reference together
>> >> > with MultiFDPages_t here, so the offset[] always belongs to one single
>> >> > MultiFDPages_t object for its lifetime.
>> >> 
>> >> MultiFDPages_t is part of MultiFDSendData, it doesn't get allocated
>> >> individually:
>> >> 
>> >> struct MultiFDSendData {
>> >>     MultiFDPayloadType type;
>> >>     union {
>> >>         MultiFDPages_t ram_payload;
>> >>     } u;
>> >> };
>> >> 
>> >> (and even if it did, then we'd lose the pointer to ram_payload anyway -
>> >> or require multiple free/alloc)
>> >
>> > IMHO it's the same.
>> >
>> > The core idea is we allocate a buffer to put MultiFDSendData which may
>> > contain either Pages_t or DeviceState_t, and the size of the buffer should
>> > be MAX(A, B).
>> >
>> 
>> Right, but with your zero-length array proposals we need to have a
>> separate allocation for MultiFDPages_t because to expand the array we
>> need to include the number of pages.
>
> We need to fetch the max size we need and allocate one object covers all
> the sizes we need.  I sincerely don't understand why it's an issue..
>

What you describe is this:

p->data = g_malloc(sizeof(MultiFDPayloadType) +
                   max(sizeof(MultiFDPages_t) + sizeof(ram_addr_t) * page_count,
                       sizeof(MultiFDDevice_t)));

This pushes the payload specific information into multifd_send_setup()
which is against what we've been doing, namely isolating payload
information out of multifd main code.

>> 
>> Also, don't think only about MultiFDPages_t. With this approach we
>> cannot have pointers to memory allocated by the client at all anywhere
>> inside the union. Every pointer needs to have another reference
>> somewhere else to ensure we don't leak it. That's an unnecessary
>> restriction.
>
> So even if there can be multiple pointers we can definitely play the same
> trick that we allocate object A+B+C+D in the same chunk and let A->b points
> to B, A->c points to C, and so on.
>
> Before that, my question is do we really need that.
>
> For device states, AFAIU it'll always be an opaque buffer..  VFIO needs
> that, vDPA probably the same, and for VMSDs it'll be a temp buffer to put
> the VMSD dump.
>
> For multifd, I used offset[0] just to make sure things like "dynamic sized
> multifd buffers" will easily work without much changes.  Or even we could
> have this, afaict:
>
> #define MULTIFD_PAGES_PER_PACKET (128)
>
> typedef struct {
>     /* number of used pages */
>     uint32_t num;
>     /* number of normal pages */
>     uint32_t normal_num;
>     /* number of allocated pages */
>     uint32_t allocated;
>     RAMBlock *block;
>     /* offset of each page */
>     ram_addr_t offset[MULTIFD_PAGES_PER_PACKET];
> } MultiFDPages_t;

I think this is off the table, we're looking into allowing multifd
packet size to change. Page size can change as well.

Also future payload types might need to add dynamically allocated data
to the payload. Although it might be ok if we have a rule that
everything in the payload needs to be static, it just seems unnecessary.

>
> It might change perf on a few archs where psize is not 4K, but I don't see
> it a huge deal, personally.
>
> Then everything will have no pointers, and it can be even slightly faster
> because we use 64B cachelines in most systems nowadays, and one indirect
> pointer may always need a load on a new cacheline otherwise..
>
> This whole cacheline thing is trivial.  What I worried that you worry too
> much on that flexibility that we may never need.
>
> And even with that flexibilty I don't understand why you don't like
> allocating an object that's larger than how the union is defined: I really

The object being larger than the union is not the point. The point is we
don't know what size that array will have, because that's
client-specific data. Say RAM code wants an array of X size, vmstate
might need another of Y size, etc.

> don't see it a problem..  It'll need care on alloc/free, true, but it
> should be pretty manageable in this case to me.
>
>> 
>> >> 
>> >> >
>> >> > For option 2: I meant MultiFDPages_t will have no offset[] pointer anymore,
>> >> > but make it part of the struct (MultiFDPages_t.offset[]).  Logically it's
>> >> > the same as option 1 but maybe slight cleaner.  We just need to make it
>> >> > sized 0 so as to be dynamic in size.
>> >> 
>> >> Seems like an undefined behavior magnet. If I sent this as the first
>> >> version, you'd NACK me right away.
>> >> 
>> >> Besides, it's an unnecessary restriction to impose in the client
>> >> code. And like above, we don't allocate the struct directly, it's part
>> >> of MultiFDSendData, that's an advantage of using the union.
>> >> 
>> >> I think we've reached the point where I'd like to hear more concrete
>> >> reasons for not going with the current proposal, except for the
>> >> simplicity argument you already put. I like the union idea, but OTOH we
>> >> already have a working solution right here.
>> >
>> > I think the issue with current proposal is each client will need to
>> > allocate (N+1)*buffer, so more user using it the more buffers we'll need (M
>> > users, then M*(N+1)*buffer).  Currently it seems to me we will have 3 users
>> > at least: RAM, VFIO, and some other VMSD devices TBD in mid-long futures;
>> > the latter two will share the same DeviceState_t.  Maybe vDPA as well at
>> > some point?  Then 4.
>> 
>> You used the opposite argument earlier in this thread to argue in favor
>> of the union: We'll only have 2 clients. I'm confused.
>
> Maybe I meant "2 types of clients"?  VDPA will also use the same device
> state buffer.
>
>> 
>> Although, granted, this RFC does use more memory.
>
> IMHO it's also easier to understand, where any user always has a free
> SendData buffer to manipulate, and multifd always has one buffer for each
> channel (free or busy).
>
> That is compared to each client needs to allocate
> N buffers and we're actually at least leaking "number of multifd channels"
> into the client which may not be wanted.

That's a stretch. multifd-channels is a migration parameter, it's fine
if any code has access to it.

>
> IOW, I wonder whether you're happy with below to drop the union idea:
>
>      struct MultiFDSendData {
>          MultiFDPayloadType type;
>          MultiFDPages_t ram_payload;
>          MultiFDDeviceState_t device_payload;
>      };
>
> Then we keep the "(M+N)" usage model, but don't use union and simply forget
> about the memory consumption (similar to your original memory consumption
> with this, but will be better as long as anything else joins, e.g. vDPA,
> because then vDPA will at least share that same buffer with VFIO).
>
> Do you think you would accept this?

I'm not sure. I'll try some alternatives first. Maybe the a[] approach
is not so bad. More below...

>
>> 
>> > I'd agree with this approach only if multifd is flexible enough to not even
>> > know what's the buffers, but it's not the case, and we seem only care about
>> > two:
>> >
>> >   if (type==RAM)
>> >      ...
>> >   else
>> >      assert(type==DEVICE);
>> >      ...
>> 
>> I don't understand: "not even know what's the buffers" is exactly what
>> this series is about. It doesn't have any such conditional on "type".
>> 
>> >
>> > In this case I think it's easier we have multifd manage all the buffers
>> > (after all, it knows them well...).  Then the consumption is not
>> > M*(N+1)*buffer, but (M+N)*buffer.
>> 
>> Fine. As I said, I like the union approach. It's just that it doesn't
>> work if the client wants to have a pointer in there.
>> 
>> Again, this is client data that multifd holds, it's not multifd
>> data. MultiFDPages_t or DeviceState_t have nothing to do with
>> multifd. It should be ok to have:
>> 
>> DeviceState_t *devstate = &p->data->u.device;
>> devstate->foo = g_new0(...);
>> devstate->bar = g_new0(...);
>> 
>> just like we have:
>> 
>> MultiFDPages_t *pages = &p->data->u.ram;
>> pages->offset = g_new0(ram_addr_t, page_count);
>> 
>> >
>> > Perhaps push your tree somewhere so we can have a quick look?
>> 
>> https://gitlab.com/farosas/qemu/-/commits/multifd-pages-decouple
>> 
>> > I'm totally
>> > lost when you said I'll nack it.. so maybe I didn't really get what you
>> > meant.  Codes may clarify that.
>> 
>> I'm conjecturing that any contributor adding a zero-length array (a[0])
>> would probably be given a hard time on the mailing list. There's 10
>> instances of it in the code base. The proper way to grow an array is to
>> use a flexible array (a[]) instead.
>
> I'm not familiar with flexible array.  What's the difference between:
>
> struct {
>     int a[];
> };
>
> v.s.
>
> struct {
>     int a[0];
> };

Both are ways of making a dynamically sized structure. We allocate them
with:

s = malloc(sizeof(struct) + n * sizeof(int));

a[0] is the older way and full of issues:

 - sizeof might return 0 or 1 depending on compiler extensions
 
 - the compiler can't tell when the array is not at the end of the struct
 
 - I'm not sure putting this inside an usion is well defined. gcc docs
   mention:
 
   "Declaring zero-length arrays in other contexts, including as interior
   members of structure objects or as non-member objects, is
   discouraged. Accessing elements of zero-length arrays declared in such
   contexts is undefined and may be diagnosed." --
   https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
 
 - the kernel has deprecated this usage entirely:
 
  "...this led to other problems ... like not being able to detect when
  such an array is accidentally being used _not_ at the end of a
  structure (which could happen directly, or when such a struct was in
  unions, structs of structs, etc)." --
  https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

a[] is the modern way and doesn't have the issues above, but it's still
not a perfect solution for us:

- note above how allocation doesn't reference "a" directly, which means
  we need to know "n" at the time of allocating p->data. This requires
  the sizeof mess I mentioned at the beginning.

- the array needs to be at the end of the structure, so we can only have
  one of them per payload.

- I have no idea how this would work if more than one payload needed an
  array like that.

I'll give this one a shot and see how it looks. I'm getting tired of
looking at this code.

