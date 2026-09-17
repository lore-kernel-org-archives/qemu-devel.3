Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7DC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7IQn-0003aK-C2; Thu, 17 Sep 2026 16:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7IQl-0003Zn-Li
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:10:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7IQi-0000Xg-F2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 16:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789675798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+Z17r5/Sh4xUkATgTc/vHZNFPDxOPCm3Y63dbPISOE=;
 b=gkpzerr+XdFW37xs8yNHs1zACPiXZugGwqf33IH/YJv020yfxAJEGGvXYEeTlHApGAd6il
 4U63DW/fWpybok9k4V2PcF4oZctDqLe+E9sL2ahW2aBWMhpgryGf5qLlv30pz3+XdKAwBS
 Mj+7aw9v3Zovjt0E1VuYLtMuZWZsnFU=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-S8j39dNpNqWXOI0CAhZEoA-1; Thu, 17 Sep 2026 16:09:57 -0400
X-MC-Unique: S8j39dNpNqWXOI0CAhZEoA-1
X-Mimecast-MFC-AGG-ID: S8j39dNpNqWXOI0CAhZEoA_1789675797
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66cdb701595so93982d50.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 13:09:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789675797; cv=none;
 d=google.com; s=arc-20260327;
 b=NTi6zKMEbAgwC5bjmyvGjF7gDppZmyPWtEtMNpGlpeopxhBY5fLhL70jfnmTf/6GLK
 AuAX03Z1oi8IPqWDPn73O/4NzK5boug3b3EGzOBMK/c9O8a0Xd2KFpcCw/GYEgou+x9h
 +jbXI29payhN2l2IZIw5zjxwq9pL1MaErK8+hEAlG99dL9aw3wuuiCj4jWiJqjNKbJFs
 O4ScCsTP9L/rl537y8cXju+a93OBYPfehUtr6TLbdvNCqsD6ISwkVYhrz3p5Kbc1ZGzb
 G+a8/1OeDW++54qrm4f5B0mpDT8y1bX1bOYuCjzB8+EbkwTzES0gZdw44nXjhO3ApHlq
 +Clw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4+Z17r5/Sh4xUkATgTc/vHZNFPDxOPCm3Y63dbPISOE=;
 fh=6/3MBLY771l9Tjbp9sIrjfuM3gYSL1dAxCLrcHqISag=;
 b=bnvAgU/VigbiWXh0RTtJa3wv4M+O2BHIEBaOy1BGEc0uEiWM4Xnhz6KuwTbcY0dWOp
 rN1EOb/T5FpNZDVDNHiiQdiqV7ijJTKAdzsVJ9LpyS05vFVW7v17FMWSNAQtnilrFWtw
 P4o2kA0nTonYzXmUH7qhDbR2IVSBFnZffjVwskILoWqfKSvRdcPwDjrXBDj21UOtGek3
 tOOw8/444juUpzUiv5A3ruE3lPXtyMjCxgW/lJEqapC/05SGURcTMRuK+6m+OfQNh5nc
 +qedu8s6Ri9QwwRUbmu2YxnGIT22cZ1Jkw3hIspq0UGDm9hPObZDlwUG4F36r8DwEskj
 aiow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789675797; x=1790280597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4+Z17r5/Sh4xUkATgTc/vHZNFPDxOPCm3Y63dbPISOE=;
 b=YzhH9sbAKzDkF2kb1A/qR42BvzoDh4sjdzIxopBe6GIpSC7BYVxfSaWxLtF7E/dWdQ
 dwDUF0urZ7z3UgY0zXuv0xjcNeV2pdyu0SvIg5sg1qSsKrNJfUvD2nOaoRs5raNIVM7V
 HeikksuXAhYezgFFvB+j47tIEqo5/WLyqKm8w7ZIUCiXHL8/GNkbrtl9eX0aRLOaE/Cx
 S/QMYwQex+n6vgROv9mdUPTN+evFCVrw3wIGT74WZJHHvJDCZS+QEpZVy7QCEuOYyodG
 X2XT7mVNQKuFfo3TUoDo+DzN9g49CaOoihbW7U1D9dKJMBFw9WzwTkd3XzBapjgmh8eD
 6X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675797; x=1790280597;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4+Z17r5/Sh4xUkATgTc/vHZNFPDxOPCm3Y63dbPISOE=;
 b=Iw646pwMqLSgmsAA8FHh6EXZkSXaxfiUBjt0h2t3IIkfQ+97OYPyv1AR9vYZ74UhwJ
 HEXDuJ6OntP0Tq+earbzFaDa9gPJL+1udGIUFnfkeynv30iCFWK2f2p8NgDROU3YetEt
 LDzH0few17rKz4EtuiR71tfuCSuD3Fba0WmK+6MxZ0UiJi0bHwvl8HGXCVZ3EMsUsNZ/
 dN24PWyGUwV5GENEfgPg3k3rtSzgELVDu2ps3qSQNUj6SpueycpVJpIMMRTsgw+RcR0s
 YCQg1a39O5l+c/n5H4NpV8avwUuKYJc9jlelaB8Ldknefl1KaDp7AfbaUZAQeEjJ6UxF
 lGFA==
X-Gm-Message-State: AFuF++nV91SqWmhuBGvS4+KWRRGa9XKbC2kzVUKTNbTTP3EixQw8gdmf
 KwnDua02B95GpBiIi4w0XaMAOdZDjtoK73g2WFJyxMzgGKoQNX0XF4Zb/4hHSr+MqPzJvqmCiik
 3/akiCCsFJHuWw0MaqvHw7weI1MTnUQ9FPmB+wURvECdPRu1LGrLOUXHW3E4Vjp2/Gilha6DkO2
 X2fqhNmjvickfYjRtYpUahbvlsE69eDh0=
X-Gm-Gg: AYBFou33lR74j+OoaiBSu/Et2uPkSktjTcfrkPnLsWiRcE5GDJKL7QioKYo4p5158ZR
 fKCIBd3gkcVi34dfkM+rGMvv6kf5l+H8sEFOEtd44tvc0OAFYHr1cZHrfziVAeaH2NmFaM7e3N3
 M1iszf8GfOh5oulxkJp/SqzQiokhoIuqFudRl0yEW8qiZvLtZUdS4X5vqNkw6YfIZscr/Ii50Dt
 x5x+fQ13f4xt3oz
X-Received: by 2002:a05:690e:43c1:b0:671:4b17:bfee with SMTP id
 956f58d0204a3-6717fc67689mr76762d50.1.1789675796451; 
 Thu, 17 Sep 2026 13:09:56 -0700 (PDT)
X-Received: by 2002:a05:690e:43c1:b0:671:4b17:bfee with SMTP id
 956f58d0204a3-6717fc67689mr76753d50.1.1789675795839; Thu, 17 Sep 2026
 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-3-jsnow@redhat.com>
 <874ifpcz85.fsf@pond.sub.org>
In-Reply-To: <874ifpcz85.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 17 Sep 2026 16:09:44 -0400
X-Gm-Features: AcwNN1Vppm3jyz3jn3aB3GQpQ1ctLpxVqSYj1vOAGRpx8IYAmZ9qHsyhG_1Q6WI
Message-ID: <CAFn=p-aEjPnXH_xvJJWcPYoZmqXP1PCyKAReV7rXfJD0hQskLA@mail.gmail.com>
Subject: Re: [PATCH 2/9] qapi: convert multi-paragraph intros (commands)
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 16, 2026 at 5:38=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > This patch converts some slightly-non-trivial intros with more than
> > one paragraph, but doesn't create any new intro/details splits.
> >
> > Review notes: Some of these possibly could be split, but as they are co=
mmands
> > (not eligible as an inlining source) and the additional information in
> > the intro is not terribly long, I opted to leave them alone instead of
> > laboring on prose rewrites.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json | 49 +++++++++++++++++++++-----------------------
> >  qapi/block.json      | 29 +++++++++++++-------------
> >  qapi/migration.json  |  9 ++++----
> >  qapi/misc-arm.json   |  9 ++++----
> >  qapi/misc.json       | 13 ++++++------
> >  qapi/qdev.json       | 14 ++++++-------
> >  6 files changed, 58 insertions(+), 65 deletions(-)
> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 1ca147285e7..c505369aeb2 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1772,13 +1772,12 @@
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
> 'overlay' and 'node' refer to arguments, so they should be @overlay and
> @node.  Since the arguments are in type BlockdevSnapshot, the reference
> is non-local until the inliner lands.

It isn't a reference at all as far as Sphinx is concerned, merely a
markup convention. Whether or not that convention applies to non-local
things is kind of up to you. If you say the word, I'll edit these in
this series and forward if you wish, but my default will be to leave
it alone.

>
> We may want to render this paragraph below the argument descriptions to
> avoid forward references.  This requires splitting it off the intro.  We
> can do it now, or leave it for later.
>
> Not splitting now keeps the conversion simple, which is a plus.  It
> reindents the entire unsplit intro, and if we do split it later, the
> part split off gets reindented right back.
>
> I'm leaning towards not rocking the boat, but you decide.

I'm likely to forget or ignore about later splits, so if it's
something you want, we may as well do it now. Note that we can just
decide to only indent the first paragraph and leave the second
unindented, and then it gets shifted into place during a later code
movement patch.

>
> Not noting these things again.
>
> >  #
> >  # Features:
> >  #
> > @@ -2471,15 +2470,15 @@
> >  ##
> >  # @block-dirty-bitmap-merge:
> >  #
>
> Drop the blank line.

ACK. Accidental remnants of adding a blank line intentionally to get
reflow to behave how I want.

>
> > -# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
> > -# Dirty bitmaps in @bitmaps will be unchanged, except if it also
> > -# appears as the @target bitmap.  Any bits already set in @target will
> > -# still be set after the merge, i.e., this operation does not clear
> > -# the target.  On error, @target is unchanged.
> > +#     Merge dirty bitmaps listed in @bitmaps to the @target dirty
> > +#     bitmap.  Dirty bitmaps in @bitmaps will be unchanged, except if
> > +#     it also appears as the @target bitmap.  Any bits already set in
> > +#     @target will still be set after the merge, i.e., this operation
> > +#     does not clear the target.  On error, @target is unchanged.
> >  #
> > -# The resulting bitmap will count as dirty any clusters that were
> > -# dirty in any of the source bitmaps.  This can be used to achieve
> > -# backup checkpoints, or in simpler usages, to copy bitmaps.
> > +#     The resulting bitmap will count as dirty any clusters that were
> > +#     dirty in any of the source bitmaps.  This can be used to achieve
> > +#     backup checkpoints, or in simpler usages, to copy bitmaps.
> >  #
> >  # Errors:
> >  #     - If @node is not a valid block device, DeviceNotFound
> > @@ -5848,15 +5847,14 @@
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
> > @@ -5938,11 +5936,10 @@
> >
> >  ##
> >  # @x-blockdev-set-iothread:
> > +#     Move @node and its children into the @iothread.  If @iothread is
> > +#     null then move @node and its children into the main loop.
> >  #
> > -# Move @node and its children into the @iothread.  If @iothread is
> > -# null then move @node and its children into the main loop.
> > -#
> > -# The node must not be attached to a BlockBackend.
> > +#     The node must not be attached to a BlockBackend.
>
> This one arguably lacks an intro.  Let's not worry about this now.

How about I indent *nothing* and lead with a "#TODO: This command
needs an introduction" ?

>
> >  #
> >  # @node-name: the name of the block driver node
> >  #
> > diff --git a/qapi/block.json b/qapi/block.json
> > index e47592d5500..15f08372564 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
> > @@ -181,12 +181,13 @@
> >
> >  ##
> >  # @blockdev-close-tray:
> > +#     Closes a block device's tray.
> >  #
> > -# Closes a block device's tray.  If there is a block driver state tree
> > -# associated with the block device (which is currently ejected), that
> > -# tree will be loaded as the medium.
> > +#     If there is a block driver state tree associated with the block
> > +#     device (which is currently ejected), that tree will be loaded as
> > +#     the medium.
> >  #
> > -# If the tray was already closed before, this will be a no-op.
> > +#     If the tray was already closed before, this will be a no-op.
> >  #
> >  # @device: Block device name
> >  #
>
> Shouldn't this one be in "[PATCH 5/9] qapi: split intro sections for
> commands"?

Ah, I did something halfway between ... Well, this particular block
doesn't actually add a new "split", but I did reflow the paragraphs
*as if* I had performed the split.

Let's collapse this one way or the other: please state your
preference, and I'll sift it into the correct patch.

>
> > @@ -218,13 +219,12 @@
> >
> >  ##
> >  # @blockdev-remove-medium:
> > +#     Removes a medium (a block driver state tree) from a block
> > +#     device.  That block device's tray must currently be open
> > +#     (unless there is no attached guest device).
> >  #
> > -# Removes a medium (a block driver state tree) from a block device.
> > -# That block device's tray must currently be open (unless there is no
> > -# attached guest device).
> > -#
> > -# If the tray is open and there is no medium inserted, this will be a
> > -# no-op.
> > +#     If the tray is open and there is no medium inserted, this will
> > +#     be a no-op.
> >  #
> >  # @id: The name or QOM path of the guest device
> >  #
> > @@ -504,12 +504,11 @@
> >
> >  ##
> >  # @block-latency-histogram-set:
> > +#     Manage read, write and flush latency histograms for the device.
> >  #
> > -# Manage read, write and flush latency histograms for the device.
> > -#
> > -# If only @id parameter is specified, remove all present latency
> > -# histograms for the device.  Otherwise, add/reset some of (or all)
> > -# latency histograms.
> > +#     If only @id parameter is specified, remove all present latency
> > +#     histograms for the device.  Otherwise, add/reset some of (or
> > +#     all) latency histograms.
> >  #
> >  # @id: The name or QOM path of the guest device.
> >  #
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 8096ef64682..13c446b922f 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1965,12 +1965,11 @@
> >
> >  ##
> >  # @cancel-vcpu-dirty-limit:
> > +#     Cancel the upper limit of dirty page rate for virtual CPUs.
> >  #
> > -# Cancel the upper limit of dirty page rate for virtual CPUs.
> > -#
> > -# Cancel the dirty page limit for the vCPU which has been set with
> > -# `set-vcpu-dirty-limit` command.  Note that this command requires
> > -# support from dirty ring, same as the `set-vcpu-dirty-limit`.
> > +#     Cancel the dirty page limit for the vCPU which has been set with
> > +#     `set-vcpu-dirty-limit` command.  Note that this command requires
> > +#     support from dirty ring, same as the `set-vcpu-dirty-limit`.
> >  #
> >  # @cpu-index: index of a virtual CPU, default is all.
> >  #
> > diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> > index 8cb2ea77951..64059b5688d 100644
> > --- a/qapi/misc-arm.json
> > +++ b/qapi/misc-arm.json
> > @@ -28,12 +28,11 @@
> >
> >  ##
> >  # @query-gic-capabilities:
> > +#     It will return a list of `GICCapability` objects that describe
> > +#     its capability bits.
> >  #
> > -# It will return a list of `GICCapability` objects that describe its
> > -# capability bits.
> > -#
> > -# On non-ARM targets this command will report an error as the GIC
> > -# technology is not applicable.
> > +#     On non-ARM targets this command will report an error as the GIC
> > +#     technology is not applicable.
> >  #
> >  # Since: 2.6
> >  #
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index b3c2a1421f3..374711ac6c7 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -178,14 +178,13 @@
> >
> >  ##
> >  # @x-exit-preconfig:
> > +#     Exit from "preconfig" state
> >  #
> > -# Exit from "preconfig" state
> > -#
> > -# This command makes QEMU exit the preconfig state and proceed with VM
> > -# initialization using configuration data provided on the command line
> > -# and via the QMP monitor during the preconfig state.  The command is
> > -# only available during the preconfig state (i.e. when the --preconfig
> > -# command line option was in use).
> > +#     This command makes QEMU exit the preconfig state and proceed
> > +#     with VM initialization using configuration data provided on the
> > +#     command line and via the QMP monitor during the preconfig state.
> > +#     The command is only available during the preconfig state
> > +#     (i.e. when the --preconfig command line option was in use).
> >  #
> >  # Features:
> >  #
> > diff --git a/qapi/qdev.json b/qapi/qdev.json
> > index a35321d2fd1..e19a92a44e8 100644
> > --- a/qapi/qdev.json
> > +++ b/qapi/qdev.json
> > @@ -163,14 +163,14 @@
> >  ##
> >  # @device-sync-config:
> >  #
>
> Drop the blank line.

ACK

>
> > -# Synchronize device configuration from host to guest part.  First,
> > -# copy the configuration from the host part (backend) to the guest
> > -# part (frontend).  Then notify guest software that device
> > -# configuration changed.
> > +#     Synchronize device configuration from host to guest part.
> > +#     First, copy the configuration from the host part (backend) to
> > +#     the guest part (frontend).  Then notify guest software that
> > +#     device configuration changed.
> >  #
> > -# The command may be used to notify the guest about block device
> > -# capacity change.  Currently only vhost-user-blk device supports
> > -# this.
> > +#     The command may be used to notify the guest about block device
> > +#     capacity change.  Currently only vhost-user-blk device supports
> > +#     this.
> >  #
> >  # @id: the device's ID or QOM path
> >  #
>


