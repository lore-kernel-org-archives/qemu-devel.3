Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47ECCD13CF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIvzA-0006an-27; Tue, 11 Nov 2025 16:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvz7-0006Yz-Nm
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvz5-0001nv-FS
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i+oXSFl4vjiaSM0BKvMVlZugB8Noir6B4IEuokBMK+g=;
 b=KKGR2IOxvgjo0StyzpMT8lMaR0OYKkvIyzH3RhMa8sgiWHLGn/Of2lw9SaQqn+cvwcU/np
 DfVcFv60YlRJCywSt3WoZSDuP8Rb37pAaQjS3NSdxosA/RUkHNr1SzJF1/38A+idN+zlT2
 4Xz959CJVSg/yORVEN8Pd3CLq3qXPTg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-ad8MWjwzOHSkoOH1NlA9tg-1; Tue,
 11 Nov 2025 16:33:00 -0500
X-MC-Unique: ad8MWjwzOHSkoOH1NlA9tg-1
X-Mimecast-MFC-AGG-ID: ad8MWjwzOHSkoOH1NlA9tg_1762896779
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A0E31956094; Tue, 11 Nov 2025 21:32:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BAFF830044E0; Tue, 11 Nov 2025 21:32:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/28] Block layer patches
Date: Tue, 11 Nov 2025 22:32:10 +0100
Message-ID: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 593aee5df98b4a862ff8841a57ea3dbf22131a5f:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-11-10 16:49:59 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 909852ba6b4a22fd2b6f9d8b88adb5fc47dfa781:

  qemu-img rebase: don't exceed IO_BUF_SIZE in one operation (2025-11-11 22:06:09 +0100)

----------------------------------------------------------------
Block layer patches

- stream: Fix potential crash during job completion
- aio: add the aio_add_sqe() io_uring API
- qcow2: put discards in discard queue when discard-no-unref is enabled
- qcow2, vmdk: Restrict creation with secondary file using protocol
- qemu-img rebase: Fix assertion failure due to exceeding IO_BUF_SIZE
- iotests: Run iotests with sanitizers
- iotests: Add more image formats to the thorough testing
- iotests: Improve the dry run list to speed up thorough testing
- Code cleanup

----------------------------------------------------------------
Akihiko Odaki (2):
      qemu-img: Fix amend option parse error handling
      iotests: Run iotests with sanitizers

Alberto Garcia (1):
      qemu-img rebase: don't exceed IO_BUF_SIZE in one operation

Eric Blake (2):
      block: Allow drivers to control protocol prefix at creation
      qcow2, vmdk: Restrict creation with secondary file using protocol

Jean-Louis Dupond (2):
      qcow2: rename update_refcount_discard to queue_discard
      qcow2: put discards in discard queue when discard-no-unref is enabled

Kevin Wolf (1):
      iotests: Test resizing file node under raw with size/offset

Stefan Hajnoczi (15):
      aio-posix: fix race between io_uring CQE and AioHandler deletion
      aio-posix: fix fdmon-io_uring.c timeout stack variable lifetime
      aio-posix: fix spurious return from ->wait() due to signals
      aio-posix: keep polling enabled with fdmon-io_uring.c
      tests/unit: skip test-nested-aio-poll with io_uring
      aio-posix: integrate fdmon into glib event loop
      aio: remove aio_context_use_g_source()
      aio: free AioContext when aio_context_new() fails
      aio: add errp argument to aio_context_setup()
      aio-posix: gracefully handle io_uring_queue_init() failure
      aio-posix: unindent fdmon_io_uring_destroy()
      aio-posix: add fdmon_ops->dispatch()
      aio-posix: add aio_add_sqe() API for user-defined io_uring requests
      block/io_uring: use aio_add_sqe()
      block/io_uring: use non-vectored read/write when possible

Thomas Huth (3):
      tests/qemu-iotests/184: Fix skip message for qemu-img without throttle
      tests/qemu-iotests: Improve the dry run list to speed up thorough testing
      tests/qemu-iotest: Add more image formats to the thorough testing

Wesley Hershberger (1):
      block: Drop detach_subchain for bdrv_replace_node

Yeqi Fu (1):
      block: replace TABs with space

 block/qcow2.h                                 |   4 +
 include/block/aio.h                           | 156 +++++++-
 include/block/block-global-state.h            |   3 +-
 include/block/nbd.h                           |   2 +-
 include/block/raw-aio.h                       |   5 -
 util/aio-posix.h                              |  18 +-
 block.c                                       |  42 +--
 block/bochs.c                                 |  14 +-
 block/crypto.c                                |   2 +-
 block/file-posix.c                            |  98 +++--
 block/file-win32.c                            |  38 +-
 block/io_uring.c                              | 505 +++++++-------------------
 block/parallels.c                             |   2 +-
 block/qcow.c                                  |  12 +-
 block/qcow2-cluster.c                         |  16 +-
 block/qcow2-refcount.c                        |  25 +-
 block/qcow2.c                                 |   4 +-
 block/qed.c                                   |   2 +-
 block/raw-format.c                            |   2 +-
 block/vdi.c                                   |   2 +-
 block/vhdx.c                                  |   2 +-
 block/vmdk.c                                  |   2 +-
 block/vpc.c                                   |   2 +-
 qemu-img.c                                    |   4 +-
 stubs/io_uring.c                              |  32 --
 tests/unit/test-aio.c                         |   7 +-
 tests/unit/test-nested-aio-poll.c             |  13 +-
 util/aio-posix.c                              | 137 ++++---
 util/aio-win32.c                              |   7 +-
 util/async.c                                  |  74 ++--
 util/fdmon-epoll.c                            |  34 +-
 util/fdmon-io_uring.c                         | 249 ++++++++++---
 util/fdmon-poll.c                             |  85 ++++-
 tests/qemu-iotests/testrunner.py              |  12 +
 block/trace-events                            |  12 +-
 meson.build                                   |   2 +
 stubs/meson.build                             |   3 -
 tests/qemu-iotests/024                        |  46 +++
 tests/qemu-iotests/024.out                    |  26 ++
 tests/qemu-iotests/184                        |   2 +-
 tests/qemu-iotests/257                        |   8 +-
 tests/qemu-iotests/257.out                    |  14 +-
 tests/qemu-iotests/check                      |  42 ++-
 tests/qemu-iotests/meson.build                |  11 +-
 tests/qemu-iotests/tests/resize-below-raw     |  53 ++-
 tests/qemu-iotests/tests/resize-below-raw.out |   4 +-
 util/trace-events                             |   4 +
 47 files changed, 1037 insertions(+), 802 deletions(-)
 delete mode 100644 stubs/io_uring.c


