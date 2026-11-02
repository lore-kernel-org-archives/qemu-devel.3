Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F116072C5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z+18iaqS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvR-0006FN-TZ; Mon, 02 Nov 2026 11:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvC-000659-9D
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvA-00022W-3U
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PQPlzSWPqun3snQ2lGazEe/MtTE/THlQGFQTcRRclxE=;
 b=Z+18iaqSQR4h8tKJSiyyGMQWw0MY3RbP6J5GeGPRpnBskagLFzhNq0nqQhih/MQ1p6i/xv
 C22J7Td1WXR4Ze/PGQ9xPhBiq+N9WEWpXeeF3An3UTdBzYPAu2XEK3x8KyH9vsXn19+IAx
 pICRiWvRZnvTBrc6o2UQx73dGefz4nQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-q0qWWjDlOmei7jtoHUW7Xg-1; Mon,
 02 Nov 2026 11:30:04 -0500
X-MC-Unique: q0qWWjDlOmei7jtoHUW7Xg-1
X-Mimecast-MFC-AGG-ID: q0qWWjDlOmei7jtoHUW7Xg_1793637003
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E42FF19560B1; Mon,  2 Nov 2026 16:30:02 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BEBE1956087; Mon,  2 Nov 2026 16:30:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/17] Block layer patches
Date: Mon,  2 Nov 2026 17:29:38 +0100
Message-ID: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 6e641f2440aa637c670b7f0fe512ea3fc2611b99:

  block/vmdk: add eos marker for stream optimized disks (2026-11-02 17:06:37 +0100)

----------------------------------------------------------------
Block layer patches

- mirror: do not require a root block node
- file-posix: Add 'accept-read-only-device' option
- vmdk: Fixes for converting to streamOptimized
- virtio-blk: Add support for FUA write requests
- Print simple help text when calling "-blockdev help"
- qemu-nbd: Add --all-bitmaps option
- coroutine: Fix default idle pool max size on Linux

----------------------------------------------------------------
Alberto Faria (1):
      virtio-blk: Add support for FUA write requests

Christian Quante (1):
      tests/qtest/fdc-test: check block accounting of non-DMA reads

Daniel P. Berrangé (1):
      block: fix leak of block histogram data

Eric Blake (1):
      qemu-nbd: Add --all-bitmaps option

Fiona Ebner (3):
      iotests/041: add test for mirror with throttle node as source
      blockdev: mirror: do not require a root block node
      iotests/041: add tests for mirroring below throttle node

Haoqian He (1):
      iotests: cover discard passthrough during background mirror

Hector Cao (1):
      util/coroutine: trim sysctl's max_map_count newline before parsing

Kevin Wolf (2):
      file-posix: Add 'accept-read-only-device' option
      iotests: Add loop-accept-ro-dev test

Sanne Raymaekers (3):
      block/vmdk: Don't preallocate full 64k for compressed data grains
      block/vmdk: skip RGD for stream optimized disks
      block/vmdk: add eos marker for stream optimized disks

Stefan Hajnoczi (1):
      qemu-pr-helper: do not free reply when multipath_process_cmd() fails

Thomas Huth (1):
      block: Print simple help text when calling "-blockdev help"

Wesley Hershberger (1):
      util/coroutine: Reduce default idle pool max size

 qapi/block-core.json                            |  23 ++++-
 docs/tools/qemu-nbd.rst                         |  12 ++-
 include/block/block-common.h                    |   1 +
 include/hw/virtio/virtio-blk.h                  |   1 +
 block.c                                         |  15 +++
 block/accounting.c                              |   2 +
 block/file-posix.c                              |  23 ++++-
 block/vmdk.c                                    | 121 +++++++++++++---------
 blockdev.c                                      |  20 +++-
 hw/block/virtio-blk.c                           |  37 +++++++
 hw/core/machine.c                               |   1 +
 hw/virtio/virtio-qmp.c                          |  10 ++
 qemu-nbd.c                                      |  57 ++++++++++-
 scsi/qemu-pr-helper.c                           |  11 +-
 system/vl.c                                     |   7 +-
 tests/qtest/fdc-test.c                          |  42 ++++++++
 util/qemu-coroutine.c                           |  71 ++++++++-----
 tests/qemu-iotests/041                          | 128 ++++++++++++++++++++++++
 tests/qemu-iotests/041.out                      |   4 +-
 tests/qemu-iotests/tests/loop-accept-ro-dev     |  88 ++++++++++++++++
 tests/qemu-iotests/tests/loop-accept-ro-dev.out |  19 ++++
 tests/qemu-iotests/tests/mirror-discard         |  73 ++++++++++++++
 tests/qemu-iotests/tests/mirror-discard.out     |   5 +
 tests/qemu-iotests/tests/qemu-img-bitmaps       |  13 +++
 tests/qemu-iotests/tests/qemu-img-bitmaps.out   |  12 +++
 25 files changed, 707 insertions(+), 89 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/loop-accept-ro-dev
 create mode 100644 tests/qemu-iotests/tests/loop-accept-ro-dev.out
 create mode 100755 tests/qemu-iotests/tests/mirror-discard
 create mode 100644 tests/qemu-iotests/tests/mirror-discard.out


