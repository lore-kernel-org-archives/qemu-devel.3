Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECF2CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJd-0000ku-Ov; Thu, 30 Oct 2025 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJA-0000fC-LN
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:47 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIv-0005uz-Sq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 0A25280A77;
 Thu, 30 Oct 2025 23:31:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-PxA1Khza; Thu, 30 Oct 2025 23:31:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856279;
 bh=zPSvLzV5oEWLxRux3mf1ZzQRP9oUxdLezIV9FSlTOyE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=AK4S+OmTQmpIq4RlbgpRGGHTFQBDvg+uLZe4IPDEFabIkKg8wJE83cBKGc5fKMw6b
 3hEdhHqnlbI+N88SIK/ZVol16BaQkYTCTJPMMElMj00LbLXE2N/BJoWLoXLpO/xq/+
 dCAagVV3/WPtOT5G4jeC7uGxKRlw7yTowsunku5Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 0/8] virtio-net: live-TAP local migration
Date: Thu, 30 Oct 2025 23:31:07 +0300
Message-ID: <20251030203116.870742-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

Here is a new migration parameter backend-transfer, which allows to
enable local migration of TAP virtio-net backend (and maybe other
devices and backends in future), including its properties and open
fds.

With this new option, management software doesn't need to initialize
new TAP and do a switch to it. Nothing should be done around
virtio-net in local migration: it just migrates and continues to use
same TAP device. So we avoid extra logic in management software, extra
allocations in kernel (for new TAP), and corresponding extra delay in
migration downtime.

v9:
- preparation patches are moved to separate series:
1. [PATCH v9 0/7] net/tap: simple refactoring
2. [PATCH v9 0/9] net/tap: postpone connect
- new interface: list of qdev paths
- significant rework of architecture: don't mix
  backend and frontend code, instead create generic
  interfaces.

Based-on: <20251030171915.726441-1-vsementsov@yandex-team.ru>
Based-on: <20251030164023.710048-1-vsementsov@yandex-team.ru>

Also, pushed to
 https://gitlab.com/vsementsov/qemu.git tag up-tap-fd-migration-v9

Vladimir Sementsov-Ogievskiy (8):
  migration: introduce .pre_incoming() vmsd handler
  qapi: introduce query-backend-transfer-support
  qapi: add backend-transfer migration parameter
  net: introduce vmstate_net_peer_backend
  virtio-net: support backend-transfer migration
  net/tap: support backend-transfer migration
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_tap_migration

 hw/net/virtio-net.c                           | 157 ++++++-
 include/hw/qdev-core.h                        |  10 +
 include/hw/virtio/virtio-net.h                |   1 +
 include/migration/misc.h                      |   2 +
 include/migration/vmstate.h                   |   1 +
 include/net/net.h                             |   4 +
 migration/migration.c                         |   4 +
 migration/options.c                           |  31 ++
 migration/savevm.c                            |  15 +
 migration/savevm.h                            |   1 +
 net/net.c                                     |  47 +++
 net/tap.c                                     |  46 +-
 qapi/migration.json                           |  35 +-
 qapi/qdev.json                                |  26 ++
 system/qdev-monitor.c                         |  74 ++++
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 398 ++++++++++++++++++
 18 files changed, 860 insertions(+), 9 deletions(-)
 create mode 100644 tests/functional/x86_64/test_tap_migration.py

-- 
2.48.1


