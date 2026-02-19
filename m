Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32378E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 11:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt2dN-0004Pp-2X; Thu, 19 Feb 2026 06:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt2dD-0004Ne-4E
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:55:43 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt2d8-0006Bb-84
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 06:55:42 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0D66780767;
 Thu, 19 Feb 2026 14:55:34 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VtZwpM4A6uQ0-ZUjJDPcM; Thu, 19 Feb 2026 14:55:33 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771502133;
 bh=pgiPm8c9aGbZjGQdmRm9kWER5Sk/17AC4zn2nbM8Ukw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=0c7zaEhKkNaHPI8nlcrQfLUy335s3pi7L/bnBLmNZN10kMw9uaQozzoC78cfB5aSt
 qEbHHMF2POUw4exy8PBc2J2s3gx7Kx/R588oF0uEy12g1gswUl7EVf80FDszLLabU4
 HHrswIU02gj4/hTERpxAHXPQdA4IP+PzXS5GuN/8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: thuth@redhat.com, armbru@redhat.com, eblake@redhat.com, farosas@suse.de,
 peterx@redhat.com, zhao1.liu@intel.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: [PATCH v11 0/8] virtio-net: live-TAP local migration
Date: Thu, 19 Feb 2026 14:55:21 +0300
Message-ID: <20260219115530.2019498-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Hi all!

Here is a new migration parameter "local", which allows to
enable local migration of TAP virtio-net backend (and maybe other
devices and backends in future), including its properties and open
fds.

With this new option, management software doesn't need to initialize
new TAP and do a switch to it. Nothing should be done around
virtio-net in local migration: it just migrates and continues to use
same TAP device. So we avoid extra logic in management software, extra
allocations in kernel (for new TAP), and corresponding extra delay in
migration downtime.

v11: rebranding "backend-transfer" -> "local"
06: require script=no and downscript=no
    instead of requiring absent options,
    for future compatibility


Vladimir Sementsov-Ogievskiy (8):
  net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
  net/tap: move vhost initialization to tap_setup_vhost()
  qapi: add local migration parameter
  net: introduce vmstate_net_peer_backend
  virtio-net: support local migration of backend
  net/tap: support local migration with virtio-net
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_tap_migration

 hw/core/machine.c                             |   1 +
 hw/net/virtio-net.c                           | 137 +++++-
 include/hw/virtio/virtio-net.h                |   2 +
 include/migration/misc.h                      |   2 +
 include/net/net.h                             |   6 +
 migration/options.c                           |  18 +-
 net/net.c                                     |  47 ++
 net/tap.c                                     | 189 +++++++--
 qapi/migration.json                           |  14 +-
 qapi/net.json                                 |   6 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 401 ++++++++++++++++++
 13 files changed, 795 insertions(+), 45 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.52.0


