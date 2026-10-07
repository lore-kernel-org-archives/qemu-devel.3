Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74739CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUb5-0002sS-Uf; Wed, 07 Oct 2026 12:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUay-0002ri-D4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUav-0006Hk-PH
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jzpu1O/7TABrkb6z5iVMA79CEVPEVFnmF6qiFWdyOp8=;
 b=ZKAHTrNTI2lavQX5mm7i0kZU3VvPN5YuH5UpO0oYlGuzblyw/ejYZ4lcDZG7shK0adYNsb
 V8M42O0+0Fasx8rEscH+5/vTyjULjWoU5CAbytB/e9V+8hyF5lJsqubA23v1vkOf9CfLp0
 nIH4SLfKLt+qu0vJd89YT4oRAywBxQo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-0kw-V5gpMzCFbZegnLROzA-1; Wed,
 07 Oct 2026 12:34:14 -0400
X-MC-Unique: 0kw-V5gpMzCFbZegnLROzA-1
X-Mimecast-MFC-AGG-ID: 0kw-V5gpMzCFbZegnLROzA_1791390853
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC131936179; Wed,  7 Oct 2026 16:34:13 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA0901956087; Wed,  7 Oct 2026 16:34:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/21] Block layer patches
Date: Wed,  7 Oct 2026 18:32:41 +0200
Message-ID: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

The following changes since commit f9587d4045c67cd0d8d8bdcd5d0bb5b6b395b63c:

  Merge tag 'pbouvier/pr/plugins-20261005' of https://gitlab.com/p-b-o/qemu into staging (2026-10-06 11:26:40 +0200)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to cf4f672c11d663f87462cfd99a92124b30804e99:

  block: Remove now redundant bdrv_wait_serialising_requests() calls (2026-10-07 18:00:36 +0200)

----------------------------------------------------------------
Block layer patches

- Fix corruption from broken RMW atomicity
- Fix bdrv_next() skipping monitor-owned nodes
- fdc: Account for read and write requests
- throttle-groups: Fix crash when enabling I/O limits on a busy disk
- file-posix: Fixed O_DIRECT alignment for truncate requests
- file-posix: add statx(STATX_DIOALIGN) support
- qcow2: (Partially) fix reopen for read-only nodes
- scripts/qemugdb: Fixes for 'qemu bt' / 'qemu coroutine' commands
- Code cleanup

----------------------------------------------------------------
Andrey Drobyshev (10):
      block: allocate aligned write buffer for 'truncate -m full'
      scripts/qemugdb: coroutine: Fix selected frame leak on error path
      scripts/qemugdb: coroutine: Get rid of fallback pattern when dumping backtrace
      scripts/qemugdb: coroutine: Only attempt to restore regs in coredump
      scripts/qemugdb: coroutine: Don't unwind past the outermost frame
      scripts/qemugdb: coroutine: Fix patching pt_regs in the coredump
      scripts/qemugdb: coroutine: Fix '--detailed' description
      scripts/qemugdb: coroutine: Handle target absence gracefully
      scripts/qemugdb: coroutine: Speed up coroutine lookup in a coredump
      scripts/qemugdb: coroutine: Don't touch the coredump for a plain backtrace

Christian Quante (1):
      hw/block/fdc: account for read and write requests

Daniel P. Berrangé (1):
      iotests: remove unused 'owner=' variable assignment

Denis V. Lunev (5):
      block-common: fix BDRV_WANT_PRECISE duplicating BDRV_WANT_OFFSET_VALID
      block/throttle-groups: fix crash when enabling I/O limits on a busy disk
      block: fix bdrv_next() skipping monitor-owned nodes
      qcow2: do not clear the dirty bit when reopening a read-only node
      block: reject a reopen of an unusable node instead of crashing

Kevin Wolf (2):
      block: Fix corruption from broken RMW atomicity
      block: Remove now redundant bdrv_wait_serialising_requests() calls

Stefan Hajnoczi (1):
      file-posix: add statx(STATX_DIOALIGN) support

Tim Pambor (1):
      iotests: annotate TestRunner.shared_self for mypy 2.4

 include/block/block-common.h                       |   2 +-
 include/block/block_int-common.h                   |   1 +
 block.c                                            |  14 ++-
 block/block-backend.c                              |  13 +-
 block/file-posix.c                                 |  61 ++++++----
 block/io.c                                         |  42 ++++---
 block/qcow2.c                                      |   8 +-
 block/throttle-groups.c                            |   4 +-
 hw/block/fdc.c                                     |  52 ++++++--
 scripts/qemugdb/coroutine.py                       | 135 +++++++++++++--------
 tests/qemu-iotests/testrunner.py                   |   2 +-
 tests/qemu-iotests/001                             |   2 -
 tests/qemu-iotests/002                             |   2 -
 tests/qemu-iotests/003                             |   2 -
 tests/qemu-iotests/004                             |   2 -
 tests/qemu-iotests/005                             |   2 -
 tests/qemu-iotests/007                             |   2 -
 tests/qemu-iotests/008                             |   2 -
 tests/qemu-iotests/009                             |   2 -
 tests/qemu-iotests/010                             |   2 -
 tests/qemu-iotests/011                             |   2 -
 tests/qemu-iotests/012                             |   2 -
 tests/qemu-iotests/013                             |   2 -
 tests/qemu-iotests/014                             |   2 -
 tests/qemu-iotests/015                             |   2 -
 tests/qemu-iotests/017                             |   2 -
 tests/qemu-iotests/018                             |   2 -
 tests/qemu-iotests/019                             |   2 -
 tests/qemu-iotests/020                             |   2 -
 tests/qemu-iotests/021                             |   2 -
 tests/qemu-iotests/022                             |   2 -
 tests/qemu-iotests/023                             |   2 -
 tests/qemu-iotests/024                             |   2 -
 tests/qemu-iotests/025                             |   2 -
 tests/qemu-iotests/026                             |   2 -
 tests/qemu-iotests/027                             |   2 -
 tests/qemu-iotests/028                             |   2 -
 tests/qemu-iotests/029                             |   2 -
 tests/qemu-iotests/031                             |   2 -
 tests/qemu-iotests/032                             |   2 -
 tests/qemu-iotests/033                             |   2 -
 tests/qemu-iotests/034                             |   2 -
 tests/qemu-iotests/035                             |   2 -
 tests/qemu-iotests/036                             |   2 -
 tests/qemu-iotests/037                             |   2 -
 tests/qemu-iotests/038                             |   2 -
 tests/qemu-iotests/039                             |  52 +++++++-
 tests/qemu-iotests/039.out                         |  20 +++
 tests/qemu-iotests/042                             |   2 -
 tests/qemu-iotests/043                             |   2 -
 tests/qemu-iotests/046                             |   2 -
 tests/qemu-iotests/047                             |   2 -
 tests/qemu-iotests/048                             |   2 -
 tests/qemu-iotests/049                             |   2 -
 tests/qemu-iotests/050                             |   2 -
 tests/qemu-iotests/051                             |   2 -
 tests/qemu-iotests/052                             |   2 -
 tests/qemu-iotests/053                             |   2 -
 tests/qemu-iotests/054                             |   2 -
 tests/qemu-iotests/058                             |   2 -
 tests/qemu-iotests/059                             |   2 -
 tests/qemu-iotests/060                             |  32 ++++-
 tests/qemu-iotests/060.out                         |  12 ++
 tests/qemu-iotests/061                             |   2 -
 tests/qemu-iotests/062                             |   2 -
 tests/qemu-iotests/063                             |   2 -
 tests/qemu-iotests/064                             |   2 -
 tests/qemu-iotests/066                             |   2 -
 tests/qemu-iotests/068                             |   2 -
 tests/qemu-iotests/069                             |   2 -
 tests/qemu-iotests/070                             |   2 -
 tests/qemu-iotests/071                             |   2 -
 tests/qemu-iotests/072                             |   2 -
 tests/qemu-iotests/073                             |   2 -
 tests/qemu-iotests/074                             |   2 -
 tests/qemu-iotests/075                             |   2 -
 tests/qemu-iotests/076                             |   2 -
 tests/qemu-iotests/077                             |   2 -
 tests/qemu-iotests/078                             |   2 -
 tests/qemu-iotests/079                             |   2 -
 tests/qemu-iotests/080                             |   2 -
 tests/qemu-iotests/081                             |   2 -
 tests/qemu-iotests/082                             |   2 -
 tests/qemu-iotests/083                             |   2 -
 tests/qemu-iotests/084                             |   2 -
 tests/qemu-iotests/085                             |   2 -
 tests/qemu-iotests/086                             |   2 -
 tests/qemu-iotests/087                             |   2 -
 tests/qemu-iotests/088                             |   2 -
 tests/qemu-iotests/089                             |   2 -
 tests/qemu-iotests/090                             |   2 -
 tests/qemu-iotests/091                             |   2 -
 tests/qemu-iotests/092                             |   2 -
 tests/qemu-iotests/094                             |   2 -
 tests/qemu-iotests/095                             |   2 -
 tests/qemu-iotests/097                             |   2 -
 tests/qemu-iotests/098                             |   2 -
 tests/qemu-iotests/099                             |   2 -
 tests/qemu-iotests/101                             |   2 -
 tests/qemu-iotests/102                             |   2 -
 tests/qemu-iotests/103                             |   2 -
 tests/qemu-iotests/104                             |   2 -
 tests/qemu-iotests/105                             |   2 -
 tests/qemu-iotests/106                             |   2 -
 tests/qemu-iotests/107                             |   2 -
 tests/qemu-iotests/108                             |   2 -
 tests/qemu-iotests/109                             |   2 -
 tests/qemu-iotests/110                             |   2 -
 tests/qemu-iotests/111                             |   2 -
 tests/qemu-iotests/112                             |   2 -
 tests/qemu-iotests/113                             |   2 -
 tests/qemu-iotests/114                             |   2 -
 tests/qemu-iotests/115                             |   2 -
 tests/qemu-iotests/116                             |   2 -
 tests/qemu-iotests/117                             |   2 -
 tests/qemu-iotests/119                             |   2 -
 tests/qemu-iotests/120                             |   2 -
 tests/qemu-iotests/121                             |   2 -
 tests/qemu-iotests/122                             |   2 -
 tests/qemu-iotests/123                             |   2 -
 tests/qemu-iotests/125                             |   2 -
 tests/qemu-iotests/126                             |   2 -
 tests/qemu-iotests/127                             |   2 -
 tests/qemu-iotests/128                             |   2 -
 tests/qemu-iotests/130                             |   2 -
 tests/qemu-iotests/131                             |   2 -
 tests/qemu-iotests/133                             |   2 -
 tests/qemu-iotests/134                             |   2 -
 tests/qemu-iotests/135                             |   2 -
 tests/qemu-iotests/137                             |   2 -
 tests/qemu-iotests/138                             |   2 -
 tests/qemu-iotests/140                             |   2 -
 tests/qemu-iotests/142                             |   2 -
 tests/qemu-iotests/143                             |   2 -
 tests/qemu-iotests/144                             |   2 -
 tests/qemu-iotests/145                             |   2 -
 tests/qemu-iotests/146                             |   2 -
 tests/qemu-iotests/150                             |   2 -
 tests/qemu-iotests/153                             |   2 -
 tests/qemu-iotests/154                             |   2 -
 tests/qemu-iotests/156                             |   2 -
 tests/qemu-iotests/157                             |   2 -
 tests/qemu-iotests/158                             |   2 -
 tests/qemu-iotests/159                             |   1 -
 tests/qemu-iotests/160                             |   1 -
 tests/qemu-iotests/161                             |   2 -
 tests/qemu-iotests/162                             |   2 -
 tests/qemu-iotests/170                             |   1 -
 tests/qemu-iotests/171                             |   2 -
 tests/qemu-iotests/172                             |   2 -
 tests/qemu-iotests/173                             |   2 -
 tests/qemu-iotests/174                             |   2 -
 tests/qemu-iotests/175                             |   2 -
 tests/qemu-iotests/176                             |   2 -
 tests/qemu-iotests/177                             |   2 -
 tests/qemu-iotests/178                             |   2 -
 tests/qemu-iotests/179                             |   2 -
 tests/qemu-iotests/181                             |   2 -
 tests/qemu-iotests/182                             |   2 -
 tests/qemu-iotests/184                             |   2 -
 tests/qemu-iotests/185                             |   2 -
 tests/qemu-iotests/186                             |   2 -
 tests/qemu-iotests/187                             |   2 -
 tests/qemu-iotests/188                             |   2 -
 tests/qemu-iotests/189                             |   2 -
 tests/qemu-iotests/190                             |   2 -
 tests/qemu-iotests/191                             |   2 -
 tests/qemu-iotests/192                             |   2 -
 tests/qemu-iotests/195                             |   2 -
 tests/qemu-iotests/197                             |   2 -
 tests/qemu-iotests/198                             |   2 -
 tests/qemu-iotests/200                             |   2 -
 tests/qemu-iotests/204                             |   2 -
 tests/qemu-iotests/225                             |   2 -
 tests/qemu-iotests/226                             |   2 -
 tests/qemu-iotests/227                             |   2 -
 tests/qemu-iotests/229                             |   2 -
 tests/qemu-iotests/231                             |   2 -
 tests/qemu-iotests/232                             |   2 -
 tests/qemu-iotests/233                             |   2 -
 tests/qemu-iotests/236                             |   1 -
 tests/qemu-iotests/239                             |   2 -
 tests/qemu-iotests/243                             |   2 -
 tests/qemu-iotests/244                             |   2 -
 tests/qemu-iotests/246                             |   1 -
 tests/qemu-iotests/247                             |   2 -
 tests/qemu-iotests/249                             |   2 -
 tests/qemu-iotests/250                             |   2 -
 tests/qemu-iotests/251                             |   2 -
 tests/qemu-iotests/252                             |   2 -
 tests/qemu-iotests/256                             |   1 -
 tests/qemu-iotests/257                             |   1 -
 tests/qemu-iotests/259                             |   2 -
 tests/qemu-iotests/261                             |   2 -
 tests/qemu-iotests/263                             |   2 -
 tests/qemu-iotests/267                             |   2 -
 tests/qemu-iotests/268                             |   2 -
 tests/qemu-iotests/271                             |   2 -
 tests/qemu-iotests/284                             |   2 -
 tests/qemu-iotests/287                             |   2 -
 tests/qemu-iotests/288                             |   2 -
 tests/qemu-iotests/290                             |   2 -
 tests/qemu-iotests/292                             |   2 -
 tests/qemu-iotests/293                             |   2 -
 tests/qemu-iotests/294                             |   2 -
 tests/qemu-iotests/302                             |   1 -
 tests/qemu-iotests/304                             |   1 -
 tests/qemu-iotests/305                             |   2 -
 tests/qemu-iotests/312                             |   2 -
 tests/qemu-iotests/313                             |   2 -
 tests/qemu-iotests/314                             |   2 -
 tests/qemu-iotests/tests/commit-zero-blocks        |   2 -
 .../tests/detect-zeroes-registered-buf             |   2 -
 tests/qemu-iotests/tests/inactive-node-nbd         |  16 +++
 tests/qemu-iotests/tests/inactive-node-nbd.out     |   8 ++
 tests/qemu-iotests/tests/iothreads-resize          |   2 -
 tests/qemu-iotests/tests/nbd-in-qcow2-chain        |   2 -
 tests/qemu-iotests/tests/nbd-tls-iothread          |   2 -
 tests/qemu-iotests/tests/parallels-checks          |   2 -
 tests/qemu-iotests/tests/qcow2-encryption          |   2 -
 tests/qemu-iotests/tests/qcow2-internal-snapshots  |   2 -
 tests/qemu-iotests/tests/qemu-img-close-errors     |   2 -
 tests/qemu-iotests/tests/qsd-jobs                  |   2 -
 tests/qemu-iotests/tests/regression-vhdx-log       |   2 -
 224 files changed, 357 insertions(+), 522 deletions(-)


