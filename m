Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76972CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHFR-0005oP-46; Tue, 19 May 2026 06:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPHFP-0005oG-2o
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:00:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPHFM-0001Xh-TN
 for qemu-devel@nongnu.org; Tue, 19 May 2026 06:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779184818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ezwyf2U2w/a9iifOhqkpVGgHc4A1NvYnd1BK8rIE1xM=;
 b=bbWwOlzQGB1JR4FHEAACth1YIF8iBToRP7f1tfNYa75uG55102A68Q8wv8qAbi2eUZ6qsa
 DY+to287VYogJDQwhOj5KYDScFRw4HaTqkczexqZB5M6ky73M0Qi/X3vdm+QNFUYzDM7+P
 T1HhpQP2iJqP0gobkft186PFf1oKWcM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-QL6YvjQsNW-BV5_uY1-SqQ-1; Tue,
 19 May 2026 06:00:17 -0400
X-MC-Unique: QL6YvjQsNW-BV5_uY1-SqQ-1
X-Mimecast-MFC-AGG-ID: QL6YvjQsNW-BV5_uY1-SqQ_1779184816
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FDAD18002E3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:00:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3F7230001A2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 10:00:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 53A5221E6A01; Tue, 19 May 2026 12:00:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 12/13] monitor: add 'info ramblock-attributes' command
In-Reply-To: <CAJ+F1CKpZsWFZy9LSU8WCekNq3B_hWhfw4Xz1pyp2zkRzhPs_g@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 18 May 2026
 12:27:02 +0400")
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com>
 <875x4lz0q6.fsf@pond.sub.org>
 <CAJ+F1CKpZsWFZy9LSU8WCekNq3B_hWhfw4Xz1pyp2zkRzhPs_g@mail.gmail.com>
Date: Tue, 19 May 2026 12:00:13 +0200
Message-ID: <87bjebpvma.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi Markus
>
> I am not an expert in this area, and I am only working on this series
> occasionally (too little activity to keep me fresh on the topic,
> unfortunately). Bear with me.

Sure!

> On Mon, May 18, 2026 at 10:34=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
>>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>
>> > Add a new 'info ramblock-attributes' HMP command and the corresponding
>> > 'x-query-ramblock-attributes' QMP command to display the shared/private
>> > memory attributes for ram blocks.
>> >
>> > The QMP command returns structured data (RamBlockAttributesInfo list
>> > with per-range shared/populated attributes), while HMP formats it for
>> > human consumption.
>> >
>> > This is useful for debugging confidential guests (TDX, SNP) to inspect
>> > which memory regions are shared vs private, and their population state
>> > when a RamDiscardManager is present (e.g. virtio-mem).
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  qapi/machine.json             | 55 +++++++++++++++++++++++++++++++++
>> >  include/monitor/hmp.h         |  1 +
>> >  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
>> >  system/ram-block-attributes.c | 72 ++++++++++++++++++++++++++++++++++=
+++++++++
>> >  hmp-commands-info.hx          | 13 ++++++++
>> >  5 files changed, 173 insertions(+)
>> >
>> > diff --git a/qapi/machine.json b/qapi/machine.json
>> > index 685e4e29b87..aac8a235cf6 100644
>> > --- a/qapi/machine.json
>> > +++ b/qapi/machine.json
>>
>> I have a few fairly ignorant questions.  They may or may not indicate a
>> need for doc improvements.
>>
>> > @@ -1738,6 +1738,61 @@
>> >    'returns': 'HumanReadableText',
>> >    'features': [ 'unstable' ] }
>> >
>> > +##
>> > +# @RamBlockAttributeRange:
>> > +#
>> > +# A contiguous range within a ram block with uniform attributes.
>>
>> RAM please.  More of the same below, not flagging it again.
>>
>
> ok
>
>> > +#
>> > +# @start: start offset in bytes within the ram block
>> > +#
>> > +# @length: length in bytes of the range
>> > +#
>> > +# @shared: true if the range is shared, false if private
>>
>> What does it mean for a range to be shared?
>
> commit 5d6483edaa9232d8f3709f68c8eab4bc2033fb70
> "in the current context
>     of RamDiscardManager for guest_memfd, the shared state is analogous to
>     being populated, while the private state can be considered discarded =
for
>     simplicity. In the future, it would be more complicated if considering
>     more states like private/shared/discarded at the same time."

Thought and care went into that commit message.  Unfortunately, it's
still greek to me.  Not criticism!  It needs to make sense to the people
working in that area, and I'm not.

Can we assume that anybody with a use for x-query-ramblock-attributes
understands what "range is shared" means?

>> > +#
>> > +# @populated: true if the range is populated (only present when a
>> > +#     RamDiscardManager is managing the block)
>>
>> What's a RamDiscardManager?
>
> commit 8947d7fc4e77d36fae44411b1b63c513863f89a7
>  * A #RamDiscardManager coordinates which parts of specific RAM #MemoryRe=
gion
>  * regions are currently populated to be used/accessed by the VM, notifyi=
ng
>  * after parts were discarded (freeing up memory) and before parts will be
>  * populated (consuming memory), to be used/accessed by the VM.
>
> In this series, RamDiscardManager learned to aggregate from multiple
> sources (virtio-mem + RamBlockAttributes), so virtio-mem can work with
> confidential VMs.

Can we assume that anybody with a use for x-query-ramblock-attributes
understands what "a RamDiscardManager is managing the block" means?

I can't find anything about RamDiscardManager in docs.  Would it make
sense to have something there, so we can point to it here?

>> > +#
>> > +# Since: 11.1
>> > +##
>> > +{ 'struct': 'RamBlockAttributeRange',
>> > +  'data': { 'start': 'uint64',
>> > +            'length': 'uint64',
>> > +            'shared': 'bool',
>> > +            '*populated': 'bool' } }
>> > +
>> > +##
>> > +# @RamBlockAttributesInfo:
>> > +#
>> > +# Shared/private memory attributes for a ram block.
>> > +#
>> > +# @name: the ram block identifier
>>
>> Where do RAM block names come from?
>
> They are set during vmstate_register_ram(). "idstr" and "name" are
> used interchangeably to refer to it.

    void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
    {
        qemu_ram_set_idstr(mr->ram_block,
                           memory_region_name(mr), dev);
        qemu_ram_set_migratable(mr->ram_block);
        ram_block_add_cpr_blocker(mr->ram_block, &error_fatal);
    }

Looks like it's the name of the memory region associated with the RAM
block.  Would "the memory region name" do?  Or would something like "the
name of the RAM block's memory region" be better?

>>
>> > +#
>> > +# @ranges: list of attribute ranges
>> > +#
>> > +# Since: 11.1
>> > +##
>> > +{ 'struct': 'RamBlockAttributesInfo',
>> > +  'data': { 'name': 'str',
>> > +            'ranges': [ 'RamBlockAttributeRange' ] } }
>> > +
>> > +##
>> > +# @x-query-ramblock-attributes:
>> > +#
>> > +# Query ram block shared/private attributes.  This is useful
>> > +# to debug confidential guests.
>>
>> What are RAM blocks?
>
> They are the actual host allocated memory backing guest RAM MemoryRegions

How are RAM blocks related to memory regions?

>> > +#
>> > +# Features:
>> > +#
>> > +# @unstable: This command is meant for debugging.
>> > +#
>> > +# Returns: list of ram block attributes
>> > +#
>> > +# Since: 11.1
>> > +##
>> > +{ 'command': 'x-query-ramblock-attributes',
>> > +  'returns': [ 'RamBlockAttributesInfo' ],
>> > +  'features': [ 'unstable' ] }
>> > +
>> >  ##
>> >  # @x-query-roms:
>> >  #
>>
>> [...]


