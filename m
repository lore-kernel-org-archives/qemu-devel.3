Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47886EFB811
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 07:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vunCj-00041G-KQ; Tue, 24 Feb 2026 02:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vunCR-0003wk-RZ; Tue, 24 Feb 2026 02:51:21 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vunCM-0006VQ-R0; Tue, 24 Feb 2026 02:51:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1e1e:0:640:c6a6:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 20B6E80C6B;
 Tue, 24 Feb 2026 10:51:05 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:515::1:1d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uoat9O6Am8c0-MXFLhXTQ; Tue, 24 Feb 2026 10:51:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771919464;
 bh=i6hS/8iYe2gFCgfPXNEGfPg7PpWZzPYMO5TSY+voERg=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=vME65MnxKjTqAzL/Fy+742o9BEQrtkAS7zwjX8cDJtRnh2tLC0Q4N4WZ86x5tJTXE
 8Ix9j23YTERLs7pkBW7ArPe7VEBCUdXDTZ3RudFotsZqRReaPbYQ8qiAM5pEpMLfc2
 K+V7z9P8RJe9ScIp1+Gu3xGpthEIocxE2nVJhUQM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Raphael Norwitz <rnorwitz@nvidia.com>, virtio-fs@lists.linux.dev,
 Milan Zamazal <mzamazal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH 0/4] vhost-user-blk: fix compatibility with older qemu versions
Date: Tue, 24 Feb 2026 12:50:51 +0500
Message-Id: <20260224075055.863068-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

This is a small continuation of my series about inflight migration for vhost-user-blk.

This series is designed to solve the problem of compatibility with older versions of qemu, where this feature has not yet been introduced (for example, if we want to downgrade versions due to some problems).

In the current version for vhost-user-blk, this feature is enabled using the parameter and further migration of the inflight region will depend on whether the vhost-user has accepted the new protocol feature or not. This creates an inconvenient dependency, because there is no way to disable this feature without reconnecting to the backend.
This series slightly changes the semantics of the introduced protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT. Enabling this feature adds a new parameter for GET_VRING_BASE message - skip_drain, which allows to control drain in-flight requests on the backend.

Thus, user can enable or disable inflight-migration param for vhost-user-blk to maintain compatibility with older versions of QEMU.

Alexandr Moshkov (4):
  vhost-user.rst: fix typo
  vhost-user: add skip_drain param to GET_VRING_BASE
  vhost-user: remove supports_inflight_migration
  vhost-user-blk: make inflight migration throught skip_drain

 backends/cryptodev-vhost.c     |  2 +-
 backends/vhost-user.c          |  2 +-
 docs/interop/vhost-user.rst    |  5 +++--
 hw/block/vhost-user-blk.c      | 26 ++++++++++++++------------
 hw/net/vhost_net.c             |  9 +++++----
 hw/scsi/vhost-scsi-common.c    |  2 +-
 hw/virtio/vdpa-dev.c           |  2 +-
 hw/virtio/vhost-user-base.c    |  2 +-
 hw/virtio/vhost-user-fs.c      |  2 +-
 hw/virtio/vhost-user-scmi.c    |  2 +-
 hw/virtio/vhost-user.c         |  3 +--
 hw/virtio/vhost-vsock-common.c |  2 +-
 hw/virtio/vhost.c              | 24 +++++++++++++++---------
 include/hw/virtio/vhost-user.h |  1 -
 include/hw/virtio/vhost.h      |  7 +++++--
 15 files changed, 51 insertions(+), 40 deletions(-)

-- 
2.34.1


