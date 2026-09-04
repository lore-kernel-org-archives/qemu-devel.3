Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8C5C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WcK-0000UC-Q8; Fri, 04 Sep 2026 12:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WcI-0000St-GM; Fri, 04 Sep 2026 12:18:14 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1x2WcE-0001Gz-V3; Fri, 04 Sep 2026 12:18:14 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01EB140F00;
 Fri,  4 Sep 2026 16:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447A71F00A3D;
 Fri,  4 Sep 2026 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788538688;
 bh=rhrV+RG3Xk2r6ckQoKpb6yBiOmZgPbtxK8lLrbEBKaE=;
 h=From:To:Cc:Subject:Date;
 b=RVKNO9v+rsMhZ8KBCf+QA7KhcE9CD9ZN/DNUfooQB/68fYW0MwcPD1PTpN5+NnA3E
 Df1JbrrtIDIFRiMvHEiW32ksKHsVMhgpSWE8CN3Z7isQzcoBOiGn228yDhPceeklj6
 RcNrLH3D0htaNTEbRhmuZQqsKeK6ek7m+VnKvBtU7Og4ErD43v2P0bquOox4xYPQko
 YGqWX7MOv0XhWpSzRrANu1A/Ops1Do3Adv5lAToZBNPFs/wYJD37v66PIGtArzF+49
 M29wIkasU6z/bbl/UKAOijzZLYpyflMQq2nnZ5BHxJQGBOg2+1TxgQlsiX3VvJA/CG
 A8Hy2IPo7ra9A==
From: Niklas Cassel <cassel@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] block: fix the zone write granularity and the zone
 append limit
Date: Fri,  4 Sep 2026 18:17:48 +0200
Message-ID: <20260904161801.1568841-1-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
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

This series fixes how QEMU reports and enforces the two constraints a zoned
device places on a write to a sequential zone: the write granularity, and
the largest zone append it accepts. It also fixes two bugs in the zone
append emulation in file-posix, one of which a guest can reach.

Many of these patches are in preparation for Sam Li's zoned qcow2 series.
The first two patches in the series are taken directly from there, as they
are unrelated to qcow2.

Patch 3 is preparation with no functional change: deriving the zone that an
offset belongs to was open coded in five places, so it becomes a helper.

Patches 4 to 6 concern the write granularity. virtio-blk reported the
logical block size while the driver enforced the backend value, so on a
512e SMR disk a guest could be told that a request was valid and get an
I/O error for it. Writes to sequential zones were not checked against the
granularity at all, and zone appends had only their offset checked, not
their length. Patch 6 then refuses at realize a device whose write
pointers the configured logical block size cannot address, which needs no
emulated backend to provoke: write 512 bytes to a zone of a null_blk
device and attach it with logical_block_size=4096.

Patches 7 to 10 concern the append limit. The sector invariant moves to
bdrv_co_zone_append(), since a write pointer is tracked in sectors and
cannot represent anything finer, and file-posix drops its own check which
conflated that with the coarser granularity of the medium. file-posix then
stops reporting zone_append_max_bytes, which bounds REQ_OP_ZONE_APPEND, an
operation it never issues: it appends with an ordinary pwritev(), so
max_hw_transfer is the limit that applies. Finally virtio-blk derives what
it advertises rather than passing BlockLimits.max_append_sectors through,
which made an unset field mean "zone append unsupported" rather than "no
limit of its own", and Linux refuses to attach a zoned device that reports
zero.

Patches 11 and 12 fix the write pointer that raw_co_prw() substitutes for
the offset of an append. An offset that is never bounded against the
device derives an out of range zone index and reads past the write pointer
array, which qemu-io can reach. An append to a full zone uses a pointer
recorded at the end of the zone, so the data is written into the next zone
and success is returned; a guest can reach that one, because nothing in
virtio-blk checks whether a zone is full.


Changes since v2:
-Address review comments from Damien
-Added a patch that adds a helper to get the zone index


Niklas Cassel (10):
  block: add a helper for the index of the zone an offset falls in
  virtio-blk: report the effective zone write granularity
  virtio-blk: check the write granularity of writes to sequential zones
  hw/block: reject a zoned device whose write pointers are unaddressable
  block: reject zone appends that are not a multiple of the sector size
  file-posix: remove the zone append write granularity check
  file-posix: base the zone append limit on the transfer limit
  virtio-blk: derive the maximum zone append size
  file-posix: reject a zone append past the device capacity
  file-posix: reject a zone append to a full or conventional zone

Sam Li (2):
  block: widen BlockLimits.zone_size to uint64_t
  virtio-blk: do not merge requests across a zone boundary

 block/block-backend.c             |  11 +++
 block/file-posix.c                |  71 +++++++++++++-------
 block/io.c                        |  26 +++++++
 hw/block/block.c                  |  53 +++++++++++++++
 hw/block/virtio-blk.c             | 108 +++++++++++++++++++++++++-----
 include/block/block-io.h          |  11 +++
 include/block/block_int-common.h  |   2 +-
 include/hw/block/block.h          |   9 +++
 include/system/block-backend-io.h |   1 +
 9 files changed, 251 insertions(+), 41 deletions(-)

-- 
2.55.0


