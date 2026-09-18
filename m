Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D14C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 06:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SI9-0004G1-AA; Fri, 18 Sep 2026 02:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7SI7-0004FI-8W
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x7SI5-0001nk-5B
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 02:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789713703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9/ajaWRtzmxqAVtFV3qqqKq77DGgiX44YqMPYPOY+c=;
 b=EyeQE1PpsQcW3zQaPzTyLSeZMDb/KcfhZ7hCy0xfGJnJHZpj/vDddDts167/VnOk6Cn4V/
 GIu1AgSFz6HpV7FTAye6slJ5QGX4b4SY4uD7wCcsRzuFAvTCU3T/PPDWhqWme/dWh1rxm3
 ljWBH784zi08VEv7X7AX7BWk661CNBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-Xw1kOKKNOraaqRVbgfYxPQ-1; Fri,
 18 Sep 2026 02:41:38 -0400
X-MC-Unique: Xw1kOKKNOraaqRVbgfYxPQ-1
X-Mimecast-MFC-AGG-ID: Xw1kOKKNOraaqRVbgfYxPQ_1789713697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 243621956054; Fri, 18 Sep 2026 06:41:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25AC830001A2; Fri, 18 Sep 2026 06:41:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B574321E6A04; Fri, 18 Sep 2026 08:41:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Jason Wang
 <jasowangio@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org,  Eric Blake <eblake@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu <peterx@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>
Subject: Re: [PATCH 2/9] qapi: convert multi-paragraph intros (commands)
In-Reply-To: <CAFn=p-aEjPnXH_xvJJWcPYoZmqXP1PCyKAReV7rXfJD0hQskLA@mail.gmail.com>
 (John Snow's message of "Thu, 17 Sep 2026 16:09:44 -0400")
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-3-jsnow@redhat.com>
 <874ifpcz85.fsf@pond.sub.org>
 <CAFn=p-aEjPnXH_xvJJWcPYoZmqXP1PCyKAReV7rXfJD0hQskLA@mail.gmail.com>
Date: Fri, 18 Sep 2026 08:41:32 +0200
Message-ID: <87jyojoycj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Wed, Sep 16, 2026 at 5:38=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch converts some slightly-non-trivial intros with more than
>> > one paragraph, but doesn't create any new intro/details splits.
>> >
>> > Review notes: Some of these possibly could be split, but as they are c=
ommands
>> > (not eligible as an inlining source) and the additional information in
>> > the intro is not terribly long, I opted to leave them alone instead of
>> > laboring on prose rewrites.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  qapi/block-core.json | 49 +++++++++++++++++++++-----------------------
>> >  qapi/block.json      | 29 +++++++++++++-------------
>> >  qapi/migration.json  |  9 ++++----
>> >  qapi/misc-arm.json   |  9 ++++----
>> >  qapi/misc.json       | 13 ++++++------
>> >  qapi/qdev.json       | 14 ++++++-------
>> >  6 files changed, 58 insertions(+), 65 deletions(-)
>> >
>> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> > index 1ca147285e7..c505369aeb2 100644
>> > --- a/qapi/block-core.json
>> > +++ b/qapi/block-core.json
>> > @@ -1772,13 +1772,12 @@
>> >
>> >  ##
>> >  # @blockdev-snapshot:
>> > +#     Takes a snapshot of a block device.
>> >  #
>> > -# Takes a snapshot of a block device.
>> > -#
>> > -# Take a snapshot, by installing 'node' as the backing image of
>> > -# 'overlay'.  Additionally, if 'node' is associated with a block
>> > -# device, the block device changes to using 'overlay' as its new
>> > -# active image.
>> > +#     Take a snapshot, by installing 'node' as the backing image of
>> > +#     'overlay'.  Additionally, if 'node' is associated with a block
>> > +#     device, the block device changes to using 'overlay' as its new
>> > +#     active image.
>>
>> 'overlay' and 'node' refer to arguments, so they should be @overlay and
>> @node.  Since the arguments are in type BlockdevSnapshot, the reference
>> is non-local until the inliner lands.
>
> It isn't a reference at all as far as Sphinx is concerned, merely a
> markup convention. Whether or not that convention applies to non-local
> things is kind of up to you. If you say the word, I'll edit these in
> this series and forward if you wish, but my default will be to leave
> it alone.

Right now, improving markup is a distraction we need to avoid.  We
should still take notes for later, though.

The obvious goal is to mark up references to things so they can be
suitably rendered, preferably as links.

Solved markup problem for references to definitions (`name-of-defn`) and
local member descriptions (@name-of-member).  We don't have a good
solution for referencing non-local member descriptions.

>> We may want to render this paragraph below the argument descriptions to
>> avoid forward references.  This requires splitting it off the intro.  We
>> can do it now, or leave it for later.
>>
>> Not splitting now keeps the conversion simple, which is a plus.  It
>> reindents the entire unsplit intro, and if we do split it later, the
>> part split off gets reindented right back.
>>
>> I'm leaning towards not rocking the boat, but you decide.
>
> I'm likely to forget or ignore about later splits, so if it's
> something you want, we may as well do it now. Note that we can just
> decide to only indent the first paragraph and leave the second
> unindented, and then it gets shifted into place during a later code
> movement patch.

Yes, that's splitting off the intro.  It forces us to revisit the doc
comment when we eliminate the plain sections between intro and tagged
sections.  Simple way to punt contents work down the road some.

I'm encouraging you to do that when you're less than sure the contents
should be intro, simply because the primary goal right now is to get the
syntax conversion done.  Limiting followup cleanup work is secondary: we
do it whenever it doesn't distract us from the primary.

Makes sense?

>> Not noting these things again.
>>
>> >  #
>> >  # Features:
>> >  #
>> > @@ -2471,15 +2470,15 @@
>> >  ##
>> >  # @block-dirty-bitmap-merge:
>> >  #
>>
>> Drop the blank line.
>
> ACK. Accidental remnants of adding a blank line intentionally to get
> reflow to behave how I want.
>
>>
>> > -# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
>> > -# Dirty bitmaps in @bitmaps will be unchanged, except if it also
>> > -# appears as the @target bitmap.  Any bits already set in @target will
>> > -# still be set after the merge, i.e., this operation does not clear
>> > -# the target.  On error, @target is unchanged.
>> > +#     Merge dirty bitmaps listed in @bitmaps to the @target dirty
>> > +#     bitmap.  Dirty bitmaps in @bitmaps will be unchanged, except if
>> > +#     it also appears as the @target bitmap.  Any bits already set in
>> > +#     @target will still be set after the merge, i.e., this operation
>> > +#     does not clear the target.  On error, @target is unchanged.
>> >  #
>> > -# The resulting bitmap will count as dirty any clusters that were
>> > -# dirty in any of the source bitmaps.  This can be used to achieve
>> > -# backup checkpoints, or in simpler usages, to copy bitmaps.
>> > +#     The resulting bitmap will count as dirty any clusters that were
>> > +#     dirty in any of the source bitmaps.  This can be used to achieve
>> > +#     backup checkpoints, or in simpler usages, to copy bitmaps.
>> >  #
>> >  # Errors:
>> >  #     - If @node is not a valid block device, DeviceNotFound
>> > @@ -5848,15 +5847,14 @@
>> >
>> >  ##
>> >  # @block-set-write-threshold:
>> > +#     Change the write threshold for a block drive.  An event will be
>> > +#     delivered if a write to this block drive crosses the configured
>> > +#     threshold.  The threshold is an offset, thus must be
>> > +#     non-negative.  Default is no write threshold.  Setting the
>> > +#     threshold to zero disables it.
>> >  #
>> > -# Change the write threshold for a block drive.  An event will be
>> > -# delivered if a write to this block drive crosses the configured
>> > -# threshold.  The threshold is an offset, thus must be non-negative.
>> > -# Default is no write threshold.  Setting the threshold to zero
>> > -# disables it.
>> > -#
>> > -# This is useful to transparently resize thin-provisioned drives
>> > -# without the guest OS noticing.
>> > +#     This is useful to transparently resize thin-provisioned drives
>> > +#     without the guest OS noticing.
>> >  #
>> >  # @node-name: graph node name on which the threshold must be set.
>> >  #
>> > @@ -5938,11 +5936,10 @@
>> >
>> >  ##
>> >  # @x-blockdev-set-iothread:
>> > +#     Move @node and its children into the @iothread.  If @iothread is
>> > +#     null then move @node and its children into the main loop.
>> >  #
>> > -# Move @node and its children into the @iothread.  If @iothread is
>> > -# null then move @node and its children into the main loop.
>> > -#
>> > -# The node must not be attached to a BlockBackend.
>> > +#     The node must not be attached to a BlockBackend.
>>
>> This one arguably lacks an intro.  Let's not worry about this now.
>
> How about I indent *nothing* and lead with a "#TODO: This command
> needs an introduction" ?

Do we want every command to have an intro?

If we do, we should enforce it at some point.  If we plan to enforce it,
simply leaving the intro empty now will be caught without a TODO.

I'm taking note:

9. Consider making intro mandatory (maybe just for commands and
events?)

>> >  #
>> >  # @node-name: the name of the block driver node
>> >  #
>> > diff --git a/qapi/block.json b/qapi/block.json
>> > index e47592d5500..15f08372564 100644
>> > --- a/qapi/block.json
>> > +++ b/qapi/block.json
>> > @@ -181,12 +181,13 @@
>> >
>> >  ##
>> >  # @blockdev-close-tray:
>> > +#     Closes a block device's tray.
>> >  #
>> > -# Closes a block device's tray.  If there is a block driver state tree
>> > -# associated with the block device (which is currently ejected), that
>> > -# tree will be loaded as the medium.
>> > +#     If there is a block driver state tree associated with the block
>> > +#     device (which is currently ejected), that tree will be loaded as
>> > +#     the medium.
>> >  #
>> > -# If the tray was already closed before, this will be a no-op.
>> > +#     If the tray was already closed before, this will be a no-op.
>> >  #
>> >  # @device: Block device name
>> >  #
>>
>> Shouldn't this one be in "[PATCH 5/9] qapi: split intro sections for
>> commands"?
>
> Ah, I did something halfway between ... Well, this particular block
> doesn't actually add a new "split", but I did reflow the paragraphs
> *as if* I had performed the split.

You're right.

> Let's collapse this one way or the other: please state your
> preference, and I'll sift it into the correct patch.

Breaking the paragraph like you did feels like an improvement to me.

If we think the contents after the paragraph split should not be intro,
then the adjusted patch should be in "[PATCH 5/9] qapi: split intro
sections for commands".

If we think keeping it in intro is fine, then it should stay here.
However, the paragraph split is an unnecesseary contents improvement
then.  Better to keep the syntax conversion patches focused to ease
review.

I'm leaning towards the latter.  Thus:

   ##
   # @blockdev-close-tray:
  -#
  -# Closes a block device's tray.  If there is a block driver state tree
  -# associated with the block device (which is currently ejected), that
  -# tree will be loaded as the medium.
  -#
  -# If the tray was already closed before, this will be a no-op.
  +#     Closes a block device's tray.  If there is a block driver state
  +#     tree associated with the block device (which is currently
  +#     ejected), that tree will be loaded as the medium.
  +#=20=20=20=20=20
  +#     If the tray was already closed before, this will be a no-op.
   #
   # @device: Block device name
   #

Thoughts?

[...]


