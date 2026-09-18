Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17135C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7cPM-0004bm-QG; Fri, 18 Sep 2026 13:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cP7-0004Yt-Pu; Fri, 18 Sep 2026 13:29:41 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x7cP5-0000G6-Bo; Fri, 18 Sep 2026 13:29:41 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D00B940711;
 Fri, 18 Sep 2026 17:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 229561F0089A;
 Fri, 18 Sep 2026 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789752575;
 bh=s1VuQ9nWUfklkbVLPzHIzgtuwQKdW2OPg3L23R+nMsY=;
 h=From:To:Cc:Subject:Date;
 b=JQpyLSyAiaILATofQOdZmmHcmEo7uzdwSPb+RDEImXnwytBqAhociEJX10wWBvtAT
 PMbQq8mwJf8NQwv57m4qljP1tH2NtuyNJfOvXY8GQAwj+1hxDyzyeuGP8XhW5Z3Wgu
 ADhC9xR8qYYu3ifwCAtPwVC05VvZsjK5xw186Jv0v1fHmQBNJtK7mrfqyMZZWxrfQV
 ZjeLrBC+Aqng15o4UmEPP5gvhKGwtA0SvnJs5bQMIBn8tEQKdyc8x45Vstg4gT8ucE
 U8b9H1TQtc6OGMCkozz8I7Ibr3VCbUX55qYmYn36DS4tlq6WuJb3WR74AQYQ+z6Hzf
 CAgJEf4BuapFA==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 00/15] block: fix the zone write granularity and the zone
 append limit
Date: Fri, 18 Sep 2026 19:29:08 +0200
Message-ID: <20260918172925.2640888-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
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

Hello Stefan, Kevin, and everyone else,

This series fixes how QEMU reports and enforces the two constraints that a
zoned device places on a write to a sequential zone: the write granularity,
and the largest zone append that it accepts. It also fixes two bugs in the
zone append emulation in file-posix, one of which a guest can reach.

Most of it is preparation for Sam Li's zoned qcow2 series. The first two
patches are taken directly from there, as they are unrelated to qcow2.

Neither of the two values that this series touches is derived from
BlockLimits any more, which was Stefan's objection to v4: the guest has
been told the value, so it is part of the migration stream, and a
destination host whose disks report something else breaks the guest. The
write granularity now comes from the logical and the physical block size,
the append limit from a property, and a backend that needs more than the
configuration can express is refused at realize. The conditions that hold
for every backend rather than for a particular one moved into the block
layer, where they also cover callers that are not a device model.

Changes since v4:
- Patch 4 is new: a helper to check if a zone is conventional. The device
  model tested that by reaching into bs->wps->wp[] and decoding the bit
  that the block layer encodes it in, which two patches here would have
  added two more instances of.
- Patch 5: derive the granularity from the logical and the physical block
  size rather than from BlockLimits. Document
  BlockLimits.write_granularity. Dropped Damien's Reviewed-by, as the
  derivation itself changed.
- Patch 7: also refuse a backend that needs a coarser granularity than the
  block sizes can express. Dropped Damien's Reviewed-by, as the patch
  gained a check.
- Patch 9 is new: reject an append larger than a zone. This is the bound
  that the device model gives up by no longer deriving its own limit.
- Patch 11: a max-append-sectors property rather than a value derived from
  the backend. It now precedes patch 12, which v4 had first; that way round
  left a commit that reported a zero limit to the guest.
- Patch 12: remove BlockLimits.max_append_sectors, rather than have
  file-posix report max_hw_transfer for it. Nothing reads the field once
  virtio-blk takes its limit from a property, and file-posix was its only
  writer. Damien, your Reviewed-by was for reporting max_hw_transfer, so I
  have dropped it.
- Patch 15 is new: the CoroutineIOCompletion cleanup.

Niklas Cassel (13):
  block: add a helper for the index of the zone an offset falls in
  block: add a helper to check if a zone is conventional
  hw/block: derive the zone write granularity from the block sizes
  virtio-blk: check the write granularity of writes to sequential zones
  hw/block: reject a zoned device that the block sizes cannot address
  block: reject zone appends that are not a multiple of the sector size
  block: reject a zone append that is larger than a zone
  file-posix: remove the zone append write granularity check
  virtio-blk: add a max-append-sectors property
  block: remove BlockLimits.max_append_sectors
  file-posix: reject a zone append past the device capacity
  file-posix: reject a zone append to a full or conventional zone
  block: do not use CoroutineIOCompletion to hold a return value

Sam Li (2):
  block: widen BlockLimits.zone_size to uint64_t
  virtio-blk: do not merge requests across a zone boundary

 block/block-backend.c             |  11 +++
 block/file-posix.c                |  59 +++++++-----
 block/io.c                        |  79 ++++++++++++----
 hw/block/block.c                  |  68 ++++++++++++++
 hw/block/virtio-blk.c             | 146 ++++++++++++++++++++++++++----
 include/block/block-io.h          |  14 +++
 include/block/block_int-common.h  |  19 +++-
 include/hw/block/block.h          |  14 +++
 include/hw/virtio/virtio-blk.h    |   1 +
 include/system/block-backend-io.h |   1 +
 10 files changed, 349 insertions(+), 63 deletions(-)


base-commit: 3b5d71cc3652fa7f5ecc449f05dae3ead2b718d7
-- 
2.55.0


