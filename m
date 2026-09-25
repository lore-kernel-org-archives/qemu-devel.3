Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6349FC98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA9WM-0000U6-La; Fri, 25 Sep 2026 13:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xA9WJ-0000TU-FK
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xA9WF-0005Qb-1k
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 13:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790356528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5H26yJoaDXHs9qXxQNcHZ4djewxmzFpOr+ac0GY35jg=;
 b=dWtDKWWCFIvxi6OrW08q4/I8MUVygYfX4y2bQnQpiTjXIa7JqzsaNWpXXX0oudid/Smq5N
 8HQplwwHhssbr2lNZu7pYz8rfdzJcOmGw8zXn9TGosSXStBEeuOIAqF4/2NITG6ZiMZnRH
 7+qTNif4AmA0i7YXlasd3fzvnjpXcEY=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-JUc7wmFjMAG1GqD5wwJ1hw-1; Fri, 25 Sep 2026 13:15:27 -0400
X-MC-Unique: JUc7wmFjMAG1GqD5wwJ1hw-1
X-Mimecast-MFC-AGG-ID: JUc7wmFjMAG1GqD5wwJ1hw_1790356527
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-892be308859so17528447b3.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 10:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790356527; cv=none;
 d=google.com; s=arc-20260327;
 b=PGBzSq+rSh4PDBuR982xuVieG3LgC+87GFBUhQGAZzarj5ufltOvBw8PiN1cpO6MtR
 ZhsTaPeMeRzp9I3YoYg0uf4biuEkaqsGV4gR/p6uXSi7kj+czkiBEtzm/93zFDAXkrt5
 Kpc4jK9jNb+Q7ONbj7+sXR8HvIG2Old4wYqYJwxPherS1mtZC/W6lOXdw6NdEC3eMf2N
 EZIOQ0aFv+EiyI3oNrP5wmmvx8Jkc/+AU18G2JgoVTmt14tqmHU/+NYE9ZtkRnthFSZw
 iUs83LgLdwCV2+wJEBKtgAbGObrRPh+LTzJvBFlFVzcy2lkSGK8ZmmVWIHOIiGqukuEL
 xO3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5H26yJoaDXHs9qXxQNcHZ4djewxmzFpOr+ac0GY35jg=;
 fh=b0Z3lWGcCo1hESi6SCJ0YxnP/BPVR7A0V6Qykw4FH5U=;
 b=FSbZO2YEqgWzXwVk08Df36E7ERDzSMRBzPHo0Snf1DcL88B3+rOhTWSAQ3VvouhdUL
 mkBFdp0x8MPUsdfjAZOMakd6/F1XVWA82rKvqzOf8XnoDxP6z6ns63bRm0WH6kDG2JBr
 Eaj5V6c0dqJhSn1D6cV/Z6zWFjR4oIoJA4SyzPaW51G5TPVQRAh2pBy5RCH3UBDfZMbE
 VOw/gne54lKCd0znvhSaW91gMmoznz409XfrfQZp+Axw+lWYg1RpanF7GIvKM8q98Oqf
 f5nMGWmvudN95G4DCEHJF8i4FRyYUUZvCr28fQqcD+2B56dyQMDTjfF57eMVhycEJ7sv
 z2ZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790356527; x=1790961327; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5H26yJoaDXHs9qXxQNcHZ4djewxmzFpOr+ac0GY35jg=;
 b=t1D1IjJOAj3VqT5yR1ho9xkUH/LM9SYxklV0a6BzBwswEHUzi0m8ukFweN64T1XM0c
 GJelWyzCftUkP6TNbXlptyik/ddMyJO/+sHSEu/GaFV41PpjkVZWnuNmCbsQcm5PclXn
 fWgU/45b9gkEHZ5rrpc/6uO8JKvTMdsZUhXp9NvFVym53YhaSisVKJ5UTMtsTHMcSI+k
 JMyNS73PBEsbnoo5euJXT7UUwrU2YUzJwY9QnXYTiEZEjvACCgqpc+dC/qhYiMi4BnD/
 6UERSA3kOFLvoJk/E4bbH0VYZ/CQqaV7LPpcR7/9hsRwDRjLEWRx9F7nlMhmArhQlfbV
 +2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790356527; x=1790961327;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5H26yJoaDXHs9qXxQNcHZ4djewxmzFpOr+ac0GY35jg=;
 b=NAonMa7nUTFtL5NYhcIBUURWbzgFCcilJZQW+2ZPiNhka5+1ref59Qnxy/BDHn/+cI
 RCBb95PiPdl5YC2/M9yjOrMmjfvJp/AghJJWf/4Do/C//pncjz9LevnXImZ19g/+DzDC
 EoRe9/GjNRWCQSxWfKGEZyksmKHgVJNduY0y+6s/c9iN+nkkkwYQXB5A0OuYPUx193dx
 Qx8mvby4/U+Wyg7zlZTSXtEI8kffn9c+YAbyhX9i8vqU8Aw/retndg+YKs7nD7NFmmG+
 3z0vnhT7LhwUekS5FEujYDACLFInKsNipNUTdNDRtfrZIxJbf3alHtsfLxazN5GqrR83
 HLwg==
X-Gm-Message-State: AFuF++ko526qjE/+vceo3ou62anvFO8R+Rf9kuNrh/JgjNoobK/mD7u5
 1ahDaeR0G2/NNlHFlLtrE7aZAZRoR1jznJwQ9KaFQjDYzmlDRv9G3+wZSm30PfArOvB+P1babxb
 8mnFy3KIFrWrR4w5r2uY1dZYdY6JB29Iah3ZSf806WdfUIkV8FX8BwfieNUGK19CHkLZO7j8jNu
 ycRs/QKmwbcxo7KuH5B1TliuGI1MjCiy8=
X-Gm-Gg: AYBFou0McdtnYILccPMjk4deJEbvXYm8e9xfzNFP7flnvi6qVhK5Qbc7MpUa7lCjxJq
 ai/ZOgaq0U7amw/l+R3Kwyd5V0vU9+SkBiXBIR/TLdShRBEHadAl0udT8WLIJxCsaNMrq5R0fOG
 6Hbf35q/j4sB/G5SuiXGsKxlCzoDUL0lv2qYMpWVAOkAZqdfeWv46HHTBkS8Xjh0+nnS8icVB+C
 ug5trzzuY60+qbz
X-Received: by 2002:a05:690c:dd4:b0:8a8:9149:e4da with SMTP id
 00721157ae682-8a89149f557mr4068087b3.108.1790356526537; 
 Fri, 25 Sep 2026 10:15:26 -0700 (PDT)
X-Received: by 2002:a05:690c:dd4:b0:8a8:9149:e4da with SMTP id
 00721157ae682-8a89149f557mr4067897b3.108.1790356525847; Fri, 25 Sep 2026
 10:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260921205712.1862167-1-jsnow@redhat.com>
 <20260921205712.1862167-3-jsnow@redhat.com>
 <87bj9owdvr.fsf@pond.sub.org>
In-Reply-To: <87bj9owdvr.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 25 Sep 2026 13:15:14 -0400
X-Gm-Features: AclHuK8u2G7-Z4j_BhZCH4uRWCkIh4hXw8kJtrXtWnI1bhaVGa5pgOddVeNEW-Y
Message-ID: <CAFn=p-ZbEQ3LXFRo0Kfvi4Sib7SwBwgthj5HPmxP6HLhMzvEBQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] qapi: convert/split intros for block-core.json
 commands
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 23, 2026 at 4:50=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json | 126 +++++++++++++++++++------------------------
> >  1 file changed, 55 insertions(+), 71 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 802a4af74ed..13981d7e69d 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1556,8 +1556,7 @@
> >
> >  ##
> >  # @block_resize:
> > -#
> > -# Resize a block image while a guest is running.
> > +#     Resize a block image while a guest is running.
> >  #
> >  # Either @device or @node-name must be set but not both.
> >  #
> > @@ -1812,13 +1811,12 @@
> >
> >  ##
> >  # @blockdev-snapshot:
> > +#     Takes a snapshot of a block device.
> >  #
> > -# Takes a snapshot of a block device.
> > -#
> > -# Take a snapshot, by installing 'node' as the backing image of
> > -# 'overlay'.  Additionally, if 'node' is associated with a block
> > -# device, the block device changes to using 'overlay' as its new
> > -# active image.
> > +#     Take a snapshot, by installing 'node' as the backing image of
> > +#     'overlay'.  Additionally, if 'node' is associated with a block
> > +#     device, the block device changes to using 'overlay' as its new
> > +#     active image.
>
> The second paragraph refers to arguments.
>
> For types, such text tends to be something we want to inline, and for
> that, it needs to stay out of intro, and eventually move below the fold.
>
> Not a concern for commands and events.  But we might want to do the same
> just for consistency.

I agree; it's not always going to be clear at a glance which intros
will make it into the final documentation, and which won't. I think
people will learn over time, but consistency is a good thing as the
copy-paste-templaters will have good examples to follow.

>
> The hunk is acceptable as is.  I'm tracking
>
> 2. Review and improve doc comments where the intro refers to arguments /
> members / features.
>
> Splitting now would also be acceptable, as long as the split is trivial
> enough to not slow us down.  You did that for block_resize above.

Well, we'll have to sort it out sooner or later, so...

Anyway.

Are forward references really that bad? We obviously don't want to go
overboard, but sometimes - especially for commands with lots of
branches and features - highlighting the core functionality of the
command with reference to specific members is not really a bad thing.
It can help suggest what the "important" arguments are for the block
to follow.

In this case I actually do think it makes sense to appear above the
fold, almost like a cover letter, to help guide reading of the details
that follow.

It makes sense to look at any intros that refer to arguments and
wonder in which section it is more appropriate, but in this case I do
think it is entirely appropriate.

>
> >  #
> >  # Features:
> >  #
> > @@ -1883,9 +1881,8 @@
> >
> >  ##
> >  # @block-commit:
> > -#
> > -# Live commit of data from overlay image nodes into backing nodes -
> > -# i.e., writes data between 'top' and 'base' into 'base'.
> > +#     Live commit of data from overlay image nodes into backing nodes
> > +#     - i.e., writes data between 'top' and 'base' into 'base'.
>
> Likewise, except a split doesn't look trivial.

Candidate for a rewrite. Not for this series.

>
> >  #
> >  # If top =3D=3D base, that is an error.  If top has no overlays on top=
 of
> >  # it, or if it is in use by a writer, the job will not be completed by
> > @@ -2510,16 +2507,15 @@
> >
> >  ##
> >  # @block-dirty-bitmap-merge:
> > +#     Merge dirty bitmaps listed in @bitmaps to the @target dirty
> > +#     bitmap.  Dirty bitmaps in @bitmaps will be unchanged, except if
> > +#     it also appears as the @target bitmap.  Any bits already set in
> > +#     @target will still be set after the merge, i.e., this operation
> > +#     does not clear the target.  On error, @target is unchanged.
> >  #
> > -# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
> > -# Dirty bitmaps in @bitmaps will be unchanged, except if it also
> > -# appears as the @target bitmap.  Any bits already set in @target will
> > -# still be set after the merge, i.e., this operation does not clear
> > -# the target.  On error, @target is unchanged.
> > -#
> > -# The resulting bitmap will count as dirty any clusters that were
> > -# dirty in any of the source bitmaps.  This can be used to achieve
> > -# backup checkpoints, or in simpler usages, to copy bitmaps.
> > +#     The resulting bitmap will count as dirty any clusters that were
> > +#     dirty in any of the source bitmaps.  This can be used to achieve
> > +#     backup checkpoints, or in simpler usages, to copy bitmaps.
>
> Again.

Definitely another rewrite candidate. I wonder who wrote this one?

(Ah,)

Anyway, I do volunteer to do a series reviewing bitmaps, because I'd
like to tie the standalone bitmaps doc and the QAPI documentation
together more holistically with the new cross-reference features.

I think for now we leave this one alone for now and revisit post-inliner.

>
> >  #
> >  # Errors:
> >  #     - If @node is not a valid block device, DeviceNotFound
> > @@ -2865,8 +2861,7 @@
> >
> >  ##
> >  # @block-stream:
> > -#
> > -# Copy data from a backing file into a block device.
> > +#     Copy data from a backing file into a block device.
> >  #
> >  # The block streaming operation is performed in the background until
> >  # the entire backing file has been copied.  This command returns
>
> Another trivial split.  Not noting these again.

Is that good or bad for the purposes of this review?

I figured the intro here is a succinct summary, but the second
paragraph gives additional insight into the implementation, so it
seemed appropriate.

The first time you said "trivial split" in this series, it seemed to
me to intuit a place where you'd like a split, but in this case it's
where I already made one. Not sure what the action item is.

>
> > @@ -2977,8 +2972,7 @@
> >
> >  ##
> >  # @block-job-set-speed:
> > -#
> > -# Set maximum speed for a background block operation.
> > +#     Set maximum speed for a background block operation.
> >  #
> >  # This command can only be issued when there is an active block job.
> >  #
> > @@ -3003,8 +2997,7 @@
> >
> >  ##
> >  # @block-job-cancel:
> > -#
> > -# Stop an active background block operation.
> > +#     Stop an active background block operation.
> >  #
> >  # This command returns immediately after marking the active background
> >  # block operation for cancellation.  It is an error to call this
> > @@ -3046,8 +3039,7 @@
> >
> >  ##
> >  # @block-job-pause:
> > -#
> > -# Pause an active background block operation.
> > +#     Pause an active background block operation.
> >  #
> >  # This command returns immediately after marking the active job for
> >  # pausing.  Pausing an already paused job is an error.
> > @@ -3079,8 +3071,7 @@
> >
> >  ##
> >  # @block-job-resume:
> > -#
> > -# Resume an active background block operation.
> > +#     Resume an active background block operation.
> >  #
> >  # This command returns immediately after resuming a paused job.
> >  # Resuming an already running job is an error.
> > @@ -3108,9 +3099,9 @@
> >
> >  ##
> >  # @block-job-complete:
> > -#
> > -# Manually trigger completion of an active job in the READY or STANDBY
> > -# state.  Completing the job in any other state is an error.
> > +#     Manually trigger completion of an active job in the READY or
> > +#     STANDBY state.  Completing the job in any other state is an
> > +#     error.
> >  #
> >  # This is supported only for drive mirroring, where it also switches
> >  # the device to write to the target path only.  Note that drive
> > @@ -3148,14 +3139,13 @@
> >
> >  ##
> >  # @block-job-dismiss:
> > -#
> > -# Deletes a job that is in the CONCLUDED state.  This command only
> > -# needs to be run explicitly for jobs that don't have automatic
> > -# dismiss enabled.  In turn, automatic dismiss may be enabled only for
> > -# jobs that have @auto-dismiss option, which are `drive-backup`,
> > -# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit`
> > -# and `block-stream`.  @auto-dismiss is enabled by default for these
> > -# jobs.
> > +#     Deletes a job that is in the CONCLUDED state.  This command only
> > +#     needs to be run explicitly for jobs that don't have automatic
> > +#     dismiss enabled.  In turn, automatic dismiss may be enabled only
> > +#     for jobs that have @auto-dismiss option, which are
> > +#     `drive-backup`, `blockdev-backup`, `drive-mirror`,
> > +#     `blockdev-mirror`, `block-commit` and `block-stream`.
> > +#     @auto-dismiss is enabled by default for these jobs.
>
> Forward reference to an argument again.

Candidate for a prose rewrite to more easily distinguish introduction
from details. Something for later? Since I also had a hand in the job
impl, I feel equipped to handle these along with bitmaps.

>
> >  #
> >  # This command will refuse to operate on any job that has not yet
> >  # reached its terminal state, CONCLUDED.  For jobs that make use of
> > @@ -3177,11 +3167,10 @@
> >
> >  ##
> >  # @block-job-finalize:
> > -#
> > -# Instructs all jobs in a transaction (or a single job if it is not
> > -# part of any transaction) to finalize any graph changes and do any
> > -# necessary cleanup.  This command requires that all involved jobs are
> > -# in the PENDING state.
> > +#     Instructs all jobs in a transaction (or a single job if it is
> > +#     not part of any transaction) to finalize any graph changes and
> > +#     do any necessary cleanup.  This command requires that all
> > +#     involved jobs are in the PENDING state.
> >  #
> >  # For jobs in a transaction, instructing one job to finalize will
> >  # force ALL jobs in the transaction to finalize, so it is only
> > @@ -4917,14 +4906,13 @@
> >
> >  ##
> >  # @blockdev-reopen:
> > -#
> > -# Reopens one or more block devices using the given set of options.
> > -# Any option not specified will be reset to its default value
> > -# regardless of its previous status.  If an option cannot be changed
> > -# or a particular driver does not support reopening then the command
> > -# will return an error.  All devices in the list are reopened in one
> > -# transaction, so if one of them fails then the whole transaction is
> > -# cancelled.
> > +#     Reopens one or more block devices using the given set of
> > +#     options.  Any option not specified will be reset to its default
> > +#     value regardless of its previous status.  If an option cannot be
> > +#     changed or a particular driver does not support reopening then
> > +#     the command will return an error.  All devices in the list are
> > +#     reopened in one transaction, so if one of them fails then the
> > +#     whole transaction is cancelled.
> >  #
> >  # The command receives a list of block devices to reopen.  For each
> >  # one of them, the top-level @node-name option (from
>
> This one affects rendered documentation.  Suggest to mention it in the
> commit message, like the previous patch does.

Sure. I didn't really mention them up to this point because we had
been avoiding any changes, but implicitly this series is about
allowing and making such changes. I didn't actually audit specifically
WHICH ones cause rendering changes, I just knew that it would happen
for some.

Do you want an explicit accounting of which ones do, or is it enough
to say "This might change rendering in cases where a new split is
introduced" ...?

>
> > @@ -4996,9 +4984,8 @@
> >
> >  ##
> >  # @blockdev-set-active:
> > -#
> > -# Activate or deactivate a block device.  Use this to manage the
> > -# handover of block devices on migration with qemu-storage-daemon.
> > +#     Activate or deactivate a block device.  Use this to manage the
> > +#     handover of block devices on migration with qemu-storage-daemon.
> >  #
> >  # Activating a node automatically activates all of its child nodes
> >  # first.  Deactivating a node automatically deactivates any of its
> > @@ -5881,15 +5868,14 @@
> >
> >  ##
> >  # @block-set-write-threshold:
> > +#     Change the write threshold for a block drive.  An event will be
> > +#     delivered if a write to this block drive crosses the configured
> > +#     threshold.  The threshold is an offset, thus must be
> > +#     non-negative.  Default is no write threshold.  Setting the
> > +#     threshold to zero disables it.
> >  #
> > -# Change the write threshold for a block drive.  An event will be
> > -# delivered if a write to this block drive crosses the configured
> > -# threshold.  The threshold is an offset, thus must be non-negative.
> > -# Default is no write threshold.  Setting the threshold to zero
> > -# disables it.
> > -#
> > -# This is useful to transparently resize thin-provisioned drives
> > -# without the guest OS noticing.
> > +#     This is useful to transparently resize thin-provisioned drives
> > +#     without the guest OS noticing.
> >  #
> >  # @node-name: graph node name on which the threshold must be set.
> >  #
> > @@ -5911,8 +5897,7 @@
> >
> >  ##
> >  # @x-blockdev-change:
> > -#
> > -# Dynamically reconfigure the block driver state graph.
> > +#     Dynamically reconfigure the block driver state graph.
> >  #
> >  # Currently only supports adding and deleting quorum children.  A
> >  # child will be added at the end of the list of children.  Its
> > @@ -5971,11 +5956,10 @@
> >
> >  ##
> >  # @x-blockdev-set-iothread:
> > +#     Move @node and its children into the @iothread.  If @iothread is
> > +#     null then move @node and its children into the main loop.
> >  #
> > -# Move @node and its children into the @iothread.  If @iothread is
> > -# null then move @node and its children into the main loop.
>
> Forward reference to an argument again.

Would need a rewrite to avoid discussing implementation in the
summary, so IMO it's a task for later. My goal right now is generally
just to accomplish the split in some semi-reasonable way without an
obvious degradation in quality of what is available to the end user
without getting bogged down in the mires of prose rewrites.

Fixing these sorts of things right now is probably well beyond the
scope I can afford, currently.

>
> > -#
> > -# The node must not be attached to a BlockBackend.
> > +#     The node must not be attached to a BlockBackend.
> >  #
> >  # @node-name: the name of the block driver node
> >  #
>
> In the interest of getting the job done: consider my commit message
> suggestion, and leave the remainder for another day.

I think I agree, so long as the splits I chose here are "acceptable
enough" to not inhibit the inliner work, i.e. the docs are not really
tangibly worse for having done it and the prose rewrites can be
"if/when" improvements.


