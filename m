Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6D7CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqu-0006AD-0A; Fri, 19 Sep 2025 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqW-0005ej-Kl
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:06 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqQ-0004Yw-JE
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:03 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DB88080EC2;
 Fri, 19 Sep 2025 12:55:50 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-To8Al743; Fri, 19 Sep 2025 12:55:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275750;
 bh=W5+a2Kl2t4AD1DImDRN8stBbrtbFkVdI+xnn0fObBUk=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=hhszwWh8NDoJ7PczzbUFT5Ijr+3Y6tcDXQtmMfnGjSPLn1MJMq1rMtaNQMioqDTA5
 aEkjBVKwPugHa6IYo8EH2w474RnOF+zu7yQCJFh/C3qCtp713+KoFq1/pKLSdAlw0b
 MVD15Tb6GKyWSMOepzr/xVBGYd4WzI6pAlXTwyF0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 00/19] virtio-net: live-TAP local migration
Date: Fri, 19 Sep 2025 12:55:26 +0300
Message-ID: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Here is a  new migration parameter fds, which allows to enable the new
local migration of TAP device, including its properties
and open fds.

With this new option, management software doesn't need to
initialize new TAP and do a switch to it. Nothing should be
done around virtio-net in local migration: it just migrates
and continues to use same TAP device. So we avoid extra logic
in management software, extra allocations in kenel (for new TAP),
and corresponding extra delay in migration downtime.

v5:

Follows [PATCH v3 0/9] virtio-net: live-TAP local migration,
but called v5, to not conflict with

   [PATCH v4 0/8] TAP initialization refactoring

, which becomes obsolete, and with

   [PATCH v4 0/2] save qemu-file incoming non-blocking fds

(two patches simply included here, to not create extra
dependancy).

What was changed:

1. Now, based on master.

As already said patches 01-02 are from

   [PATCH v4 0/2] save qemu-file incoming non-blocking fds

(which still may be merged in separate)

Also note, that the series is in small conflict with
in-flight

   [PATCH v5 00/13] io: deal with blocking/non-blocking fds

, I'll rebase if it merged first.

2. New interface: simply one migration parameter

    fds = [ virtio-net ]

It could simply be reduced to boolean fds=true, but I think
that a possibility to specify target is good, see more in
patch 16.

The series supersedes:
[PATCH v4 0/8] TAP initialization refactoring
Supersedes: <20250911165101.1637608-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (19):
  migration/qemu-file: don't make incoming fds blocking again
  io/channel: document how qio_channel_readv_full() handles fds
  net/tap: net_init_tap_one(): drop extra error propagation
  net/tap: net_init_tap_one(): move parameter checking earlier
  net/tap: rework net_tap_init()
  net/tap: setup exit notifier only when needed
  net/tap: split net_tap_fd_init()
  net/tap: rework tap_set_sndbuf()
  net/tap: rework sndbuf handling
  net/tap: introduce net_tap_setup()
  net/tap: move vhost fd initialization to net_tap_new()
  net/tap: use net_tap_setup() in net_init_bridge()
  net/tap: finalize net_tap_set_fd() logic
  migration: add MIG_EVENT_PRE_INCOMING
  net/tap: postpone tap setup to pre-incoming
  qapi: add interface for local TAP migration
  virtio-net: support fds migration of TAP backend
  tests/functional: add skipUnlessPasswordlessSudo() decorator
  tests/functional: add test_x86_64_tap_fd_migration

 hw/net/virtio-net.c                           | 138 +++++-
 include/io/channel.h                          |  18 +
 include/migration/misc.h                      |   1 +
 include/net/tap.h                             |   5 +
 include/qapi/util.h                           |  17 +
 io/channel-socket.c                           |  13 +-
 migration/migration.c                         |   8 +-
 migration/options.c                           |  25 ++
 migration/options.h                           |   2 +
 migration/qemu-file.c                         |   3 +-
 net/tap-bsd.c                                 |   3 +-
 net/tap-linux.c                               |  19 +-
 net/tap-solaris.c                             |   3 +-
 net/tap-stub.c                                |   3 +-
 net/tap.c                                     | 422 ++++++++++++++----
 net/tap_int.h                                 |   4 +-
 qapi/migration.json                           |  46 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 .../test_x86_64_tap_fd_migration.py           | 343 ++++++++++++++
 19 files changed, 970 insertions(+), 119 deletions(-)
 create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py

-- 
2.48.1


