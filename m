Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1CBCCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuN1-0006Hp-Ai; Mon, 19 Jan 2026 13:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMt-00067Z-6x
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:51 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMo-0005qF-Kt
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 61F1D804AA;
 Mon, 19 Jan 2026 21:52:41 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-KQ6HFLGV; Mon, 19 Jan 2026 21:52:40 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848760;
 bh=8sBVX4BbnuTheNjAsAvdtk4my30psEqfh9wtRMqbnuQ=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=1Mv8+PzLf2HgK00cMFisRLGU+1zAvIchZniKNdBGro9UG0+9sPgi00yuXA8qL0XFk
 mRmB5INbrgp3yEzU2X73NSyLEdEeU559/vjayi7o+RLS2lxVJw8t+OzUVomxDsMCCp
 0L4LOsuAp9smJNVDV9azdYKuVF9IqzD4GU3OLs8Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v4 00/23] vhost refactoring and fixes
Date: Mon, 19 Jan 2026 21:52:04 +0300
Message-ID: <20260119185228.203296-1-vsementsov@yandex-team.ru>
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

Hi all. That's a preparation for vhost-user-blk backend-transfer
feature.

v4: rebase on master, and follow Michael's comments:
04: cover one more (new) dev->protocol-features access, keep r-bs
06: add r-b by Daniil
07: new
08: support virtio-ccw, drop r-b
11: rebase on changed code in master, drop r-bs
15: rebase on changed code in master, drop r-bs
16: rebase on changed code in master, drop r-bs
21: add macro VHOST_USER_CASE, drop r-bs
23: s/virtque/virtqueue/, keep r-bs

I also have dropped
 [PATCH v3 18/23] vhost: introduce check_memslots() helper
as it was doubtful, and I'm not sure now, do I really need
it, and should it be done this way. Will look, when reworking
actual vhost-user-blk backend-transfer series on top of this.

And can't keep t-b of v3, I think.

Vladimir Sementsov-Ogievskiy (23):
  vhost-user: rework enabling vrings
  vhost: drop backend_features field
  vhost-user: introduce vhost_user_has_protocol_feature() helper
  vhost: move protocol_features to vhost_user
  vhost-user-gpu: drop code duplication
  vhost: make vhost_dev.features private
  virtio-ccw: virtio_ccw_set_guest_notifier(): fix failure path
  virtio: move common part of _set_guest_notifier to generic code
  virtio: drop *_set_guest_notifier_fd_handler() helpers
  vhost-user: keep QIOChannelSocket for backend channel
  vhost: vhost_virtqueue_start(): fix failure path
  vhost: make vhost_memory_unmap() null-safe
  vhost: simplify calls to vhost_memory_unmap()
  vhost: move vrings mapping to the top of vhost_virtqueue_start()
  vhost: vhost_virtqueue_start(): drop extra local variables
  vhost: final refactoring of vhost vrings map/unmap
  vhost: simplify vhost_dev_init() error-path
  vhost: move busyloop timeout initialization to vhost_virtqueue_init()
  vhost: vhost_dev_init(): simplify features initialization
  hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
  vhost-user: make trace events more readable
  vhost-user-blk: add some useful trace-points
  vhost: add some useful trace-points

 backends/cryptodev-vhost.c     |   9 +-
 hw/block/trace-events          |  10 ++
 hw/block/vhost-user-blk.c      |  20 ++-
 hw/display/vhost-user-gpu.c    |  11 +-
 hw/net/vhost_net.c             |  35 ++---
 hw/s390x/virtio-ccw.c          |  34 ++---
 hw/scsi/vhost-scsi.c           |   1 -
 hw/scsi/vhost-user-scsi.c      |   1 -
 hw/virtio/trace-events         |  16 +-
 hw/virtio/vdpa-dev.c           |   3 +-
 hw/virtio/vhost-user-base.c    |   8 +-
 hw/virtio/vhost-user.c         | 258 ++++++++++++++++++++++-----------
 hw/virtio/vhost.c              | 238 +++++++++++++++---------------
 hw/virtio/virtio-bus.c         |  18 +--
 hw/virtio/virtio-hmp-cmds.c    |   2 -
 hw/virtio/virtio-mmio.c        |  41 +-----
 hw/virtio/virtio-pci.c         |  34 +----
 hw/virtio/virtio-qmp.c         |  12 +-
 hw/virtio/virtio.c             |  48 +++---
 include/hw/virtio/vhost-user.h |   3 +
 include/hw/virtio/vhost.h      |  63 +++++---
 include/hw/virtio/virtio-pci.h |   3 -
 include/hw/virtio/virtio.h     |  16 +-
 net/vhost-vdpa.c               |   7 +-
 qapi/virtio.json               |   3 -
 25 files changed, 487 insertions(+), 407 deletions(-)

-- 
2.52.0


