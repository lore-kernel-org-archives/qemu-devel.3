Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39820C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 17:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH5Qn-0008Vv-M4; Tue, 11 Jun 2024 13:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Ql-0008UW-Cc
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sH5Qj-0008RY-MW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 13:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718127428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bN3/Ft7mIfVvkp85+OB5qSx2iA4eQDvCxKe5CnKDVBc=;
 b=cMF6m1+6fSgxH6F/ngL43DMu/AO7q8a7UY835rRRgEtrLjhNc+JNlU57ptPAgqVFYi1+rG
 rdBiN9cZnT5tKAkyRJM+pBWsEbwv/Gx/1Vn67aSf0IFH//X/dqlOFHXX6e+RuHQ7mXvN77
 A6tjJlikg6snUansRq9GZ5CSX2ztthU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-Qhq-WawbPKa9rFhpmYXFbg-1; Tue,
 11 Jun 2024 13:37:04 -0400
X-MC-Unique: Qhq-WawbPKa9rFhpmYXFbg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71C0019560BB; Tue, 11 Jun 2024 17:37:03 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.130])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A43719560AB; Tue, 11 Jun 2024 17:37:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/8] Block layer patches
Date: Tue, 11 Jun 2024 19:36:50 +0200
Message-ID: <20240611173658.231831-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:

  Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 3ab0f063e58ed9224237d69c4211ca83335164c4:

  crypto/block: drop qcrypto_block_open() n_threads argument (2024-06-10 11:05:43 +0200)

----------------------------------------------------------------
Block layer patches

- crypto: Fix crash when used with multiqueue devices
- linux-aio: add IO_CMD_FDSYNC command support
- copy-before-write: Avoid integer overflows for timeout > 4s
- Fix crash with QMP block_resize and iothreads
- qemu-io: add cvtnum() error handling for zone commands
- Code cleanup

----------------------------------------------------------------
Denis V. Lunev via (1):
      block: drop force_dup parameter of raw_reconfigure_getfd()

Fiona Ebner (1):
      block/copy-before-write: use uint64_t for timeout in nanoseconds

Prasad J Pandit (1):
      linux-aio: add IO_CMD_FDSYNC command support

Stefan Hajnoczi (5):
      Revert "monitor: use aio_co_reschedule_self()"
      aio: warn about iohandler_ctx special casing
      qemu-io: add cvtnum() error handling for zone commands
      block/crypto: create ciphers on demand
      crypto/block: drop qcrypto_block_open() n_threads argument

 crypto/blockpriv.h             |  13 +++--
 include/block/aio.h            |   6 +++
 include/block/raw-aio.h        |   1 +
 include/crypto/block.h         |   2 -
 block/copy-before-write.c      |   2 +-
 block/crypto.c                 |   1 -
 block/file-posix.c             |  17 ++++--
 block/linux-aio.c              |  21 +++++++-
 block/qcow.c                   |   2 +-
 block/qcow2.c                  |   5 +-
 crypto/block-luks.c            |   4 +-
 crypto/block-qcow.c            |   8 ++-
 crypto/block.c                 | 114 ++++++++++++++++++++++++-----------------
 qapi/qmp-dispatch.c            |   7 ++-
 qemu-io-cmds.c                 |  48 ++++++++++++++++-
 tests/unit/test-crypto-block.c |   4 --
 16 files changed, 176 insertions(+), 79 deletions(-)


