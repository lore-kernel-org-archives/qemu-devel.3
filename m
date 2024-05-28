Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B50FC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 13:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxLF-0006Ur-8F; Tue, 28 May 2024 09:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sBxLB-0006TQ-9I; Tue, 28 May 2024 09:58:13 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sBxL8-0005Ae-HO; Tue, 28 May 2024 09:58:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5d80:0:640:e743:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6BE8F60C93;
 Tue, 28 May 2024 16:58:04 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6512::1:33])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id nvQj710IWSw0-S8OgP19p; Tue, 28 May 2024 16:58:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1716904683;
 bh=erzaPRKJJUwZ1J/O5yLRbGI+DB7cXT9BO2OL2oWPrTI=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=ynp0NucL6OTJ500xaKmo8tGArTNP+Hr4UOvG4+e7Y7foCnh40lDistm+pkv4af37h
 aNkJbsNWFAYnlF3NsCXgLxaQuJ+hcLp8VQtlNX5LKnQPF34tjyqMDpiLjJ+mXDfVbU
 7jdBYSv0n03384TrWaTIPjO+SZuqOSzx5cncjQIE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PULL v2 0/7] Block jobs patches for 2024-04-29
Date: Tue, 28 May 2024 16:57:46 +0300
Message-Id: <20240528135747.2476904-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit ad10b4badc1dd5b28305f9b9f1168cf0aa3ae946:

  Merge tag 'pull-error-2024-05-27' of https://repo.or.cz/qemu/armbru into staging (2024-05-27 06:40:42 -0700)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2024-04-29-v2

for you to fetch changes up to a149401048481247bcbaf6035a7a1308974fb464:

  iotests/pylintrc: allow up to 10 similar lines (2024-05-28 15:52:15 +0300)

----------------------------------------------------------------
Block jobs patches for 2024-04-29

v2: add "iotests/pylintrc: allow up to 10 similar lines" to fix
    check-python-minreqs

- backup: discard-source parameter
- blockcommit: Reopen base image as RO after abort

----------------------------------------------------------------
Alexander Ivanov (1):
      blockcommit: Reopen base image as RO after abort

Vladimir Sementsov-Ogievskiy (6):
      block/copy-before-write: fix permission
      block/copy-before-write: support unligned snapshot-discard
      block/copy-before-write: create block_copy bitmap in filter node
      qapi: blockdev-backup: add discard-source parameter
      iotests: add backup-discard-source
      iotests/pylintrc: allow up to 10 similar lines

 block/backup.c                                     |   5 +-
 block/block-copy.c                                 |  12 ++-
 block/copy-before-write.c                          |  39 +++++++--
 block/copy-before-write.h                          |   1 +
 block/mirror.c                                     |  11 ++-
 block/replication.c                                |   4 +-
 blockdev.c                                         |   2 +-
 include/block/block-common.h                       |   2 +
 include/block/block-copy.h                         |   2 +
 include/block/block_int-global-state.h             |   2 +-
 qapi/block-core.json                               |   4 +
 tests/qemu-iotests/257.out                         | 112 +++++++++++++-------------
 tests/qemu-iotests/pylintrc                        |   2 +-
 tests/qemu-iotests/tests/backup-discard-source     | 152 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/tests/backup-discard-source.out |   5 ++
 15 files changed, 282 insertions(+), 73 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out


Alexander Ivanov (1):
  blockcommit: Reopen base image as RO after abort

Vladimir Sementsov-Ogievskiy (6):
  block/copy-before-write: fix permission
  block/copy-before-write: support unligned snapshot-discard
  block/copy-before-write: create block_copy bitmap in filter node
  qapi: blockdev-backup: add discard-source parameter
  iotests: add backup-discard-source
  iotests/pylintrc: allow up to 10 similar lines

 block/backup.c                                |   5 +-
 block/block-copy.c                            |  12 +-
 block/copy-before-write.c                     |  39 ++++-
 block/copy-before-write.h                     |   1 +
 block/mirror.c                                |  11 +-
 block/replication.c                           |   4 +-
 blockdev.c                                    |   2 +-
 include/block/block-common.h                  |   2 +
 include/block/block-copy.h                    |   2 +
 include/block/block_int-global-state.h        |   2 +-
 qapi/block-core.json                          |   4 +
 tests/qemu-iotests/257.out                    | 112 ++++++-------
 tests/qemu-iotests/pylintrc                   |   2 +-
 .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 15 files changed, 282 insertions(+), 73 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

-- 
2.34.1


