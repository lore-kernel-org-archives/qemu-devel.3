Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3813CC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6m6e-0003Tu-1O; Wed, 16 Sep 2026 05:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6m6d-0003Tb-4C
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6m6a-0002Xi-Tu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 05:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789551540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AFIdLN2mfUDmSvJW1giQxzJpemmLGbl/4FggnVW//UM=;
 b=GTV7rzYXubhlb8H6I8RiM9Tb+8zVxV5Aulaz4AECR26SMuh4YHpuVDwIIznYg9mTr921Ij
 SmXBOTnmsxbAqvXGVQFX25/m1YVvrmIxqBBVQPnPKmFPehibBzLgHbJVIPDZsdJpKg96pB
 ToR1phSyyjWyf4CaRqB9S/5ksuLZyM4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-7wSlneYgNCuEYmuerOjN4g-1; Wed,
 16 Sep 2026 05:38:56 -0400
X-MC-Unique: 7wSlneYgNCuEYmuerOjN4g-1
X-Mimecast-MFC-AGG-ID: 7wSlneYgNCuEYmuerOjN4g_1789551535
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7EAF1809CAD; Wed, 16 Sep 2026 09:38:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47FA11800446; Wed, 16 Sep 2026 09:38:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DD77521E6A04; Wed, 16 Sep 2026 11:38:50 +0200 (CEST)
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
In-Reply-To: <20260911203002.305316-3-jsnow@redhat.com> (John Snow's message
 of "Fri, 11 Sep 2026 16:29:55 -0400")
References: <20260911203002.305316-1-jsnow@redhat.com>
 <20260911203002.305316-3-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 11:38:50 +0200
Message-ID: <874ifpcz85.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> This patch converts some slightly-non-trivial intros with more than
> one paragraph, but doesn't create any new intro/details splits.
>
> Review notes: Some of these possibly could be split, but as they are commands
> (not eligible as an inlining source) and the additional information in
> the intro is not terribly long, I opted to leave them alone instead of
> laboring on prose rewrites.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 49 +++++++++++++++++++++-----------------------
>  qapi/block.json      | 29 +++++++++++++-------------
>  qapi/migration.json  |  9 ++++----
>  qapi/misc-arm.json   |  9 ++++----
>  qapi/misc.json       | 13 ++++++------
>  qapi/qdev.json       | 14 ++++++-------
>  6 files changed, 58 insertions(+), 65 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1ca147285e7..c505369aeb2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1772,13 +1772,12 @@
>  
>  ##
>  # @blockdev-snapshot:
> +#     Takes a snapshot of a block device.
>  #
> -# Takes a snapshot of a block device.
> -#
> -# Take a snapshot, by installing 'node' as the backing image of
> -# 'overlay'.  Additionally, if 'node' is associated with a block
> -# device, the block device changes to using 'overlay' as its new
> -# active image.
> +#     Take a snapshot, by installing 'node' as the backing image of
> +#     'overlay'.  Additionally, if 'node' is associated with a block
> +#     device, the block device changes to using 'overlay' as its new
> +#     active image.

'overlay' and 'node' refer to arguments, so they should be @overlay and
@node.  Since the arguments are in type BlockdevSnapshot, the reference
is non-local until the inliner lands.

We may want to render this paragraph below the argument descriptions to
avoid forward references.  This requires splitting it off the intro.  We
can do it now, or leave it for later.

Not splitting now keeps the conversion simple, which is a plus.  It
reindents the entire unsplit intro, and if we do split it later, the
part split off gets reindented right back.

I'm leaning towards not rocking the boat, but you decide.

Not noting these things again.

>  #
>  # Features:
>  #
> @@ -2471,15 +2470,15 @@
>  ##
>  # @block-dirty-bitmap-merge:
>  #

Drop the blank line.

> -# Merge dirty bitmaps listed in @bitmaps to the @target dirty bitmap.
> -# Dirty bitmaps in @bitmaps will be unchanged, except if it also
> -# appears as the @target bitmap.  Any bits already set in @target will
> -# still be set after the merge, i.e., this operation does not clear
> -# the target.  On error, @target is unchanged.
> +#     Merge dirty bitmaps listed in @bitmaps to the @target dirty
> +#     bitmap.  Dirty bitmaps in @bitmaps will be unchanged, except if
> +#     it also appears as the @target bitmap.  Any bits already set in
> +#     @target will still be set after the merge, i.e., this operation
> +#     does not clear the target.  On error, @target is unchanged.
>  #
> -# The resulting bitmap will count as dirty any clusters that were
> -# dirty in any of the source bitmaps.  This can be used to achieve
> -# backup checkpoints, or in simpler usages, to copy bitmaps.
> +#     The resulting bitmap will count as dirty any clusters that were
> +#     dirty in any of the source bitmaps.  This can be used to achieve
> +#     backup checkpoints, or in simpler usages, to copy bitmaps.
>  #
>  # Errors:
>  #     - If @node is not a valid block device, DeviceNotFound
> @@ -5848,15 +5847,14 @@
>  
>  ##
>  # @block-set-write-threshold:
> +#     Change the write threshold for a block drive.  An event will be
> +#     delivered if a write to this block drive crosses the configured
> +#     threshold.  The threshold is an offset, thus must be
> +#     non-negative.  Default is no write threshold.  Setting the
> +#     threshold to zero disables it.
>  #
> -# Change the write threshold for a block drive.  An event will be
> -# delivered if a write to this block drive crosses the configured
> -# threshold.  The threshold is an offset, thus must be non-negative.
> -# Default is no write threshold.  Setting the threshold to zero
> -# disables it.
> -#
> -# This is useful to transparently resize thin-provisioned drives
> -# without the guest OS noticing.
> +#     This is useful to transparently resize thin-provisioned drives
> +#     without the guest OS noticing.
>  #
>  # @node-name: graph node name on which the threshold must be set.
>  #
> @@ -5938,11 +5936,10 @@
>  
>  ##
>  # @x-blockdev-set-iothread:
> +#     Move @node and its children into the @iothread.  If @iothread is
> +#     null then move @node and its children into the main loop.
>  #
> -# Move @node and its children into the @iothread.  If @iothread is
> -# null then move @node and its children into the main loop.
> -#
> -# The node must not be attached to a BlockBackend.
> +#     The node must not be attached to a BlockBackend.

This one arguably lacks an intro.  Let's not worry about this now.

>  #
>  # @node-name: the name of the block driver node
>  #
> diff --git a/qapi/block.json b/qapi/block.json
> index e47592d5500..15f08372564 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -181,12 +181,13 @@
>  
>  ##
>  # @blockdev-close-tray:
> +#     Closes a block device's tray.
>  #
> -# Closes a block device's tray.  If there is a block driver state tree
> -# associated with the block device (which is currently ejected), that
> -# tree will be loaded as the medium.
> +#     If there is a block driver state tree associated with the block
> +#     device (which is currently ejected), that tree will be loaded as
> +#     the medium.
>  #
> -# If the tray was already closed before, this will be a no-op.
> +#     If the tray was already closed before, this will be a no-op.
>  #
>  # @device: Block device name
>  #

Shouldn't this one be in "[PATCH 5/9] qapi: split intro sections for
commands"?

> @@ -218,13 +219,12 @@
>  
>  ##
>  # @blockdev-remove-medium:
> +#     Removes a medium (a block driver state tree) from a block
> +#     device.  That block device's tray must currently be open
> +#     (unless there is no attached guest device).
>  #
> -# Removes a medium (a block driver state tree) from a block device.
> -# That block device's tray must currently be open (unless there is no
> -# attached guest device).
> -#
> -# If the tray is open and there is no medium inserted, this will be a
> -# no-op.
> +#     If the tray is open and there is no medium inserted, this will
> +#     be a no-op.
>  #
>  # @id: The name or QOM path of the guest device
>  #
> @@ -504,12 +504,11 @@
>  
>  ##
>  # @block-latency-histogram-set:
> +#     Manage read, write and flush latency histograms for the device.
>  #
> -# Manage read, write and flush latency histograms for the device.
> -#
> -# If only @id parameter is specified, remove all present latency
> -# histograms for the device.  Otherwise, add/reset some of (or all)
> -# latency histograms.
> +#     If only @id parameter is specified, remove all present latency
> +#     histograms for the device.  Otherwise, add/reset some of (or
> +#     all) latency histograms.
>  #
>  # @id: The name or QOM path of the guest device.
>  #
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8096ef64682..13c446b922f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1965,12 +1965,11 @@
>  
>  ##
>  # @cancel-vcpu-dirty-limit:
> +#     Cancel the upper limit of dirty page rate for virtual CPUs.
>  #
> -# Cancel the upper limit of dirty page rate for virtual CPUs.
> -#
> -# Cancel the dirty page limit for the vCPU which has been set with
> -# `set-vcpu-dirty-limit` command.  Note that this command requires
> -# support from dirty ring, same as the `set-vcpu-dirty-limit`.
> +#     Cancel the dirty page limit for the vCPU which has been set with
> +#     `set-vcpu-dirty-limit` command.  Note that this command requires
> +#     support from dirty ring, same as the `set-vcpu-dirty-limit`.
>  #
>  # @cpu-index: index of a virtual CPU, default is all.
>  #
> diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
> index 8cb2ea77951..64059b5688d 100644
> --- a/qapi/misc-arm.json
> +++ b/qapi/misc-arm.json
> @@ -28,12 +28,11 @@
>  
>  ##
>  # @query-gic-capabilities:
> +#     It will return a list of `GICCapability` objects that describe
> +#     its capability bits.
>  #
> -# It will return a list of `GICCapability` objects that describe its
> -# capability bits.
> -#
> -# On non-ARM targets this command will report an error as the GIC
> -# technology is not applicable.
> +#     On non-ARM targets this command will report an error as the GIC
> +#     technology is not applicable.
>  #
>  # Since: 2.6
>  #
> diff --git a/qapi/misc.json b/qapi/misc.json
> index b3c2a1421f3..374711ac6c7 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -178,14 +178,13 @@
>  
>  ##
>  # @x-exit-preconfig:
> +#     Exit from "preconfig" state
>  #
> -# Exit from "preconfig" state
> -#
> -# This command makes QEMU exit the preconfig state and proceed with VM
> -# initialization using configuration data provided on the command line
> -# and via the QMP monitor during the preconfig state.  The command is
> -# only available during the preconfig state (i.e. when the --preconfig
> -# command line option was in use).
> +#     This command makes QEMU exit the preconfig state and proceed
> +#     with VM initialization using configuration data provided on the
> +#     command line and via the QMP monitor during the preconfig state.
> +#     The command is only available during the preconfig state
> +#     (i.e. when the --preconfig command line option was in use).
>  #
>  # Features:
>  #
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index a35321d2fd1..e19a92a44e8 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -163,14 +163,14 @@
>  ##
>  # @device-sync-config:
>  #

Drop the blank line.

> -# Synchronize device configuration from host to guest part.  First,
> -# copy the configuration from the host part (backend) to the guest
> -# part (frontend).  Then notify guest software that device
> -# configuration changed.
> +#     Synchronize device configuration from host to guest part.
> +#     First, copy the configuration from the host part (backend) to
> +#     the guest part (frontend).  Then notify guest software that
> +#     device configuration changed.
>  #
> -# The command may be used to notify the guest about block device
> -# capacity change.  Currently only vhost-user-blk device supports
> -# this.
> +#     The command may be used to notify the guest about block device
> +#     capacity change.  Currently only vhost-user-blk device supports
> +#     this.
>  #
>  # @id: the device's ID or QOM path
>  #


