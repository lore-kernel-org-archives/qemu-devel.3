Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44ABF588F0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErM5-0005Tf-Hq; Mon, 20 Apr 2026 12:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wErM3-0005SZ-5z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:20:11 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wErM0-00038e-Q1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:20:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 5548F8062E;
 Mon, 20 Apr 2026 19:20:03 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 0KUTY10KuKo0-oloNIL0m; Mon, 20 Apr 2026 19:20:02 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776702002;
 bh=FMjvWZvh+BHyQvnKVRx3QFQvy0kSNZeIvAdDVEXy0qw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=Jo7F30i6/SLu5Tw4eotOHewOdoIXXSyE81pc9mvOy0BdIZ8zKEhqhwt0F1r1KdmZh
 AvZ5791tXvVQXVPkZboTHCGq26Ex5AGE+if8VUnfelpsfcoFV+w/XTG2fAxKwMoOqg
 yPGHS/S7013u8lgXreK4q3p0xUv/T84WBg+AMcSo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru
Subject: [PATCH v14 0/8] virtio-net: live-TAP local migration
Date: Mon, 20 Apr 2026 19:19:50 +0300
Message-ID: <20260420161958.584407-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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

v14:
03: add a-b by Markus, s/11.0/11.1/
06: s/scirpt/script/, improve doc, s/11.0/11.1/

v14 pushed as branch up-tap-fd-migration-with-bk-opt
    at https://gitlab.com/vsementsov/qemu.git

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
 tests/functional/x86_64/test_tap_migration.py | 456 ++++++++++++++++++
 13 files changed, 903 insertions(+), 51 deletions(-)
 create mode 100755 tests/functional/x86_64/test_tap_migration.py

-- 
2.52.0


