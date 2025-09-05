Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99254CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuWqE-0001fU-OS; Fri, 05 Sep 2025 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWqD-0001ef-6a
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:51:01 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWq2-0006Wz-Ri
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:50:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D3E0AC1088;
 Fri, 05 Sep 2025 16:50:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id foiXcl3Gh8c0-q9SldYSX; Fri, 05 Sep 2025 16:50:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757080242;
 bh=ctFlVoels+P5XIXCLxbd3tfwXD7hdEUsEgNWLvyWgZA=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=g1BTQb/iWAtib3BkJ0IsPHXx/IU4YfTgiXk1R6M83bZDwjTeUVmejBa7FtUQtfV4i
 WUIfVHtkf7eOzYSESWwKyNHAhn/3gjayxfWwBM8rWDhtle5+4oVKXec0uKFtHQ1b8s
 0M+avrmVwnb45z2nzS0zK6l/7H9mBITHvxHfdSr0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v3 0/9] virtio-net: live-TAP local migration
Date: Fri,  5 Sep 2025 16:50:30 +0300
Message-ID: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Here is a  new migration capability "local-tap", which
allows local migration of TAP device, including its properties
and open fds.

With this new option, management software doesn't need to
initialize new TAP and do a switch to it. Nothing should be
done around virtio-net in local migration: it just migrates
and continues to use same TAP device. So we avoid extra logic
in management software, extra allocations in kenel (for new TAP),
and corresponding extra delay in migration downtime.

Note that patch 07 is reused from
[PATCH 00/33] vhost-user-blk: live-backend local migration
to not create extra dependency on a big series.

v3:
- drop tap_dump_packet (actually we already have qemu_hexdump,
  which is even called in network code (under ifdef).
- rework save/load code in tap.c to VMSD
test:
  - avoid using shell
  - use sudo, and add skipUnlesPasswordlessSudo decorator
  - don't keep extra open fd for ping.log
  - use scratch file for ping.log (not hardcoded  /tmp/ping.log)

Based on [PATCH v3 00/19] TAP initialization refactoring, or in other
words:
Based-on: <20250903124934.1169899-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (9):
  net/tap: add some trace points
  net/tap: keep exit notifier only when downscript set
  net/tap: refactor net_tap_setup_vhost()
  qapi: add interface for local TAP migration
  net/tap: implement interfaces for local migration
  virtio-net: support local tap migration
  tests/functional: exec_command_and_wait_for_pattern: add vm arg
  tests/functional: add skipUnlessPasswordlessSudo() decorator
  tests/functional: add test_x86_64_tap_fd_migration

 hw/net/virtio-net.c                           | 100 ++++-
 include/hw/virtio/virtio-net.h                |   2 +
 include/net/tap.h                             |   4 +
 migration/options.c                           |   7 +
 migration/options.h                           |   1 +
 net/tap.c                                     | 279 ++++++++++----
 net/trace-events                              |   6 +
 qapi/migration.json                           |   9 +-
 qapi/net.json                                 |  12 +-
 tests/functional/qemu_test/cmd.py             |   7 +-
 tests/functional/qemu_test/decorators.py      |  16 +
 .../test_x86_64_tap_fd_migration.py           | 345 ++++++++++++++++++
 12 files changed, 703 insertions(+), 85 deletions(-)
 create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py

-- 
2.48.1


