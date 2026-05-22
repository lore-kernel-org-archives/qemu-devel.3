Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22E6CD5BB1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOdX-0001mf-AT; Fri, 22 May 2026 08:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdP-0001jT-M1
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdL-0000M2-QG
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:47 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 8EBDC80758;
 Fri, 22 May 2026 15:05:37 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Z5T7aO0g14Y0-BEjslNEQ; Fri, 22 May 2026 15:05:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779451537;
 bh=eCA5IvpjoTj/hBH52GGNM1G+YPXBh3mcxHCKH2heXvk=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=rptB+yBZ3MzibCi3n+9GxN4VfNjceKFz8aFD5ZCpP0IB7ybRsmqrpAIg2L+12DaOl
 hTeB82NnGKVCThEA1wzbxfZq9D1W1aS6edNHlAm89XjvEqpTbMTu1uwKHShhxhoEdG
 MCna/ktPnzHG4ICVgJyW+XU1YjNGgpRHhcPBB9VM=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru
Subject: [PATCH v16 0/8] virtio-net: live-TAP local migration
Date: Fri, 22 May 2026 15:05:25 +0300
Message-ID: <20260522120534.77653-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v16: rebase on master (on top of "[PATCH v4 00/13] net: refactoring and fixes"),
01-08: add r-b by Ben
06: add a-b by Markus
07: small fix, exclude vnet_hdr= and ifname= arguments when
    incoming-fds is set (they are not allowed actually, and
    netdev_add fails), keep r-b by Ben.

Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
    "[PATCH v4 00/13] net: refactoring and fixes"

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
 hw/i386/pc_q35.c                              |   1 +
 hw/net/virtio-net.c                           | 137 +++++-
 include/hw/virtio/virtio-net.h                |   2 +
 include/migration/misc.h                      |   2 +
 include/net/net.h                             |   6 +
 migration/options.c                           |  18 +-
 net/net.c                                     |  47 ++
 net/tap.c                                     | 246 ++++++++--
 qapi/migration.json                           |  12 +-
 qapi/net.json                                 |  10 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 458 ++++++++++++++++++
 14 files changed, 906 insertions(+), 51 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.52.0


