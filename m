Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C7BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww336-0003Fk-Ap; Mon, 17 Aug 2026 15:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww331-0003E4-Df; Mon, 17 Aug 2026 15:31:03 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ww32x-00032F-Tz; Mon, 17 Aug 2026 15:31:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id D437E80B0A;
 Mon, 17 Aug 2026 22:30:54 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:d2f::1:33])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rUaw3t0XVW20-OCQLpOt1; Mon, 17 Aug 2026 22:30:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1786995054;
 bh=YLAgJrOK+0alhspiwZqYj6fUH7aYBH6x6PClb/0APEk=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=RmJiQLItCpPVqmnuhQXB6AZBDBwquqTgU/ssE2wDgbWhBbLmdXlXThzG2WzmfT8Eo
 zClnqAGdUlTf3hOhEvJEdFD3U1YxzAEfsWpd+wv9TM23Czrj6tmL1iVUq6WoYWjasy
 MwzrG++kT7HyhJVO1jfm/20rlx272O3+uLiJtagc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	den@openvz.org,
	vsementsov@yandex-team.ru
Subject: [PULL 0/6] block: jobs and dirty-bitmaps
Date: Mon, 17 Aug 2026 22:29:42 +0300
Message-ID: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some fixes and improvements around block-jobs and block dirty-bitmaps.

The following changes since commit 9696bf5dc5a5bf0b4a9d05b6cdfe5f13990f97aa:

  Merge tag 'hw-misc-20260816' of https://github.com/philmd/qemu into staging (2026-08-16 08:17:47 -0700)

are available in the Git repository at:

  https://gitlab.com/vsementsov/qemu.git tags/pull-block-jobs-2026-08-17

for you to fetch changes up to dc04053687ec7219a78f9b90fe2f71c9336914e1:

  dirty-bitmap: fix integer overflow in serialization coverage (2026-08-17 18:32:44 +0300)

----------------------------------------------------------------
block-jobs and dirty-bitmaps patches

----------------------------------------------------------------
Denis V. Lunev (6):
      job: keep job paused across overlapping pause requests
      tests/unit/test-blockjob: cover keeping a job paused while a pause is pending
      block/monitor: reject persistent bitmap add on a read-only node
      migration/block-dirty-bitmap: reject bitmap load onto ro node
      block/monitor: allow dropping a bitmap never stored on disk
      dirty-bitmap: fix integer overflow in serialization coverage

 block/dirty-bitmap.c                               |   2 +-
 block/monitor/bitmap-qmp-cmds.c                    |  19 ++--
 block/qcow2-bitmap.c                               |   9 ++
 job.c                                              |   9 +-
 migration/block-dirty-bitmap.c                     |  22 +++--
 qapi/block-core.json                               |   4 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test      |  33 +++++++
 tests/qemu-iotests/tests/migrate-bitmaps-test.out  |   4 +-
 .../qemu-iotests/tests/remove-bitmap-from-backing  |  29 +++++-
 .../tests/remove-bitmap-from-backing.out           |  22 ++++-
 tests/unit/test-blockjob.c                         | 100 +++++++++++++++++++++
 11 files changed, 233 insertions(+), 20 deletions(-)

-- 
2.43.0


