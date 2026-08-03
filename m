Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B80C55175
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqn78-0003Lt-4b; Mon, 03 Aug 2026 03:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wqn71-0003Jm-1c; Mon, 03 Aug 2026 03:29:27 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1wqn6v-0005x4-Lt; Mon, 03 Aug 2026 03:29:23 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 25DDD806DC;
 Mon, 03 Aug 2026 10:29:14 +0300 (MSK)
Received: from dtalexundeer-nx.yandex-team.ru (unknown
 [2a02:6bf:8080:a53::1:f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rSdSxZ08oGk0-sKfWIuR8; Mon, 03 Aug 2026 10:29:13 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785742153;
 bh=4bPvWX8Bl6sQAkGXhxfZM9mm5a/Z0JCU18UzmbNVPus=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=DXMifX0X2DmWt4LT6R3nMngUZT13Z4yR4taSr33wTu8bEHeTDcXvQfg3E+fKroQ+W
 15GGUmxWfJu3DEudKFdMlw/E0HKNli26DXufo9xRNBkx2T+eCk14iORwjFdqgGmoDY
 ikBseB8YIuoCvDBGHwDJxRfy7kawiHkmcbNxp0R4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Jason Wang <jasowangio@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Milan Zamazal <mzamazal@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>,
 virtio-fs@lists.linux.dev,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: [PATCH v6 0/6] vhost-user-blk: allow toggling inflight-migration at
 runtime
Date: Mon,  3 Aug 2026 12:28:47 +0500
Message-Id: <20260803072853.2920007-1-dtalexundeer@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
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

v5 -> v6:
- block changing inflight-migration property while VM is not running
- remove checking runstate in vhost_user_blk_stop() since it's not necessary
- updated cover letter: changed subject and description to focus on
  runtime toggling of inflight-migration rather than cross-version
  migration compatibility

v4 -> v5:
- introduce protocol feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN
  to guard the new message, instead of reusing the existing
  VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INLIFGHT. Update docs.
- improved commit messages.

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

This is v6 of the series previously sent as:
"[PATCH v5 0/6] vhost-user-blk: add compatibility with older qemu versions"

This series allows the inflight-migration property of vhost-user-blk to
be toggled at runtime via qom-set without restarting the VM or
reconnecting to the back-end.

Currently, the inflight migration behaviour is controlled by
VHOST_USER_PROTOCOL_F_GET_VRING_BASE_INFLIGHT, which is negotiated once
at connection time. Once negotiated, the back-end always uses suspend
semantics on GET_VRING_BASE -- there is no way for the front-end to
request normal drain behaviour on a per-call basis. This makes it
impossible to disable inflight-migration at runtime.

To solve this, the series introduces a new protocol message
VHOST_USER_GET_VRING_BASE_SKIP_DRAIN (id=45) guarded by a new protocol
feature VHOST_USER_PROTOCOL_F_GET_VRING_BASE_SKIP_DRAIN. The message
instructs the back-end to suspend in-flight I/O immediately rather than
draining it. This gives the front-end explicit per-call control:
GET_VRING_BASE for normal drain, GET_VRING_BASE_SKIP_DRAIN when
inflight-migration is enabled.

In vhost-user-blk, GET_VRING_BASE_SKIP_DRAIN is sent whenever
inflight-migration is on. The inflight-migration
property can only be changed while the VM is running, so its value at
stop time reliably reflects the user's intent.

Alexandr Moshkov (6):
  vhost-user: add skip_drain param to do_vhost_virtqueue_stop
  vhost-user: add GET_VRING_BASE_SKIP_DRAIN message
  vhost-user: use skip_drain with GET_VRING_BASE_SKIP_DRAIN message
  vhost-user-blk: make inflight-migration prop mutable on running vm
  vhost-user-blk: move inflight_needed higher
  vhost-user-blk: use GET_VRING_BASE_SKIP_DRAIN when inflight-migration
    is on

 backends/cryptodev-vhost.c        |  2 +-
 backends/vhost-user.c             |  2 +-
 docs/interop/vhost-user.rst       | 88 +++++++++++++++++++------------
 hw/block/vhost-user-blk.c         | 60 ++++++++++++++++++---
 hw/net/vhost_net.c                |  9 ++--
 hw/scsi/vhost-scsi-common.c       |  2 +-
 hw/virtio/vdpa-dev.c              |  2 +-
 hw/virtio/vhost-user-base.c       |  2 +-
 hw/virtio/vhost-user-fs.c         |  2 +-
 hw/virtio/vhost-user-scmi.c       |  2 +-
 hw/virtio/vhost-user.c            | 47 ++++++++++++++---
 hw/virtio/vhost-vsock-common.c    |  2 +-
 hw/virtio/vhost.c                 | 34 ++++++++----
 include/hw/virtio/vhost-backend.h |  1 +
 include/hw/virtio/vhost-user.h    |  2 +-
 include/hw/virtio/vhost.h         |  7 ++-
 16 files changed, 189 insertions(+), 75 deletions(-)

-- 
2.34.1


