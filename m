Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F59606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IkRbz6Ii
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLo7o-0008Eq-8Y; Tue, 27 Oct 2026 16:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLo7l-0008E8-QA; Tue, 27 Oct 2026 16:50:25 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLo7j-0002ZB-Ni; Tue, 27 Oct 2026 16:50:25 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 417E7400E6;
 Tue, 27 Oct 2026 20:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2511F01825;
 Tue, 27 Oct 2026 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793134220;
 bh=4hTAwrGfWhum6sswELTzqWg2CWccCtuqBeE0O/3E2RQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=IkRbz6IiO6/WOF0VkDVR+kK9b6kYFDG3i8cZDqziVlPiHjLQ9W6TWIbbsYBtJzkKf
 usodxl9IqRnVw9xLZ7Z2Lju2qNOyPuiWrSTSv7B1wFP7wmkrhApOmTG4OjgCwo1pI3
 bO3rgMLVaa/0LONbdCuBhYEgCS0UMApPLez1nkMnsB9FAML0+LIwZBfdhQ0CzFLyHx
 VkRqcTiRhlHTpj7JBJz2kjQUCpX7zoZz+RD5TC6LVh8GYU27ZqkbYQm72y3+s4NrT5
 pdnvc1cbtUiwCQ8KyvBPUJzHMOXpGlnsu1m2YurdHSd5hyeBXleqG55rz27Jz86Fvp
 yUtwnRHI+U1MA==
Date: Tue, 27 Oct 2026 21:50:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sam Li <faithilikerun@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/15] block: fix the zone write granularity and the
 zone append limit
Message-ID: <auEOhyERyw6IeAIg@ryzen>
References: <20260921142819.2916043-1-cassel@kernel.org>
 <20261027204114.GI933537@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027204114.GI933537@shajnocz.csb>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 04:41:14PM -0400, Stefan Hajnoczi wrote:
> On Mon, Sep 21, 2026 at 04:28:02PM +0200, Niklas Cassel wrote:
> > Hello Stefan, Kevin, and everyone else,
> > 
> > This series fixes how QEMU reports and enforces the two constraints that a
> > zoned device places on a write to a sequential zone: the write granularity,
> > and the largest zone append that it accepts. It also fixes two bugs in the
> > zone append emulation in file-posix, one of which a guest can reach.
> > 
> > Most of it is preparation for Sam Li's zoned qcow2 series. The first two
> > patches are taken directly from there, as they are unrelated to qcow2.
> > 
> > Changes since v5:
> > -Picked up Stefan's Reviewed-by tags that he gave when reviewing v4.
> >  Patches that have changed significantly since v4 have had tags dropped
> >  (i.e. they will have neither Damien's nor Stefan's Reviewed-by tags).
> > 
> > Niklas Cassel (13):
> >   block: add a helper for the index of the zone an offset falls in
> >   block: add a helper to check if a zone is conventional
> >   hw/block: derive the zone write granularity from the block sizes
> >   virtio-blk: check the write granularity of writes to sequential zones
> >   hw/block: reject a zoned device that the block sizes cannot address
> >   block: reject zone appends that are not a multiple of the sector size
> >   block: reject a zone append that is larger than a zone
> >   file-posix: remove the zone append write granularity check
> >   virtio-blk: add a max-append-sectors property
> >   block: remove BlockLimits.max_append_sectors
> >   file-posix: reject a zone append past the device capacity
> >   file-posix: reject a zone append to a full or conventional zone
> >   block: do not use CoroutineIOCompletion to hold a return value
> > 
> > Sam Li (2):
> >   block: widen BlockLimits.zone_size to uint64_t
> >   virtio-blk: do not merge requests across a zone boundary
> > 
> >  block/block-backend.c             |  11 +++
> >  block/file-posix.c                |  59 +++++++-----
> >  block/io.c                        |  79 ++++++++++++----
> >  hw/block/block.c                  |  68 ++++++++++++++
> >  hw/block/virtio-blk.c             | 146 ++++++++++++++++++++++++++----
> >  include/block/block-io.h          |  14 +++
> >  include/block/block_int-common.h  |  19 +++-
> >  include/hw/block/block.h          |  14 +++
> >  include/hw/virtio/virtio-blk.h    |   1 +
> >  include/system/block-backend-io.h |   1 +
> >  10 files changed, 349 insertions(+), 63 deletions(-)
> > 
> > 
> > base-commit: 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7
> > -- 
> > 2.55.0
> > 
> 
> Thanks, applied to my block tree:
> https://gitlab.com/stefanha/qemu/commits/block

Thank you Stefan!


Kind regards,
Niklas

