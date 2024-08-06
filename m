Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD3EC52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 18:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbOr3-0003N2-HB; Tue, 06 Aug 2024 14:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sbOqs-0003GU-Q0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:24:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sbOqp-0005ck-VX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 14:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722968637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=SygTLguhWF4+mVWRjGiWmt0kkv+HTJG2cmn1Lv6Ce6A=;
 b=D+ae1Wu3wusFKD0515mLOWT7atuYfa0BrKZLjk1x5kuPrxGTCIDrJfuya5/HIqUxhoZ76E
 GCeJW8WYafWcf1Waj47YBtrxc0dNfYpWnzMp+VfbRQFM0j2E8bKrWog1FbQGBZe7j47Ckc
 SNt82yFvO/ZTIF9G7P5S1N53VP08Qj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-5pfXw74_NAmVrGltDJmDJg-1; Tue,
 06 Aug 2024 14:23:54 -0400
X-MC-Unique: 5pfXw74_NAmVrGltDJmDJg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 717D51955D42; Tue,  6 Aug 2024 18:23:53 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.170])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB0FE19560AE; Tue,  6 Aug 2024 18:23:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v3 00/13] Block layer patches
Date: Tue,  6 Aug 2024 20:23:46 +0200
Message-ID: <20240806182346.91118-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit c659b7b3b4925f8cef486a3ee64e911519495782:

  Merge tag 'pull-riscv-to-apply-20240806-2' of https://github.com/alistair23/qemu into staging (2024-08-06 17:35:51 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to ca1dcc913888a97073233dd9142ca5241dab1b7c:

  iotests/024: exclude 'backing file format' field from the output (2024-08-06 20:12:40 +0200)

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


