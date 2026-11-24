Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E78606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9PfOE2y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVmJj-0007sx-Tj; Tue, 24 Nov 2026 03:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xVmJd-0007pp-2q; Tue, 24 Nov 2026 03:55:53 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xVmJX-0006RK-DV; Tue, 24 Nov 2026 03:55:52 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C763623DB;
 Tue, 24 Nov 2026 08:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F6E1F000D2;
 Tue, 24 Nov 2026 08:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795510536;
 bh=WllkkGTF+X8CrBbxJWsNPAta/FmEI+EsRYxrsSLUItE=;
 h=From:To:Cc:Subject:Date;
 b=L9PfOE2y9qZAvVw9n6qpmVBqnn78g/QOvXf2MFNFFZNIMS8kRuOGu64o5UQrEVwIU
 LJ12r72K074JBQ/q7m4tHxjA0THBXO0rDHb4QQqKgmnqfUdCi2W8v9fA7ZBuTGx/e8
 6FcsTd0xRk/Vq4dZ3NNoVjfySXZuIi5k8pZZUrGhe2spV6PAXWzZfVCyiSPCy+Mvwp
 QtXLgPtCBR1UVQ3igIrw/g5JEs2o+bw3u0xQ+WI5Q1S/nfPfTpvh+nyqWx1WSYF6Sa
 /HvbIQyh0i6yAz3YyhmgWFmlds4GYjO8O9mLA9SYYuDMP2CR1jzOxEyCeYra5OM4Qv
 TCuKMurtWogzA==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>, Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v18 00/10] Add full zoned storage emulation to the qcow2 driver
Date: Tue, 24 Nov 2026 09:55:19 +0100
Message-ID: <20261124085529.1537572-1-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The last two patches are not used by the qcow2 driver. Both Daejun
Park's zoned UFS series and an upcoming series that adds zoned support
to ATA depend on this series, and both also require these two patches,
so they are included here, to avoid both series needing to carry them
separately as dependencies.

Git branch can be found at:
https://github.com/floatious/qemu/tree/qcow2-v18

v17->v18:
- Move the qcow2_cache_set_dependency() change out of "qcow2: add zoned
  emulation capability" into its own patch, "qcow2: do not flush when a
  cache dependency is already set", whose commit message explains why
  skipping the flush is safe.
- Reset bs->wps to NULL after freeing it in qcow2_do_close(), so that
  closing the image again after a failed reopen, e.g. in
  qcow2_co_invalidate_cache(), does not free it twice.

Niklas Cassel (5):
  block: define errnos for zone protocol errors
  qcow2: validate the write pointer table when opening an image
  virtio-blk: report zone errors with their zone status codes
  block: add accessors for the zone model, capacity and open zone limit
  scsi: add the sense codes of zoned block devices

Sam Li (5):
  docs/qcow2: add the zoned format feature
  qcow2: add configurations for zoned format extension
  qcow2: do not flush when a cache dependency is already set
  qcow2: add zoned emulation capability
  iotests: test the zoned format feature for qcow2 file

 MAINTAINERS                                   |    1 +
 block/block-backend.c                         |   33 +
 block/io.c                                    |   13 +-
 block/qcow2-cache.c                           |   11 +-
 block/qcow2-refcount.c                        |   18 +
 block/qcow2.c                                 | 1725 ++++++++++++++++-
 block/qcow2.h                                 |   86 +-
 block/trace-events                            |   10 +
 docs/interop/qcow2.rst                        |  115 +-
 docs/system/qemu-block-drivers.rst.inc        |   44 +
 hw/block/block.c                              |    7 +
 hw/block/virtio-blk.c                         |   49 +-
 include/block/block-common.h                  |   17 +
 include/block/block-io.h                      |    6 +
 include/block/block_int-common.h              |   12 +
 include/qemu/osdep.h                          |    6 +
 include/scsi/utils.h                          |    6 +
 include/system/block-backend-io.h             |    3 +
 qapi/block-core.json                          |   86 +-
 scsi/utils.c                                  |   15 +
 tests/qemu-iotests/031.out                    |    8 +-
 tests/qemu-iotests/036.out                    |    4 +-
 tests/qemu-iotests/061.out                    |   14 +-
 tests/qemu-iotests/082.out                    |  108 ++
 tests/qemu-iotests/303.out                    |    4 +-
 tests/qemu-iotests/tests/qcow2-encryption.out |    4 +-
 tests/qemu-iotests/tests/zoned-qcow2          |  379 ++++
 tests/qemu-iotests/tests/zoned-qcow2.out      |  267 +++
 28 files changed, 3003 insertions(+), 48 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out


base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
-- 
2.56.1


