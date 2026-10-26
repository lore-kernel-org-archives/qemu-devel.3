Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1658606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6goCWtq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJZo-00006j-Go; Mon, 26 Oct 2026 08:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLJZm-00005h-2t; Mon, 26 Oct 2026 08:13:18 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLJZk-0005xj-2m; Mon, 26 Oct 2026 08:13:17 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C45C343AC7;
 Mon, 26 Oct 2026 12:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D11F01825;
 Mon, 26 Oct 2026 12:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793016792;
 bh=1Y7NAzHaRtInXa6woXKE3nGA0pc0QenHLP8Prpyxf/E=;
 h=From:To:Cc:Subject:Date;
 b=W6goCWtqxFVK0hPPEOxXO7d0Y8/d0/LAF5N65kE5Jsvo5j2SXMNOvbuyOtNa/0eyh
 hzgVxKbQFPJgcntw58PD1lqxxgqm0dijoW+MI5zQTUmHzTxOcofFcP9Z+Gq4N29l+R
 1ylsXhT32Tlh1wZ0QjlNhY6Um8zJ7cWpvBE7mTQT1C84On4qXPF768f9JiI5giKIeZ
 R8EAzD6q5FcngqggrvB0jWor/9M5ASucKGip8cFz2elOro+7j96eawwpl2BrGfGgi4
 d6CwcSXnUvcvY7RVzkWr+Syls+gsOhiryxhvqq2rRRuOPNGwmm3xaeA05OPzyQMxGe
 xb829xh2/UM7g==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH v15 0/7] Add full zoned storage emulation to the qcow2 driver
Date: Mon, 26 Oct 2026 13:12:48 +0100
Message-ID: <20261026121259.3354561-1-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=cassel@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This patch series adds a new extension - zoned format - to the
qcow2 driver, allowing full zoned storage emulation on a qcow2
image file. A user can attach such an image to a guest and have
it appear as a host-managed zoned block device.

The zoned format is opt-in through a new qcow2 header extension
that pins the zone geometry. Behind the extension is a dedicated
zoned metadata region that stores one 8-byte write pointer (WP)
per zone. The extension is gated by an incompatible bit, so an
older qcow2 implementation cannot accidentally open the image.

Each write pointer is routed through the write pointer cache,
a Qcow2Cache object. The write pointer cache is written to disk
after the qcow2 metadata is written, thus guaranteeing that
the write pointer is updated after the corresponding data is
written.

Zone states are in memory. Read-only and offline states are
device-internal events, which are not modelled in qcow2
emulation for simplicity. The other zone states
(closed, empty, full) can be inferred from write pointer
values, persistent across QEMU reboots. The open states are
kept in memory using open zone lists.

To create a qcow2 file with the zoned format:

    qemu-img create -f qcow2 zbc.qcow2 \
        -o size=768M \
        -o zone.size=64M \
        -o zone.capacity=64M \
        -o zone.conventional_zones=0 \
        -o zone.max_open_zones=6 \
        -o zone.max_active_zones=8 \
        -o zone.mode=host-managed

Then attach it to a guest via the QEMU command line:
    -blockdev node-name=drive1,driver=qcow2,file.driver=file,file.filename=zbc.qcow2 \
    -device virtio-blk-pci,drive=drive1 \

Tested with blktests, fio, zbd_state (an internal test suite) and
zonefs, comparing a zoned qcow2 image attached via virtio-blk with
zloop, null_blk and scsi_debug (passed/failed/skipped):

    +--------------------+----------+---------+-----------+---------+
    | Testrun            | blktests | fio     | zbd_state | zonefs  |
    +--------------------+----------+---------+-----------+---------+
    | zloop              | 9/0/10   | 57/0/18 | 29/0/8    | 113/0/0 |
    | null_blk           | 9/0/10   | 57/0/18 | 29/0/8    | 113/0/0 |
    | scsi_debug         | 10/0/12  | 61/0/14 | 29/0/8    | 113/0/0 |
    | virtio-blk + qcow2 | 9/0/10   | 57/0/18 | 29/0/8    | 113/0/0 |
    +--------------------+----------+---------+-----------+---------+

This series depends on the (still not merged) series "block: fix the
zone write granularity and the zone append limit":
https://lore.kernel.org/qemu-devel/20260921142819.2916043-1-cassel@kernel.org/

Git branch which includes the dependency series can be found at:
https://github.com/floatious/qemu/tree/qcow2-v15

Based-on: <20260921142819.2916043-1-cassel@kernel.org>

v14->v15:
- rebase on the series above, which now contains the v14 patches
  "block: widen BlockLimits.zone_size to uint64_t" and "virtio-blk: do
  not merge writes across a zone boundary", and which moves the zone
  append checks to the block layer
- drop zone.max_append_bytes; zonedmeta_offset moves to bytes 24-31 of
  the zoned header extension, so images created with v14 are not
  compatible
- require a version 3 image, a zone size that is a multiple of the
  cluster size, and a zone capacity that is a multiple of the zone
  write granularity
- report zone errors with dedicated errnos (new patch) instead of EIO,
  EINVAL and EBUSY
- manage the zone resources as in NVMe ZNS (2.1.1.4.1) and ZBC-3, and
  fix OPEN ZONE of a full zone, writes that fill a closed zone, writes
  from a conventional into a sequential zone, conventional zone and
  zone capacity reporting, and a shorter last zone
- validate the zoned header extension, and the write pointer table (new
  patch), when opening an image
- account for the zoned metadata in qemu-img check
- report zone errors with their zone status codes in virtio-blk (new
  patch)
- extend the iotest with zone errors, zone resources and image checks

Niklas Cassel (3):
  block: define errnos for zone protocol errors
  qcow2: validate the write pointer table when opening an image
  virtio-blk: report zone errors with their zone status codes

Sam Li (4):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 MAINTAINERS                                   |    1 +
 block/io.c                                    |   13 +-
 block/qcow2-cache.c                           |   11 +-
 block/qcow2-refcount.c                        |   18 +
 block/qcow2.c                                 | 1674 ++++++++++++++++-
 block/qcow2.h                                 |   86 +-
 block/trace-events                            |    2 +
 docs/interop/qcow2.rst                        |  115 +-
 docs/system/qemu-block-drivers.rst.inc        |   44 +
 hw/block/block.c                              |    7 +
 hw/block/virtio-blk.c                         |   48 +-
 include/block/block-common.h                  |   16 +
 include/block/block-io.h                      |    6 +
 include/block/block_int-common.h              |   12 +
 include/qemu/osdep.h                          |    3 +
 qapi/block-core.json                          |   86 +-
 tests/qemu-iotests/031.out                    |    8 +-
 tests/qemu-iotests/036.out                    |    4 +-
 tests/qemu-iotests/061.out                    |   14 +-
 tests/qemu-iotests/082.out                    |  108 ++
 tests/qemu-iotests/303.out                    |    4 +-
 tests/qemu-iotests/tests/qcow2-encryption.out |    4 +-
 tests/qemu-iotests/tests/zoned-qcow2          |  362 ++++
 tests/qemu-iotests/tests/zoned-qcow2.out      |  265 +++
 24 files changed, 2874 insertions(+), 37 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

-- 
2.56.0


