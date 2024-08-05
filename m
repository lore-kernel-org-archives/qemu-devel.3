Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494C5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 21:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4x0-0008IK-Ba; Mon, 05 Aug 2024 17:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4wy-0008Gv-Po
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4wx-0008SK-3p
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oX2DP96yCeF2DgkPvt2MQVPJep14EgN0KTP79m5EVB4=;
 b=FwHmNBYEkE/583xJCXVoMZ/MCObZ2C4zmRU4f9Q+qgJzCrHlxo5JXBcG9SXp2N7bV6GfEl
 XOa+KnTb0WaQC/NXUQQ3mr/6cGQVPgW8sqoFO//x0rkbVvN6GbvHp8Pny4uqHOZTIryiV6
 F3YRx4EcoMasrRwXWuZlRHmM0wYLeDM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-3oNvngJPMPCd7LbkCrnLAw-1; Mon,
 05 Aug 2024 17:08:57 -0400
X-MC-Unique: 3oNvngJPMPCd7LbkCrnLAw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07E0F1955D48; Mon,  5 Aug 2024 21:08:57 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D63230001AA; Mon,  5 Aug 2024 21:08:55 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/13] Block layer patches
Date: Mon,  5 Aug 2024 23:08:38 +0200
Message-ID: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit f9851d2ffef59b3a7f39513469263ab3b019480f:

  Merge tag 'migration-20240802-pull-request' of https://gitlab.com/farosas/qemu into staging (2024-08-03 07:26:26 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 833362e55d9acc6b7ccc1d80d8cd84688e7f5761:

  iotests/024: exclude 'backing file format' field from the output (2024-08-05 23:00:42 +0200)

----------------------------------------------------------------
Block layer patches

- scsi-block: Fix error handling with r/werror=stop
- Depend on newer clang for TSA, make WITH_GRAPH_RDLOCK_GUARD() fully
  checked, fix block-copy to add missing lock
- vvfat: Fix write bugs for large files and add iotests
- Clean up blockdev-snapshot-internal-sync doc
- Fix iotests 024 for qed

----------------------------------------------------------------
Amjad Alsharafi (5):
      vvfat: Fix bug in writing to middle of file
      vvfat: Fix usage of `info.file.offset`
      vvfat: Fix wrong checks for cluster mappings invariant
      vvfat: Fix reading files with non-continuous clusters
      iotests: Add `vvfat` tests

Andrey Drobyshev (1):
      iotests/024: exclude 'backing file format' field from the output

Kevin Wolf (6):
      block-copy: Fix missing graph lock
      block/graph-lock: Make WITH_GRAPH_RDLOCK_GUARD() fully checked
      scsi-disk: Use positive return value for status in dma_readv/writev
      scsi-block: Don't skip callback for sgio error status/driver_status
      scsi-disk: Add warning comments that host_status errors take a shortcut
      scsi-disk: Always report RESERVATION_CONFLICT to guest

Markus Armbruster (1):
      qapi-block-core: Clean up blockdev-snapshot-internal-sync doc

 qapi/block-core.json               |   7 +-
 include/block/graph-lock.h         |  21 +-
 block/block-copy.c                 |   4 +-
 block/vvfat.c                      |  27 +-
 hw/scsi/scsi-disk.c                |  73 ++--
 tests/qemu-iotests/fat16.py        | 690 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/testenv.py      |   2 +-
 meson.build                        |  14 +-
 tests/qemu-iotests/024             |   2 +-
 tests/qemu-iotests/024.out         |   1 -
 tests/qemu-iotests/check           |   2 +-
 tests/qemu-iotests/tests/vvfat     | 485 ++++++++++++++++++++++++++
 tests/qemu-iotests/tests/vvfat.out |   5 +
 13 files changed, 1280 insertions(+), 53 deletions(-)
 create mode 100644 tests/qemu-iotests/fat16.py
 create mode 100755 tests/qemu-iotests/tests/vvfat
 create mode 100755 tests/qemu-iotests/tests/vvfat.out


