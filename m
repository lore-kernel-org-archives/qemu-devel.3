Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD8BC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJLv-0005sr-P4; Thu, 03 Jul 2025 08:47:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLg-0005Tt-PG; Thu, 03 Jul 2025 08:47:33 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uXJLc-0006ni-KU; Thu, 03 Jul 2025 08:47:32 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:4a1:0:640:2691:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4EDBA60CC7;
 Thu,  3 Jul 2025 15:47:19 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:73d::1:28])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HlbMgQ0FgSw0-5XJ9sAkD; Thu, 03 Jul 2025 15:47:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1751546838;
 bh=AySAxDUiU1PmP0dJyXSDIuLXy0LWQcMASwNWclWRNw0=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=053XnnZatYaIcRJFccCO9TtUVqEnfOAGV2pA+1XWPfAbH2HwWgnoH++qb1z01APne
 jGMFoKlebSnpC//1xvI+nRcXWboRfrGiFiHKAoGUsbFL9Tgv2cYLrUEDNKhdNhpbTr
 NWvzerERgTnG7Kxrb3EtYuyBvPRKpq8nbMhrvndw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: qemu-block@nongnu.org, fam@euphon.net, pbonzini@redhat.com,
 jasowang@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 sgarzare@redhat.com, raphael@enfabrica.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/4] vhost: introduce
 vhost_ops->vhost_set_vring_enable_supported method
Date: Thu,  3 Jul 2025 15:47:09 +0300
Message-ID: <20250703124713.2530079-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
References: <20250703124713.2530079-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

Remove vhost-user specific hack from generic code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c            |  8 ++++++++
 hw/virtio/vhost.c                 | 15 ++++++---------
 include/hw/virtio/vhost-backend.h |  2 ++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1e1d6b0d6e0..1b2879a90cc 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1230,6 +1230,12 @@ static int vhost_user_set_vring_base(struct vhost_dev *dev,
     return vhost_set_vring(dev, VHOST_USER_SET_VRING_BASE, ring, false);
 }
 
+static bool vhost_user_set_vring_enable_supported(struct vhost_dev *dev)
+{
+    return virtio_has_feature(dev->backend_features,
+                              VHOST_USER_F_PROTOCOL_FEATURES);
+}
+
 static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
 {
     int i;
@@ -3032,6 +3038,8 @@ const VhostOps user_ops = {
         .vhost_reset_device = vhost_user_reset_device,
         .vhost_get_vq_index = vhost_user_get_vq_index,
         .vhost_set_vring_enable = vhost_user_set_vring_enable,
+        .vhost_set_vring_enable_supported =
+            vhost_user_set_vring_enable_supported,
         .vhost_requires_shm_log = vhost_user_requires_shm_log,
         .vhost_migration_done = vhost_user_migration_done,
         .vhost_net_set_mtu = vhost_user_net_set_mtu,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index fc438537048..429fad07ded 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1988,15 +1988,12 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
         return 0;
     }
 
-    /*
-     * For vhost-user devices, if VHOST_USER_F_PROTOCOL_FEATURES has not
-     * been negotiated, the rings start directly in the enabled state, and
-     * .vhost_set_vring_enable callback will fail since
-     * VHOST_USER_SET_VRING_ENABLE is not supported.
-     */
-    if (hdev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER &&
-        !virtio_has_feature(hdev->backend_features,
-                            VHOST_USER_F_PROTOCOL_FEATURES)) {
+    if (hdev->vhost_ops->vhost_set_vring_enable_supported &&
+        !hdev->vhost_ops->vhost_set_vring_enable_supported(hdev)) {
+        /*
+         * This means, that rings are always enabled, and disable/enable
+         * API is not supported.
+         */
         return 0;
     }
 
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d6df209a2f0..f65fa26298e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -105,6 +105,7 @@ typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
                                          int enable);
+typedef bool (*vhost_set_vring_enable_supported_op)(struct vhost_dev *dev);
 typedef bool (*vhost_requires_shm_log_op)(struct vhost_dev *dev);
 typedef int (*vhost_migration_done_op)(struct vhost_dev *dev,
                                        char *mac_addr);
@@ -193,6 +194,7 @@ typedef struct VhostOps {
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;
+    vhost_set_vring_enable_supported_op vhost_set_vring_enable_supported;
     vhost_requires_shm_log_op vhost_requires_shm_log;
     vhost_migration_done_op vhost_migration_done;
     vhost_vsock_set_guest_cid_op vhost_vsock_set_guest_cid;
-- 
2.48.1


