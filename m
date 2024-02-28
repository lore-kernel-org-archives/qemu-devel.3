Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BE2C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 14:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfKik-0003vv-OI; Wed, 28 Feb 2024 09:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfKid-0003qU-8j; Wed, 28 Feb 2024 09:15:38 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfKiV-00025q-HR; Wed, 28 Feb 2024 09:15:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3A9C460AF0;
 Wed, 28 Feb 2024 17:15:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a522::1:14])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4FaAWa1Of0U0-VHY4YEMw; Wed, 28 Feb 2024 17:15:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709129715;
 bh=RVBSZUr0UBMECgOvHzY9fpdXf+KZyTQPkaOm5i/MKmk=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=VQ4TAc8yoZf/NYdBhZq4qhZVA5D8OmeHYNMEp8s7S31PCLkP0Nd0Yg2An7C9BquQW
 ws9XALWjWN5Kr3M4wWPTfrx23vhtAYtV31ryqDR3pW6+sWn0mgFz9bUJ/wB/ukkcoZ
 Kw8KJ1WTQJFRbtoZibXFBp0EHXEGL13IPK+CQGtA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com, den@virtuozzo.com, alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 0/5] backup: discard-source parameter
Date: Wed, 28 Feb 2024 17:14:56 +0300
Message-Id: <20240228141501.455989-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi all! The main patch is 04, please look at it for description and
diagram.

v3:
02: new patch
04: take WRITE permission only when discard_source is required

Vladimir Sementsov-Ogievskiy (5):
  block/copy-before-write: fix permission
  block/copy-before-write: support unligned snapshot-discard
  block/copy-before-write: create block_copy bitmap in filter node
  qapi: blockdev-backup: add discard-source parameter
  iotests: add backup-discard-source

 block/backup.c                                |   5 +-
 block/block-copy.c                            |  12 +-
 block/copy-before-write.c                     |  39 ++++-
 block/copy-before-write.h                     |   1 +
 block/replication.c                           |   4 +-
 blockdev.c                                    |   2 +-
 include/block/block-common.h                  |   2 +
 include/block/block-copy.h                    |   2 +
 include/block/block_int-global-state.h        |   2 +-
 qapi/block-core.json                          |   4 +
 tests/qemu-iotests/257.out                    | 112 ++++++-------
 .../qemu-iotests/tests/backup-discard-source  | 151 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 13 files changed, 271 insertions(+), 70 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

-- 
2.34.1


