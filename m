Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E0FC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8f2E-000365-Uw; Mon, 21 Sep 2026 10:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0k-0001vm-Ta; Mon, 21 Sep 2026 10:28:55 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x8f0h-000063-7g; Mon, 21 Sep 2026 10:28:50 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E821F600C8;
 Mon, 21 Sep 2026 14:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6D51F000FF;
 Mon, 21 Sep 2026 14:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790000916;
 bh=LZZy49Ez8GDffGHRFnMw72Dx2x8nZP6w80g1o7sGip4=;
 h=From:To:Cc:Subject:Date;
 b=BVm/xLmfsWzC2ERLKV06z2HqjOOH5vLYkI3e44SY4PyISS4ycsOkdPikzdqYyaZ4U
 nelZoglfxcTwEwPIAIB61+1u0bbuHn63VZVMsPdlyBk0eIyQ7H8W2p6TMmwURiXeGS
 +ti9CEYZl67gTO0ngWTCTC4HzXkC4A5k7PteICwwqk9qrI2j2Yfg1HipFck+5GBs99
 KWYiQFAgC2H4yZNKmpEwa9V2B3k8+gIGSkxRROPYCjoqaXTv4w5JNvxelYAmGZbfsN
 F0QM44XBcsVxfmTEtvqKAONaY7uagi/g3Qcm+FYKrgdWcHyFYur+gY0Bvd4JRIbCI2
 Z8zHONjH4rrFg==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v6 00/15] block: fix the zone write granularity and the zone
 append limit
Date: Mon, 21 Sep 2026 16:28:02 +0200
Message-ID: <20260921142819.2916043-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hello Stefan, Kevin, and everyone else,

This series fixes how QEMU reports and enforces the two constraints that a
zoned device places on a write to a sequential zone: the write granularity,
and the largest zone append that it accepts. It also fixes two bugs in the
zone append emulation in file-posix, one of which a guest can reach.

Most of it is preparation for Sam Li's zoned qcow2 series. The first two
patches are taken directly from there, as they are unrelated to qcow2.

Changes since v5:
-Picked up Stefan's Reviewed-by tags that he gave when reviewing v4.
 Patches that have changed significantly since v4 have had tags dropped
 (i.e. they will have neither Damien's nor Stefan's Reviewed-by tags).

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


