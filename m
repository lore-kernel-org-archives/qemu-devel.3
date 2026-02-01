Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0759E6529E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 16:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmaBO-0001A7-Ap; Sun, 01 Feb 2026 11:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmaBL-00019R-Fq
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 11:20:15 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmaBI-0005XE-Go
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 11:20:15 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C1299807BA;
 Sun, 01 Feb 2026 19:20:07 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:765::1:3b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4Kp2C46Aq8c0-OCOkfOSe; Sun, 01 Feb 2026 19:20:05 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769962805;
 bh=gOApMt0ao51SCjGtaGgLfykJeGe4viRGJu22sKRZEb4=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=jIWAUGJyeiR8tHuM0BNMZe6p2DdC6a+NCHPdl/k2fkiefZfAxDBY+MLpu4CbE+9JN
 sueQuEhyyK109W8/vmFKPx3nB9kRcTBcvS3+IQIGQg+/0Hw3U7aZmmfgx46XdtwlBK
 06K3HCeqTTgb2OI03ZXPu7ZkxhMr+PcLo8JFCdt0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, thuth@redhat.com,
 armbru@redhat.com, eblake@redhat.com, farosas@suse.de, peterx@redhat.com,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: [PATCH v10 0/8] virtio-net: live-TAP local migration
Date: Sun,  1 Feb 2026 19:19:52 +0300
Message-ID: <20260201162001.296328-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
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

v10:

reworked interface:

1. backend-transfer migration parameter - simple boolean

2. backend-transfer option for virtio-net device - in combination with
[1] it enables the feature for concrete virtio-net device

3. incoming-fds option for TAP - to skip any open() calls and setting
up the fd, and instead wait for incoming FD.

Why we need [1]? To be able to simply choose between local and remote
migration, not touching device options.

Why we need [2]? Because otherwise we have to significantly complicate
migration paremeter (to be a list of QOM paths of devices to enable
backend-transfer for), which doesn't look good architectural design
(we don't want to end with migration parameters like

feature1 = [list of QOM paths],
feature2 = [list of QOM paths]k,
...

Why we need [3]? To avoid complicated logic of postponing the whole
initialization of TAP up to pre-incoming point (see
"[PATCH v9 0/9] net/tap: postpone connect"), and to make the whole
feature more reliable: with such a parameter user is sure, that
backend code will not do any open()/connect(), etc, which may
influence running source vm. Automatic logic of 3 stage postponing
in v9 (first, we postpone initialization up to attaching to frontend,
then, if it's a virtio-net, it take ownership and postpone initializing
of backend up to pre-incoming point (where we know migration
parameters), and finally if it's a backend-transfer, postpone it up
to post-load) can't be so reliable. Misconfiguration on target may
lead to breaking source vm. And with separate parameter, everything
becomes a lot simpler and reliable.


The series is based on
"[PATCH v2 00/12] net: refactoring and fixes"
Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (8):
  net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
  net/tap: move vhost initialization to tap_setup_vhost()
  qapi: add backend-transfer migration parameter
  net: introduce vmstate_net_peer_backend
  virtio-net: support backend-transfer migration
  net/tap: support backend-transfer migration
  tests/functional: add skipWithoutSudo() decorator
  tests/functional: add test_tap_migration

 hw/core/machine.c                             |   4 +-
 hw/net/virtio-net.c                           | 137 +++++-
 include/hw/virtio/virtio-net.h                |   2 +
 include/migration/misc.h                      |   2 +
 include/net/net.h                             |   6 +
 migration/options.c                           |  18 +-
 net/net.c                                     |  47 ++
 net/tap.c                                     | 185 ++++++--
 qapi/migration.json                           |  13 +-
 qapi/net.json                                 |   6 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 tests/functional/x86_64/meson.build           |   1 +
 tests/functional/x86_64/test_tap_migration.py | 401 ++++++++++++++++++
 13 files changed, 792 insertions(+), 46 deletions(-)
 create mode 100644 tests/functional/x86_64/test_tap_migration.py

-- 
2.52.0


