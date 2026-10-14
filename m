Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543BAC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3wj-0002b5-CK; Wed, 14 Oct 2026 14:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xH3wf-0002ar-3j
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xH3wc-0003mK-N4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792003396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bJHXpmTmxzGi3FpR1RkO7Dt+U5YWqFIEZ9UmDdFeHlI=;
 b=ZVFwmJDBIN4SGylKzE1MTTZ5bC3Sw1wK7VMMsvOy5Sj/TuhecZpX/ZvWDd/hkLqtuUuOgE
 ysfLOlYoaFlDFyFV+QB3ViJZ0hPZqeVANP620M2sICP9WBc6z0sUjZwvaP0jstHFB3aD/W
 iwNZjbQ4skGmMEVicHe4KoRF5lZj75M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-wUBmDk6LMgKGntENV3-bmA-1; Wed,
 14 Oct 2026 18:43:14 +0000
X-MC-Unique: wUBmDk6LMgKGntENV3-bmA-1
X-Mimecast-MFC-AGG-ID: wUBmDk6LMgKGntENV3-bmA_1792003394
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D8551955F1D
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:43:14 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8FB0F1800347
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:43:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/15] NBD patches through 2026-10-08
Date: Wed, 14 Oct 2026 13:42:34 -0500
Message-ID: <20261014184309.664714-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 8ee6c77176cfee03be0ec7665b6652b2f31f1531:

  Merge tag 'pull-ufs-20261012' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-10-13 22:01:07 +0200)

are available in the Git repository at:

  https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-10-08-v3

for you to fetch changes up to 9c4c3cb45b321b6365a1b03df14ca7449523aac0:

  iotests/iothreads-nbd-export: Skip on s390 (2026-10-14 13:07:56 -0500)

[v3: sending only the updated cover letter and patch 11/15]

----------------------------------------------------------------
NBD patches through 2026-10-08

Several fixes, including:
- Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l
- Fiona Ebner: Report flush error on qemu-img convert
- Guillaume Vinke: Fix NBD client on dead connection
- Denis V. Lunev: Fix postcopy dirty bitmap migration
- Eric Farman: Several iotest improvements

----------------------------------------------------------------
Denis V. Lunev (3):
      migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
      migration/block-dirty-bitmap: fix postcopy abort with bitmaps on several nodes
      iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node

Eric Blake (2):
      maint: Update eblake's staging repo
      qemu-nbd: Support -s and -l at the same time

Eric Farman (4):
      iotests/nbd-in-qcow2-chain: use default machine
      iotests/nbd-tls-iothread: skip on non-x86 hardware
      iotests/fuse-truncate: skip if FUSE is not usable
      iotests/iothreads-nbd-export: Skip on s390

Fiona Ebner (4):
      iotests: add test cases for failing flush after qemu-img convert
      iotests.py: add filter_qemu()
      block: report flush error during bdrv_close()
      qemu-img: convert: flush target image after copying

Guillaume Vincke (2):
      nbd/client-connection: Fix client returning a closed channel
      iotests: Add coverage for NBD connect thread start delay

 docs/tools/qemu-nbd.rst                            |  7 +-
 include/migration/qemu-file-types.h                |  6 +-
 block.c                                            | 13 +++-
 migration/block-dirty-bitmap.c                     | 62 ++++++++++++++--
 migration/qemu-file.c                              |  5 +-
 nbd/client-connection.c                            | 32 +++++++++
 qemu-img.c                                         |  8 ++-
 qemu-nbd.c                                         | 22 +++++-
 MAINTAINERS                                        |  4 +-
 tests/qemu-iotests/026                             | 10 +--
 tests/qemu-iotests/026.out                         | 84 ++++++++++++++++++++++
 tests/qemu-iotests/071                             |  2 +-
 tests/qemu-iotests/071.out                         |  2 +
 tests/qemu-iotests/080.out                         |  2 +
 tests/qemu-iotests/098.out                         |  4 ++
 tests/qemu-iotests/122                             | 33 +++++++++
 tests/qemu-iotests/122.out                         | 17 +++++
 tests/qemu-iotests/244                             |  2 +-
 tests/qemu-iotests/244.out                         |  1 +
 tests/qemu-iotests/iotests.py                      |  4 ++
 tests/qemu-iotests/tests/file-io-error             |  2 +-
 tests/qemu-iotests/tests/file-io-error.out         |  2 +
 tests/qemu-iotests/tests/fuse-truncate             |  9 ++-
 tests/qemu-iotests/tests/iothreads-nbd-export      |  5 ++
 .../tests/migrate-bitmaps-postcopy-test            | 22 ++++++
 tests/qemu-iotests/tests/nbd-in-qcow2-chain        |  2 +-
 tests/qemu-iotests/tests/nbd-stale-connection      | 62 ++++++++++++++++
 tests/qemu-iotests/tests/nbd-stale-connection.out  | 17 +++++
 tests/qemu-iotests/tests/nbd-tls-iothread          |  4 ++
 tests/qemu-iotests/tests/qemu-nbd-snapshots        | 81 +++++++++++++++++++++
 tests/qemu-iotests/tests/qemu-nbd-snapshots.out    | 39 ++++++++++
 tests/qemu-iotests/tests/qsd-migrate               |  5 +-
 tests/qemu-iotests/tests/qsd-migrate.out           |  1 +
 33 files changed, 538 insertions(+), 33 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out
 create mode 100755 tests/qemu-iotests/tests/qemu-nbd-snapshots
 create mode 100644 tests/qemu-iotests/tests/qemu-nbd-snapshots.out

-- 
2.56.0


