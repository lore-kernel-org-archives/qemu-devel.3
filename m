Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F4ECA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnfz-0005CM-NB; Wed, 03 Sep 2025 09:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfs-000581-Um
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:21 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfp-0004tG-Or
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 46FE3C0189;
 Wed, 03 Sep 2025 16:37:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BbgRSa3GomI0-KpmcKA5H; Wed, 03 Sep 2025 16:37:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756906632;
 bh=yPoVxfVIAnrRjM8aQPwPNKozvWBLFCJz4WUDmbQcXOw=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=USjftcpMieqHDI1L/HhVg0e5oaY/6ZgpTTCBOjN8cuAxl5EEObKHnuyGyXgx9MdEe
 BjofEpjt/TEvhMBPCyhc9qoEvfMJscQlE9ayiF+/o03NgjiWDWF/ui/EBvPT6/dvIu
 dJ1mU3bQNdAau/HZlTUrSBNMoyY8SQ+jcOJPo8f4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v2 0/8] virtio-net: live-TAP local migration
Date: Wed,  3 Sep 2025 16:36:57 +0300
Message-ID: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Based on [PATCH v3 00/19] TAP initialization refactoring, or in other
words:
Based-on: <20250903124934.1169899-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (8):
  net/tap: add some trace points
  net/tap: keep exit notifier only when downscript set
  net/tap: refactor net_tap_setup_vhost()
  qapi: add interface for local TAP migration
  net/tap: implement interfaces for local migration
  virtio-net: support local tap migration
  test/functional: exec_command_and_wait_for_pattern: add vm arg
  tests/functional: add test_x86_64_tap_fd_migration

 hw/net/virtio-net.c                           | 100 ++++-
 include/hw/virtio/virtio-net.h                |   2 +
 include/net/tap.h                             |   4 +
 migration/options.c                           |   7 +
 migration/options.h                           |   1 +
 net/tap.c                                     | 323 ++++++++++++----
 net/trace-events                              |   7 +
 qapi/migration.json                           |   9 +-
 qapi/net.json                                 |  12 +-
 tests/functional/qemu_test/cmd.py             |   7 +-
 .../test_x86_64_tap_fd_migration.py           | 347 ++++++++++++++++++
 11 files changed, 734 insertions(+), 85 deletions(-)
 create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py

-- 
2.48.1


