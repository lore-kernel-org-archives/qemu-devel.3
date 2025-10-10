Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B5D6CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7H6P-000866-49; Fri, 10 Oct 2025 13:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6J-0007zP-7a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:19 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7H6A-0007G6-OJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:40:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9297:0:640:61e7:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 662F28079B;
 Fri, 10 Oct 2025 20:40:01 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a89::1:23])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xdPFQ30FtmI0-3fSRAnYg; Fri, 10 Oct 2025 20:40:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760118000;
 bh=jjr/g+Hsy5QyLPl8ZnWI0LTitXu9UML1fbj7BgSi2Ss=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=U0af6G1kFFRdmzKCCn13k4B4LXAcL7juLV2+ItbbvraQ94Q5GqJsnw2batm33EugP
 qlZyLQ5TA3K8C7i20p8rnJyW+WZ73NsilJZND3iVO/Z5b2S0pE/wm5ClGnySLprHkW
 Z504OZdQeOxS68x+Ma8nBc8YVUL1nskapOdRBVdk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v7 00/19] virtio-net: live-TAP local migration
Date: Fri, 10 Oct 2025 20:39:38 +0300
Message-ID: <20251010173957.166759-1-vsementsov@yandex-team.ru>
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

v7:

01-13,18: r-b by Maxim Davydov
          t-b by Lei Yang

05: fix tap->script to tap->downscript
07: tiny rebase conflict around "NetOffloadsd ol = {}"

14: reworked to vmsd handler
    tap is migrated inside virtio-net. And we support backend-transfer
    only for virtio-net+tap. So, it's better to support initialization
    postponing directly in virtio-net, the code is simplified, and we
    don't have to manage global list of taps.

15: reworked on top of 14

16: - drop QAPI_LIST_CONTAINS macro
    - improve commit message
    - improve QAPI documentation comments

17: - don't add extra check into virtio_net_update_host_features(),
      as we now can call it only when needed (more explicit logic)
    - drop extra includes
    - no need in "attached_to_virtio_net" variable anymore
    - add .has_tunnel to the state

19: add also test-cases for TAP migration without backend-transfer
    (to be sure, that we don't break it with new feature:)

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
  migration: introduce .pre_incoming() vmsd handler
  net/tap: postpone tap setup to pre-incoming
  qapi: add interface for backend-transfer virtio-net/tap migration
  virtio-net: support backend-transfer migration for virtio-net/tap
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_x86_64_tap_migration

 hw/net/virtio-net.c                           | 150 ++++++-
 include/migration/vmstate.h                   |   1 +
 include/net/tap.h                             |   5 +
 migration/migration.c                         |   4 +
 migration/options.c                           |  33 ++
 migration/options.h                           |   2 +
 migration/savevm.c                            |  15 +
 migration/savevm.h                            |   1 +
 net/tap-bsd.c                                 |   3 +-
 net/tap-linux.c                               |  19 +-
 net/tap-solaris.c                             |   3 +-
 net/tap-stub.c                                |   3 +-
 net/tap-win32.c                               |  11 +
 net/tap.c                                     | 425 +++++++++++++-----
 net/tap_int.h                                 |   3 +-
 qapi/migration.json                           |  42 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/test_x86_64_tap_migration.py | 396 ++++++++++++++++
 18 files changed, 1001 insertions(+), 131 deletions(-)
 create mode 100644 tests/functional/test_x86_64_tap_migration.py

-- 
2.48.1


