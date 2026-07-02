Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D529C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDRl-0000sM-IA; Thu, 02 Jul 2026 05:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wfDRi-0000r8-LH; Thu, 02 Jul 2026 05:10:58 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wfDRa-0000h6-NC; Thu, 02 Jul 2026 05:10:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 7ED5C8076F;
 Thu, 02 Jul 2026 12:10:43 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:43d::1:15])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id NAc7BT0aDa60-yElGCSCU; Thu, 02 Jul 2026 12:10:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782983442;
 bh=cPpczhyfhg0ENT0RRZwkIGGfJXTBipzh7oKirHWYqZo=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=r41+LzU0svnBVYxMNVRfSc/3OelFYT8QwkvqGdgLRmFxyoIc/vDha+ia+Fe9Jt/qw
 iKmtW3Vxsvk6dzYz8dYVJGkQzCV5RQoe9DXEqTNnZvQynhIcGwfkgI2tsSxr/HjS0p
 a68WOSW/FF5igtjSwnOT+x+GpHgPsWvFTKJ5MQtw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, Milan Zamazal <mzamazal@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, zhenwei pi <zhenwei.pi@linux.dev>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 virtio-fs@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, qemu-block@nongnu.org,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v4 0/6] vhost-user-blk: fix compatibility with older qemu
 versions
Date: Thu,  2 Jul 2026 14:10:17 +0500
Message-Id: <20260702091023.3306378-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

v3 -> v4:
- add new protocol message GET_VRING_BASE_SKIP_DRAIN instead of parameter to GET_VRING_BASE message. This new message can be send instead of GET_VRING_BASE, allowing back-end to suspend inflight I/O immediately instead of waiting and completing them.
- rebase to newer master

v2 -> v3:
- fix complile problems
- add assert check in do_vhost_virtio_stop
- make inflight-migration property mutable

v1 -> v2:
- reorganize commits: make refactor commits first, then core semantic change
- add additional pre_save check for inflight migration possibility

---

This is a small continuation of my series about inflight migration for vhost-user-blk.

This series is designed to solve the problem of compatibility with older versions of qemu, where this feature has not yet been introduced (for example, if we want to downgrade versions due to some problems).

In the current version for vhost-user-blk, this feature is enabled using the parameter and further migration of the inflight region will depend on whether the vhost-user has accepted the new protocol feature or not. This creates an inconvenient dependency, because there is no way to disable this feature without reconnecting to the backend.
This series add new protocol message - GET_VRING_BASE_SKIP_DRAIN. This new message can be send instead of GET_VRING_BASE, allowing back-end to suspend inflight I/O immediately instead of waiting and completing them. This new message can be used only with protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT.

Thus, now user can enable or disable inflight-migration param for vhost-user-blk to maintain compatibility with older versions of QEMU by using GET_VRING_BASE_SKIP_DRAIN or GET_VRING_BASE messages.

Alexandr Moshkov (6):
  vhost-user: add skip_drain param to do_vhost_virtqueue_stop
  vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
  vhost-user: use skip_drain with GET_VRING_BASE_SKIP_DRAIN message
  vhost-user-blk: make inflight-migration prop mutable
  vhost-user-blk: move inflight_needed higher
  vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN during inflight
    migration

 backends/cryptodev-vhost.c        |  2 +-
 backends/vhost-user.c             |  2 +-
 docs/interop/vhost-user.rst       | 38 ++++++++++++++++++---------
 hw/block/vhost-user-blk.c         | 43 +++++++++++++++++++++++++------
 hw/net/vhost_net.c                |  9 ++++---
 hw/scsi/vhost-scsi-common.c       |  2 +-
 hw/virtio/vdpa-dev.c              |  2 +-
 hw/virtio/vhost-user-base.c       |  2 +-
 hw/virtio/vhost-user-fs.c         |  2 +-
 hw/virtio/vhost-user-scmi.c       |  2 +-
 hw/virtio/vhost-user.c            | 40 +++++++++++++++++++++++-----
 hw/virtio/vhost-vsock-common.c    |  2 +-
 hw/virtio/vhost.c                 | 34 +++++++++++++++++-------
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost-user.h    |  1 -
 include/hw/virtio/vhost.h         |  7 +++--
 16 files changed, 137 insertions(+), 52 deletions(-)

-- 
2.34.1


