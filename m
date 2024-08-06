Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEFBC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 08:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbF9S-0005jg-5i; Tue, 06 Aug 2024 04:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sbF9Q-0005eb-0m
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sbF9N-00084P-PV
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 04:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722931351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fjlALRPqPwLyvKU8q4dL6mlCRYvwVzq0q3UCOvp0Soo=;
 b=EJC60pSDYvvWVuO+xPdsGavMtI1PhqZ9PDYtrT1VqEqUu8cSJ8dacgVddjI/wY3EyOePjF
 uYLHcOUXeCz+so4H+gsQg88g+bSjx5zdMBxajvMRTSwLEe6lQ80Ny3FWoQdrffk5UvFIcr
 NfqKIEvTTHaM0T76w6HKSZhosj8ORBY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-gPekuA9zPuS3Gt9juLTnVQ-1; Tue,
 06 Aug 2024 04:02:29 -0400
X-MC-Unique: gPekuA9zPuS3Gt9juLTnVQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 232001955D47; Tue,  6 Aug 2024 08:02:28 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D4E51955F40; Tue,  6 Aug 2024 08:02:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/13] Block layer patches
Date: Tue,  6 Aug 2024 10:02:17 +0200
Message-ID: <20240806080217.14941-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit e7207a9971dd41618b407030902b0b2256deb664:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-08-06 08:02:34 +1000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 91f16b6cdccd2942ae09d155cf3f79e6bbb485d5:

  iotests/024: exclude 'backing file format' field from the output (2024-08-06 09:54:24 +0200)

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


