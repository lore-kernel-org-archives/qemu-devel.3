Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5F7CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92xQ-0007f8-D5; Wed, 15 Oct 2025 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xO-0007eY-CK
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:26 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xH-0000a3-Cr
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id C193BC04DA;
 Wed, 15 Oct 2025 17:58:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-tfJmmqAZ; Wed, 15 Oct 2025 17:58:11 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540291;
 bh=jrQtk21mt1nUk+DmzUszLZtEs0ITLbqWzIIrKdfzsTI=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=MZnfZWntQcF6TFWb1/h8C3vCVj0ERliiO4Z0ilp+5U9fDzAcxKaCBGle2Bkwn+NfG
 F2Hj48v0GOo9iA1gI0nRwOn1wpfSqJJ5U9FJ76bRR/R4DP/Cq9BqxXQepnPRamaF5k
 cY2hQRhAtp9D3Cx5HacmNWpb3qfVaLoOu+/SpZDg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v3 00/23] vhost refactoring and fixes
Date: Wed, 15 Oct 2025 17:57:44 +0300
Message-ID: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi all. That's rebased and updated first part of
  [PATCH 00/33] vhost-user-blk: live-backend local migration

v3:
01-05,07-23: add r-b by Daniil
01,03,04,11-12,15,19,22,23: add r-b by Raphael
02: - add a-b by Markus and Raphael
    - touch-up commit message
06: carefully follow existing pattern
    of split into features / features_ex

Vladimir Sementsov-Ogievskiy (23):
  vhost-user: rework enabling vrings
  vhost: drop backend_features field
  vhost-user: introduce vhost_user_has_protocol_feature() helper
  vhost: move protocol_features to vhost_user
  vhost-user-gpu: drop code duplication
  vhost: make vhost_dev.features private
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
  vhost: introduce check_memslots() helper
  vhost: vhost_dev_init(): simplify features initialization
  hw/virtio/virtio-bus: refactor virtio_bus_set_host_notifier()
  vhost-user: make trace events more readable
  vhost-user-blk: add some useful trace-points
  vhost: add some useful trace-points

 backends/cryptodev-vhost.c     |   9 +-
 hw/block/trace-events          |  10 ++
 hw/block/vhost-user-blk.c      |  20 ++-
 hw/display/vhost-user-gpu.c    |  11 +-
 hw/net/vhost_net.c             |  35 ++--
 hw/scsi/vhost-scsi.c           |   1 -
 hw/scsi/vhost-user-scsi.c      |   1 -
 hw/virtio/trace-events         |  16 +-
 hw/virtio/vdpa-dev.c           |   3 +-
 hw/virtio/vhost-user-base.c    |   8 +-
 hw/virtio/vhost-user.c         | 285 ++++++++++++++++++++++---------
 hw/virtio/vhost.c              | 300 +++++++++++++++++----------------
 hw/virtio/virtio-bus.c         |  18 +-
 hw/virtio/virtio-hmp-cmds.c    |   2 -
 hw/virtio/virtio-mmio.c        |  41 +----
 hw/virtio/virtio-pci.c         |  34 +---
 hw/virtio/virtio-qmp.c         |  12 +-
 hw/virtio/virtio.c             |  48 +++---
 include/hw/virtio/vhost-user.h |   3 +
 include/hw/virtio/vhost.h      |  63 +++++--
 include/hw/virtio/virtio-pci.h |   3 -
 include/hw/virtio/virtio.h     |  16 +-
 net/vhost-vdpa.c               |   7 +-
 qapi/virtio.json               |   3 -
 24 files changed, 537 insertions(+), 412 deletions(-)

-- 
2.48.1


