Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755D8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOtJv-00055T-R3; Mon, 18 May 2026 04:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wOtJo-00055B-Hf
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:27:23 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wOtJl-0006qe-T8
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:27:19 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2f7020a928eso2655659eec.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 01:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779092835; cv=none;
 d=google.com; s=arc-20240605;
 b=km3YH5rq/7O8f0JmM9IW4i/Q+Z+G8BdW2KIySApjFxnx3XuImWVnuBftiFb3xD73Xw
 EW2VZ31ZnWvgmAl27Rwiafks+RU9piWfWXDITv6qBSLzvxRJgLO04s4qNGfW5fnkE9O1
 +9/qpwCFuOo9JZrU1EJD0279/0hmnQJwkL0yg7WWW1ImzJE4AmlYAYBvUEdpyn6CFmp9
 FuYglIeNgE2DaQTG67Wvo/noQ9jlwXCRDAnTs6kF9YuBhzKQIfPxd10U9FZyYoyRT8JR
 GcNnT+P/kg+uEJ8c66QccSQl797RxqGouifBXEsO81yd+oD4PHL52EWZ72fULAK1KXur
 wgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7pXnQwkBSIkmcykbUlvYUJJBvl1FPKOhFGBkT3Mmp+0=;
 fh=8aBEJY+feA7d7ThUvpzyIH9FOGeOtT6IdrliqPJEqPM=;
 b=J97z+I1I1AsWvx55AwODNgxDt7jS9WSxG91bFzKQYG/os50AIsqDcLyQGJ1jWcim5F
 bnIDQAxFalR64leEldgO+N7rfhE9HlxMBNbLTBYp0pAZ7trktmfXM+bZZ8hny8Y+F4Tu
 ZcYCpO4PgIznVWb9GzLcnKHbBINCrQCvRbdQZ6OHMlvMacxGQ0RBo3raMPDHACPaty3b
 l2B0aFdAdSM36GG1wpdJVQzn0ZeOo03zQGFND4r6BgO0K9FKcCgNU+H71WC/IMxMTaqP
 GwN7Fg4di/fq7RmE4S8glH53zULa83rryVSUoZgAC/Q47BzdZsDss7zYaqOyiqRa7xTQ
 bodA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779092835; x=1779697635; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7pXnQwkBSIkmcykbUlvYUJJBvl1FPKOhFGBkT3Mmp+0=;
 b=j5TZuMc03Moxxag6ARnLVT+72ujuJaZ/6EUld7aMg3TQRhQnXix6Z1IvjRAjKTELmH
 MLJrxB6SwXQGUz3nA6nZvZ/hgsIYG8R7tiOv8Oxc/iAxHaMgq4rQOfnvd1O4n46NDYmR
 Moc2GJ1jAE8sDQzuqUXXkgncjBATi3ucMaDXiHD2g93RckPz21njtgsbtqircxW3gVv7
 UQNhUMZX70CY+0QJed9/rvG6W25XZV8c79Jp5iPFMbwnLCs/U1AZdPkcloPjQHlKJKAb
 OwRXpHhUWExtZf+uQ1MeyMrgpRAgNDG6YLe74QT9whzA92LPHacrFq1DEcu8cdwa019y
 ZgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779092835; x=1779697635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7pXnQwkBSIkmcykbUlvYUJJBvl1FPKOhFGBkT3Mmp+0=;
 b=o8cCSbxKnvo1CY7hrdPIrnehMEPs5eXBZlAYr3Wu4EDquFOKnBG1o93NibFQZDA0aa
 27oB8mTdJb56JrY3DAFzUd7cUoC2io92lbMF9qyWlffzLleSeeQufy4qJhtFt/59vNAc
 EAfBCwXpUUO5Vup8e3qssAq5YuhgJGudv19g51FQTYzHG7JGv/2x4DdpU4FCGi5p0EDm
 HI1NFnjO8CI1DZFZEjHa1/sfv4kZ2tUCKQtMAH3j1yJmP9UxVKplMdO643nAKPx7zGdq
 zWNtW8fH/ELc4XzdAhLGOJa1CJr476OlGHK9fXIjlLU0/qdlF4SYzwHE9fWkQfKSRgQ0
 0WFw==
X-Gm-Message-State: AOJu0Yxpr9KCVeQwrHlKBJQpUbdpTwRnXXvmT1szuS6jB2BUAFNyGHQI
 s0fLgMH6GgOlhDbDgYvpeDHHle4ZduIfeRT0zGr6EC0H7XP4PqwGTXI09u8SHhLu6DxVcyqNXbv
 RRUlmlqjlLg3jv3bUI9tIACIuxrfDGp0+K+3kkKI=
X-Gm-Gg: Acq92OGKNCEn77CqDiHdB4e3gLayHDFA1JVPIAEtyW3MZP7Ass1E+AQuzSLthsG1+C+
 d3Q3B5s4l0QGFONJHnwVYsl49XvfWnO5RgU5OaYUczPIVs9vOQoJOT4Q4QkHVTXMdmfKDL8zrfl
 /3pNpcusX/P57G6D1ZkHA/Jk4Tp3+6zrVqtGHiGlvY6Bk+4Fcq2wh6dqPkhESJY9lMuDjdjCSOe
 p7yF6GCmXr3FHWISMy7dhl38B1vTl7Lmbk7c270slapVDoxHc0tg6MEYPGLbRLR32y/QrowTEzS
 apT1vaCNtmPHq2VGSudOB6mTbqpdvZzayN3s5BTOlI4PZw7jTA==
X-Received: by 2002:a05:7301:4001:b0:2c1:7793:7bbb with SMTP id
 5a478bee46e88-3039869793amr5607118eec.27.1779092835320; Mon, 18 May 2026
 01:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com>
 <875x4lz0q6.fsf@pond.sub.org>
In-Reply-To: <875x4lz0q6.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 18 May 2026 12:27:02 +0400
X-Gm-Features: AVHnY4LC5aEJBzkuBR9CCo0fzD_JIMPCQQD_b3dViXMye7eAaa61iSDMBSf1poY
Message-ID: <CAJ+F1CKpZsWFZy9LSU8WCekNq3B_hWhfw4Xz1pyp2zkRzhPs_g@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] monitor: add 'info ramblock-attributes' command
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Markus

I am not an expert in this area, and I am only working on this series
occasionally (too little activity to keep me fresh on the topic,
unfortunately). Bear with me.

On Mon, May 18, 2026 at 10:34=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > Add a new 'info ramblock-attributes' HMP command and the corresponding
> > 'x-query-ramblock-attributes' QMP command to display the shared/private
> > memory attributes for ram blocks.
> >
> > The QMP command returns structured data (RamBlockAttributesInfo list
> > with per-range shared/populated attributes), while HMP formats it for
> > human consumption.
> >
> > This is useful for debugging confidential guests (TDX, SNP) to inspect
> > which memory regions are shared vs private, and their population state
> > when a RamDiscardManager is present (e.g. virtio-mem).
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qapi/machine.json             | 55 +++++++++++++++++++++++++++++++++
> >  include/monitor/hmp.h         |  1 +
> >  hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
> >  system/ram-block-attributes.c | 72 +++++++++++++++++++++++++++++++++++=
++++++++
> >  hmp-commands-info.hx          | 13 ++++++++
> >  5 files changed, 173 insertions(+)
> >
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 685e4e29b87..aac8a235cf6 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
>
> I have a few fairly ignorant questions.  They may or may not indicate a
> need for doc improvements.
>
> > @@ -1738,6 +1738,61 @@
> >    'returns': 'HumanReadableText',
> >    'features': [ 'unstable' ] }
> >
> > +##
> > +# @RamBlockAttributeRange:
> > +#
> > +# A contiguous range within a ram block with uniform attributes.
>
> RAM please.  More of the same below, not flagging it again.
>

ok

> > +#
> > +# @start: start offset in bytes within the ram block
> > +#
> > +# @length: length in bytes of the range
> > +#
> > +# @shared: true if the range is shared, false if private
>
> What does it mean for a range to be shared?

commit 5d6483edaa9232d8f3709f68c8eab4bc2033fb70
"in the current context
    of RamDiscardManager for guest_memfd, the shared state is analogous to
    being populated, while the private state can be considered discarded fo=
r
    simplicity. In the future, it would be more complicated if considering
    more states like private/shared/discarded at the same time."

>
> > +#
> > +# @populated: true if the range is populated (only present when a
> > +#     RamDiscardManager is managing the block)
>
> What's a RamDiscardManager?

commit 8947d7fc4e77d36fae44411b1b63c513863f89a7
 * A #RamDiscardManager coordinates which parts of specific RAM #MemoryRegi=
on
 * regions are currently populated to be used/accessed by the VM, notifying
 * after parts were discarded (freeing up memory) and before parts will be
 * populated (consuming memory), to be used/accessed by the VM.

In this series, RamDiscardManager learned to aggregate from multiple
sources (virtio-mem + RamBlockAttributes), so virtio-mem can work with
confidential VMs.

>
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'struct': 'RamBlockAttributeRange',
> > +  'data': { 'start': 'uint64',
> > +            'length': 'uint64',
> > +            'shared': 'bool',
> > +            '*populated': 'bool' } }
> > +
> > +##
> > +# @RamBlockAttributesInfo:
> > +#
> > +# Shared/private memory attributes for a ram block.
> > +#
> > +# @name: the ram block identifier
>
> Where do RAM block names come from?

They are set during vmstate_register_ram(). "idstr" and "name" are
used interchangeably to refer to it.

>
> > +#
> > +# @ranges: list of attribute ranges
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'struct': 'RamBlockAttributesInfo',
> > +  'data': { 'name': 'str',
> > +            'ranges': [ 'RamBlockAttributeRange' ] } }
> > +
> > +##
> > +# @x-query-ramblock-attributes:
> > +#
> > +# Query ram block shared/private attributes.  This is useful
> > +# to debug confidential guests.
>
> What are RAM blocks?

They are the actual host allocated memory backing guest RAM MemoryRegions

>
> > +#
> > +# Features:
> > +#
> > +# @unstable: This command is meant for debugging.
> > +#
> > +# Returns: list of ram block attributes
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'command': 'x-query-ramblock-attributes',
> > +  'returns': [ 'RamBlockAttributesInfo' ],
> > +  'features': [ 'unstable' ] }
> > +
> >  ##
> >  # @x-query-roms:
> >  #
>
> [...]
>
>

