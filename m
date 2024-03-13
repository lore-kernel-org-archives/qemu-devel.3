Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07DDC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQX7-0003kZ-Tg; Wed, 13 Mar 2024 11:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQX4-0003iu-Cw; Wed, 13 Mar 2024 11:28:43 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQWz-0002kF-Sm; Wed, 13 Mar 2024 11:28:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2a:3dc:0:640:1e66:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C5BA860FFA;
 Wed, 13 Mar 2024 18:28:30 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OSpDOX0Xl4Y0-unUOAePT; Wed, 13 Mar 2024 18:28:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710343710;
 bh=QATKThshj4hm7c8e+tFurKPyhtJsoxzdweCGcDYoTRY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=BZDRRNHZrLheLmtBCP0PJbvQNagSy42Lkmana5UNS42xnAcaAcGJAVso50su2LIrE
 D3xCc1qwqyqTGIa10Skfq42Q9pNd2C54GfWEybUJiqW+2HZY/oGPDhqje+mNQB47Hq
 gg6HhZ/F68khhwW6h36hzjfa9vi4XK6ZFIT/A42c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v4 0/5] backup: discard-source parameter
Date: Wed, 13 Mar 2024 18:28:17 +0300
Message-Id: <20240313152822.626493-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v4: add t-b by Fiona
    add r-b by Fiona to 02-05 (patch 01 still lack an r-b)
    05: fix copyrights and subject in the test
    04: since 9.0 --> since 9.1 (we missed a soft freeze for 9.0)

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
 .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 13 files changed, 272 insertions(+), 70 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

-- 
2.34.1


