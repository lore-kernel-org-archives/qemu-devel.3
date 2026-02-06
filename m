Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D0FECD98B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voIXF-0001xF-RZ; Fri, 06 Feb 2026 04:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWu-0001oE-72
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:39 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1voIWp-0000Kp-VN
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:53:33 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1593:0:640:6beb:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 606F68043B;
 Fri, 06 Feb 2026 12:53:29 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2rKPQc0AN0U0-iLPSHPWN; Fri, 06 Feb 2026 12:53:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770371608;
 bh=03EmRq0WTGGM+7nNla4mSGspHZJC/t4jo6ZtoJujS/Q=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nXPC8TfFn3f+sY/bYBWzKLp7Jt+uya0MOhX5QkJbxFa885PkOWWH+qJtWqHvlkosW
 Dwz4eWkat0mbryPXkQ1u/6nQ1+CKCd2yI77VExTfkEy9JfGbhj0F2nRg6FfTRPXEKV
 q1igBwQEZRPXLuvAVD2fAqhNEDSB8eqWL1X7nejg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v5 19/23] vhost: vhost_dev_init(): simplify features
 initialization
Date: Fri,  6 Feb 2026 12:52:53 +0300
Message-ID: <20260206095258.894504-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206095258.894504-1-vsementsov@yandex-team.ru>
References: <20260206095258.894504-1-vsementsov@yandex-team.ru>
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

Drop extra variable and extra function parameter passing, initialize
dev._features directly.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
---
 hw/virtio/vhost.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c3903d314d..fa02e94af4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1563,18 +1563,17 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
-static int vhost_dev_get_features(struct vhost_dev *hdev,
-                                  uint64_t *features)
+static int vhost_dev_init_features(struct vhost_dev *hdev)
 {
     uint64_t features64;
     int r;
 
     if (hdev->vhost_ops->vhost_get_features_ex) {
-        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
+        return hdev->vhost_ops->vhost_get_features_ex(hdev, hdev->_features_ex);
     }
 
     r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
-    virtio_features_from_u64(features, features64);
+    virtio_features_from_u64(hdev->_features_ex, features64);
     return r;
 }
 
@@ -1582,7 +1581,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
-    uint64_t features[VIRTIO_FEATURES_NU64S];
     unsigned int used, reserved, limit;
     int i, r, n_initialized_vqs = 0;
 
@@ -1603,9 +1601,9 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = vhost_dev_get_features(hdev, features);
+    r = vhost_dev_init_features(hdev);
     if (r < 0) {
-        error_setg_errno(errp, -r, "vhost_get_features failed");
+        error_setg_errno(errp, -r, "vhost_init_features failed");
         goto fail;
     }
 
@@ -1631,8 +1629,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         }
     }
 
-    virtio_features_copy(hdev->_features_ex, features);
-
     hdev->memory_listener = (MemoryListener) {
         .name = "vhost",
         .begin = vhost_begin,
-- 
2.52.0


