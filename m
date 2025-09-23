Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9084FCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zpv-0002fs-BN; Tue, 23 Sep 2025 06:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zps-0002f5-3U
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:24 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpm-0000ss-N4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 67203804AB;
 Tue, 23 Sep 2025 13:01:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-gym6Muaw; Tue, 23 Sep 2025 13:01:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621672;
 bh=F4nP/ZVkIj0RHssD6dwXmgKJ+3IRdFPlhHZVk2VQOc8=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Paivz9rRUnVMOtzy+bNSERqxIusetMRpZMybQk7vdj1L4X9I06XlUE20a3Zv1wq1p
 Br4KKGLZrcq02JiWQoDzz1An5kbj8HuO1qGFRbuhYR13QsTDoHUzKCPGagC7GUsWuG
 zf64aNiO+jG0PMIjrBATkwkFGD+RaNltZama88KI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 00/19] virtio-net: live-TAP local migration
Date: Tue, 23 Sep 2025 13:00:51 +0300
Message-ID: <20250923100110.70862-1-vsementsov@yandex-team.ru>
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

Here is a new migration parameter backend-transfer, which allows to
enable local migration of TAP virtio-net backend, including its
properties and open fds.

With this new option, management software doesn't need to
initialize new TAP and do a switch to it. Nothing should be
done around virtio-net in local migration: it just migrates
and continues to use same TAP device. So we avoid extra logic
in management software, extra allocations in kernel (for new TAP),
and corresponding extra delay in migration downtime.

v6:
- rebase on master (to solve conflict with merged
  "io: deal with blocking/non-blocking fds")
- use name "backend-transfer" for the whole feature consistently
  though the whole series. (live-backend is good, but actually,
  we are already in "live-migration", so every its feature may
  have "live-" prefix, and it seems redundant)

03-04: new, making changes in 05 correct
08-09: split "net/tap: rework tap_set_sndbuf()" into two commits
15: fix windows compilation
16: move has_ = true, to _params_init
18: use shorter name

and some other cosmetic changes.

Vladimir Sementsov-Ogievskiy (19):
  net/tap: net_init_tap_one(): drop extra error propagation
  net/tap: net_init_tap_one(): move parameter checking earlier
  net/tap: rework net_tap_init()
  net/tap: pass NULL to net_init_tap_one() in cases when scripts are
    NULL
  net/tap: rework scripts handling
  net/tap: setup exit notifier only when needed
  net/tap: split net_tap_fd_init()
  net/tap: tap_set_sndbuf(): add return value
  net/tap: rework tap_set_sndbuf()
  net/tap: rework sndbuf handling
  net/tap: introduce net_tap_setup()
  net/tap: move vhost fd initialization to net_tap_new()
  net/tap: finalize net_tap_set_fd() logic
  migration: add MIG_EVENT_PRE_INCOMING
  net/tap: postpone tap setup to pre-incoming
  qapi: add interface for backend-transfer virtio-net/tap migration
  virtio-net: support backend-transfer migration for virtio-net/tap
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_x86_64_tap_migration

 hw/net/virtio-net.c                           | 138 +++++-
 include/migration/misc.h                      |   1 +
 include/net/tap.h                             |   5 +
 include/qapi/util.h                           |  17 +
 migration/migration.c                         |   8 +-
 migration/options.c                           |  27 +
 migration/options.h                           |   2 +
 net/tap-bsd.c                                 |   3 +-
 net/tap-linux.c                               |  19 +-
 net/tap-solaris.c                             |   3 +-
 net/tap-stub.c                                |   3 +-
 net/tap-win32.c                               |   5 +
 net/tap.c                                     | 467 ++++++++++++++----
 net/tap_int.h                                 |   4 +-
 qapi/migration.json                           |  47 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/test_x86_64_tap_migration.py | 344 +++++++++++++
 17 files changed, 974 insertions(+), 135 deletions(-)
 create mode 100644 tests/functional/test_x86_64_tap_migration.py

-- 
2.48.1


