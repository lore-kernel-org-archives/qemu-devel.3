Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151B3C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7d1m-0002G5-CF; Fri, 18 Sep 2026 14:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7d1k-0002Fr-Uq; Fri, 18 Sep 2026 14:09:36 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7d1j-0000Qm-30; Fri, 18 Sep 2026 14:09:36 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4CE266053B;
 Fri, 18 Sep 2026 18:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918901F000FF;
 Fri, 18 Sep 2026 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789754973;
 bh=nn2ACGNl0JItvk+0dkDagjUvBrduDougE0sMWGM5CWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nRV+wbv/BkAlmuezx4TiByOsWJT6GF+mf5cHezPCJ+62yTvsl+kW/uStIBT8fEa/y
 irPPm+Z63V5kb6MvDQFkWwo/Wd7Q4y3EINvgVHwLvH48WP1o5V9COVhWyqJMJDBO18
 212ut6ijwjw2KMSF22BCuv8K7o32IPlfZBjeUd/wAeYJ4PMm47b20rGC+ThBvEplzz
 tbvCaLVEJo2RTYp7FiBLDgiv4FWFocSou997CT5KUKDDrQ6+OxTvP9jsvM/yE4C/Fc
 w6XNKE06OIdxfvEFmWpCEcDyaxagIg5rGTGF+gog3LaAws59bpQPfXIYPdWmmxfon9
 HbGF7Q5APBZ1Q==
Date: Fri, 18 Sep 2026 20:09:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 00/15] block: fix the zone write granularity and the
 zone append limit
Message-ID: <aq1-V-1kBKvoTbJV@ryzen>
References: <20260918172925.2640888-1-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918172925.2640888-1-cassel@kernel.org>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 18, 2026 at 07:29:08PM +0200, Niklas Cassel wrote:
> Hello Stefan, Kevin, and everyone else,
> 
> This series fixes how QEMU reports and enforces the two constraints that a
> zoned device places on a write to a sequential zone: the write granularity,
> and the largest zone append that it accepts. It also fixes two bugs in the
> zone append emulation in file-posix, one of which a guest can reach.
> 
> Most of it is preparation for Sam Li's zoned qcow2 series. The first two
> patches are taken directly from there, as they are unrelated to qcow2.
> 
> Neither of the two values that this series touches is derived from
> BlockLimits any more, which was Stefan's objection to v4: the guest has
> been told the value, so it is part of the migration stream, and a
> destination host whose disks report something else breaks the guest. The
> write granularity now comes from the logical and the physical block size,
> the append limit from a property, and a backend that needs more than the
> configuration can express is refused at realize. The conditions that hold
> for every backend rather than for a particular one moved into the block
> layer, where they also cover callers that are not a device model.
> 
> Changes since v4:
> - Patch 4 is new: a helper to check if a zone is conventional. The device
>   model tested that by reaching into bs->wps->wp[] and decoding the bit
>   that the block layer encodes it in, which two patches here would have
>   added two more instances of.
> - Patch 5: derive the granularity from the logical and the physical block
>   size rather than from BlockLimits. Document
>   BlockLimits.write_granularity. Dropped Damien's Reviewed-by, as the
>   derivation itself changed.
> - Patch 7: also refuse a backend that needs a coarser granularity than the
>   block sizes can express. Dropped Damien's Reviewed-by, as the patch
>   gained a check.
> - Patch 9 is new: reject an append larger than a zone. This is the bound
>   that the device model gives up by no longer deriving its own limit.
> - Patch 11: a max-append-sectors property rather than a value derived from
>   the backend. It now precedes patch 12, which v4 had first; that way round
>   left a commit that reported a zero limit to the guest.
> - Patch 12: remove BlockLimits.max_append_sectors, rather than have
>   file-posix report max_hw_transfer for it. Nothing reads the field once
>   virtio-blk takes its limit from a property, and file-posix was its only
>   writer. Damien, your Reviewed-by was for reporting max_hw_transfer, so I
>   have dropped it.
> - Patch 15 is new: the CoroutineIOCompletion cleanup.

Stefan, it seems like my tooling failed to pick up your tags because they
were multipart messages.... I'm very sorry about that.

Patches that you have reviewed, and are supposed to have your R-b tag:
1, 2, 3, 6, 8, 10, 13, 14



Patches that you need to review - changed so much that I dropped tags:
7, 12

Patches that you need to review - patches that you had comments on:
5, 11

Patches that you need to review - patches that are new:
4, 9, 15



Kind regards,
Niklas

