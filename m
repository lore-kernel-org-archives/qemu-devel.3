Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7139FCCF2DD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 18:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhuMz-0006Et-Ac; Mon, 19 Jan 2026 13:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMt-00067V-5G
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:51 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhuMo-0005qH-Jc
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 13:52:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id D37AB8072F;
 Mon, 19 Jan 2026 21:52:42 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id dqetGa1BQGk0-PF0hALdb; Mon, 19 Jan 2026 21:52:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768848762;
 bh=2QJAlf70N0EQAeu+sY5mYIW7U8Kb/aPsvIxdva1LARw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=O7sf8SOvWtvkp8oUrvV1XXuSRzYbfBvsPtOI8m2nvZMvvAyRdZG6kipipKnRa9gg1
 FiPeV+/v68lP9YyVe7Cc77NuXjzwPukBhLdmnaSVEmKBh8t00AE8T6l5S57Gf5dJJA
 pNJETiaY7aFS30QeKvU1CkJnwrRmOXIsK9snoypc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 01/23] vhost-user: rework enabling vrings
Date: Mon, 19 Jan 2026 21:52:05 +0300
Message-ID: <20260119185228.203296-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119185228.203296-1-vsementsov@yandex-team.ru>
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
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

We call the handler almost the same way in three places:

 - cryptodev-vhost.c
 - vhost_net.c
 - vhost.c

The only difference, is that in vhost.c we don't try to call the handler
for old vhost-user (when VHOST_USER_F_PROTOCOL_FEATURES is not supported).

cryptodev-vhost and vhost_net code will just fail in this case. Probably
they were developed only for newer vhost-user. Anyway, it doesn't seem
correct to rely on this error path, if these devices want to check,
that they don't communicate to old vhost-user protocol, they should
do that earlier.

Let's create the common helper, to call .vhost_set_vring_enable and
use in all three places. For vhost-user let's just always skip
enable/disable if it's unsupported.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 backends/cryptodev-vhost.c |  8 +-------
 hw/net/vhost_net.c         |  7 +------
 hw/virtio/vhost-user.c     |  7 ++++++-
 hw/virtio/vhost.c          | 21 ---------------------
 include/hw/virtio/vhost.h  |  9 +++++++++
 5 files changed, 17 insertions(+), 35 deletions(-)

diff --git a/backends/cryptodev-vhost.c b/backends/cryptodev-vhost.c
index 943680a23a..abdfce33af 100644
--- a/backends/cryptodev-vhost.c
+++ b/backends/cryptodev-vhost.c
@@ -152,7 +152,6 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
 {
     CryptoDevBackendVhost *crypto =
                        cryptodev_get_vhost(cc, b, queue);
-    const VhostOps *vhost_ops;
 
     cc->vring_enable = enable;
 
@@ -160,12 +159,7 @@ vhost_set_vring_enable(CryptoDevBackendClient *cc,
         return 0;
     }
 
-    vhost_ops = crypto->dev.vhost_ops;
-    if (vhost_ops->vhost_set_vring_enable) {
-        return vhost_ops->vhost_set_vring_enable(&crypto->dev, enable);
-    }
-
-    return 0;
+    return vhost_dev_set_vring_enable(&crypto->dev, enable);
 }
 
 int cryptodev_vhost_start(VirtIODevice *dev, int total_queues)
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index a8ee18a912..25e9f1fd24 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -587,7 +587,6 @@ VHostNetState *get_vhost_net(NetClientState *nc)
 int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 {
     VHostNetState *net = get_vhost_net(nc);
-    const VhostOps *vhost_ops = net->dev.vhost_ops;
 
     /*
      * vhost-vdpa network devices need to enable dataplane virtqueues after
@@ -601,11 +600,7 @@ int vhost_net_set_vring_enable(NetClientState *nc, int enable)
 
     nc->vring_enable = enable;
 
-    if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
-        return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
-    }
-
-    return 0;
+    return vhost_dev_set_vring_enable(&net->dev, enable);
 }
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 63fa9a1b4b..7615ae2a9b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1235,7 +1235,12 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
     int i;
 
     if (!virtio_has_feature(dev->features, VHOST_USER_F_PROTOCOL_FEATURES)) {
-        return -EINVAL;
+        /*
+         * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
+         * been negotiated, the rings start directly in the enabled state,
+         * and can't be disabled.
+         */
+        return 0;
     }
 
     for (i = 0; i < dev->nvqs; ++i) {
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 31e9704cdc..29f2c75f1e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2022,27 +2022,6 @@ int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
     return 0;
 }
 
-static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
-{
-    if (!hdev->vhost_ops->vhost_set_vring_enable) {
-        return 0;
-    }
-
-    /*
-     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
-     * been negotiated, the rings start directly in the enabled state, and
-     * .vhost_set_vring_enable callback will fail since
-     * VHOST_USER_SET_VRING_ENABLE is not supported.
-     */
-    if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
-        !virtio_has_feature(hdev->backend_features,
-                            VHOST_USER_F_PROTOCOL_FEATURES)) {
-        return 0;
-    }
-
-    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
-}
-
 /*
  * Host notifiers must be enabled at this point.
  *
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 08bbb4dfe9..1ee639dd7e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -215,6 +215,15 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
+{
+    if (!hdev->vhost_ops->vhost_set_vring_enable) {
+        return 0;
+    }
+
+    return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
+}
+
 /**
  * vhost_dev_start() - start the vhost device
  * @hdev: common vhost_dev structure
-- 
2.52.0


